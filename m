Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E371C3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 06:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2l2x-0002rg-7e; Thu, 10 Apr 2025 02:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u2l2o-0002l3-Ft
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 02:05:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u2l2m-0001ow-2k
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 02:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744265142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=srJnrWC5m/uVmI/yE8vzwiF7k5u1bDwTF3N57h0kArI=;
 b=KeqyhpmWZUcfx+DZIXIViDQf8XDRpzcgsgzrNPbS7Rlkf4RS+T2BvYaXfQkseDIWXv6M3B
 hC16BnqO5upAPUztS6ITkrkCUBMaau1C3vIBg3ZpZ52UGbrBWmHdAJmlCcGekjL0HQipGf
 hhzK1gQ570Ouk49vDreg3l7SgmAkXdw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-sao4kNCVPjOe8cbKunn1RA-1; Thu, 10 Apr 2025 02:05:39 -0400
X-MC-Unique: sao4kNCVPjOe8cbKunn1RA-1
X-Mimecast-MFC-AGG-ID: sao4kNCVPjOe8cbKunn1RA_1744265138
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5f05d36993aso431137a12.0
 for <qemu-devel@nongnu.org>; Wed, 09 Apr 2025 23:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744265138; x=1744869938;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=srJnrWC5m/uVmI/yE8vzwiF7k5u1bDwTF3N57h0kArI=;
 b=GgLDRIBTPAa/uc+v2tA/fSCTFBatS7QqAJjTxCngwBBpgK1x8McmmmO4hIox8hlD+x
 gy4MX/Rm+ENMTGzuuVICPNrH/UIjqM5zwY1uos2WfSN0GFapju3bE7MZWFGOhYWw0I7Q
 O1KjLg2+W3WWDqNay6/RMzu1popgHIVxhqfVSL2tEmLXAxvbpyz3GWIoK7YafgahomoM
 ngSmuzxkMKtCA+rtK6Y7Q2mAL6snt4rm27HR7JI9M6Nap0nkjwldKorojBxENvbPR4IB
 kwU/RJbtdppBUALUgXi4h2W2YZRL2+mpnL+5H0hj6Gr4JYoIEDTu3b4nAZBVg+B2cLoS
 sGLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgEKUFvZg00qbKThwE2/iGCl9POdc9iqTJPi/EIX42V2E1ApbtkauDrybEt7PRa9gMx/Y2zhhvae3E@nongnu.org
X-Gm-Message-State: AOJu0Yz1MI+kOcgnmZNWnXLdMSQf54CSgzC1mcHF0i6tawIFcMwM9L84
 N+H00pdiVCnYi2j4qo8EqiwDP5s6yAYnWtNXESgjq3CaHWaKaxdlIQlXmz2UHDw1oyxzoVXeIOi
 8jdl4CfFuZm2MoHz4sHRo2zxTkRXU2OS5A6h9I1ilBYWkTpG0FJW2
X-Gm-Gg: ASbGnctth238hMU/DHAJWHT1nkVZni9Gac6lfC5dH/nq7TF8ZpoonBxf+wI2rcy6Iir
 j/4EfrQ6lSVmtIiqekVV6MsJ8LfvHTXZRgERvJX5nyNZLEvFC5axNZlfW58Ubwxyst55qWt5VgA
 GbiAyuF/2pLm/nCixW2ES65wtd193wGb9G66kVcUo2FznwBdLCWLYT/YWcbxhjYhEiedxUdEvuN
 isCjJ/Hy+kX0nWZWs30NRZdhoMrsJL9sKO/RYo85RqvDTjpP+qYyT2xIC9cOPUiFn6ZlSwdTEQH
 F1HJ1UeTh2QdA1TLf0wViaxGrWhFFuopButnm0GaDIQ=
X-Received: by 2002:a05:6402:84f:b0:5e5:49af:411d with SMTP id
 4fb4d7f45d1cf-5f32926bbbdmr1135386a12.17.1744265138061; 
 Wed, 09 Apr 2025 23:05:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlMcBfWq0Ip9uQwYbtHd1+Ee4dNHPJOdIKUGRBE1s3frNOFKY9vDcJNeurGtHCEBgUuaqwdg==
X-Received: by 2002:a05:6402:84f:b0:5e5:49af:411d with SMTP id
 4fb4d7f45d1cf-5f32926bbbdmr1135375a12.17.1744265137680; 
 Wed, 09 Apr 2025 23:05:37 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-221.web.vodafone.de.
 [109.42.49.221]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f2fbc2b975sm1766021a12.33.2025.04.09.23.05.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Apr 2025 23:05:37 -0700 (PDT)
Message-ID: <aa47d49a-b81a-46cf-811a-2045e453f4bf@redhat.com>
Date: Thu, 10 Apr 2025 08:05:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0? v2] tests/functional: Add test for imx8mp-evk
 board with USDHC coverage
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20250409202630.19667-1-shentey@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250409202630.19667-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.505,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 09/04/2025 22.26, Bernhard Beschow wrote:
> Introduce a functional test which boots Debian 12 on the imx8mp-evk board. Since
> the root filesystem resides on an SD card, the test also verifies the basic
> operation of the USDHC.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> 
> --
> v2:
> * Make test file executable (Thomas)
> * Omit fetch() (Thomas)
> * Omit "-accel tcg" (Thomas)
> * Add "snapshot=on" to make potential future tests independent
> 
> Supersedes: 20250405214900.7114-1-shentey@gmail.com
> ---
>   MAINTAINERS                                 |  1 +
>   tests/functional/meson.build                |  1 +
>   tests/functional/test_aarch64_imx8mp_evk.py | 66 +++++++++++++++++++++
>   3 files changed, 68 insertions(+)
>   create mode 100755 tests/functional/test_aarch64_imx8mp_evk.py
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d54b5578f8..4ceffa89dc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -833,6 +833,7 @@ F: include/hw/arm/fsl-imx8mp.h
>   F: include/hw/misc/imx8mp_*.h
>   F: include/hw/pci-host/fsl_imx8m_phy.h
>   F: docs/system/arm/imx8mp-evk.rst
> +F: tests/functional/test_aarch64_imx8mp_evk.py
>   F: tests/qtest/rs5c372-test.c
>   
>   MPS2 / MPS3
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 0f8be30fe2..aaaf3472f1 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -75,6 +75,7 @@ tests_aarch64_system_quick = [
>   
>   tests_aarch64_system_thorough = [
>     'aarch64_aspeed',
> +  'aarch64_imx8mp_evk',
>     'aarch64_raspi3',
>     'aarch64_raspi4',
>     'aarch64_replay',
> diff --git a/tests/functional/test_aarch64_imx8mp_evk.py b/tests/functional/test_aarch64_imx8mp_evk.py
> new file mode 100755
> index 0000000000..62fee74044
> --- /dev/null
> +++ b/tests/functional/test_aarch64_imx8mp_evk.py
> @@ -0,0 +1,66 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test that boots a Linux kernel and checks the console
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from qemu_test import LinuxKernelTest, Asset
> +

In case you respin (due to other reasons), please add a second empty line 
before the "class" statement (that's the style that we use in the other 
tests, too).

Anyway:
Reviewed-by: Thomas Huth <thuth@redhat.com>


> +class Imx8mpEvkMachine(LinuxKernelTest):
> +
> +    ASSET_IMAGE = Asset(
> +        ('https://cloud.debian.org/images/cloud/bookworm/20231210-1590/'
> +         'debian-12-generic-arm64-20231210-1590.tar.xz'),
> +        '7ebf1577b32d5af6204df74b54ca2e4675de9b5a9fa14f3ff70b88eeb7b3b359')
> +
> +    KERNEL_OFFSET = 0x51000000
> +    KERNEL_SIZE = 32622528
> +    INITRD_OFFSET = 0x76000000
> +    INITRD_SIZE = 30987766
> +    DTB_OFFSET = 0x64F51000
> +    DTB_SIZE = 45 * 1024
> +
> +    def extract(self, in_path, out_path, offset, size):
> +        try:
> +            with open(in_path, "rb") as source:
> +                source.seek(offset)
> +                data = source.read(size)
> +            with open(out_path, "wb") as target:
> +                target.write(data)
> +        except (IOError, ValueError) as e:
> +            self.log.error(f"Failed to extract {out_path}: {e}")
> +            raise
> +
> +    def setUp(self):
> +        super().setUp()
> +
> +        self.image_path = self.scratch_file("disk.raw")
> +        self.kernel_path = self.scratch_file("linux")
> +        self.initrd_path = self.scratch_file("initrd.zstd")
> +        self.dtb_path = self.scratch_file("imx8mp-evk.dtb")
> +
> +        self.archive_extract(self.ASSET_IMAGE)
> +        self.extract(self.image_path, self.kernel_path,
> +                     self.KERNEL_OFFSET, self.KERNEL_SIZE)
> +        self.extract(self.image_path, self.initrd_path,
> +                     self.INITRD_OFFSET, self.INITRD_SIZE)
> +        self.extract(self.image_path, self.dtb_path,
> +                     self.DTB_OFFSET, self.DTB_SIZE)
> +
> +    def test_aarch64_imx8mp_evk_usdhc(self):
> +        self.set_machine('imx8mp-evk')
> +        self.vm.set_console(console_index=1)
> +        self.vm.add_args('-m', '2G',
> +                         '-smp', '4',
> +                         '-kernel', self.kernel_path,
> +                         '-initrd', self.initrd_path,
> +                         '-dtb', self.dtb_path,
> +                         '-append', 'root=/dev/mmcblk2p1',
> +                         '-drive', f'file={self.image_path},if=sd,bus=2,'
> +                                    'format=raw,id=mmcblk2,snapshot=on')
> +
> +        self.vm.launch()
> +        self.wait_for_console_pattern('Welcome to ')
> +
> +if __name__ == '__main__':
> +    LinuxKernelTest.main()


