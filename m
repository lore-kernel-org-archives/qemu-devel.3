Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82DAAC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 20:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufOzG-00065n-E1; Fri, 25 Jul 2025 16:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ufOu1-0007c4-9F
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 16:20:26 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ufOtz-0001EE-OZ
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 16:20:25 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-748feca4a61so1640178b3a.3
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 13:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753474822; x=1754079622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hOER9uQB2Y/m84Ohnetnwb9O8q4b7cP6gnngP22thpE=;
 b=WrOqKEQsoUV1ju7MdP81P5T0JvY5hyPRwmbixeAAzA3oigqNLnsVUOjI8SFFfNGnaG
 96Q4wu5imZxVkv8O81p6UWApPakI+lWnbYDKfZKvplRnS/9J+TZ6LJ2XG3jFHNjF7HVN
 qdpfYR4UVYSsS3jRLZ3s4WWFZ+7f6xtJjYhSGgKmzf7z2f1Qrv2WCmKzjQCU5z87bxhh
 dk33wPrJgxMdZ4NcLdX3QhO2QRKkFE+aQm6+FcxnbswQdIRJ0FNm4K9zfF8aReogOoou
 2CjKJAE44ngEntaepKNik/6dhP35mnblhOfTh9QxMhHU1sd2a3zPQZzpoXyU/u8CwT61
 vQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753474822; x=1754079622;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hOER9uQB2Y/m84Ohnetnwb9O8q4b7cP6gnngP22thpE=;
 b=ZJIV3GptGBm9BwstCXh29Lx6CKdPRIl2Z7NUQVa/7fXERnLDObz+E1mSg6g6yzV7qB
 FER4kuyzwmS10gxhuB35tBsFx2N8kQqtd+pf+nNWbcJa1zXThNTkh8liytKOsBAb71mS
 GQBwwne8r10QaCh9oBgc/OkHzjHXM0qJPms1X5nJKFk0wWrIopp3yOAlFmA09Uujmp0v
 0/W2U1cHt7p/M0kkFJoWA/gkNmBw9AkjTbXym5llF5xs1SQX4owjHUKR4Q5R1WtFBbLL
 QZNQV05tU5l/wKy45I8Ej61vmnuu8ffHQ8W27owglu6AuKe3bATGOekYE06PGVsM8aB9
 R32Q==
X-Gm-Message-State: AOJu0YzOKGm+s5kXIG0RtFniwq3FUPxWgBmedZruyLOVvA1t2jqfC8u/
 X4fqzfzYJkuhzYHoeRTRe1Oa7IAcZbk8ba/7nf2fy/TclVpOwsJF/CwGT6teUNydrX8hVCUPNlc
 EAokq
X-Gm-Gg: ASbGncutmw+ZA4O16E3+TEdnjpwhx9I+kXWAhizUM7KsZ5obhqD20D/jebyw9adgTIl
 l25NIvb5QRi64xyE/HSwN/ki6H4/Q86DyTJy0C4iCDUAe8j1J5fx1BgCK1rP7MF/S53pse+6FRP
 Kp+8qCmEUFhhLwjoNiFL8PXqORR3Iitl489a6AJ2F9panR86EHV8lVVkGB4mARSBOkUS6pXb23C
 GUkV8mwuTg/J7gUP0guQ7VADMNva+3HhcbDqFlb6p8UZXmY98tTWtdZaV5msELca6xyJz/DI7eN
 4E0j+J639sLENB5lUZFCDDOgP/Fcf0Ow6lRrP7nzXhbBodGQrOHXPw3rFJHynGlQY2nCSwZZxRt
 waMTjgkSHMHjrutBaN4MeSKtA+AL4i6Fn
X-Google-Smtp-Source: AGHT+IG7erzKRzzM8iGbSNEmGRixz2X+JA84NDND9NupgR6d6laIB5ANa1J3p/92pcCLy65jzYFaqQ==
X-Received: by 2002:a05:6a00:92a8:b0:748:f1ba:9b0d with SMTP id
 d2e1a72fcca58-7633582ff95mr4534504b3a.11.1753474822170; 
 Fri, 25 Jul 2025 13:20:22 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640882071dsm360925b3a.16.2025.07.25.13.20.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 13:20:21 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 0/3] single-binary: compile some top level files once
Date: Fri, 25 Jul 2025 13:20:13 -0700
Message-ID: <20250725202016.21325-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

Pierrick Bouvier (3):
  cpu-target: build compilation unit once for user/system
  include/exec/target_page.h: move page-target.c to header
  system/main.c: compile only once

 meson.build                | 10 +++++-----
 include/exec/target_page.h | 11 ++++++++++-
 cpu-target.c               |  5 -----
 page-target.c              | 10 ----------
 target-info-stub.c         |  4 ++++
 system/meson.build         |  1 +
 6 files changed, 20 insertions(+), 21 deletions(-)

-- 
2.47.2


