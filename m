Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B0BC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:40:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfgwK-0002KL-Hi; Fri, 03 Jul 2026 12:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgwJ-0002H1-54
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:40:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgw8-0000X6-Tt
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:40:30 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GIoLj498256
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 16:40:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Vl143n2Efcc1cvNmnaWGElQ+fuvmLhHAw55vZ/sV884=; b=JHT5hdFSsiHZlTKB
 rFh84QgrunEPNe49b0g/sJ5yo4HTNHvnFijlRUY5qI7i1bF7XhtCqmILb6kiiuWx
 rKfftaqDcYYWpBnUV2Q/yMaslWF5cooEoZG+YaBs9dvquj9r5kRbGVd9Cod5O7MW
 pGT7YYTaiQX6Zj8chCFt5E8DWNxM6vWhiYPC5hCmcb9GEqFQ6WuYRGw7IuuTxH4l
 87nC7Fa5TBLJ1dqEAWxNP5g9gviqU6/+uFggBf7TlD7g2qGljFJmij9WCCfuBom0
 u7djsPhYRHz0slZY9tRrpQ89mUJhWJEaFFPOom1+mDfMskbjex/LMg2B7jVL1Fke
 kp3B4A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f65qcjwy8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 16:40:09 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-91ed0e140c5so130906685a.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 09:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783096808; x=1783701608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vl143n2Efcc1cvNmnaWGElQ+fuvmLhHAw55vZ/sV884=;
 b=a/4idZQyyveRkUA/XOuiFAE5EBK3Qo93UmGffMs0X+fcdOHb4786LhS+/hAbyz9LAe
 x4DArP94HA9ZHUvN79NiAoRmRWC7wBB9ZXzzxasJOfnO5xeO07jBFks6xL3Guy+EBUgb
 pw3LYTh4nZ8joMsOjmjlecqBJ0XWwFQdsDcqGOqQXzKW0EAr5ShQZrzCFJ5Y89AnDZaD
 l042Im7yhEp0KLqBiP7p2pzOaFXkSucGuJH7/WxkfvOHi1ebFUaj1ByiPHENEEgv4Geb
 7GQCAQ0TYGn9uXkKlLi7D+8UHxOOr3aTl+2AH0aDFHcn89nulBvVXWXfUQO6IXw7ana2
 Fquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783096808; x=1783701608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Vl143n2Efcc1cvNmnaWGElQ+fuvmLhHAw55vZ/sV884=;
 b=Sp1QMkbSD50NngEH+qqUcxU3+fCAcmHXygu9aVoKXskw8HQH+QgCi+JpIY+n3BU6lY
 JW+xURxeWP0E7VrDnWCnlAcVaaBfid18nNUf645oO1Q43xTOqHzWbfvpIx4oMjOxHAND
 dw7h4BejQXohIyszbV0TChZKPzRBgQsDlFWVsY5QS/mDqnq5Xei6inzCrMKYmctAcDKP
 CCbuu37/lrxSIT2QcXkoOqrq4ddvrfkbuqGOhwnt/3zz1OGyTaZhgKBj6EN51NW15JCl
 dwQxeDeH9G/kqzEFJ5rQ6BZCdwMBICntmOffaqA7MroMen4AiVq6JLdWOAemKvUIXdP7
 IXfQ==
X-Gm-Message-State: AOJu0YxC3AEHgS5SY3lPRnG0k9paVwBTSiP48FJ1RkSOnAhhv9OMK9Mh
 iKJncupDjgJLMkGvr50OGfRP3qutmyevYqEuKYuL8jHtAirKaAfGf6Z/2Pe3m65QJOFWD8JIlNQ
 swa0/SqdpFMC+C3hwJVzi1d9KL+Ax00ofs+xVjM8TY4Eo4Vj3cD+NVKFJw9Bc75ykBA==
X-Gm-Gg: AfdE7cm8zGFl4uukANnHY16E8MhUnoRnWiWcfpdF3yOFieVEuN95V1Vo5coSeUriz6s
 HP17fx3p5QOtWPCGPrJmg7tOWtK5GlEv/1F8sES1Th8kXelVuRCc7e3rayU8VErQnrO1TfFx1mO
 egtU1ScnrZsPwggJx913b59dWRkw/L5SB/2yFHispc+FiBeCzHciaYz7mhMBbq4zL3W+OZEDBTv
 q65zlvQNos4/LIr/rK4ee/nLmZDbdnjzWOa6GolllouQu8FqJqGnZPJd20Qkt98na0PByxIl6wn
 4wlovWWXH0rN0ieFlKC2Hx1TYLt9H7xzIpUZwV54q0Wpz6rXZPHrM0sMRVNxjK644PbS2syG1Xk
 CYIdRD+afTcT9vvYEtbcd2bZqjBbS3P6fNqvCt2ufEKErtHZxneHPtDpi2Az8uL64Al/q
X-Received: by 2002:a05:620a:4403:b0:921:ea36:2ee1 with SMTP id
 af79cd13be357-92e9a3ae60bmr27367785a.21.1783096808196; 
 Fri, 03 Jul 2026 09:40:08 -0700 (PDT)
X-Received: by 2002:a05:620a:4403:b0:921:ea36:2ee1 with SMTP id
 af79cd13be357-92e9a3ae60bmr27360285a.21.1783096807539; 
 Fri, 03 Jul 2026 09:40:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0f21543sm471743f8f.35.2026.07.03.09.40.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jul 2026 09:40:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, alex.bennee@linaro.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 17/33] accel: Remove AccelOpsClass::supports_guest_debug
Date: Fri,  3 Jul 2026 18:37:40 +0200
Message-ID: <20260703163757.55500-18-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703163757.55500-1-philmd@oss.qualcomm.com>
References: <20260703163757.55500-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: rJ2yusz__GtEBGORKzNzWB2jdGw2OXqp
X-Authority-Analysis: v=2.4 cv=Bb7oFLt2 c=1 sm=1 tr=0 ts=6a47e5e9 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=u5zfA1t3EaNT3PtHZxEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: rJ2yusz__GtEBGORKzNzWB2jdGw2OXqp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX8OTyXP2G+ayO
 2FdmTGkpyE0lYScrMv5pDynP0K84/8QYxh57c+EZb2pQSnXfH6cWl+s7Qg96ORivqNHePGCRRsY
 mlm9l21zs57vJzMf1ca6haje+BsRUIkxlbopfpWnzKteuWUoQmlbsski0BUk/QA57asTVlzcwo0
 dXdMANgUADlSPxopNZGVq8ApmYiqAj2+UQIzeqd/pnI6lCBKaMUjmXcrXJkyYqLU7fKkQFefCuo
 p/seuyee63ctmYH7iNsDSfcW40s54blsO+T7rvbQm2CMSEM8qmpO3qpqmKAV2SXVH+OME72TnhJ
 t2wocg1OyefCmnIqaigsu51JauYJCRln6E2D5hUXrj1vh4ySamUu4hKe5aME4EkiQkbNrbqEpN4
 EknG/d7e+L9ZcZ3Ws9ozN3Lf+e1HmI+6gNziJBNHTmxxk+1K1YRFVIUTdjV5onKB64WDIV7QAad
 ABDVSgeiJl8w1OgDwXg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfXyt4Dn5IJWuln
 QfTa25JCVys11SkZ5ja91uoSx0TkB5kd3xjCw80jtWNepBd7VGeH2lQ5UgehE5lmvXUxapu9JQy
 JBrZebZjlQjtiyTvoHEdNTID47DlI5Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030164
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Now accelerators hold the 'guest debug supported' information
in their state, accessible by the common code. No need to call
a per-accelerator handler, simply check for the SSTEP_ENABLE
in AccelGdbConfig::sstep_flags.

Remove all AccelOpsClass::supports_guest_debug implementations,
inline gdb_supports_guest_debug() and remove the now unnecessary
KVMState::have_guest_debug field.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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


