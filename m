Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D917CD5BB1
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 13:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ37j-0001F6-4n; Thu, 21 May 2026 09:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wQ37i-0001Eo-22
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:07:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wQ37f-0005pb-LK
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:07:37 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64L99oVq3009540
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 13:07:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=vuVY+Sc4Piiu7vkyt9FSN/rOyb6y4l+9Yko
 g1NCtbjs=; b=QeLDpP2EDoOgcmGlU7J02EvSvMbcWcIjGTdMNMsxGdDRWJmQG7w
 hhK/IpQF5hVXOV7xUUR6VrqJkz7IaE1hRsHBY41MrpwOuPK9K1SayvXdhcyGILNo
 +u1GPR4RtnKiExsKUwkviXGeyA5vYW9equBQVr42u6VMrqc+4GMnJnBxBJ+Lw8Ti
 wWCS0h5J9vJDhD2ycGF1/YsO6DAkm3BYVrkzfPAr8J/PuzWEk+KpnUAZHSbvSU0/
 1qXrpweZAVh9XlZSMZeF2XF/LfD1/U8ccoe59Rr/8qTURpxWSLC0SBAAqRccl2Yc
 rZxdcwowoNYaSighbwJgiEyQhRd9cdRljYw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9sr329rj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 13:07:33 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5156c85538cso165316201cf.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 06:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779368853; x=1779973653; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vuVY+Sc4Piiu7vkyt9FSN/rOyb6y4l+9Ykog1NCtbjs=;
 b=UBNhUmB9ZAFXSSjgrQCs6t7cZHphSoSNtH38/B0RgqWl9JPqLotzDRjbj2EnVtXaMw
 WaeV1T86w+dQVwnRWmaWKmcdIIDJWc8K4c96wg9PeNvbi2s9iLSzr0WENy/OYhOhXKh5
 GebpkoFlXQ5wZop8apZeCgeafpqt/UYsk5siS8zOKnu/Cw+DZV4ntoVvjwS+K4ydCV1M
 nfIo5Pqd4BL0vWZsb4zUXYoZRncMMuQK/NhipHaqCfZYxfDGYtg9QMm3FGRxkmg+1xRw
 c1NGvFRum2X5lDatJ/eOz7uPf6rlAvWEzed8jsTxX1QnvPLqP+EV2eOEaQsNT6O4OARg
 j9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779368853; x=1779973653;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vuVY+Sc4Piiu7vkyt9FSN/rOyb6y4l+9Ykog1NCtbjs=;
 b=pPFnlgraMc5PjNt96QObTWt1iCT2tg9fq4mrHYAvk+6+itEkeifD2PCygDq2dpPVlf
 XmcaXv5TxfK+pfrmf70LJGBFh3VmRF7yNUoWNlhsvkGwV+6Hn1oMI0z7xYfuYygZe5Cr
 88VTqPDcjZlRfROV4fBnPCtBBcSAYNhVBnZZ0JnakEmmh4K2fB0aNGPqBhT90ARBD/qN
 ilYxABMGas1IjhAYwqZnMLjevaRRtnk8GQ/LyV1DMm1FDHUezhxMfqNO3IOZwFFeNMi1
 VY7q9xcxjZFPAUk/pI6zw+5cc0lBTO4yxGAKS4BJ7wO3lrGNIKIPMICk+DUChTDSvBE6
 qnRw==
X-Gm-Message-State: AOJu0YyspT/kB5OLsUGbNgcwYBTF8ubYSJizcMUW2oXqk6MYcpT19+PI
 T3HTdBjfwPFhCNVREn0wUcsFEJDXeiMtwe8Mn9eAsMVJ8WjHaoSFdWkh6xBaSMsO7ou0Wqdx3Rj
 ld2WUI7SGdZYacRSBs/b5oaZW8h8hPZLxMTrxQgkT+T7iw+O7xN2L3SfrbsfpQRyC7g==
X-Gm-Gg: Acq92OH6sS9jCgJqXahh8+MFQwXHbRrqq4Fotpxpy0sehnV/q2fDxvft/jXhUgVbIQB
 KKuyCLLzLHnnbAUu5p8gUH/xuuFG3PBKb0VQyq2T0MjJO5nk2l2nKQ9t0KGGckasvOiBh9gjjc3
 VfihyyAr8dr9uDpoBzMGSypL7PkxQI0uhWxBCvt/KPujPIcu+hLvWcatBAVID6BvaW4FAvc6gfG
 zKKwHl9hMJK6xPURCrrKNKmIgGddi9jk2VWFi2ivL63GdYjwnHaNBzE+ZeOS4zoVXJEV8Ek1GJQ
 XK/d/95K72gRt1J6lYxo8F+p5BPBmP3aIAK1R3DWMIZImdRdchnLzL0EHq5TsoAOM5QgN7Ya7xn
 eysz5yJndgOw+9nZQO2dBYXvsL6oIJVBHAWi+vqN0MAqcr+qyD4tXqFuwIU4T
X-Received: by 2002:a05:622a:1b90:b0:50e:6314:1a5e with SMTP id
 d75a77b69052e-516c54bd17emr36801541cf.21.1779368852720; 
 Thu, 21 May 2026 06:07:32 -0700 (PDT)
X-Received: by 2002:a05:622a:1b90:b0:50e:6314:1a5e with SMTP id
 d75a77b69052e-516c54bd17emr36801141cf.21.1779368852252; 
 Thu, 21 May 2026 06:07:32 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.196.135.199])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-516ccbed8fasm6514671cf.11.2026.05.21.06.07.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 06:07:31 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH] target/riscv/cpu_helper.c: fault with reserved PTE.PBMT val
Date: Thu, 21 May 2026 10:07:27 -0300
Message-ID: <20260521130727.2311629-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: CJOlMPIRfDovfVk_5akGUIz02-iQiWMW
X-Proofpoint-ORIG-GUID: CJOlMPIRfDovfVk_5akGUIz02-iQiWMW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEzMSBTYWx0ZWRfX0+JUSXv2a4vs
 mi7AVdUk5WDDAkluSu0O6Wgxz4Zoaz3+EC0G0akDTtd8dQ8TvKNmJVKsUxVRwK/3bkD8QJ+AVB4
 ZWT5uytcFNDEiEHXnDWHndzgPSG4t6bLPQ/0N9M/LjWPhgrR3BI3rey/D2aZDZQ93GBNroqgPE1
 7GdL3bbhoKZTltI0atsJOV4LzTvXKPAbYsFcV1w/Q1EFqkKtydtRaTEXYJXP6VCUnUKr7afsg8R
 jLSNfmDgMfyu2eDCSR1hcPhYC31K6t8rpLRXgRI5gooY56vvYQNKbj9YQZTrCJtvXTvMQv5Pm6V
 f2lvVxynQpFwXL+S/d9NeYXEckbYdxf+/NFDYo8HIDXowebZw/V+wcYyBV+2oPW2xglJesh+zxi
 wT5B3ylAu5ptDbPbYf8tbY3fTgh9MZWyQlGaqUVCMRuJsawqsDa0QLQ3kZaCpJchRuPAUIdFPPB
 7a3KxqsfNK2euQFXO7w==
X-Authority-Analysis: v=2.4 cv=L+YtheT8 c=1 sm=1 tr=0 ts=6a0f0395 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=IOOwV0Eez6LtLsIbZioZZQ==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=4zucAbZRx66qMOFbNLgA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210131
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

We need to fault during any access done while PTE bits 62-61 are both
set, according to the RISC-V priv spec.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3494
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu_helper.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 17305e1bb7..bc63713ddf 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1446,6 +1446,25 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
                 return TRANSLATE_FAIL;
             }
 
+            /*
+             * priv spec, "Svpbmt" chapter:
+             * "For non-leaf PTEs, bits 62-61 are reserved for future
+             * standard use.  Until their use is defined by a standard
+             * extension, they must be cleared by software for forward
+             * compatibility, or else a page-fault exception is raised."
+             *
+             * For leaf PTEs the same bits are also reserved but in that
+             * case the page-fault is mandatory.  Make both cases consistent
+             * by also page faulting here.
+             */
+            if ((pte & PTE_PBMT) == PTE_PBMT) {
+                qemu_log_mask(LOG_GUEST_ERROR, "%s: PBMT bits 62 and 61 are "
+                        "reserved but are set in PTE: "
+                        "addr: 0x%" HWADDR_PRIx " pte: 0x" TARGET_FMT_lx "\n",
+                        __func__, pte_addr, pte);
+                return TRANSLATE_FAIL;
+            }
+
             if (!riscv_cpu_cfg(env)->ext_svnapot && (pte & PTE_N)) {
                 /* Reserved without Svnapot extension */
                 qemu_log_mask(LOG_GUEST_ERROR, "%s: N bit set in PTE, "
@@ -1498,6 +1517,23 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
         return TRANSLATE_FAIL;
     }
 
+    /*
+     * priv spec, "Svpbmt" chapter:
+     * "For leaf PTEs, setting bits 62-61 to the value 3 is reserved
+     * for future standard use. Until this value is defined by a
+     * standard extension, using this reserved value in a leaf PTE
+     * raises a page-fault exception. "
+     *
+     * Raise a fault if 62-61 (i.e. PTE_PBMT) are set.
+     */
+    if ((pte & PTE_PBMT) == PTE_PBMT) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: PBMT bits 62 and 61 are "
+                      "reserved but are set in leaf PTE: "
+                      "addr: 0x%" HWADDR_PRIx " pte: 0x" TARGET_FMT_lx "\n",
+                      __func__, pte_addr, pte);
+        return TRANSLATE_FAIL;
+    }
+
     target_ulong rwx = pte & (PTE_R | PTE_W | PTE_X);
     /* Check for reserved combinations of RWX flags. */
     switch (rwx) {
-- 
2.43.0


