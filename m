Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37C9C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Wb7-0003pu-7u; Wed, 23 Apr 2025 05:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7Wap-0003ne-Ri
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:40:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7Wan-0008Fd-BU
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745401232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BOtn9ma/XBXc5SypNaNRmyrr3Ioj5GUU7hRkEj2fBaA=;
 b=E9FldyZjlz1Au9OcxR3sYvFdCW40ogJD7NdlWDk7XQKJiPKsePoM4wPaseeoDqCDg1/AEE
 Nd8JD9MBNw2YSr6jvXsStsp3ir6Y/ymFgtMxwnjM8MHB+KJXQmloSyYlI9Xj1hRGh0EnKT
 EnwTuhRteXIsYYFhrBRZqk0znnoi6aU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-ZuELJfAoM5aUtAIuQTRkZw-1; Wed, 23 Apr 2025 05:40:29 -0400
X-MC-Unique: ZuELJfAoM5aUtAIuQTRkZw-1
X-Mimecast-MFC-AGG-ID: ZuELJfAoM5aUtAIuQTRkZw_1745401228
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-39141ffa913so3021919f8f.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745401228; x=1746006028;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BOtn9ma/XBXc5SypNaNRmyrr3Ioj5GUU7hRkEj2fBaA=;
 b=GqdHdMp86xZvtCj0cuNt0G7EYR2hoDIAwErPx2bk3GyeiaiMFzGsyM1RkZBDKVSSX0
 xbPgFV2bqHwGsip3gePIl17qemFPpOfh/RTlcdTmmbI7GmQFjiTES71gBwKF48Y2JkNo
 fNgX5V0gXOJ92XSzRz3Qtonolj5xKdOWXk2o4OnOm68CWOF8IcnW93o2Lcx4abrYq/xd
 UzRZOvqZId+1Zu8+ZU19txD3UL1ElPRJudTQAiZzP0/KQceBfH44qEGSBt/ZCcsFK03Y
 4guICngS8ew1JLhtCZZnLss3HU6F7W5ItgOu1b1gBddtY4GztCoQ9IASxJRUAg7OTG6G
 kEBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6vG25oGmxx1x5ZewrygJ1rhyi3CO94BPl1zat5O203B6dCdGMywLDvzHUVJB/6y4+OAJyEkbv7RFO@nongnu.org
X-Gm-Message-State: AOJu0YyuyvNhd2DdyALwQKDWWYhjUpAJFst7INJ1tQr+P/cMOPCczSim
 g3Vd77NZM1eHAwYXg1zz/0gANguv/oEDZsesBkEP6pOPrrpf876BnVVhBQSsdbxk1c6zwIYfOim
 M+3/G1v5ynT+T5aZmNbLJJtZcmtx8QJxkuFlM9A8gmx6pl2R+vVhz
X-Gm-Gg: ASbGnctt0hSxuCS6d77uJPmEzQlYkVP7TmLfpMslanswes/YpCesNoSfkbgCWCYN1IG
 UnzndPFJHj3g62d3mTmQZ/lqep57/MTZmGxpMr2wUUMZ1tJRbk3ojgBGRBKvYASSipNTsDdSvQ0
 SdYjrMxBXouah0u1TEGqKHCsV2VMs3XjhIWv7ONG21Qvf03Ak7dPs4/Io6bvh99WaVg5V/kBIzu
 fflEW0GQ2iiVLaeDtDc8jL9VTAhZKz3FmpeBqMsztnI4f0M3FBDGY9SZ6MB3TRzMgjC3kSEfGm8
 gNpq73JuormDzuFnDE+7+7UwdaqwuLWeVOZ9
X-Received: by 2002:a05:6000:4201:b0:391:456b:6ab7 with SMTP id
 ffacd0b85a97d-39efba5db9bmr14159859f8f.34.1745401227793; 
 Wed, 23 Apr 2025 02:40:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHn+xJxdfHVuNs7SaAKdu3POi5RM8jrszfg3tD+Hw6sXbznCfuzSqLHnApPkQQgLN8c/VZDg==
X-Received: by 2002:a05:6000:4201:b0:391:456b:6ab7 with SMTP id
 ffacd0b85a97d-39efba5db9bmr14159839f8f.34.1745401227401; 
 Wed, 23 Apr 2025 02:40:27 -0700 (PDT)
Received: from [10.33.192.219] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4a498csm17901051f8f.85.2025.04.23.02.40.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 02:40:27 -0700 (PDT)
Message-ID: <2c725cbc-6ba0-4e07-8863-acacbb45e121@redhat.com>
Date: Wed, 23 Apr 2025 11:40:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0? v2] tests/functional: Add test for imx8mp-evk
 board with USDHC coverage
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org
References: <20250409202630.19667-1-shentey@gmail.com>
 <aa47d49a-b81a-46cf-811a-2045e453f4bf@redhat.com>
 <6621A6A6-83F8-476C-973C-FE3D1918E061@gmail.com>
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
In-Reply-To: <6621A6A6-83F8-476C-973C-FE3D1918E061@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
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

On 23/04/2025 11.31, Bernhard Beschow wrote:
> 
> 
> Am 10. April 2025 06:05:35 UTC schrieb Thomas Huth <thuth@redhat.com>:
>> On 09/04/2025 22.26, Bernhard Beschow wrote:
>>> Introduce a functional test which boots Debian 12 on the imx8mp-evk board. Since
>>> the root filesystem resides on an SD card, the test also verifies the basic
>>> operation of the USDHC.
>>>
>>> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
>>>
>>> --
>>> v2:
>>> * Make test file executable (Thomas)
>>> * Omit fetch() (Thomas)
>>> * Omit "-accel tcg" (Thomas)
>>> * Add "snapshot=on" to make potential future tests independent
>>>
>>> Supersedes: 20250405214900.7114-1-shentey@gmail.com
>>> ---
>>>    MAINTAINERS                                 |  1 +
>>>    tests/functional/meson.build                |  1 +
>>>    tests/functional/test_aarch64_imx8mp_evk.py | 66 +++++++++++++++++++++
>>>    3 files changed, 68 insertions(+)
>>>    create mode 100755 tests/functional/test_aarch64_imx8mp_evk.py
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index d54b5578f8..4ceffa89dc 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -833,6 +833,7 @@ F: include/hw/arm/fsl-imx8mp.h
>>>    F: include/hw/misc/imx8mp_*.h
>>>    F: include/hw/pci-host/fsl_imx8m_phy.h
>>>    F: docs/system/arm/imx8mp-evk.rst
>>> +F: tests/functional/test_aarch64_imx8mp_evk.py
>>>    F: tests/qtest/rs5c372-test.c
>>>      MPS2 / MPS3
>>> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
>>> index 0f8be30fe2..aaaf3472f1 100644
>>> --- a/tests/functional/meson.build
>>> +++ b/tests/functional/meson.build
>>> @@ -75,6 +75,7 @@ tests_aarch64_system_quick = [
>>>      tests_aarch64_system_thorough = [
>>>      'aarch64_aspeed',
>>> +  'aarch64_imx8mp_evk',
>>>      'aarch64_raspi3',
>>>      'aarch64_raspi4',
>>>      'aarch64_replay',
>>> diff --git a/tests/functional/test_aarch64_imx8mp_evk.py b/tests/functional/test_aarch64_imx8mp_evk.py
>>> new file mode 100755
>>> index 0000000000..62fee74044
>>> --- /dev/null
>>> +++ b/tests/functional/test_aarch64_imx8mp_evk.py
>>> @@ -0,0 +1,66 @@
>>> +#!/usr/bin/env python3
>>> +#
>>> +# Functional test that boots a Linux kernel and checks the console
>>> +#
>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>> +
>>> +from qemu_test import LinuxKernelTest, Asset
>>> +
>>
>> In case you respin (due to other reasons), please add a second empty line before the "class" statement (that's the style that we use in the other tests, too).
>>
>> Anyway:
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> Ping (not for 10.0)

Peter, should this go through your arm tree, or shall I pick it up with 
other functional test patches for my next PR?

  Thomas


