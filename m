Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2576C43602
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 21:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgUsC-0000I2-3k; Sun, 05 Jul 2026 17:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUsA-0000FJ-Mb
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 17:59:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUs8-0000MJ-8x
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 17:59:34 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665LxKbu2839031
 for <qemu-devel@nongnu.org>; Sun, 5 Jul 2026 21:59:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bc1IU9CgmcY+0G7lSlsFtIectefxcgj07/d7AIAf3oM=; b=oSTsYvl/iwJiqQ++
 w405USHY8161JYAO2/p197rYMGVPyKghPTNapkTRp4vR3mrHfReXAdAmJAqN+o3V
 REvKOrff/GaHW6bV94q8cTC5WBR6FECVw5ZsPm8DS0Ho9cLnzkkBh6plUSmBFJbQ
 hyQya1PxBYjxCpkMbiFdMCHDTTGIBL2d0/GzcTWot+WdMoWYk2twbsJ3OQIj+qMs
 SKRPDPRirB9qW+ek95eMlKOELX4ZP+dnzNe6SRsOnK5qMqRsr9c3igP4BEypmjZy
 v8K8QEHlM1n3e4OwokmjUmsk49R/6UYsrSNiwprulp5VgCJ6F6XVNc20iRC0E6aR
 1gOAfQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6qvgutsd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 21:59:20 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e7ee64b25so416128585a.0
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 14:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783288759; x=1783893559; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bc1IU9CgmcY+0G7lSlsFtIectefxcgj07/d7AIAf3oM=;
 b=d9/hfntt8i7M7PPCvYtqs5xIBsafzUzgYc2ORJ3Uu4YrniAPWLiZghT041aYAjN2Zb
 gme3TbytNsb+kXLp8rQI5Jz3nhI1fIB5f52rkn6fBlu+m0bZn9kUYpIlRHS/1GNIjBTI
 vmQZSf3gnAg9snT4n/fzTo3tKbuVBL20ou1fwoz9PdaIIoF7NvRP9ofQ+Yke+lpBS0+9
 wUZBV7yWTTgyTgTw0ovGwjk0+ac0Iwjh4tVCO233iSmQbI8dSaqoVQQUM3Z4qLCiG3J/
 wz0VLzYQzT1dgyjKrMgcF0CtuS9smCocTYHV/fIZ2nSUdOgnOSLoePxSAXKCV4cBzXdV
 mwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783288759; x=1783893559;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bc1IU9CgmcY+0G7lSlsFtIectefxcgj07/d7AIAf3oM=;
 b=pmbbpMFoe3Piikf8X6GpNiV7o0I2stzVJLF+jb5qgUcbIA5QREeFt9LgJPO6dNHgud
 iR2Jjk/yicryp4p8HuisuYTjApb8XHVlerRZEsAPLMS/JbIu2xDKp+QY+pMYr5hrMqcy
 c/x6ebzY++VGPF35KfBFk/InAOJPkPDNGZ+MumNsqTbcl54Bz/VIZPkoaxQKiFQbNWfz
 JZVY9uLpcTR8hg6/qL1+KTfiu9xR86TCEfJFNrRyhdNuSHk6ScXqcIOuJN0jtaxIutoQ
 PJ35QCaGOeDBaIVXQb7a6DeZcynfAkAUik0YK6hT1wgi6Jm48xem74b3Q5SyowUa6sZN
 WEwA==
X-Gm-Message-State: AOJu0Yz/VUN/KI/P9Lg+ZAIaiszaPxPsWQEsGJSkE2qJLf1nMNZj5CUG
 7NdDRe8Y5oT6wbdvpVLPzS/JeDWWcKHS5MLANS8pgofmr8JWFLtsi67fvolgXCLPCEmYAjzwSEQ
 HQj1u4rlwby/dNnsSm0jf6zj4eGu0CcA5ryKyuXYlcf6BFkPiC7EZDZttjoMuNt6mUg==
X-Gm-Gg: AfdE7cn/atq8GZp4jEMkXOhEUvW9+JeRE5eqDRkHytWqX+tA9OAwa7SbkOXhIcVKWxf
 qeSRlIgRGrcTWiybbaturD7Gn7LjtSpu1rFxOOxGXjeOnVEYDqb/7eGEkCfxb9QIJp7klKw/WGn
 i2vDwsTzMkhJ9mH7qplx+J7SkA8wbkyJ7FzfnexT696OSM2uYuwgAGKkTVzgq4dCbf+f0BQynEC
 c14aNNh7xMiQfR1sH1c6kBnttw6CVNtSE4yLZYdrff3OgcOAZu+p14CK1ARLZafbt61T861Lkwv
 T8q7kQv6uVW2aIAZcd996QbBg/0F6rVOu7OXm1Bqj+1jPCbovzz14Cqi2hLRurjj2PhKgeq397j
 nDH9gBc6UdfJlV3dtQPE6e/ovufElorPUVSY7Rbnc5SHGLhIpMvgxbA==
X-Received: by 2002:a05:620a:44c2:b0:92e:5137:2830 with SMTP id
 af79cd13be357-92e9a4d281cmr1046091185a.72.1783288759423; 
 Sun, 05 Jul 2026 14:59:19 -0700 (PDT)
X-Received: by 2002:a05:620a:44c2:b0:92e:5137:2830 with SMTP id
 af79cd13be357-92e9a4d281cmr1046088685a.72.1783288758923; 
 Sun, 05 Jul 2026 14:59:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1e785sm18913925f8f.8.2026.07.05.14.59.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Jul 2026 14:59:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, alex.bennee@linaro.org,
 qemu-s390x@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 14/32] accel: Have each implementation return their
 AccelGdbConfig
Date: Sun,  5 Jul 2026 23:57:10 +0200
Message-ID: <20260705215729.62196-15-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705215729.62196-1-philmd@oss.qualcomm.com>
References: <20260705215729.62196-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VvoTxe2n c=1 sm=1 tr=0 ts=6a4ad3b8 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=GIYXWNLsZHjPOkf-ILAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: VMyIl78Nn9bFYn5Hvhg6XrRF_KUf05K3
X-Proofpoint-GUID: VMyIl78Nn9bFYn5Hvhg6XrRF_KUf05K3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIzOCBTYWx0ZWRfX3UYpVmlT2VIu
 pYcbvIlptZoD8eINf142+/yuV81oOqNjfEFxQ0065zVFi91QfP7omx8Ai5UUqrQUFXVMyNJ3wKv
 Bl66KTn/vXaJMLCM/Hl7za2ffPl63zI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIzOCBTYWx0ZWRfX/xVoMN/ikWDJ
 RrxlZ9U8TTFvc9XUc/TR8n2wZ91R5cpia0bbyduloOI7DCUK9WsT6ctx/veWK+EAQ1uI/tqYUnx
 T+lwGFLdD47PI9R3UuH63xnT4JZARdPOIKZ3+3F4342ix1xmL3gf2HkjNr4EqppE3f0dFVS2Fon
 ytsEag5Ry7KYPW51GvnfIA7uqq2XyvKvBAIsniEnk5hmEAsbz8MO8ycLxBTGBDRdl80ZQOw3T8x
 S4OTxDOQjiJoS8nO1t++WYvw83d+Ary5N3rlrtZVJoJ8HJg/Df4TO8U6dqHCQQFmcLkIx7hsX8g
 y5+fs8fi6At8NSH34UWvJu6Po7+6FpLaWzEngxiD/V2XSvnpexEwn5D6BV9nX5jRJ1VRcbOZ0NH
 kWu/Iu65CXcL5ofeCqZML2x9/do746vi0QQ3dGfrpDMKz91yEzfRjP3C+qynOH9aHoUwEwhn+Lp
 bSr4qDHK1MjpoJfcbKg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050238
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hold the per-accelerator AccelGdbConfig in AccelState, set its
single @sstep_flags field in AccelClass::init_machine handlers.

Remove the AccelClass::gdbstub_supported_sstep_flags() getter
and inline the single accel_supported_gdbstub_sstep_flags() call
in gdb_init_gdbserver_state().

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/accel/accel-ops.h   |  5 ++---
 include/qemu/accel.h        |  8 --------
 include/system/whpx-all.h   |  1 -
 accel/accel-common.c        | 10 ----------
 accel/hvf/hvf-all.c         |  8 ++------
 accel/kvm/kvm-all.c         | 17 ++---------------
 accel/tcg/tcg-all.c         | 27 +++++++++++----------------
 accel/whpx/whpx-common.c    |  1 -
 gdbstub/gdbstub.c           |  2 +-
 target/arm/whpx/whpx-all.c  |  5 -----
 target/i386/whpx/whpx-all.c |  7 ++-----
 11 files changed, 20 insertions(+), 71 deletions(-)

diff --git a/include/accel/accel-ops.h b/include/accel/accel-ops.h
index f46492e3fe1..9f3f329c448 100644
--- a/include/accel/accel-ops.h
+++ b/include/accel/accel-ops.h
@@ -13,6 +13,8 @@
 
 struct AccelState {
     Object parent_obj;
+
+    AccelGdbConfig gdbstub;
 };
 
 struct AccelClass {
@@ -36,9 +38,6 @@ struct AccelClass {
     bool (*has_memory)(AccelState *accel, AddressSpace *as,
                        hwaddr start_addr, hwaddr size);
 
-    /* gdbstub related hooks */
-    int (*gdbstub_supported_sstep_flags)(AccelState *as);
-
     bool *allowed;
     /*
      * Array of global properties that would be applied when specific
diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index 052b4c59313..3b01d55741b 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -82,12 +82,4 @@ typedef struct AccelGdbConfig {
     unsigned sstep_flags;
 } AccelGdbConfig;
 
-/**
- * accel_supported_gdbstub_sstep_flags:
- *
- * Returns the supported single step modes for the configured
- * accelerator.
- */
-int accel_supported_gdbstub_sstep_flags(void);
-
 #endif /* QEMU_ACCEL_H */
diff --git a/include/system/whpx-all.h b/include/system/whpx-all.h
index 0e2d333e919..4022571ffff 100644
--- a/include/system/whpx-all.h
+++ b/include/system/whpx-all.h
@@ -23,7 +23,6 @@ void whpx_arch_destroy_vcpu(CPUState *cpu);
 void whpx_arch_accel_class_init(ObjectClass *oc);
 
 /* called by whpx-accel-ops */
-int whpx_arch_gdbstub_sstep_flags(AccelState *as);
 bool whpx_arch_supports_guest_debug(void);
 
 #endif
diff --git a/accel/accel-common.c b/accel/accel-common.c
index 62590a7d9a6..f31d68a9b78 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -113,16 +113,6 @@ void accel_cpu_common_unrealize(CPUState *cpu)
     }
 }
 
-int accel_supported_gdbstub_sstep_flags(void)
-{
-    AccelState *accel = current_accel();
-    AccelClass *acc = ACCEL_GET_CLASS(accel);
-    if (acc->gdbstub_supported_sstep_flags) {
-        return acc->gdbstub_supported_sstep_flags(accel);
-    }
-    return 0;
-}
-
 static const TypeInfo accel_types[] = {
     {
         .name           = TYPE_ACCEL,
diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 21b9b71a6df..8bd9154a50b 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -220,6 +220,8 @@ static int hvf_accel_init(AccelState *as, MachineState *ms)
     }
     assert_hvf_ok(ret);
 
+    as->gdbstub.sstep_flags = SSTEP_ENABLE | SSTEP_NOIRQ;
+
     QTAILQ_INIT(&s->hvf_sw_breakpoints);
 
     hvf_state = s;
@@ -228,11 +230,6 @@ static int hvf_accel_init(AccelState *as, MachineState *ms)
     return hvf_arch_init();
 }
 
-static int hvf_gdbstub_sstep_flags(AccelState *as)
-{
-    return SSTEP_ENABLE | SSTEP_NOIRQ;
-}
-
 static void hvf_set_kernel_irqchip(Object *obj, Visitor *v,
                                    const char *name, void *opaque,
                                    Error **errp)
@@ -278,7 +275,6 @@ static void hvf_accel_class_init(ObjectClass *oc, const void *data)
     ac->name = "HVF";
     ac->init_machine = hvf_accel_init;
     ac->allowed = &hvf_allowed;
-    ac->gdbstub_supported_sstep_flags = hvf_gdbstub_sstep_flags;
     hvf_kernel_irqchip_override = false;
     hvf_kernel_irqchip = false;
     object_class_property_add(oc, "kernel-irqchip", "on|off|split",
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index b6125125f82..ceb0b33abdd 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -104,7 +104,6 @@ bool kvm_readonly_mem_allowed;
 bool kvm_vm_attributes_allowed;
 bool kvm_msi_use_devid;
 bool kvm_pre_fault_memory_supported;
-static int kvm_sstep_flags;
 static bool kvm_immediate_exit;
 static uint64_t kvm_supported_memory_attributes;
 static bool kvm_guest_memfd_supported;
@@ -3041,13 +3040,13 @@ static int kvm_init(AccelState *as, MachineState *ms)
         (kvm_check_extension(s, KVM_CAP_SET_GUEST_DEBUG) > 0);
 
     if (s->have_guest_debug) {
-        kvm_sstep_flags = SSTEP_ENABLE;
+        as->gdbstub.sstep_flags = SSTEP_ENABLE;
 
         int guest_debug_flags =
             kvm_check_extension(s, KVM_CAP_SET_GUEST_DEBUG2);
 
         if (guest_debug_flags & KVM_GUESTDBG_BLOCKIRQ) {
-            kvm_sstep_flags |= SSTEP_NOIRQ;
+            as->gdbstub.sstep_flags |= SSTEP_NOIRQ;
         }
     }
 #endif
@@ -4279,17 +4278,6 @@ static void kvm_accel_instance_init(Object *obj)
     s->honor_guest_pat = ON_OFF_AUTO_OFF;
 }
 
-/**
- * kvm_gdbstub_sstep_flags():
- *
- * Returns: SSTEP_* flags that KVM supports for guest debug. The
- * support is probed during kvm_init()
- */
-static int kvm_gdbstub_sstep_flags(AccelState *as)
-{
-    return kvm_sstep_flags;
-}
-
 static void kvm_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
@@ -4298,7 +4286,6 @@ static void kvm_accel_class_init(ObjectClass *oc, const void *data)
     ac->rebuild_guest = kvm_reset_vmfd;
     ac->has_memory = kvm_accel_has_memory;
     ac->allowed = &kvm_allowed;
-    ac->gdbstub_supported_sstep_flags = kvm_gdbstub_sstep_flags;
 
     object_class_property_add(oc, "kernel-irqchip", "on|off|split",
         NULL, kvm_set_kernel_irqchip,
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 8eb4a6b89e8..d30b53cd3b7 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -149,6 +149,17 @@ static int tcg_init_machine(AccelState *as, MachineState *ms)
 
     tcg_allowed = true;
 
+    as->gdbstub.sstep_flags = SSTEP_ENABLE;
+    if (replay_mode == REPLAY_MODE_NONE) {
+        /*
+         * In replay mode all events will come from the log and can't be
+         * suppressed otherwise we would break determinism. However as those
+         * events are tied to the number of executed instructions we won't see
+         * them occurring every time we single step.
+         */
+        as->gdbstub.sstep_flags |= SSTEP_NOIRQ | SSTEP_NOTIMER;
+    }
+
     page_init();
     tb_htable_init();
     tcg_init(s->tb_size * MiB, s->splitwx_enabled, max_threads);
@@ -242,21 +253,6 @@ static void tcg_set_one_insn_per_tb(Object *obj, bool value, Error **errp)
     qatomic_set(&one_insn_per_tb, value);
 }
 
-static int tcg_gdbstub_supported_sstep_flags(AccelState *as)
-{
-    /*
-     * In replay mode all events will come from the log and can't be
-     * suppressed otherwise we would break determinism. However as those
-     * events are tied to the number of executed instructions we won't see
-     * them occurring every time we single step.
-     */
-    if (replay_mode != REPLAY_MODE_NONE) {
-        return SSTEP_ENABLE;
-    } else {
-        return SSTEP_ENABLE | SSTEP_NOIRQ | SSTEP_NOTIMER;
-    }
-}
-
 static void tcg_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
@@ -266,7 +262,6 @@ static void tcg_accel_class_init(ObjectClass *oc, const void *data)
     ac->cpu_common_unrealize = tcg_exec_unrealizefn;
     ac->get_stats = tcg_get_stats;
     ac->allowed = &tcg_allowed;
-    ac->gdbstub_supported_sstep_flags = tcg_gdbstub_supported_sstep_flags;
 
     object_class_property_add_str(oc, "thread",
                                   tcg_get_thread,
diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index e3f93efc61f..247e12db812 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -527,7 +527,6 @@ static void whpx_accel_class_init(ObjectClass *oc, const void *data)
     ac->init_machine = whpx_accel_init;
     ac->pre_resume_vm = whpx_pre_resume_vm;
     ac->allowed = &whpx_allowed;
-    ac->gdbstub_supported_sstep_flags = whpx_arch_gdbstub_sstep_flags;
 
     object_class_property_add(oc, "kernel-irqchip", "on|off|split",
         NULL, whpx_set_kernel_irqchip,
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 06b712562c5..6c4fa065638 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -72,7 +72,7 @@ void gdb_init_gdbserver_state(void)
      * By default try to use no IRQs and no timers while single
      * stepping so as to make single stepping like a typical ICE HW step.
      */
-    gdbserver_state.accel_config.sstep_flags = accel_supported_gdbstub_sstep_flags();
+    gdbserver_state.accel_config = current_accel()->gdbstub;
     gdbserver_state.sstep_flags = SSTEP_ENABLE | SSTEP_NOIRQ | SSTEP_NOTIMER;
     gdbserver_state.sstep_flags &= gdbserver_state.accel_config.sstep_flags;
 }
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 5208d7e1dfe..3079c6293c8 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -295,11 +295,6 @@ void whpx_translate_cpu_breakpoints(
     /* Breakpoints aren’t supported on this platform */
 }
 
-int whpx_arch_gdbstub_sstep_flags(AccelState *as)
-{
-    return 0;
-}
-
 bool whpx_arch_supports_guest_debug(void) 
 {
     return false;
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index f6e1636a4e0..467ac6bed45 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1853,11 +1853,6 @@ void whpx_apply_breakpoints(
     }
 }
 
-int whpx_arch_gdbstub_sstep_flags(AccelState *as)
-{
-    return SSTEP_ENABLE;
-}
-
 bool whpx_arch_supports_guest_debug(void) 
 {
     return true;
@@ -3348,6 +3343,8 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     whpx_memory_init();
     whpx_init_emu();
 
+    as->gdbstub.sstep_flags = SSTEP_ENABLE;
+
     return 0;
 
 error:
-- 
2.53.0


