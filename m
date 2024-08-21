Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB337C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 11:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgjng-0001q9-NK; Wed, 21 Aug 2024 07:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sgjna-0001pY-68
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 07:46:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sgjnW-0002Gy-LS
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 07:46:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724240798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OjjJOw+R6OUsuRLZ2H2WBE9WfmQVwNuokRFvz7aIje0=;
 b=X91RbzgEQiOIc0xjxoeIo1Nb9WOgKMm8+E1CXrsOatJ5cZeXy9n5BTBR8RC6T43kKDiVGE
 OeOWKc7rBqDBNnYPdMYj4OBYP/n2+kC7DHPKMXgS5/s8Q+tBp64k9KLlRDmyOdAmKooCCq
 pOvLYVRLjgj3kpmhVeaYaAJNfYFPCpQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-EQ6yeVa1NMC6xvZr6w38BQ-1; Wed, 21 Aug 2024 07:46:37 -0400
X-MC-Unique: EQ6yeVa1NMC6xvZr6w38BQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37187b43662so4026185f8f.0
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 04:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724240796; x=1724845596;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OjjJOw+R6OUsuRLZ2H2WBE9WfmQVwNuokRFvz7aIje0=;
 b=NP+itiFQry51H/pOKACJnO+FCaJy8ABoRRooc8YJVPq+0Ecoos1YK5ud4hx53VK0ex
 tiBp1XeV5+QvU9WmBfmZnKPzyPeDz9KUyHOLVlcmCYbIEyl1/EcMDscqktw8G+P28KT3
 OYQWjYGunWhj+dIG6qlqSvjZIDQ7E6sqe0m9O9FABpq7DhS78Ht5PtdkwQ7PphoArQYr
 OC8+QCXz0zKLG8BET1ZGX+NbohwD5dWg5PKkQeXBGtFDa/dte56ZgB0GPJA5UeGKBwqt
 3oflZeh4Io1RJ5yIMmhO2yGyzJZxII4FHUlsa8IWyxvaphmy4Uu5TcZ/F87qrGbeg73O
 6Y+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZaJ6kYLAvOSRkhykB+x2oOTlKG2IiK2J5doDEAY3wRorRu8aQa9uNNMi2GCTdJPg2sjPr02jp0LYF@nongnu.org
X-Gm-Message-State: AOJu0YxDvRhfDU9C4qtefQAe3JamWeGyxhObo7Dt6EJO64ac/9N1f7fT
 Qbsftwimku5JYSH2HKrOYuPSJbj/n3ycG6Mh6xKTnh/ttLcZBIaNFqnygEkvFzvpXAF8MX297Ti
 d5En4i5pH+2dHi6vHb2YjJ/MJRBT0Hf6xH4v42RUyvutW19jYuya4
X-Received: by 2002:a5d:5184:0:b0:368:65ad:529 with SMTP id
 ffacd0b85a97d-372fd5929f0mr1356871f8f.17.1724240795503; 
 Wed, 21 Aug 2024 04:46:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFnrOVJZmLuDYE+xx6MNkm/DgesDSjujySCejsOXmt2XJhLvQ7+LGkjolwt31TFDnHzRdb0A==
X-Received: by 2002:a5d:5184:0:b0:368:65ad:529 with SMTP id
 ffacd0b85a97d-372fd5929f0mr1356851f8f.17.1724240794920; 
 Wed, 21 Aug 2024 04:46:34 -0700 (PDT)
Received: from [10.33.192.191] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37189849b08sm15363101f8f.43.2024.08.21.04.46.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2024 04:46:34 -0700 (PDT)
Message-ID: <9a289ee9-63c4-470a-8256-da1f04e539aa@redhat.com>
Date: Wed, 21 Aug 2024 13:46:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Convert mips fuloong2e avocado test
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20240821112959.54237-1-philmd@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240821112959.54237-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 21/08/2024 13.29, Philippe Mathieu-Daudé wrote:
> Straight forward conversion. Update the SHA1 hashes to
> SHA256 hashes since SHA1 should not be used anymore nowadays.
> 
> Since the asset is expected locally and the test is guarded
> with QEMU_TEST_ALLOW_UNTRUSTED_CODE, keep it under the 'quick'
> category.
> 
>    $ RESCUE_YL_PATH=/path/to/rescue-yl QEMU_TEST_ALLOW_UNTRUSTED_CODE=1 \
>      make check-functional-mips64el
>    1/4 qemu:func-quick+func-mips64el / func-mips64el-empty_cpu_model      OK   0.12s   1 subtests passed
>    2/4 qemu:func-quick+func-mips64el / func-mips64el-version              OK   0.13s   1 subtests passed
>    3/4 qemu:func-quick+func-mips64el / func-mips64el-info_usernet         OK   0.15s   1 subtests passed
>    4/4 qemu:func-quick+func-mips64el / func-mips64el-mips64el_fuloong2e   OK   0.19s   1 subtests passed
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Based-on: <20240821082748.65853-1-thuth@redhat.com>
> ---
>   MAINTAINERS                                   |  2 +-
>   tests/functional/meson.build                  |  4 +++
>   .../test_mips64el_fuloong2e.py}               | 32 +++++++++----------
>   3 files changed, 21 insertions(+), 17 deletions(-)
>   rename tests/{avocado/machine_mips_fuloong2e.py => functional/test_mips64el_fuloong2e.py} (56%)
>   mode change 100644 => 100755
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 25e71ac14c..77fbb5d42e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1384,7 +1384,7 @@ S: Odd Fixes
>   F: hw/mips/fuloong2e.c
>   F: hw/pci-host/bonito.c
>   F: include/hw/pci-host/bonito.h
> -F: tests/avocado/machine_mips_fuloong2e.py
> +F: tests/functional/test_mips64el_fuloong2e.py
>   
>   Loongson-3 virtual platforms
>   M: Huacai Chen <chenhuacai@kernel.org>
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 12e08e365b..8d28313a65 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -51,6 +51,10 @@ tests_microblazeel_thorough = [
>     'microblazeel_s3adsp1800'
>   ]
>   
> +tests_mips64el_quick = [
> +  'mips64el_fuloong2e',
> +]
> +
>   tests_mips64el_thorough = [
>     'mips64el_loongson3v',
>   ]
> diff --git a/tests/avocado/machine_mips_fuloong2e.py b/tests/functional/test_mips64el_fuloong2e.py
> old mode 100644
> new mode 100755
> similarity index 56%
> rename from tests/avocado/machine_mips_fuloong2e.py
> rename to tests/functional/test_mips64el_fuloong2e.py
> index 89291f47b2..523dce4ec4
> --- a/tests/avocado/machine_mips_fuloong2e.py
> +++ b/tests/functional/test_mips64el_fuloong2e.py
> @@ -1,3 +1,5 @@
> +#!/usr/bin/env python3
> +#
>   # Functional tests for the Lemote Fuloong-2E machine.
>   #
>   # Copyright (c) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
> @@ -9,34 +11,32 @@
>   
>   import os
>   
> -from avocado import skipUnless
> -from avocado_qemu import QemuSystemTest
> -from avocado_qemu import wait_for_console_pattern
> +from qemu_test import QemuSystemTest, Asset
> +from qemu_test import wait_for_console_pattern
> +from unittest import skipUnless
>   
>   class MipsFuloong2e(QemuSystemTest):
>   
>       timeout = 60
>   
> -    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
> -    @skipUnless(os.getenv('RESCUE_YL_PATH'), 'RESCUE_YL_PATH not available')

Wouldn't it be better to keep the RESCUE_YL_PATH decorator?

> +    ASSET_KERNEL = Asset(
> +        # http://dev.lemote.com/files/resource/download/rescue/rescue-yl
> +        ('file://' + os.getenv('RESCUE_YL_PATH')),

The precaching is now failing if this environment variable has not been set:

Traceback (most recent call last):
   File 
"/home/thuth/devel/qemu/tests/functional/test_mips64el_fuloong2e.py", line 
18, in <module>
     class MipsFuloong2e(QemuSystemTest):
   File 
"/home/thuth/devel/qemu/tests/functional/test_mips64el_fuloong2e.py", line 
24, in MipsFuloong2e
     ('file://' + os.getenv('RESCUE_YL_PATH')),
      ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
TypeError: can only concatenate str (not "NoneType") to str

Since we don't really need precaching in this case, maybe you could move the 
asset definition into the function itself, or do this test without the asset 
framework?

  Thomas

> +        'ab588d3316777c62cc81baa20ac92e98b01955c244dff3794b711bc34e26e51d')
> +
> +    @skipUnless(os.getenv('QEMU_TEST_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
>       def test_linux_kernel_isa_serial(self):
> -        """
> -        :avocado: tags=arch:mips64el
> -        :avocado: tags=machine:fuloong2e
> -        :avocado: tags=endian:little
> -        :avocado: tags=device:bonito64
> -        :avocado: tags=device:via686b
> -        """
>           # Recovery system for the Yeeloong laptop
>           # (enough to test the fuloong2e southbridge, accessing its ISA bus)
> -        # http://dev.lemote.com/files/resource/download/rescue/rescue-yl
> -        kernel_hash = 'ec4d1bd89a8439c41033ca63db60160cc6d6f09a'
> -        kernel_path = self.fetch_asset('file://' + os.getenv('RESCUE_YL_PATH'),
> -                                       asset_hash=kernel_hash)
> +        kernel_path = self.ASSET_KERNEL.fetch()
>   
> +        self.set_machine('fuloong2e')
>           self.vm.set_console()
>           self.vm.add_args('-kernel', kernel_path)
>           self.vm.launch()
>           wait_for_console_pattern(self, 'Linux version 2.6.27.7lemote')
>           cpu_revision = 'CPU revision is: 00006302 (ICT Loongson-2)'
>           wait_for_console_pattern(self, cpu_revision)
> +
> +if __name__ == '__main__':
> +    QemuSystemTest.main()


