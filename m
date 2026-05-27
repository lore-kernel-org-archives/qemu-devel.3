Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8899CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 20:16:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSKex-00084h-IE; Wed, 27 May 2026 16:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSKew-00081g-Gw
 for qemu-devel@nongnu.org; Wed, 27 May 2026 16:15:22 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSKeu-0005fj-Hq
 for qemu-devel@nongnu.org; Wed, 27 May 2026 16:15:22 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-45ee1a4cd2dso144972f8f.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 13:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779912919; x=1780517719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3SwaiZ85vx51Jxqz+Ao7fBPYHCfcHkKwY4wASWC2Ft8=;
 b=Y/cba+Bh6ToeQN4+6iNbKQFXNMaKsFa5csh+qJifwtc7GqThlLY/kbyT9JAcEgFTzb
 Dp8KGrYx0d4YQQBBJXPfhN/LCU1i/2zf0TMjWvYWpoHeFC4KrJeT+UlhL/x4XS64TC5t
 g7hlCmpxVjXniOkHPsw1+PMO5Tr79kZYkNs3AGM/XffbzgmfJ5KzpR/ZftLNoM4DTy6A
 zyby/1M1ZWOhQV/S9n7uNX6fLFTWGI89quIvHGFC8pN1YDG9Iw4rGVw5yPzJ6r56Fdgt
 XZSMLiZR8Dow/3NK4NC4tEJvOmV+VSQNBmdvS9mRoNp9x20ZD/WAU6ua6ueS7YXz/iCr
 6U4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779912919; x=1780517719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3SwaiZ85vx51Jxqz+Ao7fBPYHCfcHkKwY4wASWC2Ft8=;
 b=HIa7sekEJOBQb43Ago+g5EfWoNbN54CC0bDrlNFcWAWC7H6QGJAoU/TWch2DhB4HD6
 rIVrnkhPfFA2LsJ75llo9nUI+4ybIAXjMpeQMoPHcUCcw0fABuzC/+8pwE2vTTw1KHw9
 +SsgslE4bKbAOMAUBG6p3dtuM02FBE0hCUxBJpHUDYA+2FRY+umD3uf0KIxtbPyz0uIH
 iwen6i1siUOHr25syz1YPOuamiFBvrUvE5mJBlq5zoIs5rncIG+MBnaGf8ZPu5Qb1Y9P
 pjgvOC118q1QLESkTogOxk9mB0nFmT4OuAP7VqeE7LuzRMSZe7Il06psuf0YLIidSccF
 xVhA==
X-Gm-Message-State: AOJu0YzA1BDgtGFmX7VqwTV6gjpV6PNFxAW1jSRDXLQ6M1QGtPmGrMAN
 c1lDAN/QPRRFdfR2E5OzJiF4Go+TBucSHqIJx5XLVEGo1625aXdW5BUmn2xTeM1nroS6Wj2SSDP
 zRGSCMvTBqg==
X-Gm-Gg: Acq92OFQ/FCZ4jo00R9uvO2aqUipRdzBrRpiSj5Qvy3qAEDMXBNxSHS2azH7BemTd/E
 ecilu5nKf2Fc2Krins/Lyj7KqprcbaWSQzDx+iAZ7TFFhZm54+1sjX0/aU2zLnZsbkf8GKqmLbw
 Y6Hk55QCP26K/hQw+q4KLM3bZ5lMlWwvUNRwzHus/OVd5dSd8Yc61CVcP0TEUTeabt3JMBpg7wG
 tN/jO7JnmMjSCqX6bBjmIP4wSbhyifHCJwwC0O6XWl1Fhr945Iy+qWMvirpJsjGZ9mTMrVjsUaz
 x3QXz3GqV6VUHTlDgRlHqQJ++G+hUukoLvIf9lV9ng40KRDKc7hPMhuH3F0dK6Reu9HtMvdMaFa
 BDhvUIRrv+BZUU8jaFQFrYik//U6yNna5aA35L16XZEdIHH7uCmtq1sHqck+WpwIqitDUND0r+a
 UFxdtFdO7vnjJVnLCyy8jVH76HLbR4YFxWADCnbeFrxcs3md9ziXOOjH168gLRkbi0KQ==
X-Received: by 2002:a05:6000:18af:b0:45e:9304:a4c3 with SMTP id
 ffacd0b85a97d-45eb333aa31mr36621337f8f.19.1779912918629; 
 Wed, 27 May 2026 13:15:18 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5a2a73sm8162405f8f.22.2026.05.27.13.15.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 13:15:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Anton Johansson <anjo@rev.ng>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v11 11/12] target/riscv: Expose and document the CPU
 'big-endian' property
Date: Wed, 27 May 2026 22:13:47 +0200
Message-ID: <20260527201348.29511-12-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527201348.29511-1-philmd@linaro.org>
References: <20260527201348.29511-1-philmd@linaro.org>
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

From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>

Now that the full big-endian data path is in place (runtime MSTATUS
bits, boot code, and page-table walks), expose the "big-endian"
property to users via DEFINE_PROP_BOOL and document it in
docs/system/target-riscv.rst.

Document that the property models fixed-endian hardware: it selects
harts whose MBE/SBE/UBE fields are fixed to 1, and it does not model
a mixed-endian implementation where software can toggle those bits at
runtime.

The property can be enabled from the command line, e.g.:

    -cpu <cpu>,big-endian=on

Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/system/target-riscv.rst | 29 +++++++++++++++++++++++++++++
 target/riscv/cpu.c           |  1 +
 2 files changed, 30 insertions(+)

diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
index 3ad5d1ddafb..afd86ca2ba1 100644
--- a/docs/system/target-riscv.rst
+++ b/docs/system/target-riscv.rst
@@ -95,3 +95,32 @@ the images they need.
 * ``-bios <file>``
 
 Tells QEMU to load the specified file as the firmware.
+
+RISC-V CPU endianness
+---------------------
+
+The RISC-V ISA specifies that instruction fetches are always little-endian,
+while data accesses can be either little-endian or big-endian under control
+of the MSTATUS ``MBE``/``SBE``/``UBE`` bits (see section 3.1.6.5, "Memory
+Endianness", in the RISC-V Privileged Specification).
+
+QEMU implements the full data-endianness behaviour described by those bits.
+In addition, the RISC-V CPU object exposes a ``big-endian`` boolean property
+which models a big-endian-only hardware implementation, where the
+``MBE``/``SBE``/``UBE`` bits are hardwired to 1. When the property is set,
+the CPU is reset with all three bits initialised to 1, so the guest starts
+executing in big-endian data mode from the reset vector. The property is a
+static, per-CPU hardware configuration option and is not meant to be toggled
+at runtime.
+
+The property does not model a mixed-endian implementation where software can
+toggle ``MBE``/``SBE``/``UBE`` at runtime. QEMU's RISC-V CPUs treat these
+fields as fixed by the CPU configuration: they are reset to 0 by default and
+to 1 when ``big-endian`` is enabled.
+
+The property can be enabled from the command line, for example::
+
+    -cpu <cpu>,big-endian=on
+
+No upstream CPU model currently defaults to big-endian; the property is
+provided so that big-endian-only RISC-V CPU variants can be modelled.
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index fef424f2bf9..c8a41c57a57 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2520,6 +2520,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
 
 static const Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
+    DEFINE_PROP_BOOL("big-endian", RISCVCPU, cfg.big_endian, false),
 
     {.name = "pmu-mask", .info = &prop_pmu_mask},
     {.name = "pmu-num", .info = &prop_pmu_num}, /* Deprecated */
-- 
2.53.0


