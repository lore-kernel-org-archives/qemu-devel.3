Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD3EC36014
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 00:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UVD-0000ig-Ky; Thu, 03 Apr 2025 20:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UV8-00005q-Un
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:01:39 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UV7-0003Aa-3b
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:01:38 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39c1ee0fd43so1248787f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 17:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724895; x=1744329695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BhwdbMEEM7I3hfTeozw77ZRbF5uiUck6nvSzS4M2Fao=;
 b=NnoEcjkQTlkJ7aaOUQ5hY2221M5LF3x2fY4lwIdEBk0biJ6ssOEafHPgOWo6vvX9Ed
 OsDAwPaaivMFytQm0tNboY8KeI0Ke97suhVKgZ8HugPm3qhZmyRai9/vdzR/uyJFDqWC
 Lq2LOoSaHof4bi5hYE7gy/TMMwPGCgHmUrNrTUBU8e0vgdsTuS/RAOj2WzJkMJO48rpg
 xKSg+0zQZwFX/9XvFRciweHzJ9u/GHQA7qgSwvX9RYt7ItY37S/XXbn3w5DzKZs6dKPT
 67WWtsG88oBBJNsck/bxultD2Hwvf9VxehhhRuYWc3Mk/qkUpCDJ1TDQG8tTkLzZGHls
 jS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724895; x=1744329695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BhwdbMEEM7I3hfTeozw77ZRbF5uiUck6nvSzS4M2Fao=;
 b=CeZXwaD1ZgcAaAuMITRZzLlOjCPE06LnhbnYDZxySrT10IypVto0EX39lTrlU/B8KY
 8Vps3UT9ACOEkYNWh/23BuRoFq3rNJqBdrj0tuvJAnrf/h0AbYZqER4O9me8a7NA4bNw
 0EBbZ+YK3OgR1KV+HI3Z1CoZZ6ZWeHggc5iowQattga3AaHi2kkYnv7o4YPwVa23Hyd0
 4s0Loqq8Z9U89IoiXAJb51Ed74Jt75UdxxwPVc/julypK2knI/q6ajoacoCoHojt/2O7
 z7CQOIV1/Me/e9qaqd1aYcj1JFaQrE4oQg2cXv7aoSSsXe0enVWCZ+Fy+6zNHU3O7xvJ
 0nNA==
X-Gm-Message-State: AOJu0Yx4KSD901/31GtUj/X9rYMeFIwHWEsoEvqXaopOQPt5uoHko9Do
 UYdGkQJ9hxUP43wCk7S1Eg13ustweM40fzYTwpBltlQkWGhcLkUr5lG2fuxxKBzwqxFbLDE2Tid
 n
X-Gm-Gg: ASbGncsPaNGWNyVaHZcxc0W5WZT6UEgAMPO33gLHNuXy2pPzypFXSWKDeQlp2SIp9oq
 jpqfTX9B3E3xW1UtNTiZ1/OaWkUy+3mh9LG4ZwT63KsdH5vEr/eGw9o/0gjLr4FLDnr8C+ZSUsu
 b5x0svyaDDwENj/DU2f93smSxo/mv9N1XBQvCrgetxi/GZQQvgAgnJiFawqm41XXjHjKFs+Zcy9
 QgBr1GC6yRR/fRzG/rI5wPEZ6FihGOWmests5O+S6NWJycRoiLrsldVRVMKCIENvald+E3tGQmr
 wjg2/7q5BXucBFjXvWZ7RapTLr1cV3ad/IiWlTXlHB9uBnM1nHffRpYLx/LuPM2p1ct7JerAKbb
 jYKDCJtJLREKcHA7y1t0=
X-Google-Smtp-Source: AGHT+IHIM3h+cubkYG0oa87gtAfNzRzMiTY8PzYnnVxsVXICp0FTHwnLjqac9P2mx9L98sfoQ9CM7A==
X-Received: by 2002:a5d:64ce:0:b0:391:3915:cffb with SMTP id
 ffacd0b85a97d-39cba9825d3mr820471f8f.43.1743724895250; 
 Thu, 03 Apr 2025 17:01:35 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a7225sm2978752f8f.26.2025.04.03.17.01.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 17:01:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH-for-10.1 29/39] hw/arm: Build sbsa-ref.c once
Date: Fri,  4 Apr 2025 01:58:11 +0200
Message-ID: <20250403235821.9909-30-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403235821.9909-1-philmd@linaro.org>
References: <20250403235821.9909-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Since previous commit allowed the use of accelerator definitions
in common code, we can now move sbsa-ref.c to arm_common_ss[].

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 536e3c369c5..7eb49c7327f 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -14,7 +14,7 @@ arm_common_ss.add(when: 'CONFIG_OLIMEX_STM32_H405', if_true: files('olimex-stm32
 arm_common_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx.c', 'npcm7xx_boards.c'))
 arm_common_ss.add(when: 'CONFIG_NPCM8XX', if_true: files('npcm8xx.c', 'npcm8xx_boards.c'))
 arm_common_ss.add(when: 'CONFIG_REALVIEW', if_true: files('realview.c'))
-arm_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa-ref.c'))
+arm_common_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa-ref.c'))
 arm_common_ss.add(when: 'CONFIG_STELLARIS', if_true: files('stellaris.c'))
 arm_common_ss.add(when: 'CONFIG_STM32VLDISCOVERY', if_true: files('stm32vldiscovery.c'))
 arm_common_ss.add(when: 'CONFIG_ZYNQ', if_true: files('xilinx_zynq.c'))
-- 
2.47.1


