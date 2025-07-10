Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10930C83F22
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 21:11:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZyXu-0000X0-Jg; Thu, 10 Jul 2025 17:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uZyXi-0000TY-4X
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 17:11:01 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uZyXe-0006bu-VJ
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 17:10:56 -0400
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-234d3261631so12738755ad.1
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 14:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752181853; x=1752786653; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZHcxjosZWahGjCunSAtbcvQ0wld6Cf/5jVHz9hCwO74=;
 b=r9EkwcHLeoYxlr2iadepHI7SZKMatRuhF9ZqdpvGYVLN0jyVq/Gb+usbWIaAnFj1yh
 Qpo7gmHkfzu+A5wXocE3TqUvtRioqOB3tM5+cXplBDCqlckm/KRWfY2AhRVP8QfqM+8V
 44YD56lyxBKDTMFRxpd/sFEhm933u2MGtcynmd4OCf/+Nd+yz5CY3cRtw4uGC57Rc1bm
 8sUfEjOTKbWLOhPBR0cJ+Fnjn7S99CUhsf1o/zH11I4xbkVFI8CEILl4aUZU6x0JMhYs
 tFCfPfv6XBpWXiXIQppS3MLJW7CFu3v3stQJJu4+CTcafubwk0JPIC5gJKGztlok5r5G
 8NHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752181853; x=1752786653;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZHcxjosZWahGjCunSAtbcvQ0wld6Cf/5jVHz9hCwO74=;
 b=QTioyyZsnfe3TLsMv6hnkJ6RbffMGbLFLY9h7BZoNAwdlQSAm/sEBH+nrwdw4fLUGA
 mryxsOwBp48HUxP6956VmTdbcUbvNDqHugx3u2Nb23Ib/JuXVdKU4TlnMFRTz8keb0H+
 ErmWLNdijyYsRz5hEj1ZITctC7syQwhAfCxlqUKhpbjUU6JZ/ScBR2gg+pSFb4qBhDJW
 jq8jUIOb+t3ZVH3ldV2PbNyjU6tabxA5X2jkwvmov27uQluoQJvGoVmgHGve0LZAH9Pw
 r0ID8LpacNl+SuZolGi+YxXwU9Pgz+UMka7aYN0nunbIz8lhVZwLAmvHOypIJ8LYWuF1
 +KXw==
X-Gm-Message-State: AOJu0YyMixKUir67DjkWjMlBAzqNv2Dng9VpRSQhff+KyuurMar3MRvP
 9prHQvTXiWm4SOJW3mP52vEbsDpDENvt0qxupeIMB3tqWQ+40OFRbU2P0bA4JtxRWWc=
X-Gm-Gg: ASbGncvNv9uDr5rxd3SdemV7LTbXXklB1SehKVytjDeuitMSpZglRAcWU8YF7ziSU4K
 biY3E5gJL3LbjgveF1GZRUU62RsMO339Gu4clqYZw/JGOZg8zjGCMchBq9LRG1JXgDGwUREmTMu
 7uHjfKSUlMOwmgJTLvZsN5YYC4JbHse7Iikcr3WYIrV2PULW2iMwcrbbWiNtUtbpILxNk6hk6RH
 w/cYCxI9jI4sgYIfSDQPv83mZz4UkkX46IAkAbDzvGpevR0ESwezxj4sI8B3qoqsCnYDAHcogxq
 8Dadg005BmxPwvlGRWMBzyIzFwEOj/Wpkv607t4R15H/ObN7/ll0IPQmMnk6CQ6S2moVgKPEFQe
 b3xAwvY+fMWS2grqFUM4KavyXWxiPLahiSR3T0kFVn2RhaVFTDHiED/rd+9ITmxc4WMY6
X-Google-Smtp-Source: AGHT+IEb8z+cGX1JBAFYaZtvTH8O0bFuNe/GuqIo7CDMeRFfoWfsgveHQBUBvHBnqTgjjUhCmW5RRQ==
X-Received: by 2002:a17:903:2ecd:b0:224:1eab:97b2 with SMTP id
 d9443c01a7336-23dedfaa6b8mr10164685ad.53.1752181853182; 
 Thu, 10 Jul 2025 14:10:53 -0700 (PDT)
Received: from gromero0.. (189-47-46-41.dsl.telesp.net.br. [189.47.46.41])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de434d6b0sm30447775ad.203.2025.07.10.14.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 14:10:52 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-arm@nongnu.org, richard.henderson@linaro.org, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH-for-10.1 v6 0/6] target/arm: Add FEAT_MEC to max cpu
Date: Thu, 10 Jul 2025 21:09:35 +0000
Message-Id: <20250710210941.1098088-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x642.google.com
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

Since v4:

- Moved MECID_WIDTH from cpu.h to internal.h
- Fixed stray ';'s in access and write functions
- Use of GET_IDREG/FIELD_DP64/SET_IDREG for setting feature in ID regs
- Sorted correctly isar_feature_aa64_* AA64MMFR3 tests
- Simplified/unified accessfn for cache instructions
- Fixed how cache instruction-related registers are registered in the cpu

Since v5:
- Fixed missing checks for ARM_FEATURE_EL3 in sctlr2_el2_access and
  tcr2_el2_access functions

v1: https://mail.gnu.org/archive/html/qemu-devel/2025-06/msg04598.html 
v2: https://mail.gnu.org/archive/html/qemu-devel/2025-07/msg01799.html
v3: https://mail.gnu.org/archive/html/qemu-devel/2025-07/msg02338.html
v4: https://mail.gnu.org/archive/html/qemu-devel/2025-07/msg02488.html
v5: https://mail.gnu.org/archive/html/qemu-devel/2025-07/msg02689.html

This series adds support for all FEAT_MEC registers and cache instructions to
the Arm64 max CPU.

It includes the FEAT_MEC registers and cache maintenance instructions, but does
not modify the translation regimes to support the MECIDs, so no encryption is
supported yet. However, software stacks that rely on FEAT_MEC should work
properly at this point.

I'm currently exploring possibilities to support FEAT_MEC encryption (or
obfuscation, for testing purposes) in QEMU for the various translation regimes
on arm64, hence the encryption part of FEAT_MEC will be contributed later and is
not targeted for QEMU 10.1.


Cheers,
Gustavo

Gustavo Romero (6):
  target/arm: Add the MECEn SCR_EL3 bit
  target/arm: Add FEAT_MEC registers
  target/arm: Add FEAT_SCTLR2
  target/arm: Add FEAT_TCR2
  target/arm: Implement FEAT_MEC cache instructions
  target/arm: Advertise FEAT_MEC in cpu max

 docs/system/arm/emulation.rst |   5 +
 target/arm/cpu-features.h     |  15 +++
 target/arm/cpu.h              |  27 ++++
 target/arm/helper.c           | 236 ++++++++++++++++++++++++++++++++++
 target/arm/internals.h        |  23 ++++
 target/arm/tcg/cpu64.c        |   7 +-
 6 files changed, 312 insertions(+), 1 deletion(-)

-- 
2.34.1


