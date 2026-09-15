Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF9FC88E77
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 20:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Zrs-0001HQ-Ba; Tue, 15 Sep 2026 16:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x6Zrq-0001H8-Cv
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:35:02 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x6Zro-0005ZU-FO
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:35:02 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f635552aso100011f8f.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 13:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789504499; x=1790109299; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vzo6ObB9H7yVC9RecKBrGqXoabYS6sJDbZ5xznrbBJ0=;
 b=HlP5Wigr72NqPpxtuREOZBMIx8KVdQv69XNMm6om6PZlw+xH9/UaGNST5S9oj8oizi
 67RjbBhFMbzIfdVhLvpSWASBrN6MOR6M+wxzJQASBhcNs98wPocObG1oocZHbBAaObge
 HDxjhBZAP2zhwAY6PFhNghBqKB89/zvAOfRuFBHjbqzdsGgqREPzxsMjzY8Wht8uLX5r
 yUgVk0WrnQGdMRw+4e8gIzgpE53eLYbIAzBLb212kaLgadwk/M6pbs9stn/Omw4hM3O/
 5XEeTDlIEdCX6btGk8fE++6SFs4zeckdv8UTxNOpnvX+hJmrrzxbrPpCwsK2I19/zxQu
 rRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789504499; x=1790109299;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vzo6ObB9H7yVC9RecKBrGqXoabYS6sJDbZ5xznrbBJ0=;
 b=hWBKvRRdXhzXhjD7M2oSSbb2X+sUqFILObh0JjtNmeU6wk+dK/19oCaRz1pTiueuL2
 5O6ZIPhAwECsBZQWyNYvv8I+CqdDmcnGktfP5twKpzcMTABirgFr6HCJPokrkpEXnlyh
 80dRzKNtzP8YO6XxJ6FWbaa6eC/PPXUCQb/tJgBEylJfsxR7UzS1ynFuD9XeGTbDAvQ9
 HyIjdv7tslc9lqhTuAjnlRkqWfcpg58ALryRJ0lH6lxULASWh9wYr+7/AVCFxRpQafBe
 mUPtBbIUwXMpEFs8PhmDs7/7VA+HNVgwQAxN82fdXsCuLvX3XhMYpX0qjYbWpfu4UVYB
 Idfg==
X-Gm-Message-State: AFuF++lMuRG4Mw7bdXk7pi7s4Aht/0Vkty+1eIdmohSE9WGkFA8EgmF8
 8WgPNcC8x8xaqgl67hwdjltwScFWX5S0c8LNIsLWL7RmOpN9vL0tTm0fK4gFrrb62BLcO1J+KiT
 Qm7OD
X-Gm-Gg: AYBFou0aQnjyTBqaGPAOGtgoO+qQLDVYJiblzg8l3ygGSgM6+pJeNwbOmtLUFT5lcU0
 DK6UGVwB7hc+EkDbTeNFZpNPZIbtbWGdpQDEj3K1WfDNThfv3LiZv6ttEEKRwvvv998SFadLg1E
 9puBn/HTHhRkn1B/ZOpg97vviWWweIBd0/ofdRiI4MaZwZfE+TzYttc+WYhne6YCRUSKN68CmOz
 9Y0b1lw+alte1qNN2H/WLJAPvvcc/DbVJmIgStDamxCbv+jC8oDzhqwO0/MtmSW+Nx/WVDZkRWI
 cjx649RA3oN3qOzAeCCPFr5T/3rgjsx+y2ziELbe1O7q4Pr+TNHxp5DczM00Y8B2P3j5Gp2J5LB
 sZKay8C7P7j8EmINVIi2mnsVbsoLgh8xHcvw5AsOhVI+FHlBCELrJCLoU7IjPXTK9naRk5KwhF4
 +zspaidhwUPk/s2vSpO2rvGxq5sePTbVGMbDsNS1AgXVYmVZHtjbs8fcbmZ+1DGVQSz5an
X-Received: by 2002:a05:6000:1883:b0:487:94b:2262 with SMTP id
 ffacd0b85a97d-4870d05adabmr128414f8f.52.1789504498649; 
 Tue, 15 Sep 2026 13:34:58 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:f0fe:c7ed:403d:e487])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf37e69sm1504073f8f.29.2026.09.15.13.34.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 13:34:57 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 0/10] system: add a watchdog for the Big QEMU Lock
Date: Tue, 15 Sep 2026 22:34:44 +0200
Message-ID: <20260915203455.580999-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=den@openvz.org; helo=mail-wr2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

A vCPU thread reacquires the BQL on every exit that needs userspace. A
holder that keeps it for tens of seconds stops every vCPU, the guest
reports a soft lockup or panics, and qemu itself records nothing. The
guest log is the only evidence, and it cannot say whether the hypervisor
held the lock or the guest wedged on its own.

This series adds a BQL watchdog. A sampler thread watches a sequence
counter that bql_update_status() advances on every acquire and release.
One odd value across the whole window means one owner held the lock for
the whole window. On expiry the watchdog names the holder and prints the
state of every other thread:

  qemu-system-x86_64: 2026-09-15T15:53:57Z BQL held for more than 100 ms by thread 168146
    168146  qemu-system-x86  S
        pc 0x785a4dbcb884 liburing.so.2+0x2884
        wchan io_cqring_wait
    168147  call_rcu         S
        pc 0x785a4d534acb syscall+0x1b
        wchan futex_do_wait
    168148  IO mon_iothread  S
        pc 0x785a4d4ac802 libc.so.6+0xac802
        wchan poll_schedule_timeout.constprop.0

With CAP_SYS_ADMIN the wchan line becomes the kernel stack. The pc line
comes from signalling each thread and reading the program counter out of
its signal frame, which is what tells a thread spinning in userspace
from one asleep in a syscall.

The watchdog is off by default and stays quiet under a debugger. Two
machine properties drive it: bql-watchdog-ms sets the deadline, on the
command line or over qom-set at any time, and bql-watchdog-abort turns
the report into a core dump for hosts where the answer is worth more
than the guest.

Patches 1 to 6 are the pieces: a fix for bql_locked across the timed
condvar wait, a debugger check, the per-thread state reader and its
kernel stack and program counter extensions, and the signal reserved for
the latter. Patches 7 to 9 are the watchdog itself. Patch 10 is a
functional test that holds the BQL through an HMP qemu-io write to a
null-co node with a latency longer than the deadline.

The program counter lives at a host specific offset in the signal frame,
so patch 6 reads it through a host/include header. The Linux headers for
aarch64, ppc64, riscv64, s390x and loongarch64 repeat what linux-user's
host-signal.h already knows about those frames, but only the x86_64 one
has been compiled here, and the Windows half of patch 1 has not been
compiled either.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Cc: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>

Denis V. Lunev (10):
  util/qemu-thread: track bql_locked across the timed condvar wait
  oslib: add qemu_debugger_attached()
  oslib: add qemu_thread_states()
  oslib: report kernel stacks in qemu_thread_states()
  util/qemu-thread: reserve a signal for thread introspection
  oslib: report each thread's program counter
  system/cpus: report a BQL held past a deadline
  system/cpus: hold off the BQL watchdog under a debugger
  system/cpus: add bql-watchdog-abort
  tests/functional: cover the BQL watchdog

 host/include/aarch64/host/signal-pc.h         |  20 ++
 host/include/generic/host/signal-pc.h         |  11 +
 host/include/loongarch64/host/signal-pc.h     |  20 ++
 host/include/ppc64/host/signal-pc.h           |  22 ++
 host/include/riscv64/host/signal-pc.h         |  20 ++
 host/include/s390x/host/signal-pc.h           |  20 ++
 host/include/x86_64/host/signal-pc.h          |  20 ++
 hw/core/machine.c                             |  44 +++
 include/qemu/osdep.h                          |  29 ++
 include/system/cpus.h                         |   8 +
 meson.build                                   |   2 +
 qemu-options.hx                               |  11 +
 system/cpus.c                                 | 143 ++++++++
 tests/functional/generic/meson.build          |   1 +
 tests/functional/generic/test_bql_watchdog.py |  60 ++++
 util/oslib-posix.c                            | 316 ++++++++++++++++++
 util/oslib-win32.c                            |  10 +
 util/qemu-thread-posix.c                      |   8 +-
 util/qemu-thread-win32.c                      |   4 +-
 19 files changed, 765 insertions(+), 4 deletions(-)
 create mode 100644 host/include/aarch64/host/signal-pc.h
 create mode 100644 host/include/generic/host/signal-pc.h
 create mode 100644 host/include/loongarch64/host/signal-pc.h
 create mode 100644 host/include/ppc64/host/signal-pc.h
 create mode 100644 host/include/riscv64/host/signal-pc.h
 create mode 100644 host/include/s390x/host/signal-pc.h
 create mode 100644 host/include/x86_64/host/signal-pc.h
 create mode 100755 tests/functional/generic/test_bql_watchdog.py

-- 
2.53.0


