Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E6BE6894F
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 03:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MFq-0007GI-Um; Wed, 30 Oct 2024 23:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MFo-0007FL-PL
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:53:49 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MFm-0003td-Iu
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:53:48 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-20e576dbc42so5429865ad.0
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 20:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730346825; x=1730951625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i8Ikw2NcsgZpzTmcdbGYuA7GcCItNURSpq5TPRbUd/s=;
 b=AYEH3vg7x+YF/28pVjmrARmqcw8pdbWXQxlZxTtZ1OEfmON8sqvJ+Ui3wVxTBip+Vk
 fsEl7sbDZtoKT+r+aCz30j8wk2SjK1fMra8f3gumxo//EXAkN0gLUGdmbFTFB3UG+xWe
 bX1I7h4z/qqHzmJxziXBEd0cEmGnyUS43WqkWrw6kSkVqswwzpWsPh+MIlQi+9phSYAf
 qxWIYpAdfeL/KD85G0IIPAk+PpqXAlGhDY1/Fu7sQH5sjYpieFqg/o3YH4zmTeGdicGr
 Uewl5RZSNaFAcufXgcxH3HdjwRn8bK58MpbVOLQlRT1mIFot3aCrt8bCsPzYBoVxoMiG
 2u5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730346825; x=1730951625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i8Ikw2NcsgZpzTmcdbGYuA7GcCItNURSpq5TPRbUd/s=;
 b=G9BzP6N/1Y+El0QB84KbNBwBcPmSnuzAN6JQCnqK5e+vN4VcjeHuXMWodii+pesC9Y
 dB9FyrG+8PC0c4I6mCQUNB+z3TBXAPgqoP5YjLo4DxTAJDS2jyqm9lkoJi38uurkkdSY
 hcLCAmrU74TlPEln5+TkncNrfc3Bp5BoedFsIJr+UzyXYE/dUUk/TC4u7SId1Y4kOVT/
 ABZU5o8auYLdVgR1zNY3IX2Y4GGJJAkZ7ZKmCAUMnf0RRC6ug4Hpo/j3Avou+UyioXN5
 /W8uSz5PLP9iJuBUPyars0rSXb82bJ5JWZQ5L4VdoYmY4DYKsKz/P9PCWfU6xggcshPI
 sjlQ==
X-Gm-Message-State: AOJu0YyLeEO+gBlM9GZFLy+eYrYXk8LRkOTPMbx+4ITE8q0Kn97NHhUv
 XJ9u0MwA5jOVKfUAEt3KfqMMQTVT0fnDxo3Xg4fss+jkVoJpcsNv79kIpYDv
X-Google-Smtp-Source: AGHT+IHFPwHe2b10sA90Ce0axRItyk/2Jvz0H5iVMUl98Tvz+xt3/ttku0z3tq6/MDTye3zr66ZQrQ==
X-Received: by 2002:a17:902:ce07:b0:205:709e:1949 with SMTP id
 d9443c01a7336-21103cc0a4emr18540615ad.57.1730346824762; 
 Wed, 30 Oct 2024 20:53:44 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21105707064sm3022795ad.70.2024.10.30.20.53.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 20:53:44 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 06/50] target/riscv: Correct mcause/scause bit width for RV32
 in RV64 QEMU
Date: Thu, 31 Oct 2024 13:52:34 +1000
Message-ID: <20241031035319.731906-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031035319.731906-1-alistair.francis@wdc.com>
References: <20241031035319.731906-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
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

From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>

Ensure mcause high bit is correctly set by using 32-bit width for RV32
mode and 64-bit width for RV64 mode.

Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240919055048.562-6-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 621bf4c1b8..203c0a92ab 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1677,6 +1677,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     target_ulong tinst = 0;
     target_ulong htval = 0;
     target_ulong mtval2 = 0;
+    int sxlen = 0;
+    int mxlen = 0;
 
     if (!async) {
         /* set tval to badaddr for traps with address information */
@@ -1805,7 +1807,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         s = set_field(s, MSTATUS_SPP, env->priv);
         s = set_field(s, MSTATUS_SIE, 0);
         env->mstatus = s;
-        env->scause = cause | ((target_ulong)async << (TARGET_LONG_BITS - 1));
+        sxlen = 16 << riscv_cpu_sxl(env);
+        env->scause = cause | ((target_ulong)async << (sxlen - 1));
         env->sepc = env->pc;
         env->stval = tval;
         env->htval = htval;
@@ -1836,7 +1839,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         s = set_field(s, MSTATUS_MPP, env->priv);
         s = set_field(s, MSTATUS_MIE, 0);
         env->mstatus = s;
-        env->mcause = cause | ~(((target_ulong)-1) >> async);
+        mxlen = 16 << riscv_cpu_mxl(env);
+        env->mcause = cause | ((target_ulong)async << (mxlen - 1));
         env->mepc = env->pc;
         env->mtval = tval;
         env->mtval2 = mtval2;
-- 
2.47.0


