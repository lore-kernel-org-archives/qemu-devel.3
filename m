Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6BFC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 20:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wef7r-0008CV-CT; Tue, 30 Jun 2026 16:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wef7n-0008BV-4u
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 16:32:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wef7l-0000aD-GT
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 16:32:06 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UJDXDx2942514
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 20:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=jGopJavkYeBYBXg/7hLpl8EYHaTc+xVFyt1
 r+Qma4Gg=; b=mpcbNOnK4/5imXlpcgByIjmVOFFDDgEkcpTCSo0krlpHZqCk9vA
 gcfLEPX/fUXyVXquKyzKpRi5p1v8tfwXWsjCv6Rck7PUysmoaeWrTmRXH9aLB4N0
 tjpNmesWZwPwBUCJkI2ulVlCCj+migN0CGijjdPGOBCOjsOfjKUiKSqhn6sVAud/
 sQ+SJGHLmMxXk2C2bmC4GniiEEI3mlCstcj0Yw+A72WXf2HbkwV5u6qe8GfCpK6M
 dPMuH8t4olI8uuDq1vGagR6wP/yTRLN4HCPw/AZFBfC9Hp/inO303gORrh6apb6P
 wyo7bv4012057LGbNGD4oSlbmSJ21Hah7Zw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4j99gt9r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 20:32:03 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8ef18406878so51970476d6.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 13:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782851522; x=1783456322; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jGopJavkYeBYBXg/7hLpl8EYHaTc+xVFyt1r+Qma4Gg=;
 b=Cj7Yjw22quhTjWezEmHCh6aKGXepqJ8BpXMWhcB8dVtet2ucmWZnxbPWJyp0fkfKAC
 +FNRdH7mZoMeotYD/JxF4FCIOmKDY4UaAQ+jZAc3IQhYYoFxIusfpbLugGCCVr42WYMb
 +4jY/IYHOA9AOJFd0X3RstvT5Qx0Fv09/mH/j/FtWK18UmvtdquVnzvsQSfa8BB8xuFL
 GLAJe9cuPH1cr+adTPg8sB217Zb/DkSEtMN6zmOOG/UzD0p6EF1M7rY2FRlG5/EObfV3
 SaHMkq6W55sTVs0Zt5co4A2HS3XCghH5MTWw4cpJHrfAZ/nxmYzfqtfO8PHSt3IMft+T
 Wmwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782851522; x=1783456322;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jGopJavkYeBYBXg/7hLpl8EYHaTc+xVFyt1r+Qma4Gg=;
 b=peko1ofJU6ZADejtc+QF0XzoOtI0hRs+PaOb9RmAHORug8N0spAAIU/nqvIdMUM9WA
 aWTzMaOYx4V3zXmM6nxZs+JtnmICXpAyXtnLoAXebr0jn2p4Cz5VcPOKOBkHuED+VQPM
 wAYHZWFbMFsHthRrYLxyvYLx9LuRy3OQuJE92chDcuHPafUpjQ/IKvFymOUH8sADfvsc
 sLRP1GfHp8ZSnILRvbEU3ZWQj9w1YWhY7xTlmTv2hmlPu4HcOHVZxdEeT8V+rnDhlPyx
 BKDvxegiicftSUhJB19bBpF4kQbVj+AqnTduxgtOIKlo6n84Lig+t4P3Qp40ItnUf6Tb
 aliw==
X-Gm-Message-State: AOJu0Yz4nR3bf8MnzVYXXEGKK877RDFXA37/PAHiKNGPjIvpyj+/Vsg9
 6aE4e4s9YI2GJQdJL+/rwOlNc7IPEvl1D/XVxIumNOJcwGHu274/ouZCMVd6XEykCTIv6uB2onS
 L1sPHYFYC4HV4RVlHnon8icub3rn+QeLzQ9DC2iw1AXpaNRaORpaKc8QwnirikMcvqQ==
X-Gm-Gg: AfdE7ckBaekyk5fxStQSescp1O1wsL2+RayH/YOTjx8rUzyIbPwfa8J9Aku6MrZcrYm
 qvFouUnv77QpfZV25TsguyVmmsKLK49G4Kv4wJEuln/ovNA1Bw4CbQ1jFZPzwfnuxOPmEQaDnOC
 sKkRIhJpVFENm3KvRDL5vOsN2YzijZtltCyJcqvCVfnJfH1lRvEyf59Y6POGqMmBiOy9/bMIKOe
 cRm6X+vyS8qZM9iGnp58kP5f2/ckFZTtND0t6dxYHQjugUZAlErxbrsDZvvNCrJ9YunXkLBOIq8
 k5q06qR9iTgAxa75mxSGMFxb5fVSHvaxhWh5pRxrHosLbnLIMJ6sTVXeNQq893kLmZyCXouC0Xl
 r6hm97ODvx/48v8aVs2wc3A/hMpsgbCOfFXShD6AxAmnQNA==
X-Received: by 2002:ad4:5aa6:0:b0:8f1:1bf9:5119 with SMTP id
 6a1803df08f44-8f1b9248ca8mr78848516d6.8.1782851522127; 
 Tue, 30 Jun 2026 13:32:02 -0700 (PDT)
X-Received: by 2002:ad4:5aa6:0:b0:8f1:1bf9:5119 with SMTP id
 6a1803df08f44-8f1b9248ca8mr78847996d6.8.1782851521410; 
 Tue, 30 Jun 2026 13:32:01 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f1a26f1b34sm34002006d6.3.2026.06.30.13.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 13:32:00 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Tao Tang <tangtao1634@phytium.com.cn>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] hw/riscv/riscv-iommu.c: check for misaligned IOHGATP_PPN
Date: Tue, 30 Jun 2026 17:31:55 -0300
Message-ID: <20260630203155.2103084-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE5OCBTYWx0ZWRfX7ujEuIfna6Hi
 1/zTMC6yT3y9DsfdJ4OB2R6Mz7ME/8V2+W9Q4RIh4uEuRsXDtSwwbjdNnmO2WOCckPV4oK4hFop
 4qbkvbsImgertaGTEBUOHjej6je1rC0=
X-Proofpoint-ORIG-GUID: Mn-8oPJ-lIVA0m0W-UcDx3dPsaaU4eDM
X-Proofpoint-GUID: Mn-8oPJ-lIVA0m0W-UcDx3dPsaaU4eDM
X-Authority-Analysis: v=2.4 cv=bNcm5v+Z c=1 sm=1 tr=0 ts=6a4427c3 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=Hby_iviSRyb2hFVhffYA:9 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE5OCBTYWx0ZWRfXyUaqrY3xbNdV
 6J4Xy8LHKntQiS7wKXICsSTXN/V2ERmDOElYLgXc937wa5Afa/WmrjS45RdU3YUj6zCt18b0eNN
 pUCOsnEAdf9YQ03fxBDb/4n6eDY1YmSbI2nVSJxg/bRWggyHp++1VpSUDssHRFxO1AU7n631TL5
 8FX6kqORpwlaHT+lxCzolH31EpXy3hNo6Milgyxvo9EAOBDiyEqKiSyla31gaRuy/uZ6irMFC1C
 FY+3vk5Kb/GdpFKZN31LwQ4nc1w/GHgc6kXwPCYcrk9ZktPwPwM+7mKkxuJyHhY4abV55xdzDIZ
 Si48mO85mvmNxsyGzLeesxzujzX4osbJuKhY7QRS1trj8X9ygS3rfDZvFH55ftZAvuabm2ysfWs
 kCYlcDmilEne79AXSyCBTJqhdD39cZ0IdqPd51E+iMnO/MV9F+Bl/GFQSd3pSpBmFcsabtC46vK
 y07yyy1oZvQjVx3KP4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300198
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

We must check if IOHGATP_PPN is 16kb aligned for non-bare GATP modes.

qos-riscv-iommu.h needs change too since G_IOHGATP must now be 16kb
aligned too.

Fixes: 69a9ae4836 ("hw/riscv/riscv-iommu: add ATS support")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3550
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/riscv-iommu.c               | 14 ++++++++++++++
 tests/qtest/libqos/qos-riscv-iommu.h |  2 +-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 891a56e731..09990c640f 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -795,6 +795,20 @@ static bool riscv_iommu_validate_device_ctx(RISCVIOMMUState *s,
         return false;
     }
 
+    if (gatp != RISCV_IOMMU_DC_IOHGATP_MODE_BARE) {
+        uint64_t iohgatp_ppn = get_field(ctx->gatp,
+                                         RISCV_IOMMU_DC_IOHGATP_PPN);
+        /*
+         * One of the conditions for a misconfigured DDT entry
+         * according to the riscv-spec: "DC.iohgatp.MODE is not
+         * Bare and the root page table determined by DC.iohgatp.PPN
+         * is not aligned to a 16-KiB boundary."
+         */
+        if (iohgatp_ppn & ((1ULL << 14) - 1)) {
+            return false;
+        }
+    }
+
     fsc_mode = get_field(ctx->satp, RISCV_IOMMU_DC_FSC_MODE);
 
     if (ctx->tc & RISCV_IOMMU_DC_TC_PDTV) {
diff --git a/tests/qtest/libqos/qos-riscv-iommu.h b/tests/qtest/libqos/qos-riscv-iommu.h
index 90e69a5d73..4a972401f5 100644
--- a/tests/qtest/libqos/qos-riscv-iommu.h
+++ b/tests/qtest/libqos/qos-riscv-iommu.h
@@ -46,7 +46,7 @@
 #define QRIOMMU_L1_PTE_VAL          0x0000000000012000ull
 #define QRIOMMU_L2_PTE_VAL          0x0000000000013000ull
 
-#define QRIOMMU_G_IOHGATP           0x0000000000020000ull
+#define QRIOMMU_G_IOHGATP           0x0000000008000000ull
 #define QRIOMMU_G_L0_PTE_VAL        0x0000000000021000ull
 #define QRIOMMU_G_L1_PTE_VAL        0x0000000000022000ull
 
-- 
2.43.0


