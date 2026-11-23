Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E45E606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 22:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Agy/iPje;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GjFH1C27
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVcvQ-00019f-A9; Mon, 23 Nov 2026 17:54:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVcvM-00016S-Ip
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 17:54:12 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVcvJ-0004w5-LI
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 17:54:12 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANJua752973607
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 22:54:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 L6kQC+Xb75uU+rut17QePV/sgqSARNx+6O/Idlok/pk=; b=Agy/iPjemIa6psIU
 0uQR8CzBBv4DAxPmO135tGbfPk2bz1Qn9ZtIqiiEy79s8CEP+zzuuf4gPCzIDbjw
 U0PNDO1g0mGs109BtUW/l6AK2UfcFV6fUnsOBcLF0Q5ftY01SgxFnfn9gUxfV53I
 3myeLaen6MPSBHYEuz99UTTQCY4F5tRhmqVifNy4UxG319YjYpwq5FQ5yzd+J/6p
 /0X4xBD5X38UtfLY8YA/QCS8oWqakjwISTka4diHM+I3viRiNCikUAjb4wHVBjsE
 ACIYrZ8H5OW1v+5PWxC3krXw2/0tePxdYOxzIB5J6aUABBMu7RXt36dKQ9pmG4tt
 ANRsWQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4fy03u4k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 22:54:08 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-947a607ec40so368983285a.3
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 14:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795474448; x=1796079248; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=L6kQC+Xb75uU+rut17QePV/sgqSARNx+6O/Idlok/pk=;
 b=GjFH1C275IhAnNlHHebDC4oA4SfBvKAXoKIaXXJIBnCF3Dgte3WDES5LAbRTOv/gwf
 182NBJENXMA2U/0uOnmkqw8WnwNSXoeFgIomasCUDiWkIHO8xKY4UtlW+IZAkJkmCADF
 k2wGUHiRLSoRwBvwE6vwhTXd1dWH0ZiDCOuBtOzJpOojkSTJhODB//QocMyVIvvZV11Q
 Vwk+zpGRrtoA5q7kF5BgwNZCorezcQ/M3jg1U8ZwWS/lN0w+Cwqjq1JaEQrh7ONfVbjb
 ZGTzIxlIQcaWvut2vkwuMd0XJ+2ISCiPcMJSDRVFy6WFKFFiD5M/ZGjXdPp2P8Q7guED
 PFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795474448; x=1796079248;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L6kQC+Xb75uU+rut17QePV/sgqSARNx+6O/Idlok/pk=;
 b=wAqhKaAvIvRtwxDogMvz8hWQAE2W+uEWPeAjGtiZ7pA4vvJXWdZfyBr5lIcUiUcaUD
 vswlkjIybVg9+ea0mOIJkSTBqmXwJ6oIJozVsBAOtKI0Ul5kDiPkVwwhIrb0jQfzJyLg
 n7QgulQhBgaYQYNEaHJVQN5YSPvHPIjaFXmdAOQW2qdYl4lSOyVx+aW5XUqBNMzUX1/i
 6u3lx7x/Kq2OYUKQgC/3rDO7n9FlI/t0pfbdvuAJwnS3xlvaFHXxvucVVX9GH6eEMK3x
 XwHh+wbjvyoY+ph6BeF84+UpUXIA96iUuodCj4aLTvpcw2OAlnP2g2LKf3dQdNggdmNN
 AQ+g==
X-Gm-Message-State: APuU4Z8mrzlCAvBJwROirml1AyhiqCnXUaP6BihzyWvT7yMCd76URUue
 JNH8OgWbep5SGOFpRai+/V/QC5Z2qu0HhSpt3KE912SEvun6OTqYJ31j5e2GGHcFwNlinEjwoz2
 6WIuAsgPKM/WouiD/jEqRCqwOZCbpMyZmCNVWtkvANv6a0ZIjCCRcZ53cmPa59V5rhj87
X-Gm-Gg: AZFdTZfKcN6m6fzGJh1XJdgRs+wB9Yfe8/CojjaSidb+0SSztgS2e9zI+aG23pqheqp
 Tp2Uv87Wl1Fs7GUwYhZ9IhqbkwubGKOvmlWUgBePcfC/RdrKphasDQMvEaLNOyzJHG5l6tpzUcx
 bDkFbPgsiWhu3170Ygn2NyUH/baNemOcjOtkU8LdTsfWIt2VqirFzmv/a0W8iBK0HHcy27uYz7l
 syFK3rIQaoU6ZQ9mNQim8tJqho2vrCeN0fGPKljqZ7dvqnmPv7bTC/josv9mpJ499cownEXndT3
 bAvXj/dDVoroI6ittkC6JfE7Vzwt1fzikd5dBndeeWu8+cjqaSDOZLTgD6DzKO3ichfyL6dwfDE
 jqF6kWOepYP2CYfQrgMmS+DnR9oVL70GMcUHOoJlhdpaF3QffUKx1bNanUXuLzlTIr9VZDp0hlM
 w9ltSRj+aLe+zpbw==
X-Received: by 2002:a05:620a:838a:b0:949:6f9f:34fe with SMTP id
 af79cd13be357-949ba9fe0acmr2083532985a.36.1795474447902; 
 Mon, 23 Nov 2026 14:54:07 -0800 (PST)
X-Received: by 2002:a05:620a:838a:b0:949:6f9f:34fe with SMTP id
 af79cd13be357-949ba9fe0acmr2083530185a.36.1795474447415; 
 Mon, 23 Nov 2026 14:54:07 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6bb989b3sm24641246f8f.51.2026.11.23.14.54.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Nov 2026 14:54:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org
Subject: [PATCH-for-11.2 2/9] hw/sd/sdcard: Do not write data to
 write-protected areas
Date: Mon, 23 Nov 2026 23:53:42 +0100
Message-ID: <20261123225349.54981-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261123225349.54981-1-philmd@oss.qualcomm.com>
References: <20261123225349.54981-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA5MSBTYWx0ZWRfX6Ykb8o+3R8EP
 9MbwuZtQsQiQuwuTlstsgsX9FeDQlrGM3yw+EsuSXwmXrj9bbKRxffWfgT4/AuxvbmeNhtoMDZI
 BQTQHUVCxUUXtriVHV0iYkcHomhqfkoUP6ahJNjKxywsqWK2ooo8fTTC2ZWVpjF75O8jbT6ZvP4
 2IrRtij5NmiM2tfb2Rr1YdDMl55JRNoWQUWXB6bRfB5SXhAe0Wyz+RV56IrM/tzengKWGNk+efp
 fTOMFQzYE8XLRKzTXkFAnojp+1YglwMlA/TC/M3LfM0WgdcCUyDQ+NJR2bKcSss5G3Fy/TaKLkG
 Fe1SX8DkeqPE3mIadzWqkqPSoZWwG/osMY9gheKoWCYUVjZnCZBiFRnOra4/ggkKK3bgHwIRcd8
 9BJdWID//OdF+WmJwAoFSnn6S2sd4qkmROAA8uw1k1f5lH9aLrBovM8YqlKkVV+PKQPOZQJK+Tk
 PPlViorsp6G0MfenP2A==
X-Proofpoint-ORIG-GUID: bOQCag-ZJ437fMc31CIR8laVeNvSBmUx
X-Authority-Analysis: v=2.4 cv=QrXLTlyd c=1 sm=1 tr=0 ts=6b04c410 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=Jfmu8KON9GdjRzWt8d0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: bOQCag-ZJ437fMc31CIR8laVeNvSBmUx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA5MSBTYWx0ZWRfX7O6HFiE4HteW
 aHFxMf6tyGvdbtTB2eBP7bVOP6L1FtPROhKkHY2jp9aCp5T0MB5Ujq2BTR28mQopxif1u54J3Wk
 OPc9ofYShaLnDK7OcsI/wemsX+oTweU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230091
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

WRITE_SINGLE_BLOCK (CMD24) and WRITE_MULTIPLE_BLOCK (CMD25) check
write protection when the command is received, set the WP_VIOLATION
status bit and enter the receiving-data state, relying on
sd_write_data() to ignore the data while WP_VIOLATION is set.

However WP_VIOLATION is cleared on read: it is cleared when the R1
response of the write command is built, before any data is received.
The data is then committed to the backing image, bypassing:

- the write protect groups (CMD28) for CMD24,
- the CSD TMP_WRITE_PROTECT / PERM_WRITE_PROTECT bits for CMD24
  and CMD25 (CMD25 only re-checks the write protect groups).

Introduce sd_wp_violation() and check it again when committing the
data.

Cc: qemu-stable@nongnu.org
Fixes: a1bb27b1e98a ("SD card emulation (initial implementation)")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/sd/sd.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 6b817f11c5d2..04870c7b3962 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1481,6 +1481,17 @@ static inline bool sd_wp_addr(SDState *sd, uint64_t addr)
     return test_bit(sd_addr_to_wpnum(addr), sd->wp_group_bmap);
 }
 
+/* Return true if writing at @addr violates a write protection */
+static bool sd_wp_violation(SDState *sd, uint64_t addr)
+{
+    /* Permanent or temporary write protection of the whole card */
+    if (sd->csd[14] & 0x30) {
+        return true;
+    }
+    /* Only SDSC cards support write protect groups */
+    return sd->size <= SDSC_MAX_CAPACITY && sd_wp_addr(sd, addr);
+}
+
 static void sd_lock_command(SDState *sd)
 {
     int erase, lock, clr_pwd, set_pwd, pwd_len;
@@ -2691,6 +2702,10 @@ static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
     switch (sd->current_cmd) {
     case 24:  /* CMD24:  WRITE_SINGLE_BLOCK */
         if (sd_generic_write_data(sd, buf, &length)) {
+            if (sd_wp_violation(sd, sd->data_start)) {
+                sd->card_status |= WP_VIOLATION;
+                break;
+            }
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
             sd_blk_write(sd, sd->data_start, sd->data_offset);
@@ -2714,11 +2729,9 @@ static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
                                   sd->data_start, blk_len)) {
                 break;
             }
-            if (sd->size <= SDSC_MAX_CAPACITY) {
-                if (sd_wp_addr(sd, sd->data_start)) {
-                    sd->card_status |= WP_VIOLATION;
-                    break;
-                }
+            if (sd_wp_violation(sd, sd->data_start)) {
+                sd->card_status |= WP_VIOLATION;
+                break;
             }
         }
         sd->data[sd->data_offset++] = value[0];
-- 
2.55.0


