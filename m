Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC35E606A322
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 22:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jHWVASjb;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CFhOv7Dk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVcvd-0001FW-EQ; Mon, 23 Nov 2026 17:54:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVcvb-0001EK-IM
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 17:54:27 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVcvZ-0004xm-Q5
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 17:54:27 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANLCPEr189072
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 22:54:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aX4Zd/r+HKRKyjNsted6QI0xTC8rYEmdwtxMfPoLcKg=; b=jHWVASjb+tnp9ieB
 fAHhHbv2XWJccKtyxEPyeiRO9Sz4M12M6rscAhYe38MWTKNYbn4bKwXSVAWtY8mm
 e6BmoMQW6ZWjMWqbisRjhnqflEzdSqltREAHao1v4SqhtmJ/95Au9qEizd8/kAmJ
 +TqUE5EnOv4segddJdorKWUx3a6uaapQ2QfM1mdPTtUaAOlYcQXZd6aaPqRghl31
 u+t4wpGtRLLUK0S8Nib/BfXcbd6Vyc3rKk8NBy4VofhtJVWNqpE8TJPHlzbIytPh
 m4SnVmqI+yYonQeEty43irR5u0vCK91hv8hNHoGIpMDlwPTTvI9slXeh6YySpcEE
 NgkYYg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4w6sradj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 22:54:23 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-94960bd17b5so641118685a.0
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 14:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795474462; x=1796079262; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aX4Zd/r+HKRKyjNsted6QI0xTC8rYEmdwtxMfPoLcKg=;
 b=CFhOv7Dk478Lq5oR78h+iAI3gaDLfsUBlyuAwZPBlaTlBGXePE1tW7zXTckjbQpFGz
 qNW5rQrOFgabZL6Py6fzqLvrFYSQ1Bx1RFYqQpzR54F/vfKeOomaP+kpOERTq/feDgm0
 5X9Qyl4+q+tfX2NK8hGZPNMhCVspyv0VVA4NSQBgSLtgA7KG2Zr7I896OkHytATFSZHc
 ofkoNqY0Flp72CAFD3tmcvG/6d3qqNiAzuszXWeGOc5FZ9Z0OuE7athUsWpBfPmEoiHI
 6bx2AroibQOM5gRxBeOl0gR2gDaNq2oH3AWrVlKCSz+jqLNsgvEVcEuglucJbYmXCKlW
 luGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795474462; x=1796079262;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aX4Zd/r+HKRKyjNsted6QI0xTC8rYEmdwtxMfPoLcKg=;
 b=al7Nk7m2/7/zECmW/JXyinxlPTZEpZYR/fsPFlHh2H9bVop8Qmka3XBjHTsPDTacgr
 0VPO9uIvcy1Uo0OQdmM8ugd484cimGtWjvue/BqqLqzirBWZ4gcHc+ja5MmTc2q8Snxd
 1wUpcEZBNUMGOES6+Hoco7KfSLmIk6t1umpAPOyKL0WTtwLW4i4gX/kIxWH+6lcirFUw
 vXgohiJGzCqTJdaVZXM+GfZuKQ0jv/GyOLaAvkpClAvdV+SuppvJyDxsKR7h1rsItswi
 IeBJsGKltDvmwlL7y/O1euPDJnutIanIJxgE7DZ6AkSwxVVoA/+yaLwIUffop1BWErQa
 h/4g==
X-Gm-Message-State: APuU4Z+wGb48gBiguaFPTx7+WNOr7RmXO/qgeqBY3//ckYRKlSEIpXUs
 4RMSbriGl+roCh3WJPlmBDPjlKg3ZK4NOFcISaujXJGDaTdA7sup1Knei4HMq5QRNXWxBHfqL2k
 02mCL7mGuoIgw/23P3w1b4YL7Ew3GpEG3LrsVWLjsJs4/xCW6FbLLt+PbGHhtNyIhBwJk
X-Gm-Gg: AZFdTZeb10YP3TRZvZCUZeO6gFXGXSrm82IMr6InUdiFew8ReK/ElPmKEXpckrZjL8b
 rmDggGsbLngF4IFOq/yN0LZbuNSLBWlDTMt/G/MLatdUYvLJGpXrz02+Le0eQopY1rcDhaG7X4q
 PQKoAYAa56DC9rXr+hR3BciZR+oVNgohjp9LPp6nipjOvzZ0bvyOYMHoaEuD4a2508W+4LzEXF5
 tAPDKEt7pd2ufg4ZIfaSZFEOTVFgebC2NI1hhtvEcuwiE0sUjselF3ii+JynzxcoxiLTc4TQpjj
 UVVK57+alc/RK6UE+F3FIlD59f/alKCTWVzp3A243+sj9fhXRaolnbxcCAcvAnmlIbstnkoqy9l
 sMUPHDmNclKgmtg55nkK4EcWZdpov0VuRjgqwzh53iUGbSYxD/QoPsGsobX2/6N14bf7SheWzmK
 VaA+hhcVJxnh7jrQ==
X-Received: by 2002:a05:620a:1727:b0:93c:a191:88fe with SMTP id
 af79cd13be357-949ba80f88bmr2236830985a.8.1795474462547; 
 Mon, 23 Nov 2026 14:54:22 -0800 (PST)
X-Received: by 2002:a05:620a:1727:b0:93c:a191:88fe with SMTP id
 af79cd13be357-949ba80f88bmr2236828285a.8.1795474462087; 
 Mon, 23 Nov 2026 14:54:22 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb85399d52sm374758205e9.6.2026.11.23.14.54.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Nov 2026 14:54:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org
Subject: [PATCH-for-11.2 4/9] hw/sd/sdcard: Fix incoming migration of SPI mode
 cards
Date: Mon, 23 Nov 2026 23:53:44 +0100
Message-ID: <20261123225349.54981-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261123225349.54981-1-philmd@oss.qualcomm.com>
References: <20261123225349.54981-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: lmyr2y9V4vxscJobAZ3Bd1sFVjZ8nKHC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA5MSBTYWx0ZWRfX9NprLg4kVTRF
 6Ds7Lt9UAdfR+03nuYUS0J9Hiu6bD0BCQTnYs0GEf+iEu3lYTT5hXwYoNnRIn1nLynMlzGqhCTA
 X6UQ8wCdiyshHEFxnrN9H1j2/WzI2d4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA5MSBTYWx0ZWRfX39wK/+aak8Q6
 eNOF3JbSl1cRyELzgqFQzRPulEJic29TxevxIHhWlj4vf5VL4WitZpiCwVh61GKhfBdRhB5vGcz
 DD2B5MSD/D0VRKbjCAVwu9Na20/Ixq2zZbR97qosEznJuFR87yMx2u37zD54qMRwlszqJXLHWvR
 Ac/ZbCUA/I0IsGvAVCPqKMjBru4Q+hORXFt6H9KaTdHeFOy+MJbdxB9yzHtqEgPdj/Efpronmy7
 7N6fswcboCJToHGmSciek+Bk2ENANRSUWWKAlDBl2TnwxMzXROQOzKCGMUJCiW5vqfm4AENfh6y
 8tG4aQBTKCAe1GUb0DvoIkMDpSqLFZyk7lcqRGSAv+QKIk0pX9zv0zXwdQJwHw7K/w/X7P+bKSz
 0a1CwaeIr1YeDmQ7lIYDsJM6LuPUGC9zdM6wylz6ou2Kv0in+1TfaWZYJ6icXLzLF9DbbNTTDoQ
 stKpek2QyBM1HmnQP5Q==
X-Proofpoint-ORIG-GUID: lmyr2y9V4vxscJobAZ3Bd1sFVjZ8nKHC
X-Authority-Analysis: v=2.4 cv=V8DoQuni c=1 sm=1 tr=0 ts=6b04c41f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=OJEd5HcXf_zait6-lbMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
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

sd_vmstate_pre_load() powers up the card when the OCR state is not
part of the migration stream. Since commit b66f73a0cb31, SPI mode
cards are already powered up at reset, so the incoming migration
of a machine with an SPI mode card aborts in sd_ocr_powerup():

  Assertion failed: (!FIELD_EX32(sd->ocr, OCR, CARD_POWER_UP)),
  function sd_ocr_powerup, file sd.c, line 409.

Only power up the card if it is not already powered up.

Cc: qemu-stable@nongnu.org
Fixes: b66f73a0cb31 ("hw/sd: Add SDHC support for SD card SPI-mode")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/sd/sd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index d82aa35f6f87..d922e813c102 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1067,8 +1067,11 @@ static int sd_vmstate_pre_load(void *opaque)
     /* If the OCR state is not included (prior versions, or not
      * needed), then the OCR must be set as powered up. If the OCR state
      * is included, this will be replaced by the state restore.
+     * In SPI mode the card is already powered up after reset.
      */
-    sd_ocr_powerup(sd);
+    if (!FIELD_EX32(sd->ocr, OCR, CARD_POWER_UP)) {
+        sd_ocr_powerup(sd);
+    }
 
     return 0;
 }
-- 
2.55.0


