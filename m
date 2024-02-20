Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25EF7C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 04:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcHbU-0001cz-PJ; Mon, 19 Feb 2024 23:19:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rcHbT-0001cm-SV; Mon, 19 Feb 2024 23:19:35 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rcHbS-0006AR-CB; Mon, 19 Feb 2024 23:19:35 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5dca1efad59so4637902a12.2; 
 Mon, 19 Feb 2024 20:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708402772; x=1709007572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=03y1ElgO+K/tR/pNBJoDvBFVtboXPQsLAKW5AYR2Fl0=;
 b=iPv468wNDx6FjB4kIDa1lu6s+IXQhMrv61T+N+Rs7p6q8mbb6eri8iH9cF1DaZX3sf
 wU7xe6SxXKxHxYF9OyNo7IEcQqfEYJV+RwYq29TcWbF508IbmPfDH9AEF6uVGvn2bt0B
 lo1N8CDycX/Hf6TyODv2ZDVLAFh4bqSqUGEoDo75ypKk3lStdA5ARyaL1HbkHJ93jQTc
 6b4rFJpsCL2Zz22uwBJttRGYlR0n925qjmAYv/4bZu3s/xaSKh0YrEuC/ICptdUI6MY8
 8UWwOgGCzH8qAjJy2MfEWi8UnHwRkcBqmUjxmG/hHxNvUK369Hcu1hSp2QKFAV49f3Pl
 T7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708402772; x=1709007572;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=03y1ElgO+K/tR/pNBJoDvBFVtboXPQsLAKW5AYR2Fl0=;
 b=nnmUYU1Zqcii15gk2DlFR0ZRFXeslCMQiBKFIu9+o+wu8TiO9Ug1NWBJNLxNrNIaUc
 AJRvHpDP1GulkTq31iXkZwAXRYgpxulnlznvljO5hdcWx199Q5sgB7SREzBBgYhN5i/w
 z7e69DlUeIzUsufkbkZanlqhhpgd4smR3Y+1ThDPL8dQVxMhPq1UPt7pIKb0dgSMMHu4
 jJvY0/TV4nE+fXonvadolw/MkgGgmU4+2zeMqtIe6SCCMRCAq9pBWB0ml29AtWsdxhsC
 yVhnISqiJMu8iTCuReG1OuLUKY4/I797dJNfTPqZY1afSBXtXHZU97QGMlEzlzO9u9xH
 yLSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUZ1823ZOf7AhavrJP6/JW9u0Zsf4DYE5OIjD7ZZm4PIysX52n40z479V52+5pCo/QQejsO1a1yigPLBD5jAjWZb/JfEc=
X-Gm-Message-State: AOJu0YySvLlHsjcyREy9pqiwkzrctFKys/XcYfKqGI1XYpvtrFlkNuH8
 Ad7E7wIL2ufKgRWA70DdHHWM0U1n3b7IP9Hwv0BUR0sCD8OS7qcvNRDCyOST
X-Google-Smtp-Source: AGHT+IFTX9EHQOWIEiG/02XLz+h+rwitaKxxbIluzNekjojs7SWBwa9OaCi3LXB/dJjPRsjOnpI5ZQ==
X-Received: by 2002:a05:6a20:d493:b0:19e:b9ba:1a6a with SMTP id
 im19-20020a056a20d49300b0019eb9ba1a6amr15862702pzb.49.1708402771732; 
 Mon, 19 Feb 2024 20:19:31 -0800 (PST)
Received: from wheely.local0.net (123-243-155-241.static.tpgi.com.au.
 [123.243.155.241]) by smtp.gmail.com with ESMTPSA id
 pl6-20020a17090b268600b00297138f0496sm6232621pjb.31.2024.02.19.20.19.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 20:19:31 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH 0/3] real ll/sc emulation
Date: Tue, 20 Feb 2024 14:19:19 +1000
Message-ID: <20240220041922.373029-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

I've been toying with how we might do a more faithful ll/sc emulation.
Our cmpxchg based one actually had problems on some firmware code we're
testing.

The using the dirty memory bitmap to detect stores coming from other
CPUs and invalidating active protection / reservations seems to be a
possibility. This passes some basic atomic and locking stress tests
with mttcg, and boots Linux.

Excuse some of the hacky / ugly / unfinished bits of code, I missed
getting into details of vfio, migration, and making it clean. Just
wanted to hear thoughts on the general idea at the moment.

The code doesn't seem to be _terribly_ tricky, but there are some
tricks around the store-conditional side of it where we have to
take a mutex, do the tlb lookup with possible recursion into the
code protected by that mutex, verify the protection is still active,
and then modify memory.

There is only a single lock now, but if that beomes a problem we
*might* be able to split it via physical address hash. But that
doesn't help uncontended performance or contention on the same
address, which are probably the two most important cases.

(I will submit the TCG TLB coherency fix patch separately, difficulty
at the moment is creating a test case for it that does not require
subsequent patches!)

Thanks,
Nick

Nicholas Piggin (3):
  accel/tcg: Fix TCG TLB coherency race with physical dirty bit clearing
  tcg: add a ll/sc protection facility
  target/ppc: Implement reservation protection for larx/stcx

 include/exec/cputlb.h    |   7 ++
 include/exec/exec-all.h  |   1 -
 include/exec/ram_addr.h  |  42 ++++++-
 include/exec/ramlist.h   |  10 ++
 include/hw/core/cpu.h    |   5 +
 target/ppc/cpu-param.h   |   4 +
 target/ppc/helper.h      |   2 +
 accel/stubs/tcg-stub.c   |   4 -
 accel/tcg/cputlb.c       | 235 ++++++++++++++++++++++++++++++++++++---
 hw/core/cpu-common.c     |   5 +
 hw/vfio/common.c         |   2 +-
 hw/virtio/vhost.c        |   1 +
 system/memory.c          |   3 +
 system/physmem.c         |   7 ++
 target/ppc/cpu_init.c    |   4 +
 target/ppc/mem_helper.c  | 132 ++++++++++++++++++++++
 target/ppc/translate.c   | 128 +++++----------------
 system/memory_ldst.c.inc |   3 +-
 18 files changed, 467 insertions(+), 128 deletions(-)

-- 
2.42.0


