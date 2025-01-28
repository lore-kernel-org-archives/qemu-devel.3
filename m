Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC6D6C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 18:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcqCh-0002Ul-Db; Tue, 28 Jan 2025 13:20:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tcqCb-0002Rc-BZ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 13:20:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tcqCY-00045a-An
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 13:20:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738088438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xOte7pqP5I1GQu6z/MP41qe8mm2R2LQCd2bV89S/bxs=;
 b=Mg+ZByGWDQWp5JX6xj/DawtkgX7wBGfoStcnZVifmVnmKF+vMGYyQGPQxJN7RoigaGvCY/
 Hu/yg4mg0YbQm6HOQv7w5DiMwlaAsHn4BEltP4v/2u09UzS92C9BYepXBA8+H9gOKZiMBX
 tqOzlV1QQTJhHREs96wzZEFrzbQS8jo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-JgvczQewOvmHC0TAOtpbtA-1; Tue, 28 Jan 2025 13:20:37 -0500
X-MC-Unique: JgvczQewOvmHC0TAOtpbtA-1
X-Mimecast-MFC-AGG-ID: JgvczQewOvmHC0TAOtpbtA
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-436328fcfeeso47332085e9.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 10:20:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738088436; x=1738693236;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xOte7pqP5I1GQu6z/MP41qe8mm2R2LQCd2bV89S/bxs=;
 b=lFomnyvfSA0MDOLT40/dvgILGrS0OY/+61Vfc5lFyeMrwNof+kB/LQsU5xDsO4zZa3
 1alFvyl4+91tke2y8s9JLfakhOAJP4UHMgmY07Cw2/nY48GreJMl0s8ij9UBbBnhs7wy
 BhNyWA45T5sNhNTZWnk1S/OzjUlK7mZyhcgJTnTkKReY69o9XS91Q27g0fZbVm96yMqT
 rVjmy2USYPLB6DhDCHyfCYmhAuI5Ak5Tu6YlEnvCbN8vrwNp6WHdPyQWVmvLfhceaJ3I
 Pw47lSmkLFJemLpZdSK4fYeuhbeQ1oHNGJEbH/88xPXgxwLz/fzwPLvlGgcmYvlMfdaL
 MqsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNMbjDq3eM2El7r0xpCkJA2h617aJWb8TM5oURgTDoxSwwa6FsUjOCnjagGIt/5dmqd1quTMZ1DYaM@nongnu.org
X-Gm-Message-State: AOJu0YxdAtXo+THBo54G6gLji2NoaF5zD1Y48mrxCnnwHPFZkIDGhzh5
 yp7LsxP7H1yqiKWS0ZowV23XQzArXqrohxS6GTygigNIvO7ozfdXPVbWhcQGRwWWjMrLKx2iX8y
 gUTos64AqwPWoqH4GQEjm592iqCaHdF92p/l4cGp6Ybl1MeVk9by5
X-Gm-Gg: ASbGncs0XAA7jVUfQxhHGL0KF+xTwiFy98jwpAKWO1pV7QAabQK63UbRLQTYb2J1G9F
 DZzmQt+BlVxQwVx46aTpLPMNONeEDrmprJ6pu5dCr0/VCJMiY7GMSYHOxpCqO3ya1yxzBfmI6Rc
 29m3tYj+u2/SmxTGziIt9m9Lp+0+PSgQkd6iSOltneYsuk37XmYAmdiIHIfoDXAiCzHV7V/bsGM
 p1QFeyOXAVCEH8V5LCTBp1jenB7lgcfMoodw9SNl/haoryr4dPYvNLtpHtNS+FqplAZrf/sj02C
 XUqqP7dj1ICzAhk4WokLb0biljCLRlZujcFV
X-Received: by 2002:a05:600c:9a3:b0:434:fa73:a907 with SMTP id
 5b1f17b1804b1-4389191b819mr434437565e9.13.1738088435809; 
 Tue, 28 Jan 2025 10:20:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmqBu9C4Ap2fo+nsVE7HGVxiZWFvtFhY1zUq4uPMLOJguB5uNnr/mwuJOIJPWFFX4fBJYUsw==
X-Received: by 2002:a05:600c:9a3:b0:434:fa73:a907 with SMTP id
 5b1f17b1804b1-4389191b819mr434437375e9.13.1738088435438; 
 Tue, 28 Jan 2025 10:20:35 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-50-234.web.vodafone.de.
 [109.42.50.234]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a176490sm14518927f8f.1.2025.01.28.10.20.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 10:20:35 -0800 (PST)
Message-ID: <7bb6ab1b-169e-4752-8aee-ef87877a38b4@redhat.com>
Date: Tue, 28 Jan 2025 19:20:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Add a ppc64 mac99 test
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-ppc@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20250128180742.1137741-1-clg@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250128180742.1137741-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 28/01/2025 19.07, Cédric Le Goater wrote:
> The test sequence boots from disk a mac99 machine in 64-bit mode, in
> which case the CPU is a PPC 970.
> 
> The buildroot rootfs is built with config :
> 
> BR2_powerpc64=y
> BR2_powerpc_970=y
> 
> and the kernel with the g5 deconfig.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   MAINTAINERS                          |  1 +
>   tests/functional/meson.build         |  2 ++
>   tests/functional/test_ppc64_mac99.py | 45 ++++++++++++++++++++++++++++
>   3 files changed, 48 insertions(+)
>   create mode 100644 tests/functional/test_ppc64_mac99.py
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3a2291d17d7e..ebf249173f00 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1446,6 +1446,7 @@ F: include/hw/pci-host/uninorth.h
>   F: include/hw/input/adb*
>   F: pc-bios/qemu_vga.ndrv
>   F: tests/functional/test_ppc_mac.py
> +F: tests/functional/test_ppc64_mac99.py
>   
>   Old World (g3beige)
>   M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 01a87b03e553..821a0a7c49ac 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -41,6 +41,7 @@ test_timeouts = {
>     'ppc64_powernv' : 480,
>     'ppc64_pseries' : 480,
>     'ppc64_tuxrun' : 420,
> +  'ppc64_mac99' : 120,
>     'riscv64_tuxrun' : 120,
>     's390x_ccw_virtio' : 420,
>     'sh4_tuxrun' : 240,
> @@ -181,6 +182,7 @@ tests_ppc64_system_thorough = [
>     'ppc64_powernv',
>     'ppc64_pseries',
>     'ppc64_tuxrun',
> +  'ppc64_mac99',
>   ]
>   
>   tests_riscv32_system_quick = [
> diff --git a/tests/functional/test_ppc64_mac99.py b/tests/functional/test_ppc64_mac99.py
> new file mode 100644
> index 000000000000..ba582d267dae
> --- /dev/null
> +++ b/tests/functional/test_ppc64_mac99.py
> @@ -0,0 +1,45 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test that boots a mac99 machine with a PPC970 CPU
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from qemu_test import LinuxKernelTest, Asset
> +from qemu_test import exec_command_and_wait_for_pattern
> +
> +class mac99Test(LinuxKernelTest):
> +
> +    ASSET_BR2_MAC99_LINUX = Asset(
> +        'https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main/buildroot/qemu_ppc64_mac99-2023.11-8-gdcd9f0f6eb-20240105/vmlinux',
> +        'd59307437e4365f2cced0bbd1b04949f7397b282ef349b7cafd894d74aadfbff')
> +
> +    ASSET_BR2_MAC99_ROOTFS = Asset(
> +        'https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main//buildroot/qemu_ppc64_mac99-2023.11-8-gdcd9f0f6eb-20240105/rootfs.ext2',
> +        'bbd5fd8af62f580bc4e585f326fe584e22856572633a8333178ea6d4ed4955a4')
> +
> +    def test_ppc64_mac99_buildroot(self):
> +        self.require_netdev('user')
> +
> +        linux_path = self.ASSET_BR2_MAC99_LINUX.fetch()
> +        rootfs_path = self.ASSET_BR2_MAC99_ROOTFS.fetch()
> +
> +        self.set_machine('mac99')

Nit: Move the set_machine to the top of the function, so that the assets 
don't have to be fetched in case the machine is not available.

With that nit fixed:
Reviewed-by: Thomas Huth <thuth@redhat.com>


> +        self.vm.set_console()
> +
> +        self.vm.add_args('-kernel', linux_path,
> +                         '-append', 'root=/dev/sda',
> +                         '-drive', f'file={rootfs_path},format=raw',
> +                         '-net', 'nic,model=sungem', '-net', 'user',
> +                         '-snapshot', '-nographic')

I just also noticed that we already have "-display none" in 
python/qemu/machine/machine.py, so you likely don't need the -nographic here 
(but looks like we've got that wrong in a bunch of tests already).

> +        self.vm.launch()
> +
> +        self.wait_for_console_pattern('>> OpenBIOS')
> +        self.wait_for_console_pattern('Linux version')
> +        self.wait_for_console_pattern('/init as init process')
> +        self.wait_for_console_pattern('gem 0000:f0:0e.0 eth0: Link is up at 100 Mbps')
> +        self.wait_for_console_pattern('buildroot login:')
> +        exec_command_and_wait_for_pattern(self, 'root', '#')
> +        exec_command_and_wait_for_pattern(self, 'poweroff', 'Power down')
> +
> +if __name__ == '__main__':
> +    LinuxKernelTest.main()


