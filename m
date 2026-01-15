Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4316FD46617
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 20:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgU4J-0007rA-J8; Thu, 15 Jan 2026 15:35:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgU4F-0007pK-9z
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 15:35:43 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgU4B-0000XR-Dx
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 15:35:42 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-81f478e5283so1181964b3a.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 12:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768509337; x=1769114137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3n2+6Lkvd9Z4hr5H7tUx/F8N5N/KrUG73498s6tKe5o=;
 b=ovgsM8gv11F0Zp9Nv/N3KWfaeQfr0cuJwtGw/eoScSjdEkaXGemEgfTQxYdfyvrHa8
 kyRzCpft2yrIM0Tp4qxg6ZK9mOx2GalQTv9UrLtDM9H3hGrlC7lKHb0puGQFVRkoldVj
 dgVz4UMwZMBqSmG82WJE949UIc+aLg5zLP4l9+lgp1RSkr0MMaUbosAsC4b18kCAs5Yy
 AogB/ZioGbN2ju4R8mqg6mX33u5o+mGSOgflz9mvROFEs4/qI3MsNAhosiMEUzBj3K0v
 IjbX17w5gO1Fvx1BXvs7S48+81NDpzqTCXnG8QIAZuleXiWL4TkOMeOaE6RH279V/LpD
 s3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768509337; x=1769114137;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3n2+6Lkvd9Z4hr5H7tUx/F8N5N/KrUG73498s6tKe5o=;
 b=hWeL3dvEgRREraPMFOI9IUD5l/hzhGJtu7wkTv6t98icnQ+KLiGTLTLJJop4v+WktO
 SPLrF15rVRwcg78GqhlKc8JMS1JnWSAniM1R3u+h7WHNbRuse6pVBWgnShNLjTNrm423
 ugyisR2IymTvzUw7TxskASHoC6ea6VBI3rvefQd0zStJ/SAJgchKYlvdluWnUn+KSt+m
 bX0UviFdzK2HSuOVjmF/ENnIO3cfL2/h/+Ss6wmlNdEwzWjTA5OrxwFrB2x5WiEFoamK
 UoBPPCZ+VGKw5aPXFN3Xt4oo6fZZ9MhHLL1gBGqLS9jsMRehwWirWeZJTRsH4wWkC4m3
 ddXA==
X-Gm-Message-State: AOJu0Yx7oGwVOiGxlSp1SfV1HsBQQHFwNb9ev40/aPmSM90KHa2Wh1ka
 XBf5f8L4W41l4vsKxk3+1CvQkWRpVVICop6L/U5hEslgE3I0g0CSlR2d5Vf1SVQoS2K8IsSUYuo
 0y3/v
X-Gm-Gg: AY/fxX5Q/XIXuvyai5oO5fqAunlBXLXj1MibcgGLzs1mzVh01Iu024Ii6Nao8gPd2dc
 415LxiJlKL8xZuZgsDfc4oAnji0KDv3QyyQjEnhe9TzJ2c9rlBKM9BD/JMINLS1KZdrWFZtcs6+
 5U+/XHn4RzfzKN0yLm+Sjc5dBBifqga9jldgSIqrBRqBcMuDcrxLO49oaXd95VVP4jriCT7g5UW
 wWC4jVSYqhQtQBH1m+Cw6d+A5UtzsodfYNrT6cxVPUKg12VuqcmQX0aGKCGg4YE+xX+KxfgTRos
 QPvC4Cir6/xyj7+s36H8FV+yEV+Jjy8loPIS33oOTbxcXNVGbmaOyTnMnSSE8aCollMXDkdz13K
 1aSveTY2vtWlgbXBBtV/WMZERXRrurO+608QjXm+ebPDnGEnFQzYMuooA3T3p4E9/GXc+8/sbWa
 Qd+YuB2qsuqsSV2iNZPTddZzI8hvTHC92QEzRS26YwROk1LOfLzhWtGlpf4gx6cE9AgYqu2a1lm
 us=
X-Received: by 2002:a05:6a00:bc8a:b0:81f:4769:6fec with SMTP id
 d2e1a72fcca58-81fa01b8db6mr730533b3a.21.1768509337430; 
 Thu, 15 Jan 2026 12:35:37 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa108c23esm230996b3a.8.2026.01.15.12.35.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 12:35:37 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Phil=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] MAINTAINERS: add maintainer for docs/
Date: Thu, 15 Jan 2026 12:35:29 -0800
Message-ID: <20260115203529.2713193-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

I would like to help maintaining qemu documentation and I've been
invited by Alex to apply as maintainer.

Files in docs/ that are already maintained will continue to be under
their respective maintainer. The goal here is to have someone that can
help on all other files that don't have an official maintainer.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ddbfba9f01..786f3b3a456 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4505,6 +4505,11 @@ Incompatible changes
 R: devel@lists.libvirt.org
 F: docs/about/deprecated.rst
 
+General Documentation
+M: Pierrick Bouvier <pierrick.bouvier@linaro.org>
+S: Maintained
+F: docs/
+
 Build System
 ------------
 Meson
-- 
2.47.3


