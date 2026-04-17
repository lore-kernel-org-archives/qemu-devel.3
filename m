Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CABE2F43690
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 11:07:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDh25-0000d6-Oc; Fri, 17 Apr 2026 07:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDh1s-0000TR-VQ
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 07:06:33 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDh1r-0003oU-IZ
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 07:06:32 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43d73422431so402215f8f.2
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 04:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776423990; x=1777028790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d7zIbXV3N0b/RBTQjkJbbOoErq2rXFNeYVrRRPCYViI=;
 b=HcfhDPKOKx/GF83a9DpzMPE/JzweHqjEXt+OU6XCHVoaz+edmu6HpjtxWBJ3AEQtnJ
 gZVCWbo2ASDMrGnKE7ZZ+1X95ifH8B18iUbI7WF4yPyyfT1AiFvWt9nvWVijAJy9U9fd
 Ml1quQ7CaZrKOhEkRhDm/v5ptLOB+/YnnSFy2Hh/z+1Oo0AE/mQiStCu7gfChjTA6kaw
 BGOWFsb7e6YK1BZSL3OYKHm+2croeDgGJYt4oWKrrO3Hgi5F0l2Y7wTaXVG7p11RTbBx
 R15t0mgS/w1wTNSxIzOekpnsuC57t8L935MHZLKJEuRiWIdKbnijMcrRBE17jBtBi6jd
 LjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776423990; x=1777028790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d7zIbXV3N0b/RBTQjkJbbOoErq2rXFNeYVrRRPCYViI=;
 b=ZsK/GXxZF3jo63jKyka6V15K9aVH5RXnLRx5CMOkTlfhEQLAa0BrCKsBxbabjelNjG
 NKoCu+9k54E1etIVG5CYR2S9nlKwHNsCEwU5ReYWjxJz97dhL7jxAcMlB3SjhW6PA7pm
 jmE/uFa/gaxMXZPPADc/v4Lt7hW3f7oV2bQZhU3VjXLu6EAyK30x1d+O+N3IZ9K9QOjm
 Mp9a1UjgThECdLmsbQkfvnYFmR7XVrw2uW56FHOfRhBDrUq4tVzzz1JHb8V8Zq7AZMg9
 OuGkgUiZM1hDEgDupE6KrauLHN/fu+dZY9LHjnva6wA9uf9TRhymLgiqICBfQvBDZxMS
 ZUxw==
X-Gm-Message-State: AOJu0Yy9zXZ3OXtBFZSZE1HPg4wssARF73Ta1Be3xoQVJqsd7/UwUOnh
 x5AWgCLtlH+d7dYVMBOcXhCHqPttRI6mKaxZjOtSsHNbVydT6e5LrVopsCtzZC+kBYC3HuIB+qt
 VqqqRtRY=
X-Gm-Gg: AeBDieu3zH4yPQFm3HKInZpgObBrq0xo8Pvyx4EmcMEjtmn/GEP1jpx76vn4lypBeDz
 sUlPqoTnKn1F6wTW67zOaZlsyNDA5TpjULyXfksz0LxSK9JFh/ZyTshlT8meRRxZjJ9yBgjyCf0
 9JIrZCCWnplIDw5ao3oAdPhqVEb1j8mT/hVyY+nQBBRYla7YrZNlAhF1pkg/Dorfdd1ighsUQzA
 biil8TPR+ml7KnV5U9xFtSRuQTs2vOppas0aSj4nHDyjNPpiqDhP1IeCbmUXdKHq+zoFIl2RoEM
 YY0JqAV8MU/3coxig51PXraoyAuykgkao3OxaJ4xtQ1zAhsNJS+49Oi8ChPyPQGoA/5PBbweyT2
 lH04PBslC4C70pSPT+14TauEh57lpXZzIcBcQ34nugFFIi4IMQyd8TrnZoC4dsTSILtraX7mCc2
 YJn5PYZ8MY/rwXoGo2pStZp3NdWyB/NVGtdJ5un+5qGEE5PGbkX4MDZyrzznP+OOkjsyCoTMS2X
 i6AWbokLXjnGl1Q+g1f7g==
X-Received: by 2002:a05:6000:420a:b0:43e:a69b:d813 with SMTP id
 ffacd0b85a97d-43fe3e0d459mr3745009f8f.25.1776423989436; 
 Fri, 17 Apr 2026 04:06:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4daf2sm3504685f8f.33.2026.04.17.04.06.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 Apr 2026 04:06:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>
Subject: [PATCH 5/7] MAINTAINERS: Remove PhilMD from firmware sections
Date: Fri, 17 Apr 2026 13:05:47 +0200
Message-ID: <20260417110550.70068-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417110550.70068-1-philmd@linaro.org>
References: <20260417110550.70068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

I'm not paid to support this code. I haven't followed
it neither, so be fair and just remove myself.
Demote the status to 'Odd Fixes'.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Daniel P. Berrange <berrange@redhat.com>
Cc: Kashyap Chamarthy <kchamart@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d5e766ca6c9..df8413c79e7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2837,9 +2837,8 @@ F: hw/usb/vt82c686-uhci-pci.c
 F: include/hw/isa/vt82c686.h
 
 Firmware configuration (fw_cfg)
-M: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Gerd Hoffmann <kraxel@redhat.com>
-S: Supported
+S: Odd Fixes
 F: docs/specs/fw_cfg.rst
 F: hw/nvram/fw_cfg*.c
 F: stubs/fw_cfg.c
@@ -3955,14 +3954,12 @@ F: docs/specs/fsi.rst
 F: tests/qtest/aspeed_fsi-test.c
 
 Firmware schema specifications
-M: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Daniel P. Berrange <berrange@redhat.com>
 R: Kashyap Chamarthy <kchamart@redhat.com>
 S: Maintained
 F: docs/interop/firmware.json
 
 EDK2 Firmware
-M: Philippe Mathieu-Daudé <philmd@linaro.org>
 M: Gerd Hoffmann <kraxel@redhat.com>
 S: Supported
 F: hw/i386/*ovmf*
-- 
2.53.0


