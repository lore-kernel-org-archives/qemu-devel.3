Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E96D0D16D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 20:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vda6y-0003rs-WE; Wed, 07 Jan 2026 15:26:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vda6w-0003ph-BZ
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 15:26:31 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vda6u-0006Rq-NP
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 15:26:30 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47a8195e515so17994175e9.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 12:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767817586; x=1768422386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=up9yE3JF2/GpSuDP0drzQS4jHQaVrvt4XM0YzFC607U=;
 b=F87x7Xc176sxpK0whBL/wOGSAjkfhrQkPML2pkc3nQy7Yb4sVgyJtjfRfKlSuwRlLI
 7ffngDrTS3TSJzl2ej0g0Ihce+9J9R1Sb0DlgKP6CefsABLpITHK1LINayTQSHsGK7KI
 F00LjZEoYcoMrElE6fRs6Ias+N82OD5Zyb11fpTKVQeHCQBye5fxhxSKaISxegk1wnbH
 6aeErtXUmOVVb8UiT8yQeH0rdlRzIJQOzm6wr8/gp4cVHgzRivhOgv/20bFs7ZvRROpg
 YsNNRMLKnV3N1nza3stVNVjhlEM2ZxTep7PcORw1mn/GmawjKAYDMwdLNFi7MtHDBXhW
 U4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767817586; x=1768422386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=up9yE3JF2/GpSuDP0drzQS4jHQaVrvt4XM0YzFC607U=;
 b=qAnEWI76JokYEKoMmZbxaaGZkRtmnMn8UG0DG9ZuiFkdNgIX1UyKTZeOvR/ih34D4J
 Xu1gKluPbXQpzgaHqpJAPVFiWYsEa1gbly5/L2RQmJA6zE7p/ctnxE0gkU+fO7bFNi2u
 gMoz//wHAbmFTZsdLi2o8lHZmGOBkpqcN+XZh11nlKrXERsvF7NkWr1WPOn0mnES9/hB
 wARv+rOF0tMIeaNeos7uqCu49EC22KNINoeiSin6W5aG0vWX+cuU2LQTMBBCgpG5Jcic
 7A1r7gpo6mrAGe/TvrIl34+5Njcq9IGI8MCU0xd31ysJaqCFwcBRtSc/oaITiyTWYRhb
 5pOg==
X-Gm-Message-State: AOJu0Yy/XERcJe/GAAF1xdvjFn0LLcfx6R30UjkjcsCNz8K2NjZAKWWO
 f2bIaIFrjzJGm0jNjYbEh2k7yDRrrmDvPSWYNp88bp4bhGEGK0ngAD9bVKvmjfxTDmXghcuunDX
 7aw5jNH8=
X-Gm-Gg: AY/fxX4dCKuGmcJhA8EbpffDqEg/LKGMKSE4a8SlFA7CTKxRCsU9p+iVW9rDWTeIym6
 txROAFry/ojNMjXE7FuhuKWJL9hbooqyMGgGvTWI2/fOaVvZeIZO3KgGRZ7yZWIc64CYS8k5JeP
 JdF+XVow0mzpUOQQGcMPVemY94Tjgx+CnYX9UWVkhEmx1DuKsmrT/2B8huGkvTs0r+mJS+XVZn0
 PvaMYBl3a7zVJOblB8W0oOblXVESvtlzjLi/B2JCSS/sipsmWc6ae9Con4DAVUfhY9iTeFjKcK4
 2AYjIRir1BLp6mzxAYvPhFRNeYIDytSFRiRWmEdhENK75Ot/c3z9BdRzYkZPGYpa2BydCQdt4rG
 AOeDx6Z36JXNjO05x0lZTrFOO8KMRAIWQZmT5rM5iUh1LDFDcAB0HTK9NjJXtreaEx4lzb205dy
 EYwPHDo08yLTGmTYvJ97T4XS1vYnRMum/nu5+bXpBcnuEII5d6j80huvoaFLSB
X-Google-Smtp-Source: AGHT+IHo1i4KiXFRrEqj37mys/rTeqGD05u3X+4QwBFU4/42B0QEkfWU8OfrUJ0+OcYB4iS+Tp0EYg==
X-Received: by 2002:a05:600c:3152:b0:47a:814c:ee95 with SMTP id
 5b1f17b1804b1-47d84b17eb9mr47694885e9.12.1767817586523; 
 Wed, 07 Jan 2026 12:26:26 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f410c6csm125746115e9.1.2026.01.07.12.26.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 12:26:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>,
 Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/7] target/xtensa: Build system units in common source set
Date: Wed,  7 Jan 2026 21:25:53 +0100
Message-ID: <20260107202556.55787-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107202556.55787-1-philmd@linaro.org>
References: <20260107202556.55787-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

These files are now free of target-specific symbols,
build them as common files (thus forbidding further
uses of such target-specific symbols).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/xtensa/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/xtensa/meson.build b/target/xtensa/meson.build
index f8d60101e3d..69c6946420a 100644
--- a/target/xtensa/meson.build
+++ b/target/xtensa/meson.build
@@ -24,4 +24,4 @@ xtensa_system_ss.add(files(
 ))
 
 target_arch += {'xtensa': xtensa_ss}
-target_system_arch += {'xtensa': xtensa_system_ss}
+target_common_system_arch += {'xtensa': xtensa_system_ss}
-- 
2.52.0


