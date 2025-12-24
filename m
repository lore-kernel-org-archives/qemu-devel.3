Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B89E776C2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 15:15:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYQZ5-00027r-Db; Wed, 24 Dec 2025 10:14:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQZ4-00026m-KY
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:14:14 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQZ1-0002yr-SH
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:14:14 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b736d883ac4so1047707566b.2
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 07:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766589250; x=1767194050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NQzy0dLdaSF6COAicvlR6PVbfYgMujeHrja50VAAj50=;
 b=E2S9SEcbko9BJUpsp/TgaPlG6jiKDpHND7Qh77WGbLTp3CyovdwK91AJ+Acx622J43
 3M8muqsSLUpNAO7d9N6aKaXoMXElYJKEDKCWzO3f0WZnXg9hLFw3kYRrXaVW/1Ql+BRJ
 8m0t71fCc8TNfW6U1ksDkv1iLNFSUgT0GOYvbeFjsN/1ScGkDqcfpBfq6K3MU9HfQiGS
 Y7/oWh9YV9ijt33x73qe2hNjMaaUo+/xl+nO9dQy3rdF227tQvfhz+GZjWGJ/yySNB18
 fOAAUAR8E28VBfabjF9IhB6VmlICQmH12muBTNhZOUtuUg8Y0iKlDdrKXLYy31aR2TaA
 kqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766589250; x=1767194050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NQzy0dLdaSF6COAicvlR6PVbfYgMujeHrja50VAAj50=;
 b=NkkGwCfvy+UKSJGZAfyXrt+Abj8w+XyfcTNTCmeO74pGMzP24XdaJHZJKktt4wn7m0
 P2P/NY9P/ghHEOkgbElPpRoSYdmjpgGe/wq3t706Fesby/VPT0nzT3fdCOL3E5Kwpvz3
 PFOvX92ut55OENgMXjbVUD+nzZR19g3wmv2j/AA1rok+8WJEVeZHphmnYWkIupstxSA7
 KjQmJwdvAFfZXkcW3H2k2rpapaOajuJaplI5era7NsgyaGBktHU9Lvwo1TYBDR50sA0e
 Epwazet1qojWlOTl/Z4b1O+b86evOrWKiPNb25EnktTi/ntS2RBPGQITS+lFRzWnNb4R
 GibA==
X-Gm-Message-State: AOJu0Yykh05hmCh6bwPSUbY0cH6qAi13SAS0dw1dPVBDqxZIiaH2J/a9
 6EwQ3gvuVdi7VPXqQcBOyRpRrvU3VeMMvq0rNOFgHfPYg9bKyBBHCRyQWf2+kG0fLb+7y2Wd6bW
 Jdx34i5s=
X-Gm-Gg: AY/fxX5WDpOb5w+hRXgr3rJgF4Zc999uMghfX+aXltqE2fkGtJzOpwmtkudT9j+e7D+
 OUKhz+XXs492KWH+wfH+AJRalK0azHTRBTDfKyojGQrPMnIEw6FFvVdL9SPU3lvIxCl+jRq+h84
 AbyPdA13EKL7g5iTTz7glIEnQ237xTYkwAe2i5Gs3WfWrooauEk1KrLdTEWc0ii0NpUvaDdjmPl
 QMhswH/6tHaGqHV+el6SvS2Mfd6UkmKhTKNoz4q2JDl+/Gz+5YnR5cqk1Q+h74P496ApOV/8k4O
 DVGM3b+snq8JXeTdeW2fH6y4bpzEj4EVkCuKOK8q00DMLrfoR6b8ajfzmBO5VdhrXnahR47JWBw
 KtMoVMGw3chRkzC0xa+AMCikj6Taf2C7uY8VNoBZ/UVPpvXhonD45TytIUrsH1uUH8g8cUD/rmU
 OPbIftiC6FQwe+TOdWEn/LhDH4RiZ18AnhbiWjrAJXmzv7/VbqzVMK2bo=
X-Google-Smtp-Source: AGHT+IG1MXjRhMLVLkvNGpMS1CpLHWaxCRCtClGiZg8AGngYKI/lUOhGKo86qATzFu0tPR4tqcpw1g==
X-Received: by 2002:a17:906:30c1:b0:b80:4101:c99 with SMTP id
 a640c23a62f3a-b8041010d71mr1260480566b.21.1766589249356; 
 Wed, 24 Dec 2025 07:14:09 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037f09149sm1772261266b.47.2025.12.24.07.14.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 07:14:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Weiwei Li <liwei1518@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>,
 qemu-riscv@nongnu.org, Steven Lee <steven_lee@aspeedtech.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Troy Lee <leetroy@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Zhao Liu <zhao1.liu@intel.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Alistair Francis <alistair.francis@wdc.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 1/9] target/i386: Remove x86_stl_phys_notdirty() leftover
Date: Wed, 24 Dec 2025 16:13:42 +0100
Message-ID: <20251224151351.86733-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224151351.86733-1-philmd@linaro.org>
References: <20251224151351.86733-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

Last use of x86_stl_phys_notdirty() was removed in commit 4a1e9d4d11c
("target/i386: Use atomic operations for pte updates"), let's remove.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.h    |  1 -
 target/i386/helper.c | 10 ----------
 2 files changed, 11 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index cee1f692a1c..4c0579a5678 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2623,7 +2623,6 @@ uint32_t x86_lduw_phys(CPUState *cs, hwaddr addr);
 uint32_t x86_ldl_phys(CPUState *cs, hwaddr addr);
 uint64_t x86_ldq_phys(CPUState *cs, hwaddr addr);
 void x86_stb_phys(CPUState *cs, hwaddr addr, uint8_t val);
-void x86_stl_phys_notdirty(CPUState *cs, hwaddr addr, uint32_t val);
 void x86_stw_phys(CPUState *cs, hwaddr addr, uint32_t val);
 void x86_stl_phys(CPUState *cs, hwaddr addr, uint32_t val);
 void x86_stq_phys(CPUState *cs, hwaddr addr, uint64_t val);
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 72b2e195a31..d14f14e0d4d 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -690,16 +690,6 @@ void x86_stb_phys(CPUState *cs, hwaddr addr, uint8_t val)
     address_space_stb(as, addr, val, attrs, NULL);
 }
 
-void x86_stl_phys_notdirty(CPUState *cs, hwaddr addr, uint32_t val)
-{
-    X86CPU *cpu = X86_CPU(cs);
-    CPUX86State *env = &cpu->env;
-    MemTxAttrs attrs = cpu_get_mem_attrs(env);
-    AddressSpace *as = cpu_addressspace(cs, attrs);
-
-    address_space_stl_notdirty(as, addr, val, attrs, NULL);
-}
-
 void x86_stw_phys(CPUState *cs, hwaddr addr, uint32_t val)
 {
     X86CPU *cpu = X86_CPU(cs);
-- 
2.52.0


