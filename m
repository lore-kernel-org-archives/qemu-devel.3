Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C4DCCCD189
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 07:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqpLG-0001LP-4V; Wed, 18 Sep 2024 03:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1sqpLC-0001Eq-KJ
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 03:43:10 -0400
Received: from mout.kundenserver.de ([217.72.192.74])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1sqpLA-0001lR-Iu
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 03:43:10 -0400
Received: from quad ([82.64.211.94]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N7RDn-1runHg3nYL-018ETf; Wed, 18
 Sep 2024 09:42:58 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Brian Cain <bcain@quicinc.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 1/3] linux-user: update syscall_nr.h to Linux v6.10
Date: Wed, 18 Sep 2024 09:42:54 +0200
Message-ID: <20240918074256.720617-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240918074256.720617-1-laurent@vivier.eu>
References: <20240918074256.720617-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ewYyTsbsicYDINVKjFvXrNwKBExDG7z/2bTTuv8jnNx/snluXht
 LJke7zk8eHn/7/MO55nURxfNqGsuE6Sfgmdf62rgAr+VugpouBWW8UMAn/TkSGzkDBVhnH2
 A2gYhk2Hq0QmXdUwK3wBOaGAAjUCoauv3zLRx7OLCb9r1mu18n7wGWX8NCCFyDQWpCRCrEI
 xgvLS1QmxpUlSVJ47SRTw==
UI-OutboundReport: notjunk:1;M01:P0:2W1GZEupHyw=;3AKKfuRjJbf1YJMQ4XQHzaBv3Zp
 CeL+tlj+RdUwOQGXRPUrbIiBFxHjvKetExZDdAdJHzFhWYcjzzEf9Cqgg8eDuV/rBUB8Vfu/6
 2ZXWqqDpkbP3qunbmVeJNs47tyUxYOtBl9nWOcLxOgiWCbMItdn9ktP0K9AN8iAh8+PuxZhHc
 PRAFODgKBFCSDrx/ddNewxmD809vgWIs+VuVdvUZYMxm+jcTpl8v5hjiqjNsY9TqDcDvHJ6WV
 n91CKwU23V3nyGFOzhUVpS5oLyslSnG7TgXNAYINga4reccDnZShosOn6hR0M8YWSTByExj6O
 84+rf5yWI8LbmSP3sD9znKxgMJwaOaMNua04ybWre/UH4iSzJHyZRZPOl9RWv7x2e1DhpISwI
 feJAd03yL2CoVnpvDCBdrbjBzauvQjiTSPdBKNqJXMzNjqOBLLIIyUGqZNquOyaEOxJOf2FBp
 DymunFEXhCdT3AE7M9cMxShbwjvA13BkxHrNXHlx/6Ufy+9Mee9ya4cFn7U90nGRHSEX28oqJ
 9iyKa8KpQB3wlPsg7XbN6P4BGtsDgpoes2O8DSZ7HOKJUHAdnbvAKYRyjLWLehEYL6iIr72ga
 qujXkipt2CpngzFdYT0W6hrhVJZ8Pmo5++QZ4e+4K5rg1BQEJpuX74p0O00fMJgP/bzjbrq5F
 06XQtZuGkuKeF5tPbbgZbauUxyI0FnYZIq7MuNt7C62nu2R7632iKWM0ImpNuHvl2THTTNWQj
 TTkIn93gJGNcZSY0XsyBTa9VLDo1c2JmA==
Received-SPF: pass client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Automatically generated using scripts/gensyscalls.sh

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/aarch64/syscall_nr.h     | 19 ++++++++++++++++++-
 linux-user/hexagon/syscall_nr.h     | 20 ++++++++++++++++++--
 linux-user/loongarch64/syscall_nr.h | 14 +++++++++++++-
 linux-user/openrisc/syscall_nr.h    | 18 +++++++++++++++++-
 linux-user/riscv/syscall32_nr.h     | 23 ++++++++++++++++++++---
 linux-user/riscv/syscall64_nr.h     | 23 ++++++++++++++++++++---
 6 files changed, 106 insertions(+), 11 deletions(-)

diff --git a/linux-user/aarch64/syscall_nr.h b/linux-user/aarch64/syscall_nr.h
index 12ef002d60f9..c2e09ed5c50c 100644
--- a/linux-user/aarch64/syscall_nr.h
+++ b/linux-user/aarch64/syscall_nr.h
@@ -305,9 +305,26 @@
 #define TARGET_NR_process_madvise 440
 #define TARGET_NR_epoll_pwait2 441
 #define TARGET_NR_mount_setattr 442
+#define TARGET_NR_quotactl_fd 443
 #define TARGET_NR_landlock_create_ruleset 444
 #define TARGET_NR_landlock_add_rule 445
 #define TARGET_NR_landlock_restrict_self 446
-#define TARGET_NR_syscalls 447
+#define TARGET_NR_memfd_secret 447
+#define TARGET_NR_process_mrelease 448
+#define TARGET_NR_futex_waitv 449
+#define TARGET_NR_set_mempolicy_home_node 450
+#define TARGET_NR_cachestat 451
+#define TARGET_NR_fchmodat2 452
+#define TARGET_NR_map_shadow_stack 453
+#define TARGET_NR_futex_wake 454
+#define TARGET_NR_futex_wait 455
+#define TARGET_NR_futex_requeue 456
+#define TARGET_NR_statmount 457
+#define TARGET_NR_listmount 458
+#define TARGET_NR_lsm_get_self_attr 459
+#define TARGET_NR_lsm_set_self_attr 460
+#define TARGET_NR_lsm_list_modules 461
+#define TARGET_NR_mseal 462
+#define TARGET_NR_syscalls 463
 
 #endif /* LINUX_USER_AARCH64_SYSCALL_NR_H */
diff --git a/linux-user/hexagon/syscall_nr.h b/linux-user/hexagon/syscall_nr.h
index b047dbbf6df3..f3220b74f7c3 100644
--- a/linux-user/hexagon/syscall_nr.h
+++ b/linux-user/hexagon/syscall_nr.h
@@ -90,7 +90,7 @@
 #define TARGET_NR_sync 81
 #define TARGET_NR_fsync 82
 #define TARGET_NR_fdatasync 83
-#define TARGET_NR_sync_file_range 84
+#define TARGET_NR_sync_file_range2 84
 #define TARGET_NR_timerfd_create 85
 #define TARGET_NR_timerfd_settime 86
 #define TARGET_NR_timerfd_gettime 87
@@ -324,9 +324,25 @@
 #define TARGET_NR_process_madvise 440
 #define TARGET_NR_epoll_pwait2 441
 #define TARGET_NR_mount_setattr 442
+#define TARGET_NR_quotactl_fd 443
 #define TARGET_NR_landlock_create_ruleset 444
 #define TARGET_NR_landlock_add_rule 445
 #define TARGET_NR_landlock_restrict_self 446
-#define TARGET_NR_syscalls 447
+#define TARGET_NR_process_mrelease 448
+#define TARGET_NR_futex_waitv 449
+#define TARGET_NR_set_mempolicy_home_node 450
+#define TARGET_NR_cachestat 451
+#define TARGET_NR_fchmodat2 452
+#define TARGET_NR_map_shadow_stack 453
+#define TARGET_NR_futex_wake 454
+#define TARGET_NR_futex_wait 455
+#define TARGET_NR_futex_requeue 456
+#define TARGET_NR_statmount 457
+#define TARGET_NR_listmount 458
+#define TARGET_NR_lsm_get_self_attr 459
+#define TARGET_NR_lsm_set_self_attr 460
+#define TARGET_NR_lsm_list_modules 461
+#define TARGET_NR_mseal 462
+#define TARGET_NR_syscalls 463
 
 #endif /* LINUX_USER_HEXAGON_SYSCALL_NR_H */
diff --git a/linux-user/loongarch64/syscall_nr.h b/linux-user/loongarch64/syscall_nr.h
index be00915adf22..fefca6f5f6d3 100644
--- a/linux-user/loongarch64/syscall_nr.h
+++ b/linux-user/loongarch64/syscall_nr.h
@@ -307,6 +307,18 @@
 #define TARGET_NR_process_mrelease 448
 #define TARGET_NR_futex_waitv 449
 #define TARGET_NR_set_mempolicy_home_node 450
-#define TARGET_NR_syscalls 451
+#define TARGET_NR_cachestat 451
+#define TARGET_NR_fchmodat2 452
+#define TARGET_NR_map_shadow_stack 453
+#define TARGET_NR_futex_wake 454
+#define TARGET_NR_futex_wait 455
+#define TARGET_NR_futex_requeue 456
+#define TARGET_NR_statmount 457
+#define TARGET_NR_listmount 458
+#define TARGET_NR_lsm_get_self_attr 459
+#define TARGET_NR_lsm_set_self_attr 460
+#define TARGET_NR_lsm_list_modules 461
+#define TARGET_NR_mseal 462
+#define TARGET_NR_syscalls 463
 
 #endif /* LINUX_USER_LOONGARCH_SYSCALL_NR_H */
diff --git a/linux-user/openrisc/syscall_nr.h b/linux-user/openrisc/syscall_nr.h
index f7faddb54c58..2b66f99ea66a 100644
--- a/linux-user/openrisc/syscall_nr.h
+++ b/linux-user/openrisc/syscall_nr.h
@@ -326,9 +326,25 @@
 #define TARGET_NR_process_madvise 440
 #define TARGET_NR_epoll_pwait2 441
 #define TARGET_NR_mount_setattr 442
+#define TARGET_NR_quotactl_fd 443
 #define TARGET_NR_landlock_create_ruleset 444
 #define TARGET_NR_landlock_add_rule 445
 #define TARGET_NR_landlock_restrict_self 446
-#define TARGET_NR_syscalls 447
+#define TARGET_NR_process_mrelease 448
+#define TARGET_NR_futex_waitv 449
+#define TARGET_NR_set_mempolicy_home_node 450
+#define TARGET_NR_cachestat 451
+#define TARGET_NR_fchmodat2 452
+#define TARGET_NR_map_shadow_stack 453
+#define TARGET_NR_futex_wake 454
+#define TARGET_NR_futex_wait 455
+#define TARGET_NR_futex_requeue 456
+#define TARGET_NR_statmount 457
+#define TARGET_NR_listmount 458
+#define TARGET_NR_lsm_get_self_attr 459
+#define TARGET_NR_lsm_set_self_attr 460
+#define TARGET_NR_lsm_list_modules 461
+#define TARGET_NR_mseal 462
+#define TARGET_NR_syscalls 463
 
 #endif /* LINUX_USER_OPENRISC_SYSCALL_NR_H */
diff --git a/linux-user/riscv/syscall32_nr.h b/linux-user/riscv/syscall32_nr.h
index 412e58e5b2f2..42376ac8c7d2 100644
--- a/linux-user/riscv/syscall32_nr.h
+++ b/linux-user/riscv/syscall32_nr.h
@@ -7,6 +7,8 @@
 #define LINUX_USER_RISCV_SYSCALL32_NR_H
 
 #define TARGET_NR_io_setup 0
+#define TARGET_NR_riscv_flush_icache (TARGET_NR_arch_specific_syscall + 15)
+#define TARGET_NR_riscv_hwprobe (TARGET_NR_arch_specific_syscall + 14)
 #define TARGET_NR_io_destroy 1
 #define TARGET_NR_io_submit 2
 #define TARGET_NR_io_cancel 3
@@ -227,8 +229,6 @@
 #define TARGET_NR_perf_event_open 241
 #define TARGET_NR_accept4 242
 #define TARGET_NR_arch_specific_syscall 244
-#define TARGET_NR_riscv_flush_icache (TARGET_NR_arch_specific_syscall + 15)
-#define TARGET_NR_riscv_hwprobe (TARGET_NR_arch_specific_syscall + 14)
 #define TARGET_NR_prlimit64 261
 #define TARGET_NR_fanotify_init 262
 #define TARGET_NR_fanotify_mark 263
@@ -300,9 +300,26 @@
 #define TARGET_NR_process_madvise 440
 #define TARGET_NR_epoll_pwait2 441
 #define TARGET_NR_mount_setattr 442
+#define TARGET_NR_quotactl_fd 443
 #define TARGET_NR_landlock_create_ruleset 444
 #define TARGET_NR_landlock_add_rule 445
 #define TARGET_NR_landlock_restrict_self 446
-#define TARGET_NR_syscalls 447
+#define TARGET_NR_memfd_secret 447
+#define TARGET_NR_process_mrelease 448
+#define TARGET_NR_futex_waitv 449
+#define TARGET_NR_set_mempolicy_home_node 450
+#define TARGET_NR_cachestat 451
+#define TARGET_NR_fchmodat2 452
+#define TARGET_NR_map_shadow_stack 453
+#define TARGET_NR_futex_wake 454
+#define TARGET_NR_futex_wait 455
+#define TARGET_NR_futex_requeue 456
+#define TARGET_NR_statmount 457
+#define TARGET_NR_listmount 458
+#define TARGET_NR_lsm_get_self_attr 459
+#define TARGET_NR_lsm_set_self_attr 460
+#define TARGET_NR_lsm_list_modules 461
+#define TARGET_NR_mseal 462
+#define TARGET_NR_syscalls 463
 
 #endif /* LINUX_USER_RISCV_SYSCALL32_NR_H */
diff --git a/linux-user/riscv/syscall64_nr.h b/linux-user/riscv/syscall64_nr.h
index 29e1eb20753e..96ee92ec31f8 100644
--- a/linux-user/riscv/syscall64_nr.h
+++ b/linux-user/riscv/syscall64_nr.h
@@ -7,6 +7,8 @@
 #define LINUX_USER_RISCV_SYSCALL64_NR_H
 
 #define TARGET_NR_io_setup 0
+#define TARGET_NR_riscv_flush_icache (TARGET_NR_arch_specific_syscall + 15)
+#define TARGET_NR_riscv_hwprobe (TARGET_NR_arch_specific_syscall + 14)
 #define TARGET_NR_io_destroy 1
 #define TARGET_NR_io_submit 2
 #define TARGET_NR_io_cancel 3
@@ -250,8 +252,6 @@
 #define TARGET_NR_accept4 242
 #define TARGET_NR_recvmmsg 243
 #define TARGET_NR_arch_specific_syscall 244
-#define TARGET_NR_riscv_flush_icache (TARGET_NR_arch_specific_syscall + 15)
-#define TARGET_NR_riscv_hwprobe (TARGET_NR_arch_specific_syscall + 14)
 #define TARGET_NR_wait4 260
 #define TARGET_NR_prlimit64 261
 #define TARGET_NR_fanotify_init 262
@@ -306,9 +306,26 @@
 #define TARGET_NR_process_madvise 440
 #define TARGET_NR_epoll_pwait2 441
 #define TARGET_NR_mount_setattr 442
+#define TARGET_NR_quotactl_fd 443
 #define TARGET_NR_landlock_create_ruleset 444
 #define TARGET_NR_landlock_add_rule 445
 #define TARGET_NR_landlock_restrict_self 446
-#define TARGET_NR_syscalls 447
+#define TARGET_NR_memfd_secret 447
+#define TARGET_NR_process_mrelease 448
+#define TARGET_NR_futex_waitv 449
+#define TARGET_NR_set_mempolicy_home_node 450
+#define TARGET_NR_cachestat 451
+#define TARGET_NR_fchmodat2 452
+#define TARGET_NR_map_shadow_stack 453
+#define TARGET_NR_futex_wake 454
+#define TARGET_NR_futex_wait 455
+#define TARGET_NR_futex_requeue 456
+#define TARGET_NR_statmount 457
+#define TARGET_NR_listmount 458
+#define TARGET_NR_lsm_get_self_attr 459
+#define TARGET_NR_lsm_set_self_attr 460
+#define TARGET_NR_lsm_list_modules 461
+#define TARGET_NR_mseal 462
+#define TARGET_NR_syscalls 463
 
 #endif /* LINUX_USER_RISCV_SYSCALL64_NR_H */
-- 
2.46.0


