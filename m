Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 020A7C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 12:01:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjeLJ-0002pw-RT; Mon, 11 Mar 2024 08:01:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rjeKb-0002Xx-TX
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 08:00:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rjeKY-0004c7-5U
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 08:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710158432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OlgcVNfaSaMNOKULnTpDZzoKo+bpzQsC3Zl5sNB2xas=;
 b=VgFNBOJ+AFP9P/AslW/2YmzWHYNSelZB90L2Ycka6Sf184tBucSoEiB2Bu1yEeLnhDO+l+
 cdUVU2JnXB5tUB9cwGsKOTHKF0X3tq4LooI6EojEeBKdp/9Bpu9rSpaU3coRsFiIqKLJvX
 T0GIbFrteToNJoCFvbpjJ3t1oL1RTFk=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-c_MGmgelOLCq3Orkmz9pNg-1; Mon, 11 Mar 2024 08:00:29 -0400
X-MC-Unique: c_MGmgelOLCq3Orkmz9pNg-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-5a112a333ceso3159528eaf.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 05:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710158429; x=1710763229;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OlgcVNfaSaMNOKULnTpDZzoKo+bpzQsC3Zl5sNB2xas=;
 b=nmY6prA846A/i7BXbBiRhzbXF8veOKwKeNuwekZ/3rc8puPlqqBxBcE8zbujm0YrDC
 9dpxvmDEZYF59DEZ6j31259Oh8z+nWGv9tosuAN9m+zrLH9H7WJ6nyG+cHrGfrKBCbB2
 t/q7OCbiGk5UYQtL5sqRcwC4d7dPkDaU0hctoG/JjbqPWlWwyx7qxNGXFCeuLmYcSd42
 C2DCQ/iuO/exa4Q7HUHXMnlMAnmKZJO8R97vpRKxYvxRWFiYz7roZwblcZCOOwJE5e++
 K4lmzj04ss+F4qxdegtnUnYWQC2xHhcJ0obJb6qNXyAmu9zVsXcLcTU+3Mw2L2NW5+L+
 0Ebg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUM9q6P4cVv5RTLMGenwQQU7ot/hpO/AOBFCPiySWU53s4os4MBoczr3gcdKqGE+L7R7qvPVAMYDXJVoN0tBJ8Qg94Gpt4=
X-Gm-Message-State: AOJu0YwvkswO7ENAjbrAbvr7IK68UjGe/VsinYQjXdmmDsq3JlDphHju
 pwicGMyad0oxwbY6h+VYwy54LRNp9TTLsGLsvnDdL4ov2LMuIO2zutlVsEBNvC9KPDZK/uRMbIx
 /bDX+PUXoLMqnsheugvIOU03eAWfk0YvVEHznpKDc+v7uH7pNAsPo
X-Received: by 2002:a05:6358:561b:b0:17c:263a:5b8e with SMTP id
 b27-20020a056358561b00b0017c263a5b8emr6623211rwf.14.1710158429115; 
 Mon, 11 Mar 2024 05:00:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoFGymcm/yCAcEXzXXsmjeeX+Fs1IldS/wF6FFttNQnURTeZ8GnelLPyh5pHMJNeHhLKyC/A==
X-Received: by 2002:a05:6358:561b:b0:17c:263a:5b8e with SMTP id
 b27-20020a056358561b00b0017c263a5b8emr6623190rwf.14.1710158428768; 
 Mon, 11 Mar 2024 05:00:28 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-178-151.web.vodafone.de.
 [109.43.178.151]) by smtp.gmail.com with ESMTPSA id
 v11-20020ae9e30b000000b00788419961f1sm2616827qkf.35.2024.03.11.05.00.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 05:00:28 -0700 (PDT)
Message-ID: <2a8d4e86-1e33-424d-bc13-b1ce5323cb0c@redhat.com>
Date: Mon, 11 Mar 2024 13:00:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] crypto: Introduce SM4 symmetric cipher algorithm
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <95b77afe68b898c95d381c9aa039c16b54d2e525.1701963950.git.yong.huang@smartx.com>
 <ac13ac70-9894-48b2-97a9-ddb7a8077ac7@redhat.com>
 <Ze7PsJV7eQar1hNe@redhat.com> <Ze7Zomg9YrhvrN2J@redhat.com>
From: Thomas Huth <thuth@redhat.com>
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
In-Reply-To: <Ze7Zomg9YrhvrN2J@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/03/2024 11.14, Daniel P. Berrangé wrote:
> On Mon, Mar 11, 2024 at 09:32:32AM +0000, Daniel P. Berrangé wrote:
>> On Fri, Mar 08, 2024 at 09:30:52PM +0100, Thomas Huth wrote:
>>> On 07/12/2023 16.47, Hyman Huang wrote:
>>>> Introduce the SM4 cipher algorithms (OSCCA GB/T 32907-2016).
>>>>
>>>> SM4 (GBT.32907-2016) is a cryptographic standard issued by the
>>>> Organization of State Commercial Administration of China (OSCCA)
>>>> as an authorized cryptographic algorithms for the use within China.
>>>>
>>>> Detect the SM4 cipher algorithms and enable the feature silently
>>>> if it is available.
>>>>
>>>> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>
>>> FYI, starting with this commit, tests/unit/test-crypto-cipher is now failing
>>> on s390x hosts (i.e. big endian machines)... could be that there is maybe an
>>> endianess issue somewhere in here...
>>
>> Or more worringly the issue could be in nettle's impl of SM4, as
>> I'm not seeing an obvious place in this QEMU glue layer which
>> could cause endianness mistakes.
> 
> This is not a s390x problem in fact, it happens on all arches.

Agreed, I can reproduce it on x86 on RHEL as well, so it's indeed a problem 
with the libgcrypt there.

I guess we need a test in "configure" to make sure that SM4 is really available?

  Thomas



