Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D6EE776C4
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:28:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRiU-00087f-VL; Wed, 24 Dec 2025 11:28:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRiA-0007rB-Ec
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:27:44 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRi8-0003rl-8l
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:27:41 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4779a4fc95aso34083865e9.1
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766593658; x=1767198458; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gvU8IjxyyWGbnt0TpIestxRQYownf9I7RuEDkGDxUZg=;
 b=VWLTRGPF1F3IxoTQS/yTb/DaG23BpmN6rRpl40sywGh+pbTzVaiuYZU49I64EI2ZSt
 nXyMGo/MxEhmNW+7bptYEtXiv65Bi7RBN84g2CQErIxczxM0QlAy0xwR+F9f/sh/waMD
 GMg+bsUTn4kc44x0iTrqjV0UxYh+ZSyRFUKSgN0SNkUnRk+jeRmCUcMH9ilRvLXd6NSN
 far49RWoqRumM8UwroPR0fjGTg9wqdj2VAc4jdLN6kQx+O6jeayqtAMzM7oPSK2PUEyX
 KhqpmCMmBTYnuP1aGIpyTi1faG9epZ/r6RAmL4Ui7NZSczYGCU3rUc3IimiEy0mRhNaz
 E8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766593658; x=1767198458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gvU8IjxyyWGbnt0TpIestxRQYownf9I7RuEDkGDxUZg=;
 b=h69/TSpB9nja4J41uWMHfY+178QAfOsyyf5GI64TUd8H/G1r5fKwbmtHdaIcP25x7e
 dWNQq6XJqsxR0w2eqPwjEU/IxRF0jSXn1WmM3yBVwDrPVoVE49JMXyG+pUVSNG4m6+It
 ekzntml6Jo2a0f59RFt//6mvIMUGBbJ7YptVws5maOKq/q8KHDELcSQSp9G0PIkoR5qH
 5G6Whq2vAjK4m7Qfpx/A5LquYkEYCrp4mwiK+D7QuCkm4wAyqBLNNIJ6ABCfsYD5hqlx
 sfsNUEEGSxbpFJtNqJwXEJ07aOz+U6nZv8Jdl06rPz3fh9ujRuEZJ20UbAq+rudaz9OW
 48zQ==
X-Gm-Message-State: AOJu0Yyi4wEUvr8ymA6P7QsE0xprXBTFXFS9/ESx0N254hAj2Kv84vcM
 RdVrVIe3CRryGmOkDnAXVV/ur9ICz7bXYN+nIUUrtj8KHheK8tw0TeoJS2qd+5PVf7+keJ9mw89
 DTbIrCvs=
X-Gm-Gg: AY/fxX5fk/XDershhVvweJym71WnBW4u/eGrrm7zzj1IEgc21utcf4dN88nVy8Si+jR
 h8faAUKgfpXifl/cdln/6KLbLWRa+5xD3J3E/7whWAZ1zbpHdWDio3FLvevBfA3sdpaWr5mPd2I
 AfGUdXjzPtwM2wmBXQFgiMktajfUgQRtTEpr288Rb4Tv/9vHNp7jdTCKLsysI99eC1ZSko+bOS8
 PBqC4ERHl9DFpXWwWkjmb/wmAsUeR6JaJ3/rGTK57JSkVUWzCPLtP44rpERX7f3Eezhqy/zvvpx
 zhGOvYjDX6RZafaEHBjVsvLopFhRyxvaYmz263gGXS/r0i904u0oF2jNdVVMm2xjDLxvqioUbHu
 VXbomVIzOEzJQgok/p7fODMlSg4iybq54FvVmua2+kfLPHYEoPBvy5QZekOVShoOr4nvkdKEhdt
 Ig2G5laBDYM3zBx/bU6DSlYQo00rPV/ypG1l1hgIxPrPBn+ZZZ5KThaaCH0QswhRvpcQ==
X-Google-Smtp-Source: AGHT+IECKB1ju5vRf8EIl9TPv74aO46F5xD1OsJDy/pGRLFl1q0bYl1GELU12gJA3D4CGaPDDxHUnA==
X-Received: by 2002:a05:600c:5489:b0:46e:59bd:f7e2 with SMTP id
 5b1f17b1804b1-47d18bd5651mr186427835e9.11.1766593658117; 
 Wed, 24 Dec 2025 08:27:38 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193d4e91sm294125295e9.13.2025.12.24.08.27.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:27:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 6/9] target/sparc: Inline translator_ldl()
Date: Wed, 24 Dec 2025 17:26:38 +0100
Message-ID: <20251224162642.90857-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224162642.90857-1-philmd@linaro.org>
References: <20251224162642.90857-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

translator_ldl() is defined in "exec/translator.h" as:

  198 static inline uint32_t
  199 translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
  200 {
  201     return translator_ldl_end(env, db, pc, MO_TE);
  202 }

Directly use the inlined form, expanding MO_TE -> MO_BE
since we only build the SPARC targets as big-endian.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 23079697f52..57b50ff8b9a 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5743,7 +5743,7 @@ static void sparc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     DisasContext *dc = container_of(dcbase, DisasContext, base);
     unsigned int insn;
 
-    insn = translator_ldl(cpu_env(cs), &dc->base, dc->pc);
+    insn = translator_ldl_end(cpu_env(cs), &dc->base, dc->pc, MO_BE);
     dc->base.pc_next += 4;
 
     if (!decode(dc, insn)) {
-- 
2.52.0


