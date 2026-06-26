Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB4BFC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 17:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd9zv-0007ya-OK; Fri, 26 Jun 2026 13:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wd9zu-0007yH-2x
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 13:05:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wd9zs-0004Ly-Hf
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 13:05:45 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QFie0I1725906
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 17:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=rHkaSinKw9rxeEQlSeJVjrJHgx/3ODwms0D
 HUpJfUlg=; b=DVYYGu/5RsHShfw33f9z+as2EGMxlPwNvkVAEeaXNm7tkSzt+ez
 KYQdEcmVIikZ5xFaeqkgDz/ov6hVzdSEdnoA4i38fHyMsEJefcrkl9XjCc5QkJJa
 SrOIVmPL8WUHJ0LwZFNu6Ljgn6QCPiqvjNGIEBbAl10mMQ2Q0C4DrXvrz+XztpUb
 nm7o6VPZ/kXW76sA53WdeOU7V5mgcmJpiRw1CuFO/uFjcfyZNAgWqlbvKxq1+uWp
 fTTsHHBWztP3NgSNpbCRmYadBV2KZpSKVvrMvjapwezVWYVCisuS4YATEup8MGii
 F5ph1m+NPXPEwTiJpyxrppag8Z+Qm1zkjWw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1ngghxe4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 17:05:41 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5195760750bso19103141cf.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 10:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782493541; x=1783098341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rHkaSinKw9rxeEQlSeJVjrJHgx/3ODwms0DHUpJfUlg=;
 b=j1N2Ep+aM4EKE3dC6IS90vN33RWj0vZmj3XXcKCNr3feGrn9cL167Q7Y3HtmEInn82
 5Ti0bOqjkhqjstkkCsiv+vLMQspXyaw2VGOfsqeYpVsL716U3VvVbeqH0zWws7r/b1TN
 dh0sKDSd3Q3L9DRCVu6aXXvzC0QviM8lfcliAUJ0yXqYhJKwO0t2307OB65qN+ZuNAmK
 TEeuUC++C+Fc4aOWqS1/Qitc2avwxYTNHGFo1xbpc22iEhoV1BF+WLFKm91Hn1ueSrVS
 +ljujsGvAEkV5lz1rTaWjhO32KAcp2n3f5M/E/kZPvy8cZJE9ykSh5MVSuAzI0SsuQuv
 pA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782493541; x=1783098341;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rHkaSinKw9rxeEQlSeJVjrJHgx/3ODwms0DHUpJfUlg=;
 b=JGEabQQ3+g5eWR+PiaM20imiueJX9ZQMg8xQU8cNgPw3Ae6j4Fwol+zjyUj98nQIA8
 dvM4YVNBadJ5UXhCdKhUx2SDzEty38y4WrtULpmcjv6ogaMHwuytWmHUaZC1Ea9tYPzJ
 dTwO4HOeP/7hvxfaOuunM0//a1Kw4MW59YlF1TcYnddPsn1bqaa250xSJ+tX4eReDVSB
 ASL6s3olFUAVjLJIkAORfH09rbkv0gS1Ze4EYhli42CE3Lt5/TDEJenKOMn/uAse+/Gg
 KKs7VVpfB1D+LYMi484vIGZQNvTn6ZiPbho3ituXWHE+jQW7lvfl7RmH4XZV53UEpnXR
 eXbg==
X-Gm-Message-State: AOJu0YwnEfohsTVPSYICPWCR6FET2es8pLTcn5zZarbaXVxpO/xEeAUR
 dFufGR60e3DAv2E4lAa4PUYz1UJTw2RKl2Xy0eOYlch9vy+c7dlYkfUIQlwTxvVgqYsD4Ksx4yr
 X/HTyCVtBJ1XXcZJ8z7/18tX/XbWk7Ck4wd0NWGu+vYuFoJR44SQgEx4bSrVA8sICNw==
X-Gm-Gg: AfdE7ckV3xCwCsSYipGAtWrQhvBC9D06lRuS3p6mmu+gU4DgcLTjAfRjM6Vb5EKpx35
 ZtXXIEVLokWisfFwphQq+GAEQWI2O6eJxtzfg5zGlzKSstmMzgqsRyKljFGSZlmGoBt0joGJUDm
 NxT+X7FhVawV12+14XOyV8A6T3Um468h45IOTSf0LpMY9JC8ijlFURaIG3JszTtBeWkKmZ1jaab
 NhIYXcK0c8SoWGnFjFznQXASFrLsbrfeEuJP0gHWvX30lIamzfF+7W2fPFYOjc+vhbFXDCPDsu9
 Ow3T86Wu4Lzgtw9kJ1GBYLLlQ/c31nLHQjZHplONIx56VrRNGVJZHhjJLF3G3ZCA+aRa+EXYhnc
 Y5EMaYUYcTjCh0sDzQ3bzfHc8roe0NO3qbhuLzyRcr1cCvA==
X-Received: by 2002:a05:622a:4112:b0:517:5beb:9b17 with SMTP id
 d75a77b69052e-51a7277c822mr123098071cf.1.1782493541080; 
 Fri, 26 Jun 2026 10:05:41 -0700 (PDT)
X-Received: by 2002:a05:622a:4112:b0:517:5beb:9b17 with SMTP id
 d75a77b69052e-51a7277c822mr123097121cf.1.1782493540449; 
 Fri, 26 Jun 2026 10:05:40 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51a51ae9505sm111133901cf.26.2026.06.26.10.05.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 10:05:39 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH] hw/riscv/riscv-iommu: set cmd_ill IOFENCE.C rsvp bits are set
Date: Fri, 26 Jun 2026 14:05:33 -0300
Message-ID: <20260626170533.3562484-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE0MiBTYWx0ZWRfX7u5GbQDZov33
 woX2MuyYDf/pTf2jDrheVGKEL72SdYouVBrP9y0zVhXX/NVHj0o4Z26aJeHxAnZeIEOKrmwMIID
 uq/wZRm96taji6UU50c4E2KwySVa3asecKC2jOSHIy2NINtv5/Akf+Ij/FmtMe332aRbmlg6x48
 9+qWRqFEkcq5CMi87JmX0xO8SSxZ3Bh2Wa4m+7ULqS6A7gdK9YH9j/T+VzxHItTCTHaYBahiDLY
 9goVXJMK3BLBGS4A3Zy54nH8YutvYe6NNJY3ZHWefisbgbp9RugODQrrseVO1nxPvpmOpmZu8Fs
 uV8zqjt/b6ecY+sVXSfrkkTHCvqU9766e7QZIz4scf+mragmHbTva/hBHLd/PwXmHJ38GCyGqVU
 gqEiIGKOzBpVSzDqXZk98ajk+PCOYZMl7cEt5v0mHVga/n2eEFHQsXTmGaOS2cqexnRxC24R2Ap
 6f7d2zpK4JPNUoPwz1Q==
X-Authority-Analysis: v=2.4 cv=KNlqylFo c=1 sm=1 tr=0 ts=6a3eb165 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=LCFUk0-MNyTV7KBWhY8A:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE0MiBTYWx0ZWRfXwkrA+aB4NnXj
 pa1zpBBtIRd4qLSJpSd5DLg7M4esXA6QbVKUIumjJD43TWUj4MASyPnxRjWiufnNmzHJ9TxGnkT
 ZjUc5T0Ha+J5c/5UuR14/nId4vnGZa8=
X-Proofpoint-ORIG-GUID: mW89bqF2LZg8_TE6oArP9WqJDJKsSwqY
X-Proofpoint-GUID: mW89bqF2LZg8_TE6oArP9WqJDJKsSwqY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260142
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

We're not setting RISCV_IOMMU_CQCSR_CMD_ILL if a reserved bit happens to
be set in an IOFENCE.C command.

Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3575
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/riscv-iommu-bits.h | 1 +
 hw/riscv/riscv-iommu.c      | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
index a938fd3eb4..60256ad9b8 100644
--- a/hw/riscv/riscv-iommu-bits.h
+++ b/hw/riscv/riscv-iommu-bits.h
@@ -344,6 +344,7 @@ struct riscv_iommu_command {
 #define RISCV_IOMMU_CMD_IOFENCE_OPCODE          2
 #define RISCV_IOMMU_CMD_IOFENCE_FUNC_C          0
 #define RISCV_IOMMU_CMD_IOFENCE_AV      BIT_ULL(10)
+#define RISCV_IOMMU_CMD_IOFENCE_RESERVED GENMASK_ULL(31, 14)
 #define RISCV_IOMMU_CMD_IOFENCE_DATA    GENMASK_ULL(63, 32)
 
 #define RISCV_IOMMU_CMD_IODIR_OPCODE            3
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index c9687e01a8..d47abf9eb3 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -1876,6 +1876,10 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
         switch (cmd_opcode) {
         case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IOFENCE_FUNC_C,
                              RISCV_IOMMU_CMD_IOFENCE_OPCODE):
+            if (cmd.dword0 & RISCV_IOMMU_CMD_IOFENCE_RESERVED) {
+                goto cmd_ill;
+            }
+
             res = riscv_iommu_iofence(s,
                 cmd.dword0 & RISCV_IOMMU_CMD_IOFENCE_AV, cmd.dword1 << 2,
                 get_field(cmd.dword0, RISCV_IOMMU_CMD_IOFENCE_DATA));
-- 
2.43.0


