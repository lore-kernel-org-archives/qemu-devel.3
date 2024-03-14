Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC0FC5475B
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 11:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkjNA-0001NN-Aq; Thu, 14 Mar 2024 07:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rkjMr-0001Kx-Jk
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 07:35:26 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rkjMi-0007Gm-DO
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 07:35:21 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1dde367a10aso247245ad.0
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 04:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710416114; x=1711020914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VVVLOLyRJ+K930ODIuaC3Y3UaTGDwGJudFyiwPiu4KI=;
 b=chGoOelmHMsNGMUcD7zuEtIYJRAh14Z/7puGcmT/7L2y/cdxjq+1PY8UiPzQtTdch8
 IAfyFjd8xsqTAaAYkVZM44n24Q8aLNbHrMD6732GuFCFuhGHAy4riytwrGIlUPcN56/h
 3ctVAXzc/lvTZvVLdlbEG4SwXc6kE3vyrVFYV4W9KGiEQC8JF75e60Y5L9g7pFUf2FT5
 NbOoDrbc30B9Ats4qJXhx4qQdwsOi9qL09KgPpfxXFicV810RSQCnoDa7V0fK5IzvPai
 1If0JR5QjYEWVXTUQilVNFylhXb44WNyxJdUzm3chJb++CqIS8tc2461qsT4JpxEf3uc
 WN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710416114; x=1711020914;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VVVLOLyRJ+K930ODIuaC3Y3UaTGDwGJudFyiwPiu4KI=;
 b=LdP67F1r6ZqSkCvWiqT5hgPdj1OlVFgU/mwlHPTMmKzRlZ3HY41o6NWizS+q38zYWX
 E/eQKn3UuFS1VOV6P4ymTTWpdQflC71Y0SqlE7kdFRUe9gMn3uQXtYIaS2mpEM5SgOTo
 JQoA4bDW1STFzYGxxfzYSZ9YJSWNj+zCiI40G30qsobs6T7ZFgVTJMXUZeZGjhJ8zS31
 SySNinK5H9Nlp5PfqpwGxemZF8pHHj3o8GAM6jTwv/YqKDlrDU20CveSy07SGUD448c8
 yKwLCg5A5WnvPfa9/akU2I4ZJS/ehTCDhCU4skh0HjZeOe9s5RVEq32NRdY/VajOPkAO
 oJyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRUUP7Fdq45z/4QpvEkaTzyYF4TM1P7uGdb7kyf4Xmuj4uVA+KdJkexIylVznQai2ABxSzwnxqz3ucW0fTeZuJvFaVEpQ=
X-Gm-Message-State: AOJu0Yw4qcoPQs6IDRFbCZF9+ZCPhxcGSXlxH1qaIW/0LG/zFEdVP2wk
 4pjNklUQx1Kf0Q0YSIBHdmnKfjHGO2S9uJbmOZdmih34rbnDMG1nK22xjFT+Ik0=
X-Google-Smtp-Source: AGHT+IHtHeOi51JCCfYD3j7qhpwzHIkGhFu0lWnwYohYWvkccQv882A9wEQrENt+2riU01R9p1FGhQ==
X-Received: by 2002:a17:902:e551:b0:1db:f23f:676c with SMTP id
 n17-20020a170902e55100b001dbf23f676cmr1577581plf.0.1710416114162; 
 Thu, 14 Mar 2024 04:35:14 -0700 (PDT)
Received: from aryabhatta.. ([49.37.251.185]) by smtp.gmail.com with ESMTPSA id
 y7-20020a17090322c700b001dc6f7e794dsm1465859plg.16.2024.03.14.04.35.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 04:35:13 -0700 (PDT)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: ajones@ventanamicro.com
Subject: [PATCH v6 0/3] Introduce sdtrig ISA extension
Date: Thu, 14 Mar 2024 17:05:07 +0530
Message-Id: <20240314113510.477862-1-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=hchauhan@ventanamicro.com; helo=mail-pl1-x62c.google.com
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

Himanshu Chauhan (3):
  target/riscv: Enable mcontrol6 triggers only when sdtrig is selected
  target/riscv: Expose sdtrig ISA extension
  target/riscv: Enable sdtrig for Ventana's Veyron CPUs

 target/riscv/cpu.c     | 12 +++++-
 target/riscv/cpu_cfg.h |  1 +
 target/riscv/csr.c     |  2 +-
 target/riscv/debug.c   | 90 +++++++++++++++++++++++++-----------------
 4 files changed, 65 insertions(+), 40 deletions(-)

-- 
2.34.1


