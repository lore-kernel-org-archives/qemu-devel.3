Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D06AC48260
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 10:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSaJQ-0003Cz-TD; Wed, 24 Jan 2024 05:16:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSaJQ-0003Ck-6e
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 05:16:52 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSaJO-0003nP-Aq
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 05:16:51 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a30359b97a8so345924066b.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 02:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706091409; x=1706696209; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aG1VmNa9qyKWKkyTkfP1qaYwJsyZK0k+Eh9BTsafnvQ=;
 b=VzLi3jxHhxEo920rGX6gRIDmRiZj2AkSHCaXwZKpN+TWCS4+yhHuxhDKEciGgNeR7+
 xmlRzUOrDC/m2/1eSaR7vBmWr/RLDIgpTca9JGLk/6hDdQ4eiX+HG26dh3KlgdQ7Guu0
 YEJ8Ht2gDxtPpqq1IN6GiUJZrUvM7IglPa0FsnaM3wZOyGZOOzyjBTYhf4F4WM28dqax
 +g+5natMg7mVDhASbJpl3Jvq5wArg7axR6yw1OeXaWwI/IrZlJCgB+rna3JdesOyJ0UC
 8AsgC+AN3Tb+58Iw/lLXZ/4Q/A/YszCTinzmEEWuY1g8qpm9Iy3WbNhUc95HZiVuSrbU
 j/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706091409; x=1706696209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aG1VmNa9qyKWKkyTkfP1qaYwJsyZK0k+Eh9BTsafnvQ=;
 b=SinOml0dtSKFTZDZUxtwZHf+Mb0IdfVGt0Sfi+vgSmCxT3rt4YLgwzisNnqkL25V8u
 p61k5sMeNzfrDlnW5MdhXY/qGn/32BFYtUiUhDqU1zoDo6t+vVKEEyz7xuBEC1hYHZrg
 MncgfFQIS9HNcfGZM+l/IAGtU4ndReDxxNHk8b7mENVCd5SWtjSfCZhpsglYpzlqsYYE
 tEXqxF5EWRZiwgxGdPisKHbYQz0HBOrkmuy2Pzv9nTpqDDyuiHalRD4Csab9eCz7JreH
 dDLiSo8qlATZLMglhmWs7asevSlGJBoESlKcI3Yhyk/ZnW1mYhugdDcLSFTC1fJ3vI7y
 RnVA==
X-Gm-Message-State: AOJu0YwLpHDjUT5h86FK6g8bEGyCCWSrPoYqB4CkP8chiw/+eIQGA1CT
 kWZgfg3zICYmNdDiX/5dbL2EgpNumdHrWyS38JrCuoiliy+nLoIVsbJpSYl079Y=
X-Google-Smtp-Source: AGHT+IG7V+UBnvi+5pbPb6BUIafu8xEh+xMJhHE6KHSpw95PGthvKCiqljmTc1FngTIWiHANLuzCPg==
X-Received: by 2002:a17:907:c201:b0:a31:3d5a:1337 with SMTP id
 ti1-20020a170907c20100b00a313d5a1337mr120904ejc.45.1706091408933; 
 Wed, 24 Jan 2024 02:16:48 -0800 (PST)
Received: from m1x-phil.lan (lgp44-h02-176-184-8-67.dsl.sta.abo.bbox.fr.
 [176.184.8.67]) by smtp.gmail.com with ESMTPSA id
 i2-20020a170906090200b00a2a04c9226asm15225890ejd.194.2024.01.24.02.16.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Jan 2024 02:16:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Anton Johansson <anjo@rev.ng>,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/9] accel/tcg: Rename tcg_ss[] -> tcg_specific_ss[] in meson
Date: Wed, 24 Jan 2024 11:16:31 +0100
Message-ID: <20240124101639.30056-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240124101639.30056-1-philmd@linaro.org>
References: <20240124101639.30056-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

tcg_ss[] source set contains target-specific units.
Rename it as 'tcg_specific_ss[]' for clarity.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/meson.build | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 46f7d53eeb..aef80de967 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -1,8 +1,8 @@
-tcg_ss = ss.source_set()
 common_ss.add(when: 'CONFIG_TCG', if_true: files(
   'cpu-exec-common.c',
 ))
-tcg_ss.add(files(
+tcg_specific_ss = ss.source_set()
+tcg_specific_ss.add(files(
   'tcg-all.c',
   'cpu-exec.c',
   'tb-maint.c',
@@ -11,12 +11,12 @@ tcg_ss.add(files(
   'translate-all.c',
   'translator.c',
 ))
-tcg_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user-exec.c'))
-tcg_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_false: files('user-exec-stub.c'))
+tcg_specific_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user-exec.c'))
+tcg_specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_false: files('user-exec-stub.c'))
 if get_option('plugins')
-  tcg_ss.add(files('plugin-gen.c'))
+  tcg_specific_ss.add(files('plugin-gen.c'))
 endif
-specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_ss)
+specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_specific_ss)
 
 specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
   'cputlb.c',
-- 
2.41.0


