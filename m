Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B10606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JOzv2GcX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLagO-00026F-VV; Tue, 27 Oct 2026 02:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLagG-0001ya-Jb
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:29:09 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLagF-0008BI-5f
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:29:08 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3ac78f4c10bso1793364a91.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793082544; x=1793687344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K4MWpK5CB0Skv604hvdzJDPtjFWaWttfk33njqHjEEU=;
 b=JOzv2GcXnmXao440e1+exRxWzUlInqa3xrV9dv1DrFm9C0f3B5LHyQxNqr5vVw69gK
 wYglWK98O6cv42hhLMvk+wPH2GW+0tZcflaOtL3xeqFl4Tsd1OmlJR12r1uDBI68XSKb
 4wFOgwG5K6zMccAUkCgSUmiUqTgF+E6w4m9jgBptfRELlQ5qhAV4dPXMknbZmuu3emFC
 d4CIfCZqm1kI5q4VkQf3w1xl96fQIr2Wsv+79st/cxjAs2/eL/M5FIZldt50DebBeIyJ
 72LMpHAfpEDnw/cpoEKS2+OprljN3YcB74XstkqDuA9fKqzikBlyvd8QG78mWgbPyRYf
 I0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793082544; x=1793687344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=K4MWpK5CB0Skv604hvdzJDPtjFWaWttfk33njqHjEEU=;
 b=O0ugKIzIb5UF3hN7is7arBEATq9JnhDZtkTUSSci+bSDtH09kpoEGgODU9RBab0Pqy
 jUutPXiYSA0QSe6GMmb8x91AccL09wq/k2CGSjKv1eB6nCdHbY54Kqvg4V43sgv1QePx
 GSX8PTTYvbjbcVxFep50aX36jCBNIbB1iCR2dHNkBGGPMxSIc/jcIDCERcnUuGGz97kH
 N1AXfg6ZbRzvpek/69aJ1wC2FvyeNP8jt0eB+igezJ5J6Nkx6rZ7geG7yvle+2o2zy4B
 lCEkSJFOoM27XF+4Id2s9xNOOuMLPa3bo2V9UDdiDcnqgVnoP3y2GCsTYIhvtEJWx4po
 Ie3Q==
X-Gm-Message-State: AFq9FYLT8MLha+JN/3Jvj7GkQPfkzmGAqNj35ZXjrIHq8NkBXofK4lPF
 vQg2RMkEHWShPNeyamMxyNer3uRVwOIvrg6sOsHuSAQQePbLVD0eA9lfDvYdjA==
X-Gm-Gg: AYBFou1NRfWS4IuK6MrMlmGQ6IP5SOd1N4TxMLc4mvr5SkKIUmqYK6YI+iZ9ndYMvdM
 xmCxyS1eiGO8MMfOikTJegGV1GpG2yqpHojp8ffJO/f4R8BV0xcpy5wHqFBSNo1ZIkp97S01hN5
 vf74LOvdlau+3ciI1v1N2s+LKnPZhdmZ8/hqgRuhGpNney5a4Ul9m6Pw/fPP05gIRYReanPkzCP
 cyp6sbgoll913UVpT6CDP8Uh5/dQRJcTONuVvfE1NQn/e6bLUDJq+iMGPYVBVjvqwR/E++Y3wAE
 entQ/EdMyuEKmB4YINCP6kA3d2ShHsEpI/GtQG1+Y0hCXVUxrmp5k5gb/9cLcVZvohj3AIfrgtI
 ucabDXVFExfB4CksF+iftKY0DBpLjI2PUa3wFNahd2ZvJP5NtsuHzfVVjXB7r2FMQi3tL2XbXIT
 mG8LPRxNHIkI1MJFPW3DuhU8ahzbxv/K6RPB4bP+dGkudNai8MRO3o7TDpSbjCAd+Ei+nyTMznq
 MgghiU/46FEpnPIgpqv8OwuNkZ8QOT2KI7gY0wTGBfFRbQr8DLdIVC20TDyww0yB1GrIRLYJCIV
 iw7yBvMV8addRRiexSpxK6G8uShIuZBjgP4pcIAo52y61Ys=
X-Received: by 2002:a17:90b:5647:b0:39e:6a7e:ee18 with SMTP id
 98e67ed59e1d1-3adeae8342bmr6692223a91.36.1793082544501; 
 Mon, 26 Oct 2026 23:29:04 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae401bf352sm2358541a91.0.2026.10.26.23.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 23:29:03 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Tao Ding <dingtaodtdt@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, Tao Ding <dingtao0430@163.com>
Subject: [PULL 12/29] hw/misc: use hwaddr for the k230_decomp_gzip input
 address
Date: Tue, 27 Oct 2026 16:27:51 +1000
Message-ID: <20261027062808.1995205-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027062808.1995205-1-alistair.francis@wdc.com>
References: <20261027062808.1995205-1-alistair.francis@wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1036.google.com
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

Use hwaddr for address calculations to avoid 32-bit overflow and
address truncation.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Tao Ding <dingtao0430@163.com>
Message-ID: <20261018141006.16398-4-dingtao0430@163.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/misc/k230_decomp_gzip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/k230_decomp_gzip.c b/hw/misc/k230_decomp_gzip.c
index da4dc6f95497..54303c0e7f4a 100644
--- a/hw/misc/k230_decomp_gzip.c
+++ b/hw/misc/k230_decomp_gzip.c
@@ -102,7 +102,7 @@ static void k230_decomp_gzip_finish(K230DecompGzipState *s, bool crc_ok)
 }
 
 static bool k230_decomp_gzip_load_input(K230DecompGzipState *s,
-                                        uint32_t addr, uint32_t size)
+                                        hwaddr addr, uint32_t size)
 {
     s->input.current_offset = 0;
 
-- 
2.55.0


