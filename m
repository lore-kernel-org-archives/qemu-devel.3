Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCD7CA9EBD
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGprm-0000Rq-QN; Tue, 13 Oct 2026 23:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGprh-00005u-4u
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:41:17 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGprf-0001iw-IJ
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:41:16 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3ab868eb9cfso219202a91.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791949274; x=1792554074; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JU9FC+AgPOsfxCEoIA3ZPGvJJqPUOOFOukwg+UzBEQQ=;
 b=cT2G8RT+Yva03dr109EWtCtwEJODVWcCIjkb36lZay6jil8zEb4VMU+BxWGbeNWfpF
 YOxDh9C7yDTgK+fCSmZhNVEMkpx/Tg97856bGuOhLtnXZfBuZE7P+oeroxlP2sFNYl75
 +6BEqU7g/2qyXCfn5HxE0GWpSsW4fQUVv9MDf/1bQI2qxd2tYAA/d5RFYHtgOvY93X/T
 8r3Mpzw+IFPeYzc5uMGqcpw9MNUbSq8PhzkyBAzvjDVDukNLEnrcrrCHggcHWoLEHomL
 EprbBplAGvU488xMIrrBtvDfJGGrTh8cGj0nVLMOUJxZW1w8DcYcmLDizrzMJxeEaK8Q
 9DIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791949274; x=1792554074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JU9FC+AgPOsfxCEoIA3ZPGvJJqPUOOFOukwg+UzBEQQ=;
 b=mlOd0GN3uCeUgOVYTabdIEDNQueKu0tvItrhzVL+77txBxap4ftr199lMZuQ2Phs/0
 pTueH2UwEtKYs19dJR6gDz05hA37vLQ55phJBLx4n5CbhmRsDJEh852RX+L5D7Rq6K81
 hiBkCc38YtZeAQA2jsDofkDKZvZZedRSTRyf/NSNbdJ40hv6BmP/0La5ehJe857JNZLp
 vKXA4daYl8jiZdb6evyvvAYte4CmVWaV5LD6Wip9TgZsgStUD7w6XtC7N6Uoep51uXDg
 YQAE+J8nS3GFrvCi9vj/dJs+oK98MrQ+umWzTcuGo0jeI3Ej+C2MWiRfkx71PZ/odWC6
 42LA==
X-Gm-Message-State: AFq9FYJ/NgGEiaLANwLJJ6jHFikrxi1IRm4HTf9uxf8RM4Qmznq9eLfC
 isHgDqfQra1Bh8eSck/JmKQLcAdfH95waTUjpFMcydkhvDStDKq/irBgqaYflg==
X-Gm-Gg: AYBFou1oGQa6Rh2LNXB1OUOJd87JeF2lqEfTGF3ff19RvUMzDWsX8/IWqRo98WGU5f5
 rUnz9BNjv8ETH8v4HunNxjV/jVdVykV++ujG67LlE1aPR66h6VL+38+hpgVtqdMul/75tJiAuJo
 7tq6JzJ2r4tc58m8kkF/RMjOuoD5jVpU6EdoCX6RH8v1ZIb5gufyTDTytFSGwD0fUxbT8ma9zlc
 sdlyfEy/FfaqdHR04cK6mVxFUSe4FS1jmtWXzgB25iEvO9dH5jyq7ERYh24CtERuVvgJZ36tjUH
 BC/ef8D8AovbE1T61CZyZr9QSng2YWR667Ndv4tYFVv6XI60LvN3OgF490zmE6k4UUZ5Iq9SE14
 HNQH3JgL0VJ9TfX5ZVferk5/32e9qm8OiJ4ezFaM88px2alZMcwcnmGHVJE8zjjdmlPHveyp/SK
 pZddigmQIzDli6vR+ICfYldBhqnb39BFRy7i0mCxV46bj/ANAjjzl//abSm+Oc4xWZWooFzSKut
 vUxsJMjIrC4jukK
X-Received: by 2002:a17:90b:2e0c:b0:3ac:7872:d1b7 with SMTP id
 98e67ed59e1d1-3ac7872d292mr23641a91.32.1791949274260; 
 Tue, 13 Oct 2026 20:41:14 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac61170b7bsm2321457a91.16.2026.10.13.20.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:41:13 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Frank Chang <frank.chang@sifive.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Max Chou <max.chou@sifive.com>, Chao Liu <chao.liu@processmission.com>
Subject: [PULL 36/52] target/riscv/cpu: Add SiFive custom int8 matmul
 extension implied rules
Date: Wed, 14 Oct 2026 13:38:51 +1000
Message-ID: <20261014033907.3332383-37-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014033907.3332383-1-alistair.francis@wdc.com>
References: <20261014033907.3332383-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1036.google.com
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

From: Frank Chang <frank.chang@sifive.com>

Add SiFive custom int8 matmul extension implied rules to enable the
implied extensions of SiFive custom int8 matmul extension recursively.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Message-ID: <20260927082534.3228237-4-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f145f8fd0b..4f4ca08583 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2921,6 +2921,24 @@ static RISCVCPUImpliedExtsRule ZVFBFA_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule XSFVQMACCDOD_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_xsfvqmaccdod),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zve32x),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule XSFVQMACCQOQ_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_xsfvqmaccqoq),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zve32x),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
     &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
     &RVM_IMPLIED, &RVV_IMPLIED, &RVG_IMPLIED,
@@ -2972,6 +2990,8 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     &SMCTR_IMPLIED,
     &SSCTR_IMPLIED,
     &SSSTATEEN_IMPLIED,
+    &XSFVQMACCDOD_IMPLIED,
+    &XSFVQMACCQOQ_IMPLIED,
     NULL
 };
 
-- 
2.55.0


