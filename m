Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9462CF45C5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 19:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfNhI-0007Mp-03; Mon, 12 Jan 2026 14:35:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bobby.prani@gmail.com>)
 id 1vfNhG-0007LH-FP
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 14:35:26 -0500
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bobby.prani@gmail.com>)
 id 1vfNhE-0007Co-Sv
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 14:35:26 -0500
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-382fd45a1feso53500301fa.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 11:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768246521; x=1768851321; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=a9se/EaoRQKrKwIxFKRzvfFVYp2sswWLWm93D88ry3M=;
 b=gN5kT2yJy72h1nliiNc2kMWRRgh/yh+VmQla7F7zWmE9XdqJNFXAK5zv5XcXy6fk40
 e1rlqpJXyY7oSR4uqPtGlnDnk2gWcp6W7J6HQUbkDYCh1QIxwprWO/RlITqAlznMEirl
 /kZKyqoaYPqqkcbcRvoqXOBXqJGNoyXevcXg8ak46JuYgutSZev885pYeT+s84jwwl4Y
 al2qe69+1RugUTSS7oSgsRgw2vg3VF4hd78LUwjJx8kH38R6wdacGBtER+v/QrbhcYSj
 4Sfcqv1asAiRKCxWHDwEjwqHKFUCtIJ3Ja/kJlqwVj3qvi9g5+pSAnG+UlxN8Tb23jgd
 0++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768246521; x=1768851321;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a9se/EaoRQKrKwIxFKRzvfFVYp2sswWLWm93D88ry3M=;
 b=AfPle98lbXbPkgzegH/xG463XyeIkrp7yPBfHhexjPkW+l5ObN5x7aW65HSW/G3VKS
 uQcFHnPl4jTTdr3/j/4PALHHiU6D7jeAy9RzaD4avkH0sk8UbYD5Nl3PW+jPZTTXA9Di
 d5sy5WBpE0yUubcNmOhmoIQYHY6RSs7acAQJSkP/cEWmtCbWvu4sFiYumsAO0h+2l+d8
 E3z3EC4nZuzEM3xIqdxZNXliMG8x+A1JXIpLbOaFgeF7Lma5Y4aNnUyWqHp5UN05qAt2
 Ql+tvH+/Gr+tr0N/G3zoSO1k6mexcd27u6pI4ieiuLef1DI0JuCzz3ZzPWth6OHE9wTx
 +Vmg==
X-Gm-Message-State: AOJu0Yxzy07kOvka3GR6JQQAVun5b0RV77m3mZ+FpQHEjsF2HIsfOp7t
 uHKsray2yN0dSbJt7BUQRO4NuNMpa/w2j1DsG1BjCUSlMd3z2ao4GYygKI4z7yiiuoDakQc8mPZ
 aeH95TSxWYpZUvBudbFNuqdpH36g3j0g/autM
X-Gm-Gg: AY/fxX6T1D7AuVDYl3HEe6t4EaMT1JqgwCDML60YnVRmIanyM0DgqKLRhBc0sn+EwZc
 505MIkf2xB94w4/T7WZas/vhGrXkxsidmt1rbGDBdqVQLd56k1FcZ3LJrPtlc1Tk8y1Cb3xiOBd
 R5EpGLAmYKfbvDcu2r9Camb75gbDHLrsaycl/CbUkOZgxEzadUk2ApqZUR6AXBs0VcPvJELqHmD
 KT3ym7rstoTiyCqQAJ4HL5dA4vANfFLIM71fiGDZ13LsohqKUrXTS1h3ABKYX8sQBOt65NO
X-Received: by 2002:a2e:b8c2:0:b0:383:227:2891 with SMTP id
 38308e7fff4ca-38350a08562mr1631331fa.4.1768246521266; Mon, 12 Jan 2026
 11:35:21 -0800 (PST)
MIME-Version: 1.0
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Mon, 12 Jan 2026 11:34:54 -0800
X-Gm-Features: AZwV_QhUJhu7Nne9-jBS1ETa8pi2tQ1QJVuQkTFxoHLpJh7CdXlV_k_YVgsMVLY
Message-ID: <CAJhHMCDqZE-TwmbPhDeYR0ZZYJRcV3tvcZD8-+rz7WE-oDMgQg@mail.gmail.com>
Subject: qemu-x86_64 fails with 'Illegal Instruction' error
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=bobby.prani@gmail.com; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hello,

I am trying to run spec intrate with qemu-x86_64 and it seems to fail
with an 'Illegal Instruction' error. I tried compiling with an ancient
architecture (-march=core2/athlon64) and this error persists.

Is this a known issue? Are there any workarounds?

Trace 0: 0x7fffe806fd40 [00000000/000000000050d8d6/1040c0b3/00000000]
Perl_sv_upgrade
----------------
IN: Perl_sv_upgrade
0x0050d8dc:  c5 f9 ef c0              vpxor    %xmm0, %xmm0, %xmm0
0x0050d8e0:  48 83 c2 10              addq     $0x10, %rdx
0x0050d8e4:  62                       .byte    0x62
0x0050d8e5:  f1                       int1



                       [0/92921]

OUT: [size=128]
  -- guest addr 0x000000000050d8dc + tb prologue
0x7fffe806fec0:  8b 5d ec                 movl     -0x14(%rbp), %ebx
0x7fffe806fec3:  85 db                    testl    %ebx, %ebx
0x7fffe806fec5:  0f 8c 5d 00 00 00        jl       0x7fffe806ff28
0x7fffe806fecb:  c6 45 f0 00              movb     $0, -0x10(%rbp)
0x7fffe806fecf:  c5 f9 ef c0              vpxor    %xmm0, %xmm0, %xmm0
0x7fffe806fed3:  c5 f9 7f 85 60 03 00 00  vmovdqa  %xmm0, 0x360(%rbp)
0x7fffe806fedb:  c5 f9 7f 85 70 03 00 00  vmovdqa  %xmm0, 0x370(%rbp)
  -- guest addr 0x000000000050d8e0
0x7fffe806fee3:  48 8b 5d 10              movq     0x10(%rbp), %rbx
0x7fffe806fee7:  48 83 c3 10              addq     $0x10, %rbx
0x7fffe806feeb:  48 89 5d 10              movq     %rbx, 0x10(%rbp)
0x7fffe806feef:  48 89 9d 90 00 00 00     movq     %rbx, 0x90(%rbp)
0x7fffe806fef6:  48 c7 85 98 00 00 00 10  movq     $0x10, 0x98(%rbp)
0x7fffe806fefe:  00 00 00
0x7fffe806ff01:  c6 45 f0 01              movb     $1, -0x10(%rbp)
  -- guest addr 0x000000000050d8e4
0x7fffe806ff05:  c7 85 a8 00 00 00 0b 00  movl     $0xb, 0xa8(%rbp)
0x7fffe806ff0d:  00 00
0x7fffe806ff0f:  48 c7 85 80 00 00 00 e4  movq     $0x50d8e4, 0x80(%rbp)
0x7fffe806ff17:  d8 50 00
0x7fffe806ff1a:  be 06 00 00 00           movl     $6, %esi
0x7fffe806ff1f:  48 8b fd                 movq     %rbp, %rdi
0x7fffe806ff22:  ff 15 10 00 00 00        callq    *0x10(%rip)
0x7fffe806ff28:  48 8d 05 d4 fe ff ff     leaq     -0x12c(%rip), %rax
0x7fffe806ff2f:  e9 e4 00 f9 ff           jmp      0x7fffe8000018
  -- tb slow paths + alignment
0x7fffe806ff34:  90                       nop
0x7fffe806ff35:  90                       nop
0x7fffe806ff36:  90                       nop
0x7fffe806ff37:  90                       nop
  data: [size=8]
0x7fffe806ff38:  .quad  0x000055555564a472

Linking TBs 0x7fffe806fd40 index 1 -> 0x7fffe806fec0
Trace 0: 0x7fffe806fec0 [00000000/000000000050d8dc/1040c0b3/00000000]
Perl_sv_upgrade
qemu: uncaught target signal 4 (Illegal instruction) - core dumped

Thread 1 "qemu-x86_64" received signal SIGILL, Illegal instruction.
__syscall_cancel_arch () at
../sysdeps/unix/sysv/linux/x86_64/syscall_cancel.S:56
warning: 56     ../sysdeps/unix/sysv/linux/x86_64/syscall_cancel.S: No
such file or directory
(gdb) layout asm
(gdb) f 1
#1  0x00007ffff7249668 in __internal_syscall_cancel (a1=<optimized
out>, a2=a2@entry=8, a3=a3@entry=0, a4=a4@entry=0, a5=a5@entry=0,
a6=a6@entry=0, nr=130) at ./nptl/cancellation.c:49
warning: 49     ./nptl/cancellation.c: No such file or directory
(gdb) f 0
#0  __syscall_cancel_arch () at
../sysdeps/unix/sysv/linux/x86_64/syscall_cancel.S:56
warning: 56     ../sysdeps/unix/sysv/linux/x86_64/syscall_cancel.S: No
such file or directory
(gdb) bt
#0  __syscall_cancel_arch () at
../sysdeps/unix/sysv/linux/x86_64/syscall_cancel.S:56
#1  0x00007ffff7249668 in __internal_syscall_cancel (a1=<optimized
out>, a2=a2@entry=8, a3=a3@entry=0, a4=a4@entry=0, a5=a5@entry=0,
a6=a6@entry=0, nr=130) at ./nptl/cancellation.c:49
#2  0x00007ffff72496ad in __syscall_cancel (a1=<optimized out>,
a2=a2@entry=8, a3=a3@entry=0, a4=a4@entry=0, a5=a5@entry=0,
a6=a6@entry=0, nr=130) at ./nptl/cancellation.c:75
#3  0x00007ffff71fa07d in __GI___sigsuspend (set=<optimized out>) at
../sysdeps/unix/sysv/linux/sigsuspend.c:26
#4  0x00005555556ccef1 in die_with_signal (host_sig=4) at
../linux-user/signal.c:807
#5  0x00005555556cd065 in dump_core_and_abort (env=0x5555559466e0,
target_sig=4) at ../linux-user/signal.c:847
#6  0x00005555556ce2c4 in handle_pending_signal
(cpu_env=0x5555559466e0, sig=4, k=0x55555595e490) at
../linux-user/signal.c:1306
#7  0x00005555556ce5ed in process_pending_signals
(cpu_env=0x5555559466e0) at ../linux-user/signal.c:1386
#8  0x00005555556352c7 in cpu_loop (env=0x5555559466e0) at
../linux-user/x86_64/../i386/cpu_loop.c:323
#9  0x00005555556c72af in main (argc=15, argv=0x7fffffffdaa8,
envp=0x7fffffffdb28) at ../linux-user/main.c:1035

-- 
Pranith

