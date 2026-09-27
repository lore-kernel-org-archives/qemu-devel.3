Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D0AEC98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 07:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAjNL-0007nh-0k; Sun, 27 Sep 2026 03:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAjMs-00071x-L4
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 03:32:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAjMr-0006Sq-1i
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 03:32:14 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QNtpuP1075724
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 07:32:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tJj7Q4vyTC4ryc/tp/F7NMBFMsbaQtNl+doQfYMt0hM=; b=G8Wfp21MIxWqwLJH
 ZwxLn2E1KwT/7hsT0JbRtwNxvVJg+EpK4dAC8hLRUpgYiWiK98Nd8cYuINbI20HW
 FCJrJ611a1cyeXc7tjWJCTd1ya0FlDO+s97n0ISZOxy9T53TY4hFs/cjs5zh8yWu
 dkO4ldqqp0aZBRA9usj0NihKdJk7nP52bm+4/4CYZgT07cG0/F+WyQo73Qv2Sg8f
 ZIgJdB40ToxsamYsCmcbIGDHiUP7yAab79oP85TqDCneLtmJ+GoSFuW+/crsOMGf
 lQY1JnRCzkQAUiyhZwTtCets0vQFty5KwHhuyEXYHYL6gE9BX+TzC2R/Y+SHopET
 sjW62w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx3dp2ue9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 07:32:12 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93c5d7c4c26so223151385a.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 00:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790494331; x=1791099131; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tJj7Q4vyTC4ryc/tp/F7NMBFMsbaQtNl+doQfYMt0hM=;
 b=iXBqLWa/64RHTyUSZIfXMUXo/kSck9kHueyEUPfsAlzuBCNdZfh4O7SyBuJxPnRXIg
 dqauX2IEmsuXY52jNbmkihQYSkNZgiUS1P/zG3LOSn+Afe4QgK3vCfvSJMaqT5BnHWme
 gwyumiN2sXj1nwGONUzT4S0Uv18VCD7nffM63K6+GFq4Y4dEvQHW+E+A83m6Vf3h5E1d
 2CFC9zIVq/aVRlOf761Q75ZR8B2Vivam8VAQ/mIw9xODEiLwgMBuSYsbe+PGaurr16ic
 09g8eCTwxg7ROOpGURSDVjWJ2hRX7KK4zSQZ2ARMwSbBsjCpTMmaUS4jwUjAQVuAO6hN
 roDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790494331; x=1791099131;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tJj7Q4vyTC4ryc/tp/F7NMBFMsbaQtNl+doQfYMt0hM=;
 b=k2/5oN+T3PAKl9bJTK0kr1QTetpgAsEXFVatRSq6Qs6C7yZC4kg9i43494k992fVrs
 ovlW5TOVRg7UsD03/knVbVjyXGE3bdZAE5H/bNAenDCsv8bhWkWQAHQKpvnATJctyEeS
 e/HkICMgLT5+goeJ3r4/JTTkC12uVrWK7FqFMvX0qoUZFFsG9BFtgg5TcaU1xy3hBO7t
 nNFj3Cm0ogdPElQafUFsov+t+E05eBXDCwSt0zHjbLCebe37x9YnJrc0jxp/Cdf8nIwj
 DXc4nySx1tWhtDDhN8K68TpHWwLZ93dHPhiCcpAjE2RYsCKZBY50rNW5oDguxqze4DvE
 l0Rg==
X-Gm-Message-State: AFuF++kPG9jeI41oCGcDfEnqWf+vx3PBQjE5QaVO8wLlZWTZDniUG942
 1Pa5xJ0kkYukxIO/P9Mr8jUgxtfsIE4MU3OvgusjwKO0UzHf3SlEJb4MsCf/bP3JUkFkMEOm31R
 nsU1il1buXH4mX3v6Pt9J47GmQZVzqBhgycQVrx6/fm+o6niOy/DgUkGmq3+6RW6UTQ==
X-Gm-Gg: AYBFou3r92C1OxT4Gy91LXxRFfCF3ox21mjJ+OwXEin0AruDR1bdwPuyhEHtLDYSfsS
 A+qP2eRy1S/ofqiduABzIzOUygfvORxpxfIEgfVYvDlvv3f9E6GUf7GNlxJpt4x7ym8K2+8nEfa
 5AY+v/faDR7x+Tvm56Kq2KafDale9Z2Nke1D11wYDH7YaiObdBpdblnPXRX7pXCDYRkRJrdHJEi
 NA/XGFj0VsCRIUcpJ3s88/2aL/yC47VHto2ujlXHUyovx22ui1oVsfMFBy+xhkAbC0cdo/4sl+G
 UdzgROKVSbiktJhukAhGpe0nTS3M9CEbIWIGxq2VbxyaFUgXkvH1akN4UXaFTXh+e0+gvflYVk/
 fzCVZMFNFk3ptpDp9gjEpxm2QHAN8FgjxO4mVke91
X-Received: by 2002:a05:620a:470f:b0:93c:62a9:d5d8 with SMTP id
 af79cd13be357-93c62a9d6aamr512950385a.39.1790494331566; 
 Sun, 27 Sep 2026 00:32:11 -0700 (PDT)
X-Received: by 2002:a05:620a:470f:b0:93c:62a9:d5d8 with SMTP id
 af79cd13be357-93c62a9d6aamr512948685a.39.1790494331152; 
 Sun, 27 Sep 2026 00:32:11 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a746c57sm17618541f8f.35.2026.09.27.00.32.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 27 Sep 2026 00:32:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/9] hw/macio/mac_dbdma: ensure only implemented DBDMA
 registers are accessed
Date: Sun, 27 Sep 2026 09:31:35 +0200
Message-ID: <20260927073140.41422-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927073140.41422-1-philmd@oss.qualcomm.com>
References: <20260927073140.41422-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDAyOSBTYWx0ZWRfXy+nq4HOz/rvx
 7V9NZ4fRCzG2UOn4Xbu3GmhoMIX16W4MJh+erokDJjXjytB8bPng/jJw9RDMvuCmOklYtDA2l+G
 pTAeXCO3ayL+6b6VaomeEjKIoh+G3ivwJ+nn+7al1NWzK/ycAN8F7/NNB1MLKvjI6sZq/udzgem
 EO+NGpsklqmW+NIIm2/ldLup1uhul6gLx7wyryHZyp5hsSJJxNr6aOBvoNeTVgBG/fzr7YyX/mK
 27zraIkgy0G1LO4ddUyZnYyhUAwB0/od5fVmMmC/NRFFsjG37/fAFn0HDDT86faVcYFu7eyvGW+
 lHc7jiCMigYQPcxlXOCpTYpnP/HNQ1cX9GL69oACsRSF5gtcxMXhZ/4or6OdKX4O9nXYJUCUXmz
 xEU5vbul0Kca9KTYy1UKJmjrivusSaDw6U4ihYMWaUtZvVwqTT09YMcRJuuYLRv/ZbiAPR5Up6V
 +WYc/yxj94/5mTZYclA==
X-Authority-Analysis: v=2.4 cv=QsXLTlyd c=1 sm=1 tr=0 ts=6ab8c67c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pcZqCyVeAAAA:8 a=EUspDBNiAAAA:8 a=kOx39PzbhEYiDC7fm0kA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=SGy6VSG0Ue1xmPAwIFl9:22
X-Proofpoint-GUID: n-We5rFH6ruYy9TQypjVfxo8iVDOA-2s
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDAyOSBTYWx0ZWRfX6b/a1LGj9JiH
 PjLLYdy9wtzpjzV3FtHvHlh9gfmhqyEyAQLP5qbbl9Zid+0wrAcpbNDHlI34HAlTWMvEBeZozkz
 843tjguzIEbcxt57pFt7RZQCRW+I9Ik=
X-Proofpoint-ORIG-GUID: n-We5rFH6ruYy9TQypjVfxo8iVDOA-2s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270029
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Whilst the DBDMA memory region is 4K in size, only the bottom 16 registers are
implemented in the Power Macintosh DBDMA controller. If an attempt is made to
access any unimplemented registers then an out-of-bounds array access occurs.

Rework the switch() statements in dbdma_read() and dbdma_write() to handle each
individual register access, as well as providing a safe default for all other
unimplemented registers.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260914125236.820155-1-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/misc/macio/mac_dbdma.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/hw/misc/macio/mac_dbdma.c b/hw/misc/macio/mac_dbdma.c
index a55c9c99824..d00181b9781 100644
--- a/hw/misc/macio/mac_dbdma.c
+++ b/hw/misc/macio/mac_dbdma.c
@@ -715,22 +715,25 @@ static void dbdma_write(void *opaque, hwaddr addr,
         return;
     }
 
-    ch->regs[reg] = value;
-
     switch(reg) {
     case DBDMA_CONTROL:
+        ch->regs[DBDMA_CONTROL] = value;
         dbdma_control_write(ch);
         break;
     case DBDMA_CMDPTR_LO:
         /* 16-byte aligned */
-        ch->regs[DBDMA_CMDPTR_LO] &= ~0xf;
+        ch->regs[DBDMA_CMDPTR_LO] = value & ~0xf;
         dbdma_cmdptr_load(ch);
         break;
     case DBDMA_STATUS:
     case DBDMA_INTR_SEL:
     case DBDMA_BRANCH_SEL:
     case DBDMA_WAIT_SEL:
-        /* nothing to do */
+    case DBDMA_RES1:
+    case DBDMA_RES2:
+    case DBDMA_RES3:
+    case DBDMA_RES4:
+        ch->regs[reg] = value;
         break;
     case DBDMA_XFER_MODE:
     case DBDMA_CMDPTR_HI:
@@ -738,12 +741,11 @@ static void dbdma_write(void *opaque, hwaddr addr,
     case DBDMA_DATA2PTR_LO:
     case DBDMA_ADDRESS_HI:
     case DBDMA_BRANCH_ADDR_HI:
-    case DBDMA_RES1:
-    case DBDMA_RES2:
-    case DBDMA_RES3:
-    case DBDMA_RES4:
         /* unused */
         break;
+    default:
+        /* do nothing */
+        break;
     }
 }
 
@@ -756,8 +758,6 @@ static uint64_t dbdma_read(void *opaque, hwaddr addr,
     DBDMA_channel *ch = &s->channels[channel];
     int reg = (addr - (channel << DBDMA_CHANNEL_SHIFT)) >> 2;
 
-    value = ch->regs[reg];
-
     switch(reg) {
     case DBDMA_CONTROL:
         value = ch->regs[DBDMA_STATUS];
@@ -767,7 +767,11 @@ static uint64_t dbdma_read(void *opaque, hwaddr addr,
     case DBDMA_INTR_SEL:
     case DBDMA_BRANCH_SEL:
     case DBDMA_WAIT_SEL:
-        /* nothing to do */
+    case DBDMA_RES1:
+    case DBDMA_RES2:
+    case DBDMA_RES3:
+    case DBDMA_RES4:
+        value = ch->regs[reg];
         break;
     case DBDMA_XFER_MODE:
     case DBDMA_CMDPTR_HI:
@@ -778,11 +782,9 @@ static uint64_t dbdma_read(void *opaque, hwaddr addr,
         /* unused */
         value = 0;
         break;
-    case DBDMA_RES1:
-    case DBDMA_RES2:
-    case DBDMA_RES3:
-    case DBDMA_RES4:
-        /* reserved */
+    default:
+        /* unimplemented */
+        value = 0;
         break;
     }
 
-- 
2.53.0


