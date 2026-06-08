Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB22DCD8CA7
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 21:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWhBZ-0007ZL-Hq; Mon, 08 Jun 2026 17:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wWhBV-0007Yx-QM
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 17:07:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wWhBU-0006yC-1g
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 17:07:01 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 658Ix7pf314986
 for <qemu-devel@nongnu.org>; Mon, 8 Jun 2026 21:06:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=A8pFO5uKfkU+vxdf6kK+BSxIjx20O3kZkXx
 4dTPB1Ws=; b=Q2hkjvVp2DZ29suFnbPdw6EGUDsCX4VAwTfqzVoPfkM81RuMbiu
 lVqA+8pwuMPNFHktbv1+wlAmhcZJxH3E1flx7h9U9HY+c/lMAFDbFobiaZsluPJq
 c32FuUijksBbQr3zjjv/NWriOHT9CMo39+BN/UeVel6dS0Jv4wooVI9LYnyVPOMI
 wa3IG+NHmCvOAAyoMrwKBHPjMUKvpg9SVxdMqUQneLzcH0AeIm6l5Cn1Dsym1hNq
 vD0fTXFT5LJWU1s6pKKtJu4wZiGfAEtOMZsRpLTm1copqqu1oXrzm8Ox3qn1Q2WZ
 hAG++u5X0Kvs21O+dNMezcyX+HG8Eg9jrLg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4entr0k7mu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 21:06:53 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-304ed777a96so3077684eec.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 14:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780952812; x=1781557612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=A8pFO5uKfkU+vxdf6kK+BSxIjx20O3kZkXx4dTPB1Ws=;
 b=avNpkpeJPSqKMan6lOQUx1hm2vPPrY+tThldtpF93K7iFcLzfoW67DxBK2NS7VxYv2
 WU6rCpYZCIl3g2yRYHwSOaqMhBle4E5HB8BSU2XfHPg+8rnPazXeMxyDC8Jqd7bvrTnM
 yJUMUD+RU2YcILDW79sn4CKpoixPJGFnzE8NyxlVI3TvvlqL0xT7Y34eptHfMZR5oc22
 W5Nxz597+s5cnoxpbgj2LnrmUwNy5GEMh3P0Ni2PhDfrVuyzRPl7KOTgx0KO9IhA5yZ9
 DNyMlDQGaAbJ16QUK6ycq8yHrVLqqH9t+UzjoQGDUe2zWbqDd0Xr7e8kmqCXgF+EdCIH
 ro+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780952812; x=1781557612;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A8pFO5uKfkU+vxdf6kK+BSxIjx20O3kZkXx4dTPB1Ws=;
 b=SQOAWqYjjKHQxcWxcpe1dGlpLzCGF9FcC+9d0cJegyuk1Gy30VtNEfusjY9yTqVHNi
 a5mr+06tfPeRZzyya8kNrJfVvexpHurFa/jFPgnGinWzGTHczYFicjR91Lq1swBeO29P
 iKesqgeTGKCFIRA8IO23AB0K6FykCpZTDyKaoK2tmyd7wHB60JbCZI4rq5OFZfr3VKXL
 ADlQbXmjMLxKQazIsCrNFBeS4KNOYtc50L/Y71yHbQAX36Iwsk30exWb5btUSrFEHgXi
 wJ4k81RH4YhY2tJKBU7GXc3efNUfKDoB6QyrFbvxglnO8GA2LNk2hOYsYJnXyi98cSS8
 1eUw==
X-Gm-Message-State: AOJu0YxxQQlpj5CdKyxBbRR2HMMcutpCYS6lcHOKjKidf2BgwaC9TEkN
 rw8rGvs9eZ5kPWx5m5444FF6iSnVnKdB/bGmM+VltmdPGZeX2bOlEZNwNFCKYRY9sjEfVK81Y8h
 IO/F92HVn1paaKSe70EsDjAlJJBRUNGQgS4YKBkZlTU9Ona3gVY2OwK1QVUcliUFHyQ==
X-Gm-Gg: Acq92OGfEe8wenBs1u6eqQhJ6aICVGk8pOnqAuwLXeIEdjgE+Nw4Y1jZkLdCRSpi+RC
 bGNAXQGnTTodq6yQF2xA3WrSKzZcrJA1RyGvq6hEJUffQ341fAUSh0APlSl8k7/6VJNtXSY9dd8
 WViJOkPs8zi0Ou8Awwaqtc8dn7f5wHIYjXRqvsbEt3vHDOrVrnp/Evydibk6L1uYnsFGY4MYzW/
 XwCG3r1ZYvuC5Vfz4Pc26E1OVZxp35PoPiWmMhzwnPsoGHLKH5J3GExlnTJIWKcYpA2PqWwUg8m
 kkDq+CRyMx5UUDY9dSuOaJU05hdbwwkI8IVpqLwDx7BZoij6APOus/VeLc+Hekb7XfJcdBwpOCW
 PF01qphjRQLf0agbLpzc97fPlZ7TezSrBCzyBfQRq3HewgaNKEjFc5r9earwWw36OFgitdA==
X-Received: by 2002:a05:7022:113:b0:12c:9037:5126 with SMTP id
 a92af1059eb24-13807d36f7bmr6837195c88.9.1780952812308; 
 Mon, 08 Jun 2026 14:06:52 -0700 (PDT)
X-Received: by 2002:a05:7022:113:b0:12c:9037:5126 with SMTP id
 a92af1059eb24-13807d36f7bmr6837171c88.9.1780952811842; 
 Mon, 08 Jun 2026 14:06:51 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f5539432sm15822414c88.9.2026.06.08.14.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 14:06:51 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH] hw/riscv/virt.c: fix 'iommu-map' FDT entry
Date: Mon,  8 Jun 2026 18:06:42 -0300
Message-ID: <20260608210642.464131-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE5MSBTYWx0ZWRfX7OWE10iHnI9V
 UL0DDhgvjhg7EDwb35N8FNvctq7CvEeS9Qc2fG1YgNo1ZJj0V70r0TRZiWS9DtYYgfTRRCK3N+f
 X2ZGzOdN5y6xiJF9ztZm5m3Jy1zHHsEfQVQX+3JwG64uertrmF2/KzQCYITfMin2IO+hroEQkBE
 XeTHRewXbeZkNtOgbaaCpC3lbVxv84sEKh64m8QV979wN8SOXEFtjO/TRy1600evgJzhvba70HR
 pz2AKu8NKgT9Y2DZ1bf/LOr69S0AW67UQNpktgqS4yeR8e+adVkaZVuOjYv8y7mqvnpzx+ANJ+1
 O1bVFy6Q5LZqU1q5+P3bxw7PR5R2rkG3bf0wOHo8yDuy6MuffMF/sxk0reNrWEu3fiUnnK9Pbi7
 26ncTIPaK/yZY0A71AK+oflJZtkrWGtYx1dXFa8q6F00dj8HUrEUo9njGvKcZmMqZB8Sq0zDdvo
 G0/5JMuCK86s7Bg+5wQ==
X-Proofpoint-ORIG-GUID: Tm_sT_MnwD5TBl2vb6tRis93F6z1N2pr
X-Proofpoint-GUID: Tm_sT_MnwD5TBl2vb6tRis93F6z1N2pr
X-Authority-Analysis: v=2.4 cv=VowTxe2n c=1 sm=1 tr=0 ts=6a272eed cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=oNYACLWKlWMaaXUTyR8A:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_05,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080191
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

Based on the DT documentation of 'iommu-map':

https://www.kernel.org/doc/Documentation/devicetree/bindings/pci/pci-iommu.txt

- iommu-map: Maps a Requester ID to an IOMMU and associated IOMMU specifier
  data.

  The property is an arbitrary number of tuples of
  (rid-base,iommu,iommu-base,length).

----------

We're adding a no-op entry (length = 0) in iommu-map:

         qemu_fdt_setprop_cells(ms->fdt, name, "iommu-map",
                                0, iommu_sys_phandle, 0, 0, 0,
                                iommu_sys_phandle, 0, 0xffff);

This is easily seen in the generated DT:

iommu-map = <0x00 0x8000 0x00 0x00 0x00 0x8000 0x00 0xffff>;

The tuple (0 0 0x8000 0) does nothing since it has length = 0.  The
information we want to advertise is in the second tuple only.  Thus
remove the empty tuple.

While we're at it, seems like we've mistaken the API and we're using
0xffff as 'last address', but in fact it is length.  This means that
we're telling the DT we're mapping 0x0 -> 0xfffe, which wasn't our
intention.  Therefore change size to '0x10000' to reflect the address
mapping we want (0x0 -> 0xffff).

Found while reviewing the RISC-V Server Platform DT generation, which
happens to copy a lot of code from the 'virt' board, and this nit is
also present there.

Fixes: 2c12de1460 ("hw/riscv/virt: Add IOMMU as platform device if the option is set")
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/virt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index ce64eaaef7..0c489bb412 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -900,8 +900,7 @@ static void create_fdt_pcie(RISCVVirtState *s,
 
     if (virt_is_iommu_sys_enabled(s)) {
         qemu_fdt_setprop_cells(ms->fdt, name, "iommu-map",
-                               0, iommu_sys_phandle, 0, 0, 0,
-                               iommu_sys_phandle, 0, 0xffff);
+                               0, iommu_sys_phandle, 0, 0x10000);
     }
 
     create_pcie_irq_map(s, ms->fdt, name, irq_pcie_phandle);
-- 
2.43.0


