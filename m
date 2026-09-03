Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65624C624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:41:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24sQ-0005lP-F4; Thu, 03 Sep 2026 06:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24sJ-0005bQ-Qi
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:40:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24sH-0006Uh-6X
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:40:55 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHEMF327166
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KhITqIJMF343IsucLQepk7vttbDnaMQQ3wYnSIoJank=; b=juNVDDmry+DsEjmT
 TAa2ueDCGtjWSI4DrcCMZxV+9IHGmf2jA7LybzojMGVYni+alzNIcA16bavrbE6u
 +EsNlmbZ127KKYC/kG3LhZkBdfa0zHTI3LhXy0y0OtnYaEBvsEjVd2CrnLNhk9PH
 PAQUPAaevPslFmX2ptkEWIilg28MNzm6gGqog6i00b+UAwL8m0FtJC/K+73+I6q/
 zqnGvVOsUkQUGvJJzKvuRJEL6TWXchhgZe4bl5SrqNLcPKIfB9GNt05CQSgnTpA3
 ooAPajusaLHh7b8t1qcSt0Vu1n9kl6c9+3IhNZn09RsMRCT/2MxK12aEi4AALfTR
 RG/aWQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf4ekgtfs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:40:51 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9390ca1a9abso354821885a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432051; x=1789036851; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KhITqIJMF343IsucLQepk7vttbDnaMQQ3wYnSIoJank=;
 b=VDQkhzO665n4wKrqtmg0K9CUXO0lSe//FBmhHXDYwi3TkFyG3fJV9X12adITa0HjLU
 R6jlkhbe52FGzNwTub1QX/pG185tXvx68dobHTMxajRFKlOtYJ2qPXMMjJIBu3JUC4Uv
 TXVoZ34NZPF1KlLY+vRyjo/oy4lbgjELTt/Ip9VGd87JHQG09mHhjCAgaABoNjctZ/Ws
 Jszhb0QuUyyKxOH0d7kczl3+a4EWoRSf62CcOo/cUn7/gL94CG1v7maHG6hOxACEcvXU
 f3ZjrVxvSPH32oikhy2PYe9dah9Qe4BJHqXZV13tEtHwHVR0fIrPB5BQ2zNNiFe0u0rX
 KNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432051; x=1789036851;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KhITqIJMF343IsucLQepk7vttbDnaMQQ3wYnSIoJank=;
 b=LF2n/B8s3GHrjiV0qIyjKBEBR5zbfMOZRzBBtz15YepYTh2WJ8P4fPDbPG/xV0nhuy
 V7lrfPlSr6TAmsxYxuDo23b5KW/ox+Ay7sOq3zjEQI1zXjXgCl39rq7DzyrSxcjrcYu6
 mO+Za/CWPh6s78K23MSvBFa0GUcHkwgJyUYEotyJGbr8LifL8GBxoZ677ldlXQFVvj9i
 LD/1m5POskPPdEpgf8Uh327/nXaChypa+vNMZhJPxbKNKCfo2dQXbuEN5tJI1hCZDv7L
 7Y7j13mUUvFer7NByXyWavs8WW8bYdw3JZVJK8STcHOG8u5LYDaXxJd6f5foX/PyTByu
 Zx4Q==
X-Gm-Message-State: AFuF++nnwJUtzOyTh6neiFCsP1xDiamr04EVfrcGdf9cz2WVtGU1w5pg
 9zEFzFpEptGjhqCO7RPJu2FjnPRalFWtoijKZ6pweodYUvLemO8Wmm5Uift/z02uMUFfFBdNC0R
 /5Fw8QJIy3b9IXaL43wGbIis4Hzt5M97+XCC2aHQdC3gUOatJGujBidyH3bWMWbfbTg==
X-Gm-Gg: AYBFou0098+rg3iPQv5lP2MuERa+iL+aGz3BSWBqLSM3OdiWrknk+kgDT6OpHTQ6gbS
 hEEK3MIXOirBkdluY2LGLw5Cxns9op66v1fIrk8wvcNBz5oXrcigVHT4/nOtDo4Z6Lz3l+ZFT6D
 GhuSTZUqWkt1jDGIIzfvsZjCx2MICzGfBX+m4MbcGnzC30tS/E74Z6V9iT940eqo+HIIA6s2N1s
 266u7LcJsO5uj9Wq0LsU+jijxLej9MO6JLmZWqlvr7oJncIrqMQ5GR6spIv1yZAQKdamvacrDLJ
 SSjYEIgK8pl75OC9vedrxgyuF2s9qFR+5eQr1wv4Tt1+AfQiWFEEgje/trfMlRes92DWyTDAfF2
 WJto885kB1NOBPiQGgI0cqC41zQclVxHdtKyrHLF6
X-Received: by 2002:a05:620a:40d5:b0:939:3571:bb90 with SMTP id
 af79cd13be357-93960f2b49bmr1274579685a.24.1788432051186; 
 Thu, 03 Sep 2026 03:40:51 -0700 (PDT)
X-Received: by 2002:a05:620a:40d5:b0:939:3571:bb90 with SMTP id
 af79cd13be357-93960f2b49bmr1274576385a.24.1788432050713; 
 Thu, 03 Sep 2026 03:40:50 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ed38cfsm11889296f8f.19.2026.09.03.03.40.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:40:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/51] hw/sd: sdhci: Resume version 4 SDMA at buffer boundaries
Date: Thu,  3 Sep 2026 12:38:54 +0200
Message-ID: <20260903103936.62355-11-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: PtICKcjJHwMBcUJQ3j4K17IsSX5mXZZf
X-Proofpoint-GUID: PtICKcjJHwMBcUJQ3j4K17IsSX5mXZZf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX56ApJS6e1lK3
 wQp2MZ5H46nuCojibl8g1EsvoFkH8KHtzcIx1HVWwjSqrpryhRNhjhav9FiCyEY3hy3rFlzqjin
 WWK56HPlVjygmM3d+WpWEEVW065fgIAn+zfR0ZiWSA5X9IsQTH9/Kv8u1BAmlXNpAE6j6ZaTR0z
 HWsisNCXiKoterC8elPSaisjH3KfDcfXaJF/gvUNUHFe9MsRQZrIn/yt13ax32EI+IoQTorTZch
 xF3vLskZ3cZ9nP/G5QnLymzLuCLynaqyPSMCxolvCoAECkd2Amk/9IPQRF2giauSunVk7EJpsdA
 FY4J2lCTjZEfG+hhbWllkBF4tdIS6ua5d3CGKLLZee5Y6UOZDqaV9t0XzvC41lAW4L4wQeKZJDj
 EC1sZ8StOXpO54uV2WV3EM4VN1idU8Ha0xTSdr/hAD/4w2Mda+z90rfbSvmqg4tieVHuEBcSImW
 4cw0yfswvSWsJS+AcAg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX+COmYYC5RZLl
 kokmlN9pTsKBgcXA4MLuh6Jj07Elg6MC2+IhnaEgK8Pi+CmoN2H1dYEhNttwTk7kWnDoRN3/sAc
 Nu2eM6nVDvot8xXf8VYJSbVS7I1Iynk=
X-Authority-Analysis: v=2.4 cv=PKc/P/qC c=1 sm=1 tr=0 ts=6a994eb3 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=3YG1UsAA5NaYTQao5CoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0
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

Version 4 SDMA selects its system address from the registers also named
as the ADMA System Address registers. Updating those registers does not
resume a transfer that stopped at the configured SDMA buffer boundary.

Resume 32-bit addressing after an access completes the lower 32 bits of
the ADMA System Address register. For 64-bit addressing, wait until an
access completes the upper 32 bits so software can update the low half
before the high half without starting from a mixed address.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260723151853.2143177-12-bin.meng@processmission.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/sd/sdhci.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index f0ba5c11dfc..bd74c60f728 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -786,6 +786,12 @@ static bool sdhci_sdma_transfer_active(SDHCIState *s)
             SDHC_DMA_TYPE(s->hostctl1) == SDHC_CTRL_SDMA;
 }
 
+static void sdhci_resume_sdma_transfer(SDHCIState *s)
+{
+    s->sdma_boundary_paused = false;
+    sdhci_sdma_transfer(s);
+}
+
 typedef struct ADMADescr {
     hwaddr addr;
     uint16_t length;
@@ -1257,14 +1263,15 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
 
     switch (offset & ~0x3) {
     case SDHC_SYSAD:
-        if (!TRANSFERRING_DATA(s->prnsts) || s->sdma_boundary_paused) {
+        if (!TRANSFERRING_DATA(s->prnsts) ||
+            (!sdhci_version4_enabled(s) && s->sdma_boundary_paused)) {
             s->sdmasysad = (s->sdmasysad & mask) | value;
             MASKED_WRITE(s->sdmasysad, mask, value);
-            /* Writing to last byte of sdmasysad might trigger transfer */
-            if (!(mask & 0xFF000000) && s->blkcnt &&
-                (s->blksize & BLOCK_SIZE_MASK) &&
-                SDHC_DMA_TYPE(s->hostctl1) == SDHC_CTRL_SDMA) {
-                sdhci_sdma_transfer(s);
+            /* A completed selected-address write resumes stopped SDMA */
+            if (!sdhci_version4_enabled(s) && !(mask & 0xff000000) &&
+                s->sdma_boundary_paused &&
+                sdhci_sdma_transfer_active(s)) {
+                sdhci_resume_sdma_transfer(s);
             }
         }
         break;
@@ -1401,10 +1408,23 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
     case SDHC_ADMASYSADDR:
         s->admasysaddr = (s->admasysaddr & (0xFFFFFFFF00000000ULL |
                 (uint64_t)mask)) | (uint64_t)value;
+        if (sdhci_version4_enabled(s) &&
+            !sdhci_64bit_addressing_enabled(s) &&
+            !(mask & 0xff000000) && s->sdma_boundary_paused &&
+            sdhci_sdma_transfer_active(s)) {
+            sdhci_resume_sdma_transfer(s);
+        }
         break;
     case SDHC_ADMASYSADDR + 4:
         s->admasysaddr = (s->admasysaddr & (0x00000000FFFFFFFFULL |
                 ((uint64_t)mask << 32))) | ((uint64_t)value << 32);
+        /* A completed selected-address write resumes boundary-stopped SDMA */
+        if (sdhci_version4_enabled(s) &&
+            sdhci_64bit_addressing_enabled(s) &&
+            !(mask & 0xff000000) && s->sdma_boundary_paused &&
+            sdhci_sdma_transfer_active(s)) {
+            sdhci_resume_sdma_transfer(s);
+        }
         break;
     case SDHC_FEAER:
         s->acmd12errsts |= value;
-- 
2.53.0


