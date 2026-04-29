Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB06FF8864
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:51:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwri-0002ni-H4; Wed, 29 Apr 2026 00:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwrd-0002fz-Iw
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:49:33 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwrb-0008S1-Si
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:49:33 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2aaed195901so52974125ad.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438170; x=1778042970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kSxzjeWowjH6pPZPuZ1B8y5yQscu5B8SeT7B6HwvaD0=;
 b=XzPA577w2lkuI5TiJoegOAidhNfIJfmmU3fyyKT6k+T2rmL7tKHffMjAOI3iDkuazK
 NI7KbegUP/+3E0llQtlccxJhpKLWGDEiatL2VfE9j21QvYf3Sq/hAkqgGGg7yKmo3NjC
 rNugsR3N+VkGHPIt0n4efdTRQkog/bufOZ7jniiu6a+U4SbWmmNuba5uIP86eWXmN4E4
 V63DDeUotxlDuH7aSJjgD3EgZeuOrYPX67RTCusf8okUOZKk/pHZUNqdUB+fWqsPszSF
 L3iNN9BUCYeDELFhhcGxbDd08ESNVMPAVXLe1SQnBeVvH2HGuSwZjO4M1yV9brWvFzob
 vTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438170; x=1778042970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kSxzjeWowjH6pPZPuZ1B8y5yQscu5B8SeT7B6HwvaD0=;
 b=GuUriyQoYrXj0Z5tnHOkWCdRpx6QlPvnBAiqzkUvtqRmFb6qGcmko/SdnyNALoJ6to
 fTj3ha6MRp+JyGHtYfIdA86PNBEZodvjwt9ukTm6lyufEzdjB3U0j+DBvwSf4Hh2MLad
 Va+7SXmOmgtFF1d4kMg7TYxlow4e8vAMA5IbicKwDOelYR6KZTv2LgQ4dNSyeJznYDRA
 442H78TlOcSn8HKTEvKL5ey3LSE+BlDLM2oCZ5vGInfcoaDrIlxM3JT9ON0WCTEgJVi/
 J6uxueo/6TyUd1zFmujKiuOWbAZFaTd48zBc+lM5MLgtShCXHpc4K2rMogcoT+R/5n1g
 dSZQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ936oGppuFL8u0XMG++ms0ZSZ7JFwd64l5PF67Q/hygA1zkvoskz3dhgyvjkrbuwHuRuxVOdvwLctZs@nongnu.org
X-Gm-Message-State: AOJu0YzCGnCMnRxDaE1BeaB9WUMaCDQbQdTbl7LzVGvRMFQDBHqBP0j3
 2Q+4NYXwaPnAS7u6WrCT/6VrJZp3Q0DtW7EEk8YG3rTWhYDvk9bGn3Sm
X-Gm-Gg: AeBDiesMTZenZYpbcgrdd9D9YEP47hUpUMaNP129KYv1gSYY/4MSrzhFr/0JNIPh6+r
 Ml7i8tkKLZmlO2qWwwnhBBecE6qEAxQUo+yxytvSN1nme5zroC/5Y5HiVwg5UwMiDBUw4NS1O9L
 ENBrnOGIC7xxD5E70TPWAXlEO6WTn5EGzrFRtW5sDmz2FFwaiPh+aNETKnYFWbY9sryi5qpFMAy
 TVYtXfYRL7FjfpNIfUklla7WKv2Vim1Svqbm+Z3EfhK5qKDfW9gJo0gclxA4baDBxkGql5lyuRM
 eQBfsrKwulN05awb7qqcvWOiY9tYSok0nVRUqzCnxwgFmjbiNCaehm+mud0szC/PBscqI8LYdnv
 CzBd6ONtXCxas2p9Hs1jqQ1nWZ6bmSFNDoIQn/lToLS06yoZTbF6BIQzIT/fsJc5LizeRUolaD4
 7Iv9AVgB1mrxm46hJOCJuMG2PrzXYH1tFqSdrE81ubmvW0PRAmMGtSRUeULM9Xf5k=
X-Received: by 2002:a17:903:1ae7:b0:2b7:aa20:3c61 with SMTP id
 d9443c01a7336-2b97c4b6a0cmr60140225ad.33.1777438170310; 
 Tue, 28 Apr 2026 21:49:30 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.49.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:49:29 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 16/51] target/riscv: Replace MO_TE by mo_endian (Zalasr
 extension)
Date: Wed, 29 Apr 2026 14:47:17 +1000
Message-ID: <20260429044752.4176397-17-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Replace compile-time MO_TE evaluation by runtime mo_endian()
one, which expand target endianness from DisasContext.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260318103122.97244-14-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvzalasr.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvzalasr.c.inc b/target/riscv/insn_trans/trans_rvzalasr.c.inc
index 2b1f73f650..0f307affec 100644
--- a/target/riscv/insn_trans/trans_rvzalasr.c.inc
+++ b/target/riscv/insn_trans/trans_rvzalasr.c.inc
@@ -29,7 +29,7 @@ static bool gen_load_acquire(DisasContext *ctx, arg_lb_aqrl *a, MemOp memop)
         return false;
     }
 
-    memop |= MO_ALIGN | MO_TE;
+    memop |= MO_ALIGN | mo_endian(ctx);
     memop |= (ctx->cfg_ptr->ext_zama16b) ? MO_ATOM_WITHIN16 : 0;
 
     tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, memop);
@@ -79,7 +79,7 @@ static bool gen_store_release(DisasContext *ctx, arg_sb_aqrl *a, MemOp memop)
         return false;
     }
 
-    memop |= MO_ALIGN | MO_TE;
+    memop |= MO_ALIGN | mo_endian(ctx);
     memop |= (ctx->cfg_ptr->ext_zama16b) ? MO_ATOM_WITHIN16 : 0;
 
     /* Add a memory barrier implied by RL (mandatory) and AQ (optional) */
-- 
2.53.0


