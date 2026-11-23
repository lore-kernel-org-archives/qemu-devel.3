Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF58606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 22:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OLfKEcf3;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JrO/ZWcZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVcw0-0001aQ-4H; Mon, 23 Nov 2026 17:54:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVcvy-0001Zj-SX
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 17:54:50 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVcvw-00050U-RD
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 17:54:50 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANMO21e2663196
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 22:54:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qK9j8VItAE/cXXmI7yh7tyrI70Y75YwVGAQD84E/cyg=; b=OLfKEcf3LYARjmry
 tIIVD+6uJO7K4R+8xfRVadwRqv63yI7wltMMMQUF1Bj9tCoR+5Sa2AawtxwWBQPI
 sgAXNV+2fwip6D9aR7zbwZU9eewxWAckYb44cINnQzn9x9b+2hgeLVN4QInnBas+
 mI2rbJJbDZ4WKR51P9oReiSIiAnZI6C1iK0RnxXHcKFw9Hw4HYAZtJMHtiSKKV29
 RqxEDVzQL0W0YNQ+m/ycYGkr3Y1W2jwFvRSXxbvRIcfR6TJ6hyQHjIq4pMF0AShc
 NrIQFCbcC5KiVr1LFCbNOeSHsiNznqS1jB/LdHpieRPpTPOZ982rkbOJI4hTct14
 zJqdyQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4x8f02qv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 22:54:47 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93e92aad34aso700886485a.0
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 14:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795474486; x=1796079286; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qK9j8VItAE/cXXmI7yh7tyrI70Y75YwVGAQD84E/cyg=;
 b=JrO/ZWcZRi8a0QECbuff5dcn2fXwJtdKOL76L+RI38Kn/23/GtPV/cWWQBQZQ4a/uO
 ifWb7bUpYA4MAA4J754DvGjDXml1E3MN5Cnb+Cw5LWNhfCVMrTaaxTvWzqkhoWKA0gna
 RVM8+FKul4ITDmUkkVV4pLKT2PbA+LBCaBvyULhdJ/pCx4Nygm4jtZPoc5jXUviRjLO6
 AOwdCG7qV9NE70fFlNlptOasDVyBW8K+djUJRLf2Rkh6MIYmitXzrdwe6QXs1iR7R8SO
 CM+fZua7IwdbhyJiXnSncL4ipHRLSHHbLr7HD77XjhLgVb/JiDTnUC0OJbGatsFK8OUS
 4xrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795474486; x=1796079286;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qK9j8VItAE/cXXmI7yh7tyrI70Y75YwVGAQD84E/cyg=;
 b=C29Diylkds6JfkuqGYkxa8X/+ivsNFuoLl1k/GV7ApnRYgu9AQqEWklVMlds6LgWoU
 Mm9TU0k/2+ECGiB67jEbZ6puqJBQwtHPYAIlA1DjkXyHLL5rZmeHbr0IUbiPICHvpCee
 TEBryruN1qzvgwPfw0slf+xjHkSkyWN0eKeHPGnEAKjS/5jE/p1YoSvvi9XRhk57rQeJ
 XpjTBO4U9CjFjG59daAeGnkSTI3m5RNxMPzkFji76KMPp61QVOdBBfe+e/JIZpgOnoS+
 8WNhFPU3kB5/tQJRhN0QaUjn0zM+3XBG7iq5CSdqMKK7TNJD2+iXp86B7SGOyUIJnavo
 2cJg==
X-Gm-Message-State: APuU4Z9E5xN8Zk9TTB/zxLP7wUjcN1jGIjWMwfyh/lRDdHW6ZogwsaJP
 s0XeRyj+nsMaMCtAVCG8DzdQKXlv+bi9AvL3ZFA3aMwFuzZp+T/ylvEht7i4ld2xPfBuu81+z5b
 aadq7kMsegDYtWHdci4Nuk5Abk+q6mXz2cYLKwuBdlGSAH1yLuSF4tjtK62EEVkZu9NiH
X-Gm-Gg: AZFdTZdMcknhRiSDzgKBLpu6wbyTDYPMWBLLQVJuj4yM461eVzcxx3iW4E7m80EM/0s
 OeElyAyyf2STgpXca0ckTKLmWFPXovUoimTtc6iJx9pNf/6M55DzhzsYcTdhi6fFcnw/mm0T2ul
 S0+zzf7qgCLMen4cKAkrRDd4zcI0+/zJqLBEK2Mfov2DWEjhsjdicV1DR3w5uqNBuS6saDFH+JF
 G+vc4pCjmOx8QVLf2d6ARfpqEONGMeLBFhi+2G0MvmtedhTg0AeRYSM7I1Zw0a3B4oMhzMm4F66
 5T4Lvj5DuCtNFjPn0NhYzrxqfUo1TUhw83jUvuirdBh/swxdnsaXPm/iHiMfVB7/BB8lS40ccgl
 Yyl/emFkVzghQ17SGQ79Yc+BfKSw2AYpOL1jZ+cmMu2LGB8FmpJzEOibZbCTGTk20hmjOGpeTwl
 82bHxd4pIRGBngXg==
X-Received: by 2002:a05:620a:46a3:b0:93e:84e5:3c66 with SMTP id
 af79cd13be357-949bab0e65fmr2518601985a.40.1795474486339; 
 Mon, 23 Nov 2026 14:54:46 -0800 (PST)
X-Received: by 2002:a05:620a:46a3:b0:93e:84e5:3c66 with SMTP id
 af79cd13be357-949bab0e65fmr2518599585a.40.1795474485954; 
 Mon, 23 Nov 2026 14:54:45 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b8b7888sm24344500f8f.42.2026.11.23.14.54.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Nov 2026 14:54:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org
Subject: [PATCH-for-11.2 7/9] hw/sd/sdcard: Validate the migrated state
Date: Mon, 23 Nov 2026 23:53:47 +0100
Message-ID: <20261123225349.54981-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261123225349.54981-1-philmd@oss.qualcomm.com>
References: <20261123225349.54981-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA5MSBTYWx0ZWRfX6YNBUHKCtUeb
 8ySAyPVjkl0tRfoHLhA35ogdh3V3DbBNr9QDJz3TjeND/8cDE0YVJo1Y12PPG1Joq80s2wcEGfl
 RcxAv9nCSxdxT7EN3MT8CgXOv/o99+M=
X-Authority-Analysis: v=2.4 cv=JbgpPkKV c=1 sm=1 tr=0 ts=6b04c437 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=nSXtqnGyVT92Lixn0_EA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: ZSafXpQQWWlwZWValQbXK2sGFZ_pDv5h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA5MSBTYWx0ZWRfX/Ke8RkcTCJzY
 HALUJIsGTKX0RDEAycSez3SgZjWth1KVMeMlfRIKvbkazu9CnX+Ak6qu4NAIH53a/8l4coiuTKo
 Pt63oXW3T3VbbkDfaU1R4NsdlsxYxJ+wFWvaKMSYZoyJm/VJE/adfBdKPk3IhFBonBQ2cZtFKNU
 UM5hVgLtroowG5PNlMMwtg//7Ch38vCvuUGtsRJdIiUtTltEi+r+Y9mBWK7g6hhalXAJmkFEzTZ
 F2H4ZL5371tJ/aqCMgXwtlmnO0pbogjwxF8PvhS4P9IfFIObDBrMpAzWiNJFnbOZ0TZdCac4xqh
 Y/nicgcKslg0vK7E6HvEn93O9COZB7uzPcqpkJIjM0J8XKybkfbAjChDqrii1DgyvgRQa2/mA43
 Bq4kkq5F4u78vSJ3uG6FKmNduimQg+AN3XZZkgn4ui+Am6de/zGI1vZZnXFjPBMk6FPlv8sUmO2
 G5zJ9KxBrSwD08AchTA==
X-Proofpoint-ORIG-GUID: ZSafXpQQWWlwZWValQbXK2sGFZ_pDv5h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
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

Several migrated fields index the card buffers or are used without
validation:

- data_offset and data_size index the SDState::data[] buffer in
  sd_generic_read_data() and sd_generic_write_data(),
- blk_len bounds the CMD18/CMD25 data loops writing to SDState::data[],
  using the effective length from sd_blk_len() (fixed to 512 on
  SDHC/SDXC),
- pwd_len is the length used to access the SDState::pwd[] buffer,
- an unknown state hits g_assert_not_reached() in sd_mode().

Check these values in a post_load_errp() handler and reject invalid
ones. In a data state, data_offset must be below the transfer size.

Cc: qemu-stable@nongnu.org
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/sd/sd.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 5 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index ce1d1ed583bd..862622e217b4 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1100,16 +1100,60 @@ static int sd_vmstate_pre_load(void *opaque)
     return 0;
 }
 
-static int sd_vmstate_post_load(void *opaque, int version_id)
+static bool sd_vmstate_post_load(void *opaque, int version_id, Error **errp)
 {
     SDState *sd = opaque;
 
-    /* Check for blk_len that overflows data[] */
+    /* Values used to access the data and password buffers */
+    if (sd->data_offset > sizeof(sd->data)) {
+        error_setg(errp, "sd-card: invalid data_offset %u", sd->data_offset);
+        return false;
+    }
+    if (sd->data_size > sizeof(sd->data)) {
+        error_setg(errp, "sd-card: invalid data_size %u", sd->data_size);
+        return false;
+    }
     if (sd->blk_len > sizeof(sd->data)) {
-        return -EINVAL;
+        error_setg(errp, "sd-card: invalid blk_len %u", sd->blk_len);
+        return false;
+    }
+    if (sd->pwd_len > sizeof(sd->pwd)) {
+        error_setg(errp, "sd-card: invalid pwd_len %u", sd->pwd_len);
+        return false;
+    }
+    /* In a data state, data_offset must be below the active transfer size */
+    if (sd->state == sd_sendingdata_state
+        || sd->state == sd_receivingdata_state) {
+        uint32_t limit = sd->data_size;
+
+        if (sd->current_cmd == 18 || sd->current_cmd == 25) {
+            /* CMD18/CMD25 are bounded by the effective block length */
+            limit = sd_blk_len(sd);
+        }
+
+        if (sd->data_offset >= limit) {
+            error_setg(errp, "sd-card: invalid data_offset %u (limit %u)",
+                       sd->data_offset, limit);
+            return false;
+        }
     }
 
-    return 0;
+    switch (sd->state) {
+    case sd_inactive_state:
+    case sd_idle_state ... sd_disconnect_state:
+        return true;
+    case sd_waitirq_state:
+    case sd_bus_test_state:
+    case sd_sleep_state:
+        if (sd_is_emmc(sd)) {
+            return true;
+        }
+        break;
+    default:
+        break;
+    }
+    error_setg(errp, "sd-card: invalid state %d", sd->state);
+    return false;
 }
 
 static const VMStateDescription sd_vmstate = {
@@ -1117,7 +1161,7 @@ static const VMStateDescription sd_vmstate = {
     .version_id = 2,
     .minimum_version_id = 2,
     .pre_load = sd_vmstate_pre_load,
-    .post_load = sd_vmstate_post_load,
+    .post_load_errp = sd_vmstate_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UNUSED(4),
         VMSTATE_INT32(state, SDState),
-- 
2.55.0


