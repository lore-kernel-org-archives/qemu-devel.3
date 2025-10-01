Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5956ECCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 11:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3uoY-00060y-HO; Wed, 01 Oct 2025 07:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v3uoW-00060T-GL
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 07:16:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v3uoM-0002MP-2y
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 07:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759317345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nOgdg8hLR/cTl3KVbl+C7is6KgQuw6Lvi+czpi4df8I=;
 b=B3ZEzvzA2nj5Iu98Cl4QwEpluj4vGjVutKC2+5cQCSfZnA0kVeacWdwR+fndSkcIK7ukLc
 xUCuv/kymQVZ8MC28q0UXzkAidyhwKnGxcEazBrxNh/z8IseglM8sGDrYPboT3PONS/meb
 +3wI8R3+MI/tDZWSuDPFy3Z2MM51U+I=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-Ht_u0hxHMVeUImTrHmLYCQ-1; Wed, 01 Oct 2025 07:15:44 -0400
X-MC-Unique: Ht_u0hxHMVeUImTrHmLYCQ-1
X-Mimecast-MFC-AGG-ID: Ht_u0hxHMVeUImTrHmLYCQ_1759317343
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b3cbee9769fso452678666b.3
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 04:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759317343; x=1759922143;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nOgdg8hLR/cTl3KVbl+C7is6KgQuw6Lvi+czpi4df8I=;
 b=m8Wah4P9j6OxmFUY2v//+gNF0y6rGKteFo7nXGqdF3oPMFvDCAHyzPHTyxJNkLMsAX
 BPRjLV0Ez8Jt3VJsBSU8tPMyCClOoP+Q77x+DyK+kC+T5EvB4jfqLRYY33mIr+UsJcwB
 Z5KAk+z3Bhf2LVPYd7nSy2VOetIbISaS2Ir/6vdMws+8Hdk36lt3VhXS0g7drUjFXcAj
 n5r+DiUrDzvkSnConqz43T9P98dsAch485oegw12VFIrE8ik3IAybrv9SOixq+eS86aS
 tkxyiqs+kKTWPVZ6zQdeq/FR7nL9qcnSi3GL5GsoTl6XuccUputj3pi1HH7Wx9aPdG4r
 Wfwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVpHaXDmoHnHw9kYLnHK4KJfIhufx0yen+LUAu6qjrEeZfF2nxt/25sMPpDeV1j+CfCsxRWSipUHmf@nongnu.org
X-Gm-Message-State: AOJu0Yy7lWxDutFiJV0BPNYRgDDt3Y9lnVnswmpJGosi5gRl26Rv+WkY
 SosTJ24kyHt4XK5Bh1HaRlZe8nQ2NVOkBJgyGun83chlQB59UfLZmA6+u7ZObRWrwY0y8DKJ973
 /wfUKQpRiNcuXYPX4kdqlm5GHK8LWXBdyhd4ER8YWJmMpps0RoTOmgl04
X-Gm-Gg: ASbGncvhqxj9jH3tPzdionFhpN+rb+kND6rCsj2dTZo2D+xVDA9dvkTV6rF5dfJWxCW
 j81KPyTQXil06xGIi5HJsVAx8ZgpbXh4vOuH+TBSVBJ5qOpev4DeMR3xlyEtM70kn0xAIFcYwg+
 Asbwd5tMLC/Wu+mYKVZfLVpKC+xUQQ1cgthel6cbQYMHGlAwUU6o8fAO2XyywVdfdhOedCuv+RW
 xlJ/uAXXwh+3ja+M7g8lIYIVz1DrkdjHwL6We1lyKsRN+KnZKhRHfAGeFsN7D/n6o2yn/3aWgD5
 sTmCAqc2MqSQuxBS6QMFkYr/J/1uhKyd6I72JzxPTWL3wIYK0zVDX9RofyO0FLnKrJKXrIp9Csz
 1u/AshxtJJw==
X-Received: by 2002:a17:907:9709:b0:b46:31be:e8fe with SMTP id
 a640c23a62f3a-b46e4d7d64fmr406245366b.11.1759317342709; 
 Wed, 01 Oct 2025 04:15:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9PBa0FSy+Kj46i/XWcQYNQxl/TVTHOYnMbiQPmH1YC0f4fNSP+xzUAJ+/gALl2IaXziNnkQ==
X-Received: by 2002:a17:907:9709:b0:b46:31be:e8fe with SMTP id
 a640c23a62f3a-b46e4d7d64fmr406241766b.11.1759317342269; 
 Wed, 01 Oct 2025 04:15:42 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-056.pools.arcor-ip.net.
 [47.64.114.56]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b3d62a59fcesm719083866b.91.2025.10.01.04.15.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 04:15:41 -0700 (PDT)
Message-ID: <7e924450-1d8e-4fff-8b16-f164b050d721@redhat.com>
Date: Wed, 1 Oct 2025 13:15:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 13/13] test/functional: Add test for boston-aia board
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "alistair23@gmail.com" <alistair23@gmail.com>
References: <20251001094859.2030290-1-djordje.todorovic@htecgroup.com>
 <20251001094859.2030290-14-djordje.todorovic@htecgroup.com>
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
In-Reply-To: <20251001094859.2030290-14-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 01/10/2025 11.49, Djordje Todorovic wrote:
> Add functional test for Boston AIA board. The P8700 RISC-V based
> CPU by MIPS supports it at the moment.
> 
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> ---
>   tests/functional/riscv64/meson.build          |   1 +
>   .../functional/riscv64/test_riscv64_boston.py | 164 ++++++++++++++++++
>   2 files changed, 165 insertions(+)
>   create mode 100755 tests/functional/riscv64/test_riscv64_boston.py
> 
> diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv64/meson.build
> index c1704d9275..9bce341b80 100644
> --- a/tests/functional/riscv64/meson.build
> +++ b/tests/functional/riscv64/meson.build
> @@ -7,6 +7,7 @@ test_riscv64_timeouts = {
>   tests_riscv64_system_quick = [
>     'migration',
>     'opensbi',
> +  'riscv64_boston',
>   ]
>   
>   tests_riscv64_system_thorough = [
> diff --git a/tests/functional/riscv64/test_riscv64_boston.py b/tests/functional/riscv64/test_riscv64_boston.py
> new file mode 100755
> index 0000000000..0527571847
> --- /dev/null
> +++ b/tests/functional/riscv64/test_riscv64_boston.py
> @@ -0,0 +1,164 @@
> +#!/usr/bin/env python3
> +#
> +# Boston board test for RISC-V P8700 processor by MIPS
> +#
> +# Copyright (c) 2025 MIPS
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +
> +import os
> +from qemu_test import QemuSystemTest, Asset
> +from qemu_test import wait_for_console_pattern
> +

Cosmetic nit: Most tests use two empty lines between the imports and the 
class ... might be nicer to use it here, too.

> +class RiscvBostonTest(QemuSystemTest):
> +    """
> +    Test the boston-aia board with P8700 processor
> +    """
> +
> +    timeout = 120  # Timeout for boot tests

Please remove the timeout line here, it's of no use in the functional tests 
anymore (yeah, I know, we also have to remove this from a bunch of other 
files...).

If you need a timeout > 90s for the total test time, please specify it in 
the meson.build file instead.

> +    ASSET_FW_PAYLOAD = Asset(
> +        'https://github.com/MIPS/linux-test-downloads/raw/main/p8700/fw_payload.bin',
> +        'd6f4ae14d0c178c1d0bb38ddf64557536ca8602a588b220729a8aa17caa383aa')
> +
> +    ASSET_ROOTFS = Asset(
> +        'https://github.com/MIPS/linux-test-downloads/raw/main/p8700/rootfs.ext2',
> +        'f937e21b588f0d1d17d10a063053979686897bbbbc5e9617a5582f7c1f48e565')
> +
> +    def _fetch_rootfs(self):
> +        """Fetch rootfs and fix permissions"""
> +        rootfs_path = self.ASSET_ROOTFS.fetch()
> +        # Ensure the rootfs file is readable
> +        try:
> +            os.chmod(rootfs_path, 0o644)
> +        except:
> +            pass  # If we can't change permissions, try anyway

Please don't make the files in the cache writable, otherwise the hashsum of 
the file might get changed and then you have to re-download.

The correct way to allow the guest to write to the disk (and throw away the 
changes afterwards), is to use ",snapshot=on" in your -drive statement below.

> +        return rootfs_path
> +
> +    def test_boston_boot_linux(self):
> +        """
> +        Test full Linux kernel boot with rootfs on Boston board
> +        """
> +        self.set_machine('boston-aia')
> +        fw_payload_path = self.ASSET_FW_PAYLOAD.fetch()
> +        rootfs_path = self._fetch_rootfs()
> +
> +        self.vm.add_args('-cpu', 'mips-p8700')
> +        self.vm.add_args('-m', '2G')
> +        self.vm.add_args('-smp', '2')
> +        self.vm.add_args('-kernel', fw_payload_path)
> +        self.vm.add_args('-drive', f'file={rootfs_path},format=raw')
> +
> +        self.vm.set_console()
> +        self.vm.launch()
> +
> +        # Wait for OpenSBI
> +        wait_for_console_pattern(self, 'OpenSBI')
> +
> +        # Wait for Linux kernel boot
> +        wait_for_console_pattern(self, 'Linux version')
> +        wait_for_console_pattern(self, 'Machine model: MIPS P8700')
> +
> +        # Test e1000e network card functionality
> +        wait_for_console_pattern(self, 'e1000e')
> +        wait_for_console_pattern(self, 'Network Connection')
> +
> +        # Wait for boot to complete - system reaches login prompt
> +        wait_for_console_pattern(self, 'Run /sbin/init as init process')
> +
> +    def test_boston_7_vps_boot_linux(self):
> +        """
> +        Test full Linux kernel boot with rootfs on Boston board
> +        """
> +        self.set_machine('boston-aia')
> +        fw_payload_path = self.ASSET_FW_PAYLOAD.fetch()
> +        rootfs_path = self._fetch_rootfs()
> +
> +        self.vm.add_args('-cpu', 'mips-p8700')
> +        self.vm.add_args('-m', '2G')
> +        self.vm.add_args('-smp', '7')
> +        self.vm.add_args('-kernel', fw_payload_path)
> +        self.vm.add_args('-drive', f'file={rootfs_path},format=raw')
> +
> +        self.vm.set_console()
> +        self.vm.launch()
> +
> +        # Wait for OpenSBI
> +        wait_for_console_pattern(self, 'OpenSBI')
> +
> +        # Wait for Linux kernel boot
> +        wait_for_console_pattern(self, 'Linux version')
> +        wait_for_console_pattern(self, 'Machine model: MIPS P8700')
> +
> +        # Test e1000e network card functionality
> +        wait_for_console_pattern(self, 'e1000e')
> +        wait_for_console_pattern(self, 'Network Connection')
> +
> +        # Wait for boot to complete - system reaches login prompt
> +        wait_for_console_pattern(self, 'Run /sbin/init as init process')
> +
> +    def test_boston_35_vps_boot_linux(self):
> +        """
> +        Test full Linux kernel boot with rootfs on Boston board
> +        """
> +        self.set_machine('boston-aia')
> +        fw_payload_path = self.ASSET_FW_PAYLOAD.fetch()
> +        rootfs_path = self._fetch_rootfs()
> +
> +        self.vm.add_args('-cpu', 'mips-p8700')
> +        self.vm.add_args('-m', '2G')
> +        self.vm.add_args('-smp', '35')
> +        self.vm.add_args('-kernel', fw_payload_path)
> +        self.vm.add_args('-drive', f'file={rootfs_path},format=raw')
> +
> +        self.vm.set_console()
> +        self.vm.launch()
> +
> +        # Wait for OpenSBI
> +        wait_for_console_pattern(self, 'OpenSBI')
> +
> +        # Wait for Linux kernel boot
> +        wait_for_console_pattern(self, 'Linux version')
> +        wait_for_console_pattern(self, 'Machine model: MIPS P8700')
> +
> +        # Test e1000e network card functionality
> +        wait_for_console_pattern(self, 'e1000e')
> +        wait_for_console_pattern(self, 'Network Connection')
> +
> +        # Wait for boot to complete - system reaches login prompt
> +        wait_for_console_pattern(self, 'Run /sbin/init as init process')

Do you really need to repeat the same test three times, just with different 
amount of CPUs? Once with the smallest possible amount and once with the 
biggest possible amount should be sufficient, shouldn't it? (Otherwise 
please state in the comments at the beginning of the function why certain 
amounts of CPUs are special and should be tested separately).

Please also consider to merge the parts that are common between the tests 
into a shared setup function.

  Thanks,
   Thomas


