Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377A2CEFCE3
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 23:54:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdGs8-0003QZ-8P; Tue, 06 Jan 2026 18:53:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdGs6-0003QO-5Y
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 18:53:54 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdGs4-00042j-NF
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 18:53:53 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-477563e28a3so2147525e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 15:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767743631; x=1768348431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JnxoSZ1P5e+4Xs0K/LmGN52qaOcYyAkfc3LCvt/gqiY=;
 b=V1KAFr+WXk9Pdm30ysqa6+M646CHMReE00cYyFerjXAcoxwUj/NVWqUixz5DNb5qoL
 bKkPc/tUpBX3TbJovejEM5azUKbge4ZKDRz7aPCzGZEDHIiyD1t82OPacivQlUAuA2eb
 etlc061R2ZL1USAbB1XR+cMCk/Y41DH4jKsx3Unq97TKgVw3Ih2W1At9zw8WOEPgx6BP
 3sIHylXRKQIwEPhpTXp5KMG04mfBbYVZpLU0UTlY2mqacrx5iW3FW9Kskn11NQ0njx91
 mAaOEN0vrxqJ5UBI+IvtmWbvZOZxhmtYU1BvLoW5y6vWMN+GaxkM5pJE7kRyxi6GoVfz
 tOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767743631; x=1768348431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JnxoSZ1P5e+4Xs0K/LmGN52qaOcYyAkfc3LCvt/gqiY=;
 b=bUT6VV9vzwcQ5CMjZ5qnt8D+VbVp2oTBGGcCieHmNYtgzUS4OTd/7T/+TjsSQf+Qbi
 HYo8Qs42gR2cJIJTLCXB5QUOl6Er2cq0E/LEqIfQyb5D2UzFfNUAZn7yB796P8eCAtzn
 dny4aScK5d6gkLwItq3bweZKALrl9HkHmd0F9HjbuloqT2z3mc6W1T4bJAWs/7B4CMQV
 fkTuhJCFZOozOEqEwNIw3a0GDDQpr4dAgPpDDTAveSigCuGQJJC0+qKTCkoDq9j7wjYD
 RIiAxmyjB1rwTPFuABT/ZmphEIzciiGbTZ2s/owCaSpSYafhv1+Pcg8TIPj85vIOpHa0
 /T9w==
X-Gm-Message-State: AOJu0YyeJZD0QHbZblkSViY5p3L+BtDa7iofj5EYGuW03KqqAMZrAYF5
 1ZFz4mwMAugVKE0lsVPOgohLTo+yxk/xPhz90EmHVrWxQSnPuovWcFz2C4fSC9xHJnRa2VdJ+2o
 X9NgjRHQ=
X-Gm-Gg: AY/fxX5vKD3lJgPhAEFurVLyjYVakV1eEgAjyzmD7KfjGYFrQVaUqjw5JqCg/d/Kz9+
 QgfpQwLp5ClcmInOpkP4b5m/RHPX3e0sgKaT2vrh3n7tP92eu2hH4W+RrIHDf+lWXcCZ4HcdQSw
 oujGwncomwYFbcIdDJP3N0NMpEPaJpXySVwZn20KjTGayhqLTBj9oshXdnxktg8YSPXh6T4iSym
 6aR0bl1wuKtqt57KTeX7KkVuz0GjvnKqIZFOxfzEqKxV2lu8DBia6FhQ1SOG5872yUoxZ8f+fOy
 iaL6ybXC6f7sBrvsf2l7t8nybukzoNRk096NT4ALjHls0jb3R6YnGMfGtcL6J3GI9qg7Tc5x5R1
 VSJkAldR9nBhr6WzYs+175giIuUSjmE9nRB6+MHYENE+cNKd28/CdPJPk9k+RNfBI+nOl0fKz1+
 4iR2/eWNoYplJHU5ViGclTweE1qXb5j4IuY20quh+3npRdHre/M2kxPKzAtJA0rlk7GsH84VM=
X-Google-Smtp-Source: AGHT+IGlU9d32GNvlTne4QBv2rzxdCODCwty5Co7nCae1fkt6s8rx9++BFHDoK+w0YZs9v7ClUq6Ew==
X-Received: by 2002:a05:600c:848d:b0:477:9a61:fd06 with SMTP id
 5b1f17b1804b1-47d7f41153cmr53065785e9.8.1767743630970; 
 Tue, 06 Jan 2026 15:53:50 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0dacd1sm7002107f8f.4.2026.01.06.15.53.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Jan 2026 15:53:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/6] target/microblaze: Directly check endianness via
 CPUConfig::endi flag
Date: Wed,  7 Jan 2026 00:53:28 +0100
Message-ID: <20260106235333.22752-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106235333.22752-1-philmd@linaro.org>
References: <20260106235333.22752-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

The MicroBlazeCPUConfig::endi flag reports whether the CPU is
configure in little endianness. Directly use this knowledge
instead of evaluating MemOp from mo_endian().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/microblaze/translate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index fefe5cb552a..0be3c98dc17 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -794,7 +794,7 @@ static bool trans_lhuea(DisasContext *dc, arg_typea *arg)
 #else
     TCGv_i64 addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
     gen_alignment_check_ea(dc, addr, arg->rb, arg->rd, MO_16, false);
-    (mo_endian(dc) == MO_BE ? gen_helper_lhuea_be : gen_helper_lhuea_le)
+    (dc->cfg->endi ? gen_helper_lhuea_le : gen_helper_lhuea_be)
         (reg_for_write(dc, arg->rd), tcg_env, addr);
     return true;
 #endif
@@ -828,7 +828,7 @@ static bool trans_lwea(DisasContext *dc, arg_typea *arg)
 #else
     TCGv_i64 addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
     gen_alignment_check_ea(dc, addr, arg->rb, arg->rd, MO_32, false);
-    (mo_endian(dc) == MO_BE ? gen_helper_lwea_be : gen_helper_lwea_le)
+    (dc->cfg->endi ? gen_helper_lwea_le : gen_helper_lwea_be)
         (reg_for_write(dc, arg->rd), tcg_env, addr);
     return true;
 #endif
@@ -954,7 +954,7 @@ static bool trans_shea(DisasContext *dc, arg_typea *arg)
 #else
     TCGv_i64 addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
     gen_alignment_check_ea(dc, addr, arg->rb, arg->rd, MO_16, true);
-    (mo_endian(dc) == MO_BE ? gen_helper_shea_be : gen_helper_shea_le)
+    (dc->cfg->endi ? gen_helper_shea_le : gen_helper_shea_be)
         (tcg_env, reg_for_read(dc, arg->rd), addr);
     return true;
 #endif
@@ -988,7 +988,7 @@ static bool trans_swea(DisasContext *dc, arg_typea *arg)
 #else
     TCGv_i64 addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
     gen_alignment_check_ea(dc, addr, arg->rb, arg->rd, MO_32, true);
-    (mo_endian(dc) == MO_BE ? gen_helper_swea_be : gen_helper_swea_le)
+    (dc->cfg->endi ? gen_helper_swea_le : gen_helper_swea_be)
         (tcg_env, reg_for_read(dc, arg->rd), addr);
     return true;
 #endif
-- 
2.52.0


