Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8AFBD41D5F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 07:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAl6S-0001bo-ND; Tue, 12 Nov 2024 02:14:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tAl6P-0001aT-GY
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 02:14:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tAl6N-00072Q-DX
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 02:14:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731395653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zb8U/+doWBa05XRot33wTgCEXY9Yz0wFm0qnpMOM0Es=;
 b=E1Bg1aJCGOEgEkpJtGM542nzCSwoPGOFWbrEp2dFoOP70TCL85RPcDwFV151i+uUmDllcF
 sTHPs6mpBwVTJccbNxDMRGwafvQAhF17ZaQwWEd1/HtqY3/qrOXlx3DWaDqFEZVFZJQaja
 acOLsuSjWE8VLeyAEZz5AxMQAI0f3xc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-oHR7oVANNVKbvg-OwlT15w-1; Tue, 12 Nov 2024 02:14:11 -0500
X-MC-Unique: oHR7oVANNVKbvg-OwlT15w-1
X-Mimecast-MFC-AGG-ID: oHR7oVANNVKbvg-OwlT15w
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a9a273e4251so474592666b.1
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 23:14:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731395650; x=1732000450;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zb8U/+doWBa05XRot33wTgCEXY9Yz0wFm0qnpMOM0Es=;
 b=CZ8DZ3beu4HnojxTx9nYgtVuIBM1nW85HEXC8MQQkcQx0dlKh38xiS1sprG10fIe5r
 zScpkRavuB5sPH2E1QAsBHmcsJ1pjORe22/8g7HNSCuLet7Hcf2qB8jihgNW/1L38+5G
 7OPZWn2qqGwfytVAbd71SI4m+TdYWTvYx3CvlhhXxzAx7WFZ+3UNgK9CAKGrw0hJnrb8
 NEllEAHM79VgrAAdlRXsbGpT4GBf2ktI4agIZJ3K6NYoyX1oedVFP1UxsJggQ9I1etGU
 zLuc5crHfF4aOWHyx52qjMfx40TzbVfPnTMdWF/h8i91lG+hQVUvHtuFZltXbaemRqT1
 PEyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbhSVuD8tiOxUwAeVXYIx8CIGUAYFpiX0Ai2u1/pMmVIHCxxrOvEPHddV1rdmLYC9KPexyloxiD0mx@nongnu.org
X-Gm-Message-State: AOJu0YzhicvylVBMt7A3r/yMR7qHCxd3Cy96sM4ouDNuTX6LMpFpTNvI
 bu9Z3Z4KqU+Oc8PzMSKP8fgVOqZHZNnhdT4lh/RT5tKTTnEOGskmIiuNiFWMUSmSYq0hDifJYts
 6+Tg5+8bJDuhZbaafS80Y7yewPz+mZuwGjPE7bK1q8j/3ZggeuRPI
X-Received: by 2002:a17:906:4a18:b0:aa1:e60e:6fe7 with SMTP id
 a640c23a62f3a-aa1e60e774cmr27883966b.11.1731395650167; 
 Mon, 11 Nov 2024 23:14:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6whAhtT4wDL7jro/qdjzRJB1NqHf6T4RAD1u7nvoTObU/F/prx9JSii2SYEz1nhizodrBuw==
X-Received: by 2002:a17:906:4a18:b0:aa1:e60e:6fe7 with SMTP id
 a640c23a62f3a-aa1e60e774cmr27881566b.11.1731395649793; 
 Mon, 11 Nov 2024 23:14:09 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-50-175.web.vodafone.de.
 [109.42.50.175]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0a184f8sm675454766b.15.2024.11.11.23.14.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Nov 2024 23:14:09 -0800 (PST)
Message-ID: <f97df212-9094-4ea4-ab9a-3ca3f88a0c81@redhat.com>
Date: Tue, 12 Nov 2024 08:14:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] tests/functional: Remove sleep workarounds from
 Aspeed tests
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20241112062806.838717-1-clg@redhat.com>
 <20241112062806.838717-5-clg@redhat.com>
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
In-Reply-To: <20241112062806.838717-5-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 12/11/2024 07.28, Cédric Le Goater wrote:
> These were introduced in the avocado tests to workaround read issues
> when interacting with console. They are no longer necessary.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   tests/functional/test_arm_aspeed.py | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/functional/test_arm_aspeed.py b/tests/functional/test_arm_aspeed.py
> index bdd5771a794e..07a8905e2365 100755
> --- a/tests/functional/test_arm_aspeed.py
> +++ b/tests/functional/test_arm_aspeed.py
> @@ -136,10 +136,8 @@ def do_test_arm_aspeed_buildroot_start(self, image, cpu_id, pattern='Aspeed EVB'
>           self.wait_for_console_pattern('lease of 10.0.2.15')
>           # the line before login:
>           self.wait_for_console_pattern(pattern)

Could we please wait for the "login:" string now instead, to make sure that 
there is no race between detecting the previous line and the real login prompt?

> -        time.sleep(0.1)
> -        exec_command(self, 'root')
> -        time.sleep(0.1)
> -        exec_command(self, "passw0rd")
> +        exec_command_and_wait_for_pattern(self, 'root', 'Password:')
> +        exec_command_and_wait_for_pattern(self, 'passw0rd', '#')
>   
>       def do_test_arm_aspeed_buildroot_poweroff(self):
>           exec_command_and_wait_for_pattern(self, 'poweroff',
> @@ -210,7 +208,6 @@ def test_arm_ast2600_evb_buildroot(self):
>                'echo slave-24c02 0x1064 > /sys/bus/i2c/devices/i2c-3/new_device',
>                'i2c i2c-3: new_device: Instantiated device slave-24c02 at 0x64');
>           exec_command(self, 'i2cset -y 3 0x42 0x64 0x00 0xaa i');

Could please you change the above line to wait for the shell prompt pattern now?

  Thanks,
   Thomas

> -        time.sleep(0.1)
>           exec_command_and_wait_for_pattern(self,
>                'hexdump /sys/bus/i2c/devices/3-1064/slave-eeprom',
>                '0000000 ffaa ffff ffff ffff ffff ffff ffff ffff');


