Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D37E7FDF2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 22:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn2LY-00083S-UW; Mon, 02 Feb 2026 17:24:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn2LW-00082e-MG
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 17:24:38 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn2LU-0005fz-Gz
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 17:24:38 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-435a517be33so2970540f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 14:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770071075; x=1770675875; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pHArYt5JL2wmE5bb1Fmatz7wESrf6iQwO1bJMqHZ4A0=;
 b=BHA8N3vmcKc1iIElNBR9br0jM7204vmgLHPSq+DsJ0OdvZe0x08H+ln9J+Ej948s9Z
 ZmSAKhZE0mzPejhFG+a9lpj3+hdjdA3aYf0VA4QWEcTfOL0FEPrLue+5/mboaKsd1WmF
 8Z27yRNSjIIqh9HqzARO6DgDeZWTRWM8/PVcRQpvsPg7RLDDDbkYj77kpR2XDM+WgAZA
 uDpqPJgsp2N3LGqPSlJUT3+8n+SQx+ta3cxO0Sw9VFuD2QmU5W7wIjT0gMkot+R24gTE
 cfhgbw5LO8Klkn66APofHE4RFXUBFGg6bL25i5hbHEpZH7hhiS5EkZao0EiBiJ+lTbcm
 0y8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770071075; x=1770675875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pHArYt5JL2wmE5bb1Fmatz7wESrf6iQwO1bJMqHZ4A0=;
 b=QhRksgL8GguOPYHQZwjXlueClJkqygalKhgWxpGzGJUxpx77l3A7Uflh6JK4q8M26z
 vcRXP3VzPbA63dW4C2SzKTZF4WkBvBN94vFKYNsh7cq6HiJYKbUskAs/4q0X3Vhq997A
 LFuboENWAPcTGtH7DPdpy4OdhW4nyojHDDzFE7y0Um85aKZ5SGuCK8fvKZmLmZb83qPb
 CryYo0KUB57PHsl1cP619pBiav328Zvm6BoytwQNftuncpzh3Gwqtaq6xmXK01qQxNDG
 xmWhALd51Nch8YJN+JWmkFHpsg38VwnaCBXdHfXL81QFVaq+UhB8DaVDmky4J1p3tty9
 Fbew==
X-Gm-Message-State: AOJu0YxYu8/ejJ1hV72Pp9hRqFuhKq92NCcNOuGuVFiYxCp6uloUYulo
 la7g8Tb2PG2E89L0bXCpq1KlqUzCWFSMkXFYk+LjF+AIyh09f5SpyWkTi95dF9xVVdoxucs+5Yb
 HOsTNN6c=
X-Gm-Gg: AZuq6aJZ+V+MboFF8soxfNBxt9VRktksKGsKBYuUcAF3U5RfHKIGZ8JChNsL4FNkodh
 030FGjVM94IMV+NORKJvPvEZeKaffz1SnGhSTu+qoVhrm3v7eU0cqin2LD4gMAvnSE3RUFzIUG9
 oFRvIq7y5zBxUH+FcnhtDIl1+R5gPkNMizCi7j6ex9MOfhOvEm05nRbc6x5G01utO2fve2RcNcM
 9mlRNaNet3ELVpnnXOW1E5D7sgDdYpdI6uYV6n7z+fu7671vnxD3EYIOGxKXUf8kKBUa4eiQPAA
 QofdJSS5kn7Of8ysXV3ss0smAp9QG6FB/DAqxfB1G1aFWgVbT+3VlATWeWXvrnQsTB6kK5rzF9K
 Z7ujQToBBtnOHdeipOO+hu8YNBX0IwPpmOioKpPm9QdSSiT104ujqk/hN1guZAv1luSZ46uM8Hw
 vWSxE67KV8WvHecX3hbyo1gl8GiGwfeZfRJLQCTLPpYKvRJsQKfeJmVVA0h1rK
X-Received: by 2002:a05:6000:25c1:b0:435:99d5:9d90 with SMTP id
 ffacd0b85a97d-435f3a69053mr19331830f8f.3.1770071074809; 
 Mon, 02 Feb 2026 14:24:34 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ee04csm47144832f8f.12.2026.02.02.14.24.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 14:24:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 3/7] target/arm: Have is_64() take a const @env argument
Date: Mon,  2 Feb 2026 23:24:08 +0100
Message-ID: <20260202222412.24923-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202222412.24923-1-philmd@linaro.org>
References: <20260202222412.24923-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

is_64() only access @env read-only, make it const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d4a146b4202..40237168419 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1345,7 +1345,7 @@ uint32_t sve_vqm1_for_el_sm(CPUARMState *env, int el, bool sm);
 /* Likewise, but using @sm = PSTATE.SM. */
 uint32_t sve_vqm1_for_el(CPUARMState *env, int el);
 
-static inline bool is_a64(CPUARMState *env)
+static inline bool is_a64(const CPUARMState *env)
 {
     return env->aarch64;
 }
-- 
2.52.0


