Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE679606A31F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kTn39QJb;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=clwi97bK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmqX-00037F-Up; Tue, 27 Oct 2026 15:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmq6-0002yB-5r
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:28:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmq4-0002ME-KQ
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:28:05 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHMg92088124
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 64yoYBDdyaAlS+N/JwPaIdbbfiffX1y7hU3iftRzx00=; b=kTn39QJbHxyfzoKx
 WVfAWjc2MC8CwcUgLaJA/nL2rOOrTeB+zpvEDPSQVnT2aQh0vScYu7G47R0oBXZ6
 mcxRtneUgWEo+2qkoIOhQjh2h/fMAFPmWgfD08yZV1bwMVDXzqrR53zDX2/6TBR2
 NXnB4Ncjp1/ZAs4RtiCm95vu+L9mx8X73LsntE3H0mj1j3IJ1lr5UDB1XanJi191
 wqqzQI/Oe1oiCkheQOu1w/pLvdiZPbTX3cSL6/OPzEamUMLAVwHXVt/HGkpMBe+j
 qhKlvoHjyOf7B5spWpvQBLmlrDYuVa/ZEH7QIKYjwLWuedJN1oEfYXFxNttdEOen
 FGl1nQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjp2tbb6b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:28:03 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91b4bf686ceso5321486d6.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129282; x=1793734082; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=64yoYBDdyaAlS+N/JwPaIdbbfiffX1y7hU3iftRzx00=;
 b=clwi97bKEH80+sJFRyvdPDh8kDpYfXvBnb5sjLvpPm/hSiEHq3LzzjHt04hSq3BQQK
 GqN44bIQq73o6Op5AKf5WXtopHRQ/HjljeKhb9M9jtu+Jbg9Jv870d8rlHpbC01ivuBJ
 zNIeB7B3Qxkd+HwnStxwbVb236OZ9PnuCDyToNRswh0ZwUxDLkpu72lwIgAKL5CKhgBY
 Tlw7JGWj5PzM3zmpGh1dr7KqvnXBKC6aXbSKXsZLuA4pFeZVT9sy3CWROY+vVV/UxMrt
 fP5rA7f/gLKGBxk4iOrnmJvlJBjUSJl2OfN0VZfFZ9a2zDIWG3LycXjLoqHxjrunTdvz
 sTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129282; x=1793734082;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=64yoYBDdyaAlS+N/JwPaIdbbfiffX1y7hU3iftRzx00=;
 b=jPBkZC6rRTp8mu3PSM3nNpz117OhSpre1wF4lmwx0KJVoHoyzhxp7FvFISOT1BCBq4
 niMgXe3oFZlsyCjJZZZ1p6YzooaO8D+rLKTFe2z1CFq6gDq7BToclU8ycF970ryYcD/T
 2jBLxysV9BFYX6j39bs8z4aKvNmLLeW/qKVVuiM85BOGaPGzRfBSB2Fvyft1z0+dWig1
 cWJASCa5MA1jyi0n1443D7Be3hFT+qKVC4QYrons1KazVp3qnxPnKeIcRI6LhZ8TeyWi
 F7X4+UYoKZXxth/XDC6yQONWd5bW0HZeT3MVNb69DbX6GmL5OoZ6SHTHyh91wKBsOgCO
 8WYQ==
X-Gm-Message-State: AFq9FYLG4qeH2qVp4gu88NIoS79/sveH5cv7rEcxDrWja8FmWTeaEhDc
 sANId4UJk9+HtEbrtr1v5c0jghmEL4n9kKzk/c/6GVQj9Aqy0oHVUfdHNtL/k6IXcTaiDg6lW4C
 x/l3xkoeJjMh64mlsdCdjsnkPCOBAFYQKyuTP4yb11ciayeIscSPjFDjG82o7CQIEtg==
X-Gm-Gg: AYBFou3BAOPB/HB/FQkfhdvCWH7EI8WYXZIPAHIepRXT3smTt29ZSYYwZRrHlJ4dsoe
 aXl8ocysEEknSFlneOjpATQjy/9uWB8SrTqvja2iQSsghVLFL5w5sKEEUo0UhKlpMZFUfB03FVm
 hEqaR+RO2eLxwIwAE2r5rfeO41t6AiDNda5AQbCmAwJda1tAFICJPSlZ/3EQSvRIay85f70/IbZ
 zY4CqjR9PZ6aivs4YwMu8frtdCkdWeJhzdbm7yWDLWY8BRP8vrapqynrCGVIeh4uR4fa8zXuAg0
 D9ABJgj9v3dY/zZdFtRMHo7CqxhgJTebFumzXmUgM/w0h/LnWDWEXlh6T3UX9afS6NSgR1X22vX
 tbYeqQQwyBl/Op50rsShpbG4jm/ClFTB2Itx/L4Dxn63aQIsyIG1embBH
X-Received: by 2002:a05:620a:4728:b0:93e:942f:b8a5 with SMTP id
 af79cd13be357-940ef8aec7dmr1729999585a.14.1793129282246; 
 Tue, 27 Oct 2026 12:28:02 -0700 (PDT)
X-Received: by 2002:a05:620a:4728:b0:93e:942f:b8a5 with SMTP id
 af79cd13be357-940ef8aec7dmr1729996085a.14.1793129281748; 
 Tue, 27 Oct 2026 12:28:01 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a94e3c638csm2592965e9.8.2026.10.27.12.28.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:28:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 38/59] hw/misc/imx6_src: Avoid casting from void *
Date: Tue, 27 Oct 2026 20:23:19 +0100
Message-ID: <20261027192341.9197-39-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AJjzCM5L c=1 sm=1 tr=0 ts=6ae0fb43 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=5EfrD_kSPsmhVrOwvXAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: 4w3-35hr4i02YE7jZl8FmUJ9rneNtinl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX5ELC0kOfwfZk
 F/Ux5AvARjfmwQBR2Jura3gzWK7Ylw/iUSGve6y3TrlWpPnj581x9WfMb2fa1DL5s9tdAP06P9k
 iRf/whUPCLV9hHur0Wh2+QeZa8GLhNM=
X-Proofpoint-ORIG-GUID: 4w3-35hr4i02YE7jZl8FmUJ9rneNtinl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX5EyE7OP1uXwB
 OqudkpzlvbCScRdSftk35EBhTM4VoyJRJJKAZMsCK1AI9MAaVHvh3sLyNap8PFadMz8KW5DYh2S
 b4es/GxODyGBsEhSR+Digko6NIum9eOlVNfqojiBc+A+3+gosw4zPRTh+j7AEtBw8iWzqXzE5RS
 lmazZ77JCrSfLW0YgAb+atzet9MND3BVY/H0RTO1nr+FmF01L5JrDPkjrQuKCESglyVFESEG4WD
 Z0gMDL+8Bv+b2XJoyItc+pmNYAg+qIotpgpGEqKxPWDL6vh+dgpfdFr7TlYzwagPg5qy7J4eHcH
 VqWj68VNmh2mfSQB8zIFdVgzyPhq2mHaGdVsV09UpP3q+AK2T+mr57eLiEDDU5bFX9ZTcV0nfDG
 t27TNfA+yudo+jnO3sVlBONlPELIlSXxyboj1cG6hzBnd7SlQvAux7HbtfcwV2ve9fzh18Ijy/E
 rKocdvlyTtY1uUFa1mw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270078
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260921214710.29422-36-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/misc/imx6_src.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/misc/imx6_src.c b/hw/misc/imx6_src.c
index 8d2c4175e4e1..5bc1318f9d28 100644
--- a/hw/misc/imx6_src.c
+++ b/hw/misc/imx6_src.c
@@ -89,7 +89,7 @@ static void imx6_src_reset(DeviceState *dev)
 static uint64_t imx6_src_read(void *opaque, hwaddr offset, unsigned size)
 {
     uint32_t value = 0;
-    IMX6SRCState *s = (IMX6SRCState *)opaque;
+    IMX6SRCState *s = opaque;
     uint32_t index = offset >> 2;
 
     if (index < SRC_MAX) {
@@ -150,7 +150,7 @@ static void imx6_defer_clear_reset_bit(int cpuid,
 static void imx6_src_write(void *opaque, hwaddr offset, uint64_t value,
                            unsigned size)
 {
-    IMX6SRCState *s = (IMX6SRCState *)opaque;
+    IMX6SRCState *s = opaque;
     uint32_t index = offset >> 2;
     unsigned long change_mask;
     unsigned long current_value = value;
-- 
2.55.0


