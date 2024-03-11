Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BB4C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 17:55:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjrf-0001jt-FS; Mon, 11 Mar 2024 13:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjjrS-0001eH-Aq; Mon, 11 Mar 2024 13:54:54 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjjrK-0001GJ-7R; Mon, 11 Mar 2024 13:54:53 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1dc49b00bdbso24836325ad.3; 
 Mon, 11 Mar 2024 10:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710179684; x=1710784484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=O+pOrOM6lySZTVYddKbxBUhvRTRmJUmOI75S/suUw9o=;
 b=Ho+DUe7afCi/8CR5/5MIKjkgoju499FLceQRExsrw1iizyFjXiWp/MKG7Qofue/F4D
 VVXWbFn+IwGgLvTUXxgy3k6Yt0j11BvS5YK019e4kJhROs0rWiFbGb3v8muxybmtEJai
 nr14wAo5a7rt212EP3vhiUkbANu69e/QWxE3STZNiKeBnvYXKFTjS2k0x59RkEFaHwtQ
 daRvd6ITqVX4Nj1NMi6rD/UN++VNIoq7DvdGnXwvopMkkURyOF5r3eRitIAJlCHrt7KC
 fVTX1UmlEdWsKfD1qX3xP2Ojov2a1vl+Gvhftsq0vCw1yK0UmNM/RkhWGpTAx/aSAzGl
 no7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710179684; x=1710784484;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O+pOrOM6lySZTVYddKbxBUhvRTRmJUmOI75S/suUw9o=;
 b=GSdNiw6UzOZF2Ih7ebr/2a7x9LeQsCDsrpjrIPlf1LgyMTl0hrcQXOh7ehHfmGrHq+
 q5GaAPJzXPxcBGqcXGGIAQ+kei6QLoLujaTIX2JdBraBiqhEwJyA6fazgiBPoIoFNhs2
 1yvDQlrKYs5atZcVQQ0E0uwyu72B9Eao3OovPlhdJHHRtygCG1y8cePBi2COL1/QS5mU
 U3aircIR+e+Q2/mfQP7mXT3bHebPhuG5eHtf2bFNzZCo7WT55xMkXMxuRyKzfcsNBB0N
 xZnQkacIn2CH+uAB8UZ+0Vv5bCoMbs9iwHMGENEHtnDdYuwl+8/+MFYrQskS1gZuUjky
 iEWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc0ZC2fO4P8313b1LRIRrBZE+LTWZtVo/F+3EqDQkGnJJu5S+Zpvo2OnGXlTPp8dy/foV0wTeF+2SiDsAM7aKJsXfLGFk=
X-Gm-Message-State: AOJu0YxAe8qcShTn681wYy/hoazYYvOqzmpKsyIxmi9fX5pHxiFAPv38
 BnWbjQsgbV8xCxuSIo/Atv/FBcbnrX3Cd9lP3OKbiL0LZibDJuEOho00cXICwKw=
X-Google-Smtp-Source: AGHT+IHrpExRCzc3O37GAx5iLgfdWyGBBe7IvfgUVF9mGoQLrf5axjiKEEPjG3fip286QkC8dZqOKQ==
X-Received: by 2002:a17:902:b784:b0:1dc:4199:a31d with SMTP id
 e4-20020a170902b78400b001dc4199a31dmr6348590pls.53.1710179684310; 
 Mon, 11 Mar 2024 10:54:44 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 u8-20020a17090341c800b001dd8b248aa1sm3688427ple.81.2024.03.11.10.54.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 10:54:43 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] target/ppc: Fix GDB SPR regnum indexing
Date: Tue, 12 Mar 2024 03:54:37 +1000
Message-ID: <20240311175437.2177587-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Fix an off by one bug.

Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
Fixes: 1b53948ff8f70 ("target/ppc: Use GDBFeature for dynamic XML")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/gdbstub.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index 122ea9d0c0..80a2e7990b 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -324,6 +324,9 @@ static void gdb_gen_spr_feature(CPUState *cs)
             continue;
         }
 
+        gdb_feature_builder_append_reg(&builder, g_ascii_strdown(spr->name, -1),
+                                       TARGET_LONG_BITS, num_regs,
+                                       "int", "spr");
         /*
          * GDB identifies registers based on the order they are
          * presented in the XML. These ids will not match QEMU's
@@ -334,10 +337,6 @@ static void gdb_gen_spr_feature(CPUState *cs)
          */
         spr->gdb_id = num_regs;
         num_regs++;
-
-        gdb_feature_builder_append_reg(&builder, g_ascii_strdown(spr->name, -1),
-                                       TARGET_LONG_BITS, num_regs,
-                                       "int", "spr");
     }
 
     gdb_feature_builder_end(&builder);
-- 
2.42.0


