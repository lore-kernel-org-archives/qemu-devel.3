Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A51DC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 16:55:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x93js-0006U7-De; Tue, 22 Sep 2026 12:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x93iE-0004gB-Ov
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 12:51:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x93iC-0002aL-Ng
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 12:51:22 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MEjVev1058317
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 16:51:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Kn2lfIEpf8rwL5b2StWxveggcsoepXeRi8I92ntqRYw=; b=ntQO7OpN5obckipM
 SwrW3NUbCKG3DtEsJvI8P5y/TNew6szA7yXeCEGWnfqdwyYQVepBRpc3SG1N3V0D
 7juoMfaSqOXMJCENGvqM1sl7eW3DO66Xb1trldVFCHQ90gkBZWA2JudEZ5X3o/bE
 YUNiraDnVCA/xGrLErUvUuuPH8ebvBO8WVr6bUX8vnmIC/6et+T66NxRHJmDDtgd
 Cy8tzoWpaRdc5dac9cdN/nK5eq4l0wpCv0VExGTjrhVmjoWhahC+DWxFN7VZ8AD9
 esAfCYyy40RIdfqT+Ixel8TYOlvnvZs7Y6XErD6TH39mZ7KUHiaNBRbuD1Jvr7oW
 i+rP6Q==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guha5ugy4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 16:51:09 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-78faf713ab2so7728137.0
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 09:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790095869; x=1790700669; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Kn2lfIEpf8rwL5b2StWxveggcsoepXeRi8I92ntqRYw=;
 b=O7WuKDT8/yUes3+AtYKZhIrvf5J3DG/+W0AMM4kGvaO84ZIvx5WbL7yCjeM/nPbVg5
 pY0s15UACsxnKbBlmEIWpSZ4JDQn6pfjUQ8mC7JjmjJMUQvS+NV2+aHEQI816jKcZ3gm
 ZFddv29ZnmVv9JCDX7OUDecCJniZshBu6pU9BhPifdA8YgAZXUrod4YA+tfk6dWjIgSs
 YpFdqgMsg2o42eZAj5XtUnSKu3y5VOVvnOSyVTIS52d3NRA3hQF4mkTeP4f3XWQdzNyl
 +3Na2XiYtHzYNocEsJUNmlUn3uFNLuMcYBixcxJVtwh1kGWq0rAPFlRvQXY1He/hQ0wo
 doVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790095869; x=1790700669;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Kn2lfIEpf8rwL5b2StWxveggcsoepXeRi8I92ntqRYw=;
 b=FVKAp+jkudleAUjFlIS6rH/F7Tc2HDRdbL5O+uZet9oeGEsPeJIZVihrpDEWMBPAdg
 qD+jS2y6ecNjvAOD5uPC0CNyS5DGDST6WZy0n23q03IA8/LrhYuwGQuGERspelH0+cVH
 9lVMlEtM17rUp1jHx+krUH/jkiIfWEcNBuHPjPFVZM0RMxz4LFk6ipLwOy4z2yrZITsz
 gFHkD9st9RuG07v5HnlW5BHS8tPg6Rr8OFu/M6o7CPbTHY2qsjP1646Yjg01Fr/M6Eqk
 /5D3T3m419PCJFfqeKgE/I0NmvCLHG1z/0fe8ywQda4Rni+XSRQ/RNxeWyuYpeJSTaES
 mdyw==
X-Gm-Message-State: AFuF++mRx+U6/44he4TW+QnyJfH4dflIv8PKPlzBMqTMUdT0ZPK5FRgM
 dOAejez+/RQ1TSZpnKqETJ8rm2TnU1bSqtgQmfXzxdCeDDjU7K+uKfCH1ibM09IEVm0Z7WgbLWB
 PKNQfaWq9AWe4AlW/hXkioWoRzfaYjqlihx4Y90a1Z+xS4NaR1bE7pCQ3Me8k6MZRSQ==
X-Gm-Gg: AYBFou2j55FZiGKRWUVFRh9Ltnm5vSzgy9bwh/Q5uGaWeGz+El5h9tZeg5ki9cVrLTV
 9ikHcfMzQkgLKOecO0XY8SXP8DbLyA13s/Z1sxpmkCSz+fXzSY+D3CHv286DWaHm7x7t43vA2CV
 MCsW0xZjKUt5jabXY3PbGOy2kAS7vdndIVGpsR+iRWQs95YZi0+gTnxuvAxneD6OFvm7oQEMY0d
 MIucoRxmzCNTmvBUBZwiVXU+7jHCungJeKLnF5HwzZGhUIV6GNINNOOr1Kny64Gb/U8MdtJrcj8
 XELqq57oi/8uJtVpmNHbUn7LYw1U8Elpq0O4fr5QViijoxF+bmLek4G5AFDkB5Gr8JPXt1hIRHW
 eKvKFuaLLAzrRJdyfzWrmpqoN9FMrEeuy7BcXTClj
X-Received: by 2002:a05:6102:8482:20b0:7a7:a382:6bd7 with SMTP id
 ada2fe7eead31-7a7a3828422mr5081722137.27.1790095868720; 
 Tue, 22 Sep 2026 09:51:08 -0700 (PDT)
X-Received: by 2002:a05:6102:8482:20b0:7a7:a382:6bd7 with SMTP id
 ada2fe7eead31-7a7a3828422mr5081642137.27.1790095867901; 
 Tue, 22 Sep 2026 09:51:07 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fde1c159esm3813515e9.4.2026.09.22.09.51.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Sep 2026 09:51:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-arm@nongnu.org
Subject: [PATCH v2 12/17] target/arm: Split leaving-halt handling from
 arm_cpu_exec_halt()
Date: Tue, 22 Sep 2026 18:49:30 +0200
Message-ID: <20260922164936.15189-13-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922164936.15189-1-philmd@oss.qualcomm.com>
References: <20260922164936.15189-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: uXWJh2KPjNBnqN3IfCIpzIdl_OIBN7hU
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI0NiBTYWx0ZWRfX2hcM6BjCIT+4
 qYwHYDjGdEGpGBTbmI72JldTDLQzlraTBoQrM7xpqj/fpx0Fpipha0hKCssxurQx+szUk2tou2t
 XfGhvsi40qEsCdp077gseHmUqo/zxqU=
X-Authority-Analysis: v=2.4 cv=U+4Hnuru c=1 sm=1 tr=0 ts=6ab2b1fd cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=snbnvTbt-5-dSQZ-83gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: uXWJh2KPjNBnqN3IfCIpzIdl_OIBN7hU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI0NiBTYWx0ZWRfX35X4T3rQD3CX
 gW/q3TBK9dGCOgb4yZI0wHjKM2WcBTUkNTFVvy1bBW8sVG4xXVFnxSfkPd+hEDn+LraljqNTq4W
 isL03pkbCdYrWwCJumBaOHhUEcbzs8CuKKHK8y9lFGNJQO9qmlaT4D/UszuMBXxKaWHcWx1Pac8
 E5Wgd/Mrz93ie68vVFtC9bV+eNBfLUYpNTliwPFpv0eP8+WjXnmXJd72351R4yXFk9Exl3sAQj9
 fF84qgb9eCEHpdOoMWMuXam370RCymVpAwXCvRV39zifj7/T1ibm/a0TagtAM+XIWWC+p3pjP8J
 tkmrabClD646q2ugA9pHDEH/ElTOypAKTGTwDuFdFHvNg8SixQukf4ZJ3R8nVsiATXwDEH8iCxM
 z89/FP8l/t8KIuzmVy2YbInJFPU+lqv93XkQPqVwSOXxsPwogZJGCrruhZ8MtlEBVjv+zpB2PFW
 xPzowZVK2bKRpMRpQMg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220246
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

Move WFxT timer cleanup and halt-reason reset into
arm_cpu_leaving_halt(). Keep arm_cpu_exec_halt()
focused on deciding whether the CPU can leave the
halted state.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index ccc6630026c..4863e7cd450 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -872,18 +872,24 @@ static bool arm_cpu_internal_is_big_endian(CPUState *cs)
 }
 
 #ifdef CONFIG_TCG
+static void arm_cpu_leaving_halt(CPUState *cs)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+
+    /* We're about to come out of WFI/WFE: disable the WFxT timer */
+    if (cpu->wfxt_timer) {
+        timer_del(cpu->wfxt_timer);
+    }
+    /* clear the halt reason */
+    cpu->env.halt_reason = NOT_HALTED;
+}
+
 bool arm_cpu_exec_halt(CPUState *cs)
 {
     bool leave_halt = cpu_has_work(cs);
 
     if (leave_halt) {
-        /* We're about to come out of WFI/WFE: disable the WFxT timer */
-        ARMCPU *cpu = ARM_CPU(cs);
-        if (cpu->wfxt_timer) {
-            timer_del(cpu->wfxt_timer);
-        }
-        /* clear the halt reason */
-        cpu->env.halt_reason = NOT_HALTED;
+        arm_cpu_leaving_halt(cs);
     }
     return leave_halt;
 }
-- 
2.53.0


