Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 393C8C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 14:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raFrt-0003iM-Q3; Wed, 14 Feb 2024 09:04:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1raFrs-0003hW-Lt
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 09:04:08 -0500
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1raFrq-00079U-Qv
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 09:04:08 -0500
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-595aa5b1fe0so3489649eaf.2
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 06:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707919445; x=1708524245;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ewbbNpJvWYpI7U47AiryhUST1NbMBhVBsPoNDU/buUs=;
 b=SnZbqr8lSkRSWimH9YwH9NKjXmmCjRcgoTmid8Ce1njx3KRxKRI4Wr0J4LEcG3W/Mb
 PRy6P9YMEE5XzMy0i+z5NZORfyi1LUVN9Mbw3dPpciQ1Om6Sh+QBdby133U/vDfR6X0e
 3FEo/sRfOnXNBQLbt+x5+PVOhcoGnrNeeR78gb0D/SQyUa4oU7L3A6WKZ0SH19cyYPUt
 GbZY9G9QGcUDr2zO0CeYmP75j/11wT6xeEznXMMf3vAQ7O/n0MKl+jpk2o7Wr8hDsVCm
 eKlcKnkR9YXMgAXTaF77HfaS2J7pwavmWtniJqcXM3sVnCsK9C3Td/oCGfaK7P81tS/E
 n48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707919445; x=1708524245;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ewbbNpJvWYpI7U47AiryhUST1NbMBhVBsPoNDU/buUs=;
 b=BQxNYHjIifFhHMQFDZCq33gxD6OSzGFECoydxq5NyIUlx1wNfQQXMMQ8Ooadk+ZhDj
 Z06+rWDJ2ovrxSB4EraEX3P6VJ/LtUEIFCd1ELdlnDo8C5QS19j3rDlK2Q3xBMPxGkYu
 bpv/HgWrntSI23kdfCtDnoVd3ftRA+S1zCS8DjLcmMi04hGCLcWY6ULmoywGrVamDJGf
 SplQBE8agDbqAWBPgDSHnMcFYN9df+pa5H6Dnu85k/MVctKRxKTU6E/ZhhJMu4gFo1i5
 WdM8LO++Dq2Ck2O1x3lq+SpHGj7i9WDi9Vd7rF3N5Jb6RiMNxEyooPqZdfU0f2vxsZOc
 evVg==
X-Gm-Message-State: AOJu0YxQwG5tCXE1UalP3vXBkxToZ6yjwaBPPKvHyl6KMrsUltmIPESk
 UJvpDf2nj2Huzg8gl+AQNt9zTvBnN4pWkebYeJipaAmdVmTZ2XZmm0b787vPF/M=
X-Google-Smtp-Source: AGHT+IH5ct0bULueqigHeo/nmGa6BHtMjWUWrg/CJhbVQQVyBy8TfmNNicthPJduejHlwbs3XNvSMw==
X-Received: by 2002:a05:6358:620c:b0:178:f482:6e50 with SMTP id
 a12-20020a056358620c00b00178f4826e50mr3088239rwh.11.1707919445109; 
 Wed, 14 Feb 2024 06:04:05 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXq73PttMaurUWwJVpgdUMbw4UUrVKBV3ATzEvsAHRLatUcA9OgkjCpnCCs4f7oFye9gNC5rM4nWOv6dOBiCGKPxdZGdbwvsAMZ6s+FeU3MaEVDSUD7VIaKIw5vldu9LiE3LuFDC+vnpaoKXEdRe/0CiCzfaOizJiiWLYX+OnqHfdF7arb6zE9a7P+LMUFkHoRXrXRuu/cqcu+ceACM8X32+veXVm4Uzkf26MJFhXjpAyeQg4n5FsZxKBlF+Glp
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 x190-20020a6363c7000000b005dc9ab425c2sm1041244pgb.35.2024.02.14.06.04.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Feb 2024 06:04:04 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v7 0/3] meson: Fixes for dbus modules
Date: Wed, 14 Feb 2024 23:03:55 +0900
Message-Id: <20240214-dbus-v7-0-7eff29f04c34@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEvIzGUC/23Py2rDMBAF0F8JWldFMxq9uup/hCz0GDda1A52a
 xKC/71KcCGts7zDnAv3KiYeK0/ibXcVI891qkPfgnvZiXyM/QfLWloWqFADgpElfU/SW+8s5+S
 SCqK9nkbu6vlesz+0fKzT1zBe7q0z3K7/CmaQSmoKrEyI2SR8L/HS1/NrHj7FrWHGZwqbAka2M
 SoEMBulH5VdlW4qUcqJi9OO4kbRo3KroqaoK4ZApU5Rt1HmmTJNeUBkjxh12O6yv4raAlqVlSA
 JIHaYAvrAf9SyLD9GJ6Y2pwEAAA==
To: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::c30;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc30.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

I found it was failing to build dbus modules when --enable-dbus so here
are fixes.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v7:
- Reverted to v2.
- Dropped patch "Move dbus-display1 out of ui".
- Rebased.
- Link to v6: https://lore.kernel.org/r/20240214-dbus-v6-1-411af2b9289e@daynix.com

Changes in v6:
- Dropped patch "audio: Do not include ui/dbus.h" (Marc-André Lureau).
- Rebased.
- Link to v5: https://lore.kernel.org/r/20231217-dbus-v5-0-8122e822a392@daynix.com

Changes in v5:
- Fixed docs/interop/dbus-display.rst.
- Link to v4: https://lore.kernel.org/r/20231217-dbus-v4-0-4fd5410bf04f@daynix.com

Changes in v4:
- Moved dbus_display1 to util.
- Link to v3: https://lore.kernel.org/r/20231216-dbus-v3-0-b4bcbed7374a@daynix.com

Changes in v3:
- Merged dbus_display1_lib into libqemuutil.
- Added patch "audio: Do not include ui/dbus.h".
- Link to v2: https://lore.kernel.org/r/20231215-dbus-v2-0-1e2e6aa02115@daynix.com

Changes in v2:
- Updated MAINTAINERS.
- Link to v1: https://lore.kernel.org/r/20231215-dbus-v1-0-349e059ac5b2@daynix.com

---
Akihiko Odaki (3):
      audio: Depend on dbus_display1_dep
      meson: Explicitly specify dbus-display1.h dependency
      tests/qtest: Depend on dbus_display1_dep

 audio/meson.build       | 3 ++-
 tests/qtest/meson.build | 2 +-
 ui/meson.build          | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)
---
base-commit: 5005aed8a7e728d028efb40e243ecfc2b4f3df3a
change-id: 20231215-dbus-86876ecb7b09

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


