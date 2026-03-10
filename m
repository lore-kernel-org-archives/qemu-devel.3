Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43E1EB107D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 15:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzzOy-0002ee-48; Tue, 10 Mar 2026 11:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzzOw-0002di-4Y
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:53:42 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzzOu-0005vc-Js
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:53:41 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-485345e1013so37925e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 08:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773158019; x=1773762819; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VbjCxPdxTy0F+sdur/B9cQkzQDmrjNtGzbXRyewiX7w=;
 b=W9dbffFnkgXLaiSvyP5O1j2yn/UbzY++GbEt0Drdt3BuPLaF5joTpZ5Qi07zO4pIJv
 fAqBt01IQit1jFtMGNuRgoj2rTlK83QR1TVT8hjJrsxMynjQ1gdH9BNbe5LflPjux3Xm
 SHVl1KlRs2YqFoJ8CkD7bqdzpegxs6nGsKzxexyakFuXDhe8Pv0MN6gGBEayL/ol9Dv+
 aPZ3BeUHgMCkvXhl0i8Zhfc3xkvv1m3CgCy44IQuMCgqmPwtJvpJ080xA+YGYI596HHa
 0e1rC3+X2dz97v6PWIiKvqPvNFJlh/X3goyiCfxg3A1AkfB7dAueifXAW6O7skce8JWg
 8tnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773158019; x=1773762819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VbjCxPdxTy0F+sdur/B9cQkzQDmrjNtGzbXRyewiX7w=;
 b=fqpK6Yq3dE3WWNcxVK9SXxhlWhOoEnLrRhenz8gm0OK+aJ0sZlm7YTMpAmHA6aL+37
 ktlAZRyrU5A5Tr+SFVsoKM7BE51MA0gE9IMgnHaq+pmLqqJKGyn8+0Is/BvmnF+iyH2L
 oDlhNI62Bo0KXMr9jieOxcc/kVflMPzd8SzkxoipJ+sRzlh3McAUewzKtPvVielrw9jC
 t9elauDLKIpAZys4GaJF2B90jLdKnakBVasQ0HllCL40+g+9WP6EMjqQ/D0KbzI3M7yS
 8TZKX49xipUTeSymEYRIJmMAbNJPTTD5IpoVt195xJanM/j8KBXxf3RZhxB5qcOaPW7c
 Q5pQ==
X-Gm-Message-State: AOJu0YyhDCOy+YmbbNSjZaSSJ/OWu3CdYoeY4Kv3xG0fhfIC5cA3fYic
 f/IUWFUUfEHb8cjQkE1u5djvFbfOxzMxNuI6CqpcqY70MUMxa8RxaQ7SbY7uafcbTwVaQ8V8Pjl
 /JOxyQK8=
X-Gm-Gg: ATEYQzy2pfOn3istnsAJ4adZHXWzmWXqGyH/yciTq5Qr6qNnzHLqXOATMGWNB6GavDn
 YvcPKswAtF42TA+CjpnhL60XgzKZnZiYpHDF6oP6tKrJwwKcAYFDsjl2d0jiAXjawgWXLDMTgtC
 E6ynZeLv2vEoKLSnQHTu8YFrcON/G3byiDxePhPgjodtDjeZO6axGPTQ3JhS4oCSvInHxdNjniV
 RmMyz4ITFEM0biQ9dIGubuxOFxc3E9iGqhFA3xkauMEDsdhAy2u/CtcuNAuvgO9/t0bDVoJiFtQ
 rkXW//4EgNqhJ1aeKadLEkx5p3NjvICTVb6WidNr1EuFjCF3sbzqKenn1dQOSHWoDdAUCHBc/Mx
 9SzBB/SysWhzyGa0lGOOcrV0dpvkFf70PXT/JfWQeaCOVdo6Jwj3OdqsUcufbq23UhTYBHdKzvd
 GfW2x1f3unCfmiQfV6TZtrXRd2n+yjhHp/jMcuWg63NuyThmZCNyVAC6QuRXINyDrHZmwprxgq
X-Received: by 2002:a05:600d:848a:b0:485:3294:fff0 with SMTP id
 5b1f17b1804b1-48541a2b9f4mr43533675e9.17.1773158018622; 
 Tue, 10 Mar 2026 08:53:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541a6bc3bsm96154915e9.2.2026.03.10.08.53.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 08:53:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-ppc@nongnu.org
Subject: [PATCH v2 01/13] meson: Restrict gdbstub to user/system builds
Date: Tue, 10 Mar 2026 16:53:17 +0100
Message-ID: <20260310155329.48772-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310155329.48772-1-philmd@linaro.org>
References: <20260310155329.48772-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Limited builds (tools, documentation) don't need to generate /
build gdbstub files. Only process the gdbstub/ folder when
user / system emulation / acceleration is built.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 1867560da63..db8918dd303 100644
--- a/meson.build
+++ b/meson.build
@@ -3754,7 +3754,6 @@ subdir('qom')
 subdir('authz')
 subdir('crypto')
 subdir('ui')
-subdir('gdbstub')
 subdir('semihosting')
 subdir('audio')
 subdir('io')
@@ -3805,6 +3804,7 @@ if have_system or have_user
                          output: 'decode-@BASENAME@.c.inc',
                          arguments: ['@INPUT@', '@EXTRA_ARGS@', '-o', '@OUTPUT@'])
   subdir('libdecnumber')
+  subdir('gdbstub')
   subdir('target')
 endif
 
-- 
2.53.0


