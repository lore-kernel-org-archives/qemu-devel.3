Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC9ABC44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:47:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjfg-0008IN-PO; Mon, 06 Jul 2026 09:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjfU-0007Jj-86
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:47:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjfS-0006dY-N3
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:47:28 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666AxAVQ391078
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 13:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mkt8zo5ut3AEpdB800hQyITq4DLwrZk2lzRGpXglHSI=; b=cu7ozZSlzR59qMkM
 /VoUuno170HRf2YQBAgQ04Wb73oOVAZ6PRTi+PbAhjKotPq2Qj10feeFaqcHRVyV
 TFM5Le4eTOKDeSeor4Xv4qwF7XIpsxNj8n88rEzchkWPdAsYgfJ+aN72SVJE4dsc
 oZjYkVue0QV+UHJf63RYh/2zHCsiSvzffSNoODklTtzeY3QpkL+VldJXvIwVi5Zs
 bYNCeTbOH0tSITJ0IWwb6fI0UUdK7+DE+9OYcWN9xJcOR17wAGjB1aUnVc1/iq+4
 oQnJMdbfxv54fUz81k0GluTgPPVv11rs2MgzIUpxmwfOkzOH3qWW7URaRu2wvnDf
 kzh1xg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89kgs1c9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 13:47:25 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8ea75996387so63980646d6.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 06:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783345644; x=1783950444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mkt8zo5ut3AEpdB800hQyITq4DLwrZk2lzRGpXglHSI=;
 b=jHtp6lFmm3q/Tq4ULgB/hQOGHIkosGlFEYm/tpJUk77GwMiOBXZjizl3BS47zWvjSD
 wseNueMZ7OAzvux44lhCnLYWXne5RwYMMw4yH8VehrTrCTOtD5TUO6dGTbYks3BiNy6D
 ZSOO0S/kayUXNaoF/lpKquFYW0HsBskrkD3wWn6QsQiJBETFE/bqfEsgKJw1o3q5AGl5
 W4MIthpjhziLzl7taIIHUV3vlICxdgCBzg8xlFGA7r1NGBSBpZ0AaYgexQmq7xiwRZ8M
 i3utScZ4RlMkLzckobDaydru5PUTKXtn6pJyxJzu472SVJGQAeiuT0l3XtB6XyaJENk2
 J5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783345644; x=1783950444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mkt8zo5ut3AEpdB800hQyITq4DLwrZk2lzRGpXglHSI=;
 b=UvjLD6+lAiSRk1pq2bOfYd88RDaEcyAyJbq49Lt8Lu8gFN0xTXn4Ub5faU6j6dK9W+
 xPXyYRfIAeYhlNeY+g/wanQ7is38R/3Om0CozHRBY3UoccngDU7l4+tY3Jnlam41Ikox
 J9avSXQz402oW45RcBjk5OHPw/MoUF2PxcBFnCMla6eZGNIfKOlM+PDkFYfhfPxUWgli
 n5BVPcXOQYDoB/+23QKmaQ0a3DkrLMM/qt0D329gctM3OcB/9iitLXCnOMDAeBkiJ9iT
 3W2avw3AWzD8RhchU41pNNIwqEvP8DmzL+3V1ozNW43+U3IjJP4ZjEpwGvr9srZOfKqO
 jmnQ==
X-Gm-Message-State: AOJu0YwmU4/tJQ+Nn3YLhOpA+ZordF1yHp8qcr2RjWdG55uAEbFua/Hd
 FTMmRsWwmi8opuhJdMRz5ZnN2x/GaXo8AvRDkc0K2JD8PCoWK04g50QGHJFcaZWyRgOLuI+/cTv
 seRrS/9xMW4H6J5dERBDl5DWv1C+o3HHd3S8Vnfq2SlY2Wz9MMXx0fwE95QWiBdbrgA==
X-Gm-Gg: AfdE7cklp98gfKoSoNQW1IQ/zIfBrpdDYx6nCig8qZ0G7Yt9ikNYRPYoZfElPVW7ujD
 tlaKwJrgvZtgBsvI4JaFcvU4o4Z6b1xdW5AHCBUQCF1XCjMjMlHsYjAFxF9st1xwg3LZ2QJO3Rv
 IKhsjso+MHkuGyvPmGNgmS7ZlPadpIvcwsAoQK1c8CPeu5DIU46U0uy1HGy9UVEAVF5RAEJNX5n
 +WvAzmPPDE9xv3yfIWwcfXVfDMFMEQCVJsuLbywqCWbpQKA73Psw1eOhRpL0idBuu8fHrr7RnB4
 Lx0SdmLz7RlmHLyncAFj8vVDs29jY240Oho4M1tmauPLiFEXbhOJbT1IwcAntWvirF+G6zbqYm8
 STEqawLcQGnQn5gI24zlJBTOUgY+2LbSesiCLb4rnY0HfSh4kZvOo5n4qsg==
X-Received: by 2002:a05:620a:4014:b0:92e:7afc:93ed with SMTP id
 af79cd13be357-92ebb5c7efamr83737485a.71.1783345643923; 
 Mon, 06 Jul 2026 06:47:23 -0700 (PDT)
X-Received: by 2002:a05:620a:4014:b0:92e:7afc:93ed with SMTP id
 af79cd13be357-92ebb5c7efamr83733085a.71.1783345643340; 
 Mon, 06 Jul 2026 06:47:23 -0700 (PDT)
Received: from localhost.localdomain (1.171.88.92.rev.sfr.net. [92.88.171.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493cce03fa1sm275898175e9.11.2026.07.06.06.47.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Jul 2026 06:47:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/32] accel/kvm: Hold have_guest_debug in KVMState
Date: Mon,  6 Jul 2026 15:45:07 +0200
Message-ID: <20260706134527.84808-13-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706134527.84808-1-philmd@oss.qualcomm.com>
References: <20260706134527.84808-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: y9iRh26xwzl_EACl-WtrprmB7SutnuNO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MCBTYWx0ZWRfXx2X4qskXs4GI
 eKo1bGDuRkrabGOzjFrTdNOU7lL9Vt0pmFbZJk1DV9vS7ux4FbmZhckfsZUi5XP9cM/4wOe7YZE
 /KhmFUqB1cL35Xv9x+gCnAso5a735q9yUzxDfdEyBZo+ImoC8q4F1Ng1WhTqxQF+3CHUEl7K1pi
 eQZ/pxJt3FkOHqErbFevgTrlk9GMamf+3JWUFZ/dLoGHFjN804AO+mjOWJ8OjQQNaByMzeoU7Tx
 rRC4mm0Zz0EClUaIS8MLH0yQxbuk9qGKTEHjO+kMO+Z73M6AYp6gIR8QR6YAOwhz7qmRoAw3Pje
 diZu8gDpb7B/sJC1IX0Gp/gCAny83XmovOTRHREB3rfy30Iim0RiYrD3TYsHrtFAhU9L2onbRM9
 0x7/0slihtRyfgrvD8zptnSGjoCIBVpB6eLsBu9DzNg5rPfWhAX/suGbn2rxf36dRBRCSWqQeif
 SF2E3fLm+E2hLqgUgKg==
X-Proofpoint-ORIG-GUID: y9iRh26xwzl_EACl-WtrprmB7SutnuNO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MCBTYWx0ZWRfX+fz2G6oEvttx
 drZIOStelh0JxAcfXRWlm/PTQ0uA9W6OOfMu42YYkTmQEoJ9QYzs9ObyvxFl2vP1GUtmHfnSY1c
 qFDsIp1pbfqNCBzLZ5q5JfwtBeAWdaM=
X-Authority-Analysis: v=2.4 cv=c6Sbhx9l c=1 sm=1 tr=0 ts=6a4bb1ed cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=PLEY+c9/kVlxBKEpvFYBUQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=O5kNlQXW-qQlE3Y8R88A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060140
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

Prefer to store per-accelerator variables in the per-accelerator
state, rather than as static variables. This is a good practice
to allow concurrent accelerators in the future.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260705215729.62196-12-philmd@oss.qualcomm.com>
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


