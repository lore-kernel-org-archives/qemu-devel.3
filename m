Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C73F327CB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 08:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFSZR-0005BY-Lj; Wed, 22 Apr 2026 04:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFSZJ-0005AW-Kl
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:04:23 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFSZI-00014S-3j
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:04:21 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43d7645adbdso2770582f8f.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 01:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776845058; x=1777449858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BDE5bBL6N8uC5afY0iLuv2ls2xOn37nkGwCYYiB0pHU=;
 b=N0rGug4pv/HItCfEbhVHnCItTAXjxUVNgKW4WLvyYRydARg2nu7pNlMYnkg98Kk4bt
 RV1zeYuK3C3FLT5gSsJzVjBu9HN9AKqLyiT1XhjkG73e0h110dBi7yagTw/quxlg6mj0
 GzFGXoKswMXVpBMaDo5nRWX7uLRoGZBIIJU+JvZLVFj0BUWh3QgZdG786LyuooCYcR+e
 APAhHvnIav4ZcRFYJsJbB/B09dZalg+HiEmCA4lVV6OggWJ8UWFYP2wLAxDysj0ISYT0
 WqV/NRtcae/i14PcZvbUaxF3e3ykpUnZx4aYSIkzwZc6lPYOcybTKrDhFzGA7OlwhZcc
 oi7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776845058; x=1777449858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BDE5bBL6N8uC5afY0iLuv2ls2xOn37nkGwCYYiB0pHU=;
 b=TR3CE9fXCuAfYp3RlK2DxQrnPgOXPMRcVM9MjP87gHoKc/iVmh1aKxRnMxd2wB0xy+
 u6TMLilzgB1dHbpIFvhMQ+LADQn0Xuvxmswlx1F95y7q0Xc/665ZyZ4ZG0J1guB33k6z
 YhRt7vATMIcP/GmO35nF/KmC39K//0i3v1WQ/j0fXKuQIv1Mp3m8mhkAttFL+7pmJ+h/
 ZXjAeTstMESmtYdz2VJr8joO3aYa7fQn6enZXh1j/rqe/jbn9yke8DvATN8+67jRwUY8
 Gf+aCpQUqMUMW7ILnjCYGbP032daoPV66oGSYnYlebbNhKRf5BLZ6pHUxGAnh2NEWpsv
 jq5Q==
X-Gm-Message-State: AOJu0YxmIG11hMoc32wLjHmyPnG+XomoLmi3L3w5w7BJla4M9oI59NLA
 vaMW34+U9yvlelKcTpl+/6tDtqH9CyTRGVGUMDGO/JK5NURmn1ZISS15slVThJjKYrbBYUqPRAz
 eL+PhVEM=
X-Gm-Gg: AeBDiesYR+fm3V7NjWxermfVIVjPOMELrBiCzddlBp7d8EDz9yMqhWl/4oXPHu99qc3
 uo0ySDD2bt+dfoXa6iw+d0fZx/bSkVYm+0ZR2aHtuiPV1a9CnsTDZPj56u1miu9dPEyKndi0OXT
 b5rhat3qV8mUu/t9FDKaJAg7HWMeoegveszuo0Syf1T00pgCNmD8GDnsQ3beLKUT9VM2n9xNq9X
 6S9Exce+3H76TcvtyhacWl9QhVDOmeFhHg1pUF8A4oqmdRG74nEvJ2hsv4R8R/peQ1CZvcz/oc2
 kN7dLbvuMoa9v/43mdqWnlOcH04AmAPDhLbXPLvqM0l0LvtBBwzSSgI40Cs3n5XQbXDzZ1lCONX
 b76+yIhkUASN8G6lk2QEv3OSsqAVJK3Rrta1RrgxybfAfwbEmo+Os5GO4MTj1Uo0JjT/3j4yiG6
 UN/JNxgodIOMI8jBAUNCLaCTrjvomQ1H79QPZMMeh0885XdQs6sYEM71bq/1+9EWhL8r8JapeHX
 VWx5toBUiW0CfZbuvmJJQ==
X-Received: by 2002:a05:6000:1785:b0:43c:fc5c:a9fe with SMTP id
 ffacd0b85a97d-43fe3dbf4e7mr32631458f8f.20.1776845057616; 
 Wed, 22 Apr 2026 01:04:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e46471sm42660923f8f.28.2026.04.22.01.04.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 01:04:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 01/10] MAINTAINERS: Remove my unused git tree locations
Date: Wed, 22 Apr 2026 10:03:56 +0200
Message-ID: <20260422080406.62638-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422080406.62638-1-philmd@linaro.org>
References: <20260422080406.62638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

I haven't used these for years. And as explained in [*]
QEMU development workflow doesn't leverage subsystem's
git trees. Remove them.

[*] https://lore.kernel.org/qemu-devel/CAFEAcA9xCN6XMUFmZ_QAn617W14FAzi4D_H1mgSER10otTtQMQ@mail.gmail.com/

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1fe9672e41f..ecd236f818d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2265,7 +2265,6 @@ T: git https://github.com/jasowang/qemu.git net
 
 Parallel NOR Flash devices
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
-T: git https://gitlab.com/philmd/qemu.git pflash-next
 S: Maintained
 F: hw/block/pflash_cfi*.c
 F: include/hw/block/flash.h
@@ -2864,7 +2863,6 @@ F: include/hw/nvram/fw_cfg.h
 F: include/standard-headers/linux/qemu_fw_cfg.h
 F: tests/qtest/libqos/fw_cfg.c
 F: tests/qtest/fw_cfg-test.c
-T: git https://github.com/philmd/qemu.git fw_cfg-next
 
 XIVE
 R: Gautam Menghani <gautam@linux.ibm.com>
-- 
2.53.0


