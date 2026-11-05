Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5900606D82E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 12:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GtDxK3HM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CUweKV9p
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOx1c-00078H-0N; Thu, 05 Nov 2026 07:57:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOwz6-0004Nb-5F
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 07:54:30 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOwz3-0005t8-SV
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 07:54:27 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A59tJE73684598
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 12:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nX7INPBhRNlLnO+y4Wv2CzYvOQ+2sQ7fNu8pWhDB3/U=; b=GtDxK3HMVBIDhVIQ
 Bvm1UEiKLCqRXoOdqZdciI4lLhH1DjT8J5jOoZj/BBa50mOkZd3x/ryKEGKqORjB
 qG8ggpnN9zModum+SpyQj/pLWwblpFtTQqKPI/ztD9h0fDij4deL9FtOqsy6szjx
 FqZHqWs1upvW8BkNIFIlK/BJuMrUBLrfF8qWp0mlUMNvHh7zJiSQFRJGWLDN5YGX
 OPJQuK9QSkqk+gSLPcB2MDE7krbnWNWMhUt+rSAmACkJpx3Yq8rJPytfNZxmAzTu
 V/cOELsXDtryHd4x7Q3dY9h46oxxk5d17oqtUxDsayozCLEkDItWO1YbxNj+qApU
 LzbiZw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrj43j4vw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 12:54:14 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f13c143c8so351815985a.3
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 04:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793883253; x=1794488053; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nX7INPBhRNlLnO+y4Wv2CzYvOQ+2sQ7fNu8pWhDB3/U=;
 b=CUweKV9pNn4RndJaLsxWaFBA8c979nUY+Q0Lx2aB301skFIViPCV231wOv4L4PX8JY
 l/tZlqrVLaS8m0Wk3daZnhc25JMe46eCbLJHq2KdzCEdWWLQ6u0SRb9iSmYvzNnxQoxJ
 Yt3iZnUmLiJMhyntECaxOVgH0pj2f0HzTkKhrKPx6SnXt/xzL7/Yjo0k2mzY0Xlod6SO
 VqRfduTs2xoDzc/GkAcFL6cDYjYqzubiHNCCu1zT0X3p3VnKkYMWqXV+nrPyi8Lnl2EU
 KmkhS8NcsRqwa9pcve7E7xFjfcIkh7p8aYtC9kcYlPYTfAr4Ox1lOd9azNF99JncPRaW
 a/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793883253; x=1794488053;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nX7INPBhRNlLnO+y4Wv2CzYvOQ+2sQ7fNu8pWhDB3/U=;
 b=Do0gjSWlfJbU9r0VmYUQkLlX5rJTuZ+5g0LKRbN7FUHC/5N8YbyMD436mxa0noaL6U
 HG9KFT4t3PBXyT6ZVL/6HIF4H1txNNHo9jpW/sYbPcC8J+48mfYIsSXpb200tsAgzcY5
 xW8WvBwVzqjtKYHr92rJjNTg1s+Mmi0QWdFguA1ZCDwYhL5OCdLSlLiBc6fWlKYXgEHB
 gw5CbxA5RWQ/ECyyd/CGxy/e9dJ9jnFek/wlDW+HcdJ7JvgdN2JMuiZMKDAL+OjOhZ+Z
 PkHiFSl4fIiF+bdDf3tl8U++uAgI8HE4T237QtCU3TH+lIRYEkfkK+fvMtDeAVeb4D1P
 A8BA==
X-Gm-Message-State: APuU4Z8VBLfazE/vBHixcSvEPvyZCSjLCK7cFRjZ2EyFYCy1vf5JU5yB
 PlKaK621SnlYL6l0ns2Lxl9Saa9lsGMKh+WCTnQcAnP0ApNq9HX9RyTMcZxt3f9ICS3qRH0zilR
 b3261iFXJwU+OykDG1mK8OrgTlf56l0L8bP8n2fL+lMSvUFnHMOeuthCy1/BKXwFqWA==
X-Gm-Gg: AYBFou3YeiqahIqGijF3mtEgYFox17OT4mACD8JU/11TlAaVXgonSG8O8j99Ek5GQbr
 eDCxMyv7QGS/BBKrV4mquaK0zUmPZCe/+UO5E3/YNy/vqPq6fdkeJxydzd10hG1Q2J2mu+5O9h2
 AhgYEZfbDyS3/3UUQxT9hs6ahQxwd3ptWSfrKMR6+GxAcokQm7kTjl91bWNrSc6an0vdyRigFVN
 lcJ4gAmJfu/3XWKjKtykOBTIHctGTUhulTWY7pNEoBFRrbWDUpwO0hpUZn2WlHZNres1QqzrStP
 F/DS/wWZwyz0asfJZTN4WY8B6zqJ4lXoQwTNHmNyov1lChupAi3TnTsB3u9Km0fwu3gnXmVn1FX
 HuX4NRcubt2XNJ3pE9odCFPHrFs90I9zQ/aGqLBOGQ/YpoQiTQQHj4wmN4CZpVKhD9lfU9LJxlq
 z2sqHndEfFWBsr3xN58BGcxVekRejb1g==
X-Received: by 2002:a05:620a:318a:b0:93f:54e4:6d43 with SMTP id
 af79cd13be357-94421585553mr3134788185a.6.1793883253189; 
 Thu, 05 Nov 2026 04:54:13 -0800 (PST)
X-Received: by 2002:a05:620a:318a:b0:93f:54e4:6d43 with SMTP id
 af79cd13be357-94421585553mr3134784585a.6.1793883252641; 
 Thu, 05 Nov 2026 04:54:12 -0800 (PST)
Received: from localhost.localdomain (104.171.88.92.rev.sfr.net.
 [92.88.171.104]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b58c868e70sm148033a12.24.2026.11.05.04.54.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Nov 2026 04:54:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 13/17] target/xtensa: Replace deprecated sprintf() with
 snprintf()
Date: Thu,  5 Nov 2026 13:51:58 +0100
Message-ID: <20261105125203.40320-14-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261105125203.40320-1-philmd@oss.qualcomm.com>
References: <20261105125203.40320-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 5NOZDHk637b9aKDDDAF7yrdacuR7DQns
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1MSBTYWx0ZWRfX6jERJqkEPWvv
 Gl3qkY/+WZeaOG0lADOJY57DZN4qwDXu1bUGC5DUl0fg1wDmdRLXVxv0K226NEvCe6hg6C6qWa3
 Y70PI3yfnQmO9FY0Dl72DTCIQEdS65sc+g3bj2ba2tARM9L2lkf2ErtioHee3oKLuJmKD2bd79g
 Jljl9EkeaWwDJXYtgTsc4coWRVRp6UhQIS7J1D7Zw+lM5ubKJv8K7ndBPZFOhL9YQYgjVQSeNWO
 kGLr7mbhn8B6yRBOCjpqih1bA5h4N7RMIY6lkv1Z7ZjkdyAXlNvSrbMxr0hRBqsWk13aG+A8ECM
 tGjMqJ3/H5yKgWFyLcYYariL1z4Zox2wAYT1gC4DqlXwb30UJvVoukSnmuwL84dcyQYsnVntIbm
 2Ed3pgvqYy+daX2ciKjcBap6NLj4C+AT3o5QPUb0iu1LCZd/AjCxq6siuv+vrMV6jL2HzwBgp53
 GaEWvYfJ5PwjaTl14zw==
X-Proofpoint-GUID: 5NOZDHk637b9aKDDDAF7yrdacuR7DQns
X-Authority-Analysis: v=2.4 cv=SZdi5fRu c=1 sm=1 tr=0 ts=6aec7c76 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=pBdeej1U2jlWEHTh2vTwjw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=rWSpPdxy7J_5Rebl_tYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1MSBTYWx0ZWRfXyTaO89j4WOTX
 12bhM/DOS292GSCRWzqRNHZ36VjY5Rg9pnyu64yWafmoCGXK5jZVbCY2ZpXyFdDtcbeXH/tJkY6
 Kh3hexYcPOohATETRRxy/CVOxDEV+cc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050051
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace sprintf() by safer snprintf() to format ISA error
message, silencing -Wdeprecated-declarations produced by
Apple clang 17.0.0.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/xtensa/xtensa-isa.c | 50 +++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/target/xtensa/xtensa-isa.c b/target/xtensa/xtensa-isa.c
index c564af340fa9..f589a7cffe01 100644
--- a/target/xtensa/xtensa-isa.c
+++ b/target/xtensa/xtensa-isa.c
@@ -519,7 +519,8 @@ xtensa_format xtensa_format_lookup(xtensa_isa isa, const char *fmtname)
     }
 
     xtisa_errno = xtensa_isa_bad_format;
-    sprintf(xtisa_error_msg, "format \"%s\" not recognized", fmtname);
+    snprintf(xtisa_error_msg, sizeof(xtisa_error_msg),
+             "format \"%s\" not recognized", fmtname);
     return XTENSA_UNDEFINED;
 }
 
@@ -646,7 +647,8 @@ xtensa_opcode xtensa_opcode_lookup(xtensa_isa isa, const char *opname)
 
     if (!result) {
         xtisa_errno = xtensa_isa_bad_opcode;
-        sprintf(xtisa_error_msg, "opcode \"%s\" not recognized", opname);
+        snprintf(xtisa_error_msg, sizeof(xtisa_error_msg),
+                 "opcode \"%s\" not recognized", opname);
         return XTENSA_UNDEFINED;
     }
 
@@ -692,7 +694,7 @@ int xtensa_opcode_encode(xtensa_isa isa, xtensa_format fmt, int slot,
     encode_fn = intisa->opcodes[opc].encode_fns[slot_id];
     if (!encode_fn) {
         xtisa_errno = xtensa_isa_wrong_slot;
-        sprintf(xtisa_error_msg,
+        snprintf(xtisa_error_msg, sizeof(xtisa_error_msg),
                 "opcode \"%s\" is not allowed in slot %d of format \"%s\"",
                 intisa->opcodes[opc].name, slot, intisa->formats[fmt].name);
         return -1;
@@ -809,7 +811,8 @@ xtensa_funcUnit_use *xtensa_opcode_funcUnit_use(xtensa_isa isa,
     CHECK_OPCODE(intisa, opc, NULL);
     if (u < 0 || u >= intisa->opcodes[opc].num_funcUnit_uses) {
         xtisa_errno = xtensa_isa_bad_funcUnit;
-        sprintf(xtisa_error_msg, "invalid functional unit use number (%d); "
+        snprintf(xtisa_error_msg, sizeof(xtisa_error_msg),
+                 "invalid functional unit use number (%d); "
                 "opcode \"%s\" has %d", u, intisa->opcodes[opc].name,
                 intisa->opcodes[opc].num_funcUnit_uses);
         return NULL;
@@ -825,7 +828,8 @@ xtensa_funcUnit_use *xtensa_opcode_funcUnit_use(xtensa_isa isa,
     do { \
         if ((OPND) < 0 || (OPND) >= (ICLASS)->num_operands) { \
             xtisa_errno = xtensa_isa_bad_operand; \
-            sprintf(xtisa_error_msg, "invalid operand number (%d); " \
+            snprintf(xtisa_error_msg, sizeof(xtisa_error_msg), \
+                     "invalid operand number (%d); " \
                     "opcode \"%s\" has %d operands", (OPND), \
                     (INTISA)->opcodes[(OPC)].name, (ICLASS)->num_operands); \
             return ERRVAL; \
@@ -938,7 +942,7 @@ int xtensa_operand_get_field(xtensa_isa isa, xtensa_opcode opc, int opnd,
     get_fn = intisa->slots[slot_id].get_field_fns[intop->field_id];
     if (!get_fn) {
         xtisa_errno = xtensa_isa_wrong_slot;
-        sprintf(xtisa_error_msg,
+        snprintf(xtisa_error_msg, sizeof(xtisa_error_msg),
                 "operand \"%s\" does not exist in slot %d of format \"%s\"",
                 intop->name, slot, intisa->formats[fmt].name);
         return -1;
@@ -974,7 +978,7 @@ int xtensa_operand_set_field(xtensa_isa isa, xtensa_opcode opc, int opnd,
     set_fn = intisa->slots[slot_id].set_field_fns[intop->field_id];
     if (!set_fn) {
         xtisa_errno = xtensa_isa_wrong_slot;
-        sprintf(xtisa_error_msg,
+        snprintf(xtisa_error_msg, sizeof(xtisa_error_msg),
                 "operand \"%s\" does not exist in slot %d of format \"%s\"",
                 intop->name, slot, intisa->formats[fmt].name);
         return -1;
@@ -1050,7 +1054,8 @@ int xtensa_operand_encode(xtensa_isa isa, xtensa_opcode opc, int opnd,
         (test_val = *valp, (*intop->decode)(&test_val)) ||
         test_val != orig_val) {
         xtisa_errno = xtensa_isa_bad_value;
-        sprintf(xtisa_error_msg, "cannot encode operand value 0x%08x", *valp);
+        snprintf(xtisa_error_msg, sizeof(xtisa_error_msg),
+                 "cannot encode operand value 0x%08x", *valp);
         return -1;
     }
 
@@ -1076,7 +1081,8 @@ int xtensa_operand_decode(xtensa_isa isa, xtensa_opcode opc, int opnd,
 
     if ((*intop->decode)(valp)) {
         xtisa_errno = xtensa_isa_bad_value;
-        sprintf(xtisa_error_msg, "cannot decode operand value 0x%08x", *valp);
+        snprintf(xtisa_error_msg, sizeof(xtisa_error_msg),
+                 "cannot decode operand value 0x%08x", *valp);
         return -1;
     }
     return 0;
@@ -1186,7 +1192,7 @@ int xtensa_operand_do_reloc(xtensa_isa isa, xtensa_opcode opc, int opnd,
 
     if ((*intop->do_reloc)(valp, pc)) {
         xtisa_errno = xtensa_isa_bad_value;
-        sprintf(xtisa_error_msg,
+        snprintf(xtisa_error_msg, sizeof(xtisa_error_msg),
                 "do_reloc failed for value 0x%08x at PC 0x%08x", *valp, pc);
         return -1;
     }
@@ -1218,7 +1224,7 @@ int xtensa_operand_undo_reloc(xtensa_isa isa, xtensa_opcode opc, int opnd,
 
     if ((*intop->undo_reloc)(valp, pc)) {
         xtisa_errno = xtensa_isa_bad_value;
-        sprintf(xtisa_error_msg,
+        snprintf(xtisa_error_msg, sizeof(xtisa_error_msg),
                 "undo_reloc failed for value 0x%08x at PC 0x%08x", *valp, pc);
         return -1;
     }
@@ -1234,7 +1240,8 @@ int xtensa_operand_undo_reloc(xtensa_isa isa, xtensa_opcode opc, int opnd,
     do { \
         if ((STOP) < 0 || (STOP) >= (ICLASS)->num_stateOperands) { \
             xtisa_errno = xtensa_isa_bad_operand; \
-            sprintf(xtisa_error_msg, "invalid state operand number (%d); " \
+            snprintf(xtisa_error_msg, sizeof(xtisa_error_msg), \
+                     "invalid state operand number (%d); " \
                     "opcode \"%s\" has %d state operands", (STOP), \
                     (INTISA)->opcodes[(OPC)].name, \
                     (ICLASS)->num_stateOperands); \
@@ -1279,7 +1286,7 @@ char xtensa_stateOperand_inout(xtensa_isa isa, xtensa_opcode opc, int stOp)
     do { \
         if ((IFOP) < 0 || (IFOP) >= (ICLASS)->num_interfaceOperands) { \
             xtisa_errno = xtensa_isa_bad_operand; \
-            sprintf(xtisa_error_msg, \
+            snprintf(xtisa_error_msg, sizeof(xtisa_error_msg), \
                     "invalid interface operand number (%d); " \
                     "opcode \"%s\" has %d interface operands", (IFOP), \
                     (INTISA)->opcodes[(OPC)].name, \
@@ -1337,7 +1344,8 @@ xtensa_regfile xtensa_regfile_lookup(xtensa_isa isa, const char *name)
     }
 
     xtisa_errno = xtensa_isa_bad_regfile;
-    sprintf(xtisa_error_msg, "regfile \"%s\" not recognized", name);
+    snprintf(xtisa_error_msg, sizeof(xtisa_error_msg),
+             "regfile \"%s\" not recognized", name);
     return XTENSA_UNDEFINED;
 }
 
@@ -1369,7 +1377,8 @@ xtensa_regfile xtensa_regfile_lookup_shortname(xtensa_isa isa,
     }
 
     xtisa_errno = xtensa_isa_bad_regfile;
-    sprintf(xtisa_error_msg, "regfile shortname \"%s\" not recognized",
+    snprintf(xtisa_error_msg, sizeof(xtisa_error_msg),
+             "regfile shortname \"%s\" not recognized",
             shortname);
     return XTENSA_UNDEFINED;
 }
@@ -1453,7 +1462,8 @@ xtensa_state xtensa_state_lookup(xtensa_isa isa, const char *name)
 
     if (!result) {
         xtisa_errno = xtensa_isa_bad_state;
-        sprintf(xtisa_error_msg, "state \"%s\" not recognized", name);
+        snprintf(xtisa_error_msg, sizeof(xtisa_error_msg),
+                 "state \"%s\" not recognized", name);
         return XTENSA_UNDEFINED;
     }
 
@@ -1555,7 +1565,8 @@ xtensa_sysreg xtensa_sysreg_lookup_name(xtensa_isa isa, const char *name)
 
     if (!result) {
         xtisa_errno = xtensa_isa_bad_sysreg;
-        sprintf(xtisa_error_msg, "sysreg \"%s\" not recognized", name);
+        snprintf(xtisa_error_msg, sizeof(xtisa_error_msg),
+                 "sysreg \"%s\" not recognized", name);
         return XTENSA_UNDEFINED;
     }
 
@@ -1626,7 +1637,8 @@ xtensa_interface xtensa_interface_lookup(xtensa_isa isa, const char *ifname)
 
     if (!result) {
         xtisa_errno = xtensa_isa_bad_interface;
-        sprintf(xtisa_error_msg, "interface \"%s\" not recognized", ifname);
+        snprintf(xtisa_error_msg, sizeof(xtisa_error_msg),
+                 "interface \"%s\" not recognized", ifname);
         return XTENSA_UNDEFINED;
     }
 
@@ -1716,7 +1728,7 @@ xtensa_funcUnit xtensa_funcUnit_lookup(xtensa_isa isa, const char *fname)
 
     if (!result) {
         xtisa_errno = xtensa_isa_bad_funcUnit;
-        sprintf(xtisa_error_msg,
+        snprintf(xtisa_error_msg, sizeof(xtisa_error_msg),
                 "functional unit \"%s\" not recognized", fname);
         return XTENSA_UNDEFINED;
     }
-- 
2.55.0


