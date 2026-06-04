Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23C6CD6E6D
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 14:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV8xk-00074g-2A; Thu, 04 Jun 2026 10:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1wV8xd-00073x-VO
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 10:22:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1wV8xa-0005RE-Rw
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 10:22:17 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654CCVga3221049
 for <qemu-devel@nongnu.org>; Thu, 4 Jun 2026 14:22:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=DGuKlp2kNQG
 hHzR0xLe/9sYZgagy6Ek1xTF0685bdgg=; b=Rkl4jrNEZCloRsIDcyvCx1IFgiL
 mftUmNpwVyXMr9pUaAlhwBYdLiVih6stqldvn2A8XBONpUKJ8yBQDIAIrzpAFka8
 tjfbcymoaJrQ+Gr7flcR76BbQyNUE/HmfgkS9bOpGHNAjkUuPN3eg3Abc4i4cWuM
 Cpjb20TMGSMM9gnPOcPD8EM2JeyhEVTfHop/wrbclAF1xO5HI7Ju4FeH7UJ/UjZm
 fk6JrYHmEzGD+MR2OidFqiEBmuvDLF3OCpbQWSYOlv1Oc0oV+/3f3VshWbtkhCzL
 CJhjd/wZJq7g9K/vy5pAu7iCqcfz3BMCsyQLvs1cNL0hVW+QFGaC/zma6/g==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek95u8k17-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 14:22:12 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304d8613efbso701108eec.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 07:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780582932; x=1781187732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DGuKlp2kNQGhHzR0xLe/9sYZgagy6Ek1xTF0685bdgg=;
 b=JubwT07lLhxz1hjfhpUGgDWfiCwMADPjr5Aq53C5lqILtHsf8n/BN0vX8ltYtATuk9
 UpOv2lRrkCmtwf8/o31YJVpuBKJketJs7MNAzOOkIg3WHjF7VbWqA9/jbSwWM1fAQwdW
 3A+P+ys7AjXcQrecLof5zk6nkp5gqB1nTrMAaQjTm6j2j7AYhmLyvPk9p2KHuvZuhEVF
 Tc5yhVGuuv6IHjPp7JjQf2WHvtUpbLeovzLlPM4EIdt0ycxB76zZ2HObMHFHkqSkREwe
 tZHNWITsdehDHPHBDgUSJAO5HSbV/ATYTExAMoACiWNY6JW0uzpwBQbhMvQPT7lKg3uu
 8a7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780582932; x=1781187732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DGuKlp2kNQGhHzR0xLe/9sYZgagy6Ek1xTF0685bdgg=;
 b=capsp4Kq0prcARz5Eyc7F4at9nDyA5rtglZvUdM9uW05FnjDStxr0+ZjfKWqxhGgiN
 K70Eo3sqbpZN5HgCSfXLIffqUFdkbItftijal5Pnod04TQfvo0YynxwAgVY2tBMqLKQB
 vpOODN+tl0XOcRlhC74DFLOKnYMm58stkx9EUBv3VcpNwifNEaGQji/aXr+X/yJHUhKO
 ss/JiPJU7oAXPDvy3ZTGjlmXyAqddqMFbNr4IkYV4M7fFPqgNF1wGLz6lBH4nfzP8TXu
 nEDxAHMDU3Gnl08BzjciaxpYUTUBfhdkdo5YQrfJyXFQLGz/9pOrUPxYm9FO0xauMxT5
 vmxg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+TS42z7lc32OYP0FN0PeQXx8HrmO0GvwksWNJTYEYbovbmZBZhlwh/jLWHjR4+bqXPeKG1SlGOhrS5@nongnu.org
X-Gm-Message-State: AOJu0Yxthvd1xJIZp+OifpVmMdEx8w4NCeGtRYSLknOE7VpLTqPtDOkn
 lC3YYhjOS12o60W7+T/zTv4GzXfMFOCfsCBqKElo9pbT8Zc30y1++n+oN4JOrjo8H3WxHWSaw5Q
 Q/C3YV+yO1VMq4CiNyqNbu0jFieSy0oTUirMNrTavFMRduud95OhaqxZRcA==
X-Gm-Gg: Acq92OGLK03zhTcbIsX1ObCPhOjo/sGtFcJ3sErzB5gSIaYoBV3+ukDwfR4x5mCpF6I
 /3B9xx9nJkfl5WZtPxrp1kyS/Swh02CUrg3vN24ac909VF+VcjYTbdgv8IZHrSyFbq2NX5AODtI
 7/upJX4vFgTW04mMMiPOQJRw7GegibLxW9A/Be4RLJQsuiuCdea7MzcakiGtCVmINr7tAK7Gjt3
 GcYnYEsjHWkUyVdNVdwZ3Gt/5uYHWaznGZVpawAaS//ZTFz+jCBmQo/jWtc8dA2MLAIKqeQNZ3E
 EZqdEDRc3LbQmszt4Pw/WhNx4Csxkge4il7C5t/JNyYCbaGKvsA+5h1DkkCqQgbmJTysyiZJE0h
 t9AjcmHUB63fVR8f6XKCItgsFWU90j49Q8xPzf1IvTPwyJoJPcRjADwV/W0DkCpnGB0nofg1nk2
 7Zzyet0NtJwF0=
X-Received: by 2002:a05:7300:320c:b0:2ed:e14:e956 with SMTP id
 5a478bee46e88-3074fc018e6mr4841743eec.32.1780582931891; 
 Thu, 04 Jun 2026 07:22:11 -0700 (PDT)
X-Received: by 2002:a05:7300:320c:b0:2ed:e14:e956 with SMTP id
 5a478bee46e88-3074fc018e6mr4841720eec.32.1780582931160; 
 Thu, 04 Jun 2026 07:22:11 -0700 (PDT)
Received: from hu-jithjose-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db528dcsm6179560eec.3.2026.06.04.07.22.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 07:22:10 -0700 (PDT)
From: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
To: clg@kaod.org, jamin_lin@aspeedtech.com, komlodi@google.com
Cc: nabihestefan@google.com, philmd@mailo.com, jithu.joseph@oss.qualcomm.com, 
 qemu-devel@nongnu.org
Subject: [PATCH v3 1/3] hw/i3c: fix CMD/data FIFO depth reset values to match
 real silicon
Date: Thu,  4 Jun 2026 07:22:04 -0700
Message-ID: <20260604142207.2118098-2-jithu.joseph@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604142207.2118098-1-jithu.joseph@oss.qualcomm.com>
References: <20260604142207.2118098-1-jithu.joseph@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=at2CzyZV c=1 sm=1 tr=0 ts=6a218a14 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=69wJf7TsAAAA:8
 a=EUspDBNiAAAA:8 a=V2NxCb60AAAA:8 a=1Cgkl99JUvOo6gf9qOkA:9
 a=PxkB5W3o20Ba91AHUih5:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE0MCBTYWx0ZWRfX2eCt1qwuDesZ
 aI9513uP3QWOP6ULxTz7iwNnBMm7OrlqYLk3NDih0nud8VL8dw7vAFFGxJsjQ9t7FGj2QFAHHG7
 2ABfHei1DJgmsamM3X0ZYuEy+AW79eUxtWjQ/DLyGpWTGGSnex7JkkdXe0VdkdUxXjxn6NSlicR
 s8bSKV50j7XZYMZkfnStlEQRS69V4w/PP8L1Mq5UtZ2VU9DlukwLSe+wcJB2cqYaV02Jf8cIncI
 a7c2meO7uUrqJgyp4X+ikRzPeO2pIjXRx+cTdi0MRiJL3+Fwwvtnk9YoB8WaX1udwnBL/Tbd7aR
 SCfKQxAbl5+/5HjL2pzslVWuN5KkuE5lPuatlOPcG2OSsHXq6FkvwXim8GFIMnhmakTX0VC/6Ua
 SihyF9OfgF1Uhho65BydFuF4/I13zHoh4BhJxaujR7iMHo2hss1oO/FLuxlCkQqFOVxQHyjlE6S
 GDxM9K0dMti5w7xHSUA==
X-Proofpoint-GUID: MuagFOgmQTU_AkfPTDzdTyYRcxNhp7v8
X-Proofpoint-ORIG-GUID: MuagFOgmQTU_AkfPTDzdTyYRcxNhp7v8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015 malwarescore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040140
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=jithu.joseph@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
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


