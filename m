Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD391C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:41:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24sC-0005RC-0S; Thu, 03 Sep 2026 06:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24rz-0005De-6v
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:40:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24rw-0006SB-7F
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:40:34 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHKTQ055412
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:40:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nyvi1a/tYYIkqUcnBE7VItdo02ESrel1JJPaNj5VsJY=; b=EugqUSMrat/V0Oap
 bOygq2KKW6CEJ/+Yyjra/qvo3htGGsA7IcsFMMe9jYbe3HJs9xpDLpAgVRl9oFc0
 f16yS/b39pElS+ZjXXNbJGTxLoxjTeiXqoMSe2m9W0mhHtxCtNvNjwto3ilXRR2U
 Cw4l9cY7QP/WAHzBg1HVnF7FpPagckZqy4YPraQNLB0pfFx3KEubrX1qfGvjzTaQ
 rb95G/Tbc16qa/zUuMfH7vjOg3SxKupmcx0rmUqRM0kCI3nnk0Ou5mWKfd+tTSqW
 d7q4qO1tsxKV8WCKGsgl1/y1/fuCCnyucs6n83pmYXcf7jwvNs41Td6eWUshcyX4
 5UOc4w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4genrdvgkf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:40:31 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-936708f129aso348444685a.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432030; x=1789036830; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nyvi1a/tYYIkqUcnBE7VItdo02ESrel1JJPaNj5VsJY=;
 b=izKHQrF2yRfuFKtNc7sdn+bAna0bvJMtmLaPWBvr1foaVKE6XxRLEf1m3IGSy8xhxW
 VVTRjIqKIWSeJvh7mwRpbqvCsS43/mVc9fUOk99craTn88uYOpbGtsANkSUEJGQqX6P/
 4pq30tGZAjcFamxpgYqM7v+XBqJ+dtzF7MwIPYirfvC8V3cXUFMf+L7gKgfQA3HBRWiH
 ZFf8NQorujVs7Afdhd74vfsUDRf/V32pNgeSWVtbuqgjqSXVYrLnhy0JUXvxWhvUon91
 7R5qRM+zSNC68Sm9eSMm2aUonFRk3rbnY+e/A2/bghtE7Msu5379OCwg78oFZhQYdHZ7
 eTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432030; x=1789036830;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nyvi1a/tYYIkqUcnBE7VItdo02ESrel1JJPaNj5VsJY=;
 b=CLOluaX/53FK1DDmxx2MqC+DNgL+x/0j6Cbb8DOxoh+aXMBHwyzfDJgTSi2djXFFb7
 1A93BGLkC7Wh/GB5BjfPpbQHl+ezVJZ3Fe8nMcEdY+zxskdkw84bMPCb470i9N7H6nrY
 t43MzrZhHPqSZSwW8hdikk0i504+/NyHPc25p/Mg67VAUJ9PtfcpXjT3FGXM7ZThWF5G
 qzHI4FYW3P6XkwKsOG5C9EmAAKADbxFF3qaapA4d0inDB1GEKbizKNvmZQMf7zU41luQ
 8Lf+DxZwAc+tPoItVD55vciKj5AWT9DyvUNU4S2FhUUXFqPmVmQqX0/1emOK1txHMbeR
 e4VQ==
X-Gm-Message-State: AFuF++mnUaf7/DYIpb3ifUZlczuULnxD8swKogsuoYlZl0x2J5DPtDZT
 2V2WwVm3DX0KNNiM1WFMSQcUdrpgvICVItWhb0xHPHxHZ/wZajeP/xO8ed7s+M9zb7QyBhJTJoS
 qiKDOnvaOrc10wbW6AEwFvGalefz9p71DTNPf9/Vw1mdYEZqAykFo4oPufJviu/D3WA==
X-Gm-Gg: AYBFou0lJIp0SrqETAp6wCzQyQmCSITBAxnuSigq10ebWWvkKHv6aOeqS4VuL0E4Iny
 Z8jvTpwdq4bDOZ0bArWdqOBi6DCjZp2mHjKHe2Feo1ql41BKmIYed7241W6ihxRYNu1F2q1XGC5
 Prtw6aVk2TlZA+l/Tj5qnKOhea2dQsVRFHScDLyMdFpQhMLCA4QBpdPdpbZo+lELmlUTCuRyBOb
 8vJxCZaItoqq7IrIMnUXshn0VLax1kPt008NB1ZeohwcWGuCr91xLmhFbYRDKsYTg1K0cs1lVBZ
 x+CHv41ixRccjUMPSYHfdDdZV0XK8lt4K/CJNMtPJKSvIORNZSRHrNvQ/LC7fCzn3DjzWKcd4Gw
 ToZSao1aQjOc0+GC7ZqrV2e0lJ86lZMgpBUcuWGSg
X-Received: by 2002:a05:620a:72cd:20b0:938:61e0:20a7 with SMTP id
 af79cd13be357-93960c6ca10mr992242285a.1.1788432030201; 
 Thu, 03 Sep 2026 03:40:30 -0700 (PDT)
X-Received: by 2002:a05:620a:72cd:20b0:938:61e0:20a7 with SMTP id
 af79cd13be357-93960c6ca10mr992238985a.1.1788432029656; 
 Thu, 03 Sep 2026 03:40:29 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e80388sm14506014f8f.14.2026.09.03.03.40.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:40:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/51] hw/sd: sdhci: Factor sdhci_sdma_address() helper out
Date: Thu,  3 Sep 2026 12:38:51 +0200
Message-ID: <20260903103936.62355-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=H4/rBeYi c=1 sm=1 tr=0 ts=6a994e9f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=1EIJZlbp_TTgYt2UKbcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-GUID: 9zAnt8vzYcnG2L_EhlxpBio6XDDq0q30
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfXzE3ocqOPSIAv
 1TBLpaBKX2trHqMyHlc7G5OvNuO+hIhQVqB+RKe6NIrvBr503a9coqVHdG1+W5Id0L+zFWtYsL2
 eZ+0mbKWg42oXJY69TbPQsZ1EfRWv4AiBycCI7dsPQVaPgpyNY65tcx2R1fklN4wZoUzU3XxLg3
 JgiinC4Ms90hgALTiX+9x1SUZvQjbKn+QtUa9IHeicb1XcUiejOp4/5R0P+RbppeQrX1RJSaZ8c
 S6VdoRqZUjLHCzen6Gson2OX5s/54N4pzGVF0LpbS358H3BbxEuW/X5whhwTEU5zsQmBfdc+exq
 2U6SoQbe5MPyWXaBayDoHswNkxsYQs+4IPxmoAfVki1BpPMjJVdxC644CjmRBw64ru4NLjx0VWm
 K+wDvPpkpctLRijapFr8vd8+pVsObGmCK6IfdipZZzrKa7lRqKnkcNFrFGVHHI9DVJ2sRFhOyRi
 m3wgQwAccU2VZtkO7EA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX5GApgNIBbzSO
 otQ9+dlAhEBPo8Xgu4bVD2YQMHB+3WGWPuJisxMQPJTsbA9Fk7T3e5Nnl0XVRSH7LrWGxxQsvjr
 BL40icSdObOaWUCAtHVb6gYCRM5pUiI=
X-Proofpoint-ORIG-GUID: 9zAnt8vzYcnG2L_EhlxpBio6XDDq0q30
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
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

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Message-ID: <20260723151853.2143177-10-bin.meng@processmission.com>
[PMD: Split of bigger patch]
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/sd/sdhci.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index ad370407c6e..93e1687dbe5 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -598,6 +598,11 @@ static void sdhci_write_dataport(SDHCIState *s, uint32_t value, unsigned size)
  * Single DMA data transfer
  */
 
+static uint64_t sdhci_sdma_address(SDHCIState *s)
+{
+        return s->sdmasysad;
+}
+
 static void sdhci_advance_sdma_address(SDHCIState *s, uint32_t bytes)
 {
         s->sdmasysad += bytes;
@@ -610,7 +615,8 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
     unsigned int begin;
     const uint16_t block_size = s->blksize & BLOCK_SIZE_MASK;
     uint32_t boundary_chk = 1 << (((s->blksize & ~BLOCK_SIZE_MASK) >> 12) + 12);
-    uint32_t boundary_count = boundary_chk - (s->sdmasysad % boundary_chk);
+    uint64_t sdma_address = sdhci_sdma_address(s);
+    uint32_t boundary_count = boundary_chk - (sdma_address % boundary_chk);
 
     if (!(s->trnmod & SDHC_TRNS_BLK_CNT_EN) || !s->blkcnt) {
         qemu_log_mask(LOG_UNIMP, "infinite transfer is not supported\n");
@@ -622,7 +628,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
      * possible stop at page boundary if initial address is not page aligned,
      * allow them to work properly
      */
-    if ((s->sdmasysad % boundary_chk) == 0) {
+    if ((sdma_address % boundary_chk) == 0) {
         page_aligned = true;
     }
 
@@ -644,7 +650,8 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
                     s->blkcnt--;
                 }
             }
-            dma_memory_write(s->dma_as, s->sdmasysad, &s->fifo_buffer[begin],
+            dma_memory_write(s->dma_as, sdhci_sdma_address(s),
+                             &s->fifo_buffer[begin],
                              s->data_count - begin, MEMTXATTRS_UNSPECIFIED);
             sdhci_advance_sdma_address(s, s->data_count - begin);
             if (s->data_count == block_size) {
@@ -665,7 +672,8 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
                 s->data_count = block_size;
                 boundary_count -= block_size - begin;
             }
-            dma_memory_read(s->dma_as, s->sdmasysad, &s->fifo_buffer[begin],
+            dma_memory_read(s->dma_as, sdhci_sdma_address(s),
+                            &s->fifo_buffer[begin],
                             s->data_count - begin, MEMTXATTRS_UNSPECIFIED);
             sdhci_advance_sdma_address(s, s->data_count - begin);
             if (s->data_count == block_size) {
@@ -700,10 +708,12 @@ static void sdhci_sdma_transfer_single_block(SDHCIState *s)
 
     if (s->trnmod & SDHC_TRNS_READ) {
         sdbus_read_data(&s->sdbus, s->fifo_buffer, datacnt);
-        dma_memory_write(s->dma_as, s->sdmasysad, s->fifo_buffer, datacnt,
+        dma_memory_write(s->dma_as, sdhci_sdma_address(s),
+                         s->fifo_buffer, datacnt,
                          MEMTXATTRS_UNSPECIFIED);
     } else {
-        dma_memory_read(s->dma_as, s->sdmasysad, s->fifo_buffer, datacnt,
+        dma_memory_read(s->dma_as, sdhci_sdma_address(s),
+                        s->fifo_buffer, datacnt,
                         MEMTXATTRS_UNSPECIFIED);
         sdbus_write_data(&s->sdbus, s->fifo_buffer, datacnt);
     }
-- 
2.53.0


