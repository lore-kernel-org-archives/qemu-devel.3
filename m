Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E9AC43602
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:14:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAsI-0002Mt-JB; Mon, 29 Jun 2026 08:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1weAs6-00023W-NK
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:13:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1weAs0-0005Kf-E5
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:13:51 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATR1l2605192
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 12:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=EkJTtkmEV4v
 c01IaRV9V7AP44PqbMhXkWKQN8F0CzFA=; b=eQea9ARU7tLV52Zd1C5HLNOljGO
 9MbqRHogK2OzeAH7RRfTr+UlgzJ4teGH9OMInyBeVMiiY94w3MYP6CutE+PNMS+y
 ZS1nDyQtxGVM9E+qlm+XRjFBAw495wMBk5QfREbzildgj5iaT4TIvTBm/kPxKZlg
 lULq7mKOfKZrN2+V+PLRopBPUFpWlvoSs44Pt0TuIkKgM9n8PPDhk05HMxwIh952
 be+zLOfFgwjUOMWoIhE5v+ldubRqOpL7FxLqWKl9F1bWysvrPBsLtPwX8aysklZH
 S/NLKSmQjD9+0CgLoCZX386t2jphP7PZZOBE+qcEDpEIkuFpSiC0W5kjV3A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nq88q1w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 12:13:44 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-37c9127e316so2193253a91.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782735224; x=1783340024; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EkJTtkmEV4vc01IaRV9V7AP44PqbMhXkWKQN8F0CzFA=;
 b=IkFW27JsAi5rslHqIvLf9iH86eRLdBF69wPjZyeBmFZmtoGpUC5vmlrkJ5jFDZne/g
 lTNzdSYWeXEL5c34pLEq469zLJyaZRem8a4zUBROh2xN+SKYbyhfi6c4pP0/fgwpcp2F
 G4YNRuIJSZAb+ylNyAicplLBKuNptfF2m9V8qbtOVcXYCm1+ZcFHco07UTvGk7RLF32W
 UknpXyBDH3SDRSlmhMSyD9sklu9480QLjgJ5nOMcylRDW93mXjeS3e1H8mXeqJxTcKNX
 j8Y5i04kSs98KOSy6irVfWbvtYBhyso1ZdRUxaJdzE0g710vD2bsSGYn/ulXCXU+jHLG
 Y1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782735224; x=1783340024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EkJTtkmEV4vc01IaRV9V7AP44PqbMhXkWKQN8F0CzFA=;
 b=StJ2X2Q3EuzXNWeOI/68AO+XjGRDPE8ruy6UuvL9mkDnDrgSAZk4RJkjrSa0PjS1RN
 cBO3sckCFYZFo4OweOufpydhliTQAMNs96d38mUIZ3pAaeAs761OYU/e8K2/xoDKhHuo
 POIp5ZjhzH/zW1LC7mQeHUww16SB4OGHn2gbTHUknCyOq4gh1HjclRPCW2svDpcDZiQX
 BZB+ceDhVIQ7mJ7uifxO7QISbGF6jXs8f7mXrS0/TE49h5i1JuvUfGpayMZPigye2tl7
 iXBuL+LR98/N7vgK6ixTIjUnPOUVPgTDRMzwiZ3Sfvs9pzzt7VYTRephf4sRwbtfD+nz
 RRKQ==
X-Gm-Message-State: AOJu0Yx0e5sMbFvyqcOci2PcsOF/ENQVq6iIE4uwxCHZZWV2TvtW6rQ9
 A/w5Ew84URNTSeR0MBuDIAlNaqb4Fz07n4qc8df1tocJYb/v39fFzfcMfWLkPHxT/xsypXP0ZjJ
 v3W18YVaYeDdZOUSgxQFVGa+EthoIkMqqi2QMB5sM8RnDiVS9BIySfEPRiHwQZZNC1w==
X-Gm-Gg: AfdE7cn2LsZfcQvSmQX63r9M+IJi/VLhwGGIGEeSNqON/LCeY9kAGuQ17W1ErDvGbjV
 uvTxB3N9C3wGSfErpqKy2U5OL3XYC/JABr+LH0yc4FGfj97klSwzFsev9q8ZoZ2vPy5NUYcZDja
 QDzXqcxgetKeE7i/ujvVRq7N04Kko/eZQ6KRshDAQbLt9y6Wsa/G+Nl1u1ATnkDAiwwzORTLF61
 Y+mG2/SV8jYsDWd4MuPSY/Q7EZxcAUxX2a44xC3Fdm2ZmrHZWNsVjCFQy/jxwLrbu9BHKpsetXL
 o7GCeVF7EtFTjVDNnat0prCJkF2P/NiTVeunqNa9t8jAtCDskypZ2bjiJmDpfb3epvivhNuPhXq
 4huYyMTWOHSNFpRg5xxJnYaAM7HKfKTgAvTupLOn2ide/VA==
X-Received: by 2002:a17:90b:52c7:b0:37f:eda5:5169 with SMTP id
 98e67ed59e1d1-37feda55454mr4418566a91.13.1782735223897; 
 Mon, 29 Jun 2026 05:13:43 -0700 (PDT)
X-Received: by 2002:a17:90b:52c7:b0:37f:eda5:5169 with SMTP id
 98e67ed59e1d1-37feda55454mr4418547a91.13.1782735223484; 
 Mon, 29 Jun 2026 05:13:43 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37e1c93272fsm5800179a91.14.2026.06.29.05.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:13:43 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 1/2] hw/riscv/riscv-iommu.c: check for reserved PTE bits
Date: Mon, 29 Jun 2026 09:13:33 -0300
Message-ID: <20260629121334.567587-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629121334.567587-1-daniel.barboza@oss.qualcomm.com>
References: <20260629121334.567587-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: XW2aczuHPN_opQKjes7pm1Lb8A9lP7sg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwMCBTYWx0ZWRfX1oBnv5z0eaZY
 GdGMZEG89T2ePs7IItOjza1x5CtI8kFcRK63UyD+R2za2Sdyj/bl6YCGCsdi454cwxaoZPGfuKW
 7ik5oXnN9PsLEXWUkzFCmFAHL/PoLUo=
X-Proofpoint-ORIG-GUID: XW2aczuHPN_opQKjes7pm1Lb8A9lP7sg
X-Authority-Analysis: v=2.4 cv=PqSjqQM3 c=1 sm=1 tr=0 ts=6a426178 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=qwidNiq27HggKHQKDkEA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwMCBTYWx0ZWRfX3EwRtCty1Qit
 OXaLTKiKqOhXw/0qyhtxWZK/OHsyuo/wUoRJYFutJpYTYFPmmBfAgzCxsPuLT7c84xZiNWPmQSt
 9Wm4sw0TzPVY+CtXOlVVAxx492XVwNMDbXvl+hd1wgM1j35KzoiDhciukBvVHHDVSnLs3dZbk4C
 nqtrkWzkejAxDcbyGDxQ14cYhI1QN29t7XW0dY2kuaJAgF+BFPw+OY2Feh44F2lylmQxG+QO5Ko
 9cMKx9hSwF//yP1JFPxFp4AwNFhmPxogbTIBSHbqh5J/GDXPkRdX115Co0jGVjXf+qDbrSJeeND
 UlNwElMnGmcYTuVnYt/sreZncznrjfE0KcSkK/+ZtRljKp5urgMyn4VbuC5MrTLaa/nKrkZH5lo
 8+k6jNx7NbIAoSEzOPTY/qEYWkbH8QwviaF6VWi0hVg6Y53psEbxhT/SjZVP+F0+DZbx+XE7/TN
 xBroc7ZjBAoz9tkQ1uA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290100
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

We need to fault if reserved PTE bits (60:54) are set.

Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3554
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/riscv-iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index c9687e01a8..453601d7a5 100644
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


