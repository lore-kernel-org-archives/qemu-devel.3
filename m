Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6630F606A331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M5d2bqWy;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RkG3ExjC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVl2j-0007hM-W6; Tue, 24 Nov 2026 02:34:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVl2i-0007gI-3V
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 02:34:20 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVl2g-00053E-Gm
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 02:34:19 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO2k3Jj4129069
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 07:34:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FWbIvN25WGDSKMHZ+JHWG//c3Utf/MpE5NclgiTBkH0=; b=M5d2bqWyBwC+zB01
 klxYVOn4FwfOZLb4UNwAxuxhQdzC8So3CwfPIVUmA9Lhl/ZNOXSH+N2A/T75VVlv
 /SGEo5vY2IGTPQWliQnfdJISwSc0h01x5zJWsUaR1RGoTCLMAuL/zLSjop8BqRn3
 iC7T57q8R7K69SFff2jLG1A7mXf3HYntu1GFeDF6b2pCNxZ2HefNoL5wWBuMJZqh
 0NoC7VnSGyZsf/pWzHe1e6KOAarQ0w4D4J8sj7KasOU65CrJM7ix7SAkr2XYnNRl
 EpK3HquKmJoaunSioyLtenuiT25Tb7kxX1ojOrJfk/d1ZMFTVAksmYFpZQX4Uh8A
 D26w5Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4yyt1ek4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 07:34:16 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-94970ad532bso151569285a.0
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 23:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795505656; x=1796110456; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FWbIvN25WGDSKMHZ+JHWG//c3Utf/MpE5NclgiTBkH0=;
 b=RkG3ExjCegzBl9yk413EdIjdGwnGE07s4A9J9CpesDNjdn/pw9TwxmFrzylFCB9lSQ
 XN26ZnZDS145dR7ozKIpltimkGerOazvudrGKIkMIFUhuN3cv3ThR7Xi0TgNA1GzIRaw
 HWpXfvpm2z/8ZJttqNkE+0TXC6ILGIHSO7zAlmwKzMF1h8NxAEk++KDEusLS/MBG/hcG
 M6nV8gQO8zCHiVa9/fLyUqUpqpxsTWK+WvP/ZewGjoXxS3jvDqD1dpqk4CMUlKHgi04h
 9ierFAu4BGLq5UPTnyLEBssyoN2IiEsmgpn3yWNJWpdpRgyTBQRThK3PRMQCcfBXyNbS
 ZWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795505656; x=1796110456;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FWbIvN25WGDSKMHZ+JHWG//c3Utf/MpE5NclgiTBkH0=;
 b=BOkMorzCiJDAXY/+qzRiKxFxhQBwXcPanrPM+8wOzXPhA+foAJHp+dXasVQ1Iwhkrh
 WB//R5/MpOgOd+35bAjahRwZ1WScTtwQTDhndrKUMWuqaJxcKVobeUJ2c5x4Fae0w2Gd
 HQJzRb/OyQr5PpgfEKpyOB9RDrGxJH3v6FZD8uQIX96yYQSoluZrIfJL41fcNnP1/iyL
 YNXM6LRMW7IEMoZoYLO5noIvkBwn2lHQhmkZF9aDhetw4wMV7RwGViDl0JtlrJHp6Gli
 fIoVVXSuB6oDjqLfOf3yBUDdZF31USqoQ9IZ1UGYdtopWe2228qm8NCG29RSiD9xfJjI
 r/XQ==
X-Gm-Message-State: APuU4Z+or/sVz7MNqWByR61I7Lu44aumleuteD7/EiLeeSBxy9I08xR9
 xgC+hQPuAuGOo2kHu8iREDvMJm6yf904P2VPukqsA0gVqEdo+/2iJW+sxPv4x1LhXNK+OQikSYj
 zOUXnL0AAvMKHr6ltRID3j+d99kMxLpH+z0IiIiXW1SekIIRuSwqKcGzVfyL3W7RuRJfy
X-Gm-Gg: AZFdTZc2ezjCgAY1PwX9GyI4qt3WvNOdIWIBq4l+dznXZEfmuZ0hmza43gidv13GT4L
 qBIsgMuDO3Hw9NFKBbC6zAHJUNLFTBS7hPh+pKmUEymtAnRger1EJ4o9+ymal4Ztpm+nB65KNQo
 zM5etEn43QV42bbSDoGzmrmT4Ll+9BrJVFnGVppyrupxhKZuNsjip4sUE4H9jhSUPEE4msLH/m7
 nIs5njDjQm9UsrcoF89bgSOlmSQmlIPOq8qfWf9U9xGqJpE8H5619sZXDkGDSQwVB1c2bKAkZei
 DctxgVrGWCJMk6v4KZ+Olmh35Vzz6RlrymhA/O4i1t/SMJndo3Nhg8yuHd3abkGsy7R/QyjAYx8
 lvsFfJIuBIrf8MwvjVqkxY5dwDMn728XELLE2tw4bgemkvCrUJ067UMHkpdcWEjenloMQrd3513
 P4LTyYNbE8YXHDSQ==
X-Received: by 2002:a05:620a:4046:b0:949:6476:91df with SMTP id
 af79cd13be357-949ba9b395bmr2686133785a.27.1795505655931; 
 Mon, 23 Nov 2026 23:34:15 -0800 (PST)
X-Received: by 2002:a05:620a:4046:b0:949:6476:91df with SMTP id
 af79cd13be357-949ba9b395bmr2686131385a.27.1795505655489; 
 Mon, 23 Nov 2026 23:34:15 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853368d3sm415732485e9.1.2026.11.23.23.34.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Nov 2026 23:34:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Karl Mehltretter <kmehltretter@gmail.com>, qemu-stable@nongnu.org
Subject: [PATCH-for-11.2 1/4] hw/sd/sdhci: Report Auto CMD12 response timeout
 in error status
Date: Tue, 24 Nov 2026 08:34:02 +0100
Message-ID: <20261124073406.87537-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124073406.87537-1-philmd@oss.qualcomm.com>
References: <20261124073406.87537-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAyOSBTYWx0ZWRfX2z4ldrnoIyrq
 D849W5NWTOTdM/RiPUE7kgJ90fG9FG45F85y8I6Z9inPdTBzcMNdDeLm7G9jJJuMMd+6y0RGmXE
 7GYRiQ+AyHMLxAySCVML2HnIdExxGqY=
X-Proofpoint-GUID: IC0t4ADARh7lvxmSog4b-LHyO3Ds1mHb
X-Proofpoint-ORIG-GUID: IC0t4ADARh7lvxmSog4b-LHyO3Ds1mHb
X-Authority-Analysis: v=2.4 cv=W9OtxhWk c=1 sm=1 tr=0 ts=6b053df8 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=AtiBkSoUvsowU9FJreAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAyOSBTYWx0ZWRfX/IsdNcJztLtt
 lxJ/eyu9WRvZ7dCJBJ+umQJc6PVL3zK5MgStEvkmaBYud4zgSq/WIKzDdu9M0N9seAbwEDpMokp
 R/S6/AUWwZK7GgnCcMRb5zgHXBtT8XTkbohmdj4s4VEw0bzocn/jrTdso6+DlhOXXOdSGTDxehu
 bRuopC0iTD7pPcMpwjwI3G0Rkk9qlbpVbv6G0Ok0w+M5OSlXwMQCAkvDjN9g/L0FQm+CUWn3IK2
 h0UeA9COjn+bFBH6Ef2XVsezUqfbK4AWPC7B720xutdBTaY+kGURH2c3wUZeB5J1gYI0ksFXHMe
 Gt/wG72dxArW5AmalzhvYfPeO6WnxiIbLsvNVyyg5qjzD4khWcdUT08+zvJ51EjxY4z2M4uQzR9
 FgYKzC0gB3mrDQvP04pEdE5ecsVYvAmuWg2y0itrCSoR9a1i3foSj5u3yKkRzJCnwjNMSXeY2Wm
 pZ/aEtputKGfXbU1HLQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240029
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

Store the response only when one is returned. On timeout, set the
Auto CMD12 Timeout Error status and, if enabled, the Auto CMD12
Error interrupt (SD Host Controller v1.00, sections 1.11, 2.2.23).

Cc: qemu-stable@nongnu.org
Fixes: d7dfca0807a0 ("hw/sdhci: introduce standard SD host controller")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/sd/sdhci-internal.h |  1 +
 hw/sd/sdhci.c          | 17 ++++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

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
index bd74c60f7287..1e70e1e7dd52 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -415,13 +415,24 @@ static void sdhci_end_transfer(SDHCIState *s)
     if ((s->trnmod & SDHC_TRNS_ACMD12) != 0) {
         SDRequest request;
         uint8_t response[16];
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
+            /* Auto CMD12 response goes to the upper Response register */
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


