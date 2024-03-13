Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F313C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 18:21:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkTDn-0002kg-9W; Wed, 13 Mar 2024 14:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rkTDl-0002jN-0E
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 14:20:57 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rkTDj-0007vI-9N
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 14:20:56 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6e6aa270d55so40636b3a.1
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 11:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710354054; x=1710958854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=4P1Y9DU//c5f5UPKRjdSsKnX1qZro47d4XTjh0nhijE=;
 b=hDCtqBmIbfcWwkT9PlBYVNjyE4DYlm0Clsvz4Dlotox818LFbmtdlhWdBjGp3kZGSJ
 t+U0lETOygqQjlA91L2KwCkeJn8XYrmenyS54FY7oMeQGk3QO0sLwST+L9vwKrFFJwu0
 KYM2/scVZmL4lEKiS17c/r+MFdBCPCyxOfoyPdqOvHmzSOgBTCwTxrYJ0Q6WFS2R7OQN
 nnDi6r6N8zcIMS1l3qY6P8QVeIaW8E4bbJvUtXbFOBuwY0qYxrinvTurn5Xla14nqet3
 2uuZvoSDQjA3PiPV2CWCS3QO5U3PHLI1WMmiC++6i0ux7cS5VTy9Xf/Z7eke+Z8TMRWb
 /cKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710354054; x=1710958854;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4P1Y9DU//c5f5UPKRjdSsKnX1qZro47d4XTjh0nhijE=;
 b=SF0V/dlwHpXnVr7ZiQ89eX+S0d2Ho8rSAyBHSFRHA+1g1geitSwlaa+EjA+BdR9ODF
 hpPbdaWCb8Qy2zO71YTut0re7TKTqjIUuIiSBXI1EleZX4lplYN8j4Z1TJo8OslZonjp
 /sxCWagEuQPj7mzJ1a8my1sXB3XoMsjL9FWtkB7g2k5rjKfaAdoyV8OE0HdKpqMHvBRT
 Z2toCU4iWeWeKLtHRByehPn8RTXGSMfuMRyNxJrf2XLt/ISn2jpNaJSAzYvueROMxhRR
 39uHITvLT/W91khj5f15vNnvBh9ctQq7+l4PqN+3VLwSe421uVi//c0apc9NXfeX7afO
 RbcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyBIAcmi99zCTn0Bxx/CjUCwdlytKBJIltlSi6MKca4GJ0htZsToRV6Dhq012Ghmngh1aTYI9MBu4EJyCkwcV+cahvjJ0=
X-Gm-Message-State: AOJu0Ywdetz3zdv/anck3v2V/zqssmyNUI0xqLHVUWnUreK2UBL6y5cH
 /uqks/PMCL0K7wUiKMf42y3Nt9EibEyVBNgXBdPAnQEHtS00pRpghte0uBuuYb4=
X-Google-Smtp-Source: AGHT+IFkt91b0cgZaM3nQms9WW1oIWnAisEiKsNeGsIelTX3n9RRwZYurMWUlKzsmwBpXtfe1Hl2oA==
X-Received: by 2002:a05:6a21:2d8a:b0:1a1:6ced:a0e0 with SMTP id
 ty10-20020a056a212d8a00b001a16ceda0e0mr2606232pzb.1.1710354053470; 
 Wed, 13 Mar 2024 11:20:53 -0700 (PDT)
Received: from localhost.localdomain ([49.37.251.185])
 by smtp.gmail.com with ESMTPSA id
 l22-20020a62be16000000b006e6a16acf85sm3457528pff.87.2024.03.13.11.20.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 11:20:53 -0700 (PDT)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v5 0/3] Introduce sdtrig ISA extension
Date: Wed, 13 Mar 2024 23:50:06 +0530
Message-Id: <20240313182009.608685-1-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=hchauhan@ventanamicro.com; helo=mail-pf1-x42a.google.com
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

Himanshu Chauhan (3):
  target/riscv: Enable mcontrol6 triggers only when sdtrig is selected
  target/riscv: Expose sdtrig ISA extension
  target/riscv: Enable sdtrig for Ventana's Veyron CPUs

 target/riscv/cpu.c     | 12 +++++-
 target/riscv/cpu_cfg.h |  1 +
 target/riscv/csr.c     |  2 +-
 target/riscv/debug.c   | 90 +++++++++++++++++++++++++-----------------
 target/riscv/machine.c |  2 +-
 5 files changed, 66 insertions(+), 41 deletions(-)

-- 
2.34.1


