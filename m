Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C082CC43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 21:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgUrn-0007KK-SD; Sun, 05 Jul 2026 17:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUrm-0007DB-1x
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 17:59:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUrj-0000CC-DC
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 17:59:09 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665HhfbS2167952
 for <qemu-devel@nongnu.org>; Sun, 5 Jul 2026 21:58:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6WT95Gph8Xg6aTkiLQdrIw1hlxRErYZ/kEcLb8sMdPQ=; b=Gnu4mutSMOcKz6CD
 HdX6ItsLfG8VZvF/48Yd8B5SKIOlurGkb/vq8sFc+tVYiL+c/aGYTfu+G2fYiTy2
 fLiKMSJfUms5br/GzmYnBllcew2GBYAuy1cuBYh+bjd6rnVFiPoom+3Ma45A5rD7
 1QTn9wBpkSb46mhDFgx03mKmSdSvoXgzSEIA29SjnbPdNyxdcjIv8YxYLobu1QJC
 2S/xvQYrwPkVUk1ma027e+/VsLGB1lEnh+lUSZW/++hm3xqzHMAMnU4OsUmnxmls
 Abyh4I70yjPXLiH2U8DOV79Nq/dxK8PLrtg01j7NHO52DmjTw/B/qmx2GA0jdPJA
 Wqc1VA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6tj8kffp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 21:58:56 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e66f9e2baso228889785a.0
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 14:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783288736; x=1783893536; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6WT95Gph8Xg6aTkiLQdrIw1hlxRErYZ/kEcLb8sMdPQ=;
 b=iMkb8eMD41i8877iq3MO5MnBgv5wll7OdRrpgWPFAwzJTS4hX6QLedKg20w2k/Y/LN
 CL/MPIb1P1V8/LBUF7wM4lPC/qzoUxhCcmZrilMzsrk3JzXrfYa/onkU58JObqA7jUsJ
 o6PUZXEZMGaQVduqf2V0L+oDakwd99L5aIPIVspLNuKV1g2LXdkFHH4O+KG86au93pXL
 77TvsYXvXrevJznWq66YXgKhbo+UHiXo791JsDYvPUxxn9PVMlYUS0zLJa+yHmHzUYUa
 XmDbJ3QVXSKo1wwime1Sob8MhhEtvOivC2fXj7rLcc3vecqf58PzfNOvbBXEOKppAFj4
 oibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783288736; x=1783893536;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6WT95Gph8Xg6aTkiLQdrIw1hlxRErYZ/kEcLb8sMdPQ=;
 b=Pqy88o7ViCiPA8nGbTfWnRIOGI0yUYxcefL09hztRRgR3XU0gBamUy1AHHwZk09NWf
 p5PjZ4QlB8ge2TpY2KhMstopyqCN0HrhmXp1Ji6UWPigr9UxFCD0T8ZKin5F5FeyAJsO
 /yc5eGEKAP3OAQa5qf6gHrSK8HaGE/lE1Y3aeyYBBKVq56LmDnI40PjTX21y3Rby4Agw
 ebTLPOVUuNeAdnRH3bNJ5zdZFA4Xxa2nktF3hCGfqx1BqwTQEaoVJL4Pp6WNoGiyuRS/
 wm1HjAyUM/mnggsdt8nFldmq7VBt/PbSUcKCMPjubXIEOaLDo20FVCY79IemCxqjl7kJ
 KkAw==
X-Gm-Message-State: AOJu0Yz4Mf5tHf0VTlTetL86ovCNFK/1Y56DnPrqu991J3FahjNuYorw
 IddDcTKKUqN8jPITR77IT1Astiz3DPUQYHErGXCV+JfK0Y8i7DwzcNlPr/jzmK38fbIKl0RTst8
 fvCcJoSwe2sI9CslvFK65D8R5LPvE9zEK0bIW2wdZeObiEebiTzkK1Qm38lO45/dTyg==
X-Gm-Gg: AfdE7cltGoyuQEhn0UBCEOeyhxStzm9GGK43Wn4GVrov/ATpqUf9nkN2BNHykX6eJC8
 oUJKIz2kGZcATHbQaTIVuNNg8tX/Y4LaUeQABUCZ8xcfqnX3VpxNM42tzdGuCKnGig1ssjv511o
 Qy9Pm+EtmiDQUHU+t9T+1TfwmUpG7oppQJgro5aBFb+tcnZdwJmHeywvxcfHJU+ragzZsRG6QfV
 tCZcmwuRGUfqIzA49Fc1IqU20u7YR+PuAvwSHWohZarA4+hitEYAqmC64RU23ms05nqY9tgxJPp
 Q7tRSgACzvonEnvo3R5TL7IZQSUPD/IWkqce7cPk9E5O0TYukW0A4h1/9BHph8LN8EseFkWhtSq
 w4JcTxo4NoyHLofeTyEWJdv/sysVyaIOGb3xwgKBPBEq636m7ofWmNIATP0CUqhF9YuS0
X-Received: by 2002:a05:620a:6086:b0:929:b3a4:9bf4 with SMTP id
 af79cd13be357-92e9a3af13emr1129342485a.21.1783288735658; 
 Sun, 05 Jul 2026 14:58:55 -0700 (PDT)
X-Received: by 2002:a05:620a:6086:b0:929:b3a4:9bf4 with SMTP id
 af79cd13be357-92e9a3af13emr1129340585a.21.1783288735215; 
 Sun, 05 Jul 2026 14:58:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039ae4fsm19721756f8f.18.2026.07.05.14.58.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Jul 2026 14:58:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, alex.bennee@linaro.org,
 qemu-s390x@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 11/32] accel/kvm: Hold have_guest_debug in KVMState
Date: Sun,  5 Jul 2026 23:57:07 +0200
Message-ID: <20260705215729.62196-12-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705215729.62196-1-philmd@oss.qualcomm.com>
References: <20260705215729.62196-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIzNyBTYWx0ZWRfX0m9R2gP7KQPt
 uBqqEZs6SJYwaq4jyiZ9l1fGJ5oY0fqFCboUOrwMSjoEcC5uHLOeVLbgs9rL7J2SoXoQirriOPU
 HLx+qxncGpJti7NJh3nBL87p7heaLlYNw6ivgbtl20sc+mCT1EgiSSIVPXXRmBzRpYWrFNWbxQS
 5dBW/YfwvLIxosQ57Qt0dvy71s9eN8thAhXdUnqwcoqF8AgOnePitt/OS+pEs2dOIHYIYYuYl7B
 0aDacvi/xTy5KhPWycMjTgN43ZTLT9JBXv9kkIQf2fBHCspXKZABNsF88ncmeXUnmHsU8BnO/t5
 rOx8nGaXgx377S88kFtNUJ4mSuDRu54RGBbnLRScG9yWMAqc0FSwErr7Z9FXOVzYq9CKv2x4aV9
 gwWaFx59R8s1brgSQzDAFLXyUUiWsM5nxRczWLYnqyDQxPaiubv9uE9ubKT8LoDPvxY+QeSGU3h
 wOHquRw7w0eOiTJqgGA==
X-Proofpoint-ORIG-GUID: zG_dMH2E6oLi881tzsSgNvht_OFHpB6B
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIzNyBTYWx0ZWRfXzJSzlmpyDokT
 ApmaL2VL5trUOzAvg698GkM1+rfaMk5jzn+O9+89APmiZph8ee39OBdLKTb6V7iWE/yvm578A9a
 r82OB40JMS9LtF45Apbxd737ZXf8Q/c=
X-Proofpoint-GUID: zG_dMH2E6oLi881tzsSgNvht_OFHpB6B
X-Authority-Analysis: v=2.4 cv=H6TrBeYi c=1 sm=1 tr=0 ts=6a4ad3a0 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=O5kNlQXW-qQlE3Y8R88A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607050237
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

Prefer to store per-accelerator variables in the per-accelerator
state, rather than as static variables. This is a good practice
to allow concurrent accelerators in the future.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/kvm_int.h | 1 +
 accel/kvm/kvm-all.c      | 9 +++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
index 0876aac938d..53bb0fcf180 100644
--- a/include/system/kvm_int.h
+++ b/include/system/kvm_int.h
@@ -118,6 +118,7 @@ struct KVMState
 #endif
     int max_nested_state_len;
     int kvm_shadow_mem;
+    bool have_guest_debug;
     bool kernel_irqchip_allowed;
     bool kernel_irqchip_required;
     OnOffAuto kernel_irqchip_split;
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 304467704ee..b6125125f82 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -104,7 +104,6 @@ bool kvm_readonly_mem_allowed;
 bool kvm_vm_attributes_allowed;
 bool kvm_msi_use_devid;
 bool kvm_pre_fault_memory_supported;
-static bool kvm_has_guest_debug;
 static int kvm_sstep_flags;
 static bool kvm_immediate_exit;
 static uint64_t kvm_supported_memory_attributes;
@@ -3038,10 +3037,10 @@ static int kvm_init(AccelState *as, MachineState *ms)
         (kvm_check_extension(s, KVM_CAP_VM_ATTRIBUTES) > 0);
 
 #ifdef TARGET_KVM_HAVE_GUEST_DEBUG
-    kvm_has_guest_debug =
+    s->have_guest_debug =
         (kvm_check_extension(s, KVM_CAP_SET_GUEST_DEBUG) > 0);
 
-    if (kvm_has_guest_debug) {
+    if (s->have_guest_debug) {
         kvm_sstep_flags = SSTEP_ENABLE;
 
         int guest_debug_flags =
@@ -3833,8 +3832,10 @@ int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap)
 
 bool kvm_supports_guest_debug(void)
 {
+    KVMState *s = KVM_STATE(as);
+
     /* probed during kvm_init() */
-    return kvm_has_guest_debug;
+    return s->have_guest_debug;
 }
 
 int kvm_insert_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len)
-- 
2.53.0


