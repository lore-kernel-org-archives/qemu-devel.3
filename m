Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E16CD4851
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzwz-00017X-Tw; Fri, 15 May 2026 17:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzwy-00016k-DZ
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:04 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzwv-0002co-Ms
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:04 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7dbe07d3ec3so166609a34.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880000; x=1779484800;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ruwWonfNQe/D6Drgv8TzvK/TULsZ794e+l0FbEY/rMA=;
 b=uKSoRUDmV6nttPN7J1+B2Q3WmTXJVOcl3gb5vaJ+bcY6eNAz6HtLpWMpu7hCcigVxQ
 hslKykQdJl3kErdb5+6sFe509Trzh4osBJxktI8yrlOZ/l8EOLm6S8WnlpxKamq+uUGv
 uNnj8nPSsZsdp0tbVaJyG3qsm5CXk3MkcmkDymqBqvLiODDgO2hW0+Vrzc+g/tE7LKup
 OZr8ae1mPH2K+OnzsM2N6TLA/S3Hyu6GYV+ILa5yptLthzj5I80YCJaHHh8ojVIsDO8r
 DXX3ZTkKtcVO5y+DWoT2oxZcMzvRWZCpKx3Pf+rcewbFcTYkvrsOH+KcA8RU2jzP0qYQ
 Zqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880000; x=1779484800;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ruwWonfNQe/D6Drgv8TzvK/TULsZ794e+l0FbEY/rMA=;
 b=DoUmCFwgSAQ1p/+aprG5CSXqkzWjmml3521TonjRzTXCcqBZfDrOa1QG3pouI+Kgzu
 ruR5W3DrT2hcjBX4VwHUuknbDgB8/ytOmFTcZo4AujN3USpIAkje/YaQjV8KwMBKOhyX
 CLY3VG3VhWbofpcVIqqRQ+2cR94nckx2B84pPUwcKl8wqCOTSyICz9wN51IX5ZznsqIV
 +ESIuhKRMXBc3n5zjORZ9xCpwLz5NcutLRhQdB8OX4pfiLHir5l8tP4H/6CjdeGoi7qe
 +hQOaJJyXG3TDqjvwXZ5fSxpBGSwSz3El8kl12RcHB1rMLPw8vV5da8xAff5XULYA9+F
 A9cw==
X-Gm-Message-State: AOJu0Yz55tZeDPwnkTJKVGJUw6B7P3g2PgGFyBZvYnl+6Hq2hC/WJ0hE
 BKivNajdGEOrgBglyo4NVTOV9WJoVitsUUkKRNbpzZPYJZ/uMRZbPwhz3G5UGkDediQ=
X-Gm-Gg: Acq92OHaZ3alhesX8G87xuBN6FrwRvnYY1FDh9JiXxUrMLVnKAMifDoPb1OyNafAesm
 qI8Dg89QQ9iQOfOK6G7K3C1BgnE3E1jNgiUn65Ci5dEsn7j5uISD0hOWKTJVMiaiXjx9MxLwQVG
 ysJ/UtHYVy2+bVqRk1DDjvBw3k9oXPL00WWpqh7qp3RuMOY6+QBaWIh2Vj1g1FWHeKovHcY7EJE
 gTfSYTM2f8clScT74msrCKdUH3EsATlHV4WWFtlJXgMdXjQjdRHhF4iqpBwfvBxsygNgrx5wY/5
 ugL+74HIx6OJ9fLavW04sFKWMjDnsr3LC31MZIXzMS0ojaG5nVY30px/rf+L3ny6DF8C1OuQIZc
 4oe00PbdeB3I4hSlMDANovcyunhf8CMk0hRrqlZCRPt3g0wbGRfIZJK3UFwig8yqQ24Y6ldwio3
 /LNZOIw9i3BXy7Ox12YmaE
X-Received: by 2002:a05:6830:660a:b0:7dc:cd0b:58b0 with SMTP id
 46e09a7af769-7e4ea03bab4mr3893560a34.3.1778879999595; 
 Fri, 15 May 2026 14:19:59 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:19:59 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Subject: [PATCH 00/66] bsd-user: Upstream most of the remaining system
 calls
Date: Fri, 15 May 2026 15:18:59 -0600
Message-Id: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMWNB2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUwMT3dzM4mRdEK/QSDfRNDHN2DAx2cDYKFEJqKOgKDUtswJsWnRsbS0
 A95Lbbl0AAAA=
X-Change-ID: 20260504-misc-2026q2-a5af31ac032a
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>, 
 =?utf-8?q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>, 
 Michal Meloun <mmel@FreeBSD.org>, Sean Bruno <sbruno@FreeBSD.org>, 
 Karim Taha <kariem.taha2.7@gmail.com>, Alexander Kabaev <kan@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8538; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=dX6tAdz9JRa8dTaePLNsiDv7Y2imH6DewyDy92lYBTA=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43bbpadwkM4q2E2ELFkbdHOhCdZSlV+PxX1B
 rKikCA/0x2JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN2wAKCRBsHNEofbAR
 AHxlD/9CsTvomdubUGNOprjRMFssypmc4iKeGRPdmghyfQayJ4FMvkk1tjF/a0HYLTHukl4sDY8
 HbEh/InOZKIjG49Cz3XCR2FEYiulUYWUqdtJLRavPbMWAChHBkJLUyh+MzNSbs4xX7W4w25tm7b
 feWMfxDUOjDwZnI6kTiuMo/DlSqYDmFjIiYKKWgT0oTssFdmZ+67STJIW/Rgz4cCuetUeT2471K
 2nQKUlelto+GV/PTnJEUlVycaSgqTKfdxYCmPomEPZGMdLR44NYBz2xB0YLjrJVpP6px8cKs5xa
 hkUUp9uwyRam5h5uyP90S37SDfyA+G4tJOAmpt5xsjq8DkPJEzq7NtnEBoQf+byHtWtBowunj3V
 fCpR2f8ueJOB5LmjaGIaDdCAXWQSkCN6Ah/4YyI6GobKQD9swAuoHobZn3rZmVm0eYIGQW7kYIX
 Ww/eUXJY875HyrksdeR3brLUcLzqykirRFKBw1Rrd4+6E33lhiA15Kvmdl1JT3xaDI3f34+8NOi
 2WtaqgIHVXeXMYb0GQywu1itkD5odccR4Frdl8ctUQPrcSewJYfr41AXYKd9GkRoZt49p2WFDNC
 61YLkmupqPIPS6A1BS4jMNwfEFSuIeBAIotzl3v6L0yL9hLLjYisVK24YHBYLqTw5dESUCBGdT6
 hTr9nkwgGzlnZhw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::331;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x331.google.com
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

Finally, a number of bugs were found late in the process, and not all
were squashed back since the patch series is a bit unwieldy, and it
helps me to make sure I've applied the fixes found during review to
blitz. I know this pushes us past the suggested 50 chunks, but I felt it
important to keep them seprate since Claude identified all the issues. I
think it's important to have another set of eyes on the changes that I
made to fix them. I'd be open to feedback other ways to handle this.

This is a big experiment, in many ways, for me, so I'm interested in
whatever feedback you may have to make things better in the future.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
Warner Losh (66):
      bsd-user: catchup to locking / mapping routines in bsd-misc.
      bsd-user: Rename cpu_env to env throughout bsd-user
      bsd-user: Add bsd-signal.h with sigaction through sigreturn
      bsd-user: Add signal shims sigwait through kill and os-signal.h
      bsd-user: Add signal system call dispatch
      bsd-user: Add poll, lseek, pipe, and swap system call shims
      bsd-user: Add os-file.h with pipe2, chflagsat, close_range, and more
      bsd-user: Add file operation system call dispatch
      bsd-user: Add bsd-socket.h with bind through getsockname
      bsd-user: Add socket shims socketpair through shutdown
      bsd-user: Add os-socket.h with sendrecvmsg and message structures
      bsd-user: Add do_bsd_setsockopt and socket option definitions
      bsd-user: Add do_bsd_getsockopt
      bsd-user: Add FreeBSD socket helpers and sockaddr conversion
      bsd-user: Add os-socket.c with cmsg conversion functions
      bsd-user: Add socket system call dispatch
      bsd-user: Add os-time.h with clock and time-of-day functions
      bsd-user: Add utimes, futimes, and ktimer functions to os-time.h
      bsd-user: Add select, pselect, and ppoll to os-time.h
      bsd-user: Add kqueue and kevent functions to os-time.h
      bsd-user: Add sigtimedwait, itimer, and futimens to os-time.h
      bsd-user: Add os-time.c and time-related type definitions
      bsd-user: Add time system call dispatch
      bsd-user: Add thread, umtx, and ACL type definitions
      bsd-user: Add cpu_copy and make init_task_state non-static
      bsd-user: Add os-thread.h with thr and context functions
      bsd-user: Add do_freebsd__umtx_op to os-thread.h
      bsd-user: Add os-thread.c with umtx, mutex, and thread creation
      bsd-user: Add thread system call dispatch
      bsd-user: Add os-extattr.h with file and fd extattr functions
      bsd-user: Add link and list extattr functions to os-extattr.h
      bsd-user: Add ACL system call shims to os-extattr.h
      bsd-user: Add os-extattr.c with ACL conversion functions
      bsd-user: Add extended attribute and ACL system call dispatch
      bsd-user: Add scheduler and cpuset functions to os-misc.h
      bsd-user: Add kmod, posix, and misc functions to os-misc.h
      bsd-user: Add scheduler, cpuset, kmod, and misc syscall dispatch
      bsd-user: Remove dead watchpoint code from cpu_copy
      bsd-user: Fix cpu_copy to initialize new_cpu queues, not source
      bsd-user: Free CPU state and TaskState on thread creation failure
      bsd-user: Fix kenv KENV_SET to not write back read-only buffer
      bsd-user: Fix freebsd_lock_umutex to re-read m_owner not m_count
      bsd-user: Fix problem with extattr_* routines
      bsd-user: do_freebsd__acl_aclcheck_file pass type to __acl_aclcheck_file
      bsd-user: Unlock in h2t_freebsd_ntptimeval
      bsd-user: freebsd_umtx_mutex_wake2 fix unlock_user
      bsd-user: In do_freebsd_thr_new, use unlock_user_struct
      bsd-user: h2t_freebsd_cmsg should use SCM_TIMEOUT
      bsd-user: sendto/recvfrom need + 1 too for addrlen
      bsd-user: __acl_aclcheck_file should check t2h_freebsd_acl_type
      bsd-user: do_freebsd_ppoll: unlock target_pfds in error paths
      bsd-user: Return -TARGET_EINVAL rather than EINVAL
      bsd-user: t2h_freebsd_cmsg use host not target values
      bsd-user: Validate acl_maxcnt
      bsd-user: Convert TARGET_SO_SNDLOWAT to SO_SNDLOWAT not SO_RCVLOWAT
      bsd-user: os-time.c -- Fix copy in time conversion rotuines
      bsd-user: Fix gettimeofday's writeback to tz
      bsd-user: settimeofday should copy the data in, but not out
      bsd-user: unlock the start of the cmsg
      bsd-user: Don't leak fd's when we can't writeback in do_bsd_pipe2
      bsd-user: freebsd_rw_rdlock and freebsd_rw_wrlock fix missed decrement
      bsd-user: freebsd_rw_wrlock needs to unlock_user_struct on this path
      bsd-user: Don't write back length on kenv error
      bsd-user: avoid writeback in do_freebsd_extattr_set_*
      bsd-user: In specialfd, we need to copyin target_eventfd
      bsd-user: freebsd_unlock_umutex: make flags 32 bits

 bsd-user/aarch64/target.h     |    2 +-
 bsd-user/arm/target.h         |    2 +-
 bsd-user/bsd-file.h           |  164 +++-
 bsd-user/bsd-mem.h            |    4 +-
 bsd-user/bsd-proc.h           |   24 +-
 bsd-user/bsd-signal.h         |  231 ++++++
 bsd-user/bsd-socket.c         |   98 +++
 bsd-user/bsd-socket.h         |  274 +++++++
 bsd-user/freebsd/meson.build  |    8 +-
 bsd-user/freebsd/os-extattr.c |  116 +++
 bsd-user/freebsd/os-extattr.h |  662 ++++++++++++++++
 bsd-user/freebsd/os-file.h    |  128 ++++
 bsd-user/freebsd/os-misc.h    |  470 +++++++++++-
 bsd-user/freebsd/os-proc.c    |    4 +-
 bsd-user/freebsd/os-proc.h    |   26 +-
 bsd-user/freebsd/os-signal.h  |   20 +
 bsd-user/freebsd/os-socket.c  |  234 ++++++
 bsd-user/freebsd/os-socket.h  |  764 +++++++++++++++++++
 bsd-user/freebsd/os-stat.h    |   10 +
 bsd-user/freebsd/os-sys.c     |    4 +-
 bsd-user/freebsd/os-syscall.c |  790 +++++++++++++++++--
 bsd-user/freebsd/os-thread.c  | 1674 +++++++++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-thread.h  |  596 +++++++++++++++
 bsd-user/freebsd/os-time.c    |  316 ++++++++
 bsd-user/freebsd/os-time.h    |  978 ++++++++++++++++++++++++
 bsd-user/freebsd/qemu-os.h    |   47 ++
 bsd-user/i386/target.h        |    2 +-
 bsd-user/main.c               |   32 +-
 bsd-user/meson.build          |    1 +
 bsd-user/qemu-bsd.h           |   26 +
 bsd-user/qemu.h               |   48 +-
 bsd-user/riscv/target.h       |    2 +-
 bsd-user/signal-common.h      |    4 +
 bsd-user/signal.c             |   67 ++
 bsd-user/syscall_defs.h       |  458 +++++++++--
 bsd-user/x86_64/target.h      |    2 +-
 36 files changed, 8099 insertions(+), 189 deletions(-)
---
base-commit: edcc429e9e41a8e0e415dcdab6aa52ad17ef8889
change-id: 20260504-misc-2026q2-a5af31ac032a

Best regards,
-- 
Warner Losh <imp@bsdimp.com>


