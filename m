Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7A5C54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 13:43:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpq11-0003Aa-TX; Thu, 28 Mar 2024 09:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@linux-m68k.org>)
 id 1rpq10-00033e-C8; Thu, 28 Mar 2024 09:41:58 -0400
Received: from mail-out.m-online.net ([2001:a60:0:28:0:1:25:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@linux-m68k.org>)
 id 1rpq0x-0007Fz-4Y; Thu, 28 Mar 2024 09:41:57 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4V54TC0Xrsz1sB8C;
 Thu, 28 Mar 2024 14:41:51 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4V54TB6Gp6z1qqlS;
 Thu, 28 Mar 2024 14:41:50 +0100 (CET)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id s7kMP7KkyLqn; Thu, 28 Mar 2024 14:41:48 +0100 (CET)
X-Auth-Info: jmFaiXUYkic2QaHYgZczOKIVhMEHHpBDJ+mG8VT3pkCG3aW/QHGf/PFXGDO8x00n
Received: from hawking (unknown [81.95.8.245])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA;
 Thu, 28 Mar 2024 14:41:47 +0100 (CET)
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
X-Yow: I feel real SOPHISTICATED being in FRANCE!
Date: Thu, 28 Mar 2024 14:41:46 +0100
Message-ID: <mvmbk6yfp7p.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2001:a60:0:28:0:1:25:1;
 envelope-from=schwab@linux-m68k.org; helo=mail-out.m-online.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Mär 06 2024, Alistair Francis wrote:

> On Sun, Mar 3, 2024 at 8:34 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
>>
>> On Jan 28 2024, Michael Tokarev wrote:
>>
>> > From: Richard Henderson <richard.henderson@linaro.org>
>> >
>> > A typo in sizeof_reg put the registers at the wrong offset.
>> >
>> > Simplify the expressions to use positive addresses from the
>> > start of uc_mcontext instead of negative addresses from the
>> > end of uc_mcontext.
>>
>> This breaks the testsuite of libunwind.  The test Gtest-resume-sig and
>> all dependent tests hang.  Reverting this commit fixes them.
>
> Do you have any more details? It seems strange that this commit is
> breaking something as it looks to be correct

It also breaks the Ltest-init-local-signal test, and it is still broken
in 9.0.0-rc1, and reverting this commit still fixes it.

$ LD_LIBRARY_PATH=../src/.libs /tmp/qemu-riscv64.bad -strace .libs/Ltest-init-local-signal
24864 brk(NULL) = 0x0000555555559000
24864 faccessat(AT_FDCWD,"/etc/ld.so.preload",R_OK,AT_EACCESS|0x55557c08) = -1 errno=2 (No such file or directory)
24864 openat(AT_FDCWD,"../src/.libs/libunwind-riscv.so.8",O_RDONLY|O_CLOEXEC) = 3
24864 read(3,0x601ff3e0,832) = 832
24864 fstat(3,0x00007fab601ff260) = 0
24864 mmap(NULL,8192,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS,-1,0) = 0x00007fab68c0a000
24864 getcwd(0x7fab68c0a4c0,128) = 50
24864 mmap(NULL,156800,PROT_EXEC|PROT_READ,MAP_PRIVATE|MAP_DENYWRITE,3,0) = 0x00007fab603d9000
24864 mmap(0x00007fab603e6000,8192,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_DENYWRITE|MAP_FIXED,3,0xd000) = 0x00007fab603e6000
24864 mmap(0x00007fab603e8000,95360,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED,-1,0) = 0x00007fab603e8000
24864 close(3) = 0
24864 openat(AT_FDCWD,"../src/.libs/libunwind.so.8",O_RDONLY|O_CLOEXEC) = 3
24864 read(3,0x601ff3c0,832) = 832
24864 fstat(3,0x00007fab601ff240) = 0
24864 getcwd(0x7fab68c0aa40,128) = 50
24864 mmap(NULL,156848,PROT_EXEC|PROT_READ,MAP_PRIVATE|MAP_DENYWRITE,3,0) = 0x00007fab603b2000
24864 mmap(0x00007fab603bf000,8192,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_DENYWRITE|MAP_FIXED,3,0xd000) = 0x00007fab603bf000
24864 mmap(0x00007fab603c1000,95408,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED,-1,0) = 0x00007fab603c1000
24864 close(3) = 0
24864 openat(AT_FDCWD,"../src/.libs/libc.so.6",O_RDONLY|O_CLOEXEC) = -1 errno=2 (No such file or directory)
24864 openat(AT_FDCWD,"/etc/ld.so.cache",O_RDONLY|O_CLOEXEC) = 3
24864 fstat(3,0x00007fab601ff230) = 0
24864 mmap(NULL,7935,PROT_READ,MAP_PRIVATE,3,0) = 0x00007fab68c08000
24864 close(3) = 0
24864 openat(AT_FDCWD,"/lib64/lp64d/libc.so.6",O_RDONLY|O_CLOEXEC) = 3
24864 read(3,0x601ff3a0,832) = 832
24864 fstat(3,0x00007fab601ff220) = 0
24864 mmap(NULL,1473984,PROT_EXEC|PROT_READ,MAP_PRIVATE|MAP_DENYWRITE,3,0) = 0x00007fab6024a000
24864 mmap(0x00007fab603a1000,20480,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_DENYWRITE|MAP_FIXED,3,0x157000) = 0x00007fab603a1000
24864 mmap(0x00007fab603a6000,48576,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED,-1,0) = 0x00007fab603a6000
24864 close(3) = 0
24864 openat(AT_FDCWD,"../src/.libs/liblzma.so.5",O_RDONLY|O_CLOEXEC) = -1 errno=2 (No such file or directory)
24864 openat(AT_FDCWD,"/home/abuild/rpmbuild/BUILD/libunwind-1.8.1/src/.libs/liblzma.so.5",O_RDONLY|O_CLOEXEC) = -1 errno=2 (No such file or directory)
24864 newfstatat(AT_FDCWD,"/home/abuild/rpmbuild/BUILD/libunwind-1.8.1/src/.libs/",0x00007fab601ff1e0,0) = 0
24864 openat(AT_FDCWD,"/lib64/lp64d/liblzma.so.5",O_RDONLY|O_CLOEXEC) = 3
24864 read(3,0x601ff360,832) = 832
24864 fstat(3,0x00007fab601ff1e0) = 0
24864 mmap(NULL,200720,PROT_EXEC|PROT_READ,MAP_PRIVATE|MAP_DENYWRITE,3,0) = 0x00007fab60218000
24864 mmap(0x00007fab60248000,8192,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_DENYWRITE|MAP_FIXED,3,0x30000) = 0x00007fab60248000
24864 close(3) = 0
24864 mmap(NULL,8192,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS,-1,0) = 0x00007fab68c06000
24864 set_tid_address(0x7fab68c064f0) = 24864
24864 set_robust_list(0x7fab68c06500,24) = -1 errno=38 (Function not implemented)
24864 mprotect(0x00007fab603a1000,12288,PROT_READ) = 0
24864 mprotect(0x00007fab60248000,4096,PROT_READ) = 0
24864 mprotect(0x00007fab603bf000,4096,PROT_READ) = 0
24864 mprotect(0x00007fab603e6000,4096,PROT_READ) = 0
24864 mprotect(0x0000555555557000,4096,PROT_READ) = 0
24864 mprotect(0x00007fab68c2d000,8192,PROT_READ) = 0
24864 prlimit64(0,RLIMIT_STACK,NULL,0x00007fab601ffe68) = 0 ({rlim_cur=8388608,rlim_max=-1})
24864 munmap(0x00007fab68c08000,7935) = 0
24864 rt_sigaction(SIGSEGV,0x00007fab601fff18,NULL) = 0
--- SIGSEGV {si_signo=SIGSEGV, si_code=1, si_pid=0, si_uid=0} ---
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab603e7050,0x00007fab601f7858,8) = 0
24864 mmap(NULL,4096,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS,-1,0) = 0x00007fab68c09000
24864 mmap(NULL,4096,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS,-1,0) = 0x00007fab68c08000
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab601f7858,NULL,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab603e7050,0x00007fab601f7338,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab603e7050,0x00007fab601f7238,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab601f7238,NULL,8) = 0
24864 pipe2(0x7fab603e7000,526336) = 0
24864 read(3,0x601f6e57,1) = -1 errno=11 (Resource temporarily unavailable)
24864 write(4,0x55556000,1) = 1
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab603e7050,0x00007fab601f6e98,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab601f6e98,NULL,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab603e7050,0x00007fab601f7278,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab601f7278,NULL,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab601f7338,NULL,8) = 0
24864 read(3,0x601f6d97,1) = 1
24864 write(4,0x60200000,1) = 1
24864 read(3,0x601f7827,1) = 1
24864 write(4,0x60275000,1) = 1
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab603e7050,0x00007fab601f7338,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab603e7050,0x00007fab601f7238,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab601f7238,NULL,8) = 0
24864 read(3,0x601f6e57,1) = 1
24864 write(4,0x60372000,1) = 1
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab603e7050,0x00007fab601f6e98,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab601f6e98,NULL,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab603e7050,0x00007fab601f7278,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab601f7278,NULL,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab601f7338,NULL,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab603e7050,0x00007fab601f7338,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab603e7050,0x00007fab601f7238,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab601f7238,NULL,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab603e7050,0x00007fab601f6e98,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab601f6e98,NULL,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab603e7050,0x00007fab601f7278,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab601f7278,NULL,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab601f7338,NULL,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab603e7050,0x00007fab601f7338,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab603e7050,0x00007fab601f7238,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab601f7238,NULL,8) = 0
24864 read(3,0x601f6e57,1) = 1
24864 write(4,0x55556000,1) = 1
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab603e7050,0x00007fab601f6e98,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab601f6e98,NULL,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab603e7050,0x00007fab601f7278,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab601f7278,NULL,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab601f7338,NULL,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab603e7050,0x00007fab601f7338,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab603e7050,0x00007fab601f7238,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab601f7238,NULL,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab603e7050,0x00007fab601f6e98,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab601f6e98,NULL,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab603e7050,0x00007fab601f7278,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab601f7278,NULL,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab601f7338,NULL,8) = 0
24864 read(3,0x601f6d97,1) = 1
24864 write(4,0x601ff000,1) = 1
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab603e7050,0x00007fab601f7338,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab603e7050,0x00007fab601f7238,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab601f7238,NULL,8) = 0
24864 read(3,0x601f6e57,1) = 1
24864 write(4,0x68c0c000,1) = 1
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab603e7050,0x00007fab601f6e98,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab601f6e98,NULL,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab603e7050,0x00007fab601f7278,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab601f7278,NULL,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab601f7338,NULL,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab603e7050,0x00007fab601f7338,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab601f7338,NULL,8) = 0
24864 read(3,0x601f7827,1) = 1
24864 write(4,0x60200000,1) = 1
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab603e7050,0x00007fab601f7338,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab603e7050,0x00007fab601f7238,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab601f7238,NULL,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab601f7338,NULL,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab603e7050,0x00007fab601f7338,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab603e7050,0x00007fab601f7238,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab601f7238,NULL,8) = 0
24864 rt_sigprocmask(SIG_SETMASK,0x00007fab601f7338,NULL,8) = 0
24864 fstat(1,0x00007fab601f7658) = 0
24864 getrandom(0x7fab603aa5c8,8,1) = 8
24864 brk(NULL) = 0x0000555555559000
24864 brk(0x000055555557a000) = 0x000055555557a000
24864 write(1,0x555592a0,62)unw_getcontext steps was 4, ucontext steps was 3, should be 2
 = 62
24864 exit_group(-1)
$ LD_LIBRARY_PATH=../src/.libs /tmp/qemu-riscv64.good -strace .libs/Ltest-init-local-signal
24875 brk(NULL) = 0x0000555555559000
24875 faccessat(AT_FDCWD,"/etc/ld.so.preload",R_OK,AT_EACCESS|0x55557c08) = -1 errno=2 (No such file or directory)
24875 openat(AT_FDCWD,"../src/.libs/libunwind-riscv.so.8",O_RDONLY|O_CLOEXEC) = 3
24875 read(3,0x3cfff3d0,832) = 832
24875 fstat(3,0x00007f213cfff250) = 0
24875 mmap(NULL,8192,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS,-1,0) = 0x00007f2145a81000
24875 getcwd(0x7f2145a814c0,128) = 50
24875 mmap(NULL,156800,PROT_EXEC|PROT_READ,MAP_PRIVATE|MAP_DENYWRITE,3,0) = 0x00007f2145a5a000
24875 mmap(0x00007f2145a67000,8192,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_DENYWRITE|MAP_FIXED,3,0xd000) = 0x00007f2145a67000
24875 mmap(0x00007f2145a69000,95360,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED,-1,0) = 0x00007f2145a69000
24875 close(3) = 0
24875 openat(AT_FDCWD,"../src/.libs/libunwind.so.8",O_RDONLY|O_CLOEXEC) = 3
24875 read(3,0x3cfff3b0,832) = 832
24875 fstat(3,0x00007f213cfff230) = 0
24875 getcwd(0x7f2145a81a40,128) = 50
24875 mmap(NULL,156848,PROT_EXEC|PROT_READ,MAP_PRIVATE|MAP_DENYWRITE,3,0) = 0x00007f2145a33000
24875 mmap(0x00007f2145a40000,8192,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_DENYWRITE|MAP_FIXED,3,0xd000) = 0x00007f2145a40000
24875 mmap(0x00007f2145a42000,95408,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED,-1,0) = 0x00007f2145a42000
24875 close(3) = 0
24875 openat(AT_FDCWD,"../src/.libs/libc.so.6",O_RDONLY|O_CLOEXEC) = -1 errno=2 (No such file or directory)
24875 openat(AT_FDCWD,"/etc/ld.so.cache",O_RDONLY|O_CLOEXEC) = 3
24875 fstat(3,0x00007f213cfff220) = 0
24875 mmap(NULL,7935,PROT_READ,MAP_PRIVATE,3,0) = 0x00007f2145a31000
24875 close(3) = 0
24875 openat(AT_FDCWD,"/lib64/lp64d/libc.so.6",O_RDONLY|O_CLOEXEC) = 3
24875 read(3,0x3cfff390,832) = 832
24875 fstat(3,0x00007f213cfff210) = 0
24875 mmap(NULL,1473984,PROT_EXEC|PROT_READ,MAP_PRIVATE|MAP_DENYWRITE,3,0) = 0x00007f213d098000
24875 mmap(0x00007f213d1ef000,20480,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_DENYWRITE|MAP_FIXED,3,0x157000) = 0x00007f213d1ef000
24875 mmap(0x00007f213d1f4000,48576,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED,-1,0) = 0x00007f213d1f4000
24875 close(3) = 0
24875 openat(AT_FDCWD,"../src/.libs/liblzma.so.5",O_RDONLY|O_CLOEXEC) = -1 errno=2 (No such file or directory)
24875 openat(AT_FDCWD,"/home/abuild/rpmbuild/BUILD/libunwind-1.8.1/src/.libs/liblzma.so.5",O_RDONLY|O_CLOEXEC) = -1 errno=2 (No such file or directory)
24875 newfstatat(AT_FDCWD,"/home/abuild/rpmbuild/BUILD/libunwind-1.8.1/src/.libs/",0x00007f213cfff1d0,0) = 0
24875 openat(AT_FDCWD,"/lib64/lp64d/liblzma.so.5",O_RDONLY|O_CLOEXEC) = 3
24875 read(3,0x3cfff350,832) = 832
24875 fstat(3,0x00007f213cfff1d0) = 0
24875 mmap(NULL,200720,PROT_EXEC|PROT_READ,MAP_PRIVATE|MAP_DENYWRITE,3,0) = 0x00007f213d066000
24875 mmap(0x00007f213d096000,8192,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_DENYWRITE|MAP_FIXED,3,0x30000) = 0x00007f213d096000
24875 close(3) = 0
24875 mmap(NULL,8192,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS,-1,0) = 0x00007f2145a2f000
24875 set_tid_address(0x7f2145a2f4f0) = 24875
24875 set_robust_list(0x7f2145a2f500,24) = -1 errno=38 (Function not implemented)
24875 mprotect(0x00007f213d1ef000,12288,PROT_READ) = 0
24875 mprotect(0x00007f213d096000,4096,PROT_READ) = 0
24875 mprotect(0x00007f2145a40000,4096,PROT_READ) = 0
24875 mprotect(0x00007f2145a67000,4096,PROT_READ) = 0
24875 mprotect(0x0000555555557000,4096,PROT_READ) = 0
24875 mprotect(0x00007f2145aa4000,8192,PROT_READ) = 0
24875 prlimit64(0,RLIMIT_STACK,NULL,0x00007f213cfffe58) = 0 ({rlim_cur=8388608,rlim_max=-1})
24875 munmap(0x00007f2145a31000,7935) = 0
24875 rt_sigaction(SIGSEGV,0x00007f213cffff08,NULL) = 0
--- SIGSEGV {si_signo=SIGSEGV, si_code=1, si_pid=0, si_uid=0} ---
24875 rt_sigprocmask(SIG_SETMASK,0x00007f2145a68050,0x00007f213cff7848,8) = 0
24875 mmap(NULL,4096,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS,-1,0) = 0x00007f2145a32000
24875 mmap(NULL,4096,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS,-1,0) = 0x00007f2145a31000
24875 rt_sigprocmask(SIG_SETMASK,0x00007f213cff7848,NULL,8) = 0
24875 rt_sigprocmask(SIG_SETMASK,0x00007f2145a68050,0x00007f213cff7328,8) = 0
24875 rt_sigprocmask(SIG_SETMASK,0x00007f2145a68050,0x00007f213cff7228,8) = 0
24875 rt_sigprocmask(SIG_SETMASK,0x00007f213cff7228,NULL,8) = 0
24875 pipe2(0x7f2145a68000,526336) = 0
24875 read(3,0x3cff6e47,1) = -1 errno=11 (Resource temporarily unavailable)
24875 write(4,0x55556000,1) = 1
24875 rt_sigprocmask(SIG_SETMASK,0x00007f2145a68050,0x00007f213cff6e88,8) = 0
24875 rt_sigprocmask(SIG_SETMASK,0x00007f213cff6e88,NULL,8) = 0
24875 rt_sigprocmask(SIG_SETMASK,0x00007f2145a68050,0x00007f213cff7268,8) = 0
24875 rt_sigprocmask(SIG_SETMASK,0x00007f213cff7268,NULL,8) = 0
24875 rt_sigprocmask(SIG_SETMASK,0x00007f213cff7328,NULL,8) = 0
24875 read(3,0x3cff6d87,1) = 1
24875 write(4,0x3d000000,1) = 1
24875 read(3,0x3cff7817,1) = 1
24875 write(4,0x3d0c3000,1) = 1
24875 rt_sigprocmask(SIG_SETMASK,0x00007f2145a68050,0x00007f213cff7328,8) = 0
24875 rt_sigprocmask(SIG_SETMASK,0x00007f2145a68050,0x00007f213cff7228,8) = 0
24875 rt_sigprocmask(SIG_SETMASK,0x00007f213cff7228,NULL,8) = 0
24875 read(3,0x3cff6e47,1) = 1
24875 write(4,0x3d1c0000,1) = 1
24875 rt_sigprocmask(SIG_SETMASK,0x00007f2145a68050,0x00007f213cff6e88,8) = 0
24875 rt_sigprocmask(SIG_SETMASK,0x00007f213cff6e88,NULL,8) = 0
24875 rt_sigprocmask(SIG_SETMASK,0x00007f2145a68050,0x00007f213cff7268,8) = 0
24875 rt_sigprocmask(SIG_SETMASK,0x00007f213cff7268,NULL,8) = 0
24875 rt_sigprocmask(SIG_SETMASK,0x00007f213cff7328,NULL,8) = 0
24875 rt_sigprocmask(SIG_SETMASK,0x00007f2145a68050,0x00007f213cff7328,8) = 0
24875 rt_sigprocmask(SIG_SETMASK,0x00007f2145a68050,0x00007f213cff7228,8) = 0
24875 rt_sigprocmask(SIG_SETMASK,0x00007f213cff7228,NULL,8) = 0
24875 rt_sigprocmask(SIG_SETMASK,0x00007f2145a68050,0x00007f213cff6e88,8) = 0
24875 rt_sigprocmask(SIG_SETMASK,0x00007f213cff6e88,NULL,8) = 0
24875 rt_sigprocmask(SIG_SETMASK,0x00007f2145a68050,0x00007f213cff7268,8) = 0
24875 rt_sigprocmask(SIG_SETMASK,0x00007f213cff7268,NULL,8) = 0
24875 rt_sigprocmask(SIG_SETMASK,0x00007f213cff7328,NULL,8) = 0
24875 rt_sigprocmask(SIG_SETMASK,0x00007f2145a68050,0x00007f213cff7328,8) = 0
24875 rt_sigprocmask(SIG_SETMASK,0x00007f2145a68050,0x00007f213cff7228,8) = 0
24875 rt_sigprocmask(SIG_SETMASK,0x00007f213cff7228,NULL,8) = 0
24875 read(3,0x3cff6e47,1) = 1
24875 write(4,0x55556000,1) = 1
24875 rt_sigprocmask(SIG_SETMASK,0x00007f2145a68050,0x00007f213cff6e88,8) = 0
24875 rt_sigprocmask(SIG_SETMASK,0x00007f213cff6e88,NULL,8) = 0
24875 rt_sigprocmask(SIG_SETMASK,0x00007f2145a68050,0x00007f213cff7268,8) = 0
24875 rt_sigprocmask(SIG_SETMASK,0x00007f213cff7268,NULL,8) = 0
24875 rt_sigprocmask(SIG_SETMASK,0x00007f213cff7328,NULL,8) = 0
24875 rt_sigprocmask(SIG_SETMASK,0x00007f2145a68050,0x00007f213cff7328,8) = 0
24875 rt_sigprocmask(SIG_SETMASK,0x00007f2145a68050,0x00007f213cff7228,8) = 0
24875 rt_sigprocmask(SIG_SETMASK,0x00007f213cff7228,NULL,8) = 0
24875 rt_sigprocmask(SIG_SETMASK,0x00007f2145a68050,0x00007f213cff6e88,8) = 0
24875 rt_sigprocmask(SIG_SETMASK,0x00007f213cff6e88,NULL,8) = 0
24875 rt_sigprocmask(SIG_SETMASK,0x00007f2145a68050,0x00007f213cff7268,8) = 0
24875 rt_sigprocmask(SIG_SETMASK,0x00007f213cff7268,NULL,8) = 0
24875 rt_sigprocmask(SIG_SETMASK,0x00007f213cff7328,NULL,8) = 0
24875 read(3,0x3cff6d87,1) = 1
24875 write(4,0x3cfff000,1) = 1
24875 read(3,0x3cff7817,1) = 1
24875 write(4,0x45a83000,1) = 1
24875 rt_sigprocmask(SIG_SETMASK,0x00007f2145a68050,0x00007f213cff7328,8) = 0
24875 rt_sigprocmask(SIG_SETMASK,0x00007f213cff7328,NULL,8) = 0
24875 read(3,0x3cff6d87,1) = 1
24875 write(4,0x3d000000,1) = 1
24875 rt_sigprocmask(SIG_SETMASK,0x00007f2145a68050,0x00007f213cff7328,8) = 0
24875 rt_sigprocmask(SIG_SETMASK,0x00007f213cff7328,NULL,8) = 0
24875 rt_sigprocmask(SIG_SETMASK,0x00007f2145a68050,0x00007f213cff7328,8) = 0
24875 rt_sigprocmask(SIG_SETMASK,0x00007f213cff7328,NULL,8) = 0
24875 rt_sigprocmask(SIG_SETMASK,0x00007f2145a68050,0x00007f213cff7328,8) = 0
24875 rt_sigprocmask(SIG_SETMASK,0x00007f213cff7328,NULL,8) = 0
24875 exit_group(0)

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

