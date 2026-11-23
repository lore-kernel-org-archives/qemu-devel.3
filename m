Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE84606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 22:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JJmfmauP;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=go9KBqqj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVcvk-0001HY-8w; Mon, 23 Nov 2026 17:54:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVcvi-0001Gv-0B
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 17:54:34 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVcvg-0004yt-5O
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 17:54:33 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANJu7In3513810
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 22:54:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 B7jJO3HEUukDtf1ptN4spynXKaPHLgUG88DcMNxtRv0=; b=JJmfmauPNLiNsI5b
 nWMdJwWgta9/T3v4EaDjO9B+QHGsjcprjnrxNbv32+KDYLl4fy+ImEkqsARduQC3
 omSMsdibZXSFfUSP+e4VOcmUocxX+SCCpvAnFQXY+dOBaP5j5CxRdEfABQZ98XRf
 waup35R40Ov4bQuS0/kV4/hZTFaphLCmdKf3XZRh4LIxlvMEA+aVjXsR8+xrsR+9
 0LVhmtt5jyZkb1o7iGJVcoy82iwxLwmeENpruHVCnyBaIxVQr9KGSY4CthTKn1J5
 6RLl2DcGTip+pp3BHQQzCwqa8w4hg36E8TP681prrxVVWVsowUAx4KLkJOBZRqN6
 WWzfDA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4ukr8q7r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 22:54:30 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9495a1f5e47so632540585a.1
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 14:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795474470; x=1796079270; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=B7jJO3HEUukDtf1ptN4spynXKaPHLgUG88DcMNxtRv0=;
 b=go9KBqqjh5Cng568371obXvAth0NzO+rn9hZfCseV0b6QlpIExKNwWS9uBD04kIvnn
 nWwKrb1J1PTF82z3QRQoPOTRxM6gQRXaRaahmv0h5I53TNr2fhzyembcP0PyYn7TWQ/A
 S3/cJntrOlMkvTxjtyNmOjLn6rhYelOImsfK8d6+wNZG8O1HoICIhNbcM/fMqNcCsIC0
 drY1eiR7RrC0MRXXzAMhFG4igWXwaAhYVYUHWN6KRLc7CTovebxhAOs0cpjSjPSFrCOW
 Q1ZBJfdMpFaSp8D4xmh9gRPRQHfrtcqQK30Gp3WXILOATpu+hBU3J7QplW3ksUAu5NpY
 XG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795474470; x=1796079270;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=B7jJO3HEUukDtf1ptN4spynXKaPHLgUG88DcMNxtRv0=;
 b=tQtqQbM7BjmZKAR2dQzsY0g7/bJXwUmZ8QGe1l7Lz/229H1ZM5EoSc/RNUlNFrv03C
 swlTUmZHp3dIGK4+g8X4LLHCauEuakFAk5hOuihwGL+1aQseocBhGmuDTyghlRoNd8ZN
 7XQ15D351UXHY5a4ok64Rb87c/1tu4CfKKCQV+Cgm/3xmLcxa0NApmjF7Gu84E9UQKqi
 lsvebnwH/1BW4d9wo6ZmGy7qifEmBCgOAIVTWL01N7xbG/S51wX1CTni5XOAEBlIsXzK
 pagNTqUCwXnFbCWnvnqqWuk9ddAAnC3QYKU5bOz8HiPKCrWXXKJMtjs1fQjRID7UzuUA
 moxA==
X-Gm-Message-State: APuU4Z8ctgL2836RzKJi6Exu7LVRdzNv5kLZwYVAO3lAahkiFVTt2Oda
 gODh+55BKg98tm3ux5oq52UsYdpVN++5n7/NbNFrO0PlBXZHn44UFzSKcEBTedCICl5y6IqrGyP
 Di9MzInsSdp9qc4V92PT3QY/K91m/MHyYunagEb0oe3M4Gjn6en2ekuRUJXjlfJd0pM5r
X-Gm-Gg: AZFdTZdjWOA+khXmbFHq+iVLUhnXv/aBsIpmMSXFN49H4ws50uQ3FAqKew9EfPmV96c
 +SX3BYP8kMA2ve6yuMRy+lBLMa/SZkSPVN4ND7SCf7I5FRuIV00GzuZHieL90m/Vnj46jDF9FC0
 7LEFkkyy+UgWjerzqKFA/w8zIaKwte/qZQXZwcWMXL2QlFaHyBTcrEOZ92B40k0kkD0OCVViXrB
 I9f4ZKN5Vd+aJzG6ca2EEbjYZMIhdp/1WabiZQmBM4/b8DzmlWsf9/WOlLHyfs0EWjV4Z/eJySv
 Y8LFJWFlOUCxjMnBLsizRii/q1HAIZavv3dRzAPpdT1gjKjCF5mfoeD9wLFKBgu4XhgCS+uRvYT
 dkqYMzXdYqWRlEEYJJAFgWxdqOfxOdsIqPOWyg+sAGDuEywpb7ysuP+od+p/rGPl1fEWJ48qypL
 dqJE9rek8FRNF2NQ==
X-Received: by 2002:a05:620a:2b46:b0:93f:3e45:a419 with SMTP id
 af79cd13be357-949ba9b34e6mr2240587085a.38.1795474469719; 
 Mon, 23 Nov 2026 14:54:29 -0800 (PST)
X-Received: by 2002:a05:620a:2b46:b0:93f:3e45:a419 with SMTP id
 af79cd13be357-949ba9b34e6mr2240584085a.38.1795474469242; 
 Mon, 23 Nov 2026 14:54:29 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb85399e2esm438045145e9.7.2026.11.23.14.54.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Nov 2026 14:54:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org
Subject: [PATCH-for-11.2 5/9] hw/sd/sdcard: Migrate the data transfer size
Date: Mon, 23 Nov 2026 23:53:45 +0100
Message-ID: <20261123225349.54981-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261123225349.54981-1-philmd@oss.qualcomm.com>
References: <20261123225349.54981-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA5MSBTYWx0ZWRfXyd5xEO97PkPh
 kSuB8+viq6Tt7rPgvTDHdcnszBEc7+/1CIYLGg4NPbyy16kuZqJ/UpI0lxQjfHfeVf33ehlrvUM
 7kF2mB1NAb8oj0pk/T9pNJP4vXWnAqk=
X-Proofpoint-ORIG-GUID: VzdB7EDLUH-CNv7sqbXAmHbhHrSJ5CMC
X-Authority-Analysis: v=2.4 cv=M+rYuCws c=1 sm=1 tr=0 ts=6b04c426 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=CPET_a92Nx1jWeZIcBwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA5MSBTYWx0ZWRfXyjI1+KgY7pNt
 oZ2VbzfKrbNtt754SyGxjA4ON8ZOVaI9CMGVp0T5nmwXZecETe2O+EK9NjsT0a3RqSRaz7Aazdi
 ZwwTMxFu6BijaRmDXTusZs0RInGiELrw2tV3g4/GY9mmzYkzfq7o/abq4KgftrR6Orr2iAaN6vJ
 L+HzltqLeIKrCGbJ19fbYd5tLOWrTNe8Q1K/XRhx7wovFtCodZvXhYdrb9Ya/un+OsbWpBCnVPQ
 w24VQJTSqPcoMZEb6JnxNK6wlcHt71+IdJUdDLb1Zq3lPtyeDC62C86Lx1tEZmvHsE/N/L8g6C2
 9rLWqXODymrj8USt45hHXTQ7KDzmP2hOp0tTqeTZGTwtW/3xMIamTRr+0TEC7StPjlIXCfI8uop
 1URK6cRsZEl9jhlOMCqZ0AG/XpxZAdpMrB/P4WogO6ymZm02ZL8fOQZKBApLtx7NqEPVRptLqxk
 3YMe4osBTEETSe1NmfQ==
X-Proofpoint-GUID: VzdB7EDLUH-CNv7sqbXAmHbhHrSJ5CMC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230091
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

Commit f486bf7d1092 introduced SDState::data_size, the size of the
current data transfer, but did not migrate it. When migrating in the
middle of a data transfer, the destination uses its reset value (0):
the transfer completes after the next byte, so the guest receives a
truncated data block.

Migrate data_size in a subsection, only needed while sending or
receiving data. When the subsection is absent (older source), assume
the whole data buffer. Use uint32_t, as the size never exceeds the
512 byte data buffer.

Cc: qemu-stable@nongnu.org
Fixes: f486bf7d1092 ("hw/sd/sdcard: Introduce sd_cmd_to_sendingdata and sd_generic_read_byte")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/sd/sd.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index d922e813c102..cca8debc0938 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -194,7 +194,7 @@ struct SDState {
 
     uint64_t data_start;
     uint32_t data_offset;
-    size_t data_size;
+    uint32_t data_size;
     uint8_t data[512];
     struct {
         uint32_t write_counter;
@@ -1002,6 +1002,25 @@ static bool sd_ocr_vmstate_needed(void *opaque)
     return !FIELD_EX32(sd->ocr, OCR, CARD_POWER_UP);
 }
 
+static bool sd_data_size_vmstate_needed(void *opaque)
+{
+    SDState *sd = opaque;
+
+    return sd->state == sd_sendingdata_state
+           || sd->state == sd_receivingdata_state;
+}
+
+static const VMStateDescription sd_data_size_vmstate = {
+    .name = "sd-card/data-size",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = sd_data_size_vmstate_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(data_size, SDState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static const VMStateDescription sd_ocr_vmstate = {
     .name = "sd-card/ocr-state",
     .version_id = 1,
@@ -1072,6 +1091,11 @@ static int sd_vmstate_pre_load(void *opaque)
     if (!FIELD_EX32(sd->ocr, OCR, CARD_POWER_UP)) {
         sd_ocr_powerup(sd);
     }
+    /*
+     * The data size is not included by older versions: assume the
+     * whole buffer. Replaced by the state restore when included.
+     */
+    sd->data_size = sizeof(sd->data);
 
     return 0;
 }
@@ -1110,6 +1134,7 @@ static const VMStateDescription sd_vmstate = {
     },
     .subsections = (const VMStateDescription * const []) {
         &sd_ocr_vmstate,
+        &sd_data_size_vmstate,
         &emmc_extcsd_vmstate,
         &emmc_rpmb_vmstate,
         NULL
-- 
2.55.0


