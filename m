Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C368C43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weBYT-0008NB-Dd; Mon, 29 Jun 2026 08:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1weBYK-0008LV-Rv
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:57:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1weBYG-00075m-Qv
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:57:32 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAT46G2646947
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 12:57:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=BCD+lbTTBcHnrhwfJPIkg0NgvOocxGOdwTv
 wqhDzvak=; b=NLeCEGKIu30niTYRuqYkYkOwWiWAYJL8eMqeBtdaszH+9npmUP1
 qYXAE9oj3lXt6/7X/kEkEaUh9yhOa5tdgwdtFmrdBLzuP3YBKeN13fKU9sa7ixT6
 83uRgjkGcm29DlelfUsDzffMdXt5UKH2PmGmuRM05CDgMeuqGIKXGPNS3DNtAHar
 tVHRZ9MDkYV1Gh+M7NT0rSwbIaTvWxjH3eI7BnBY9qnBz0BtAyd3+Ku+EzYP4G/u
 DtbOvQOKZPatgxlrRcbEwC7jpqymwSx/HFohPmmrMkAV+Nnb+Z2IjDElt002PKVz
 +GpZg7gUfHGLJVKHkVY2o3zsaKMFjZ6C6Rg==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3m4tsben-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 12:57:26 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-96925fc24a6so3308439241.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782737846; x=1783342646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BCD+lbTTBcHnrhwfJPIkg0NgvOocxGOdwTvwqhDzvak=;
 b=UVYgHo89ZNVyA/wMmePVAV8m+YE5mvqCKuJhbcsEE11X6guZ/a5TNKg+zzhraPCA2E
 p2+OD+ql8BJHJrV/Oeyvvvx3Kl0p4Du3o2y6LQH1Be2wK1c7Y9V/5i1gWEfwGDtDQZoM
 uTt5ITkRcahNqU8ubBRn0V5/7/jrKsxeyDQ3raKAPTTt5PJGHD7pnVLwqqB9Dc1rStnH
 6cyjQfJPRhcCULYKMRAzUzVe9wDs+pEsS+X2JzX70Dqu8Qsx/wzymQuNlsCiJqecLWpZ
 XTmyfxCJXxbYObUbji5qpEjlZJZEnauYLOdmS4+V5g6yXExdgClXR1Nu9Xa/qiXZTWLQ
 3eAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782737846; x=1783342646;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BCD+lbTTBcHnrhwfJPIkg0NgvOocxGOdwTvwqhDzvak=;
 b=VAXtQHSWKGvRYZecH66LF03n0JOOEIyIoqSgTRdqPFbLKjwJsbgQ1hllSiCFCema6I
 Vhtj3woLHNeJuiugAtjws4YI4hdrhOA0xtprU7jEI5ZyaiEvuQzXgL1ZzoY0scbA8BaE
 BpfoxfNKnl5ZsqwMzQQwRutYe69wGXRq/WvQc9XbEk4bMXyCS90iYnQG/q41vk9zN6zH
 fwlPkhSQwiy31IFH/sMNUzAMWqwJ8ZE+yx/Sj+z5wyXwvieUS9Cuol1XnVCwKiB7NvnA
 3UOeFwlPlsgqdohFMJUGQ2u2Y6cxeY5ITx6aTwoMwV7t6J9s5YKiPYGlrXeeNK9DvYGE
 FBvQ==
X-Gm-Message-State: AOJu0Yzck/BOrMHgmlK0bWenfRIDuuh/kLLuESE8qk0bvtB7t5ml182m
 UMchj7S2Q8WR8klN3zPgTKDCnDWJQZNKgyhuQqzYure0aV0wXHGw8wLwUDEaFvaOdWorWoyIlCP
 gI5s/TNPgneBR/oAFsF5QjMAcEvdsAEkxwwPL3C0dvZx7JDBTvDaWp5qiUUgytYfwcA==
X-Gm-Gg: AfdE7ckvCssddezEXM3qJWqrNtMpwVyUUiLt+sCIrDvSpZlcIgqpfgY0i2oeckLP9ul
 Hu9xduQ2z6oxLhXf+e3PO+XLYWxOeyv0Hr5HTgMwfyRS+Bkcx6DMdv9NzS+lSPdbfr4OmFehpIP
 XD8DzNTxE8beUzOlkW1Q6zA3aQEAePlhkTRMhRsaKr6KvZwxiH+fHyeh1CNFhvMObWJIyRSkaCQ
 PEzZlm2uJGuDn8U7rJ8s+F9XCkEN9ngKorNzwl0m75085WPkebjDzkNqp3qkBeUDEdBKXoo96Xq
 7Xy7dCloEGY/8qrcKTvwuUraJIrXVxBOk90QDttaP4C4MVLU1JxKgfja6fXDiAFq3vUu1/lcUqX
 Hbxoa8yqdZu2TLCuwKpMX0MSeBHm5W6RAkVgeU210u3C4yw==
X-Received: by 2002:a05:6102:6d3:b0:738:6994:eb8 with SMTP id
 ada2fe7eead31-738699411c6mr1833396137.0.1782737845707; 
 Mon, 29 Jun 2026 05:57:25 -0700 (PDT)
X-Received: by 2002:a05:6102:6d3:b0:738:6994:eb8 with SMTP id
 ada2fe7eead31-738699411c6mr1833370137.0.1782737845214; 
 Mon, 29 Jun 2026 05:57:25 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7356657be2dsm5507595137.2.2026.06.29.05.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:57:24 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH] hw/riscv/riscv-iommu.c: check reserved MSI PTE basic bits
Date: Mon, 29 Jun 2026 09:57:19 -0300
Message-ID: <20260629125719.679626-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwNiBTYWx0ZWRfX6A6bZF65gkCm
 JVPPV86ad0GbDQ1BOMCUUsqTa19AqGWi4EkZh3e2Bz1EFwlPtLsF/SWRWXJhfYwCw1YF0SsAnI1
 vYo7s48uxhokCyPMsKZMijKhIMIvP8y4BJK1jFj+O0oASd8aWDB/WsM+omtmBTLjNAUtla/mMFB
 plBH3S6YLpARDOo5JFPYj6H/AO21C9krc/Sp+okFC+T8k7KTMzKVFb/Z8foWaoE+NFqLNgJDhWe
 gcA2s5NHZ+bAeh7F4qTQH6oegjn+5gqlX56ppDtqwXKkl6oF6GNrebk068B2Qsf3rFrFBnT3Hfp
 GSf8itjvPjh0Ogvw0TMhxNmk13xHi5f1x8V5GaYAr6jff9v5ZES9pzQYsaFYtnpgVKT07Dcy9Wz
 SKAP9uyzuPF6xFPU5ut17WteN1VwlqiXAK+c5W1VW5Hv9T+u56JIdo/GRbObNMkDAkAI7gYDOZ5
 y5cheKL+VpzkXPfsb0Q==
X-Authority-Analysis: v=2.4 cv=R58z39RX c=1 sm=1 tr=0 ts=6a426bb6 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=o8AJCCVMZl93uFZnl5wA:9 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwNiBTYWx0ZWRfX+XLJ6FB2Pip5
 hdgWgz24tY2IXuqgmMNQpfgCIvwf5SrrdowEXQoHEYZWawksKKMI19SyrnT2Bpwgg17ToPm7DAX
 OdIa5VAx8z9iT8NrVF3YnXA8Y/xTKL0=
X-Proofpoint-ORIG-GUID: Y74ljtblbL6yXLrZ2rwkfJnPrBlgNyC1
X-Proofpoint-GUID: Y74ljtblbL6yXLrZ2rwkfJnPrBlgNyC1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290106
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

We need to throw an MSI_MISCONFIGURED error when any of the reserved PTE
bits (first doubleword only) are set.

Fixes: Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3563
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/riscv-iommu.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index c9687e01a8..6828349fe3 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -648,6 +648,27 @@ static MemTxResult riscv_iommu_msi_write(RISCVIOMMUState *s,
 
     switch (get_field(pte[0], RISCV_IOMMU_MSI_PTE_M)) {
     case RISCV_IOMMU_MSI_PTE_M_BASIC:
+        /*
+         * riscv-iommu spec MSI PTE basic translate mode:
+         * "When an MSI PTE has fields V = 1, C = 0, and M = 3
+         *  (basic translate mode), the PTE's complete format is:
+         *  First doubleword:  bit 63      C, = 0
+         *                     bits 53:10  PPN
+         *                     bits 2:1    M, = 3
+         *                     bit 0       V, = 1
+         *  All other bits of the first doubleword are reserved
+         *  and must be set to zeros by software.  The second
+         *  doubleword is ignored by an IOMMU so is free for
+         *  software to use."
+         *
+         * In other words, bits 62:54 and 9:3 of pte[0] are reserved.
+         */
+        if (pte[0] & (GENMASK_ULL(62, 54) | GENMASK_ULL(9, 3))) {
+            res = MEMTX_DECODE_ERROR;
+            cause = RISCV_IOMMU_FQ_CAUSE_MSI_MISCONFIGURED;
+            goto err;
+        }
+
         /* MSI Pass-through mode */
         addr = PPN_PHYS(get_field(pte[0], RISCV_IOMMU_MSI_PTE_PPN));
 
-- 
2.43.0


