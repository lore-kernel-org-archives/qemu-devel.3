Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21DA5C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 03:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuNVr-0008Sl-4p; Mon, 17 Mar 2025 23:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tuNVp-0008SU-PR; Mon, 17 Mar 2025 23:21:05 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tuNVn-0005u8-NC; Mon, 17 Mar 2025 23:21:05 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2255003f4c6so88691475ad.0; 
 Mon, 17 Mar 2025 20:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742268062; x=1742872862; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V8j+gMvEU+jwKAXCZxbhmDtOlRKdR+ozToCxBapqZ4k=;
 b=UscJGQB+zcAIUhvX9YLHNkfUVtsqxMIINyf64J0BFoUiciot+PHvOQqzKlu2Rkkc58
 Cob09oGSPRk7AHuvdewyWVC8hiqfzefKnHskpiossDwTtN0L42/I0TDjhvBvxTwR+2RF
 kCvd3McDeTr1MYkyE3VLthvxESc/GKrI/d7l3UQ+2knAJUc+1Nk7vQwFTnZ3qIDYxDLY
 xQOUCNUm/smqQ1s1HGi7byL3btAoRHoY5gO+x3OkcaoE4aQ7+qeKOeYlRcqLEIrcE31u
 VwA8BkuggilAbpGHCC8V0BZsg+Uj+7J14jtk+kh1eHSnIXHztyyVJIyZdCcGOwZFg2YD
 m0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742268062; x=1742872862;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=V8j+gMvEU+jwKAXCZxbhmDtOlRKdR+ozToCxBapqZ4k=;
 b=KO4sdf6I5bJiV0IQ4a9UkJOwut/unRaglpiaCicrbtND9xMxUXl76iDG8lQnxoQpLP
 pUdlpi8Gl1cLAMa3dKPCVORoH2ZuaI4xO4ehmgv/HRHITIMR8FunQnGkIA9xcmXJ8RBR
 cxjyPsCgSaG+3u+kbia4DZJjvKw/75Xd3uQng2rtWnqqYVXcvcQFEsBeLcIb3RDQvw7q
 tdAkd/g90OgfFna0qqOwi1Vb/HgLzysbirqIZs0/AeptUKt/h9kqElewi1/3Vdc+AJAP
 r95SFsFY5ujtQLSRX55IJWoIcdSsGYfzWDt9lFkLyiTffE2O1qzHL/QrKacdMzKbEl4R
 +yEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxyj3WPyP01fcuPncAkZk4HIGxo1joLaZLhvkxFE+bwTzk98sDzmez0xWWPPX+Hxb6gTZ8WjzWBQ==@nongnu.org
X-Gm-Message-State: AOJu0YxYNJzYqsweMvdzc0XvBl4KZuLmnN/MQMay1Icdby7zn7/dLDwK
 254/JI9CvoSOqThuCyXnKFDMymgt4lo7xrHRGyQMDgHNIT+opnIJ
X-Gm-Gg: ASbGncuAA1+m0Dz2t5Mtxm7O1oqd6ri2OqlBjw0XhOHpgYQiuZTOnjKUqPoyn8OgHU9
 ON+o6WDpp59a1zyyh+XRajgBaKgpGB4mRV0iUtwaU/jpYuF+bIrMoh38PsDtoMAaLfzUBgwP4HK
 Yp9YasDEwYfZNuLaaqJWkH+zepcbzf8cR1CW8prPt5jCBrY6h4LbKIl7czREFa0kHukC0wMhmQS
 VeHWro6hClJXMi4RfHwiyEN38UyR0drrgwLqo8dYLkYe+/IV84SgKmavOBZQn/rbQ6+ToAA3mnJ
 gC9JjFe8f1+ghnHVu5qNgCE6rUvyrr/3gdWH/A==
X-Google-Smtp-Source: AGHT+IF9vDTslpbdVMEcpJiNPkGd8Hlr2HaHM+T3162j/m0UrEsbwqOPjF0Z7G/IFG8otdsJAcR5sA==
X-Received: by 2002:a05:6a00:b8a:b0:736:a93d:c9ca with SMTP id
 d2e1a72fcca58-73722395f3fmr17171370b3a.10.1742268061594; 
 Mon, 17 Mar 2025 20:21:01 -0700 (PDT)
Received: from localhost ([1.146.108.112]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-737115592b7sm8667744b3a.64.2025.03.17.20.20.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 20:21:01 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 18 Mar 2025 13:20:56 +1000
Message-Id: <D8J2HBJWT4FD.11OT57ZT2LQGN@gmail.com>
Cc: <qemu-devel@nongnu.org>
Subject: =?utf-8?q?Re:_[BUG][powerpc]_KVM_Guest_Boot_Failure_=E2=80=93_Hangs_at_"B?=
 =?utf-8?q?ooting_Linux_via_=5F=5Fstart()=E2=80=9D?=
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "misanjum" <misanjum@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.19.0
References: <fbb76ecc616d4065de7ab56d1311f876@linux.ibm.com>
In-Reply-To: <fbb76ecc616d4065de7ab56d1311f876@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Thanks for the report.

Tricky problem. A secondary CPU is hanging before it is started by the
primary via rtas call.

That secondary keeps calling kvm_cpu_exec(), which keeps exiting out
early with EXCP_HLT because kvm_arch_process_async_events() returns
true because that cpu has ->halted=3D1. That just goes around he run
loop because there is an interrupt pending (DEC).

So it never runs. It also never releases the BQL, and another CPU,
the primary which is actually supposed to be running, is stuck in
spapr_set_all_lpcrs() in run_on_cpu() waiting for the BQL.

This patch just exposes the bug I think, by causing the interrupt.
although I'm not quite sure why it's okay previously (-ve decrementer
values should be causing a timer exception too). The timer exception
should not be taken as an interrupt by those secondary CPUs, and it
doesn't because it is masked, until set_all_lpcrs sets an LPCR value
that enables powersave wakeup on decrementer interrupt.

The start_powered_off sate just sets ->halted, which makes it look
like a powersaving state. Logically I think it's not the same thing
as far as spapr goes. I don't know why start_powered_off only sets
->halted, and not ->stop/stopped as well.

Not sure how best to solve it cleanly. I'll send a revert if I can't
get something working soon.

Thanks,
Nick

On Tue Mar 18, 2025 at 7:09 AM AEST, misanjum wrote:
> Bug Description:
> Encountering a boot failure when launching a KVM guest with=20
> qemu-system-ppc64. The guest hangs at boot, and the QEMU monitor=20
> crashes.
>
>
> Reproduction Steps:
> # qemu-system-ppc64 --version
> QEMU emulator version 9.2.50 (v9.2.0-2799-g0462a32b4f)
> Copyright (c) 2003-2025 Fabrice Bellard and the QEMU Project developers
>
> # /usr/bin/qemu-system-ppc64 -name avocado-vt-vm1 -machine=20
> pseries,accel=3Dkvm \
>    -m 32768 -smp 32,sockets=3D1,cores=3D32,threads=3D1 -nographic \
>    -device virtio-scsi-pci,id=3Dscsi \
>    -drive=20
> file=3D/home/kvmci/tests/data/avocado-vt/images/rhel8.0devel-ppc64le.qcow=
2,if=3Dnone,id=3Ddrive0,format=3Dqcow2=20
> \
>    -device scsi-hd,drive=3Ddrive0,bus=3Dscsi.0 \
>    -netdev bridge,id=3Dnet0,br=3Dvirbr0 \
>    -device virtio-net-pci,netdev=3Dnet0 \
>    -serial pty \
>    -device virtio-balloon-pci \
>    -cpu host
> QEMU 9.2.50 monitor - type 'help' for more information
> char device redirected to /dev/pts/2 (label serial0)
> (qemu)
> (qemu) qemu-system-ppc64: warning: kernel_irqchip allowed but=20
> unavailable: IRQ_XIVE capability must be present for KVM
> Falling back to kernel-irqchip=3Doff
> ** Qemu Hang
>
> (In another ssh session)
> # screen /dev/pts/2
> Preparing to boot Linux version 6.10.4-200.fc40.ppc64le=20
> (mockbuild@c23cc4e677614c34bb22d54eeea4dc1f) (gcc (GCC) 14.2.1 20240801=
=20
> (Red Hat 14.2.1-1), GNU ld version 2.41-37.fc40) #1 SMP Sun Aug 11=20
> 15:20:17 UTC 2024
> Detected machine type: 0000000000000101
> command line:=20
> BOOT_IMAGE=3D(ieee1275/disk,msdos2)/vmlinuz-6.10.4-200.fc40.ppc64le=20
> root=3D/dev/mapper/fedora-root ro rd.lvm.lv=3Dfedora/root crashkernel=3D1=
024M
> Max number of cores passed to firmware: 2048 (NR_CPUS =3D 2048)
> Calling ibm,client-architecture-support... done
> memory layout at init:
>    memory_limit : 0000000000000000 (16 MB aligned)
>    alloc_bottom : 0000000008200000
>    alloc_top    : 0000000030000000
>    alloc_top_hi : 0000000800000000
>    rmo_top      : 0000000030000000
>    ram_top      : 0000000800000000
> instantiating rtas at 0x000000002fff0000... done
> prom_hold_cpus: skipped
> copying OF device tree...
> Building dt strings...
> Building dt structure...
> Device tree strings 0x0000000008210000 -> 0x0000000008210bd0
> Device tree struct  0x0000000008220000 -> 0x0000000008230000
> Quiescing Open Firmware ...
> Booting Linux via __start() @ 0x0000000000440000 ...
> ** Guest Console Hang
>
>
> Git Bisect:
> Performing git bisect points to the following patch:
> # git bisect bad
> e8291ec16da80566c121c68d9112be458954d90b is the first bad commit
> commit e8291ec16da80566c121c68d9112be458954d90b (HEAD)
> Author: Nicholas Piggin <npiggin@gmail.com>
> Date:   Thu Dec 19 13:40:31 2024 +1000
>
>      target/ppc: fix timebase register reset state
>
>      (H)DEC and PURR get reset before icount does, which causes them to=
=20
> be
>      skewed and not match the init state. This can cause replay to not
>      match the recorded trace exactly. For DEC and HDEC this is usually=
=20
> not
>      noticable since they tend to get programmed before affecting the
>      target machine. PURR has been observed to cause replay bugs when
>      running Linux.
>
>      Fix this by resetting using a time of 0.
>
>      Message-ID: <20241219034035.1826173-2-npiggin@gmail.com>
>      Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>
>   hw/ppc/ppc.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
>
>
> Reverting the patch helps boot the guest.
> Thanks,
> Misbah Anjum N


