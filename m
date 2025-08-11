Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D69CA0EDC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 19:39:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulYL3-0007JC-6y; Mon, 11 Aug 2025 15:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1ulYKh-0007Dn-Ft
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 15:37:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1ulYKR-0003rX-Jv
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 15:37:22 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BGW383022560
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 19:37:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=kTCG4odqlk4
 I31FckedmmBZfTyjLctBkXvzLD9hftMI=; b=YvyoM7Nrz9Utd/f3AJsGiHbc830
 p7dJ1sXW40ZAOaP90AEaY4sqmg5MnpuqXYt/nyqjkgmsxqodT3BNJr2ONMdva8Om
 aK/a3t9RVIYOhSnbOxKG6LvkoxnzkaXIj19emqN2QZVMvW/y7AeogjcCGGpUUrNp
 la4PsuC+rDoLStZrVJWzajJ5A8OnicHA+EeFD/XOAAegFqN7r/f/n34NIsNqvKe0
 5BjDct9PuhB2hcRa3BpM3yo9BUibpUjpwKqmmC+XpA88Jo/w7gqxaaqJiEqcFK9G
 rMzI9WGD2laBPXbZH4oUEu09XEtohvCch7QXQs0WAJXmlFZ2EojZlxhFZgg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fm3vggcn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 19:37:01 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-76bf8e79828so9094079b3a.3
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 12:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754941020; x=1755545820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kTCG4odqlk4I31FckedmmBZfTyjLctBkXvzLD9hftMI=;
 b=El166ZYROAObLZUidH8FjbuQlCPVNc13gCAGuE5W5WEPNh7WwWDlfuVz+tjmp2H+Jj
 /aKUS0tYHrKBhVvm6LuqozlQS7j78tUOQKLAkVh4VRAQ9jCr+BNkEeuBZFnllXEVfKcW
 6Z383EiOcpssh+3PEmGxC4FogPv9BgiTKiNCWZqMDYSVp2w16KRtTEaY7yRgFeq7MaSV
 4aCkZXci+1YpYb6opKxM6A+Y4muBwLwwQavoM4SGjoHmAUBdz75FxNPnLt1FsDjaSAlv
 dB25eXcd/LyVA7BSl/CgQkBxEXrfLDdEmk/PwcG3aIHtsNJqeWwf0w8+A7LXZ79WsERh
 7zbQ==
X-Gm-Message-State: AOJu0YwGKWzik0Bees+aUXt3qxaWsNtHHpsRO6/IIh0zIb0Vwn1LFCRu
 Pwf2Bs9FwsUEY+bTar+QQ6UdpEy4bBaNh+n8VklV4WpjHKzZEtGQ2l4GryZMd5wm91x9RAsfAA/
 1cfEu6xx6ayYGkYt1SWcFC+uXgYHiqkm7h4GklW+uScyFbIJFmUJazlqlHlssHfkaJ9aY
X-Gm-Gg: ASbGncs1qzzll7E5kRJYPNaE37e8GoydlrVxodFY4UFTobFaPgeKBj9W0nn1WA72V7o
 UO3ytWbaGC7HOIT8hIBA1IknUX3QAU85r6lTl4FXrtI2Er+I7f6jpIIHRNjHZNSHb92GZaddBj0
 VOQsCP1lQnEauC5h/6+WYYiDq9JzCs372padeyRfC/71TklDLJ+ah7fGLs6Jv66oI8hkmBUWUoI
 Uczzrh6NIKu4VpaAFfb7y6X7g6R6b2o5VXguTAdey3dP4tEJBKLqnPZyX8K83MvD73zjiyV4AGe
 wwPvpj4l+FZWoysY5vMVYt5ckGO2F/4HsFAvsj7egHrEJjZ8xIovt7NMwzGvBG6wsJbHlLqXjSm
 H0wjzSVvZa8nNvqM=
X-Received: by 2002:a05:6a00:14cc:b0:748:f750:14c6 with SMTP id
 d2e1a72fcca58-76c4615bd8cmr20210597b3a.14.1754941019698; 
 Mon, 11 Aug 2025 12:36:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKY/+VMA4PGeSzQIazQ5ZD0pwlpk82BzSIgQzHx6RHSkmcgZaY3DKMeQMifr4wZ3Y0/xK7dQ==
X-Received: by 2002:a05:6a00:14cc:b0:748:f750:14c6 with SMTP id
 d2e1a72fcca58-76c4615bd8cmr20210563b3a.14.1754941019262; 
 Mon, 11 Aug 2025 12:36:59 -0700 (PDT)
Received: from admin15.qualcomm.com (i-global254.qualcomm.com.
 [199.106.103.254]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bccfbcef6sm27677171b3a.85.2025.08.11.12.36.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 12:36:58 -0700 (PDT)
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Subject: [PATCH v5 2/4] target/arm: Change GDBState's line_buf to a GString
Date: Mon, 11 Aug 2025 19:36:52 +0000
Message-Id: <20250811193654.4012878-3-vacha.bhavsar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811193654.4012878-1-vacha.bhavsar@oss.qualcomm.com>
References: <20250811193654.4012878-1-vacha.bhavsar@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDEwNyBTYWx0ZWRfX7rg3lAmh9H4Z
 9aoCjSZ8o+Sx6SZTP0CitobNhP/WjLDQpo1cQlH+bfKDEW5saewyZ5Ei+2zkg7HKu/fE391psHq
 v1rYz07Cc+skWVggVZ8TwzX3aSE4r+NkBR14nCsXZf0uLeFqetC+oygZNX9rB+R2pz3xWJPpKUY
 4gwJJSvGp/vyeB0PHwWfJSGsNrpSjDAd+uWgTd1Yrp2TyEvwCrKawsuWgCR4FJbY7jjISuxvnl7
 gEuGmabCAoQBTlpfX1jLju3Qh66R3KKD8Y6tNAxUsw/vUW7i50NKckxzEma14GcROlpNjibEu1p
 nKqh7D1K6he3Qli5YVUiH+nx9EraXiklEXCYkMsZ918aRRVy8eST9+qbs9v6eTV3mGrSQij/Ihm
 qrSHTXie
X-Proofpoint-GUID: VH6TMhomdvMMGg8Ik19t1DSC5yIbiJMe
X-Authority-Analysis: v=2.4 cv=A+1sP7WG c=1 sm=1 tr=0 ts=689a465d cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=w1AtNIWgmVDSpf7mFgMA:9
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: VH6TMhomdvMMGg8Ik19t1DSC5yIbiJMe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_04,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110107
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=vacha.bhavsar@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch changes GDBState's line_buf from a character
array to a GString. This allows line_buf to be dynamically
re-sizeable.

Signed-off-by: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
---
Changes since v4:
- this patch was not present in v4, it has been added as
suggested during review of v4
---
 gdbstub/gdbstub.c   | 25 +++++++++++++------------
 gdbstub/internals.h |  3 +--
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index dd5fb5667c..0634ff9e91 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -64,6 +64,7 @@ void gdb_init_gdbserver_state(void)
     memset(&gdbserver_state, 0, sizeof(GDBState));
     gdbserver_state.init = true;
     gdbserver_state.str_buf = g_string_new(NULL);
+    gdbserver_state.line_buf = g_string_new(NULL);
     gdbserver_state.mem_buf = g_byte_array_sized_new(MAX_PACKET_LENGTH);
     gdbserver_state.last_packet = g_byte_array_sized_new(MAX_PACKET_LENGTH + 4);
 
@@ -2369,7 +2370,7 @@ void gdb_read_byte(uint8_t ch)
         case RS_IDLE:
             if (ch == '$') {
                 /* start of command packet */
-                gdbserver_state.line_buf_index = 0;
+                g_string_set_size(gdbserver_state.line_buf, 0);
                 gdbserver_state.line_sum = 0;
                 gdbserver_state.state = RS_GETLINE;
             } else if (ch == '+') {
@@ -2393,12 +2394,12 @@ void gdb_read_byte(uint8_t ch)
             } else if (ch == '#') {
                 /* end of command, start of checksum*/
                 gdbserver_state.state = RS_CHKSUM1;
-            } else if (gdbserver_state.line_buf_index >= sizeof(gdbserver_state.line_buf) - 1) {
+            } else if (gdbserver_state.line_buf->len >= MAX_PACKET_LENGTH) {
                 trace_gdbstub_err_overrun();
                 gdbserver_state.state = RS_IDLE;
             } else {
                 /* unescaped command character */
-                gdbserver_state.line_buf[gdbserver_state.line_buf_index++] = ch;
+                g_string_append_c(gdbserver_state.line_buf, (gchar) ch);
                 gdbserver_state.line_sum += ch;
             }
             break;
@@ -2406,13 +2407,13 @@ void gdb_read_byte(uint8_t ch)
             if (ch == '#') {
                 /* unexpected end of command in escape sequence */
                 gdbserver_state.state = RS_CHKSUM1;
-            } else if (gdbserver_state.line_buf_index >= sizeof(gdbserver_state.line_buf) - 1) {
+            } else if (gdbserver_state.line_buf->len >= MAX_PACKET_LENGTH) {
                 /* command buffer overrun */
                 trace_gdbstub_err_overrun();
                 gdbserver_state.state = RS_IDLE;
             } else {
                 /* parse escaped character and leave escape state */
-                gdbserver_state.line_buf[gdbserver_state.line_buf_index++] = ch ^ 0x20;
+                g_string_append_c(gdbserver_state.line_buf, (gchar) ch ^ 0x20);
                 gdbserver_state.line_sum += ch;
                 gdbserver_state.state = RS_GETLINE;
             }
@@ -2429,19 +2430,20 @@ void gdb_read_byte(uint8_t ch)
             } else {
                 /* decode repeat length */
                 int repeat = ch - ' ' + 3;
-                if (gdbserver_state.line_buf_index + repeat >= sizeof(gdbserver_state.line_buf) - 1) {
+                if (gdbserver_state.line_buf->len + repeat >= MAX_PACKET_LENGTH) {
                     /* that many repeats would overrun the command buffer */
                     trace_gdbstub_err_overrun();
                     gdbserver_state.state = RS_IDLE;
-                } else if (gdbserver_state.line_buf_index < 1) {
+                } else if (gdbserver_state.line_buf->len < 1) {
                     /* got a repeat but we have nothing to repeat */
                     trace_gdbstub_err_invalid_rle();
                     gdbserver_state.state = RS_GETLINE;
                 } else {
                     /* repeat the last character */
-                    memset(gdbserver_state.line_buf + gdbserver_state.line_buf_index,
-                           gdbserver_state.line_buf[gdbserver_state.line_buf_index - 1], repeat);
-                    gdbserver_state.line_buf_index += repeat;
+                    for (int i = 0; i < repeat; i ++){
+                        g_string_append_c(gdbserver_state.line_buf, 
+                            gdbserver_state.line_buf->str[gdbserver_state.line_buf->len - 1]);
+                    }
                     gdbserver_state.line_sum += ch;
                     gdbserver_state.state = RS_GETLINE;
                 }
@@ -2454,7 +2456,6 @@ void gdb_read_byte(uint8_t ch)
                 gdbserver_state.state = RS_GETLINE;
                 break;
             }
-            gdbserver_state.line_buf[gdbserver_state.line_buf_index] = '\0';
             gdbserver_state.line_csum = fromhex(ch) << 4;
             gdbserver_state.state = RS_CHKSUM2;
             break;
@@ -2477,7 +2478,7 @@ void gdb_read_byte(uint8_t ch)
                 /* send ACK reply */
                 reply = '+';
                 gdb_put_buffer(&reply, 1);
-                gdbserver_state.state = gdb_handle_packet(gdbserver_state.line_buf);
+                gdbserver_state.state = gdb_handle_packet((char *) gdbserver_state.line_buf->str);
             }
             break;
         default:
diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index 87f64b6318..27afbef4f5 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -72,8 +72,7 @@ typedef struct GDBState {
     CPUState *g_cpu; /* current CPU for other ops */
     CPUState *query_cpu; /* for q{f|s}ThreadInfo */
     enum RSState state; /* parsing state */
-    char line_buf[MAX_PACKET_LENGTH];
-    int line_buf_index;
+    GString *line_buf;
     int line_sum; /* running checksum */
     int line_csum; /* checksum at the end of the packet */
     GByteArray *last_packet;
-- 
2.34.1


