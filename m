Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9354C54E5D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 19:00:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkqJE-0000qR-G7; Thu, 14 Mar 2024 15:00:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rkqJC-0000ph-Kc
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 15:00:06 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rkqJA-0000zD-QS
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 15:00:06 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1dd74a009bdso2118775ad.0
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 12:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710442802; x=1711047602; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HHPCIYM44KkcXHE/rBdEnHoegFOSU8UID+9T1jpR0WE=;
 b=DSDrhrAdrCTtRkXwtpeiJdhZJ7qtMvZKNwcRCBVDZla3tk4CSrpGH0DVuISx55J0bu
 bgQJMwOz3gkhAPSJBCYoZetNQDZfHC77kUyEQK/5JpIxFiXY1e0JHaHcrV7DoHwg1Kn6
 ifuGgA/AzKTBYcn7cGZ90C9i2jYZmoNuUd99q3RIAnDjbTU4a5chlup+reeEwVj2wUcB
 90Q1eGDnR0ZOqw0kSc8lSzy0sgtbe9/g6NeoHRU39SEtEuSd4SFXih9Jon7mbOFgycJB
 RMq0/ObhE5JhbqbWvaSXO2HeoPU+yXNUBRt+ZyvL/JAtoKKqK/eWLRCciv+sIdXNl/Es
 z/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710442802; x=1711047602;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HHPCIYM44KkcXHE/rBdEnHoegFOSU8UID+9T1jpR0WE=;
 b=lwcwY1CMjFmKh4AC5qxabwAXTM1RpljWzPAoKiVnbP8VPKoXBXS5jbcdH3Tu3T5Inu
 xLgmeZiQrQFEPMv0wGbRJsXFIMuuTAe6YO/HX2OmoPainKA11BADBO3yQOcdfANzDZOX
 0JXWsebFFpIzgQkUZ5aCWz6mU6FTK5UfJUcH1LQTJw8BrwRjpL1R0n1wsDmbzh/dXtTt
 dyGvtLyPVcwpOPd79cTiPQ1cRnt4EAFIPtC9/2rdvBHvDyo+Z6LyDWuzxOrn5QkiACCW
 FsKnXPy5B/UvFNOEo3RWKxJRrLJn1uEcCZvJz9nL38u4n8p7lD9HQkLzY8upvcMfKjFT
 1jrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXS9y9UfiaViIN6UBoYxORoJg1q5K3c75d0WV1ECohbe9VZyb2b3PhBrENq29pTViryCqfcHGA0hmBUPa2SZVBpOF0wK7k=
X-Gm-Message-State: AOJu0YwG3q5pCD+oK0QmQ6LN1cnvwMduxFikfAcSyvPTG0TQPmuGNvBu
 qkIZW1ftM3eVQQFjIMMBTb4cZNke2XhPsRtOXwVZokD/18u9JdFLQ6vtI1ydgE4=
X-Google-Smtp-Source: AGHT+IFkWLwIAp45mKcewWb+uxXWoJYX00+/o/qnSdPv5ODCnMzx727kg8ZviBHRHHTtbZGSfQBl+g==
X-Received: by 2002:a17:903:186:b0:1dd:6f1a:2106 with SMTP id
 z6-20020a170903018600b001dd6f1a2106mr2967041plg.0.1710442802008; 
 Thu, 14 Mar 2024 12:00:02 -0700 (PDT)
Received: from aryabhatta.. ([49.37.251.185]) by smtp.gmail.com with ESMTPSA id
 e8-20020a170902784800b001dd1096e365sm2105732pln.281.2024.03.14.11.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 12:00:01 -0700 (PDT)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: ajones@ventanamicro.com
Subject: [PATCH v7 0/4] Introduce sdtrig ISA extension
Date: Fri, 15 Mar 2024 00:29:53 +0530
Message-Id: <20240314185957.36940-1-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=hchauhan@ventanamicro.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

All the CPUs may or may not implement the debug triggers. Some CPUs
may implement only debug specification v0.13 and not sdtrig ISA
extension.

This patchset, adds sdtrig ISA as an extension which can be turned on or off by
sdtrig=<true/false> option. It is turned off by default.

When debug is true and sdtrig is false, the behaviour is as defined in debug
specification v0.13. If sdtrig is turned on, the behaviour is as defined
in the sdtrig ISA extension.

The "sdtrig" string is concatenated to ISA string when debug or sdtrig is enabled.

Changes from v1:
  - Replaced the debug property with ext_sdtrig
  - Marked it experimenatal by naming it x-sdtrig
  - x-sdtrig is added to ISA string
  - Reversed the patch order

Changes from v2:
  - Mark debug property as deprecated and replace internally with sdtrig extension
  - setting/unsetting debug property shows warning and sets/unsets ext_sdtrig
  - sdtrig is added to ISA string as RISC-V debug specification is frozen

Changes from v3:
  - debug propery is not deprecated but it is superceded by sdtrig extension
  - Mcontrol6 support is not published when only debug property is turned
    on as debug spec v0.13 doesn't define mcontrol6 match triggers.
  - Enabling sdtrig extension turns of debug property and a warning is printed.
    This doesn't break debug specification implemenation since sdtrig is
    backward compatible with debug specification.
  - Disable debug property and enable sdtrig by default for Ventana's Veyron
    CPUs.

Changes from v4:
  - Enable debug flag if sdtrig was enabled but debug was disabled.
  - Other cosmetic changes.

Changes from v5:
  - Addressed comments from Andrew Jones

Changes from v6:
  - Cosmetic changes. All patches were run through checkpatch.pl.
    No errors/warning.
  - Remove all debug || ext_sdtrig references. All decisions are based on
    debug flag alone
  - Added null check before itimers are deleted. Without this check a
    crash is observed.

Himanshu Chauhan (4):
  target/riscv: Check for valid itimer pointer before free
  target/riscv: Enable mcontrol6 triggers only when sdtrig is selected
  target/riscv: Expose sdtrig ISA extension
  target/riscv: Enable sdtrig for Ventana's Veyron CPUs

 target/riscv/cpu.c     |  8 ++++++++
 target/riscv/cpu_cfg.h |  1 +
 target/riscv/debug.c   | 35 +++++++++++++++++++++++++++++------
 3 files changed, 38 insertions(+), 6 deletions(-)

-- 
2.34.1


