Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693E5C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 13:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx2R1-0007o1-2Z; Thu, 20 Aug 2026 09:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wx2Qz-0007no-RN
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 09:03:53 -0400
Received: from sonic309-20.consmr.mail.gq1.yahoo.com ([98.137.65.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wx2Qx-0006ed-ON
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 09:03:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1787231028; bh=dPE99sHCvypQ23EzktncrpJmi6hmAomsenCsxwBOrio=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To;
 b=bWVMhEOLOQCP3J+DVEwMfTBDQ7KST/O/8ganoNSXspmHsnA6ZHkZseOlR+KQyXBmZ6TMNWRjwI8o+mqA8iaamNg+46/B70U51EQ7U+TDgxRaHY4XDmWaqwZyTMkIPrQVBb7IJ8G641xtfVGd9omOaDAIeWASsCeNvkdZii2+gauFsxDRG99HWwtby8lWIW5a1LE3I0zDtHcE6HVtmKLdS2WkQw6FW+xFwR8dQ5WRkFwnG4mWVt93l4VY+VaNwVpIMoOrNAg6nvFSCdZ5NrqMy9doum2g3lOlngvDeBMkKTOAnjeMWXHxZ4sGprPv5qlhYx6nIcX4PRUs3xsSjVHuFg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787231028; bh=O8SruZh0pIXQ3xaDfux1pefGZ4Ws/Uijrrp8i9Xsots=;
 h=X-Sonic-MF:Date:Subject:To:From:From:Subject;
 b=QY8jhTRF72QPwgjA3QylVMl0QrwCgo/QIsveP+YbVlCNmweGkEojgZHGVsKHwAKCBGUEK3QgRU+zc2qQXlSZtye2c7p3ZfwcaK79zzmzfVRgx37wVFZ/iuWskuE9qQDYOCTp9+l1+3PIs1BIok5AVv6zuwFCBW1P/PREwr3YNKLeVGSZlN0En7qO7Lq8tq8PHF0V9G6w5ZrDrpfCBwEVSjygVIohNB80U0UJnGLf2Lz/a+k/cGZ95QZ6lvB3JdwNLGaSRTA3q2kU/T7pKi4qAI5VRJCuCllKg+vF9o47dpWI1vQdvLYH0Tn3RMXn4xSjSBluLK8iXTfgAguI7zUoFA==
X-YMail-OSG: PbvUjnsVM1mlRT1deoOi1yhsgg9vkToRu0KFJhPE3cSr6BMFqrSSWcnboFmd3w9
 2INKpa1.CfEZT50feO4YJeXsw0xYkIXU9nT3VrxOZlN3ptoJSUhzKmeZylnIdxtxlRugodjl_DeR
 3WUVGRCo58wOwb768KnTWLrhgiyv6cdfrRtWUFbPofgq56ljDddxCefQGip46Pd6RIqcXtRwcoVv
 ZYtpT93XIgSOkQYqFZVCtC_JNMxpojkoV_4kNR3YtsSzQrgdCNE.VFkCeEmW6VM4PB4nWbtf5fF6
 ncv7eQL3NbbhAm5wIcgc4TRKZVBztqE_k3UrC6XxpGw8l84JdP88YJ0_mFxaE8niSihh8oaPYhcq
 UlGRAdlyiR1NLWdiEr4roKl0uuBQy9wqMUXyl_94I8tkMmGQOh7Fp9KsUF_mX0yXoarZ.jyb9Gci
 kHCviHEDo6ke_9ne2YtEo9qW0rJJ5LKh3DOes.Ej.PRcc4RR.rsxBKGsJ3Aqtipdgoot0kvZpKdU
 3XX1WEIczJi.n12lhlxbj916ceAk.kXpxRh2xSQN9d5OkvTTjGS9c8dSIu9AmyDnE5gDsC7e6FG_
 XH_T7I5ihVuBNKCL1gfxSkOJUxrRfpMRK5bUx99XCTWF45xb0Lv4eilVUA1qabwtyHwwZKcebN8s
 7rnLMidPKCKsu94tjXhnSu3jFCZMvfAVY9oIzh1frzY_Y3tal72M3KCdt7A5P30YeOPjHQ8CqYh8
 HS7YaTYEnCRSbsyAPqJ7wvNYAJZknlxKMMDWAQsVBRGiXyYXtFzzQcsW7Ob7mgde5Ck3EPd1Nakg
 e9g4MNPyrn.lz3Ddk8fXv.lJ73XKmxt5k7githmDd9Xb0PyBOF1xJ5nf56SlgoY0jiszrISvv2jV
 0GxQaQaCt9EnNRcauxJ21rdTLzCFPLWm5FxYSfO4su4f4KHGWUo5ceBe66loB.mIzdNbr6cMx4RE
 RmoDhxlww_SML.KfBD6FKWWq2tWbQF_igok_j7mcOI8GSYoKP7kyx5SaaNAs2Z0KTcmEN7vys1mw
 PlV4wDliM8pUwVYpjHL4QLBLBr_SjFxnCWa9Q37ZCwtPuVLaekYsCQv6wgx7dRWONQrAZAUrlOB4
 AV0FW_zBwp0FbHUp0_m7sbGxPTid1V6hcy4Mlq4kLGcOfIu_NzWJpiMWMME1v.s5mTR_eyg8LPqD
 kbGxPAREjV9KZ8qaem9G7lJ.0evDgztlw1xjkYRp5gClFwq_u3SLBFOGk8Ff5wOdIFm.KgaIR6fY
 WupWAkVvDJpw53XJrfdQZRo4r2Dpyr23wQyIxhIXkn3OVX0rVVhkd9D1sF55CffBryCyBVh2YsTR
 8pJPPmZnko27bikv1sYZeKAw6VH48MwIh85ZPNKhjiv4JDhV6eVmjTJkVkNOklfl041YFi2nUG2.
 tS0i8KXYl9bfunNU8SFhHszDPDmtTVMIJRCmqB3Vge_1vlz1tZpa4455zT8PBxc5Hs9eVQAkGLv7
 P5Cqu8XT_GGS0.jR6RjHqgBFvlpRnLw7N__cAxoL1xQNLRl961o.dL_31mSY.4wuFm4di6PUEu4o
 9JFe9NGQY5FMzPPHbwiq3WMwzYdOonCBVnIHbVWOONgJXEx9F2BuvMDt8MgatP6Wng7RzBRGULjx
 R_iHZhLY3s4f.GWvtK0QyoBNbSJp7SGjpGILE3SJWAzhVcVf7tpEOG3RysCTv5MRS1PFZ5Guh15f
 qZcYORo4rtAIre24HJgbEokNeifEHn0uBqPyjvyPn43QtGUkzVBtbO52PuAjLllI2YLHLgrPz5f0
 QTxplbLrwYDd2CTPOR1jxzsGfBrNcjvjq8l0t19kRDq87nt25TUum5s2zPMPtIvq4knpGEcEuFwr
 6pWJ7KX6sU6PvkNKzn62EO8Cx_0PON5wOLnefZyLqvu5RcDDPqF0NL_cTu7GwUw830kBbxyEfem.
 4tjuyfJ5yAhlZZY3nhswc8L2lwRBv9HazwJB8FEFVTrCq6Zvm6A_GWHat9m75xoKGNtbpg_B3PK2
 F0565IeME5yKv7S5I3Buk4BGbO4EYb997x1RmNaE4wQUpE2dXeu.mmUgKoQI6UsGtQiMlK7xHVRz
 Yi2QtOjb8.enjZc3Laa1ElsQzKRDhbi5y6tj3.57e5FxnyNsrCFJhTCQkRaNqv5pCHFzRQTz67Td
 PJNeKBgdYFGSeH3mVZwOQK9.mGtD9Cw83mIUfW0mYUmu50pJlkMsjAxmBs5cfJwE0VX6DrpxLXzT
 SZ1G0fO.8Y33nYygeKO1gp3cnGhgoyLKqAFmcxT9nRcGSbkc-
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: 80061041-86f3-416a-9689-bd491a756f1b
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic309.consmr.mail.gq1.yahoo.com with HTTP; Thu, 20 Aug 2026 13:03:48 +0000
Received: by hermes--production-ne1-6dbcb84f44-wqnk6 (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 57e5b9f33273342361b36bf3a60d741b; 
 Thu, 20 Aug 2026 13:03:46 +0000 (UTC)
Message-ID: <0762fb50-01b5-4ae2-8587-7574020082b4@aol.com>
Date: Thu, 20 Aug 2026 09:03:46 -0400
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
 <da2200cd-def7-4cce-a6c2-9f9ac9e202ce@suse.com>
 <de56c8bd-f0e8-4fe9-8cf5-f6807698176c@aol.com>
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
 <682975cc-4857-42b2-badf-b638869f3268@aol.com>
 <7ab98288-0c5e-472d-87dd-5586e60027bb@aol.com>
 <f0ffe015-1bc5-4091-8dbe-2b4eee9cec2d@aol.com>
 <b05a3553-398d-4ed0-bbf1-6e93cf385fe2@suse.com>
Content-Language: en-US
From: Chuck Zmudzinski <brchuckz@aol.com>
In-Reply-To: <b05a3553-398d-4ed0-bbf1-6e93cf385fe2@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26254
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
Received-SPF: pass client-ip=98.137.65.146; envelope-from=brchuckz@aol.com;
 helo=sonic309-20.consmr.mail.gq1.yahoo.com
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

On 8/20/2026 3:58 AM, Jan Beulich wrote:
> On 19.08.2026 21:09, Chuck Zmudzinski wrote:
>> On 8/19/2026 1:49 PM, Chuck Zmudzinski wrote:
>>> On 8/19/2026 11:47 AM, Chuck Zmudzinski wrote:
>>>> On 8/19/2026 9:51 AM, Jan Beulich wrote:
>>>>> On 19.08.2026 14:36, Chuck Zmudzinski wrote:
>>>>>> On 8/19/2026 8:16 AM, Chuck Zmudzinski wrote:
>>>>>>> Yes, I agree that v3 of the patch to hvmloader should presume that the DM can get
>>>>>>> a copy of the OpRegion and read its contents so most of this can be done in the
>>>>>>> DM instead of in hvmloader. So from hvmloader's perspective, the patch will be more
>>>>>>> about avoiding the layering violation than anything else.
>>>>>>
>>>>>> However, there is one advantage, from the viewpoint of the Xen virtualization platform
>>>>>> as a whole, to do the patching of the OpRegion in hvmloader instead of in the DM.
>>>>>>
>>>>>> If we patch the OpRegion in hvmloader as v2 of this patch does, we provide a common
>>>>>> solution for extended VBT support for Intel IGD devices that would be compatible with
>>>>>> all DM implementations, not just with Qemu. So why not do the patching of the OpRegion
>>>>>> in hvmloader?
>>>>>
>>>>> As indicated before: If the OpRegion holds data that is needed to drive the
>>>>> device, and if the OpRegion is exposed writable to guests, then guest can
>>>>> screw up that data such that subsequent guests won't work anymore. Hence
>>>>> exposing to guests (which includes hvmloader) needs to be stopped, or at
>>>>> least be limited to r/o. That, in fact, includes exposing to any privilege-
>>>>> restricted DM as well.
>>>>>
>>>>> Exposing r/o may be entirely okay (i.e. may not be a layering violation),
>>>>> depending how exactly an OpRegion surfaces for a device (on the host). Aiui
>>>>> it's not addressed by any of the BARs, yet it looks like it needs similar
>>>>> treatment. Earlier on we also talked about the region not necessarily being
>>>>> page-aligned. That poses, even with r/o exposure, the question of other
>>>>> data on the same (leading / trailing) pages. This may imply that the
>>>>> copying needs to be done strictly in Dom0, for both DM and guest to only
>>>>> ever act on copies (which may then as well be r/w).
>>>>
>>>> Yes, I am thinking the DM should make a copy host OpRegion and never expose
>>>> the host OpRegion to the guest but only a copy of it.
>>>>
>>>> The reason we need a patch like this is that with the introduction of the
>>>> rvda/rvds fields into the OpRegion, the OpRegion is not always position-independent
>>>> so its contents might be unsuitable in the guest address space, so in those cases
>>>> we need to patch the copy of the OpRegion that will be exposed to the guest.
>>>> If there is an extended VBT the DM will also get a copy of it, make a copy of
>>>> it, and expose it to the guest by appending it contiguous with the OpRegion.
>>>> Since in this scenario we are assuming the DM knows the contents of the OpRegion,
>>>> then it can find the host VBT and make a copy of it without needing hvmloader
>>>> to send the rvda and rvds values to it.
>>>>
>>>> Then, the remaining question is which component (DM or hvmloader) will patch it
>>>> if it needs to be patched to make the guest's copy of it compatible with the guest
>>>> address space.
>>>
>>> As I noted earlier, it think it would be advantageous for the Xen platform as whole
>>> for the patching to be done in hvmloader. That way, support for extended VBT is
>>> automatically added for all implementations of the DM, not just for Qemu. But the
>>> downside is that for hvmloader to do the patching, it needs to know the host OpRegion
>>> address, which one could argue it should not need to know. This is the only reason I
>>> can think of to do the patching of the OpRegion in the DM instead of in hvmloader: to
>>> avoid disclosing the host OpRegion address to the guest.
>> 
>> Correction: Actually, with this new scenario, we need not disclose any confidential
>> host addresses to hvmloader if the DM removes such information from the copy of
>> the OpRegion that it exposes to hvmloader. Then, all hvmloader needs to know to
>> ensure the OpRegion is compatible with the guest's address space is the guest
>> address of the OpRegion. It need not know either the host OpRegion address or the
>> host VBT address.
>> 
>> So the guidance I need from you to do v3 of the patch is simply to answer these
>> two questions.
>> 
>> 1. Should I write v3 of the patch not only assuming the DM will never expose the
>> host OpRegion to hvmloader, but also assuming that the DM is responsible for
>> patching the OpRegion to ensure it is compatible with guest address space?
>> 
>> Or
>> 
>> 2. Should I write v3 of the patch assuming that hvmloader is responsible for
>> patching the OpRegion so it is compatible with the guest address space?
> 
> My tentative response is to use option 1, not the least because a mid to long term
> plan is to see about removing hvmloader altogether. However, a more firm response
> here depends on an answer to the question raised in
> <92022f85-9a53-4db8-b489-fc91c86b413c@suse.com> (sorry, the list archive hasn't
> caught up yet).

I apologize for the tone of my last message which I wrote before I saw this message.
(Unfortunately some of your messages are going to the spam folder, I will try to fix
that, but it seems aol.com's spam filters are not all that smart)

I was really hoping you would answer this question and I appreciate that you are
able to give me a tentative answer favoring option 1. 

To follow up on what I did say in the last message, I think we have exhausted what
you and I can agree on and now would be a good time to pause this discussion and
I will write a new version of the Qemu patches and v3 of this patch assuming what
I said in option 1, and hopefully the Qemu maintainers will help us out by replying
to a version of the Qemu patches that does the patching of the OpRegion in Qemu instead
of in hvmloader. So far none of the Qemu maintainers have replied to my Qemu patches,
unfortunately, but ultimately, we at some point will need their input to decide how
best to do this, so until they respond to the Qemu patchsets I posted, I think we
just have to wait now until they weigh in with their thoughts and opinions.

Chuck

