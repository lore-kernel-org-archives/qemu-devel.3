Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C99CD3427
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 20:43:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMAwX-0004rB-Pw; Sun, 10 May 2026 16:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAwW-0004on-8J
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:04 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAwU-0003jZ-7G
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:04 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-479d5ff103aso1736661b6e.0
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778445601; x=1779050401; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s57FVZBl5QsqTG9n1o2XBVMCmXx0kXo1XvXGYBREwtY=;
 b=FS9w1O9GiLO/FFjW0X4TYLehmWRqVUxQDTAwRaJ5QUD6b2mZDRf5L6WF0ryVsj01CF
 kZBIc9ROJiZJfxLwFST3u/u9pxEIqIxt+1eG1citMkaSvKUfDc3vjFs36hbPY4hg+VFy
 MTHIPh5AHX0rHlbGmHK98y+Wy99DAF6TmQ3p7fjF//9NVykZH1dW88stbomfuTxKX1+3
 s50XCl7c6WeddNP1GVjTbUgiww09J4Owz1Y0MhOptoMa/b8ykm4mogvnqcu01AX/zUX7
 ZISPud94Yn9DVZVC2u4RfpwPZ1GIyEmDpPI/HleGjcDJ6oVY5f6r9QPY3ZjpqdfGzz6K
 XmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778445601; x=1779050401;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s57FVZBl5QsqTG9n1o2XBVMCmXx0kXo1XvXGYBREwtY=;
 b=Qv1L3Z5NaYdgsygjUV3Thr6JxG9YQDXBhERkYKZ3ZeXtw6OmW+rSF2a0ADmrMDQmhr
 bEWY4nX9BPveGCDypz86CzlARYWvtryS/FA0xLjbQPpK7jALYj5FJaqyAurZ8AaZ5HUh
 CeAZG542o11TvZNWhJqgksZGKWjel5yVG5ZSIXTu6cHmlmMdjle8ujrxDOdfInHm4PNC
 tayb9LM9r+g+Z64Myqp9qBeMZMZBYGf20idmZc3hoU92+0PHcecbXHJEhSDnco5bG23w
 jCOji4y6GaUASbWtG9qliquoV9voBJWAy7bmMqSLSDX0c45/uIK7gmE64NBwuQCZO7tW
 gKXw==
X-Gm-Message-State: AOJu0YyXIpTQn9HlLQgCcp7mLx+bNeqeUbkV5X26LYNCWqCcVNaLJE7k
 RuAg6Y9+Vn81s2IJjWH4FNtsmw4HPJlAVPTWRFl7TknyEprnu5kEBz32
X-Gm-Gg: Acq92OH0b4tSqyPdI/SiCPh3V8XseU7uxm76JvDVUuEu8eBO0f3Q1D3xW4jxM9aWB4k
 G/nWjNKHLYajaJGENXhpgcS04sTS6WGxc/S2nwF+5T2Zhd/in8FZvXwKYhO1y/YbFXFM0salkqe
 JpKxzpNfhTN833thG/3dU4NYGGc9/diVZvPKxXM20C4jwf6cU7ABAjJEOUCpGD/jxrT3iV8wJCv
 k/o0Ihbd3ChMiP79DxMkLHNtSLFYMv+wZgsEGAWijBZfhmzKXtWVEarcmZlVi9mHUmKbZfs1aSm
 BRkljTpU6XRsGRjZ59HimqQgf5HY9ZaRQ9reRjiurbjOsg1apkY0mQ9vgF08s0AEz7BP0zTF3UA
 aek+VWtVj2FDemW0Fcpbb2gFCZ0gh+X3o5TWScRVnfYQzl8CRdSndGB+twq2PlGt1PZb/4XaGiO
 Zburf2fQ5dxg5aR4oDKcrjLRNastbEjCd0D5zia5wfZMht5Rvg0sdgYZ3a3s0W2ZWmB5DXALf64
 rvyKDzpdfSaPQVg1ZUzucd+IdOSfXM0UT45NkmeRNI=
X-Received: by 2002:a05:6808:3029:b0:463:927c:1e3d with SMTP id
 5614622812f47-4807fd398a5mr6345837b6e.23.1778445600736; 
 Sun, 10 May 2026 13:40:00 -0700 (PDT)
Received: from MacBook-Pro.local ([209.245.15.183])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76935637sm18908207b6e.12.2026.05.10.13.39.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 13:40:00 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v5 00/32] target/mips: add missing Octeon user-mode support
Date: Sun, 10 May 2026 14:39:30 -0600
Message-Id: <20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XN0YrCMBAF0F+RPBtJ0yZtfNr/WHxoJ9M6YhPp1
 KJI/93UZVEQFOZhLlzOvQnGgZDFdnUTA07EFEMKZr0SsK9Dh5J8ykIrbVWhlezpxDLCiDGkn5l
 CJylwYDlpadC6vCwVtBpEIk4DtnR58L+7v8zn5oAwLubS2BOPcbg+9ie99P6nss9T6ZSsVeky3
 2ZVBe6n62s6biD2Ypma8idmVPUFyxPWQIPgbG5K/4YVr5j7ghUJ89Y6D14Z0O0rNs/zHQfj+B1
 0AQAA
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x22d.google.com
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
Changes in v5:
- Added Richard Henderson's Reviewed-by tags for LBX, LHUX, LWUX, SAA,
  and SAAD, plus Acked-by tags for ZCB and ZCBT.
- Dropped the separate Octeon+ feature bit; QEMU has a single Octeon CPU
  model today, so SAA/SAAD stay under the existing Octeon feature bucket.
- Folded ZCBT into the ZCB decodetree entry with a selector comment.
- Link to v4: https://lore.kernel.org/qemu-devel/20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com

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
 target/mips/cpu-defs.c.inc                    |   10 +-
 target/mips/cpu.c                             |   75 +-
 target/mips/cpu.h                             |  257 +++
 target/mips/helper.h                          |    6 +
 target/mips/internal.h                        |    3 +
 target/mips/system/machine.c                  |  142 ++
 target/mips/tcg/meson.build                   |    1 +
 target/mips/tcg/octeon.decode                 |   46 +-
 target/mips/tcg/octeon_crypto.c               | 2479 +++++++++++++++++++++++++
 target/mips/tcg/octeon_translate.c            |  537 +++++-
 target/mips/tcg/op_helper.c                   |  100 +
 target/mips/tcg/translate.c                   |   23 +-
 target/mips/tcg/translate.h                   |    1 +
 tests/tcg/mips/Makefile.target                |   11 +
 tests/tcg/mips/user/isa/octeon/octeon-insns.c |  216 +++
 tests/tcg/mips64/Makefile.target              |   20 +
 tests/tcg/mips64el/Makefile.target            |    8 +
 22 files changed, 3946 insertions(+), 58 deletions(-)
---
base-commit: ee7eb612be8f8886d48c1d0c1f1c65e495138f83
change-id: 20260420-mips-octeon-missing-insns-v2-5e693770cf2c

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>


