Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91386C44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjgP-0003Al-O7; Mon, 06 Jul 2026 09:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjgN-0002s9-4C
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:48:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjgK-0006ok-Gu
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:48:22 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666Ax7hi245529
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 13:48:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PJwFDn/oYUlgyh+vrkNeWnLqkInjmkCBFCNkS7Cm5xc=; b=COTkm4oLssADz64k
 1OlTwuzLvJ6Myng/W6BviftDXTGTZzhnKbaqCm+0Fn4Omhh1EJxB/SGC2Z4Y9ZTH
 Ml2XSxMne7Kb7Ppd8G1N4X+6mz9tUpb1PVmPqrlJLhKs1vXiTGkP2nVElYesvy2k
 vzP+3zoqVUD9pifaO+e05ep7khywUjwG/8hw/lW9dnOSlkQB2dOltpPAbFANYuyQ
 EOesVkN+ALcLoZQVwwepw4Bau9alQxih9WtuSug/wnSmJXVHDffuDGAiyArgArFS
 FUfpG5mtMPiUnruy8PV/5QTeLcpiSziBbhuylGlcttVnt8EJP3D7W01n5oia8zcj
 DziIXg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a98guf3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 13:48:19 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e61b38eddso552004285a.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 06:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783345698; x=1783950498; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PJwFDn/oYUlgyh+vrkNeWnLqkInjmkCBFCNkS7Cm5xc=;
 b=Vf0sCN/ADhahDaFe9ZblZs0Mm3a6FJPhaQdVQeQbWITwxGiNmpOQ+hnC2S1LhwL+s4
 erG6JQSpjH9c2F/LGH2QFuMR0UfD1hSs8pNW6PUqH5JAaSCnf9sXXynBEBRq+0HFYpXz
 2JFibjI3aPE6d9ccwV56NgrkMqGaVhN0tIouh3l0JPF43fA5F62zBAsHgLO2h6RcY3Ut
 sLwl+cDhk9kh/PfhBRaaFvp+1tyGgrOcuDlxuIvKLJtYFNOKHq3CEMVlsGuXbOtv95dq
 pRcpK96Ii7VKcrfznXqPziJCB3N4RzI2LzWobY1vRrWIROmHqB0hxTWLc59H+pwJIl7G
 iRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783345698; x=1783950498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PJwFDn/oYUlgyh+vrkNeWnLqkInjmkCBFCNkS7Cm5xc=;
 b=RY46VHBgVX12EF20Eegk6Oc9kftS6SnhPeuFMdrg+jeReZDyLW5/0N8//b0lb08oV1
 9X0TD/kO9cV6IJPQP7yp4nxCXWRcnJ5GhZedOrTNgfMRMDeHrQF91ziWfz4a1DOdVjvk
 T4/623iWCowD1vhv96LohY47CN0PscIPCdCUVltc4jzc9SwcxvH0ALqO3qfRJiWXx6yZ
 ZGiZjTZaQzd/K4rTki9zx4EgS1jPjxc+IXnSFgRQEYM0sUCOSwsa6s1yd0F4IyCA0a69
 3mUcO61tXzrSjFD9OQRWkSU4QnW2xsbx4vQ8ViCjdb3YI3FpA8iylWWN9UKSk4Fw6vyz
 +EeA==
X-Gm-Message-State: AOJu0YyxfruoyHPtP7YNrpeNUHzyWNs40SDlJUgLKqwh/Pe8TFybkv7r
 u1xyuI7/59qwGH0E3DOUgTcYH0EFhtEGQ0jeBBYlrfMyoB+5d/tVtCnOSFxNtjloAICc0KfM9w/
 1Ml9PysLAWHyKx5jwnGWEXanMWjaYPPyu7kBN7Wxc88D0l83cbc/usdOQVhROCGKbiA==
X-Gm-Gg: AfdE7cmiG2inKjwR6HmXNBBkwnTHvZ87J2uy8W/yT/fLHSv7sIFDBxFu+Zzq7cnkxUg
 Fa2fu5k/u6yddH+PMBGbNN8LBD68REACjC/Kb2rW9prkkRTQ4XlHTh+RjB9u9MXHgtfPg6USx2K
 nygNfZZsjP3fb3J8D3zLOJPwIXzlhgWYFNtZGzvTQ8Hb0C+3KmdfgykKov28mGva/deWBS6P8Yl
 sNPLXYD1wE0dlCeELrhwRZsI/gnVUzoMhSoTh8AG7G4lyNHSX9piG5Lz8fVVfHirQwWGg/5gDCi
 c/xzgd+cbUfgXfvLCl9FGiyRRnpjRsLygdxW8A5uJpo7N0TBuV+LDUeHfcokSUSkZ3RpZ3BcjNM
 3mCldKGIpQH+wmwW6KgCz0untXMwizwVDyW8GV3AF04Kz+Z6I77DOgvHSyQ==
X-Received: by 2002:a05:620a:808c:b0:92e:5554:a80e with SMTP id
 af79cd13be357-92ebb5601acmr86657585a.39.1783345697848; 
 Mon, 06 Jul 2026 06:48:17 -0700 (PDT)
X-Received: by 2002:a05:620a:808c:b0:92e:5554:a80e with SMTP id
 af79cd13be357-92ebb5601acmr86651285a.39.1783345697190; 
 Mon, 06 Jul 2026 06:48:17 -0700 (PDT)
Received: from localhost.localdomain (1.171.88.92.rev.sfr.net. [92.88.171.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0f21543sm23819551f8f.35.2026.07.06.06.48.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Jul 2026 06:48:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/32] accel: Remove AccelOpsClass::supports_guest_debug
Date: Mon,  6 Jul 2026 15:45:13 +0200
Message-ID: <20260706134527.84808-19-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706134527.84808-1-philmd@oss.qualcomm.com>
References: <20260706134527.84808-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SpigLvO0 c=1 sm=1 tr=0 ts=6a4bb223 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PLEY+c9/kVlxBKEpvFYBUQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=u5zfA1t3EaNT3PtHZxEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX+1bEVRQrdJVX
 2zT2KTsw8N8W8eU7ZMbQ75L2YpeAEarJwXT1jBYhKPoi5ZUYEn04TdvhkG8D3WcnweHrh+cnFUH
 Uv7aOyl9Va363MTcQcyZQUs0ayt4VbsHa52k+nx/LVyZFcfN2cBD9jLMo6Ufa9HXRAlar6+KO9a
 gYRorft6S/+5m++C36tStK59DHISjKx7NOhwXWTEAkEy4KbVlFUbILpJ7Wq0/2bxrAP33974krR
 d9+5T4ExRaK9fFfyzqq/a5Q9lnxTx3vN5NEUnDNBXIsUM6Lyb9LAyFs9eJSxlOufzGslYiAI7rl
 y3EkJItkrr0CZ1WIHwsJlWf18/8o2SwkMVYo9/znSX/c/Lf9HZnZBH9tehLrOMzShfiA+EjMl6U
 Dej2C0OaXlmwjWbMMCtkfFr5IsneyQEXSqi4ncrqKsHq5hM9m5+mUD+tvntUzPF5PN0xCzU3V3J
 GLjCaeHSOUdT24EpqLQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX+mEjZ+31wzIt
 +ME76D06dIVTmNa5W/1hbLLIwbWe0P5uf2zbFoeLAV9UpHtmEh5DYxuUnFJ4RYXS9qR6vnvfJxt
 ibjs1I7ADopJCEzoi3IHa54Nz8YdlWw=
X-Proofpoint-GUID: PipPyxZCczzqFVQhP8fP88zsKMPHuxut
X-Proofpoint-ORIG-GUID: PipPyxZCczzqFVQhP8fP88zsKMPHuxut
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060141
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Now accelerators hold the 'guest debug supported' information
in their state, accessible by the common code. No need to call
a per-accelerator handler, simply check for the SSTEP_ENABLE
in AccelGdbConfig::sstep_flags.

Remove all AccelOpsClass::supports_guest_debug implementations,
inline gdb_supports_guest_debug() and remove the now unnecessary
KVMState::have_guest_debug field.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260705215729.62196-18-philmd@oss.qualcomm.com>
---
 docs/system/gdb.rst           |  2 +-
 accel/kvm/kvm-cpus.h          |  1 -
 include/accel/accel-cpu-ops.h |  1 -
 include/qemu/accel.h          |  2 ++
 include/system/hvf_int.h      |  5 -----
 include/system/kvm_int.h      |  1 -
 include/system/whpx-all.h     |  3 ---
 accel/accel-common.c          |  5 +++++
 accel/hvf/hvf-accel-ops.c     |  1 -
 accel/kvm/kvm-accel-ops.c     |  1 -
 accel/kvm/kvm-all.c           | 13 +------------
 accel/tcg/tcg-accel-ops.c     |  6 ------
 accel/whpx/whpx-accel-ops.c   |  6 ------
 gdbstub/system.c              | 13 +------------
 target/arm/hvf/hvf.c          |  5 -----
 target/arm/whpx/whpx-all.c    |  5 -----
 target/i386/hvf/hvf.c         |  5 -----
 target/i386/whpx/whpx-all.c   |  5 -----
 18 files changed, 10 insertions(+), 70 deletions(-)

diff --git a/docs/system/gdb.rst b/docs/system/gdb.rst
index d50470b135e..b6d8f8e77da 100644
--- a/docs/system/gdb.rst
+++ b/docs/system/gdb.rst
@@ -54,7 +54,7 @@ While GDB can always fall back to inserting breakpoints into memory
 accelerator. For TCG system emulation we advertise an infinite number
 of hardware assisted breakpoints and watchpoints. For other
 accelerators it will depend on if support has been added (see
-supports_guest_debug and related hooks in AccelOpsClass).
+the AccelGdbConfig structure).
 
 As TCG cannot track all memory accesses in user-mode there is no
 support for watchpoints.
diff --git a/accel/kvm/kvm-cpus.h b/accel/kvm/kvm-cpus.h
index 688511151c8..3185659562d 100644
--- a/accel/kvm/kvm-cpus.h
+++ b/accel/kvm/kvm-cpus.h
@@ -16,7 +16,6 @@ void kvm_destroy_vcpu(CPUState *cpu);
 void kvm_cpu_synchronize_post_reset(CPUState *cpu);
 void kvm_cpu_synchronize_post_init(CPUState *cpu);
 void kvm_cpu_synchronize_pre_loadvm(CPUState *cpu);
-bool kvm_supports_guest_debug(void);
 int kvm_insert_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len);
 int kvm_remove_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len);
 void kvm_remove_all_breakpoints(CPUState *cpu);
diff --git a/include/accel/accel-cpu-ops.h b/include/accel/accel-cpu-ops.h
index 9c07a903ea0..b23a0606c7e 100644
--- a/include/accel/accel-cpu-ops.h
+++ b/include/accel/accel-cpu-ops.h
@@ -84,7 +84,6 @@ struct AccelOpsClass {
     int64_t (*get_elapsed_ticks)(void);
 
     /* gdbstub hooks */
-    bool (*supports_guest_debug)(void);
     int (*update_guest_debug)(CPUState *cpu);
     int (*insert_breakpoint)(CPUState *cpu, int type, vaddr addr, vaddr len);
     int (*remove_breakpoint)(CPUState *cpu, int type, vaddr addr, vaddr len);
diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index 8e0c3dfe088..6f65f1cb89a 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -84,4 +84,6 @@ typedef struct AccelGdbConfig {
     bool can_reverse;
 } AccelGdbConfig;
 
+bool accel_supports_guest_debug(AccelState *accel);
+
 #endif /* QEMU_ACCEL_H */
diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index 58fb865ebae..d64f4942556 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -104,11 +104,6 @@ void hvf_arch_remove_all_hw_breakpoints(void);
  */
 int hvf_update_guest_debug(CPUState *cpu);
 
-/*
- * Return whether the guest supports debugging.
- */
-bool hvf_arch_supports_guest_debug(void);
-
 bool hvf_arch_cpu_realize(CPUState *cpu, Error **errp);
 uint32_t hvf_arch_get_default_ipa_bit_size(void);
 uint32_t hvf_arch_get_max_ipa_bit_size(void);
diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
index 53bb0fcf180..0876aac938d 100644
--- a/include/system/kvm_int.h
+++ b/include/system/kvm_int.h
@@ -118,7 +118,6 @@ struct KVMState
 #endif
     int max_nested_state_len;
     int kvm_shadow_mem;
-    bool have_guest_debug;
     bool kernel_irqchip_allowed;
     bool kernel_irqchip_required;
     OnOffAuto kernel_irqchip_split;
diff --git a/include/system/whpx-all.h b/include/system/whpx-all.h
index 4022571ffff..d018e67e4f7 100644
--- a/include/system/whpx-all.h
+++ b/include/system/whpx-all.h
@@ -22,7 +22,4 @@ void whpx_translate_cpu_breakpoints(
 void whpx_arch_destroy_vcpu(CPUState *cpu);
 void whpx_arch_accel_class_init(ObjectClass *oc);
 
-/* called by whpx-accel-ops */
-bool whpx_arch_supports_guest_debug(void);
-
 #endif
diff --git a/accel/accel-common.c b/accel/accel-common.c
index f31d68a9b78..00a400243f0 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -70,6 +70,11 @@ void accel_init_interfaces(AccelClass *ac)
     accel_init_cpu_interfaces(ac);
 }
 
+bool accel_supports_guest_debug(AccelState *accel)
+{
+    return accel->gdbstub.sstep_flags & SSTEP_ENABLE;
+}
+
 void accel_cpu_instance_init(CPUState *cpu)
 {
     if (cpu->cc->accel_cpu && cpu->cc->accel_cpu->cpu_instance_init) {
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index dd2b45b7cb5..ecc0cd1b558 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -369,7 +369,6 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->remove_breakpoint = hvf_remove_breakpoint;
     ops->remove_all_breakpoints = hvf_remove_all_breakpoints;
     ops->update_guest_debug = hvf_update_guest_debug;
-    ops->supports_guest_debug = hvf_arch_supports_guest_debug;
 
     ops->get_vcpu_stats = hvf_get_vcpu_stats;
 };
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index d7967bc922f..45330327909 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -105,7 +105,6 @@ static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->synchronize_pre_loadvm = kvm_cpu_synchronize_pre_loadvm;
     ops->handle_interrupt = generic_handle_interrupt;
 
-    ops->supports_guest_debug = kvm_supports_guest_debug;
 #ifdef TARGET_KVM_HAVE_GUEST_DEBUG
     ops->update_guest_debug = kvm_update_guest_debug_ops;
     ops->insert_breakpoint = kvm_insert_breakpoint;
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index ceb0b33abdd..b03488ebac3 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3036,10 +3036,7 @@ static int kvm_init(AccelState *as, MachineState *ms)
         (kvm_check_extension(s, KVM_CAP_VM_ATTRIBUTES) > 0);
 
 #ifdef TARGET_KVM_HAVE_GUEST_DEBUG
-    s->have_guest_debug =
-        (kvm_check_extension(s, KVM_CAP_SET_GUEST_DEBUG) > 0);
-
-    if (s->have_guest_debug) {
+    if (kvm_check_extension(s, KVM_CAP_SET_GUEST_DEBUG) > 0) {
         as->gdbstub.sstep_flags = SSTEP_ENABLE;
 
         int guest_debug_flags =
@@ -3829,14 +3826,6 @@ int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap)
     return data.err;
 }
 
-bool kvm_supports_guest_debug(void)
-{
-    KVMState *s = KVM_STATE(as);
-
-    /* probed during kvm_init() */
-    return s->have_guest_debug;
-}
-
 int kvm_insert_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len)
 {
     struct kvm_sw_breakpoint *bp;
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index c179cd4adeb..927af6c1db0 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -109,11 +109,6 @@ void tcg_handle_interrupt(CPUState *cpu, int mask)
     }
 }
 
-static bool tcg_supports_guest_debug(void)
-{
-    return true;
-}
-
 /* Translate GDB watchpoint type to a flags value for cpu_watchpoint_* */
 static inline int xlat_gdb_type(CPUState *cpu, int gdbtype)
 {
@@ -221,7 +216,6 @@ static void tcg_accel_ops_init(AccelClass *ac)
     }
 
     ops->cpu_reset_hold = tcg_cpu_reset_hold;
-    ops->supports_guest_debug = tcg_supports_guest_debug;
     ops->insert_breakpoint = tcg_insert_breakpoint;
     ops->remove_breakpoint = tcg_remove_breakpoint;
     ops->remove_all_breakpoints = tcg_remove_all_breakpoints;
diff --git a/accel/whpx/whpx-accel-ops.c b/accel/whpx/whpx-accel-ops.c
index b8f41544cbe..ca5a119521a 100644
--- a/accel/whpx/whpx-accel-ops.c
+++ b/accel/whpx/whpx-accel-ops.c
@@ -82,11 +82,6 @@ static bool whpx_vcpu_thread_is_idle(CPUState *cpu)
     return !whpx_irqchip_in_kernel();
 }
 
-static bool whpx_supports_guest_debug(void)
-{
-    return whpx_arch_supports_guest_debug();
-}
-
 
 static void whpx_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
@@ -96,7 +91,6 @@ static void whpx_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->kick_vcpu_thread = whpx_kick_vcpu_thread;
     ops->cpu_thread_is_idle = whpx_vcpu_thread_is_idle;
     ops->handle_interrupt = generic_handle_interrupt;
-    ops->supports_guest_debug = whpx_supports_guest_debug;
 
     ops->synchronize_post_reset = whpx_cpu_synchronize_post_reset;
     ops->synchronize_post_init = whpx_cpu_synchronize_post_init;
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 2e8c457097b..bf7aa1ac234 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -331,8 +331,6 @@ static void create_processes(GDBState *s)
     gdb_create_default_process(s);
 }
 
-static bool gdb_supports_guest_debug(void);
-
 bool gdbserver_start(const char *device, Error **errp)
 {
     Chardev *chr = NULL;
@@ -345,7 +343,7 @@ bool gdbserver_start(const char *device, Error **errp)
         return false;
     }
 
-    if (!gdb_supports_guest_debug()) {
+    if (!accel_supports_guest_debug(current_accel())) {
         error_setg(errp, "gdbstub: current accelerator doesn't "
                    "support guest debugging");
         return false;
@@ -624,15 +622,6 @@ int gdb_signal_to_target(int sig)
  * Break/Watch point helpers
  */
 
-static bool gdb_supports_guest_debug(void)
-{
-    const AccelOpsClass *ops = cpus_get_accel();
-    if (ops->supports_guest_debug) {
-        return ops->supports_guest_debug();
-    }
-    return false;
-}
-
 int gdb_breakpoint_insert(CPUState *cs, int type, vaddr addr, vaddr len)
 {
     const AccelOpsClass *ops = cpus_get_accel();
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 8b902c68829..e16457c3cfb 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2900,8 +2900,3 @@ void hvf_arch_update_guest_debug(CPUState *cpu)
 
     hvf_arch_set_traps(cpu);
 }
-
-bool hvf_arch_supports_guest_debug(void)
-{
-    return true;
-}
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 3079c6293c8..00a5de8cdc1 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -295,11 +295,6 @@ void whpx_translate_cpu_breakpoints(
     /* Breakpoints aren’t supported on this platform */
 }
 
-bool whpx_arch_supports_guest_debug(void) 
-{
-    return false;
-}
-
 void whpx_arch_destroy_vcpu(CPUState *cpu)
 {
     /* currently empty on Arm */
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 2d1a943b96c..19ad64a1d93 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -1066,8 +1066,3 @@ void hvf_arch_remove_all_hw_breakpoints(void)
 void hvf_arch_update_guest_debug(CPUState *cpu)
 {
 }
-
-bool hvf_arch_supports_guest_debug(void)
-{
-    return false;
-}
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 467ac6bed45..11b5d1fc607 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1853,11 +1853,6 @@ void whpx_apply_breakpoints(
     }
 }
 
-bool whpx_arch_supports_guest_debug(void) 
-{
-    return true;
-}
-
 void whpx_arch_destroy_vcpu(CPUState *cpu)
 {
     X86CPU *x86cpu = X86_CPU(cpu);
-- 
2.53.0


