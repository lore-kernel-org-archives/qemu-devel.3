Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F88CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 10:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru98j-0001MW-4R; Tue, 09 Apr 2024 06:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ru98i-0001MM-3E
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 06:55:44 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ru98g-00034R-GN
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 06:55:43 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a51fc011e8fso51801666b.0
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 03:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712660140; x=1713264940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TTVu/2e2x7Cz/F9RoNtxdxAm3oz3O3QucZR+rExoGSU=;
 b=Cetv9B9fiyd2BKkVxcKLLTNbiNncSN4dw7JsTzUfMA5KBzc6dsMm6ye4yM4HEUP8TX
 RzYqnijpVMq3CYBzNyWL7WdsUzKxG+DUq+TE90H13hGJjFKTDMmK1ysGXUvybQybd/xi
 z60VyRXoq6rQXmMup7Mzr3q2pZeoBFed8kgoenTp/D/pbBuuD1rW+fvfCsNfheQpJWVv
 dIFApj7zLNQ2qRE/oO7evUkPfzo2x0d2h60ysi/YgUX9EotS20OU1xoUElrzEg4xE/C/
 ZNDcwkwRs7gcJ6+KoqwNrl+7Gyz0OBtekkm1GbsP039qM4FSh1MlAwOz+8tskaTYPy6L
 r6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712660140; x=1713264940;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TTVu/2e2x7Cz/F9RoNtxdxAm3oz3O3QucZR+rExoGSU=;
 b=BWx1AIUs3Wkr3cyGn0bs5TnMkUQxwYG/FTlqhBvERKlhWTx7rJJm4qTDg8j8/xYB9D
 7DR5QhCZZ1midql2RTnJz1KDKb0y//ZG6B3kGFBd4YX6bS09Wf/a0vgLaiQGue8KlzP5
 Jdlg5qWz7CUI9W+Q6MuOvKlzlQ8ji5pon+hvKUcBdAK+EeqEoYOrhCuL5fJaBDjogTqi
 MNxPGY0K5kFXxGnXVXc4bR1PagYI8ObIm6S0keQ7Otum3X0uFrDcCOczpH3zPBNxiQ3Q
 b8Bg5VsuKpIQbc9KUvYsIGzR90cov/D+yjVGliSdlcpotRxO8KtkAClB34+b4AumPm8O
 RBDQ==
X-Gm-Message-State: AOJu0YycgouAvE8R6d6ac1dyUAHjQjqgAeLWJeDYdhwdapV8AI2VYeUw
 4qjxWrI8t9JJSfwR3O3CFmJUa52ji6JaNRU0pnxdMUZHw+grGrVvxfkXvtdY8uqK3kmIRhAOjwQ
 7
X-Google-Smtp-Source: AGHT+IE6niMzj5kMsFnbMVhCPvUCaHNOD4o79++C0ohnhb1jrEzjs/QXKmd/PaXTKw3AwvSV4AJVJA==
X-Received: by 2002:a17:907:2d09:b0:a51:d463:32c0 with SMTP id
 gs9-20020a1709072d0900b00a51d46332c0mr5423399ejc.57.1712660140487; 
 Tue, 09 Apr 2024 03:55:40 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.160.134])
 by smtp.gmail.com with ESMTPSA id
 sa2-20020a1709076d0200b00a474ef94fddsm5540435ejc.70.2024.04.09.03.55.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Apr 2024 03:55:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Amit Shah <amit@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 v2 0/4] hw/virtio: Protect from more DMA re-entrancy
 bugs
Date: Tue,  9 Apr 2024 12:55:33 +0200
Message-ID: <20240409105537.18308-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

Fixes for CVE-2024-3446.

Gerd suggested to use the transport guard to protect the
device from DMA re-entrancy abuses.

Since v1:
- Take a DeviceState argument, not VirtIODevice, so it
  works seamlessly with CCW devices (actually the original
  code from Gerd).
- Build and test :>

I'll send a PR with these patches later today.

Regards,

Phil.

Philippe Mathieu-Daudé (4):
  hw/virtio: Introduce virtio_bh_new_guarded() helper
  hw/display/virtio-gpu: Protect from DMA re-entrancy bugs
  hw/char/virtio-serial-bus: Protect from DMA re-entrancy bugs
  hw/virtio/virtio-crypto: Protect from DMA re-entrancy bugs

 include/hw/virtio/virtio.h  |  7 +++++++
 hw/char/virtio-serial-bus.c |  3 +--
 hw/display/virtio-gpu.c     |  6 ++----
 hw/virtio/virtio-crypto.c   |  4 ++--
 hw/virtio/virtio.c          | 10 ++++++++++
 5 files changed, 22 insertions(+), 8 deletions(-)

-- 
2.41.0


