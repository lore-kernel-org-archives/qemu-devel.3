Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93865CD1288
	for <qemu-devel@archiver.kernel.org>; Sun, 31 Mar 2024 07:34:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqphl-0002cy-9x; Sun, 31 Mar 2024 03:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rqphj-0002WY-Dx; Sun, 31 Mar 2024 03:34:11 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rqphg-00025o-NL; Sun, 31 Mar 2024 03:34:11 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5d8ddbac4fbso2348194a12.0; 
 Sun, 31 Mar 2024 00:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711870446; x=1712475246; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=D6wSsPZEcVSSUGBkwC/VmUENDZWLIRZujo9SWc2/D2w=;
 b=XT3o45pHoowKsDoy6EF6n4Rms+ih5scAV+LutBXKHldt9tgVfrUksTmMgF/egVPes6
 QV9su6iz0zxN8g7dXQV11/wJ60LoA4uLz4Jp3/fFIDE03hvGZ31O6jVLP3Guu/tx7iFp
 oz55EDt/vU9SvBiaa/cB6iPu0MeuzwHBzoP5nJaj5oU4EQhuumjar3bH6oL+vNEg/ORC
 OSACY1nhY4/6rUQYnZY4HD2kVEJjY+nllnmYkRNpAthU5zgpzlkZh/ZptDk2fqVq9Wp7
 v9ECsktUgyQVqqERsFnU5KLYQwoMuBDTAoL9MTDhgz9VvmHuPP1SxyXDshgM7K7HpPbK
 GM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711870446; x=1712475246;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D6wSsPZEcVSSUGBkwC/VmUENDZWLIRZujo9SWc2/D2w=;
 b=A03vIvpl3JgQ66e7AZyO9PWZeVtHG2HtvgiZl9+n2lQrXZI2ge85SlAg2xj81Ck71v
 7KU5TFpwuqcgsgB15R8lGgVWTZds1QaTJuU5ju7bGQPjQahMe9+PGdquJm3qmLf8iT1V
 1YT8pg40kuvznFlHt/9E8UGu0N3bJVf5I/g4E/2+HF/b3X7VbRAO1xTi/ScXAVM5CPnD
 aAti4vH8sOkQwLrlE/O4flgWemoXzOAfGca3pDae21ocBsYS5uib23rA6NCxkd8TQM2k
 AGQTfMLljCeCou7Kz3uIHvcXaogJX9BBERoD2rkcHmeuEFYEqRTz/ULy8IdW7wQMytuW
 Hs1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF34f+1ZTQS9ZC2lik4Cv0Y4lZT8/wwNTrvNzE02SYSmWrG3egtIeKjLZVWFXlQoF4y5yybZtjf9rMLQajR95aMmD7
X-Gm-Message-State: AOJu0Yw8+geS8ASGi/y+UfPLXF2mFJBDpy83n0lDfRqec5Ck3bWuhC2O
 0uKDBPCTe2RrXWOVB/22/x8r3+9lLXraZYtMlH3jmsXdJ6og9lMU1yk6HUadDcY=
X-Google-Smtp-Source: AGHT+IG/aqwqcWwUkTXeHO1NTALU1O6kIsQEvrbt72G4fYCKmbAXq6TOKOkUyFttoJydPpY9cKcb4g==
X-Received: by 2002:a05:6a20:430b:b0:1a3:c404:37fc with SMTP id
 h11-20020a056a20430b00b001a3c40437fcmr8426469pzk.13.1711870445985; 
 Sun, 31 Mar 2024 00:34:05 -0700 (PDT)
Received: from wheely.local0.net ([118.210.97.62])
 by smtp.gmail.com with ESMTPSA id
 k9-20020aa78209000000b006eabe72ce84sm5822411pfi.16.2024.03.31.00.34.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Mar 2024 00:34:05 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-ppc@nongnu.org
Subject: [PULL 0/8] ppc-for-9.0-3 queue
Date: Sun, 31 Mar 2024 17:33:37 +1000
Message-ID: <20240331073349.88324-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52d.google.com
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

The following changes since commit 5012e522aca161be5c141596c66e5cc6082538a9:

  Update version for v9.0.0-rc1 release (2024-03-26 19:46:55 +0000)

are available in the Git repository at:

  https://gitlab.com/npiggin/qemu.git tags/pull-ppc-for-9.0-3-20240331

for you to fetch changes up to b07a5bb736ca08d55cc3ada8ca309943b55d4b70:

  tests/avocado: ppc_hv_tests.py set alpine time before setup-alpine (2024-03-30 18:50:26 +1000)

----------------------------------------------------------------
* Various fixes for recent regressions and new code.

----------------------------------------------------------------
Benjamin Gray (2):
      target/ppc: Restore [H]DEXCR to 64-bits
      target/ppc: Fix GDB register indexing on secondary CPUs

Harsh Prateek Bora (1):
      spapr: nested: use bitwise NOT operator for flags check

Nicholas Piggin (3):
      target/ppc: Do not clear MSR[ME] on MCE interrupts to supervisor
      tests/avocado: Fix ppc_hv_tests.py xorriso dependency guard
      tests/avocado: ppc_hv_tests.py set alpine time before setup-alpine

Philippe Mathieu-Daudé (2):
      hw/ppc/spapr: Include missing 'sysemu/tcg.h' header
      target/ppc/mmu-radix64: Use correct string format in walk_tree()

 hw/ppc/spapr.c                |  1 +
 hw/ppc/spapr_nested.c         |  2 +-
 target/ppc/cpu_init.c         |  4 ++--
 target/ppc/excp_helper.c      |  5 +++--
 target/ppc/gdbstub.c          | 31 ++++++++++++++++++++-----------
 target/ppc/mmu-radix64.c      |  8 ++++----
 tests/avocado/ppc_hv_tests.py |  6 +++++-
 7 files changed, 36 insertions(+), 21 deletions(-)

