Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2C9C531DE
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 23:38:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seNY4-0001fL-Vc; Wed, 14 Aug 2024 19:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seNY2-0001cK-Gg
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 19:36:58 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seNY0-0006Vn-Jl
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 19:36:58 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-710dc3015bfso273251b3a.0
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 16:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723678614; x=1724283414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IGS4bdB+9eTz8vEajfbjLybPSF9As7459mfj2MYdVLM=;
 b=U/VEeuU4kqeH3Uo1QavS0a3UtqFvyF+3BPyRpdA3667GnkbL9HWYCll4IxxgB01/NB
 DQaEaugOfWqQXf4zNYB6DsOHY4qPXqdqbBYP/mVEUueRYtPPh4oT5fSO8O2X5oQeniy3
 +snXcnMKfrwViDU83fAKHlOkLFp8Uwag8YW2GQ+4YEaCNnrJ4e8ARNnHKwAxB39QSfNZ
 Yab/aejCXDGW1rG/xpC4ShL3Cw23awvOBjE3md03i81TnHEb0sb1KHOCYCVZQ8VTvsva
 k8RX/tsytHIKnHVnlU3G9DqyEIgkUDKN8PeQNGYj6ZkNq9kqdk97XT3GUgNS1sQ45jIJ
 le7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723678614; x=1724283414;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IGS4bdB+9eTz8vEajfbjLybPSF9As7459mfj2MYdVLM=;
 b=A6Y2SYxBmcGi1d/i4+3I4WJnXgRJtoa/UO/g7BH34GYZx8kVkmzKC7uBc/MGpZWpjQ
 2HEhFfi94+pnTUpep5QCosmmDf5s3j3JIDACwfElTl0NA4b/zIqjE+KXVM/Q9dy694nS
 f1sOac+R9ajS9PLFTWhR8ZwqFL3KMmhY7BEYt4tsRahk3/BKW4FHncFVLSt7AjRo8EJt
 mxx0ARsMPtuley62LQZN6F7sVBQn5JAzg3TPu0GgDfM9cJb9ceTk2eU+e3IZCt644kNi
 yEI2q/By5CXXim963cAESjjU4otQR1nOcRih8Owt9p2Jocz/mX9Tj6v+2bEJxiz//Tdz
 9FUg==
X-Gm-Message-State: AOJu0YxQNqMAuIkjwBl1BDYJ9X4vsJuW7YhDrHUBwYweKJVK/gBvj5xz
 wwTwSPK4Na+ZnnZhRJ0lGPk38FlTgt6pCqtfgquvsoBHTu/OtMW9esXl8RddvDzDSHa4eE8JhFU
 prhg=
X-Google-Smtp-Source: AGHT+IH7wecuekXYjvlhhCkSj2GHQkSQ7yLoM80iPnOzvTYZB78x4u0hbyvDI9YVJ32U6JgY4ZB6PQ==
X-Received: by 2002:a05:6a00:6f14:b0:70d:2e89:de2b with SMTP id
 d2e1a72fcca58-71276efcab5mr2243861b3a.4.1723678614548; 
 Wed, 14 Aug 2024 16:36:54 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127aef57dfsm112164b3a.115.2024.08.14.16.36.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 16:36:54 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/6] build contrib/plugins using meson
Date: Wed, 14 Aug 2024 16:36:39 -0700
Message-Id: <20240814233645.944327-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

Contrib plugins have been built out of tree so far, thanks to a Makefile.
However, it is quite inconvenient for maintenance, as we may break them,
especially for specific architectures.

First patches are fixing warnings for existing plugins, then we add meson
support, and finally, we remove Makefile for contrib/plugins.

Based on the proposal of Anton Kochkov on associated gitlab issue.
Solves: https://gitlab.com/qemu-project/qemu/-/issues/1710

Pierrick Bouvier (6):
  contrib/plugins/execlog: fix warning
  contrib/plugins/cache: fix warning when compiling on 32bits host
  contrib/plugins/hwprofile: fix warning when compiling on 32bits host
  contrib/plugins/hotblocks: fix warning when compiling on 32bits host
  meson: build contrib/plugins with meson
  contrib/plugins: remove Makefile for contrib/plugins

 configure                   | 18 --------
 Makefile                    | 10 -----
 meson.build                 |  4 ++
 contrib/plugins/cache.c     |  6 +--
 contrib/plugins/execlog.c   |  4 +-
 contrib/plugins/hotblocks.c |  4 +-
 contrib/plugins/hwprofile.c |  9 ++--
 contrib/plugins/Makefile    | 85 -------------------------------------
 contrib/plugins/meson.build | 23 ++++++++++
 9 files changed, 39 insertions(+), 124 deletions(-)
 delete mode 100644 contrib/plugins/Makefile
 create mode 100644 contrib/plugins/meson.build

-- 
2.39.2


