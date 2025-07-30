Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97EE7C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 22:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhEvp-0008Ly-0A; Wed, 30 Jul 2025 18:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhEvQ-0007v9-QW
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 18:05:28 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhEvO-0002Hu-Uf
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 18:05:28 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2403df11a2aso2865365ad.0
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 15:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753913125; x=1754517925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=d9+qLmeNG4+Z9G+xCVn3OMjo9YBWLWMDMQDUhPhczf0=;
 b=I72tqQ6igyILLqFYPekoOPhAfj4ectOmVu1Jcnh07STxBjwpdQVUdtTD+qcKh0ZRP+
 9ujQIUP0yN0wVP5N0dBHmfkhDohXrGjfp2lcNreKQTpOdOhLCQmoLW52iI/pgvjx5Das
 qW2fHbdVFQ9WE37ddVArmC5MBJFZShXhJLNQdwRZOLBEXUswimYD/OHLtdMai4I3v1Wo
 lcSvAGbgZNn50hWaZLFMQC3Gms4jke5G4z3LXfmB8brTXX8bZrUD6Z2SgsUiovzn99S+
 cHPryu3XKvzJwlUVjMmS1Y2sI346EgR39iNjKb82KsciPViJsqTC5lzK7sUdDiikJ66/
 84aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753913125; x=1754517925;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d9+qLmeNG4+Z9G+xCVn3OMjo9YBWLWMDMQDUhPhczf0=;
 b=JMl3x5IT3cT9SgZhEo1PyBWBodlTRzLrVB9dvAqGbiXF6rhdLBF1pazamfgg0MsqON
 lgzCt9j3tG2eHfr+1Uqob5LtMv8OGWEBOj+BygqNNVKc0+dFSJistHJOlubWqOZitTvs
 4TEVTnbLNY/iIwkrLsjetGKK7BgD4ECYFyQBFE7h52HP44rIP0H9uhmCYFifVTkEIvb3
 2KsyLuUWoLpt+rtCKrf0I1o5+52dOo6Idmtf/K14+lGpyD5JvJwu5i3kK+Xg0f++itla
 4XphuNEAMfXvgqyesAL7typBrTcOPpLh5rebAXYTeHGSWHssyx3+H2Y0IAFor7ctT2dc
 XPQQ==
X-Gm-Message-State: AOJu0YyDYdxJR2AzwfP9gWyT3bVV6o8pe9lQZ5t6UC4v00w2D3IFuuoS
 gh2Wa9Ry/DhxIVA0MopE3w2RNBvCz5KwiNZov4+UTRpqapJvzokEHfVCNqoCjfqnbahIOb0dHQq
 1fspZ
X-Gm-Gg: ASbGncsp32ACv3sar5bWXbBtDVH5u6vJogAe0Rb7zsk9QgeAM5FDVejYuErLlAgxcb6
 CvPn3TWVDPwYd4eiA07y/gyWxgUfebckDWcCLhdBucoKrGv7TVzgYHtYBARxtiLL4x4b/FfiNR9
 nWn2x3tL0YaVh7wy8hko0vVW8y+J3qFDWCPuxRR2zsoWQhQZRmtXH0o+0pS3rzRTBwPkjk66+Fy
 +OsXcZYh0vsOHU8GH00XAvwiNQnTk8HWuk3Sch7LL+EYgVME2SuOO/vQntXCF10m70JzIvvPOBm
 /toUCAw+3JWuaUgHDD7HYEAg0rz+/pj2wPKhIMKFXxrEDEQIBIg99AuDV7Lff69eul7UyHPCpP4
 HFW1hqC2ZmZAFd54wfBaUCw==
X-Google-Smtp-Source: AGHT+IFPTzsIS9cTLn2THNaxzuAyKJnhaFyWT2OiIOqth2yQH9INsm4cu/6Ijv4WPjk+k3Rls4Tdsw==
X-Received: by 2002:a17:902:d550:b0:240:a559:be6a with SMTP id
 d9443c01a7336-240a559c379mr47672595ad.34.1753913125424; 
 Wed, 30 Jul 2025 15:05:25 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241afb7037asm1266325ad.0.2025.07.30.15.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jul 2025 15:05:25 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 0/3] single-binary: compile some top level files once
Date: Wed, 30 Jul 2025 15:05:16 -0700
Message-ID: <20250730220519.1140447-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

We still have some files left on top files that are compiled per target. Start
with the ones included in this series.

v2
--

- rebase cleanly on top of master
- remove empty page-target.c file

Pierrick Bouvier (3):
  cpu-target: build compilation unit once for user/system
  include/exec/target_page.h: move page-target.c to header
  system/main.c: compile only once

 meson.build                |  9 +++++----
 include/exec/target_page.h | 11 ++++++++++-
 cpu-target.c               |  5 -----
 page-target.c              | 21 ---------------------
 target-info-stub.c         |  4 ++++
 system/meson.build         |  1 +
 6 files changed, 20 insertions(+), 31 deletions(-)
 delete mode 100644 page-target.c

-- 
2.47.2


