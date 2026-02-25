Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E6EFD45FB
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:17:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvO6A-0005BH-80; Wed, 25 Feb 2026 18:15:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO63-00055X-FJ
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:15:12 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO61-0002mB-R9
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:15:11 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso13403975e9.0
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061308; x=1772666108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NZbo8084LvFt6DRJ0xDf9VJEW+VJ0Qd7W0M/EfR1IrA=;
 b=T0BCGYYNWm4Q/FklFR2BGowpjbjcKmBRPZVw1J9/OduvVkP5RuXlj+3AwOic93mPVL
 STet/6ZZDCzXEjpj/pNSthtHXpBBon60V3pxjg5pLwKaki5pTtWJKZDccpKuEbXvvdoL
 yl6Kpp9FXokFn+3NDJbEbNyBvKxcyEGpoxPdZEsrFWR7bI1ApPAq5UV38NJeOyoMJX1h
 Ez5VqxF3CQw/DksxzgHUsndx/l7LAnlgk8Vnwjhccpr9ND7NaSyLZPF5KeFkulVFzLny
 7PUpnqtxiQDN0VQjn7K+ex49mHrjFlW+C7841J0hL/xwopeKAQ/2YN6GrJ6/KyU5afub
 YMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061308; x=1772666108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NZbo8084LvFt6DRJ0xDf9VJEW+VJ0Qd7W0M/EfR1IrA=;
 b=STqgivta7BTpUICET84KwxQdRMAfGwrswRUQomTdHAF/HZqbxwmmchqLkzACDlO+aH
 GZwLjS7AFkMQsB0dSgnnz/bP3crZ1aeuomWSyXuq/6jiUQyqWCY1pzsaJ7eHj5G85Uzn
 ZF5isBAtF/pg4qXuMC/K1/KGISBg2ObNrvBb9eOT7VMYAcup6yO0dazYbyytwxzpWHDL
 jqnBmNA+axTdqjdSTrN9aqRZfBm5bTe0ygTIudNrqxTyf3ep/LjSMKo1sFsYHrGMggVP
 ZomysNvioMk3oAuE4m33lGWyPJMCfc0KTWPBneBGDkarakbRfvfzpuSYrIZvKmZCeOzO
 NzZA==
X-Gm-Message-State: AOJu0Yw3hO+m8Fvq6ihR7vDGgU+sYziwubD+pYruIJ8uW8DmpbobE1cH
 03VBHdTl/xI3OTo2VR5bg4gO8ryZ6o9lv2JoZEXgls6K/TmZOQhuMAAHDrZGWoouFKfkuJEmCcc
 elUPbA/g=
X-Gm-Gg: ATEYQzz1BbJywzHsCTAq4k3+j/oHRzPJqZTplY4C27FWJC/v0LGVJZ7V4PePLavYQga
 chNRKvvE5G9t9ZEa8+b3PLnhBv7pXaWi4UDkdCUeRJVCEz+NiGwGi9OOXUnhWb8SUjW/j4FY1/r
 I67U9jGOY6qpTC0PKXioPwqUJbH/Pvl3Go1hNgAPPMMaq/ns3p6GVTRl7/vV5JbjmNXHD5QD4cR
 DcECfaEyTalRoVr91CwWiPCRVwHduRZmly4LBeuqqQdgGVTH35rrGg/vOn7ayfczUkn/1J/5LLt
 igz32ArQR5HKEjG1lxfB9xC9RyD8gNLcqFEhi/l7+iOYCmk7UZRCkehNvX/y+3uRJY5AxOGWLAW
 p4ZAg0Z4ZpUE+jH6LpbpJuZu5qlu0vTgs4LLvvKcrXVLHD5jeHnDUz0WgbFH37t2icDv8tmb+Ds
 g6XqkE8k4kEfTMdQbSo1gIAlUpM6YecrOxOQbLLUBsKRBkq8svkAMhcDh2lYG/t7b4TL4eJGHz
X-Received: by 2002:a05:600c:5289:b0:483:7b99:131d with SMTP id
 5b1f17b1804b1-483c33d6b0fmr13614715e9.16.1772061307784; 
 Wed, 25 Feb 2026 15:15:07 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3addb3asm4443415e9.0.2026.02.25.15.15.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:15:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/70] target/ppc: Move user_only_helper.c to
 target_user_arch[] source set
Date: Thu, 26 Feb 2026 00:13:08 +0100
Message-ID: <20260225231411.96482-9-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Since commit 46369b50ee3 ("meson: Introduce meson_user_arch
source set for arch-specific user-mode") using target_user_arch[] is
preferred because clearer, and no need to filter on CONFIG_USER_ONLY.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260219191955.83815-2-philmd@linaro.org>
---
 target/ppc/meson.build | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/ppc/meson.build b/target/ppc/meson.build
index 8eed1fa40ca..b0d708bb519 100644
--- a/target/ppc/meson.build
+++ b/target/ppc/meson.build
@@ -31,7 +31,10 @@ gen = [
 ]
 ppc_ss.add(when: 'CONFIG_TCG', if_true: gen)
 
-ppc_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user_only_helper.c'))
+ppc_user_ss = ss.source_set()
+ppc_user_ss.add(files(
+  'user_only_helper.c',
+))
 
 ppc_system_ss = ss.source_set()
 ppc_system_ss.add(files(
@@ -57,4 +60,5 @@ ppc_system_ss.add(when: 'TARGET_PPC64', if_true: files(
 ))
 
 target_arch += {'ppc': ppc_ss}
+target_user_arch += {'ppc': ppc_user_ss}
 target_system_arch += {'ppc': ppc_system_ss}
-- 
2.52.0


