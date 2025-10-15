Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27074CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 18:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v95p8-0003r9-JX; Wed, 15 Oct 2025 14:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v95ol-0003nt-HO
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:01:55 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v95oe-0006Fa-33
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:01:43 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46e6c8bc46eso46478215e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 11:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760551292; x=1761156092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V994PTOYXfSbgqk3wPN+Ltq5BghnfXGjVQUSgxw4NwA=;
 b=eeoxEsR9TCcbPnrGkL3iOyRwe51DRlmbO6vtxbA2ETd3rhLGHWoo9aR2LsYZKYIQVJ
 PwIECFcPAhZxT9BCjMqoO5dQdJSs9nZD3xC0GDXMfSJVEzeOFMRqXLOEyv9evT1m0IMl
 KtL6u79Kk52kHCpnn+yhY0fQXkHJe0KwZswcaywD9cP6cJiHuq7kPY/v3f9DW4OfFRtD
 iVi3+b/PelDANTfRdpnfM3Blq27Kz5aLGm2umfx5G3wfE/oWn4wlHr+leSkRYXry0Vdd
 qePTT4H3HRN+0XCxj4GEhccAdPvxeItQefHZ26+qmBN3OdjMgK+D/XWXe2ofNHk1HJad
 icGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760551292; x=1761156092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V994PTOYXfSbgqk3wPN+Ltq5BghnfXGjVQUSgxw4NwA=;
 b=aZcHOfUzYZef1MwJ1U+/fCw7TcH36+8U6A3gI7rrLfBjFxgQBX9OZSkODC+fX8zUok
 tJeS4VgyyKJsSsW0UJFYUi5kJLUrVaWg5v5cLVB8DexmkUuUpI6vSTyOrE7BfERQ0V7P
 9lHPb6P+Ik3KZEGZ1tWmMxz6BloqhiXA7DBSm1/SDdNspEB1XYcih1rV9ffmuOyC9LmV
 103L8X3uIuEIWDH+GPOaWSwZKmazgDJaVLSzy53pEiITJlEtgDeBc8ljDsN/ckSfiOe8
 ri6SOOW2WxVdZJRfUWw+pk378vu4RqhRVFFHrbH3VoiaGeclzbb429Udkz8AZ4im0zIk
 DMVw==
X-Gm-Message-State: AOJu0Yxlhdc2NvTbtQEflRGajy7jP14gtitskR/JW9SBYuTxo8LwjAoA
 x9jSyLBCkvxM2oVcaToDxokHXiJ7pH0UcJcKMl0xNQSIC5jwFGQXYcX4Vib0kL2bMsvKquBZIir
 LoRfGeoerug==
X-Gm-Gg: ASbGncuISar58OMlaCKn3zDj471Cphk0S0VrTPdt0rqaAcnw/BQCRIo6Svf+j4HBcX1
 PvRRpQd/jmwlucnVl/4XFGbKaK9nuUuFTk3j9F5IxfNumU9RzGyyj+WKtAQUCCAHP6WYtcTBGqS
 0aKlB9Nv85qTiaZ2yQo6D+fd7KGzdgjpXaNT+Hu8N6/It3ysJ/ElQAaRDaRwBFrPTskEwPrbauY
 F2pEBE4Hbs6ZY2Gm9suefv9uKz3aN4tKOoC/8fm6A5dEgXwufv10P0J8Rj6lF6W2IZKvSmDossA
 aYSNHQ6OyYglPYwng/g2pUIsvQXrCeBmlkw4ql3RZMHb80KS/EQh9mqmaenk0rJsC3y2KPa4TXe
 cYlO5YYBPwtE03cWAQWjAK9F85iDmmvWme9XqgT361SyytrcoBL8Ez0D7qhtJJ1RpGCWdloKbAb
 EuhvFBsFdLQBskNa6E3UXHBj9kWD3wQw==
X-Google-Smtp-Source: AGHT+IHoOk0Y+TM0NcopWernL11ZV7KMHjfwjVzLtqw75+zPta1bkG5ZiFL5PJo2PDcs6BavtlVNCg==
X-Received: by 2002:a05:600c:8b54:b0:46f:d897:516f with SMTP id
 5b1f17b1804b1-46fd89758e7mr72203455e9.34.1760551291957; 
 Wed, 15 Oct 2025 11:01:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4710a20328asm8387755e9.1.2025.10.15.11.01.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 11:01:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 3/7] target/microblaze: Remove target_ulong use in
 gen_goto_tb()
Date: Wed, 15 Oct 2025 20:01:11 +0200
Message-ID: <20251015180115.97493-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015180115.97493-1-philmd@linaro.org>
References: <20251015180115.97493-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

translator_use_goto_tb() expects a vaddr type since commit
b1c09220b4c ("accel/tcg: Replace target_ulong with vaddr in
translator_*()").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/microblaze/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 3dd74b021e8..b93a40fedbc 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -116,8 +116,7 @@ static void gen_raise_hw_excp(DisasContext *dc, uint32_t esr_ec)
     gen_raise_exception_sync(dc, EXCP_HW_EXCP);
 }
 
-static void gen_goto_tb(DisasContext *dc, unsigned tb_slot_idx,
-                        target_ulong dest)
+static void gen_goto_tb(DisasContext *dc, unsigned tb_slot_idx, vaddr dest)
 {
     if (translator_use_goto_tb(&dc->base, dest)) {
         tcg_gen_goto_tb(tb_slot_idx);
-- 
2.51.0


