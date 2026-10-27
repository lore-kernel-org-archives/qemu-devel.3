Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F5E606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FNFe5M5L;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DY2BvmTw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmmR-00018w-77; Tue, 27 Oct 2026 15:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmmG-00015T-GK
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:24:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmmE-0001mr-VE
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:24:08 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIIA433486342
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:24:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6AdqAo4llWmP1rCkVU0PS97jOSHLKkWsUiZ31bCQoIY=; b=FNFe5M5LmskZfQPS
 L49ODenY8iE3JgbHT7WlU7nJ63mh5j2yp28fxJOfdBpo8DtPn6F/J8KChzrD2/vd
 vENYXwxpFMpakXGmC2Pecu025heJ/GtEsxUcroYbUArbHJvWY0vVp6UkPCH6eWp7
 7uQBjP7OqxnEn4UAhE6y6VkRyme5tXrHbNjxiOO/ONSxr96jKQ9XNsdS6JsYsx4Q
 XqHOklrFB/tDK1i2dyrHYLLIbTZRcBXsUQg9W7YJTqFfwuqb7hbcaU2UvcNxOgCB
 mgHwZh+xPOWYjf+iofWO69BbYWlckOipWyPDfd246F+RtrBN9Zw5Jq7XR2YKHdI+
 Wvnl1g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjjbtc2nx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:24:05 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f559420f3so13639585a.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129045; x=1793733845; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6AdqAo4llWmP1rCkVU0PS97jOSHLKkWsUiZ31bCQoIY=;
 b=DY2BvmTw/nq3q92fjQMYf9xG/wMS0HeJZGnEHP9wwwIwFVKAO6nxFkgs3CxH2lHtwK
 VnYTR/xT8sYWzjLWvETvTSxIQmtmpT4bO/wHHo7q/DHINqDcMnQAn1QYcQuPlStcpmDF
 46YGr1Npi/q8ePsHxsCuB4yRIwlLPCbxap0zsHMNetFdvc2VWvexvR8HCce3ni8/+dRy
 F0pKe0vR64QL5J8CcSy6Z88JsKXCzKFTc8Hm8AZabd7TcuCgBzQiWyQNuE6nTqb4gIou
 DEq6yN2oRr0enJGSaX3rBu9jb6s6QLDbuaCIskVfb8cQkQVrLFHw+q2SqCUcmynu54rm
 i4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129045; x=1793733845;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6AdqAo4llWmP1rCkVU0PS97jOSHLKkWsUiZ31bCQoIY=;
 b=MOeTOuBq3k0yWlLh4QZrw2X4m6US4y2AXwUJBahBbvG3EptkHR4nkBBV9T+VGJfgnq
 7PYE0Nds31hfQzN5zuWsRVTTNpR7vIoL+icn5FeRqLEQNNVoXhhljRKabEhWcepErc3L
 4IwE5Xiz6W2b/T5omVE/y/UnvDiV+MebfVmVikqH1nVyPeikwjee0zeeiq7/ON9E0ynW
 nlVslI7MQzFUPmTuIkSGOBwq1v4hGZcDu6ZD0TiGyfNDYcGmxpFd47dSnmJNfMzt5G6H
 zre7n5AYm+JlWty+dae1y0yVRB+P61e+bbRFHCNZhuRcq3S1+c05YDNnj47Fe1KLHOUn
 zKgg==
X-Gm-Message-State: AFq9FYLYacW31EJptxPaw708XuxMMG473PlQA27myxujDojsrSkzlOFo
 Rr7FEHIkWV8ngMm7TtmXhVnt6up3sH6QBGWu8wQlYZz145fbpdZaqlPMMSfCGv4X/MUHjC9KYrn
 +Tnt//aS6LUfXhxvmfs6Lnyi7KjEWMnWxm+LQM0pWwFVlm9N5wuHULFntBRlHtRa/xw==
X-Gm-Gg: AYBFou2CCGWmVmA8gv0qKaJZu4knT7MoUzuCKvsUMT+nng5YSA2pfAQv5uBarzsxMSt
 8WfCXgRb36q24JXpi6CBzlX6krZz3nRtkjkk3bXD7AExHPGXpPzbWchXtXFKOXGnYrvXD32a1KU
 zsX7nQ83nsR7MXr76vpaCFxMN1Nzp3ijKzoq6D3eIC6quG51gj9IGk3CYwHAH8MZ8GuHDTdFSf7
 duEDHgFeLfHTK8zOwBDfJLnVUTCpV+2safQMATrCWwJ96SSj+wIvnB4yHTtUi8OEt4ijnLZxC/1
 ArypS151X9dd4M6rzFd9ZHyOY1KXjxP8sybrcAJXHm5rHiJ6vdkuMzwiKTj/WtUjRvlSDCZpeXo
 f/RoeP6Wc7FLI+fn7HRzj8evYjxYJ0SMhv+fcQCZC4leAuGDSaNZQCZS7
X-Received: by 2002:a05:620a:a407:10b0:943:e946:8c6d with SMTP id
 af79cd13be357-943e9468f08mr778782085a.72.1793129044758; 
 Tue, 27 Oct 2026 12:24:04 -0700 (PDT)
X-Received: by 2002:a05:620a:a407:10b0:943:e946:8c6d with SMTP id
 af79cd13be357-943e9468f08mr778778585a.72.1793129044172; 
 Tue, 27 Oct 2026 12:24:04 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a94e1dcd1asm2442115e9.7.2026.10.27.12.24.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:24:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/59] hw/watchdog/wdt_imx2: Preserve own locked bits in WCR
Date: Tue, 27 Oct 2026 20:22:44 +0100
Message-ID: <20261027192341.9197-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3NyBTYWx0ZWRfX9qQCMBuM7SFg
 H/gaOg91EGk2qbqAK7alAn4oibrkzfRJKujAtEG8kd+IEpOGRYDmQxK5I4nZZzl7ROILoEI3LFT
 X2R/4OT0xd6BMDTacC38V7kapdu6Aa4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3NyBTYWx0ZWRfX55M0/CpXnwjI
 uLXJiVXFWm9qQV6oVB1vg2sShtLgpDs4h+E6tr0b/8jEsJzHmr3NB/0PDPPVYmkzrO8+Q70Bq0e
 WNImS+J17Hi07FDfg71OTEI83zwEN5dWa7pVfgz7wR53yYKL1uC/b/pP7ppTIthCxh5yNT/ox3T
 EsdFOAb9mqMfzisXTpbNNfcLHERgczN52/962W9Fhu87WiZmJJ7ckdoDdXDDh87FojUPU4b2BJx
 cUhAqa4AyB2dnaAp4E75c1N04v7Cib74jkf3mv8ZMR+44JQsr7MpJnoJb5PYjNL1s+DG58ctOAb
 0Fla+ziapld7d+E8zDN6rsgbw8sdtW7Yl9gaB4WWvNxWHExjsCnwIl8xxYaA9sOXjBZxDsBDmHd
 7Yxhx9YR6WdvU/RI1Xiu5wIZHpACyIQQZ2mLJbILYYT39DoSFikWEt86cPecoycvzWtdiS9/hFu
 YNR9RFVcjuUKqXALeBw==
X-Proofpoint-ORIG-GUID: TyW3ytFlf4pfUIzi-LzeE8M7WEeA6gjW
X-Proofpoint-GUID: TyW3ytFlf4pfUIzi-LzeE8M7WEeA6gjW
X-Authority-Analysis: v=2.4 cv=XaIcX455 c=1 sm=1 tr=0 ts=6ae0fa55 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8 a=FRSEYCzRAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=OQTJR_iXj6gm-c6kepUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=H4N_Y-AU75W7NKDNhZlT:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270077
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

Apparently there is a typo in the WCR locked bits handling: The locked
values for s->wcr must come from itself rather than from s->wicr, so fix
that. Without it, guests such as u-boot may experience inadvertent
reboots when configuring the WCR register.

Cc: qemu-stable@nongnu.org
Fixes: daca13d495a1 ("hw/watchdog: Implement full i.MX watchdog support")
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20261006083445.30362-2-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/watchdog/wdt_imx2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
index c83d4107c19f..3283990bbf88 100644
--- a/hw/watchdog/wdt_imx2.c
+++ b/hw/watchdog/wdt_imx2.c
@@ -156,18 +156,18 @@ static void imx2_wdt_write(void *opaque, hwaddr addr,
     case IMX2_WDT_WCR:
         if (s->wcr_locked) {
             value &= ~IMX2_WDT_WCR_LOCK_MASK;
-            value |= (s->wicr & IMX2_WDT_WCR_LOCK_MASK);
+            value |= (s->wcr & IMX2_WDT_WCR_LOCK_MASK);
         }
         s->wcr_locked = true;
         if (s->wcr_wde_locked) {
             value &= ~IMX2_WDT_WCR_WDE;
-            value |= (s->wicr & ~IMX2_WDT_WCR_WDE);
+            value |= (s->wcr & ~IMX2_WDT_WCR_WDE);
         } else if (value & IMX2_WDT_WCR_WDE) {
             s->wcr_wde_locked = true;
         }
         if (s->wcr_wdt_locked) {
             value &= ~IMX2_WDT_WCR_WDT;
-            value |= (s->wicr & ~IMX2_WDT_WCR_WDT);
+            value |= (s->wcr & ~IMX2_WDT_WCR_WDT);
         } else if (value & IMX2_WDT_WCR_WDT) {
             s->wcr_wdt_locked = true;
         }
-- 
2.55.0


