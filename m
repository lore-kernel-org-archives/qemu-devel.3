Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCCE5E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 20:35:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWLhy-0000Va-0F; Fri, 10 Jan 2025 15:34:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tWLhv-0000VA-HN
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 15:34:15 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tWLht-0005eu-JP
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 15:34:15 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2163dc5155fso45108685ad.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 12:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736541251; x=1737146051; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2wVgW4ZcjXo//dfpFkDwXhNPgQ5kohxBC90Lc3HtqlM=;
 b=WPtdoOJ8vEaKI1gYluPw508TM+vDJf3ZtIMUDDomfjDtKunlS20ApIJhOUySk6vF+Z
 4qWOV3+mnPaZVqJy2Ge9ABPH/M36uPoFW5k9bjHyTOlhIGyRGffmXF1D0gUSJxohAJdE
 C+b3/T2Ojhj0DmlAasCh2NrDNRDKt916qxj227a9RjsyshPp+LRci2cefm7JeAjrQHr5
 OiddSwqBUKcTIarBTMHaMvL6bBF3fnUumwH9hUNQKCm0e0bE7FvEVk6Aw+WDb+mtj7LV
 DrNWvfub3Uw/DXqYaB7gvJ7D7Wl7G0bMqW7osoXvM4Xn7uc4cMEJSdQoi5KvRz17IJYe
 /Ssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736541251; x=1737146051;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2wVgW4ZcjXo//dfpFkDwXhNPgQ5kohxBC90Lc3HtqlM=;
 b=lxaye9hy2zrtrmfpmDTZb7eGnKRwYz1/HIdjlyqFFlkiAy+3vEA9ya8U4l60+HIOyy
 nOq2YPaqQAnxMATxn5VLQrsHJvqHjAkgHfCLROe1vji4z0jG8Xs+ESXDLHDGdcLi6Vps
 dKv+z7i98a5lklhfZ3F4D6mrHZQU/MJuA+mVen68QsfkNbwn8ylapiDiVRC+D10/xy37
 bLttum0xXe0Aiy7ZfJrzKnpHLaQj6wwxxcEzDRv+FV1LypkHmc3k82JewQPpDwxUvcsG
 caWeCNplqeuvhlJciAnsLTxBUuqarN5nwmafms57PZ5AZh/0utHl34L/jE51WZfdns1X
 Fr9Q==
X-Gm-Message-State: AOJu0Yzsj7ZnwEK6Rr7ZOyXHUUdbbYjFoO37KA6inyKx/hUZRVoBK7Vi
 eICs99FkTfPywM9fDMKWi2I/FGVjunaibevMaRJs8+hlIHfOM7KQk5e6hq/AYRNuV/eDsoND16r
 bZfaGnA==
X-Gm-Gg: ASbGncvWCRMKir1yiwtgNKc91RcCvsFM4+dTMluaLog1no4ZRyNue/S8cO/3jkbxj4C
 ZSAQ8EudUH5y4pRzaaUgKhYDj3kb0oJTPi7zeKCQ8xYKOPiydfrwZajxikegEjkXqgHvqRTb4Iv
 Zvp+v40OAiX3A15TOdEtDOz1bvkUAQ9Ga54KVm7n6pRNiEzU7/5UXXWUWermW08GE5ABf05XbDJ
 tQnThcXVlXFV4PL16hT/wft77OwxbQtzkO09P80kOXMssa5kjQ8goeF
X-Google-Smtp-Source: AGHT+IHt/N96ONU+tuD4v1CyV6IsUw5hqBxvISJ9e8V+PruZaazdORiMlqQABvRyR5v1MhWLSBK+5A==
X-Received: by 2002:a05:6a21:3a87:b0:1e0:c56f:7daf with SMTP id
 adf61e73a8af0-1e88cf7f7bdmr19435304637.6.1736541251316; 
 Fri, 10 Jan 2025 12:34:11 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-a318e8ecacfsm3215947a12.38.2025.01.10.12.34.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 12:34:10 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v4 0/3] Enable clang build on Windows
Date: Fri, 10 Jan 2025 12:33:58 -0800
Message-Id: <20250110203401.178532-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

For now, it was only possible to build plugins using GCC on Windows. However,
windows-aarch64 only supports Clang.
This biggest roadblock was to get rid of gcc_struct attribute, which is not
supported by Clang. After investigation, we proved it was safe to drop it.

Built and tested on Windows (all msys env)/Linux/MacOS for x86_64 and aarch64
hosts.

v1 contained warning fixes and various bits that have been upstreamed already.
The only bits left in this series are the gcc_struct removal, and fixing the
plugins build with clang.

This series is for 10.0, as we decided to not include the gcc_struct removal is
9.2 release.

All patches are now reviewed, so this series can be pulled. I'll report that to
MSYS2 too, so we can enable clang environments for QEMU.

v1: https://patchew.org/QEMU/20241031040426.772604-1-pierrick.bouvier@linaro.org/

v2:
- drop attribute gcc_struct instead of using -mno-ms-bitfields option
- add a section about bitfields in documentation

v3:
- explain why gcc_struct attribute matters in packed structs in commit message
- reword the bitfields documentation with suggestions given

v4:
- edit for bitfields doc requested by Philippe

Pierrick Bouvier (3):
  win32: remove usage of attribute gcc_struct
  docs/devel/style: add a section about bitfield, and disallow them for
    packed structures
  plugins: enable linking with clang/lld

 docs/devel/style.rst                      | 20 +++++++++++++++++++
 meson.build                               |  6 +++---
 include/qemu/compiler.h                   |  7 +------
 scripts/cocci-macro-file.h                |  6 +-----
 subprojects/libvhost-user/libvhost-user.h |  6 +-----
 contrib/plugins/meson.build               |  2 +-
 plugins/meson.build                       | 24 +++++++++++++++++++----
 tests/tcg/plugins/meson.build             |  3 +--
 8 files changed, 48 insertions(+), 26 deletions(-)

-- 
2.39.5


