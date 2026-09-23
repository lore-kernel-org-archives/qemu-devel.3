Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D66C9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:15:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9QYb-00082q-7e; Wed, 23 Sep 2026 13:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9QXI-0006Bg-FJ
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:13:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9QXE-0001JI-T0
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:13:36 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NGTsZu2470361
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 17:13:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 htbXqjnNdfHoIX28CTRI9s/yb9X3TP6JwahLbnmhFgs=; b=m4Z67HR3Ft6L5z1e
 oN82u5QzLkuZrRWsNWYZfkP4Yilrpx4t0DbAaghWBCTbN8ap37UPw8bwma0Kv7f8
 7UpAhM3HbvwVmV3Kru7+s0QShTfhosKVYCGfBeUFrXXNEq9f7R+tsvf1ey93fJOH
 PDZe0MZIl6gas7/whFPHexynrp1ELJMUwRUPkpL7UGVoTerd5MDuJLOoQtbANN37
 uzFDXdTdaEMEZsvZ9QQ8QVOqJwcOC9s0wpTy9avoFBlNu5BR0e+2d2Kc/BmZtPkl
 /m4l1Wy+JI31X3TS1bnJyti71PPnNfogjdEB+pWYCQJkVg17W9l+Ws16NB0uEa3Q
 i23jGQ==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfjv12wu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 17:13:21 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-97caca2faacso180664241.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 10:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790183600; x=1790788400; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=htbXqjnNdfHoIX28CTRI9s/yb9X3TP6JwahLbnmhFgs=;
 b=MJblQU9QBAr6WXNGJTTkOFUyfbmbInNBIJxh/qAowQPOxW4VrC0KYrY0W+tRBuzm93
 F3MUviLMPH1vH77a9VHe4YxDooGwadITOsT8ARiFPmMRwi0vcsyda9GgDb3gyc1Hl+WD
 3xatLC8STqdRaIutARIw3T5z4GbYVH6VPkGiowuBwt53Krs5/5kXy17muZXNnn7euQp0
 tBnGbjGSeC5pg9id0zfeDaGa8cyikbpBoV655G4dRh+tDh5Uh0EDQKDpnSeWkQJYdneP
 Jk8fnI7mYRUP36uuTg3wgLx8HvgVmsiH+c6NXoBqguUmLy2sKNJ/D3V8xBihOADA6OKi
 rBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790183600; x=1790788400;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=htbXqjnNdfHoIX28CTRI9s/yb9X3TP6JwahLbnmhFgs=;
 b=Eip4/CIFCLdPPtLIefQ0GRTKxL+TeFDpvu9YcTvaZXMN2bXRWdeYsq/yMfPe1MLGAN
 tYTHRvP8U+cGeSwctgfFCLrZFRiTFJPWG5KoLOn44N7maAth7ZFyB/39oXl27uenApj6
 Gc0pPpZSdM+GKip1CK4wAnFsqxAlJ70kAWUCqxf9mfwEVtM9FheuX9gVTlvRYoFMAZyY
 ezIx2M64ihX+TPZn0ITJTxf7/+lVR2MrBSX9CjSHSl5RlYVJY1yKorCTebZYRTxSGygp
 n73Ywm9zaCesYXKgmxo9qZUfhdMrPQFmaL1caqqcr97Uv6ZpsL/++id8ZA81eUjNrSeG
 Ec0w==
X-Gm-Message-State: AFuF++nB9qOXPY6CfCF34UIdrEFC8NSlhNB1D96opkBxmMyTUTJCgzCV
 GSoK31dsnRrNjrmw1u0TIkJERRL0GGzTNbFIYm/eGxzQegt7Gzo7EM1eZR1Yy2tzDYI3LWcZ/PA
 rWn3Zi1rgRiyvFUAZsmOdOUahDBzSNEESYJi/uHpno+Ll65y0KcajqYomNS18Y2M8EJsJ
X-Gm-Gg: AYBFou0dPgUEsaPvVU8N8DvxocDcr58lcNHHjYuHM91v28cj21uMs7yoBbw6w+Vr4lA
 42/Ofl7qQob+Ddg/sjl+KiZ3i8e6PH8sASBT8y1z9yVCTakBw9Pl5L0jZU4Dj0BLBns2a71Plxi
 0ypMhBYusRlIWhCrwFkwfoFD/QC7G1tTnkqJ87/tNm/T45DYnXry5PrwtjbB4+9si85ONYXe5fn
 AMjFlNjVJ47JDMM8Yy/Uvr7SnRJXec5ByOkUgLKehjXY9S2ciB8zCAxK4SWV/X0JAVyMfHtiPi9
 UQahyVwnFuaCguN2t3dbgEWNg0RPO/2NrmNa5HLKA/pwwWM0XIkyFOwwO33dgqMR5+jmaXV8G84
 SVOCMK4hsBu3yLuQERjU7TACsklR0oOOUX1KyGJ2w
X-Received: by 2002:a05:6102:370c:b0:7a3:833c:49a4 with SMTP id
 ada2fe7eead31-7ac1d4f01edmr2824605137.26.1790183600343; 
 Wed, 23 Sep 2026 10:13:20 -0700 (PDT)
X-Received: by 2002:a05:6102:370c:b0:7a3:833c:49a4 with SMTP id
 ada2fe7eead31-7ac1d4f01edmr2824577137.26.1790183599884; 
 Wed, 23 Sep 2026 10:13:19 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe0c50da7sm47282255e9.3.2026.09.23.10.13.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 23 Sep 2026 10:13:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 16/21] target/arm: Convert cpu_exec_halt() to leaving_halt()
Date: Wed, 23 Sep 2026 19:11:10 +0200
Message-ID: <20260923171116.31276-17-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923171116.31276-1-philmd@oss.qualcomm.com>
References: <20260923171116.31276-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA2OCBTYWx0ZWRfX1WyXC4YSZ9a9
 tBlLOvB9BO7K40RZkD/rA+Fw5q14/zz4LXlgbnXKOyUBew+fWyxd7135DfMymRP+1MhPlBZFq9w
 ihncPeg18i3u/Ar2oOlG+QSnOoqGICi/J1KqTEU/x8xqCZsDtgQv5F6w3KO6cVXaRxbUOQDpE3c
 WeDVfsGq29LAIYEOXoYkI1NjJSfd6Wd6wmnP54YP8w6J0eIjFoWJmq5I1h0e7spfFptHTgcBOay
 0Bg5HKEamf6uBIpCmp4K8ByKZYxvRxtaxmz6JQVhbZq+I7Ox1EH0Qj1zGtFIFf2FRoStam06PVE
 aGwRlyX15y2MBdMCvH+nwculvwHzN8CF8VLM62RX1mcKRX7XipUtQ2jSS3i9RErAeEgiw0ij0NH
 q3XbBo4IwpymdtaSM+29d6bRaj2zZjQaRcWsmuJPGrBPVYMZKwqpWX+d09PEEzWq3E0fiZNiwQt
 nPRkhOPwPB0KROo6vjw==
X-Authority-Analysis: v=2.4 cv=aIxlOr9m c=1 sm=1 tr=0 ts=6ab408b1 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=AtaPWBxvZOLBLR1XvpsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Lzk6CYaiqGhCrK4C6VG657xsO9nVLJGu
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA2OCBTYWx0ZWRfXxRIFXW62eZIl
 87ajgZ8pgJxHL1IR85vLyDfgZy1H13ycuH5DkYL1ds7sBaUdDY4MGMAFUpInrjg8SkxFrIao2W+
 eIQiyW3Z9bYhPnDx6gxRwkOPXGQr4gg=
X-Proofpoint-ORIG-GUID: Lzk6CYaiqGhCrK4C6VG657xsO9nVLJGu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230068
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

arm_cpu_exec_halt() now merely checks cpu_has_work() and
conditionally call arm_cpu_leaving_halt(), which is now
the generic flow in cpu_has_work_after_processing_async_events().

Register the leaving_halt handler to use the generic
target-agnostic flow and remove the arm_cpu_exec_halt() wrapper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h   |  3 ---
 target/arm/cpu.c         | 12 +-----------
 target/arm/tcg/cpu-v7m.c |  1 -
 3 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 1efda543270..cfe932d0e5d 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -431,9 +431,6 @@ void arm_restore_state_to_opc(CPUState *cs,
 #ifdef CONFIG_TCG
 TCGTBCPUState arm_get_tb_cpu_state(CPUState *cs);
 void arm_cpu_synchronize_from_tb(CPUState *cs, const TranslationBlock *tb);
-
-/* Our implementation of TCGCPUOps::cpu_exec_halt */
-bool arm_cpu_exec_halt(CPUState *cs);
 int arm_cpu_mmu_index(CPUState *cs, bool ifetch);
 #endif /* CONFIG_TCG */
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 0885a8eb03e..81f1f8b5052 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -883,16 +883,6 @@ static void arm_cpu_leaving_halt(CPUState *cs)
     /* clear the halt reason */
     qatomic_set(&cpu->env.halt_reason, NOT_HALTED);
 }
-
-bool arm_cpu_exec_halt(CPUState *cs)
-{
-    bool leave_halt = cpu_has_work(cs);
-
-    if (leave_halt) {
-        arm_cpu_leaving_halt(cs);
-    }
-    return leave_halt;
-}
 #endif
 
 /*
@@ -2617,7 +2607,7 @@ static const TCGCPUOps arm_tcg_ops = {
     .tlb_fill_align = arm_cpu_tlb_fill_align,
     .pointer_wrap = aprofile_pointer_wrap,
     .cpu_exec_interrupt = arm_cpu_exec_interrupt,
-    .cpu_exec_halt = arm_cpu_exec_halt,
+    .leaving_halt = arm_cpu_leaving_halt,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = arm_cpu_do_interrupt,
     .do_transaction_failed = arm_cpu_do_transaction_failed,
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index 48b31d5eac8..1093c6cbf63 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -302,7 +302,6 @@ static const TCGCPUOps arm_v7m_tcg_ops = {
     .tlb_fill_align = arm_cpu_tlb_fill_align,
     .pointer_wrap = cpu_pointer_wrap_uint32,
     .cpu_exec_interrupt = arm_v7m_cpu_exec_interrupt,
-    .cpu_exec_halt = arm_cpu_exec_halt,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = arm_v7m_cpu_do_interrupt,
     .do_transaction_failed = arm_cpu_do_transaction_failed,
-- 
2.53.0


