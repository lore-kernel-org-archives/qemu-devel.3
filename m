Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4AE6C43602
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 17:12:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfKxY-0000tR-By; Thu, 02 Jul 2026 13:12:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfKxR-0000mz-Ng
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 13:12:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfKxO-0002qp-ND
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 13:12:13 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662E3gNR560655
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 17:12:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=OiKCLdfsyg9WtOLsO+xWUlwobzjgWUuWLDt
 6lZlyWQY=; b=EHJiiUDwfVrQ1ArmNIOge/TKuY/0M8ofONWy5cvrbmYIAci+FHT
 0haEmPq2Kuv/HEWZWWn7FHQeL2xlKRHb1IvYhUQSK4dlIjb2GRvpvEiiFx9pkXUL
 j3tzxVgEZbihOtxIKDHwrws4inJz6jXuSqd6EkxuGfQaFHNlf752mTefUtbvC562
 rFKNod+JBdv9WevkcQIpLQ9cMZyEvlRRh48FubfwbiIg4NPJv1tzVQC44kUeSid4
 jz/w4bB4RlGJJH1yy354Dm0FKdcUgbpr/E7YuxeH0ZTj50dw6sJOmRt+AnfH65mX
 DKxxDAt0zhiOfUZdlOSRwibRpQuuRLnufoQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5n9bj207-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 17:12:08 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51bff5c7035so37631471cf.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 10:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783012328; x=1783617128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OiKCLdfsyg9WtOLsO+xWUlwobzjgWUuWLDt6lZlyWQY=;
 b=Og2gewJr73Djk8TxT/wGHUCCqN6Djx4np/LXsIsXJkt0c6AOazD40N1BpdCEld8yQS
 sA071Mnln4ENX9cKz/IJzTUfiwBB8baPkwKS/ci2sZz/5flZnrxABvogaTcHyciySg4H
 k+9Q95isU2jXoTxeyCe2GPU+PyE43WAXevZtbBoXJDRVMOegBirfuM7gABhzBV5FOK5l
 NDVRfDz3a/9d/yuFS9JE2DNPvxlXxabJeEysge6LOzFqSBkiglBYzC7yiUjd4iXlOcVa
 SZdUCBzE9Z2mNPgnfeN3zT1Yv970aX7K2+m2B+PSHRMEGWs8iQZHBS4C942pkjhaMyZb
 smDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783012328; x=1783617128;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OiKCLdfsyg9WtOLsO+xWUlwobzjgWUuWLDt6lZlyWQY=;
 b=HivL+ygv2UO+Nfu+76jylNfcsPPyBPw25aKoRrkiytwplVYfLHbxXov/b6X4wAmB7a
 PzJQR08vLfFYfpoYeXAF+XTE6txLsShWOR4n6UAsxDh9SnLyxYoquE2oQHiaQ90p0vUq
 YP/4lAoiqETTvhnSdy+DrDZUygqP/p3goRx0GfAgJW0gu3T9eHLoZIS6V45YE23ci+KS
 O8XnNwKdo5rYFrHUEIBk8Ql9P32i8PFxyZt7nzbwRUR2+OnrZZDX8p3S2EiqE6Vo87Yk
 M7LGgUK48Ad0WC6r+4jnN/ssnNT5TT9mOmVFIcHDk1D98gFT1EZBKpfD9lXCP/Z1/33y
 FDDA==
X-Gm-Message-State: AOJu0YxV9lqo3U01Flybgh0ILKS5x0DR1Wi8SBEHml9BthSoiY3DMWTy
 lyOaanrkCKT/LHu8u6lYK5ER+pTWFRXk1mjJKT7awZgi9Xmj7KCsx7YT4A/Ii+1bX+CetjNzKiY
 EEXF+t/cjPWmQDKLdYoAy8r0W+JLWEyKg+PuKKGsF5tqan2pW92KR3mq76PgALiH7xA==
X-Gm-Gg: AfdE7clNFZo042mc8V47WVUZQxiDUswBJ4dngWK2r9yIlaRNIUfsc+QSe80IoDqBC4v
 pkEfumUk7BhtjIxRrEsfmCiBU+T2YQXuhpcdVTBA6YZ0olPlRouIe2deiWtHKLKwIiEmqVoGqBo
 4U4fV312lTjsQydqxFlTX434WRVd9yuNKlevW0whH09uf8Keyj8FaIymJLVx3SqFO4ZnzHTmnUU
 x9emZK02tVrbfOOwjfX8yIVFojMXGtOF2Rw9GluuH+SCK1z51LdQkwJ6NjzEuU9sg/jaB5EoAAk
 ZHiaAWsDyfgYU4N5sZaiEjkqzOSu3eQp0vg8QJLVQ3s3hQAWin6/E+c9rb2OU6XOPE0V6N9dGZx
 lkLz902Fg57epx9/ZMCSZv8KIoGeIoTsCQyVYdXnmOsmmHQ==
X-Received: by 2002:ac8:5a50:0:b0:519:f02b:45cb with SMTP id
 d75a77b69052e-51c26a7a3bemr94016171cf.26.1783012327496; 
 Thu, 02 Jul 2026 10:12:07 -0700 (PDT)
X-Received: by 2002:ac8:5a50:0:b0:519:f02b:45cb with SMTP id
 d75a77b69052e-51c26a7a3bemr94015411cf.26.1783012326877; 
 Thu, 02 Jul 2026 10:12:06 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c30c1582esm18338491cf.16.2026.07.02.10.12.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 10:12:06 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH] hw/riscv/riscv-iommu.c: update ioval2 when faulting in
 spa_fetch()
Date: Thu,  2 Jul 2026 14:12:02 -0300
Message-ID: <20260702171202.1322493-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ZA-B-WcZDkS4tvDS13pDM0AZ9zOJHb64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE4MCBTYWx0ZWRfX89K4n2jwBh19
 ot3dCZJmtVUy9tcpMlg/yLFWTtpamzXbipekyLa2lB3DyvkVGwl2GoMwWHItQ+20z8bV8dbQhLr
 Ual/lDfyHB9NsJQEDfAOqgmU/CBMnH4=
X-Proofpoint-GUID: ZA-B-WcZDkS4tvDS13pDM0AZ9zOJHb64
X-Authority-Analysis: v=2.4 cv=bOom5v+Z c=1 sm=1 tr=0 ts=6a469be8 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=brxubhDnoS8KGqh5eZoA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE4MCBTYWx0ZWRfX48rMfF/QeFJA
 rIpAbH1PqlICH32Na2zGTj3rYU2KUwBC6WkJDRcvfakim3e6koze21x3LGFzjTz+LuwBZ9QMHQp
 eIgVphKXBzScn965d1kqMMcLRA2aR+E1yuoOZb3sd4UEc328DkfMMqHcKPG66QftCyqRiNhmujr
 ZecgVNEOvm3CGytzkdME5X39nnVI2I3bO8bBFp7JUvdkWX6joAWhLdbAwfTrO/Gu1uXufsEdGXk
 V87TGxCecClQuHN1Egiub++J3ArFzN8Qck4PBc+xO+HKbpCeig3GAsqsk7v3gbqeHFdTEaSbiT0
 Vdww9AmI/FwJmEPQus/lMagwbUvv23v+KnWssqsLfNVrVH1RFM4Ah3WI9UgZcirtAH3PhkgrZoM
 z3oURDqdfW/Ovwicg4pAFd7YBvCAhfnYM4r0sjcHJno9DxiJBqTvUbd6pNl4vID+B4gZMf3yNl6
 8Zu+Bu5v3XJ7qzpIQLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 suspectscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020180
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

riscv_iommu_translate(), the only caller of riscv_iommu_spa_fetch(),
will use riscv_iommu_report_fault() for all faults it detects.  And it
will use iotlb->translated_addr as 'iotval2' every time.

At this moment we're updating iotlb->translated_addr only after a
translation step is completed, meaning any fault that occur before that
will have a zeroed iotlb->translated_addr, and as a result iotval2 will
also be zero later on.

Keep iotlb->translated_addr updated with the latest translated addr we
have.

Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3559
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/riscv-iommu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 974042d017..6761b77f95 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -546,6 +546,14 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
         }
     } while (1);
 
+    /*
+     * riscv_iommu_translate() will receive a fault and then call
+     * riscv_iommu_report_fault() using iotlb->translated_addr
+     * as iotval2.  Update translated_addr it with the latest
+     * translated addr we have.
+     */
+    iotlb->translated_addr = addr;
+
     return (iotlb->perm & IOMMU_WO) ?
                 (pass ? RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS :
                         RISCV_IOMMU_FQ_CAUSE_WR_FAULT_S) :
-- 
2.43.0


