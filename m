Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC44BE92722
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 06:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaSyw-0006qP-IG; Tue, 30 Dec 2025 01:13:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vaSym-0006oQ-EW
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 01:13:12 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vaSyl-00048M-0E
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 01:13:12 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-ba599137cf8so3156380a12.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 22:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767075189; x=1767679989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ldf2kbdgnmOIY67ePy0AhhoIYKjLiKyp8sJYjnWKUkU=;
 b=JO4P6InE5otQ3kAvu0Vo0NH5bfKbjL+MrNWXcPziIi2EsxGXHy5p/FwCxxZRGpe/CJ
 JpM/LArEqvTmoOCxafUtqmEZ+NlRfgBOBdHQ+a/O1S+se7k1+exVESNglSVxXaePUkbm
 YwtHzPEJxtHhirtukUrohMZ9t6PsTVP1RipZ/KC9B1SZDxMAL1mpOGv0FVVcjNcnbj/j
 wZ3Bv8qJXlkEbfaU3nHGQgqnaFObHJmxDZUJ4EToBpMali2swGfuibGqDonj3Ol6HE+4
 UZxjV0uo7rIKBqrhGbx0VEvI3JXBtvSI4Bs5tv5JWLjItiL0QgoYGmCHKUPQS+j4neqc
 A+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767075189; x=1767679989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ldf2kbdgnmOIY67ePy0AhhoIYKjLiKyp8sJYjnWKUkU=;
 b=sWQWSf6FfBRH2uC5pOok8cZdXc60+YMz4+rfOXGn1Az+ilOi/9eF8QcYYp9zvSKaIh
 9MEaG51DNztH92XomZlt9GpnfRKu7DcrfKHSBmz8Bt5h1dvOUu2O22XQQ+IIWlwWwMmY
 1Ti0x9MA797Gp+QhATX6pBmrezw82XI3AeI6tCdhy4JGceT5Y5giM+GP2m4RjqDQronX
 CNY40l2ns6huNKyUx3ECy7pgk0ZSQ0L3fkHK/QEhdkmJoB+ggaGjs+kGvlSAX/GRo9f9
 wJtmDLjM3m9CqRYhm8e4ohosMOcIX8KPFJKTB7BvQ+E8YYsz01hza3Gq+/eD+JeidEaz
 4kNg==
X-Gm-Message-State: AOJu0Yx6Nc+tG1QMSLoFGrHE32hYdr88LJcYg1At//jfXYw+wQ6qUwdE
 ECrVogEgs3rlpw+RcA5+PPVTlRFcOdPk9PovbAVtMKjKa+ooTjnTCk8GoPpO3nnduIupSQ7e6iG
 V4zUyxJYEAX403ZtFhURj1J4eqljgznRab5xMRTCKuF1yCNf82IPZceI6d67wOZtNfMoc12GzwP
 TZMnleNwIq8porYNXOj+l8P6lNp4ZHjIYxhAoiog5BObs=
X-Gm-Gg: AY/fxX7okmXX0E8pkX+9/Ini0qy1uiX+c5Dec1YYi4cCbrUQyMGF2wI5ShQmdkc/P79
 bTNJ4fvWWZmejct6AkIjnW5Q3LRQXDN0RS7J06D/rX0bBZlLCA9EuytQW2C4NQqEAvsKlB45lYr
 19NsDM7SkxZcHKKecH7Zpwx7seSdODOEZVftu99IzwYACXXaoWVcEuFSy85MZgudblT1cIk75Ok
 WGTEyTzIZDCshcrBQGTgsUvcaB7SPID8v9L+yfJy+9dnM2jYm+KI5Bua1H2S4pWzDGW4WPRUsfy
 3/qXK50tpCTYMLtp8uqV++sU5Q8zmh3KBUGCDasZFec4+9YhDvpIW8F9cgPRuzI9gb+FB3rEjrQ
 q2XmMt7cThGQSlE72aNeB1mMza76HRO+oVP6Cv/WFW9EZRl4PH1bjSsgyd7mPE4fMfS/5z+ABHf
 ZoKHHOGqnREaVLQOQoJV+HuqAoXffBgxvhhvvPSUQ44Qe99Ha08YgwUzdlYGkE
X-Google-Smtp-Source: AGHT+IHksMYj76gJ5tO2uFaAuwxe0pWIqOBUjvIFGQB/KzzPm4/ozfoKClvjfgqpwOpbabLyDuuCrQ==
X-Received: by 2002:a05:6300:83:b0:366:14b0:4afe with SMTP id
 adf61e73a8af0-37554a4cceamr37636847637.37.1767075189245; 
 Mon, 29 Dec 2025 22:13:09 -0800 (PST)
Received: from jchang-1875.internal.sifive.com ([136.226.240.181])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c1e79a1778esm26960906a12.13.2025.12.29.22.13.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Dec 2025 22:13:09 -0800 (PST)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jay Chang <jay.chang@sifive.com>
Subject: [PATCH v2 2/2] target/riscv: Use ROUND_DOWN for PMP address alignment
Date: Tue, 30 Dec 2025 14:12:58 +0800
Message-ID: <20251230061258.15596-3-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251230061258.15596-1-jay.chang@sifive.com>
References: <20251230061258.15596-1-jay.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=jay.chang@sifive.com; helo=mail-pg1-x531.google.com
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

Replace manual bit manipulation with ROUND_DOWN() macro for
better readability. The behavior remains unchanged.

Signed-off-by: Jay Chang <jay.chang@sifive.com>
---
 target/riscv/pmp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 01b337f529..7ac5cbfae2 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -235,8 +235,9 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index)
     case PMP_AMATCH_TOR:
         /* Bits pmpaddr[G-1:0] do not affect the TOR address-matching logic. */
         if (g >= 1) {
-            prev_addr &= ~((1ULL << g) - 1ULL);
-            this_addr &= ~((1ULL << g) - 1ULL);
+            target_ulong granule = 1ULL << g;
+            prev_addr = ROUND_DOWN(prev_addr, granule);
+            this_addr = ROUND_DOWN(this_addr, granule);
         }
         if (prev_addr >= this_addr) {
             sa = ea = 0u;
@@ -625,7 +626,8 @@ target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
         case PMP_AMATCH_TOR:
             /* Bit [g-1:0] read all zero */
             if (g >= 1 && g < TARGET_LONG_BITS) {
-                val &= ~((1ULL << g) - 1ULL);
+                target_ulong granule = 1ULL << g;
+                val = ROUND_DOWN(val, granule);
             }
             break;
         case PMP_AMATCH_NAPOT:
-- 
2.48.1


