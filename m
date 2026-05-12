Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CD6CD484E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:29:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgW4-0000u2-Rw; Tue, 12 May 2026 02:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgW1-0000sl-3c
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:22:49 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgVw-0004KH-OB
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:22:48 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488ba840146so45138675e9.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 23:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778566961; x=1779171761; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HJjHhanPxzEzFP7iU69XomdUjQFJLtfEo/O85wyJQto=;
 b=aVsmIv6hkPN9Td+//YW39dJ0HMHcacFlTl0q4X1yN3PJBtikuw3Gs3VI/Hfzq2IVfA
 PID2gFjnJdGLvk4+RKhVBSoqH86TpVxQVWZQKE2VI1omrq1N90IMhuroSEFn2Mfx+ZYf
 RTAx0zfHHFS/Hrdl/QNqJaqi8MT5un+1ndkzZL2l3KAbyY/UsvEUc/SVpRzgdklZZRC0
 c9p9pQhk6uPt3nmOPxkL9dCZQDdEE9Udj6wVgAKN0AXGQMwJF2zMoi6fI6yz/myQiUgx
 5RxKMAt+4Hm+/Af6PhR1FV9eViwuA3M0n+a1vEPBc+Cuqs5Lm2GyY1ZynU6TBO0utxF8
 Gbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778566961; x=1779171761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HJjHhanPxzEzFP7iU69XomdUjQFJLtfEo/O85wyJQto=;
 b=e7L4byBA50N2I5JMYP8EkIkdX0kK3CrBrfonjfOckiAsGv379cWxqEjFJhtfM6uOtH
 KoIwr25WCjY9H6Eay9idX4zyzq7pTOSPGXaioPqoCBw/212sZ0/GX2/rfkon5EcXT2tY
 YPgOTT3tyJlmCLHiwhmzx96wxiqOfVWRqTUOKvZq4b+l2NR8QPu6dEn1RoL21kfx4iHk
 NRNZEXKjug+VaRaO8UEZPcF04NRv3hS0LpdgQb5WO4ibxdwpRxRZb+apLmGXAiRtLAQv
 Xq/8WqZdSeyZDVvXa/qWF0DaS8q46Ibrk8TVUmLtM5449kXYISd9ytcLYi7BvMFdJMc9
 nUag==
X-Gm-Message-State: AOJu0YxwnsS4h5Z87R1JSrwF4lawjpj53fcfZtRDVzZvpM49NhfqEh+Z
 5dNIq2kikZuGq7O9bEdihoXUOu1cogxg0gpOdbDC7uq1zouIpQ5tROkH+WKkLE7dZ21cn1KhX9G
 gY9HH5jc=
X-Gm-Gg: Acq92OGvXQYz8sbB5Cta8ixqaposZl1CjqGNqQYfl+hugldYdRKSc7NW3JZltndvA07
 LGMgzZzEhrE3ZSgtl+DP7ABhmQE/QvSar0pF1r8x/en693qP0y/h75wpJdATSkYhjEzK99YxVUy
 ZrC4o36dA80sirToFe0Svc+/T9mPCJMiEMVWTHvGDXCnwy+yvTjrltOHsgOsU3FiXnLe4WN9Llv
 XXqy9ejUJjGaG+f3IgcpOnlR9Lb6oHIirlUtY8nhe89I2SWwqxHyle8SSCaXJuZLjLVCRVIKW50
 w7uyGgF2MVWLuK6MCgu1T4IDOdrlPyHYg7Gq5s6TOX15uMxMWS2GnxxQWRX7jIQrtiDc8SkMi/h
 xmGNFst0VKOKx9iQQq+0SZQ/36op78oPE4YxRVb6S4rpCJHvokg6w3PE95yqimNHQdQLz/o5Gmg
 keU2teiZSrPOL3KbxD3Fg2YBYmTy5vOgT3JcAeoNHezZsK+G6CDxVSdhoJtuJbbiUI1T1GgC26P
 IsqEizejwg=
X-Received: by 2002:a05:600c:8289:b0:489:201c:dc46 with SMTP id
 5b1f17b1804b1-48e8fe52c6bmr22077815e9.12.1778566961291; 
 Mon, 11 May 2026 23:22:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e908d2c77sm23515565e9.12.2026.05.11.23.22.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 23:22:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/41] MAINTAINERS: Step up to maintain core machine code
Date: Tue, 12 May 2026 08:21:09 +0200
Message-ID: <20260512062142.67998-9-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512062142.67998-1-philmd@linaro.org>
References: <20260512062142.67998-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

The 'Machine core' section is orphan. Being acquainted
with the code, step up to maintain it.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Yanan Wang <wangyanan55@huawei.com>
Cc: Eduardo Habkost <eduardo@habkost.net>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260417110550.70068-3-philmd@linaro.org>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93a1e4e4822..488d194a41e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2037,9 +2037,9 @@ F: include/hw/i386/nitro_enclave.h
 F: docs/system/i386/nitro-enclave.rst
 
 Machine core
-R: Philippe Mathieu-Daudé <philmd@linaro.org>
+M: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Zhao Liu <zhao1.liu@intel.com>
-S: Supported
+S: Maintained
 F: hw/core/cpu-common.c
 F: hw/core/cpu-system.c
 F: hw/core/machine-qmp-cmds.c
-- 
2.53.0


