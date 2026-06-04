Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D81ACD6E60
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 00:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUvcg-0001qw-2t; Wed, 03 Jun 2026 20:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1wUvce-0001pw-1V
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 20:07:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1wUvcb-0006YC-MC
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 20:07:43 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653I6h1V1993965
 for <qemu-devel@nongnu.org>; Thu, 4 Jun 2026 00:07:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=W3plxZB95bO
 YBv8PsvF1VYB1qsttARz/uMLqwisAwgo=; b=edlGC6+taAGpW1XqLXqWJ2mOrDO
 WrGQ6raD16SHqwnl8AP9ORcfWaQiwpSsLVd9GlJI5JfZetjoOKfmibhTHlFx5ITd
 EzdRfbXmbcV4BDoRNFKi1CySX3oDXpFlpaHIquigoJxOlrMIUWZYYV8IoaqFxOQ0
 mewFWnqnP15j6nl+beTlzq2vvyShm2JV05jgYtPTRtZok4H8Sw9tMXffuOqUNVAR
 9EqziFuo8ccseB71XRZzwzQS6X9zPhBEGFue45+1Z0gQuMS+yLaWpEdSxnC4ioH7
 y3r5+ZfWPQl3JILjQm3kU4LggoTYE9OLqsyQWm03R0VScUUA+ZuZWZ304/w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejs8ps5uw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 00:07:38 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-307625ee07fso283873eec.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 17:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780531658; x=1781136458; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W3plxZB95bOYBv8PsvF1VYB1qsttARz/uMLqwisAwgo=;
 b=BZVyObOnIiwYusIEX1VtLj0K1Wa0A5hD1zFngmHodhySZ4IYRDHWDsiXK16Qtz1fKz
 P+b3hhPA5SnM9jpqOQoxfC+5LdPkSPOdWbNgs6vc3tIypakqL6rkXV39OgVKeTVk3fzX
 65d5HDU7OPqdMS5bfw43x9+mqUN6epOXMT+7CksQ7er06NzYn8k4vckbbvvGZTNekrt6
 vde6IO0/NZWX7rpkaaZ3wZ6gi4yDTIp6K3PJzV9M6g4pMafrbGAsLu1Zlmqq2ZH9k+78
 8VWlxeX2chT+DGk0L+nIVSpTU2xGY3UPCr987LH1Uvs39i8R4iYw/ihkc4olh1f4t68Q
 AcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780531658; x=1781136458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W3plxZB95bOYBv8PsvF1VYB1qsttARz/uMLqwisAwgo=;
 b=Ky0UaDbUASw0E4hKipwkHbC/iFOPP0XOUMH0Bsl/IlAdipX/hgcr4PZ3iTZUPOumRl
 9HIKERPSWJQ0WA9LWBwbhNWNh53caN11rXrnxBGXz2zaKq3p1NQ6iIFnN7uMSqR5QMFA
 LYxZs6tEv6kQL3nIl4Hrzusc3ZUbbWNew4LsqD1lJ64jNHEXfphzvlWXP0eCEtQb/q8R
 WY+V+GMzhS73E6K31VWUiWjVRr9BLwWKgiQDUzlNe4tY7shkZ0I43pkb0dbQpu5icBHb
 7RXyJHG9lr4DTsQ9XheM0m18jFB3uh5G2wBiKJqHmqhIOqAUPiIU1I/zaNoZhtt7Y6mx
 L/Cw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8xyE0MYi6L6o0AdPEIy+ZCJzaEIS1ejdoHzev+XSymNYS4Sj27uV2Bve3GhwicVIDTdZ7weAmDvp2h@nongnu.org
X-Gm-Message-State: AOJu0YxMTr+lmMeYcPFK7PKB2f7wP5bpewqcfQFEqCC+S2zDttl7k/rO
 5VyQd9c5Si0XYs/pQALJ8X7Q0t3hzOJuASUbJhVCqgTRo9gfo0p680PNW2uoqZ9bNE55+TAbJRJ
 yQKDnTFk8QLQJO3k2fDjIFElkhlCVxDLkIXHEef1EsZUypfo/3OneIqymEg==
X-Gm-Gg: Acq92OH2+/GFzDU9fxROKBNf6HdpmCEdukZpf2IX64jlXzv0olAvrIGTiUmtu7PaYSr
 joJOCnITifjy2F5KLmX+ZwP1zn4BBx6Vck1J/kiQR2UjFM76TORbh9wSgdSumicDOZ04d7JYdQd
 Cd65yEsdF6i7PXww38cPF6CDtfptuwpJJEcpbZze7hzGUj8eNyCPR7o8VWyzlyUvDrZauEwGdeC
 zjLvFwSwsu7HmKdTjc18W948vOPF8ga0SgAEkX2+D/xXSiYBABcvjzAoHrFUy1/jgbCFjDPiRbU
 W7pdzOU9SUrWJXUKr4XgshdHynUJcGQOY4PWNjs2ouP7/pkZmm4i9g2xYdMpyqb8s4b+dibRS98
 WyKovHbFtua3Yqn5GPJneL0okxHmWtzFxe+rjHkrsp49k4G4K89KvbxHbqva90ulYsH54nLBQJX
 BAxPyDBXA5+lo=
X-Received: by 2002:a05:7301:22a8:b0:304:641b:12fd with SMTP id
 5a478bee46e88-3074fbcadfamr2997490eec.27.1780531657726; 
 Wed, 03 Jun 2026 17:07:37 -0700 (PDT)
X-Received: by 2002:a05:7301:22a8:b0:304:641b:12fd with SMTP id
 5a478bee46e88-3074fbcadfamr2997472eec.27.1780531657241; 
 Wed, 03 Jun 2026 17:07:37 -0700 (PDT)
Received: from hu-jithjose-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074dfa3a2asm5374960eec.31.2026.06.03.17.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 17:07:36 -0700 (PDT)
From: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
To: clg@kaod.org, jamin_lin@aspeedtech.com, komlodi@google.com
Cc: nabihestefan@google.com, philmd@linaro.org, jithu.joseph@oss.qualcomm.com, 
 qemu-devel@nongnu.org
Subject: [PATCH v2 1/3] hw/i3c: fix CMD/data FIFO depth reset values to match
 real silicon
Date: Wed,  3 Jun 2026 17:07:32 -0700
Message-ID: <20260604000734.1094382-2-jithu.joseph@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604000734.1094382-1-jithu.joseph@oss.qualcomm.com>
References: <20260529014034.864722-1-jithu.joseph@oss.qualcomm.com>
 <20260604000734.1094382-1-jithu.joseph@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: KsCIobLB-gWmNxwkCE5wwd8oPg5OP5rh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIzNSBTYWx0ZWRfX9bxQpw9GhG0N
 N4qjqproVfitetWFcQFemnjZwU8O1mpSaUfKy9SV6OjSHx89PxibS5EfTonCtYkDMZsPF5JSDgg
 7u6FJ6wV9MTePyKLpc5OXQcI7rzWD77w9CQ9PYY7DUviCg0k+rBAE9vn/FHilI/bUp+1ulpRBfl
 A3vjfGxrV8Dm5eqOqIzEAO2r6syXXUlX0p4VRef2h+sKFIB0IF0R7uKZHLJWJSko2sFYK917dhk
 CD7PL/Mph1soWEnzpSWRHdQ4LnDDnlvihYHuf2RzZd6Gz9Krw7GRKKzRuJ6NfjL58E3gVsCUXEa
 X7EdHxBRO2Nb+qF6074Io5YNrO+YYSK/4eTRFS/dFj76YX85mBOm+Z8VtGgu8kyij/rz+Rh3xbu
 T+vReLsHSpB0z5HfUYMY5jXY7nOZxAxic+CnqT8MvTm+qe7xJTWzsrGIpB5or2MuEL/cf6URDvj
 ZoAwb98yoPC79SpF5FA==
X-Authority-Analysis: v=2.4 cv=E779Y6dl c=1 sm=1 tr=0 ts=6a20c1ca cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=69wJf7TsAAAA:8
 a=EUspDBNiAAAA:8 a=1Cgkl99JUvOo6gf9qOkA:9 a=PxkB5W3o20Ba91AHUih5:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: KsCIobLB-gWmNxwkCE5wwd8oPg5OP5rh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030235
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=jithu.joseph@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

The Linux DW-I3C master driver infers controller queue depths at probe
by reading two status registers that report free queue slots, which at
probe (queues empty) equals the full depth.  It then uses those values
to gate every I3C transfer -- any batch whose word count exceeds the
advertised depth is rejected with -EOPNOTSUPP.

  QUEUE_STATUS_LEVEL        (0x4c) [7:0] -> cmdfifodepth  (cmd slots)
  DATA_BUFFER_STATUS_LEVEL  (0x50) [7:0] -> datafifodepth (32-bit words)

Per the AST2600 datasheet the reset values are 0x10 and 0x40 (16 cmd
slots, 64 words = 256 B).  QEMU was advertising 0x02 and 0x10, making
the kernel believe the controller can only do 64-byte transfers.  The
visible symptom was -EOPNOTSUPP on any I3C transfer whose payload
exceeded 64 B (datafifodepth = 0x10 = 16 words = 64 B).

The underlying FIFOs in QEMU were already allocated at the right size
(fifo32_create takes word counts; the existing defaults give 16 cmd
slots and 64 data words).  Only the advertised reset values were wrong.

Correct the reset values in dw_i3c_resets[], and additionally drive the
advertised depths from the queue-capacity configs in the reset handlers
(as is already done for the device/char table pointers), so a configured
override is reflected in what the guest reads instead of being silently
ignored.  The advertised fields are 8-bit, so the depth saturates at 255
regardless of the wider capacity configs.

With this fix the guest sees datafifodepth=64 words and accepts
transfers up to 256 B.

Fixes: e974c6957576 ("hw/i3c/dw-i3c: Add more reset values")
Cc: qemu-stable@nongnu.org
Signed-off-by: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
---
 hw/i3c/dw-i3c.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
index 17ff484c5df1..06c2d55f5958 100644
--- a/hw/i3c/dw-i3c.c
+++ b/hw/i3c/dw-i3c.c
@@ -282,8 +282,8 @@ static const uint32_t dw_i3c_resets[DW_I3C_NR_REGS] = {
     [R_QUEUE_THLD_CTRL]             = 0x01000101,
     [R_DATA_BUFFER_THLD_CTRL]       = 0x01010100,
     [R_SLV_EVENT_CTRL]              = 0x0000000b,
-    [R_QUEUE_STATUS_LEVEL]          = 0x00000002,
-    [R_DATA_BUFFER_STATUS_LEVEL]    = 0x00000010,
+    [R_QUEUE_STATUS_LEVEL]          = 0x00000010,
+    [R_DATA_BUFFER_STATUS_LEVEL]    = 0x00000040,
     [R_PRESENT_STATE]               = 0x00000003,
     [R_I3C_VER_ID]                  = 0x3130302a,
     [R_I3C_VER_TYPE]                = 0x6c633033,
@@ -947,6 +947,10 @@ static void dw_i3c_reset(DeviceState *dev)
                      s->cfg.dev_char_table_pointer);
     ARRAY_FIELD_DP32(s->regs, DEV_CHAR_TABLE_POINTER, DEV_CHAR_TABLE_DEPTH,
                      s->cfg.dev_char_table_depth);
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, CMD_QUEUE_EMPTY_LOC,
+                     s->cfg.cmd_resp_queue_capacity_bytes);
+    ARRAY_FIELD_DP32(s->regs, DATA_BUFFER_STATUS_LEVEL, TX_BUF_EMPTY_LOC,
+                     s->cfg.tx_rx_queue_capacity_bytes);
 
     dw_i3c_cmd_queue_reset(s);
     dw_i3c_resp_queue_reset(s);
@@ -1793,6 +1797,10 @@ static void dw_i3c_reset_enter(Object *obj, ResetType type)
                      s->cfg.dev_char_table_pointer);
     ARRAY_FIELD_DP32(s->regs, DEV_CHAR_TABLE_POINTER, DEV_CHAR_TABLE_DEPTH,
                      s->cfg.dev_char_table_depth);
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, CMD_QUEUE_EMPTY_LOC,
+                     s->cfg.cmd_resp_queue_capacity_bytes);
+    ARRAY_FIELD_DP32(s->regs, DATA_BUFFER_STATUS_LEVEL, TX_BUF_EMPTY_LOC,
+                     s->cfg.tx_rx_queue_capacity_bytes);
 }
 
 static void dw_i3c_realize(DeviceState *dev, Error **errp)
-- 
2.43.0


