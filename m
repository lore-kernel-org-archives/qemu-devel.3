Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F52C35FF3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 14:31:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuBSK-0000hJ-1r; Mon, 17 Mar 2025 10:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuBS8-0000Zk-NV
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 10:28:29 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuBS6-000196-0y
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 10:28:28 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so10334855e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 07:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742221704; x=1742826504; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NaCPyDdxmRmZpYCr7DKDsJe3bk+lLzZjopyFV4R3vdM=;
 b=Vk+WsdMnu4yb7RZcok/WPH5AOa9COQOol5i1a/EwttGcA3LsnOOyl4af/3J89Ai4sv
 B7rt9i34RtD9mkpl0J2T0M60jhhuysLM5r2vOWrLT6LQ+d/Ee8t4Rv7DIC/TMbk3+j65
 sRCf3jOO9L5mrqRmMSy4laEzlpOinjE7xpZ3lsAeSq+9m5I/5Us1mKPTYz09lU/iQSTx
 /6hSWWBX7zN5+2Eepv1pTKOw5tpCYQsbWqSGeyu+6m1yZJ5NIwcSP9uIGhsS61NAhjW7
 3My6FMcb/j9ZAmrM7vRxpcvY8oAKTRZFGbCuwA/E89EeBlcFMWRPiooCRIOrhz8X5KYC
 FfUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742221704; x=1742826504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NaCPyDdxmRmZpYCr7DKDsJe3bk+lLzZjopyFV4R3vdM=;
 b=L7TZ3/lBc0JLi9eZVcP/OnjTw6T/Awh1c90bUC3JM/kL3lNMI99Xb4C7m9Oxvt391F
 QD+IjEdkjL06jn2oWVtb9YAIexK1huFORXwJaDLGukijEBuo4bJzYDV99YPbAoJWGhci
 7YqMF8jbDzU/ODSJGZ7qzLWF2v6kZRGVdK/MxUjXcOatwRccdWMB16dBTUVHG1nx73cU
 1jHD5WIIZGShojgzaZGyiBbBcMBBbbTtuVlX6BVtERDeZlFvmS8J/SgqSvBrZfT+OyCo
 m4ENI26uNnTPd7jqcipxNX1XmVIh+1y+mBfziblj30iVBmwp6/xbcizxWNAg12v8RCtf
 ZBxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUnA2xnf0BYTjZVP+Nm2+kWRTQ0O2saxIOQGvljsSwbkD7xmF6x67MELvBnmw8577Hqn8yCv8tqe4O@nongnu.org
X-Gm-Message-State: AOJu0YwnDMArBfyPKzOpAJPjHXEMc6oHlU5c3W//QHewAs9OdDnES3VL
 fsOTvWRDPvBCZrEuUzWMacpuE2P6ATrRR2FK/vSwH+h6RtqejHD3p23mQWHlWK0=
X-Gm-Gg: ASbGncuohIbtpQ/tqGBeoMAtSjWQ6tyNrzeaH9+Jc9o4ewx346vwqpwpcSpANWR/jxN
 vd4gGXWo7EmuLk8z/yJlta5HvVPLqTXd7FpqSij2Yy8QKBmnLPiCpcUjol72R87YgeE6G0YPqRX
 Na5bQGuFP3HG03nf9d3XVKmoSX+0Wusp1nDTfrsGyeTzFqP+KEl22Io0fL4jHq5CV4DCA97lfUV
 Q0/AdUIfhP/spNjbFVIxrTR8R9ceIhE7j0vvc/ggZFnMLdnnSHYWpsCpMakqXqimoxn0YA8A4gS
 fUu4VcSU5/UkjRdwLSVa48YVFZm4/9+ICRTBpNFUQXKbGUGlXTQ=
X-Google-Smtp-Source: AGHT+IFZgSA/cAkWsL0NANo70r3hAPr+GdqpLT9y7NSc4S/7MvPAGpv2x8FLpBZMLwhaZhgiayEm0Q==
X-Received: by 2002:a05:600c:46ca:b0:43c:ee62:33f5 with SMTP id
 5b1f17b1804b1-43d389ae727mr261045e9.27.1742221704183; 
 Mon, 17 Mar 2025 07:28:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe60ad4sm107914985e9.29.2025.03.17.07.28.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 07:28:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-10.1 3/9] target/arm: Handle AArch64 in TYPE_ARM_CPU
 gdb_arch_name
Date: Mon, 17 Mar 2025 14:28:13 +0000
Message-ID: <20250317142819.900029-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250317142819.900029-1-peter.maydell@linaro.org>
References: <20250317142819.900029-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Instead of having the TYPE_AARCH64_CPU subclass set
CPUClass::gdb_arch_name to a different function, make the
TYPE_ARM_CPU implementation of the method handle AArch64.

For the moment we make the "is this AArch64?" function test "is the
CPU of TYPE_AARCH64_CPU?", so that this produces no behavioural
change.  When we've moved all the gdbstub related methods across to
the base class, we will be able to change this to be "does the CPU
have the ARM_FEATURE_AARCH64 feature?".

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h | 6 ++++++
 target/arm/cpu.c       | 3 +++
 target/arm/cpu64.c     | 6 ------
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index bb962389192..a14c269fa5a 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1691,6 +1691,12 @@ void aarch64_add_sve_properties(Object *obj);
 void aarch64_add_sme_properties(Object *obj);
 #endif
 
+/* Return true if the gdbstub is presenting an AArch64 CPU */
+static inline bool arm_gdbstub_is_aarch64(ARMCPU *cpu)
+{
+    return object_dynamic_cast(OBJECT(cpu), TYPE_AARCH64_CPU);
+}
+
 /* Read the CONTROL register as the MRS instruction would. */
 uint32_t arm_v7m_mrs_control(CPUARMState *env, uint32_t secure);
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 01786ac7879..d69403fda90 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2647,6 +2647,9 @@ static const gchar *arm_gdb_arch_name(CPUState *cs)
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
 
+    if (arm_gdbstub_is_aarch64(cpu)) {
+        return "aarch64";
+    }
     if (arm_feature(env, ARM_FEATURE_IWMMXT)) {
         return "iwmmxt";
     }
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 8188ede5cc8..020b32f21e9 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -813,11 +813,6 @@ static void aarch64_cpu_finalizefn(Object *obj)
 {
 }
 
-static const gchar *aarch64_gdb_arch_name(CPUState *cs)
-{
-    return "aarch64";
-}
-
 static void aarch64_cpu_class_init(ObjectClass *oc, void *data)
 {
     CPUClass *cc = CPU_CLASS(oc);
@@ -825,7 +820,6 @@ static void aarch64_cpu_class_init(ObjectClass *oc, void *data)
     cc->gdb_read_register = aarch64_cpu_gdb_read_register;
     cc->gdb_write_register = aarch64_cpu_gdb_write_register;
     cc->gdb_core_xml_file = "aarch64-core.xml";
-    cc->gdb_arch_name = aarch64_gdb_arch_name;
 
     object_class_property_add_bool(oc, "aarch64", aarch64_cpu_get_aarch64,
                                    aarch64_cpu_set_aarch64);
-- 
2.43.0


