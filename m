Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D7AC54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 11:31:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhpUY-0006TY-Um; Wed, 06 Mar 2024 06:31:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@linux-m68k.org>)
 id 1rhpUX-0006TK-Gy; Wed, 06 Mar 2024 06:31:21 -0500
Received: from mail-out.m-online.net ([212.18.0.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@linux-m68k.org>)
 id 1rhpUR-0000Xx-Do; Wed, 06 Mar 2024 06:31:21 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4TqVcZ2bTWz1qsP5;
 Wed,  6 Mar 2024 12:31:10 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4TqVcZ1R1vz1qqlY;
 Wed,  6 Mar 2024 12:31:10 +0100 (CET)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id QdNR0kb3c77n; Wed,  6 Mar 2024 12:31:08 +0100 (CET)
X-Auth-Info: /wuBx/05G2qPRrxHiEgYJlB3CYxP+BK7cd7o2PJM7w7Y3BmFs2sKW7cHsrJlxMep
Received: from hawking (unknown [81.95.8.245])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA;
 Wed,  6 Mar 2024 12:31:07 +0100 (CET)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Alistair Francis <alistair23@gmail.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>,  qemu-devel@nongnu.org,
 qemu-stable@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Vineet Gupta <vineetg@rivosinc.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Alistair
 Francis <alistair.francis@wdc.com>
Subject: Re: [Stable-8.2.1 61/71] linux-user/riscv: Adjust vdso signal frame
 cfa offsets
In-Reply-To: <CAKmqyKMGODCT3BetDRL_1MLuEKcBhQjUBgZ99eMQvN-Aeo+CAg@mail.gmail.com>
 (Alistair Francis's message of "Wed, 6 Mar 2024 14:27:28 +1000")
References: <qemu-stable-8.2.1-20240128204849@cover.tls.msk.ru>
 <20240128175035.812352-7-mjt@tls.msk.ru>
 <87ttlnehb1.fsf@linux-m68k.org>
 <CAKmqyKMGODCT3BetDRL_1MLuEKcBhQjUBgZ99eMQvN-Aeo+CAg@mail.gmail.com>
X-Yow: There's a lot of BIG MONEY in MISERY if you have an AGENT!!
Date: Wed, 06 Mar 2024 12:31:06 +0100
Message-ID: <mvmbk7rsikl.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: none client-ip=212.18.0.9; envelope-from=schwab@linux-m68k.org;
 helo=mail-out.m-online.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

$ qemu-riscv64 -strace -E LD_LIBRARY_PATH=../src/.libs .libs/Gtest-resume-sig
30962 brk(NULL) = 0x000055555555a000
30962 faccessat(AT_FDCWD,"/etc/ld.so.preload",R_OK,AT_SYMLINK_NOFOLLOW|0x55558c98) = -1 errno=2 (No such file or directory)
30962 openat(AT_FDCWD,"../src/.libs/libunwind-riscv.so.8",O_RDONLY|O_CLOEXEC) = 3
30962 read(3,0xab2aa3b0,832) = 832
30962 fstat(3,0x00002aaaab2aa230) = 0
30962 mmap(NULL,8192,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS,-1,0) = 0x00002aaaab2d1000
30962 getcwd(0x2aaaab2d14c0,128) = 50
30962 mmap(NULL,156800,PROT_EXEC|PROT_READ,MAP_PRIVATE|MAP_DENYWRITE,3,0) = 0x00002aaaab2d3000
30962 mmap(0x00002aaaab2e0000,8192,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_DENYWRITE|MAP_FIXED,3,0xd000) = 0x00002aaaab2e0000
30962 mmap(0x00002aaaab2e2000,95360,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED,-1,0) = 0x00002aaaab2e2000
30962 close(3) = 0
30962 openat(AT_FDCWD,"../src/.libs/libunwind.so.8",O_RDONLY|O_CLOEXEC) = 3
30962 read(3,0xab2aa390,832) = 832
30962 fstat(3,0x00002aaaab2aa210) = 0
30962 getcwd(0x2aaaab2d1a40,128) = 50
30962 mmap(NULL,156848,PROT_EXEC|PROT_READ,MAP_PRIVATE|MAP_DENYWRITE,3,0) = 0x00002aaaab2fa000
30962 mmap(0x00002aaaab307000,8192,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_DENYWRITE|MAP_FIXED,3,0xd000) = 0x00002aaaab307000
30962 mmap(0x00002aaaab309000,95408,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED,-1,0) = 0x00002aaaab309000
30962 close(3) = 0
30962 openat(AT_FDCWD,"../src/.libs/libc.so.6",O_RDONLY|O_CLOEXEC) = -1 errno=2 (No such file or directory)
30962 openat(AT_FDCWD,"/etc/ld.so.cache",O_RDONLY|O_CLOEXEC) = 3
30962 fstat(3,0x00002aaaab2aa200) = 0
30962 mmap(NULL,11027,PROT_READ,MAP_PRIVATE,3,0) = 0x00002aaaab321000
30962 close(3) = 0
30962 openat(AT_FDCWD,"/lib64/lp64d/libc.so.6",O_RDONLY|O_CLOEXEC) = 3
30962 read(3,0xab2aa370,832) = 832
30962 fstat(3,0x00002aaaab2aa1f0) = 0
30962 mmap(NULL,1473984,PROT_EXEC|PROT_READ,MAP_PRIVATE|MAP_DENYWRITE,3,0) = 0x00002aaaab324000
30962 mmap(0x00002aaaab47b000,20480,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_DENYWRITE|MAP_FIXED,3,0x157000) = 0x00002aaaab47b000
30962 mmap(0x00002aaaab480000,48576,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED,-1,0) = 0x00002aaaab480000
30962 close(3) = 0
30962 openat(AT_FDCWD,"../src/.libs/liblzma.so.5",O_RDONLY|O_CLOEXEC) = -1 errno=2 (No such file or directory)
30962 openat(AT_FDCWD,"/home/abuild/rpmbuild/BUILD/libunwind-1.8.1/src/.libs/liblzma.so.5",O_RDONLY|O_CLOEXEC) = -1 errno=2 (No such file or directory)
30962 newfstatat(AT_FDCWD,"/home/abuild/rpmbuild/BUILD/libunwind-1.8.1/src/.libs/",0x00002aaaab2aa1b0,0) = 0
30962 openat(AT_FDCWD,"/lib64/lp64d/liblzma.so.5",O_RDONLY|O_CLOEXEC) = 3
30962 read(3,0xab2aa330,832) = 832
30962 fstat(3,0x00002aaaab2aa1b0) = 0
30962 mmap(NULL,200720,PROT_EXEC|PROT_READ,MAP_PRIVATE|MAP_DENYWRITE,3,0) = 0x00002aaaab48c000
30962 mmap(0x00002aaaab4bc000,8192,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_DENYWRITE|MAP_FIXED,3,0x30000) = 0x00002aaaab4bc000
30962 close(3) = 0
30962 mmap(NULL,8192,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS,-1,0) = 0x00002aaaab4be000
30962 set_tid_address(0x2aaaab4be4f0) = 30962
30962 set_robust_list(0x2aaaab4be500,24) = -1 errno=38 (Function not implemented)
30962 mprotect(0x00002aaaab47b000,12288,PROT_READ) = 0
30962 mprotect(0x00002aaaab4bc000,4096,PROT_READ) = 0
30962 mprotect(0x00002aaaab307000,4096,PROT_READ) = 0
30962 mprotect(0x00002aaaab2e0000,4096,PROT_READ) = 0
30962 mprotect(0x0000555555558000,4096,PROT_READ) = 0
30962 mprotect(0x00002aaaab2cc000,8192,PROT_READ) = 0
30962 prlimit64(0,RLIMIT_STACK,NULL,0x00002aaaab2aae38) = 0 ({rlim_cur=8388608,rlim_max=-1})
30962 munmap(0x00002aaaab321000,11027) = 0
30962 rt_sigaction(SIGUSR1,0x00002aaaab2aaed8,NULL) = 0
30962 rt_sigaction(SIGUSR2,0x00002aaaab2aaed8,NULL) = 0
30962 getpid() = 30962
30962 kill(30962,SIGUSR1) = 0
--- SIGUSR1 {si_signo=SIGUSR1, si_code=SI_USER, si_pid=30962, si_uid=399} ---
30962 rt_sigprocmask(SIG_BLOCK,0x00002aaaab2a2870,NULL,8) = 0
30962 getpid() = 30962
30962 kill(30962,SIGUSR2) = 0
30962 rt_sigaction(SIGUSR1,0x00002aaaab2a25b8,0x00002aaaab2a2648) = 0
30962 rt_sigprocmask(SIG_SETMASK,0x00002aaaab2e1050,0x00002aaaab2a2788,8) = 0
30962 mmap(NULL,4096,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS,-1,0) = 0x00002aaaab4c0000
30962 mmap(NULL,4096,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS,-1,0) = 0x00002aaaab4c1000
30962 rt_sigprocmask(SIG_SETMASK,0x00002aaaab2a2788,NULL,8) = 0
30962 rt_sigprocmask(SIG_SETMASK,0x00002aaaab2e1050,0x00002aaaab2a2268,8) = 0
30962 rt_sigprocmask(SIG_SETMASK,0x00002aaaab2e1050,0x00002aaaab2a2168,8) = 0
30962 rt_sigprocmask(SIG_SETMASK,0x00002aaaab2a2168,NULL,8) = 0
30962 pipe2(0x2aaaab2e1000,526336) = 0
30962 read(3,0xab2a1d87,1) = -1 errno=11 (Resource temporarily unavailable)
30962 write(4,0x55557000,1) = 1
30962 rt_sigprocmask(SIG_SETMASK,0x00002aaaab2e1050,0x00002aaaab2a1dc8,8) = 0
30962 rt_sigprocmask(SIG_SETMASK,0x00002aaaab2a1dc8,NULL,8) = 0
30962 rt_sigprocmask(SIG_SETMASK,0x00002aaaab2e1050,0x00002aaaab2a2068,8) = 0
30962 rt_sigprocmask(SIG_SETMASK,0x00002aaaab2a2068,NULL,8) = 0
30962 rt_sigprocmask(SIG_SETMASK,0x00002aaaab2e1050,0x00002aaaab2a2068,8) = 0
30962 rt_sigprocmask(SIG_SETMASK,0x00002aaaab2a2068,NULL,8) = 0
30962 rt_sigprocmask(SIG_SETMASK,0x00002aaaab2e1050,0x00002aaaab2a21a8,8) = 0
30962 rt_sigprocmask(SIG_SETMASK,0x00002aaaab2a21a8,NULL,8) = 0
30962 rt_sigprocmask(SIG_SETMASK,0x00002aaaab2a2268,NULL,8) = 0
30962 read(3,0xab2a1cc7,1) = 1
30962 write(4,0xab2aa000,1) = 1
30962 rt_sigprocmask(SIG_SETMASK,0x00002aaaab2e1050,0x00002aaaab2a2268,8) = 0
30962 rt_sigprocmask(SIG_SETMASK,0x00002aaaab2e1050,0x00002aaaab2a2168,8) = 0
30962 rt_sigprocmask(SIG_SETMASK,0x00002aaaab2a2168,NULL,8) = 0
30962 read(3,0xab2a1d87,1) = 1
30962 write(4,0xab2d0000,1) = 1
30962 rt_sigprocmask(SIG_SETMASK,0x00002aaaab2e1050,0x00002aaaab2a1dc8,8) = 0
30962 rt_sigprocmask(SIG_SETMASK,0x00002aaaab2a1dc8,NULL,8) = 0
30962 rt_sigprocmask(SIG_SETMASK,0x00002aaaab2e1050,0x00002aaaab2a21a8,8) = 0
30962 rt_sigprocmask(SIG_SETMASK,0x00002aaaab2a21a8,NULL,8) = 0
30962 rt_sigprocmask(SIG_SETMASK,0x00002aaaab2a2268,NULL,8) = 0
30962 read(3,0xab2a2747,1) = 1
30962 write(4,0xab2ab000,1) = 1

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

