Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93027CD342F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 20:52:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLSAd-0005DP-9i; Fri, 08 May 2026 16:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1wLSAb-0005Cf-Mj
 for qemu-devel@nongnu.org; Fri, 08 May 2026 16:51:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1wLSAZ-0004pc-Kn
 for qemu-devel@nongnu.org; Fri, 08 May 2026 16:51:37 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 648G4G4G1093734
 for <qemu-devel@nongnu.org>; Fri, 8 May 2026 20:51:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=UYixlM2ZLFvkxHABahcR95C/B+DqICf7ZSz
 8OQUreik=; b=alDzwJt8z/4I9Tjzj4zzSf7hGtxoeN6ANa7p6A5dmUDHo42HH6h
 1im2dXBJaKvyEQCJww0hXSleA+fJ9e06MJLIwbXjJn4XFjNtmW6Cp4ja5T1rLw0v
 G8yjNgqW1b8hUJQPSNevEl56MJ3mxt4hp7h7pT5Q+4qC2Tr6FqaHLpncY9q021HH
 sHRIsebNv19+EwBFU8PZ5RU/Pj14Pt8/at7GFR0VomJC0M/iFsj3At7nSkSncPyg
 I2gJibho3r6Jbt2cM5AEnksrlkhQh+XEhBoyIsribfAUPE8iwxmhhrUpXfXTp3tb
 /fauYqB1B24mpBh24wDkaaKWEe6ZKhm664w==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1k1d0xyb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 20:51:32 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-130aab787bcso5690018c88.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 13:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778273492; x=1778878292; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UYixlM2ZLFvkxHABahcR95C/B+DqICf7ZSz8OQUreik=;
 b=at2IXxBapJ8+BhRpdr5+IePyvxuRpoWe9L9OZXZkdo1Scc5TUZ9/rSuvcDskhqF9U6
 54UXupVnuQI6qw1Q7broriuMlweQSv01M4i22Xqu3kQQoHzeoZKeeXrXZZZ0le8XZ6Xp
 l0weIDMMDUI08aNjWPRQt6yGONjUbbNSFEECosOrEClCguRK4sHUbF4blA84Z/c2ViMD
 s/sF6Ih2VGhh56OHD/wn7jt8NMbQkZ5D9Ll5r5uukyu/FsmR3ZjnRZm4+nVdX+MWIxKy
 ZkcAbk60dWYU/zWmSjTrD3t21l0kqcCG1Sn9pXf2uEdWOJVvSpAX0mwuVmKrtQg0Fb/F
 RYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778273492; x=1778878292;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UYixlM2ZLFvkxHABahcR95C/B+DqICf7ZSz8OQUreik=;
 b=NgHKYawMO7rS09agiJhCORSX7PjjRlc2SSpzBw0+RSW9vuyBO5aE8JbsCex3DQdchH
 W7fafe76QW3/pxcY84RLix+U4ATqnXEpLOvTdlDz98gVBtMoiylWXWpCXke7O4kbWuJ6
 Bw997XRIE3DgvBo8DhSCCwduneicVlaoBmmSp9oNZT9QAe3ghl8ZKggzlY1NV5bAMRBj
 gGU2+Ifgw20lfZPGr5mlfY3BRJTRYkpOo1gAcjMUaR/XYWPP4hFxRpDOlR7EbSEofsLc
 vnlOIpH6vO2atYUuH9fVAmGG+O9fD5Fg/j+tK1ox6jxa/U8kS4wLDZ4CLS19sbgUtN/5
 sIww==
X-Forwarded-Encrypted: i=1;
 AFNElJ9o6hhig3aNEvGcZoL5wPe01kq3tzF2reXMv2GNcA88RT9b3JxYvdVStc3jHeQn3r+Z+UMs0yPcJD1I@nongnu.org
X-Gm-Message-State: AOJu0Yz5p89ViE0tsJnqT9lw2daQE/83tneWGCdDF5UNYrgvLubIo3DK
 6JDlMUgqb3NGijlqysAWxg0xKRPp+f7fsJVM+ciExKlzWnPqPn0yYiE+8Td6l9MQT/RTqJLcBTn
 yzXSCftDEPpbc7OciOnpcyEWv8T9DyRViY61cGH75b4HjLxt9GHOwdTW3OQ==
X-Gm-Gg: AeBDievuUdH/fjgn+Ougf8UnYBo0PsehihPPF9/baXNx6QBI91at8TWd88J4lhKbtLU
 ky0pr+zpQfm+sJuJtateeeNnh5cuQ5y5aIOJyu2iCveee3rvDsYJxsDLQAAb6C1hiRfhOc25QWu
 ACbmUj9ryhSshA6m0qpyF+0IobV5kSyfW2pI65K+TfXao0D+JwS7CqZRsJ6zYjibbOfrnn/1sqZ
 UR7egySxD8i424TfyHzcH/Mf2BD1JPzxZ2fXNFDuwVu97QZ+ZE1R7NwamAMs0J2O1Jf6pO2EFQ+
 Z7sX6bwz2/BPDXV4R4bSZq9YYXIU8hUGQWCEypTtIYS266XpzV+6hjhgARe+OnIbVah1xURcCrV
 kSfIKDgxD/jGvwrucZ7ueMO3pZGWkVQU=
X-Received: by 2002:a05:7022:fb0c:b0:12d:ca31:f19d with SMTP id
 a92af1059eb24-13271b86630mr2319319c88.28.1778273491877; 
 Fri, 08 May 2026 13:51:31 -0700 (PDT)
X-Received: by 2002:a05:7022:fb0c:b0:12d:ca31:f19d with SMTP id
 a92af1059eb24-13271b86630mr2319295c88.28.1778273491252; 
 Fri, 08 May 2026 13:51:31 -0700 (PDT)
Received: from localhost ([140.82.166.162]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1327810ff4dsm3858562c88.3.2026.05.08.13.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 13:51:30 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, palmer@dabbelt.com,
 daniel.barboza@oss.qualcomm.com, tjeznach@rivosinc.com
Subject: [PATCH] hw/riscv/riscv-iommu: Fix Svnapot 64KB pages
Date: Fri,  8 May 2026 15:51:29 -0500
Message-ID: <20260508205129.377032-1-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDIwNiBTYWx0ZWRfX1P/bLFZahXfL
 w7p+pvoMIw7nrBVmH7bK2+/0jyyJGcAtR+qkMiX+Z6qia0e954nABhWNKURz7y+NqI3NvDCEMGf
 FRRySv79Fp1YSRHkbR/gD0HxBb8HSGKKRTgmdPpgKRH+RUXY/h837ip/XIs5Pcfy963esIfc4CU
 GlEEBeKbj9gNL2WMZtC3/t4/2zurABcLmDPTcTAKnuw/7TWRfhmJqozzGfCYvovyVcBFtp1jY52
 DivZkMvzUK4B1c7eUR1Mzl4hmOd9ccI8Y+50meqHEGQELV7phAQxGS/0lcBHKvJxWgHH0VwmzBx
 gTRahzt22X6t/kT+gPECtOV9KlW9yiqBUJ1a5qaxlI1E+xxDN39VGo0LInWNXXomOk0n8xlqEKJ
 nCZgwYMuEtEgoMht1s0hCGidPINr2fYhq61x8kZYFoLbHZROe64NSr7wf5kQglIiEXjyPzfQQkF
 2s8oOoztlvr0y8gTy/A==
X-Authority-Analysis: v=2.4 cv=GLU41ONK c=1 sm=1 tr=0 ts=69fe4cd4 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=2y_yIg3y-CFyToFg34oA:9 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: KPxu01cxecl-ioJ52WDqDmc3QuvZL57J
X-Proofpoint-GUID: KPxu01cxecl-ioJ52WDqDmc3QuvZL57J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080206
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=andrew.jones@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

The Svnapot extension encodes a 64KB leaf PTE by setting PTE_N and
storing bits [3:0] of the PPN as a NAPOT size indicator. The IOMMU
model wasn't checking PTE_N and therefore was using the raw (NAPOT-
encoded) PPN directly in the physical address, yielding an address
32 KB above the correct base.

Fix both riscv_iommu_spa_fetch() and pdt_memory_read() by mirroring
the Svnapot handling already present in target/riscv/cpu_helper.c:

  napot_bits  = ctz64(ppn) + 1          /* 4 for 64KB */
  napot_mask  = (1 << napot_bits) - 1   /* 0xF */
  phys_base   = PPN_PHYS(ppn & ~napot_mask)
  page_offset = addr & (PPN_PHYS(napot_mask) | (TARGET_PAGE_SIZE - 1))

The spec only defines napot_bits == 4 (64KB); any other value is
treated as a reserved encoding.

This is a fix, rather than new feature support, because the spec
says "IOMMU implementations must support the Svnapot standard
extension for NAPOT Translation Contiguity."

Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 hw/riscv/riscv-iommu.c | 44 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 25a356d1d366..eb09cc974812 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -237,6 +237,25 @@ static bool riscv_iommu_msi_check(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
     return true;
 }
 
+/* Returns the NAPOT page mask, or 0 for reserved encodings. */
+static hwaddr riscv_iommu_napot_page_mask(hwaddr ppn, hwaddr addr, hwaddr *out)
+{
+    int napot_bits = ctz64(ppn) + 1;
+    hwaddr napot_mask, page_mask;
+
+    /* The spec only defines 64KB (napot_bits == 4) */
+    if (napot_bits != 4) {
+        return 0;
+    }
+
+    napot_mask = (1ULL << napot_bits) - 1;
+    page_mask = PPN_PHYS(napot_mask) | (TARGET_PAGE_SIZE - 1);
+
+    *out = PPN_PHYS(ppn & ~napot_mask) | (addr & page_mask);
+
+    return page_mask;
+}
+
 /*
  * RISCV IOMMU Address Translation Lookup - Page Table Walk
  *
@@ -458,9 +477,20 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
         } else {
             /* Leaf PTE, translation completed. */
             sc[pass].step = sc[pass].levels;
-            base = PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - 1));
-            /* Update address mask based on smallest translation granularity */
-            iotlb->addr_mask &= (1ULL << va_skip) - 1;
+
+            if (pte & PTE_N) {
+                hwaddr mask = riscv_iommu_napot_page_mask(ppn, addr, &base);
+
+                if (!mask) {
+                    break;
+                }
+                iotlb->addr_mask &= mask;
+            } else {
+                base = PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - 1));
+                /* Update address mask based on smallest translation granularity */
+                iotlb->addr_mask &= (1ULL << va_skip) - 1;
+            }
+
             /* Continue with S-Stage translation? */
             if (pass && sc[0].step != sc[0].levels) {
                 pass = S_STAGE;
@@ -997,7 +1027,13 @@ static MemTxResult pdt_memory_read(RISCVIOMMUState *s,
             return MEMTX_ACCESS_ERROR; /* Misaligned PPN */
         } else {
             /* Leaf PTE, translation completed. */
-            base = PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - 1));
+            if (pte & PTE_N) {
+                if (!riscv_iommu_napot_page_mask(ppn, addr, &base)) {
+                    return MEMTX_ACCESS_ERROR;
+                }
+            } else {
+                base = PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - 1));
+            }
             break;
         }
 
-- 
2.43.0


