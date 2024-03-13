Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40826C54E68
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 22:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkWfe-0007Mu-Hn; Wed, 13 Mar 2024 18:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rkWfb-0007MA-97
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 18:01:55 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rkWfZ-0004I7-Qa
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 18:01:55 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6e6ac741ff7so405776b3a.0
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 15:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710367311; x=1710972111; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8PUZYN/jxC55WgIbgr/YDIPnxwzEfC4uN3+8U/WL+Ts=;
 b=Q06OjxCZerl1XvDcegt72BmQESemm5mNjTw0F2GRybJyrou8cYROoOdA60KFdfE4xC
 ZLYVwWpYNBMxS+l5HMHGdC+CU/dTuY49QY90sEAra0gAs5bBDlax4XZ+s2Z5lUHga5P9
 tW1qlgUKMY0MmCgcEpcLB+XKnaYLPDjE6izztthTmqRGChPuAlWxKv6Cuu5phs138yxl
 ILgHU/QD++QuxPOcytMD/q/WXb9k/z0FXtaVLgQKiujOBWZC92MEpxYi6AkptvBBn7MW
 unrBDwSmmkzq3thwCZjZwL0HXZ83QstxPd7qqbX4Ai5fQrm9cqHlwFx4ac9IcXnIhhvm
 CKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710367311; x=1710972111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8PUZYN/jxC55WgIbgr/YDIPnxwzEfC4uN3+8U/WL+Ts=;
 b=YWqpIqF76dwWcnw2y/D2xiYdR7z0+XXCV/AYWJHWYNDznE31dBX1hND+eAL9NW2j4n
 mzGYv0tin9N+Edy5edgfFeMBwLClmKjWcjcCWWP+8FEAVvfWQBMD3GIebi08CE/+BOJd
 aq0mK4vyWBfj6toNIyZRy7BT8jFB4i7rASWzLrNJ26ixFRqQC3nrqW7mDwWe6qXh9NF6
 qzTTlHKZlFtxvUmFA1h/jRn8i3OcOevyGxyBq3ET5g2Y/3Z1wGiAyQFAZ4zLz5FxBxod
 fmgJX9CBmGeovLWnalsnyBi8pxgks4ZA2xBmy1kC8BMZ5BsUT2C9a3lPWcHZI6WUICd4
 Rs6g==
X-Gm-Message-State: AOJu0YyvT0AH/PUGfY2VCM9nzXtbQaWNCuaL70Mf7sMkS5+yCF9ve8zs
 D8KjUWF2J8dvLcLwE9WZ+p92nO4an0jP+WzTH6pmp1akqsr2ayyYBOW8+ErSr6IllGVEOoB5Hcy
 b
X-Google-Smtp-Source: AGHT+IEZcj3UOOX7c2dqK50m68ikQVMYXpWO/kKRFN0xGjiN0eJ1xNOiZv0VjOk+mgzReffP87wrmw==
X-Received: by 2002:a05:6a20:c6c8:b0:1a3:1246:c43e with SMTP id
 gw8-20020a056a20c6c800b001a31246c43emr228712pzb.28.1710367311677; 
 Wed, 13 Mar 2024 15:01:51 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 ln17-20020a056a003cd100b006e6bcbea9e0sm95812pfb.88.2024.03.13.15.01.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 15:01:51 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 v14 1/8] target/riscv/vector_helper.c: set vstart = 0
 in GEN_VEXT_VSLIDEUP_VX()
Date: Wed, 13 Mar 2024 19:01:34 -0300
Message-ID: <20240313220141.427730-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240313220141.427730-1-dbarboza@ventanamicro.com>
References: <20240313220141.427730-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The helper isn't setting env->vstart = 0 after its execution, as it is
expected from every vector instruction that completes successfully.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index fe56c007d5..ca79571ae2 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4781,6 +4781,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
         }                                                                 \
         *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - offset));          \
     }                                                                     \
+    env->vstart = 0;                                                      \
     /* set tail elements to 1s */                                         \
     vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);              \
 }
-- 
2.43.2


