Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A18D2594E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 06:40:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkciK-0002zN-RO; Tue, 27 Jan 2026 01:38:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkciG-0002xM-Mk
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 01:38:08 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkciD-0006ll-3x
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 01:38:07 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c613a0ca52dso2841737a12.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 22:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1769495884; x=1770100684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ATVqaM7ZW01f8u/zPmOMSZFgIAA3aDS5ix/aVxS3Tys=;
 b=VLlDSuzESu71jo0c840ZqypKUUXreMcBrkbqP52p4GqoSN6kk73owaolP5+hlOmueB
 N3Wt+VZxwOt1+pYjJZvr7gkJKSrqKvvEahAzSn528S2Jga23F+naZjLF/sSAZ0xD1xh/
 uoBwfal6mskyVvX16Wl8WqfwqXcqUslTuVC8RrW052koKyn4VvHvaICFK8zDQzl0Q/DW
 +rasJj7OP3kVsAPVww98p/6lq8bo1b00VG689gB9qgkA0yatD+REnA8L1vDSaI+YcnYL
 pMn9avFNfERaS8FQR8LW8lq5U/kJnbvDD37ZIc/IRLjjCrbNytqhbRCiWxm4ahAx6zrg
 QvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769495884; x=1770100684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ATVqaM7ZW01f8u/zPmOMSZFgIAA3aDS5ix/aVxS3Tys=;
 b=a7RbFqQAAAc29ib9ziOzbw9SUaTzTyW+25fEpPmCrYHtQqR7aLm6vrfDlKXXly+p8W
 7qbti3H3ClcwpkurEw0Jd8f/c7oKxez/zfrTPWroD3VB6viaRw3d2TbTanqI/dI5p5CC
 w/PPVBopBsdBTdg5qT3Qqb9Q0pmURKicXG8FoQTlCf1AcxHMGGWQPfb5+eSz0M6Fw46y
 U4IYQeIWRO1iFpsckZEz5g0MP87chJ/Yt8oKOlZBR1oBMKkD7TXwAm/wUpMar+bIRWYG
 r2FftN0EYqcizh0upouz4Y7AR7Y6FWZZ722MkP/6eJ9/AQCQGvoCvr/MHEnkx0D1f+zw
 7CMw==
X-Gm-Message-State: AOJu0YwZ0jIospDnQqaIsTlZfG2wqc9NPg/1cIz2rjpTo3qzDRewv/1j
 qCOIjmB/d7zGlBiIODGakX7aDWcWulbJu4DDljgtTIHfbSV6yaVVqfaClarE5gtrIu30q9+7abO
 la1KQ1G/DQelECShc4zqeotx+2sKGKcQTrw6O/JTOjV83ohqHCQ96gss53MaY25Id0CgCi0Co1G
 RZiQQpkuLxqL6+gccexdy1WbQtcxorjvFM/FJ0J06BMg==
X-Gm-Gg: AZuq6aLbRRHoZpqJZTkJ9kL7/jUO5XWmbpS7Lvf/9gHP0Z+YEL3kCM5zXuaEWxiCeo/
 XUiOxXCpmQr3LTOsY1cehtIUEkck9TV6KASxToXeK0eg9uvz3etIeti08EZCAdEAADeWsb6C8EO
 3flS3EMAj77OSUUSdFR36GDo2wNP8ImVY4hpQO+z1ugH+Tq/+4tNCrkop81B4yvms8bd4J8RZa+
 y/vWcnI8r+jJqbQfXiYGQa1Z2mQXxD293oA1AzmITwkM+T0JkOf2Kue+4MfbFRFJgBHG4J9bLgQ
 Qe0emkz/m97lR3JQhLAez8GWtXSsfwOo93T1WHtd9l6t+UyS9eBjJNj3oF3tY0/dWBTUhIkHjSe
 emWsvqbNZCjCAWYYE88wk3ACGr+dHMzHXEEW8uMhydVjd6IMTuYdoTyPc/DNWjgGBYuw6PPos0f
 G15/mLv3HLxrT3yW76XiKgx3VnJB46kxJO2VlgZoz3zbXPYDQ5VAzWHTS8vOrzBubTcBau/aOKl
 ncn2/fdzyrgqjk=
X-Received: by 2002:a05:6a21:a96:b0:38e:9b5d:dc44 with SMTP id
 adf61e73a8af0-38ec65a285cmr616656637.74.1769495883713; 
 Mon, 26 Jan 2026 22:38:03 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f5f96293sm1414175a91.0.2026.01.26.22.38.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 22:38:03 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, richard.henderson@linaro.org,
 Max Chou <max.chou@sifive.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 13/17] target/riscv: Add cfg properity for Zvfofp4min
 extension
Date: Tue, 27 Jan 2026 14:37:19 +0800
Message-ID: <20260127063723.442734-14-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127063723.442734-1-max.chou@sifive.com>
References: <20260127063723.442734-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x531.google.com
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

According to the ISA spec of Zvfofp4min extension,
"The Zvfofp4min extension requires on the Zve32f extension."

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c                | 1 +
 target/riscv/cpu_cfg_fields.h.inc | 1 +
 target/riscv/tcg/tcg-cpu.c        | 5 +++++
 3 files changed, 7 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c8cb3d021d..7823508615 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -194,6 +194,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvfbfwma, PRIV_VERSION_1_12_0, ext_zvfbfwma),
     ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
     ISA_EXT_DATA_ENTRY(zvfhmin, PRIV_VERSION_1_12_0, ext_zvfhmin),
+    ISA_EXT_DATA_ENTRY(zvfofp4min, PRIV_VERSION_1_12_0, ext_zvfofp4min),
     ISA_EXT_DATA_ENTRY(zvfofp8min, PRIV_VERSION_1_12_0, ext_zvfofp8min),
     ISA_EXT_DATA_ENTRY(zvkb, PRIV_VERSION_1_12_0, ext_zvkb),
     ISA_EXT_DATA_ENTRY(zvkg, PRIV_VERSION_1_12_0, ext_zvkg),
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 59302894af..353a932c36 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -104,6 +104,7 @@ BOOL_FIELD(ext_zvfbfmin)
 BOOL_FIELD(ext_zvfbfwma)
 BOOL_FIELD(ext_zvfh)
 BOOL_FIELD(ext_zvfhmin)
+BOOL_FIELD(ext_zvfofp4min)
 BOOL_FIELD(ext_zvfofp8min)
 BOOL_FIELD(ext_smaia)
 BOOL_FIELD(ext_ssaia)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index ba89436f13..b1097e55a3 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -715,6 +715,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+    if (cpu->cfg.ext_zvfofp4min && !cpu->cfg.ext_zve32f) {
+        error_setg(errp, "Zvfofp4min extension depends on Zve32f extension");
+        return;
+    }
+
     if (cpu->cfg.ext_zvfh && !cpu->cfg.ext_zfhmin) {
         error_setg(errp, "Zvfh extensions requires Zfhmin extension");
         return;
-- 
2.52.0


