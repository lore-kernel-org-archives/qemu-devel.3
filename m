Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0F9D18154
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 22:03:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0T8k-0003jr-9R; Mon, 14 Oct 2024 18:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1t0T8i-0003iV-5r
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 18:02:08 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1t0T8e-0006Ug-BK
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 18:02:06 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43117ed8adbso52637755e9.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 15:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1728943321; x=1729548121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mser6RZhK+UJgovuFS53xmD+fZjgdUZFZOhfivY7xVc=;
 b=LX/+24ix0D4W3oocD5fG2olF7XSbMboNQ5yVXPjjMOPsYIEoy1J8AMVYoqwPhlldrA
 /xwSBQ8BBZ6I+Kirq5s1vdTcUZqrxLm0pMGaHUL7o5hqAyDm5Y/kQx0kiHCu4T+FK+ON
 xAftkilkF77mu0oK6Sb29jC+R4dpJOM2LpL5xwXiZZx5Smuu9uXvWuvkiCotaBKgbJS+
 u25YpXQOEQp7gEboerEZzQrxmhPHFCNwXf2En40J036jIjFbD4C5Atl51Q/k0GDZnWs4
 zFF6sccgeblkyMCK0Ec5X9DFf8VCguMjm4o1vYqMd6cJW+19jyR0MstofX4HmOUIHDL+
 F1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728943321; x=1729548121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mser6RZhK+UJgovuFS53xmD+fZjgdUZFZOhfivY7xVc=;
 b=ULCCsPQQ4BbMjq2aUKCAiSkrzX6xgI4eKlr7ys/dRinwS0DIwK3IKrg/2o1gx1aEnR
 BWgNmH1puDYjrUm5meO/qXz7DLJ+vUhc/w1tttZ6Uc/8GppU0qQrEMSPCeKfK53jYXEs
 Ktpu/CDTMMFfxJrLiWRjXbL1gCKrSV02peMskFspiSuX6eR0prV/o4AC45cLa+moaEle
 2NNPxCOPsl+IxMsZgYtH39xc/kTTSp2La8NzMTFF4Oky2fYON0m3Mkb2jwa3QpLcDxeo
 2+82r4oQiEd6pfqIrrznweHdWckzAomjQ3x0phM00MW9MSBeUNQTSZKXPhuKB3wEiF6A
 ToZA==
X-Gm-Message-State: AOJu0YxYlRAnCzWGqsSPOkEcdTdO7UN39kKNnxJLSDI7vduMfCSfSEIY
 JrhSfxOpodFukdZ2aSaY1JdNSV1Op7VKara3VBP8XIfUvpHMw07Gk2Yl5pm8OI8kySdHOiAPkQE
 RwFU=
X-Google-Smtp-Source: AGHT+IF5GaZsCA3nlIKyhWDHMvHB7PEWXyCbgCGS+DjwxoXCR1wCmaZZeIia4R7MH3F4p6dcIDUgiQ==
X-Received: by 2002:a05:600c:1d0b:b0:42b:ac3d:3abc with SMTP id
 5b1f17b1804b1-43125607986mr121583225e9.24.1728943321196; 
 Mon, 14 Oct 2024 15:02:01 -0700 (PDT)
Received: from paolo-laptop-amd.. ([2a0e:cb01:d3:f100:8971:afed:16dc:a06f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa7a09dsm22769f8f.23.2024.10.14.15.02.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 15:02:00 -0700 (PDT)
From: Paolo Savini <paolo.savini@embecosm.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Paolo Savini <paolo.savini@embecosm.com>,
 Richard Handerson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Max Chou <max.chou@sifive.com>
Subject: [RFC v3 2/2] target/riscv: rvv: improve performance of RISC-V vector
 loads and stores on large amounts of data.
Date: Mon, 14 Oct 2024 23:01:53 +0100
Message-ID: <20241014220153.196183-3-paolo.savini@embecosm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014220153.196183-1-paolo.savini@embecosm.com>
References: <20241014220153.196183-1-paolo.savini@embecosm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=paolo.savini@embecosm.com; helo=mail-wm1-x32e.google.com
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

This patch optimizes the emulation of unit-stride load/store RVV instructions
when the data being loaded/stored per iteration amounts to 64 bytes or more.
The optimization consists of calling __builtin_memcpy on chunks of data of 128
bytes between the memory address of the simulated vector register and the
destination memory address and vice versa.
This is done only if we have direct access to the RAM of the host machine,
if the host is little endiand and if it supports atomic 128 bit memory
operations.

Signed-off-by: Paolo Savini <paolo.savini@embecosm.com>
---
 target/riscv/vector_helper.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 75c24653f0..b3d0be8e39 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -488,7 +488,19 @@ vext_group_ldst_host(CPURISCVState *env, void *vd, uint32_t byte_end,
     }
 
     fn = fns[is_load][group_size];
-    fn(vd, byte_offset, host + byte_offset);
+
+    /* x86 and AMD processors provide strong guarantees of atomicity for
+     * 16-byte memory operations if the memory operands are 16-byte aligned */
+    if (!HOST_BIG_ENDIAN && (byte_offset + 16 < byte_end) && ((byte_offset % 16) == 0) &&
+        ((cpuinfo & (CPUINFO_ATOMIC_VMOVDQA | CPUINFO_ATOMIC_VMOVDQU)) != 0)) {
+      group_size = MO_128;
+      if (is_load)
+        __builtin_memcpy((uint8_t *)(vd + byte_offset), (uint8_t *)(host + byte_offset), 16);
+      else
+        __builtin_memcpy((uint8_t *)(host + byte_offset), (uint8_t *)(vd + byte_offset), 16);
+    } else {
+      fn(vd, byte_offset, host + byte_offset);
+    }
 
     return 1 << group_size;
 }
-- 
2.34.1


