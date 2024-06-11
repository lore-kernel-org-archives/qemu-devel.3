Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D376C27C5E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 04:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGtMs-0002SN-Ow; Tue, 11 Jun 2024 00:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sGtMr-0002Ro-5g; Tue, 11 Jun 2024 00:44:21 -0400
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sGtMo-00019h-22; Tue, 11 Jun 2024 00:44:20 -0400
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-4df550a4d4fso171823e0c.2; 
 Mon, 10 Jun 2024 21:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718081056; x=1718685856; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ai9o3PIQxKLXr/dQNzDCMS6JTfA9S+JRLVnyQWbTPDo=;
 b=MnYkZD01+g2yVNi4uI1PHFKLffMIfya680ki5M8vcswfaZRACksJ0cO9i6HtAiLe2q
 Tba6gx/t+x9gamdSmsfch2GejKFloh/mOstyAwgjVG8X6f2PoimBAmgwXuprvQKz+7vx
 NRNLSz4oc+MEuRQtc4p95c5W1PZf4ViWDEKn5NhfZsU+GGgZOti6M/c7L3ZcrH9ONfQa
 FdlyKDIyamycn3lriVILP9AmVfLxJZagWz1QnXdiguHcjSrRmWtJOwWjvxB/YCXBJ8m1
 MvU/dZ1glPJ/qD0x8Fp+SRA9ZBFS46ppULI0TgPnL/yNP74elyxn3NrYbEGHe7U+1A4j
 yifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718081056; x=1718685856;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ai9o3PIQxKLXr/dQNzDCMS6JTfA9S+JRLVnyQWbTPDo=;
 b=hoQQeBlPzsjIPiHcdEgekJjH9sJESkCE6o2KJ5FwrkvJbLfZljUvHOABak1L8epKwG
 pqnDXwFhqRPAr4LYEiYsujEbNOw9puM6kIE7o1mwi7OeavKhYUIdkkg3ScommKk957KV
 hsqgcfEhVIykwadBrD8YA+aEkELf5y43At8eMkDcIFsFitzmj6aexkltFsHHrgKBmbTT
 UuHTeagJzd4K8PTuhesP6PNYKWnUY5FQKKrftJnIcTlSkJ6oKyXYdeo5fhGSJFe9KY3k
 x0OcDCfuinESIAFNJDOBkYEhLBec3oN67/tknlon1oLpn1glQycAvnIRIvMFnVNqjJaJ
 84oA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLLWJbFq+XD9rMErZar4HNDU3Q4Y4KkdnB9i0qOSZNyQKaA0GmBnKtD56491NSufd5hsCHeRuIefcPddkheSIwX9BtAds=
X-Gm-Message-State: AOJu0Ywpi5THUVbSSYEowpYH3qzxOM61n4dskXmVJwFYtigeeRBuV5U6
 JBLiCEYdVsEGwaY0q21TnCzxcTSUGfr40bnOJ1RiyAr8Kmf1t3XHGHVkfTuCFjRCGAh0FULsD/y
 59r7sWXB5HRyGtH0S39xDXLIGgCz/1du2
X-Google-Smtp-Source: AGHT+IFC/y9b8lkzjx+zEw5aUZT7pQbnKcGXgryZzAbY5YbyEbC2WkdzjNlRGAg7yX7XDPHw+2EfuaPqQdbIn3UsU/s=
X-Received: by 2002:a05:6122:2641:b0:4d3:45a2:ae53 with SMTP id
 71dfb90a1353d-4eb562e8e98mr7345203e0c.16.1718081056319; Mon, 10 Jun 2024
 21:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <10817413.NyiUUSuA9g@pinacolada> <6353228.kQq0lBPeGt@pinacolada>
 <CAKmqyKP2cSh-U8s9hJfLH1GSsEHXQaL0xjd=s19WCzLdeyOPTA@mail.gmail.com>
 <5239676.BddDVKsqQX@pinacolada>
In-Reply-To: <5239676.BddDVKsqQX@pinacolada>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 11 Jun 2024 14:43:49 +1000
Message-ID: <CAKmqyKMRpSis8uaQVs_FTawtC-nwsFj8t7AVjrTNM4DQr-5pYw@mail.gmail.com>
Subject: Re: qemu-riscv32 usermode still broken?
To: "Andreas K. Huettel" <dilfridge@gentoo.org>
Cc: qemu-devel@nongnu.org, "open list:RISC-V" <qemu-riscv@nongnu.org>, 
 LIU Zhiwei <baxiantai@gmail.com>, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a34;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa34.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Sep 20, 2023 at 6:39=E2=80=AFAM Andreas K. Huettel <dilfridge@gento=
o.org> wrote:
>
> Hi Alistair,
>
> > It would be great to get a strace of the failure to narrow down what
> > it is. From there it should be not too hard to find and fix.
>
> thanks a lot. Here's as much info as I could get with strace mechanisms.
>
> 1) What I did, without any tracing
>
> pinacolada ~ # qemu-riscv32 -L /var/lib/machines/riscv32 /var/lib/machine=
s/riscv32/bin/bash
> pinacolada ~ # python
> Python 3.11.5 (main, Aug 27 2023, 18:39:05) [GCC 12.3.1 20230623] on linu=
x
> Type "help", "copyright", "credits" or "license" for more information.
> >>>
> [1]+  Stopped                 python
> ^C^C
> pinacolada ~ # ^C
> pinacolada ~ # fg
> python
>
> pinacolada ~ #
> exit
>
> * When I type Ctrl-Z at the python prompt, the terminal hangs.
> * With several Ctrl-C I can get back to the riscv32 bash, and then python=
 is suspended in the background.
>
> * Now I did this again, first with qemu tracing system calls, then with s=
trace tracing qemu
> * In both cases, the log starts when I type "python", and ends (with quic=
kly repeated output lines)
>   after pressing Ctrl-Z
>
> 2)
> pinacolada ~ # QEMU_STRACE=3D1 qemu-riscv32 -L /var/lib/machines/riscv32 =
/var/lib/machines/riscv32/bin/bash
> (QEMU_STRACE is getting unset in my bashrc, so no subprocesses are traced=
)
>
> (...)
> 2472050 write(2,0xe56c0,58)pinacolada ~ #  =3D 58
> 2472050 Unknown syscall 413
> 2472050 read(0,0x2b2aa29b,1) =3D 1
> 2472050 Unknown syscall 413
> 2472050 write(2,0xe56c0,1)p =3D 1
> 2472050 Unknown syscall 413
> 2472050 read(0,0x2b2aa29b,1) =3D 1
> 2472050 Unknown syscall 413
> 2472050 write(2,0xe56c0,1)y =3D 1
> 2472050 Unknown syscall 413
> 2472050 read(0,0x2b2aa29b,1) =3D 1
> 2472050 Unknown syscall 413
> 2472050 write(2,0xe56c0,1)t =3D 1
> 2472050 Unknown syscall 413
> 2472050 read(0,0x2b2aa29b,1) =3D 1
> 2472050 Unknown syscall 413
> 2472050 write(2,0xe56c0,1)h =3D 1
> 2472050 Unknown syscall 413
> 2472050 read(0,0x2b2aa29b,1) =3D 1
> 2472050 Unknown syscall 413
> 2472050 write(2,0xe56c0,1)o =3D 1
> 2472050 Unknown syscall 413
> 2472050 read(0,0x2b2aa29b,1) =3D 1
> 2472050 Unknown syscall 413
> 2472050 write(2,0xe56c0,1)n =3D 1
> 2472050 Unknown syscall 413
> 2472050 read(0,0x2b2aa29b,1) =3D 1
> 2472050 write(2,0xe56c0,1)
>  =3D 1
>  =3D 9050 write(2,0xe56c0,9)
> 2472050 ioctl(0,TCSETSW,{c_iflag =3D ICRNL|IXON|IXOFF|IUTF8,c_oflag =3D O=
POST|ONLCR,c_cflag =3D B38400,CS8,CREAD,c_lflag =3D ISIG|ICANON|ECHO|ECHOE|=
ECHOK|ECHOCTL|ECHOKE|IEXTEN,c_cc =3D "",c_line =3D ''}) =3D 0
> 2472050 rt_sigaction(SIGINT,0x2b2aa1bc,0x2b2aa244) =3D 0
> 2472050 rt_sigaction(SIGHUP,0x2b2aa1bc,0x2b2aa244) =3D 0
> 2472050 rt_sigaction(SIGALRM,0x2b2aa1bc,0x2b2aa244) =3D 0
> 2472050 rt_sigaction(SIGWINCH,0x2b2aa1bc,0x2b2aa244) =3D 0
> 2472050 rt_sigaction(SIGINT,0x2b2aa14c,0x2b2aa1d4) =3D 0
> 2472050 clock_gettime64(CLOCK_REALTIME_COARSE,0x2b2aa268) =3D 0 ({tv_sec=
=3D1695154794,tv_nsec=3D760883171})
> 2472050 statx(AT_FDCWD,".",AT_NO_AUTOMOUNT|AT_STATX_SYNC_AS_STAT,STATX_BA=
SIC_STATS,0x2b2aaa78) =3D 0
> 2472050 statx(AT_FDCWD,"/usr/local/sbin/python",AT_NO_AUTOMOUNT|AT_STATX_=
SYNC_AS_STAT,STATX_BASIC_STATS,0x2b2aa998) =3D -1 errno=3D2 (No such file o=
r directory)
> 2472050 statx(AT_FDCWD,"/usr/local/bin/python",AT_NO_AUTOMOUNT|AT_STATX_S=
YNC_AS_STAT,STATX_BASIC_STATS,0x2b2aa998) =3D -1 errno=3D2 (No such file or=
 directory)
> 2472050 statx(AT_FDCWD,"/usr/sbin/python",AT_NO_AUTOMOUNT|AT_STATX_SYNC_A=
S_STAT,STATX_BASIC_STATS,0x2b2aa998) =3D -1 errno=3D2 (No such file or dire=
ctory)
> 2472050 statx(AT_FDCWD,"/usr/bin/python",AT_NO_AUTOMOUNT|AT_STATX_SYNC_AS=
_STAT,STATX_BASIC_STATS,0x2b2aa998) =3D 0
> 2472050 statx(AT_FDCWD,"/usr/bin/python",AT_NO_AUTOMOUNT|AT_STATX_SYNC_AS=
_STAT,STATX_BASIC_STATS,0x2b2aa8e8) =3D 0
> 2472050 geteuid() =3D 0
> 2472050 getegid() =3D 0
> 2472050 getuid() =3D 0
> 2472050 getgid() =3D 0
> 2472050 faccessat(AT_FDCWD,"/usr/bin/python",X_OK,AT_SYMLINK_NOFOLLOW|0x1=
da42089) =3D 0
> 2472050 statx(AT_FDCWD,"/usr/bin/python",AT_NO_AUTOMOUNT|AT_STATX_SYNC_AS=
_STAT,STATX_BASIC_STATS,0x2b2aa8e8) =3D 0
> 2472050 geteuid() =3D 0
> 2472050 getegid() =3D 0
> 2472050 getuid() =3D 0
> 2472050 getgid() =3D 0
> 2472050 faccessat(AT_FDCWD,"/usr/bin/python",R_OK,AT_SYMLINK_NOFOLLOW|0x1=
da42089) =3D 0
> 2472050 rt_sigprocmask(SIG_BLOCK,NULL,0x2b2aabec,8) =3D 0
> 2472050 rt_sigprocmask(SIG_BLOCK,0x2b2aaaec,0x2b2aab6c,8) =3D 0
> 2472050 rt_sigaction(SIGTERM,0x2b2aa85c,0x2b2aa8e4) =3D 0
> 2472050 rt_sigprocmask(SIG_BLOCK,0x2b2aa98c,0x2b2aaa0c,8) =3D 0
> 2472050 rt_sigprocmask(SIG_SETMASK,0x2b2aaa0c,NULL,8) =3D 0
> 2472050 pipe2(0x5560d3f4,0) =3D 0
> 2472050 clone(CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|0x11,child_stack=3D=
0x00000000,parent_tidptr=3D0x00000000,tls=3D0x00000000,child_tidptr=3D0x2b2=
d20c8) =3D 2472055
> 2472050 rt_sigaction(SIGTERM,0x2b2aa85c,0x2b2aa8e4) =3D 0
>  =3D 0
> 2472050 setpgid(2472055,2472055) =3D 0
> 2472055 set_robust_list(0x2b2d20cc,12) =3D 2472050 rt_sigprocmask(SIG_SET=
MASK,0x2b2aab6c,-1 errno=3D38 (Function not implemented)NULL,
> 8) =3D 0
> 2472055 getpid() =3D 2472055
> 2472055 rt_sigprocmask(SIG_SETMASK,0x55616e24,NULL,8) =3D 0
> 2472050 rt_sigprocmask(SIG_BLOCK,0x2b2aaaac,0x2b2aab2c,8) =3D 0
> 2472050 close(3) =3D 0
> 2472050 close(4) =3D 0
> 2472055 rt_sigaction(SIGTSTP,0x2b2aa84c,0x2b2aa8d4) =3D 0
> 2472055 rt_sigaction(SIGTTIN,0x2b2aa84c,0x2b2aa8d4) =3D 0
> 2472055 rt_sigaction(SIGTTOU,0x2b2aa85c,0x2b2aa8e4) =3D 0
> 2472055 setpgid(2472055,2472055) =3D 0
> 2472055 rt_sigprocmask(SIG_BLOCK,0x2b2aa99c,0x2b2aaa1c,8) =3D 0
> 2472055 ioctl(255,TIOCSPGRP,2472055) =3D 0
> 2472055 rt_sigprocmask(SIG_SETMASK,0x2b2aaa1c,NULL,8) =3D 0
> 2472050 ioctl(255,TIOCGPGRP,0x2b2aaa78) =3D 0 (2472055)2472055
> close(4) =3D 0
> 2472050 rt_sigprocmask(SIG_SETMASK,0x2b2aab2c,NULL,2472055 8)read(3,0x2b2=
aaaeb,1) =3D 0 =3D
> 0
> 2472055 close(3) =3D 0
> 2472050 rt_sigprocmask(SIG_BLOCK,0x2b2aabac,0x2b2aac2c,8) =3D 0
> 2472055 rt_sigaction(SIGHUP,0x2b2aaacc,NULL) =3D 0
> 2472055 rt_sigaction(SIGILL,0x2b2aaacc,NULL) =3D 0
> 2472055 rt_sigaction(SIGTRAP,0x2b2aaacc,NULL) =3D 0
> 2472055 rt_sigaction(SIGIOT,0x2b2aaacc,NULL) =3D 0
> 2472055 rt_sigaction(SIGFPE,0x2b2aaacc,NULL) =3D 0
> 2472055 rt_sigaction(SIGBUS,0x2b2aaacc,NULL) =3D 0
> 2472055 rt_sigaction(SIGSEGV,0x2b2aaacc,NULL) =3D 0
> 2472055 rt_sigaction(SIGSYS,0x2b2aaacc,NULL) =3D 0
> 2472055 rt_sigaction(SIGPIPE,0x2b2aaacc,NULL) =3D 0
> 2472050 2472055 waitid(0,-1,0x2b2aaa7c,0xe)rt_sigaction(SIGALRM,0x2b2aaac=
c,NULL) =3D 0
> 2472055 rt_sigaction(SIGXCPU,0x2b2aaacc,NULL) =3D 0
> 2472055 rt_sigaction(SIGXFSZ,0x2b2aaacc,NULL) =3D 0
> 2472055 rt_sigaction(SIGVTALRM,0x2b2aaacc,NULL) =3D 0
> 2472055 rt_sigaction(SIGUSR1,0x2b2aaacc,NULL) =3D 0
> 2472055 rt_sigaction(SIGUSR2,0x2b2aaacc,NULL) =3D 0
> 2472055 rt_sigaction(SIGINT,0x2b2aaa0c,0x2b2aaa94) =3D 0
> 2472055 rt_sigaction(SIGQUIT,0x2b2aaa0c,0x2b2aaa94) =3D 0
> 2472055 rt_sigaction(SIGTERM,0x2b2aaa0c,0x2b2aaa94) =3D 0
> 2472055 rt_sigaction(SIGCHLD,0x2b2aaa0c,0x2b2aaa94) =3D 0
> 2472055 execve("/usr/bin/python",{"python",NULL})Python 3.11.5 (main, Aug=
 27 2023, 18:39:05) [GCC 12.3.1 20230623] on linux
> Type "help", "copyright", "credits" or "license" for more information.
> >>>  =3D 0
> 2472050 rt_sigprocmask(SIG_BLOCK,0x2b2aa9ec,0x2b2aaa6c,8) =3D 0
> 2472050 rt_sigprocmask(SIG_SETMASK,0x2b2aaa6c,NULL,8) =3D 0
> 2472050 rt_sigprocmask(SIG_BLOCK,0x2b2aa9ec,0x2b2aaa6c,8) =3D 0
> 2472050 rt_sigprocmask(SIG_SETMASK,0x2b2aaa6c,NULL,8) =3D 0
> 2472050 rt_sigprocmask(SIG_BLOCK,0x2b2aaa6c,0x2b2aaaec,8) =3D 0
> 2472050 ioctl(255,TIOCSPGRP,2472050) =3D 0
> 2472050 rt_sigprocmask(SIG_SETMASK,0x2b2aaaec,NULL,8) =3D 0
> 2472050 ioctl(255,TCSETSW,{c_iflag =3D ICRNL|IXON|IXOFF|IUTF8,c_oflag =3D=
 OPOST|ONLCR,c_cflag =3D B38400,CS8,CREAD,c_lflag =3D ISIG|ICANON|ECHO|ECHO=
E|ECHOK|ECHOCTL|ECHOKE|IEXTEN,c_cc =3D "",c_line =3D ''}) =3D 0
> 2472050 ioctl(255,TIOCGWINSZ,0x2b2aab74) =3D 0 ({49,194,1749,896})
> 2472050 write(2,0xe56c0,1)
>  =3D 1
> 2472050 openat(AT_FDCWD,"/usr/share/locale/locale.alias",O_RDONLY|O_LARGE=
FILE|O_CLOEXEC) =3D 3
> 2472050 statx(3,"",AT_EMPTY_PATH|AT_NO_AUTOMOUNT|AT_STATX_SYNC_AS_STAT,ST=
ATX_BASIC_STATS,0x2b2aa3b8) =3D 0
> 2472050 read(3,0xf4d00,4096) =3D 2998
> 2472050 read(3,0xf4d00,4096) =3D 0
> 2472050 close(3) =3D 0
> 2472050 openat(AT_FDCWD,"/usr/share/locale/en_US.utf8/LC_MESSAGES/bash.mo=
",O_RDONLY|O_LARGEFILE) =3D -1 errno=3D2 (No such file or directory)
> 2472050 openat(AT_FDCWD,"/usr/share/locale/en_US/LC_MESSAGES/bash.mo",O_R=
DONLY|O_LARGEFILE) =3D -1 errno=3D2 (No such file or directory)
> 2472050 openat(AT_FDCWD,"/usr/share/locale/en.utf8/LC_MESSAGES/bash.mo",O=
_RDONLY|O_LARGEFILE) =3D -1 errno=3D2 (No such file or directory)
> 2472050 openat(AT_FDCWD,"/usr/share/locale/en/LC_MESSAGES/bash.mo",O_RDON=
LY|O_LARGEFILE) =3D -1 errno=3D2 (No such file or directory)
> 2472050 write(2,0xe56c0,37)[1]+  Stopped                 python
>  =3D 37
> 2472050 rt_sigprocmask(SIG_SETMASK,0x2b2aac2c,NULL,8) =3D 0
> --- SIGCHLD {si_signo=3DSIGCHLD, si_code=3D5, si_pid=3D2472055, si_uid=3D=
0, si_status=3D20, si_utime=3D2, si_stime=3D0} ---
> 2472050 waitid(0,-1,0x2b2aa70c,0xf) =3D 0
> 2472050 waitid(0,-1,0x2b2aa70c,0xf) =3D 0
> 2472050 waitid(0,-1,0x2b2aa70c,0xf) =3D 0
> 2472050 waitid(0,-1,0x2b2aa70c,0xf) =3D 0
> 2472050 waitid(0,-1,0x2b2aa70c,0xf) =3D 0
> 2472050 waitid(0,-1,0x2b2aa70c,0xf) =3D 0
> 2472050 waitid(0,-1,0x2b2aa70c,0xf) =3D 0
> 2472050 waitid(0,-1,0x2b2aa70c,0xf) =3D 0
> 2472050 waitid(0,-1,0x2b2aa70c,0xf) =3D 0
> 2472050 waitid(0,-1,0x2b2aa70c,0xf) =3D 0
> 2472050 waitid(0,-1,0x2b2aa70c,0xf) =3D 0
> 2472050 waitid(0,-1,0x2b2aa70c,0xf) =3D 0
> 2472050 waitid(0,-1,0x2b2aa70c,0xf) =3D 0
> 2472050 waitid(0,-1,0x2b2aa70c,0xf) =3D 0
> (...)
>
> 3)
> pinacolada ~ # strace qemu-riscv32 -L /var/lib/machines/riscv32 /var/lib/=
machines/riscv32/bin/bash
>
> (...)
> write(2, "\33]0;root@pinacolada:~\7\33[01;31mpi"..., 58pinacolada ~ # ) =
=3D 58
> pselect6(1, [0], NULL, NULL, NULL, {sigmask=3D[], sigsetsize=3D8}) =3D 1 =
(in [0])
> read(0, "p", 1)                         =3D 1
> pselect6(1, [0], NULL, [0], {tv_sec=3D0, tv_nsec=3D0}, NULL) =3D 0 (Timeo=
ut)
> write(2, "p", 1p)                        =3D 1
> pselect6(1, [0], NULL, NULL, NULL, {sigmask=3D[], sigsetsize=3D8}) =3D 1 =
(in [0])
> read(0, "y", 1)                         =3D 1
> pselect6(1, [0], NULL, [0], {tv_sec=3D0, tv_nsec=3D0}, NULL) =3D 0 (Timeo=
ut)
> write(2, "y", 1y)                        =3D 1
> pselect6(1, [0], NULL, NULL, NULL, {sigmask=3D[], sigsetsize=3D8}) =3D 1 =
(in [0])
> read(0, "t", 1)                         =3D 1
> pselect6(1, [0], NULL, [0], {tv_sec=3D0, tv_nsec=3D0}, NULL) =3D 0 (Timeo=
ut)
> write(2, "t", 1t)                        =3D 1
> pselect6(1, [0], NULL, NULL, NULL, {sigmask=3D[], sigsetsize=3D8}) =3D 1 =
(in [0])
> read(0, "h", 1)                         =3D 1
> pselect6(1, [0], NULL, [0], {tv_sec=3D0, tv_nsec=3D0}, NULL) =3D 0 (Timeo=
ut)
> write(2, "h", 1h)                        =3D 1
> pselect6(1, [0], NULL, NULL, NULL, {sigmask=3D[], sigsetsize=3D8}) =3D 1 =
(in [0])
> read(0, "o", 1)                         =3D 1
> pselect6(1, [0], NULL, [0], {tv_sec=3D0, tv_nsec=3D0}, NULL) =3D 0 (Timeo=
ut)
> write(2, "o", 1o)                        =3D 1
> pselect6(1, [0], NULL, NULL, NULL, {sigmask=3D[], sigsetsize=3D8}) =3D 1 =
(in [0])
> read(0, "n", 1)                         =3D 1
> pselect6(1, [0], NULL, [0], {tv_sec=3D0, tv_nsec=3D0}, NULL) =3D 0 (Timeo=
ut)
> write(2, "n", 1n)                        =3D 1
> pselect6(1, [0], NULL, NULL, NULL, {sigmask=3D[], sigsetsize=3D8}) =3D 1 =
(in [0])
> read(0, "\r", 1)                        =3D 1
> write(2, "\n", 1
> )                       =3D 1
> )             =3D 904l\r", 9
> ioctl(0, TCSETSW, {c_iflag=3DICRNL|IXON|IXOFF|IUTF8, c_oflag=3DNL0|CR0|TA=
B0|BS0|VT0|FF0|OPOST|ONLCR, c_cflag=3DB38400|CS8|CREAD, c_lflag=3DISIG|ICAN=
ON|ECHO|ECHOE|ECHOK|IEXTEN|ECHOCTL|ECHOKE, ...}) =3D 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> rt_sigaction(SIGINT, {sa_handler=3D0x4c2160, sa_mask=3D~[RTMIN RT_1], sa_=
flags=3DSA_RESTORER|SA_SIGINFO, sa_restorer=3D0x5cdb50}, NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> rt_sigaction(SIGHUP, {sa_handler=3D0x4c2160, sa_mask=3D~[RTMIN RT_1], sa_=
flags=3DSA_RESTORER|SA_SIGINFO, sa_restorer=3D0x5cdb50}, NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> rt_sigaction(SIGALRM, {sa_handler=3D0x4c2160, sa_mask=3D~[RTMIN RT_1], sa=
_flags=3DSA_RESTORER|SA_SIGINFO, sa_restorer=3D0x5cdb50}, NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> rt_sigaction(SIGWINCH, {sa_handler=3D0x4c2160, sa_mask=3D~[RTMIN RT_1], s=
a_flags=3DSA_RESTORER|SA_RESTART|SA_SIGINFO, sa_restorer=3D0x5cdb50}, NULL,=
 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> rt_sigaction(SIGINT, {sa_handler=3D0x4c2160, sa_mask=3D~[RTMIN RT_1], sa_=
flags=3DSA_RESTORER|SA_SIGINFO, sa_restorer=3D0x5cdb50}, NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) =3D 0
> statx(AT_FDCWD, ".", AT_STATX_SYNC_AS_STAT|AT_NO_AUTOMOUNT, STATX_BASIC_S=
TATS, {stx_mask=3DSTATX_BASIC_STATS|STATX_MNT_ID, stx_attributes=3D0, stx_m=
ode=3DS_IFDIR|0700, stx_size=3D16384, ...}) =3D 0
> statx(AT_FDCWD, "/usr/local/sbin/python", AT_STATX_SYNC_AS_STAT|AT_NO_AUT=
OMOUNT, STATX_BASIC_STATS, 0x7fff3f875900) =3D -1 ENOENT (No such file or d=
irectory)
> statx(AT_FDCWD, "/usr/local/bin/python", AT_STATX_SYNC_AS_STAT|AT_NO_AUTO=
MOUNT, STATX_BASIC_STATS, 0x7fff3f875900) =3D -1 ENOENT (No such file or di=
rectory)
> statx(AT_FDCWD, "/usr/sbin/python", AT_STATX_SYNC_AS_STAT|AT_NO_AUTOMOUNT=
, STATX_BASIC_STATS, 0x7fff3f875900) =3D -1 ENOENT (No such file or directo=
ry)
> statx(AT_FDCWD, "/usr/bin/python", AT_STATX_SYNC_AS_STAT|AT_NO_AUTOMOUNT,=
 STATX_BASIC_STATS, {stx_mask=3DSTATX_BASIC_STATS|STATX_MNT_ID, stx_attribu=
tes=3D0, stx_mode=3DS_IFREG|0755, stx_size=3D18808, ...}) =3D 0
> statx(AT_FDCWD, "/usr/bin/python", AT_STATX_SYNC_AS_STAT|AT_NO_AUTOMOUNT,=
 STATX_BASIC_STATS, {stx_mask=3DSTATX_BASIC_STATS|STATX_MNT_ID, stx_attribu=
tes=3D0, stx_mode=3DS_IFREG|0755, stx_size=3D18808, ...}) =3D 0
> geteuid()                               =3D 0
> getegid()                               =3D 0
> getuid()                                =3D 0
> getgid()                                =3D 0
> faccessat2(AT_FDCWD, "/usr/bin/python", X_OK, 0) =3D 0
> statx(AT_FDCWD, "/usr/bin/python", AT_STATX_SYNC_AS_STAT|AT_NO_AUTOMOUNT,=
 STATX_BASIC_STATS, {stx_mask=3DSTATX_BASIC_STATS|STATX_MNT_ID, stx_attribu=
tes=3D0, stx_mode=3DS_IFREG|0755, stx_size=3D18808, ...}) =3D 0
> geteuid()                               =3D 0
> getegid()                               =3D 0
> getuid()                                =3D 0
> getgid()                                =3D 0
> faccessat2(AT_FDCWD, "/usr/bin/python", R_OK, 0) =3D 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, [INT TERM CHLD], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> rt_sigaction(SIGTERM, {sa_handler=3D0x4c2160, sa_mask=3D~[RTMIN RT_1], sa=
_flags=3DSA_RESTORER|SA_SIGINFO, sa_restorer=3D0x5cdb50}, NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, [INT TERM CHLD], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, [INT TERM CHLD], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, [INT TERM CHLD], NULL, 8) =3D 0
> pipe2([3, 4], 0)                        =3D 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> clone(child_stack=3DNULL, flags=3DCLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID=
|SIGCHLD, child_tidptr=3D0x228b790) =3D 2472081
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, [INT TERM CHLD], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> rt_sigaction(SIGTERM, {sa_handler=3DSIG_IGN, sa_mask=3D~[RTMIN RT_1], sa_=
flags=3DSA_RESTORER|SA_SIGINFO, sa_restorer=3D0x5cdb50}, NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, [INT TERM CHLD], NULL, 8) =3D 0
> setpgid(2472081, 2472081)               =3D 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, [CHLD], NULL, 8) =3D 0
> close(3)                                =3D 0
> close(4)                                =3D 0
> ioctl(255, TIOCGPGRP, [2472081])        =3D 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, [CHLD], NULL, 8) =3D 0
> waitid(P_ALL, -1, Python 3.11.5 (main, Aug 27 2023, 18:39:05) [GCC 12.3.1=
 20230623] on linux
> Type "help", "copyright", "credits" or "license" for more information.
> >>> {si_signo=3DSIGCHLD, si_code=3DCLD_STOPPED, si_pid=3D2472081, si_uid=
=3D0, si_status=3DSIGTSTP, si_utime=3D140734259223024 /* 1407342592230.24 s=
 */, si_stime=3D4923637 /* 49236.37 s */}, WEXITED|WSTOPPED|WCONTINUED, NUL=
L) =3D 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, [CHLD], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, [CHLD], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, [CHLD], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, [CHLD], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, [CHLD TSTP TTIN TTOU], NULL, 8) =3D 0
> ioctl(255, TIOCSPGRP, [2472076])        =3D 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, [CHLD], NULL, 8) =3D 0
> ioctl(255, TCSETSW, {c_iflag=3DICRNL|IXON|IXOFF|IUTF8, c_oflag=3DNL0|CR0|=
TAB0|BS0|VT0|FF0|OPOST|ONLCR, c_cflag=3DB38400|CS8|CREAD, c_lflag=3DISIG|IC=
ANON|ECHO|ECHOE|ECHOK|IEXTEN|ECHOCTL|ECHOKE, ...}) =3D 0
> ioctl(255, TIOCGWINSZ, {ws_row=3D49, ws_col=3D194, ws_xpixel=3D1749, ws_y=
pixel=3D896}) =3D 0
> write(2, "\n", 1
> )                       =3D 1
> futex(0x8800f8, FUTEX_WAKE_PRIVATE, 2147483647) =3D 0
> readlink("/usr", 0x7fff3f8742a0, 1023)  =3D -1 EINVAL (Invalid argument)
> readlink("/usr/share", 0x7fff3f8742a0, 1023) =3D -1 EINVAL (Invalid argum=
ent)
> readlink("/usr/share/locale", 0x7fff3f8742a0, 1023) =3D -1 EINVAL (Invali=
d argument)
> readlink("/usr/share/locale/locale.alias", 0x7fff3f8742a0, 1023) =3D -1 E=
INVAL (Invalid argument)
> access("/var/lib/machines/riscv32/usr/share/locale/locale.alias", F_OK) =
=3D 0
> openat(AT_FDCWD, "/var/lib/machines/riscv32/usr/share/locale/locale.alias=
", O_RDONLY|O_CLOEXEC) =3D 3
> statx(3, "", AT_STATX_SYNC_AS_STAT|AT_NO_AUTOMOUNT|AT_EMPTY_PATH, STATX_B=
ASIC_STATS, {stx_mask=3DSTATX_ALL|STATX_MNT_ID, stx_attributes=3D0, stx_mod=
e=3DS_IFREG|0644, stx_size=3D2998, ...}) =3D 0
> read(3, "# Locale name alias data base.\n#"..., 4096) =3D 2998
> read(3, "", 4096)                       =3D 0
> close(3)                                =3D 0
> readlink("/usr", 0x7fff3f8742a0, 1023)  =3D -1 EINVAL (Invalid argument)
> readlink("/usr/share", 0x7fff3f8742a0, 1023) =3D -1 EINVAL (Invalid argum=
ent)
> readlink("/usr/share/locale", 0x7fff3f8742a0, 1023) =3D -1 EINVAL (Invali=
d argument)
> readlink("/usr/share/locale/en_US.utf8", 0x7fff3f8742a0, 1023) =3D -1 ENO=
ENT (No such file or directory)
> access("/var/lib/machines/riscv32/usr/share/locale/en_US.utf8/LC_MESSAGES=
/bash.mo", F_OK) =3D -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/share/locale/en_US.utf8/LC_MESSAGES/bash.mo", O_RD=
ONLY) =3D -1 ENOENT (No such file or directory)
> readlink("/usr", 0x7fff3f8742a0, 1023)  =3D -1 EINVAL (Invalid argument)
> readlink("/usr/share", 0x7fff3f8742a0, 1023) =3D -1 EINVAL (Invalid argum=
ent)
> readlink("/usr/share/locale", 0x7fff3f8742a0, 1023) =3D -1 EINVAL (Invali=
d argument)
> readlink("/usr/share/locale/en_US", 0x7fff3f8742a0, 1023) =3D -1 EINVAL (=
Invalid argument)
> readlink("/usr/share/locale/en_US/LC_MESSAGES", 0x7fff3f8742a0, 1023) =3D=
 -1 EINVAL (Invalid argument)
> readlink("/usr/share/locale/en_US/LC_MESSAGES/bash.mo", 0x7fff3f8742a0, 1=
023) =3D -1 ENOENT (No such file or directory)
> access("/var/lib/machines/riscv32/usr/share/locale/en_US/LC_MESSAGES/bash=
.mo", F_OK) =3D -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/share/locale/en_US/LC_MESSAGES/bash.mo", O_RDONLY)=
 =3D -1 ENOENT (No such file or directory)
> readlink("/usr", 0x7fff3f8742a0, 1023)  =3D -1 EINVAL (Invalid argument)
> readlink("/usr/share", 0x7fff3f8742a0, 1023) =3D -1 EINVAL (Invalid argum=
ent)
> readlink("/usr/share/locale", 0x7fff3f8742a0, 1023) =3D -1 EINVAL (Invali=
d argument)
> readlink("/usr/share/locale/en.utf8", 0x7fff3f8742a0, 1023) =3D -1 ENOENT=
 (No such file or directory)
> access("/var/lib/machines/riscv32/usr/share/locale/en.utf8/LC_MESSAGES/ba=
sh.mo", F_OK) =3D -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/share/locale/en.utf8/LC_MESSAGES/bash.mo", O_RDONL=
Y) =3D -1 ENOENT (No such file or directory)
> readlink("/usr", 0x7fff3f8742a0, 1023)  =3D -1 EINVAL (Invalid argument)
> readlink("/usr/share", 0x7fff3f8742a0, 1023) =3D -1 EINVAL (Invalid argum=
ent)
> readlink("/usr/share/locale", 0x7fff3f8742a0, 1023) =3D -1 EINVAL (Invali=
d argument)
> readlink("/usr/share/locale/en", 0x7fff3f8742a0, 1023) =3D -1 EINVAL (Inv=
alid argument)
> readlink("/usr/share/locale/en/LC_MESSAGES", 0x7fff3f8742a0, 1023) =3D -1=
 EINVAL (Invalid argument)
> readlink("/usr/share/locale/en/LC_MESSAGES/bash.mo", 0x7fff3f8742a0, 1023=
) =3D -1 ENOENT (No such file or directory)
> access("/var/lib/machines/riscv32/usr/share/locale/en/LC_MESSAGES/bash.mo=
", F_OK) =3D -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/share/locale/en/LC_MESSAGES/bash.mo", O_RDONLY) =
=3D -1 ENOENT (No such file or directory)
> write(2, "[1]+  Stopped                 py"..., 37[1]+  Stopped          =
       python
> ) =3D 37
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) =3D 0
> --- SIGCHLD {si_signo=3DSIGCHLD, si_code=3DCLD_STOPPED, si_pid=3D2472081,=
 si_uid=3D0, si_status=3DSIGTSTP, si_utime=3D2 /* 0.02 s */, si_stime=3D0} =
---
> rt_sigreturn({mask=3D~[BUS SEGV]})        =3D 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
> rt_sigprocmask(SIG_SETMASK, [CHLD], NULL, 8) =3D 0
> waitid(P_ALL, -1, {}, WNOHANG|WEXITED|WSTOPPED|WCONTINUED, NULL) =3D 0
> waitid(P_ALL, -1, {}, WNOHANG|WEXITED|WSTOPPED|WCONTINUED, NULL) =3D 0
> waitid(P_ALL, -1, {}, WNOHANG|WEXITED|WSTOPPED|WCONTINUED, NULL) =3D 0
> waitid(P_ALL, -1, {}, WNOHANG|WEXITED|WSTOPPED|WCONTINUED, NULL) =3D 0
> waitid(P_ALL, -1, {}, WNOHANG|WEXITED|WSTOPPED|WCONTINUED, NULL) =3D 0
> waitid(P_ALL, -1, {}, WNOHANG|WEXITED|WSTOPPED|WCONTINUED, NULL) =3D 0
> waitid(P_ALL, -1, {}, WNOHANG|WEXITED|WSTOPPED|WCONTINUED, NULL) =3D 0
> waitid(P_ALL, -1, {}, WNOHANG|WEXITED|WSTOPPED|WCONTINUED, NULL) =3D 0
> waitid(P_ALL, -1, {}, WNOHANG|WEXITED|WSTOPPED|WCONTINUED, NULL) =3D 0
> waitid(P_ALL, -1, {}, WNOHANG|WEXITED|WSTOPPED|WCONTINUED, NULL) =3D 0
> waitid(P_ALL, -1, {}, WNOHANG|WEXITED|WSTOPPED|WCONTINUED, NULL) =3D 0
> waitid(P_ALL, -1, {}, WNOHANG|WEXITED|WSTOPPED|WCONTINUED, NULL) =3D 0
> waitid(P_ALL, -1, {}, WNOHANG|WEXITED|WSTOPPED|WCONTINUED, NULL) =3D 0
> waitid(P_ALL, -1, {}, WNOHANG|WEXITED|WSTOPPED|WCONTINUED, NULL) =3D 0
> waitid(P_ALL, -1, {}, WNOHANG|WEXITED|WSTOPPED|WCONTINUED, NULL) =3D 0
> (...)

Ok!

So on my x86 machine I see this

--- SIGCHLD {si_signo=3DSIGCHLD, si_code=3DCLD_EXITED, si_pid=3D285545,
si_uid=3D1000, si_status=3D0, si_utime=3D0, si_stime=3D0} ---
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) =3D=3D 0}],
WNOHANG|WSTOPPED|WCONTINUED, NULL) =3D 285545
wait4(-1, 0x7ffe3eeb8210, WNOHANG|WSTOPPED|WCONTINUED, NULL) =3D 0
rt_sigreturn({mask=3D[INT]})              =3D 0
close(3)                                =3D 0

It all looks ok.

Maybe the host_to_target_siginfo() function in QEMU is the issue?
Something in here?
https://github.com/qemu/qemu/blob/master/linux-user/signal.c#L335

Nothing jumps out with a quick look though

Alistair

>
>
>
> --
> Andreas K. H=C3=BCttel
> dilfridge@gentoo.org
> Gentoo Linux developer
> (council, toolchain, base-system, perl, libreoffice)

