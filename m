Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6383C88E41
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 15:00:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkkXf-0000oj-Jr; Tue, 27 Jan 2026 09:59:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vkkXb-0000lu-5h
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 09:59:39 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vkkXZ-0001kJ-OC
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 09:59:38 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48068127f00so6772485e9.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 06:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769525976; x=1770130776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/AJa7mtnRy3yuybFAunlrxI/q1EMn1+CgkHnlOAuLTU=;
 b=cgSbIbMNyJAqc26DXdxHjAgVcWctBlVzTyEJq5Q9KHDyZMXNZ61feYtyjE7Gy6jKLw
 4VOwbwOou2InsMkDnVg5maz1USJZhLOnJRqqNCoGpU6UEagG3CnneMLBtTFkixNayBzW
 FKLzrT+UeJteVQ9cStEz5SED7f9C4ZtW2NHmPa8ECFTUFF9wYrm2wyGFd5B9NkUGxyav
 xgpjw0QHJ9sp8jT4aaSFfOJovzBuhYa0rDqLVYj8b8PsTr+lVHcFrZ0WVgbb+9wHh+oY
 ns1hggByxVN+3KjQQThzPBsOBiDAddNNNFd7qAl2wKmyM/N0pxJvPavOnQJecPRj0rBX
 KeKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769525976; x=1770130776;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/AJa7mtnRy3yuybFAunlrxI/q1EMn1+CgkHnlOAuLTU=;
 b=FEIJbqK9XQrzMS0lgR36zpAZrQbnjNMQhZ5H39W+MCY79Z516e+NCbJMhKqDZsBaAS
 Sa+97+SlxwcDME1+eV4SE3DHE+A9uELA+v5XYUYoa/96vZ0YMSzmNGHgeqzKeNMPl9Qn
 FnDfsc2YbeBzjiPQJuAkGSmJqwct3VgBOwKvhaZxo24gBb/YMz7RTGZI4OsYgU2j1WbK
 rOk1JEZp5iuhStbmpvir/kKdW4CbbEle0Cw8TJs6G56Ib80/ccmGpRKGu9Qr0JJGgzjC
 Vk8TgLoQtG22VWmcX8SDqYJIUj6L65xtMAPB6FpodyQXJTDgslwSGTVjzwb8Wu/y7zha
 exZA==
X-Gm-Message-State: AOJu0YwS44x/1085K8zv77Z7u8h6MNOKQtt/bXEO7oFGDz+o4L+LBa4b
 5kAKaRmjj41IJmsofUuq7sIdiKN+jxBOZyszWlZFzCwGGP8n/2czTzEIbhKvbrRZ3FlZBSB3FJ9
 KwLil8fE=
X-Gm-Gg: AZuq6aKmvO8cI+TPFcGrS2SJS96W6UF2j58T6NA1fSC/MH2KUku/+ZkoEk7lrzvsPQ4
 oHPUAUlHI5ZlelDDlG8PonRQ33glqbevSICEJCR/555U6iJ9kvf/TnQ6jlJRQcuoT+szvC3Yv5b
 w4zBPBkaCGrJ/LG2TGQsm8jj+YcwbZvUFa44DV3SbxF2cIcocM01eAdybW/ZjBPrZZ/99+nZz8P
 y4OQM0VBOftdWzalUonunbmv+i7YXwd/ycfWCghNQOxxDUCT57gKyJNYnnACJ/SprJ8GdO7V6/i
 bJQotuLtyDHXxNvsSd0ndQP8KPgoD1kAlrYZMWnV806TnW1srnbal2lHUWL/ab901QbL5kVAOjB
 zNAkx6pXJXDTmhjTtAOE2vFwyIkCsWW1YaGb0XBma467aLnBioteDypl+yFVHJdnG/CSsImIOzL
 iw186kqOWG3Ag=
X-Received: by 2002:a05:600c:450b:b0:480:69b6:dfee with SMTP id
 5b1f17b1804b1-48069c21069mr26492365e9.15.1769525975972; 
 Tue, 27 Jan 2026 06:59:35 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c10dbasm68796705e9.15.2026.01.27.06.59.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 06:59:35 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7068F5F7DC;
 Tue, 27 Jan 2026 14:59:34 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH] MAINTAINERS: add emulation.rst to ARM TCG CPUs
Date: Tue, 27 Jan 2026 14:59:28 +0000
Message-ID: <20260127145928.3073826-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

This is updated as Arm architectural features are added so we should
catch changes to the docs as well.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dccdf478886..9b7ed4fccb1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -213,6 +213,7 @@ F: hw/cpu/a*mpcore.c
 F: include/hw/cpu/a*mpcore.h
 F: docs/system/target-arm.rst
 F: docs/system/arm/cpu-features.rst
+F: docs/system/arm/emulation.rst
 F: gdb-xml/arm*.xml
 F: gdb-xml/aarch64*.xml
 
-- 
2.47.3


