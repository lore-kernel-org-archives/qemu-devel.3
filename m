Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03258E92FC4
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 18:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaIJ1-00055J-Dk; Mon, 29 Dec 2025 13:49:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vaII4-0003oL-An
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 13:48:28 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vaII0-0008J4-7i
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 13:48:23 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BT9TwBp3686954
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 18:48:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=iBQKhcie6Xc
 QkgkKwPbzsyYJiHSU8CdbCPTyhDneiPc=; b=O6fP6lnUp2fYVJHnB5smdi2za68
 XgDZN2XW7g27QetuNN2ia8Cf4S+g6iFzqJvb5Am/hT04P7f2Yx3s7y++lBXCSeQm
 b+iL4GcNHEdZmWRWAwplCDNP/8BcII+XxSFCZ2ahbNL8iRIUaByGIJKyCedtE7qI
 6So1qPXplRSJvvs3iPDvguG+pgKo9AAlD3nZTRSgPePLBJSjY8bckjRE2dntxpRv
 MJ0qyiw2aq6kw3qOI5kLC9YsfjCpelpUWnVGlUqrTnRZ3eLeTa1gQ1cJQhuWC0E4
 yZe5JM5TYwwHfL4ReFLWuCWKCpxhtRcIyJQ+RXraGuqbSNXC7xKt1lnZntA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba7hsd5tu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 18:48:03 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2a0c495fc7aso136180605ad.3
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 10:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767034082; x=1767638882; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iBQKhcie6XcQkgkKwPbzsyYJiHSU8CdbCPTyhDneiPc=;
 b=EvAOgaPwKbGqyRKIyELk8Bhb5damrKGRFIky5Wuk4Dv4CIqlR5ksRomZw4WJ7GY+Ic
 d3e9DiAJU6SZVjH6usATki+2FwF7HJW9eDz2IBENbqOs1VnAlWFWdJ+kMMXUB/UNeH1o
 lPqZJvzd4LIhUpAr1gQZrw+sjq5Hhp0ox02ONCjjTrPQOV+CQ+YsllzoAcGVwiPBh45g
 n9R4e2sxmB/X5o2UjCBtmsYcsjaDKvaE+rmnHikAg49GdssSeyZJ5w/b5ZDsaYKUfWWu
 Pa5uH5c0I+JljRz4z+2WkInwPi2MXzgqE16D9VGwy0rsKKz8YtgU7LfpWra/hhzw2sEY
 LK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767034082; x=1767638882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iBQKhcie6XcQkgkKwPbzsyYJiHSU8CdbCPTyhDneiPc=;
 b=IFcKTB1qX0JvJ7ETSZtuS3C9TfWZqNevC55ttdeiD/Z1g5aTqjRo0iuG6gMXzG4xFx
 Dvcu5XnPLkkp7YmH0u/7zCHPmgk6XGGN1AVIgU2Tbcu7xMcD6EExtxG/zsLPORSQM1Bo
 O4/StPDp5x0paSvMpIESzlqNnV6cqM8X0hs7YXEHWTRVgdX4HdmMrvwvHagbkj/D1GMD
 nHYN3lLYFt9bshDg6w1e9YnZtRN+XtEc9LQI5KKlhNWj9eeIFeotTb372JAXL8zJ23am
 2qvkHeg/wgtuew4ShGCxQc2jnmHMep10NBhKTPo65JUumfyK9WxLp4arPZcVXEcZcwfR
 Lqrg==
X-Gm-Message-State: AOJu0YyFxEeymlBe3YZyDWVTA4pZbcbmN4mQ5ykcZfylGrQmT4Yau1Fb
 jrAxLdyKFyOeTVZL6RyqDnsfDOKyw4OzzggDT4iNIs4LvE2j9W3/d2Hk5W82MCpXtixaK3GkWHw
 TVuJebI2+e5FEjivgTBPPdvpUGkEBLPZ8tvOIxbRW1GkqO/ZOpiaEMP7z/bFrC3anrA==
X-Gm-Gg: AY/fxX7o7Q6P1hCdq9XH8FpAqPFLB2D1KL4r/usGKL/qh0U/nRP7xgCCHTC9zhRq1dr
 swsNaaeuc7a0trA2FFzyBHi1h9YZSqVuDlUwrPTMZnETpMHNjmV5JVskuZLfjFGgPyt8lr0Pvem
 FLgNewrqus3Lrx9MQ3Q85UaYQbIvxTBhnea4E5/tQQVR7oGbAf+Gg/vLd1Jq7DSjzUYqK72b8Tb
 p99+NIzeSWU9pfYxy8kumP0+OA2bMfm4Y02yJrTXUGnwXIcB8y2tCs6RPS5u3p3HM17Pm4u0HRU
 +yEmVU01Oiq5FcIPJ6vRswCee1gsDO7kGLYN1D7HrHjjTEqwDUiKYgaqtt7SV4Yx3Mtu9c2aS6r
 2JzYXtPF7c2M3h30zAm91FTf6YUgyNLJmLPnQ+pG+ACKjSvE=
X-Received: by 2002:a17:903:41c6:b0:2a1:360c:3659 with SMTP id
 d9443c01a7336-2a2f2a3d1f4mr264340665ad.58.1767034082484; 
 Mon, 29 Dec 2025 10:48:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlLqj/xiI3/7508ZcOTRotsYxKvUNFXJJTdbO14H8F/vlMq3zw82izabfxwMoHnIec74AyVw==
X-Received: by 2002:a17:903:41c6:b0:2a1:360c:3659 with SMTP id
 d9443c01a7336-2a2f2a3d1f4mr264340475ad.58.1767034082000; 
 Mon, 29 Dec 2025 10:48:02 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.101.184.177])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c82aa8sm282198705ad.31.2025.12.29.10.47.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 10:48:01 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v3 17/17] hw/riscv/trace: update branch bit in sync messages
Date: Mon, 29 Dec 2025 15:46:56 -0300
Message-ID: <20251229184656.2224369-18-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251229184656.2224369-1-daniel.barboza@oss.qualcomm.com>
References: <20251229184656.2224369-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Xg8LaK6a8kk_ok5d4h_VwRCkXdsImcn_
X-Authority-Analysis: v=2.4 cv=O4o0fR9W c=1 sm=1 tr=0 ts=6952cce3 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=cW5wcbexNO3A0Ml9TiDm9w==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=l-bS85s7JyIff80a6EEA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: Xg8LaK6a8kk_ok5d4h_VwRCkXdsImcn_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDE3MiBTYWx0ZWRfX8Lh0kNegHd2o
 yNPala3S30rlB5koWGRwCfl28MgHnVNOR29dg32RYA42dNYUIiGE4L90HWNqeKkFuS+H4SzsIGv
 e6sQj5bZjYCH/mr2ry2t0qDRU0xqgh0m35xo2pxS7fNbQU90+FivyiYeTbJ68Mb3Ua0mpUE4GWs
 ApeMeUF6nqHot6oX/1UU3R8+sTRD1dRuXH6tT1FYWqtbF/D8ifkk6Hg1KKZxS3YjnZZaa/K7Vww
 sC4YRKPa6kn7m50l+MK91y3GrIV6uD0mVoff2OHfvJxVZWtNsjCA89ROLv4jEbk24lPui/HhnL+
 Eaw/UWOtM9y/PkOxz1YlbZzklYOd6C1QsC2VsVGjmaKdd7/ZuMIcUS3iIqtj+7r9EvVmkfjQmum
 n7rQofjfWLZTvpxfvc0h/A7KmhYhheK3XmPH1NbYU7ZLC4U6smruOYZ9MNJxvgqu0FoBPGaXKcR
 4yUR+Sk6NRE0XBOkuBA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_06,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512290172
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Now that we have a working branch map update the branch bit in sync
messages by checking if the sync address is a branch address that was
taken (or not).

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/rv-trace-messages.c |  6 +++---
 hw/riscv/rv-trace-messages.h |  3 ++-
 hw/riscv/trace-encoder.c     | 30 ++++++++++++++++++++++++++++--
 3 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/hw/riscv/rv-trace-messages.c b/hw/riscv/rv-trace-messages.c
index 7deaf25060..932f3ae499 100644
--- a/hw/riscv/rv-trace-messages.c
+++ b/hw/riscv/rv-trace-messages.c
@@ -126,11 +126,12 @@ static uint8_t rv_etrace_write_header(uint8_t *buf, RVTraceMessageHeader header)
 }
 
 size_t rv_etrace_gen_encoded_sync_msg(uint8_t *buf, uint64_t pc,
-                                      TracePrivLevel priv_level)
+                                      TracePrivLevel priv_level,
+                                      bool pc_is_branch)
 {
     RVTraceSyncPayload payload = {.format = 0b11,
                                   .subformat = 0b00,
-                                  .branch = 1,
+                                  .branch = pc_is_branch,
                                   .privilege = priv_level,
                                   .addressLow = extract64(pc, 0, 32),
                                   .addressHigh = extract64(pc, 32, 32)};
@@ -160,7 +161,6 @@ size_t rv_etrace_gen_encoded_trap_msg(uint8_t *buf, uint64_t trap_addr,
 {
     RVTraceTrapPayload payload = {.format = 0b11,
                                   .subformat = 0b01,
-                                  .branch = 1,
                                   .privilege = priv_level,
                                   .ecause = ecause,
                                   .addressLow = extract64(trap_addr, 0, 32),
diff --git a/hw/riscv/rv-trace-messages.h b/hw/riscv/rv-trace-messages.h
index f8f1830852..6f700eac8e 100644
--- a/hw/riscv/rv-trace-messages.h
+++ b/hw/riscv/rv-trace-messages.h
@@ -20,7 +20,8 @@ typedef enum {
 } TracePrivLevel;
 
 size_t rv_etrace_gen_encoded_sync_msg(uint8_t *buf, uint64_t pc,
-                                      TracePrivLevel priv_level);
+                                      TracePrivLevel priv_level,
+                                      bool pc_is_branch);
 size_t rv_etrace_gen_encoded_trap_msg(uint8_t *buf, uint64_t trap_addr,
                                       TracePrivLevel priv_level,
                                       uint8_t ecause,
diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
index c0f74887cf..55acb1f2ae 100644
--- a/hw/riscv/trace-encoder.c
+++ b/hw/riscv/trace-encoder.c
@@ -394,15 +394,38 @@ static void trencoder_send_message_smem(TraceEncoder *trencoder,
     trencoder_update_ramsink_writep(trencoder, dest, wrapped);
 }
 
+static bool trencoder_addr_is_branch_taken(TraceEncoder *te, uint64_t addr)
+{
+    uint8_t last_branch;
+
+    if (te->branches == 0) {
+        return false;
+    }
+
+    if (te->last_branch_pc == addr) {
+        last_branch = extract32(te->branches, te->branches - 1, 1);
+
+        /* 0: branch taken, 1: not taken*/
+        if (last_branch == 0) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
 static void trencoder_send_sync_msg(Object *trencoder_obj, uint64_t pc)
 {
     TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
     TracePrivLevel priv = trencoder_get_curr_priv_level(trencoder);
     g_autofree uint8_t *msg = g_malloc0(TRACE_MSG_MAX_SIZE);
     uint8_t msg_size;
+    bool is_branch_taken;
 
     trencoder->first_pc = pc;
-    msg_size = rv_etrace_gen_encoded_sync_msg(msg, pc, priv);
+    is_branch_taken = trencoder_addr_is_branch_taken(trencoder, pc);
+    msg_size = rv_etrace_gen_encoded_sync_msg(msg, pc, priv,
+                                              is_branch_taken);
 
     trencoder_send_message_smem(trencoder, msg, msg_size);
 }
@@ -440,6 +463,7 @@ void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t pc)
     TracePrivLevel priv = trencoder_get_curr_priv_level(trencoder);
     g_autofree uint8_t *msg = g_malloc0(TRACE_MSG_MAX_SIZE);
     uint8_t msg_size;
+    bool is_branch_taken;
 
     if (trencoder->updiscon_pending) {
         trencoder_send_updiscon(trencoder, pc);
@@ -447,7 +471,9 @@ void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t pc)
 
     trencoder->first_pc = pc;
     trace_trencoder_first_trace_insn(pc);
-    msg_size = rv_etrace_gen_encoded_sync_msg(msg, pc, priv);
+    is_branch_taken = trencoder_addr_is_branch_taken(trencoder, pc);
+    msg_size = rv_etrace_gen_encoded_sync_msg(msg, pc, priv,
+                                              is_branch_taken);
 
     trencoder_send_message_smem(trencoder, msg, msg_size);
 }
-- 
2.51.1


