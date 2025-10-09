Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA45CCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 08:21:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lsL-0005RD-1Y; Thu, 09 Oct 2025 04:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6lsJ-0005PW-QK
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 04:19:48 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6lsG-00088y-VG
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 04:19:47 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e2826d5c6so4376295e9.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 01:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759997982; x=1760602782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Avr8kO4HEStDUKuZQKdwkKL59sVw03X9BDkTqZlM5UY=;
 b=w2q7jhk/CSOjGIZhIZuO1fFGjVZ/9mWkVl6QwozofWWwqV2eoAp6UuTlKXnjnyIgtk
 dVQchrynsgv2brTyilG88lNKhTjkDLzzDBD8xAySVmkjTy/cyh2WvvQLySs6rWzK/3Fe
 /eYPOq+oKAu3v/1Z+oUC19Y21iSlh9hmFbWeWiR+450bdXuTps2PBtBOlEK8bqzWleRc
 o5ojHkV7HNrrjJQDencgglmewmOuKd6gh/ao/hZp0vEZkNZrjlMIgnnfWq9hZIn0ZE+G
 +W6fSgKkDrlA3Th3TgyUZtIQQlNgY+vsah4OsfMWoAL2uvzEkbcX7KEwEEKCzoWHMTKA
 7KJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759997982; x=1760602782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Avr8kO4HEStDUKuZQKdwkKL59sVw03X9BDkTqZlM5UY=;
 b=M5C/suHkM5ACyoDtwOfg/tFFiI1cy60ADFlbB/WKH/+a1JktrXCmooBZxjpT6uBjR3
 aLkDDHec7GKxmLafRMfM6YDyQPgkdtkDkKy9OLQZX1YhKyVgUl2zOBtwSpEh3L23WKWv
 0JrDGz6iqhvo+5GzGzDQ1JDwJxDgYh6e67tjTydRXc8A2C3V0JQhvxxo7zQ+bILi8rnG
 sYwc/kUFZbC9ywfyNJQbZaszgsVRTO/QXG3UdXJMGQsBU/KQc+a6MK8fHNsPs2hEZmKv
 E4Ikpj8Qf7Nk132KX1ZZ4bX0Q3dFs2q7mu7+40/RUhVx1Q7rFWoW4pK6G48u3xbJH0F6
 CE9g==
X-Gm-Message-State: AOJu0YzUgwhA8SbJ8kpgDIygjXSjnfPu7/wnW1zBBmAEKPFucwAsnwz1
 LzvSPNF3CMXOL79Hsy/sFn/Pj5liUttcIPQAzMmfuB8xqvREpIvFBHlFkmsHQ9Py8jrbBfOaFHV
 zNJmiNuc8DQ==
X-Gm-Gg: ASbGnctYM0FSDjFHdZaQv4jufxRgrfX+1pLpQzylZ89Ys/xtafJMh6Dg87g41wkQqqi
 iKqYC48iJjEcb7DHobBvHhXTtly0ZVyZbX24i4tLYIohUKmcBhJeW+IBUJk/LAe5AHpx3fjfKuD
 4Cr+gWE1amk98l6ZBQIb4XDvCbhAQyfhwS+BcDrvYqstjrR1u+UeVndNVeWDmiqFZNvqf44Iz2k
 JHAVKuzcBZohKRNyQv3OJQUT6Wq3e4BZTh0Dhp1edzlxvv7i/tNzRSBhj+74AF5bLZ9BgjC52W7
 Tr3s/lhwaSKfE/1u1a9h1Wxcc9UsvEdUwoMfmguOADRD7qSzR9syU5TdEa6p51ySoULKPXn/aVh
 D/e8d2O0XBizgfoi16AwrgPyY6scgoeQsEtOEKZEb0yWrK2uQTAdvtWLP2dfnklYJgiEJTmly9L
 16u2n3yJsBKRD+H9NkPCDsJy0n
X-Google-Smtp-Source: AGHT+IGhULNOLsY+bw0WsAgEbvdu9dynQIhfGGFqJNCvTCjuuGnm1qm8h/glzG1y/J1kYhva0tAuaQ==
X-Received: by 2002:a05:600c:3f1b:b0:46e:1a14:a81b with SMTP id
 5b1f17b1804b1-46fa9b17e09mr40337235e9.36.1759997982051; 
 Thu, 09 Oct 2025 01:19:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46faf1118aasm35486475e9.5.2025.10.09.01.19.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 01:19:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 08/10] target/openrisc: Remove 'TARGET_LONG_BITS != 32'
 dead code
Date: Thu,  9 Oct 2025 10:19:00 +0200
Message-ID: <20251009081903.13426-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009081903.13426-1-philmd@linaro.org>
References: <20251009081903.13426-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

The OpenRISC targets are only built as 32-bit:

  $ git grep TARGET_LONG_BITS configs/targets/or1k-*
  configs/targets/or1k-linux-user.mak:5:TARGET_LONG_BITS=32
  configs/targets/or1k-softmmu.mak:5:TARGET_LONG_BITS=32

Remove the dead code guarded within TARGET_LONG_BITS != 32.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/openrisc/translate.c | 33 ++++-----------------------------
 1 file changed, 4 insertions(+), 29 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 06625367ae4..dd93cfd6074 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -298,19 +298,8 @@ static void gen_muld(DisasContext *dc, TCGv srca, TCGv srcb)
 
     tcg_gen_ext_tl_i64(t1, srca);
     tcg_gen_ext_tl_i64(t2, srcb);
-    if (TARGET_LONG_BITS == 32) {
-        tcg_gen_mul_i64(cpu_mac, t1, t2);
-        tcg_gen_movi_tl(cpu_sr_ov, 0);
-    } else {
-        TCGv_i64 high = tcg_temp_new_i64();
-
-        tcg_gen_muls2_i64(cpu_mac, high, t1, t2);
-        tcg_gen_sari_i64(t1, cpu_mac, 63);
-        tcg_gen_negsetcond_i64(TCG_COND_NE, t1, t1, high);
-        tcg_gen_trunc_i64_tl(cpu_sr_ov, t1);
-
-        gen_ove_ov(dc);
-    }
+    tcg_gen_mul_i64(cpu_mac, t1, t2);
+    tcg_gen_movi_tl(cpu_sr_ov, 0);
 }
 
 static void gen_muldu(DisasContext *dc, TCGv srca, TCGv srcb)
@@ -320,18 +309,8 @@ static void gen_muldu(DisasContext *dc, TCGv srca, TCGv srcb)
 
     tcg_gen_extu_tl_i64(t1, srca);
     tcg_gen_extu_tl_i64(t2, srcb);
-    if (TARGET_LONG_BITS == 32) {
-        tcg_gen_mul_i64(cpu_mac, t1, t2);
-        tcg_gen_movi_tl(cpu_sr_cy, 0);
-    } else {
-        TCGv_i64 high = tcg_temp_new_i64();
-
-        tcg_gen_mulu2_i64(cpu_mac, high, t1, t2);
-        tcg_gen_setcondi_i64(TCG_COND_NE, high, high, 0);
-        tcg_gen_trunc_i64_tl(cpu_sr_cy, high);
-
-        gen_ove_cy(dc);
-    }
+    tcg_gen_mul_i64(cpu_mac, t1, t2);
+    tcg_gen_movi_tl(cpu_sr_cy, 0);
 }
 
 static void gen_mac(DisasContext *dc, TCGv srca, TCGv srcb)
@@ -349,11 +328,7 @@ static void gen_mac(DisasContext *dc, TCGv srca, TCGv srcb)
     tcg_gen_xor_i64(t1, t1, cpu_mac);
     tcg_gen_andc_i64(t1, t1, t2);
 
-#if TARGET_LONG_BITS == 32
     tcg_gen_extrh_i64_i32(cpu_sr_ov, t1);
-#else
-    tcg_gen_mov_i64(cpu_sr_ov, t1);
-#endif
 
     gen_ove_ov(dc);
 }
-- 
2.51.0


