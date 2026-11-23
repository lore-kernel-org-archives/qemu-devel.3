Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ADF606A322
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 22:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PTODh3Si;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hoOdD/io
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVcwI-0002Ps-5d; Mon, 23 Nov 2026 17:55:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVcwE-0002FY-M4
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 17:55:07 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVcwC-0005eY-6i
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 17:55:06 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANJuQkR3255327
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 22:55:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0FZlg61rj4t/q48PT/Pf/xZZdnByOmwaoaTpd4wxur8=; b=PTODh3Sipjf/Fws5
 bTiqEu6CPXtT5StqqBw4yeY7xDpWTGOjLedsfEBAZy62urz8H916Yph0FjH8FHFc
 U5fiY06/dqTN4+kL4kWrEXddFdOb73izEXSInrGvxRh61bSNxficUaYzD5xqZW4b
 dydLGLM7Elx96rSpXJgfxbN0FrID71/TJMHnjJNwEwhtZY9Tq+tY+KQLC8jZ8rFr
 6IeclLQJFySKFZLM8cY4QYBFM+g8vCO+LyJDG9zf1o5+EgVAwLkbqyRyFgWL/NKu
 co9OO+Wg0qPw56qG7JzYOlEgn53GFXu8XhH1UFaV1PvPEhFV4SBsehEvWs9uVGfJ
 91TtsA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g1pbrx2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 22:55:02 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-94970ad532bso98979685a.0
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 14:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795474502; x=1796079302; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0FZlg61rj4t/q48PT/Pf/xZZdnByOmwaoaTpd4wxur8=;
 b=hoOdD/ioOp6zykMtDcIlHttjeXZZPZJD1bKDGc4dpPpWwv2TKoALutdMwc00g+73l+
 HM+oZjgbddcfcnbT79lPkeW1nBCeg0MjNW6A35E6Ul2yfIyOzYjUgqyT7y5tg2UvII8o
 7KRxOy4Y5XOnyLEv4ASwc0Y1et8MZlGP+k4OIcaGySXMgGkM277e79NJ/go5fsmVHDj0
 bVol9Gcih3Kux9InlIhE+VPHB/kR6k0uMnCsdSxqoplmfIjlehfkt6YMCEJNCSLl+LW9
 NdVrf1EO27eeG10EkxUucTW4w25Stl+8ONP3uyARsL7HOMz5fCJ7VI9ps7a5l2t3oazh
 uIyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795474502; x=1796079302;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0FZlg61rj4t/q48PT/Pf/xZZdnByOmwaoaTpd4wxur8=;
 b=uOjYCDR3SRKOxb4LVMfcRZBgxN78YjFH1b5XfnA/EjLDQ88gJTMOtksx1ROTfEwnoE
 5WrOfFeiJeTEKA6ihPva6rQmP11K+1rJLE6XLM/Ijr7bQ4H8Ua6uRf4kdZGWdqNPKURh
 dZ4k5s2dJD8bHlz1ZkHYZvvanSAVi8rtr6sIKIIGeQLBa3a727JjlYdeb5hGBrYDRg2t
 fu7p8mkkMWTAanbz0t6MCJmSsqZIUB6nQZI339Gu8pCYa92PN8eLWYCK8aDfwhYekwVW
 DyK2ZNy0e0k8y9nP+Xh+eWYslGSPyTHz58/FF6TjRBeI9DNoAgjAaAB6BZFAcotlrw0C
 HVNw==
X-Gm-Message-State: APuU4Z/b/Myn0YvbdVVEVd1YLimvIXqciNk9vk9U4sIGLCxuQZO38h8v
 NgFwFJfNsx3ipk1z/drOHIZmsr+8pDxIAkXo1HHcU2LWOA9iF4gycAeJ1GSD/fJmLuGA8XsKihk
 I6BnMVKHYZfY9Bw9EG42Yl1S9Xf1aXd6nRUWmxD9Nz136QROSG1OJbO+w7T/UXyS2lSjY
X-Gm-Gg: AZFdTZc6k2AxPrqxk/5L6urNN3/PSQqy+36/PkylD5wfkHKMmGovUoV7Az4Bxvft4Fn
 bFB/p3/GeL21iCBNCFcKaNzDiq6C4Dtp0ArtdcBJNdjl6kC6C+FLIqF4EeoQej92ByitrerjO6e
 yBkGMe0I1HRp6M94oOq3wdRE/w3Jrn7HOxVsHQKjU2KP87Qm9B/eId1Y9+9G4jlXWqUIcwLgAHC
 L++UXdNB4MDroYZBqEi/+GyqVSRtZj93OHVg3e42EpG56XStqnFny7KV1nRLkMHeVlO3+FJvBZy
 so4RqM44RLMAZewPJTM9jv9+Tj5qnwgBinkTdYxRzcoeIVe/x2ODQTDZdLJNN62oxcw8iVAs+v+
 IoZhVdDPmjbq9lX6opHMVlMAU7zR1Q6Jlp07tAsPrk5ysMNToGhfwmq1VCGsZi0pUWdKJICEBnf
 sj4CCM8RFQu2MnZg==
X-Received: by 2002:a05:620a:480e:b0:949:7502:6a5 with SMTP id
 af79cd13be357-949bab2275emr2336817685a.57.1795474501622; 
 Mon, 23 Nov 2026 14:55:01 -0800 (PST)
X-Received: by 2002:a05:620a:480e:b0:949:7502:6a5 with SMTP id
 af79cd13be357-949bab2275emr2336815385a.57.1795474501212; 
 Mon, 23 Nov 2026 14:55:01 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884a3a3dsm369109495e9.10.2026.11.23.14.55.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Nov 2026 14:55:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org
Subject: [PATCH-for-11.2 9/9] hw/sd/sdhci: Report Auto CMD12 response timeout
 in error status
Date: Mon, 23 Nov 2026 23:53:49 +0100
Message-ID: <20261123225349.54981-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261123225349.54981-1-philmd@oss.qualcomm.com>
References: <20261123225349.54981-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA5MSBTYWx0ZWRfX/VQB0ktToe0H
 jZcGJSM9fsXa8/EFhKS6FfocuWaL0lu9ng97TuVwoKwUBwJ1Chi5vSTJr9o5Xwdq6Xe/bxMEo6L
 tXCqsQk6pkiUB7XqW+GCUn0CaZzUj+Ndekq46ZBPuFZ8P8pBrRQidfTao9/Y8FTIigp56fYHEcw
 oi/zoApUEWc/e91piENphyDleSkK8y2k8sxrzwx5IUfZKW8MKPbkYR2p2tZy6QDiUNUx7SO06/X
 H0XWz2v6s9e4YyFSXvufijlF0t38HE7s44AcImX+qAfcHOThXmFBagI1ZWYxIJW1nT0ufez9j9m
 /9D/UWu+3hy56d5XPi3V3SswHdfAPsG574DnaZAAyfhUAjUzsVPCt493cDPGuybhWI071+XYgPb
 +UowNacoygzK62EhTfSXF/2WMPvEEsJjo3y+D/5LRq3gqigD6brNejbvFLnMLsc8tZwbT4HYHKV
 tyRZnrLXRhC3P46Hr9w==
X-Authority-Analysis: v=2.4 cv=AeIkjHXG c=1 sm=1 tr=0 ts=6b04c446 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=AtiBkSoUvsowU9FJreAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: wedZ-lD_M8Un8WjvrN8cp0RsJ3_g178w
X-Proofpoint-ORIG-GUID: wedZ-lD_M8Un8WjvrN8cp0RsJ3_g178w
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA5MSBTYWx0ZWRfX7v5bYwT3MxuW
 UMC0KAw04NAAE5uBe5irltAq3LrJkn2BlbRReerq3AwJ1NskEb3s7lk3D4oLhiRqO3iJG1T0lyE
 IXuMIzeUjhdDsT8ypAAj8kgWMNPDT6c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230091
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Auto CMD12 copied an uninitialised stack buffer into the upper
Response register when the card did not respond.

Zero the buffer. On timeout, set the Auto CMD12 Timeout Error status
bit and, if enabled, the Auto CMD12 Error interrupt.

Cc: qemu-stable@nongnu.org
Fixes: d7dfca0807a0 ("hw/sdhci: introduce standard SD host controller")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/sd/sdhci-internal.h |  1 +
 hw/sd/sdhci.c          | 18 ++++++++++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index 2116995dccaf..9bc6f302b62e 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -174,6 +174,7 @@ FIELD(SDHC_TIMEOUTCON, COUNTER,        0, 4);
 #define SDHC_EISEN_CMDTIMEOUT          0x0001
 #define SDHC_EISEN_BLKGAP              0x0004
 #define SDHC_EISEN_CMDIDX              0x0008
+#define SDHC_EISEN_CMD12ERR            0x0100
 #define SDHC_EISEN_ADMAERR             0x0200
 
 /* R/W Normal Interrupt Signal Enable Register 0x0 */
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index bd74c60f7287..8c81b90f1a73 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -414,14 +414,24 @@ static void sdhci_end_transfer(SDHCIState *s)
     /* Automatically send CMD12 to stop transfer if AutoCMD12 enabled */
     if ((s->trnmod & SDHC_TRNS_ACMD12) != 0) {
         SDRequest request;
-        uint8_t response[16];
+        uint8_t response[16] = { };
+        size_t rlen;
 
         request.cmd = 0x0C;
         request.arg = 0;
         trace_sdhci_end_transfer(request.cmd, request.arg);
-        sdbus_do_command(&s->sdbus, &request, response, sizeof(response));
-        /* Auto CMD12 response goes to the upper Response register */
-        s->rspreg[3] = ldl_be_p(response);
+        rlen = sdbus_do_command(&s->sdbus, &request, response,
+                                sizeof(response));
+        if (rlen == 4) {
+            s->rspreg[3] = ldl_be_p(response);
+        } else {
+            trace_sdhci_error("timeout waiting for Auto CMD12 response");
+            s->acmd12errsts |= R_SDHC_ACMD12ERRSTS_TIMEOUT_ERR_MASK;
+            if (s->errintstsen & SDHC_EISEN_CMD12ERR) {
+                s->errintsts |= SDHC_EIS_CMD12ERR;
+                s->norintsts |= SDHC_NIS_ERR;
+            }
+        }
     }
 
     s->prnsts &= ~(SDHC_DOING_READ | SDHC_DOING_WRITE |
-- 
2.55.0


