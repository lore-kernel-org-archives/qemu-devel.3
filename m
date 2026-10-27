Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEB6606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nIOK24ww;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fVv18hfS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmrI-0004IT-JT; Tue, 27 Oct 2026 15:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmqu-0003ky-2j
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:29:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmqr-0002Pw-2Y
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:28:54 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHRl72639301
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:28:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KGtboOQOOdqOnEdyTBcrFbLqK8xKlDhoziyQ2g4T6Tg=; b=nIOK24wwIm+uKYIW
 +ZgTs1m83O5AuOOhnqkMmbK3Nn9xPAifIvcYemgZ12gBd10/BSD5p0UgErC8pk1h
 pV6PaWBbkHRDMxvBpBSNl9NjgjhGxcLwzyczXxA6vKSlUVxLLI0M5sUIxy4jd9KM
 IM7xuNGa3MEA6AkXVhPygy09eazbmVqTbu2euGljcQjB3VlSMjCAShW+lxWXamOi
 hKmYrSnUSMZlX2U4SD2I90eAnjYEL783ACtPfslu+6u7P4M7Hb6uDM5zIoLdnLSC
 8Btb+RQ/SLbhximCOTIKU3NZSapd+Js8U3ngeqcQ0AoB91K6v7JvBlLWKWpNPMnu
 uKnqow==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjqf5u21k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:28:51 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f2373e9b4so14224585a.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129331; x=1793734131; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KGtboOQOOdqOnEdyTBcrFbLqK8xKlDhoziyQ2g4T6Tg=;
 b=fVv18hfSwUvZ05b8cC5xVyW6AJXSPD5b9X46ZWs39OPGeuH5iM+rbrsvkw0m6Dvdig
 jN4RAI62UiVwzcYnHShMqyZKfj+xdwJarhW2AQ2u9SG/Mlm0TXt8jvIo/iHrXZPZg4zT
 Q6j0LdsQKSyCJKZCDuzuD4uuobPY6rglH9T5Zc8oM0edSxyupRkrCfrAuBopO3BZJ9SH
 9CUJSh27mkpqBlViXVVzK/ohojbHXeYBYfRwDWgnfR0lI9Wo3KBnAJ2uU1QMvZ1sq9Ai
 xTVq3g4C5GgQjPHnII1ysM38tLAS+VzYh3vY1nWO0K6xBMktLanwkfICtHtcXcUahMZe
 XZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129331; x=1793734131;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KGtboOQOOdqOnEdyTBcrFbLqK8xKlDhoziyQ2g4T6Tg=;
 b=A+AU7cqr3YkLfCOoO9wF1eTj9SyHkqOVS3s1fzOWu+wqqolXd6rRG8QByVvPInQKmB
 /xMB5O8hurUsUaz1ftkH+jcujnjW+kLcdybjm+1JpkfX4ZJ21pPQRAA/wQYym89C7LeE
 dLc1dufa1xvLGN9eII2ZP0adeipnzOrSSd11K094AcvCVIbd2W32pkUsZWnrXRykYsZp
 5P4bmGU6X3jDuGRUFvSptClibIXmwsZLWRhMvx1KYkqS6tEebddbrVbVf7ypmJJotHBs
 qBdoIZ50RaquZHP3UXu5JEA/Q76qWVdFrwrXqd08SU/GXaZ7wj3YCJyneUywDvKrZEeO
 kPxA==
X-Gm-Message-State: AFq9FYLY7Ef+c5kpu756NpaAR/5LVCz/lTn7T1ekvj4QHeEGkHgBKx9j
 O0xyrKgFgbBHpI17+J/yv0JPZsLG858DFeCJfvb/gQVFyuZiIYG8ZuIEcj2Xn0Ujs1ROFvF11xm
 K2ovYGZt7M9v4lDkYEGZLILRGm31fftPv9ISdDqVP5aq/E0/da2i3dO4WeulqrPjq/A==
X-Gm-Gg: AYBFou2YuCxLKAUfyiCtDVo6QELbBSs+JdaihYjPDqwA+yy+hd5y7D3/HQsZQvWhCaH
 hrQDlOEKsUwy/mLxMFIIhvTwMciT+U6eWpvIZ9TMEQ5oU96vLK9twuvDLNFbWH2bi5d04R7pAw8
 rxrAq7s/pvTo95RrElvjhGBqNXyWg1dtrsXNonolt1YYIaH/T6vquBQW+pxkSLrm9ijGWsrDz23
 3Ygdi8z2DrZeXlT6g0o3B+j14lJNqPFJ8Brmzv4O8HDBjcEobFmARa/V/5r5B4quke+oFMQ+LNP
 uOPn9J4c2m4Fc5IfVCCFDl/JJykPbDYHTQ4Udjz0679orU5pShWLGjMkX3j+OEgQgREC3rve3Wl
 CwO3D1CRO+6rH70r35doFN3BJqDkDUHRKYDcYwZhEvcmcvfT4vChAsCCF
X-Received: by 2002:a05:620a:2621:b0:93d:23b3:5088 with SMTP id
 af79cd13be357-940ef914145mr1689459285a.16.1793129331230; 
 Tue, 27 Oct 2026 12:28:51 -0700 (PDT)
X-Received: by 2002:a05:620a:2621:b0:93d:23b3:5088 with SMTP id
 af79cd13be357-940ef914145mr1689455485a.16.1793129330709; 
 Tue, 27 Oct 2026 12:28:50 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3bdbsm20040331f8f.19.2026.10.27.12.28.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:28:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 45/59] hw/watchdog/wdt_imx2: Trace with QOM path
Date: Tue, 27 Oct 2026 20:23:26 +0100
Message-ID: <20261027192341.9197-46-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfXxHmW7v8vshwd
 Uw8GM3fDzHJ4ZrbBdZ0S/5xG2jBaGDQxVPh0RGEXfB/k6QVSE2LHw5wURO/OqZGLHL2uFjeWgvm
 lcS3ynQ9i9fRGg3a6s8VNmiOGDE8fEE=
X-Proofpoint-ORIG-GUID: ECUG8sedOkrRe6BVZ7XkawwP_skMLNng
X-Proofpoint-GUID: ECUG8sedOkrRe6BVZ7XkawwP_skMLNng
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX54Sd+04IalDk
 ul8Eicm8Fzbnh3B2if5rWWQK1kDTWvswRhEbyS+d3qnzEL0IDFtalCtSxlfcqOvRydz0DJwD47L
 47FJ7csrbgqqdD54ufxcqFHi0t9qni22o8Uu4z0ZRjQRs+ca8127+tdlVgRZTxAED74xPs/HpV4
 J0JmBFN9dt1LI5Op1Qx/KCQ/xaVXwRMZ01+BPhidkcQCWB7OZt9fsFXeYu8IM3+6+vyxpFSOvtb
 Ym+oE6dCgL7jDKnjCLDvFhd4vpZQz5SP6xgKiQQ1cvRPA9/fSA7N2njUvzVKs5f3lO8riv1PK5n
 cPUUF8fBiIwWmf9QfQnWoOHmoHUydZjcM6LOiSVOlaQ6tp9hyZz0gKOu5moxKXszMg2wAdEi0pV
 XvsByx6qSmueG4F3mZdjpIRQ59GSPWxmGYaSmr1IBv0/bY2Y/FlxZqNyazE8z0gHpGOA2wcOVCX
 V8ORh49NJ9QOVb3V5Jw==
X-Authority-Analysis: v=2.4 cv=UOFIjyfy c=1 sm=1 tr=0 ts=6ae0fb73 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=3Yd6l86sBrAyeg_TsFQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270078
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Bernhard Beschow <shentey@gmail.com>

SoCs such as the i.MX8M Plus have several of these watchdog devices.
Allow to distinguish the instances when tracing.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260921214710.29422-43-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/watchdog/wdt_imx2.c   | 8 ++++----
 hw/watchdog/trace-events | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
index c19f0383ad74..f8129625e582 100644
--- a/hw/watchdog/wdt_imx2.c
+++ b/hw/watchdog/wdt_imx2.c
@@ -23,7 +23,7 @@ static void imx2_wdt_interrupt(void *opaque)
 {
     IMX2WdtState *s = IMX2_WDT(opaque);
 
-    trace_imx2_wdt_interrupt();
+    trace_imx2_wdt_interrupt(DEVICE(s)->canonical_path);
 
     s->wicr |= IMX2_WDT_WICR_WTIS;
     qemu_set_irq(s->irq, 1);
@@ -33,7 +33,7 @@ static void imx2_wdt_expired(void *opaque)
 {
     IMX2WdtState *s = IMX2_WDT(opaque);
 
-    trace_imx2_wdt_expired();
+    trace_imx2_wdt_expired(DEVICE(s)->canonical_path);
 
     s->wrsr = IMX2_WDT_WRSR_TOUT;
 
@@ -90,7 +90,7 @@ static uint64_t imx2_wdt_read(void *opaque, hwaddr addr, unsigned int size)
         break;
     }
 
-    trace_imx2_wdt_read(addr, value);
+    trace_imx2_wdt_read(DEVICE(s)->canonical_path, addr, value);
 
     return value;
 }
@@ -149,7 +149,7 @@ static void imx2_wdt_write(void *opaque, hwaddr addr,
 {
     IMX2WdtState *s = IMX2_WDT(opaque);
 
-    trace_imx2_wdt_write(addr, value);
+    trace_imx2_wdt_write(DEVICE(s)->canonical_path, addr, value);
 
     switch (addr) {
     case IMX2_WDT_WCR:
diff --git a/hw/watchdog/trace-events b/hw/watchdog/trace-events
index b388f7b2506f..5963943d5dc2 100644
--- a/hw/watchdog/trace-events
+++ b/hw/watchdog/trace-events
@@ -18,10 +18,10 @@ aspeed_wdt_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
 aspeed_wdt_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
 
 # wdt_imx2.c
-imx2_wdt_read(uint32_t addr, uint16_t data) "[0x%" PRIx32 "] -> 0x%" PRIx16
-imx2_wdt_write(uint32_t addr, uint16_t data) "[0x%" PRIx32 "] <- 0x%" PRIx16
-imx2_wdt_interrupt(void) ""
-imx2_wdt_expired(void) ""
+imx2_wdt_read(const char *qom_path, uint32_t addr, uint16_t data) "%s: [0x%" PRIx32 "] -> 0x%" PRIx16
+imx2_wdt_write(const char *qom_path, uint32_t addr, uint16_t data) "%s: [0x%" PRIx32 "] <- 0x%" PRIx16
+imx2_wdt_interrupt(const char *qom_path) "%s"
+imx2_wdt_expired(const char *qom_path) "%s"
 
 # spapr_watchdog.c
 spapr_watchdog_start(uint64_t flags, uint64_t num, uint64_t timeout) "Flags 0x%" PRIx64 " num=%" PRId64 " %" PRIu64 "ms"
-- 
2.55.0


