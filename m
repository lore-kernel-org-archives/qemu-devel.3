Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B201AD232DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 05:33:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve56g-0004L8-W6; Fri, 09 Jan 2026 00:32:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56e-0004I1-Ow
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:16 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56c-0003hs-Lb
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:16 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c026e074373so2013842a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 21:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767936733; x=1768541533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EBfZzb7NJTy2HQal17ePd4sZS9r7eIeXMW+azOITUQU=;
 b=y1rnbpo+kO6l/6oBzkpYdOkwK9riR2+IiB/DesTHq5YFj7F+D3n/qeBAexuHzOh/kX
 R9I58ww9qkxh7UMyl+aHQ03lWfx/iAiWONeHBDgMeBtmO4tvNsp6tnxEOM1749nVOKm4
 jpaAgMBCz57kiWDPINrTWgZOKAFqrFhJWFtKAmcF0Sd/7319wPCIRjdK0shlkpUzOT6z
 btikbaELnxFk5ykAQdG4XtvgeUkF+m3QFBHwnf5JG+XY94YPvQ/vVnwx/+iVIJGJrkdD
 RjQIZyejampsidOZSUTRjV47JrUTpiefHgvi5o6BmXpSnD29C2XzjBDJ2DqkMi3jo6O/
 Spdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767936733; x=1768541533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EBfZzb7NJTy2HQal17ePd4sZS9r7eIeXMW+azOITUQU=;
 b=O2I40KXu1tPYxp/Vz3PvJr7k8ja/pphSuuVrK18AXcFpWfW2fs2ah2d6MAY85COLZc
 LHA5df/s3djodTmH9zo9yHcMyRJxwVrdlZX6/+ZR3MbZmKzb7QC7NzaQHpSJkmHHQl6+
 vQg6LBpu1Y/EVSdYrGf8zdH4+mfBEkqrWBFr6IQUH+ajP/qSAGZEeDF5yvxhOA5UJ7Wj
 L5ctzEFFnGghE4RCo8oyNpejgECGFdQDH9gM+awyw1gEDR572srnDvMydFeJqCCxhspy
 sILqmog5UBYnIJ0MZ39LM+MjGJYthf9i2AYouCrs1S/E8473SxwOCgEqQZKCrfDeY9cb
 Jd2Q==
X-Gm-Message-State: AOJu0YwxSE9HWAp/w7p7pcqkEATj1f3hHDg/exxf7as/aj9SbHct/HY5
 Xt4F6GNITyMaV8Z/z3fU6xnrV3c/aZyzxuxe8ZcofhQJ6MOqLdXgwAyjAHvZQlz2vtXkZpOjgPT
 Z4KTr
X-Gm-Gg: AY/fxX4/8gF/8hFgYZ8KLuBAHr+cipviJJx91rxPoIhnK1z+x/8rTHuNwtagydylP7F
 kqpLy45eUXwv/vE0ohW2kHFBk7kYiNRMvvfKLv8T1lbXetYEyg7ETQss9MC+ZpxzcQnENYuLZxI
 itNUN4t9Oh05j+IwW2WWLtNxIdF90aYdxuUya2+AXgwtFhV406ql0lJEkofrc1VdxZzRzLlAAv7
 SUNpoQN4AWhO4vgLtHyC2C1rSBi5NuIXoXpAEF6MvCUkXp//ofx7whVApfWIM1IPo3eCyDNyi9R
 R91HYENc8C368ZLthtIikhCNCmHdXwVLpZbbqKwozvnyWoVLbcrpfFrFMOFcUhux1P4fBP9NZ20
 AWc80Ld104WUosW3ph8CXXdjji+cD6OMRdYEU/o7Ehi+yv/C2S7aRim5s33dyPRoobWgjpC2bl+
 GCqNl/u4XV63JYLYfH8AZrnDIm7Ryc9at15IL8nyJtYueRg0fcSEV1hlzl4psQZWPo
X-Google-Smtp-Source: AGHT+IGOr1MDN2Vp4Qb+EuiaL0XdcewRAtDCGf0IMzzfnCpjWaftBgNsGJrvZ5L7w32vXWPBy/vo+Q==
X-Received: by 2002:a17:90b:4c09:b0:335:2747:a9b3 with SMTP id
 98e67ed59e1d1-34f68c281a5mr6921988a91.32.1767936733081; 
 Thu, 08 Jan 2026 21:32:13 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fa93f30sm9260137a91.5.2026.01.08.21.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 21:32:12 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 08/29] target/arm/tcg/cpu-v7m.c: make compilation unit common
Date: Thu,  8 Jan 2026 21:31:37 -0800
Message-ID: <20260109053158.2800705-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x532.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 144a8cd9474..08ac5ec9906 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -49,7 +49,7 @@ arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'sve_helper.c',
 ))
 
-arm_system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('cpu-v7m.c'))
+arm_common_system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('cpu-v7m.c'))
 arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files('cpu-v7m.c'))
 
 arm_common_ss.add(zlib)
-- 
2.47.3


