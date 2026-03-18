Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8722D107BCF2
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 10:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2oBn-0001T3-R2; Wed, 18 Mar 2026 06:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2oBj-0001RR-5D
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:31:43 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2oBh-0001sQ-MZ
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:31:42 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-439b9cf8cb5so7576067f8f.0
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 03:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773829900; x=1774434700; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Yr8oa0KZPJED/ap4UIxqQ/hv0GrjFZS5ezJZG5FycQ=;
 b=owV1Jq9l7qun5V03ufkFpNy04SCqHhq/aaeqOrExjQTS0l3QVC+KBTCmJt8PUfDthu
 aw4Tj0dYtaqkK8fjJEM/8wFS/AOHT60hFWBCaBlX0KjybwWF6lclN8hX4zOjz2iFSj42
 edA9L5a9mk3pH5G0s58XtXSjdlS6fRLxMP7Tp0aYM0R35ceLHVwkqliuVujzWEQ9KJHg
 80XdWihg6HWcp0sjsXJT/qGncKaypoK/UcM1SYWO44PELoL3+PDAJfmkbdS14aUcpaz4
 Y7PXROOqF30UH8Pv0ZZZjdZKpDvEUS0KabcgzBHhHh2GF3ZC6IHCSleoZFfb61hxzdm2
 YiGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773829900; x=1774434700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7Yr8oa0KZPJED/ap4UIxqQ/hv0GrjFZS5ezJZG5FycQ=;
 b=sx4YEiyPqCC0xsCFZqNJJHK9FYMwjk8aqZzifAXW+JfDRptGX2+l0htS21h2I4fpoC
 GHOCLBLpYzON7FpWCAe33ezR1jbaBzvD6IOjiCWV6+vXvTRnpWjcbgPxh+9jp2i55C8Q
 DRx4ooDUwjSimx5w40T4ECgVW7Q2OP+LPbjkovfygSXXnbXpdXb8bgL+5IUVzwwVbztE
 unqaXZ9aEGBuRaSh5C7eULVJfTzmbqO41jp9ANMa3uAZgAz6kRRHyR/ZECOOh+1wwpsF
 /n5DEFOnyo6MlhUJac/0mz4zaeXMNy67AHDdsAvNqqeffTKKNOIw/8JeNSReSYTCpGud
 rVDw==
X-Gm-Message-State: AOJu0YzgPaKh2xSxdUDzXE8Ni6oarSvV35PHjv98wuMpz27E+vw+84WA
 mH1/w1ct3TnyGePQfs9dJ1coyZFe+2PEF0ycpRdgvuhZzLuA2xIos3I8R8cNz1t2j4b5PbRCib0
 Hb7p8WAo=
X-Gm-Gg: ATEYQzwnk88Vkwsq7RGHbsdDv/KQlFFNaXMOEdlhYpqZ0smTdOtPc5SxehGtY38qd4B
 n6+GHONMGtcqGSNR97sgM6vrORITUIXmOMln0VjRllTJ5ElNjCJYGqp3ILEBnNecGpk7TXjCoYI
 OIiz1/YItK8HUhp1jf5ZfSskArpngHVkK68bK3w9D8qGT8if/lzeVPhp2QB2ix/aPSnyhm8FRSO
 HrtLpKo9n8vepQqFOQAEHgESiydmXMM/O5ooHrt74kkWQF2I9kDnw90JlwSV23sw4AXWJDTpt7y
 +XHPWtiSqNnfIAxoQuvPfkJPSps3tCQThv0QYlAK3aJfrau7ZQhCc9ppbcege2uO+LeHgHqWfGG
 Yu/FEJJSxvfjQcQb0fKBz2GKGW12MDPlheDetaNYJ2xXEqTUYFkr8Gu+VueLiH03tZZzdCumHO3
 6grEvUQGL4d3QkK6X3r2HFsuuhWp+ne99J3qy/D7O7/Sa3DoqTOCmILna3YrtDrNdkHlSSIRmn
X-Received: by 2002:a5d:5f86:0:b0:439:beb9:5a96 with SMTP id
 ffacd0b85a97d-43b527c4291mr4954019f8f.31.1773829899779; 
 Wed, 18 Mar 2026 03:31:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b51892228sm7677849f8f.17.2026.03.18.03.31.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Mar 2026 03:31:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Warner Losh <imp@bsdimp.com>, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>, 
 Vijai Kumar K <vijai@behindbytes.com>, Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH-for-11.1 02/16] target/riscv: Use explicit little-endian LD/ST
 API
Date: Wed, 18 Mar 2026 11:31:07 +0100
Message-ID: <20260318103122.97244-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318103122.97244-1-philmd@linaro.org>
References: <20260318103122.97244-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We only build our RISC-V targets as little-endian, therefore
the LD/ST API expands to its little-endian variant. Directly
use the latter.

Mechanical change running:

  $ for a in uw w l q; do \
      sed -i -e "s/ld${a}_p(/ld${a}_le_p(/" \
        $(git grep -wlE '(ld|st)u?[wlq]_p' target/riscv);
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/cpu_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index dd6c861a90e..c28832e0e39 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1365,9 +1365,9 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
         }
 
         if (riscv_cpu_mxl(env) == MXL_RV32) {
-            pte = address_space_ldl(cs->as, pte_addr, attrs, &res);
+            pte = address_space_ldl_le(cs->as, pte_addr, attrs, &res);
         } else {
-            pte = address_space_ldq(cs->as, pte_addr, attrs, &res);
+            pte = address_space_ldq_le(cs->as, pte_addr, attrs, &res);
         }
 
         if (res != MEMTX_OK) {
-- 
2.53.0


