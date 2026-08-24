Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D69C5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:59:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNbE-0004yl-5s; Mon, 24 Aug 2026 01:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNa1-0003cd-Kl
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:50:47 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNa0-0002Va-4E
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:50:45 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c9cf07d2df6so1890605a12.2
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550643; x=1788155443; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/dfTpCPKeINTMs5DuO+JXEx9y5VLl487hSHIWrRqxGo=;
 b=FJMYfNN6J7xELWqqiYBZGho6bOYQ1OuSfYTtx6WtoVVsxxg1pUj0QkLMBwJRmJ0jfX
 WCJk/I+qnoMa3Wk8YBmUJyvD7XbKO/LXOgrN3qvZG4cIiEMtTwyyE/bwLPDjwDJYpsKu
 OHg0woGPjWbUb/Vxlc0m1BH5z07u6jtjj5eiWuGI+WdEwyYKlb7UGgsmAkoauEab6QJz
 LNxE8KvHuOARrwPaknQWCyhouipk/qXm03W3YLt8mQWCWuW0wLjAl6u8umeZjD1MebA7
 +MQJczbWblq1JHsNrUbmpgjuHeq+SjzA2dMv/zLEv+vvE6TlbpM0INYljRMds2w5SMYc
 o7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550643; x=1788155443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/dfTpCPKeINTMs5DuO+JXEx9y5VLl487hSHIWrRqxGo=;
 b=UBLcLlzqRUzcc1npgDb5K3IXjhLpRMS1m0OSUZ40zYdHGhZB0lG2s3Vwl50EdzyzkI
 v/UjaGyWGCBaqmVLi3MqteTmaGVgaXEtVu1u8qJctQ0pRyjuvCZvic2moHjO6mdKkUPY
 zWdsqw64krb9oOEo3MDbSLk0oS/kmwzq8+nc03ABr+f+ycbxN+I0BIsANztBFdHYfKIv
 HQNaVjQJ4SjsC8PMqDDP1vvDONsDBMItnSn5yU9LiE2ULRNqDfuIadS6HBqoUm7TNurr
 OIOgHKmCsx/gLcaksr15tq4ew8bxxaAS9b2mbe5lKy3LVDavzKR0ROqkFciheIz6ckRB
 D7Bw==
X-Gm-Message-State: AFuF++kBy5vRfWG6/mt5zWBSrqorFClbdYX+dRjFSj4FzDSWwsS4SXzr
 IQ4jClggJevcO29PqneoRnR6UBovsbSnGYXLopG5zz9OB+3oRcWfuScF3IS4hQ==
X-Gm-Gg: AR+sD13QebW9WsbQ/HFQUTqa8dDGkdJTgJTo3lcbj+3IocGBBEeI3sKbepI8Y1/dD/j
 N6IFqIfAS/xOJXKAuHwYZsxQf2aed5epDTDf1yzNNZycj7b/weI7lgQOb5T7AfusBSV+zdlIXQ0
 IvhCgdTDQ1/49DHCi1REHQoDrpckKRaomMXHy1983x+L3wElen4eUh/Lao0Wa6uuCwOZrraC4+Q
 hXoaTxg1xJxjAPkd3PGQsLSVxhY2M1/4VLILfLZHdNn5hl2YdFCv+oFagVatwhoU3/9FtHAEbWT
 EaSmxgj8blP0ipNYPKadezo0UwGE37eSWjdgr33qXkiA8dDUIlf4EvhXVsNnDKokT7J4xxIMKk/
 8rOybSP99Y3mUbOPXsRUAcia9IRXj8vQHFbtkJYe+VWTv9QvLfAb0jO0tv7l1qpjypfUtrE0yIV
 0atQ49G+8n6bNJ9yizEGeKW3G7JLsoqMDRQ3KKKs44uVBZO5JpBd7wzpRX1l0t2qqpYUJOrSoP/
 E5/iA==
X-Received: by 2002:a17:90b:4986:b0:38e:e9b:ffa4 with SMTP id
 98e67ed59e1d1-395c33cf295mr43122397a91.6.1787550642796; 
 Sun, 23 Aug 2026 22:50:42 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.50.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:50:42 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 46/96] disas/riscv: Handle c.addi4spn imm != 0 during decode
Date: Mon, 24 Aug 2026 15:47:16 +1000
Message-ID: <20260824054806.2790041-47-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-14-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 9813d75feb..8a957e6a1e 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1885,7 +1885,7 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "fmv.x.q", rv_codec_r, rv_fmt_rd_frs1 },
     { "fmv.q.x", rv_codec_r, rv_fmt_frd_rs1 },
     { "c.addi4spn", rv_codec_ciw_4spn, rv_fmt_rd_rs1_imm, NULL, rv_op_addi,
-      rv_op_addi, rv_op_addi, rvcd_imm_nz },
+      rv_op_addi, rv_op_addi },
     { "c.fld", rv_codec_cl_ld, rv_fmt_frd_offset_rs1, NULL, rv_op_fld,
       rv_op_fld, 0 },
     { "c.lw", rv_codec_cl_lw, rv_fmt_rd_offset_rs1, NULL, rv_op_lw, rv_op_lw,
@@ -2952,7 +2952,11 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
     switch ((inst >> 0) & 0b11) {
     case 0:
         switch ((inst >> 13) & 0b111) {
-        case 0: op = rv_op_c_addi4spn; break;
+        case 0:
+            if ((inst >> 5) & 0xff) {
+                op = rv_op_c_addi4spn;
+            }
+            break;
         case 1:
             if (isa == rv128) {
                 op = rv_op_c_lq;
-- 
2.54.0


