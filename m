Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2310C982D6
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 04:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Q9x-0005Ia-OX; Fri, 18 Sep 2026 00:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7Q9v-0005IB-VP
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:11 -0400
Received: from mail-oi2-x10.google.com ([2607:f8b0:4864:32::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7Q9s-00048k-DV
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:11 -0400
Received: by mail-oi2-x10.google.com with SMTP id
 46e09a7af769-804ef461aedso156439a34.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 21:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789705506; x=1790310306;
 darn=nongnu.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MXBi9bDNnxNRNXVS6d+F5a+muGMmr55BNBTzexcpe6A=;
 b=V77STaTYURC0SWcA6cPO9L1Un621V2f4p9zRyAjupCbRltRalQLtcni/FeY+GF5QOK
 ALxCK7LYeOP9kVUXHSg8owd9E39cM38YK7O+m42PSep7Xg20QvTHenbZGDmTn+4jUx7+
 gDOyUNohS0dpqTIg1J66xRv9gd8B/Yb6McgMWkyk4yG56ufH2/6fEd5rIw40bJbmH4Gk
 o9gjs4KpUZPhA7CdgB+JRgRCna8ir07qxCURiLlY303KGIVbx7dU8R91k1DpzTHf3pIG
 hFjpG5NpO6IdBd4Dn6v3ylOfGvisGTsvvoYxD4vmT0YB9qbm0nEhG4NIFGE45q37t9is
 /kyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789705506; x=1790310306;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MXBi9bDNnxNRNXVS6d+F5a+muGMmr55BNBTzexcpe6A=;
 b=b7+duNroDNnKeJ1j8VzDg41N7kwDrO/T5W6F+/8FpfrJkxMhrnPt3QLWF0GAyHAbyc
 7RRHX8JNPCgc5M54SH5PZ94c+Fo36FAP/CPX5QvwJN1SSpxgf2guModdE0nuvZFb8v25
 YE+P62U9cATT3Tcd1rkNouslbvFjJ85ytFQrT9p7D1/Swed8yYAXLku06AdgWfLz9aKZ
 rueKVeQMvWHgQf68o4nidHIcJtEhv5zIUhjivP6tYvidBZEM0SgWjo6qiuTWU0YGma/K
 RtIl5XPfXZ1Ivli2ZkVH74pdbPpAiZdA3h0gpx0UKvQuJg4wSbCPLgybF2jghX6eYbcF
 Jr8A==
X-Gm-Message-State: AFuF++lOgvqrioL4AVA2AMF5JixH5Fs3M+2hn/atk3Gev9fgCWFw6yt0
 IyRJsP5Gh2w19VmtpZyBYBYsM+x6oLtmTO8haMA+FpcfzmuMv/T91RC3HS5DeyzQme8rZi7g1vR
 7wfDRZrc=
X-Gm-Gg: AYBFou1FJX44Q1oiSB2jMoGkNb+JoANe61aAp0nDVOAj3yS2dA8EpwsM20KfSaqR7iO
 5cwW9wP7TYwCKJcAt/izWMFCz3RNn8b3TpnyDF14Sq3YD17WS41Kf5r8x1bP4KPvKai41FSnPV+
 EyMhXDBkKCQpOL0nkiRS5queq2AWByGyC3ROd/4GPck0CPHtO3U8uoroOlfQdgCCwjK41tK8QH2
 U8C8wOjib9lAhQsz7Yzx1PGo7ITJA16uYV1xJRWiQ3NBIjJw0r7krt4qM3MGpi2kDCug+pUlaRq
 jKuuHHgXZ05arGKqHEL+9tqLZ74ukE3qs7iW8/pTA07TVqhjxR9vzt9eqS3/1TgAIagsYX/ln2u
 nMAL9+YsXygke63iP3V6mjck8P5yywukkw3rlrhWzi2MYzl/NKfvJ71g1hqJfYdwfKmxUBdYZyY
 yEP0pB5ZXyKUi9VT/42sshxX+HCnmwiI40kLMefqqPItIOIU3r+Id+9Wev9A==
X-Received: by 2002:a05:6830:388a:b0:805:ba8b:37ed with SMTP id
 46e09a7af769-80de2cd691cmr1730314a34.25.1789705506486; 
 Thu, 17 Sep 2026 21:25:06 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80e51d627b5sm489718a34.20.2026.09.17.21.25.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 21:25:05 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 00/41] Misc 2026q2 v4 patches
Date: Thu, 17 Sep 2026 22:23:41 -0600
Message-ID: <20260918042422.38713-1-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:32::10;
 envelope-from=imp@bsdimp.com; helo=mail-oi2-x10.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 3b5d71cc3652fa7f5ecc449f05dae3ead2b718d7:

  Merge tag 'pull-ufs-20260918' of https://gitlab.com/jeuk20.kim/qemu into staging (2026-09-17 15:18:09 -1000)

are available in the Git repository at:

  git@gitlab.com:bsdimp/qemu-from-official.git tags/misc-2026q2-v4-pull-request

for you to fetch changes up to 1f71ada86d7ad43c7241a6ae96912139ec3a6a7e:

  bsd-user Update random_seed on thread creation (2026-09-17 22:07:42 -0600)

----------------------------------------------------------------
bsd-user: Upstream most of the remaining system calls

Upstream the file, thread, socket and remaining signal system calls (too
numerous to list here).

This series is an ambitous use of claude to help me upstream all the
remaining system calls. I've batched them together in what I think are
reasonable chunks, and had claude do the grunt work of copying the code
over and attributing the commits from our complex branching history. The
chopping up was a bit arbitrary, but I think it's good. The commit
messages may be a little weak, but may also be OK. I've also double
checked the style and made fixes upstream for them as well. Claude also
reviewed all these changes and found a few bugs that I've fixed. I've
personally read through them all and haven't found anything glaring. I
fixed all the bugs that were found, in most cases differently than
claude's suggestions.

I've added 'Assisted-by: Claude...' to all these commits to reflect my
leaning on Claude so hard. This use falls within the 'non-creative' use
that the Qemu project has said is OK. If that's not the right thing to
do, I can remove them.

This leaves sysctl translation, the powerpc architecture support,
coredumps and a transition to 'truss' based system call tracing. With
these changes applied we'er down from a high of about 30k lines of diffs
to only 5k (not counting genereted, but checked in files in blitz). The
changes are 8k, so maybe a bit ambitious from that perspective as well.

There's a few lines over 80 that I've not cleaned up. Let me know if
that's a problem. The other warnings are about adding files, and there's
no new MAINTAINERS entry needed. And the 'arch dependent defines should
be avoided' are needed to cope with different FreeBSD build systems
having different system calls.

Note, this is called out below too, but in v2 I've folded back all the
fixes based on some out-of-band feedback I recieved to do this the
normal way and the qemu project isn't interested in the fixes to fixes.

Note that in v3 I've added a rather long generated file. I generated it
automatically looking at the type annocations in FreeBSD on the socket
options in comments. I had to augment the annotations, so I can't just
generate it within the build from the installed headers until it's
merged from head and then merges to stable branches and then waiting for
a release on each of them (6-9 months given FreeBSD's release schedule).
Also note: there's a couple left over issues from v2, so if I've not
taken care of them all, please gently remind me if you think action
is still needed after my comments before.

And in v3 I've added some random_seed fixes for fork/new threads
since we're upstreaming those files. These should be correct now,
but I'm looking for the correction.

In v4, I've rebased to post 11.1.0 master, and fixed the issues that
were highlighted in the last review. Some comments I rejected, for now,
since they were refactoring code that's hard to test. I've also juggled
many patch hunks between revisions so they all compile w/o warnings.

I've created annotation in FreeBSD to allow us, in the future, to
generate os-sockopt.h from the installed headers. It will take a while
for that to work its way into all the supported releases, so in the mean
time I'm committing the generated os-sockopt.h file. I've ignored the
too-long-line warnings and errors for this file because there's no
reason for this file to conform to style.

To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>

---
Changes in v5:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v4: https://lore.kernel.org/qemu-devel/20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com

Changes in v4:
- Fix the rebase errors in v3.
- Rebase to post 11.1.0.
- Fix overly large chunking with syscalls-defs.h by breaking it up
- Tweak syscalls-defs.h with an eye toward diff reduction to blitz
- Break out realpath fix
- Various chunks shuffled to make each patch compile w/o warnings
- better get/setsockopt implementaiton
- Link to v3: https://lore.kernel.org/qemu-devel/20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com

Changes in v3:
- refactor get/setsockopt, including new generated file
- add random_seed fixes to fork
- move adding of .c files to meson.build to where we add the file.
- Fix acl bounds checking
- Fix indentation and other misc nits
- copy_to/from_user needs to be abi_long
- Fix toggling of the _ at the end of BSD_PROC_H
- Fix leak in error paths in do_freebsd_ktimer_create
- Don't write back on ktimer_gettime errors
- Be more careful about EINTR returns
- do_freebsd_ntp_adjtime needs to return failures from h2t_freebsd_timex
- do_freebsd_ktimer_gettime shouldn't writeback on error
- t2h_freebsd_umtx_time needs to unlock_user on error path
- Prefer abi_long for all pointers in extattr
- Remove accidentally duplicated prototypes.
- Don't writeback the eventlist, we're just reading it
- Add missing 'do' to the macro
- Byte swap sival_ptr in convertion
- Add missing get_errno call to safe___umtx_op
- Don't write back if getsockopt fails
- Write back correct number of bytes for do_bsd_recvfrom
- Loop through cnt, not maxcnt for acl conversion
- Fix getsockopt size computation
- Return ret, not errno, since do_freebsd_new_thr doesn't touch errno
- Fixed off by one in connectat: we need the bug compat fix here too
- Fixed error in preadv: copy params backwards
- Link to v2: https://lore.kernel.org/qemu-devel/20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com

Changes in v2:
- don't write offsets on errors for copy_file_range
- pipe2: Check the raw system call value directly
- setsockopt: Check target_to_host_ip_mreq return value
- <several places>: Check return value of host_to_target_sockaddr
- do_bsd_setsockopt: Read in the socket option
- ntp_gettime: write back time on non-errors, not just 0
- do_freebsd_sigtimedwait check t2h_freebsd_timespec return
- do_freebsd_swapcontext writing incorrectly, readonly data (0 to user_unlock)
- do_thr_set_name needs get_errno()
- Have ntp_adjtime write back the structure
- kevent_freebsd11 no need to explicitly mask, datatypes do this for us
- do_freebsd_setcontext just reads the mcontext, 0 in unlock_user
- target_to_host_sigevent is read-only, so pass 0 in unlock_user
- target_to_host_ip_mreq needs tswap32 for int32_t
- use get_errno on kenv return values to report errors better
- kevent: only copy the number of events returns, not whole buffer
- Copy tolerance field of timex
- freebsd_umtx_sem_wake use VERIFY_READ instead of write to read struct
- Avoid double g2h_untagged mistakes in !_UMTX_OPTIMIZED
- Fixed additional missing unlock in freebsd_rw_rdlock and freebsd_rw_wrlock in !_UMTX_OPTIMIZED
- Squashed all the bug commit back to the appropriate earleir patch
- Link to v1: https://lore.kernel.org/qemu-devel/20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com
-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQJPBAABCgA5FiEEIDX4lLAKo898zeG3bBzRKH2wEQAFAmqsvHsbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwzAAoJEGwc0Sh9sBEAhSgP/2ZXhHkkhQVUYzUhhM5K
vsOO/cJXMoTdvGlW8fG1bofHm4znS/WQvMxTaCOW6b472YLmRWkg+DSp5LqwZp/n
4VjQE0guaxUS9fQloPKFslfCmWaeszfiFR3W3VX2qxIZngMDbBLPJwwj5m8HHorG
oEYNTxW9kEIXBMlDeFW0A/rU+tQJSlfjaktbmCB03AvS9NpJNt0l1koA4IFwA0bO
9dK1hIXTQp/7iDcukRg6Q0PY12N0plI359hEz1O4A/sOcc9tFJ747Jeltw7TBCIH
A9sKPhwXsQYeWecCvSjyeYVa0A8BEC+bL2Ii2/g4waf6eYLy5UR6vLzQwsNsRy5w
CkLb614MXlpPPmxlWIo7Kr2aM6ZC8ictg0LBofxlqUz2Fn7rNVpEMFM23GgW+wgW
LeA4QVmN7jrMNdW0gOnsbMp8XPtJXkgaYj6xFzlRlI0PMTLMiwy2EF+9uuoRy+4k
2gnmcwOvZ3bnNRkCootzSGrrPQ1myUlqQlrHTCDPJxuPMRPP/mG9vYk0QcKAtZ5o
qR3El++zg0W+/kYH1/VQK+ekST07R161uOyItm8zPqq4SikhGRRujHUu0nLiL8t5
UU1ARZ63rDXZSnrS/ZI5iHkdFhM71Bf+wsHRjLsqtla1nbjp6Tmc4i19NX8PZwTW
0x8IkZhNH3ewbdFWb9p3MeTU
=DGJO
-----END PGP SIGNATURE-----

----------------------------------------------------------------

Warner Losh (41):
  bsd-user: Upstream most of the remaining system calls
  bsd-user: Rename cpu_env to env throughout bsd-user
  bsd-user: Fix copy direciton in preadv
  bsd-user: Add bsd-signal.h with sigaction through sigreturn
  bsd-user: Add signal shims sigwait through kill and os-signal.h
  bsd-user: Add signal system call dispatch
  bsd-user: move sys/shm.h lines
  bsd-user: Remove mmap defines
  bsd-user: Use target_suseconds_t
  bsd-user: Move sys/uuid.h defines
  bsd-user: Fix realpathat for FreeBSD 15.0 and newer
  bsd-user: Add os-file.h with chflagsat, close_range, and more
  bsd-user: Add poll, poll2, lseek, pipe, and swap system call shims
  bsd-user: Add FreeBSD socket helpers and sockaddr conversion
  bsd-user: Add bsd-socket.h with bind through getsockname
  bsd-user: Add socket shims socketpair through shutdown
  bsd-user: Commit the generated os-sockopt.h files
  bsd-user: Implement both getsockopt and setsockopt
  bsd-user: Add FreeBSD socket system calls
  bsd-user: Add os-socket.[ch] sendmsg, recvmsg and cmsg
  bsd-user: Add socket system call dispatch
  bsd-user: Add os-time.h with clock and time-of-day functions
  bsd-user: Add utimes, futimes, and ktimer functions to os-time.h
  bsd-user: Add select, pselect, and ppoll to os-time.h
  bsd-user: Add kqueue and kevent functions to os-time.h
  bsd-user: Add sigtimedwait, itimer, and futimens to os-time.h
  bsd-user: Add os-time.c and time-related type definitions
  bsd-user: Add time system call dispatch
  bsd-user: Add cpu_copy and make init_task_state non-static
  bsd-user: Add os-thread.h with thr and context functions
  bsd-user: Add do_freebsd__umtx_op to os-thread.h
  bsd-user: Add thread system call dispatch
  bsd-user: Add os-extattr.h with file and fd extattr functions
  bsd-user: Add link and list extattr functions to os-extattr.h
  bsd-user: Add ACL system call shims to os-extattr.h
  bsd-user: Add os-extattr.c with ACL conversion functions
  bsd-user: Add extended attribute and ACL system call dispatch
  bsd-user: Add scheduler and cpuset functions to os-misc.h
  bsd-user: Add scheduler, cpuset, kmod, and misc syscall dispatch
  bsd-user: Move qemu_guest_random_seed_main to same as linux-user
  bsd-user Update random_seed on thread creation

 bsd-user/aarch64/target.h     |    2 +-
 bsd-user/arm/target.h         |    2 +-
 bsd-user/bsd-file.h           |  168 +++-
 bsd-user/bsd-mem.h            |    4 +-
 bsd-user/bsd-proc.h           |   26 +-
 bsd-user/bsd-signal.h         |  231 +++++
 bsd-user/bsd-socket.c         |   98 ++
 bsd-user/bsd-socket.h         |  283 ++++++
 bsd-user/freebsd/meson.build  |    8 +-
 bsd-user/freebsd/os-extattr.c |  118 +++
 bsd-user/freebsd/os-extattr.h |  661 +++++++++++++
 bsd-user/freebsd/os-file.h    |  129 +++
 bsd-user/freebsd/os-misc.h    |  466 ++++++++-
 bsd-user/freebsd/os-proc.c    |    4 +-
 bsd-user/freebsd/os-proc.h    |   26 +-
 bsd-user/freebsd/os-signal.h  |   20 +
 bsd-user/freebsd/os-socket.c  |  239 +++++
 bsd-user/freebsd/os-socket.h  |  428 +++++++++
 bsd-user/freebsd/os-sockopt.h |  316 +++++++
 bsd-user/freebsd/os-stat.h    |    8 +-
 bsd-user/freebsd/os-sys.c     |    4 +-
 bsd-user/freebsd/os-syscall.c |  790 ++++++++++++++--
 bsd-user/freebsd/os-thread.c  | 1684 +++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-thread.h  |  596 ++++++++++++
 bsd-user/freebsd/os-time.c    |  347 +++++++
 bsd-user/freebsd/os-time.h    |  989 +++++++++++++++++++
 bsd-user/freebsd/qemu-os.h    |   48 +
 bsd-user/i386/target.h        |    2 +-
 bsd-user/main.c               |   38 +-
 bsd-user/meson.build          |    1 +
 bsd-user/qemu-bsd.h           |    8 +
 bsd-user/qemu.h               |   48 +-
 bsd-user/riscv/target.h       |    2 +-
 bsd-user/signal-common.h      |    4 +
 bsd-user/signal.c             |   67 ++
 bsd-user/syscall_defs.h       |  449 +++++++--
 bsd-user/x86_64/target.h      |    2 +-
 37 files changed, 8110 insertions(+), 206 deletions(-)
 create mode 100644 bsd-user/bsd-signal.h
 create mode 100644 bsd-user/bsd-socket.c
 create mode 100644 bsd-user/bsd-socket.h
 create mode 100644 bsd-user/freebsd/os-extattr.c
 create mode 100644 bsd-user/freebsd/os-extattr.h
 create mode 100644 bsd-user/freebsd/os-file.h
 create mode 100644 bsd-user/freebsd/os-signal.h
 create mode 100644 bsd-user/freebsd/os-socket.c
 create mode 100644 bsd-user/freebsd/os-socket.h
 create mode 100644 bsd-user/freebsd/os-sockopt.h
 create mode 100644 bsd-user/freebsd/os-thread.c
 create mode 100644 bsd-user/freebsd/os-thread.h
 create mode 100644 bsd-user/freebsd/os-time.c
 create mode 100644 bsd-user/freebsd/os-time.h

-- 
2.55.0


