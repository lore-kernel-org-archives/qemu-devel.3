Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66701C25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:37:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJfg-0007yd-Dl; Sun, 26 May 2024 15:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJfe-0007yB-Ie
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:36:42 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJfc-0006TO-Tc
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:36:42 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2bf59381a11so2096778a91.1
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752199; x=1717356999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZA42/hNYVPC57TtkdZ/JbMJ+HoEJ+TWNqQHDSStfx9s=;
 b=uTHAI+JgIpkkiCZIRFiVvnrrcXcBdqUhI5std+TTY6jRdHQxtuInZgbT5BVUztMp8h
 gt9QLRdftEM6P/P2b/3oT02qaxk5qk5q3U0XmkLXpf87nxlTM4zjGFkMCu2/HZfDd4nz
 5LkoHpcUGiExOhGupc0ZzgjjxVKc0DrXjbQ6JIUs6bKlpZtelYLO8uB6x/wwwETQlg4l
 1XAjejqbUeetZHdElTDx9A7T7cYjwPS7g8Iaot/GytAaTzCtZYNjMMuIyHCcWeLH6Jx5
 nL6mbsQsUabm5HfQLDnE1rieJ7RvGkso7liv5YRYxHu4gDf2x1f+1Kk2KID2AysRDWbd
 VH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752199; x=1717356999;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZA42/hNYVPC57TtkdZ/JbMJ+HoEJ+TWNqQHDSStfx9s=;
 b=Cy1aNeYsugMkXVMLFVTVxGlLE3ojzqE+VRrkPNdoAdalkl9NWzCLG9MfjMWhO1ae0W
 Rv+amXVL3unZQVDmU9aDKdERQBmZqlXxtrZ/S42uftC2G1VBPZeD6A49r0bF3jb1Zkvc
 AaQWw0kLa33/9nk9CEQ8UzZ6S7/zfnX3NUqjETdfD9xr673WRq/KaKX1uw8WlPSWC6Ky
 fueqauhhsonRm1ApeUTHnPK5bqPg6ktriZBxPjqGia+92eJwo5VIFJ76L8mpkF+tVSkH
 4nZuylTpdE/EyVBKfF0I5SBTlTi9CCYkNhXWGIEKpqaUedFdFlf4ihAXFo3UUdxx6G9z
 bQaQ==
X-Gm-Message-State: AOJu0YwVllgRQ59ISMNj2FuVDYfx9b9TNLkCJUTexjVPa9pd071tgEeV
 7hsMFdrxxbtlKkqGDcHXGErp+PPfXDlInCVBI2Ts933HvFkWz9g/82zrULpyhu5x2xKJA7rZ+/k
 l
X-Google-Smtp-Source: AGHT+IFVy8gYGXH2YyVNgn2gR+xPRZIoCbtrRLUQ3OtUa2zzyMMogpY/t65SeQteQnTNhivVr4Tg4w==
X-Received: by 2002:a17:90a:8a0f:b0:2bd:fa57:b360 with SMTP id
 98e67ed59e1d1-2bf5f75125bmr5891986a91.49.1716752199119; 
 Sun, 26 May 2024 12:36:39 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bf5f6155b6sm4943761a91.29.2024.05.26.12.36.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:36:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH RISU v2 00/13] ELF and Sparc64 support
Date: Sun, 26 May 2024 12:36:24 -0700
Message-Id: <20240526193637.459064-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

Let risu accept elf test files, adjusted from v1.
Adjust risugen to invoke the assembler and linker,
with a cross-compiler prefix if needed.
Add some sparc64 testing which utilizes this.

Changes for v2:
  - Implement VIS2 through VIS4.

There's something odd going on with the Sparc M8 Solaris host where
the values recorded via RISU for some floating-point operations are
incorrectly rounded, but performing the same operations with the
same inputs in a standalone test program produces correct results.

I wonder if there's some unfinished_FPop exception being generated
and the operating system emulation is producing incorrect results.
I'd be much happier if I could test this on Linux...


r~


Richard Henderson (13):
  risu: Allow use of ELF test files
  Build elf test cases instead of raw binaries
  Introduce host_context_t
  risu: Add initial sparc64 support
  risugen: Be explicit about print destinations
  risugen: Add sparc64 support
  contrib/generate_all: Do not rely on ag
  sparc64: Add a few logical insns
  sparc64: Add VIS1 instructions
  sparc64: Add VIS2 and FMAF insns
  sparc64: Add VIS3 instructions
  sparc64: Add IMA instructions
  sparc64: Add VIS4 instructions

 Makefile                   |  22 ++-
 risu.h                     |  16 +-
 risu_reginfo_aarch64.h     |   2 +
 risu_reginfo_arm.h         |   2 +
 risu_reginfo_i386.h        |   2 +
 risu_reginfo_loongarch64.h |   3 +
 risu_reginfo_m68k.h        |   2 +
 risu_reginfo_ppc64.h       |   2 +
 risu_reginfo_s390x.h       |   2 +
 risu_reginfo_sparc64.h     |  36 ++++
 risu.c                     |  59 +++++-
 risu_aarch64.c             |   6 +-
 risu_arm.c                 |   7 +-
 risu_i386.c                |   7 +-
 risu_loongarch64.c         |   6 +-
 risu_m68k.c                |   6 +-
 risu_ppc64.c               |   6 +-
 risu_reginfo_loongarch64.c |   3 +-
 risu_reginfo_sparc64.c     | 186 ++++++++++++++++++
 risu_s390x.c               |   5 +-
 risu_sparc64.c             |  52 +++++
 configure                  |   2 +
 contrib/generate_all.sh    |   4 +-
 risugen                    |  10 +-
 risugen_common.pm          |  68 ++++++-
 risugen_sparc64.pm         | 385 +++++++++++++++++++++++++++++++++++++
 sparc64.risu               | 298 ++++++++++++++++++++++++++++
 test.ld                    |  12 ++
 test_aarch64.s             |   4 +-
 test_arm.s                 |  16 +-
 test_i386.S                |   4 +-
 test_sparc64.s             | 137 +++++++++++++
 32 files changed, 1298 insertions(+), 74 deletions(-)
 create mode 100644 risu_reginfo_sparc64.h
 create mode 100644 risu_reginfo_sparc64.c
 create mode 100644 risu_sparc64.c
 create mode 100644 risugen_sparc64.pm
 create mode 100644 sparc64.risu
 create mode 100644 test.ld
 create mode 100644 test_sparc64.s

-- 
2.34.1


