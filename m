Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE6A3C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 17:51:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbNpg-0002CP-IL; Fri, 24 Jan 2025 12:51:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbNpa-00029d-G0
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:50:59 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbNpY-0004RB-U4
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:50:58 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-38634c35129so2127854f8f.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 09:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737741055; x=1738345855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lF5hqMSJTCIx7rTk7yIx1IdPJjb0y4n+2mCwilvQc40=;
 b=M7loR5KzV9lymj+sMOLSrCLnUiZbr0puT5z+8qBzGfkPNVI4R2GQ9LFwRulHwe9Yze
 jkF9q4fKAfwknKsJ69xGoSTLBAGd3HpWZfRXI/K7Ol+4HlzB2ZZl0TofsEaJcj2CJSKL
 dPnKFB2P5VhExyOr5fJiSV8e1fud7QqGWNT4my91LsqRi6/mOjX393kOvIfCksfHnYPA
 EOAjoC1F0AsCchsk1rZE0mfZrNBdiWtcKGVsrFDoHp7MFoJVyIAAD4XkA/hOp7QjAtcT
 1GWAzznvlji1Eeg6JVH0uc5U19GbrfluaoMd8/uSfOHtGmhNvpQK6o8e6ZGf3YsnRt0M
 v8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737741055; x=1738345855;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lF5hqMSJTCIx7rTk7yIx1IdPJjb0y4n+2mCwilvQc40=;
 b=MLSV35AVVra+8mD+385RGA6Vj1b/kj2RpNEMV18ilnKyIpTKSbpBWZDoqSXfmKDztJ
 EhsZz8Hkp7HHXiq7Xr1RBup1D1FeMOWpPoKMrGpinBBsEr6OMol5hAZyHBKTNr7S263l
 4PrtnPW/YAaJcQi3Vx5x0ORYM4GyXCIm17ALoc+jFrrRXHHLi7CW+DtfSy6eq80Q51Z1
 OJz3BTMQFQU9exaZX8fT/91itCWvEfS/z12a3A0GEWlDtGzfUg67pdVohJIh+3moMViB
 dI6HkKuz3n7g/wpOswKTdrbS7RjWFz1Y2r1Iym/kwyePOep9AsqZE4pcGpeskB4do/Xi
 qlNA==
X-Gm-Message-State: AOJu0Yy2i9DMIzHNwB6fhKxyyBRvAcVCJPM57CDKvom1gnfijjxkqp8z
 Gkc+6oIoSew0cZ5+8oEHHw3+k5gvwWHGJCu9VWWlxub1qp/a2Mm1cyLnYVhxcQvp8+QqKwijRTP
 J3hk=
X-Gm-Gg: ASbGncvSQnawaiBke3C5a/BCol6I6QL0a6LFqAZBPpTf1pCrM8U2X3ZX8bdd4bXxaPb
 jybYVA5JwK0b2scuTxapCjdXaIDaeG27H6nNTy9URjqj9CULL+bCxqf3iC1Nx2nztvfdZuGUU0a
 xJ3D0hgARGoGYwRWEnfpz9OcKxNJ5G9guJS67YGaq5830OweDa+at7a+rK65D7alSKZYjoevmrW
 6EB0FpfdKxrSMebt1X5HFf30fX+SW01ANb03i9Eg80YP9XYu7ZmxK386Gu3m+cWKvXnzqV4dqnD
 DzpSnJ82XWR4PAXJiihjis0Su4HXZqlQq21SrIc/KU5SLoO8l4hz758=
X-Google-Smtp-Source: AGHT+IEfBi3tvvPMZ3Tjxv8Vqe+ppbkK5nj+di8BAXELeC4dSWrtWSK4SoDPnwLPNXU41atPTczAkA==
X-Received: by 2002:a05:6000:402a:b0:386:3327:9d07 with SMTP id
 ffacd0b85a97d-38bf59ef829mr31301079f8f.54.1737741054716; 
 Fri, 24 Jan 2025 09:50:54 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a17d5easm3287184f8f.25.2025.01.24.09.50.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Jan 2025 09:50:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] hw/char/sh_serial: QOM housekeeping
Date: Fri, 24 Jan 2025 18:50:51 +0100
Message-ID: <20250124175053.74461-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

- Parity in realize / unrealize
- Define TypeInfo structure

Philippe Mathieu-Daudé (2):
  hw/char/sh_serial: Delete fifo_timeout_timer in DeviceUnrealize
  hw/char/sh_serial: Convert to TypeInfo

 hw/char/sh_serial.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

-- 
2.47.1


