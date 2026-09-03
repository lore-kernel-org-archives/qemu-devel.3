Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B16BC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:41:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24sQ-0005nf-FD; Thu, 03 Sep 2026 06:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24sG-0005aU-V8
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:40:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24sB-0006Ti-Rd
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:40:50 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHBMn3782254
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XyuN6PFVWKFuf1ZjipgLX6cblWICVka9Ua8+99l39Aw=; b=AMSCOYRWYg3C6eE5
 0App834HVvU28DkWa62jyaow5t+2R/9FYsOyEaz6+eXwWwXQO0PaPPLXIeO4IBUQ
 YfKa+/R6YDeOf+ES721CcFHS2EXL1mfOTmWA7RyOwBNuE802vx+0YuqqFzLu254N
 3acuHmdoYFBoGTM946GGD9O/NAhgOkJUX2IePG2sFDopSeQsB2pjbJfK5YxuyVuH
 6AyfmSmBXXrhaQJvRB/N4TXJgMtkb45NDd/kz3aIKs96t0Pa7fk/YJZAMPe/Z23r
 8BIXq1O/8zEBSmh7soBZcPCvGudPuGv4rqDc8s2e7iTWCbXiam5Tr7jWV1ljPITX
 5JRxsw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf5pdrfsq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:40:44 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-939665a1ae6so413957185a.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432044; x=1789036844; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XyuN6PFVWKFuf1ZjipgLX6cblWICVka9Ua8+99l39Aw=;
 b=MKbMf7fp8dyBLiTVyG55LEqeyHIEzNxaHYl4dGENmiCacsIMTvIp155NbkDufablB7
 zOjOUn1XSaRDg5EuOmukJBMRoLlFxhPOrKxKQ6IrkVaV6oipW7bcFEAddpLXQmBywCGt
 4meyUMgsY0slz5CBP806EIbXv0Nj4tWXHdJNW7JymiJbCYLUrltBfrEvXhUtaR/0DJy3
 QfjHkfdSVJn5dF+g5drG3WRPB9ya+NhRbttraPqMLsEl0xeTOrPgqoMMH1njkxcHw/r3
 6cyA9+QI9RKXda7GXs64dwaIkVkiPjv1nXrCKeklz/NAUU4h6x06bP38N6Th5XPQ/aIi
 z90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432044; x=1789036844;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XyuN6PFVWKFuf1ZjipgLX6cblWICVka9Ua8+99l39Aw=;
 b=RmzOONs+beslfg0avb47AZKe0PaOJbE8eK15c0zeKagctoqlfmQBiOyo24EAmhfECc
 3BRltA4DSssZN12mcyIw+dOY2iHvRFgjTgR29sRfm9ZmEo2otK8rg1v2LmsoGkEoWoRg
 4FdMCaS/Zj1uh49rFO6GLEm1Iqk2dctfm+c5jDsOslaOfTCIz9ihBrKg7hDn3kS/x6Ak
 QBcf12201EqFg+2mN6yUSQhaDDA79lmg/B1qKWPAo5guHAiiwcw+A5e1ZRD19n46T29A
 BH7MPS4sCMbeyrllXMgq3JjKP9tZY6qg+fVZ46MSPNUBRa4JKl1cTuh+aKqwA9JosOQt
 uXuw==
X-Gm-Message-State: AFuF++mmJv41X4/pxhALCc64dr45WDBaMZMInPHzO13EJq4vWwQyqnHw
 QTbWkCC2xu/I2cO89Apa4vrCkDM99lQAtNCdYpnodzw2AbA4TTTJTfdHcRdZ+IfR2gQfgGS+Ggl
 McVIq/dR9d0HAp2iq/nQLVMDRByPy4VQKW2bZrtGsbtVuC8tW480Qrod6DF4ID2ts+g==
X-Gm-Gg: AYBFou1Bt7ayAiDdIMc7HwD650lPJjNaYfw4TvEWBSl5vJ1ZrIFms/2l+jVBkQlOtsi
 4cw4PETROEdprlP/V+yk4n/U/+ULU5rhH9bQa+7iN2+1VQWFuclIQVhSCljchy1BEd+Bep0R3Zl
 NYpibOH4tqsDiGNAm9l/BG13je+jNZXJQew45Xmwce8EnCW7a4ZQIEq2qV3jZWG4efS6+xzyywm
 zFnKM8J99F9k4yCsG/e2D4Wl2BzEZXOYTDA+sKydyrwQQYKaeRfvlVWK1ylI9WEDYw2ahrXpKYe
 /b68byeuc2BWIZqy7GdcWYvexi4+oNf8w0gVicAsJwuf7xImdL8jEnGJBUBFg0L2RgopImF8urf
 xeNZlVVhKAS/vvW30Z5Hq2wnR5IDYY5pYrqYSR03l
X-Received: by 2002:a05:620a:2886:b0:939:4891:6799 with SMTP id
 af79cd13be357-93960decb8fmr1347671585a.11.1788432043777; 
 Thu, 03 Sep 2026 03:40:43 -0700 (PDT)
X-Received: by 2002:a05:620a:2886:b0:939:4891:6799 with SMTP id
 af79cd13be357-93960decb8fmr1347667685a.11.1788432043303; 
 Thu, 03 Sep 2026 03:40:43 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e81718sm12733262f8f.16.2026.09.03.03.40.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:40:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/51] hw/sd: sdhci: Support version 4 ADMA 64-bit addressing
Date: Thu,  3 Sep 2026 12:38:53 +0200
Message-ID: <20260903103936.62355-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX9VJ7Jy/dOXGZ
 4b7Una7q+FbJcnXbEw1IiX8FM5vb44xDJMYKzO2w2avWvgt2WUDiKBSaILIPfEXgSzOkpH5GXIB
 YGkEk92ZVZZusYu2kBaYK/744iX+mhk=
X-Proofpoint-ORIG-GUID: KAt9pfBB32njghQMbmdTSaRHjHnc0RVo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX21srroKqRSr1
 +7v49RL1gCNnvL4OKelW7r0XqPOvB/a9K+1BJ5wNZSuI8kzhlR57fPDHZUqgzcdoJAu5XBAYVCt
 VxVK8qX7wMGIwEfHz/zTSxb4qSfA8rB93lLVo92PYYq7e1CLKGgFsa/ntVW5f7ZQTJY1Dh9Nsxc
 AumwvP6wY2pW/omdL8Jr9cb6WA4tzEzKHHsBlI/y7DVv8AwsYceRe2njqkXqeLNBo62VpbciY+c
 cgLX1aBmtVaPjTpUL4HZIipixbKMQkNgZC6m3yvsyFTNiNBWAG9TfnqoenUqT0ItjKw9MD3UHnK
 B5XdLYaIR7mIcaYrP1+79Q/I9VblyvJRFWxFRuVvylaVFK2N1l2qVFNz9c3V5aCbjYz+MI3jtAI
 AhBR6tB3XtD3TiuP4TMEHbfPMwxsAdQJeV6BdmTb2cMDRRWyhIyW0wiD2t39Y/82wamtsoyyrML
 2Qep3aFNt+3xijXZq9w==
X-Authority-Analysis: v=2.4 cv=RsL16imK c=1 sm=1 tr=0 ts=6a994eac cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=cecaVjzdulOwRCAQsNoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-GUID: KAt9pfBB32njghQMbmdTSaRHjHnc0RVo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030092
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

The Cadence Linux driver enables version 4 mode and 64-bit addressing in
Host Control 2 but retains the ADMA2 encoding in Host Control 1. QEMU
treats the transfer as 32-bit ADMA and uses 12-byte descriptors because
it only decodes Host Control 1.

Resolve the DMA type from both control registers and use 16-byte version
4 descriptors. Preserve the legacy 12-byte ADMA2 64-bit format when
version 4 mode is disabled.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260723151853.2143177-11-bin.meng@processmission.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/sd/sdhci.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 3fba3970d4f..f0ba5c11dfc 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -227,6 +227,23 @@ static bool sdhci_update_irq(SDHCIState *s)
     return pending;
 }
 
+static uint8_t sdhci_get_dma_type(SDHCIState *s)
+{
+    uint8_t type = SDHC_DMA_TYPE(s->hostctl1);
+
+    /*
+     * In version 4 mode, the legacy ADMA2_32 encoding selects ADMA2,
+     * while ADDRESSING_64 determines its address width.
+     */
+    if (type == SDHC_CTRL_ADMA2_32 &&
+        FIELD_EX32(s->hostctl2, SDHC_HOSTCTL2, VERSION4) &&
+        FIELD_EX32(s->hostctl2, SDHC_HOSTCTL2, ADDRESSING_64)) {
+        return SDHC_CTRL_ADMA2_64;
+    }
+
+    return type;
+}
+
 static void sdhci_raise_insertion_irq(void *opaque)
 {
     SDHCIState *s = (SDHCIState *)opaque;
@@ -781,7 +798,7 @@ static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
     uint32_t adma1 = 0;
     uint64_t adma2 = 0;
     hwaddr entry_addr = (hwaddr)s->admasysaddr;
-    switch (SDHC_DMA_TYPE(s->hostctl1)) {
+    switch (sdhci_get_dma_type(s)) {
     case SDHC_CTRL_ADMA2_32:
         dma_memory_read(s->dma_as, entry_addr, &adma2, sizeof(adma2),
                         MEMTXATTRS_UNSPECIFIED);
@@ -818,7 +835,9 @@ static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
                         MEMTXATTRS_UNSPECIFIED);
         dscr->addr = le64_to_cpu(dscr->addr);
         dscr->attr &= (uint8_t) ~0xC0;
-        dscr->incr = 12;
+        /* Version 4 pads 64-bit ADMA2 descriptors from 96 to 128 bits */
+        dscr->incr = FIELD_EX32(s->hostctl2, SDHC_HOSTCTL2, VERSION4) ?
+                     16 : 12;
         break;
     }
 }
@@ -998,7 +1017,7 @@ static void sdhci_data_transfer(void *opaque)
     SDHCIState *s = (SDHCIState *)opaque;
 
     if (s->trnmod & SDHC_TRNS_DMA) {
-        switch (SDHC_DMA_TYPE(s->hostctl1)) {
+        switch (sdhci_get_dma_type(s)) {
         case SDHC_CTRL_SDMA:
             sdhci_sdma_transfer(s);
             break;
-- 
2.53.0


