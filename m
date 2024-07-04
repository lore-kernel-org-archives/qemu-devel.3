Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F024BC31D97
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 12:17:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPLOE-0007vV-Pe; Thu, 04 Jul 2024 08:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sPLNn-0007ra-2s
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 08:16:20 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sPLNi-0002Ri-Iy
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 08:16:14 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42573d3f7e4so3763985e9.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 05:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720095367; x=1720700167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xt+VxmwzqqK9gMrTvz+AxGQbrZZuHkdN6tBaDv95dAw=;
 b=w2Uzwh3ZheKZZNJ5FNph6LuVyDES8zUXZ6Nryj7OmjdkqOds291DQPLaQoPhG/GA2E
 FX4IIy9dWEM1ProkdlAyF0zC4TwNNzshrownTdG3uiq5MA/Nrin3MPmzznYI9ieus323
 HGtHJsF0XwFP9tNZztPwCCZq0fGvMoQ7sgIIqV6ONVmU1WdygCD0KFEpGXvQAqHGI6D6
 USW0VFpH9iWqSjY/dTcr3CmSyfRe6m4N5s5wTlsJXA8uT251BhhIl1UzqfeG+wRyjZHg
 gmBdzoHxzTQlcGFwd8xGq90x1nfe2sE5MPjLELfbtYuSk1YPkQkp7aTpJa4ToVToHolL
 0rLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720095367; x=1720700167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xt+VxmwzqqK9gMrTvz+AxGQbrZZuHkdN6tBaDv95dAw=;
 b=qJPZ8cK+yYSH7G4M04ot0Y+9yy+O7P6/cNwRGoBE+ej7smBgwtSosVy/TsZhgEbKkd
 3NRUG24MInrKZciiik9547k5vQoBNPWok10pUlWhNgQxGr0pcXDU8YEgNoiC5gwoo/74
 knU7jaHp92jVL1leGQ1wagowrzY+8LQdIARD1kz+CBkn4AW5NM/Cqm+904/ZRoA5ifNN
 E/qZGakvML5GUX/cbMbmkJfQ0FBsJxzMhFBQiMqU9NSZ8dYQfaw1aZcYEyNFxUqxzWp4
 IOUD63kUZrmrozm3a1lFlTxxU22RJ4luuiTxiJZZx5DBPMpjQH8kr4szTMDzCd6v7zLO
 2zZg==
X-Gm-Message-State: AOJu0Yxc2nRHFwrTpWxOYNWf7SzLkiR0DRJj9R3GtwC3ZKKbB6WQvovr
 QAvOND6uY9Ue0WmfDIMzxfnc7QQbmrynlWkZYFZdITIko5fVl8JL6pEi7QU3rjE+zD8TsaveJ56
 glR4=
X-Google-Smtp-Source: AGHT+IEk0Ega4s3wSCPzWMDeD6pshOITcqSqSqG9W8tQreCtDFLSZR+3QkzYALbnO4koUY3J7s5FAw==
X-Received: by 2002:a05:600c:1790:b0:424:9c01:a0d3 with SMTP id
 5b1f17b1804b1-4264a3e1ed0mr11320605e9.12.1720095367013; 
 Thu, 04 Jul 2024 05:16:07 -0700 (PDT)
Received: from localhost.localdomain (adsl-241.37.6.160.tellas.gr.
 [37.6.160.241]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a2ca5casm22471015e9.32.2024.07.04.05.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 05:16:06 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH v4 5/7] .gitattributes: add Rust diff and merge attributes
Date: Thu,  4 Jul 2024 15:15:41 +0300
Message-ID: <b51249befbee4186a6c0fd6c6c0542f0413e0477.1720094395.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <rust-pl011-rfc-v4.git.manos.pitsidianakis@linaro.org>
References: <rust-pl011-rfc-v4.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x331.google.com
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

Set rust source code to diff=rust (built-in with new git versions)
and merge=binary for Cargo.lock files (they should not be merged but
auto-generated by cargo)

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 .gitattributes | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitattributes b/.gitattributes
index a217cb7bfe..6dc6383d3d 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -2,3 +2,6 @@
 *.h.inc         diff=c
 *.m             diff=objc
 *.py            diff=python
+*.rs            diff=rust
+*.rs.inc        diff=rust
+Cargo.lock      diff=toml merge=binary
-- 
γαῖα πυρί μιχθήτω


