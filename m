Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD366F4368D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 11:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDh1L-0008OE-IK; Fri, 17 Apr 2026 07:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDh1H-0008Ny-Nj
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 07:05:56 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDh1G-0003gq-5v
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 07:05:55 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so8715525e9.2
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 04:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776423952; x=1777028752; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YZ1G3tn/TSsrAgUlaQvGIMTS+scW3QBkKoEUV6q8PYY=;
 b=HUHAlCmUu8l+NbddQEjluPFpxjhqrp31kw2GrtLZ5xtBrBIzbLxoEutqIzRWftXh9O
 f2hyiO1o++C0l840/BZPRksYzY2ClPT1weG9BqpnaXtFUaHe2CKI084rgL3gYUBZCc98
 yJniVfLSGvbQdy92a1iX5YtmbwwUoEdxXO38pngGN7KaoJINhpzlLzT4+rgOJVUOx0FC
 7h7fen4mMnTs8K72Tr4hWKdSxZm+WwNAZLGn3LcauZ9Tn/LTc8jR4Hvs9ItnYHZgsMF2
 uHFuuocY9oQ4N5DCokF5XfeF0Uj1rw8NIcCnx0/om5utVUQFPCdAAATxHJJSzBpX7xrb
 Ax/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776423952; x=1777028752;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YZ1G3tn/TSsrAgUlaQvGIMTS+scW3QBkKoEUV6q8PYY=;
 b=hr8C2lMK/L1IDG/ZrA5GxUj7T+AlF13KBwueY/pmLfrk+b49P/B8vKFKFfwcbyF5h8
 LJbvzrTGhEp3QUyv+tlx2Y9JPvdH1YhmwTAuYeNuqok1WbcGVeUG80IeeUObwVBcb5u6
 OWpPJMZReF+Ojhwj+gPZI6h2EdnUAuARXPB8g/dARtymh0dA2a3A8uByushOBN+p4ssW
 1Tys3u/095y5eZE5/ggO+KqHN4OYT+1SVQT425BQKusE2oisGc6ToujopI4oHKhCQ6fy
 RNl8V6zS4JiPQdKLC/LAxHZGSLUVy3fAIABIosbR0aZ5RykBF5DY+sv+BitxiMLFkecx
 rz/g==
X-Gm-Message-State: AOJu0YzI/CFXqmxMkoLHKbX/gYrf7dlbXP0QJFja+diPtq9L5/L5+epR
 kVqskbj1+N21382hgqEulf4fmABrHXzSGVYA/vaPQ/N0fHK0jieLLIzvGyZI/AsWZIQ17tcQHFE
 MANjR5ak=
X-Gm-Gg: AeBDietnt9wr+vxT4Z01rQT627qZzFXbuwfeWsneRWD/f7uxgGbIPXSEGk2TiNzC+BC
 gXk9SyGJXdWutNtFi7D2GNo7ZP7gM5Hyg2TWIX5/OBgvfs3h4t0Bt0kQYRngxJ+U1VlLWXPCKO6
 zyRuGFYAOf0+flTeBXIdFpYCWDDk9qLTp5yXbQ5utJtHCWcbU7LdCcPM199NTFo6ni5R70jCMbt
 +NpHYCgbs9eqybHiRmYSuaWtFblrFUuTua5UknFczp41nQSRGcosV1Pjmx8LMm2Ocig7GXNIGtL
 1enKhrqgGpaEINmSQnoo7ljez/Px6F5zvQTAZ7ZQY3xsODlMOZFEI013Pfk9tGM+hSP2hWUsuqY
 z/Wp/0Qs003kPAJWctWl7uJfoDY81PNIB1mtpm6bBawvrvgnXTwDpWrb9JXe0BNbrmRws63Hc/y
 VoVASWEji3QbqNZRtMolSVIYRAHl/VGH+3oaII2Cgk9HeRoAjS9hXC4oyoR1Oy6HRuEAjkrLSwe
 Y8praXjD3zq1xQJhi8SJw==
X-Received: by 2002:a05:600c:1da1:b0:488:f453:b976 with SMTP id
 5b1f17b1804b1-488fb7844c5mr35784415e9.27.1776423952238; 
 Fri, 17 Apr 2026 04:05:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4ffa8sm3567782f8f.35.2026.04.17.04.05.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 Apr 2026 04:05:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/7] MAINTAINERS: Update PhilMD entries
Date: Fri, 17 Apr 2026 13:05:42 +0200
Message-ID: <20260417110550.70068-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Based-on: <20260416091654.316158-1-peter.maydell@linaro.org>

Philippe Mathieu-Daudé (7):
  MAINTAINERS: Maintain MIPS Boston
  MAINTAINERS: Step up to maintain core machine code
  MAINTAINERS: Merge PCIe DOE section within SPDM
  MAINTAINERS: Cover hexloader tests under the Generic Loader section
  MAINTAINERS: Remove PhilMD from firmware sections
  MAINTAINERS: Remove PhilMD from NVMe Block Driver
  MAINTAINERS: Transfer CI maintenance to Pierrick

 MAINTAINERS | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

-- 
2.53.0


