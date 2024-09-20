Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5EE8CF9C41
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 15:12:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srfHt-0002l0-25; Fri, 20 Sep 2024 11:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1srfHk-0002GD-KM; Fri, 20 Sep 2024 11:11:05 -0400
Received: from mout.kundenserver.de ([217.72.192.74])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1srfHh-0003oK-Fl; Fri, 20 Sep 2024 11:11:04 -0400
Received: from quad ([82.64.211.94]) by mrelayeu.kundenserver.de (mreue109
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MF39S-1sl5hH0nMW-00FoAY; Fri, 20
 Sep 2024 17:10:39 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Brian Cain <bcain@quicinc.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Weiwei Li <liwei1518@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Bin Meng <bmeng.cn@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 6/6] linux-user: update syscall.tbl to Linux v6.11
Date: Fri, 20 Sep 2024 17:10:34 +0200
Message-ID: <20240920151034.859533-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240920151034.859533-1-laurent@vivier.eu>
References: <20240920151034.859533-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:KbRQvgrfASEhMMHjTqRC8I6sKTuCkdJ4S5BZI7var1lQ8pm96Bq
 Z7DwEFGvt09NpS6Z2oqR3PvwCKG5EKmGswrGOZFWrv0ji36b8fg4i1Z/xgqGFN10efaNiRU
 J0+SfVyend01bGpJ5T2hcOzxs83ROryZOkBgdiUmBP2t68TEawnVWL+BxT4IJMgDctCwGwy
 5Q0C2pCD3gkzYkKn9VkiQ==
UI-OutboundReport: notjunk:1;M01:P0:RF+TW4TvdEI=;8UYvTCbZhT5HHTbLRDpw6dd/euS
 S0zimYJURPqPM9JHXFZsK7K6YS+We/eA2pE1uyFJU9ttzodBXtMpgXoo8kUIA/qvVeEkJ0XpV
 TrUuduxa97Sf3/W1VYrNmw+rPIXgnfHMN4tluh0euIzR9YSWHhClvMSiCl48eUGRc8I0vAyej
 cAl+z565hOHVz4Vesd19V8+4sUrOK/yW+nu48Vv8U8+1wg+OgIAqb9HvYki4tXrWRvRtB/Ccd
 Yq1OIhYy1zJpVui/yPtoNL2TVxWsWqHPQSaKNwYBDaqC8Wer2J5OmTFAWLT5pjn+BpsqVJBn4
 SZBY49XY0xtaI+mF6d+yRVRqO00N6r6KsA7etStDmmrdl+okDU2Xba44WtmMxVU3upA0TpDJX
 JR2CrMx0RNRXT9eJajCOXfxSaYVn1CgoF8TxrcVn4Nb5MVzBHREYKt+bqAby3/mcOaf5MqPl1
 qUEzJz+1cotjyLUjzH5R8DlG6WauOUQDufYPZylAO0uuuE4kcq0cYHiNXZ0L1R98AxSR5sQMi
 ysdfJtl90pyYsBWpOqNA6fDh8GTrr5KQjNEUIa/KVSPhYGucvTmfORxrahyeerr7muEhGkDFB
 Hf87rXkXuFRbwD953YJGHYbyMavYLfj5ioDE8m8+o311woVyGA3b2bcr7W7w8uf/EhKrDfZLA
 dBgUzxZdt9150BoS28rFjASTgCMxq7TpvfVt0qkqvnk7orOarF3RCMwekTwqalG4Ox4t/tNeC
 SSsQuZ0JOWYPpOTiW46/in1MVxVl4Ir/Q==
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

Updated running scripts/update-syscalltbl.sh

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/arm/syscall.tbl       | 1 +
 linux-user/i386/syscall_32.tbl   | 7 ++++---
 linux-user/x86_64/syscall_64.tbl | 8 +++++---
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/linux-user/arm/syscall.tbl b/linux-user/arm/syscall.tbl
index 2ed7d229c8f9..23c98203c40f 100644
--- a/linux-user/arm/syscall.tbl
+++ b/linux-user/arm/syscall.tbl
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
 #
 # Linux system call numbers and entry vectors
 #
diff --git a/linux-user/i386/syscall_32.tbl b/linux-user/i386/syscall_32.tbl
index d6ebcab1d8b2..534c74b14fab 100644
--- a/linux-user/i386/syscall_32.tbl
+++ b/linux-user/i386/syscall_32.tbl
@@ -1,8 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
 #
 # 32-bit system call numbers and entry vectors
 #
 # The format is:
-# <number> <abi> <name> <entry point> <compat entry point>
+# <number> <abi> <name> <entry point> [<compat entry point> [noreturn]]
 #
 # The __ia32_sys and __ia32_compat_sys stubs are created on-the-fly for
 # sys_*() system calls and compat_sys_*() compat system calls if
@@ -12,7 +13,7 @@
 # The abi is always "i386" for this file.
 #
 0	i386	restart_syscall		sys_restart_syscall
-1	i386	exit			sys_exit
+1	i386	exit			sys_exit			-			noreturn
 2	i386	fork			sys_fork
 3	i386	read			sys_read
 4	i386	write			sys_write
@@ -263,7 +264,7 @@
 249	i386	io_cancel		sys_io_cancel
 250	i386	fadvise64		sys_ia32_fadvise64
 # 251 is available for reuse (was briefly sys_set_zone_reclaim)
-252	i386	exit_group		sys_exit_group
+252	i386	exit_group		sys_exit_group			-			noreturn
 253	i386	lookup_dcookie
 254	i386	epoll_create		sys_epoll_create
 255	i386	epoll_ctl		sys_epoll_ctl
diff --git a/linux-user/x86_64/syscall_64.tbl b/linux-user/x86_64/syscall_64.tbl
index a396f6e6ab5b..7093ee21c0d1 100644
--- a/linux-user/x86_64/syscall_64.tbl
+++ b/linux-user/x86_64/syscall_64.tbl
@@ -1,8 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
 #
 # 64-bit system call numbers and entry vectors
 #
 # The format is:
-# <number> <abi> <name> <entry point>
+# <number> <abi> <name> <entry point> [<compat entry point> [noreturn]]
 #
 # The __x64_sys_*() stubs are created on-the-fly for sys_*() system calls
 #
@@ -68,7 +69,7 @@
 57	common	fork			sys_fork
 58	common	vfork			sys_vfork
 59	64	execve			sys_execve
-60	common	exit			sys_exit
+60	common	exit			sys_exit			-			noreturn
 61	common	wait4			sys_wait4
 62	common	kill			sys_kill
 63	common	uname			sys_newuname
@@ -239,7 +240,7 @@
 228	common	clock_gettime		sys_clock_gettime
 229	common	clock_getres		sys_clock_getres
 230	common	clock_nanosleep		sys_clock_nanosleep
-231	common	exit_group		sys_exit_group
+231	common	exit_group		sys_exit_group			-			noreturn
 232	common	epoll_wait		sys_epoll_wait
 233	common	epoll_ctl		sys_epoll_ctl
 234	common	tgkill			sys_tgkill
@@ -343,6 +344,7 @@
 332	common	statx			sys_statx
 333	common	io_pgetevents		sys_io_pgetevents
 334	common	rseq			sys_rseq
+335	common	uretprobe		sys_uretprobe
 # don't use numbers 387 through 423, add new calls after the last
 # 'common' entry
 424	common	pidfd_send_signal	sys_pidfd_send_signal
-- 
2.46.0


