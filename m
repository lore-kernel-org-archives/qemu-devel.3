Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07138109B462
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 13:16:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7YxB-0006LI-OH; Tue, 31 Mar 2026 09:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7YxA-0006IO-68
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:16:20 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7Yx8-0004BQ-K4
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:16:19 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-486507134e4so65260265e9.0
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 06:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774962976; x=1775567776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3TiU30N3aL04FVTsBMyQy/KMizH5YZnUxC49XTkGNzw=;
 b=wjrn0xq4KaPEHPkH1duSfZd8yexSMetpJgyf0vb+cSfOUDH7NCcr86SOFLZWlQbsNt
 CA9NcqnR+UQssALJgSKX1igHAWNS4MrHH5ZbdjB/coBvxUXWMPHCP9WZz/F0vx4EVieu
 hThy5l15L9JE2kB910Oxn0/Yir0aA6EAM0wKdCNnUn2sCNP9+QP5IyVBFuNSqDoO3Bk9
 2ZhonJppYUJqG0DcWisi5cHpS16AHRGmvCdAWCppKy0TmXQmatkYKy15pU8tx5EQToqv
 QNVaLAPglYsmFtxiF41SoYkLqhw6Tn/9ql+iortIf8vF/vTk27Qafg3LFavON2Ww++L7
 PYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774962976; x=1775567776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3TiU30N3aL04FVTsBMyQy/KMizH5YZnUxC49XTkGNzw=;
 b=GoOjThvfeCZyH0FJCbQYVYB/Yt+cEw1Yb2nZU6BJsGUPd+Cxwqe60f270ATRRiGnKg
 B9GMJ3J60bOYmoa4oEbOscQOHHfrTc7lZkgQTUeL5cogSnEDiJlp6X04apeQD2x9AmZj
 jDT3cOpqOQFZUS5iRkR4aWAgB24IZqpb5Pb1gjPhZN/lJHZyp6N7fMSQXQ8zsty9Zgx/
 EVkmRbQbQSA/xcXfSmnsHkYERtc+UaDu85kjCkECrNaClVJnOAKG1z+WytitpxiEXq3G
 B2Xk9knRgh5d3nFV0QNmA6/2Ja8Vhe/2EJXCZy32rLm6svvACb3CdBGJlxNwH3zqEjCM
 AmKQ==
X-Gm-Message-State: AOJu0Yzl8FRpKVXp0cr/iV5k8WrNEzsqEnQrSiraOXBA9b4LJoZHxZxV
 +LDmtZZvMOBZ2dvUUjLwYHAT7vBhbh8EEw1HAZYA8J+1TI/WG+E6+MrtMhRc4qxQ48h5h3C7lCQ
 ypgnyfLk=
X-Gm-Gg: ATEYQzz5gdQTklbXcpp8s46cxJCghFO/IarwsoPwfv0ClGhEgjI983jG6iF07Dko4/+
 K9apPYpLthSNTHzwG3Yn8XlF8F34OnQY+KT+BFRxX/HLJ42Ko5tfnpPDYeSCQ75F6tnp+3mrxOD
 OJRzmxveH3cNMyTTJQjpPJwOVxJW1LCsOJ7uByUaT8wUpdEYVcVafTNtPvs3SDJHnHmE8AEIQUP
 KKy8Gm1cbSfaQNE7gycRj1UjkMErIxw9nGBtp9lZFbU9GHB5ys1ZnCzfMpDbvKiEQnPz624wiWU
 0COgB0Ze4t5X3wOKZF/12y4XBSI+wf6hYHwC0PAQz9LSZoF1A47w8R4R8mMOPB0O8Wfa5lVnjAA
 JkSuk1F2H74YHzwNKgVXrkENLSBHrUv6pfw9/vLSlK3LOpkKQ7M1JjsFdDrH7OXLL0Dl6ue1pUm
 RxJapsFmbWnhhohJloIjufmeNNQ2w69r9H0dUHbU/wyjYJ9ugTXX8yFGV07v9AaDH/afTyaeJ1x
 dFmfg==
X-Received: by 2002:a05:600c:4685:b0:480:20f1:7aa6 with SMTP id
 5b1f17b1804b1-48727ef67f8mr289681565e9.21.1774962976369; 
 Tue, 31 Mar 2026 06:16:16 -0700 (PDT)
Received: from localhost.localdomain (43.149.216.82.rev.sfr.net.
 [82.216.149.43]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e829c43sm33935015e9.5.2026.03.31.06.16.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Mar 2026 06:16:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/11] ati-vga: Silence warning about operator precedence
Date: Tue, 31 Mar 2026 15:15:09 +0200
Message-ID: <20260331131514.21152-8-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331131514.21152-1-philmd@linaro.org>
References: <20260331131514.21152-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Coverity in CID 1645969 warns about possible operator precendence
issue which is a false positive in this case but simplify the
expression to silence the warning.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <24161ec41f118ad097387f8a84897dee7b4747b8.1774904832.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/ati_2d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 23527b2c505..9baf6ff37b0 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -91,7 +91,7 @@ static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
     ctx->host_data_active = s->host_data.active;
     ctx->left_to_right = s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT;
     ctx->top_to_bottom = s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM;
-    ctx->need_swap = HOST_BIG_ENDIAN != s->vga.big_endian_fb ? true : false;
+    ctx->need_swap = (HOST_BIG_ENDIAN != s->vga.big_endian_fb);
     ctx->frgd_clr = s->regs.dp_brush_frgd_clr;
     ctx->palette = s->vga.palette;
     ctx->dst_offset = s->regs.dst_offset;
-- 
2.53.0


