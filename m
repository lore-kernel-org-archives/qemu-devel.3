Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC01C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 17:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVwrc-0000T3-Dt; Mon, 22 Jul 2024 13:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sVwrZ-0000HO-Fl
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 13:30:17 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sVwrR-0006Nj-BU
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 13:30:17 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-426717a2d12so23240835e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 10:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721669400; x=1722274200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8nfDaGNYYtX7WTms9otZZ/RyOW6fJggHI+PAByoitQ4=;
 b=Tcp7YWDtRpvssscB17O8CJJ0K1Yook0ZQ0ZdLXoZbozNBycZDgTt4Kl+8+SqogyexN
 O7kD8GL768c7N9YJFd1BU+U3bzU4bIEfeLIXAMuN5KecC+RZgn9JhrVNT3wHHrEWweOm
 4Ps64CWkY+SPF8jwRX0Ey7bY8nro7uVzQs7BxqoSS1uNXHA6LcKK2QzZ3LNgnCLoBpmX
 yNG3qjhgw+c/KQ/TpNqpwnc9m4cA1p3CTMgTFZcktezSIGQOoJaSMD28pq/Is0NN4U/r
 aNPBeFGtBSm+9fCC97XxTJIVHGuDwWIFqX4Sl0wVJ02T6FOyDGG4YPa8gSVvLobsGVUv
 8W2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721669400; x=1722274200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8nfDaGNYYtX7WTms9otZZ/RyOW6fJggHI+PAByoitQ4=;
 b=coDjx4491Qvh+1lwdOU13PYMA8YVnCjtC+G945SxqJCH9MaX8mZKEH1OQ8CpGaujGn
 Y1VtUmtYfsOe7Zuupdlsc/suE03/KoLPYU68a4hGpXJ5lKc26EcSEix0ai1vrRPAbQmM
 8lwumi7PUZmOICLOYgsdkhI7SdIRzw+F+EzTgGgvYFczrJ/rh2Zcdx/7hMqcXs7N0PBQ
 raWk/8NGXViqr87uAq5YH9dZc0cMJ6emtjbWO60QmiH6C3S1hcrFtrOPbyCraiHpMkfY
 SEZBs3nsOSVif8cG9q7itcDcYWN0RYNHWAuGR8FMcyLwaX5IpREDhfaNwqY2ngkKVCKx
 Ya/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzkoeEKpVP+ev0ONlIt6Jn/UKKWCYwHN0Pk1hLjThaIV9LpjtPl4BrnJlf0syHZFYVEZTtPWjDnBhwv0K7fayJPJtOGhg=
X-Gm-Message-State: AOJu0Yxsf1qL3VH455U2/pn2XUqcugCLKj6UHJQFuoosalLIJqPwkcBz
 96ivCz0We3P5jvEDWov7FV5AGAMdqAwSdTkCu9+UQjVpuNm1Ex56sy91wfKZMew=
X-Google-Smtp-Source: AGHT+IESykxc2xIjcPnIcvWjMUjSIU/bRD3kBDqRd0w+0+M94iHjZh5f7qUzy0rUA3DtB6brt+3QCQ==
X-Received: by 2002:a05:600c:4509:b0:426:67fa:f7 with SMTP id
 5b1f17b1804b1-427d2a954c2mr89604295e9.9.1721669399753; 
 Mon, 22 Jul 2024 10:29:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d68fa493sm138035665e9.10.2024.07.22.10.29.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 10:29:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH 1/4] target/arm: Don't assert for 128-bit tile accesses when
 SVL is 128
Date: Mon, 22 Jul 2024 18:29:54 +0100
Message-Id: <20240722172957.1041231-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240722172957.1041231-1-peter.maydell@linaro.org>
References: <20240722172957.1041231-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

For an instruction which accesses a 128-bit element tile when
the SVL is also 128 (for example MOV z0.Q, p0/M, ZA0H.Q[w0,0]),
we will assert in get_tile_rowcol():

qemu-system-aarch64: ../../tcg/tcg-op.c:926: tcg_gen_deposit_z_i32: Assertion `len > 0' failed.

This happens because we calculate
    len = ctz32(streaming_vec_reg_size(s)) - esz;$
but if the SVL and the element size are the same len is 0, and
the deposit operation asserts.

In this case the ZA storage contains exactly one 128 bit
element ZA tile, and the horizontal or vertical slice is just
that tile. This means that regardless of the index value in
the Ws register, we always access that tile. (In pseudocode terms,
we calculate (index + offset) MOD 1, which is 0.)

Special case the len == 0 case to avoid hitting the assertion
in tcg_gen_deposit_z_i32().

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-sme.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 185a8a917b0..a50a419af27 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -49,7 +49,15 @@ static TCGv_ptr get_tile_rowcol(DisasContext *s, int esz, int rs,
     /* Prepare a power-of-two modulo via extraction of @len bits. */
     len = ctz32(streaming_vec_reg_size(s)) - esz;
 
-    if (vertical) {
+    if (!len) {
+        /*
+         * SVL is 128 and the element size is 128. There is exactly
+         * one 128x128 tile in the ZA storage, and so we calculate
+         * (Rs + imm) MOD 1, which is always 0. We need to special case
+         * this because TCG doesn't allow deposit ops with len 0.
+         */
+        tcg_gen_movi_i32(tmp, 0);
+    } else if (vertical) {
         /*
          * Compute the byte offset of the index within the tile:
          *     (index % (svl / size)) * size
-- 
2.34.1


