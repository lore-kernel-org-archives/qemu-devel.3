Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B76FBE8B39B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 05:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnVHH-0007Gz-4t; Wed, 04 Feb 2026 00:18:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vnVHF-0007FX-HT
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:18:09 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vnVHE-0007lM-38
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:18:09 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-35305538592so5379843a91.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 21:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1770182287; x=1770787087; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LRPOC/3+XMfcKObCsTL8Q0o11X+pdIr3Wyk3iUXtQg0=;
 b=LOoXMTryBLHp0xslmvFiz72AW0smDzcSIjXAiGk5xpHLl47jeh+6OkKuIK3iy4zS4S
 O12LJibvzjDJ7v2Lk0uI5W2mcErzMR6Cs60x5jZiwuABp7J/a0TUHfG1nAHZvJeud8M6
 QD01F0s+ZkkKaG9/A+L4RaryMrCerDwqEZ/jfSg9MfUfTKWjnZT7EaJvnO2+nLVo5r2d
 p6vk0qPPfsd0tsZSJxzyF4hlfIzAHJ8ARizc9csMUdecdW9u44YEWwBVoWaPqwzvLWKr
 GC4CJhnEnM9/8HGh7KwhB/vAkXjpDGElPhStXCCssL7VVeTNk8j964Mb1YZAbvDaiQh8
 vXjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770182287; x=1770787087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LRPOC/3+XMfcKObCsTL8Q0o11X+pdIr3Wyk3iUXtQg0=;
 b=K5FCUIRAbFolZthY2d+OU4LbLYR6DECzp1mNYkGMSC7v8/aV8hjsXwgPH02BtNGvWY
 x8fjNpT5xsDyEwfXBhF8EbTLuEKIP/QD6e41tK8VgQKQc7X8Z5aCXuuoRIAlby03BsQr
 tTc7Tax8wdbvseOqjmTR5drPJGUZB/aYsR3eoHm9mpHbBr+3lQyDch83DA0n7YaelxRb
 9NkavnQyYMQvvxDzHwhf8JjXAUfL54X3m0CbHN4Jzd2E+OQsF4xkVfZczdsl9IcXBOZ2
 hEvOfxOgW+VNxBeiDNY/SQXwM+6wxGSAFPIwgDySiGlU4+bv5UuwBypxnCWh/z9iLBHc
 Agaw==
X-Gm-Message-State: AOJu0Yx+sNrgYmEMn3rycU2X0ZGtazTkP+oOkbjNTQF8xwM9PCnVGRH+
 fTRm55WFfP47BGWXSYNTbx5ND7KpiPzT/ICaKFrmaU2t6TuJS13FAdKgWDcM8r3MH7BhjfDuzIC
 KVCEM77clzJA0CquOYBVgP5t9BXx04YfWORzcrUQeKgN0+1uiJKvoPwOAhSpwHRge3XsB7oYmnR
 4sikoqRGUP3U1U3txu2f1pbRHOvSNuC6bt9Pp4EBuZhsRv
X-Gm-Gg: AZuq6aJtIfE6uZBWHkFph5xUf6HoOA9l9DMczRBHLCnumvC79W3fdI8Rx9urwGDWJ3x
 zbOAfI36KO2YaYFLS3Ixd/7dGBT31euC7NqR8boIxQXC2tx/jPAp6/rm5g/W8IgEv/OeckpxHUp
 Ocx+nAo839RNIZF8BzCwFagjbGs32mrH3xWM7t/OduN/+ma0usUFfi+Me+RUE2ZhbONAnDZKreh
 L4XcylY8IEZsdZiSheeSFmUeZqrmhmr+r9VwGYvn6SMHH5gmAMGSkfwZci6Gx0XHkWWAgUHVkO4
 OG7cyBnWhMAbpoOBXKdtUPXAzo8ZkuNDiK/dEXg9f8/BgvBQY4NQqSNCMZbsY4tMLM6HcAe+0c4
 Cbc1ptOEhl35UoEkJ4oMyH5F658r8Czy1nzVD1kcTq2NXJQAu3GP9DUnNFtIFy8ywUjCNnvwGG9
 YLNC8+qfjOPnDQ7N+aEElTpLuzAYhnXeQBVZ3SW1Dd1RlVLFYmLEmR4XkLmtlw6VFCFly36G1Gu
 arXTg3sNU7zR/Q=
X-Received: by 2002:a17:90b:2fd0:b0:34c:a29d:992f with SMTP id
 98e67ed59e1d1-354871fea80mr1694194a91.31.1770182286594; 
 Tue, 03 Feb 2026 21:18:06 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35485eb8d90sm1266314a91.12.2026.02.03.21.18.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 21:18:06 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 01/19] target/riscv: rvv: Fix NOP_UU_B vs2 width
Date: Wed,  4 Feb 2026 13:17:37 +0800
Message-ID: <20260204051756.667397-2-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204051756.667397-1-max.chou@sifive.com>
References: <20260204051756.667397-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1030.google.com
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

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/vector_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 5aea553814..ec0ea4c143 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4972,7 +4972,7 @@ GEN_VEXT_V_ENV(vfwcvtbf16_f_f_v, 4)
 
 /* Narrowing Floating-Point/Integer Type-Convert Instructions */
 /* (TD, T2, TX2) */
-#define NOP_UU_B uint8_t,  uint16_t, uint32_t
+#define NOP_UU_B uint8_t,  uint16_t, uint16_t
 #define NOP_UU_H uint16_t, uint32_t, uint32_t
 #define NOP_UU_W uint32_t, uint64_t, uint64_t
 /* vfncvt.xu.f.v vd, vs2, vm # Convert float to unsigned integer. */
-- 
2.52.0


