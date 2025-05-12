Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19623C3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 08:00:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEO4m-0007HC-FS; Mon, 12 May 2025 03:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uEO4k-0007Gg-6T
 for qemu-devel@nongnu.org; Mon, 12 May 2025 03:59:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uEO4h-0006Bn-MF
 for qemu-devel@nongnu.org; Mon, 12 May 2025 03:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747036786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QIK8nGQ0MEZFLKvoSSeOKf9NCIFZ/tj6SPwIdGOL6T4=;
 b=RMUpXrHxKMYIRn0PY+rIBJg/LQ5zxpguPdAcXbi5URiDeGKkkLgzsTUVjqnY1deU2lorHd
 fCRRDT0FgmHLnW2LmnYA9DOBlEhAyF0vPqykctQgZivj/rkrXeEqFHy/dHbRlblCLwFFa8
 YT3bpBYoznGrVM3Oq7ao+j5QeuInAoo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-dz_VUxxDMiqP1WAFmLNJiA-1; Mon, 12 May 2025 03:59:44 -0400
X-MC-Unique: dz_VUxxDMiqP1WAFmLNJiA-1
X-Mimecast-MFC-AGG-ID: dz_VUxxDMiqP1WAFmLNJiA_1747036783
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a0bd786a53so1605288f8f.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 00:59:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747036783; x=1747641583;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QIK8nGQ0MEZFLKvoSSeOKf9NCIFZ/tj6SPwIdGOL6T4=;
 b=fp5cScqtm12KBtPjzS7t62ssTEUb/I4Y9yb+Izi4b9aJMVWedIe/UzyEPX2zTslNbP
 L4L1N1v5xgPTy51Agj3jvczOAnSLQNi2MLaRz8C4OqfUDVQXqrmPLG1XvKcgt89hKmrr
 8DsE1+iRwkWsl5UdktZOsHXBjAoVpR05YOb7GfSpH/3aflFWEvzc0zUqe+TGeeLAKenj
 79HNHcTMCcVre9Oyu9+8DW7uxi4H5e9xWFVcou/uL+hQ7nLmYWv90lE/C/vsn8jf7W2w
 3IHAiTw4Z4WvFpKL1I/KFAgCrfTTXfladIEscIOrusaCi3Q0082MgHSneQYsom0409hA
 14Ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBs6H1N4AtJUoKFVNXbnfyWGD3lGRSCnLvBjoxqmWk6jtVUcfVGHsEaSchvaz2ZPZP1emKhjUh+zOk@nongnu.org
X-Gm-Message-State: AOJu0YxgB2b2X04OCIo536KDXp14ACekBFzKOOmQN1YrjY1gPij+lGPB
 6K+2jk46WnOmkuk32J94NP5QZp9G8/AQsc5v2/KMxQFLjevmGDfffPXaimtk8k+CiuRe+lelmiM
 nyK0lobcbyVFXHECYerlkIcOh1QU7oXF5z3DMEJpYElw7aukJiJgE
X-Gm-Gg: ASbGncsd8qYFyWkNMCyGkTSzMF/ehpQ6fovwjK2Pk4zrpFCeATI4fph+fYp1vVCm24P
 a9qVUviH6oUrmmqpE7gGQBAXyTKwXcKyasGzRLycobsrhH+0RmQsl8WVJ5P0O7r02+zqh57v4RD
 aBvXLlX3XenyUZaDIYgoIIUkyi3ckTFTUBuHKsLMQZ6fkR1uRBUXkCfssbOzpnNCom8TX/U/CnP
 qRPojUVmjfJi1UtvikZSv5XVGuEofaic75rOBQR6OHaeRDXJvDS7dwjbuUG8A/hF2oBf1v5RX0a
 OT47Kk6/qUlYCObYmNIJIFbNdl+LVRxkxILXyMDA8b0VjBGFV0FV
X-Received: by 2002:a05:6000:2ab:b0:3a1:f5c4:b81b with SMTP id
 ffacd0b85a97d-3a1f64376b5mr9799842f8f.23.1747036783366; 
 Mon, 12 May 2025 00:59:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvG7zgv/+4Eotm8qSFV7LCV+SemdE7g0WQYq6ogd4+yfLoLgWGjA24CPx29+jsGoAajphwyg==
X-Received: by 2002:a05:6000:2ab:b0:3a1:f5c4:b81b with SMTP id
 ffacd0b85a97d-3a1f64376b5mr9799824f8f.23.1747036783028; 
 Mon, 12 May 2025 00:59:43 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-115-173.pools.arcor-ip.net.
 [47.64.115.173]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f579aa5bsm11511227f8f.0.2025.05.12.00.59.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 00:59:42 -0700 (PDT)
Message-ID: <80e7eacc-0b71-4e1c-981e-607a4ce8a7bd@redhat.com>
Date: Mon, 12 May 2025 09:59:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Add PCI hotplug test for aarch64
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, alex.bennee@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org
References: <20250509232156.106465-1-gustavo.romero@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
In-Reply-To: <20250509232156.106465-1-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  Hi!

On 10/05/2025 01.19, Gustavo Romero wrote:
> Add a functional test, aarch64_hotplug_pci, to exercise PCI hotplug and
> hot-unplug on arm64. Currently, the aarch64 'virt' machine uses the PCIe
> native controller and does not support ACPI-based hotplugging. However,
> since support is planned, this test sets 'acpi=force' and specifies an
> EDK2 firmware image in advance. This is harmless and prepares for future
> ACPI support.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   tests/functional/meson.build                 |  1 +
>   tests/functional/test_aarch64_hotplug_pci.py | 73 ++++++++++++++++++++
>   2 files changed, 74 insertions(+)
>   create mode 100755 tests/functional/test_aarch64_hotplug_pci.py

Could you also add the test file to one of the sections in the MAINTAINERS 
file, please?

> diff --git a/tests/functional/test_aarch64_hotplug_pci.py b/tests/functional/test_aarch64_hotplug_pci.py
> new file mode 100755
> index 0000000000..031540ba22
> --- /dev/null
> +++ b/tests/functional/test_aarch64_hotplug_pci.py
> @@ -0,0 +1,73 @@
> +#!/usr/bin/env python3
> +#
> +# The test hotplugs a PCI device and checks it on a Linux guest.
> +#
> +# Copyright (c) 2025 Linaro Ltd.
> +#
> +# Author:
> +#  Gustavo Romero <gustavo.romero@linaro.org>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +from os import path
> +from qemu_test import LinuxKernelTest, Asset, exec_command_and_wait_for_pattern
> +from qemu_test import BUILD_DIR
> +
> +class HotplugPCI(LinuxKernelTest):
> +
> +    ASSET_KERNEL = Asset(
> +        ('https://ftp.debian.org/debian/dists/stable/main/installer-arm64/'
> +         'current/images/netboot/debian-installer/arm64/linux'),
> +        '3821d4db56d42c6a4eac62f31846e35465940afd87746b4cfcdf5c9eca3117b2')
> +
> +    ASSET_INITRD = Asset(
> +        ('https://ftp.debian.org/debian/dists/stable/main/installer-arm64/'
> +         'current/images/netboot/debian-installer/arm64/initrd.gz'),
> +        '2583ec22b45265ad69e82f198674f53d4cd85be124fe012eedc2fd91156bc4b4')
> +
> +    def test_hotplug_pci(self):
> +
> +        self.vm.add_args('-m', '512M')
> +        self.vm.add_args('-machine', 'type=virt')

Please use self.set_machine('virt') instead so that the test gets correctly 
skipped in case the machine has not been compiled into the binary.

  Thanks,
   Thomas


