Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 631E7C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5bK-0000Cm-3c; Tue, 07 Jul 2026 09:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5bI-0000Cb-CN
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:12:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5bG-0000Pk-L8
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:12:36 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C9F3e3590494
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 13:12:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eOKDwqSOuBZJrV4MX+PcvhrBkSUij57ra62E/Hh8P/c=; b=SIrFbeqAWUIcohYD
 3wKZcfow6rYZR0X34ZWoOBmMByJKdj3bY2U0hsx71L5XYZCq6Z+WPLbqZBIqBGgy
 DgUHTDkPYf/17r1rv9jRcIXVKKMKejnbjNAs4qDDHWqba4ObKXK3cr+vKpem5Ci+
 U48H2eya9mti///nMDJjR59HmgLEscLzZSHTgS5L/2U7q+cTUxKzfLB3z5CE/0Wy
 6QeCtktnjO0MLmj10H3U+JacbPPeA5kDC8CZeIwqIOr8YhRjchdViEz0eJgTCua5
 Xqes5FwVtFtbufqBpJI/yA1eKVvR0SllA55WyWDh8obnLkPT6cC8MMqnHnd+1Tui
 OannVg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8w2u9bcj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:12:33 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c075c1e25so32054161cf.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783429953; x=1784034753; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eOKDwqSOuBZJrV4MX+PcvhrBkSUij57ra62E/Hh8P/c=;
 b=d8s65s1MMtE1vvWyrnN3UGdPTkpsBJz0taKf00kGM+QdHVlkKRLb44PvcAcQAQS2Sl
 gWzhwCHhl06gL2RzM00sIbOXs4O7RNowS9WC9clWjGz7nZzmmDTlRs+juBAnnJ/8UMEP
 LQNuO7cKiNBo0nvteQ48nLEw4MdSMrMUqYJlVhUVuQ0C7Vn8imRkKer9lNq5RLjFL6Uu
 SMCFIjNIwyRe4IU0GZHAYq/Uyvb00P34Z+9AcpiLWYUKSRUx10ubgqXmFWrcFA1/TKzj
 sKC/X2fpWQhzwwNyG6u2/tEwOIL/raydfFYFLeHTojKG2rXdphOCaLwwQYWAaaBxdNRi
 f5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783429953; x=1784034753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eOKDwqSOuBZJrV4MX+PcvhrBkSUij57ra62E/Hh8P/c=;
 b=eAhCeVisrsv8vT3VTq5ld5FznXpAYAWA7nC7DSgAqaP73cqQhntrvnUYUuA0U30mRZ
 ayf4AIKfq2pVIGVYGnnCFtV9eusv8geatbrDi2amcHb+HUCYnxqHKJko0aVV6yqFxBto
 B7lKMefPje/zmYivuGISDQU9IwoSmqN2YaGnI3fiXQRADLzLb30PabsHeqta8Sx8cZgD
 04G9dshsYDllQwjfhyo3WKht6jjsTznNjTWopw1QbZ085Y8bRVglwlonNaosD/E4RK2h
 4LR85VPupY5e5dr8/W1Dsg7uz+x6mmUUQ+GjNI09N/zgdMVVEMqrW4W3p/sj9I7wXGn+
 VdtA==
X-Gm-Message-State: AOJu0YyrJUW7/qQjhSOVKMI43/ORCcrtpcveFtpBbzhnap3RkLX3kgM9
 9NJr6kQW4ltu2AOpH28QlfI1xS0SfpxkOjoyZywnqU41CSHIaDQx0mPPmV2CprjWvjnirO3z+2r
 Cns7XYwtP0a8h4cqfykHTwP+9XBfuCmOBqbFpy+X8xGTAb3V8Ho02m1GsFkLUM35WuQ==
X-Gm-Gg: AfdE7cnEQqMuz0PkVL3QkxwN2XoDArhqL/t4E7YbnppIrbhSN46Mri/ahGHHGd7Cz+D
 NrKt6nBIm6pujI6OxKk0miajoB9kCUzWn2YulmmlSxfX0ls/UlsKNoyYktBZph7J2i101ZCJc6K
 kyfljvQx+C36ot/LXm6g3TgCuFDWvFlfDnDOF73OpDYo6B4rBczfImAisqZhEC1y/GMwqRZuRSf
 5IzNNvGyRU2w5glJgvg88CkGmzaWPqIWjXqJqOPzh/ZFNp6IqkPycpncTtgHDUmZ+3wG5gZtnvJ
 bF1iK86E0HS1/BT7yVCu2g3dKczKBvKb1bG8On5JBgarDkvNcXFlVXQ3h+Rm/BzCjNjb23jKvMw
 aS6yBMI7liXM55VWHHacIApE5oFyVjzL8BAL419jThONlCHULY+i0pMmkvWO9BghUisGj
X-Received: by 2002:ac8:584f:0:b0:517:8711:d46c with SMTP id
 d75a77b69052e-51c7481d84emr55564461cf.31.1783429952821; 
 Tue, 07 Jul 2026 06:12:32 -0700 (PDT)
X-Received: by 2002:ac8:584f:0:b0:517:8711:d46c with SMTP id
 d75a77b69052e-51c7481d84emr55563781cf.31.1783429952005; 
 Tue, 07 Jul 2026 06:12:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69a19cd88aesm5668611a12.3.2026.07.07.06.12.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 06:12:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/32] hw/misc/edu: restrict dma access to dma buffer
Date: Tue,  7 Jul 2026 15:11:51 +0200
Message-ID: <20260707131223.51505-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707131223.51505-1-philmd@oss.qualcomm.com>
References: <20260707131223.51505-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyOCBTYWx0ZWRfX2Z4OPFG0XxLL
 0mlCHR0hSI7d+IiJLLtkfGcNpRhyVGomLp6J/KI5eyeZVT5DIGjrzJDuk5C/WoYHjT9x4d3EeHT
 3Z9gEHHDSG9VxYdL1BviZ+ZzDlaLIJc=
X-Proofpoint-GUID: 2rBkbLgbkf1qVjFFYoIRPnfE6-r1DJNg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyOCBTYWx0ZWRfX2ULHuhbv2ZF/
 HAk2R5ymySTBoRJRbe5jYQeghD3cDL1MquhUTHR3cHOwpvB60VX/muD+rf8Y96tmaFqwnenDjMa
 mpnuNg75gi6VMyfH/SUKT7kz0fnsLXnFwoRaOE82CcOQEwQsMTDYQ7mPxS0jv7cPVgXvcaYC3aI
 LHUryg0Y4NlhLc2PHJk6Kg9H2jmn84fnnha6cfu24vVEUCXkPQQXUejaWmwgtVh7I9nIx2ww1dB
 mGXX31Js/2LeRAlTRIg8tJsX1Y8Pyk5mQprTHXoRoBZ9nw4alhBwDXXBgy5u13hbphhDHd0PWif
 Oemb/wiEaIrQh50Ti49rhd8Iiq2XIya/yuimfPNG7sD6zBHJiLyL2aKv9iVbcHn11MtoHJC3nxI
 viZXibiyPX7L2eQEob8F7+WWTxaifWQPEc0abmmtOSdcODbwA/nvVaVV7CPHJyroTe0Z2RiOkPL
 oSQshr5zT4rAVHTtczw==
X-Proofpoint-ORIG-GUID: 2rBkbLgbkf1qVjFFYoIRPnfE6-r1DJNg
X-Authority-Analysis: v=2.4 cv=bPQm5v+Z c=1 sm=1 tr=0 ts=6a4cfb41 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=p0WdMEafAAAA:8 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=tJWlHokCBnNpzHG-xPAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070128
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

From: Torin Carey <torin@tcarey.uk>

The EDU device doesn't enforce any bound checks on the addresses provided,
allowing users of the device to perform arbitrary reads and writes to QEMU's
address space.

Signed-off-by: Torin Carey <torin@tcarey.uk>
Cc: qemu-stable@nongnu.org
Fixes: 7b608e5d6c1 ("hw: misc: edu: use qemu_log_mask instead of hw_error")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3852
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <aQtAotYvzFY0Vpft@tcarey.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/misc/edu.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index cece633e113..a4b01269e8b 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -103,7 +103,7 @@ static void edu_lower_irq(EduState *edu, uint32_t val)
     }
 }
 
-static void edu_check_range(uint64_t xfer_start, uint64_t xfer_size,
+static bool edu_check_range(uint64_t xfer_start, uint64_t xfer_size,
                 uint64_t dma_start, uint64_t dma_size)
 {
     uint64_t xfer_end = xfer_start + xfer_size;
@@ -115,13 +115,15 @@ static void edu_check_range(uint64_t xfer_start, uint64_t xfer_size,
      */
     if (dma_end >= dma_start && xfer_end >= xfer_start &&
         xfer_start >= dma_start && xfer_end <= dma_end) {
-        return;
+        return true;
     }
 
     qemu_log_mask(LOG_GUEST_ERROR,
                   "EDU: DMA range 0x%016"PRIx64"-0x%016"PRIx64
                   " out of bounds (0x%016"PRIx64"-0x%016"PRIx64")!",
                   xfer_start, xfer_end - 1, dma_start, dma_end - 1);
+
+    return false;
 }
 
 static dma_addr_t edu_clamp_addr(const EduState *edu, dma_addr_t addr)
@@ -148,16 +150,18 @@ static void edu_dma_timer(void *opaque)
 
     if (EDU_DMA_DIR(edu->dma.cmd) == EDU_DMA_FROM_PCI) {
         uint64_t dst = edu->dma.dst;
-        edu_check_range(dst, edu->dma.cnt, DMA_START, DMA_SIZE);
-        dst -= DMA_START;
-        pci_dma_read(&edu->pdev, edu_clamp_addr(edu, edu->dma.src),
-                edu->dma_buf + dst, edu->dma.cnt);
+        if (edu_check_range(dst, edu->dma.cnt, DMA_START, DMA_SIZE)) {
+            dst -= DMA_START;
+            pci_dma_read(&edu->pdev, edu_clamp_addr(edu, edu->dma.src),
+                         edu->dma_buf + dst, edu->dma.cnt);
+        }
     } else {
         uint64_t src = edu->dma.src;
-        edu_check_range(src, edu->dma.cnt, DMA_START, DMA_SIZE);
-        src -= DMA_START;
-        pci_dma_write(&edu->pdev, edu_clamp_addr(edu, edu->dma.dst),
-                edu->dma_buf + src, edu->dma.cnt);
+        if (edu_check_range(src, edu->dma.cnt, DMA_START, DMA_SIZE)) {
+            src -= DMA_START;
+            pci_dma_write(&edu->pdev, edu_clamp_addr(edu, edu->dma.dst),
+                          edu->dma_buf + src, edu->dma.cnt);
+        }
     }
 
     edu->dma.cmd &= ~EDU_DMA_RUN;
-- 
2.53.0


