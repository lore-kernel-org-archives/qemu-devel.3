Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE02ACCF2C9
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:11:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIRb1-0005pR-MV; Sun, 18 Oct 2026 10:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtaodtdt@gmail.com>)
 id 1xIRaz-0005oB-K4
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 10:10:41 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dingtaodtdt@gmail.com>)
 id 1xIRav-00050g-0Z
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 10:10:39 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-8a01cac8733so762966b3a.2
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 07:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792332635; x=1792937435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2Hj0eRrB32lGUpH16jwWWPrR4KRoNl92h2htBgfoO4s=;
 b=AZ8iuiOUc78dNjbNge+/eMTWjRmF6jYVANu3aLe88mcWEVm2bTYs20Ferk0yzRd9fA
 /LKSkL+9k0882+bsEh0KLEZDRXCmH0gy2I/qCQrUYW9V3VXhRuGT4CJ7dZYiNcVh7bch
 2nH6NeJX1RGD1nwCMo3xk1E1w71k6b5m7xtUDSGBVtWqMunTRg879DezDBqh6QcA75xt
 GqpuS9w1yj/3qCB/UN0BQ4cTgXlmFhUZgqsMpxgezx1T91oF5nzjPmBId6N7YLu6FaMQ
 Ki78/Ti6Jm59o4NjikvmJHpmb6sjKdWx618RbPGK1swJbmo+jZXqVJ0jkeJTgESNK/Jl
 DKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792332635; x=1792937435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2Hj0eRrB32lGUpH16jwWWPrR4KRoNl92h2htBgfoO4s=;
 b=KxarwLt2PqYqMwFaf/184zy4FA45gDOgE9Xfg6RR9fSLPC+GMJcBFIuKhEmK5MTVHQ
 gVGfyXi6vkIx3schqOb+SvGnQJ1QvyMZRT0iFdgIfrnW2djGF5mQ5IpkDM+JaJfnMrIb
 Ay5Fz1xfjhoQZV09lZQ9F+GEZh1DQ4y0O6apqXs6nxGz1HzEXdJir9iGbm8puKWi6pBL
 wk+xIEJ6G9klPQjhI/oQB4ZuOb1LAfrDfasGz2PEWxj9e3FFojg6CnjIBOqHRke2KudZ
 w2GQ4O0kd75n0qcQUAV4zi1o3WYy6U1T5IZXmgKGZhMlI8qGS2B2x7Uaij7s3G4sjMkm
 UEwA==
X-Gm-Message-State: AFq9FYJ+wsijbx4QYCIyu2hYUCFwcqkiqoVQvyuCuygzyRgfeG5oEfPH
 vpx9ADkrYpEfj315+oZ9TRXoOhhvJfCWM4hzoy8a7sQii8CdYBsPWUBy1mXkozOF
X-Gm-Gg: AYBFou3LjHHRlEBxbHJo9yVB7ZOoe3vlih9NsGFI/i45vqQNK96NYAFF1gVWJf0JTfE
 NRaFvpAp2zpue+orprLfB+FPvBQYyws0huoPSWq5qHkiRvX6fSUzxoCIAL//mBfeSRZwkdJyf9B
 /r46vBbkRhJBzu4KCcRYi/pPJOKZIqatSpsl2ngl5QL4Tl//t2hyit6aNloPf8mqE/Pz3XvyyK4
 DiHDpERF0N1yp64fo/p0SG6p1EeGZ3ByAoH4Bf3FjIv76+izygCPwQvPOjmZeEMZgO43FQFRnRT
 yz0TTNAItQxuB206wPEH6B4k2H1tFat+dL3NmYnxGRb3+WKViVJJwKfeuzFutbnRZdiRjbY1gSH
 G5HQuRcj1h+F4Yc58SCJm0Njq8XTsSmmA7PMb5MZZxDmGmj9ysRzSWD/NtL6eieylfmET6aP/Ho
 dKmbiH16sLe+dzoDFJp/9SxkHizpy0maTE1rnSZlQ+6rQw127Ml3cG0LIMNmjwBRQX4iGwkwGPN
 Eux7btud79p5Dgn
X-Received: by 2002:a05:6300:86:b0:3e0:e60f:2e5b with SMTP id
 adf61e73a8af0-3e226026bccmr3747606637.30.1792332635602; 
 Sun, 18 Oct 2026 07:10:35 -0700 (PDT)
Received: from dt-VM.localdomain ([101.204.150.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-89f57653ea9sm2949430b3a.32.2026.10.18.07.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 07:10:35 -0700 (PDT)
From: Tao Ding <dingtaodtdt@gmail.com>
X-Google-Original-From: Tao Ding <dingtao0430@163.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, chao.liu@processmission.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com, Alistair.Francis@wdc.com,
 Tao Ding <dingtao0430@163.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 4/5] qtest: fix k230_decomp_gzip test integer handling
 issues
Date: Sun, 18 Oct 2026 22:10:05 +0800
Message-ID: <20261018141006.16398-5-dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261018141006.16398-1-dingtao0430@163.com>
References: <20261018141006.16398-1-dingtao0430@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=dingtaodtdt@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Cast slot to hwaddr before multiplication to prevent 32-bit overflow when 
calculating the SRAM input address. 

Resolves: Coverity CID 1685516

Reported-by: Alistair Francis <Alistair.Francis@wdc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Tao Ding <dingtao0430@163.com>
---
 tests/qtest/k230-decomp-gzip-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/k230-decomp-gzip-test.c b/tests/qtest/k230-decomp-gzip-test.c
index e80113fd28..249c8ae82c 100644
--- a/tests/qtest/k230-decomp-gzip-test.c
+++ b/tests/qtest/k230-decomp-gzip-test.c
@@ -46,7 +46,7 @@ static inline hwaddr k230_sram_addr(hwaddr off)
 static inline hwaddr k230_sram_input_addr(unsigned int slot)
 {
     return k230_sram_addr(K230_DECOMP_GZIP_SRAM_IN_BASE +
-                          slot * K230_DECOMP_GZIP_BLOCK_SIZE);
+                          (hwaddr) slot * K230_DECOMP_GZIP_BLOCK_SIZE);
 }
 
 /*
-- 
2.43.0


