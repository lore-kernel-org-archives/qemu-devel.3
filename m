Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B54BBC27C77
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 08:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHJ8c-0002iu-3q; Wed, 12 Jun 2024 04:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sHJ8a-0002hO-LG
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 04:15:20 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sHJ8X-0006Pm-Um
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 04:15:20 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1f44b45d6abso52242005ad.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 01:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1718180116; x=1718784916; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UcDgwLrJ/vJ0LXvTIFwEowSYV1ch13n/xdEVQi7gzwg=;
 b=V7dqK03Yx9eDJ3inOzyA/GRofWPe86ycGZze/x7o1MqaYfSnRQ27RosOKXOm7X8w61
 kL82GgTUK2R/E4OWvIKDjWS96Jdsd1zASo1DYLJHF9uJIhS2ImYvPEMHc663zFovoQgo
 rkse+eQbcAgM7WJCFkTopP5Gt8cKm68U+ddhJI+LyEp3fStn6HAk5mj3SVMwSkPmG4EL
 YSk2JOQ0y8Zs5zfQd6O69xE9lner7k+6MkT3lBRZI1pJIVmiGry9FBdMW44wohXtRs26
 qA8fkLSWXZIdd2ouL3axajUpPW1NfQdHqs1Uhl6nChoCqw1Zvoo/KV7oX57Hg52bxxML
 YA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718180116; x=1718784916;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UcDgwLrJ/vJ0LXvTIFwEowSYV1ch13n/xdEVQi7gzwg=;
 b=aRfywJf4jueamut6o6HFj18OeIRZqmWdA33dZFdA1FAPTfzlKs5Q8vlBqIdiGWZEEJ
 LKo2A3Pz7j99ogjD1lvGrq+NKCH9NLpL31Yd4oD/puGf6agn/Lma2NzOwvwS709Zh4vJ
 RFsB3AKFKPGDg4CVxrksnKNhnKro65YD0MMkq0tKsEgLzooJNoueYFXvHbjZfyE91nbs
 cc2z8sp8EYtovajv9qckd6oqJ/+SQh8hdvoiy83ZA2jg8rVEYviJIB4DhC6F2q5PEWD+
 QdE4gdEnC2dghD6oRrtaSYNZDyZfBSEUPGCQ2ztCIg1F+tvoF3JDiLejHTrBtqwD+Fsm
 J9qg==
X-Gm-Message-State: AOJu0Yzj991Oh9EzAkoEvA6Y84h5EdThUubKJ2N0j7qGmk5dvwOIOjVI
 5rCXrx+KXzh5UC7xJEcd2wxiRZnrdGmhi4WVrCGRmVaWYMZEkIMIcVEnpbHP2CIzuC53I4BDJ+0
 vUsVCZkf9Y1xRaJjhe7h3wnSWiWfOxWyVXQ4p2IXIGXZ83aR+q8BnT6Q/GHpMOO4L7sub3jfGEH
 SX6urmogj08+kJKVv1JN2AWWHfhThvGBBelC4BNnGgGw==
X-Google-Smtp-Source: AGHT+IFJgYDmFtlEPz+ZdnPNMvTRVXP2I6U3BKMOCznksrq2qjqXVGEPeamRrREJOhgaIl3R3IbUDA==
X-Received: by 2002:a17:902:db04:b0:1f7:17e4:b57b with SMTP id
 d9443c01a7336-1f83b6abc85mr13533535ad.23.1718180115817; 
 Wed, 12 Jun 2024 01:15:15 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f8393e8e53sm11363875ad.16.2024.06.12.01.15.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 01:15:15 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs),
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>
Subject: [RFC PATCH 07/16] target/riscv: Add defines for WorldGuard CSRs
Date: Wed, 12 Jun 2024 16:14:07 +0800
Message-Id: <20240612081416.29704-8-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240612081416.29704-1-jim.shu@sifive.com>
References: <20240612081416.29704-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=jim.shu@sifive.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Add CSRs for 3 WG extensions: Smwg, Smwgd, and Sswg.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 target/riscv/cpu_bits.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 74318a925c..3ea8a8e9a0 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -360,6 +360,11 @@
 #define CSR_DPC             0x7b1
 #define CSR_DSCRATCH        0x7b2
 
+/* RISC-V WorldGuard */
+#define CSR_MLWID           0x390
+#define CSR_SLWID           0x190
+#define CSR_MWIDDELEG       0x748
+
 /* Performance Counters */
 #define CSR_MHPMCOUNTER3    0xb03
 #define CSR_MHPMCOUNTER4    0xb04
-- 
2.17.1


