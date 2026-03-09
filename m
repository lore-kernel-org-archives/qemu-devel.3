Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2369F417EF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbv0-0001DT-Gg; Mon, 09 Mar 2026 10:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbuV-0000qc-6A
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:48:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbuT-0005Ep-9u
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:48:42 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629A6dMf2195107
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2026 14:48:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GTtFMiaJ0mspfQ/TE8zJxQINMRb4QLRMr882PiJr9Sk=; b=HRKwXub+N3ca9Sg5
 qDjlI8DHwkQHD0tz7cuxgRgh7cicZBNx0NQQcx+VaXa4V2yMJRzhfdRyHL4+/E4I
 J/q9Y8Ato1bNk3mZpyWa3N99Olq7dMs777rF6WiDRxHWsXyC+P8FhULe1MzLRp0D
 iWsWO54sXQsr3cmQmzs3jZFbPmQuA9heMc0lMQhMh2jHu8oi+MYoagibYSF9WYIm
 Av8m6JR+lH9YDsqLOYSlzOGlwifaetIFP77vP/NaQYhO4QD9/2v3oirRN0bAlJTk
 LjLu9QyZds+HD7wVc42nwtQhDKRtuHVe2hAlk92R0lwkMaVCsWWLFD0dwGzZbxEe
 RF5OMA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csv5u8vk2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:48:39 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2bdf75bc88fso9277480eec.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773067718; x=1773672518; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GTtFMiaJ0mspfQ/TE8zJxQINMRb4QLRMr882PiJr9Sk=;
 b=biF/1Qi8w0cbK4saXjPQ44xM3OGAThe1IqYRun6FvB6s9xy2dixmaGVnr2D/wnDFgn
 6idIi5IuxNODW3Tpo4ugyYdlxpmnbAI0Be6aTrQzUrIQvfWDHF25tMW07o1mrYC5OpNr
 qhwo0GkyYsnh40jRMcAdX/NDkKhsRDGbMjFARt6xuZrw1BrOLSH5doSXmTDMsz6vLDCJ
 j3xxLxHs2BEXSveXD2zgVd8q1HRCfqi/KGegS5jOUg5U0+ulOKvELzIEImiUiEiXjq/K
 Xd7jRlc5lwcG27SdP7k/Jew1eoqaE+jHRfF31ATifitG7tLZl1F2YXr662JaJeFVOgZR
 Q4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067718; x=1773672518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GTtFMiaJ0mspfQ/TE8zJxQINMRb4QLRMr882PiJr9Sk=;
 b=p68AREskJj2XPKk6Mmd9UKXIVUbAvp7pL408OYXJCwkcB2oF4RGmhAEd7oqtEfDdIN
 1OKWUDxK1fnG2n2+OzkDtmhbqpl4wYusNTgvjZD1nMH5a1Vp8nDc8oyibSS/sIPApi28
 QnGbgmPTRRnrDP7RGWRJAI8MBFl6fQlZ4buu6IYH4hJ68WK2WWscIJD0T/zTpr2Rh2mC
 S9vyNv0f4xYGFGEG8lgGhtDOYvEvWXLxFx8F/7n/E3/d6mx0+3IWL0PaiOMeOdygHLO4
 zhAnuNwi9AS/ShfkAot1sKiWkS6r1tlG0Jr1t6BWD1kfSeOoAT3C9VTWnuGPkzNc6CEg
 A+hg==
X-Gm-Message-State: AOJu0Yw8oTDX7NNZfbwcidQ97B3OK7REpl9EBLtrxPS4tO9+fOHvug02
 DlauiB0/JB0wqiXbToe4gQqkRL3EPu5es9xhfVsnyw2Z+23p+Ai2ZxAN+TZJtDc2bjt1MLot3qP
 GsOPP0+Z3iYOmOSDFHeWvGeOz4gAzZCBWdBzZCN6Yjtq/g/73KB4tv/G/FfLxPOUYkQ==
X-Gm-Gg: ATEYQzwowAL8lj5JtXKy/iY6I71hnn1UQr+AdAAXbkFXHGkpd6eS6w+KN0tZE4mr4Ef
 Rt0D2flqLw8wEFaZ8npTIsw/bBiikU12vtliJeJDKNnI9Mtu8GXlIHsQdGpB+f4u6O1ZCzknggW
 dD/qNAnj3YW83K6Yf9n8qtMcaAvs2iHDrmyGM1lnGuJCdsHDt5VUv23vFW87K+Wqtb3cgOQNlD/
 R5rWiFat20K0flSCcl8iNQVyBdIfHi9WBWSsK9xUTrVwcQQ83EPoV8pO4Cv2pd2bfyAunO5ZjgY
 CO7BJB2QiCYTpE9SNw7GdbY/utjt9PXY/qfEcQ2f8OsvyrPaWMe4qz1yck9fr5ewJ4zeT3ru/zW
 8UL3TSwJZupIusP47N3zLxsFbAc/P/9W4fIpF+DSwIszG/YqDe9o0zlkWKt2waDPKdDLj4A==
X-Received: by 2002:a05:7300:6da4:b0:2ba:a60a:15e6 with SMTP id
 5a478bee46e88-2be4dfca833mr4004145eec.16.1773067717661; 
 Mon, 09 Mar 2026 07:48:37 -0700 (PDT)
X-Received: by 2002:a05:7300:6da4:b0:2ba:a60a:15e6 with SMTP id
 5a478bee46e88-2be4dfca833mr4004117eec.16.1773067716856; 
 Mon, 09 Mar 2026 07:48:36 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f82b78esm9322776eec.12.2026.03.09.07.48.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 07:48:36 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Subject: [PATCH v4 09/35] target/hexagon: Add privilege check, use tag_ignore()
Date: Mon,  9 Mar 2026 07:47:56 -0700
Message-Id: <20260309144822.877695-10-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
References: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: OQNtschaYYn1PL7dOMD2KzrCcs63sws2
X-Proofpoint-ORIG-GUID: OQNtschaYYn1PL7dOMD2KzrCcs63sws2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzMyBTYWx0ZWRfX/x8HsPa+8mjf
 KYfIwf1Yo8B4wlVx/okKv8Zvd2Qt7LNQWZD6wy9dxoaD+S0nZ5IPF5DHYFnAHr4Ah4HqW+i1KVA
 OIILEVDOvujTR1Xhh1qCgKmCiM2rVtuigjA2j4LewnAiabkroOgiWmdSrheKgB5NQ3JkeoUO0q0
 WRewX/dJp0SrlvUSaSrajgxsOHUkRu6fNeXXiyKz+NBTC4t5Wu2UyGmsh9kF0ezRGUYtXiXwLMz
 IZxbNfeEZ7/QsnPp9wlRH9BGY2EHZ1IW0p0cg3YEKohJL52aK2bW89NUCVnaveHNY5z004D82HQ
 LMdn4mP74xMpLmMR1wfoOVie1k92DAdsRFEqgM+uh0Mzvef/I9HGEuHJsot5BymQE+6pydjQ2e2
 ebEf+dCfSO6X8BqvP/fARbzbRR3phdVEUhyJ6do9P+mEBToB0II/1KQd1tQLdxY3cUUTLG2AGb0
 eG0KRnUciLLWRYVrV2Q==
X-Authority-Analysis: v=2.4 cv=Xr/3+FF9 c=1 sm=1 tr=0 ts=69aeddc7 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=pksD3ONYjMjZD1LmeuAA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090133
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add system event and cause code definitions needed for exception
handling in sysemu mode.  Add privilege checks that raise exceptions
for guest/supervisor-only instructions executed without appropriate
privilege.

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/cpu.h            | 10 +++++
 target/hexagon/cpu_bits.h       | 75 +++++++++++++++++++++++++++++----
 linux-user/hexagon/cpu_loop.c   | 16 +++++++
 target/hexagon/cpu.c            |  1 +
 target/hexagon/translate.c      |  8 ++++
 target/hexagon/gen_tcg_funcs.py | 35 +++++++++------
 6 files changed, 123 insertions(+), 22 deletions(-)

diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 85afd592778..937194e460e 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -44,6 +44,15 @@
 
 #define MMU_USER_IDX 0
 
+#define HEXAGON_CPU_IRQ_0 0
+#define HEXAGON_CPU_IRQ_1 1
+#define HEXAGON_CPU_IRQ_2 2
+#define HEXAGON_CPU_IRQ_3 3
+#define HEXAGON_CPU_IRQ_4 4
+#define HEXAGON_CPU_IRQ_5 5
+#define HEXAGON_CPU_IRQ_6 6
+#define HEXAGON_CPU_IRQ_7 7
+
 typedef struct {
     target_ulong va;
     uint32_t width;
@@ -76,6 +85,7 @@ typedef struct {
 typedef struct CPUArchState {
     target_ulong gpr[TOTAL_PER_THREAD_REGS];
     target_ulong pred[NUM_PREGS];
+    uint32_t cause_code;
 
     /* For comparing with LLDB on target - see adjust_stack_ptrs function */
     target_ulong last_pc_dumped;
diff --git a/target/hexagon/cpu_bits.h b/target/hexagon/cpu_bits.h
index 19beca81c0c..91e9da09e03 100644
--- a/target/hexagon/cpu_bits.h
+++ b/target/hexagon/cpu_bits.h
@@ -24,20 +24,77 @@
 #define PCALIGN_MASK (PCALIGN - 1)
 
 enum hex_event {
-    HEX_EVENT_NONE           = -1,
-    HEX_EVENT_TRAP0          =  0x008,
+    HEX_EVENT_NONE = -1,
+    HEX_EVENT_RESET = 0x0,
+    HEX_EVENT_IMPRECISE = 0x1,
+    HEX_EVENT_PRECISE = 0x2,
+    HEX_EVENT_TLB_MISS_X = 0x4,
+    HEX_EVENT_TLB_MISS_RW = 0x6,
+    HEX_EVENT_TRAP0 = 0x8,
+    HEX_EVENT_TRAP1 = 0x9,
+    HEX_EVENT_FPTRAP = 0xb,
+    HEX_EVENT_DEBUG = 0xc,
+    HEX_EVENT_INT0 = 0x10,
+    HEX_EVENT_INT1 = 0x11,
+    HEX_EVENT_INT2 = 0x12,
+    HEX_EVENT_INT3 = 0x13,
+    HEX_EVENT_INT4 = 0x14,
+    HEX_EVENT_INT5 = 0x15,
+    HEX_EVENT_INT6 = 0x16,
+    HEX_EVENT_INT7 = 0x17,
+    HEX_EVENT_INT8 = 0x18,
+    HEX_EVENT_INT9 = 0x19,
+    HEX_EVENT_INTA = 0x1a,
+    HEX_EVENT_INTB = 0x1b,
+    HEX_EVENT_INTC = 0x1c,
+    HEX_EVENT_INTD = 0x1d,
+    HEX_EVENT_INTE = 0x1e,
+    HEX_EVENT_INTF = 0x1f,
 };
 
 enum hex_cause {
     HEX_CAUSE_NONE = -1,
-    HEX_CAUSE_TRAP0 = 0x172,
-    HEX_CAUSE_FETCH_NO_UPAGE =  0x012,
-    HEX_CAUSE_INVALID_PACKET =  0x015,
-    HEX_CAUSE_INVALID_OPCODE =  0x015,
+    HEX_CAUSE_RESET = 0x000,
+    HEX_CAUSE_BIU_PRECISE = 0x001,
+    HEX_CAUSE_UNSUPPORTED_HVX_64B = 0x002, /* QEMU-specific */
+    HEX_CAUSE_DOUBLE_EXCEPT = 0x003,
+    HEX_CAUSE_TRAP0 = 0x008,
+    HEX_CAUSE_TRAP1 = 0x009,
+    HEX_CAUSE_FETCH_NO_XPAGE = 0x011,
+    HEX_CAUSE_FETCH_NO_UPAGE = 0x012,
+    HEX_CAUSE_INVALID_PACKET = 0x015,
+    HEX_CAUSE_INVALID_OPCODE = 0x015, /* alias: same cause as INVALID_PACKET */
+    HEX_CAUSE_NO_COPROC_ENABLE = 0x016,
+    HEX_CAUSE_NO_COPROC2_ENABLE = 0x018,
+    HEX_CAUSE_PRIV_USER_NO_GINSN = 0x01a,
+    HEX_CAUSE_PRIV_USER_NO_SINSN = 0x01b,
     HEX_CAUSE_REG_WRITE_CONFLICT = 0x01d,
-    HEX_CAUSE_PC_NOT_ALIGNED =  0x01e,
-    HEX_CAUSE_PRIV_NO_UREAD  =  0x024,
-    HEX_CAUSE_PRIV_NO_UWRITE =  0x025,
+    HEX_CAUSE_PC_NOT_ALIGNED = 0x01e,
+    HEX_CAUSE_MISALIGNED_LOAD = 0x020,
+    HEX_CAUSE_MISALIGNED_STORE = 0x021,
+    HEX_CAUSE_PRIV_NO_READ = 0x022,
+    HEX_CAUSE_PRIV_NO_WRITE = 0x023,
+    HEX_CAUSE_PRIV_NO_UREAD = 0x024,
+    HEX_CAUSE_PRIV_NO_UWRITE = 0x025,
+    HEX_CAUSE_COPROC_LDST = 0x026,
+    HEX_CAUSE_STACK_LIMIT = 0x027,
+    HEX_CAUSE_VWCTRL_WINDOW_MISS = 0x029,
+    HEX_CAUSE_IMPRECISE_NMI = 0x043,
+    HEX_CAUSE_IMPRECISE_MULTI_TLB_MATCH = 0x044,
+    HEX_CAUSE_TLBMISSX_CAUSE_NORMAL = 0x060,
+    HEX_CAUSE_TLBMISSX_CAUSE_NEXTPAGE = 0x061,
+    HEX_CAUSE_TLBMISSRW_CAUSE_READ = 0x070,
+    HEX_CAUSE_TLBMISSRW_CAUSE_WRITE = 0x071,
+    HEX_CAUSE_DEBUG_SINGLESTEP = 0x80,
+    HEX_CAUSE_FPTRAP_CAUSE_BADFLOAT = 0x0bf,
+    HEX_CAUSE_INT0 = 0x0c0,
+    HEX_CAUSE_INT1 = 0x0c1,
+    HEX_CAUSE_INT2 = 0x0c2,
+    HEX_CAUSE_INT3 = 0x0c3,
+    HEX_CAUSE_INT4 = 0x0c4,
+    HEX_CAUSE_INT5 = 0x0c5,
+    HEX_CAUSE_INT6 = 0x0c6,
+    HEX_CAUSE_INT7 = 0x0c7,
 };
 
 #define PACKET_WORDS_MAX         4
diff --git a/linux-user/hexagon/cpu_loop.c b/linux-user/hexagon/cpu_loop.c
index 5711055aff2..b63990663ab 100644
--- a/linux-user/hexagon/cpu_loop.c
+++ b/linux-user/hexagon/cpu_loop.c
@@ -22,6 +22,7 @@
 #include "qemu.h"
 #include "user-internals.h"
 #include "user/cpu_loop.h"
+#include "target/hexagon/internal.h"
 #include "signal-common.h"
 #include "internal.h"
 
@@ -60,6 +61,21 @@ void cpu_loop(CPUHexagonState *env)
                 env->gpr[0] = ret;
             }
             break;
+        case HEX_EVENT_PRECISE:
+            switch (env->cause_code) {
+            case HEX_CAUSE_PRIV_USER_NO_GINSN:
+            case HEX_CAUSE_PRIV_USER_NO_SINSN:
+            case HEX_CAUSE_INVALID_PACKET:
+            force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPC,
+                    env->gpr[HEX_REG_PC]);
+            break;
+            default:
+                EXCP_DUMP(env, "\nqemu: unhandled CPU precise exception "
+                    "cause code 0x%x - aborting\n",
+                    env->cause_code);
+                exit(EXIT_FAILURE);
+            }
+            break;
         case HEX_CAUSE_PC_NOT_ALIGNED:
             force_sig_fault(TARGET_SIGBUS, TARGET_BUS_ADRALN,
                             env->gpr[HEX_REG_R31]);
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index e61ac10fbf3..1f172404608 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -306,6 +306,7 @@ static void hexagon_cpu_reset_hold(Object *obj, ResetType type)
     set_float_detect_tininess(float_tininess_before_rounding, &env->fp_status);
     /* Default NaN value: sign bit set, all frac bits set */
     set_float_default_nan_pattern(0b11111111, &env->fp_status);
+    env->cause_code = HEX_EVENT_NONE;
 }
 
 static void hexagon_cpu_disas_set_info(const CPUState *cs,
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 18b38c285ed..571ba9cae41 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -65,6 +65,10 @@ TCGv hex_vstore_addr[VSTORES_MAX];
 TCGv hex_vstore_size[VSTORES_MAX];
 TCGv hex_vstore_pending[VSTORES_MAX];
 
+#ifndef CONFIG_USER_ONLY
+TCGv_i32 hex_cause_code;
+#endif
+
 static const char * const hexagon_prednames[] = {
   "p0", "p1", "p2", "p3"
 };
@@ -1153,4 +1157,8 @@ void hexagon_translate_init(void)
             offsetof(CPUHexagonState, vstore_pending[i]),
             vstore_pending_names[i]);
     }
+#ifndef CONFIG_USER_ONLY
+    hex_cause_code = tcg_global_mem_new(tcg_env,
+        offsetof(CPUHexagonState, cause_code), "cause_code");
+#endif
 }
diff --git a/target/hexagon/gen_tcg_funcs.py b/target/hexagon/gen_tcg_funcs.py
index 87b7f10d7fd..d91bbcf1dc8 100755
--- a/target/hexagon/gen_tcg_funcs.py
+++ b/target/hexagon/gen_tcg_funcs.py
@@ -21,7 +21,7 @@
 import re
 import string
 import hex_common
-
+from textwrap import dedent
 
 ##
 ## Generate the TCG code to call the helper
@@ -49,6 +49,18 @@ def gen_tcg_func(f, tag, regs, imms):
 
     f.write("    Insn *insn G_GNUC_UNUSED = ctx->insn;\n")
 
+    if "A_PRIV" in hex_common.attribdict[tag]:
+        f.write(dedent("""\
+#ifdef CONFIG_USER_ONLY
+    hex_gen_exception_end_tb(ctx, HEX_CAUSE_PRIV_USER_NO_SINSN);
+#else
+"""))
+    if "A_GUEST" in hex_common.attribdict[tag]:
+        f.write(dedent("""\
+#ifdef CONFIG_USER_ONLY
+    hex_gen_exception_end_tb(ctx, HEX_CAUSE_PRIV_USER_NO_GINSN);
+#else
+"""))
     if hex_common.need_ea(tag):
         f.write("    TCGv EA G_GNUC_UNUSED = tcg_temp_new();\n")
 
@@ -100,6 +112,11 @@ def gen_tcg_func(f, tag, regs, imms):
         if reg.is_written():
             reg.gen_write(f, tag)
 
+    if (
+        "A_PRIV" in hex_common.attribdict[tag]
+        or "A_GUEST" in hex_common.attribdict[tag]
+    ):
+        f.write("#endif   /* CONFIG_USER_ONLY */\n")
     f.write("}\n\n")
 
 
@@ -124,18 +141,10 @@ def main():
             f.write('#include "idef-generated-emitter.h.inc"\n\n')
 
         for tag in hex_common.tags:
-            ## Skip the priv instructions
-            if "A_PRIV" in hex_common.attribdict[tag]:
-                continue
-            ## Skip the guest instructions
-            if "A_GUEST" in hex_common.attribdict[tag]:
-                continue
-            ## Skip the diag instructions
-            if tag == "Y6_diag":
-                continue
-            if tag == "Y6_diag0":
-                continue
-            if tag == "Y6_diag1":
+            if hex_common.tag_ignore(tag):
+                f.write(f"static void generate_{tag}"
+                        f"(DisasContext *ctx)\n")
+                f.write("{\n}\n\n")
                 continue
 
             gen_def_tcg_func(f, tag, tagregs, tagimms)
-- 
2.34.1


