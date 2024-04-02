Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE0ECCD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 09:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rradh-0004Fw-Ij; Tue, 02 Apr 2024 05:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rradV-0004Dm-NU
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 05:40:57 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rradR-0005Gn-T2
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 05:40:57 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-415698723efso9865765e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 02:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712050852; x=1712655652; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q8/P47BlkFU+OYaJkTLh2I3W7C4QSa7Ny3rN5YQbezM=;
 b=d91bjOKh5GOoFQDvY+R8Ov/S6uSmZi+SlFjxo0M/FRa/Dmijkz3+W22wfGzV8UhH5e
 vqggxMXlpp6e37wbIZZuFR439gLdVLjfZEue1go1BRPEHtWllZDhAgMBglv6hCzfQjWH
 uqHnCWIpyLQ5b9RVYlgSzwCcaJbTy9OGqIG3fQpiKK4x2KfD838NZ7ghc6jz8jGTyhJE
 IaXkt2/jBpe5dGMR8O6TB+QyHpIExyVhBtzBGnPUpmwo2rmt6+XVU3HXFZiUR9GWj5iT
 X1czCKYwXi7PZLIuTneEAovplwnZio6kWlcEfxduXobHRZEvgbG9qcsIqkATR+OX9y2E
 2mkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712050852; x=1712655652;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q8/P47BlkFU+OYaJkTLh2I3W7C4QSa7Ny3rN5YQbezM=;
 b=UXnoKBhP+5QS4wQO24fs9kg10A7uRWtQXPKf7UOuuGbGUhCEtySvYYAwOYuZfaWpBB
 DQXUvhglc4LU74bLAmkaGzxDjoY1LJXtLNP/ObJ7bX1KmiWRkr9KFvEvkBrzB58KoH1q
 V+eIRDkpv2MDoD3gbtJLq7JqalLr2FqKlXAtc2Ekr2SoOHoyMiNHDRBBj1lfeQbLxkdI
 4RXLO08AICSzZOHSavoH2IrJLFOVxzNfpWX/CE16W9DvyBjMFIpHiaNPgM0oqucrgrd3
 1eW5nuHdZ+PQsuEzuMQ/q4D8BGabLMXEFwbt9v7VNNb9MY9sU+BhjvYUV/LQEXFB5u0O
 A3Vw==
X-Gm-Message-State: AOJu0YzIJAcOWLatjyvfum9CwGy4si0RNIujzxRlI4/n3EScXqUetqEQ
 ha3Bedz/vbPwCLo0VBKI8R2H8IEGNqMQT5oBm8BhxKL7x8ye+4yjL7R+m0QimvU=
X-Google-Smtp-Source: AGHT+IFwNex8G9cHl/klS1EPoaTVR4Jdnu68TgsEBaBmhX6q4CjkFtzx2FSCfxnkgjnXlbBlHY5t1Q==
X-Received: by 2002:a05:600c:5199:b0:416:1e51:29c4 with SMTP id
 fa25-20020a05600c519900b004161e5129c4mr65550wmb.15.1712050851923; 
 Tue, 02 Apr 2024 02:40:51 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.202.91])
 by smtp.gmail.com with ESMTPSA id
 bk5-20020a0560001d8500b003418364032asm13784817wrb.112.2024.04.02.02.40.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Apr 2024 02:40:51 -0700 (PDT)
Message-ID: <9e5dbf88-a71a-4bf1-bed1-45b999171bef@linaro.org>
Date: Tue, 2 Apr 2024 11:40:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fast booting q35 VM?
To: Paul Menzel <pmenzel@molgen.mpg.de>
References: <1f1750c8-5887-4168-8ad7-8bb8e0ae8105@molgen.mpg.de>
Content-Language: en-US
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-discuss@nongnu.org
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1f1750c8-5887-4168-8ad7-8bb8e0ae8105@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Cc'ing qemu-devel@

On 30/3/24 10:00, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> Starting a QEMU q35 with Linux built with `make defconfig`
> 
>      qemu7-system-x86_64 -M q35 -m 32G -enable-kvm -cpu host -smp 
> cpus=32 -device virtio-rng-pci -net nic,model=virtio-net-pci -net 
> user,hostfwd=tcp::22230-:22 -drive 
> if=virtio,file=/scratch/local2/debian-linux-test.img -vga none -nographic
> 
> on a Supermicro AS -2023US-TR4/H11DSU-iN, BIOS 1.3 01/30/2020 the 
> timings are (no initrd):
> 
>      [    0.000000] Command line: 
> BOOT_IMAGE=/boot/vmlinuz-6.9.0-rc1-00274-g486291a0e624 root=/dev/vda1 ro 
> quiet console=ttyS0 initcall_debug log_buf_len=4M
>      […]
>      [    0.000000] DMI: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
> rel-1.16.1-0-g3208b098f51a-prebuilt.qemu.org 04/01/2014
>      […]
>      [    0.007979] Initmem setup node 0 [mem 
> 0x0000000000001000-0x000000087fffffff]
>      [    0.008235] On node 0, zone DMA: 1 pages in unavailable ranges
>      [    0.008249] On node 0, zone DMA: 97 pages in unavailable ranges
>      [    0.101045] On node 0, zone Normal: 36 pages in unavailable ranges
>      [    0.101327] ACPI: PM-Timer IO Port: 0x608
>      […]
>      [    0.117844] mem auto-init: stack:all(zero), heap alloc:off, heap 
> free:off
>      [    0.117849] software IO TLB: area num 32.
>      [    0.183645] Memory: 32848344K/33553896K available (18432K kernel 
> code, 2792K rwdata, 6708K rodata, 2696K init, 1304K bss, 705292K 
> reserved, 0K cma-reserved)
>      [    0.183728] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=32, 
> Nodes=1
>      […]
>      [    0.190074] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
>      [    0.190075] x86/fpu: Enabled xstate features 0x7, context size 
> is 832 bytes, using 'compacted' format.
>      [    0.211097] Freeing SMP alternatives memory: 48K
>      [    0.211109] pid_max: default: 32768 minimum: 301
>      […]
>      [    0.218021] smp: Bringing up secondary CPUs ...
>      [    0.218123] smpboot: x86: Booting SMP configuration:
>      [    0.218125] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6 
> #7  #8  #9 #10 #11 #12 #13 #14 #15 #16 #17 #18 #19 #20 #21 #22 #23 #24 
> #25 #26 #27 #28 #29 #30 #31
>      [    0.255165] smp: Brought up 1 node, 32 CPUs
>      [    0.255175] smpboot: Total of 32 processors activated (140799.87 
> BogoMIPS)
>      [    0.270016] calling  acpi_init+0x0/0x530 @ 1
>      […]
>      [    0.372097] initcall acpi_init+0x0/0x530 returned 0 after 103000 
> usecs
>      [    1.385567] systemd[1]: systemd 255.4-1+b1 running in system 
> mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT 
> -GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC 
> +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT +QRENCODE +TPM2 
> +BZIP2 +LZ4 +XZ +ZLIB +ZSTD -BPF_FRAMEWORK -XKBCOMMON +UTMP +SYSVINIT 
> default-hierarchy=unified)
> 
> Please find the Linux messages attached.
> 
> I know, that there are ways to configure the VM differently – without 
> PCI for example –, but in the end I also want to boot physical machines 
> faster, so hopefully using a “standard VM” is a good start.
> 
> 
> Kind regards,
> 
> Paul


