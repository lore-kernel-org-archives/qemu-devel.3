Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68CA7C25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 21:28:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9tV1-0004gW-HF; Wed, 22 May 2024 17:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9tV0-0004gK-AH
 for qemu-devel@nongnu.org; Wed, 22 May 2024 17:27:50 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9tUw-0002e2-JY
 for qemu-devel@nongnu.org; Wed, 22 May 2024 17:27:50 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1ee954e0aa6so15189565ad.3
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 14:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716413265; x=1717018065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Od+Bd5fQfCwVyz1MKwi9qPfk4fSByYRJcyhtBaTk8Bc=;
 b=XLjRWyCN8bAG9OVAzfMzZmLfkrJV3lxGiioBNlNPxG86LRqO3dwguKizxuFQ54thvS
 UQSM6Oc9S5xg/RmKHYU8Hfbfxut/I1EwOHvRE1itf4Rss3F/g44I0R4lrDOgIN1954xw
 spyyn0gFnihnfRN0jEFOe/A0Q+ZpQXnGKR5GN7L0+zfNfbmlwBr5PbEjsfCSQ0bK5JqQ
 G0iB7GbXCjcgTB3gDVGxX/gQLXDgVrEHK4cJXPAzY2w04NWqwNRPr553Ia9rmjELjieT
 CI+8Sbqmu8bmnw5S25PFNhZfoe2HeCY3QK5nJamNmrI0XgbN6wgZl9hNkaEvLVjJ7OaQ
 gafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716413265; x=1717018065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Od+Bd5fQfCwVyz1MKwi9qPfk4fSByYRJcyhtBaTk8Bc=;
 b=YWHgGEgdpcMlkUjVkxMECos8X8dhVfPifWR1VUbVL46ocJ8L43YjdmpTeIjZakhqcb
 hWU6G8VhT8cbO9K34hFxHaRCqNcY1SaIoRmKvFcr+m5VwMYlYVaCIjbtL6yo5fNU/YSE
 KlaVAd1GGGK7COmXAWHrPYGfAU+ICC/jCvJgczuyZrCU0iQWbQPVPOVDCnAmFIwQ+vBx
 K62ZbafVUKAeNY91Rw8hgYqoKM8tOPgg/uUMDbRbknAKu6HtnP4FZ7CufEBHhCenXU/z
 Z9tMjOkq2HRohgaq59h/OG6y2NmNX8lUoekF9ElEkY2CoULr5uRXsYCXJZjtMcBt45vZ
 AjqQ==
X-Gm-Message-State: AOJu0Yw9oyHBgTysuQ8A+f3Gg++KVE5e25sv5aC4+2dUBE8HGzCJde4D
 Io4f+f/OZVDLepriwj8nCT4gBdPCs3kW63B8t/WNbIywaRMbHM8Nug5Cw9TYh8jbyeQXNRoPX8S
 +
X-Google-Smtp-Source: AGHT+IE7MrHzdLomCKHKMa4vXpPv4TAOP/d+zE+AXUeeuIQRNTOTwIC0cAW0E2q0aFyjcCRu8gFU5w==
X-Received: by 2002:a17:902:f547:b0:1f3:289c:efe3 with SMTP id
 d9443c01a7336-1f3289cff7amr27769065ad.30.1716413264940; 
 Wed, 22 May 2024 14:27:44 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f2fc06586asm64621705ad.201.2024.05.22.14.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 14:27:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH RISU 2/4] risugen/arm: Fill general regs with 64-bit random
 data
Date: Wed, 22 May 2024 14:27:39 -0700
Message-Id: <20240522212741.297734-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522212741.297734-1-richard.henderson@linaro.org>
References: <20240522212741.297734-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Load from the memory block instead of movn + movk*3.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risugen_arm.pm | 81 ++++++++++++++++++++------------------------------
 1 file changed, 32 insertions(+), 49 deletions(-)

diff --git a/risugen_arm.pm b/risugen_arm.pm
index cf0c1af..c7ca62b 100644
--- a/risugen_arm.pm
+++ b/risugen_arm.pm
@@ -375,75 +375,58 @@ sub write_random_arm_regdata($)
     printf "\tmsr\tAPSR_nzcvqg, #0\n";
 }
 
-sub write_random_aarch64_fpdata()
-{
-    # load floating point / SIMD registers
-    printf "\t.data\n";
-    printf "\t.balign\t16\n";
-    printf "1:\n";
-
-    for (0..31) {
-        write_random_fpreg_var(4); # quad
-    }
-
-    printf "\t.text\n";
-    printf "\tadr\tx0, 1b\n";
-
-    for (my $rt = 0; $rt < 32; $rt += 4) {
-        printf "\tld1\t{v%d.2d-v%d.2d}, [x0], #64\n", $rt, $rt + 3;
-    }
-}
-
-sub write_random_aarch64_svedata()
+sub write_random_aarch64_regdata($$)
 {
+    my ($fp_enabled, $sve_enabled) = @_;
     # Max SVE size
     my $vq = 16;
 
-    # Load SVE registers
+    # clear flags
+    printf "\tmsr\tnzcv, xzr\n";
+
     printf "\t.data\n";
     printf "\t.balign\t16\n";
     printf "1:\n";
 
-    for (my $i = 0; $i < 32 * 16 * $vq; $i += 16) {
-        write_random_fpreg_var(4); # quad
+    if ($sve_enabled) {
+        for (my $i = 0; $i < 32 * 16 * $vq; $i += 8) {
+            write_random_arm_fpreg();
+        }
+        for (my $i = 0; $i < 16 * 2 * $vq; $i += 4) {
+            write_data32(rand(0xffffffff));
+        }
+    } elsif ($fp_enabled) {
+        for (my $i = 0; $i < 32 * 16; $i += 8) {
+            write_random_arm_fpreg();
+        }
     }
-    for (my $i = 0; $i < 16 * 2 * $vq; $i += 4) {
+    for (my $i = 0; $i < 31 * 8; $i += 4) {
         write_data32(rand(0xffffffff));
     }
 
     printf "\t.text\n";
     printf "\tadr\tx0, 1b\n";
 
-    for (my $rt = 0; $rt <= 31; $rt++) {
-        printf "\tldr\tz%d, [x0, #%d, mul vl]\n", $rt, $rt;
-    }
-    write_add_rri(0, 0, 32 * 16 * $vq);
-
-    for (my $rt = 0; $rt <= 15; $rt++) {
-        printf "\tldr\tp%d, [x0, #%d, mul vl]\n", $rt, $rt;
-    }
-}
-
-sub write_random_aarch64_regdata($$)
-{
-    my ($fp_enabled, $sve_enabled) = @_;
-
-    # clear flags
-    printf "\tmsr\tnzcv, xzr\n";
-
-    # Load floating point / SIMD registers
-    # (one or the other as they overlap)
     if ($sve_enabled) {
-        write_random_aarch64_svedata();
+        for (my $rt = 0; $rt <= 31; $rt++) {
+            printf "\tldr\tz%d, [x0, #%d, mul vl]\n", $rt, $rt;
+        }
+        write_add_rri(0, 0, 32 * 16 * $vq);
+
+        for (my $rt = 0; $rt <= 15; $rt++) {
+            printf "\tldr\tp%d, [x0, #%d, mul vl]\n", $rt, $rt;
+        }
+        write_add_rri(0, 0, 16 * 2 * $vq);
     } elsif ($fp_enabled) {
-        write_random_aarch64_fpdata();
+        for (my $rt = 0; $rt < 32; $rt += 4) {
+            printf "\tld1\t{v%d.2d-v%d.2d}, [x0], #64\n", $rt, $rt + 3;
+        }
     }
 
-    # general purpose registers
-    for (my $i = 0; $i <= 30; $i++) {
-        # TODO full 64 bit pattern instead of 32
-        write_mov_ri($i, rand(0xffffffff));
+    for (my $rt = 29; $rt > 0; $rt -= 2) {
+        printf "\tldp\tx%d, x%d, [x0], #16\n", $rt, $rt + 1;
     }
+    printf "\tldr\tx0, [x0]\n";
 }
 
 sub write_random_register_data($$)
-- 
2.34.1


