Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D029FC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 07:25:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMN1L-0001C8-6p; Wed, 26 Jun 2024 03:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sMN1K-0001Bb-4N
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 03:24:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sMN1I-0003Bk-Ia
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 03:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719386681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=EiUH4c2vRipZegzD2+1WaxJbMcrnjLB+UG+SI2liAfY=;
 b=KOvz3bD82ePTFYzfEbKx9lZyDNMogPiTnPfeRz/MZFMNj+r6kz53V6XFirjZ0D7wuKQl++
 kiToE0vGCbsVDYWc9LXnauss6viLq1GyXiLz4bE/0lRn5SdGmh8o7Ri9LGWa3vCPKA/eIt
 yMaE4+cqCJs8I/kPN18/qbi/K8fQE4k=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-ho18He6_Oey9KP92BVBkSg-1; Wed, 26 Jun 2024 03:24:39 -0400
X-MC-Unique: ho18He6_Oey9KP92BVBkSg-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-52cdbeaafcdso3302689e87.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 00:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719386678; x=1719991478;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EiUH4c2vRipZegzD2+1WaxJbMcrnjLB+UG+SI2liAfY=;
 b=jAE2WTE5aow3EIQH/cRXEifoVwNQvc9waYNU1aj94wBgIv2jQPTro5/E/ugyaGDXGB
 5FM+lp5CJbSt252dPURR2dAHX1v1einkmSA6DT/63A+H/TikMNRh9H0Og4+bzl+kKdhF
 tWm+RvQ5dYT9FUHQglHixOCCyhNW0A65Pp58T8o21KbCn/sZ9BjdU6mEV53F1Y2/0Uev
 zCqUPULlaIFBw0Vr96KKIu5RDoCAENSIT4hAnx5HIXv3+BjJsCk8m8sX3JlnqQmMTrsG
 Iqf450SoZRpLiVZpOYE7f09WrPhc2WQotrMjTOrEUFnVNekOYVyiRdyOjv2uBQh9yoBS
 PVnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOrNCqQC50VHWygdtrDM8VTLq5jIPbCBo/N8lBfoit4xJN2FVqLTmDbmW/adfG22G02MfZYOsUV+rZeCROZ2xD864iA+s=
X-Gm-Message-State: AOJu0Yx0UWGaxdDJUuPfImp5pBdFL5lHGf070WHjaFUAZJ4s7ObgGtCw
 oggvcZbNanwzMWg+6ZPNlenCsedBJ5+TKZ+IGL4eFA6IgS0Cuqk4snBD7U3ymhYSR3KksgYa9Gc
 UDzhCOrtFNM2mlgIXNQIH4csuVnhE5kByOFYTkExkBH+Y1RpKHrHe
X-Received: by 2002:a05:6512:2394:b0:52c:d84c:1182 with SMTP id
 2adb3069b0e04-52ce1862c12mr6874518e87.64.1719386678009; 
 Wed, 26 Jun 2024 00:24:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrNUhRYo+SGtZUMj8sOuKsMzpXgQwtJ5mDM7EPVONvbiMLNiLwtP4RqLlTOzxg01vFN1avnQ==
X-Received: by 2002:a05:6512:2394:b0:52c:d84c:1182 with SMTP id
 2adb3069b0e04-52ce1862c12mr6874494e87.64.1719386677597; 
 Wed, 26 Jun 2024 00:24:37 -0700 (PDT)
Received: from [10.33.192.191] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-366bd575f6asm14309576f8f.6.2024.06.26.00.24.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 00:24:37 -0700 (PDT)
Message-ID: <92f90366-bc65-4aa7-a64b-a7518df2e2f4@redhat.com>
Date: Wed, 26 Jun 2024 09:24:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/avocado: add hotplug_blk test
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, crosa@redhat.com, philmd@linaro.org,
 wainersm@redhat.com, bleal@redhat.com, yc-core@yandex-team.ru
References: <20240409065854.366856-1-vsementsov@yandex-team.ru>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240409065854.366856-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 09/04/2024 08.58, Vladimir Sementsov-Ogievskiy wrote:
> Introduce a test, that checks that plug/unplug of virtio-blk device
> works.
> 
> (the test is developed by copying hotplug_cpu.py, so keep original
> copyright)
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   tests/avocado/hotplug_blk.py | 69 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 69 insertions(+)
>   create mode 100644 tests/avocado/hotplug_blk.py
> 
> diff --git a/tests/avocado/hotplug_blk.py b/tests/avocado/hotplug_blk.py
> new file mode 100644
> index 0000000000..5dc30f6616
> --- /dev/null
> +++ b/tests/avocado/hotplug_blk.py
> @@ -0,0 +1,69 @@
> +# Functional test that hotplugs a virtio blk disk and checks it on a Linux
> +# guest
> +#
> +# Copyright (c) 2021 Red Hat, Inc.
> +# Copyright (c) Yandex
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +import time
> +
> +from avocado_qemu import LinuxTest
> +
> +
> +class HotPlug(LinuxTest):
> +    def blockdev_add(self) -> None:
> +        self.vm.cmd('blockdev-add', **{
> +            'driver': 'null-co',
> +            'size': 1073741824,
> +            'node-name': 'disk'
> +        })
> +
> +    def assert_vda(self) -> None:
> +        self.ssh_command('test -e /sys/block/vda')
> +
> +    def assert_no_vda(self) -> None:
> +        with self.assertRaises(AssertionError):
> +            self.assert_vda()
> +
> +    def plug(self) -> None:
> +        args = {
> +            'driver': 'virtio-blk-pci',
> +            'drive': 'disk',
> +            'id': 'virtio-disk0',
> +            'bus': 'pci.1',
> +            'addr': 1
> +        }
> +
> +        self.assert_no_vda()
> +        self.vm.cmd('device_add', args)
> +        try:
> +            self.assert_vda()
> +        except AssertionError:
> +            time.sleep(1)
> +            self.assert_vda()
> +
> +    def unplug(self) -> None:
> +        self.vm.cmd('device_del', id='virtio-disk0')
> +
> +        self.vm.event_wait('DEVICE_DELETED', 1.0,
> +                           match={'data': {'device': 'virtio-disk0'}})
> +
> +        self.assert_no_vda()
> +
> +    def test(self) -> None:
> +        """
> +        :avocado: tags=arch:x86_64
> +        :avocado: tags=machine:q35
> +        :avocado: tags=accel:kvm
> +        """
> +        self.require_accelerator('kvm')
> +        self.vm.add_args('-accel', 'kvm')
> +        self.vm.add_args('-device', 'pcie-pci-bridge,id=pci.1,bus=pcie.0')
> +
> +        self.launch_and_wait()
> +        self.blockdev_add()
> +
> +        self.plug()
> +        self.unplug()

Reviewed-by: Thomas Huth <thuth@redhat.com>


