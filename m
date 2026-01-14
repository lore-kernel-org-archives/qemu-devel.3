Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91477D31A09
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 04:48:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfsnd-0004IR-9U; Tue, 13 Jan 2026 23:48:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsnY-00045i-87
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:48:00 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsnW-0003na-TE
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:48:00 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c1e4a9033abso4311825a12.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 20:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768366077; x=1768970877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VUx02NhdWX1hPv+U0D9qWfOlv5rUxOUAPxBnO2/bP0o=;
 b=U0jsbf/elWvV4Y8O1WA/qoOCkrCGVlJJE5gXOu4YouGFzKDvDfcfwzobV29bBBUsQl
 IJplOspgeUR/oZU2MdkIFWKs9Vj74Iem1adYT5qabJNzQy6p3asQdNu/rjMw3WJmwtSE
 MobMhD/6xTO6IT0DD8jjkBYTkCx5c52tyv0wFNBEisBYzg+4yv7E4bsT17dHz8Sw8pAs
 KgqBv9F+jDM4aUZbOfjFMpD4hk+52PbPX6yuSRONghHz2/R0X5qMjMqVemC1Sou20stu
 CLkOqmZXhpyeX7FjcI7aLQHyvzqZLzr4w4GO0iP3ff80XcYdBJ/Yc943X1FU830FvhC7
 GmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768366077; x=1768970877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VUx02NhdWX1hPv+U0D9qWfOlv5rUxOUAPxBnO2/bP0o=;
 b=ljIaX7d5cF0tFoWh+ki5IkwdefG4A+X6dYA+bYEph2wjkSuz/QGCI0wIO5O3DRuTns
 t+bMs98w+O05oVZX9Nkxo0iZfUhzxaR+f0GqKq6esHQ174iY49FceGEiwGgs3pyPV1Jl
 yMQovkpxSeNANQ+GF0Ytg93eU1KuWBwsH8/GKp4QNXB9qCYj/bLNg70z+qPT9KsNUgEK
 WEEjoTQOR7T/+WxvQQl1W6TpWMwhdYpJRbTX+O2rz1JmWb9gJWfgCzLJ98YEnUKu01cO
 0MMOvy72I08hx83OHl35iAfk7HyNRF3Cy97CuTcjM/VQ/tf5g8LCGy4mTjMq4BN59nYF
 PRgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXC62zo5XhQDY/cqtWPkR/Mk4jyn4AEPlZn91LrSVvynrvs14jQEDXmkmPqw7NiE8F5UkG6t1190m/K@nongnu.org
X-Gm-Message-State: AOJu0YxA7oDEHHuuu/JlYjTvr/G2JvA2jTQ12SXydAhUBL9UJzVwz2NE
 pKLST7OSy3ee8NEfo9FUpcBilDoGX98Q6JolYshPoNVkv6taYeKxpnmH
X-Gm-Gg: AY/fxX4iYtJsP+3zW901Ou81V5wbO9mTFSzO91Tvk0RMBxFur17Ibih0+bRqKvNwMqL
 CnHSOHINRSWG+LCKiUlJ5rle3nuVv/Mu5LlDHogV+CdkdRtsei1c8sZhZp3bc7fiXhk27YmmmKW
 /x9xpcy1rT6cy67cIZ7npB0zR+sYHx6Hm4+mh3WNN7RbvZMZ5TmPiuFQoGoBJ/yp7SK61plsMFv
 RkgYmgZ/oMrJBC0TxHXBIe8gQmRpA+fnf6qgC+GbVcvJWrUeaSvQ9H4Ky/YSdQSM+vtvwrMgK3Z
 WlDLQHmVjwupiX4NqCIjkugtOHIDrdPvoq11S3Ie6IrZd0b97KUDuN92FuyUBiPHLhEX9v0Eqa9
 iQ0bGat+JIagcL0SPooQGVFPuJ2i9PHhJ7PduTA84IOYKYyqbRyoGLpEV2kiJZsf7U3QmCbSmS1
 V+Zrt1Qwsc+7SQOBrF7oHUwx1vPpG3P+HC2aHMDXCIbaNXGU8kGKCRRUqqA/ydFY1D1apiHw==
X-Received: by 2002:a05:6a20:748e:b0:366:14b0:1a3f with SMTP id
 adf61e73a8af0-38bed22cc8bmr1549074637.77.1768366077556; 
 Tue, 13 Jan 2026 20:47:57 -0800 (PST)
Received: from lima-default (123.253.188.110.qld.leaptel.network.
 [123.253.188.110]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c49037sm216111905ad.36.2026.01.13.20.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 20:47:57 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, bin.meng@windriver.com,
 vivahavey@gmail.com, Alvin Chang <alvinga@andestech.com>,
 Yu-Ming Chang <yumin686@andestech.com>, Joel Stanley <joel@jms.id.au>
Subject: [RFC PATCH 07/25] target/riscv/debug: Fix migration post_load
 icount_enabled() test
Date: Wed, 14 Jan 2026 14:46:40 +1000
Message-ID: <20260114044701.1173347-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114044701.1173347-1-npiggin@gmail.com>
References: <20260114044701.1173347-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

itrigger_enabled is relevant to the !icount_enabled() path, the test in
debug_post_load() is inverted.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/riscv/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 09c032a879..34fd73c920 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -230,7 +230,7 @@ static int debug_post_load(void *opaque, int version_id)
     RISCVCPU *cpu = opaque;
     CPURISCVState *env = &cpu->env;
 
-    if (icount_enabled()) {
+    if (!icount_enabled()) {
         env->itrigger_enabled = riscv_itrigger_enabled(env);
     }
 
-- 
2.51.0


