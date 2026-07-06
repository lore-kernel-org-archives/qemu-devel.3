Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95970C44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjg6-0000gU-OJ; Mon, 06 Jul 2026 09:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjfn-0000PE-G5
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:47:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjfl-0006fW-N5
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:47:47 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666Ax8Qd391051
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 13:47:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MvoQnDtozHt73wE+jbszXo6UD42kabePeJj9Cd77CHA=; b=KUFL9ARDSle9mYox
 S9lQlt34hA/AY5pHYTDFkA7noH1bBMysUAWj8CZ9nczmTmL+zhIu2VFj5kFIhg4V
 FbHWA3k1jHqnh1MwrhFL6Ll3fy9u/lrfX4QXtiBoJ2Ba/6UuPDMZEinpQ8TXplD9
 WLEwdPaZB7HirAzLjGe/bUQbbnnPRsHYWz6YRC2vhG5eK0T1nn4czNwq+WfqQT6c
 TmYACew5oKgfspnjG8E8OrFlND7/7NsUUVy8bTXFFtKuojhZmsoFK6lj6ZZq/IbK
 tTOjREDq/q8ISFeuuS/qVJch447/VrFCV26NJN3H13tqojY+3pFn5TO7GF7kkQjR
 JIi8ig==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89kgs1ds-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 13:47:43 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e68cb7a3eso564790585a.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 06:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783345662; x=1783950462; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MvoQnDtozHt73wE+jbszXo6UD42kabePeJj9Cd77CHA=;
 b=DRKh5+Mp1nJ6JgcQ6avE/IyP4igigcCjfzgcVVwkh4bcvfM8R7Zh5YkwaghhPgaYu7
 p727bboSbx+rWI+lZUe+OMOLyze6Zl5j0a/BkS5i5I99DE7P8USPj8Pv4NnjRmMMEIhJ
 4pDfg/oRwms73aCA1roZA/5eB8KE5phvT/dAmzzH17jEqIukNPmvFxPuO/Clo7qSeztm
 EW8K3I8lGU77te8JIc4IOI7DREeV2D+38B+2+tC1wm78bUrgAOncTe8tuF9Fz4SDc7be
 tZ8gOUdl0VTNwTuQYmwgKSbC37e7RgdJCne7y9y+b56fKEJtUkv7T05jSe+u5xgcSv/A
 0XgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783345662; x=1783950462;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MvoQnDtozHt73wE+jbszXo6UD42kabePeJj9Cd77CHA=;
 b=Hq9E2ogfHgqkRLQqjb7Y6bjeRjH5q1Qg0Av67H+CtbLOKHFH6kiVJtOFQq+2F2wpC4
 ADf/0fdxF7SaC68VEhFWgd/Il4qUUj8UGUZnhkUg2B8SjDn9vD6fLxIS3UecLErFzMdq
 ZyxIQr9h4X1wNuwZFOoUfsY6LOIDiG47yWEofcP6BdY6pHsdxK6EC+lZ/S9naOlv/GCe
 cNQgRGCdLesj/z1r8QVXuVoZNi+hgmvZHhYry7aa5Dd4SYnRol+3EhkWide3sceHr3ZO
 niKVhyoXEnjSCC4Eoml9BmAYZxNHtTMRUAqdATK4xvksSds83DtB88zfR6sVFVIdFcx+
 JKpA==
X-Gm-Message-State: AOJu0Yw0Taxxq+QuO4bH/8P5nLw1AzB6pMv9I20EPethCegSQ6x2TsoU
 8UcmQQOTxo68uqhRhzPuU0dqGTwq51dYn5Yn6G/rIiqBe+h/eGYyx4Lah4sFFDDmlimDWzrCvZv
 VkE3yukOsjW7JvFmf6Q0G7USHmEoAX0ucAJqpyAyTB2gjynaSX69bMqq6LWM8SPu3aw==
X-Gm-Gg: AfdE7clB8oilHcigdfBtdSVqs55DvD7brdWql5AwFXAYkaPDQCbsS1BR5A+VVoQPaHS
 l1DqArhSu94FDE/zGxIEY5trb5xVwSHPppA4kyQL42D/bIh6TiUF/Oa1IxDgf8GqMz5Ij+1MiJC
 mSmKvZaeJWDSgZdBrAeLH43hXnz5NSZu9RizONGUfAOHhX8l8b14wNKh/1LR/uotwu4KGniH8B8
 HHwFgmg4E+sqeiRsP127V1zR1M3gj+hBnLfcyEEm82cSKkZkerguhx2AoXP6iEhm6b/rnlo80UJ
 FTXtRZMo1EzkKpZXrtKSgUu5ZWiwWrRax7A7GMkbrrDUQszoKG8r+kxSimv6wO6shyy3V2xgCAH
 DW7llvcG52/bRT8QOhoBd7NnkziYyBOIVdwC85CWGyJX9k2Yz6p+kEpaRrw==
X-Received: by 2002:a05:620a:4694:b0:923:5e7:1664 with SMTP id
 af79cd13be357-92ebb557e2bmr84906285a.45.1783345662231; 
 Mon, 06 Jul 2026 06:47:42 -0700 (PDT)
X-Received: by 2002:a05:620a:4694:b0:923:5e7:1664 with SMTP id
 af79cd13be357-92ebb557e2bmr84900785a.45.1783345661593; 
 Mon, 06 Jul 2026 06:47:41 -0700 (PDT)
Received: from localhost.localdomain (1.171.88.92.rev.sfr.net. [92.88.171.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c6381e4fsm429542855e9.8.2026.07.06.06.47.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Jul 2026 06:47:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/32] gdbstub: Move supported_sstep_flags in AccelGdbConfig
 structure
Date: Mon,  6 Jul 2026 15:45:09 +0200
Message-ID: <20260706134527.84808-15-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706134527.84808-1-philmd@oss.qualcomm.com>
References: <20260706134527.84808-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: OwiT_ZnMO41N8aJ4bHlw949XLEkRUXek
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MCBTYWx0ZWRfXzNe6PI1inihu
 6yBwT3WVt8W/FEm2qzmo/FiAPPXMp6EjVDAnsZuUZPFD3M/BQMzmCV/2bFM8tbq8IWYWygc/0Iy
 58bBFJTwBUOj4OnJSJlrth94mg9rO5pWfLTb1cTQdyKanzxChRFIjQvTDU24Erh6uh0tCy0sGkq
 TB0Rxv+ABR85o1LVRuXOKP6Is0Je++uKZ8LuFKxB3K6OG+vqk8fdOrva+sIOVVoJ8DfpYOpOQkI
 Bc6kTy54JGTU42B09SpTr0x84C+WZQqcF13Cv5KkY3v0uE40jZq1MSS3FqtTiYyblprMP6Ylloo
 V8UcESpP5quPfIhT2uQw/G9wd3tUDUwsrFlT8UMsrJiKUswO2W1c8NJgqJAqdWzIP6yPvgDWeT1
 B8J3J7bvKhNsYx8mhbq1evdeHMiK51vFbi/2O8/YpuNjpZhkUVQjC0oNLg58MNR40h30LavYYtW
 wyrU+GA9JFeo95AzYLg==
X-Proofpoint-ORIG-GUID: OwiT_ZnMO41N8aJ4bHlw949XLEkRUXek
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MCBTYWx0ZWRfX3m5s7W6oKu+y
 YsL0aF3cBxW1E48ufvWxik73adenUF6ABiYx0C3d6Z4E3/NsRev4cvWhsZkYceJOI2Ag6jcnPM4
 Gwxln+EDLby4f3fWO0Tm0Xu2Y2ytMm0=
X-Authority-Analysis: v=2.4 cv=c6Sbhx9l c=1 sm=1 tr=0 ts=6a4bb1ff cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PLEY+c9/kVlxBKEpvFYBUQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=-SUpAgEnhvh4vktFIKIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060140
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

supported_sstep_flags are per-accelerators. Move them
to a new AccelGdbConfig structure, still in GDBState.

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260705215729.62196-14-philmd@oss.qualcomm.com>
---
 gdbstub/internals.h  |  3 ++-
 include/qemu/accel.h |  9 +++++++++
 gdbstub/gdbstub.c    | 10 +++++-----
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index 60ddc146661..0444dee2246 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -9,6 +9,7 @@
 #ifndef GDBSTUB_INTERNALS_H
 #define GDBSTUB_INTERNALS_H
 
+#include "qemu/accel.h"
 #include "exec/cpu-common.h"
 
 /*
@@ -83,8 +84,8 @@ typedef struct GDBState {
     int process_num;
     GString *str_buf;
     GByteArray *mem_buf;
+    AccelGdbConfig accel_config;
     int sstep_flags;
-    int supported_sstep_flags;
     /*
      * Whether we are allowed to send a stop reply packet at this moment.
      * Must be set off after sending the stop reply itself.
diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index d3638c7bfda..052b4c59313 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -73,6 +73,15 @@ bool accel_cpu_common_realize(CPUState *cpu, Error **errp);
  */
 void accel_cpu_common_unrealize(CPUState *cpu);
 
+/**
+ * struct AccelGdbConfig - gdbstub configuration for an accelerator.
+ *
+ * @sstep_flags: Set SSTEP_* flags that accelerator supports for guest debug.
+ */
+typedef struct AccelGdbConfig {
+    unsigned sstep_flags;
+} AccelGdbConfig;
+
 /**
  * accel_supported_gdbstub_sstep_flags:
  *
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index f54415a9db7..06b712562c5 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -72,9 +72,9 @@ void gdb_init_gdbserver_state(void)
      * By default try to use no IRQs and no timers while single
      * stepping so as to make single stepping like a typical ICE HW step.
      */
-    gdbserver_state.supported_sstep_flags = accel_supported_gdbstub_sstep_flags();
+    gdbserver_state.accel_config.sstep_flags = accel_supported_gdbstub_sstep_flags();
     gdbserver_state.sstep_flags = SSTEP_ENABLE | SSTEP_NOIRQ | SSTEP_NOTIMER;
-    gdbserver_state.sstep_flags &= gdbserver_state.supported_sstep_flags;
+    gdbserver_state.sstep_flags &= gdbserver_state.accel_config.sstep_flags;
 }
 
 /* writes 2*len+1 bytes in buf */
@@ -1537,12 +1537,12 @@ static void handle_query_qemu_sstepbits(GArray *params, void *user_ctx)
 {
     g_string_printf(gdbserver_state.str_buf, "ENABLE=%x", SSTEP_ENABLE);
 
-    if (gdbserver_state.supported_sstep_flags & SSTEP_NOIRQ) {
+    if (gdbserver_state.accel_config.sstep_flags & SSTEP_NOIRQ) {
         g_string_append_printf(gdbserver_state.str_buf, ",NOIRQ=%x",
                                SSTEP_NOIRQ);
     }
 
-    if (gdbserver_state.supported_sstep_flags & SSTEP_NOTIMER) {
+    if (gdbserver_state.accel_config.sstep_flags & SSTEP_NOTIMER) {
         g_string_append_printf(gdbserver_state.str_buf, ",NOTIMER=%x",
                                SSTEP_NOTIMER);
     }
@@ -1560,7 +1560,7 @@ static void handle_set_qemu_sstep(GArray *params, void *user_ctx)
 
     new_sstep_flags = gdb_get_cmd_param(params, 0)->val_ul;
 
-    if (new_sstep_flags  & ~gdbserver_state.supported_sstep_flags) {
+    if (new_sstep_flags & ~gdbserver_state.accel_config.sstep_flags) {
         gdb_put_packet("E22");
         return;
     }
-- 
2.53.0


