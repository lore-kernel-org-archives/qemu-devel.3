Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B9E7C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 08:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4d5D-0002EU-HH; Wed, 08 May 2024 04:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s4d5B-0002E4-3n
 for qemu-devel@nongnu.org; Wed, 08 May 2024 04:55:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s4d59-0008QK-GY
 for qemu-devel@nongnu.org; Wed, 08 May 2024 04:55:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715158522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MAKwlXvIHuN+OOP29I+4SLRjiVmJLbbr5KJxhsjpM7w=;
 b=FfRxtClqSb8FVyWA2zNvHyq8Ov9i01W/K8yskwlhQxYh/j8/W0PsFAIx/xHtEGrtYrmeMs
 0E6rfFqjIaSnxwtA6XZ/mj6odBXjtDbpHXmo8hbJX5zeRc7yCx4ShjP3V0vgWQWSnZhzT3
 BeA+NZYznaPkBorVM/C5nkpSfxP0azA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-0bmn1-CzMvCldeqH7NoIzA-1; Wed, 08 May 2024 04:55:21 -0400
X-MC-Unique: 0bmn1-CzMvCldeqH7NoIzA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-41c01902e60so20857315e9.3
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 01:55:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715158520; x=1715763320;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MAKwlXvIHuN+OOP29I+4SLRjiVmJLbbr5KJxhsjpM7w=;
 b=Uxb6S/AlvmhAg/JKcD1e6YLMqZBfJugh1YwTgGdBm41yg86LYGNCGuvloqooxOEoZ2
 ZMCuE/bWNaffSi8ThV9q0kU3Q5n7rr6G17z3HYlzrDP3QsJ5h7kMVAfCEhES8nG8qP+O
 XqL2gLG2yU7SuegpUrnQPzWK4ILZQdzGMXpQKD+LrBNKIlJ6lHeRwMAVwibeUccaye/e
 cMdGeSD4jC7gOJZhBd3KR+Jzj4okMZmg/sL5Dovum2GLCOMTJk/9wBSOP3r3J/SfAPRk
 7XDxklvYNo2zceDkvh8nm9HTFc1RnXy7cs6I08ePH/d3XGZa4vtUePy6SIfej8sfS513
 +k7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBnDVIQIhboOypeTfUt2s77g2A8ywCb9N5dDxbYiO6h0kUPc/eMm61BVnW12WqzoZ0SFRpe3zNUnjaJwVM/yLAwpw7Q4g=
X-Gm-Message-State: AOJu0Yw2qCkiXdc83WdherR6BOyXWjlYtuLS+4WGnRyavO1DM81CN2cL
 UdFUb3kKCsFQS5XDqKXauk2oeFiIII2BnFTptqxUah06lDa8d7bb3sLWrEf71AS1/ERyvtJNXUV
 HK3xp/bDbHnMZ/d757+PfRfowCKCAT9rvyh49gq08C/ogwb6vZ99q
X-Received: by 2002:a05:600c:4e51:b0:41c:15d:98ac with SMTP id
 5b1f17b1804b1-41f71cc26cbmr16143795e9.11.1715158520407; 
 Wed, 08 May 2024 01:55:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBPKdiW1nuR0XRGRF0enEzdzWpCZSvEBii+vDvWFoPsEG4JAeJspO/AcDymcNv+5AfosvrdQ==
X-Received: by 2002:a05:600c:4e51:b0:41c:15d:98ac with SMTP id
 5b1f17b1804b1-41f71cc26cbmr16143665e9.11.1715158520039; 
 Wed, 08 May 2024 01:55:20 -0700 (PDT)
Received: from [10.33.192.191] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 t12-20020a05600c450c00b0041bd920d41csm1550213wmo.1.2024.05.08.01.55.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 01:55:19 -0700 (PDT)
Message-ID: <43926368-567e-4392-a2c6-de277016c0c4@redhat.com>
Date: Wed, 8 May 2024 10:55:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-9.1 3/4] hw/i2c: Convert to spec v7 terminology
 (automatically)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Corey Minyard <cminyard@mvista.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20240408213339.83149-1-philmd@linaro.org>
 <20240408213339.83149-4-philmd@linaro.org>
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
In-Reply-To: <20240408213339.83149-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 08/04/2024 23.33, Philippe Mathieu-Daudé wrote:
> One of the biggest change from I2C spec v6 -> v7 is:
> 
>    • Updated the terms "master/slave" to "controller/target"
> 
> Since it follows the inclusive terminology from the "Conscious
> Language in your Open Source Projects" guidelines [*], replace
> the I2C terminology.
> 
> Mechanical transformation running:
> 
>    $ cat i2c_rename.txt | while read old new; do \
>        sed -i -e "s/$old/$new/g" $(git grep -l $old); \
>      done
> 
> Having:
> 
>    $ cat i2c_rename.txt
>    i2c_bus_master i2c_bus_controller
>    i2c_schedule_pending_master i2c_schedule_pending_controller
>    I2CPendingMasters I2CPendingControllers
>    I2CPendingMaster I2CPendingController
>    pending_masters pending_controllers
>    I2C_SLAVE_CLASS I2C_TARGET_CLASS
>    I2C_SLAVE_GET_CLASS I2C_TARGET_GET_CLASS
>    I2CSlaveClass I2CTargetClass
>    I2CSlave I2CTarget
>    TYPE_I2C_SLAVE TYPE_I2C_TARGET
>    I2C_SLAVE I2C_TARGET
>    i2c_slave_new i2c_target_new
>    i2c_slave_create_simple i2c_target_create_simple
>    i2c_slave_realize_and_unref i2c_target_realize_and_unref
>    i2c_slave_set_address i2c_target_set_address
>    VMSTATE_I2C_SLAVE VMSTATE_I2C_TARGET
>    vmstate_i2c_slave vmstate_i2c_target
> 
> Note, the QOM type definition is not modified, TYPE_I2C_TARGET
> remains defined as "i2c-slave".
> 
> [*] https://github.com/conscious-lang/conscious-lang-docs/blob/main/faq.md
> 
> Inspired-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
...
> @@ -649,29 +649,29 @@ static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
>           qdev_connect_gpio_out(dev, pca1_leds[i].gpio_id,
>                                 qdev_get_gpio_in(DEVICE(led), 0));
>       }
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3),
>                              "dps310", 0x76);

So the location of the opening parenthesis changes in a lot of lines in your 
patch, but you don't adapt the following line accordingly, so the 
indentation is off now. ==> One more reason for not breaking the long lines 
in your previous patch.

  Thomas


