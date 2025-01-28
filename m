Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D259C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 18:36:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcqRT-0007hz-4Y; Tue, 28 Jan 2025 13:36:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tcqRR-0007hR-L6
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 13:36:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tcqRP-00061F-QB
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 13:36:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738089361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZBsNpmo4Vjr2PKar94ML5Q+krZSNYFwajQsJouTlgmo=;
 b=iOBsrYzKyL6svaeHApPNFUGz6IY6Afcsyg5fFFPUPnAtNX9rzOIMFBD95Xi2BghSxGlGK6
 4a8IaD5DXU/qXy7RbFc6OHycfQTDBi+2N2h2gap1kMkXYUGcTVxSplp8WXKodoJLultUVx
 ScLa6jiGNsY7ZfYLoLVLTeyFzFVaP+o=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-6Wbf3R7jPGyRcZ_GcksC7Q-1; Tue, 28 Jan 2025 13:35:59 -0500
X-MC-Unique: 6Wbf3R7jPGyRcZ_GcksC7Q-1
X-Mimecast-MFC-AGG-ID: 6Wbf3R7jPGyRcZ_GcksC7Q
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6e19e09cc20so101462726d6.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 10:35:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738089358; x=1738694158;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZBsNpmo4Vjr2PKar94ML5Q+krZSNYFwajQsJouTlgmo=;
 b=gBzV1xyTTkWaE3CY697PlRqzEUmc8RxM2tsWYnRhmnwX2lpoIFGvJ3+lHErXHJcXrH
 zcKSx977FZXKsF4VhDAKYVv2kD6EkAoxZRel7QQvVhgfG9eSN013HbxHEoDJ6j2HGRKM
 uTSsQKP46ndhhvKFNZGkFzLwLF2QPRBCpcNBXLu8zSxaYMFr/nStkTDbCIEbQZcjHbxG
 mal2ehvuQQ4+x6Srj+mi0z7X6J59I7m3P1uZBIbuQ0ht3IB+8pSuWpDqf+FDbOO64jBa
 AqrDF5aS5HCBgcPBf6NQ38hyqC8eZTrAqH1xXRmAdeQax2A9SspGUJmy5/HjxCmnJY3d
 /k5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGQ61hx119lJ4rCuGgOP/YD6+bK2acKZJaV02jWbopDs8d8l89Xp+32ty5DwVxX0OULDnPwyp6nzea@nongnu.org
X-Gm-Message-State: AOJu0YxhQ6KKSd93ruYZTsCVB+L6g9z8mbs4FHLGcj0UkPSnu9YmAhg4
 1DtwkyODzXqdzG6QRya6qBls1jaEhysUomSbq+SyxfRTAvGNpaFMpPB29U3lGx3BSQApJp/bWNS
 QgiJSSyREBVbMS7U4uzh0VEd85Jftk8GnwJAhAB7TE+thALEIe9cv
X-Gm-Gg: ASbGncuSlmTuXXavy1QM72AK4C+g4FnYUJdTW1/7e89oSIb1QxRw3yoxnfMg8c6ReqC
 GCOgAAQw8QpCQoCwf7yn+Pqqvs1X4n1ueKE9IONEctAlPDeiv0QDuhP66MX7O1k2BX3WGyGW9sR
 9FpyFdacrC4h5o/HKuQ6MJFeRX30YG0tm4UHO7Pso/xtANNvDrIJXpVCPFYAiQ6lB/Fus0x1NCn
 N4QCsRzHv/yf3nWiybrR9BIaSTpTkQOo/imdHUnsOMrFkaSlOdM5Y9bbMj/WLVpSN5KXHYmz8b5
 iU1cwZ2txZ59lIFg5TqYly3TKFBeLbZ1iz9i2VcayfM=
X-Received: by 2002:a05:6214:3007:b0:6dd:d3b:de38 with SMTP id
 6a1803df08f44-6e243bb8914mr3179976d6.16.1738089358526; 
 Tue, 28 Jan 2025 10:35:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGU/gSQxznkFDYYXj6YwunynqJa5XLyDvODHsTyiupdtRMVvUJ1QgBJ6R5AZW0GJhNZh2Moqg==
X-Received: by 2002:a05:6214:3007:b0:6dd:d3b:de38 with SMTP id
 6a1803df08f44-6e243bb8914mr3179516d6.16.1738089357997; 
 Tue, 28 Jan 2025 10:35:57 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e2058c2164sm47625716d6.99.2025.01.28.10.35.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 10:35:57 -0800 (PST)
Message-ID: <9bf6cf01-d8c4-4ed8-808d-03e6ee05bc7b@redhat.com>
Date: Tue, 28 Jan 2025 19:35:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Add a ppc64 mac99 test
To: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20250128180742.1137741-1-clg@redhat.com>
 <7bb6ab1b-169e-4752-8aee-ef87877a38b4@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <7bb6ab1b-169e-4752-8aee-ef87877a38b4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 1/28/25 19:20, Thomas Huth wrote:
> On 28/01/2025 19.07, Cédric Le Goater wrote:
>> The test sequence boots from disk a mac99 machine in 64-bit mode, in
>> which case the CPU is a PPC 970.
>>
>> The buildroot rootfs is built with config :
>>
>> BR2_powerpc64=y
>> BR2_powerpc_970=y
>>
>> and the kernel with the g5 deconfig.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   MAINTAINERS                          |  1 +
>>   tests/functional/meson.build         |  2 ++
>>   tests/functional/test_ppc64_mac99.py | 45 ++++++++++++++++++++++++++++
>>   3 files changed, 48 insertions(+)
>>   create mode 100644 tests/functional/test_ppc64_mac99.py
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 3a2291d17d7e..ebf249173f00 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1446,6 +1446,7 @@ F: include/hw/pci-host/uninorth.h
>>   F: include/hw/input/adb*
>>   F: pc-bios/qemu_vga.ndrv
>>   F: tests/functional/test_ppc_mac.py
>> +F: tests/functional/test_ppc64_mac99.py
>>   Old World (g3beige)
>>   M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
>> index 01a87b03e553..821a0a7c49ac 100644
>> --- a/tests/functional/meson.build
>> +++ b/tests/functional/meson.build
>> @@ -41,6 +41,7 @@ test_timeouts = {
>>     'ppc64_powernv' : 480,
>>     'ppc64_pseries' : 480,
>>     'ppc64_tuxrun' : 420,
>> +  'ppc64_mac99' : 120,
>>     'riscv64_tuxrun' : 120,
>>     's390x_ccw_virtio' : 420,
>>     'sh4_tuxrun' : 240,
>> @@ -181,6 +182,7 @@ tests_ppc64_system_thorough = [
>>     'ppc64_powernv',
>>     'ppc64_pseries',
>>     'ppc64_tuxrun',
>> +  'ppc64_mac99',
>>   ]
>>   tests_riscv32_system_quick = [
>> diff --git a/tests/functional/test_ppc64_mac99.py b/tests/functional/test_ppc64_mac99.py
>> new file mode 100644
>> index 000000000000..ba582d267dae
>> --- /dev/null
>> +++ b/tests/functional/test_ppc64_mac99.py
>> @@ -0,0 +1,45 @@
>> +#!/usr/bin/env python3
>> +#
>> +# Functional test that boots a mac99 machine with a PPC970 CPU
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +from qemu_test import LinuxKernelTest, Asset
>> +from qemu_test import exec_command_and_wait_for_pattern
>> +
>> +class mac99Test(LinuxKernelTest):
>> +
>> +    ASSET_BR2_MAC99_LINUX = Asset(
>> +        'https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main/buildroot/qemu_ppc64_mac99-2023.11-8-gdcd9f0f6eb-20240105/vmlinux',
>> +        'd59307437e4365f2cced0bbd1b04949f7397b282ef349b7cafd894d74aadfbff')
>> +
>> +    ASSET_BR2_MAC99_ROOTFS = Asset(
>> +        'https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main//buildroot/qemu_ppc64_mac99-2023.11-8-gdcd9f0f6eb-20240105/rootfs.ext2',
>> +        'bbd5fd8af62f580bc4e585f326fe584e22856572633a8333178ea6d4ed4955a4')
>> +
>> +    def test_ppc64_mac99_buildroot(self):
>> +        self.require_netdev('user')
>> +
>> +        linux_path = self.ASSET_BR2_MAC99_LINUX.fetch()
>> +        rootfs_path = self.ASSET_BR2_MAC99_ROOTFS.fetch()
>> +
>> +        self.set_machine('mac99')
> 
> Nit: Move the set_machine to the top of the function, so that the assets don't have to be fetched in case the machine is not available.
>
> With that nit fixed:
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> 
>> +        self.vm.set_console()
>> +
>> +        self.vm.add_args('-kernel', linux_path,
>> +                         '-append', 'root=/dev/sda',
>> +                         '-drive', f'file={rootfs_path},format=raw',
>> +                         '-net', 'nic,model=sungem', '-net', 'user',
>> +                         '-snapshot', '-nographic')
> 
> I just also noticed that we already have "-display none" in python/qemu/machine/machine.py, so you likely don't need the -nographic here (but looks like we've got that wrong in a bunch of tests already).

I think we need -nographic else OpenBIOS crashes.  I will check.


Thanks,

C.




> 
>> +        self.vm.launch()
>> +
>> +        self.wait_for_console_pattern('>> OpenBIOS')
>> +        self.wait_for_console_pattern('Linux version')
>> +        self.wait_for_console_pattern('/init as init process')
>> +        self.wait_for_console_pattern('gem 0000:f0:0e.0 eth0: Link is up at 100 Mbps')
>> +        self.wait_for_console_pattern('buildroot login:')
>> +        exec_command_and_wait_for_pattern(self, 'root', '#')
>> +        exec_command_and_wait_for_pattern(self, 'poweroff', 'Power down')
>> +
>> +if __name__ == '__main__':
>> +    LinuxKernelTest.main()
> 


