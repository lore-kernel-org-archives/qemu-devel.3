Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 184E4C5DF9D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNcL-0001EO-1T; Mon, 24 Aug 2026 01:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNcI-00018b-8W
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:53:06 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNcG-0003Gs-Gq
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:53:05 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2d5cad1a6baso28259085ad.3
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550783; x=1788155583; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oecC5ZHB+mDg+64qzcXgOyLmh0fryebbjbeCqefnTnc=;
 b=HmnlcrQ7kz/3WDouMqeh7oZ8n0+Ppt6oddEjynfuTPw2ISNikc3+q4kz2fp6RbpsQS
 eTu+4c8EjOQnIpq9i0xg13ghYVhRVpEoFkuU1YExG0tSZXWW5rE5y/TTg8nizRRsGXz0
 wa8BoLBWi6Pvs2c2O3KG7zyKxj7X6KWcXIqWzXtXixcJMenCCAT8rVGsNYFXa2OBS6P9
 G/VlSeYvdCo8qhanCAkDYwqKePZ7oqqylUAqBu3D4L1N0ec3wJGHdqvNGVv4WMhpxsD/
 LBSSB8twN6QE1jvTfrMN+teBdhkrStqow9MIM79/7hzVeW2xlBZEVGmdEDF4QpxIjhkv
 HNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550783; x=1788155583;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oecC5ZHB+mDg+64qzcXgOyLmh0fryebbjbeCqefnTnc=;
 b=iahTPM1F8Kjq1PeCtq5Z3ANCxo6pV3EyROyvnv95C5E+1VRVDZQ6WicdDLubf5UqOV
 zfJDv+/JTaJYP1Gd0n9TXdRE4VblUk1yNUrvFAKtv6vMj8T+Xe783rRwpjtWsexBcZnW
 Tf6gdquz0cLaYVbaSLJ6pH4rsqHIKQHzRja538AtoiOlZgXUlaDzIMJIyvsv0QeaVqr0
 tk8hhU8WKIYg8umen2JlmGcF/y9rBY19Cg62n+YIpqEfQ8NfO4p3k78w/45+/tJC7Qt4
 WduZR+4FwN/LmqrQFg8KPvd3oTTozR7KU1YthfGt1GvrsbTP0K0c3eMRJ6DfZOFLwOQ2
 yuGQ==
X-Gm-Message-State: AFuF++li8EfTiXPpqH3xR3gRrRC+vGM9hRXzEh8qbj8o9H1/rZr1QQIH
 zFyrhWaX2uE3atjmbZS4qikFcP0neV28MNFtf5XKJml27onrnAQ4RxfI0wHulg==
X-Gm-Gg: AR+sD11biu3H9MXuTMUnvvUtGOJ7bufauPM8TM0e/ghhcb00YFsqsovu+gE7obF/6Mj
 o95Btef0WSzDpt+50/g9XzycXbkaY/PYBA0AkbT89ZtLUFAJul8+2iciPcMsBom5TA3+X4JirmI
 RNk0ODlhUXVnksmCSd6t2bevXBp/AgjN736lufLD5zkFHOKD0AqPr0NFG2RDEV9tvShUNn2ti6X
 zlcrh7BpOb1mthOe73oVuBlkvlQwJ6wj1VYDuNefBptj7fJBO9xYsdogormtZuePyzcBIfK5HMx
 c2rHYm/IFljg0iQrvBJy4nZmtzoY9tKY50HqiMXvesEj1OZhxUtXWdPAah4SMoaScBifioVFIi+
 GjT7R3V8USxbr3M18iYr8Mc4zjG5/dr5AV1o2cn+elWapLmk5nH43LdJObqBtZgy6m5aBg663Bw
 mv/L31pVybNcT8JOtRPjEp5tP1+Y4iZD7vepe4udPFkkrRtN7KtSYkvR8vr6lpPBygOe6FaSOyy
 MUaVvVLcM8=
X-Received: by 2002:a17:90b:5646:b0:38d:f5bb:e0f4 with SMTP id
 98e67ed59e1d1-395c33367ebmr44746567a91.1.1787550783020; 
 Sun, 23 Aug 2026 22:53:03 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:53:01 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 92/96] target/riscv: Allow UXL to be 3 in mstatus on rv128
Date: Mon, 24 Aug 2026 15:48:02 +1000
Message-ID: <20260824054806.2790041-93-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62e.google.com
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

From: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>

Valid UXL field values for mstatus were restricted to fix a
reported issue, but this inadvertently broke the experimental
rv128 support where a value of 3 validly represents 128-bit
execution.

Update the mstatus write logic to permit UXL=3 when running on
an rv128 CPU.

Fixes: dcd028517749 ("target/riscv: Apply UXL WARL handling to vsstatus")
Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Message-ID: <20260819105655.33391-3-frederic.petrot@univ-grenoble-alpes.fr>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/csr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 9cc6297328..4c8959a33d 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -2014,8 +2014,8 @@ static uint64_t riscv_write_uxl(CPURISCVState *env, uint64_t val,
     RISCVMXL xl = riscv_cpu_mxl(env);
     uint64_t uxl = get_field(val, field);
 
-    if (uxl == MXL_RV128) {
-        uxl = xl == MXL_RV128 ? MXL_RV64 : xl;
+    if (xl != MXL_RV128 && uxl == MXL_RV128) {
+        uxl = xl;
         val = set_field(val, field, uxl);
     }
 
-- 
2.54.0


