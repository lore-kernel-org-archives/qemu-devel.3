Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF1A8D64070
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 17:41:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Swn-00044z-AA; Fri, 08 Nov 2024 12:39:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9Swl-00044P-RN
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 12:38:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9Swk-0007fB-Fx
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 12:38:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731087537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tMydD67TS3FVaRTLFXvf1upIIs0DeRvxwW2NfVrOwOE=;
 b=L9CZe/qSZ/7Ur02E6EAjh/IOJoPBnL/6Qc6E54l38HJjN55D0ya//ZI4lQ67/tNEBahUVO
 s+Vnkk64vtG9lOfl4ZIdxpfD1+PMpYmtUxr5eiLOvCajoMT9pkkfileU5NZ+zZTqd01dKl
 rhMvno5iEb5V6YcWU5O159Ju2NsjosQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-F240E565MzShn3nGOO0Ajw-1; Fri, 08 Nov 2024 12:38:56 -0500
X-MC-Unique: F240E565MzShn3nGOO0Ajw-1
X-Mimecast-MFC-AGG-ID: F240E565MzShn3nGOO0Ajw
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43157e3521dso16345855e9.1
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 09:38:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731087535; x=1731692335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tMydD67TS3FVaRTLFXvf1upIIs0DeRvxwW2NfVrOwOE=;
 b=ODBlLnGbuXQOqKy42PQEkKgcRLhQbExGNCsgEUT8DZUUFFVmYuGyb1MigJXkv3mrqg
 bNA/3byJplbxBpER3wpvU0ac3lxe3rnquu7ikVWSSZ3/ElIRTC79/ALcfm2RL+cjS42E
 sRKWD2X35qE4tWmMxRrO14UwL1FTbjJEDjoN/VKKxCl9Jh68mQAH2kreu/Kw6woGfatx
 CzHpsBnrmAfuHQ9Dpr58BOxdW6BSKeQzb4hBWupfZVZfrfOVRy53ZdbbixFL3zuaWGlS
 HfQMvSNJmVSaqTL/I8zVBZPgdEb7KqaP+Y9jT6/Vgh0XVViEYZY/0GAWATJgT525JhyE
 9a7Q==
X-Gm-Message-State: AOJu0YxtbECLZ/+eHO5T+VOy03JDpPqpgxVIwHU+f5Q6yS8jCX+Xto/a
 9hVB/IWklyMZkcz/B6x3qSrikXHmOxCPXQ68g0FveSd21Om0dDjS8+0fraUgcwwR62g9YV2R+OJ
 TNB30VhoqwLGRr/XDGl8G4XGXCIxF1DXVp4zMCq0VRfVeJuUxnFYYGg66XZJXGwhN25L4Q0vKhe
 P81nPkw1R4SnrIYCzlsZglwl8bWsNKekB4oCFVqIA=
X-Received: by 2002:a05:600c:1f88:b0:425:80d5:b8b2 with SMTP id
 5b1f17b1804b1-432b7509ac4mr31020665e9.16.1731087535142; 
 Fri, 08 Nov 2024 09:38:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEN9FMRbFsDqdMxJjSSglanGAhsCZ3iuZV+Lv7D43fWnr/HvyU6eyYnhK07zBA2gjP6O3BN6A==
X-Received: by 2002:a05:600c:1f88:b0:425:80d5:b8b2 with SMTP id
 5b1f17b1804b1-432b7509ac4mr31020435e9.16.1731087534734; 
 Fri, 08 Nov 2024 09:38:54 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b05c1a13sm77239735e9.29.2024.11.08.09.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 09:38:53 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Junjie Mao <junjie.mao@hotmail.com>
Subject: [PULL 12/13] rust: qemu-api-macros: always process subprojects before
 dependencies
Date: Fri,  8 Nov 2024 18:38:27 +0100
Message-ID: <20241108173828.111454-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108173828.111454-1-pbonzini@redhat.com>
References: <20241108173828.111454-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>
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


