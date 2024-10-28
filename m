Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06518D33990
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 15:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5RWT-00087g-Q3; Mon, 28 Oct 2024 11:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5RWR-000879-GR
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 11:19:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5RWP-0000kB-Us
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 11:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730128749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BWcfg2aupe5UaZvSXBPNOsSy5nqMqX/xbZPHsRPq/yw=;
 b=EqcMaV/0VGfU7JlhkZD80TMzGPxzC+85Qk5M3WkI+vgeQ8gllvSUbsDOYRx4tTACNbm2OR
 0BR22FhRU0tFYfUzAO0vBSRETkeY2nylQ7XwWR71U745zQQ7aRodj594hYw6Mi+duG+CXI
 n88+hY1ZiDRYyHXMp15n4aek+Cn0DYU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-92xPeURMNim3jKsG1x8t-g-1; Mon, 28 Oct 2024 11:19:06 -0400
X-MC-Unique: 92xPeURMNim3jKsG1x8t-g-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4316ac69e6dso34480925e9.0
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 08:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730128744; x=1730733544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BWcfg2aupe5UaZvSXBPNOsSy5nqMqX/xbZPHsRPq/yw=;
 b=r4pIEsOUTJQSap2Lkkm85kALjwFQd3eLQGKGZB0bjhBDNz/MYffI8vXTVYUNcI93eZ
 DvaXtAzpxjWZ5bG3wyKK0VVyLc3NEIaaP8G2V1FG9WJJsm1jDnyWwU+s7HOq2cUVLm1R
 xvlUCiz8/mio/aONs9/wQKCz4qk1xti7h5has51dEzgcbpjssTmOuH/VjjfOazuXK8z6
 Y1mAIKGYIWq/ZBtDVbAWeA+L2Ffv2Pkd5ifN6M0hiZCL3RJGe8V+kxa+zM9CdkYoYW4Z
 gEz3pI030uYB79hg52tBIO2AqNt7V0/YU0toO6iHPrdPqfokZkJ4CfV3pK/fu0gc0tck
 hT4g==
X-Gm-Message-State: AOJu0YxyQXn+dVLf5xm2PEswvcrGF6FHQMA2lcT73gyfy5d8WDcgiCP1
 m61F1nRgq4LudG1p0E9++wqmdmo3vqTiOK3kV525aZZd3jocAI6wSPIJdioMo8v9rhqsiZWGwL5
 IzrGI6f82YFJabzxAhrohXC0mUUFDIJ1vrKgbMMAw6ywAZgyDdIVhyFjo1p9M37+7kvwRuDIumK
 Y0IkMxrYdeRrGt1CFQ3iXoNdTX+asLSoZf4JK+vp4=
X-Received: by 2002:a05:600c:5253:b0:431:46fe:4cc1 with SMTP id
 5b1f17b1804b1-4319aca42bemr78561095e9.10.1730128744561; 
 Mon, 28 Oct 2024 08:19:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpnzqoSD1fQYM7XxRtrvJGC3rYFxs1HKBKS9UoSHO7uiXWV4wMD/juc9P8S9uHzdDQI9VTbQ==
X-Received: by 2002:a05:600c:5253:b0:431:46fe:4cc1 with SMTP id
 5b1f17b1804b1-4319aca42bemr78560835e9.10.1730128744045; 
 Mon, 28 Oct 2024 08:19:04 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43193594ff3sm111869205e9.12.2024.10.28.08.19.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 08:19:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 02/14] target/i386: Tidy cc_op_str usage
Date: Mon, 28 Oct 2024 16:18:39 +0100
Message-ID: <20241028151851.376355-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028151851.376355-1-pbonzini@redhat.com>
References: <20241028151851.376355-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
2.47.0


