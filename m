Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E577C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 10:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCGbN-0005Bc-Sy; Wed, 29 May 2024 06:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sCGbM-0005Ag-DR
 for qemu-devel@nongnu.org; Wed, 29 May 2024 06:32:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sCGb7-0007Sp-6v
 for qemu-devel@nongnu.org; Wed, 29 May 2024 06:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716978716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VUzc/y7JjozyCM6dvt2q7P8zpRhJJhqGSHn7G9JDTfU=;
 b=gjh6Rjd1g3AWxCzZnPyNHTOnObisPVOvcfjwP12X/ETDutj/Fc1y3EMrmEuUfZto5EmX52
 bsnOpUylu0HbTif/WiDtKrPGyWKmhOMVzQdaudWIKd3Q73AOzPgUUrjBEr5sVZW32cLfd+
 lqzKCozRkxgyXEy4vRkFbh6NQbSy2Xw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-VntcRApgNa6mJ6fxkE2MWg-1; Wed, 29 May 2024 06:31:54 -0400
X-MC-Unique: VntcRApgNa6mJ6fxkE2MWg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4202c2d397aso12866565e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 03:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716978713; x=1717583513;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VUzc/y7JjozyCM6dvt2q7P8zpRhJJhqGSHn7G9JDTfU=;
 b=hDdjHUNleoUTBDgxrjpN9bzWhR/x50OzR1bnIO9BFBcXQBfBEoIhaXBIFxrk2xa7Dt
 EA+G0xh/HqlH6i3pC0SJavL8DROxm/S49trmBMuOG7dyrEmImDNU+URW3AT7ZKBDIG/I
 0LHeUpOZbIKw1S93/J7/wm7nZBe8P8b+oQr3XErV8shEuZnRpfjCNfGUrDkigsaglUKQ
 jOL+EcF3KLYhZ7Ap9IWEuE2UFB0pa1JpwoZ8TDO9xhB26CLVOIJQ9Jb67n4gIlFcpxl8
 T+/6nE0NK3p8A/5Q/fb5lqmbZtk/SXcz7bQhGJcvTbb0TYEUTOf/yrPEGjXbrr4zhRCV
 z8hw==
X-Gm-Message-State: AOJu0YzHe/Lnx2z/nuobL5YjyMsgUPi6nvlovLbMrsSBUuoJ3XuAdl/T
 8ZiIjE5LmlN7GBqXbULhVCrg9ssJipaJ0ZbqAVMNHTG8HQ5gO3CJDIIgH/iRT22ib/LpEVRhsiy
 qU3FSnogoXSPQhsG0Iy1eUl0okihLS8IZlCMDE3oZQirsvmAMVBQN5ukzaG82
X-Received: by 2002:a05:600c:4703:b0:420:1fab:1798 with SMTP id
 5b1f17b1804b1-421089fe2c2mr111896875e9.29.1716978713244; 
 Wed, 29 May 2024 03:31:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsfNTWLK1Drl1cJvVn73vsKfLK/YrLTI8Qe5qcE7vkn3+aAraEJim8Liwq9w0O4uve+OzHgw==
X-Received: by 2002:a05:600c:4703:b0:420:1fab:1798 with SMTP id
 5b1f17b1804b1-421089fe2c2mr111896735e9.29.1716978712734; 
 Wed, 29 May 2024 03:31:52 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-176-229.web.vodafone.de.
 [109.43.176.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42100eecbd4sm207836045e9.8.2024.05.29.03.31.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 May 2024 03:31:52 -0700 (PDT)
Message-ID: <3819e261-646d-467a-b783-85700b0e6842@redhat.com>
Date: Wed, 29 May 2024 12:31:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: tests/avocado: Add LoongArch machine start test
To: Song Gao <gaosong@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20230515111908.2606580-1-gaosong@loongson.cn>
 <20230515111908.2606580-3-gaosong@loongson.cn>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20230515111908.2606580-3-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 15/05/2023 13.19, Song Gao wrote:
> Add a new test in tests/avocado to check LoongArch virt machine start.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> Message-Id: <20230513012744.1885728-1-gaosong@loongson.cn>
> ---
>   MAINTAINERS                        |  1 +
>   tests/avocado/machine_loongarch.py | 58 ++++++++++++++++++++++++++++++
>   2 files changed, 59 insertions(+)
>   create mode 100644 tests/avocado/machine_loongarch.py
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ff2aa53bb9..50585117a0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -245,6 +245,7 @@ M: Xiaojuan Yang <yangxiaojuan@loongson.cn>
>   S: Maintained
>   F: target/loongarch/
>   F: tests/tcg/loongarch64/
> +F: tests/avocado/machine_loongarch.py
>   
>   M68K TCG CPUs
>   M: Laurent Vivier <laurent@vivier.eu>
> diff --git a/tests/avocado/machine_loongarch.py b/tests/avocado/machine_loongarch.py
> new file mode 100644
> index 0000000000..7d8a3c1fa5
> --- /dev/null
> +++ b/tests/avocado/machine_loongarch.py
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# LoongArch virt test.
> +#
> +# Copyright (c) 2023 Loongson Technology Corporation Limited
> +#
> +
> +from avocado_qemu import QemuSystemTest
> +from avocado_qemu import exec_command_and_wait_for_pattern
> +from avocado_qemu import wait_for_console_pattern
> +
> +class LoongArchMachine(QemuSystemTest):
> +    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
> +
> +    timeout = 120
> +
> +    def wait_for_console_pattern(self, success_message, vm=None):
> +        wait_for_console_pattern(self, success_message,
> +                                 failure_message='Kernel panic - not syncing',
> +                                 vm=vm)
> +
> +    def test_loongarch64_devices(self):
> +
> +        """
> +        :avocado: tags=arch:loongarch64
> +        :avocado: tags=machine:virt
> +        """
> +
> +        kernel_url = ('https://github.com/yangxiaojuan-loongson/qemu-binary/'
> +                      'releases/download/binary-files/vmlinuz.efi')
> +        kernel_hash = '951b485b16e3788b6db03a3e1793c067009e31a2'
> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +
> +        initrd_url = ('https://github.com/yangxiaojuan-loongson/qemu-binary/'
> +                      'releases/download/binary-files/ramdisk')
> +        initrd_hash = 'c67658d9b2a447ce7db2f73ba3d373c9b2b90ab2'
> +        initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
> +
> +        bios_url = ('https://github.com/yangxiaojuan-loongson/qemu-binary/'
> +                    'releases/download/binary-files/QEMU_EFI.fd')
> +        bios_hash = ('dfc1bfba4853cd763b9d392d0031827e8addbca8')
> +        bios_path = self.fetch_asset(bios_url, asset_hash=bios_hash)

  Hi!

FYI, the test does not seem to work anymore - apparently the binaries have 
changed and now the hashes do not match anymore. Could you please update it? 
(preferably with some versioned binaries that do not change in the course of 
time?)

  Thank you very much!
   Thomas


