Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A1FD1091933
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 23:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3MkJ-0000UI-7w; Thu, 19 Mar 2026 19:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w3MkI-0000U6-5b
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:25:42 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w3MkG-0007aI-LD
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:25:41 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-354a18c48b5so1036941a91.1
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 16:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773962739; x=1774567539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J8bQ3jishH1zGhp+/htrMFXAohWixgT0dPpSDIofuiE=;
 b=HYnb+iioXdeje6Hb8RcwkOTAgpKe/iTVT8cIKdUxy0Gq3oG6PzeyhVhgAhasKFWyy5
 +CIJ8BajBLKSvVAsf5YmC9CQqgYP6KCjGpg9Ih2mKwu+QYAN0Iyon4BCg8BRUt236SnG
 i8G1JIQL+M5SVvHAJDPDIRMeFG6O+XFjooqkIhBpauDiboF4ClOojgQsXSsOV7CqD7MD
 eZEvze0nZ94C+V3HUuh6eRTRjwzm9feMa1f0+FCdv6GtMgZRQadK5EV6gnCTICErjJOs
 +PBXy+56ITkNGNpYz/WI7alP3PfggZJESQxv9TSfxtbwrWNVcvuIqWFDNWVueCxwIUEI
 Ruvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773962739; x=1774567539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J8bQ3jishH1zGhp+/htrMFXAohWixgT0dPpSDIofuiE=;
 b=pTvKdPFHEoZl+g+j9z7WEYLmH/R+yZQukbJ6sQ8pOrDwGbMF/4jSgxjMqHXEr18upp
 tYy5mEH6PQLCQZCI4u7vyJRllOCl8p8mJkmzb+2wALrshskHT4w7p7RjDeOD8BtkHHMy
 9oW6guoR84Sf4uYtAFv6cMYCe6rGJK3pSiUbtti0XEP9t6ozjISxIjmirAtp6riAy95I
 bKn6Xjj737TOkdncS1Y+vovRG02ews7MMGS0IHxJAjZb1QbW4c5Wm41YTgLIRNF7epOj
 tyYeT8MpFcSqinkQJgMRPR2h+Blj0QIiWFsNqYAVu2zyFbzalzVmssG9/q8GRgWEzQOC
 rEBQ==
X-Gm-Message-State: AOJu0YyPBLsQ0UcCVWcYqPfW5A1RKzbQ9HIwqK0dZuhCRBV1go+b+bb2
 DQHEXNkFkCjpvE8EFfvZ9qPeV1dW+loKQhOIhXiY2ren5OrDCm8jzYQqaQ/0hQ==
X-Gm-Gg: ATEYQzw2McxencSZPgOMT2TtLS4czlVJ4V8ZmyXPk9bLqeg5WjxgrY76bBy6i9om9YU
 5hLiCGliOUiqONsWrEd7C7KSsesdrUoquzvql6hhngpHbm1Gn+sY54PROSXQeYOgB1JCEbUoqYt
 fSTuwtoHTMUPj3iUaaueh8dNsI3nuQQo/IrmY7X+H/eis2l0VLJD8dvE/YQLPdf2fDhVHj8oO+F
 GBsXzOCCUHLQxGSw1Ed1IwATo3iPfsrEuZ32TEobD6bKZyNXX1U2OiM4IzaxvRtTvNppqtzzM6s
 Bybmc3OFrBiwoi2NUpl21UP1d7qN5KMRyBqgj4db0oi8faj+sIfhcbTnFoLggAESQTIoa5LR5+X
 ZM5MXhe+4YU4YFvm3dTWwa4cRyH9nSVMjSrv55EIjYCKHmbPSYWOP0SuOztiitk3ZYqGdPwu9/L
 Ph0v56MPJF6mKVZbusKm26nGEnbrTe0KOOdCfJKnNyqQ==
X-Received: by 2002:a17:902:d48b:b0:2b0:5fbe:12ff with SMTP id
 d9443c01a7336-2b082793befmr7665025ad.30.1773962738647; 
 Thu, 19 Mar 2026 16:25:38 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083516ae1sm2979165ad.13.2026.03.19.16.25.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 16:25:38 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 01/17] hw/riscv: Fix integer overflow in cm_base calculation
Date: Fri, 20 Mar 2026 09:25:06 +1000
Message-ID: <20260319232522.1867400-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319232522.1867400-1-alistair.francis@wdc.com>
References: <20260319232522.1867400-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>

Ensure 64-bit arithmetic is used when computing cm_base,
avoiding potential integer overflow.

Resolves: Coverity CID 1644076

Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260115130110.2825796-2-djordje.todorovic@htecgroup.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/cps.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/riscv/cps.h b/include/hw/riscv/cps.h
index f33fd7ac86..39029bca8f 100644
--- a/include/hw/riscv/cps.h
+++ b/include/hw/riscv/cps.h
@@ -27,7 +27,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(RISCVCPSState, RISCV_CPS)
 /* The global CM base for the boston-aia model. */
 #define GLOBAL_CM_BASE 0x16100000
 /* The CM block is 512 KiB. */
-#define CM_SIZE (1 << 19)
+#define CM_SIZE (1ULL << 19)
 
 /*
  * The mhartid bits has cluster at bit 16, core at bit 4, and hart at
-- 
2.53.0


