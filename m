Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C7B606A31F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s/DR3JQA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLagJ-00020l-5b; Tue, 27 Oct 2026 02:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLag9-0001tu-1w
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:29:01 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLag7-0008Ay-JE
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:29:00 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-cdab6ae1ee9so728860a12.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793082538; x=1793687338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=am8/VQSG4uGN4wLEjLuxt8Q+WDhWLCuGzRmAcu4m+RE=;
 b=s/DR3JQAef/mzGZd+mxC2skKYmYzhUVo4Kj2jTGl1l5SnbH/hTp+CexrX4vV7UuanY
 4AjaThdqO5yV1tPcHH8ZCaHaztGTTQxWu9YJ8mrmBpmuTDvlOijWpETBS3TMACkhBw+p
 6OnW42WxXnGX3Whgj28bm8CLzP2SmZYgrrmOcWzy6NkfV6D8LRdehs0tuwO7YI9gAF6q
 fUSRIyBcptXtgrQIdfayArcRdRrqxC5bKzdn4aagEWDXOgPn4Cgs2sxuLlEIHKUA+QV8
 LhHNN6CSm+RhuNbg0qK/yFbAmfG1Ii0F+TBJ5nwX4pIaCjipdJk4Z9dNNq74Th7Gq0xb
 Rb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793082538; x=1793687338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=am8/VQSG4uGN4wLEjLuxt8Q+WDhWLCuGzRmAcu4m+RE=;
 b=uNiGtS0oEU2g6ZDs5bNSdxR24e3pj5qOGRD9uP8bi1V6syXgqtOIGXY7zrbfFMxwik
 B0XqLQ2Gy/JmceAB2sgvmJWkEWId84qp36Ip8Ufm4aPw/8NDT7OLaLni5PsaEn47CQb+
 X05oOdVJ4u5k7hK6zGFgAIv/01pJVctxcJPYo76nn51XiGKhmAbule0QM2whQIYRsIVn
 J32cF01Je9AjKKSj0N/2aH69EMKoNTXUlw+gUoVutXAa/45+BLtpiniOB7Vi9glesXQ2
 C5wH0PwJz+DYYbi4EVsQDcnIQLhfJfRyMM3uFGYUAgmkQ2N/V0s7q9b3TbrTUr5QFZm2
 1kYw==
X-Gm-Message-State: AFq9FYJkz2OqNFnKwW1Yvs/fh3LQSXNDBNMxYnlHVFLlmQ4L6IBAwG1u
 Tvba2s9oSwdJ9pAtgKXowhsijk4HhWi5WCc4zLo9Pbfrc0V0Tru2SrjsUlxn3Q==
X-Gm-Gg: AYBFou1+HIWGbOQntOkLFuApO4mTe5a/dPKPmQBAu1DHBfVbBFG+KWExDvPLvKI+YjK
 TweUWKDSnC6QImPPikC+GnmfKNWcSvdsJW5KSUzwL1i43v9673bWEqFHY5WAd6U9uTiBfa7Eb/L
 HzLved4Wu2JOwcq+fikBHr8qdh3hDCl/+QE7O1w7kx4yI+U+enzkLL/OKS33Jm8ksgjcT+e5Fn1
 kd+MrMSMe4GYjqZURyhs1Cyh5Q89TMQIC0WZvIIWkI1INbXQygSQhAidwFOOdJls8DHagCzeztR
 v6mkWm7XeuPpx2w0dPst4TOHe1J46W+Rn0BdsX/cwzpmufRic2YrKp1Mp6PV04B5vaL9FFbJJjJ
 wF/yKIcYT6clPSUaxa3/mkwiYMbnCbN5DxHZaC3tMrPKSAi+fIqKlN38d4CdboH3iOVKlRlevvj
 C+Aen9aBz7pii7sxGF3s2L2EAGHcY1WC3UO/QEVajwS9qO3LkafSmO7Nbct7Xq6gVOHsAst2Oo4
 D8vwe2mYdicZT9iPQrkOutxslrEcof4SzhosdUYKbFk68yZBSNiLKr13qy5V6fbrRa03oPqnm0=
X-Received: by 2002:a17:90b:1b06:b0:3ac:af8b:6f3 with SMTP id
 98e67ed59e1d1-3adeb13138amr6666126a91.52.1793082538237; 
 Mon, 26 Oct 2026 23:28:58 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae401bf352sm2358541a91.0.2026.10.26.23.28.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 23:28:57 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Tao Ding <dingtaodtdt@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Alistair Francis <alistair.francis@wdc.com>, Tao Ding <dingtao0430@163.com>
Subject: [PULL 10/29] hw/misc: fix calculating output address overflow in
 k230_decomp_gzip
Date: Tue, 27 Oct 2026 16:27:49 +1000
Message-ID: <20261027062808.1995205-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027062808.1995205-1-alistair.francis@wdc.com>
References: <20261027062808.1995205-1-alistair.francis@wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x534.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tao Ding <dingtaodtdt@gmail.com>

Use hwaddr for address calculations to avoid 32-bit overflow.

Resolves: Coverity CID 1685515

Reported-by: Alistair Francis <Alistair.Francis@wdc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Tao Ding <dingtao0430@163.com>
Message-ID: <20261018141006.16398-2-dingtao0430@163.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/misc/k230_decomp_gzip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/k230_decomp_gzip.c b/hw/misc/k230_decomp_gzip.c
index 0d8a3b2d2ed5..ac06cc15711d 100644
--- a/hw/misc/k230_decomp_gzip.c
+++ b/hw/misc/k230_decomp_gzip.c
@@ -53,7 +53,7 @@ static bool k230_decomp_gzip_write_mem(K230DecompGzipState *s, hwaddr addr,
 static hwaddr k230_decomp_gzip_output_addr(K230DecompGzipState *s)
 {
     return K230_DECOMP_GZIP_SRAM_OUT_BASE +
-           s->output.slot * K230_DECOMP_GZIP_BLOCK_SIZE +
+           (hwaddr) s->output.slot * K230_DECOMP_GZIP_BLOCK_SIZE +
            s->output.current_offset;
 }
 
-- 
2.55.0


