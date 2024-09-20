Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12AE5CF9C41
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 15:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srfHq-0002aF-Os; Fri, 20 Sep 2024 11:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1srfHf-00026v-Tc; Fri, 20 Sep 2024 11:11:00 -0400
Received: from mout.kundenserver.de ([217.72.192.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1srfHc-0003nI-8P; Fri, 20 Sep 2024 11:10:59 -0400
Received: from quad ([82.64.211.94]) by mrelayeu.kundenserver.de (mreue109
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1M9npT-1sug5T0n1J-005aMt; Fri, 20
 Sep 2024 17:10:38 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Brian Cain <bcain@quicinc.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Weiwei Li <liwei1518@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Bin Meng <bmeng.cn@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 4/6] linux-user,hexagon: move to syscalltbl file
Date: Fri, 20 Sep 2024 17:10:32 +0200
Message-ID: <20240920151034.859533-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240920151034.859533-1-laurent@vivier.eu>
References: <20240920151034.859533-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:OiJFNgmJf9JYW/7j6LD4SUMPblhGxvculbyGbQjXOdUeQYkoPCR
 wozOBnloBjwZK3ipyODaT9d+74tySySjQg7orPBvSd7MIQSOLoCECoo0bd2XVdL/qEouAG+
 pWLwuay5pfbN+lOjXj280R8yovGhj4svov9rzsYRE3PyUfIcRrT4Ew+wOoFUhYJFG+wlsSw
 gQZQG9k5/gIASEhxWlm6A==
UI-OutboundReport: notjunk:1;M01:P0:UBYmkT8Z4Mk=;L79a8GZrgqFinqQ04mV+RfwVp6X
 eLBi/HwiP0vfWuOMeNv7QkWqESxLgj12YjPA3yXaT5GyAQps2lDfv0wh7HxlgFMN8NHQTYDEN
 ySfpjZtklGfqJ42lwGzNXJGb19urn0BbqzqI8TmIpHu8N20ERvTSpnD6sJWrAEXqgY+8AHXsD
 NC2KyNTnQ3SmnwCMF4DCJ0igN+J3fs8IIdTaklOj7nz6tV7ITUXwk5zh206cds4BglYK1ycX0
 UbUy2nzk7f7C+W63hE1y/j9Jj2n55faHBju+TwlmDviLpPxqeT4ds3sGotwS5Y5CTYb4YfJ3k
 NoJwzijrGLZ1O/bbx8+YFiOQJZW2HWASit78yLz1nUlZ5cYl714Zfrmerl7c5oPYROW4KNSIW
 GyBoZNw252SH2v5X4vQ6s7s6Z9Nz4xtwm9KJYYCrXlkIIJFoLab83D9oB8Gz3o5uRtPKppXgr
 KsIBf35ye45oPWrrp+bNkuAaMIYnZgDG4l5CSMrwWQFhFrULmhQXWSkfdwG0Lr/qFEymJtFZv
 PezipOMT0HeZW6dCk2E8jvP3Rr6FJ5YeCpWl9kWRUXhXOou8IIsSVgMQIoMcl3pa09TYmw7U2
 yNh1TdZfKjiJ56hjUOBo9vuqbFA1XDGRFvl9yt0CBs/dr7ZqatbkFQG0Cv6yrN4xkRvmG0Q1l
 X2uVsacI91VFsMRnGkehkSo9+ylg9A95yLcd16v2jVndZyuiQz4ji8Y20xSNfpnqt5xHgX6GA
 58FC/3tAbLRBwHyNzOhk5drW+OJBxr9tg==
Received-SPF: pass client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
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

Since kernel v6.11 hexagon has moved from syscall_nr.h file
to syscall.tbl (36d69c29759e ("hexagon: use new system call table"))

Update linux-user scripts to be able to retrieve syscall numbers
from linux syscall.tbl instead of syscall_nr.h.
New syscall.tbl is imported from linux v6.11 using updated
scripts/update-syscalltbl.sh

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 configs/targets/hexagon-linux-user.mak |   2 +
 linux-user/hexagon/meson.build         |   6 +
 linux-user/hexagon/syscall.tbl         | 405 +++++++++++++++++++++++++
 linux-user/hexagon/syscall_nr.h        | 348 ---------------------
 linux-user/hexagon/syscallhdr.sh       |  28 ++
 linux-user/meson.build                 |   1 +
 scripts/gensyscalls.sh                 |   1 -
 scripts/update-syscalltbl.sh           |   1 +
 8 files changed, 443 insertions(+), 349 deletions(-)
 create mode 100644 linux-user/hexagon/meson.build
 create mode 100644 linux-user/hexagon/syscall.tbl
 delete mode 100644 linux-user/hexagon/syscall_nr.h
 create mode 100644 linux-user/hexagon/syscallhdr.sh

diff --git a/configs/targets/hexagon-linux-user.mak b/configs/targets/hexagon-linux-user.mak
index 2765a4c5638d..b912045bd307 100644
--- a/configs/targets/hexagon-linux-user.mak
+++ b/configs/targets/hexagon-linux-user.mak
@@ -1,2 +1,4 @@
 TARGET_ARCH=hexagon
 TARGET_XML_FILES=gdb-xml/hexagon-core.xml gdb-xml/hexagon-hvx.xml
+TARGET_SYSTBL=syscall.tbl
+TARGET_SYSTBL_ABI=common,32,hexagon,time32,stat64,rlimit,renameat
diff --git a/linux-user/hexagon/meson.build b/linux-user/hexagon/meson.build
new file mode 100644
index 000000000000..d203c3ec9296
--- /dev/null
+++ b/linux-user/hexagon/meson.build
@@ -0,0 +1,6 @@
+
+syscall_nr_generators += {
+  'hexagon': generator(sh,
+                      arguments: [ meson.current_source_dir() / 'syscallhdr.sh', '@INPUT@', '@OUTPUT@', '@EXTRA_ARGS@' ],
+                      output: '@BASENAME@_nr.h')
+}
diff --git a/linux-user/hexagon/syscall.tbl b/linux-user/hexagon/syscall.tbl
new file mode 100644
index 000000000000..845e24eb372e
--- /dev/null
+++ b/linux-user/hexagon/syscall.tbl
@@ -0,0 +1,405 @@
+# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+#
+# This file contains the system call numbers for all of the
+# more recently added architectures.
+#
+# As a basic principle, no duplication of functionality
+# should be added, e.g. we don't use lseek when llseek
+# is present. New architectures should use this file
+# and implement the less feature-full calls in user space.
+#
+0	common	io_setup			sys_io_setup			compat_sys_io_setup
+1	common	io_destroy			sys_io_destroy
+2	common	io_submit			sys_io_submit			compat_sys_io_submit
+3	common	io_cancel			sys_io_cancel
+4	time32	io_getevents			sys_io_getevents_time32
+4	64	io_getevents			sys_io_getevents
+5	common	setxattr			sys_setxattr
+6	common	lsetxattr			sys_lsetxattr
+7	common	fsetxattr			sys_fsetxattr
+8	common	getxattr			sys_getxattr
+9	common	lgetxattr			sys_lgetxattr
+10	common	fgetxattr			sys_fgetxattr
+11	common	listxattr			sys_listxattr
+12	common	llistxattr			sys_llistxattr
+13	common	flistxattr			sys_flistxattr
+14	common	removexattr			sys_removexattr
+15	common	lremovexattr			sys_lremovexattr
+16	common	fremovexattr			sys_fremovexattr
+17	common	getcwd				sys_getcwd
+18	common	lookup_dcookie			sys_ni_syscall
+19	common	eventfd2			sys_eventfd2
+20	common	epoll_create1			sys_epoll_create1
+21	common	epoll_ctl			sys_epoll_ctl
+22	common	epoll_pwait			sys_epoll_pwait			compat_sys_epoll_pwait
+23	common	dup				sys_dup
+24	common	dup3				sys_dup3
+25	32	fcntl64				sys_fcntl64			compat_sys_fcntl64
+25	64	fcntl				sys_fcntl
+26	common	inotify_init1			sys_inotify_init1
+27	common	inotify_add_watch		sys_inotify_add_watch
+28	common	inotify_rm_watch		sys_inotify_rm_watch
+29	common	ioctl				sys_ioctl			compat_sys_ioctl
+30	common	ioprio_set			sys_ioprio_set
+31	common	ioprio_get			sys_ioprio_get
+32	common	flock				sys_flock
+33	common	mknodat				sys_mknodat
+34	common	mkdirat				sys_mkdirat
+35	common	unlinkat			sys_unlinkat
+36	common	symlinkat			sys_symlinkat
+37	common	linkat				sys_linkat
+# renameat is superseded with flags by renameat2
+38	renameat renameat			sys_renameat
+39	common	umount2				sys_umount
+40	common	mount				sys_mount
+41	common	pivot_root			sys_pivot_root
+42	common	nfsservctl			sys_ni_syscall
+43	32	statfs64			sys_statfs64			compat_sys_statfs64
+43	64	statfs				sys_statfs
+44	32	fstatfs64			sys_fstatfs64			compat_sys_fstatfs64
+44	64	fstatfs				sys_fstatfs
+45	32	truncate64			sys_truncate64			compat_sys_truncate64
+45	64	truncate			sys_truncate
+46	32	ftruncate64			sys_ftruncate64			compat_sys_ftruncate64
+46	64	ftruncate			sys_ftruncate
+47	common	fallocate			sys_fallocate			compat_sys_fallocate
+48	common	faccessat			sys_faccessat
+49	common	chdir				sys_chdir
+50	common	fchdir				sys_fchdir
+51	common	chroot				sys_chroot
+52	common	fchmod				sys_fchmod
+53	common	fchmodat			sys_fchmodat
+54	common	fchownat			sys_fchownat
+55	common	fchown				sys_fchown
+56	common	openat				sys_openat
+57	common	close				sys_close
+58	common	vhangup				sys_vhangup
+59	common	pipe2				sys_pipe2
+60	common	quotactl			sys_quotactl
+61	common	getdents64			sys_getdents64
+62	32	llseek				sys_llseek
+62	64	lseek				sys_lseek
+63	common	read				sys_read
+64	common	write				sys_write
+65	common	readv				sys_readv			sys_readv
+66	common	writev				sys_writev			sys_writev
+67	common	pread64				sys_pread64			compat_sys_pread64
+68	common	pwrite64			sys_pwrite64			compat_sys_pwrite64
+69	common	preadv				sys_preadv			compat_sys_preadv
+70	common	pwritev				sys_pwritev			compat_sys_pwritev
+71	32	sendfile64			sys_sendfile64
+71	64	sendfile			sys_sendfile64
+72	time32	pselect6			sys_pselect6_time32		compat_sys_pselect6_time32
+72	64	pselect6			sys_pselect6
+73	time32	ppoll				sys_ppoll_time32		compat_sys_ppoll_time32
+73	64	ppoll				sys_ppoll
+74	common	signalfd4			sys_signalfd4			compat_sys_signalfd4
+75	common	vmsplice			sys_vmsplice
+76	common	splice				sys_splice
+77	common	tee				sys_tee
+78	common	readlinkat			sys_readlinkat
+79	stat64	fstatat64			sys_fstatat64
+79	64	newfstatat			sys_newfstatat
+80	stat64	fstat64				sys_fstat64
+80	64	fstat				sys_newfstat
+81	common	sync				sys_sync
+82	common	fsync				sys_fsync
+83	common	fdatasync			sys_fdatasync
+84	common	sync_file_range			sys_sync_file_range		compat_sys_sync_file_range
+85	common	timerfd_create			sys_timerfd_create
+86	time32	timerfd_settime			sys_timerfd_settime32
+86	64	timerfd_settime			sys_timerfd_settime
+87	time32	timerfd_gettime			sys_timerfd_gettime32
+87	64	timerfd_gettime			sys_timerfd_gettime
+88	time32	utimensat			sys_utimensat_time32
+88	64	utimensat			sys_utimensat
+89	common	acct				sys_acct
+90	common	capget				sys_capget
+91	common	capset				sys_capset
+92	common	personality			sys_personality
+93	common	exit				sys_exit
+94	common	exit_group			sys_exit_group
+95	common	waitid				sys_waitid			compat_sys_waitid
+96	common	set_tid_address			sys_set_tid_address
+97	common	unshare				sys_unshare
+98	time32	futex				sys_futex_time32
+98	64	futex				sys_futex
+99	common	set_robust_list			sys_set_robust_list		compat_sys_set_robust_list
+100	common	get_robust_list			sys_get_robust_list		compat_sys_get_robust_list
+101	time32	nanosleep			sys_nanosleep_time32
+101	64	nanosleep			sys_nanosleep
+102	common	getitimer			sys_getitimer			compat_sys_getitimer
+103	common	setitimer			sys_setitimer			compat_sys_setitimer
+104	common	kexec_load			sys_kexec_load			compat_sys_kexec_load
+105	common	init_module			sys_init_module
+106	common	delete_module			sys_delete_module
+107	common	timer_create			sys_timer_create		compat_sys_timer_create
+108	time32	timer_gettime			sys_timer_gettime32
+108	64	timer_gettime			sys_timer_gettime
+109	common	timer_getoverrun		sys_timer_getoverrun
+110	time32	timer_settime			sys_timer_settime32
+110	64	timer_settime			sys_timer_settime
+111	common	timer_delete			sys_timer_delete
+112	time32	clock_settime			sys_clock_settime32
+112	64	clock_settime			sys_clock_settime
+113	time32	clock_gettime			sys_clock_gettime32
+113	64	clock_gettime			sys_clock_gettime
+114	time32	clock_getres			sys_clock_getres_time32
+114	64	clock_getres			sys_clock_getres
+115	time32	clock_nanosleep			sys_clock_nanosleep_time32
+115	64	clock_nanosleep			sys_clock_nanosleep
+116	common	syslog				sys_syslog
+117	common	ptrace				sys_ptrace			compat_sys_ptrace
+118	common	sched_setparam			sys_sched_setparam
+119	common	sched_setscheduler		sys_sched_setscheduler
+120	common	sched_getscheduler		sys_sched_getscheduler
+121	common	sched_getparam			sys_sched_getparam
+122	common	sched_setaffinity		sys_sched_setaffinity		compat_sys_sched_setaffinity
+123	common	sched_getaffinity		sys_sched_getaffinity		compat_sys_sched_getaffinity
+124	common	sched_yield			sys_sched_yield
+125	common	sched_get_priority_max		sys_sched_get_priority_max
+126	common	sched_get_priority_min		sys_sched_get_priority_min
+127	time32	sched_rr_get_interval		sys_sched_rr_get_interval_time32
+127	64	sched_rr_get_interval		sys_sched_rr_get_interval
+128	common	restart_syscall			sys_restart_syscall
+129	common	kill				sys_kill
+130	common	tkill				sys_tkill
+131	common	tgkill				sys_tgkill
+132	common	sigaltstack			sys_sigaltstack			compat_sys_sigaltstack
+133	common	rt_sigsuspend			sys_rt_sigsuspend		compat_sys_rt_sigsuspend
+134	common	rt_sigaction			sys_rt_sigaction		compat_sys_rt_sigaction
+135	common	rt_sigprocmask			sys_rt_sigprocmask		compat_sys_rt_sigprocmask
+136	common	rt_sigpending			sys_rt_sigpending		compat_sys_rt_sigpending
+137	time32	rt_sigtimedwait			sys_rt_sigtimedwait_time32	compat_sys_rt_sigtimedwait_time32
+137	64	rt_sigtimedwait			sys_rt_sigtimedwait
+138	common	rt_sigqueueinfo			sys_rt_sigqueueinfo		compat_sys_rt_sigqueueinfo
+139	common	rt_sigreturn			sys_rt_sigreturn		compat_sys_rt_sigreturn
+140	common	setpriority			sys_setpriority
+141	common	getpriority			sys_getpriority
+142	common	reboot				sys_reboot
+143	common	setregid			sys_setregid
+144	common	setgid				sys_setgid
+145	common	setreuid			sys_setreuid
+146	common	setuid				sys_setuid
+147	common	setresuid			sys_setresuid
+148	common	getresuid			sys_getresuid
+149	common	setresgid			sys_setresgid
+150	common	getresgid			sys_getresgid
+151	common	setfsuid			sys_setfsuid
+152	common	setfsgid			sys_setfsgid
+153	common	times				sys_times			compat_sys_times
+154	common	setpgid				sys_setpgid
+155	common	getpgid				sys_getpgid
+156	common	getsid				sys_getsid
+157	common	setsid				sys_setsid
+158	common	getgroups			sys_getgroups
+159	common	setgroups			sys_setgroups
+160	common	uname				sys_newuname
+161	common	sethostname			sys_sethostname
+162	common	setdomainname			sys_setdomainname
+# getrlimit and setrlimit are superseded with prlimit64
+163	rlimit	getrlimit			sys_getrlimit			compat_sys_getrlimit
+164	rlimit	setrlimit			sys_setrlimit			compat_sys_setrlimit
+165	common	getrusage			sys_getrusage			compat_sys_getrusage
+166	common	umask				sys_umask
+167	common	prctl				sys_prctl
+168	common	getcpu				sys_getcpu
+169	time32	gettimeofday			sys_gettimeofday		compat_sys_gettimeofday
+169	64	gettimeofday			sys_gettimeofday
+170	time32	settimeofday			sys_settimeofday		compat_sys_settimeofday
+170	64	settimeofday			sys_settimeofday
+171	time32	adjtimex			sys_adjtimex_time32
+171	64	adjtimex			sys_adjtimex
+172	common	getpid				sys_getpid
+173	common	getppid				sys_getppid
+174	common	getuid				sys_getuid
+175	common	geteuid				sys_geteuid
+176	common	getgid				sys_getgid
+177	common	getegid				sys_getegid
+178	common	gettid				sys_gettid
+179	common	sysinfo				sys_sysinfo			compat_sys_sysinfo
+180	common	mq_open				sys_mq_open			compat_sys_mq_open
+181	common	mq_unlink			sys_mq_unlink
+182	time32	mq_timedsend			sys_mq_timedsend_time32
+182	64	mq_timedsend			sys_mq_timedsend
+183	time32	mq_timedreceive			sys_mq_timedreceive_time32
+183	64	mq_timedreceive			sys_mq_timedreceive
+184	common	mq_notify			sys_mq_notify			compat_sys_mq_notify
+185	common	mq_getsetattr			sys_mq_getsetattr		compat_sys_mq_getsetattr
+186	common	msgget				sys_msgget
+187	common	msgctl				sys_msgctl			compat_sys_msgctl
+188	common	msgrcv				sys_msgrcv			compat_sys_msgrcv
+189	common	msgsnd				sys_msgsnd			compat_sys_msgsnd
+190	common	semget				sys_semget
+191	common	semctl				sys_semctl			compat_sys_semctl
+192	time32	semtimedop			sys_semtimedop_time32
+192	64	semtimedop			sys_semtimedop
+193	common	semop				sys_semop
+194	common	shmget				sys_shmget
+195	common	shmctl				sys_shmctl			compat_sys_shmctl
+196	common	shmat				sys_shmat			compat_sys_shmat
+197	common	shmdt				sys_shmdt
+198	common	socket				sys_socket
+199	common	socketpair			sys_socketpair
+200	common	bind				sys_bind
+201	common	listen				sys_listen
+202	common	accept				sys_accept
+203	common	connect				sys_connect
+204	common	getsockname			sys_getsockname
+205	common	getpeername			sys_getpeername
+206	common	sendto				sys_sendto
+207	common	recvfrom			sys_recvfrom			compat_sys_recvfrom
+208	common	setsockopt			sys_setsockopt			sys_setsockopt
+209	common	getsockopt			sys_getsockopt			sys_getsockopt
+210	common	shutdown			sys_shutdown
+211	common	sendmsg				sys_sendmsg			compat_sys_sendmsg
+212	common	recvmsg				sys_recvmsg			compat_sys_recvmsg
+213	common	readahead			sys_readahead			compat_sys_readahead
+214	common	brk				sys_brk
+215	common	munmap				sys_munmap
+216	common	mremap				sys_mremap
+217	common	add_key				sys_add_key
+218	common	request_key			sys_request_key
+219	common	keyctl				sys_keyctl			compat_sys_keyctl
+220	common	clone				sys_clone
+221	common	execve				sys_execve			compat_sys_execve
+222	32	mmap2				sys_mmap2
+222	64	mmap				sys_mmap
+223	32	fadvise64_64			sys_fadvise64_64		compat_sys_fadvise64_64
+223	64	fadvise64			sys_fadvise64_64
+224	common	swapon				sys_swapon
+225	common	swapoff				sys_swapoff
+226	common	mprotect			sys_mprotect
+227	common	msync				sys_msync
+228	common	mlock				sys_mlock
+229	common	munlock				sys_munlock
+230	common	mlockall			sys_mlockall
+231	common	munlockall			sys_munlockall
+232	common	mincore				sys_mincore
+233	common	madvise				sys_madvise
+234	common	remap_file_pages		sys_remap_file_pages
+235	common	mbind				sys_mbind
+236	common	get_mempolicy			sys_get_mempolicy
+237	common	set_mempolicy			sys_set_mempolicy
+238	common	migrate_pages			sys_migrate_pages
+239	common	move_pages			sys_move_pages
+240	common	rt_tgsigqueueinfo		sys_rt_tgsigqueueinfo		compat_sys_rt_tgsigqueueinfo
+241	common	perf_event_open			sys_perf_event_open
+242	common	accept4				sys_accept4
+243	time32	recvmmsg			sys_recvmmsg_time32		compat_sys_recvmmsg_time32
+243	64	recvmmsg			sys_recvmmsg
+# Architectures may provide up to 16 syscalls of their own between 244 and 259
+244	arc	cacheflush			sys_cacheflush
+245	arc	arc_settls			sys_arc_settls
+246	arc	arc_gettls			sys_arc_gettls
+247	arc	sysfs				sys_sysfs
+248	arc	arc_usr_cmpxchg			sys_arc_usr_cmpxchg
+
+244	csky	set_thread_area			sys_set_thread_area
+245	csky	cacheflush			sys_cacheflush
+
+244	nios2	cacheflush			sys_cacheflush
+
+244	or1k	or1k_atomic			sys_or1k_atomic
+
+258	riscv	riscv_hwprobe			sys_riscv_hwprobe
+259	riscv	riscv_flush_icache		sys_riscv_flush_icache
+
+260	time32	wait4				sys_wait4			compat_sys_wait4
+260	64	wait4				sys_wait4
+261	common	prlimit64			sys_prlimit64
+262	common	fanotify_init			sys_fanotify_init
+263	common	fanotify_mark			sys_fanotify_mark
+264	common	name_to_handle_at		sys_name_to_handle_at
+265	common	open_by_handle_at		sys_open_by_handle_at
+266	time32	clock_adjtime			sys_clock_adjtime32
+266	64	clock_adjtime			sys_clock_adjtime
+267	common	syncfs				sys_syncfs
+268	common	setns				sys_setns
+269	common	sendmmsg			sys_sendmmsg			compat_sys_sendmmsg
+270	common	process_vm_readv		sys_process_vm_readv
+271	common	process_vm_writev		sys_process_vm_writev
+272	common	kcmp				sys_kcmp
+273	common	finit_module			sys_finit_module
+274	common	sched_setattr			sys_sched_setattr
+275	common	sched_getattr			sys_sched_getattr
+276	common	renameat2			sys_renameat2
+277	common	seccomp				sys_seccomp
+278	common	getrandom			sys_getrandom
+279	common	memfd_create			sys_memfd_create
+280	common	bpf				sys_bpf
+281	common	execveat			sys_execveat			compat_sys_execveat
+282	common	userfaultfd			sys_userfaultfd
+283	common	membarrier			sys_membarrier
+284	common	mlock2				sys_mlock2
+285	common	copy_file_range			sys_copy_file_range
+286	common	preadv2				sys_preadv2			compat_sys_preadv2
+287	common	pwritev2			sys_pwritev2			compat_sys_pwritev2
+288	common	pkey_mprotect			sys_pkey_mprotect
+289	common	pkey_alloc			sys_pkey_alloc
+290	common	pkey_free			sys_pkey_free
+291	common	statx				sys_statx
+292	time32	io_pgetevents			sys_io_pgetevents_time32	compat_sys_io_pgetevents
+292	64	io_pgetevents			sys_io_pgetevents
+293	common	rseq				sys_rseq
+294	common	kexec_file_load			sys_kexec_file_load
+# 295 through 402 are unassigned to sync up with generic numbers don't use
+403	32	clock_gettime64			sys_clock_gettime
+404	32	clock_settime64			sys_clock_settime
+405	32	clock_adjtime64			sys_clock_adjtime
+406	32	clock_getres_time64		sys_clock_getres
+407	32	clock_nanosleep_time64		sys_clock_nanosleep
+408	32	timer_gettime64			sys_timer_gettime
+409	32	timer_settime64			sys_timer_settime
+410	32	timerfd_gettime64		sys_timerfd_gettime
+411	32	timerfd_settime64		sys_timerfd_settime
+412	32	utimensat_time64		sys_utimensat
+413	32	pselect6_time64			sys_pselect6			compat_sys_pselect6_time64
+414	32	ppoll_time64			sys_ppoll			compat_sys_ppoll_time64
+416	32	io_pgetevents_time64		sys_io_pgetevents		compat_sys_io_pgetevents_time64
+417	32	recvmmsg_time64			sys_recvmmsg			compat_sys_recvmmsg_time64
+418	32	mq_timedsend_time64		sys_mq_timedsend
+419	32	mq_timedreceive_time64		sys_mq_timedreceive
+420	32	semtimedop_time64		sys_semtimedop
+421	32	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
+422	32	futex_time64			sys_futex
+423	32	sched_rr_get_interval_time64	sys_sched_rr_get_interval
+424	common	pidfd_send_signal		sys_pidfd_send_signal
+425	common	io_uring_setup			sys_io_uring_setup
+426	common	io_uring_enter			sys_io_uring_enter
+427	common	io_uring_register		sys_io_uring_register
+428	common	open_tree			sys_open_tree
+429	common	move_mount			sys_move_mount
+430	common	fsopen				sys_fsopen
+431	common	fsconfig			sys_fsconfig
+432	common	fsmount				sys_fsmount
+433	common	fspick				sys_fspick
+434	common	pidfd_open			sys_pidfd_open
+435	common	clone3				sys_clone3
+436	common	close_range			sys_close_range
+437	common	openat2				sys_openat2
+438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	faccessat2			sys_faccessat2
+440	common	process_madvise			sys_process_madvise
+441	common	epoll_pwait2			sys_epoll_pwait2		compat_sys_epoll_pwait2
+442	common	mount_setattr			sys_mount_setattr
+443	common	quotactl_fd			sys_quotactl_fd
+444	common	landlock_create_ruleset		sys_landlock_create_ruleset
+445	common	landlock_add_rule		sys_landlock_add_rule
+446	common	landlock_restrict_self		sys_landlock_restrict_self
+447	memfd_secret	memfd_secret		sys_memfd_secret
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
diff --git a/linux-user/hexagon/syscall_nr.h b/linux-user/hexagon/syscall_nr.h
deleted file mode 100644
index f3220b74f7c3..000000000000
--- a/linux-user/hexagon/syscall_nr.h
+++ /dev/null
@@ -1,348 +0,0 @@
-/*
- * This file contains the system call numbers.
- * Do not modify.
- * This file is generated by scripts/gensyscalls.sh
- */
-#ifndef LINUX_USER_HEXAGON_SYSCALL_NR_H
-#define LINUX_USER_HEXAGON_SYSCALL_NR_H
-
-#define TARGET_NR_io_setup 0
-#define TARGET_NR_io_destroy 1
-#define TARGET_NR_io_submit 2
-#define TARGET_NR_io_cancel 3
-#define TARGET_NR_io_getevents 4
-#define TARGET_NR_setxattr 5
-#define TARGET_NR_lsetxattr 6
-#define TARGET_NR_fsetxattr 7
-#define TARGET_NR_getxattr 8
-#define TARGET_NR_lgetxattr 9
-#define TARGET_NR_fgetxattr 10
-#define TARGET_NR_listxattr 11
-#define TARGET_NR_llistxattr 12
-#define TARGET_NR_flistxattr 13
-#define TARGET_NR_removexattr 14
-#define TARGET_NR_lremovexattr 15
-#define TARGET_NR_fremovexattr 16
-#define TARGET_NR_getcwd 17
-#define TARGET_NR_lookup_dcookie 18
-#define TARGET_NR_eventfd2 19
-#define TARGET_NR_epoll_create1 20
-#define TARGET_NR_epoll_ctl 21
-#define TARGET_NR_epoll_pwait 22
-#define TARGET_NR_dup 23
-#define TARGET_NR_dup3 24
-#define TARGET_NR_fcntl64 25
-#define TARGET_NR_inotify_init1 26
-#define TARGET_NR_inotify_add_watch 27
-#define TARGET_NR_inotify_rm_watch 28
-#define TARGET_NR_ioctl 29
-#define TARGET_NR_ioprio_set 30
-#define TARGET_NR_ioprio_get 31
-#define TARGET_NR_flock 32
-#define TARGET_NR_mknodat 33
-#define TARGET_NR_mkdirat 34
-#define TARGET_NR_unlinkat 35
-#define TARGET_NR_symlinkat 36
-#define TARGET_NR_linkat 37
-#define TARGET_NR_renameat 38
-#define TARGET_NR_umount2 39
-#define TARGET_NR_mount 40
-#define TARGET_NR_pivot_root 41
-#define TARGET_NR_nfsservctl 42
-#define TARGET_NR_statfs64 43
-#define TARGET_NR_fstatfs64 44
-#define TARGET_NR_truncate64 45
-#define TARGET_NR_ftruncate64 46
-#define TARGET_NR_fallocate 47
-#define TARGET_NR_faccessat 48
-#define TARGET_NR_chdir 49
-#define TARGET_NR_fchdir 50
-#define TARGET_NR_chroot 51
-#define TARGET_NR_fchmod 52
-#define TARGET_NR_fchmodat 53
-#define TARGET_NR_fchownat 54
-#define TARGET_NR_fchown 55
-#define TARGET_NR_openat 56
-#define TARGET_NR_close 57
-#define TARGET_NR_vhangup 58
-#define TARGET_NR_pipe2 59
-#define TARGET_NR_quotactl 60
-#define TARGET_NR_getdents64 61
-#define TARGET_NR_llseek 62
-#define TARGET_NR_read 63
-#define TARGET_NR_write 64
-#define TARGET_NR_readv 65
-#define TARGET_NR_writev 66
-#define TARGET_NR_pread64 67
-#define TARGET_NR_pwrite64 68
-#define TARGET_NR_preadv 69
-#define TARGET_NR_pwritev 70
-#define TARGET_NR_sendfile64 71
-#define TARGET_NR_pselect6 72
-#define TARGET_NR_ppoll 73
-#define TARGET_NR_signalfd4 74
-#define TARGET_NR_vmsplice 75
-#define TARGET_NR_splice 76
-#define TARGET_NR_tee 77
-#define TARGET_NR_readlinkat 78
-#define TARGET_NR_fstatat64 79
-#define TARGET_NR_fstat64 80
-#define TARGET_NR_sync 81
-#define TARGET_NR_fsync 82
-#define TARGET_NR_fdatasync 83
-#define TARGET_NR_sync_file_range2 84
-#define TARGET_NR_timerfd_create 85
-#define TARGET_NR_timerfd_settime 86
-#define TARGET_NR_timerfd_gettime 87
-#define TARGET_NR_utimensat 88
-#define TARGET_NR_acct 89
-#define TARGET_NR_capget 90
-#define TARGET_NR_capset 91
-#define TARGET_NR_personality 92
-#define TARGET_NR_exit 93
-#define TARGET_NR_exit_group 94
-#define TARGET_NR_waitid 95
-#define TARGET_NR_set_tid_address 96
-#define TARGET_NR_unshare 97
-#define TARGET_NR_futex 98
-#define TARGET_NR_set_robust_list 99
-#define TARGET_NR_get_robust_list 100
-#define TARGET_NR_nanosleep 101
-#define TARGET_NR_getitimer 102
-#define TARGET_NR_setitimer 103
-#define TARGET_NR_kexec_load 104
-#define TARGET_NR_init_module 105
-#define TARGET_NR_delete_module 106
-#define TARGET_NR_timer_create 107
-#define TARGET_NR_timer_gettime 108
-#define TARGET_NR_timer_getoverrun 109
-#define TARGET_NR_timer_settime 110
-#define TARGET_NR_timer_delete 111
-#define TARGET_NR_clock_settime 112
-#define TARGET_NR_clock_gettime 113
-#define TARGET_NR_clock_getres 114
-#define TARGET_NR_clock_nanosleep 115
-#define TARGET_NR_syslog 116
-#define TARGET_NR_ptrace 117
-#define TARGET_NR_sched_setparam 118
-#define TARGET_NR_sched_setscheduler 119
-#define TARGET_NR_sched_getscheduler 120
-#define TARGET_NR_sched_getparam 121
-#define TARGET_NR_sched_setaffinity 122
-#define TARGET_NR_sched_getaffinity 123
-#define TARGET_NR_sched_yield 124
-#define TARGET_NR_sched_get_priority_max 125
-#define TARGET_NR_sched_get_priority_min 126
-#define TARGET_NR_sched_rr_get_interval 127
-#define TARGET_NR_restart_syscall 128
-#define TARGET_NR_kill 129
-#define TARGET_NR_tkill 130
-#define TARGET_NR_tgkill 131
-#define TARGET_NR_sigaltstack 132
-#define TARGET_NR_rt_sigsuspend 133
-#define TARGET_NR_rt_sigaction 134
-#define TARGET_NR_rt_sigprocmask 135
-#define TARGET_NR_rt_sigpending 136
-#define TARGET_NR_rt_sigtimedwait 137
-#define TARGET_NR_rt_sigqueueinfo 138
-#define TARGET_NR_rt_sigreturn 139
-#define TARGET_NR_setpriority 140
-#define TARGET_NR_getpriority 141
-#define TARGET_NR_reboot 142
-#define TARGET_NR_setregid 143
-#define TARGET_NR_setgid 144
-#define TARGET_NR_setreuid 145
-#define TARGET_NR_setuid 146
-#define TARGET_NR_setresuid 147
-#define TARGET_NR_getresuid 148
-#define TARGET_NR_setresgid 149
-#define TARGET_NR_getresgid 150
-#define TARGET_NR_setfsuid 151
-#define TARGET_NR_setfsgid 152
-#define TARGET_NR_times 153
-#define TARGET_NR_setpgid 154
-#define TARGET_NR_getpgid 155
-#define TARGET_NR_getsid 156
-#define TARGET_NR_setsid 157
-#define TARGET_NR_getgroups 158
-#define TARGET_NR_setgroups 159
-#define TARGET_NR_uname 160
-#define TARGET_NR_sethostname 161
-#define TARGET_NR_setdomainname 162
-#define TARGET_NR_getrlimit 163
-#define TARGET_NR_setrlimit 164
-#define TARGET_NR_getrusage 165
-#define TARGET_NR_umask 166
-#define TARGET_NR_prctl 167
-#define TARGET_NR_getcpu 168
-#define TARGET_NR_gettimeofday 169
-#define TARGET_NR_settimeofday 170
-#define TARGET_NR_adjtimex 171
-#define TARGET_NR_getpid 172
-#define TARGET_NR_getppid 173
-#define TARGET_NR_getuid 174
-#define TARGET_NR_geteuid 175
-#define TARGET_NR_getgid 176
-#define TARGET_NR_getegid 177
-#define TARGET_NR_gettid 178
-#define TARGET_NR_sysinfo 179
-#define TARGET_NR_mq_open 180
-#define TARGET_NR_mq_unlink 181
-#define TARGET_NR_mq_timedsend 182
-#define TARGET_NR_mq_timedreceive 183
-#define TARGET_NR_mq_notify 184
-#define TARGET_NR_mq_getsetattr 185
-#define TARGET_NR_msgget 186
-#define TARGET_NR_msgctl 187
-#define TARGET_NR_msgrcv 188
-#define TARGET_NR_msgsnd 189
-#define TARGET_NR_semget 190
-#define TARGET_NR_semctl 191
-#define TARGET_NR_semtimedop 192
-#define TARGET_NR_semop 193
-#define TARGET_NR_shmget 194
-#define TARGET_NR_shmctl 195
-#define TARGET_NR_shmat 196
-#define TARGET_NR_shmdt 197
-#define TARGET_NR_socket 198
-#define TARGET_NR_socketpair 199
-#define TARGET_NR_bind 200
-#define TARGET_NR_listen 201
-#define TARGET_NR_accept 202
-#define TARGET_NR_connect 203
-#define TARGET_NR_getsockname 204
-#define TARGET_NR_getpeername 205
-#define TARGET_NR_sendto 206
-#define TARGET_NR_recvfrom 207
-#define TARGET_NR_setsockopt 208
-#define TARGET_NR_getsockopt 209
-#define TARGET_NR_shutdown 210
-#define TARGET_NR_sendmsg 211
-#define TARGET_NR_recvmsg 212
-#define TARGET_NR_readahead 213
-#define TARGET_NR_brk 214
-#define TARGET_NR_munmap 215
-#define TARGET_NR_mremap 216
-#define TARGET_NR_add_key 217
-#define TARGET_NR_request_key 218
-#define TARGET_NR_keyctl 219
-#define TARGET_NR_clone 220
-#define TARGET_NR_execve 221
-#define TARGET_NR_mmap2 222
-#define TARGET_NR_fadvise64_64 223
-#define TARGET_NR_swapon 224
-#define TARGET_NR_swapoff 225
-#define TARGET_NR_mprotect 226
-#define TARGET_NR_msync 227
-#define TARGET_NR_mlock 228
-#define TARGET_NR_munlock 229
-#define TARGET_NR_mlockall 230
-#define TARGET_NR_munlockall 231
-#define TARGET_NR_mincore 232
-#define TARGET_NR_madvise 233
-#define TARGET_NR_remap_file_pages 234
-#define TARGET_NR_mbind 235
-#define TARGET_NR_get_mempolicy 236
-#define TARGET_NR_set_mempolicy 237
-#define TARGET_NR_migrate_pages 238
-#define TARGET_NR_move_pages 239
-#define TARGET_NR_rt_tgsigqueueinfo 240
-#define TARGET_NR_perf_event_open 241
-#define TARGET_NR_accept4 242
-#define TARGET_NR_recvmmsg 243
-#define TARGET_NR_arch_specific_syscall 244
-#define TARGET_NR_wait4 260
-#define TARGET_NR_prlimit64 261
-#define TARGET_NR_fanotify_init 262
-#define TARGET_NR_fanotify_mark 263
-#define TARGET_NR_name_to_handle_at 264
-#define TARGET_NR_open_by_handle_at 265
-#define TARGET_NR_clock_adjtime 266
-#define TARGET_NR_syncfs 267
-#define TARGET_NR_setns 268
-#define TARGET_NR_sendmmsg 269
-#define TARGET_NR_process_vm_readv 270
-#define TARGET_NR_process_vm_writev 271
-#define TARGET_NR_kcmp 272
-#define TARGET_NR_finit_module 273
-#define TARGET_NR_sched_setattr 274
-#define TARGET_NR_sched_getattr 275
-#define TARGET_NR_renameat2 276
-#define TARGET_NR_seccomp 277
-#define TARGET_NR_getrandom 278
-#define TARGET_NR_memfd_create 279
-#define TARGET_NR_bpf 280
-#define TARGET_NR_execveat 281
-#define TARGET_NR_userfaultfd 282
-#define TARGET_NR_membarrier 283
-#define TARGET_NR_mlock2 284
-#define TARGET_NR_copy_file_range 285
-#define TARGET_NR_preadv2 286
-#define TARGET_NR_pwritev2 287
-#define TARGET_NR_pkey_mprotect 288
-#define TARGET_NR_pkey_alloc 289
-#define TARGET_NR_pkey_free 290
-#define TARGET_NR_statx 291
-#define TARGET_NR_io_pgetevents 292
-#define TARGET_NR_rseq 293
-#define TARGET_NR_kexec_file_load 294
-#define TARGET_NR_clock_gettime64 403
-#define TARGET_NR_clock_settime64 404
-#define TARGET_NR_clock_adjtime64 405
-#define TARGET_NR_clock_getres_time64 406
-#define TARGET_NR_clock_nanosleep_time64 407
-#define TARGET_NR_timer_gettime64 408
-#define TARGET_NR_timer_settime64 409
-#define TARGET_NR_timerfd_gettime64 410
-#define TARGET_NR_timerfd_settime64 411
-#define TARGET_NR_utimensat_time64 412
-#define TARGET_NR_pselect6_time64 413
-#define TARGET_NR_ppoll_time64 414
-#define TARGET_NR_io_pgetevents_time64 416
-#define TARGET_NR_recvmmsg_time64 417
-#define TARGET_NR_mq_timedsend_time64 418
-#define TARGET_NR_mq_timedreceive_time64 419
-#define TARGET_NR_semtimedop_time64 420
-#define TARGET_NR_rt_sigtimedwait_time64 421
-#define TARGET_NR_futex_time64 422
-#define TARGET_NR_sched_rr_get_interval_time64 423
-#define TARGET_NR_pidfd_send_signal 424
-#define TARGET_NR_io_uring_setup 425
-#define TARGET_NR_io_uring_enter 426
-#define TARGET_NR_io_uring_register 427
-#define TARGET_NR_open_tree 428
-#define TARGET_NR_move_mount 429
-#define TARGET_NR_fsopen 430
-#define TARGET_NR_fsconfig 431
-#define TARGET_NR_fsmount 432
-#define TARGET_NR_fspick 433
-#define TARGET_NR_pidfd_open 434
-#define TARGET_NR_close_range 436
-#define TARGET_NR_openat2 437
-#define TARGET_NR_pidfd_getfd 438
-#define TARGET_NR_faccessat2 439
-#define TARGET_NR_process_madvise 440
-#define TARGET_NR_epoll_pwait2 441
-#define TARGET_NR_mount_setattr 442
-#define TARGET_NR_quotactl_fd 443
-#define TARGET_NR_landlock_create_ruleset 444
-#define TARGET_NR_landlock_add_rule 445
-#define TARGET_NR_landlock_restrict_self 446
-#define TARGET_NR_process_mrelease 448
-#define TARGET_NR_futex_waitv 449
-#define TARGET_NR_set_mempolicy_home_node 450
-#define TARGET_NR_cachestat 451
-#define TARGET_NR_fchmodat2 452
-#define TARGET_NR_map_shadow_stack 453
-#define TARGET_NR_futex_wake 454
-#define TARGET_NR_futex_wait 455
-#define TARGET_NR_futex_requeue 456
-#define TARGET_NR_statmount 457
-#define TARGET_NR_listmount 458
-#define TARGET_NR_lsm_get_self_attr 459
-#define TARGET_NR_lsm_set_self_attr 460
-#define TARGET_NR_lsm_list_modules 461
-#define TARGET_NR_mseal 462
-#define TARGET_NR_syscalls 463
-
-#endif /* LINUX_USER_HEXAGON_SYSCALL_NR_H */
diff --git a/linux-user/hexagon/syscallhdr.sh b/linux-user/hexagon/syscallhdr.sh
new file mode 100644
index 000000000000..ed605c038ee9
--- /dev/null
+++ b/linux-user/hexagon/syscallhdr.sh
@@ -0,0 +1,28 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+in="$1"
+out="$2"
+my_abis=`echo "($3)" | tr ',' '|'`
+prefix="$4"
+offset="$5"
+
+fileguard=LINUX_USER_HEXAGON_`basename "$out" | sed \
+    -e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
+    -e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g'`
+grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
+    echo "#ifndef ${fileguard}"
+    echo "#define ${fileguard} 1"
+    echo ""
+
+    while read nr abi name entry compat ; do
+    if [ -z "$offset" ]; then
+        echo "#define TARGET_NR_${prefix}${name} $nr"
+    else
+        echo "#define TARGET_NR_${prefix}${name} ($offset + $nr)"
+        fi
+    done
+
+    echo ""
+    echo "#endif /* ${fileguard} */"
+) > "$out"
diff --git a/linux-user/meson.build b/linux-user/meson.build
index cfbaf9741ded..f75b4fe0e3ec 100644
--- a/linux-user/meson.build
+++ b/linux-user/meson.build
@@ -38,6 +38,7 @@ gen_vdso = generator(gen_vdso_exe, output: '@BASENAME@.c.inc',
 subdir('aarch64')
 subdir('alpha')
 subdir('arm')
+subdir('hexagon')
 subdir('hppa')
 subdir('i386')
 subdir('loongarch64')
diff --git a/scripts/gensyscalls.sh b/scripts/gensyscalls.sh
index babbc6127de4..1696473c6da6 100755
--- a/scripts/gensyscalls.sh
+++ b/scripts/gensyscalls.sh
@@ -93,6 +93,5 @@ generate_syscall_nr()
 mkdir "$TMP/asm"
 > "$TMP/asm/bitsperlong.h"
 
-generate_syscall_nr hexagon 32 "$output/linux-user/hexagon/syscall_nr.h"
 generate_syscall_nr loongarch 64 "$output/linux-user/loongarch64/syscall_nr.h"
 rm -fr "$TMP"
diff --git a/scripts/update-syscalltbl.sh b/scripts/update-syscalltbl.sh
index cf3ea1dea143..f7615c19bbdc 100755
--- a/scripts/update-syscalltbl.sh
+++ b/scripts/update-syscalltbl.sh
@@ -2,6 +2,7 @@ TBL_LIST="\
 arch/alpha/kernel/syscalls/syscall.tbl,linux-user/alpha/syscall.tbl \
 arch/arm/tools/syscall.tbl,linux-user/arm/syscall.tbl \
 scripts/syscall.tbl,linux-user/aarch64/syscall_64.tbl \
+scripts/syscall.tbl,linux-user/hexagon/syscall.tbl \
 arch/m68k/kernel/syscalls/syscall.tbl,linux-user/m68k/syscall.tbl \
 arch/microblaze/kernel/syscalls/syscall.tbl,linux-user/microblaze/syscall.tbl \
 arch/mips/kernel/syscalls/syscall_n32.tbl,linux-user/mips64/syscall_n32.tbl \
-- 
2.46.0


