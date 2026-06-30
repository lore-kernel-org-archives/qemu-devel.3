Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F87C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 21:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wefjP-0002fV-M7; Tue, 30 Jun 2026 17:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wefjO-0002f0-8s
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 17:10:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wefjM-0005Vk-K4
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 17:10:58 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UJDVHf2881277
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 21:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=np0FPgcNdXo12h6KgyPs/L/R7a9BfjPi8l3
 oXXD/rvg=; b=ZdEe6rxJC7GzofwvDijW710NZx2p4rAVq+uJdVUQQssjXFSv9ss
 O6b5zQepaklT3aEWsmCrgF2KMKiWm5RNBD1NCq6oE5Xz5YrwgK3fEQOPM/+k54t2
 O5nJB1XP/7N+WoBT0qWsG1dqIghi8mGyxBS2Np1N1hEnuz/qVafZFfoKcO3JOfsi
 MW32lrwsOLrmF0xUsyFltH1DZCPiVBqz1yMxkY0V9saJV+hot9hwanDdztycQBlQ
 IS1HXWvSa7GJsorW1+NVThmIw9/o7o7U2D/HP7TUi1PfZhRsQrnd7UUv5bDda3cs
 h8ayL6YbNxSPhEU4b6sjZUQZRjgOgk6xLIA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4jtqgrp4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 21:10:53 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30e773699d6so3748083eec.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 14:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782853853; x=1783458653; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=np0FPgcNdXo12h6KgyPs/L/R7a9BfjPi8l3oXXD/rvg=;
 b=Zdp35mBvJ+Bs/ge8xUZAuFw0qn8BIB2wzjvEdnNFfV7vL39TvHMKHPOJOv2vUXO8tn
 JdcsPiFV8LlnhpGcDhYnXgTXdSkQfhv5Tps4rNQI/KOjmFauCKPfvnXHbV9qhxZQuyww
 EPlzLVvJp9hDukscj7mcZvfphsctij7Nf9cp9LFjGro85rorOJvO2exDz1g4XU/XtRbW
 3ZxyzDp1K4UhJZTv26Ii/0dk9gFjQper5Z8sXf1+NDo5ieV2IO3DBvyq0skC8Q4CuT+d
 JsNBhbjZMAEBAdAsT9YLxMzVMnUCVrKe60xyjRvhkNUZatFsFR/59RZfIFJf3JdPlwJw
 9ywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782853853; x=1783458653;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=np0FPgcNdXo12h6KgyPs/L/R7a9BfjPi8l3oXXD/rvg=;
 b=gPM4mnE6HdHLVCzTclDV4JbQDtoy8dNFzcIL9NIP3CSVoXg3LQ663Qm/QP5E+Mwicf
 hSfK4rlxn0OLKcTbUJPhX9vOvKfL5w01f6sDssC0mgTTg3WGB0vkRvlhwYIANRPPPNgH
 uf57K6/cl9f336J8R3CH3KAzXZtugG1O8DrHzsazHUcNrVacM2dB9JsJt4r0hShdWskL
 CXhjF6Yn6jJrP5cRErZDp8V2mz5sv27Lp1QvtNKUO3ExZgRs0PcAQ2iZmkSRordHd0kP
 c6Wrj6SQ59myUK786WS+swkr2V4yk+jvnzmMUuLnTl0Hzzz283M2n5zelTL521xZw5AH
 gZIg==
X-Gm-Message-State: AOJu0Yxq1FcurK3xs6b0dEqfq8J6lMZhajqUhRo3kT97Opej+JBsYshn
 r1p0c47neeZC9gCXFctZM0CyfebtMxt4OaDHLD8xc8HycdWFYkY04FfrRQj7JpT3wo8gwbOVtJh
 7bRw00bhOEUmK5JAJlhjnVNGojlUTxN3HmvDNk1wvaDSgXQ0BUfS5G8b5bbdUNpsPJA==
X-Gm-Gg: AfdE7cnn7lXNaY+JZUdrTQlFn57XVf8T/i4gwYQGm0ZkuJ0gjGJ9qMypOjQAKSvgbHe
 S6IRqVoljNadlxo9BJS9cL+VPsVj3z2CZc61MflyT/qySWHoGaw13JM740Sk5jTQsguYJwzqw8p
 eK4gRI4Qi2f9yrshsf1P8rFWkzxo8bg1ywBPSWbqLd6E44VDsnu2uqzTCGbFE8o0Q/l4SOXMsDV
 Dg8UYf8Xzp4AMmGkUtd09NjugVV7vydV7DwKkgxR+ilGKR4NxpuAY3PrQwANV61RG/bMJ6/vuzf
 cN94L6tiWcfPpfe+nfddCvZtvHnn2OZmdkI4jB/ZnFIfAiTH/3i3AZpdFD4kzXYQ95R2xzD1VH7
 8my4rwq+KCNdWM8aTXt9f1dj2bGh9mfpa0w3pAO61YTmGpw==
X-Received: by 2002:a05:7022:f686:b0:138:2239:be with SMTP id
 a92af1059eb24-13b2a142f8fmr3399246c88.8.1782853852891; 
 Tue, 30 Jun 2026 14:10:52 -0700 (PDT)
X-Received: by 2002:a05:7022:f686:b0:138:2239:be with SMTP id
 a92af1059eb24-13b2a142f8fmr3399227c88.8.1782853852346; 
 Tue, 30 Jun 2026 14:10:52 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2aba8008sm9364232c88.11.2026.06.30.14.10.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 14:10:51 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH] hw/riscv/riscv-iommu.c: always fault with SADE=0 and A=0
Date: Tue, 30 Jun 2026 18:10:44 -0300
Message-ID: <20260630211044.82894-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: P3LIwn5jWynZEQKpZFe5CEZSQ_BBeTlZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIwNSBTYWx0ZWRfX86GQks0stBsJ
 qQAMJef9bnQCh7lgXmCNVaQ3tv6PMV11EXH6Ae4u8uQtP61JvfS3wUL6ConuVvsLTZECmdDBo0a
 H1AwG1le8/EumJ+jIuf9GXiuXSV5pm2cn6feLRJ1EGZMA1VVbcygQX++CvzZKDoE1Iaz8rGk6rm
 3KmJKydKyY+iA98xWpBFtS7tTNBrb5KhF3wJf9N3C1hvM/pPISZLmEx9yKNMsl6qULxtZb1oGE/
 2pmpDviSruU//qpyORxie/ApIw45/CP3jTdwdXF4OuLlMEwENIbdYY/eVXrlizhRNaOSB6bRbBO
 hC+rPyjJ/NrOCnDPZFMNSBdWa+DyppDeSmK4VuHgrNy2X7QVQR/IeEJLuBXpkasliIy68pbp1cm
 CYKmq5iMPhbqJvMySVdNbbtOqw/xZZo+VT6AbRYKcWVokuGqPyiPOsMqSqXFVRRjyM+u5L8G9js
 UMqxyH/Kf2CRLn2RL4g==
X-Proofpoint-GUID: P3LIwn5jWynZEQKpZFe5CEZSQ_BBeTlZ
X-Authority-Analysis: v=2.4 cv=LIZWhpW9 c=1 sm=1 tr=0 ts=6a4430dd cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=DKeKJJKbz6FZDBTM3_IA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIwNSBTYWx0ZWRfX6ywAXru7FJXf
 I+S9UsDi/PbU7yftl13RhXUR2Zd0s+zPO+fnUF03rBwVGSdnqIx6u1LidjFWMYvFtf1UjZATrV9
 chWVqdtfVciWO1mr/Pft2SZEDOOpjdU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300205
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

riscv-iommu spec: "If SADE is 1, the IOMMU updates A and D bits in
first-stage PTEs atomically. If SADE is 0, the IOMMU causes a
page-fault corresponding to the original access type if the
A bit is 0 or if the memory access is a store and the D bit is 0.".

Note that SADE=0 and A=0 will always cause a fault regardless of the
original access type.  Right now we're faulting in this case just for
reads.

Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3551
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/riscv-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index c9687e01a8..70eede3f14 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -480,7 +480,7 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
             break;                /* Read access check failed */
         } else if ((iotlb->perm & IOMMU_WO) && !(pte & PTE_W)) {
             break;                /* Write access check failed */
-        } else if ((iotlb->perm & IOMMU_RO) && !ade && !(pte & PTE_A)) {
+        } else if (!ade && !(pte & PTE_A)) {
             break;                /* Access bit not set */
         } else if ((iotlb->perm & IOMMU_WO) && !ade && !(pte & PTE_D)) {
             break;                /* Dirty bit not set */
-- 
2.43.0


