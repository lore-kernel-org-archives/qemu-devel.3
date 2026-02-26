Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E94FD9E19
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 22:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvjRX-0002Ux-5z; Thu, 26 Feb 2026 17:02:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvjRQ-0002UM-4n
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:02:40 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvjRO-0001rz-Ht
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:02:39 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4834826e5a0so14897705e9.2
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 14:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772143357; x=1772748157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8BewiopFU6OtMOWx2DJLJCKryyOULKc5wR7PaImslFk=;
 b=lk8OsRtyrOShX666kaXa7dZgiGMihbIyEaSb1kiluEvfBTDnIo6ViXSdLoEmJ4EneQ
 qOaSENYigfflu01wu/ei7h0fewZNiP1JaWq5AnZ+/zG/tfJH3t80D9PFE7GuWqwhGqMR
 SAeIKy4n3e/G8FWuJ1RuYSI+4sX1zqRWzD1qiamXh5B004/EKR6enlDLv4Ucz0PrAaTU
 S48RwOnidnAx7+faOGH125Yk7NWohDCRttIvvswNKsL18ChDCNM76I0QHVs6ktk7Bwlh
 i6Kx6kFs8ZPUbtOPqPIHUAGZEYoMNvUvLTYcJ47CIwywOyfJw1xsjoRDc1i8C0AEKdk5
 K3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772143357; x=1772748157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8BewiopFU6OtMOWx2DJLJCKryyOULKc5wR7PaImslFk=;
 b=m7XteDaIX5S3xDqZLkKOaxmQQeDk4rJUU3gsj9vpFlVCOrDKrNa/ImLFpASs4yCcOn
 LYNN/VnH0nyzgzi+hGL76NoTveJ3wEOFA+0oLKMsvYhcIHnSxc20uDwwc5WPfk9P1XHd
 cd93L5CaYYDCy14KXMrJg8Ivwp+tbaJWE9fHO10Ul5+AUWsoYxL85uIQnIEv287rZkH5
 VHj6XdqU1poBkF3clLFObOe3o1RF9EllCSa9VK27z6hooJOvGMbtDfeAafG6qSXh9a4+
 rN0gA3BPEOyE2YoC+UaWTyh9kXu7zPsVd+vNC1OEpeM6uQNqoqwzYhAofyGIIaTE3zot
 wspg==
X-Gm-Message-State: AOJu0Yz/VqOIp1c0oUO1GYAgM9ClIXqAWYsnfnOWxt31QyDO7SkIGabB
 zCH02oE9aPw3uY2e0UUZCX+qQzkNQFBmgXVXHpeoQun+Yu5wv35dvyIguxkhC+id0gIf9qNIfQ6
 PSRP3pto=
X-Gm-Gg: ATEYQzwHKWqYWPPpwTf9s+L/iUHfD2VLpQQFkSJGQ7fwcb6QLnuuFxnWBBL/CtGnr9e
 uzY7j0RbBnMO8BDAs4zXWqQ4Yr67cXrdrtX38TxX1Ev26/HSVa31EkFEw6b6zm+ETVTtAHyF+4V
 Z8z3DqPXQDG+SdAzhgZXryVo6+Trfw6Zq2o6hDj4CC+uRCarK6f2h502xiuJs5jqdvrd6zjhEFJ
 QVf21QIBDFpQ9QjA3epa7yBMvxJoRnabHdOVLRIUqYgIpM2vk7P2zLbYeUfqw7RAN/VEOnoZ4XO
 dPr6qvIeObc4gqF1Tej0sU2tXeDrZxM3KYhsnBrH45bbaLSi0KpuZfx2PGnSycSi3DlVAfo8fM4
 JoKTTCNfyuAApTZb14Js1d9tjpro35DEXqjkgZymOn/U+UAj+bB84Pu3sGVo4ZeuJLXxbZT4m5P
 CubCpOT6nj6OhALraXNd7PB2hvcUTwxqXxi+1uuvLTUc8qBKKKZ062zQcoZ1YYIdV7HkAT82BR
X-Received: by 2002:a05:600c:c04b:10b0:483:79a6:e7e1 with SMTP id
 5b1f17b1804b1-483c9ba7e28mr4360065e9.7.1772143356563; 
 Thu, 26 Feb 2026 14:02:36 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c71b498sm2352668f8f.15.2026.02.26.14.02.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 26 Feb 2026 14:02:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH 1/7] stubs: Merge physmem.c within ram-block.c
Date: Thu, 26 Feb 2026 23:02:19 +0100
Message-ID: <20260226220226.20164-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260226220226.20164-1-philmd@linaro.org>
References: <20260226220226.20164-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

physmem.c defines 2 stubs which are related to ram-block:
qemu_ram_block_from_host() and qemu_ram_get_fd().
Move them with the other ram-block stubs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 stubs/physmem.c   | 13 -------------
 stubs/ram-block.c | 11 +++++++++++
 stubs/meson.build |  1 -
 3 files changed, 11 insertions(+), 14 deletions(-)
 delete mode 100644 stubs/physmem.c

diff --git a/stubs/physmem.c b/stubs/physmem.c
deleted file mode 100644
index 14667f2bd8f..00000000000
--- a/stubs/physmem.c
+++ /dev/null
@@ -1,13 +0,0 @@
-#include "qemu/osdep.h"
-#include "system/ramblock.h"
-
-RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
-                                   ram_addr_t *offset)
-{
-    return NULL;
-}
-
-int qemu_ram_get_fd(RAMBlock *rb)
-{
-    return -1;
-}
diff --git a/stubs/ram-block.c b/stubs/ram-block.c
index 8790a59593e..f0650b19ac6 100644
--- a/stubs/ram-block.c
+++ b/stubs/ram-block.c
@@ -35,3 +35,14 @@ int ram_block_discard_disable(bool state)
 {
     return 0;
 }
+
+RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
+                                   ram_addr_t *offset)
+{
+    return NULL;
+}
+
+int qemu_ram_get_fd(RAMBlock *rb)
+{
+    return -1;
+}
diff --git a/stubs/meson.build b/stubs/meson.build
index 8a07059500d..0171f531523 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -20,7 +20,6 @@ if have_block
   stub_ss.add(files('get-vm-name.c'))
   stub_ss.add(files('iothread-lock-block.c'))
   stub_ss.add(files('migr-blocker.c'))
-  stub_ss.add(files('physmem.c'))
   stub_ss.add(files('ram-block.c'))
   stub_ss.add(files('runstate-check.c'))
   stub_ss.add(files('uuid.c'))
-- 
2.52.0


