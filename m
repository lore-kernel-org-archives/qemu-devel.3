Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 932F8CCD189
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 07:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqpLJ-0001Z7-HV; Wed, 18 Sep 2024 03:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1sqpLH-0001SY-QQ
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 03:43:15 -0400
Received: from mout.kundenserver.de ([212.227.17.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1sqpLD-0001lt-Gz
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 03:43:15 -0400
Received: from quad ([82.64.211.94]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MjSwu-1s5zGy2oOY-00kGMy; Wed, 18
 Sep 2024 09:42:58 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Brian Cain <bcain@quicinc.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 3/3] linux-user: update syscall.tbl to Linux v6.10
Date: Wed, 18 Sep 2024 09:42:56 +0200
Message-ID: <20240918074256.720617-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240918074256.720617-1-laurent@vivier.eu>
References: <20240918074256.720617-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:PzLTgaS7U9Wu4MUgbabWu+/hNrFI9jJaIU9oTdFZTRHpWpnjwUR
 NgXTnCrMjjY6k+vgs8w0e90lJyZdx0+1u+ntuXRne04Sii3/YYiTxc0ZN+AKgs78OFsJ1WI
 l699vkOoojZw9HuHdouIlneK6ctvFzTETmwXaKwc2zAjiUx8CLTkLutkIeQL0mu8IiWYG5J
 sSYym80RFmh5xhNk90FmA==
UI-OutboundReport: notjunk:1;M01:P0:aMYhCny3cas=;89Larp0oWCLAyqCJUj6RxuuA5um
 M4GCokXUhcngqoWAGAYEXt9aDGXpAhKbvpUF1MMAaVllQJVI7C3FLOehj0ilvvbjQo1YPt4Y4
 9H6HjikrnjMC1eao0vcjPX+OrPp2BZvHqvaDxZTTI7we5EhrYWN1zZOySiXXaKYISYrgse9/C
 2TS3kAgSxRxeNAEK+NyNGEo5oRQcRPFCmjMWQIANrxdOC9Gh+vPdFWJibuTiyBq3tTI18d6TW
 TA+Vi4jChpaMYPmtSXBq5nchZtfqa5qS9k4/dZvyN2igU0UiNUrBGdLpkOoqSwaTNWDnuisZn
 0yf7gsDFI/IG6crwYS0i78/prGGpVk52QcskySylYJjnHkRIYi808dmLSdy7dY8+5EV2SW2dY
 uqLNXKtgXq1iMANVCSMHH2CmM4FoUazb6Drz8dxu/D+KMAI/lVU+K/1g9aMsoh4VSnlV7Nsou
 0rUigs28qxOCTFVempD1CVwyFivw+gqh8iDWsWAEKDnZSHYFYbxTUx+LhyxV6QDVRgkL0ejlU
 SYG5MWRuFReIcMkFiWTJwSxrA+24EhOBOH5Ogtks1GKual5dWnMpwuU9n8zJWB0ZIldvcOD78
 46LBlubyRMBclZuNyPUY4ETI/90qN2QJW0WHhRAmFwpJ2DvnPSi44Q0oIXp+uhKc203/+cQJU
 qTWtkcXUz6mqTKHkBl+o7+yolBXbq/yUeIvQLFT6pX0IqmxtoyChjc+Y0ssyIkUsjKHW+zxLB
 13vlPJnl/w8l2meXVWeO2MtASgyAtl+2w==
Received-SPF: pass client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
 linux-user/alpha/syscall.tbl      | 28 +++++++++---
 linux-user/arm/syscall.tbl        | 24 +++++++++--
 linux-user/hppa/syscall.tbl       | 41 ++++++++++++------
 linux-user/i386/syscall_32.tbl    | 28 +++++++++---
 linux-user/m68k/syscall.tbl       | 22 ++++++++--
 linux-user/microblaze/syscall.tbl | 22 ++++++++--
 linux-user/mips/syscall_o32.tbl   | 36 +++++++++++-----
 linux-user/mips64/syscall_n32.tbl | 32 ++++++++++----
 linux-user/mips64/syscall_n64.tbl | 20 ++++++++-
 linux-user/ppc/syscall.tbl        | 71 +++++++++++++++++++++----------
 linux-user/s390x/syscall.tbl      | 34 +++++++++++----
 linux-user/sh4/syscall.tbl        | 25 +++++++++--
 linux-user/sparc/syscall.tbl      | 40 +++++++++++------
 linux-user/x86_64/syscall_64.tbl  | 22 ++++++++--
 linux-user/xtensa/syscall.tbl     | 22 ++++++++--
 15 files changed, 360 insertions(+), 107 deletions(-)

diff --git a/linux-user/alpha/syscall.tbl b/linux-user/alpha/syscall.tbl
index 3000a2e8ee21..74720667fe09 100644
--- a/linux-user/alpha/syscall.tbl
+++ b/linux-user/alpha/syscall.tbl
@@ -125,8 +125,8 @@
 116	common	osf_gettimeofday		sys_osf_gettimeofday
 117	common	osf_getrusage			sys_osf_getrusage
 118	common	getsockopt			sys_getsockopt
-120	common	readv				sys_osf_readv
-121	common	writev				sys_osf_writev
+120	common	readv				sys_readv
+121	common	writev				sys_writev
 122	common	osf_settimeofday		sys_osf_settimeofday
 123	common	fchown				sys_fchown
 124	common	fchmod				sys_fchmod
@@ -230,7 +230,7 @@
 259	common	osf_swapctl			sys_ni_syscall
 260	common	osf_memcntl			sys_ni_syscall
 261	common	osf_fdatasync			sys_ni_syscall
-300	common	bdflush				sys_bdflush
+300	common	bdflush				sys_ni_syscall
 301	common	sethae				sys_sethae
 302	common	mount				sys_mount
 303	common	old_adjtimex			sys_old_adjtimex
@@ -334,7 +334,7 @@
 401	common	io_submit			sys_io_submit
 402	common	io_cancel			sys_io_cancel
 405	common	exit_group			sys_exit_group
-406	common	lookup_dcookie			sys_lookup_dcookie
+406	common	lookup_dcookie			sys_ni_syscall
 407	common	epoll_create			sys_epoll_create
 408	common	epoll_ctl			sys_epoll_ctl
 409	common	epoll_wait			sys_epoll_wait
@@ -474,7 +474,7 @@
 542	common	fsmount				sys_fsmount
 543	common	fspick				sys_fspick
 544	common	pidfd_open			sys_pidfd_open
-# 545 reserved for clone3
+545	common	clone3				alpha_clone3
 546	common	close_range			sys_close_range
 547	common	openat2				sys_openat2
 548	common	pidfd_getfd			sys_pidfd_getfd
@@ -482,7 +482,23 @@
 550	common	process_madvise			sys_process_madvise
 551	common	epoll_pwait2			sys_epoll_pwait2
 552	common	mount_setattr			sys_mount_setattr
-# 553 reserved for quotactl_path
+553	common	quotactl_fd			sys_quotactl_fd
 554	common	landlock_create_ruleset		sys_landlock_create_ruleset
 555	common	landlock_add_rule		sys_landlock_add_rule
 556	common	landlock_restrict_self		sys_landlock_restrict_self
+# 557 reserved for memfd_secret
+558	common	process_mrelease		sys_process_mrelease
+559	common  futex_waitv                     sys_futex_waitv
+560	common	set_mempolicy_home_node		sys_ni_syscall
+561	common	cachestat			sys_cachestat
+562	common	fchmodat2			sys_fchmodat2
+563	common	map_shadow_stack		sys_map_shadow_stack
+564	common	futex_wake			sys_futex_wake
+565	common	futex_wait			sys_futex_wait
+566	common	futex_requeue			sys_futex_requeue
+567	common	statmount			sys_statmount
+568	common	listmount			sys_listmount
+569	common	lsm_get_self_attr		sys_lsm_get_self_attr
+570	common	lsm_set_self_attr		sys_lsm_set_self_attr
+571	common	lsm_list_modules		sys_lsm_list_modules
+572	common  mseal				sys_mseal
diff --git a/linux-user/arm/syscall.tbl b/linux-user/arm/syscall.tbl
index 28e03b5fec00..2ed7d229c8f9 100644
--- a/linux-user/arm/syscall.tbl
+++ b/linux-user/arm/syscall.tbl
@@ -147,7 +147,7 @@
 131	common	quotactl		sys_quotactl
 132	common	getpgid			sys_getpgid
 133	common	fchdir			sys_fchdir
-134	common	bdflush			sys_bdflush
+134	common	bdflush			sys_ni_syscall
 135	common	sysfs			sys_sysfs
 136	common	personality		sys_personality
 # 137 was sys_afs_syscall
@@ -263,10 +263,10 @@
 246	common	io_submit		sys_io_submit
 247	common	io_cancel		sys_io_cancel
 248	common	exit_group		sys_exit_group
-249	common	lookup_dcookie		sys_lookup_dcookie
+249	common	lookup_dcookie		sys_ni_syscall
 250	common	epoll_create		sys_epoll_create
 251	common	epoll_ctl		sys_epoll_ctl		sys_oabi_epoll_ctl
-252	common	epoll_wait		sys_epoll_wait		sys_oabi_epoll_wait
+252	common	epoll_wait		sys_epoll_wait
 253	common	remap_file_pages	sys_remap_file_pages
 # 254 for set_thread_area
 # 255 for get_thread_area
@@ -456,7 +456,23 @@
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2
 442	common	mount_setattr			sys_mount_setattr
-# 443 reserved for quotactl_path
+443	common	quotactl_fd			sys_quotactl_fd
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
+# 447 reserved for memfd_secret
+448	common	process_mrelease		sys_process_mrelease
+449	common	futex_waitv			sys_futex_waitv
+450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	cachestat			sys_cachestat
+452	common	fchmodat2			sys_fchmodat2
+453	common	map_shadow_stack		sys_map_shadow_stack
+454	common	futex_wake			sys_futex_wake
+455	common	futex_wait			sys_futex_wait
+456	common	futex_requeue			sys_futex_requeue
+457	common	statmount			sys_statmount
+458	common	listmount			sys_listmount
+459	common	lsm_get_self_attr		sys_lsm_get_self_attr
+460	common	lsm_set_self_attr		sys_lsm_set_self_attr
+461	common	lsm_list_modules		sys_lsm_list_modules
+462	common	mseal				sys_mseal
diff --git a/linux-user/hppa/syscall.tbl b/linux-user/hppa/syscall.tbl
index aabc37f8cae3..66dc406b12e4 100644
--- a/linux-user/hppa/syscall.tbl
+++ b/linux-user/hppa/syscall.tbl
@@ -108,7 +108,7 @@
 95	common	fchown			sys_fchown
 96	common	getpriority		sys_getpriority
 97	common	setpriority		sys_setpriority
-98	common	recv			sys_recv
+98	common	recv			sys_recv			compat_sys_recv
 99	common	statfs			sys_statfs			compat_sys_statfs
 100	common	fstatfs			sys_fstatfs			compat_sys_fstatfs
 101	common	stat64			sys_stat64
@@ -131,11 +131,11 @@
 116	common	sysinfo			sys_sysinfo			compat_sys_sysinfo
 117	common	shutdown		sys_shutdown
 118	common	fsync			sys_fsync
-119	common	madvise			sys_madvise
+119	common	madvise			parisc_madvise
 120	common	clone			sys_clone_wrapper
 121	common	setdomainname		sys_setdomainname
 122	common	sendfile		sys_sendfile			compat_sys_sendfile
-123	common	recvfrom		sys_recvfrom
+123	common	recvfrom		sys_recvfrom			compat_sys_recvfrom
 124	32	adjtimex		sys_adjtimex_time32
 124	64	adjtimex		sys_adjtimex
 125	common	mprotect		sys_mprotect
@@ -147,7 +147,7 @@
 131	common	quotactl		sys_quotactl
 132	common	getpgid			sys_getpgid
 133	common	fchdir			sys_fchdir
-134	common	bdflush			sys_bdflush
+134	common	bdflush			sys_ni_syscall
 135	common	sysfs			sys_sysfs
 136	32	personality		parisc_personality
 136	64	personality		sys_personality
@@ -245,7 +245,7 @@
 # 220 was alloc_hugepages
 # 221 was free_hugepages
 222	common	exit_group		sys_exit_group
-223	common	lookup_dcookie		sys_lookup_dcookie		compat_sys_lookup_dcookie
+223	common	lookup_dcookie		sys_ni_syscall
 224	common	epoll_create		sys_epoll_create
 225	common	epoll_ctl		sys_epoll_ctl
 226	common	epoll_wait		sys_epoll_wait
@@ -292,9 +292,9 @@
 258	32	clock_nanosleep		sys_clock_nanosleep_time32
 258	64	clock_nanosleep		sys_clock_nanosleep
 259	common	tgkill			sys_tgkill
-260	common	mbind			sys_mbind			compat_sys_mbind
-261	common	get_mempolicy		sys_get_mempolicy		compat_sys_get_mempolicy
-262	common	set_mempolicy		sys_set_mempolicy		compat_sys_set_mempolicy
+260	common	mbind			sys_mbind
+261	common	get_mempolicy		sys_get_mempolicy
+262	common	set_mempolicy		sys_set_mempolicy
 # 263 was vserver
 264	common	add_key			sys_add_key
 265	common	request_key		sys_request_key
@@ -331,7 +331,7 @@
 292	64	sync_file_range		sys_sync_file_range
 293	common	tee			sys_tee
 294	common	vmsplice		sys_vmsplice
-295	common	move_pages		sys_move_pages			compat_sys_move_pages
+295	common	move_pages		sys_move_pages
 296	common	getcpu			sys_getcpu
 297	common	epoll_pwait		sys_epoll_pwait			compat_sys_epoll_pwait
 298	common	statfs64		sys_statfs64			compat_sys_statfs64
@@ -364,7 +364,7 @@
 320	common	accept4			sys_accept4
 321	common	prlimit64		sys_prlimit64
 322	common	fanotify_init		sys_fanotify_init
-323	common	fanotify_mark		sys_fanotify_mark		sys32_fanotify_mark
+323	common	fanotify_mark		sys_fanotify_mark		compat_sys_fanotify_mark
 324	32	clock_adjtime		sys_clock_adjtime32
 324	64	clock_adjtime		sys_clock_adjtime
 325	common	name_to_handle_at	sys_name_to_handle_at
@@ -400,6 +400,7 @@
 353	common	pkey_free		sys_pkey_free
 354	common	rseq			sys_rseq
 355	common	kexec_file_load		sys_kexec_file_load		sys_kexec_file_load
+356	common	cacheflush		sys_cacheflush
 # up to 402 is unassigned and reserved for arch specific syscalls
 403	32	clock_gettime64			sys_clock_gettime		sys_clock_gettime
 404	32	clock_settime64			sys_clock_settime		sys_clock_settime
@@ -413,7 +414,7 @@
 412	32	utimensat_time64		sys_utimensat			sys_utimensat
 413	32	pselect6_time64			sys_pselect6			compat_sys_pselect6_time64
 414	32	ppoll_time64			sys_ppoll			compat_sys_ppoll_time64
-416	32	io_pgetevents_time64		sys_io_pgetevents		sys_io_pgetevents
+416	32	io_pgetevents_time64		sys_io_pgetevents		compat_sys_io_pgetevents_time64
 417	32	recvmmsg_time64			sys_recvmmsg			compat_sys_recvmmsg_time64
 418	32	mq_timedsend_time64		sys_mq_timedsend		sys_mq_timedsend
 419	32	mq_timedreceive_time64		sys_mq_timedreceive		sys_mq_timedreceive
@@ -440,7 +441,23 @@
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2		compat_sys_epoll_pwait2
 442	common	mount_setattr			sys_mount_setattr
-# 443 reserved for quotactl_path
+443	common	quotactl_fd			sys_quotactl_fd
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
+# 447 reserved for memfd_secret
+448	common	process_mrelease		sys_process_mrelease
+449	common	futex_waitv			sys_futex_waitv
+450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	cachestat			sys_cachestat
+452	common	fchmodat2			sys_fchmodat2
+453	common	map_shadow_stack		sys_map_shadow_stack
+454	common	futex_wake			sys_futex_wake
+455	common	futex_wait			sys_futex_wait
+456	common	futex_requeue			sys_futex_requeue
+457	common	statmount			sys_statmount
+458	common	listmount			sys_listmount
+459	common	lsm_get_self_attr		sys_lsm_get_self_attr
+460	common	lsm_set_self_attr		sys_lsm_set_self_attr
+461	common	lsm_list_modules		sys_lsm_list_modules
+462	common	mseal				sys_mseal
diff --git a/linux-user/i386/syscall_32.tbl b/linux-user/i386/syscall_32.tbl
index 4bbc267fb36b..d6ebcab1d8b2 100644
--- a/linux-user/i386/syscall_32.tbl
+++ b/linux-user/i386/syscall_32.tbl
@@ -145,7 +145,7 @@
 131	i386	quotactl		sys_quotactl
 132	i386	getpgid			sys_getpgid
 133	i386	fchdir			sys_fchdir
-134	i386	bdflush			sys_bdflush
+134	i386	bdflush			sys_ni_syscall
 135	i386	sysfs			sys_sysfs
 136	i386	personality		sys_personality
 137	i386	afs_syscall
@@ -264,7 +264,7 @@
 250	i386	fadvise64		sys_ia32_fadvise64
 # 251 is available for reuse (was briefly sys_set_zone_reclaim)
 252	i386	exit_group		sys_exit_group
-253	i386	lookup_dcookie		sys_lookup_dcookie		compat_sys_lookup_dcookie
+253	i386	lookup_dcookie
 254	i386	epoll_create		sys_epoll_create
 255	i386	epoll_ctl		sys_epoll_ctl
 256	i386	epoll_wait		sys_epoll_wait
@@ -286,7 +286,7 @@
 272	i386	fadvise64_64		sys_ia32_fadvise64_64
 273	i386	vserver
 274	i386	mbind			sys_mbind
-275	i386	get_mempolicy		sys_get_mempolicy		compat_sys_get_mempolicy
+275	i386	get_mempolicy		sys_get_mempolicy
 276	i386	set_mempolicy		sys_set_mempolicy
 277	i386	mq_open			sys_mq_open			compat_sys_mq_open
 278	i386	mq_unlink		sys_mq_unlink
@@ -328,7 +328,7 @@
 314	i386	sync_file_range		sys_ia32_sync_file_range
 315	i386	tee			sys_tee
 316	i386	vmsplice		sys_vmsplice
-317	i386	move_pages		sys_move_pages			compat_sys_move_pages
+317	i386	move_pages		sys_move_pages
 318	i386	getcpu			sys_getcpu
 319	i386	epoll_pwait		sys_epoll_pwait
 320	i386	utimensat		sys_utimensat_time32
@@ -420,7 +420,7 @@
 412	i386	utimensat_time64	sys_utimensat
 413	i386	pselect6_time64		sys_pselect6			compat_sys_pselect6_time64
 414	i386	ppoll_time64		sys_ppoll			compat_sys_ppoll_time64
-416	i386	io_pgetevents_time64	sys_io_pgetevents
+416	i386	io_pgetevents_time64	sys_io_pgetevents		compat_sys_io_pgetevents_time64
 417	i386	recvmmsg_time64		sys_recvmmsg			compat_sys_recvmmsg_time64
 418	i386	mq_timedsend_time64	sys_mq_timedsend
 419	i386	mq_timedreceive_time64	sys_mq_timedreceive
@@ -447,7 +447,23 @@
 440	i386	process_madvise		sys_process_madvise
 441	i386	epoll_pwait2		sys_epoll_pwait2		compat_sys_epoll_pwait2
 442	i386	mount_setattr		sys_mount_setattr
-# 443 reserved for quotactl_path
+443	i386	quotactl_fd		sys_quotactl_fd
 444	i386	landlock_create_ruleset	sys_landlock_create_ruleset
 445	i386	landlock_add_rule	sys_landlock_add_rule
 446	i386	landlock_restrict_self	sys_landlock_restrict_self
+447	i386	memfd_secret		sys_memfd_secret
+448	i386	process_mrelease	sys_process_mrelease
+449	i386	futex_waitv		sys_futex_waitv
+450	i386	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	i386	cachestat		sys_cachestat
+452	i386	fchmodat2		sys_fchmodat2
+453	i386	map_shadow_stack	sys_map_shadow_stack
+454	i386	futex_wake		sys_futex_wake
+455	i386	futex_wait		sys_futex_wait
+456	i386	futex_requeue		sys_futex_requeue
+457	i386	statmount		sys_statmount
+458	i386	listmount		sys_listmount
+459	i386	lsm_get_self_attr	sys_lsm_get_self_attr
+460	i386	lsm_set_self_attr	sys_lsm_set_self_attr
+461	i386	lsm_list_modules	sys_lsm_list_modules
+462	i386	mseal 			sys_mseal
diff --git a/linux-user/m68k/syscall.tbl b/linux-user/m68k/syscall.tbl
index 79c2d24c89dd..22a3cbd4c602 100644
--- a/linux-user/m68k/syscall.tbl
+++ b/linux-user/m68k/syscall.tbl
@@ -141,7 +141,7 @@
 131	common	quotactl			sys_quotactl
 132	common	getpgid				sys_getpgid
 133	common	fchdir				sys_fchdir
-134	common	bdflush				sys_bdflush
+134	common	bdflush				sys_ni_syscall
 135	common	sysfs				sys_sysfs
 136	common	personality			sys_personality
 # 137 was afs_syscall
@@ -255,7 +255,7 @@
 245	common	io_cancel			sys_io_cancel
 246	common	fadvise64			sys_fadvise64
 247	common	exit_group			sys_exit_group
-248	common	lookup_dcookie			sys_lookup_dcookie
+248	common	lookup_dcookie			sys_ni_syscall
 249	common	epoll_create			sys_epoll_create
 250	common	epoll_ctl			sys_epoll_ctl
 251	common	epoll_wait			sys_epoll_wait
@@ -442,7 +442,23 @@
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2
 442	common	mount_setattr			sys_mount_setattr
-# 443 reserved for quotactl_path
+443	common	quotactl_fd			sys_quotactl_fd
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
+# 447 reserved for memfd_secret
+448	common	process_mrelease		sys_process_mrelease
+449	common  futex_waitv                     sys_futex_waitv
+450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	cachestat			sys_cachestat
+452	common	fchmodat2			sys_fchmodat2
+453	common	map_shadow_stack		sys_map_shadow_stack
+454	common	futex_wake			sys_futex_wake
+455	common	futex_wait			sys_futex_wait
+456	common	futex_requeue			sys_futex_requeue
+457	common	statmount			sys_statmount
+458	common	listmount			sys_listmount
+459	common	lsm_get_self_attr		sys_lsm_get_self_attr
+460	common	lsm_set_self_attr		sys_lsm_set_self_attr
+461	common	lsm_list_modules		sys_lsm_list_modules
+462	common	mseal				sys_mseal
diff --git a/linux-user/microblaze/syscall.tbl b/linux-user/microblaze/syscall.tbl
index b11395a20c20..2b81a6bd78b2 100644
--- a/linux-user/microblaze/syscall.tbl
+++ b/linux-user/microblaze/syscall.tbl
@@ -141,7 +141,7 @@
 131	common	quotactl			sys_quotactl
 132	common	getpgid				sys_getpgid
 133	common	fchdir				sys_fchdir
-134	common	bdflush				sys_bdflush
+134	common	bdflush				sys_ni_syscall
 135	common	sysfs				sys_sysfs
 136	common	personality			sys_personality
 137	common	afs_syscall			sys_ni_syscall
@@ -260,7 +260,7 @@
 250	common	fadvise64			sys_fadvise64
 # 251 is available for reuse (was briefly sys_set_zone_reclaim)
 252	common	exit_group			sys_exit_group
-253	common	lookup_dcookie			sys_lookup_dcookie
+253	common	lookup_dcookie			sys_ni_syscall
 254	common	epoll_create			sys_epoll_create
 255	common	epoll_ctl			sys_epoll_ctl
 256	common	epoll_wait			sys_epoll_wait
@@ -448,7 +448,23 @@
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2
 442	common	mount_setattr			sys_mount_setattr
-# 443 reserved for quotactl_path
+443	common	quotactl_fd			sys_quotactl_fd
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
+# 447 reserved for memfd_secret
+448	common	process_mrelease		sys_process_mrelease
+449	common  futex_waitv                     sys_futex_waitv
+450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	cachestat			sys_cachestat
+452	common	fchmodat2			sys_fchmodat2
+453	common	map_shadow_stack		sys_map_shadow_stack
+454	common	futex_wake			sys_futex_wake
+455	common	futex_wait			sys_futex_wait
+456	common	futex_requeue			sys_futex_requeue
+457	common	statmount			sys_statmount
+458	common	listmount			sys_listmount
+459	common	lsm_get_self_attr		sys_lsm_get_self_attr
+460	common	lsm_set_self_attr		sys_lsm_set_self_attr
+461	common	lsm_list_modules		sys_lsm_list_modules
+462	common	mseal				sys_mseal
diff --git a/linux-user/mips/syscall_o32.tbl b/linux-user/mips/syscall_o32.tbl
index d560c467a8c6..2439a2491cff 100644
--- a/linux-user/mips/syscall_o32.tbl
+++ b/linux-user/mips/syscall_o32.tbl
@@ -27,7 +27,7 @@
 17	o32	break				sys_ni_syscall
 # 18 was sys_stat
 18	o32	unused18			sys_ni_syscall
-19	o32	lseek				sys_lseek
+19	o32	lseek				sys_lseek			compat_sys_lseek
 20	o32	getpid				sys_getpid
 21	o32	mount				sys_mount
 22	o32	umount				sys_oldumount
@@ -145,7 +145,7 @@
 131	o32	quotactl			sys_quotactl
 132	o32	getpgid				sys_getpgid
 133	o32	fchdir				sys_fchdir
-134	o32	bdflush				sys_bdflush
+134	o32	bdflush				sys_ni_syscall
 135	o32	sysfs				sys_sysfs
 136	o32	personality			sys_personality			sys_32_personality
 137	o32	afs_syscall			sys_ni_syscall
@@ -258,7 +258,7 @@
 244	o32	io_submit			sys_io_submit			compat_sys_io_submit
 245	o32	io_cancel			sys_io_cancel
 246	o32	exit_group			sys_exit_group
-247	o32	lookup_dcookie			sys_lookup_dcookie		compat_sys_lookup_dcookie
+247	o32	lookup_dcookie			sys_ni_syscall
 248	o32	epoll_create			sys_epoll_create
 249	o32	epoll_ctl			sys_epoll_ctl
 250	o32	epoll_wait			sys_epoll_wait
@@ -279,9 +279,9 @@
 265	o32	clock_nanosleep			sys_clock_nanosleep_time32
 266	o32	tgkill				sys_tgkill
 267	o32	utimes				sys_utimes_time32
-268	o32	mbind				sys_mbind			compat_sys_mbind
-269	o32	get_mempolicy			sys_get_mempolicy		compat_sys_get_mempolicy
-270	o32	set_mempolicy			sys_set_mempolicy		compat_sys_set_mempolicy
+268	o32	mbind				sys_mbind
+269	o32	get_mempolicy			sys_get_mempolicy
+270	o32	set_mempolicy			sys_set_mempolicy
 271	o32	mq_open				sys_mq_open			compat_sys_mq_open
 272	o32	mq_unlink			sys_mq_unlink
 273	o32	mq_timedsend			sys_mq_timedsend_time32
@@ -298,7 +298,7 @@
 284	o32	inotify_init			sys_inotify_init
 285	o32	inotify_add_watch		sys_inotify_add_watch
 286	o32	inotify_rm_watch		sys_inotify_rm_watch
-287	o32	migrate_pages			sys_migrate_pages		compat_sys_migrate_pages
+287	o32	migrate_pages			sys_migrate_pages
 288	o32	openat				sys_openat			compat_sys_openat
 289	o32	mkdirat				sys_mkdirat
 290	o32	mknodat				sys_mknodat
@@ -319,7 +319,7 @@
 305	o32	sync_file_range			sys_sync_file_range		sys32_sync_file_range
 306	o32	tee				sys_tee
 307	o32	vmsplice			sys_vmsplice
-308	o32	move_pages			sys_move_pages			compat_sys_move_pages
+308	o32	move_pages			sys_move_pages
 309	o32	set_robust_list			sys_set_robust_list		compat_sys_set_robust_list
 310	o32	get_robust_list			sys_get_robust_list		compat_sys_get_robust_list
 311	o32	kexec_load			sys_kexec_load			compat_sys_kexec_load
@@ -403,7 +403,7 @@
 412	o32	utimensat_time64		sys_utimensat			sys_utimensat
 413	o32	pselect6_time64			sys_pselect6			compat_sys_pselect6_time64
 414	o32	ppoll_time64			sys_ppoll			compat_sys_ppoll_time64
-416	o32	io_pgetevents_time64		sys_io_pgetevents		sys_io_pgetevents
+416	o32	io_pgetevents_time64		sys_io_pgetevents		compat_sys_io_pgetevents_time64
 417	o32	recvmmsg_time64			sys_recvmmsg			compat_sys_recvmmsg_time64
 418	o32	mq_timedsend_time64		sys_mq_timedsend		sys_mq_timedsend
 419	o32	mq_timedreceive_time64		sys_mq_timedreceive		sys_mq_timedreceive
@@ -430,7 +430,23 @@
 440	o32	process_madvise			sys_process_madvise
 441	o32	epoll_pwait2			sys_epoll_pwait2		compat_sys_epoll_pwait2
 442	o32	mount_setattr			sys_mount_setattr
-# 443 reserved for quotactl_path
+443	o32	quotactl_fd			sys_quotactl_fd
 444	o32	landlock_create_ruleset		sys_landlock_create_ruleset
 445	o32	landlock_add_rule		sys_landlock_add_rule
 446	o32	landlock_restrict_self		sys_landlock_restrict_self
+# 447 reserved for memfd_secret
+448	o32	process_mrelease		sys_process_mrelease
+449	o32	futex_waitv			sys_futex_waitv
+450	o32	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	o32	cachestat			sys_cachestat
+452	o32	fchmodat2			sys_fchmodat2
+453	o32	map_shadow_stack		sys_map_shadow_stack
+454	o32	futex_wake			sys_futex_wake
+455	o32	futex_wait			sys_futex_wait
+456	o32	futex_requeue			sys_futex_requeue
+457	o32	statmount			sys_statmount
+458	o32	listmount			sys_listmount
+459	o32	lsm_get_self_attr		sys_lsm_get_self_attr
+460	o32	lsm_set_self_attr		sys_lsm_set_self_attr
+461	o32	lsm_list_modules		sys_lsm_list_modules
+462	o32	mseal				sys_mseal
diff --git a/linux-user/mips64/syscall_n32.tbl b/linux-user/mips64/syscall_n32.tbl
index 9220909526f9..953f5b7dc723 100644
--- a/linux-user/mips64/syscall_n32.tbl
+++ b/linux-user/mips64/syscall_n32.tbl
@@ -214,7 +214,7 @@
 203	n32	io_submit			compat_sys_io_submit
 204	n32	io_cancel			sys_io_cancel
 205	n32	exit_group			sys_exit_group
-206	n32	lookup_dcookie			sys_lookup_dcookie
+206	n32	lookup_dcookie			sys_ni_syscall
 207	n32	epoll_create			sys_epoll_create
 208	n32	epoll_ctl			sys_epoll_ctl
 209	n32	epoll_wait			sys_epoll_wait
@@ -239,9 +239,9 @@
 228	n32	clock_nanosleep			sys_clock_nanosleep_time32
 229	n32	tgkill				sys_tgkill
 230	n32	utimes				sys_utimes_time32
-231	n32	mbind				compat_sys_mbind
-232	n32	get_mempolicy			compat_sys_get_mempolicy
-233	n32	set_mempolicy			compat_sys_set_mempolicy
+231	n32	mbind				sys_mbind
+232	n32	get_mempolicy			sys_get_mempolicy
+233	n32	set_mempolicy			sys_set_mempolicy
 234	n32	mq_open				compat_sys_mq_open
 235	n32	mq_unlink			sys_mq_unlink
 236	n32	mq_timedsend			sys_mq_timedsend_time32
@@ -258,7 +258,7 @@
 247	n32	inotify_init			sys_inotify_init
 248	n32	inotify_add_watch		sys_inotify_add_watch
 249	n32	inotify_rm_watch		sys_inotify_rm_watch
-250	n32	migrate_pages			compat_sys_migrate_pages
+250	n32	migrate_pages			sys_migrate_pages
 251	n32	openat				sys_openat
 252	n32	mkdirat				sys_mkdirat
 253	n32	mknodat				sys_mknodat
@@ -279,7 +279,7 @@
 268	n32	sync_file_range			sys_sync_file_range
 269	n32	tee				sys_tee
 270	n32	vmsplice			sys_vmsplice
-271	n32	move_pages			compat_sys_move_pages
+271	n32	move_pages			sys_move_pages
 272	n32	set_robust_list			compat_sys_set_robust_list
 273	n32	get_robust_list			compat_sys_get_robust_list
 274	n32	kexec_load			compat_sys_kexec_load
@@ -354,7 +354,7 @@
 412	n32	utimensat_time64		sys_utimensat
 413	n32	pselect6_time64			compat_sys_pselect6_time64
 414	n32	ppoll_time64			compat_sys_ppoll_time64
-416	n32	io_pgetevents_time64		sys_io_pgetevents
+416	n32	io_pgetevents_time64		compat_sys_io_pgetevents_time64
 417	n32	recvmmsg_time64			compat_sys_recvmmsg_time64
 418	n32	mq_timedsend_time64		sys_mq_timedsend
 419	n32	mq_timedreceive_time64		sys_mq_timedreceive
@@ -381,7 +381,23 @@
 440	n32	process_madvise			sys_process_madvise
 441	n32	epoll_pwait2			compat_sys_epoll_pwait2
 442	n32	mount_setattr			sys_mount_setattr
-# 443 reserved for quotactl_path
+443	n32	quotactl_fd			sys_quotactl_fd
 444	n32	landlock_create_ruleset		sys_landlock_create_ruleset
 445	n32	landlock_add_rule		sys_landlock_add_rule
 446	n32	landlock_restrict_self		sys_landlock_restrict_self
+# 447 reserved for memfd_secret
+448	n32	process_mrelease		sys_process_mrelease
+449	n32	futex_waitv			sys_futex_waitv
+450	n32	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	n32	cachestat			sys_cachestat
+452	n32	fchmodat2			sys_fchmodat2
+453	n32	map_shadow_stack		sys_map_shadow_stack
+454	n32	futex_wake			sys_futex_wake
+455	n32	futex_wait			sys_futex_wait
+456	n32	futex_requeue			sys_futex_requeue
+457	n32	statmount			sys_statmount
+458	n32	listmount			sys_listmount
+459	n32	lsm_get_self_attr		sys_lsm_get_self_attr
+460	n32	lsm_set_self_attr		sys_lsm_set_self_attr
+461	n32	lsm_list_modules		sys_lsm_list_modules
+462	n32	mseal				sys_mseal
diff --git a/linux-user/mips64/syscall_n64.tbl b/linux-user/mips64/syscall_n64.tbl
index 9cd1c34f31b5..1464c6be6eb3 100644
--- a/linux-user/mips64/syscall_n64.tbl
+++ b/linux-user/mips64/syscall_n64.tbl
@@ -214,7 +214,7 @@
 203	n64	io_submit			sys_io_submit
 204	n64	io_cancel			sys_io_cancel
 205	n64	exit_group			sys_exit_group
-206	n64	lookup_dcookie			sys_lookup_dcookie
+206	n64	lookup_dcookie			sys_ni_syscall
 207	n64	epoll_create			sys_epoll_create
 208	n64	epoll_ctl			sys_epoll_ctl
 209	n64	epoll_wait			sys_epoll_wait
@@ -357,7 +357,23 @@
 440	n64	process_madvise			sys_process_madvise
 441	n64	epoll_pwait2			sys_epoll_pwait2
 442	n64	mount_setattr			sys_mount_setattr
-# 443 reserved for quotactl_path
+443	n64	quotactl_fd			sys_quotactl_fd
 444	n64	landlock_create_ruleset		sys_landlock_create_ruleset
 445	n64	landlock_add_rule		sys_landlock_add_rule
 446	n64	landlock_restrict_self		sys_landlock_restrict_self
+# 447 reserved for memfd_secret
+448	n64	process_mrelease		sys_process_mrelease
+449	n64	futex_waitv			sys_futex_waitv
+450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	n64	cachestat			sys_cachestat
+452	n64	fchmodat2			sys_fchmodat2
+453	n64	map_shadow_stack		sys_map_shadow_stack
+454	n64	futex_wake			sys_futex_wake
+455	n64	futex_wait			sys_futex_wait
+456	n64	futex_requeue			sys_futex_requeue
+457	n64	statmount			sys_statmount
+458	n64	listmount			sys_listmount
+459	n64	lsm_get_self_attr		sys_lsm_get_self_attr
+460	n64	lsm_set_self_attr		sys_lsm_set_self_attr
+461	n64	lsm_list_modules		sys_lsm_list_modules
+462	n64	mseal				sys_mseal
diff --git a/linux-user/ppc/syscall.tbl b/linux-user/ppc/syscall.tbl
index 8f052ff4058c..ebae8415dfbb 100644
--- a/linux-user/ppc/syscall.tbl
+++ b/linux-user/ppc/syscall.tbl
@@ -110,7 +110,7 @@
 79	common	settimeofday			sys_settimeofday		compat_sys_settimeofday
 80	common	getgroups			sys_getgroups
 81	common	setgroups			sys_setgroups
-82	32	select				ppc_select			sys_ni_syscall
+82	32	select				sys_old_select			compat_sys_old_select
 82	64	select				sys_ni_syscall
 82	spu	select				sys_ni_syscall
 83	common	symlink				sys_symlink
@@ -176,11 +176,11 @@
 131	nospu	quotactl			sys_quotactl
 132	common	getpgid				sys_getpgid
 133	common	fchdir				sys_fchdir
-134	common	bdflush				sys_bdflush
+134	common	bdflush				sys_ni_syscall
 135	common	sysfs				sys_sysfs
-136	32	personality			sys_personality			ppc64_personality
-136	64	personality			ppc64_personality
-136	spu	personality			ppc64_personality
+136	32	personality			sys_personality			compat_sys_ppc64_personality
+136	64	personality			sys_ppc64_personality
+136	spu	personality			sys_ppc64_personality
 137	common	afs_syscall			sys_ni_syscall
 138	common	setfsuid			sys_setfsuid
 139	common	setfsgid			sys_setfsgid
@@ -228,8 +228,12 @@
 176	64	rt_sigtimedwait			sys_rt_sigtimedwait
 177	nospu 	rt_sigqueueinfo			sys_rt_sigqueueinfo		compat_sys_rt_sigqueueinfo
 178	nospu 	rt_sigsuspend			sys_rt_sigsuspend		compat_sys_rt_sigsuspend
-179	common	pread64				sys_pread64			compat_sys_pread64
-180	common	pwrite64			sys_pwrite64			compat_sys_pwrite64
+179	32	pread64				sys_ppc_pread64			compat_sys_ppc_pread64
+179	64	pread64				sys_pread64
+179	spu	pread64				sys_pread64
+180	32	pwrite64			sys_ppc_pwrite64		compat_sys_ppc_pwrite64
+180	64	pwrite64			sys_pwrite64
+180	spu	pwrite64			sys_pwrite64
 181	common	chown				sys_chown
 182	common	getcwd				sys_getcwd
 183	common	capget				sys_capget
@@ -242,10 +246,12 @@
 188	common 	putpmsg				sys_ni_syscall
 189	nospu	vfork				sys_vfork
 190	common	ugetrlimit			sys_getrlimit			compat_sys_getrlimit
-191	common	readahead			sys_readahead			compat_sys_readahead
+191	32	readahead			sys_ppc_readahead		compat_sys_ppc_readahead
+191	64	readahead			sys_readahead
+191	spu	readahead			sys_readahead
 192	32	mmap2				sys_mmap2			compat_sys_mmap2
-193	32	truncate64			sys_truncate64			compat_sys_truncate64
-194	32	ftruncate64			sys_ftruncate64			compat_sys_ftruncate64
+193	32	truncate64			sys_ppc_truncate64		compat_sys_ppc_truncate64
+194	32	ftruncate64			sys_ppc_ftruncate64		compat_sys_ppc_ftruncate64
 195	32	stat64				sys_stat64
 196	32	lstat64				sys_lstat64
 197	32	fstat64				sys_fstat64
@@ -288,9 +294,11 @@
 230	common	io_submit			sys_io_submit			compat_sys_io_submit
 231	common	io_cancel			sys_io_cancel
 232	nospu	set_tid_address			sys_set_tid_address
-233	common	fadvise64			sys_fadvise64			ppc32_fadvise64
+233	32	fadvise64			sys_ppc32_fadvise64		compat_sys_ppc32_fadvise64
+233	64	fadvise64			sys_fadvise64
+233	spu	fadvise64			sys_fadvise64
 234	nospu	exit_group			sys_exit_group
-235	nospu	lookup_dcookie			sys_lookup_dcookie		compat_sys_lookup_dcookie
+235	nospu	lookup_dcookie			sys_ni_syscall
 236	common	epoll_create			sys_epoll_create
 237	common	epoll_ctl			sys_epoll_ctl
 238	common	epoll_wait			sys_epoll_wait
@@ -323,17 +331,17 @@
 251	spu	utimes				sys_utimes
 252	common	statfs64			sys_statfs64			compat_sys_statfs64
 253	common	fstatfs64			sys_fstatfs64			compat_sys_fstatfs64
-254	32	fadvise64_64			ppc_fadvise64_64
+254	32	fadvise64_64			sys_ppc_fadvise64_64
 254	spu	fadvise64_64			sys_ni_syscall
 255	common	rtas				sys_rtas
 256	32	sys_debug_setcontext		sys_debug_setcontext		sys_ni_syscall
 256	64	sys_debug_setcontext		sys_ni_syscall
 256	spu	sys_debug_setcontext		sys_ni_syscall
 # 257 reserved for vserver
-258	nospu	migrate_pages			sys_migrate_pages		compat_sys_migrate_pages
-259	nospu	mbind				sys_mbind			compat_sys_mbind
-260	nospu	get_mempolicy			sys_get_mempolicy		compat_sys_get_mempolicy
-261	nospu	set_mempolicy			sys_set_mempolicy		compat_sys_set_mempolicy
+258	nospu	migrate_pages			sys_migrate_pages
+259	nospu	mbind				sys_mbind
+260	nospu	get_mempolicy			sys_get_mempolicy
+261	nospu	set_mempolicy			sys_set_mempolicy
 262	nospu	mq_open				sys_mq_open			compat_sys_mq_open
 263	nospu	mq_unlink			sys_mq_unlink
 264	32	mq_timedsend			sys_mq_timedsend_time32
@@ -381,7 +389,7 @@
 298	common	faccessat			sys_faccessat
 299	common	get_robust_list			sys_get_robust_list		compat_sys_get_robust_list
 300	common	set_robust_list			sys_set_robust_list		compat_sys_set_robust_list
-301	common	move_pages			sys_move_pages			compat_sys_move_pages
+301	common	move_pages			sys_move_pages
 302	common	getcpu				sys_getcpu
 303	nospu	epoll_pwait			sys_epoll_pwait			compat_sys_epoll_pwait
 304	32	utimensat			sys_utimensat_time32
@@ -390,8 +398,11 @@
 305	common	signalfd			sys_signalfd			compat_sys_signalfd
 306	common	timerfd_create			sys_timerfd_create
 307	common	eventfd				sys_eventfd
-308	common	sync_file_range2		sys_sync_file_range2		compat_sys_sync_file_range2
-309	nospu	fallocate			sys_fallocate			compat_sys_fallocate
+308	32	sync_file_range2		sys_ppc_sync_file_range2	compat_sys_ppc_sync_file_range2
+308	64	sync_file_range2		sys_sync_file_range2
+308	spu	sync_file_range2		sys_sync_file_range2
+309	32	fallocate			sys_ppc_fallocate		compat_sys_fallocate
+309	64	fallocate			sys_fallocate
 310	nospu	subpage_prot			sys_subpage_prot
 311	32	timerfd_settime			sys_timerfd_settime32
 311	64	timerfd_settime			sys_timerfd_settime
@@ -495,7 +506,7 @@
 412	32	utimensat_time64		sys_utimensat			sys_utimensat
 413	32	pselect6_time64			sys_pselect6			compat_sys_pselect6_time64
 414	32	ppoll_time64			sys_ppoll			compat_sys_ppoll_time64
-416	32	io_pgetevents_time64		sys_io_pgetevents		sys_io_pgetevents
+416	32	io_pgetevents_time64		sys_io_pgetevents		compat_sys_io_pgetevents_time64
 417	32	recvmmsg_time64			sys_recvmmsg			compat_sys_recvmmsg_time64
 418	32	mq_timedsend_time64		sys_mq_timedsend		sys_mq_timedsend
 419	32	mq_timedreceive_time64		sys_mq_timedreceive		sys_mq_timedreceive
@@ -522,7 +533,23 @@
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2		compat_sys_epoll_pwait2
 442	common	mount_setattr			sys_mount_setattr
-# 443 reserved for quotactl_path
+443	common	quotactl_fd			sys_quotactl_fd
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
+# 447 reserved for memfd_secret
+448	common	process_mrelease		sys_process_mrelease
+449	common  futex_waitv                     sys_futex_waitv
+450 	nospu	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	cachestat			sys_cachestat
+452	common	fchmodat2			sys_fchmodat2
+453	common	map_shadow_stack		sys_ni_syscall
+454	common	futex_wake			sys_futex_wake
+455	common	futex_wait			sys_futex_wait
+456	common	futex_requeue			sys_futex_requeue
+457	common	statmount			sys_statmount
+458	common	listmount			sys_listmount
+459	common	lsm_get_self_attr		sys_lsm_get_self_attr
+460	common	lsm_set_self_attr		sys_lsm_set_self_attr
+461	common	lsm_list_modules		sys_lsm_list_modules
+462	common	mseal				sys_mseal
diff --git a/linux-user/s390x/syscall.tbl b/linux-user/s390x/syscall.tbl
index 0690263df1dd..01071182763e 100644
--- a/linux-user/s390x/syscall.tbl
+++ b/linux-user/s390x/syscall.tbl
@@ -100,7 +100,7 @@
 106  common	stat			sys_newstat			compat_sys_newstat
 107  common	lstat			sys_newlstat			compat_sys_newlstat
 108  common	fstat			sys_newfstat			compat_sys_newfstat
-110  common	lookup_dcookie		sys_lookup_dcookie		compat_sys_lookup_dcookie
+110  common	lookup_dcookie		-				-
 111  common	vhangup			sys_vhangup			sys_vhangup
 112  common	idle			-				-
 114  common	wait4			sys_wait4			compat_sys_wait4
@@ -122,7 +122,7 @@
 131  common	quotactl		sys_quotactl			sys_quotactl
 132  common	getpgid			sys_getpgid			sys_getpgid
 133  common	fchdir			sys_fchdir			sys_fchdir
-134  common	bdflush			sys_bdflush			sys_bdflush
+134  common	bdflush			sys_ni_syscall			sys_ni_syscall
 135  common	sysfs			sys_sysfs			sys_sysfs
 136  common	personality		sys_s390_personality		sys_s390_personality
 137  common	afs_syscall		-				-
@@ -274,9 +274,9 @@
 265  common	statfs64		sys_statfs64			compat_sys_statfs64
 266  common	fstatfs64		sys_fstatfs64			compat_sys_fstatfs64
 267  common	remap_file_pages	sys_remap_file_pages		sys_remap_file_pages
-268  common	mbind			sys_mbind			compat_sys_mbind
-269  common	get_mempolicy		sys_get_mempolicy		compat_sys_get_mempolicy
-270  common	set_mempolicy		sys_set_mempolicy		compat_sys_set_mempolicy
+268  common	mbind			sys_mbind			sys_mbind
+269  common	get_mempolicy		sys_get_mempolicy		sys_get_mempolicy
+270  common	set_mempolicy		sys_set_mempolicy		sys_set_mempolicy
 271  common	mq_open			sys_mq_open			compat_sys_mq_open
 272  common	mq_unlink		sys_mq_unlink			sys_mq_unlink
 273  common	mq_timedsend		sys_mq_timedsend		sys_mq_timedsend_time32
@@ -293,7 +293,7 @@
 284  common	inotify_init		sys_inotify_init		sys_inotify_init
 285  common	inotify_add_watch	sys_inotify_add_watch		sys_inotify_add_watch
 286  common	inotify_rm_watch	sys_inotify_rm_watch		sys_inotify_rm_watch
-287  common	migrate_pages		sys_migrate_pages		compat_sys_migrate_pages
+287  common	migrate_pages		sys_migrate_pages		sys_migrate_pages
 288  common	openat			sys_openat			compat_sys_openat
 289  common	mkdirat			sys_mkdirat			sys_mkdirat
 290  common	mknodat			sys_mknodat			sys_mknodat
@@ -317,7 +317,7 @@
 307  common	sync_file_range		sys_sync_file_range		compat_sys_s390_sync_file_range
 308  common	tee			sys_tee				sys_tee
 309  common	vmsplice		sys_vmsplice			sys_vmsplice
-310  common	move_pages		sys_move_pages			compat_sys_move_pages
+310  common	move_pages		sys_move_pages			sys_move_pages
 311  common	getcpu			sys_getcpu			sys_getcpu
 312  common	epoll_pwait		sys_epoll_pwait			compat_sys_epoll_pwait
 313  common	utimes			sys_utimes			sys_utimes_time32
@@ -418,7 +418,7 @@
 412	32	utimensat_time64	-				sys_utimensat
 413	32	pselect6_time64		-				compat_sys_pselect6_time64
 414	32	ppoll_time64		-				compat_sys_ppoll_time64
-416	32	io_pgetevents_time64	-				sys_io_pgetevents
+416	32	io_pgetevents_time64	-				compat_sys_io_pgetevents_time64
 417	32	recvmmsg_time64		-				compat_sys_recvmmsg_time64
 418	32	mq_timedsend_time64	-				sys_mq_timedsend
 419	32	mq_timedreceive_time64	-				sys_mq_timedreceive
@@ -445,7 +445,23 @@
 440  common	process_madvise		sys_process_madvise		sys_process_madvise
 441  common	epoll_pwait2		sys_epoll_pwait2		compat_sys_epoll_pwait2
 442  common	mount_setattr		sys_mount_setattr		sys_mount_setattr
-# 443 reserved for quotactl_path
+443  common	quotactl_fd		sys_quotactl_fd			sys_quotactl_fd
 444  common	landlock_create_ruleset	sys_landlock_create_ruleset	sys_landlock_create_ruleset
 445  common	landlock_add_rule	sys_landlock_add_rule		sys_landlock_add_rule
 446  common	landlock_restrict_self	sys_landlock_restrict_self	sys_landlock_restrict_self
+447  common	memfd_secret		sys_memfd_secret		sys_memfd_secret
+448  common	process_mrelease	sys_process_mrelease		sys_process_mrelease
+449  common	futex_waitv		sys_futex_waitv			sys_futex_waitv
+450  common	set_mempolicy_home_node	sys_set_mempolicy_home_node	sys_set_mempolicy_home_node
+451  common	cachestat		sys_cachestat			sys_cachestat
+452  common	fchmodat2		sys_fchmodat2			sys_fchmodat2
+453  common	map_shadow_stack	sys_map_shadow_stack		sys_map_shadow_stack
+454  common	futex_wake		sys_futex_wake			sys_futex_wake
+455  common	futex_wait		sys_futex_wait			sys_futex_wait
+456  common	futex_requeue		sys_futex_requeue		sys_futex_requeue
+457  common	statmount		sys_statmount			sys_statmount
+458  common	listmount		sys_listmount			sys_listmount
+459  common	lsm_get_self_attr	sys_lsm_get_self_attr		sys_lsm_get_self_attr
+460  common	lsm_set_self_attr	sys_lsm_set_self_attr		sys_lsm_set_self_attr
+461  common	lsm_list_modules	sys_lsm_list_modules		sys_lsm_list_modules
+462  common	mseal			sys_mseal			sys_mseal
diff --git a/linux-user/sh4/syscall.tbl b/linux-user/sh4/syscall.tbl
index 0b91499ebdcf..c55fd7696d40 100644
--- a/linux-user/sh4/syscall.tbl
+++ b/linux-user/sh4/syscall.tbl
@@ -141,7 +141,7 @@
 131	common	quotactl			sys_quotactl
 132	common	getpgid				sys_getpgid
 133	common	fchdir				sys_fchdir
-134	common	bdflush				sys_bdflush
+134	common	bdflush				sys_ni_syscall
 135	common	sysfs				sys_sysfs
 136	common	personality			sys_personality
 # 137 was afs_syscall
@@ -260,7 +260,7 @@
 250	common	fadvise64			sys_fadvise64
 # 251 is unused
 252	common	exit_group			sys_exit_group
-253	common	lookup_dcookie			sys_lookup_dcookie
+253	common	lookup_dcookie			sys_ni_syscall
 254	common	epoll_create			sys_epoll_create
 255	common	epoll_ctl			sys_epoll_ctl
 256	common	epoll_wait			sys_epoll_wait
@@ -321,7 +321,7 @@
 311	common	set_robust_list			sys_set_robust_list
 312	common	get_robust_list			sys_get_robust_list
 313	common	splice				sys_splice
-314	common	sync_file_range			sys_sync_file_range
+314	common	sync_file_range			sys_sh_sync_file_range6
 315	common	tee				sys_tee
 316	common	vmsplice			sys_vmsplice
 317	common	move_pages			sys_move_pages
@@ -395,6 +395,7 @@
 385	common	pkey_alloc			sys_pkey_alloc
 386	common	pkey_free			sys_pkey_free
 387	common	rseq				sys_rseq
+388	common	sync_file_range2		sys_sync_file_range2
 # room for arch specific syscalls
 393	common	semget				sys_semget
 394	common	semctl				sys_semctl
@@ -445,7 +446,23 @@
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2
 442	common	mount_setattr			sys_mount_setattr
-# 443 reserved for quotactl_path
+443	common	quotactl_fd			sys_quotactl_fd
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
+# 447 reserved for memfd_secret
+448	common	process_mrelease		sys_process_mrelease
+449	common  futex_waitv                     sys_futex_waitv
+450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	cachestat			sys_cachestat
+452	common	fchmodat2			sys_fchmodat2
+453	common	map_shadow_stack		sys_map_shadow_stack
+454	common	futex_wake			sys_futex_wake
+455	common	futex_wait			sys_futex_wait
+456	common	futex_requeue			sys_futex_requeue
+457	common	statmount			sys_statmount
+458	common	listmount			sys_listmount
+459	common	lsm_get_self_attr		sys_lsm_get_self_attr
+460	common	lsm_set_self_attr		sys_lsm_set_self_attr
+461	common	lsm_list_modules		sys_lsm_list_modules
+462	common	mseal				sys_mseal
diff --git a/linux-user/sparc/syscall.tbl b/linux-user/sparc/syscall.tbl
index e34cc30ef22c..cfdfb3707c16 100644
--- a/linux-user/sparc/syscall.tbl
+++ b/linux-user/sparc/syscall.tbl
@@ -117,7 +117,7 @@
 90	common	dup2			sys_dup2
 91	32	setfsuid32		sys_setfsuid
 92	common	fcntl			sys_fcntl			compat_sys_fcntl
-93	common	select			sys_select
+93	common	select			sys_select			compat_sys_select
 94	32	setfsgid32		sys_setfsgid
 95	common	fsync			sys_fsync
 96	common	setpriority		sys_setpriority
@@ -155,7 +155,7 @@
 123	32	fchown			sys_fchown16
 123	64	fchown			sys_fchown
 124	common	fchmod			sys_fchmod
-125	common	recvfrom		sys_recvfrom
+125	common	recvfrom		sys_recvfrom			compat_sys_recvfrom
 126	32	setreuid		sys_setreuid16
 126	64	setreuid		sys_setreuid
 127	32	setregid		sys_setregid16
@@ -247,9 +247,9 @@
 204	32	readdir			sys_old_readdir			compat_sys_old_readdir
 204	64	readdir			sys_nis_syscall
 205	common	readahead		sys_readahead			compat_sys_readahead
-206	common	socketcall		sys_socketcall			sys32_socketcall
+206	common	socketcall		sys_socketcall			compat_sys_socketcall
 207	common	syslog			sys_syslog
-208	common	lookup_dcookie		sys_lookup_dcookie		compat_sys_lookup_dcookie
+208	common	lookup_dcookie		sys_ni_syscall
 209	common	fadvise64		sys_fadvise64			compat_sys_fadvise64
 210	common	fadvise64_64		sys_fadvise64_64		compat_sys_fadvise64_64
 211	common	tgkill			sys_tgkill
@@ -270,7 +270,7 @@
 222	common	delete_module		sys_delete_module
 223	common	get_kernel_syms		sys_ni_syscall
 224	common	getpgid			sys_getpgid
-225	common	bdflush			sys_bdflush
+225	common	bdflush			sys_ni_syscall
 226	common	sysfs			sys_sysfs
 227	common	afs_syscall		sys_nis_syscall
 228	common	setfsuid		sys_setfsuid16
@@ -365,12 +365,12 @@
 299	common	unshare			sys_unshare
 300	common	set_robust_list		sys_set_robust_list		compat_sys_set_robust_list
 301	common	get_robust_list		sys_get_robust_list		compat_sys_get_robust_list
-302	common	migrate_pages		sys_migrate_pages		compat_sys_migrate_pages
-303	common	mbind			sys_mbind			compat_sys_mbind
-304	common	get_mempolicy		sys_get_mempolicy		compat_sys_get_mempolicy
-305	common	set_mempolicy		sys_set_mempolicy		compat_sys_set_mempolicy
+302	common	migrate_pages		sys_migrate_pages
+303	common	mbind			sys_mbind
+304	common	get_mempolicy		sys_get_mempolicy
+305	common	set_mempolicy		sys_set_mempolicy
 306	common	kexec_load		sys_kexec_load			compat_sys_kexec_load
-307	common	move_pages		sys_move_pages			compat_sys_move_pages
+307	common	move_pages		sys_move_pages
 308	common	getcpu			sys_getcpu
 309	common	epoll_pwait		sys_epoll_pwait			compat_sys_epoll_pwait
 310	32	utimensat		sys_utimensat_time32
@@ -461,7 +461,7 @@
 412	32	utimensat_time64		sys_utimensat			sys_utimensat
 413	32	pselect6_time64			sys_pselect6			compat_sys_pselect6_time64
 414	32	ppoll_time64			sys_ppoll			compat_sys_ppoll_time64
-416	32	io_pgetevents_time64		sys_io_pgetevents		sys_io_pgetevents
+416	32	io_pgetevents_time64		sys_io_pgetevents		compat_sys_io_pgetevents_time64
 417	32	recvmmsg_time64			sys_recvmmsg			compat_sys_recvmmsg_time64
 418	32	mq_timedsend_time64		sys_mq_timedsend		sys_mq_timedsend
 419	32	mq_timedreceive_time64		sys_mq_timedreceive		sys_mq_timedreceive
@@ -488,7 +488,23 @@
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2		compat_sys_epoll_pwait2
 442	common	mount_setattr			sys_mount_setattr
-# 443 reserved for quotactl_path
+443	common	quotactl_fd			sys_quotactl_fd
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
+# 447 reserved for memfd_secret
+448	common	process_mrelease		sys_process_mrelease
+449	common  futex_waitv                     sys_futex_waitv
+450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	cachestat			sys_cachestat
+452	common	fchmodat2			sys_fchmodat2
+453	common	map_shadow_stack		sys_map_shadow_stack
+454	common	futex_wake			sys_futex_wake
+455	common	futex_wait			sys_futex_wait
+456	common	futex_requeue			sys_futex_requeue
+457	common	statmount			sys_statmount
+458	common	listmount			sys_listmount
+459	common	lsm_get_self_attr		sys_lsm_get_self_attr
+460	common	lsm_set_self_attr		sys_lsm_set_self_attr
+461	common	lsm_list_modules		sys_lsm_list_modules
+462	common	mseal 				sys_mseal
diff --git a/linux-user/x86_64/syscall_64.tbl b/linux-user/x86_64/syscall_64.tbl
index ce18119ea0d0..a396f6e6ab5b 100644
--- a/linux-user/x86_64/syscall_64.tbl
+++ b/linux-user/x86_64/syscall_64.tbl
@@ -220,7 +220,7 @@
 209	64	io_submit		sys_io_submit
 210	common	io_cancel		sys_io_cancel
 211	64	get_thread_area
-212	common	lookup_dcookie		sys_lookup_dcookie
+212	common	lookup_dcookie
 213	common	epoll_create		sys_epoll_create
 214	64	epoll_ctl_old
 215	64	epoll_wait_old
@@ -364,10 +364,26 @@
 440	common	process_madvise		sys_process_madvise
 441	common	epoll_pwait2		sys_epoll_pwait2
 442	common	mount_setattr		sys_mount_setattr
-# 443 reserved for quotactl_path
+443	common	quotactl_fd		sys_quotactl_fd
 444	common	landlock_create_ruleset	sys_landlock_create_ruleset
 445	common	landlock_add_rule	sys_landlock_add_rule
 446	common	landlock_restrict_self	sys_landlock_restrict_self
+447	common	memfd_secret		sys_memfd_secret
+448	common	process_mrelease	sys_process_mrelease
+449	common	futex_waitv		sys_futex_waitv
+450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
+451	common	cachestat		sys_cachestat
+452	common	fchmodat2		sys_fchmodat2
+453	common	map_shadow_stack	sys_map_shadow_stack
+454	common	futex_wake		sys_futex_wake
+455	common	futex_wait		sys_futex_wait
+456	common	futex_requeue		sys_futex_requeue
+457	common	statmount		sys_statmount
+458	common	listmount		sys_listmount
+459	common	lsm_get_self_attr	sys_lsm_get_self_attr
+460	common	lsm_set_self_attr	sys_lsm_set_self_attr
+461	common	lsm_list_modules	sys_lsm_list_modules
+462 	common  mseal			sys_mseal
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
@@ -396,7 +412,7 @@
 530	x32	set_robust_list		compat_sys_set_robust_list
 531	x32	get_robust_list		compat_sys_get_robust_list
 532	x32	vmsplice		sys_vmsplice
-533	x32	move_pages		compat_sys_move_pages
+533	x32	move_pages		sys_move_pages
 534	x32	preadv			compat_sys_preadv64
 535	x32	pwritev			compat_sys_pwritev64
 536	x32	rt_tgsigqueueinfo	compat_sys_rt_tgsigqueueinfo
diff --git a/linux-user/xtensa/syscall.tbl b/linux-user/xtensa/syscall.tbl
index fd2f30227d96..67083fc1b2f5 100644
--- a/linux-user/xtensa/syscall.tbl
+++ b/linux-user/xtensa/syscall.tbl
@@ -223,7 +223,7 @@
 # 205 was old nfsservctl
 205	common	nfsservctl			sys_ni_syscall
 206	common	_sysctl				sys_ni_syscall
-207	common	bdflush				sys_bdflush
+207	common	bdflush				sys_ni_syscall
 208	common	uname				sys_newuname
 209	common	sysinfo				sys_sysinfo
 210	common	init_module			sys_init_module
@@ -273,7 +273,7 @@
 252	common	timer_getoverrun		sys_timer_getoverrun
 # System
 253	common	reserved253			sys_ni_syscall
-254	common	lookup_dcookie			sys_lookup_dcookie
+254	common	lookup_dcookie			sys_ni_syscall
 255	common	available255			sys_ni_syscall
 256	common	add_key				sys_add_key
 257	common	request_key			sys_request_key
@@ -413,7 +413,23 @@
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2
 442	common	mount_setattr			sys_mount_setattr
-# 443 reserved for quotactl_path
+443	common	quotactl_fd			sys_quotactl_fd
 444	common	landlock_create_ruleset		sys_landlock_create_ruleset
 445	common	landlock_add_rule		sys_landlock_add_rule
 446	common	landlock_restrict_self		sys_landlock_restrict_self
+# 447 reserved for memfd_secret
+448	common	process_mrelease		sys_process_mrelease
+449	common  futex_waitv                     sys_futex_waitv
+450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	cachestat			sys_cachestat
+452	common	fchmodat2			sys_fchmodat2
+453	common	map_shadow_stack		sys_map_shadow_stack
+454	common	futex_wake			sys_futex_wake
+455	common	futex_wait			sys_futex_wait
+456	common	futex_requeue			sys_futex_requeue
+457	common	statmount			sys_statmount
+458	common	listmount			sys_listmount
+459	common	lsm_get_self_attr		sys_lsm_get_self_attr
+460	common	lsm_set_self_attr		sys_lsm_set_self_attr
+461	common	lsm_list_modules		sys_lsm_list_modules
+462	common	mseal 				sys_mseal
-- 
2.46.0


