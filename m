Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E96C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5WP-0000R3-Ai; Tue, 12 Mar 2024 13:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5US-0006Bd-32; Tue, 12 Mar 2024 13:00:38 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5UN-0008NB-Lu; Tue, 12 Mar 2024 13:00:35 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6e5dddd3b95so28358b3a.1; 
 Tue, 12 Mar 2024 10:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710262830; x=1710867630; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MoKRCKsm4E9lna6+NySazE4WVLMGHBKm/4jK5soogyI=;
 b=h/wPq5d7Hnz2CMC2PHvQdnGYFZ7R/MTebEFEOnc3He/T68OvaGqY1UotH+wxA8Z+Cn
 L7FejViyW3Iwudr9EtKciPxd/35LAZ4IUB0BqdQCvQ0TQK2oNNX8LRksMptwzLvV6KVB
 ZbJBPHWTs/movfpv8Z4th/mhb3Q/kGA4U64w7EfEUadxbXi4cJl7DftaRvRh58YmsMsP
 ZYnk76Yg1qBUGCBY8W6ImnQ54637IWMRdyVWk4+CSGdinUGmxMi0cJJfSiVrFb7su56V
 zkxb2GNl0dP6TNbNPDSEbSiGx1iL3s9fX1ju2zYddrcJLligzYtPxgXL5OoCWUEm99UZ
 H1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710262830; x=1710867630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MoKRCKsm4E9lna6+NySazE4WVLMGHBKm/4jK5soogyI=;
 b=KPVzImCD9dZMScfEXx7Ax+EtfL4Ha6G2Df26SKu35K2xRT+Rz2wAMRfACTrkXrPGWH
 anRHHWK5PVMnBUnAUwbntZdDNGxcDgToTpGWDG7jLxqpMuRJYuUvCd+xOPwR01NJgTuF
 ix7+Ynzja2DvVRl/vobWp1ipiKWkYOmaGwsPIU+Tc2CXernO5Oh+3uADnogA7sYG+Cib
 3bokJLWGYPBddN7wu1StIeEszfmrA8vSDUAoANn3lCuXCqzqnh6IQjKj4RTBEcWJNHkE
 5z/99cXbKS9uIRQs7NmH7OM41Wqgq+0zzRs/dE8pWOI7Xri/oAOKhSnlJ7ZcbhRXMq79
 fx7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOrxi1aNl8jqCLOFUZDaDxqG7zizkcuzuHrS+vFQDXm0sFM6qwNfTXJMAEtAXs8Hw/330ICK7nj0cqiwEfpooHK+ue
X-Gm-Message-State: AOJu0YzKQ6w5HKGYy65bIJGsatsthy+DXje10BZ9KXP4c9s2ArFq+/sq
 X064pd4jnFcOtOiCXFvrqMxGnL8wUnCdL8gN1++qzFs21d5XgzX0kx14cXuyse8=
X-Google-Smtp-Source: AGHT+IF1p01VJJTEl2S+CqTXnh4h3YJRrxS9Kc2zlICgMzRwtJj7wCs+ILpowdv8u55j3xlBrgb2bw==
X-Received: by 2002:a05:6a21:32a5:b0:1a1:6cf3:265b with SMTP id
 yt37-20020a056a2132a500b001a16cf3265bmr207438pzb.18.1710262829814; 
 Tue, 12 Mar 2024 10:00:29 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 t34-20020a056a0013a200b006e6a684a6ddsm1362330pfg.220.2024.03.12.10.00.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 10:00:29 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 24/38] target/ppc: Remove interrupt handler wrapper functions
Date: Wed, 13 Mar 2024 02:58:35 +1000
Message-ID: <20240312165851.2240242-25-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240312165851.2240242-1-npiggin@gmail.com>
References: <20240312165851.2240242-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: BALATON Zoltan <balaton@eik.bme.hu>

These wrappers call out to handle POWER7 and newer in separate
functions but reduce to the generic case when TARGET_PPC64 is not
defined. It is easy enough to include the switch in the beginning of
the generic functions to branch out to the specific functions and get
rid of these wrappers. This avoids one indirection and entirely
compiles out the switch without TARGET_PPC64.

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c | 67 +++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 39 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index a9efda7626..ded488fcd8 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1978,8 +1978,21 @@ static int p9_next_unmasked_interrupt(CPUPPCState *env)
 }
 #endif /* TARGET_PPC64 */
 
-static int ppc_next_unmasked_interrupt_generic(CPUPPCState *env)
+static int ppc_next_unmasked_interrupt(CPUPPCState *env)
 {
+#ifdef TARGET_PPC64
+    switch (env->excp_model) {
+    case POWERPC_EXCP_POWER7:
+        return p7_next_unmasked_interrupt(env);
+    case POWERPC_EXCP_POWER8:
+        return p8_next_unmasked_interrupt(env);
+    case POWERPC_EXCP_POWER9:
+    case POWERPC_EXCP_POWER10:
+        return p9_next_unmasked_interrupt(env);
+    default:
+        break;
+    }
+#endif
     bool async_deliver;
 
     /* External reset */
@@ -2090,23 +2103,6 @@ static int ppc_next_unmasked_interrupt_generic(CPUPPCState *env)
     return 0;
 }
 
-static int ppc_next_unmasked_interrupt(CPUPPCState *env)
-{
-    switch (env->excp_model) {
-#ifdef TARGET_PPC64
-    case POWERPC_EXCP_POWER7:
-        return p7_next_unmasked_interrupt(env);
-    case POWERPC_EXCP_POWER8:
-        return p8_next_unmasked_interrupt(env);
-    case POWERPC_EXCP_POWER9:
-    case POWERPC_EXCP_POWER10:
-        return p9_next_unmasked_interrupt(env);
-#endif
-    default:
-        return ppc_next_unmasked_interrupt_generic(env);
-    }
-}
-
 /*
  * Sets CPU_INTERRUPT_HARD if there is at least one unmasked interrupt to be
  * delivered and clears CPU_INTERRUPT_HARD otherwise.
@@ -2336,8 +2332,21 @@ static void p9_deliver_interrupt(CPUPPCState *env, int interrupt)
 }
 #endif /* TARGET_PPC64 */
 
-static void ppc_deliver_interrupt_generic(CPUPPCState *env, int interrupt)
+static void ppc_deliver_interrupt(CPUPPCState *env, int interrupt)
 {
+#ifdef TARGET_PPC64
+    switch (env->excp_model) {
+    case POWERPC_EXCP_POWER7:
+        return p7_deliver_interrupt(env, interrupt);
+    case POWERPC_EXCP_POWER8:
+        return p8_deliver_interrupt(env, interrupt);
+    case POWERPC_EXCP_POWER9:
+    case POWERPC_EXCP_POWER10:
+        return p9_deliver_interrupt(env, interrupt);
+    default:
+        break;
+    }
+#endif
     PowerPCCPU *cpu = env_archcpu(env);
 
     switch (interrupt) {
@@ -2440,26 +2449,6 @@ static void ppc_deliver_interrupt_generic(CPUPPCState *env, int interrupt)
     }
 }
 
-static void ppc_deliver_interrupt(CPUPPCState *env, int interrupt)
-{
-    switch (env->excp_model) {
-#ifdef TARGET_PPC64
-    case POWERPC_EXCP_POWER7:
-        p7_deliver_interrupt(env, interrupt);
-        break;
-    case POWERPC_EXCP_POWER8:
-        p8_deliver_interrupt(env, interrupt);
-        break;
-    case POWERPC_EXCP_POWER9:
-    case POWERPC_EXCP_POWER10:
-        p9_deliver_interrupt(env, interrupt);
-        break;
-#endif
-    default:
-        ppc_deliver_interrupt_generic(env, interrupt);
-    }
-}
-
 void ppc_cpu_do_system_reset(CPUState *cs)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
-- 
2.42.0


