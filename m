Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F297AC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:41:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24sM-0005dQ-1x; Thu, 03 Sep 2026 06:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24s5-0005Np-K8
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:40:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24s2-0006Sm-PB
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:40:40 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHKsO162990
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:40:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WQdXe9MM4hmlY6rO1rmXlFqwn9nGfwpDH0QN/wNZ1rU=; b=UaQCxSgM3CATn8ra
 QaNkLhj4xVgUO8BQBQ+ddAIRYvdU99bLb236wy6nJw2aYYRUoCjQl46sqtAZPI5d
 NGxxAY3S8EQo3OE15Jwftk5KXPiWyNhyo1SaHx9l5pBLIWPHYwWoxyYm8Kseesm8
 NtbEIQeEkcm1ImpSoT88lwkSVOsftPYmxcn+yg2gwqVaUBacAq6iX78xbpT4DH8o
 FFM7ewPN0n2q5v+BNrpCuJqhh79g7IZHU4VPVszxduAPRd66PQ1gcywCGmO0Q51q
 0TIBB7VG+W5QWtFIVmAjt9vb6XDz8sikdN+VZ8r02HV4Xs5MsIr/AlqqlSTSF0/c
 Y2Tc1g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf6tx04dh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:40:37 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93771aa0379so597157985a.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432037; x=1789036837; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WQdXe9MM4hmlY6rO1rmXlFqwn9nGfwpDH0QN/wNZ1rU=;
 b=OHSsW++oKTxVTGayb3Mer4Knr2A/qxoV0iZsr8thg6krdVfFKa0eu8Ihua5APOd0ge
 CQMWRZ6e76Gb1Uavhgfc+Q36m59r9Ak3TjiKalV6dcLzsNVNYNA50mP5lR+OSVbf4MEJ
 9aRtOCkhpTAjQwKLw3Gmg6a9kE5gCsIWknQiwTRxYs9ngMTOIYesm9q5bXD/jUtgyDKY
 gy7thES0ikTZ3Ar4r4wUOktvJTmr+5xoS0EdUhoYjBQ8kjtii32RstNuLsGpFh4lVAoD
 UX9TMkWC7wDLhSzPFudV/ECMayuFTT5lgt8peXg4nYGaxKDcH7cPyNfbDuhiieGnB2Gb
 fZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432037; x=1789036837;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WQdXe9MM4hmlY6rO1rmXlFqwn9nGfwpDH0QN/wNZ1rU=;
 b=CayrgmunPcjWkTPjeCzTUFK3Hab3TVpYx20qaTtgsNl5e18Dt5N1bA6iS0izjc3H19
 DnAqhuYEXtol9zV/PUFmRCZnckAodXbtTbyqMAqg55fE3FWVh6W5o37MItxaz1m7l9L0
 QOE5sflfUBo253mrMc/YFyu3FDeZ0DBTTyElAdu4TYi1JprEzqPs4/FCnevXG8qDJ6C4
 LiOrAGXZnuMw0JAlwVYc29wXy8UsyixHsEEt1goWcldIqyL+Ove+Gwqv+xhNYnzQlXPJ
 aS66iaVkPPMJjJurmJCLFTZuiyJGEVMhxOokCInYw1k3KUVp5gV0owGerXDf9KnXWl3d
 E2xw==
X-Gm-Message-State: AFuF++n+CNGGolBfDqm6vXlgGyeL4U6OsEWSNldJO658gcQADjISanVw
 YLE2vinX6YFzEAZyMmEyxfH6xtdAduMhofiN2cm0Qz5SzwiUKFjGGGku3T5ezPSjCoMziLOclNF
 0JzjHmRRPXoH7w6mR9JaZYpERw1PvwypHY0HGJbr3H9glyP69QTMKqw7TpHgKwPN+iA==
X-Gm-Gg: AYBFou1lMtUpC3qs5ou4suPi7BwymRsjmAo4a6/eXdiQQKto1WhFWaNgDGR65YxpLwv
 gDORoRsPLJUZE9dFI/V1LmYEhvbe4XfSkNp+Jobil5jIjw/vSf6TRy9kbKZcUL3Ju7kEcyHTCJf
 sScEBbiSmu68uF81rO6WuFxd20xfKH932HEpq+kPmXPJFtpk+Zdlz6LvfVNfyXkjBq8+QE+wGdS
 XrQtT/2HzJivBBKUiubFEalNvThrFL6z/heL0tAtbuMyrMNsS4a1mTGuMznJeHFm4tPxKGmBEcd
 9laUkHyeZ1099QnmohCy2uF1JFjjsWuMDbX8kgSEdD51GawmMvNuIWG9MleHL+sKOQkphdMvYVw
 n4AFP9f7IwVjR/s+ibkwb0p68IoYuvt0WD2kyVw4k
X-Received: by 2002:a05:620a:2682:b0:939:1459:efb2 with SMTP id
 af79cd13be357-93960ef3c8amr1346666685a.24.1788432036993; 
 Thu, 03 Sep 2026 03:40:36 -0700 (PDT)
X-Received: by 2002:a05:620a:2682:b0:939:1459:efb2 with SMTP id
 af79cd13be357-93960ef3c8amr1346662785a.24.1788432036524; 
 Thu, 03 Sep 2026 03:40:36 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5d4938sm61133225e9.2.2026.09.03.03.40.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:40:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/51] hw/sd: sdhci: Use version 4 system address for SDMA
Date: Thu,  3 Sep 2026 12:38:52 +0200
Message-ID: <20260903103936.62355-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4yQSffL8jmkFI6aus3UqBjmWBZMEsQwy
X-Authority-Analysis: v=2.4 cv=TqjWQjXh c=1 sm=1 tr=0 ts=6a994ea5 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=RSTeruuXXq40PE7alSAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-ORIG-GUID: 4yQSffL8jmkFI6aus3UqBjmWBZMEsQwy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX9CNNDR4z6rRH
 VQwvQS89iIy80111ea5ovuS9YfP0ftfz0OV9TG6HnIPGE7EWsuLxFPQgSd4NLZ19r8x5yKFP1Sw
 qBRBAyh3CsensXM5Wheup5q/JLIhhGR34jUV+xyVHOWf74EQVZAI4XKwjiv/+e3rEfxKq1zkMLm
 frkLwGxArMErFcS/mrF3yxxLytuh1mFGjkQRQWmM3x/19BFA9zfFz9RXa+W5JiqGeRxCbGkmkHx
 4CwXJc0MF/4OarsKqtl6gzRtXcFAcSOF/Uej+lygOYMLiGqt2U30aLVFoUvR2CtJ+UYAQelHoPv
 mNDZlTKhRkptfSqtaadRXSGz41AGff2chx0wCx9PxpqCrIlWFWihGVEBnyZR6kTOEdCG7Kyg2qR
 YDuf5ALSFJ9yCX8waJCYKUinhdTW/1Z1vnAcGAhVr1aX3BQ/tYlUy1BHUlvpK1u0uJjHp0wRQgO
 sepMKQF5noJ1QmkVDOQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfXxLpo1U/2CfH0
 pPbQPzfuA4Yb4SatO63D72QZAM/vjdbLGmbF9OXxafX9V1dwpxg/jB8D1NWy9x5rTzXqqk0agaA
 8Y6lx5Q2hsz2ehbJ5pPL02IGLwkPOic=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
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

SDHCI version 4 moves the SDMA system address from the legacy 32-bit
register at offset 0x00 to the address pair at offsets 0x58 and 0x5c.
At present QEMU always uses the legacy register, so guest SDHCI driver
with version 4 mode enabled uses an incorrect DMA address.

Select the address register from Host Version 4 Enable and honor 64-bit
Addressing when reading and advancing it. Keep the existing offset 0x00
behavior when version 4 mode is disabled.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Message-ID: <20260723151853.2143177-10-bin.meng@processmission.com>
[PMD: Simplified extracting the previous trivial 2 commits]
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/sd/sdhci-internal.h |  1 +
 hw/sd/sdhci.c          | 32 +++++++++++++++++++++++++++++---
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index 4aeed120bf1..2116995dcca 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -201,6 +201,7 @@ FIELD(SDHC_HOSTCTL2, UHS_II_ENA,       8, 1); /* since v4 */
 FIELD(SDHC_HOSTCTL2, ADMA2_LENGTH,    10, 1); /* since v4 */
 FIELD(SDHC_HOSTCTL2, CMD23_ENA,       11, 1); /* since v4 */
 FIELD(SDHC_HOSTCTL2, VERSION4,        12, 1); /* since v4 */
+FIELD(SDHC_HOSTCTL2, ADDRESSING_64,   13, 1); /* since v4 */
 FIELD(SDHC_HOSTCTL2, ASYNC_INT,       14, 1);
 FIELD(SDHC_HOSTCTL2, PRESET_ENA,      15, 1);
 
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 93e1687dbe5..3fba3970d4f 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -598,14 +598,39 @@ static void sdhci_write_dataport(SDHCIState *s, uint32_t value, unsigned size)
  * Single DMA data transfer
  */
 
+static bool sdhci_version4_enabled(SDHCIState *s)
+{
+    return FIELD_EX32(s->hostctl2, SDHC_HOSTCTL2, VERSION4);
+}
+
+static bool sdhci_64bit_addressing_enabled(SDHCIState *s)
+{
+    return FIELD_EX32(s->hostctl2, SDHC_HOSTCTL2, ADDRESSING_64);
+}
+
 static uint64_t sdhci_sdma_address(SDHCIState *s)
 {
+    if (!sdhci_version4_enabled(s)) {
         return s->sdmasysad;
+    }
+
+    return sdhci_64bit_addressing_enabled(s) ?
+           s->admasysaddr : (uint32_t)s->admasysaddr;
 }
 
 static void sdhci_advance_sdma_address(SDHCIState *s, uint32_t bytes)
 {
+    if (!sdhci_version4_enabled(s)) {
         s->sdmasysad += bytes;
+    } else if (sdhci_64bit_addressing_enabled(s)) {
+        s->admasysaddr += bytes;
+    } else {
+        uint32_t address = s->admasysaddr;
+
+        address += bytes;
+        s->admasysaddr = (s->admasysaddr & 0xffffffff00000000ULL) |
+                         address;
+    }
 }
 
 /* Multi block SDMA transfer */
@@ -1380,10 +1405,11 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         MASKED_WRITE(s->acmd12errsts, mask, value & UINT16_MAX);
         if (s->uhs_mode < UHS_I) {
             /*
-             * VERSION4 is writable even without UHS-I. Preserve all other
-             * Host Control 2 bits when UHS-I is not supported.
+             * Version 4 fields are writable even without UHS-I. Preserve all
+             * other Host Control 2 bits when UHS-I is not supported.
              */
-            uint16_t independent = R_SDHC_HOSTCTL2_VERSION4_MASK;
+            uint16_t independent = R_SDHC_HOSTCTL2_VERSION4_MASK |
+                                   R_SDHC_HOSTCTL2_ADDRESSING_64_MASK;
 
             hostctl2_mask |= ~independent;
             hostctl2_value &= independent;
-- 
2.53.0


