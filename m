Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B71CFA46B
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Nov 2025 18:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNFEz-0007DF-GV; Sun, 23 Nov 2025 13:55:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNFEt-0007BC-GQ
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 13:55:11 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNFEr-0002rc-Rd
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 13:55:11 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-42b2e9ac45aso2092185f8f.0
 for <qemu-devel@nongnu.org>; Sun, 23 Nov 2025 10:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763924107; x=1764528907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UOo9AhVgtEawM3gsfM+gCMk6lSM7pziegoxg2/plQqc=;
 b=I7CmylABXzrpMI0zcSF1E8dZoLWd0lrhdxbyQd6JKcPhHlc4gdaXHuyDzDrEPf8XYq
 ru1STaa4Q7rAF+DQ+Wk0oIQHZRSvex7C6x7PjXgS8mGuYIcZ+LOBPyiPlGoVdZOuuYQL
 rfJNDGwamZyRXjLs2gWGlW6tOBnojjU7VuxpK5NYjJlCOb/azPVMXovTAzG7gGU5N8sf
 M/JTSBb9EhptAD5mMhv26wJIeUkjFWJpfGindJl7IiBgpkZXE9ZQzhotaFUhvwaueUAL
 kjfMK+fbT7ErnTwfIqK2d9x4Kuy3K11d/y8pGMdIJiSt/Cyn2pBMhGqbD1GFce59bp3/
 iq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763924107; x=1764528907;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UOo9AhVgtEawM3gsfM+gCMk6lSM7pziegoxg2/plQqc=;
 b=jtSNeDUGY9ELytttRvZce5NXTUl73kh9mMljULrZ+Wn5tsX70WQio2/PbjhhAyRhes
 B5yJp9lXfeFivAYShgWONXXePK8t4wsYPhxuF37eOYF3BVW1kp9KJjtb9HE1kb7u8BtP
 gVkSJZF0TSFOATzY5Irh8+oX2apbCJLHsGCO4jCyK4ZwDESYNhwmoq7qQAhMtR/TLDGs
 ckTyscEH9pyOfrizWvRklihTWn6CURu0VZ9CT7ts41GRSW5MJFTHGkhE4JBI+PB/EQEP
 a5V7qh8RzTO/DtUDd85LpWCdaE99pRXI6wqWJssnOKPaT3C7nrpD1JtY3PcMQQ8c3+Z3
 ruqA==
X-Gm-Message-State: AOJu0YynoYm8hNziDbqHzUHABJiMkO1c3iMciR5g+TT5OHTVzalrGu+p
 uWE/NRSbcJKWajvXewabVjib+CZ/C1WWnSI3M8mZWXQeYiexNins97CaQf0p2fj0fhhDjJ7rcIf
 OqvjLWfVXvg==
X-Gm-Gg: ASbGncv1iC8Np/zXMe49bBDRF65658p1xQ/6uQ5Q+FSuLeDqaVNvHIT5QgaPupPuTr7
 b06UR/TpNFkwxZd6wyHuBVjEKW319xQ8On4ZtmXortdPux95IfqPeR1JxNCn/HkXU5N8VcKaWzc
 FCXPEE6mNe80aA9XGCa7d8+fz0A7cFEQKPgBps6JZgdb0NBk31bKjsag9FRDcoNrpX4aXukmjDo
 xDuoqwb1i8pe7xINvkxRzeuU0k1SYyTj7G4mKAeU4crof2yGrqXJRX34UkeJtJGt7LmSYPotSHH
 6NFA4y729J5vxsk4lJF1yF1qGW1oGBuNheLCxsVNjo73y0cA11zeshYgorSTHgS+oYi6yiPH7n1
 3yD3ohiLbwS4SfgNvXW1aCtc0RybZae93t7yrgILKt9thzYgA+8u435sIa+M98Y9q/e5YP9sR6g
 E1wR+dQ5CJaoKz8r9PncdAK++BYm2YxmucczH0Fa3WSyW8cps6WlOpMuitMmP8sEIgAb5mZoQ=
X-Google-Smtp-Source: AGHT+IFOes67yZUaaed8vkVQAgmA7frl/MDdRlwHE/aH/XxKJ8R+6yMyLEwsMLfJ4J/UhRdN+MB4jQ==
X-Received: by 2002:a05:6000:4210:b0:429:b9bc:e826 with SMTP id
 ffacd0b85a97d-42cc1d21287mr10267850f8f.53.1763924107505; 
 Sun, 23 Nov 2025 10:55:07 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cbd764dbesm20613631f8f.27.2025.11.23.10.55.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 23 Nov 2025 10:55:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.2] hw/pci-host/dino: Correct PCI memory access to PA
 I/O range
Date: Sun, 23 Nov 2025 19:55:05 +0100
Message-ID: <20251123185505.53503-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

PCI memory transactions above 0xf000_0000 can access
to the whole PA space. Fix the one missing byte.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/dino.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-host/dino.c b/hw/pci-host/dino.c
index 924053499c1..34aca429c98 100644
--- a/hw/pci-host/dino.c
+++ b/hw/pci-host/dino.c
@@ -466,7 +466,7 @@ static void dino_pcihost_realize(DeviceState *dev, Error **errp)
                              30 * DINO_MEM_CHUNK_SIZE);
     memory_region_init_alias(&s->bm_cpu_alias, OBJECT(s),
                              "bm-cpu", s->memory_as, 0xfff00000,
-                             0xfffff);
+                             1 * MiB);
     memory_region_add_subregion(&s->bm, 0,
                                 &s->bm_ram_alias);
     memory_region_add_subregion(&s->bm,
-- 
2.51.0


