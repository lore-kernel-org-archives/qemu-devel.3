Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A40C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfgvx-0000aV-0V; Fri, 03 Jul 2026 12:40:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgvt-0000LY-H7
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:40:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgvp-0008U9-DG
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:40:04 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GIbFl489322
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 16:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xElOALWefO9RHith08ytAYtAwWPa8il6Q7X6T2pFNzM=; b=i23E22M4ew7Xebcf
 AnxrtzX0/8yj/JlYWarOJ0pbRU5irkLtdmGABpZZ6a0C14vGN6c9QsrBLwk6dMZt
 PbaLNl+Cfyv8fgIN2nE2Hs0NIVQHz9r+Aaqq4RuNT0VTTx/Py0RQTbAXThCzn4PE
 NJedgv8pwl63GXvjkrrSuDo33ogqsF8e0svdaQuQFoWHOffm7/zQMnVkBI1jYK1l
 NKnRSio5QYKTh5xLXUwmY9WPBlabDyngM1rIGzW4vBGA8V1nyS8M9N0zBka6BMcR
 Z2+paQfyyvZgxF6jfwEbxMCcV9vajuJ6FZQr57f35DDhZf0oFqUFgnAnDXeB9Sjp
 j+FzoQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6ckj0ytj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 16:39:46 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e623b0e95so64366885a.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 09:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783096785; x=1783701585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xElOALWefO9RHith08ytAYtAwWPa8il6Q7X6T2pFNzM=;
 b=IZ61aByJ4mHdRkfh4miTHEU4STW08AcnZqc1aj8549mPFIADQfIkoNbB5rbtHcLkXD
 hi8ZsAfSdqYYdFGO3NnYl7lOZ3Z8TmM5JgwfVc1YnjYjq0Cbj4noJCl9h31inunQDXC8
 65JelsNMXkl53TUrD80iud4uzCl3qa1C7juwJLB1ujqGTBalJSdMwTh6W28nAxk+moyn
 eC6uJF4sY98xCR5zrLPiBjVz93kIJ04PaqwgYGTTPT9uHCspjZW66qSsUgjI71jW7dA2
 Od94DQSh8XO23mrk3EBNjzEsLgNeHhfj3Lceu74zUVHVsbizlodG52HigR9qUdS7wQ4T
 b5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783096785; x=1783701585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xElOALWefO9RHith08ytAYtAwWPa8il6Q7X6T2pFNzM=;
 b=Cnu8ufEgGazH/LjJROrI3OKmf6nkUd71ddRtpdrppfoVhJLaX5LF8nbDXORSEhEbCz
 SdOK00eJrbKf0IQzekpNm1LIr/9tHrwmlAB8QXQHB4VQjsz3BZMfbqMeE1/KlPwjLGjZ
 3Uw8sHlD13vJoFLOxz0W8Nez4gNzU6ZWsqt4eRlUwyG93oSkP/wxI08Yr/hjJxuX+4Yk
 6gtKoIYPmXpm5MWjkHEtJr9i89tTdQ0pXa7YmaDuSQpjorAmmijIBo3geVQ5HIF4N/Eu
 18J1XIHr2p6MVAb2O76mOELwo8dzexrxjodKQ86jxWrFIUNj27t1+qTkrST5VKI39wWD
 wRLg==
X-Gm-Message-State: AOJu0Yw2hc7cVTW0ynl4Jal/aqHiI0/syWL8MUpSwIf7y0LgXyf2mWvz
 S+0JMssqoBdeVBnjtd2DN6erh5Y/Fprud1dJWzKToersWUVTh7GRZVUUS+I5EaazZXIJJrmErCw
 27oG3h7HdlTsCEnNpSfM4dtRg52u18y7+BKPEB1LcpYsjZwdRGxRWaRB2AW/uCdPYAw==
X-Gm-Gg: AfdE7clDYC5jz2odf5uXbu9esxOwsMKpiGCbi8k5+vKsSq8KaJ101aa5yIOsTW6s7NG
 Kh3MIK+hiWKjJI2COd1hi+7FCJu8xRhEyBNfYywL6nnujb/bETY7HddpO2Pl9QWRN1aXPTBDQ2q
 /WGIP8oMiXw0t9igjlWODY1XBHZhIlBeBEz08PkgH4LfLBzrnUVZi4hYd/cuyQ1+qYHBzH68xT/
 NizibpA1fDxH6l7ElzM5YBfJd738DyldQ6acgn9MsBnzkNb1QU66cUeU0M/ZRaLe+LKpK5sn4TQ
 yCWCFjP25JK1JJNA/t0oSB/W3aSaGA9WcEA8/0VGvHniI22TCYvdqDZuVdA0mzLH0vuLhguIE/d
 5Kx1AGCCbR4ATay0I/lgYIlUBSxpSnrbU4sE+Z9YyUGu4wC+Okv5h/YQbC6MnXSJHu0ku
X-Received: by 2002:a05:620a:44c3:b0:92e:4a4a:4478 with SMTP id
 af79cd13be357-92e9a3c1e5emr30657585a.31.1783096785317; 
 Fri, 03 Jul 2026 09:39:45 -0700 (PDT)
X-Received: by 2002:a05:620a:44c3:b0:92e:4a4a:4478 with SMTP id
 af79cd13be357-92e9a3c1e5emr30654185a.31.1783096784799; 
 Fri, 03 Jul 2026 09:39:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ccdab3a8sm66538215e9.6.2026.07.03.09.39.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jul 2026 09:39:44 -0700 (PDT)
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
Subject: [PATCH v2 14/33] accel: Have each implementation return their
 AccelGdbConfig
Date: Fri,  3 Jul 2026 18:37:37 +0200
Message-ID: <20260703163757.55500-15-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703163757.55500-1-philmd@oss.qualcomm.com>
References: <20260703163757.55500-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX6yvy7HrwIEma
 iQifVHKeXPc1hYKCFq91GjK2H84TGTnepTYPx2UtjJmSeALSk0eDQdzF1ygUh6S9ySuwawbpWnt
 l1AZtyjUptDbDh9I8BDiAPkzGQX4G/o=
X-Authority-Analysis: v=2.4 cv=E8v9Y6dl c=1 sm=1 tr=0 ts=6a47e5d2 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=ft8xR6t4uCTsT4XH6kQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: tl2VJu2eHIKaZRt9wLJKvw5najgCeDKR
X-Proofpoint-GUID: tl2VJu2eHIKaZRt9wLJKvw5najgCeDKR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX5Kv95s7a4O+A
 ZIqQLUgLOE7pYWgHTlCM1vaaqg5zrBQengpB2EbrLgNqP6h+gNq7HidjdZ2it3p5tn3xKrzhYT9
 9Km5UXGRp/3IPdvrlAXxCMH93/9ODwA3vhnaTKiW+3y1et/rhEO39IJv51lgWNf8oXHa1ei13lf
 QKhVdAgpLAVe0c+QpDZryrZuAOdMvsPni+dE5hiu3gPgYRUFnv3+YZvSmeaMWy7GVD1c8EMqurQ
 Hvf6kIATkWC4fvfzn+PB3FUj4Dt4VP64gttwOtXYJHnrFGC6fnmzYdMNpqJHas8Yrwum3tlC2Pa
 jaoT+2aYfvU4hOkb4fm/jXb5fGO2AT7hdMwErgN/nwOkc3YT8gVvlZobzQv52Vi3ysZ5tk4jUZ7
 ocMFMY1uTX8CHezQBZk75NNHYEzveK6ckE8wZVrTKcxrlM2RBrs6KaNALwBNbldtO4If8u/sNDZ
 QLC+FJC+ANesk234HSA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
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

Hold the per-accelerator AccelGdbConfig in AccelState, set its
single @sstep_flags field in AccelClass::init_machine handlers.

Remove the AccelClass::gdbstub_supported_sstep_flags() getter
and inline the single accel_supported_gdbstub_sstep_flags() call
in gdb_init_gdbserver_state().

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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
index 31eb0ca6a5d..6533d78b1ca 100644
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


