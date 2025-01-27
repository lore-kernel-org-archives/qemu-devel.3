Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF44C0218C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 06:34:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcIh0-0002gR-Cd; Mon, 27 Jan 2025 01:33:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tcIgy-0002fu-49
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 01:33:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tcIgv-0004Ue-TM
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 01:33:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737959628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pXn9VZ9E0zTaknGuPvVcaJ6MFsVueGXrRF+RkjaXQNg=;
 b=XwHDP/eBGXp0ZN9r/7yGTGAtTgITuhS24zwHc85B6IZZuUXKXAU/0Ks9JBtGgiCfS9Uq+m
 VNEwXAlPBm/vII88GMvEvqdft+q6ftnmZmDGLNo+vLbvfpnjyfXpc3F0nYKyICEaxF9C4a
 qN1/AuprL2fzc1Dbk8o+jLvFvQrxJ8o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-Ythn70LTPq6I6ipPc-VNuA-1; Mon, 27 Jan 2025 01:33:46 -0500
X-MC-Unique: Ythn70LTPq6I6ipPc-VNuA-1
X-Mimecast-MFC-AGG-ID: Ythn70LTPq6I6ipPc-VNuA
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-385fdff9db5so1299505f8f.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 22:33:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737959625; x=1738564425;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pXn9VZ9E0zTaknGuPvVcaJ6MFsVueGXrRF+RkjaXQNg=;
 b=uKW8k4Id9HP6+Uy6ziFB4fbm2+moFsObJE8iyUiWh7JFqHbYBIOXOdFsFmyhyQUrjl
 ygBhgN6vOfBSiDRXT7QMGJNiTjzJuBU42zGzgBv4FChrrKVuLfdHkDTqTV/7PmNQQ0kO
 ROPIYOejxKmBQY7H/P1/ERcg3aSjH6VsEt14a292aE5BitJJ08KmoUKnFtIqCPNyAyPA
 BKII7gXNjVVGIw/OLKCsh0CQQSb941sFyjzZWETLUXcKuHNBqbR82sUdn+9DQ2Rl2p8J
 BrSEjE/Eo4zqgb397ZwDD1gtFHU/wMGIJTm4NEq9HH62DztcmNWvb73VaGmN0voDgDhu
 NFDQ==
X-Gm-Message-State: AOJu0Yz/hgjZoU/qpwKV0EeLsl3ZDzF3BC5wvv1zE/dO3Q9JIlvbBWhU
 frRwCoyYXHgXJi26XtXx5srABgi3O4KNYkeYtC4o/NP+MhUxsCtP0Yh6BFxDIh2LsbN/TiE0XQG
 4Dv+3PEMVDlWl63Uj9sRZ4JcgeCg0OpnDWTY8/ZKjLq68GUxG+m39oP56kXpo
X-Gm-Gg: ASbGnctKhI+g4x3K3nvLg8X0uIb7PnZLMGdEKlCStbW6V8WFYqpYoEoA20DYs4h8owB
 HCb34/JUDXA71FjtzGfcbvGYEQbv8LoxxVv8YweCkBfbGgYO4CFluLyfNv5ANdGhcawEOW+zIUg
 RuJ+G10SipXH1BhoG6NRk8UgNuZi4e2FP/I/L/r1YISpkTBi0NfstHF+pJFMe388J0PvHhY3ryy
 6fNDNGdBnf9xumkXS5YM6BGN34kBVeo/AQVGuT3FHCRiXzsPi2FK++W55lsasOPAtQ2Fq89B7IS
 1cmV/aYyGwqZKCurdvzqvtsB/BlagqyTCbmy
X-Received: by 2002:a5d:64a1:0:b0:38a:39ad:3e2f with SMTP id
 ffacd0b85a97d-38bf565573dmr33514025f8f.2.1737959625151; 
 Sun, 26 Jan 2025 22:33:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNjiQKQu8qRl9fC+PeL8PoWspejKT+6kmIi857PM6dedK2OVf7Z6bj/zupB/W6NaLmPdr2hw==
X-Received: by 2002:a5d:64a1:0:b0:38a:39ad:3e2f with SMTP id
 ffacd0b85a97d-38bf565573dmr33514000f8f.2.1737959624711; 
 Sun, 26 Jan 2025 22:33:44 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-134.web.vodafone.de.
 [109.42.48.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a17d7bfsm10147190f8f.35.2025.01.26.22.33.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 22:33:44 -0800 (PST)
Message-ID: <88b154a1-452e-4f5c-a6f0-9b0f148f6b80@redhat.com>
Date: Mon, 27 Jan 2025 07:33:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Add a test for the arm microbit machine
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Joel Stanley
 <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>
References: <20250124101709.1591761-1-thuth@redhat.com>
 <8734h8joui.fsf@draig.linaro.org>
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
In-Reply-To: <8734h8joui.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.299,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 24/01/2025 14.58, Alex Bennée wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> We don't have any functional tests for this machine yet, thus let's
>> add a test with a MicroPython binary that is available online
> 
> We do have a basic system test:
> 
>    test-armv6m-undef: test-armv6m-undef.S
>            $(CC) -mcpu=cortex-m0 -mfloat-abi=soft \
>                    -Wl,--build-id=none -x assembler-with-cpp \
>                    $< -o $@ -nostdlib -static \
>                    -T $(ARM_SRC)/$@.ld
> 
>    run-test-armv6m-undef: QEMU_OPTS=-semihosting-config enable=on,target=native,chardev=output -M microbit -kernel
> 
>    ARM_TESTS+=test-armv6m-undef
> 
> But I guess this exercised more of the machine as micropython actually
> comes up.
> 
>> (thanks to Joel Stanley for providing it, see:
>>   https://www.mail-archive.com/qemu-devel@nongnu.org/msg606064.html ).
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   MAINTAINERS                           |  1 +
>>   tests/functional/meson.build          |  1 +
>>   tests/functional/test_arm_microbit.py | 31 +++++++++++++++++++++++++++
>>   3 files changed, 33 insertions(+)
>>   create mode 100755 tests/functional/test_arm_microbit.py
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 1d9b3a0011..7b4d84bf5f 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1157,6 +1157,7 @@ F: hw/*/microbit*.c
>>   F: include/hw/*/nrf51*.h
>>   F: include/hw/*/microbit*.h
>>   F: tests/qtest/microbit-test.c
>> +F: tests/functional/test_arm_microbit.py
>>   F: docs/system/arm/nrf.rst
>>   
>>   ARM PL011 Rust device
>> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
>> index bcfbb70b65..a301c38806 100644
>> --- a/tests/functional/meson.build
>> +++ b/tests/functional/meson.build
>> @@ -105,6 +105,7 @@ tests_arm_system_thorough = [
>>     'arm_cubieboard',
>>     'arm_emcraft_sf2',
>>     'arm_integratorcp',
>> +  'arm_microbit',
>>     'arm_orangepi',
>>     'arm_quanta_gsj',
>>     'arm_raspi2',
>> diff --git a/tests/functional/test_arm_microbit.py b/tests/functional/test_arm_microbit.py
>> new file mode 100755
>> index 0000000000..68ea4e73d6
>> --- /dev/null
>> +++ b/tests/functional/test_arm_microbit.py
>> @@ -0,0 +1,31 @@
>> +#!/usr/bin/env python3
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +#
>> +# Copyright 2025, The QEMU Project Developers.
>> +#
>> +# A functional test that runs MicroPython on the arm microbit machine.
>> +
>> +from qemu_test import QemuSystemTest, Asset, exec_command_and_wait_for_pattern
>> +from qemu_test import wait_for_console_pattern
>> +
>> +
>> +class MicrobitMachine(QemuSystemTest):
>> +
>> +    ASSET_MICRO = Asset('https://ozlabs.org/~joel/microbit-micropython.hex',
>> +        '021641f93dfb11767d4978dbb3ca7f475d1b13c69e7f4aec3382f212636bffd6')
>> +
>> +    def test_arm_microbit(self):
>> +        self.set_machine('microbit')
>> +
>> +        micropython = self.ASSET_MICRO.fetch()
>> +        self.vm.set_console()
>> +        self.vm.add_args('-device', f'loader,file={micropython}')
>> +        self.vm.launch()
>> +        wait_for_console_pattern(self, 'Type "help()" for more information.')
>> +        exec_command_and_wait_for_pattern(self, 'import machine as mch', '>>>')
>> +        exec_command_and_wait_for_pattern(self, 'mch.reset()', 'MicroPython')
>> +        wait_for_console_pattern(self, '>>>')
> 
> We could do more if we wanted - all the microbit specific stuff lives in
> the microbit module:
> 
>    https://microbit-micropython.readthedocs.io/en/latest/microbit_micropython_api.html

Is there anything that can be done beside just "run a python command and see 
that it did not crash"? E.g. is it possible to set a different temperature 
via QOM/QAPI or simulate button presses?

> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

Thanks!

   Thomas


