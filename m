Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8BFFD45F1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:25:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvOB3-0007cr-1C; Wed, 25 Feb 2026 18:20:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOAv-0007bA-N1
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:20:15 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOAs-0003yo-Ac
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:20:12 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-483bd7354efso3547265e9.2
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061608; x=1772666408; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PKDinyTcS05CToVvGZStWK1BmUi/DlgLbbY3qxMJPtM=;
 b=qzka5pbG8p29Nn1YPFFbjqerAWKu02n4F2n5pLD6zl3D5FWOsdkVSdBc1f00//wfTC
 3t89gYUdZqRBJwO4t4EmXptFi8xp6dY+QEQrYSbhNt9GR7BBk13AloqntApDRl3MW0vv
 jteRKvekTRwAz5TfT0uyOHl3+ceT/4b/Nc0mT5s5Z6dOdLwGyhXAUNKBvWSiYG/B93q+
 XyU/XD/+CZygvixaaZD0G1VxMR7lk0domcB78qgyxgBm7mLw+XYiBtPNbx3QGxHlYA5Q
 sRjjte0EP8CnR9deu9Kd2QLNObVKuWHkYIRoIqcoKj6gZUNG2P9ut12IKqrj/3aGROpx
 sc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061608; x=1772666408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PKDinyTcS05CToVvGZStWK1BmUi/DlgLbbY3qxMJPtM=;
 b=B8SS7HVt+unwu9+UMbZ1riVK4IXnOpdLQn49ILnDd4S2XUq7hiNBG/T5FFOzhlN81U
 6YdDORRTXmrWsJq2bo11St1dz3zhUie6IJQcAj5cMqGALJ38NFU9WhhIJErQovO42tyT
 8YMEER+VPs1nLuhNEgtAwmdrpC5TU4DaseNzKZqL3Z6yNQUfC45FuH1R1DBlQIC4SwJd
 FM0mUWctMRT7QtPOgchD0nuZlcXVmKgwoehjgrOzYBBdkGoH0utlYEal7ZwwIqZLPP5F
 PO/IPN1zij+aXl74RlNwCWUJi93Bfu2VkU2J+jql7Yovba9opXpfZLWqJsaXLw7+zdwf
 0iCA==
X-Gm-Message-State: AOJu0YzVdNI5XTDs0sOb5CZ8y8EfwCWEH0fFtphSdNYyAUDQ7TmyFMtP
 XMoqaqFCBhvFUGPXYkCrYkP2P1byrcKCZbioixAM7wz56GLR0itlBmoo8oqioUpvC5HNHLjDDjM
 6/K8yiGY=
X-Gm-Gg: ATEYQzxq7Flj9/rqFiCCx5aQ87vtiwkk/XC+EJG3yaVIHM//DR2XSh+uYbE7l367be4
 yxekaVdJNGC8dFSWFz8eYjSk7045hioGph2lCa3lstDBYTQF+rlURwAiVo8c8K5mvKTvVd5J/Gq
 zu4oV6DZHj1NVRpFt4MwYd4vyiFABl0/3UzGjZ04xZ8p6Fw2LD6OcxzVAheuW0Kg3PcpKNV7lpI
 tlr1uGaRCVCWoa0TH+g0bKttn9V2OlcezZOkHKsWxyKhq+FJMUAuUgghUPxQ9bBWIGdypNSnyQJ
 xSH34MrScrie4PLrHpX3ezcScHKDKJ72eYvt/DU9rSR6UwxA3Yzg6PTVr7pvqLBZxXB/2l4vwpa
 /kAkdtqove5wKAy2gOyIJNk/xlNuH7VgcTQf3KMs1utbojo8dbU6D4mGB8qoHH0VBaxk6zQbnhv
 Q3Z/o95pnvei9SEpdm8rpujq35p8S1JcTwIZqdB4A5/cHSKZiPnKfRFK0EgBrccanDEx0hAW8R
X-Received: by 2002:a05:600c:1f85:b0:477:a219:cdb7 with SMTP id
 5b1f17b1804b1-483c2124d88mr44339585e9.0.1772061608448; 
 Wed, 25 Feb 2026 15:20:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfb77abdsm21449905e9.2.2026.02.25.15.20.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:20:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 52/70] target/avr: Build 'gdbstub.c' once for system single
 binary
Date: Thu, 26 Feb 2026 00:13:52 +0100
Message-ID: <20260225231411.96482-53-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

There is a single qemu-system-avr binary, but by moving
'gdbstub.c' in the target_common_system_arch[] source set
the resulting object can be linked into a single qemu-sytem
binary.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260219191955.83815-45-philmd@linaro.org>
---
 target/avr/meson.build | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/avr/meson.build b/target/avr/meson.build
index 3e172bde1ce..af5e7d63741 100644
--- a/target/avr/meson.build
+++ b/target/avr/meson.build
@@ -11,10 +11,13 @@ avr_ss.add(files(
   'translate.c',
   'helper.c',
   'cpu.c',
-  'gdbstub.c',
   'disas.c'))
 
+avr_common_system_ss = ss.source_set()
+avr_common_system_ss.add(files('gdbstub.c'))
+
 avr_system_ss.add(files('machine.c'))
 
 target_arch += {'avr': avr_ss}
 target_system_arch += {'avr': avr_system_ss}
+target_common_system_arch += {'avr': avr_common_system_ss}
-- 
2.52.0


