Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 695B1C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:48:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjgA-00010j-8r; Mon, 06 Jul 2026 09:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjfv-0000ZP-Oe
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:48:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjft-0006kN-KE
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:47:55 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666AxFpk368946
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 13:47:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 J6D4Yodpkn4OP2pzSX/8GBdziIU+/sc6tXgwv7yudBk=; b=kGIkm7Ox1RgNQhUL
 EBOgTuD2jfD32gr6iMTBLea1TndUK3bAGqr+6aVlf0SO4+k/Q9jsnnnA+w9BCaY2
 bMXi+l9SHI2e8yMjUB9uSAYVq+zr0VvogZt+Qxq5KtoZ7Qtu56/t6s16HCBkW4as
 nEeEwbpGMpuulDUHkfRewkI9xBEuOlhTt8AoB8Zi53Hoz1DvH/ANK1L2aYE6ojMs
 B9ABp9qUhhk7z7SBmiFqyJuo2T+q9kueFHMTdQmtaxsumgqpHsfQYdL7dLYzLN/D
 4xE5wNhEywQ1JZzV5uUXc+Uv0pVfGBpTDhRsAFy34eh7yOV2NbP2yhvOz4AMRSvS
 hkAjTA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h99c6d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 13:47:52 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e55721a8cso312445985a.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 06:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783345672; x=1783950472; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=J6D4Yodpkn4OP2pzSX/8GBdziIU+/sc6tXgwv7yudBk=;
 b=H9v5aQhPOia6Td3dxvX1zLXd0KYxQElb4TF+jBvgGBoQhDhTHpyhhWunJRxpatqbc7
 Tvcl6mHLiTxWxuuiZZ2qrnWvM8MS115RGnXafiL31k2umkQXX7T/L/x1aTyzKB9wue0e
 xy4UCV9ir+zS5/saZfzr+N8bseGE2EWquo6tUz79lliAzKLD/tXGOCRtRIpY2nyAGbUY
 1yHJjru86MZmlK0jWsBnkjP6+LT6McbFEUbKHKPvPm/bfTvJ2It+T/taPe2Ze6yMRIyk
 xCHjhaQUSBKYXJfLfmRqsIO6Rt4j3FrxqbNYTr7qMNeZr+8XH6Nn6b0PfahV2dwSv8j2
 ep6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783345672; x=1783950472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=J6D4Yodpkn4OP2pzSX/8GBdziIU+/sc6tXgwv7yudBk=;
 b=D5ex2U6D59QIN/ykS/iO+WXheCO5udUbcF80ydXtR+jZxPut8wm+bry/Vq90X1lqs1
 EGfQMCotmz0HBNWx4sMeH11TV33XV6dHm4S3IbvcoAwfHuN5nUrM0cU2Vka6vhGkZ1FC
 +M4VTUhk7htjFXPf4Cx/MeX4DW0ivcq2vnnhqTpBmjcTuzj6/HJPETSNepg2wn376VO1
 rGdHP4AyV9mUq96xZTA7t17gZFJ+qddz6iwn9wBBKfTE0jxTcDG5nX+WhZXHyqc5NWE1
 ovz1bLCclfvQ8f6w+hpF1+4Q9pK5/jms0DJyWL0O3s2QdvBbFY6TJnnFybdIq8CawYXY
 AIMg==
X-Gm-Message-State: AOJu0YwKPmxIutTikd7QKcC1AkfJkwg63v/racDdOaMroDiJM1zlW5pL
 DaW8vxVw8Mhskg0GRctU0oTFL5Dy4MbR31PiN7Z1AAPn2Plg9ZfqA3O47D1w0u1RIgbMgjd/m49
 G00UUkkaFbzmoX5qyuQ7WEuafnzGjLEHg9bBOpcSLpX2mq2Ie9ENC0WECKj5GA587vA==
X-Gm-Gg: AfdE7cnm9X/5uXt1kEU7i1KFqVDAsr8ij1SwCQyTSssO88fYQCgDgM/3tGexf4Xk6Ya
 UNSgzNbKcwEG2tZDpTPevFsNjFk+IbjSQ8s0Zo+9fmLCHl+3K/VMfUi1D93rET8SllHiXSnGDtd
 9RVytfY+Oiz4MUO/7yKdeY0hThKn6OfmWLppDjpusswU4vTCIiMUmh1P6IFDVEz+f1nqQl7i6aO
 8ZXu5AJiyfv9Tjrd+9YcV757dg0eO9SkYusQrZmuzUBBA6+96JJS/WVEM7sgDZkt5VUqxtpvs21
 Trnr4opeQiuD1rnwGavGseBV82fz5QhTD9ptvR128j3WVziICezPkk5cYEv/Pkij0lZpY614ihD
 0FCLxfdGRHrYj1ZgCKbx4tWLxdgehr8f/ADM7bKuC3doSmKzJlgJLkFJTHA==
X-Received: by 2002:a05:620a:4408:b0:92a:e2a7:d55b with SMTP id
 af79cd13be357-92ebb56675amr89447185a.47.1783345671081; 
 Mon, 06 Jul 2026 06:47:51 -0700 (PDT)
X-Received: by 2002:a05:620a:4408:b0:92a:e2a7:d55b with SMTP id
 af79cd13be357-92ebb56675amr89441185a.47.1783345670267; 
 Mon, 06 Jul 2026 06:47:50 -0700 (PDT)
Received: from localhost.localdomain (1.171.88.92.rev.sfr.net. [92.88.171.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039bcdasm25674453f8f.21.2026.07.06.06.47.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Jul 2026 06:47:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/32] accel: Have each implementation return their
 AccelGdbConfig
Date: Mon,  6 Jul 2026 15:45:10 +0200
Message-ID: <20260706134527.84808-16-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706134527.84808-1-philmd@oss.qualcomm.com>
References: <20260706134527.84808-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: cICZiUuQ94vv-Wof-6mpDNyB52aHkP6N
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MCBTYWx0ZWRfX2A7wHm7+qK6X
 MGfUQiTx4BxJ5rCz2PLYJlBX30T1/jK7pi4qbQ2UmGZzpvaxNzqZubF3i8RX7Z+4hn44IxKC+D1
 PxGiB0XpQE4rpuT28iGgrvyvUtzihHk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MCBTYWx0ZWRfX3HNT2cEkBPdy
 K3mTN1tJD73HkJDUAn1H+vpASLg04BVfOiotUXoGP+cS9a3sAXIZL0agP2CcN1DjK8pMa+BGpB1
 l5jh278DNjO34x4bkI/5O1vPdTpV1heTipI1wj+nWvQvb5uNvQYfKC4wa5UmkwHxxha7h8BjBtK
 q9/NTeTDw2CsEVjW/dZLo4NUwgD+0vkOMKPcbE2exyb4PIiyPlJQ+2UTVY+8HhuPuRgBip9fZTd
 fWBH7UHg5yh1kAuhBEbSjgaB362noXtpSN0H0GzGsUdDuqptz4vuWbaL3ClQRXZKoZKlDcYPwQe
 5yPxcc+NWvFZIAygZcPYkWN4w0kjkAHLOZbRYqLTaFM3ArlTGB/msAwXAXzIgRZID7resBelPbe
 WLDbOY/sOeU0pndOfD1JDhsBflf4ZFAkRRG9IlBTdLRwYHpIQ1QDEPc5aoudGq1VrQwG5mBThSV
 2vrh2WXM7+WX4rPYGNQ==
X-Proofpoint-GUID: cICZiUuQ94vv-Wof-6mpDNyB52aHkP6N
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a4bb208 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PLEY+c9/kVlxBKEpvFYBUQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=GIYXWNLsZHjPOkf-ILAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060140
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Hold the per-accelerator AccelGdbConfig in AccelState, set its
single @sstep_flags field in AccelClass::init_machine handlers.

Remove the AccelClass::gdbstub_supported_sstep_flags() getter
and inline the single accel_supported_gdbstub_sstep_flags() call
in gdb_init_gdbserver_state().

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260705215729.62196-15-philmd@oss.qualcomm.com>
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


