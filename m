Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD83BC3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 10:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCy8Q-0003FN-39; Thu, 08 May 2025 06:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uCy8K-0003Eg-Ll
 for qemu-devel@nongnu.org; Thu, 08 May 2025 06:05:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uCy8J-0002QK-1Z
 for qemu-devel@nongnu.org; Thu, 08 May 2025 06:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746698737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=459LRQzDzGtzWKHBHBtR/OkCiGru/x7x6Y/1oZeNsOU=;
 b=iOfjAN/8+4yqxkltdN1UNJhh1bEQ7+zHEp3yb2wtjjEDHWbyQa/8Rn8JunGrN7gMYO8TwD
 HaV/RQDEJEbnyG/Zox1kY0f+T2rEJmtcFhNbQag8agk9/fBqpPppok+/ZLtLSsrAU85Tm3
 Td1I5UjYnXBMc0u+1estmOjrieEkKr4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-2xJ_-m1GMCyPoAivjuFOJw-1; Thu, 08 May 2025 06:05:36 -0400
X-MC-Unique: 2xJ_-m1GMCyPoAivjuFOJw-1
X-Mimecast-MFC-AGG-ID: 2xJ_-m1GMCyPoAivjuFOJw_1746698735
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-39d9243b1c2so314474f8f.2
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 03:05:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746698735; x=1747303535;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=459LRQzDzGtzWKHBHBtR/OkCiGru/x7x6Y/1oZeNsOU=;
 b=sXXsLqKDmyHc9WyTrc3MVzgxkMsx68KUzMIiksSAwlBQCLZ2vybNzQ1bhy+CaprLuw
 73vSa8B2t2Sxk6V8Lpd6vXVtn6biZQaRxfCNcND3Dn08qgpWN22mdNJgsobOFldeY7Iq
 XRMG/L/5PyKHBBn8whTWt8UfDuBKmY4fxwAsRi16FbsLNJXRTEGnuCA4rHHNTo6csBv4
 rRvEqFsZTSP82i4F42PEFWMSmesIwI8AD5OtZyKGymA0Tgm4kRtwMiaeOhqnenYPgi6H
 PlEDgkL5KBWt2QBpD1m4AW644M2CW+SMprUrZwSKbsEZQVu2PF8V49lBS5Y/ZefFwunL
 KfyA==
X-Gm-Message-State: AOJu0YxTLTZXLdPN2dPbzmO2cMAXFWaPQTZ07FIN4ncFq3Vd2GHBppvQ
 BM+OJeh4B71AXQMLeQYbhfZyJ3Qu635QSg0vVXr5e90rkWkusua0+sKlysQ7Jjh4ZnhWzx2dPD5
 vXw+yK6p4DrpX/a20wHo5Xm4CnDox9/SMhhs/StccIc9JdsMwtBWu
X-Gm-Gg: ASbGncvzGUWD3w2lRLoNBAeLIzj5h7BxNjO9AV+TtyrxUl79DiwHImtX7EI3WCCaxDW
 4IAM0ttf0smAl0Sd0ZN/ty+2dbl/uqAinz3+5xhgHUwTyiSliCuF6c6PtYXmxIV0Oimfw1nwnNf
 so+avGJ6Vec+DTR4XFnlr4YBAqOi4gwgLYm0o6vlsRx9l2Nq6PuOkHfoXs89/Prb40qM8Bid1qh
 U3Rws8RiuCyZ6EWQmy1JcCIJWIKpyN8Ub+as0ERnWv7HEbCnPy6Yt9pdRMxgCVEhhX10mWcbXNH
 yQ8IG4n3jZXFKAojflSiAZZZ2tc0o4aBdUd+ZySLI2wTlDOBmPO+
X-Received: by 2002:a05:6000:1448:b0:3a0:b733:f255 with SMTP id
 ffacd0b85a97d-3a0b733f3d8mr4118619f8f.25.1746698734806; 
 Thu, 08 May 2025 03:05:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELBZ3E3EB19bUD3hVEmgqnu+88lvvA61hxNeE0ajf/qqdwFaugaHR2jQQp8UqSoJelQ19mww==
X-Received: by 2002:a05:6000:1448:b0:3a0:b733:f255 with SMTP id
 ffacd0b85a97d-3a0b733f3d8mr4118590f8f.25.1746698734390; 
 Thu, 08 May 2025 03:05:34 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-115-173.pools.arcor-ip.net.
 [47.64.115.173]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a0b89a0055sm2997989f8f.57.2025.05.08.03.05.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 03:05:33 -0700 (PDT)
Message-ID: <13eda815-02a9-4bf3-8892-3225a27c0691@redhat.com>
Date: Thu, 8 May 2025 12:05:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: use thorough test setup as default
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250503201806.3045723-1-pierrick.bouvier@linaro.org>
 <f7da46dd-0e8f-42d8-b555-300c088f605e@redhat.com>
 <91cc4370-163e-4bdd-ac1c-b0d6ea3c06cb@linaro.org>
 <aBnXXC3ldqErl8ub@redhat.com>
 <6a8d7703-e275-4566-bc38-b627cc597e9a@linaro.org>
 <e36633e2-e0de-422a-8ad3-1562e97926c6@redhat.com>
 <aBsISp5UvOLzFhqn@redhat.com>
 <51c4e997-8ae4-43a5-81b7-561c035ba85c@redhat.com>
 <0657578e-3825-407b-9837-1e29717f94e2@linaro.org>
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
In-Reply-To: <0657578e-3825-407b-9837-1e29717f94e2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 07/05/2025 20.45, Pierrick Bouvier wrote:
> On 5/7/25 12:39 AM, Thomas Huth wrote:
>>>>> Then I don't understand the previous argument from Thomas to not make
>>>>> thorough the default: "The thorough functional tests download a
>>>>> lot of assets from the internet, so if someone just runs "meson test"
>>>>> without further parameters, I think we should not trigger these
>>>>> downloads in that case". It's what precache-functional is doing.
>>>>
>>>> precache-functional is *only* called when you run "make check-functional",
>>>> i.e. when you know that you want to run the functional tests that might
>>>> download assets from the internet. It's not called when you run the normal
>>>> "make check".
>>>
>>> Are you sure ?  If that's the case it was *not* my intention when i
>>> added precaching - I thought that "make check"  would call
>>> "make check-functional" and thus trigger precaching ?
>>
>> "check-functional" is not part of the normal "check" target - on purpose
>> since we don't want to trigger downloads by surprise when people just run
>> "make check". That's also why we have separate "functional" CI jobs in the
>> gitlab CI, since otherwise this would be handled by the normal "check" jobs
>> already.
>>
> 
> `make check` calls build/pyvenv/bin/meson test --no-rebuild -t 1, which 
> triggers func-quick by default, triggering associated downloads, since 
> QEMU_TEST_NO_DOWNLOAD=1 is not set for this target, except if I missed 
> another hidden hack somewhere.

You missed the fact that the "quick" functional tests do not download any 
assets :-)

I know it's confusing since the name of the suites rather indicate something 
about the runtime of the tests and not about whether they trigger a download 
or not, but the suite names are so deeply glued into the "mtest2make" logic 
that I was not able to come up with a better solution. Maybe Paolo or some 
other Meson expert could clean that up, but for the time being, for the 
functional test we have:

- quick tests that can always run (also run during "make check")

- thorough tests that download assets from the internet (only run during 
"make check-functional")

I tried to document it in docs/devel/testing/functional.rst in the "Asset 
handling" section already, please have a look whether that's sufficient, or 
whether you have some ideas how to improve the situation.

  Thomas


