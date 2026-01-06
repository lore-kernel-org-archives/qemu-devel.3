Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED0DCE9D70
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 15:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd9SG-0003dx-Hg; Tue, 06 Jan 2026 10:58:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vd9SF-0003Xz-4J
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 10:58:43 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vd9SD-0006jw-MB
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 10:58:42 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4327555464cso642043f8f.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 07:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767715120; x=1768319920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jPPHx6tYO5HdcZWsR0MQu0bzC+/0x4C/yY9Fp2J0+/k=;
 b=BvVZuUIECh5mjbjnxsVEK58OXkVYtzG8AvadA+Q96h0kbW/gTFr5ox5HVv+wYRgpsQ
 OIax54S0GCLSNOQi9i/9beNvN3WMYCJ/MwubNFEmRoUYWhWqGCbD8aebpqcUMvSKTyM5
 8R9qgNIyiAvbV+hGQw+GcSxmQBh5UgIngqt0Cc/RGTyPzGEHp4R2DVdmi1O6NfH8oHOZ
 QLt2lCL9/dv2US5VOOosgiJiI1X/DrckgOVWa6S/8/qKTUHFi/NL1E6PQlR1nHrue08n
 I9m0EeNANiVFBu4eDx/lOxgRru91HIMrQEu4fFJl+wBfV+i52fOMoxf8fgZKnuT7AzL3
 6y9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767715120; x=1768319920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jPPHx6tYO5HdcZWsR0MQu0bzC+/0x4C/yY9Fp2J0+/k=;
 b=jTzZF8v45T7YgDqsX3Jae/kqsJrb57Q6j1CAozCeJHtKkg/vSUmnaijZhu2X1Sr5ev
 rfn3Y5LCs0XP84w2L4xnX38DlGc7gEnZKJffJTTuoSTOVPBi6X/0pbx1fGVqb3A4UcGx
 MV6U4AWW8oy/2+5SXWiODRbl24Z0/IWwp6otYRd6aRdcdwTUxx1mruxmi1stt76DEX5H
 55KwnPmlikAjVZn4k+Py5d2YlA7ZA1gktj5IsaWmqfmAeG5RQ1Ips66xh5lmk4lbYg4l
 iq5f0EBWyrnYtsjxNOCLiW0xauRbkTuI/BUKnN3tyYdnQTTOJdzs/E9m2/g6RKmNv19E
 +BqQ==
X-Gm-Message-State: AOJu0YxrPfBuyO4fabAgGMkUzF8RwA3ssYloJuakMhR8JIL85g7Nrgmg
 n8bO1Rp3eM4F8TT6HixA+SfRwMvdtVq3akOYYt7Tl6yW6crkMNITYT2oujsg8wcyDBy5rHd59Qk
 hZTfdY7Y=
X-Gm-Gg: AY/fxX7G74pYaOVNqivyDdj4bmOuGj323pT5nNw9SvpVTIqLTs3P8ZTVQ8ckpS5ccDG
 vzbd39DWea1phRdDtB/UwKkUOnQcPfMMIfdpe8oThzGYy+1M2IEdOJuM6G5MJwwY1PiE9X/dNMx
 ZH7Iyeo+bRIgnm4hGPHfAPpMu+yksX+aKLagxMiBZ+Ag3lR1vNMPVJ1AR0rt5S+RsjJ/UbiEzln
 BJJiHzEQZ2aogdZWURGvccsr+1uRBaHGgQpHyGQQ9lIPwAnEQF+dF49ypD/A/h7v8Xpkws9av3Z
 +dR2stutTEioOVnCJ/wFEeFzHHjSLPvKkPYXSaRymHUZAqd49v+JU655G6woKNgfUiL8S5fTD7W
 Mk6EcboaPWlBwePO5ofy+eqmveKmlx6BVlK4iTqiEn3PQ1XAgALs2uoZk/AGUdUINYi0n5hEg5H
 6ltN181uo+6Wf5C7+VmYQsu1lGZrwoeoGG/CJGyDjRM4axxkEURHuPkboP06hv
X-Google-Smtp-Source: AGHT+IEh8/7VbkJDHrdMj/Nd0SzC9jWMWgrNKyKsvOfoVcx7tJ790onUyIqo3aw+CZh7YNL5xtajww==
X-Received: by 2002:a5d:5888:0:b0:42b:2ac7:7942 with SMTP id
 ffacd0b85a97d-432bca168c4mr5129097f8f.5.1767715119898; 
 Tue, 06 Jan 2026 07:58:39 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df96asm4952247f8f.28.2026.01.06.07.58.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Jan 2026 07:58:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 6/8] target/alpha: Replace MO_TE -> MO_LE
Date: Tue,  6 Jan 2026 16:57:52 +0100
Message-ID: <20260106155755.53646-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106155755.53646-1-philmd@linaro.org>
References: <20260106155755.53646-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

We only build the Alpha targets using little endianness order:

  $ git grep -L TARGET_BIG_ENDIAN configs/targets/alpha-*
  configs/targets/alpha-linux-user.mak
  configs/targets/alpha-softmmu.mak

Therefore the MO_TE definition always expands to MO_LE. Use the
latter to simplify.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/alpha/translate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 4f918cbfe63..d9248e54eb6 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -98,7 +98,11 @@ static TCGv cpu_pal_ir[31];
 
 static inline MemOp mo_endian(DisasContext *dc)
 {
-    return MO_TE;
+    /*
+     * Technically, Alpha can be run in big-endian mode, but we don't bother.
+     * This was only ever used for the Cray T3[DE] machines.  :-)
+     */
+    return MO_LE;
 }
 
 void alpha_translate_init(void)
-- 
2.52.0


