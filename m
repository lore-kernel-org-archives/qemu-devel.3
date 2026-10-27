Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAD5606A324
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WQwzeGv1;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=F2I0/ekd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmmS-0001BV-I1; Tue, 27 Oct 2026 15:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmmA-00014H-6F
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:24:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmm8-0001mU-17
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:24:01 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHYid1917403
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:23:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 is010zUrhoN8u9ji7weOn/sehzCY9e9z3Fo6stBSK2Y=; b=WQwzeGv1ST+AWC84
 ePbWDa7H+sJF34haM7svHhCa3FX2N0ds6VEwTYwiOQNgXC/doNmJfa/Cay/xOci3
 WqZBU3UTajfcFR2dFfW5V2Ufw4i6QbpAYSdDMhh3fe9xRJsQgHBPyN9zJPv3t7mp
 WCouVcQquTRW3OH13VjoH/pLQZR72OlJTDwKkGInAZ1rrTAw7r2V1C4GYu+PVLsp
 N8c48zc5Hetx040TnuR8oHNCa+PiiXePGx6szXgz/cweyuhgIM1idEKJW9CrdcAk
 vEzsMqdo/gb6NPUR/JldISwqdbVashvQirV+gGDfaAv8SCgZks+qwWs4Ze92F/uV
 Btfdvw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjux99upb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:23:58 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f559420f3so13628085a.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129038; x=1793733838; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=is010zUrhoN8u9ji7weOn/sehzCY9e9z3Fo6stBSK2Y=;
 b=F2I0/ekdg1s3v5EcPfBFCe1ErwOPH7sQZ8ERYdV6QgmyuazIhIqfHjuNsGvDkNUJ+j
 MDA3xxdrG9AObLEev5fdUrlXpCSIhZGM5lt8BBDOCxk/qCKIbOIzhWlvPIYpFJeNWxAT
 caMj78omoIPDDwokN8B0uVYgnwv3tfDdjf4PBH/1EM6xcxeaYq17G9ZALWfPark2VhH6
 NTU89TJVxEm4s3xfW9NAmcjvZmWZy+jM18KHGWcaTGUtIh5okHkvZLAP8Q4NA8EfFXGj
 wei/xFGADMcDzwZPaQuanQtYz7+EQeFr9uf4P2xnIvxmqgln8dGRXEbWV8li7ZfhFTC7
 1pYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129038; x=1793733838;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=is010zUrhoN8u9ji7weOn/sehzCY9e9z3Fo6stBSK2Y=;
 b=vj2f9RzGkK+XArsL/ndDNrZLMVHDBUogWcOuN59wZsnkP2FK0GM35YV+75z1L/3pir
 udx2heYcteEtIIju7Xt0WH5jqSiRzLg04oRnrNRdKIGJ1diDg1XFSdpA3+xb/zH3M/Nf
 WZSMomrnHAvN40UZ5J95GyedZQ6q5StifX2w0QNGuR0op2Nux4J07G5SOoTLfa+EcrYR
 MLPCVEcdU2nN5VFqLy06G4ZgAlXvzZ3bFHyvb8iQb4NGnyn4pr0aFvSZGnDg6MwPoulE
 t5fAIvo3WrQVfTczUHmwUTg5eA2M/tovgLBnoWLEfGEG0BirkaDVmbOk6vhz5bfuouS9
 rDHw==
X-Gm-Message-State: AFq9FYIf0GHWOa5vNYES6ICIR+jGbBZXWMopaNse8WbdfhdtTLjxt8kD
 zpAw1VymUfsWlYz30gZWPXRvnVVoGV13Gd5Z39gIFvmwwO+ADy6sfVAmbNmWpTz2Do9Z8vUs0kO
 7FXUayQCaqJw8pDa2qo9XG0rIB2kgv8YE8PdW4grFEdepe+BUXQIc9noRbEf8CJAzFg==
X-Gm-Gg: AYBFou0LWOJg9v/mIgC1fAQlxuqNeAKsbVqwdE9EViWThjfvBcdQI4f1bBCbtfpzHXN
 6MywaXeIkBbtjbcD2KvDhEBGLtxsuq5gT+WXI48utKjwXiejuygdRYbC/Slc9x6Itvh9nks5wSJ
 fZxscneBUW2n/IKWkcIh2KKkwBjeG55pNcfww2TKF5aphlhitYLmNtDPZzYrLzqasQifQk/1SAq
 q1FLb7VhnFe/xbmthFthscWipf6cZcbDylKzNowmp0JzVe6uEMyR44qmiAsP0Le47c9LiNIGJCE
 BTMMyWcLqBICz7gtiwE2es6VVDiAv4EwizWUSNjDd3W+Cr2ANLDfH9yPOt71vyL2LdOq4bAM5Gr
 skTAMCxeTpTgJ6hRyvIdSWtXAoxnRT8O49Q4GCZcz0xpSCiPu7zVREVgS
X-Received: by 2002:a05:620a:440d:b0:93e:a71a:5de0 with SMTP id
 af79cd13be357-940ef90f155mr1673961185a.26.1793129037922; 
 Tue, 27 Oct 2026 12:23:57 -0700 (PDT)
X-Received: by 2002:a05:620a:440d:b0:93e:a71a:5de0 with SMTP id
 af79cd13be357-940ef90f155mr1673956685a.26.1793129037296; 
 Tue, 27 Oct 2026 12:23:57 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a94c021080sm2789025e9.2.2026.10.27.12.23.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:23:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/59] hw/sd/sdcard: Keep high-capacity memory blocks at 512
 bytes
Date: Tue, 27 Oct 2026 20:22:43 +0100
Message-ID: <20261027192341.9197-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GYyCDgXL c=1 sm=1 tr=0 ts=6ae0fa4e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=FRSEYCzRAAAA:8 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=yJP4gdnfSgtB7lo5kH4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=H4N_Y-AU75W7NKDNhZlT:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: gbrTLaEIc5HtitM8mnrO_47sEvY6m2sy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3NyBTYWx0ZWRfX5LxuM+vqPeNy
 G0rhxPapbEcJ4G7YScJHmTuueFkKO1KdcLyPI2v+qL1BIycO3Ehv5syNQ+hEdsQNy7TXlf+eGZ3
 EKDeubI0CdBJItaSDy6sEtxB4R0uiU/i6Xn1z8epfHI+GYIfKB0zc8zxxvSc37trdPnFRTtLJhE
 5Bo+6OggWqIFwtTxmQF9uHHBBpAMFtn6qPPPwiyqxGAnVlg7WayOsf+/+/W3Kne3wiGOYDPxAZB
 /Vt6jplE4gEy5CRpTdc7R2ZakxhkmZHtP1JEGHmNBUYnlNEfdeGlQo6w5A9BCnWfUMlpTnvXGH6
 px53W8A3ETV33lRxC+2oypkulurPLCLJA0kjv1JGMug4XvrQmvFazMkwJoJE/C/DlId0tafMJv+
 vjTl7VMFgqyaXT9aYx4MVgdJJBHNPozQu30fSN96uAV293wkvWvWD6xNx+6xiN+yxZLMY0WuwfN
 tZ9JLzGWeyHIq+VjtiA==
X-Proofpoint-GUID: gbrTLaEIc5HtitM8mnrO_47sEvY6m2sy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3NyBTYWx0ZWRfX/1DRIf5+8qh0
 qutWCxBKS+gcOYtPn/RWc+UX6sAslUqoo8OPyISkJ48D5LP2045PYrJ6AhzXXw9mZ6LTBokvgEZ
 WQKl/kjDZ7VIn31HHACa7jQxPUDIEdU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270077
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

From: Bin Meng <bin.meng@processmission.com>

SDHC and SDXC memory commands always transfer 512-byte blocks regardless
of the length selected by CMD16. QEMU stores that selected length for
LOCK_UNLOCK but also used it directly for several memory command paths.

Route single- and multi-block memory sizing through the existing helper
that distinguishes high-capacity cards from SDSC.

This lets PolarFire SoC HSS validate the complete GPT header and locate
its boot partition instead of receiving only the eight-byte signature.

Cc: qemu-stable@nongnu.org
Fixes: 2d7adea4fe57 ("hw/sd: Support SDHC size cards")
Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20261014012323.322790-12-bin.meng@processmission.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/sd/sd.c | 43 +++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index b1b3b1226a76..0083b8e064e9 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1975,18 +1975,20 @@ static sd_rsp_type_t sd_cmd_SET_BLOCKLEN(SDState *sd, SDRequest req)
 static sd_rsp_type_t sd_cmd_READ_SINGLE_BLOCK(SDState *sd, SDRequest req)
 {
     uint64_t addr;
+    uint32_t blk_len;
 
     if (sd->state != sd_transfer_state) {
         return sd_invalid_state_for_cmd(sd, req);
     }
 
+    blk_len = sd_blk_len(sd);
     addr = sd_req_get_address(sd, req);
-    if (!address_in_range(sd, "READ_SINGLE_BLOCK", addr, sd->blk_len)) {
+    if (!address_in_range(sd, "READ_SINGLE_BLOCK", addr, blk_len)) {
         return sd_r1;
     }
 
-    sd_blk_read(sd, addr, sd->blk_len);
-    return sd_cmd_to_sendingdata(sd, req, addr, NULL, sd->blk_len);
+    sd_blk_read(sd, addr, blk_len);
+    return sd_cmd_to_sendingdata(sd, req, addr, NULL, blk_len);
 }
 
 /* CMD19 */
@@ -2025,13 +2027,15 @@ static sd_rsp_type_t sd_cmd_SET_BLOCK_COUNT(SDState *sd, SDRequest req)
 static sd_rsp_type_t sd_cmd_WRITE_SINGLE_BLOCK(SDState *sd, SDRequest req)
 {
     uint64_t addr;
+    uint32_t blk_len;
 
     if (sd->state != sd_transfer_state) {
         return sd_invalid_state_for_cmd(sd, req);
     }
 
+    blk_len = sd_blk_len(sd);
     addr = sd_req_get_address(sd, req);
-    if (!address_in_range(sd, "WRITE_SINGLE_BLOCK", addr, sd->blk_len)) {
+    if (!address_in_range(sd, "WRITE_SINGLE_BLOCK", addr, blk_len)) {
         return sd_r1;
     }
 
@@ -2045,7 +2049,7 @@ static sd_rsp_type_t sd_cmd_WRITE_SINGLE_BLOCK(SDState *sd, SDRequest req)
     }
 
     sd->blk_written = 0;
-    return sd_cmd_to_receivingdata(sd, req, addr, sd->blk_len);
+    return sd_cmd_to_receivingdata(sd, req, addr, blk_len);
 }
 
 /* CMD26 */
@@ -2372,7 +2376,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         switch (sd->state) {
         case sd_transfer_state:
 
-            if (!address_in_range(sd, "READ_BLOCK", addr, sd->blk_len)) {
+            if (!address_in_range(sd, "READ_BLOCK", addr, sd_blk_len(sd))) {
                 return sd_r1;
             }
 
@@ -2392,7 +2396,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         switch (sd->state) {
         case sd_transfer_state:
 
-            if (!address_in_range(sd, "WRITE_BLOCK", addr, sd->blk_len)) {
+            if (!address_in_range(sd, "WRITE_BLOCK", addr,
+                                  sd_blk_len(sd))) {
                 return sd_r1;
             }
 
@@ -2662,6 +2667,7 @@ static void sdcard_write_data_dump(const char *proto, const char *cmd_desc,
 static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
 {
     unsigned int partition_access;
+    uint32_t blk_len;
     int i;
     const uint8_t *value = buf;
 
@@ -2678,6 +2684,7 @@ static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
     if (sd->card_status & (ADDRESS_ERROR | WP_VIOLATION))
         return length;
 
+    blk_len = sd_blk_len(sd);
     sdcard_write_data_dump(sd->proto->name,
                            sd->last_cmd_name,
                            sd->current_cmd, sd->data_offset, buf, length);
@@ -2704,7 +2711,7 @@ static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
         if (sd->data_offset == 0) {
             /* Start of the block - let's check the address is valid */
             if (!address_in_range(sd, "WRITE_MULTIPLE_BLOCK",
-                                  sd->data_start, sd->blk_len)) {
+                                  sd->data_start, blk_len)) {
                 break;
             }
             if (sd->size <= SDSC_MAX_CAPACITY) {
@@ -2715,7 +2722,7 @@ static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
             }
         }
         sd->data[sd->data_offset++] = value[0];
-        if (sd->data_offset >= sd->blk_len) {
+        if (sd->data_offset >= blk_len) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
             partition_access = sd->ext_csd[EXT_CSD_PART_CONFIG]
@@ -2726,7 +2733,7 @@ static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
                 sd_blk_write(sd, sd->data_start, sd->data_offset);
             }
             sd->blk_written++;
-            sd->data_start += sd->blk_len;
+            sd->data_start += blk_len;
             sd->data_offset = 0;
             sd->csd[14] |= 0x40;
 
@@ -2810,7 +2817,7 @@ static size_t sd_read_data(SDState *sd, void *buf, size_t length)
     /* TODO: Append CRCs */
     const uint8_t dummy_byte = 0x00;
     unsigned int partition_access;
-    uint32_t io_len;
+    uint32_t blk_len;
     uint8_t *value = buf;
 
     if (!sd->blk || !blk_is_inserted(sd->blk)) {
@@ -2830,11 +2837,11 @@ static size_t sd_read_data(SDState *sd, void *buf, size_t length)
         return length;
     }
 
-    io_len = sd_blk_len(sd);
+    blk_len = sd_blk_len(sd);
 
     trace_sdcard_read_data(sd->proto->name,
                            sd->last_cmd_name, sd->current_cmd,
-                           sd->data_offset, sd->data_size, io_len);
+                           sd->data_offset, sd->data_size, blk_len);
     switch (sd->current_cmd) {
     case 6:  /* CMD6:   SWITCH_FUNCTION */
     case 8:  /* CMD8:   SEND_EXT_CSD */
@@ -2859,22 +2866,22 @@ static size_t sd_read_data(SDState *sd, void *buf, size_t length)
 
         if (sd->data_offset == 0) {
             if (!address_in_range(sd, "READ_MULTIPLE_BLOCK",
-                                  sd->data_start, io_len)) {
+                                  sd->data_start, blk_len)) {
                 *value = dummy_byte;
                 return length;
             }
             partition_access = sd->ext_csd[EXT_CSD_PART_CONFIG]
                     & EXT_CSD_PART_CONFIG_ACC_MASK;
             if (partition_access == EXT_CSD_PART_CONFIG_ACC_RPMB) {
-                emmc_rpmb_blk_read(sd, sd->data_start, io_len);
+                emmc_rpmb_blk_read(sd, sd->data_start, blk_len);
             } else {
-                sd_blk_read(sd, sd->data_start, io_len);
+                sd_blk_read(sd, sd->data_start, blk_len);
             }
         }
         *value = sd->data[sd->data_offset++];
 
-        if (sd->data_offset >= io_len) {
-            sd->data_start += io_len;
+        if (sd->data_offset >= blk_len) {
+            sd->data_start += blk_len;
             sd->data_offset = 0;
 
             if (sd->multi_blk_cnt != 0) {
-- 
2.55.0


