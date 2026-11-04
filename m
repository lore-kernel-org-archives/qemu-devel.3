Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97862606B392
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=HCVfw/nA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOgu3-00065M-2l; Wed, 04 Nov 2026 14:44:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgu0-0005uk-IS
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:44:09 -0500
Received: from mail-dy1-x1330.google.com ([2607:f8b0:4864:20::1330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgty-0002gJ-J5
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:44:08 -0500
Received: by mail-dy1-x1330.google.com with SMTP id
 5a478bee46e88-36dbde64409so518210eec.0
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 11:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793821445; x=1794426245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WLBndAX9Hk/SEvKvgjaacaz2TqGp7WomTMiVSCK67EI=;
 b=HCVfw/nAAu7qLqVghq10PWODDbp05vewOwp1FgJJ0M6b491iPydtgmQY7JY1ImYEXV
 +3inggOkw0n+zjvWxlfPczUvmw6CnFW2V/RzLCQvZT2C4amHzKLPk8MBQjnI/F5+Scp+
 Bt/4PE0T1lNuucycr/3GJLNZaJQuILQT/jYFp6hTlZIFllGn2yr7DPzMV/N6bUV0lIxJ
 h8gprQDytdVVOewCWPpqkkYYv8RiI9ymAVGa7wcn54AR2IT8WScBrTvA84rBQ90vnJT3
 PCzmqy0HsH+kpen4qOxBVoJ/vE4TBMv9sehCn1EHHdc0yBuDpXAb59By2TTxGunKkgZG
 XzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793821445; x=1794426245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WLBndAX9Hk/SEvKvgjaacaz2TqGp7WomTMiVSCK67EI=;
 b=VtmFE2UXM0KunzEuTHu7bbDcZWqBg+vcEDSwECmLo1CcacpXwnxQAXpi9NmdgWe+cM
 8lXaX3FDrwjqYm0MBqZBiAYEyX+FgR1fykAgNm7SnPCD3iDZZDldixKkez5LQBKYGL4b
 N4yKDk3qVc6mwJLXVbaJ3op1EcJIsiNtFI5YM1nAxwLB9pVBZ7uhI4FPHTJr4QziVAJD
 kZUoEq+o7bmWDIGBmMzgmcy1hkM0CYBwh9LtEWG+vuICsn7gu9IYLfsfFncltpp8nkyh
 kF8VFz6YRPlZYjt8lnjdhmZym2O+pEmE8IX3TJsEwMHnYwrtKygj49GYkjgf4zDV7sex
 +EIw==
X-Gm-Message-State: APuU4Z/Bax1yK+LirdRDNWIKjF8bNUyLGOP3x6JRWApiiw++kDO9qeJ3
 hYYCAWTyUYYuIO0f4fg2VKIntesOUfN/TN7A/CR7rBo1iTD0O26AkL/zODKnqwnN8A1aEzhY3d2
 8K0ocj/mxvYMqkeriVLQ1UHT5YsW/Ff5e0x3AlVaPtGP176vFl8YajtGqmRtnfOtSJ9PAk5VnZD
 xnZInnWj7tTVa+RNva2om9HLGE0aZw1tGcxomRgq2KDg==
X-Gm-Gg: AYBFou0weZX07pa6GEYsXLONiX7kaIdBgNvH6BlkULNH2wY4ceVNVHaf9B4Oo0gw9Us
 weNQsM5l58/IBofvTtqJiI3SSddxgv4bAGuXv/X163b12W509bajyiYhcMg/TmqkAHsLTEt3BAp
 EhYDWdNMohNo1pm4TXP4zqWyecZPHKUOFzqwBDyem3VeaJlqKnHjio9BMCFeu70q7xi454Vgv9x
 ICQ7tcvnJtYqzHx45IQ2drO3gFTLiZTmrnXP/FS12iF2XV93UVQS0IxsPCaTB2bOVtShJJoH52r
 rtaR6IMWlwcmSK0U/rf3L0iM4K1UNa/FwuYTFmi+WkNR60/qPX/l6OuvtJxai9k6xa0EWZlinxc
 hVTF1YHvZAR3zT2MZ8h8IhStgn9QimYG9eDxG/UXB65PhmGOPHgUtTuaQje2NvybFuCmFvpR0TT
 LI536OHeNv4rHfFJiellVjxtsEt4K209Dyq/YxyAh1ggk9d280JGhznDAXsJSAL0bDltW4lbd93
 RL94lS/3Rr9MfNT/PCYGEp/yMpCwYA/EZtA8RGxEGgDhdjcjAZFtaEFt0mevr3jnHK0dDsyNiTP
 PehvDp9NPHHzNpEQxHInbyJdthPO4O9y5PVatExaRL/eSBk4J9KIF7Cl2/9mLmPDTFb4EDLOUVN
 tHAuNflRMGAVEbVl+gdrp/DS7LY3D0dfEdw0x+6JhZxsNMdLzvg==
X-Received: by 2002:a05:693c:65d2:b0:36a:18d2:8c79 with SMTP id
 5a478bee46e88-36a423c0bbbmr23338554eec.19.1793821444930; 
 Wed, 04 Nov 2026 11:44:04 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca38d36a1sm11299527eec.12.2026.11.04.11.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 11:44:04 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [RFC PATCH 35/38] target/riscv: Add implied rules for Zvfbdota32f
 extension
Date: Thu,  5 Nov 2026 03:41:50 +0800
Message-ID: <20261104194155.679241-36-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104194155.679241-1-max.chou@sifive.com>
References: <20261104194155.679241-1-max.chou@sifive.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1330;
 envelope-from=max.chou@sifive.com; helo=mail-dy1-x1330.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add implied rules to enable the implied extensions of Zvfbdota32f
extension recursively.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ed0f5ed976a..ff09bafe667 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2903,6 +2903,15 @@ static RISCVCPUImpliedExtsRule ZVFQWBDOTA8F_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule ZVFBDOTA32F_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvfbdota32f),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zve32f),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 static RISCVCPUImpliedExtsRule ZVFWBDOTA16BF_IMPLIED = {
     .ext = CPU_CFG_OFFSET(ext_zvfwbdota16bf),
     .implied_multi_exts = {
@@ -3131,6 +3140,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     &ZVE64D_IMPLIED,
     &ZVE64F_IMPLIED,
     &ZVE64X_IMPLIED,
+    &ZVFBDOTA32F_IMPLIED,
     &ZVFBFA_IMPLIED,
     &ZVFBFMIN_IMPLIED,
     &ZVFBFWMA_IMPLIED,
-- 
2.56.0


