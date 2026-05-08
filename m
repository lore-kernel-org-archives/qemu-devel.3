Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA129CD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:25:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLN4F-0000s8-Sc; Fri, 08 May 2026 11:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLN4D-0000rJ-J5
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:24:42 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLN4B-0005SR-CQ
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:24:41 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4891f625344so23032065e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 08:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778253878; x=1778858678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sv5fbuAqz8phk+zz0K3xdcDsTwuljOhl5mCxqC3uUaw=;
 b=ovWxPwaPFCs1jsISjxwfsvE4XtXNhSdHOf5kuym6sJd4QRU1XvtoxuRfMtu/Bm6zyl
 EJtIQgFA/UItL7U0UOEgCoNIY6OqmPUbnN01hPVUpPcewy9i5wqh7iJu6spzs4sim7QD
 KNvYej5plXRVFgGoBBbj79L0mTNB2ioypbXv/Uo0QDh1vcPRaQ+31YMRtbu+uY/m1WRT
 ATym+B1FuVROuj1jqlUJnGT5kJu1p2BHBRGufImw/C3QR75VMiBOx5bm/OwCbOVjbNi5
 YFSqBE4gP9VP4cS6eK7l5xdgvlGIPEksTZghJnK+qnhrds5PnFsEUW7RfLcSc5+yJpXG
 +WiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778253878; x=1778858678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sv5fbuAqz8phk+zz0K3xdcDsTwuljOhl5mCxqC3uUaw=;
 b=pRprtxxXnejCk/2uk9zfB+jzgQtpiiHQAEeCBRp7v3dkl9slFvps+CVUj8yZczK6Qj
 6idgGTz5A9QiT1Ckbx12vWFvcy+YX7lYX0mo7S5DIZMm8rzzVpeHbK27FXUbY9g7cmjJ
 J2HYC47hTht2XdTIWZRjYdkWcwoYAfXIqufOPPaGOcodQ5hJiN+uWCCheHlSYFYLRsbY
 q5vkl+hDYFUjmIH0eCwrXR/p7VfZajTNGn9Q9IGdJPBVBzg9GIaid7uifb6s9HTXH+YZ
 Kj1/rMOF2G+IJFE8GTvkbdKvVLL/J5i8PSa85KwViLYgyUFQ1EKDHgVC7lRRF744StcQ
 fPSA==
X-Gm-Message-State: AOJu0YzXfySyXhJaee1F3D9L3HGpM9ebvcT4TXhIU5N6QB4EJNSMG0Wu
 XBp7poFgshIqS/3HzlgCOxciQeCeHLjBaY16cDpmGP5XNFQwt1Wg6+nTs1RfdUJkHrzqez/vjhl
 zbA79
X-Gm-Gg: AeBDietF0tod+JBlg6XGjiIpZGAjCYrGbzt7MSt7XHs3csaA0ZYuI1vHkiGTv0zMTkP
 wjvmv23WDo9+vQ45dVDK778TyLlQT+8+e/nAyP+TYWC+baVtlUYscaaguXzpJvIqSY4ERPdk1yw
 5Uqas6VtUeut+W//0kFWHtvuwky7dKhaepD5HoRbrWnXmyKIyuH/vD6yQQ370Rh7zPShrC8/q0c
 FQUoW1MCPC1TBEOpQqkE4zGR5X+LYoRjNn/cYZM2Vq3MOAQIPaVaxiDV1v/tUmg6xsq3RqqBrQD
 F26t0EjTwkh0RMJlw7gCd8Y+Fj20kXOgUZIPHrsYukAXNxnskU1Jyg9bwfPTaXSld07+KaUCrbR
 zMpRD4YXElTMlWhxqBhW0Yl9f/TekYpu7k6hRZgGP3BlfBuCWigTYZVakXodh1nscAoaI8T+gXu
 ENXyWsQwwmS24iErhuEB/iJU/qTxl9w/Qzq8BQ1z1PIsEHSL0IYLDuq5qNGWBQyJdOOdrT2ynYX
 XEllhFlwIYR+sn4+QiXsI5qqm4g2bc=
X-Received: by 2002:a05:600d:8443:10b0:488:7d01:f67b with SMTP id
 5b1f17b1804b1-48e5dfd50e9mr96957555e9.6.1778253877628; 
 Fri, 08 May 2026 08:24:37 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548ec6c221sm4940453f8f.13.2026.05.08.08.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 08:24:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH 7/9] tools: Move qemu-keymap sources to tools/ directory
Date: Fri,  8 May 2026 16:24:26 +0100
Message-ID: <20260508152428.2648560-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508152428.2648560-1-peter.maydell@linaro.org>
References: <20260508152428.2648560-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Move the qemu-keymap sources into the tools subdirectory.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 meson.build                          | 2 +-
 qemu-keymap.c => tools/qemu-keymap.c | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename qemu-keymap.c => tools/qemu-keymap.c (100%)

diff --git a/meson.build b/meson.build
index 63eb4031a4..8164458eea 100644
--- a/meson.build
+++ b/meson.build
@@ -4517,7 +4517,7 @@ subdir('qga')
 # when we don't build tools or system
 if xkbcommon.found()
   # used for the update-keymaps target, so include rules even if !have_tools
-  qemu_keymap = executable('qemu-keymap', files('qemu-keymap.c', 'ui/input-keymap.c') + genh,
+  qemu_keymap = executable('qemu-keymap', files('tools/qemu-keymap.c', 'ui/input-keymap.c') + genh,
                            dependencies: [qemuutil, xkbcommon], install: have_tools)
 endif
 
diff --git a/qemu-keymap.c b/tools/qemu-keymap.c
similarity index 100%
rename from qemu-keymap.c
rename to tools/qemu-keymap.c
-- 
2.43.0


