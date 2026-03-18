Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F30EE10706E8
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 10:34:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2oDD-0003Wg-6v; Wed, 18 Mar 2026 06:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2oD8-0003F9-NP
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:33:10 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2oD7-0002Xy-1i
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:33:10 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43b4915161fso2243663f8f.2
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 03:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773829987; x=1774434787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=31YJoguDTECg29DDzAK2HWxAHgXIKCQcZk0EpeWDAXA=;
 b=DYZP426ev9sisz8BDHNT3Gy1r+jnZLB4udSH5mdTWK5OC8vzJHLPHpdEUL62IDXMcc
 dncWOkc9GnLQqgj68RCrM0Gu0FEbJrus4AlNgUPq3EUnzOyZSpMrLdMyY5ece9UHX1Y/
 GhYPoD01O0MEoY4WzX3+PSQ3jTl/3/ZFOCzCzf0nbeHp7GkHYlU7SkL4iDQAtfdWKB3b
 v19iLrADXd/Rk+o10YcYtL2DMnbIgvWPeqiv7t7EpkyQlJtc8ckgHBAKLSpg3cXR2UW5
 sF3DckGrR6LAeWRWPoziq3tKLsZiDuZdUd02j2oP2U3mBqG3JcsJj42SIUIoyfifqHMU
 BURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773829987; x=1774434787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=31YJoguDTECg29DDzAK2HWxAHgXIKCQcZk0EpeWDAXA=;
 b=MJy9SwNR9R5sCVttsTGqDQs8p7DHAJe+oohOlpEtaZlW/15uS+Qyco3q2piEwLrAhJ
 dGK66fdQGNpnd9chx8f9vI2VwBKuymS9MlbyuUBNRFvVazHGmfq9xQIqtTqXp5X/Rg6w
 1Don9LuN3t1uhfk035d8v4gagLdHKvz53NPP5Y0n4mZs0cvb9Tv4ypQUxFtp2x2OZVVn
 ErsugIcLuoHlpDBCLfzRgzAKICUthKImwsL3fPpq30rRRI76NtiHo0MnqAWklLQ7e1m4
 AwFUXU3sNuMz9ZhPiJdUFJuDDiPYJqYNVPoMKHfAev5i//cMOHaWKAODajZMxrhfhm+6
 rxbw==
X-Gm-Message-State: AOJu0Yy6Nn0G6KwmS3O0ghTvXQk/h3PaYfvucwbfcCU35NSqwjXVg2BJ
 ZlvH2LXJKkERo6XW9kcZX1267J7Cvc0WChvk0KQtuAKnTNEWttZWKctidB86/VPBhhp8Tjy8K2s
 iJBLc4zA=
X-Gm-Gg: ATEYQzw7MSE9HC1k9DEOg6w821xp3IPbdWeT86U5ALgOSB0i6ELbNuuidOt4qCMnWMs
 cvcBRpCmgwBEvWSmbw/bcFZnhxjNWXCFBFoc/o2Q3zzFN4xv91D2UKLXqQ4CFVgdwjMb7kJSDfI
 efZ2tt7oULgv3U0+7g0C9gp5EZnHCFzpSOEtfZbbGbzz8h461dKTG+q+pfib+7HIdPcC9Zi9BWL
 KsWwyLPkxeeKhCdvAW43ZqtvhAQjLFzokJV7KvCbkdAO8rv1amHnK1bXf8xwG8sH+kPMpLzVXIw
 UKXw/LxjbvZRtyJ9K7DfVZo0z6iM/0r0GG9WkiUneMPQMj/tLViQoRZN1OrF2T+rVhUvmDxjh3v
 LMzMuG895UMS/x5aI9blVt9fGh/S3w8a/pepFGuxapoOenNWI9zrY0MF7aXszMs+CPEsVHuHfcc
 zWxqQ3YdDqKH6dtTo61o95TE6hlnVI4ynZSOyE3mDxY5I0eCq4r76nKbBL0lyGCp2qu2/hb7Co
X-Received: by 2002:a5d:5f86:0:b0:439:fd78:188d with SMTP id
 ffacd0b85a97d-43b527aaa6bmr4766771f8f.17.1773829987021; 
 Wed, 18 Mar 2026 03:33:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b518a2cd3sm5591005f8f.32.2026.03.18.03.33.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Mar 2026 03:33:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Warner Losh <imp@bsdimp.com>, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>, 
 Vijai Kumar K <vijai@behindbytes.com>, Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH-for-11.1 14/16] target/riscv: Replace MO_TE -> MO_LE
Date: Wed, 18 Mar 2026 11:31:19 +0100
Message-ID: <20260318103122.97244-15-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318103122.97244-1-philmd@linaro.org>
References: <20260318103122.97244-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We only build the RISC-V target using little endianness order,
therefore the MO_TE definitions expand to the little endian
one. Use the latter which is more explicit.

Mechanical change running:

  $ sed -i -e s/MO_TE/MO_LE/ \
        $(git grep -wl MO_TE target/riscv/)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/internals.h | 2 +-
 target/riscv/translate.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 860c47732b6..460346dd6de 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -71,7 +71,7 @@ static inline MemOp mo_endian_env(CPURISCVState *env)
      *  - MSTATUS_MBE (Machine-mode)
      * but we don't implement that yet.
      */
-    return MO_TE;
+    return MO_LE;
 }
 
 /* share data between vector helpers and decode code */
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index cb4f4436018..6f8b8e9d19a 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -135,7 +135,7 @@ static inline MemOp mo_endian(DisasContext *ctx)
      *  - MSTATUS_MBE (Machine-mode)
      * but we don't implement that yet.
      */
-    return MO_TE;
+    return MO_LE;
 }
 
 #ifdef TARGET_RISCV32
-- 
2.53.0


