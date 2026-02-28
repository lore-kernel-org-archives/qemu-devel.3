Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DCDFEE4C4
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 04:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwBbW-00018g-7J; Fri, 27 Feb 2026 23:06:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thiago.bauermann@linaro.org>)
 id 1vwBbU-00018C-Sy
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 23:06:56 -0500
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <thiago.bauermann@linaro.org>)
 id 1vwBbS-0005V7-IJ
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 23:06:56 -0500
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-56a8dce7235so933253e0c.1
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772251611; x=1772856411; darn=nongnu.org;
 h=mime-version:message-id:date:user-agent:references:in-reply-to
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PUUQXYV8KprNC3S30OlYdhUgDO0fYH/3J2N7M/Dx1I4=;
 b=MY9HBt/aHen88WxN/BqbNmQwnghk81mXeuKBeq3qWLO6Q1qtw/2E4Br5bX1YCLwMWq
 two1A08JZz+uttzZW71O5hwCv89PxBrAA584UntaicjgtWLXiCukuT+2nqxFRnbYJLws
 GZR/ZfcBtpAZiLpvKbw94lbfDIht8k6USJO8TASz9UwkSWIti21uC7+ZB1jM5sRKsrKu
 xJyb1xueNyLpShAZHzFPJ9XGyRyXcXx46C46jmbCV3ZVlv3IpNvr5Y1iW05buUAZLE+4
 cLjiOoJ8liLErPc702L5JLkjYDmaVlxOkFXI6HBm3Qmx6HdMzW7WBvnwjiQHBgxXQpL8
 X/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772251611; x=1772856411;
 h=mime-version:message-id:date:user-agent:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=PUUQXYV8KprNC3S30OlYdhUgDO0fYH/3J2N7M/Dx1I4=;
 b=Z4XZlRKUNemSq8+DSu7cXaHTgwwReTZYGVSEVEzFueKpCUgMHkxoVTIov7HNSLj2uG
 xX331U/0PWk1rtGK6U5Cx7XohI4rn18qyFbmr0SKv4pS80BFP0vaHuRJ/WUQzW6hKIag
 /P2sWhn9SBNSHEnHCuPnHKSO8VIP5q/RnS+Ik3BfAziZDUiB/YJcvQYWFrzX+xKg8P42
 ATbSTAZVyjzy2+U6lLE4hcVJ0t1BdEMZ7uCs03cP6q6aNQ1MU3F4fJXkiH/ATm92FHnc
 aOpAjjjDVgSPSRU80y44oaUv1QMqUQJ6L+tzCI+nzmYD9sIVi+47AxdTrx3oJmVCWxk5
 QzZw==
X-Gm-Message-State: AOJu0YypdSlR10M3w1JhGEN9MndQCLDN/G03mHlE3Fj4Fi6jd0A63ZbP
 xhCDd6IxbBmb6gjqfg4RhJNbj+oK6gLnkbufIGhRIZWDzO+ox61ZVs0TeZazqVgZiCs=
X-Gm-Gg: ATEYQzxpevwdOexUt+8p7p54t6qlV3eiAJrhtNZz1vQ+gqJkzx4W0jqmol9v/5xfDUe
 FupIjHxc3zz2tIvzKBD1RxvYPV4sz19IlVgWWaUfP5CK7DaTkKUEmDWexseSNqItaXBU5bJgJZx
 dk7bKhgmAJxE7WdMJN+KGMle6xXcgbT+yP6bcI0/PD8RVyI9ON3Gxy4vKjeZ2o4phFB01+EgkQL
 mgr6VMIONJ0cVOYyHKxtpp9n+qhgZndFtUHn7QhTmyWqU4kxmNTlrifIrQrmablW0MgIdzcARaS
 /wtbcK9+Hfi507pvpI6/l/4WCbDUe+NnHAzYYX8oFyKBBDYZH23ERv/ZKf6A525x504H8wfVO4D
 GEG/eDElkchHaiiOYpTVCWVvq1iqJdtLfeP6sI/QG+IvVrUEbMpndKIU25PlMWNq9ehIEcqO+k3
 CHTLafz4xx+UuGFu6Dc5R+DEWSWkEkdIU7pQ==
X-Received: by 2002:a05:6122:895:b0:567:44ba:bd87 with SMTP id
 71dfb90a1353d-56aa0a17a0fmr2674739e0c.1.1772251611116; 
 Fri, 27 Feb 2026 20:06:51 -0800 (PST)
Received: from localhost ([2804:14d:7e39:8083:f04c:42e3:5943:38f6])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-56a91659421sm9437145e0c.0.2026.02.27.20.06.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 20:06:49 -0800 (PST)
From: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org
Subject: Re: [PATCH v4 00/84] target/arm: Implement FEAT_GCS
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org> (Richard
 Henderson's message of "Sat, 30 Aug 2025 15:40:04 +1000")
References: <20250830054128.448363-1-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.15; emacs 30.2
Date: Sat, 28 Feb 2026 01:06:47 -0300
Message-ID: <87tsv1fr54.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Received-SPF: pass client-ip=2607:f8b0:4864:20::a35;
 envelope-from=thiago.bauermann@linaro.org; helo=mail-vk1-xa35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--=-=-=
Content-Type: text/plain

Hello,

Richard Henderson <richard.henderson@linaro.org> writes:

> Based on Peter's tags/pull-target-arm-20250828.
> Tree: https://gitlab.com/rth7680/qemu/-/tree/tgt-arm-gcs
>
> This includes the prerequisite features, ATS1A and S1PIE, and
> not a prerequisite but closely related, S2PIE.
>
> This passes the linux kselftests for gcs, with a 48-bit VA.
> I also include a few smoke tests in tests/tcg/.
>
>
> This includes a best-effort linux-user implementation.  Since we
> don't have softmmu in user-only (yet), gcs stack pages get normal
> read/write access.  This means we cannot write-protect the pages
> in the same way the system implementation can.  But all of the
> other parts of GCS work fine, which is good enough for testing.

I tried using GCS in current QEMU trunk (commit d8a9d97317d0 "Merge tag
'pull-target-arm-20260226' of https://gitlab.com/pm215/qemu into
staging"), but I get this kernel oops with a simple program (attached)
that just tries to enable GCS using prctl:

[  226.334899] Unable to handle kernel paging request at virtual address fffff1ffc36c8008
[  226.335033] Mem abort info:
[  226.335088]   ESR = 0x0000000096000004
[  226.335117]   EC = 0x25: DABT (current EL), IL = 32 bits
[  226.335137]   SET = 0, FnV = 0
[  226.335153]   EA = 0, S1PTW = 0
[  226.335172]   FSC = 0x04: level 0 translation fault
[  226.335192] Data abort info:
[  226.335208]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[  226.335224]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[  226.335241]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[  226.335284] swapper pgtable: 4k pages, 52-bit VAs, pgdp=00000000dbe9b000
[  226.335306] [fffff1ffc36c8008] pgd=10000000dcfcd003, p4d=0000000000000000
[  226.335475] Internal error: Oops: 0000000096000004 [#1]  SMP
[  226.336917] Modules linked in: tpm_tis tpm_tis_core qrtr sha256 cfg80211 rfkill fuse dm_mod drm backlight ipv6 btrfs blake2b libblake2b xor xor_neon raid6_pq zstd_compress sm3_ce
[  226.337746] CPU: 0 UID: 1000 PID: 950 Comm: simple-gcs Tainted: G   M                6.19.0 #2 PREEMPT
[  226.337963] Tainted: [M]=MACHINE_CHECK
[  226.338035] Hardware name: QEMU QEMU Virtual Machine, BIOS edk2-stable202408-prebuilt.qemu.org 08/13/2024
[  226.338281] pstate: 21402005 (nzCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[  226.338411] pc : __get_user_pages+0x4a4/0xc0c
[  226.338889] lr : __get_user_pages+0x3fc/0xc0c
[  226.338977] sp : ffff800080e236f0
[  226.339042] x29: ffff800080e236f0 x28: fff00000c3c21e80 x27: 0000000000000000
[  226.339203] x26: 0000000000000000 x25: fff00000c1a988c8 x24: 0000000000000000
[  226.339327] x23: 0000ffffa3200000 x22: 000000000000000e x21: 0000000000000000
[  226.339453] x20: fff00000c80bc300 x19: 0008000000000000 x18: 0000000000000000
[  226.339573] x17: 0000000000000000 x16: ffff95c0712386b8 x15: 0000ffffa363bfff
[  226.339699] x14: 0000000000000000 x13: 1ffe000018271e21 x12: fff00000c138f10c
[  226.339824] x11: fff00000c138f100 x10: 0000000000000001 x9 : 0000000000000001
[  226.339962] x8 : 00c800011b200f41 x7 : fff00000c138f108 x6 : 00000000000008c8
[  226.340086] x5 : fffff1ffc36c8000 x4 : ffffc1ffc0000000 x3 : 0000000000000000
[  226.340207] x2 : 0000000000104a00 x1 : 0040000000000841 x0 : 0040000000000800
[  226.340392] Call trace:
[  226.340554]  __get_user_pages+0x4a4/0xc0c (P)
[  226.340701]  get_dump_page+0xe4/0x150
[  226.340797]  dump_user_range+0x64/0x2e8
[  226.340886]  elf_core_dump+0xbf8/0xe10
[  226.340955]  vfs_coredump+0xea0/0x1c80
[  226.341026]  get_signal+0x644/0x82c
[  226.341097]  arch_do_signal_or_restart+0x118/0x3c4
[  226.341184]  exit_to_user_mode_loop+0x104/0x16c
[  226.341269]  el0_da+0x8c/0x90
[  226.341344]  el0t_64_sync_handler+0xd0/0xe4
[  226.341419]  el0t_64_sync+0x198/0x19c
[  226.341626] Code: eb00003f 540029a0 924d0113 b6982d88 (f94004a4)
[  226.341893] ---[ end trace 0000000000000000 ]---
[  226.851631] note: simple-gcs[950] exited with preempt_count 1

This is using Linux kernel v6.19 built with defconfig.

I also tried the QEMU commit corresponding to the last patch in this
series (af0bd678df72 "tests/tcg/aarch64: Add gcsss") but had the same
result.

The same binaries work as expected using Arm FVP, so it seems to be
something in QEMU.

The command line I used was:

$QEMU_PREFIX/bin/qemu-system-aarch64 \
    -M virt \
    -cpu max \
    -m 4g \
    -drive if=none,file=$HOME/VMs/ubuntu-25.10-aarch64.img,id=hd1,format=raw,cache=writeback,discard=on \
    -device virtio-blk-device,drive=hd1 \
    -netdev user,id=mynet0,hostfwd=tcp::8222-:22 -device virtio-net-pci,netdev=mynet0 \
    -bios $QEMU_PREFIX/share/qemu/edk2-aarch64-code.fd \
    -nographic

-- 
Thiago


--=-=-=
Content-Type: text/plain
Content-Disposition: inline; filename=simple-gcs.c
Content-Description: simple-gcs.c

#include <stdlib.h>
#include <sys/syscall.h>
#include <linux/prctl.h>

#ifndef PR_SET_SHADOW_STACK_STATUS
#define PR_SET_SHADOW_STACK_STATUS 75
#define PR_SHADOW_STACK_ENABLE (1UL << 0)
#endif

/* We need to use a macro to call prctl because after GCS is enabled, it's not
   possible to return from the function which enabled it.  This is because the
   return address of the calling function isn't on the GCS.  */
#define my_syscall2(num, arg1, arg2)					\
  ({									\
    register long _num __asm__("x8") = (num);				\
    register long _arg1 __asm__("x0") = (long)(arg1);			\
    register long _arg2 __asm__("x1") = (long)(arg2);			\
    register long _arg3 __asm__("x2") = 0;				\
    register long _arg4 __asm__("x3") = 0;				\
    register long _arg5 __asm__("x4") = 0;				\
									\
    asm volatile ("svc #0\n"						\
		  : "=r"(_arg1)						\
		  : "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4),	\
		    "r"(_arg5), "r"(_num)				\
		  : "memory", "cc");					\
    _arg1;								\
  })

int main (void)
{
  int ret;

  ret = my_syscall2 (__NR_prctl, PR_SET_SHADOW_STACK_STATUS, PR_SHADOW_STACK_ENABLE);

  /* Don't return from main to avoid segmentation fault.  */
  exit (ret);
}

--=-=-=--

