Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5027C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:11:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wetmw-0002Z4-4P; Wed, 01 Jul 2026 08:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wetmu-0002Yg-QX
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 08:11:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wetmt-0002gk-CQ
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 08:11:32 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 661A8VLC744114
 for <qemu-devel@nongnu.org>; Wed, 1 Jul 2026 12:11:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=TmZW5SJh2F/
 t/sfvHlgMnV9qSmk9XIS1voG0p3KZfWk=; b=fZxVmum6gopoEbXWsdl8RW3N/UU
 14oLWUqZ4WeV63aFqF9WweYIFI06426gjLdlPnRiqEJgfXZvQtRrhZ1BET4HYcB9
 HVsABbxku/ibU3kJOu8VRRDmgwUmcF9sbCGl79qXVwgtTd86mrYhnz9gfDINJezx
 Voh8L3QfYAazjgIDLDvV6ilCXBfBzhrpCFAC+uv9YX5E9AOiF9mI/yynch6vB+J7
 J0PKp0YdmseRiuiIjO8RM+oKN+9iCGZsoo7TFrJA5E6rlGouq3FCPdNWUi8SrHBk
 4/ptOC68cF8Li6OEyp85RySvYdE1bioJktNuVb8DYk2lM6ryjzoIloa5EEg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4x0thd1k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 12:11:30 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8eeba1d9e47so8041796d6.2
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 05:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782907890; x=1783512690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TmZW5SJh2F/t/sfvHlgMnV9qSmk9XIS1voG0p3KZfWk=;
 b=XDtOCrEcvwizlO94ClaCjQLE7PCDkShw4kk9p5LYX289olxvFJRsyOf9uKveejHpGM
 3j0PTOBE+ow2cV8Q94grf8dFy5iZ02pCXZclevWUq1xLfDyDGbfhK/XJkvkMj+yUx48o
 KdY7djgXAUnjCTzCUcf7MbPgFj0WmbORHFqeYh25rJOy7X0qqn8y+mzL0i49xRyQLyUr
 cGvZQIaeTHbgolKL9h99/Hs0LRHBgqnO4vTNcpHzTr13K5oJ3ipxcaJftjddNvK7YBp+
 BadFd6tgtrf0fjKCoTBlY/tfGDaUoUwWs98O4kLRd/bJsaSQNJsVUhfnBX1qbluqZbTt
 JcGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782907890; x=1783512690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TmZW5SJh2F/t/sfvHlgMnV9qSmk9XIS1voG0p3KZfWk=;
 b=NoU8Wvy8VyIRHLmpwiOAiuRgYuCfekyBczZVZ60nuCKJVGj4DK7zOfzJJD4sKy7c8/
 4pTXSeitB+xyX8GdWsoYax/90YBOnaHM/cTLOpnaxi4DD66K+GqgfAnBOKZdz8pCIE7W
 Atx+xV22nuXkJk4hxK4tb4a6VzCpXkDS/lqcWmC1WCdjgcoUH//OYrJFtt3G/tsCHuJp
 1uSRlB/FixZT4mYxHmef/GowpbKRh6LhkVygCJnL9SajsjPzL825uFnkvSHPx8fC0SRh
 pc6kCRed02hMi6VkrkjFyJPG8VK6hiOS/po5ld9Yx0dPMWjLXxfVthTuNEjUf28JIUMN
 rhLg==
X-Gm-Message-State: AOJu0Yz7qK/3iZejwQu94HJjDRAEvAQIAJ3iknVqKCVNlrort4K4GGGp
 75cKxi20hkVYxAdMIFfRr1Rn9oTcw61D7AIbh8235UZUhu2IKL5NW0Dg5RH3PAqCe7ugackqfgj
 0pOo4rVi8qaxOSWL793saYbF/xpiNLEBhbuCxOVOXLtfC/JfjHXoDC2fDP66JWWPwZg==
X-Gm-Gg: AfdE7ckhw4Om9Bt78yo3C+5ZGJ+ORPEXDhOwELqcbmGdR0+H9wTL2ElphF6TLULQsIf
 M1bhqamWlFxfCk3UpX/6+RqUS1crsEtvpJQ90vaHAyQ8zM7fQ0MRc6fJXWyXlTb/vrkZaFbMqj5
 SV9SFhzPUYNnI24ZNpb9B6wIkeMEYOBjJYuVd1EhXsrIl3+urG1Zp1K7eI2lPW+M1yjE43A8bMx
 VrfUejPuXD6/zU2mMIuelVvh6sAWT2p1RAyu8T0oXAOam8EPZITqolhRFjjF6KdgrQwgXLo9LPP
 yKMwrAWKepoB5xUf12Ha+9siaozO49zDkO5ubjH+ZIxjI8P0AX7tXr1NzYiUXmc/9osafVkU8iz
 bFh6+Ms1+jHCGOLENVWKEqMtDNOkzl/AbPEJvTmG9IQyfbA==
X-Received: by 2002:a05:6214:5f0c:b0:8e8:199b:aad0 with SMTP id
 6a1803df08f44-8f3c65caf61mr18037496d6.7.1782907889692; 
 Wed, 01 Jul 2026 05:11:29 -0700 (PDT)
X-Received: by 2002:a05:6214:5f0c:b0:8e8:199b:aad0 with SMTP id
 6a1803df08f44-8f3c65caf61mr18036806d6.7.1782907889163; 
 Wed, 01 Jul 2026 05:11:29 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f3611df020sm19794706d6.30.2026.07.01.05.11.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 05:11:28 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com, nutty.liu@hotmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v2 3/3] hw/riscv/riscv-iommu.c: fault for non-user PTE in
 G_STAGE
Date: Wed,  1 Jul 2026 09:11:11 -0300
Message-ID: <20260701121111.537654-4-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701121111.537654-1-daniel.barboza@oss.qualcomm.com>
References: <20260701121111.537654-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: TYI1neCIJHWe5Un13fjdGobvyhETG8w8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDEyOCBTYWx0ZWRfXz6o5PVZW9/n0
 tlLa/BfqHv2fEDRZrepmt7he1ArQKUJjk5+Ldt47XRLK+2u7rd11xenLF3c5gReDl43LBaclkEp
 k5mWfG9RDi0yXThh+C0rFsYZTMPt8Nc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDEyOCBTYWx0ZWRfXz0p21cR+MBIa
 N6Omq/8T4Ag+TQKaZB8sSS74VEAaibzUwIrc4P7T3CLVactar2fDMAjywBnDXl0+j3LrBzqvmyk
 zcVbZ1urQwB072Rdc3Ui4OgKQRyaNBs3J+5r5Cm+Gw6MQ1oePLyKI+6Hi+3MuOHEHYbdeE/ZEP1
 0MyuUF590iFQy+o1gcu4zflJkhIx+9qKsL4vNCuyh3xpb+ETH/HJ4kKlcrSPhGenTGTU2FcMtUC
 CmnMy0Ief9BPHIIcn3LELQxfs8RvXkvYyde9dvl8panyISocF08ljbz3DELKzVCrNvw/draaWoj
 2OVygn+pk6HYsV6gYi+3/BKkKMztnDK1eapmqq75/5iuwi60XpuGeGN5OgT/DfmjOeLUx7q+prF
 evyp1Fzjgcbxh0HkoJEWO+oqojDUlv5Fx1bSU04WfxPGvVC0rH2AtmADClNnuAeY8nsmmVY+bra
 X1pjzo484QnWqxKqz7g==
X-Authority-Analysis: v=2.4 cv=T5+8ifKQ c=1 sm=1 tr=0 ts=6a4503f2 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=5RwxYKaxI1MLRJtyegQA:9 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: TYI1neCIJHWe5Un13fjdGobvyhETG8w8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010128
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

riscv-iommu spec 1.0 says:

"When checking the U bit in a second-stage PTE, the transaction
 is treated as not requesting supervisor privilege."

We need to *always* fault in case we're on G_STAGE and PTE_U is cleared
since we can't be on supervisor mode at this point.

Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3555
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/riscv-iommu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 3b165348ca..29eec3133e 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -494,6 +494,16 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
             break;                /* Access bit not set */
         } else if ((iotlb->perm & IOMMU_WO) && !ade && !(pte & PTE_D)) {
             break;                /* Dirty bit not set */
+        } else if (pass == G_STAGE && !(pte & PTE_U)) {
+            /*
+             * riscv-iommu spec 1.0: "When checking the U bit in a
+             * second-stage PTE, the transaction is treated as
+             * not requesting supervisor privilege."
+             *
+             * I.e. we need to fault if this is a non-user PTE since
+             * we are always in user mode at this point.
+             */
+            break;
         } else {
             /* Leaf PTE, translation completed. */
             sc[pass].step = sc[pass].levels;
-- 
2.43.0


