Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7ADD767F2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 17:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZNz-00068B-IJ; Thu, 31 Oct 2024 13:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMQ-000242-B3
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMN-0007PP-UC
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BWcfg2aupe5UaZvSXBPNOsSy5nqMqX/xbZPHsRPq/yw=;
 b=KiN9VwHLThPRLjI7QPUSzE6Xc5R8MTPjJcVwsBifps9KMV8aXn9KpNzFKjVeN8rb4QNyAS
 6ko/DR0GT30D2O00P1HbumkDBsOicw4U9bjAuk2+9ZfmFHr3zC6kMa0ykJwzCZ7NZJpAVt
 uw+sCsTYeGo2047a5wdcPd/rh6Q2EI8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-NyoYN4LYNRizImM_yWz3Gg-1; Thu, 31 Oct 2024 13:53:24 -0400
X-MC-Unique: NyoYN4LYNRizImM_yWz3Gg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-539ebb67c28so866900e87.3
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397202; x=1731002002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BWcfg2aupe5UaZvSXBPNOsSy5nqMqX/xbZPHsRPq/yw=;
 b=DDfsE4FzB7k9HJDOo6PiJz2grYIJcpaPdtuRevzWDgdmtUaEwF0ut4akuuh2e+Rpt4
 X+ilJRz9ekMVL9k1ww+S6dCsAbLRaob+xPJGF+tYK5syB5XgyrchTdLLTc9ZLbRUk97m
 bfYik62g4AI/Il6uZU+OgQTB1HICk8ZosLm48EcYBmyJVPPaFBLW7s85hDLn1vfhkTHN
 cL9SsfzDrTldAAWm4mOH9KucuxLWsrHEz1cIPyPjcTnxjlzJUrmBrSccH69eE9UoqOg5
 cOcVoOuRgGgiWI/cifTBs1gtrBB030bDsOzL9VZS1PXBEZP7rJQx2g5O1lvwcrBVDU3Q
 gnXw==
X-Gm-Message-State: AOJu0YxPhomCVEwdXpPVt/2co50xb59sS2FtZTLF5sWDyh+Vdl9odwX3
 VvSaK7/mJk54PNdqM24wRTP8ClTLOa2bZi4+nD3fiJXjlkGT8h5swmF7T4EN9djhK2uK7fstM2I
 ds8kbosFsdhabGsMmuCKWub5y5JPutAE6J9rE5nddN2gfVSJ1taY0hZrUsG7y/cWch8YaiWj6lC
 1OxX7Tnevz6iP3+MIh9c1PdemJixDnrBLZmGNq/ko=
X-Received: by 2002:a05:6512:32c8:b0:535:82eb:21d1 with SMTP id
 2adb3069b0e04-53d65e1781fmr587613e87.57.1730397201476; 
 Thu, 31 Oct 2024 10:53:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpJTduxqO5tFJP2JBP6PfrOmIpOOZXCziOXLoXSrZLuH/VpYgcZeJx14RUZftKDDgHL/ojrw==
X-Received: by 2002:a05:6512:32c8:b0:535:82eb:21d1 with SMTP id
 2adb3069b0e04-53d65e1781fmr587591e87.57.1730397200955; 
 Thu, 31 Oct 2024 10:53:20 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d698144sm35957565e9.39.2024.10.31.10.53.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:53:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 29/49] target/i386: Tidy cc_op_str usage
Date: Thu, 31 Oct 2024 18:51:53 +0100
Message-ID: <20241031175214.214455-30-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031175214.214455-1-pbonzini@redhat.com>
References: <20241031175214.214455-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
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


