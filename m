Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5672CD3447
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 02:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLtg4-00065N-Ia; Sat, 09 May 2026 22:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtg2-000654-Or
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:13:54 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtg0-0002sT-Gn
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:13:54 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6967fd0416bso1806947eaf.3
 for <qemu-devel@nongnu.org>; Sat, 09 May 2026 19:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778379229; x=1778984029; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=n0iS/uhByUf2JHzeZr2c5klb4gSQ28V0D6/9+AxgAA4=;
 b=Zsq3YjEO/VTgGNfPgjoAg95kbQP4OilTla+3UG86oXC2fAIQKEC/sysgkR1zBc0hn9
 zb8rJ28xaivJJZtMqpAfVFYp7ZdYoj1qZTaOME2d7CzQQ/B2zXLqXxsv05vHI+AFyUrb
 o5flus/jhaiNXVFy6zIAvvtcJngFEryJrE/ZZckRoHS7PaiehzbFpNIqFOsFfwOBXCLw
 ZBOb9ibY01Sf1TZP5Iz0vPSlWuOiL7syP5lbs3f/Zg64kV7ZrXUiyhSTR6AGyiaqKJjI
 Q3LaQQ5YNikXFJXFyjRPDj9ytcsQaM5LnELj9EvJrUBtvWU5BO/WEzTpVwP6pm7fncET
 LGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778379229; x=1778984029;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n0iS/uhByUf2JHzeZr2c5klb4gSQ28V0D6/9+AxgAA4=;
 b=aYjUh5Su5rqnMvJ9m8YpSXYjetl17p7iGLOAsMswPjYJwCYfB1K9XdbLOO+9puNZ6j
 07MKDIKingoWaRPprG3BRs9WY6hEzkQ2w2hZvNWsF+IYBQ6XsZr4Nwu9cjAZxboefN3r
 AK5dJM5fz3KmhXG1LUuJl75KNDqKDhdzgfNlGvW02eHeU5ix6IuwB3446spp6KG+vyZ0
 WDtlcHOlATYYqei9MH9VA4mZxhN1WX2tOfl3XFKt46o4IFDtes46yQz0bZNREHc9D7Vx
 G16Hiov7tLGRqE8iIwsh3wt6f8w7HBAKinePoCkiAodBHal5eN6raf3pGp54AoDVu3dn
 Enow==
X-Gm-Message-State: AOJu0YyMcdFw8UDwc2p9mI4z1w83jK0NkQ6XsKUU60XWFLsrz3qn/VIr
 iMYMOXCoxvnVX6W8fAZV1Xbl85pZ/W9qY2bK40R3b2qfZoSQdAVjx4PTe9BirJQ5
X-Gm-Gg: Acq92OHuO5uh+y0QOUNkVU/VDjidp8WcSEEA4fyzSdd/+IV8IOL8jUhLBFXfhTSPyNM
 CZXWpsCXYzci9tGZN7O6BAa4Zd4uJ+k7tNR4RszHfpDf4EWuKeXxsZV46YuAq8+fl2Xs8iBbiel
 g/HH8HVPqNzjkzalMUxUXyoveNhByEXY4VAOiNCesCGiO7/e4jsn3dZ07ObYSvHPhYRPVSaB9fe
 Bm8FCqG/+R5f4Tlx0UGplWNb2sNR44uoOa7UUNznNh+P+fdkUJUsGr5qT1s2bj1tNFfTtFX45oQ
 VQ48CcOaelgq+AzMoFa5NoiXqoIEYGJ8FndX2/DPGQyh1LZ2GPG74QBTzedSXaaqipszwMm4H1E
 T8pzRRnw6uxNBx0LLMV195Epe2B4kZvqbeAKffb8n8z2Drj95upj1dYbevcHfJnRabsn1DlWZgT
 iXX69d+oomasH2jjKTEfub0RYaDQCnSy77fYtxK/kkOieiBIBjakwe8EuH5x2ssrCE7rHx4FUsM
 /sdExM+UBchhzRHe6Qu5Nep40BNMFq5q2JiwrWygL/rTsm5+2lgGvizEz4XccIjqb4e
X-Received: by 2002:a05:6820:99a:b0:696:17a6:c06f with SMTP id
 006d021491bc7-69998c8329amr10718380eaf.12.1778379228865; 
 Sat, 09 May 2026 19:13:48 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b25dbffdbsm3645643eaf.9.2026.05.09.19.13.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 19:13:48 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v4 00/32] target/mips: add missing Octeon user-mode support
Date: Sat, 09 May 2026 20:13:23 -0600
Message-Id: <20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNzQ6CMBAGX4X0bE0p/558D+MBlgXWSEu6SDSEd
 7dgjPGiyR52ki8zs2B0hCwOwSwcTsRkjYd4FwjoStOipNqz0EqnKtZK9jSwtDCiNf5nJtNKMmx
 YTlommBZRliloNAivGBw2dN/0p/OL+VZdEMbVuS464tG6x9af9Lp7p8LfKX9KliorwroJ8xyKY
 9uXdN2D7cWamqKPLFH5H1nkZRVUCEUaJVn9JVuW5QkUUtkbJwEAAA==
X-Change-ID: 20260420-mips-octeon-missing-insns-v2-5e693770cf2c
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oo1-xc35.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This series updates MIPS linux-user unaligned-access behavior and fills
in missing Octeon user-mode instruction support used by existing Octeon
binaries.

The first patches model the Linux/MIPS sysmips ABI pieces needed by
linux-user, including MIPS_FLUSH_CACHE, MIPS_ATOMIC_SET, and the
MIPS_FIXADE policy used to control unaligned scalar access fixups.
User-mode unaligned scalar accesses default to software fixups and
sysmips(MIPS_FIXADE) can toggle SIGBUS/BUS_ADRALN behavior.

The Octeon patches add integer, indexed memory, atomic, multiplier, COP2
crypto, CHORD, and LLM support. The series also adds a small
mips64/mips64el TCG guest test covering representative Octeon integer,
multiplier, and COP2 selector paths. The final patch corrects the
Octeon68XX CP1 feature bits and FCR defaults.

Changes since v1:
- Split BADDU/DMUL destination fixes into a separate patch.
- Split the SEQ/SNE decode refactoring into a separate patch.
- Moved Octeon multiplier state to uint64_t arrays and updated VMState.
- Switched Octeon helper ABIs to i64/uint64_t where applicable.
- Moved COP2 selector decode/support logic into octeon_translate.c.
- Added in-tree TCG tests for mips64 and mips64el linux-user.
- Used switch ranges and g_assert_not_reached() for SHA3/ZUC shared
  selector handling.
- Dropped Octeon prefixes from generic Camellia helper routines.
- Replaced the reflected GFM 64-bit carryless multiply loop with
  crypto/clmul.h.
- Moved the Octeon68XX CP1 CPU-model correction to the end of the
  series.
- Added migration coverage for Octeon COP2 crypto and LLM sparse state.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v4:
- Added Richard Henderson's Reviewed-by tags to the reviewed sysmips and
  Octeon translator cleanup patches.
- Kept the Octeon3 MPL3-MPL5/P3-P5 high-lane multiplier state
  documented by Cavium SDK/toolchain sources.
- Documented the Octeon3 two-source MTM/MTP forms and preserved the rt
  high-lane operands while legacy one-source encodings use rt == $zero.
- Simplified SAA/SAAD translation to use the i64 TCG atomic add path for
  both word and doubleword sizes.
- Marked SAA/SAAD as Octeon+ instructions and gated them behind a
  separate Octeon+ feature bit.
- Simplified LA* translation to use i64 TCG atomic helpers for word and
  doubleword operations, with MO_SL selecting word result sign-extension.
- Link to v3: https://lore.kernel.org/qemu-devel/20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com

Changes in v3:
- Rebased on current qemu.git master.
- Split sysmips support into separate MIPS_FLUSH_CACHE, MIPS_ATOMIC_SET,
  and MIPS_FIXADE patches.
- Made MIPS_ATOMIC_SET always use the MIPS separate error-result register
  path for successful returns.
- Removed redundant Octeon MIPS64 checks and target-long guards from the
  translator paths.
- Removed zero-register fast paths where gen_store_gpr() already handles
  discarded writes.
- Reworked SEQ/SNE decode and LA* translator helpers as requested.
- Split the Octeon arithmetic/memory patch into narrower state, indexed
  load, SAA/SAAD, ZCB, multiplier, and test patches.
- Switched Octeon multiplier limb accumulation to uadd64_overflow().
- Link to v2: https://lore.kernel.org/qemu-devel/20260421-mips-octeon-missing-insns-v2-v2-0-a0791df188c9@gmail.com

To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
Cc: Helge Deller <deller@gmx.de>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Aleksandar Rikalo <arikalo@gmail.com>
Cc: Huacai Chen <chenhuacai@kernel.org>

---
James Hilliard (32):
      linux-user/mips: implement sysmips(MIPS_FLUSH_CACHE)
      linux-user/mips: implement sysmips(MIPS_ATOMIC_SET)
      linux-user/mips, target/mips: honor MIPS_FIXADE for unaligned accesses
      target/mips: fix Octeon arithmetic destination handling
      target/mips: split Octeon SEQ/SNE decode
      target/mips: drop Octeon zero-register fast paths
      target/mips: add Octeon multiplier state
      target/mips: add Octeon LBX instruction
      target/mips: add Octeon LHUX instruction
      target/mips: add Octeon LWUX instruction
      target/mips: add Octeon SAA instruction
      target/mips: add Octeon SAAD instruction
      target/mips: add Octeon ZCB instruction
      target/mips: add Octeon ZCBT instruction
      target/mips: add Octeon MTM0 instruction
      target/mips: add Octeon MTP0 instruction
      target/mips: add Octeon MTP1 instruction
      target/mips: add Octeon MTP2 instruction
      target/mips: add Octeon MTM1 instruction
      target/mips: add Octeon MTM2 instruction
      target/mips: add Octeon VMULU instruction
      target/mips: add Octeon VMM0 instruction
      target/mips: add Octeon V3MULU instruction
      tests/tcg/mips: add Octeon instruction smoke test
      target/mips: add Octeon LA* atomic instructions
      target/mips: add Octeon COP2 crypto core support
      target/mips: add Octeon SMS4 crypto support
      target/mips: add Octeon SHA3 crypto support
      target/mips: add Octeon ZUC crypto support
      target/mips: add Octeon Camellia crypto support
      target/mips: add Octeon CHORD and LLM COP2 support
      target/mips: expose Octeon68XX floating-point support

 MAINTAINERS                                   |    2 +
 linux-user/mips/cpu_loop.c                    |    5 +
 linux-user/mips/target_syscall.h              |    3 +
 linux-user/mips64/target_syscall.h            |    3 +
 linux-user/syscall.c                          |   56 +
 target/mips/cpu-defs.c.inc                    |   12 +-
 target/mips/cpu.c                             |   75 +-
 target/mips/cpu.h                             |  257 +++
 target/mips/helper.h                          |    6 +
 target/mips/internal.h                        |    3 +
 target/mips/mips-defs.h                       |    1 +
 target/mips/system/machine.c                  |  142 ++
 target/mips/tcg/meson.build                   |    1 +
 target/mips/tcg/octeon.decode                 |   46 +-
 target/mips/tcg/octeon_crypto.c               | 2479 +++++++++++++++++++++++++
 target/mips/tcg/octeon_translate.c            |  545 +++++-
 target/mips/tcg/op_helper.c                   |  100 +
 target/mips/tcg/translate.c                   |   23 +-
 target/mips/tcg/translate.h                   |    1 +
 tests/tcg/mips/Makefile.target                |   11 +
 tests/tcg/mips/user/isa/octeon/octeon-insns.c |  216 +++
 tests/tcg/mips64/Makefile.target              |   20 +
 tests/tcg/mips64el/Makefile.target            |    8 +
 23 files changed, 3957 insertions(+), 58 deletions(-)
---
base-commit: ee7eb612be8f8886d48c1d0c1f1c65e495138f83
change-id: 20260420-mips-octeon-missing-insns-v2-5e693770cf2c

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>


