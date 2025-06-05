Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 974B7C5B559
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 10:17:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN7eK-0007yI-Lt; Thu, 05 Jun 2025 06:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uN7di-0007Lt-Lt
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:16:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uN7dh-0001GG-4w
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:16:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749118560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=psGQCsDtbA9u1IgUQ17MAZj3PqlJT0bXnc6QWWOT9MY=;
 b=KCuZ4GaAZKfgnm06ArEZWvDK80n+AssftlHeZsmt0qjpEMHH0oyKVbTDEKIqNMHXxSJx1Y
 nogWQSonXWh63/IyLM/3jx66CTMiSW4G21IiX9vPQswFnrB2lEECqm4e4g+bdR0ioj8N2y
 iOtHQBmsPdbYb5kRRL6w+fIHfN1FlWk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-BJKzIF2ZM1qoJhg_PGP_8w-1; Thu, 05 Jun 2025 06:15:59 -0400
X-MC-Unique: BJKzIF2ZM1qoJhg_PGP_8w-1
X-Mimecast-MFC-AGG-ID: BJKzIF2ZM1qoJhg_PGP_8w_1749118558
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4fabcafecso309654f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 03:15:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749118557; x=1749723357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=psGQCsDtbA9u1IgUQ17MAZj3PqlJT0bXnc6QWWOT9MY=;
 b=VVE9US5QAg5/AxAfxBfN6IaXPCYWrSgM2xYP8TMX6wR7EZhSnsc5jwy1BCyEiP1uCu
 /kOVcaPrYC69GsuulqKeVGVLkdQ+GadQnrLNSh7vmd8jAmIme+xKSHIPskQ9bWbzeebB
 ydYEOUrDbTaGcuRAyhFmxRI4wvv70aQZqI0cFNISP//7f6nWztUOKV7Ihp4t+Pr9rMMT
 W7fNs9jhp2riiD24Em3aeAeRi6hhPOy34hq0MmbFYucQb5QJBFVwrPs6VWUZU4rliiUD
 Xkmbwz+EVZAo3TdtY1MXhbSG14ony2sys5FHrHNRWtiJwW1XZRRd/wzKgsbSDgjFWAot
 Isxg==
X-Gm-Message-State: AOJu0Yw7uhzGO/SKLD9ras1VJyZPFvTtwY9G2gZff9stjtxMqthRPy0m
 +x4iyp5FF/UcyEekqLKGTWBCZKepEZ+qPi88qNwh3bFPT5w4o2HdjfpFdZ1Lw9tEc012cNwm4g7
 +tiF8veXNIRkXhWog+cGaFGKLVmBRvVSUeSPThEu082mpV6D6TveOKrcfg22NT14wSsHlNqoRS2
 Fk5wyF/Bgcpeey7m+9WF0q/arnOIlCxyS9pNsR+r3X
X-Gm-Gg: ASbGncvJhm20LgMrx0cjw9ilg5+l88IReVAVd5Lv5p7Ya6bvpRuk/E6pacB/hMLINwO
 COLpsbD1/UaUMKUIGSUmVqwTdftT6SNWbuExZSyQg8mDWMMKppSVQGEK7NXTF/K7vVklsQ3HUir
 V5LVkAg33ot6ZiQs/W+vHF3S+rn/NgfCW+gCUcrlFMm5KnhfnA2OY9UnuD5IREHik7EhwdCI8+b
 5J48ungZtqwR0BhOOCow2D+s2RYLkP8FPgYbyAyUFgZG5FTGZfo8AkNLxim7j/c94bvbGnqXuUx
 TaPk3fCFbl5p9Q==
X-Received: by 2002:a05:6000:2dca:b0:3a4:e672:deef with SMTP id
 ffacd0b85a97d-3a51dc316bamr5120363f8f.36.1749118557201; 
 Thu, 05 Jun 2025 03:15:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESn4TJ1Nv+9oCOJthj98uXX8fq/Wd26umb9n2DmamMGTbXBJfu9AvZuf5k2jcMUwm1A4guCA==
X-Received: by 2002:a05:6000:2dca:b0:3a4:e672:deef with SMTP id
 ffacd0b85a97d-3a51dc316bamr5120338f8f.36.1749118556822; 
 Thu, 05 Jun 2025 03:15:56 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451f991967csm19454965e9.32.2025.06.05.03.15.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 03:15:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	zhao1.liu@intel.com,
	qemu-rust@nongnu.org
Subject: [PATCH 04/14] util/error: allow non-NUL-terminated err->src
Date: Thu,  5 Jun 2025 12:15:33 +0200
Message-ID: <20250605101544.368953-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605101544.368953-1-pbonzini@redhat.com>
References: <20250605101544.368953-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Rust makes the current file available as a statically-allocated string,
but without a NUL terminator.  Allow this by storing an optional maximum
length in the Error.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qapi/error-internal.h | 9 ++++++++-
 util/error.c                  | 5 +++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/qapi/error-internal.h b/include/qapi/error-internal.h
index d5c3904adec..1ec3ceb40f0 100644
--- a/include/qapi/error-internal.h
+++ b/include/qapi/error-internal.h
@@ -18,7 +18,14 @@ struct Error
 {
     char *msg;
     ErrorClass err_class;
-    const char *src, *func;
+    const char *func;
+
+    /*
+     * src might be NUL-terminated or not.  If it is, src_len is negative.
+     * If it is not, src_len is the length.
+     */
+    const char *src;
+    int src_len;
     int line;
     GString *hint;
 };
diff --git a/util/error.c b/util/error.c
index e5bcb7c0225..3449ecc0b92 100644
--- a/util/error.c
+++ b/util/error.c
@@ -24,8 +24,8 @@ Error *error_warn;
 static void error_handle(Error **errp, Error *err)
 {
     if (errp == &error_abort) {
-        fprintf(stderr, "Unexpected error in %s() at %s:%d:\n",
-                err->func, err->src, err->line);
+        fprintf(stderr, "Unexpected error in %s() at %.*s:%d:\n",
+                err->func, err->src_len, err->src, err->line);
         error_report("%s", error_get_pretty(err));
         if (err->hint) {
             error_printf("%s", err->hint->str);
@@ -67,6 +67,7 @@ static void error_setv(Error **errp,
         g_free(msg);
     }
     err->err_class = err_class;
+    err->src_len = -1;
     err->src = src;
     err->line = line;
     err->func = func;
-- 
2.49.0


