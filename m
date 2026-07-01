Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E402C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wetmq-0002OX-D6; Wed, 01 Jul 2026 08:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wetmp-0002Ko-1L
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 08:11:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wetmn-0002eQ-CW
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 08:11:26 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 661A8VL9744114
 for <qemu-devel@nongnu.org>; Wed, 1 Jul 2026 12:11:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=e/zTLleUm5t
 dJd/waMYjqqRc9jTaOdCiJwO+Zrw72nA=; b=S96aI0bU1Mgjq3haPCpinyZO+cD
 ChLtlXSQEkOLpWLezl+pCnUGQDIMgXj8Rb16z9ZEnHjs07mqjtX6LR6Q49bPWzar
 UryZ4NShiZ93bFnul9RTP89Zv7kfmXCalrftzjSDEE75t+Na1ffYXCXVicdwJWZT
 qFN2JxjpCl88pcqb7bEY6lurKWY8MGegznQEsXN6OCyldoKYAsBEoQYeozzLFujM
 4RJsPL4XzgzJ0wuW1XFX19qvk83leXA1MCnyt67IfB8H4t0vjdCdVBwku3Rltsix
 H6yL5c/1vx98jTaA5j2JOOCwiVIQNRR2nxv74Ikz4ZMMGKJ+nvmJ1kuE58Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4x0thd11-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 12:11:24 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51bff5c7035so11113511cf.2
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 05:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782907884; x=1783512684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e/zTLleUm5tdJd/waMYjqqRc9jTaOdCiJwO+Zrw72nA=;
 b=O0c9Jgd4upeuGMBn98ynBizZw/ViGZeJlTQCgHocEY7AdcLiJz8nMCfJd/SJ/d0Age
 Y0OgDJuV/g5c2VRTA450kdXBOPJH8CUH2g/+1y8k0umOvBvKMzMoAkr++E/Al/hn53iq
 kkTvNkzHxHruDXCKQfyzKsfzOQbEp5vedamGdrxbaeSeyabo5je3bjJZH77ucpgyAxqQ
 SRPuQAA4+CHMuzWySUixpek8NJP4CTKKB/aR+QOdO7YyQwNunFnvKroB4qWDe16/cywf
 OAPKFiSF4UCGlF2zDnPpx5jB4oYHq+1NAgAtFwyfk0w8i/OQxzUshlXfePdP28gP9rtA
 ncRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782907884; x=1783512684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e/zTLleUm5tdJd/waMYjqqRc9jTaOdCiJwO+Zrw72nA=;
 b=ig5/EIwdHINaxB2hXop04iZ3m7EqlPMYevPlZdCqilVH+dqZ8qhIEuxzLGAjtBTasT
 mNwzFEiPATZtFM46T08T/Fl5xm61nMmuE6B19F1ZsKSgEFZS/80eGWU2rfc2W0jCMavT
 wQjUFjQSbyZM/UIf89ARESIn714OaDFoicHTt2ewk+yB2/W4kSPYHkDUVx8nF3/0wSyr
 fs8mSCFWmwJ3NzWfb7T6nFowA0UAuuvAD9++VLfQAIzxf6Av/a+Irl+Dfqxg/zNJuYll
 QaHhMME0aWcr4XNQkKS9uYTOlA38UFFU2qUvuBidDnYjG35C8hOjW67XDjyv1h5cUOiX
 Zp4Q==
X-Gm-Message-State: AOJu0YxjflMy3DIK4mdRhyhytMCH97SyGMgEHmbHO6skpeKxaSghGGBi
 OoBFoed1AjamnyApI/wZvIzToL1zfA1VxWf8sD4TpWc5tbQjKtbq5R1wnGNNkckQHQXRHypnQRb
 BUGv87tEcqM7aTOwLZvvjoXbowsDRf9nbLrVOkD1EJ3Dh4ruZvwfn6ABx/+mSYjwj5w==
X-Gm-Gg: AfdE7cmnALA6ClPqtD0t523EXS7iNBgmfZzvi1S8QstuEHS9d81as/0qHssnfSh9Pl/
 Qfel+mp4/4+ccnx4gPjbhtLCduk5KOelczbegAGvd8dP2/WbVc4Q0metNlT9Mck5kzh7O+7e8eM
 GE7THEnYw9nhSZIClAyqMCzNjv1fPdT4eBAPxKkHWrMrQCcyRaL75fBVzkxVXmDduRkz0l5BDQJ
 70MBS84/vwYezBB/VN+c7/8ZLV8GFTNi518qIehB8Xiitia0frvmZBTW7wYcTEnjdndXCzAx9ZP
 NWUgn254VGjUdqXBCkqZMPeNK2ys0kOlSlH0c1Iimfj3dl9jHCgDbX3OK/7R5x886bnm93iKp4C
 bjnnvvuTjLWGVtKEGWOxsrNBG82CM9+nuz3UnM2MGp9Zf4w==
X-Received: by 2002:a05:622a:1194:b0:51b:eb55:2914 with SMTP id
 d75a77b69052e-51c26b00647mr15071021cf.33.1782907883668; 
 Wed, 01 Jul 2026 05:11:23 -0700 (PDT)
X-Received: by 2002:a05:622a:1194:b0:51b:eb55:2914 with SMTP id
 d75a77b69052e-51c26b00647mr15070321cf.33.1782907883034; 
 Wed, 01 Jul 2026 05:11:23 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f3611df020sm19794706d6.30.2026.07.01.05.11.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 05:11:21 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com, nutty.liu@hotmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v2 1/3] hw/riscv/riscv-iommu.c: check for reserved PTE bits
Date: Wed,  1 Jul 2026 09:11:09 -0300
Message-ID: <20260701121111.537654-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701121111.537654-1-daniel.barboza@oss.qualcomm.com>
References: <20260701121111.537654-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: dpHxtiM0kVzjqpwoz4koIe4-BVUg5e_H
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDEyOCBTYWx0ZWRfXxuOCmU7dUg12
 dMO3rJE3mrXMh647ZBOCjr1vfIEpyfeej34t4pSkkgo2zcJGCp0y1uU9Per4s6iCBh599iwPhKH
 PO/WqgcT8UMUUZqriqBdtMN+bijqOvo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDEyOCBTYWx0ZWRfX/UqPkSi4bJB2
 MQEIDpO27r0VFgOcVmQ/ZGzxjkSlghNGrmN5Frpd7rA9OoPOHbGxSUJ1Yf0oevWeJAM4zhrZ6Yf
 KtnO149b8w3XQ5idXe986wYsoLkY5dN+VwbD8dbF823IHoNoKaNBKQS1qL6I4xP65NeP8Sa+we2
 B34yFXf6jtUahQrFxtqn4jeWn5t6L2+vAoi8ksMSCa/9jd5uDVx1B+Iou6hDt027g7oeALCAT95
 u6G0k+vwE4rIWzuuHCdE5tjoa8l6/QSSZ0OwmlJZI4ZlPPLDIK55DvJQ0L4GR4cpblhCakinOT1
 bsq76x8XA/pIj36XOJZb5Y1Dv6gHGzz/EsT7Ry0T0wrxtddm/mN9SRhp1eo5zCWat8TUSulImpw
 8NP7IZrxs+/gz/SynRp3BE7dl7hmmg6Cl/e18ROGD+0HkTV+TjHjLgRFehSWT/QQKAye6b/9Zva
 COre00kQtQgoGb5zvSw==
X-Authority-Analysis: v=2.4 cv=T5+8ifKQ c=1 sm=1 tr=0 ts=6a4503ec cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=69EAbJreAAAA:8 a=pGLkceISAAAA:8 a=gKrNVKmnkRrTeqt_gscA:9
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: dpHxtiM0kVzjqpwoz4koIe4-BVUg5e_H
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

We need to fault if reserved PTE bits (60:54) are set.

Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3554
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 hw/riscv/riscv-iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 974042d017..2c2273e1d2 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -468,6 +468,8 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
 
         if (!(pte & PTE_V)) {
             break;                /* Invalid PTE */
+        } else if (pte & PTE_RESERVED(false)) {
+            break;                /* Reserved PTE bits set */
         } else if (!(pte & (PTE_R | PTE_W | PTE_X))) {
             base = PPN_PHYS(ppn); /* Inner PTE, continue walking */
         } else if ((pte & (PTE_R | PTE_W | PTE_X)) == PTE_W) {
-- 
2.43.0


