Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 972D7D5AE75
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 09:27:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8ymg-0007v8-Ig; Thu, 07 Nov 2024 04:26:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8yme-0007um-BA
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 04:26:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8ymc-00008s-FG
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 04:26:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730971588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=gloDiZsev+qeLiAcYf877fjEGq6AiDQGQT3TP28xZ1c=;
 b=NoMkqTs56BdelTNxfuhSThM++6Z7d9ws7ePw+bLjXnNLGP3iRpAGqOy7E6dNpHJW5pYTHV
 f8YJZCCbjaHRf67spawU5nOCpSyIdBjYsr/QsGbjYFunMTZOA5fxPb3Wsd5XFiS3OcPB7t
 wuSHyBPacAiAsI/jgwb/OtJhpPCxbNU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-t3RXetkYNmWUtvS9sCRlAA-1; Thu, 07 Nov 2024 04:26:26 -0500
X-MC-Unique: t3RXetkYNmWUtvS9sCRlAA-1
X-Mimecast-MFC-AGG-ID: t3RXetkYNmWUtvS9sCRlAA
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43159603c92so5054085e9.2
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 01:26:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730971585; x=1731576385;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gloDiZsev+qeLiAcYf877fjEGq6AiDQGQT3TP28xZ1c=;
 b=i7olIlCo5oUyw/CivpCjvYkKcKT1MJfhhyjcaX4/iNMv9qQWI9hIKcFFm1Dsu5oBy3
 hV3PhujYAS1FiqTaxEDXplMWmE/f1HW1ud4H6+rTXqneb08zz8vCJ0tG24DT6cMbSzMc
 pvyBHyGf/MwdAHnvthoibLDDqRY4LFRwLvCRjy2+7UU2ZTcqx8g7Zt5J8e53p7s4Hx9v
 FRp/wkxnz+D0LHEvAfct7rAdAhwiWzdufUb9KTB+7Gai8db+OqvulDD2U46Qo1lT4T/S
 c7EtffbjUobP7jrUJ5FCudNZaf2SFxzJZvSiPdM7jXhsMIboGnTtQX2jKSYx8rMJMkBP
 o5TA==
X-Gm-Message-State: AOJu0YzSUrpAqM+c1jBpF9LI9Lo1bTDZfw1DCvJvyGsZXlG8nm88ftiV
 GW3/JLNxx51FQcu3xzkfRoeI4tQfo54L4hALS8yyMk3AhG3MwShQisKQaKyy7S9hUEORtkSWt0a
 66MK2sLX/bVLZI1DtJZm+AV7TGnHPmdETUrsVlLm0+A5ZejjrzNYw+FNa8Op3JDH6datHaYUoe5
 vQPBnRZe5UUX08mjC/jV3uX9QIIBphC2bKgtPzEk0=
X-Received: by 2002:a05:600c:5493:b0:431:5533:8f0c with SMTP id
 5b1f17b1804b1-43285649fe6mr182706375e9.29.1730971584879; 
 Thu, 07 Nov 2024 01:26:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJ6tk8YbV61GCHYtUaBVReRcDW0Vj9Q7U+PENXRHKjUL9exVYz/9oUuqqOzvR5riOuXT7Dtw==
X-Received: by 2002:a05:600c:5493:b0:431:5533:8f0c with SMTP id
 5b1f17b1804b1-43285649fe6mr182706175e9.29.1730971584365; 
 Thu, 07 Nov 2024 01:26:24 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b04753d5sm17430075e9.0.2024.11.07.01.26.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 01:26:23 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] rust: qemu-api-macros: always process subprojects before
 dependencies
Date: Thu,  7 Nov 2024 10:26:22 +0100
Message-ID: <20241107092622.616487-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Avoid looking for Rust dependencies via cmake.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api-macros/meson.build | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rust/qemu-api-macros/meson.build b/rust/qemu-api-macros/meson.build
index 24325dea5c2..6f94a4bb3c2 100644
--- a/rust/qemu-api-macros/meson.build
+++ b/rust/qemu-api-macros/meson.build
@@ -1,3 +1,7 @@
+subproject('proc-macro2-1-rs', required: true)
+subproject('quote-1-rs', required: true)
+subproject('syn-2-rs', required: true)
+
 quote_dep = dependency('quote-1-rs', native: true)
 syn_dep = dependency('syn-2-rs', native: true)
 proc_macro2_dep = dependency('proc-macro2-1-rs', native: true)
-- 
2.47.0


