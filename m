Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EFD9C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 22:06:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdEgF-0007yx-9t; Fri, 26 Jun 2026 18:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wdEgA-0007yS-Lb
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 18:05:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wdEg7-0000gT-RI
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 18:05:41 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QJ8on02175662
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 22:05:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=aTqf8xcD/MoiE9hRqV47R3ykzFz8ag/WQc4
 bCET9NjI=; b=ZFwRLweH/DA/OHZrV9Zv6S7Fhl5CNpgTr/0MfALSinmJLRwk27H
 qSdnPd7cX6aMeLjkG0ZSNVbRLBxeIxH+gSMKGJgBBgUVxEeuPrPwo/CY4zXLEcZw
 t9BiPp73Fqm1Sf7rhYDkRQrG/SoolY9Wx7xlXGWskVfUNNCGlkjRBDXzp3sv6IM9
 l5e//lDMJeD97RIwWFlZpj4VimJlf9UlBGPIXhMXSBTZWEqwboWDXf7CByLoXzbG
 DYTE9JfaDwprWWkzpaEjbsTdkq2KMBF7O9iOYShguMpDr29ZN4BxgE0tp8qC89cz
 +v43i1J7g/4Rp/Nucw0tVNDQ7envfK+ZQ+Q==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1nggjvds-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 22:05:36 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8dae6572676so18749126d6.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 15:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782511535; x=1783116335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aTqf8xcD/MoiE9hRqV47R3ykzFz8ag/WQc4bCET9NjI=;
 b=cad7gET5KKOF7+FioEXspERU6B63QPrt0svUhNKrX+EhDb9YLJP0MfUtrcox77G31F
 tYlsSKLwEQhTA8IWc7oV0D+vEE0oYZsnJFnGE7sgTGePtcy2UCCAsm2llbkMNeNNGV8c
 AKnZLGG7SjOi4s5q9Wr6XFx8zCowAdRX3iCSICb1uFfjA4NFGRp8fDDUt20M4wNpRhF0
 ozAQsEMGjUlpTETnM2wsrCeOX2X/LTZG3KYi/AEZsVIeamxl7z4novbsxikQqO1DZSFw
 ja7cTffmj0snE4i3C1+ujZFo4/MDNNuQa2KI9NC5WZjQs5+pa0g7WX2br29i7+2/OxKx
 HGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782511535; x=1783116335;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aTqf8xcD/MoiE9hRqV47R3ykzFz8ag/WQc4bCET9NjI=;
 b=hWbqQv2Mh0mZxmQYtZTRcDakjGDknCyi2M243pIkftnQhokdN3c7dP8yrGbW+vfvNj
 FRBcjQUw+lsi6yZc1THQhPHkdDEO9T1qFRrdYGHkOHtJ4aBM/KTD0jwfJGYrIW7mWbAf
 BpTIq5z/PhxrwA1SfjjCBwrB0SUVzlXgWJaTFxyUZn5cn1RL0ciL79jJSLp57uZmi1kN
 piREey24jIjyQHWCe2+P9dLPt7GjFHw0hBRb6sxs/8EBzhUK91g+2ugS6JugFrgvRLGs
 YZc/f3uVwnmqSw4rPt5cUTVTblJpZ/B3AMGhXOQyL+AFEr/RMMsLX2Z4F7maG4DfcN3A
 JXog==
X-Gm-Message-State: AOJu0YzmpCJ+Es83V4jpc/YeX5jkJJowgC2AmYcW87aZYbXpgMVXQD5b
 HkzUAeunCZRV8kiWXU+qWlVH8VcXGkVdu98DuVv7hOq2/W1OPC/1LuWt5wGZaK10Yig6jMdedof
 wH89HC9zbkjtFzV4lItIRouNagALaix790x/qbHmiwfpU7wbHGkWhwp5O9B7Ur3u6yA==
X-Gm-Gg: AfdE7ck7Ys7zY1eVj4x1y/saXR4Z9uXES8PM12GJG84qbr/m9CmPoyKURlZj+OJIFr/
 TGZ33lnPhaI+Xu+SbETQBg1CsiU9tuXXQ3k5ICSibuHqGJP7QaWgm0LP7g1v0ScvsIBtEZOvv11
 a95ZxgLTBPnFThaB/NYJKpcWAE0bDe5M5/K82kquWubDTdt0NKud16W2ROQ5f9sT8/ozgiFm8vI
 /bR/M/Z8LdigKO72Lc3Fr7pMAfP0KukodzFebaIbUh+MVd+VSeSSFOVa7auC9JziQ4bfiivY/By
 2bWRxumDaGUpkuvagd1cEYYk6KTv1vr7bSlhdk5jsH1HMRiaqoo1pzUE1mWocClmUoUgmgmrXPu
 NmSEm+IeIIAvyfwuuSUiELjbIhlds94n+UjqKB7+AkvOIrA==
X-Received: by 2002:a05:6214:448f:b0:8d1:ae7a:7d79 with SMTP id
 6a1803df08f44-8e6d6684d38mr139260146d6.41.1782511535495; 
 Fri, 26 Jun 2026 15:05:35 -0700 (PDT)
X-Received: by 2002:a05:6214:448f:b0:8d1:ae7a:7d79 with SMTP id
 6a1803df08f44-8e6d6684d38mr139259696d6.41.1782511535049; 
 Fri, 26 Jun 2026 15:05:35 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8df7fbdd5f1sm227461456d6.21.2026.06.26.15.05.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 15:05:34 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH] hw/riscv/riscv-iommu.c: fix MSI MRIF interrupt-pending offset
Date: Fri, 26 Jun 2026 19:05:29 -0300
Message-ID: <20260626220529.3800372-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE4MyBTYWx0ZWRfXzn5f4bbdmCxX
 nN0JI1bvRnNwcQ3RxKm4CU1tvjVubi3FRaHCRrX3HvH49Gl+nW7dwJwbE3Zlo3GMU16UQMdMWBF
 Ua9j9k5ntnmvefuDDsFJ4TnnW+qnOqbj7Iv5pA7ch/3yUkSJIxH1/ykmkxVphmfg5HShqbYALGZ
 m0wZilk+w5ia+NBdUKoOp2VqkFKZV1sezTGYSkJ3cUx//LXBdDUI7ozMh8HzJRsYSOp3EgW8dZM
 FSjTccFt9j/Ks/fVv3kcqNN1FZfvvNjQ/rRaNX3ffLmLbBxe9gZA+Qejp2WMl86UNBYd9E1gULD
 mJGWHhzeIBXK6+Ydm93WeMMc0QHKEeNgeyBcyQzaFv+bBIJ/cL9HRAIW+biqbGKqCv01dZujgZ1
 wnprR4Qxg4JMnfb2p1KmOfqOD/CAgUnyoRyRDzhG8lj9DXYO3rpZH7QqPgisVzxujfTKVTCLD0a
 ukQKG+icaTo2duhjesA==
X-Authority-Analysis: v=2.4 cv=KNlqylFo c=1 sm=1 tr=0 ts=6a3ef7b0 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=Z7ZtqlpJiFJe_yrWnE4A:9 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE4MyBTYWx0ZWRfX427HbXllI/Pw
 XRNBiqOdGtToxZOgpD+1aZiEoOglEG69lTcFBgSB1V9wzzXigkaVJbBotLC6RXMGUftpwUy36NZ
 mqBXWO1/LHJ3FSm2di5VxydaW1MA1vk=
X-Proofpoint-ORIG-GUID: 0HLtskiBdjFXXNeLLyHFTv0n2uqQPCa8
X-Proofpoint-GUID: 0HLtskiBdjFXXNeLLyHFTv0n2uqQPCa8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260183
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

We're doing a wrong shift when calculating the offset for the
interrupt-pending bits, off by one right shift order.

This went undercover for awhile because the calculation works for
interrupt entities 1 to 63.  The math goes wrong when using interrupt
entities 64 or greater.

Instead of fixing the issue and running we're also adding some notes
on where this calc comes from.

Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3561
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/riscv-iommu.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 3ea9130860..792729cfd5 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -686,7 +686,26 @@ static MemTxResult riscv_iommu_msi_write(RISCVIOMMUState *s,
 
     /* MRIF pending bit address */
     addr = get_field(pte[0], RISCV_IOMMU_MSI_PTE_MRIF_ADDR) << 9;
-    addr = addr | ((data & 0x7c0) >> 3);
+    /*
+     * AIA spec section "Format of a memory-resident interrupt file":
+     * address offset 0x000 contains interrupt-pending bits for
+     * identities 1-63, offfset 0x010 for identities 64-127, and
+     * so it goes up to 0x1F0 for identities 1984-2047.
+     *
+     * Hence each batch of identities advances offset by 16 (0x010)
+     * for every interrupt-pending bits.  This means that doing
+     * (data & 0x7c0) will filter out the first 6 bits, then
+     * a >> 2 will turn the result in the 0x10 steps we need.
+     *
+     * E.g:
+     *
+     * - (1-63 & 0x7c0) = 0, 0 >> 2 = 0, offset 0x000
+     * - (64-127 & 0x7c0) = 64, 64 >> 2 = 16, offset 0x010
+     * - (128-191 & 0x7c0) = 128, 128 >> 2 = 32, offset 0x020
+     *
+     * and so on.
+     */
+    addr = addr | ((data & 0x7c0) >> 2);
 
     trace_riscv_iommu_msi(s->parent_obj.id, PCI_BUS_NUM(ctx->devid),
                           PCI_SLOT(ctx->devid), PCI_FUNC(ctx->devid),
-- 
2.43.0


