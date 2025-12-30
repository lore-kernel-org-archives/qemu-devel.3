Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B10BCEE01F6
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 21:12:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vah0X-0007rO-BG; Tue, 30 Dec 2025 16:11:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vah0N-0007b5-SJ
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:11:47 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vah0L-0002vq-N7
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:11:47 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-42fb2314f52so5776529f8f.0
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 13:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767129104; x=1767733904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kJzV47Vvj6GDTqW3GrUAatkuKHl3RZvRZn1ylCKI1OE=;
 b=lB4QNPdYxx06UzMmcAfZeW0s7kwUHmCx8Hbn0n75v7EeE3Mz/O4RZi4KU6jzE1rD+3
 zeInuYZIrI7em8VcmXS4xmAZrEjhPLR6B6jPbGG7lOBpsv30/SlNyo/MyCsDuRDflmxQ
 GGP44p3+lbz/P1yOwL+MPbFJd2z/TgOoZOttFqYKGstd/aiTJgD8Md7D8B9X8GXZOSHo
 w5mkESdyIT5TzKHa3QsywUL8+vXPKnw4S6DAd/82FqW0yf+v/3flfBv3tN9ud29d0WdH
 IWY7ovpqqqos0HZsjZBttAlfiUzJNlYI+s26DpbFwLz8oSoOHSFm9F3g2u4kLCOHPW6r
 4NpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767129104; x=1767733904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kJzV47Vvj6GDTqW3GrUAatkuKHl3RZvRZn1ylCKI1OE=;
 b=PMZyeSw23jewZGgVnk5tOlT2rjCDZoYfGNIctoeE32t4xr0eHu1l1nbK8YTCnZAZVQ
 6UP2ltJgyPM3aQUlv/ImShxXDrtkpm9AveScMektrYvKllzE79E3B1bI4A90eJuICHDZ
 gQPI/l5r92KyhpBq0IUCKBcC0INoQDU4J0YFud8XeZQk6KrMGRnHXxUiYwBNpgchj21+
 6mJZZg1iksRdZNTUrxfCxiVfgCOeMzQX1bx8tVGFV5FUI6eDjfebIWS/od1LNeduyn9v
 Vi7fqMtpmsE8XNBlYi0aEw31pOKe2XKiS5wwJxxblECNzUjI3EirBCL/9v0ieiz2D+Eo
 Ozew==
X-Gm-Message-State: AOJu0YzfzOVaHKVsVwRETxAHb67j96bburcpqP9FDm07ud2KRvGUNgMT
 unZINW4501gFj/lySVSWUEvw0031cxUUqLtOsefv96sxSZzuzeF9xuru1N6Bk1Cr42K3xTzXOS1
 pz/dUNhw=
X-Gm-Gg: AY/fxX5mAhyhNFRq30ShOJjo26XiOYbGoxzFIHwRutUzAevAi0mFgPvcWINX9sYSTWL
 XS6E1KhSNudZS9ndjZcKPOdaEx6rZ1KJuuKg3aE2lgsyzcgqu+gT1OfZUaGnoVfH6u0cbUTbAyg
 cPcKLAYw/ToeQ7Dx2koCKUm4z7rqaRHgRHeozaS7afsdI/7sGh0En0RmgRCJXjMKcipIFfKVs6I
 YD8JZydCXAN3EPMI85T8l5oN/I4qcD4lCR4sj3gOhNPHCFqNlhx2Chbs+Xr4leZ/obGgVWI7CJn
 LevAus7q3ykpQp9sTwayQhN2i9wfu8PLTuvdB1yxP1D+jyTehUY/J6mSSCy+prDQzmfwacOtEIY
 Kv4nGHc4r0Ts7Cdcg3ILLwUQgdcGkFRxriYr9W6zj+E4GI2QXjkwpiNKCm6c30l4zIYpvtSjyG5
 iehMw9bDLmfea8TRfM7PVRi54BAEVNjcvzoXT2FdzkT4gydExFFX3XzRwelmpP
X-Google-Smtp-Source: AGHT+IESUFX+P0qq9X61GxAWzQv1bRsGAUjPIZ4w/6HIbLxjTvMRVjubDrVPH9ZAuv0foi9Q+bmzfg==
X-Received: by 2002:a05:6000:25c1:b0:42f:bbc6:edaf with SMTP id
 ffacd0b85a97d-4324e504044mr43846630f8f.37.1767129103656; 
 Tue, 30 Dec 2025 13:11:43 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa08d9sm70778311f8f.30.2025.12.30.13.11.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Dec 2025 13:11:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/34] MAINTAINERS: Change email and status of TriCore
Date: Tue, 30 Dec 2025 22:07:56 +0100
Message-ID: <20251230210757.13803-35-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230210757.13803-1-philmd@linaro.org>
References: <20251230210757.13803-1-philmd@linaro.org>
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

From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

I'm no longer employed at the university of Paderborn. This also means
my time available for QEMU has reduced significantly. Thus, I'm dropping
the status to odd fixes.

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251227132135.4886-1-kbastian@mail.uni-paderborn.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1b4fd48935d..cca9b57c02f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -419,8 +419,8 @@ F: include/hw/xtensa/xtensa-isa.h
 F: configs/devices/xtensa*/default.mak
 
 TriCore TCG CPUs
-M: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
-S: Maintained
+M: Bastian Koppelmann <kbastian@rumtueddeln.de>
+S: Odd Fixes
 F: target/tricore/
 F: hw/tricore/
 F: include/hw/tricore/
-- 
2.52.0


