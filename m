Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4B4CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 20:24:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wShHS-0008J9-5O; Thu, 28 May 2026 16:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShHQ-0008AU-2k
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:24:36 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShHO-0004u5-FC
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:24:35 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-45e7c636e74so7027352f8f.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 13:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779999873; x=1780604673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=76Wpp7erURswqKsUG/5rkxIWZind1yO5nfVzXs2V5RA=;
 b=uq8h9M4hr1Wk7wYzSHwR0vkoBv5V1slnpXdtIKHGYJN2x6v1yoTYWtVhZplOMCwexh
 cGhT98rS/zjmvTOBMZqH0XdazqGkTQqYO0FCTwXm1Yl5HX+iGSlip7FrB0pWfiJ21KSR
 EtXF/fpRkLMumtBF7TZSCEl6u0dSsjk1wbcItzg4c/LqBpa+HkT0nYgmKMjx5DlSqNjM
 +zhQSS+a2ASAd1txKXqobHzuFoaKFVSIz8f+LCkYP+adyEkH9DXyOV/yuSGWPHJ/Lvji
 IBkFpOz5HpeEHFKjR4qx2Jqx4C6slpPpcVmSsB+laBqI3gOtL5QpTiupBBjBHIGIqQtf
 ymMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779999873; x=1780604673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=76Wpp7erURswqKsUG/5rkxIWZind1yO5nfVzXs2V5RA=;
 b=WHt+lPg4cZBDw0/cLiLqyNrSR9FK6ug4cBFC/rA+FawA0aatPx9+98axJImfJrZAPM
 6sXoqsjtTlC7j+qZDDBPZgS/Z8WPwkXHHJSzhJS8C9TkfZDbzB/ghvLLyvnom+r4wPRd
 3Bsdupfv5vu9c+6HVwBsTxb+GhBJoGcFVfl/Fd7CdtgffEBUT3NKza6/n9BLEuZxyU07
 QfhAc6LtqYfkuIoTgKSzOWVfoUqQbwju69aqZDf6xz4YrscrKO6BageZ7Hr4AuR5YA0D
 +q1dj5XsDDBZXiw0sQCJGbUy8BaNT1oDdud9yFI1jaW5fLayB5jfqo8iK5ORMdPRoFPB
 by5g==
X-Gm-Message-State: AOJu0Yw7IyqEWTY6HR+8MBf4flUBYzrvbU+QKLx/oK3yvz2EBgELfE7j
 JUcVD8Blx6LN07DipbPzgU6Kqnvk4v55QjymzV2t9ON0BC5kUL7X4Y/hCi1JyEw64sMl3/cW6qp
 0BCSlbbnHDQ==
X-Gm-Gg: Acq92OE6Y4c7YCx+4n+rFZ+dwRnwk4URQid3+sJRe5Y3KP5XT4iP1Ha+VX9bNYo1Xak
 gbs+Wi99sY52BV+0EFgA8OayRunaY+DV7CWPZynlRz3Ol0zbXrOZZbnWHsW9gvnC60Ymj0lK0Nl
 pl8JvgwPWw2RqQUIZTc39COoaHiVBF4pBrqj3ssCSQ3JBQMcktlhcxyHHIuKL88XLCHJU4LM4jE
 v9RQl8JkmQqDWcBAGjTMjd7iRfm77DkVCaI5rG1pJqecTrBo1o3KTbpnd9YvvnrajbWszle9H6O
 tmX98FVOVlRD45m4LCmWoE3Ugvn54JIuGdiLSdq6jRk69Krxc5B+ZTT6KOPhnJBt3lLQ11Jd+OC
 AKCkv7nYOqlS7+7O1oCxK63vKJ54vX5fhCChfPpypTsKcoF8tuN61T2mgrJ6+OluwaTjfuk5mBb
 xofX1q2+ZUL+C+ifCSVk4bY47cXyAZXV3JNacOYghOlgrzQJB9D6jioqdPL4vYvP0z3A==
X-Received: by 2002:a05:6000:491d:b0:45d:b14b:23f8 with SMTP id
 ffacd0b85a97d-45ef05e46a7mr1043657f8f.18.1779999872840; 
 Thu, 28 May 2026 13:24:32 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5b2ba9sm15576025f8f.31.2026.05.28.13.24.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 May 2026 13:24:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/22] net: use stub_ss for vhost-user-stub.c and
 vhost-vdpa-stub.c
Date: Thu, 28 May 2026 22:22:43 +0200
Message-ID: <20260528202253.49122-14-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528202253.49122-1-philmd@linaro.org>
References: <20260528202253.49122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-ID: <20260528051642.115721-9-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 net/meson.build | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/meson.build b/net/meson.build
index da6ea635e95..9c8068b06d1 100644
--- a/net/meson.build
+++ b/net/meson.build
@@ -46,8 +46,9 @@ endif
 system_ss.add(when: [libxdp, libbpf], if_true: files('af-xdp.c'))
 
 if have_vhost_net_user
-  system_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('vhost-user.c'), if_false: files('vhost-user-stub.c'))
+  system_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('vhost-user.c'))
 endif
+stub_ss.add(files('vhost-user-stub.c'))
 
 if host_os == 'windows'
   system_ss.add(files('tap-win32.c'))
@@ -61,8 +62,9 @@ else
   system_ss.add(files('tap.c', 'tap-stub.c'))
 endif
 if have_vhost_net_vdpa
-  system_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('vhost-vdpa.c'), if_false: files('vhost-vdpa-stub.c'))
+  system_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('vhost-vdpa.c'))
 endif
+stub_ss.add(files('vhost-vdpa-stub.c'))
 
 vmnet_files = files(
   'vmnet-common.m',
-- 
2.53.0


