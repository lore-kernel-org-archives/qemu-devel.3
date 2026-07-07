Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 429EBC43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:17:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5f5-0005W1-DU; Tue, 07 Jul 2026 09:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5ei-0005Fk-4O
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:16:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5eg-0000wB-6U
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:16:07 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C8ehL3606093
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 13:16:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 L5iGxJpWkehMFRdcjXK/AAdRu/vNygtX8WRGqS3RUso=; b=ioEJL2r0GtqUA1RN
 iXUrxSYV6yJ+dnyhnJWpNKFiHQ/ILCnMYUqVUmghrFMCnXia7eFDaA+NiafEpM1W
 D7gn+u407e2pVY3pcevCJXL7su1mce9HPeWZhpkRww1e986ksUIpNTCwML1OlQ/p
 o+su6dAY0jLv3AegZtzN7FMSVzNpBhj6hXo0Hfdo7v0YFSUHh1ewJqGxmWxIYeQ4
 6Zq0dt7isqPbFIIaPZM9gQ7Z2rycs9bhdhDH0iNKClJJmUugxKcnuL0wVqzIGtGo
 VB9gBZtE2R315rTb7EzJrx79pLe9fhODgcH4fCB9hb3zHqK78fK3f1J+Rym9wxrX
 v0jtPA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8sm8j4sn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:16:04 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51a87ef9713so6729511cf.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783430164; x=1784034964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=L5iGxJpWkehMFRdcjXK/AAdRu/vNygtX8WRGqS3RUso=;
 b=K5pyqom1SSqQSqzYv1qqJdQXur8XIcThq+fhjF29RJJfTqcaImAbXTSSrC80SO5qaA
 FXupiQBFzH/U7HFv13VAEGeqxSweZ+/bSybMFo4BbUrDX3s2aZc+G1QQzcLW5wx89SvE
 x2yAPgSAHiRqDPtrUXw647kyITFT5+DtVeGsDmgQFwJJRuoTmIuhHCn6PF79R0pUI8IT
 5P5j3pkY1A/IPxM48TjWiQ8awDduVuMCiwaG28rJwKkRg7Tt/OFlFPWXeIhWlZkVAFRK
 OvNn36e5CQ4UC7FYHU2o4t8tFNumOlQL+8cciJhAbAswGI8SLMGAHat0FAvCzsq2jBrF
 6big==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783430164; x=1784034964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=L5iGxJpWkehMFRdcjXK/AAdRu/vNygtX8WRGqS3RUso=;
 b=CiU7Tm/odlopgAW+gD0W/YCZu8PO7DjDrLRjWwwd3Ky2FKDhxm5d48gpqgTBLWukW4
 LDN3/ydLCGzMBTD4hycmTWW6+PiOe0iqVIQAFDtCB2MsWJqINMj1UbnqwaqgnUHd63mj
 uVYbxJRAhmiCZb67sLcIVmp1qb2vvwRdcSjZYuZYO1+usPJSEcKll6dDRvC1OUUp9C3x
 qTl8CJzC5OqcXNiNdqgLRqakQZDDQ5Uj8UcjIKrRdZMRfhkZpCqbQYqy7rc46YM00SMW
 a7n+7ntAVtahQ5Q5lTxQrPhEk2ZJbDQaN/5WE/TPEgOqsIxzKTnSoJhcO3s5vAJIXE5Y
 QUdg==
X-Gm-Message-State: AOJu0Yymj8LVCR1viCObOp1f+SOibHGHmofJt8j8gnMYprxU1VPI/KE0
 78Q3WJuUPMSn8DeptSn7ZYnu0vbN3yX+mDtq7Wn5n1tmYBKexZ9QD2Wgg1U4fSSMnL314mBZgPi
 cBwVDM2i1MtsNnf3szxstrODc7godMOao7/KCuTR/mjcQon1KV8TGUWMhzcbHDdXzXg==
X-Gm-Gg: AfdE7clLxE9p9cw5tajcE4LkM2nPkf7/pBS1zbj//w3kLW/J4vRjC3N2gNddpPjlFZF
 m3l9zXCAkSun0yKJEi9mBSruCnn2ry/IGGpYEJyddpmmuuscjuTFd15SHl9xElpUdr/fNqkf0h3
 dpSMMQR2Nqy2Dg1qqM9zx28TTEYlD87Y3EmmbtuIGKx4d3MkwjjYWqGaA+vWEckdJeVr0BBzvZr
 5PiWQQFcQn5XQkcb7w6cAFjOTQYTNbE1qgHciDR+ggBbAhCDABeXK1DlewQ5V+Ut1uBWpd+loun
 +ag96HGSBmU79IM4TJE4zGmNs2tbYNrESl2x6eTws5/Pf87wWPj7nx0WNKH/lhutRuKel05N2P0
 5/f6RvtyctQWOlS/xoalpsdxrjyIL80wiy1qOjpH0zq0lRP7+piwiy0+TUinorcLI3+Og
X-Received: by 2002:a05:622a:1787:b0:51b:fad7:98eb with SMTP id
 d75a77b69052e-51c7a78543bmr23592391cf.34.1783430163753; 
 Tue, 07 Jul 2026 06:16:03 -0700 (PDT)
X-Received: by 2002:a05:622a:1787:b0:51b:fad7:98eb with SMTP id
 d75a77b69052e-51c7a78543bmr23591851cf.34.1783430163100; 
 Tue, 07 Jul 2026 06:16:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15bb94c782sm41694066b.40.2026.07.07.06.16.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 06:16:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 30/32] hw/ssi: aspeed_smc: Fix direct-read dummy bytes
Date: Tue,  7 Jul 2026 15:12:20 +0200
Message-ID: <20260707131223.51505-31-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707131223.51505-1-philmd@oss.qualcomm.com>
References: <20260707131223.51505-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX4UfGevrbgUdP
 l2k1cuDEEcD9QRINup0faOMi1YyVvF5ac2+1u0Jsv9i3PmpD1J3NrwEMV+SA1b3iGtFjr5/GPfW
 vaBGyQ9rIsVFHDhh+fUiN4hI38AFo1c+71MF5qHQzC1rljt/48WvdfLDO8VH8QvSMYvbk1vMDvg
 gSIUA5Jku8CwIg0qYLkP/iodhKyyV6UovNvfArTwig0gHjaqXtqjfeZQBZ6xQXWnOFB1HXw0IeG
 +BiCavU00W30BiZE5LD7IUnJ1D3IiR700ySITPzBsN3NP85mt8UcgucakHAABMg7XWYTkRBFWVp
 whHBp4fp5fIEpSmvxacCa0KSUqJjrQB5m/iJj9dI6XL7NmrtWxjWvq2/vE8rzHsmIdhqb35qdqU
 UlTdlDSGYWiPcV/nzXoWEx5+BxcFVDHIBCRckeiTmSeYmFXsRrRzyMn3acUhDwegV6iRmGMxFq1
 u3MTdqwyhuBVwegzPtQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfXxw9AyiBPgW+C
 mj7E76C5bGnRIP6rtiZWkUmNAtGwsKpy1JHoLtbfGshuPwsglkyoNORxkJzjOQF1xWJTdorfQev
 oqQ7nornxnVdubF2fRPCgm+UqjVOEv8=
X-Proofpoint-GUID: _qtvjfmrIyGUWWEfh2-5sXkeqZ_4ARkl
X-Authority-Analysis: v=2.4 cv=UvdT8ewB c=1 sm=1 tr=0 ts=6a4cfc14 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=FRSEYCzRAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=x7vYM3qzamLLx-kl34MA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-ORIG-GUID: _qtvjfmrIyGUWWEfh2-5sXkeqZ_4ARkl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070129
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

From: Bin Meng <bin.meng@processmission.com>

m25p80 now consumes fast-read dummy phases as byte counts. The
ASPEED SMC direct-read path still treated the CEx dummy field as
raw cycles and emitted field * 8 SSI transfers. Convert the
ASPEED dummy field to SSI byte transfers using the selected
direct-read data width.

Fixes: ac2810defa9d ("aspeed/smc: handle dummy bytes when doing fast reads in command mode")
Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Message-ID: <20260707083431.219671-8-bin.meng@processmission.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/ssi/aspeed_smc.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index d87fbd798c6..3f957d153f8 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -449,19 +449,28 @@ static uint32_t aspeed_smc_check_segment_addr(const AspeedSMCFlash *fl,
     return addr;
 }
 
-static int aspeed_smc_flash_dummies(const AspeedSMCFlash *fl)
+static int aspeed_smc_flash_dummy_bytes(const AspeedSMCFlash *fl)
 {
     const AspeedSMCState *s = fl->controller;
     uint32_t r_ctrl0 = s->regs[s->r_ctrl0 + fl->cs];
     uint32_t dummy_high = (r_ctrl0 >> CTRL_DUMMY_HIGH_SHIFT) & 0x1;
     uint32_t dummy_low = (r_ctrl0 >> CTRL_DUMMY_LOW_SHIFT) & 0x3;
-    uint32_t dummies = ((dummy_high << 2) | dummy_low) * 8;
+    uint32_t dummy_bytes = (dummy_high << 2) | dummy_low;
 
-    if (r_ctrl0 & CTRL_IO_DUAL_ADDR_DATA) {
-        dummies /= 2;
+    /*
+     * Scale the controller dummy field to SSI byte transfers using the
+     * direct-read dummy/address bus width.
+     */
+    if ((r_ctrl0 & CTRL_IO_QPI) ||
+        ((r_ctrl0 & CTRL_IO_QUAD_DATA) &&
+         (r_ctrl0 & CTRL_IO_QUAD_ADDR_DATA))) {
+        dummy_bytes *= 4;
+    } else if ((r_ctrl0 & CTRL_IO_DUAL_DATA) &&
+               (r_ctrl0 & CTRL_IO_DUAL_ADDR_DATA)) {
+        dummy_bytes *= 2;
     }
 
-    return dummies;
+    return dummy_bytes;
 }
 
 static void aspeed_smc_flash_setup(AspeedSMCFlash *fl, uint32_t addr)
@@ -487,7 +496,7 @@ static void aspeed_smc_flash_setup(AspeedSMCFlash *fl, uint32_t addr)
      * settings, let's check for fast read mode.
      */
     if (aspeed_smc_flash_mode(fl) == CTRL_FREADMODE) {
-        for (i = 0; i < aspeed_smc_flash_dummies(fl); i++) {
+        for (i = 0; i < aspeed_smc_flash_dummy_bytes(fl); i++) {
             ssi_transfer(fl->controller->spi, s->regs[R_DUMMY_DATA] & 0xff);
         }
     }
-- 
2.53.0


