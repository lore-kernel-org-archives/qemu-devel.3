Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B7E2C5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 13:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxP2e-000616-PQ; Fri, 21 Aug 2026 09:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wxP2d-00060v-Mg
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 09:12:15 -0400
Received: from sonic302-21.consmr.mail.gq1.yahoo.com ([98.137.68.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wxP2b-00040Z-NN
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 09:12:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1787317929; bh=5zVYd1XG2alULCFSufa2I5v6mNIHhhyo27EKgEpsIMs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To;
 b=D4yB+rRQni0q1CvKdI5RbLiG5JiRHSg6tH38U/lEhlp0kxgtcmAefoweXoxysRFocIT/hF7MPgp12TtYEL7j94ocjsr9xz/d23BSp0LCRCqcGRaQgo4n11rvji3Wk7BmETNCqQWlF3PNlsmjjs2VZuttB/i0dn7ZQBB79XPsgfUQ+E1UA7qfL/c+jxpUQwKhCuSH2rE3QADgAoarCnMWDhxj2PFEk+G9T97CpuKAcu5psWJmRP+vnf8iGafTEB4mEsdkDALRCZLZIO3V7Mpjig1K5O/3lX8cccPhnwS6tiLSCC+vcBn7nONlPziBtRi6CcEs95hUr38VZnNtBYSLsw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787317929; bh=sB5lDNfJerqyBHBh0LK6YLb0P4q43K0eOVdEd/EhEyL=;
 h=X-Sonic-MF:Date:Subject:To:From:From:Subject;
 b=J1rsFamuBdhDgqC5KOZ2+dz7lpeVl8ltHjDiUD2EgOPZisKwM6YHHslJTKzOSIPstMDccdm+jju6U/3iUXJsuzhS4+n5QbcYjtZtYPJpg0WVash8nVW1subkSGBn/mCqK4Hidki7r34nG3N7cXSN7S6W7pxKRGddLXXUJLuKmLaE4DaXIJEJKfP/xkePBYG9T5bO3PW28kzxtOyTCdANMQQuJIn4L2ZNRqjH3q8Pw7+xalcvfXhnlcfrjTI1gk9+vk3ezt/Oxhq/Ou+vAAiWeZ5wQ7n3hRDO25pQcO5ZBK7gXtjMgum9KXluVHMT06kTkwgQRz97GPuAwuFydqWBNA==
X-YMail-OSG: 8VWMebkVM1kbktK5MBYZ5yNojDJ_0o4ar9Ck8xZh7LK_MQ38mYB1XlTclm6EdLm
 IKctxdjrDTQkT39m.niTrAv461Q2kAy.jc_n8LAJWQbrIXOmBUSZQ5Hd7lyTdfFTG_5oWgc.maao
 sqP0mg6BeqYR7Nsi6PPeubCKk6e.RV4ZKGCMhMU3StzF7nnpStJBPjj8TTtbhTS_Fdn8fi.roZOo
 7mZxLk.rXayh_mZioN3hA1_ctvijaqV9CETOZFRE1yzo2qSq8948XG1J1shbt4.TNFnqmUQMjgUb
 NJ1qdjS5bM3dAKZf7AT_nF9OmgSw7ye1KbC0DCtSmUxgSmWYIpo34AUIIfLRyvk1_0O0HMJnAqLY
 9Jdu1KU12SEq9HCPyqBhtQYa.qOI4YGZhZkiS6iONCLUhkbopSfwDriUS1qfp9LpDowT5MLk4Hlv
 b933D_BZ.dugMBPokxm5yzNsPYIvwJ0OVAOn5Vtg5TRz3M5OtDI2nYEwrBTQLJ6fcGiy.32ucTyn
 KRmrN8PTuQiO1UQJFwddsKqTgtWuglOJzlzVBCW2RJ3Zvd4EiIyB5a4_F.iRz1oAStl9E1_V.Z9A
 p2fEbELvyCC0QjyM5Vtl0BFMI_3AnFj6nfeb_QXY5e9QEUrP7U_4uX_O.HOqPTyXVXqPdYyUybtZ
 97YIj.Rb7WwkBss0DmNRebwjvSJqXWKDQfVfwduwmx5jVFx13CWv_g4tKVUaDFEQglYFEyKPTKy2
 6LZ7hjLcgPbbjHXNhfMyXfVf6JW3UuWOI2f7HvEQbAkfJ2eSHFFEhPAmrHxs.M7A3aYxGWGv_vCK
 j4CX8HEEC7YRRnZXDcnHjfIYsCJWZyz_8gjmmZHZjVRXEqClkSobOI6zlZv9kCEV83TtcdHOgD9w
 pRlis9SqokoGiWRu2fAfcfDcZ08Ia7et6_uPTzkNxIbuNig7o24THtbRLpAmYtPhuQpl3uWDp6j2
 KC_gOlNzkPfToidVY0RbMxYaE666yPf9.IoMexIguIpkjkKXfTFnuDxxFb.thaEG6rxcChRRDiAj
 rtJIl2uKSealiTjxMP3EjSvW7HBzQpqG0mw9GjbG_EZp7G9ahOHKelmYjtflRYvIFKeQlR5k60eZ
 _WMloQMa1zHpJXkITjrwBnHqGzi_ryc0hcysfBUSY26qGhHgAanqBCopgRGObhkHGuzY9_2anaaz
 qFrx0O2fksuHi3exJ5bLJ8hGT8w6h2UjmIm1gmJ6d85DHwYK0DnH7SwF3zx_9rqZCUwfjxRtNMl4
 NRjpuYTh700oRO3J.2Lmgz6viuKQKZ846c7d0h_93wmMi7K28RlSQNb0NZIbvWOlT7WfO2QWQ2r.
 9y6V93_t4fYaIYbHnCHiU0QoGk0IJQnrkUIjJudnXOXjuoTejyU_aBTDSpBlP7ii8gDXm7oVp8bu
 JS642ZGu8kKZrxOHcwCuPYPZvmtWN5z.EPnm7v2vW_KVNfOYDtMjbL4CsWnBLk_I.93bGFk5zmSE
 mF3IGOGHt7cU_0N41LUlAr2SQqphMr.gXeaqsc1jZAH.fs5aWQbj4rcBIC5yfLFLXbHhSZshk0lU
 KOpIAXWfes4NUjEBAOmCN7MKIbMoT.W1i93FPL44kDY0LlCzNRuseTB_lNjqN0aJgNjKkEXsfe3u
 U.rYpCVdWljIsxyWCTGgLlUkDWBrjvMNHYprpdgvkMoVvbvAk13.MYhUnaOoekjnXMxrpobKpfqn
 lgBjFziF947cBnNlQzHAXZfBbkMu0x9RIcMUvE8k0.56J0QiBAykGza0GCrB4611.EjVA5KA9bCf
 Hkc.woZnLHjMJ5Xl0KeVuFxD0V5c5PMXneZNPoDFyUuxt7jv5ltXIkcDGwlhvqv__SIOWBRM5CMX
 3nVNWgo5HxvkwrjIQ9pDWXtZZ3pD25EgKdwK6wtI0W7YtJhkOGUysWTWX3RvdRSz3CuQuDG48ex5
 AgQSlHR__QptP4HoTy1CCLT2KJnHZwef9YGDMF9AkKJVUzZU5Ap5S4ZFf8Yvs54B3ZCMiIviOJLV
 5SmyoOU7WP5tpoUS0PSINRmRJ6ZwIwQsG8bd.22JLdGDMUk41my5fbyprYeNIJ2C6XHzBieADxuJ
 istIyW1ru9p3k.b9Jy6c3_UC.r9bpHI03dcKkB8PxR3QKRSZtdElWHDGI2PPewOURY5hYnUQjLxj
 isPJZTsGTs7BEGZuHiwfiuz9HLjgsCBJPdXuhd8OOV5ksDlxpjTl2KFRX8WOV8SafZatqK9I1rEd
 vOZ9AkSW1qgSdzleLEP3U8trYIUOu4jHHExlQoagYqvcXxw--
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: 5c5ac2a8-00ef-4873-a97d-076503ba1328
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic302.consmr.mail.gq1.yahoo.com with HTTP; Fri, 21 Aug 2026 13:12:09 +0000
Received: by hermes--production-bf1-54b5569bdc-7hp85 (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID be8bd0e2097ea023fd1597134141cdef; 
 Fri, 21 Aug 2026 13:12:07 +0000 (UTC)
Message-ID: <24008713-2516-4a26-ab37-acdfc174a5bd@aol.com>
Date: Fri, 21 Aug 2026 09:12:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tools/hvmloader: implement Intel IGD extended VBT
 support
To: Jan Beulich <jbeulich@suse.com>
Cc: qemu-devel@nongnu.org, Andrew Cooper <andrew.cooper3@citrix.com>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger@xenproject.org>,
 Teddy Astie <teddy.astie@vates.tech>, Tomita Moeko <tomitamoeko@gmail.com>,
 xen-devel <xen-devel@lists.xenproject.org>
References: <20260802050824.10554-1-brchuckz.ref@aol.com>
 <02a7dc18-4184-4e86-84cb-121769187f71@suse.com>
 <1858e8e6-73fa-4017-93e2-c733fbf0ec8d@aol.com>
 <d6e603bf-8dc5-4ac7-842f-ff9d1f67b98f@suse.com>
 <fdec0b6b-eddf-4a36-a755-c67963daa9ea@aol.com>
 <6ecf80ef-2f0e-44fb-beab-dbcf065a4431@suse.com>
 <bb44067c-6739-4e83-a0fd-cc7ea797048f@aol.com>
 <4c58bda6-e9ed-438d-b96e-feda74a6c4c7@suse.com>
 <31a5870f-2a4d-4dc0-af9c-f0567e0f6fb3@aol.com>
 <db8fd04d-bbc7-41c7-8473-b821d7f77d5f@aol.com>
 <302ed12f-40ca-405c-80ca-ac4f2785d754@suse.com>
 <cdae1785-4d9a-4aab-929e-de55c26b7b94@aol.com>
 <10cd9f6b-678b-407b-a51e-70e9ed7a35fd@aol.com>
 <131b1252-b108-4b4c-8457-673ff0d20d5e@suse.com>
 <b14969c8-9676-404e-b7cc-ce13a6d7ff94@aol.com>
 <92022f85-9a53-4db8-b489-fc91c86b413c@suse.com>
 <fa497825-c8f0-4caf-94f5-b37108e31952@aol.com>
 <42521391-885c-4b96-96e9-5da2e4b5efa1@suse.com>
 <e86404e8-9966-44ab-86d1-4bd01a551313@aol.com>
 <069cb01d-47b2-41c5-9956-611b338964e9@suse.com>
Content-Language: en-US
From: Chuck Zmudzinski <brchuckz@aol.com>
In-Reply-To: <069cb01d-47b2-41c5-9956-611b338964e9@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26254
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
Received-SPF: pass client-ip=98.137.68.147; envelope-from=brchuckz@aol.com;
 helo=sonic302-21.consmr.mail.gq1.yahoo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/21/2026 4:19 AM, Jan Beulich wrote:
> On 20.08.2026 18:53, Chuck Zmudzinski wrote:
>> On 8/20/2026 11:17 AM, Jan Beulich wrote:
>>> On 20.08.2026 13:47, Chuck Zmudzinski wrote:
>>>> On 8/20/2026 3:51 AM, Jan Beulich wrote:
>>>>> On 19.08.2026 19:13, Chuck Zmudzinski wrote:
>>>>>> On 8/19/2026 9:51 AM, Jan Beulich wrote:
>>>>>>> On 19.08.2026 14:36, Chuck Zmudzinski wrote:
>>>>>>>> On 8/19/2026 8:16 AM, Chuck Zmudzinski wrote:
>>>>>>>>> Yes, I agree that v3 of the patch to hvmloader should presume that the DM can get
>>>>>>>>> a copy of the OpRegion and read its contents so most of this can be done in the
>>>>>>>>> DM instead of in hvmloader. So from hvmloader's perspective, the patch will be more
>>>>>>>>> about avoiding the layering violation than anything else.
>>>>>>>>
>>>>>>>> However, there is one advantage, from the viewpoint of the Xen virtualization platform
>>>>>>>> as a whole, to do the patching of the OpRegion in hvmloader instead of in the DM.
>>>>>>>>
>>>>>>>> If we patch the OpRegion in hvmloader as v2 of this patch does, we provide a common
>>>>>>>> solution for extended VBT support for Intel IGD devices that would be compatible with
>>>>>>>> all DM implementations, not just with Qemu. So why not do the patching of the OpRegion
>>>>>>>> in hvmloader?
>>>>>>>
>>>>>>> As indicated before: If the OpRegion holds data that is needed to drive the
>>>>>>> device, and if the OpRegion is exposed writable to guests, then guest can
>>>>>>> screw up that data such that subsequent guests won't work anymore. Hence
>>>>>>> exposing to guests (which includes hvmloader) needs to be stopped, or at
>>>>>>> least be limited to r/o. That, in fact, includes exposing to any privilege-
>>>>>>> restricted DM as well.
>>>>>>>
>>>>>>> Exposing r/o may be entirely okay (i.e. may not be a layering violation),
>>>>>>> depending how exactly an OpRegion surfaces for a device (on the host). Aiui
>>>>>>> it's not addressed by any of the BARs, yet it looks like it needs similar
>>>>>>> treatment.
>>>>>>
>>>>>> Yes, the OpRegion is not one of the BARs as specified by the PCI specs, but
>>>>>> it functions more or less like a BAR region with the devices's ASLS register
>>>>>> at offset 0xfc in the PCI device config space of the device acting like the
>>>>>> BAR for that region.
>>>>>
>>>>> That is, on real hardware a write to that register moves the OpRegion? That
>>>>> would need following by the DM then, i.e. the DM would need to indicate the
>>>>> original position in the register, and the guest (incl hvmloader) would
>>>>> then be free to relocate it.
>>>>
>>>> Why would that "need following by the DM" when the register in the guest is
>>>> fully emulated, [1] which means that when the guest (incl hvmloader) writes to the
>>>> register, the register on the real hardware is not touched, nor is the OpRegion
>>>> in the host address space moved?
>>>
>>> You said it's BAR-like. If the guest writes to a BAR, the referenced MMIO
>>> region moves accordingly.
>> 
>> It's BAR-like, but it is not actually a BAR (and the OpRegion is not exactly
>> an MMIO region either (it is actually and ACPI thing), so that is not relevant
>> to this patch.
>> 
>> Also, it is fully emulated so when the guest writes to it, the real register on the
>> real device is not touched, as I have said multiple times in my responses to your
>> question.
> 
> No matter how often you said that, I never put that under question. I was asking
> about the behavior of writes (where the behavior on bare hardware would need to
> be reflected in the behavior of the emulated register).
> 
>>>> Here is how I understand how this works in the current implementation and how
>>>> this should be done:
>>>
>>> I'm sorry, but this is getting out of hand, at least as far as I'm concerned.
>>> I've been trying to help, but even just reading your replies has already been
>>> taking way more time than I would have wanted to spend here.
>> 
>> Fair enough. Thank you for the time you have spent on this patch, and also thank
>> you for clearly stating that you don't want to spend any more time on it. So
>> I consider this patch dead unless and until another maintainer shows some interest
>> in it.
> 
> I didn't say I would not look at future versions of the patch. However, for me
> to (usefully) do so, things need to be presented in a way that I can understand
> without knowing all the details of IGD.

Thanks for clarifying. If I do v3 I will try to present things in a way that clearly
answers the questions you have raised here about IGD and provide more information
about IGD than I did in v1/v2 for those who don't know all the details of it.

If I do a v3, you will of course be on the Cc list since I expect you will be one of
the maintainers of the affected code.

Chuck

