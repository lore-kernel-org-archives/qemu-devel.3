Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D94CBCD343B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcuC-0007TU-KX; Wed, 06 May 2026 10:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKctz-00069A-3r
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:07:04 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKctt-0001rU-Us
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:06:59 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so53014675e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076415; x=1778681215; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=a5iXLQfpWOvAV/UnU8NyG6xn/W+EexUkBDNhnuMTiJo=;
 b=EeGqHT/naRydgXXjLfOBEuu/W1HNACH7ZLXna5CVx2hCjXcrCKd8pPAzugGP8l0DyX
 UoO9welkeYQrBwBJS+Ezso7hC3XOr20dN2oJxbDfdlnxfjygppsyK5Imf0f5ACHzeFXl
 JBZ4sR5wm3BM60tbrbqXIR4hGheVsFOmel3R5b5R5iuxEdsk7UgOyVB2S2EAGbdO5p9N
 vRYd9uaUqQS/OWvvBOZgpATdEIXTDjAlLeQuWJM9G+Q0Jh7orwxOr+Uhyc91+kKDsXT3
 74cTmmX8mBT9z4CN2at/xXOldrtzXsNCg3sCRrlHLiLeFXhT0mRtgLvu0VrccMZIByHM
 wRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076415; x=1778681215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=a5iXLQfpWOvAV/UnU8NyG6xn/W+EexUkBDNhnuMTiJo=;
 b=pBLtkFsIZe1t3bxiBZ2KdsAoKMzqo68CXyq9z0D9vN70PG86yVeW4vhEXGnVEKRwXS
 4vFN7iMN4pxhFOEUxtz9AYLqkMCDPH3xfI1SSQUBZrlx9ayVE6OTph691cTpdErQzKCQ
 A8yiap6AJRkR15aA+tgmTPlq8aKkTlavuVpPyAu6tLC59OaDr6lxovqW8hoa7PVcZBGj
 rRJoeOHBBjNhSmvPeuEewGcr6NRgCdYgniD7r0xPswh5zTSgVqLieQCkVRtukXcG/4D3
 qzthK6HkP6Rn2ZmsIWWcfv1EYkosTOJje5fcg0wRBJTp32ZQmY0bc8Cx71VhDNVG0ZFg
 30+Q==
X-Gm-Message-State: AOJu0YxkzPoHDwg+oTGV8PhGN/QsKKLUR60WkChBStn0Peve7S6A5EgN
 u4qr3N4ffYONfxuGIjcXmCz2IfDeLGWXLDgFh4R1OHq1kyvyayMzFEgDaGmIrGA1fW+8yhoosYp
 mmkOYyvM=
X-Gm-Gg: AeBDietfTRC5ETTRnG3O84k4+H8X2HRQ/GcAd1yboNNdEWc4+uRSPdfg1uAqsTrxsWG
 46lgov4XS6zWxbiga/9Ucjhq3vDFhLgSMsp0BqMxohoNltXdw7+XEI72GFhdRz1+tBufdXXPxfK
 sMdk0gscGwcuH9DYmSq2m9/teTju8XuCXwKKm0sLCxqqYx5rHmyEBt4TIYe+HhhPq0Fjdaa3u6Z
 Ikz3OqhPWH7Toq/RqEz1CsW3Z3GRgZHnr/h6oCqon0Y5BE9aixpS/sdJWI6Q58lamVhQYoQtNGd
 fb3e/2xpyycaaHp8eCvh3uHt/22df9K/C3TNGM30FdgtuosaYs6u5enaHngxYIYauSTB3ZW9jWC
 YQ6nz3vKhu1hgH4cmSOQMFFSWm95bsyKt2C9a0Y2Egggw82iOmkYcPy0xCCjueJT/+mQ/JPJc8+
 K8b1Dha5rc+Txoq+QBfDe5u9DXBridp2pYIVokwoOoXkeVhg5JG2pSxBRe72jUhsbDBq9eYlaI8
 uZyBuXLqIbrUREqjvi7mg==
X-Received: by 2002:a05:600c:c094:b0:48a:8b02:ae91 with SMTP id
 5b1f17b1804b1-48e51e20638mr45155475e9.11.1778076414595; 
 Wed, 06 May 2026 07:06:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538a50d0sm83933145e9.5.2026.05.06.07.06.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:06:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 087/110] target/microblaze: Include missing cpu-mmu-index.h
 header in translate.c
Date: Wed,  6 May 2026 15:54:59 +0200
Message-ID: <20260506135524.20617-88-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
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

translate.c calls cpu_mmu_index(), itself defined in
"accel/tcg/cpu-mmu-index.h". This header is pulled in
indirectly via "accel/tcg/cpu-ldst.h", but since we'll
remove the latter in the next commit, make the inclusion
explicit, otherwise we'd get:

  ../target/microblaze/translate.c:1620:21: error: call to undeclared function 'cpu_mmu_index'
   1620 |     dc->mem_index = cpu_mmu_index(cs, false);
        |                     ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-Id: <20260423100612.27278-9-philmd@linaro.org>
---
 target/microblaze/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 8fee5dbc337..bf8f864c324 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-mmu-index.h"
 #include "tcg/tcg-op.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
-- 
2.53.0


