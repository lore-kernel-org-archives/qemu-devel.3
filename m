Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DEFC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5f3-0005T9-AW; Tue, 07 Jul 2026 09:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5eX-0004Xz-4h
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:15:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5eV-0000tK-Ff
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:15:56 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C8slM3768559
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 13:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Q7dKRD/YZrRPz30zezRUpSFHvIoPGWdiXeo7RuBNVQQ=; b=FC/+yj8vnRCu72dB
 AJkwA+HoOtKOFXYxUl/dBfOXlm+AWUsu0uxpzFY4cc3lZDlguo72G9TFa2SqS7zV
 yiAw6rGuv1LPfvvJusGgyl1N1ODrfZ0Ace2zoHRLQwZj3oAuYoG4GpQirjcIBh+C
 99nxyH9w5zhjTiCA8hz6vA0CTBUtdIJC/b3G9PdNDUrTJuFGqmLK6S8jFmb1Qm/w
 RDH2RbOlkQZti2dZBreKjJxm4QnmwgRZ0ElXVh8GcnjEVM2xV7EVwlShCXWSXPth
 kY5DfltyiomNARi31EgAsiH3vqq/eSCqeX3jZ1JOg96pSIH7ZRcegI2VeSv80hkn
 Ile4GQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8qj7akag-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:15:54 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c26012cd0so52989101cf.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783430153; x=1784034953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Q7dKRD/YZrRPz30zezRUpSFHvIoPGWdiXeo7RuBNVQQ=;
 b=aND7iPvXLAplQDBsgBgboN5gUH/jXs3tp+tXUCDTIHM5/K6AcBO+1w/l08aCPno9/a
 Ijl1TLlGhCatnx4A0HjFEOZ/+I03gsKjPtHweXXzGPu0cT2HxMLG94NzkL5apVmfV0m3
 MWVQGLVdQAOee5WFM6kxlYKhrl8j8tNsVR3KlHusz0C6cebfrntgjWK11hCasJFeFNpV
 gUAnKOT/cwS82y8BvP5TnXZkN1p1j6183DsIFLhEuBQ5OLlIVv5/pEAO9k6yfQX+BWar
 m5pRuEG2Vdz9SVbp6Ks3+7H6ZjBcKCLZzp/MfMDR0T6YYD5XVb+MgsI/XambRVYwuMWj
 jc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783430153; x=1784034953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Q7dKRD/YZrRPz30zezRUpSFHvIoPGWdiXeo7RuBNVQQ=;
 b=s1e4rO/eDRMxCAijTvLjhdh0s23atn74/Co+g/cWXkuisOaKbqT1EBtIaJpaMVW6nC
 N1/K/BV2a4xST+1fG3OE+I/L2Hm/EsqSWWgH4HF9WU25RekAZV+ASEMwlgVM56Xo9Tzi
 Jp9rKQf++e0ukV+7fw5t8y9QRMDz+MK1pvEtws8b2q4Euoe6N5xOrjC0bg3Buefh/WYv
 4sPnH68c026IzAKwemExLPJtTc2lubisSVE6IJsppjPIvn8WwEBA9uv9A4txBGCwewhx
 +dMG14cO9WNThBuAYOqG+fp/AFoAtypHAvES72R4iAkvrXfQNKxTAAbaj3uNnx7TsugK
 pmRw==
X-Gm-Message-State: AOJu0Yxg4Z8cuNMO9Eu+sgHrEIZhsj9CeNk3U8GFlFjV5vNsHWYiC1v1
 hd85CpuxnmOWdm1XN8B9AUrSeXiIJsRPGmbvToy6kIxPn9QZLnnpqwq9qdND2URNI2aSajHhAFJ
 0OaKgVPgy8V8OsUBVdvaprVjGEKL+16vl8Fq9Z9Ue1uuUHKlf3mkr2c+EAyCGsXxxaA==
X-Gm-Gg: AfdE7ckPH/32dwKm1zxbuTceyUn398qVLhBJn4xs/Uw2cvFoQfDxPX0L2RwyYlZjGjx
 +4mx8SaLA75/otWAwMusqowh+7wKxjaxGkEb3u3kxnxtxteeCigqPiv+W01BRnYV7YTN9dY2RNH
 +HLkm22zqSVesHpfRvfUjLYb9O4FwHN5qtgTOTYlZKIOVTGt80dFnXS3EKdFf2qD7v2GgOMkDEz
 d/4UKyZGcDPM9zyUlFimsyX/HXbmLL7iTf5tqQrUrsOqJT1Sl2JSLTfdEAmQky4syY2r7EKHoXA
 s29cn568eqv2iRsSMJW+Wf0CvcB+zYRs3EoWF3bZCQhhJSr3Eje/T0dasTxTzRildXd7JUpwTeQ
 Z7WMGKT3AKv1MDTzwijtyd7IopCBUi8MdQygBa173p2EA3kO44yHDaMbdgvaahay1Si8w
X-Received: by 2002:a05:622a:3cf:b0:50d:900e:c1c1 with SMTP id
 d75a77b69052e-51c747ca072mr54534061cf.7.1783430153415; 
 Tue, 07 Jul 2026 06:15:53 -0700 (PDT)
X-Received: by 2002:a05:622a:3cf:b0:50d:900e:c1c1 with SMTP id
 d75a77b69052e-51c747ca072mr54529521cf.7.1783430148531; 
 Tue, 07 Jul 2026 06:15:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15ada05d72sm136589266b.53.2026.07.07.06.15.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 06:15:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 28/32] hw/ssi: npcm7xx_fiu: Correct the dummy cycle emulation
 logic
Date: Tue,  7 Jul 2026 15:12:18 +0200
Message-ID: <20260707131223.51505-29-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707131223.51505-1-philmd@oss.qualcomm.com>
References: <20260707131223.51505-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0RqZTkg9b0U2GbmtsAQHigho8Cjt-69w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX9fVHzZTtfT/I
 ao0FeCZgSFyyau2UEmbqMLlvfVcL+oLvLXOrTSX6aNYJmZjmtEe7P0RqEy0F8iYOU+Rna2DPsl/
 sH0TxGOVMhJaPXmikcOsk9Y6hGj+2t68pURt7nXJNVs/8RvXUEduL7ZE6pGrqqMRsnnqXe9vIbi
 eVE5ynebPWdnF109FVuNhH6LrI9Pop/vg65DTa82m1GETCa0c0Ail5ArUDRKcX2wMqFNGbyoqU3
 +Fdw3Mh+Bu6Td0El5lRpMTImPhi3zchrmrIcW6rLadwhLCsUbHIBn13IfuuWI1QGFYYmxbOzB+K
 KhVg8N3JMRZ2MkQdES9S997ktUg8o2SXxvYZV429TXbrKlTBN0WxNz4lkisRaEmAvSKipaqi4yB
 LD2evsAhcN44WLeHf55n10khlhQaHq5M2BjViGOk3dlfHvri51ZFIWH46SPeCZw/jU5E7iTuPTD
 wM6VvxnMJMoIBoEF+lg==
X-Authority-Analysis: v=2.4 cv=PIM/P/qC c=1 sm=1 tr=0 ts=6a4cfc0a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=FRSEYCzRAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=YJbDOTpK0_xWFmpPxLsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfXwhCsg4RzzyKg
 lb+VJnkCBQi9FOD84TXn50ikYcZVRx6myibAexrzhAJHqJ5BgtOfdgPVwGTSLnAi10YTrSsJPEN
 XbUTs/TzSJzqGRihBCS2ffiWgLeDAXk=
X-Proofpoint-GUID: 0RqZTkg9b0U2GbmtsAQHigho8Cjt-69w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070129
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

Change send_dummy_bits() to send_dummy_bytes() as the FIU register
fields are programmed from spi_mem_op.dummy.nbytes, so they already
describe byte transfers.

Verified the changes by booting OpenBMC image on `gbs` machine all
the way to the Linux login shell:

$ qemu-system-arm -machine quanta-gbs-bmc -nographic \
      -drive file=image.mtd,if=mtd,bus=0,unit=0,format=raw

Fixes: b821242c7b3b ("hw/ssi: NPCM7xx Flash Interface Unit device model")
Signed-off-by: Bin Meng <bin.meng@processmission.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Message-ID: <20260707083431.219671-6-bin.meng@processmission.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/ssi/npcm7xx_fiu.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/hw/ssi/npcm7xx_fiu.c b/hw/ssi/npcm7xx_fiu.c
index 2d5bed005ad..d41d877cfbe 100644
--- a/hw/ssi/npcm7xx_fiu.c
+++ b/hw/ssi/npcm7xx_fiu.c
@@ -150,7 +150,7 @@ static uint64_t npcm7xx_fiu_flash_read(void *opaque, hwaddr addr,
     NPCM7xxFIUState *fiu = f->fiu;
     uint64_t value = 0;
     uint32_t drd_cfg;
-    int dummy_cycles;
+    int dummy_bytes;
     int i;
 
     if (fiu->active_cs != -1) {
@@ -180,10 +180,8 @@ static uint64_t npcm7xx_fiu_flash_read(void *opaque, hwaddr addr,
         break;
     }
 
-    /* Flash chip model expects one transfer per dummy bit, not byte */
-    dummy_cycles =
-        (FIU_DRD_CFG_DBW(drd_cfg) * 8) >> FIU_DRD_CFG_ACCTYPE(drd_cfg);
-    for (i = 0; i < dummy_cycles; i++) {
+    dummy_bytes = FIU_DRD_CFG_DBW(drd_cfg);
+    for (i = 0; i < dummy_bytes; i++) {
         ssi_transfer(fiu->spi, 0);
     }
 
@@ -305,20 +303,13 @@ static void send_address(SSIBus *spi, unsigned int addsiz, uint32_t addr)
     }
 }
 
-/* Send the number of dummy bits specified in the UMA config register. */
-static void send_dummy_bits(SSIBus *spi, uint32_t uma_cfg, uint32_t uma_cmd)
+/* Send the number of dummy bytes specified in the UMA config register */
+static void send_dummy_bytes(SSIBus *spi, uint32_t uma_cfg)
 {
-    unsigned int bits_per_clock = 1U << FIU_UMA_CFG_DBPCK(uma_cfg);
     unsigned int i;
 
     for (i = 0; i < FIU_UMA_CFG_DBSIZ(uma_cfg); i++) {
-        /* Use bytes 0 and 1 first, then keep repeating byte 2 */
-        unsigned int field = (i < 2) ? ((i + 1) * 8) : 24;
-        unsigned int j;
-
-        for (j = 0; j < 8; j += bits_per_clock) {
-            ssi_transfer(spi, extract32(uma_cmd, field + j, bits_per_clock));
-        }
+        ssi_transfer(spi, 0);
     }
 }
 
@@ -354,8 +345,8 @@ static void npcm7xx_fiu_uma_transaction(NPCM7xxFIUState *s)
         ssi_transfer(s->spi, extract32(s->regs[reg], field, 8));
     }
 
-    /* Send dummy bits, if present. */
-    send_dummy_bits(s->spi, uma_cfg, s->regs[NPCM7XX_FIU_UMA_CMD]);
+    /* Send dummy bytes, if present */
+    send_dummy_bytes(s->spi, uma_cfg);
 
     /* Read data, if present. */
     for (i = 0; i < FIU_UMA_CFG_RDATSIZ(uma_cfg); i++) {
-- 
2.53.0


