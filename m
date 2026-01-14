Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799E5D39013
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 21:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg8UY-0008ME-IJ; Wed, 14 Jan 2026 16:33:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vg8Tx-00080J-Rl
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 16:32:55 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vg8Tw-0004d7-3U
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 16:32:49 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-64d0d41404cso386612a12.0
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 13:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768426366; x=1769031166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YDTcPZtVYw3MtG62eS7y+SIW0mtoLWrmocC3dD9mQTc=;
 b=i0MSUwh0LHqEj5gQWx8Xc+QfQNyGxhzCovFbmO1eOQOBDR5x1KDxPVRwvgtgkPeJmT
 eviSgMR4S4/XS8fl+66otN3io5fg89qMl9KMn7E51QZceyImKS76cTqjOxq/rwaZIw/9
 9Cv4yb2qI/fnrjD7ubKzrYmgAnm7IpFn9VF0hiJU1BnEpTORdPWugcX0sXgDQtKl9xuG
 FkZVy6s/Yp3QmtaurAUVaXnWR0vp7PZAOStU87YFxChn5RcsVaxqFaL+wYc7yzDS2F39
 Ody3s7qslGfBXKzTct0FYpiugDlBM8aqj/HoP8qy5ag9rTqJlOWrntsnKJgiVKSwCCaG
 +MZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768426366; x=1769031166;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YDTcPZtVYw3MtG62eS7y+SIW0mtoLWrmocC3dD9mQTc=;
 b=ibc8BOs3daUdXdATfqCsBnLJAH2ZfEGiQpmFiYzxmL1cF6LQ9Kpz+zv6hJNfzi9n20
 NrxnQtIxI/tG/iPDFqNpqlQmIZJUZBAjz1UvT185Xt6y+sjS68jlonS6CvIPnKDhz5zE
 N2g0Re5XNiVIDV01Txa86Y8x4y9jxYCl9puq/jk1w/G4y/S6j6vST610sf0KsoiGgEcy
 pa7Y2Eb8NMAQaxmeHbyo3q2EFbY2WiTTDdCjKzLdmb9bVMtYvx+wrvGQELL0FzcfBSOU
 bhtvRG3/KZGW31i8SoueS/1NV+nKENsIQqynAt63hdzIpDKSbPiu1dxhVMi81bb3L2x6
 oyfA==
X-Gm-Message-State: AOJu0YwH3ScVFtqjH/Jnbqqzw7Mmfjo+EzJAVMXkYmSucw2GvWgzTz8m
 /Cef8+OTnDX6y2nvuAtqREeD5xVD3lvIPxlZu8djVSJ7mz+N3YPkpjRIcNNn3Q==
X-Gm-Gg: AY/fxX4VGiODV1n7zuaX5dWSX3sfAlivLKvhcBAnYnQrfjNx64OZefAFXLj65aK+CDy
 /UFOFYXreJGwkHC9bpdY40pCfnSNk5uUZaLCAADJNPJv7UzycEaX/M28fzqtbOBobughibcCVNK
 X2Ml4GXwQ8T2ZTEL6lkYSKRoWmCMwxaYJRYQGyiuMooOfmvnlPEWxPqg4bMr7j3ZyXUG+QdjswL
 TFqdtoqbqiV8BXdkys4IO6cwKeygGyUk0TVVyXTER7U7iF894cpvSoYpyAXoxyz6vvrAexHP/RC
 bLO7eebxS48HUeK4WcwH7E/itUorR1PVAyD2NUBv9qx52DqXprMqZ1vA4bjOZIIbVXudbh0EImI
 oPb2rzKR6P4VMBRjrwfi6Jm8af5LSMInNCbuavrfmEAYQmQgPkEbm6tJZcvQl9HYTFor/BFXm96
 dHduC55q/ol6Fa9JF98qgbR3PVKMSM4oSBCw/dlqI9I5X7uJ63rNgs6h5lbNl/rZBg32RWIg==
X-Received: by 2002:a17:906:9f84:b0:b83:972a:6af6 with SMTP id
 a640c23a62f3a-b87677dfb73mr279483866b.44.1768426365466; 
 Wed, 14 Jan 2026 13:32:45 -0800 (PST)
Received: from archlinux (dynamic-089-012-235-150.89.12.pool.telefonica.de.
 [89.12.235.150]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87124e1a1esm1081252566b.48.2026.01.14.13.32.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 13:32:44 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 0/2] imx8mp-evk trivial patches
Date: Wed, 14 Jan 2026 22:32:25 +0100
Message-ID: <20260114213227.3812-1-shentey@gmail.com>
X-Mailer: git-send-email 2.52.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52e.google.com
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

This series contains just some quality of life improvements for imx8mp-evk=
=0D
machine's CLI usage. The first patch removes the need to pass "-smp 4 -m 6G=
"=0D
and the second one does not suggest passing redundant "-cpu host" when usin=
g=0D
KVM.=0D
=0D
Bernhard Beschow (2):=0D
  hw/arm/imx8mp-evk: Provide some defaults matching real hardware=0D
  docs/system/arm/imx8mp-evk: Avoid suggesting redundant CLI parameters=0D
=0D
 docs/system/arm/imx8mp-evk.rst | 4 ++--=0D
 hw/arm/imx8mp-evk.c            | 2 ++=0D
 2 files changed, 4 insertions(+), 2 deletions(-)=0D
=0D
-- =0D
2.52.0=0D
=0D

