Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382BB606A329
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 23:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GWokcyB5;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RixWdHy+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT650-0006yi-K0; Mon, 16 Nov 2026 18:25:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT64s-0006of-J5
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:25:38 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT64q-0005rF-Ja
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:25:34 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGLH0BD2245591
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:25:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 phLUOf6YlIk6N2anrns8FCkrPQYf3zHvEGp6xQcAEyY=; b=GWokcyB5TNS8xc0n
 fuW2YLLuxTP6hfDuI9B22fHtX9yD+SiHXZAX89OLCPVsVnH3J5DPnx3soGTSeJz9
 uQyBd2zM1AMVPVekuGkCETuzdVHH15XyCbfLibHnRdaP+Lfja+DpBg/Bt+db5SVF
 yRISYm4H7kRWpWWRswcfgT1VpDA74X/snZr2nXy35AlqIeWEv+3ZTX5/P70Vu92T
 ektgm578NKDzGx+MT3imWDX4RWu71ECCO5MSuvKgR30NcQ5m+G/c13+M/YpGrVoc
 EvTzh+Vc4ClsNtmgE3/aX7yEF9HD6d67tKlOKvi2MX5ZjZryUIdJKjUIu8802woA
 vbcVMQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j09m08d79-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:25:30 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f37c94ceeso63831485a.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 15:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794871530; x=1795476330; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=phLUOf6YlIk6N2anrns8FCkrPQYf3zHvEGp6xQcAEyY=;
 b=RixWdHy+qe7YTZtz74hQnYyKE45M9yRMqUbTJPsxHlqIdjpN/DQTmavkWzuV1+sZMo
 CIHRpjoj4ktuLqZfcGArZnTz0R3B5AlORXRd64uVChKJVt2W42IFj2lGMtFzFVik1U4P
 1k8l2/aNZtx7kZDioqGRHKGhD7nXLsiQA2qxGqVQ5ECktEA8GXtZOvzK/ZBKzBAfHzeR
 N/TyDfSG2lnCiomsKum0QKUcD/I+9qbgPzU7HmQHQmctchC8JDqXHT9wXmqQZa0MAEGs
 3Rq8J/ZBZ4XCf0WNS97mW2vNT8D05Zeb8+N2CX3EKY611jMd99jf0KqBpzp/lfqyvOpt
 oqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794871530; x=1795476330;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=phLUOf6YlIk6N2anrns8FCkrPQYf3zHvEGp6xQcAEyY=;
 b=ECK7WQmmx9tnUs/gtlGZBed6y2/hVn5XzIhG0ZtUYFW2KGx+khPnzBE/cwBbkWtFtV
 uYeTTAHRje5NSML/7OvQlGNUNM2LETHM/N3rMY9UMDK3bKDJKsvXineLBE4s1MVI9H/G
 wNKUDegQjIID1Tye8f+Y536b6YeshEiDJ8vNgdiZ2fI4bnHJ/s4PWiz5jdF19ZWG5tbC
 dI9qUNi4USE11VdAlg1UxgNIkRVrD/4RNs+DC4wlsPltt+gbdwkEUGgA8T+iEryfxHjO
 HtwjpHr0zw+pTpXJgHOgqOzmbKN3qpUFcIPZ/atTeXRWn8jlxfIn0Pio8lDmP2f0Dw+a
 SYYw==
X-Gm-Message-State: APuU4Z/QZ8W9jPilnYLlAMMu61oUivoL5B7vpC7Rtb0jGPWHkKpUAJlG
 p87KA73j5WttEN8DrqlVhMSDidVq/uzeUiaa5Wsvis2nQ9p9/5SCsktreRwJDPygpPFzdUr9CA4
 ndbgOyKmAlX8pqWVDsKEgXwUVdkHfccoZMPdYROYR4kR2E6n/P7/rafA96ELK74LTlg==
X-Gm-Gg: AYBFou1YwN5srZOB1q1F6b3xNHTxR4l4WQ+PcSt+Ip+rspfpYJIZlTOqUp2jUZwvixG
 CvHR5oRn3SL2UY+s8fJB/GS/izkH9zFOtgkC2t2kO+J+BzE6gGWfJr3CscLzqyCgviMOWwTne1Q
 pXP1WB7GhxYWEry+gonfy8SdwIYneN1Su2x827taJS2SDdpw1GCgituI651WSkA+snctaoMbESg
 OG2m72jRKc5Yi2cMuHHiW3P7AfFAVGaBa7g5Os6blybkWUvBgXfs5nFgWdr2qTj42gygsztGI+r
 S8g+6WHvj2jfbT9WCSs25+50vYPxumzlKHGPPeZAzh3EtnyoJZQs2yrhAY/sV55k8LeoflpXMQa
 cM9ftmIr+ZO8rh9ikYtZQabJrCr3BMZUUIZi/bUgf98Q0RdEXQ9yAiOHSAAKPzvSFDnqn5Zlihj
 QsBezmMAvx8jwjFg==
X-Received: by 2002:a05:620a:1789:b0:949:8109:67e7 with SMTP id
 af79cd13be357-9498b96f5a4mr167462985a.36.1794871529636; 
 Mon, 16 Nov 2026 15:25:29 -0800 (PST)
X-Received: by 2002:a05:620a:1789:b0:949:8109:67e7 with SMTP id
 af79cd13be357-9498b96f5a4mr167459585a.36.1794871529052; 
 Mon, 16 Nov 2026 15:25:29 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a3e5a6f8bbsm659132f8f.51.2026.11.16.15.25.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Nov 2026 15:25:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/22] hw/usb/u2f: validate ring buffer indices on migration
 load
Date: Tue, 17 Nov 2026 00:23:27 +0100
Message-ID: <20261116232335.31593-15-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116232335.31593-1-philmd@oss.qualcomm.com>
References: <20261116232335.31593-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfX8VGz3XFv1+b5
 h5dqJspjuCHov2+FxKv8Ah3OLMljKWOIh730/BRlp9n5LJwgaNHzxp6Ka/2naUHXu6+TFBydoiZ
 EAY18tBSfttixR5+pDWEsWbSbwggAtU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfX6ptvmMDwO2Ew
 ifLNVQjWR93A48IMVTmCSqzm17nwSQGXyQ2HcFObp7YyW/xY5Py8lPYOMHM5W7+P7w5X8oJ0Vjk
 AGXwE5gE7OG7VNmQIEEMHRnm9be6xAHtnOhNsQyMeYWn1dvyfYBy1wKUbGu3+js2KPmXmkelexM
 UgP3BQA+UEQYGNLKr03kBQuubX3XScs3gEfg2sQYIWKyptS0Ok3KdUuBNi88zwb1obxfnJS43R7
 /fXikoNRgBYxHVivpeVz0qiSB0E21jyBmXu7ECnZnxKrxYdjodg3uk/dVii+OC8Pxe+yE2+Wbjg
 RiHonzvcpJlKgvP0axhMGZDqsiCXg1XzkGmhSM0JswvJXEFR9kNY51otdUT6Ha5ortXGq9usZjn
 qkvEMKW8F8nEuls7Iv9j5T54+iHkSNVR7Bt3CPvSA1m9gRVSu7ulfCiPrVCDCurdYxaGhahQ/L9
 OI2M4XiYAvGteEQfxfg==
X-Proofpoint-GUID: 2_sl_T42_1lFO0FrGvy_uwL5aigfRZwN
X-Proofpoint-ORIG-GUID: 2_sl_T42_1lFO0FrGvy_uwL5aigfRZwN
X-Authority-Analysis: v=2.4 cv=F7rC5ahN c=1 sm=1 tr=0 ts=6afb90ea cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=p0WdMEafAAAA:8 a=SRrdq9N9AAAA:8 a=EUspDBNiAAAA:8 a=ZDzz7ryzZ8-N0FvD428A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160093
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Bin Guo <guobin@linux.alibaba.com>

The U2F key pending_in ring buffer uses uint8_t start/end/num indices
over a 32-entry array, all serialized in the vmstate.  A malicious
migration stream can inject values >= U2FHID_PENDING_IN_NUM (32),
causing an out-of-bounds heap read in u2f_pending_in_get() on the
first USB IN token after migration completes.

Add a post_load callback to validate the restored indices and reset
the ring buffer to empty on any out-of-range value.  Pending packets
are non-critical (the device will regenerate them), so resetting the
ring is preferable to rejecting migration entirely.

As defense-in-depth, also add a bounds clamp in u2f_pending_in_get()
so that even if corrupted state somehow reaches the consumer path,
the index is folded into range before array access.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4483
Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260916092342.2447-1-guobin@linux.alibaba.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/usb/u2f.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/hw/usb/u2f.c b/hw/usb/u2f.c
index d6291852f631..9ca9879f3e0c 100644
--- a/hw/usb/u2f.c
+++ b/hw/usb/u2f.c
@@ -228,6 +228,11 @@ static uint8_t *u2f_pending_in_get(U2FKeyState *key)
         return NULL;
     }
 
+    /* Clamp to valid range in case of corrupted state (e.g. migration) */
+    if (key->pending_in_start >= U2FHID_PENDING_IN_NUM) {
+        key->pending_in_start %= U2FHID_PENDING_IN_NUM;
+    }
+
     index = key->pending_in_start;
     key->pending_in_start = (index + 1) % U2FHID_PENDING_IN_NUM;
     --key->pending_in_num;
@@ -301,10 +306,36 @@ static void u2f_key_realize(USBDevice *dev, Error **errp)
     key->ep = usb_ep_get(dev, USB_TOKEN_IN, 1);
 }
 
+static int u2f_key_post_load(void *opaque, int version_id)
+{
+    U2FKeyState *key = opaque;
+
+    /*
+     * Validate pending_in ring buffer indices restored from the migration
+     * stream.  An attacker-controlled stream could inject values >= 32
+     * (U2FHID_PENDING_IN_NUM), causing out-of-bounds heap access in
+     * u2f_pending_in_get() on the first IN token after migration.
+     *
+     * Reset the ring on any invalid value: pending packets are non-critical
+     * (they will be regenerated by the device), so rejecting migration
+     * entirely is not necessary.
+     */
+    if (key->pending_in_start >= U2FHID_PENDING_IN_NUM ||
+        key->pending_in_end >= U2FHID_PENDING_IN_NUM ||
+        key->pending_in_num > U2FHID_PENDING_IN_NUM) {
+        key->pending_in_start = 0;
+        key->pending_in_end = 0;
+        key->pending_in_num = 0;
+    }
+
+    return 0;
+}
+
 const VMStateDescription vmstate_u2f_key = {
     .name = "u2f-key",
     .version_id = 1,
     .minimum_version_id = 1,
+    .post_load = u2f_key_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_USB_DEVICE(dev, U2FKeyState),
         VMSTATE_UINT8(idle, U2FKeyState),
-- 
2.55.0


