Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF64C43602
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 20:37:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfO99-0003fu-JL; Thu, 02 Jul 2026 16:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfO97-0003ek-GH
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 16:36:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfO95-0006ie-R8
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 16:36:29 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662Iv1mG1397141
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 20:36:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=SDJ5ZGZZQpu
 KupBl2glwWLAU4IdTUnw9vBZa7wGQp0Q=; b=MpjIKrm61OkTRaqDVP6iBC30hvN
 v9Y/gA1q24tlRJXUNkliqHBtDh35kzaRRLoPKJ6XCeCDzGTfR2y/o/vCcCO2fEAR
 xrX5o84CvZAMzLz0HxS0lD3Ax4o/5fmilh9Q7lySnApdEP9a60jTRN1wj2Oqsp3/
 9FgzXZPXIFzsaTUhbFfSxrq/Ox0hMEJXVlX/rXqr4MqFAa1ALzIA2tKOl+y/YlF0
 4rqW4eADBFrDxeubVo0HKUEF79kU9yX7wyXUzrTIecAZH3uTUlg+Atsf17cmnwGO
 kGKN++NuN3DeuPXuldJoQ6nVaTSRFD2SDerurXSNDzfDzvBDW17EVNsfiZA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5mvwtvna-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 20:36:26 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e61b38eddso417268685a.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783024585; x=1783629385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SDJ5ZGZZQpuKupBl2glwWLAU4IdTUnw9vBZa7wGQp0Q=;
 b=WYganqEBKKw88wjTm7QraaLHZR8qEPQYZwYBBrCiXFDp9AX1gF0BGsh6JULTVhvCtT
 FsJ0Ad4xlxd6c4v9z3BtptMy6MbfsnKhIXb6me3+w2aVNA/ABl2DM2pu7BIV//jJDAEn
 NkUA/pbU+dpiHHaR08kDRCY1aB/iSaPMxfcGDNcGhSRcOdmMyMIORnQHzs3v1jW+Eocc
 BiBmAuN4KPOZlnnlZYsOTxJBoHEcVd7dcwy8uzSMJ2A3ACL1zp914ocv89CvMZJVy8qs
 ElbBJ0nzHnsK5vIkuoTWTPa3FmFHLudItIIfNaxxTViamIwRrFIBiAh2oAnd29ZHLAWr
 ErRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783024585; x=1783629385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SDJ5ZGZZQpuKupBl2glwWLAU4IdTUnw9vBZa7wGQp0Q=;
 b=f4SLD/lx34KAEx2a25VaPJLZ6fDS3BybyREHxq+wluA3TlhuhoZbSUv7xpmUfAEPkN
 zN+jtkljvxCMdhdF9CRLN1Eexv67WS1eg2q0bVxBdzvPoEa1mw7Tt7336Dwsa5pRzfmK
 m5pB0nireZMCRJoI7IpI4gky+S17e7SLOCglpEWcWmd20iyzPUsnbK+O7h31V9yOIURJ
 JSwf5BG9AhtevE0lUk4JFw+R4SR+/Ca6p7jQ8IKZECvrpObbn+mRZF63a/BY8saj1qmI
 xd8xGo+o7rGQ80d/BHYg+m/8LGqVpOfF8W5EN/uFTd6MH0DGaWTLOuXqAAixEJLe6J+Z
 XhwA==
X-Gm-Message-State: AOJu0Yzhyzlsw4tq6KUVBDYuCesUa89q5zmgzcuP66h7W6C0BGa1GQhG
 kFOyGL+KQjjAJqlDFbo3UAvjDTWloccBk69i2739MQkHMiDBpDUwfNMGn1TpP3nS4jZf9LG2Uic
 O3ClWjWrxgeYNrdoMYbmFKwxETuMXrRBDye/i3DZTGlER2GBtSaGnomHvBFje2NvU0A==
X-Gm-Gg: AfdE7ck4GLsbLFndVytiVJ07hbDJXvGBLvMtGAJFv1Uk24h7mP0+p9C2rS/pzLiy0U8
 PDxWuUOskTp61mzxZybTg+IHG8hd/mF3UjLSORNWVpGI7ojmaCWGSg0yzwSXmH52oWWNO2wSCql
 l2YB5O1lgGqbR4weJTY33enPSUSV8pK4y3oRNqp9IEQmQhv9Xd6ycpuX6l4tA73yPrYOHvuOnyO
 o3fQArig3w+ZbZF73m8z6jKN2y+WHkDW4ufw3I1T/JPR37HhXbfSYCy0P8qLKcTikeiD7IUSFWO
 0kzHFEbEgj/Kw1FX1H1Ju2YwcJqLdF3dBILXix3MAVDKsaTj3dlu/y1mQd/HKX4ANwbwbypmjd6
 IbUsJH+95/j+OCEmqi14yrzL5YEPscuFrZa56VjtN+Vshgw==
X-Received: by 2002:a05:620a:7083:b0:92b:7370:2ddb with SMTP id
 af79cd13be357-92e784d0d2dmr1026479785a.38.1783024585279; 
 Thu, 02 Jul 2026 13:36:25 -0700 (PDT)
X-Received: by 2002:a05:620a:7083:b0:92b:7370:2ddb with SMTP id
 af79cd13be357-92e784d0d2dmr1026477685a.38.1783024584862; 
 Thu, 02 Jul 2026 13:36:24 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92e801bbd5bsm309347085a.44.2026.07.02.13.36.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 13:36:24 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 nutty.liu@hotmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v2 1/1] hw/riscv/riscv-iommu.c: check for misaligned
 IOHGATP_PPN
Date: Thu,  2 Jul 2026 17:36:16 -0300
Message-ID: <20260702203616.1795588-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702203616.1795588-1-daniel.barboza@oss.qualcomm.com>
References: <20260702203616.1795588-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _y8PfBuR2Ebg0_Y6-V_gRQEobqJpsETs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDIxNSBTYWx0ZWRfX974siqg41T1D
 hS0Ub+q8kWa85Dz9BDMp0393SCK7U0x1SQIzSvIRarLWga2sd8Mfjzo8LR/ofWHy6Xs3DNz8Kmf
 U6R/3tmStjOJp7xhA0r0w0uZU0URrtJ6hkpubWDKBFSfiwdZChffesMe7Cm5bvW8pdb6eK9V1Z3
 sGoOa26KtDb5ZvdjqHuKtO7GoQISTMXT6lAPBpzevM/R8whrH1z2Iq+uU6Yg05QsSK8ljcJWqr5
 kFGARrnOwSd24ItygKcOjUi5pq0cv+lU1/o8tI/yRk5etK/v6KHKLm8x3bXnVz3PXOGW68E+WpD
 thDrM+XR5QT2GKjpe1vqYK0C3Dzu12hlQurgqAsT7E/SiAnGPuFvgFMWhQyAF6AetwtAHlfUpNG
 ywGxqEvEkMZ4X+pY19A7axhTbZ8GdRjR7FIVu0qeP3k0CF50GDT8bFZmgHP8HXWOglxTa7YBObB
 TbSMCv3BH2EPP4Uo7aQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDIxNSBTYWx0ZWRfX1Z2cJgUWXo3d
 q2042efm9OTJ8ts+8CDuy0d6+FeQdQGFHjBj4urlDSokI2kZ0fEfLAVgj61KEhtWeNJJfoOTx8o
 fqLBet8fGknUWVa2x4MEnphX3m5LiQI=
X-Authority-Analysis: v=2.4 cv=N+UZ0W9B c=1 sm=1 tr=0 ts=6a46cbca cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=OFnKmOOrP17mNN9m7kIA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: _y8PfBuR2Ebg0_Y6-V_gRQEobqJpsETs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020215
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

We must check if IOHGATP_PPN is 16kb aligned for non-bare GATP modes.

Fixes: 69a9ae4836 ("hw/riscv/riscv-iommu: add ATS support")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3550
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/riscv-iommu.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 974042d017..ad8e108a23 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -813,6 +813,21 @@ static bool riscv_iommu_validate_device_ctx(RISCVIOMMUState *s,
         return false;
     }
 
+    if (gatp != RISCV_IOMMU_DC_IOHGATP_MODE_BARE) {
+        uint64_t iohgatp_ppn = get_field(ctx->gatp,
+                                         RISCV_IOMMU_DC_IOHGATP_PPN);
+
+        /*
+         * One of the conditions for a misconfigured DDT entry
+         * according to the riscv-spec: "DC.iohgatp.MODE is not
+         * Bare and the root page table (address) determined by
+         * DC.iohgatp.PPN is not aligned to a 16-KiB boundary."
+         */
+        if (PPN_PHYS(iohgatp_ppn) & ((1ULL << 14) - 1)) {
+            return false;
+        }
+    }
+
     fsc_mode = get_field(ctx->satp, RISCV_IOMMU_DC_FSC_MODE);
 
     if (ctx->tc & RISCV_IOMMU_DC_TC_PDTV) {
-- 
2.43.0


