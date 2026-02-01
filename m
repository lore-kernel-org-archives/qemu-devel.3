Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF6AE6529E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 23:31:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmgtr-0004eB-5g; Sun, 01 Feb 2026 18:30:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgtm-0004Vh-4l
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:30:34 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgtj-0003Ni-4o
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:30:33 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4806bf03573so18264325e9.2
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 15:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769988629; x=1770593429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3y8sx2MjjH2xIWfAsCvCax2QQJrx+zY+UiIZh3tX/d0=;
 b=nzh+NouGmqYNyUiylKK8lT8fJHqXkPjp71iSfFH8hoZxQ/1R9unAZ8ngBWn18Yh13j
 HcgVpeUj+w58hLMCRWYGbI1biwA9wJN7jOgfULT9pdDlpZCPZ5ciOtDdsYn9c/EanDp3
 L0G+2bFdGLxhd8hcK2LzpGGJaUYwf0P/jSpgIFvxR0rH7bYGx+vCykhvnq73blsXgeE9
 Lhj+ru1rywN4rVlv5wCjhQfnSipnsTfXzxvL7zFn4To4KoWCOrBd8DHDDzfzHT/Ilid5
 rB3bPSv/7FEq3iPxTpt2EeOvS9VBb8qFAo2/Ghr1WZkb1MhNjX1EbTcdyvDTupHDT1qq
 zQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769988629; x=1770593429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3y8sx2MjjH2xIWfAsCvCax2QQJrx+zY+UiIZh3tX/d0=;
 b=oil0PW+MiF0VuQLFkvVlq8Sa0ITYrDiTUiD2tXUkEBaJR8R15/NHw3Uzdw571TEmQw
 Y0VULX2O3Mwg/m18DcnqaF0K1tJUl2IZSu1IKbXV8vqrk7t+CEaGPsW4gtXAigoA2O19
 d3pJ306emyPdMseAA1PmXuJYeZDBgC8ZxCxJR7EWTYIEzk9xA41xlTtbD+I66DfqAf3J
 hfO4N4L/h8QgwPVHCFKWAvfbkPjYFg/iLC1lE8UUSWCCigr1T8uHXcWsnHGwU+5YsnZZ
 tZPtClcQfC7si51Np8utkL2TII/PaZ2tyPHIEpldOk2YRlmdN8TKCCHwIdgebMA7mWJ/
 2Wjg==
X-Gm-Message-State: AOJu0YzqYuuRZT5EjcZM1oZipjhSEbOWdcL8aUnp0ZoVT+0AMWDTjaKS
 r9sotYNAjKilhYiWcoCqKwWN5D5hpwElVPP34Sqrz+6cGr8pIPduTF7sjR6tKqmjIUxExzcBTa8
 ltVhwH/0=
X-Gm-Gg: AZuq6aLjr00Pa0m3kN2B0SZuPjBrQ+57sZqZeomQD+kFJQH9MSU9LI25rJUezYym0z6
 5UvB/CC5CPrVdUwpZA9ZKyNKC5TIp33L16G42hqOlmhMVJXwrInu3KQmg33yzsmptAQfk8e5Nvc
 OuPqfIMQy4Zl2WEHFY2EfJ+H8mOWP/g3f2jcrLhw0VxGSBFM4Ba5rNU9+WnmtOyK0SYyVgpL97l
 pYoZOZkNUq8Ar9fFCKf0LK89fyo7gVpx+jG05dp+SMwKJvmDSYw0lRbCS8WFFYVjV9KysrqcZuh
 h4dbXU79mCJ2w3JWaWjFEyHCW5AxW79NLpSSWQ9dqtWRgUp4t46xsN7N5qhVu/TXqI0huQjnl7x
 bpPY1gGMJa2aeoqEIaUnPQD8s5U4HiBPKRak/wp8I3ilWXgsNqntjLvDxBf13gBK+TT8nQgxIxw
 hFXr94FQgeDbydnhcBu6SVu32o9Cki0Ggilqocj7Y7lY3b1/NKbd19F/XiEzfo
X-Received: by 2002:a05:600c:8b12:b0:47e:e20e:bbb7 with SMTP id
 5b1f17b1804b1-482db499535mr122443635e9.25.1769988629137; 
 Sun, 01 Feb 2026 15:30:29 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e132356dsm41644763f8f.33.2026.02.01.15.30.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 01 Feb 2026 15:30:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v3 09/11] hw/virtio/vhost-user: make compilation unit common
Date: Mon,  2 Feb 2026 00:29:21 +0100
Message-ID: <20260201232924.93399-10-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260201232924.93399-1-philmd@linaro.org>
References: <20260201232924.93399-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

PPC architectures use a custom value for VHOST_USER_MAX_RAM_SLOTS (32
instead of 512).

vhost_user struct and several functions use VHOST_USER_MAX_RAM_SLOTS to
define stack allocated buffers. To avoid changing all functions to use
heap allocated buffers, we keep this max, and simply add a
target_base_ppc() conditional for the single place where size really
matters.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/vhost-user.c | 11 ++++-------
 hw/virtio/meson.build  |  3 +--
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 63fa9a1b4b1..c8a004c6d2d 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -44,13 +44,8 @@
 #define VHOST_USER_F_PROTOCOL_FEATURES 30
 #define VHOST_USER_BACKEND_MAX_FDS     8
 
-#if defined(TARGET_PPC) || defined(TARGET_PPC64)
-#include "hw/ppc/spapr.h"
-#define VHOST_USER_MAX_RAM_SLOTS SPAPR_MAX_RAM_SLOTS
-
-#else
+#include "hw/ppc/spapr_common.h"
 #define VHOST_USER_MAX_RAM_SLOTS 512
-#endif
 
 /*
  * Maximum size of virtio device config space
@@ -2280,7 +2275,9 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
                 return -EINVAL;
             }
 
-            u->user->memory_slots = MIN(ram_slots, VHOST_USER_MAX_RAM_SLOTS);
+            const uint64_t vhost_user_max_ram_slots = target_base_ppc() ?
+                SPAPR_MAX_RAM_SLOTS : VHOST_USER_MAX_RAM_SLOTS;
+            u->user->memory_slots = MIN(ram_slots, vhost_user_max_ram_slots);
         }
     }
 
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index affd66887db..ee397aaf196 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -17,8 +17,7 @@ if have_vhost
   system_virtio_ss.add(files('vhost.c'))
   system_virtio_ss.add(files('vhost-backend.c', 'vhost-iova-tree.c'))
   if have_vhost_user
-    # fixme - this really should be generic
-    specific_virtio_ss.add(files('vhost-user.c'))
+    system_virtio_ss.add(files('vhost-user.c'))
     system_virtio_ss.add(files('vhost-user-base.c'))
 
     # MMIO Stubs
-- 
2.52.0


