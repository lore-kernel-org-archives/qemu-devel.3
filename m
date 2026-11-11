Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9A4606A8B1
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 11:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=BlGwiGwD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR6w9-0000wz-Kt; Wed, 11 Nov 2026 06:56:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xR6w8-0000wh-NN
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 06:56:20 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xR6w6-0000rD-UK
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 06:56:20 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so25966195e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 03:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794398176; x=1795002976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6I9G6vp8vQqfdThmpDJnoqcQTf+w4qhyJABFqvzGtUQ=;
 b=BlGwiGwD1ykq3G3hKt6grXRJVPKOZtL9EwL0fY5l0tFpNdiBoVO9MKToxtBHz4nDqD
 qmBpwRuKe3SGmk2vojumL1O2a+fKq05YsKF6n5kdkc5fcCQcosGUhY13XfdqV8bNpHc7
 rKVjt2cioXsOCI3r5ncSJyihpDyRKFGtAwkVLB8jZPGbiPwapRg98HB9/cmfDikKulO0
 b9I6wLBsTOVmXNwW6AzWYlzgsJY8gzSUrH51jx/3pHZR1cGGCL5VTGD/T3W9cjfRNPAM
 WsBYh/zSIfVoZ2rzplPvDEHIM3GJEbEg1I/YYKx9MfFBuZqDvRjYAKO+I/TY+isVTLV5
 EPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794398176; x=1795002976;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6I9G6vp8vQqfdThmpDJnoqcQTf+w4qhyJABFqvzGtUQ=;
 b=IOKbz70JTWvluYq7usTqAnDZouBldg8gZJxEzBJsyaIBvhxghjVcobRWJUxd1g4oe2
 2njM8AY9NXLOdk2Wny10LoONXnalu7yS4p42ZbBmdiyzXW26cVrTFzAIJcMJxS6LKpnR
 hXEaXiqty2AXg7i4UmrZdDD3191V2GQ1k0/rYPvIhGvmj+hS2q2lKDtQgvfvsQGbnfId
 zCSBqNNSdtVYM/L+fezTbjpnHbwv0P6eHupU7m95d+11BHpDcUbthgf1nMRoC0VQiiE3
 3hACYD97PH+cqcnHovBB2vFdxqarXJB+9agOoBO/1pW8beDHhx2Mj7swCoe/rVkfINel
 6sbw==
X-Gm-Message-State: APuU4Z9KYccfkH37gaVxcO1gwvkUrSKZH1RVQtH6qDFjFPaQ3Vs27Knk
 u+mcZBjBxjg6euILNiBbY5+uGQ4AZ20FBJcitwvKrjoIMiAqOtoPPZR/aXBG8Zz1+W+ymVBD9nB
 rGorq
X-Gm-Gg: AYBFou1qOsRGm/DwMgSO8KipbJxw3/KimdcnI7AiWFVJ9Z5Q0w6T96owN/WLdyp6BWQ
 0Ku34HpyDRbTsF/y+BEMst/UbSmGL+leP29zR4BbZkgeN3IVyZITyGp69AnS3PYtgZEalEsIkXJ
 T6vkoZAZZ9YjdSKpeqOIzin+81mSORIbyfQ0Odwcg0zgFk+FTkN2+aGQCF9LAKDu0ArAKcbnvTz
 X1up7NoKNr0ylnc+cfeV8WTeVZ4cM2CmlGKa8n1zIU7iiby2N2vqaysWTdh0dPNRkQL9OSNd3hA
 Sx38UUnT3BLjOHnR9+snmp1AlT5YD7b8lMhA/pSlEoAtcMKBJozJVQ25DNKe611EHsVg9RYUCKQ
 KcIVbhHzxoBSk/iBl4cYRRrbICii7Ro1NTpus8iBs/AxgCrwsQOL1Q/heKFkrL3cfe48de7gLsx
 FTrvfTFtFnMfBNi8kKFcpDlXoniWDEJaf4/WpKenLnZwVd1PBRLwNGSuDtoyzphVOk2gJKnxN4V
 qmGcDmCX9gu+eKBDIrKnrp3rOovrtgCDGoxZlxscHqufEKIWbmt14ntuujaNtzjPigb3LunlKxz
 6bM/Y/Q7f0So8IcfOR4NrBB3ool2soPAOcLu2PKQJ3FNKT4RqdpinZY/eetPGpnQsob8dWuLgl5
 HAuhN/8V17Bc50uOQEKoomrXJHOWHlZrCfTVhnrnEl90EwdgKnjdmaBMun5FwFEYulFjRxFnBD3
 CRPPDerBrWGZw7NYziGDkZxOJQ9z4qrrYLKEzm+kZ/DcQJ/raXJQ2Je98oVOB+r088MHpd/+dF1
 cxdajc=
X-Received: by 2002:a05:600c:6994:b0:4a2:150f:1609 with SMTP id
 5b1f17b1804b1-4ba09364b87mr41338265e9.8.1794398176267; 
 Wed, 11 Nov 2026 03:56:16 -0800 (PST)
Received: from satan.lan (ppp-2-86-138-39.home.otenet.gr. [2.86.138.39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba02043149sm128158315e9.8.2026.11.11.03.56.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Nov 2026 03:56:16 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 0/6] virtio-snd fixes
Date: Wed, 11 Nov 2026 13:55:52 +0200
Message-ID: <20261111115559.18557-1-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x336.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 
29760efaf96bbe5928f8111881eddbf5ac06439e:

  Update version for v11.2.0-rc0 release (2026-11-10 14:47:54 -0800)

are available in the Git repository at:

  https://gitlab.com/epilys/qemu.git tags/virtio-snd-fixes-pr1

for you to fetch changes up to 9a0f03f81575168283e56dab51bc0f0a13894092:

  virtio-snd: period_bytes divides buffer_bytes (2026-11-11 13:46:50 +0200)

----------------------------------------------------------------
virtio-snd-fixes-pr1
-----BEGIN PGP SIGNATURE-----

iQJPBAABCgA5FiEEzFwbTkSgVvOHcB0QdynHcH9+CdAFAmr0VikbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMCwzAAoJEHcpx3B/fgnQqiIP/RwyAXlUupo/L8Lgetbx
bjOwtNBPZBKlZk6F3A4WNpqXZRLFlnH6GQSH7l0Xporokm8qiVytH50mHJcBFgpi
PoICtqNooN5ud9YeK8UWQFXqGLSb4G1V2x6NQyLd1zGOrZkrnNaxRIRu0vN5s8RO
R2dcrpYJ5S9IChbkWM/vLo6p9HAeGcD3F+zT1HhRpm7iKCKXZsyCCDGXu4RR6eUM
d4Oxviglg1krjxqWy0ZNiohO1I3FOhYrrJiNTwv9jbbv+FXCAs45a5Ve1XauYgRn
+8yPocxfFiuX9sobAXirNy084Xmv8kJCYThAucvho19dgEItDUamNhYg/fbsQHDv
QZKb0JNtQm5B8xXmIK3zKGSGGdSUw1hn1YmQSgAy4clUpxhRgqCmFw/6I8Eo9Yt0
IOgimj1hYQ9Fq55VNDdEEr16PH8O0b7D/ztToD3pw0ejW50kNIkBz9RrebCNfLTW
rShv67h+yhJOUGF4OH1DBDXPFIw9zAMH4ep+tR6CGNi5dK4s7kALZD1noN++NGGl
bLYCJXqdAL1o1jkiVG5Qteen4FtX1a5YI88zsnu5AMu2GyxhVmX8XWaPh2+T/vT3
hgaMb0VsNH3pixhDMAU9IFwbP7QT+vugNI+B7QtwHvOXB3f2CrsxghmmZInSoKTn
acOa8TNrie14G7F3jEdtqXHk
=j9s7
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Manos Pitsidianakis (6):
      virtio-snd: convert virtio_error to error_report
      virtio-snd: add pcm_state_to_str()
      virtio-snd: reject invalid feats in set_pcm_params
      virtio-snd: don't allocate pcm_info zero-count buf
      virtio-snd: cap maximum buffer_bytes to half a GiB
      virtio-snd: period_bytes divides buffer_bytes

 hw/audio/virtio-snd.c | 91 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 80 insertions(+), 11 deletions(-)

