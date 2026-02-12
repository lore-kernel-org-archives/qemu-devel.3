Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABEC5EDF026
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 03:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqNTZ-0007hh-3F; Wed, 11 Feb 2026 22:34:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vqNTW-0007hC-R9
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 22:34:42 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vqNTV-0008H0-C2
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 22:34:42 -0500
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7d195166b2cso5960797a34.3
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 19:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770867279; x=1771472079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=d6VdigdG4QEWW+bSAsQqbS6mt2zE8Qr0C1PWJH/dBJQ=;
 b=MpFUsBUZvoI9MKGZU23pmRA72pSjmTpnCsZ0YguLtinBNfoxtMoJw2r70wZWhQSTZ1
 YkF2sU2j7DkfvACg+NjgWFeK7HJfCbqLWZhpm1hNEZgKgpmI5+eZI79MOR4Dvwx/H7SF
 K4iMjmnREH+UtmLuAH4gap3843olvVwfKfXBRrUFCOonqNvOaiIaX9LtVq5OMXpzxC0n
 2tSWM/4vfesCtxNliVjYk0D4X+uxMJRt/IJenH6R3KMJlBP9eNZYUb958mR4fE7kHisE
 w4Z04wWogHVHSCBXdxDNDnvgdaiyjN3QZXz0iymzWm0PTRQIRYdC6Y3iRd4YPFBE+R+W
 GsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770867279; x=1771472079;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d6VdigdG4QEWW+bSAsQqbS6mt2zE8Qr0C1PWJH/dBJQ=;
 b=oIkGNa3mjICI6uPVj0aMYRiEsYFiPe0bK2UfkkTV/K+dCOqoTZ0y6/prHz/ARvZSUD
 mnwu4drU7Mu7E5YMQexUaP/2K0lJ4dJ03T8o5T1KtG8j3HHiQ6BPUzDQieTuUBgQxt/V
 WhaJFuDlChQtA1V94NVEvQit4Q6G44t31MDRgNCXL46LZtspQYTxPyqzaf8rPljWF/s+
 8oih/rFntRzpUXtanZCloekPNUyh2jVqRIkj0XQOWuTN0OlzVRguhbLsbkR99yuQBhRk
 1EGPlYpjVqwWKYcTg1YxL0tu7RF4lcftKXf0asVhIjyqBbtCr+ZUKEsX6Twj5miBENDH
 O07Q==
X-Gm-Message-State: AOJu0YzuIpViN0/2eXeHEq9mfuL/8+7fEA9XFEkJwJFP84f/8PieRN19
 LD6ohQhfdfns0fIwtJbvPso30FqN4JTZ/H1MRyiCGT6xFyiHY8ueyu4DQNCadg==
X-Gm-Gg: AZuq6aJUXy2KyNPUe0GFYh8MEg0x5J0kkn6MkwOpJHEhStTEcYtV7b3TC0vVGfJnREm
 cfy923tQ8Io+nbSwvezL+qruf4LqKveTOQeUjWpOrNuFY9tel7D//NGaE1zJNJ658K/DYE/5XWM
 pO6T1KGrEwZAYmoQAaeNPWJFBbk0NgwQSyQTb4ioxgiWIBZq20tGyCvAe0t1PBVgnA11UDHyzer
 fX3e8TiyP4MNFH7sl/LMmMuu7ZLifbP3sfonovwCVHV/UsUn/T2ciO/N/wemJi3O6P6wLl2nIaq
 7QPzTEU350s5G/O8vNxDfImKU/aTv07Gzv40tGofFubY/XduVIMLL+Fh2h2bK6CwgGKJ/5qL4kf
 YwK0SILXKrEN+iiBOb7IJYKV9kMe7Qhw5d2WeAeDUGP111T0L22HdeTKFSz6ZDpHJOpaWC9poUQ
 7Cxq+fTmVsXEMS77yYzRBXAi68kK6PGn24FtLF6jwJoYbsrCdVWmm9EZOT8TbLBMpRGMrJyuzH1
 uxf30E13atswax8
X-Received: by 2002:a05:6830:4493:b0:7d1:9da9:c6c with SMTP id
 46e09a7af769-7d4b2a9c424mr848527a34.17.1770867279581; 
 Wed, 11 Feb 2026 19:34:39 -0800 (PST)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a76e1b0csm2682858a34.14.2026.02.11.19.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 19:34:39 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH 0/8] Hexagon (target/hexagon) Check opcodes versions
Date: Wed, 11 Feb 2026 20:34:27 -0700
Message-ID: <20260212033435.3598-1-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-ot1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Currently, all versions of Hexagon CPU are treated the same, and all
opcodes are able to run on any version.  This series changes the behavior
such that only the opcodes available on the currently executing Hexagon
CPU version can execute.

Changes include:
Mark which Hexagon CPU version is currently executing
Check that each opcode is supported in the Hexagon CPU version
If not, raise SIGILL
Properly handle disassembly (-d in_asm)
Test case added

Note that this series borrows elements from Brian Cain's "Handle some
invalid encodings" series.  Therefore, it will need slight rework after
those patches are merged.

Co-authored-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Co-authored-by: Brian Cain <brian.cain@oss.qualcomm.com>

Brian Cain (2):
  Hexagon (linux-user/hexagon) Convert INVALID_PACKET into SIGILL
  tests/tcg/hexagon: Add test for revision-gated instruction decoding

Matheus Tavares Bernardino (1):
  Hexagon (target/hexagon) Introduce tag_rev_info.c.inc

Taylor Simpson (5):
  Hexagon (target/hexagon) Properly handle Hexagon CPU version
  Hexagon (linux-user/hexagon) Identify Hexagon version in ELF file
  Hexagon (target/hexagon) Add Hexagon version field to DisasContext
  Hexagon (target/hexagon) Check each opcode against current CPU version
  Hexagon (target/hexagon) Disassembly of invalid packets

 target/hexagon/cpu-qom.h             |  21 ++++
 target/hexagon/cpu.h                 |   2 +
 target/hexagon/cpu_bits.h            |   4 +-
 target/hexagon/translate.h           |   1 +
 disas/hexagon.c                      |   3 +-
 linux-user/hexagon/cpu_loop.c        |   4 +
 linux-user/hexagon/elfload.c         |  43 ++++----
 target/hexagon/cpu.c                 |  31 ++++--
 target/hexagon/decode.c              |  43 +++++++-
 target/hexagon/translate.c           |  20 +++-
 tests/tcg/hexagon/check_rev_gating.c | 141 +++++++++++++++++++++++++++
 tests/tcg/hexagon/invalid-slots.c    |  76 +++++++++++----
 target/hexagon/tag_rev_info.c.inc    |  61 ++++++++++++
 tests/tcg/hexagon/Makefile.target    |  12 +--
 14 files changed, 409 insertions(+), 53 deletions(-)
 create mode 100644 tests/tcg/hexagon/check_rev_gating.c
 create mode 100644 target/hexagon/tag_rev_info.c.inc

-- 
2.43.0


