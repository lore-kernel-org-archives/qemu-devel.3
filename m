Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB035D3C92A
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 15:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2YFQ-0003MN-7n; Sun, 20 Oct 2024 11:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2YFP-0003MD-5G
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 11:53:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2YFN-0005PW-Px
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 11:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729439616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1bX8SwrawXi6wPzSE0JjFJp8yDQGRij0ZpmKsQ3vth0=;
 b=OYZEtoLX5jSG+Udyhk4XySwLc/3kp7E+kE0vmXAvw3928ibO/H7Jkhet0TiM0rFjX9htE8
 Bxzp0TTuzw8kX62nk97IqXQbc6XMc6EKFtmVYmaJDWHXgCCNdtcBU0lX67wJw4RR3KUBjU
 cZrAkJCmRmsONDobQVRAzBicvu3cj6U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-JmPDxycHOESEbqi20MlOkw-1; Sun, 20 Oct 2024 11:53:35 -0400
X-MC-Unique: JmPDxycHOESEbqi20MlOkw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d563a1af4so1640969f8f.2
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 08:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729439612; x=1730044412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1bX8SwrawXi6wPzSE0JjFJp8yDQGRij0ZpmKsQ3vth0=;
 b=ms9DbI/fjmucyDY0q0ZhvnpiaTyBb+Y3zf3t0kKCd3u3ToJV2npInZzbAA2QLm9nVt
 PUvXT1SLpfUsKddTUYIZs8arG+S0pwe0Z7OCk8hdr2jKkYQTaWDhVsE4dIW5zl8N1zam
 f2HsuEB2wquMzhoy2Gux1jxskVIB8Gq0KGG2TaWWigSSE722E5wAwoUz2vpveVFaDenz
 z81sUvRXXuPFvCUjGmG/BEwcilstj5GqDcFIeFoxdUi3VgogRJNS9binfil43XkF+m+n
 OT1HMpNoL0tZrPxyrR1Qtql2ieoNgWalAf+PkOKFgHYbSSIwakV78qaCx5VZhJU8uZ3f
 BUuw==
X-Gm-Message-State: AOJu0YyvKJMP7F6TPnXjpcjXHy27cKMTX/MG/ya6GxEnZlETnlr0Ri/E
 Sk4h73ig2PLDfCADxBXEs3sEozYEgOsOJASfzse3Pw+rgS8ya7YHi/EptkTJrHJKDhI8FFZcB14
 xw3uCUBSwGhBTWpbl6743+9qntI5POQ1bAWI7UgsdGmd0K3sGu6KlVuNgBVkeuvtaKEciOEjjUm
 bhI43jSQRXDYcx3yGWL5bNEJ/kDJI9IIGlhRShsuc=
X-Received: by 2002:adf:fd44:0:b0:37d:42ce:f3a5 with SMTP id
 ffacd0b85a97d-37ea213c624mr5061627f8f.12.1729439612529; 
 Sun, 20 Oct 2024 08:53:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwqYrPsmtpjyII/k8kiWuM34rCyHJVYzNs4qBnQByePejJFMQGb9/059um7HV8XrTfXfghaQ==
X-Received: by 2002:adf:fd44:0:b0:37d:42ce:f3a5 with SMTP id
 ffacd0b85a97d-37ea213c624mr5061611f8f.12.1729439612098; 
 Sun, 20 Oct 2024 08:53:32 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0a49180sm2007266f8f.39.2024.10.20.08.53.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Oct 2024 08:53:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 02/14] target/i386: Tidy cc_op_str usage
Date: Sun, 20 Oct 2024 17:53:12 +0200
Message-ID: <20241020155324.35273-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241020155324.35273-1-pbonzini@redhat.com>
References: <20241020155324.35273-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.527,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

Make const.  Use the read-only strings directly; do not copy
them into an on-stack buffer with snprintf.  Allow for holes
in the cc_op_str array, now present with CC_OP_POPCNT.

Fixes: 460231ad369 ("target/i386: give CC_OP_POPCNT low bits corresponding to MO_TL")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20240701025115.1265117-2-richard.henderson@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu-dump.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/target/i386/cpu-dump.c b/target/i386/cpu-dump.c
index 3bb8e440916..dc6723aedee 100644
--- a/target/i386/cpu-dump.c
+++ b/target/i386/cpu-dump.c
@@ -27,7 +27,7 @@
 /***********************************************************/
 /* x86 debug */
 
-static const char *cc_op_str[CC_OP_NB] = {
+static const char * const cc_op_str[] = {
     [CC_OP_DYNAMIC] = "DYNAMIC",
 
     [CC_OP_EFLAGS] = "EFLAGS",
@@ -347,7 +347,6 @@ void x86_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
     int eflags, i, nb;
-    char cc_op_name[32];
     static const char *seg_name[6] = { "ES", "CS", "SS", "DS", "FS", "GS" };
 
     eflags = cpu_compute_eflags(env);
@@ -456,10 +455,16 @@ void x86_cpu_dump_state(CPUState *cs, FILE *f, int flags)
                      env->dr[6], env->dr[7]);
     }
     if (flags & CPU_DUMP_CCOP) {
-        if ((unsigned)env->cc_op < CC_OP_NB)
-            snprintf(cc_op_name, sizeof(cc_op_name), "%s", cc_op_str[env->cc_op]);
-        else
-            snprintf(cc_op_name, sizeof(cc_op_name), "[%d]", env->cc_op);
+        const char *cc_op_name = NULL;
+        char cc_op_buf[32];
+
+        if ((unsigned)env->cc_op < ARRAY_SIZE(cc_op_str)) {
+            cc_op_name = cc_op_str[env->cc_op];
+        }
+        if (cc_op_name == NULL) {
+            snprintf(cc_op_buf, sizeof(cc_op_buf), "[%d]", env->cc_op);
+            cc_op_name = cc_op_buf;
+        }
 #ifdef TARGET_X86_64
         if (env->hflags & HF_CS64_MASK) {
             qemu_fprintf(f, "CCS=%016" PRIx64 " CCD=%016" PRIx64 " CCO=%s\n",
-- 
2.46.2


