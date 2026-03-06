Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9EDDFCC04D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 17:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyYzK-00027L-SC; Fri, 06 Mar 2026 12:29:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyYzH-00024T-7J
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 12:29:19 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyYzE-00030d-9W
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 12:29:18 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-358e3cc5e7eso4452923a91.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 09:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772818148; x=1773422948; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G6uZ0yDh2QGK+7N0FMBBRcrbQT3erd+/7/6tC5gtg1c=;
 b=rrW0vOE9q4gSh0w1PbJZGvbXi2oAdDHSmGakYszznER3o0blwSzH/S/ZN42erBqJwt
 nPl/1pJ7ZKKzsCBkVyK6YV9Z0YcGjmWWf5ULgWFSwIfzhBE3RBd3qORUNOd8nwiUSN5J
 35xBt2hIikjkewybL6gGftl1cNgYYNKmYWcVLpz6OADKXIdntFQWzLfbKIEhukHFob5f
 zIDL7sEOIxGAkC/teblVp/FdSXXAfdf0otuqIUcl3qngiYJf/BeHNneKPklqb2j1lc/C
 eoSDJS6oNyKqwwkuUvbLiqzUIpYg/8La1t7HBte7yZP5TBpjHCbGWeZ8jKLaqBryBi14
 DqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772818148; x=1773422948;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G6uZ0yDh2QGK+7N0FMBBRcrbQT3erd+/7/6tC5gtg1c=;
 b=V4w05/KZSBX+oNcU6I18kpmQ2R4dJHUNNeoRL7tAEi02J2W976KCENJVcG3vJembge
 p45VuF2DorlzorvGBVMyUIIZDBNec2wy4G6O3ll8G3af5s8BNQmEL8ZqeGQrciihrh/6
 mL+x3PmcT/inNKARgtfEe9u7YJRJDGb62BlOPZ48ERhhdawx/P0ZzSFBhPknTMbPM9l/
 5coXfFw89w+C3zqH5I7cH6+thNIYOlwiylgOsTtJZp4rCzZC19dadeGQZZg2LwdUFYy+
 w2zj+QBL5C/iGHidEWtnExptsQIMnwTFCj3b7EdMj7WzW7By2S3LfGxO1pbUbuMoZe64
 rq0A==
X-Gm-Message-State: AOJu0YzdIUFuuEzcOxGqm16TfsJVTM1TIgRg9VhfHAfg7EPIosnm0Hgp
 xc6m6aoNiw3ATUgCCUHFWH+ZcslYrotH4EWexhDEwLzEdzupF++VrO4IREWWnhlYlpo=
X-Gm-Gg: ATEYQzzQZ0QhMkkhJs+gHBXhcEiQc+3xwHGlpjQCY1mvY0heOQ5axuPC5AricMHqI07
 0GmiI0ROt/adkRVEvnVPZ9uuLUxJpEuA/H5/K3RylLWt0iVxiQBH1hVfHudALza7ue8ALJYHTT6
 AXvZU2bdGetjh+FccICS0F4AQ8rN0al5S1XEVRmff3PsRPXj84hD4OovVfuX7N78T1lQvRi0jzH
 E5WMnbdwCHj0lsXH6guN3HEvVSYd0YABOFmyai4ERq7zbVYxR+GYa0T0qf87e51J5p7umt5+DRW
 lRVBkZin/KbXQMmkjZBQdO6uvGe1b4mZJ88CPfrLCVAeX/hQbXuH+2YgI1xh0U6xEnMiWDHqkID
 z4tWQmjvdAeaOSDedzxLpRKlnQoH447DdAAfh8WMxbnJ085OkL3A47fFHJW2W5LV0sBh78f2Qtd
 ZZyNzbopBngECmC9sFIa5wtuWuQ9Sc5kD+C7Tydi/XGPE0bORf9sH658rD12T3IxlmL4rq
X-Received: by 2002:a17:90b:1fc3:b0:358:e7de:a717 with SMTP id
 98e67ed59e1d1-359be3495f0mr2363655a91.25.1772818147928; 
 Fri, 06 Mar 2026 09:29:07 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-359c0154116sm2374347a91.11.2026.03.06.09.29.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Mar 2026 09:29:07 -0800 (PST)
Message-ID: <c5892570-5c73-4f82-a487-7c6db760d6d2@linaro.org>
Date: Fri, 6 Mar 2026 09:29:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 28/31] hw/arm/smmuv3: Select sec-sid from PCI property
 and validate SECURE_IMPL
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>, eric.auger@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221101907.2997408-1-tangtao1634@phytium.com.cn>
 <ac35d3e8-c1a6-4f2b-9a96-88f802299bae@redhat.com>
 <1b6a1849-6cec-4c09-aad4-3e5f33ec768e@phytium.com.cn>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 xsDNBGK9dgwBDACYuRpR31LD+BnJ0M4b5YnPZKbj+gyu82IDN0MeMf2PGf1sux+1O2ryzmnA
 eOiRCUY9l7IbtPYPHN5YVx+7W3vo6v89I7mL940oYAW8loPZRSMbyCiUeSoiN4gWPXetoNBg
 CJmXbVYQgL5e6rsXoMlwFWuGrBY3Ig8YhEqpuYDkRXj2idO11CiDBT/b8A2aGixnpWV/s+AD
 gUyEVjHU6Z8UervvuNKlRUNE0rUfc502Sa8Azdyda8a7MAyrbA/OI0UnSL1m+pXXCxOxCvtU
 qOlipoCOycBjpLlzjj1xxRci+ssiZeOhxdejILf5LO1gXf6pP+ROdW4ySp9L3dAWnNDcnj6U
 2voYk7/RpRUTpecvkxnwiOoiIQ7BatjkssFy+0sZOYNbOmoqU/Gq+LeFqFYKDV8gNmAoxBvk
 L6EtXUNfTBjiMHyjA/HMMq27Ja3/Y73xlFpTVp7byQoTwF4p1uZOOXjFzqIyW25GvEekDRF8
 IpYd6/BomxHzvMZ2sQ/VXaMAEQEAAc0uUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91
 dmllckBsaW5hcm8ub3JnPsLBDgQTAQoAOBYhBGa5lOyhT38uWroIH3+QVA0KHNAPBQJivXYM
 AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEH+QVA0KHNAPX58L/1DYzrEO4TU9ZhJE
 tKcw/+mCZrzHxPNlQtENJ5NULAJWVaJ/8kRQ3Et5hQYhYDKK+3I+0Tl/tYuUeKNV74dFE7mv
 PmikCXBGN5hv5povhinZ9T14S2xkMgym2T3DbkeaYFSmu8Z89jm/AQVt3ZDRjV6vrVfvVW0L
 F6wPJSOLIvKjOc8/+NXrKLrV/YTEi2R1ovIPXcK7NP6tvzAEgh76kW34AHtroC7GFQKu/aAn
 HnL7XrvNvByjpa636jIM9ij43LpLXjIQk3bwHeoHebkmgzFef+lZafzD+oSNNLoYkuWfoL2l
 CR1mifjh7eybmVx7hfhj3GCmRu9o1x59nct06E3ri8/eY52l/XaWGGuKz1bbCd3xa6NxuzDM
 UZU+b0PxHyg9tvASaVWKZ5SsQ5Lf9Gw6WKEhnyTR8Msnh8kMkE7+QWNDmjr0xqB+k/xMlVLE
 uI9Pmq/RApQkW0Q96lTa1Z/UKPm69BMVnUvHv6u3n0tRCDOHTUKHXp/9h5CH3xawms7AzQRi
 vXYMAQwAwXUyTS/Vgq3M9F+9r6XGwbak6D7sJB3ZSG/ZQe5ByCnH9ZSIFqjMnxr4GZUzgBAj
 FWMSVlseSninYe7MoH15T4QXi0gMmKsU40ckXLG/EW/mXRlLd8NOTZj8lULPwg/lQNAnc7GN
 I4uZoaXmYSc4eI7+gUWTqAHmESHYFjilweyuxcvXhIKez7EXnwaakHMAOzNHIdcGGs8NFh44
 oPh93uIr65EUDNxf0fDjnvu92ujf0rUKGxXJx9BrcYJzr7FliQvprlHaRKjahuwLYfZK6Ma6
 TCU40GsDxbGjR5w/UeOgjpb4SVU99Nol/W9C2aZ7e//2f9APVuzY8USAGWnu3eBJcJB+o9ck
 y2bSJ5gmGT96r88RtH/E1460QxF0GGWZcDzZ6SEKkvGSCYueUMzAAqJz9JSirc76E/JoHXYI
 /FWKgFcC4HRQpZ5ThvyAoj9nTIPI4DwqoaFOdulyYAxcbNmcGAFAsl0jJYJ5Mcm2qfQwNiiW
 YnqdwQzVfhwaAcPVABEBAAHCwPYEGAEKACAWIQRmuZTsoU9/Llq6CB9/kFQNChzQDwUCYr12
 DAIbDAAKCRB/kFQNChzQD/XaC/9MnvmPi8keFJggOg28v+r42P7UQtQ9D3LJMgj3OTzBN2as
 v20Ju09/rj+gx3u7XofHBUj6BsOLVCWjIX52hcEEg+Bzo3uPZ3apYtIgqfjrn/fPB0bCVIbi
 0hAw6W7Ygt+T1Wuak/EV0KS/If309W4b/DiI+fkQpZhCiLUK7DrA97xA1OT1bJJYkC3y4seo
 0VHOnZTpnOyZ+8Ejs6gcMiEboFHEEt9P+3mrlVJL/cHpGRtg0ZKJ4QC8UmCE3arzv7KCAc+2
 dRDWiCoRovqXGE2PdAW8788qH5DEXnwfzDhnCQ9Eot0Eyi41d4PWI8TWZFi9KzGXJO82O9gW
 5SYuJaKzCAgNeAy3gUVUUPrUsul1oe2PeWMFUhWKrqko0/Qo4HkwTZY6S16drTMncoUahSAl
 X4Z3BbSPXPq0v1JJBYNBL9qmjULEX+NbtRd3v0OfB5L49sSAC2zIO8S9Cufiibqx3mxZTaJ1
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <1b6a1849-6cec-4c09-aad4-3e5f33ec768e@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/6/26 5:30 AM, Tao Tang wrote:
> Hi Eric,
> 
> On 2026/3/3 18:47, Eric Auger wrote:
>> On 2/21/26 11:19 AM, Tao Tang wrote:
>>> Parse each PCI device's sec-sid property during SMMU device initialization
>>> and cache it in SMMUDevice::sec_sid. Support "non-secure" and "secure",
>>> default to non-secure when unspecified, and reject invalid values with an
>>> explicit error. Use sdev->sec_sid in smmuv3_translate() to select the
>>> register bank instead of hardcoding the non-secure context.
>>>
>>> Keep sec-sid parsing in smmu-common, and add a SMMUv3-specific validation
>>> hook to enforce architectural constraints: fail fast when sec-sid=secure
>>> while SMMU_S_IDR1.SECURE_IMPL is 0 or secure AS is not available.
>>>
>>> Typically, SEC_SID is a system-defined attribute (e.g. sideband or tied-off)
>>> rather than something a PCIe endpoint can freely toggle in pre-RME scenario.
>>> So this PCI sec-sid property is used as a static platform/testing knob to
>>> drive the SMMU bank selection.
>>>
>>> For future RME-DA + TDISP, this will need to become dynamic: the effective
>>> state for PCIe requests is derived from PCIe IDE/TDISP T/XT
>>> (e.g. SEC_SID = (XT || T) ? Realm : Non-secure), so we'll switch from a
>>> static property to a runtime per-device state update when that plumbing
>>> is added.
>> When a translation is triggered, address_space_translate_iommu passes attrs.
>> MemTxAttrs.secure bit should tell you whether the translation is
>> requested in secure mode.
>> Shouldn't we pass that information the smmuv3 translate function()?
>>
>> In address_space_translate_iommu I see:
>> if (imrc->attrs_to_index) {
>>      iommu_idx = imrc->attrs_to_index(iommu_mr, attrs);
>> }
>>
>> iotlb = imrc->translate(iommu_mr, addr, is_write ?
>>                             IOMMU_WO : IOMMU_RO, iommu_idx);
> 
> 
> Thanks for pointing this out.
> 
> I agree that per-transaction request intent should eventually come from
> MemTxAttrs or attrs_to_index().
> 
> However, the current producer side is not yet in a state where
> transaction attrs alone can replace stream-level security wiring: many
> PCI DMA paths still use MEMTXATTRS_UNSPECIFIED, and space cannot be
> consumed safely without an explicit validity signal. For example, an
> incorrect zero-initialized or otherwise unspecified .space value cannot
> be treated as authoritative by itself as Pierrick mentioned in this thread:
> 
> https://lore.kernel.org/qemu-devel/dbc4d33e-3477-4f39-a745-4fdc0866fc08@linaro.org/
> 
> In the current codebase, this can easily blur the distinction between
> “explicitly Secure” and “not specified at all”, especially for legacy or
> non-Arm-aware producers. So I think there are really two separate
> concerns here:
> 
> 1. the per-transaction intent (which should indeed come from MemTxAttrs
> / attrs_to_index()); and
> 2. the stream-level capability / wiring, i.e. whether this SID is
> allowed to reach the Secure programming interface in the first place.
> 
> My concern with the current patch is not that attrs-based routing is the
> wrong long-term direction, but that today transaction attrs are not yet
> propagated consistently enough to replace a stream-level model entirely.
> 
> So for now, I think a static sec-sid property is still useful as a
> platform knob, until producer-side propagation becomes reliable enough.
> Once that is in place, I agree that the bank selection should ultimately
> be driven through the standard per-transaction attrs path. How do you
> think about it?
>

As a complement of information, SMMU specification mentions:

```
3.10.1 StreamID Security state (SEC_SID)
Note: Whether a stream is under Secure control or not is a different 
property to the target PA space of a transaction.
```

At the time, we checked with spec authors at Arm what was the exact 
meaning, and they confirmed it was a builtin (static) property of the 
system. A secure device will always be secure through execution.
Realms have a different approach, and PCI transport has the T bit for 
that, to make it a dynamic property.

Of course, we can implement things differently than what spec says, but 
I definitely see it as a design hint that it should be a property of the 
device, and not of the transaction itself.

My 2 cents,
Pierrick

