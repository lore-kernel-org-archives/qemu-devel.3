Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 791E5C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 12:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXgxM-0006vS-DA; Wed, 07 Feb 2024 07:23:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1rXgxF-0006tI-J9
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 07:23:06 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1rXgxE-0007D6-51
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 07:23:05 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a3884b1a441so48536766b.2
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 04:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1707308583; x=1707913383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M2mD/C0rP4kd3MQb0al+PrLOXSiBVfqFrpY8FsaZgMg=;
 b=UrOV9EvVV8SfVt0s8WrFJUaEgAOY9Di1s+kTtzM265271gQqD+jnL34F6LfZIS4j7j
 sSgS4nNaLq5EVDoCj+yLkOpUXX1V93Igak4Ci0FVNd7Gdx9GioAbkqKM8Ly/mCBp74/2
 9kbH5TsdvaLk2ARaFMRZ8lpzme4auuRkGi4IE3GcZUgjn3X6uTWfqlYrg2bnuBQn4yxb
 8KI1BuM7kaOqfifvs/0DtfYlTMJrGQWpxhQfQZRdr0hx5Lnk5CkUmJEGALH2Yzd/x33K
 rTL8+bPuBRN5TXjVbuYt/9rvJcQ+zDeHufBdy+XVbtBdqkyx1Dc+m3bKmSuyG1AgszlR
 bBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707308583; x=1707913383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M2mD/C0rP4kd3MQb0al+PrLOXSiBVfqFrpY8FsaZgMg=;
 b=rZT34PEtgm+J86MiPl+1xqgxzODlavelLH0d571Y51YF/Mny0FvO7X1JuDA13mn5iZ
 6FX9IA/NAFazHz/hAZ+iI+tHfjSch6NENX76KYZJncMTzKa2dlOVJN4FzYsKzVQ+tbe2
 EchbSY58X+PnRBnzkyqpJI6QmukN1zqHF36GpVqPsU3U2P2reDeasydv3z8Wjph+fioj
 MuYj++kmbXolJB0JAJdmairZnmyB0GbvWy2d7qrl8SPo9qkUfGtjMtf64b7hsKnyVcJO
 IgXGDp1qfBQzuq4jeCInaplWDs/y3gE0NlB49wvBL6PT2/gIjmntIMSRPKQ+91X7VVjU
 xmOg==
X-Gm-Message-State: AOJu0Yw4yOfzYojluRaSnB7/v2Yz4IpaszaGufJF/7rTEN7XXNVAR2/t
 gkVnIjrQz2HaOw7sg3S0Y6v9EEidRu9pPdODbVs8hc3HpTISEQKPgyFkhc+M7EM=
X-Google-Smtp-Source: AGHT+IEHBp53ZrCFbzZuHyFoLtmbx8iGa7isZd3ykvcx85ipWHcZuS3hIybueK33p/8scZl1T4QuZw==
X-Received: by 2002:a17:906:b208:b0:a38:71e8:3182 with SMTP id
 p8-20020a170906b20800b00a3871e83182mr1243037ejz.23.1707308582807; 
 Wed, 07 Feb 2024 04:23:02 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCU0CEO29wy8m+7RRggoIrYxQ95Si4c5bMfx+JnQn3ez138hfzzJmV86vC/E+DEJH6YsAXdwNpB+LHWiM/54FDg2bikB/2tPA4xq6mPlt0+HDEufoJ3158y8Oi5hhV77qFu02O9oAtOLixBNdUuPYflG0aKzjFm5M1Fgq05nxOoUC0JmWLIVtUmY0SlsRlsAZNdCShzONF1dEQnk72cY+cpSWzqof0tjnaDCSG9zTE3LmosizhB4z3cI9D0QCcnc/5ee4IfVJ+RH9tIR9kg2Mv8PuVXhnTxV6GWomqoXrAc5xuM3g2rYDFFcjt6gkD/k5PZYprOT0DYrxdh/QtHzivm1V8FIfyViQdiwIA==
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at.
 [62.178.148.172]) by smtp.gmail.com with ESMTPSA id
 v8-20020a1709063bc800b00a3515b35be4sm702284ejf.104.2024.02.07.04.23.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 04:23:01 -0800 (PST)
From: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>
Cc: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 2/2] linux-user/riscv: Add Ztso extension to hwprobe
Date: Wed,  7 Feb 2024 13:22:55 +0100
Message-ID: <20240207122256.902627-3-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207122256.902627-1-christoph.muellner@vrull.eu>
References: <20240207122256.902627-1-christoph.muellner@vrull.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This patch exposes Ztso via hwprobe in QEMU's user space emulator.

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 linux-user/syscall.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 3ba20f99ad..24fa11d946 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8826,6 +8826,7 @@ static int do_getdents64(abi_long dirfd, abi_long arg2, abi_long count)
 #define		RISCV_HWPROBE_EXT_ZVFH		(1 << 30)
 #define		RISCV_HWPROBE_EXT_ZVFHMIN	(1 << 31)
 #define		RISCV_HWPROBE_EXT_ZFA		(1ULL << 32)
+#define		RISCV_HWPROBE_EXT_ZTSO		(1ULL << 33)
 #define		RISCV_HWPROBE_EXT_ZACAS		(1ULL << 34)
 #define		RISCV_HWPROBE_EXT_ZICOND	(1ULL << 35)
 
@@ -8940,6 +8941,8 @@ static void risc_hwprobe_fill_pairs(CPURISCVState *env,
                      RISCV_HWPROBE_EXT_ZVFHMIN : 0;
             value |= cfg->ext_zfa ?
                      RISCV_HWPROBE_EXT_ZFA : 0;
+            value |= cfg->ext_ztso ?
+                     RISCV_HWPROBE_EXT_ZTSO : 0;
             value |= cfg->ext_zacas ?
                      RISCV_HWPROBE_EXT_ZACAS : 0;
             value |= cfg->ext_zicond ?
-- 
2.43.0


