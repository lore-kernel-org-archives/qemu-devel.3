Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C84CAC58E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLLz-0007fx-PR; Sat, 13 Sep 2025 04:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLLn-0006Ni-Ou
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:11:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLLl-00054e-Te
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:11:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757751073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vGRqjHwieFM87pfRpp5jcSbmSM8dksQ/vT35ARHbgik=;
 b=Xb0/wcsnHkVzoykuyWxHQeOjelf/yEQtS1o1YbQIz+cDmJqouopTXP+Uqhi6SEhD1114nr
 uBbx1t9te/FEejplh0Wl6rX05X+7t0+U0C0TXL7G+fA/VbYmd1S8m7yk8NeSWRb8hWF6kC
 fcK/LXmVVFmrZAfzZRHt95f35TqtAYg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-1wmOlWwwNzeQBbv9aoB5nQ-1; Sat, 13 Sep 2025 04:11:11 -0400
X-MC-Unique: 1wmOlWwwNzeQBbv9aoB5nQ-1
X-Mimecast-MFC-AGG-ID: 1wmOlWwwNzeQBbv9aoB5nQ_1757751070
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45b99c18484so9753895e9.1
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:11:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757751069; x=1758355869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vGRqjHwieFM87pfRpp5jcSbmSM8dksQ/vT35ARHbgik=;
 b=Pd0KcMUKuTvjpky32NUxFNLYJ975ajVsy/m3PbJAQPfk/gJVConBl+KvdbRzChed6S
 BRYaIk/jba5lZpqYNHRx2iAe457mBeeuyOBnixFfD0TZ4YfKXPu5u63NrZin3m2Rq5ur
 Uyfcv/Z2BIQkISPUoQLMtPG1xmf12pX9vM+D1OR/R8dcCS9oks7PS63/9RgFlpi+2X+Q
 YsN9LOT64j2L6aOtZWbRMT0fkzVevQoU2iFAmNJd2s456WmEwm4H4QPRSgCgExyTd6/Z
 Sj3KJpE8VFqpLar5wFo8t1YBZt6wgra1aZQWXI7+VBa3NRcJ8dGq+M2tRWfDidgTkUrr
 FFDA==
X-Gm-Message-State: AOJu0YzSmdGTb5oLxGdJs52z0SCxSlc6V6+PZQXFVx+TdQyLk/ZhNzVg
 TsVQv0a1x2bMBEAGCGOciHRyoJ0EOJP6UvTmQZKkDjJyR2dvNUYq98HGNO2LqAsWesqWKpZwiqX
 Ucs8qnPsVID4WPGK90HYbSnvAR3ZGuUyS6Eng/VoIPBh/sttkrAiLoCL95+dYlwDSx9JnxQJOJv
 YOSkF54wXKDjnAMihNXgVHIJo1F9ng7EfNar7cAcIL
X-Gm-Gg: ASbGncuUj1qh9Vr8f+2Wj8fD7/a5NoODBJ/uWCRHhyQ3YnQyQgcorCiY+2uSe7xPixk
 UoT1Qsb8Kgu2OzWEcZphhze9vQ3OF0TqYdW2VZZpltoIxClcfsTf5inWFx0Y1z2faucWeSIf780
 zAv5uIR1hZvVLAhUjqrgsZAqDQ41ymMuuEAH9tLKCV4l4LM0qjLXVf0iJLLf1vucjA6iegpUd3G
 QB5bNEeFHf+FePkySw28CWXwY5fMbXSSkt0Q4vBZQtR0upj/xj9GS5BZWrn+o9cEN6ygTQIQsbS
 V2QW9yWbCWdACpss3AuTfRa0H842B6vSrxVryhVAuQYQ8iHZs67o8Mq5z1skHeU1iVYXSRgszHx
 BXegPmO2Mub6hw+jB5yMry8AgMDdZs2fu9MTgcYGlFEg=
X-Received: by 2002:a05:600c:696:b0:45d:e5ff:e38c with SMTP id
 5b1f17b1804b1-45f211ffdacmr29316375e9.32.1757751069606; 
 Sat, 13 Sep 2025 01:11:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9XStQZWoqtYlA8FJWsuqi+wXM1pB3ehc3WdG5fgcO9TqKw2SPoQOFdl48RvhN6Lp0W2e2oA==
X-Received: by 2002:a05:600c:696:b0:45d:e5ff:e38c with SMTP id
 5b1f17b1804b1-45f211ffdacmr29316125e9.32.1757751069024; 
 Sat, 13 Sep 2025 01:11:09 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e015313a0sm48488825e9.4.2025.09.13.01.11.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:11:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 29/61] docs/rust: update msrv
Date: Sat, 13 Sep 2025 10:09:10 +0200
Message-ID: <20250913080943.11710-30-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20250827104147.717203-2-marcandre.lureau@redhat.com
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst | 2 +-
 rust/Cargo.toml     | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 10b0590b56c..20d15347def 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -1,4 +1,4 @@
-.. |msrv| replace:: 1.63.0
+.. |msrv| replace:: 1.83.0
 
 Rust in QEMU
 ============
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 99c275f2d9f..9b26aa07cec 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -13,6 +13,7 @@ edition = "2021"
 homepage = "https://www.qemu.org"
 license = "GPL-2.0-or-later"
 repository = "https://gitlab.com/qemu-project/qemu/"
+# don't forget to update docs/devel/rust.rst msrv
 rust-version = "1.83.0"
 
 [workspace.dependencies]
-- 
2.51.0


