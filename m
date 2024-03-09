Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0940EC54E5C
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 03:11:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rin6j-0000vA-Uo; Fri, 08 Mar 2024 22:10:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1rin6W-0000tM-ME
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 22:10:35 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1rin6P-00045l-QG
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 22:10:31 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1dd10ae77d8so22904155ad.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 19:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709953823; x=1710558623; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SakRcwnp8Yh1EyT2Wa8Byn2WbR8UlACvso8EHydivPE=;
 b=DEeRhSxUHyFQfWXl9Ojid6TbdRVAtTHFVmbuz60aU8wN0ytfV/uFP+7SUV66u6RIt8
 VtDR4+ALSn2haQVVffpSBoAeK1jlMPOP/sKb2EnFiXrYnBLbC0Mc77FNrNkFgyDffqy9
 y7wpbY+MA2WlBFQ0y0JDtiiE+xsDS3NDFPRTxp+0qtF7WNIBfhkLyDzg3ntu5y0CzAcn
 Rf1Ax65UT2h6vBQ89xK0fkIYhxDbEGLC9g7tPubBFAZ19H4pDb82PGWB6I0PgdbZ4hsu
 io8vlkYXQEU1eLVw3MRbH8Zuhjnq0IDDZ4C8eJOw6LLEJexUFN5pIpvM197Z+nNrLkif
 FPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709953823; x=1710558623;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SakRcwnp8Yh1EyT2Wa8Byn2WbR8UlACvso8EHydivPE=;
 b=NvkUZAUMqp9xpScGdHsdyqgl7CrQ6Fs5telavc/PvYAOw3csVO7QM++2wjPNnzCIQq
 v+zIGvjHFnEQN35SdT7QYQVsNV+v9nTQjoX7cZRs9ioGJumg7ozUoZs9H6kqWT6w8hzX
 X0ZZyF/0UQYbrRab8gAMP6xOaAU4AAWRt2DeqEyV+INL7oCqHBRrtIVAEz37a5vod8T7
 u4vXXW9JAqr2Z9kE7Q+w11qjaartfusCtqlBGIELUdR5AcIvN+NnqjN3oRh9G6FgfGj7
 SxiBeXf3IdQ58n1RbXU8LGgIrtHkj+NshCLH+r774+Ap5tmVrBCXCQDvZfF2KK5Eiuao
 dQ8Q==
X-Gm-Message-State: AOJu0Yx1VcEMtbm9Q6ZQOk+UVGdmEB6pQ2NRYVGsUJISE+S91SSDYjkZ
 L2I4BgzLWG4977EOpW04/9xVhq5lvOeMkQMKbxuEw7FmGlvu/y8EjajNeQZ8o3Mgi1yNR6gKjK1
 XCIs=
X-Google-Smtp-Source: AGHT+IGTVFpbZKQm3z8F5WEDmpelCCRVqy0pP5R5VYb2aBYWp/aqQCNCJnzk01wz6z7ZRQENjD3iGw==
X-Received: by 2002:a17:902:e884:b0:1dd:7e2b:ab39 with SMTP id
 w4-20020a170902e88400b001dd7e2bab39mr28859plg.33.1709953822893; 
 Fri, 08 Mar 2024 19:10:22 -0800 (PST)
Received: from amd.. ([2804:7f0:b401:7e8e:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 w13-20020a170902d3cd00b001dd707d5fe6sm349566plb.158.2024.03.08.19.10.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 19:10:22 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu,
 philmd@linaro.org, gustavo.romero@linaro.org
Subject: [PATCH v3 0/5] Add stub to handle Xfer:siginfo:read query
Date: Sat,  9 Mar 2024 03:08:56 +0000
Message-Id: <20240309030901.1726211-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x632.google.com
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

Xfer:siginfo:read query is received, usually, when GDB catches a signal
and needs additional info about it, like the si_code and the si_addr, so
GDB can show the user interesting info about the signal. This query can
also be received when an user explicitly asks for more information via
printing GBD's special purpose variable '$_siginfo'.

This series adds the stub to handle Xfer:siginfo:read queries.

To achieve this, it is first necessary to stash the target-specific
siginfo in the gdbstub server state struct when handling a signal, so it
requires modifying the gdb_handlesig function to accept the target's
siginfo struct and its length.

Later, when replying to a Xfer:siginfo:read query (i.e., after a
signal is caught), the query handler utilizes the stashed siginfo to
form the packet for replying to the query.

Finally, a test is added to check if the stub correctly responds to the
query when a simple binary causes a SIGSEGV. Since the si_addr must be
available in the case of a SIGSEGV, the value of si_addr is checked
against the expected faulting address, corresponding to the dereferenced
pointer value in the binary.

v1:
https://lists.gnu.org/archive/html/qemu-devel/2024-03/msg00423.html

v2:
https://lists.gnu.org/archive/html/qemu-devel/2024-03/msg01858.html


Cheers,
Gustavo

Gustavo Romero (5):
  gdbstub: Rename back gdb_handlesig
  linux-user: Move tswap_siginfo out of target code
  gdbstub: Save target's siginfo
  gdbstub: Add Xfer:siginfo:read stub
  tests/tcg: Add multiarch test for Xfer:siginfo:read stub

 bsd-user/main.c                               |  2 +-
 bsd-user/signal.c                             |  5 +-
 gdbstub/gdbstub.c                             |  8 ++++
 gdbstub/internals.h                           |  1 +
 gdbstub/user.c                                | 46 +++++++++++++++++--
 include/gdbstub/user.h                        | 19 +++-----
 linux-user/aarch64/signal.c                   |  2 +-
 linux-user/alpha/signal.c                     |  2 +-
 linux-user/arm/signal.c                       |  2 +-
 linux-user/hexagon/signal.c                   |  2 +-
 linux-user/hppa/signal.c                      |  2 +-
 linux-user/i386/signal.c                      |  6 +--
 linux-user/loongarch64/signal.c               |  2 +-
 linux-user/m68k/signal.c                      |  4 +-
 linux-user/main.c                             |  2 +-
 linux-user/microblaze/signal.c                |  2 +-
 linux-user/mips/signal.c                      |  4 +-
 linux-user/nios2/signal.c                     |  2 +-
 linux-user/openrisc/signal.c                  |  2 +-
 linux-user/ppc/signal.c                       |  4 +-
 linux-user/riscv/signal.c                     |  2 +-
 linux-user/s390x/signal.c                     |  2 +-
 linux-user/sh4/signal.c                       |  2 +-
 linux-user/signal-common.h                    |  2 -
 linux-user/signal.c                           | 15 ++++--
 linux-user/sparc/signal.c                     |  2 +-
 linux-user/xtensa/signal.c                    |  2 +-
 tests/tcg/multiarch/Makefile.target           | 10 +++-
 .../gdbstub/test-qxfer-siginfo-read.py        | 26 +++++++++++
 tests/tcg/multiarch/segfault.c                | 14 ++++++
 30 files changed, 147 insertions(+), 49 deletions(-)
 create mode 100644 tests/tcg/multiarch/gdbstub/test-qxfer-siginfo-read.py
 create mode 100644 tests/tcg/multiarch/segfault.c

-- 
2.34.1


