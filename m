Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD80C5B572
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 13:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuroB-0001qw-2r; Fri, 14 Aug 2026 09:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wuro6-0001qY-Ve
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 09:18:46 -0400
Received: from sonic302-21.consmr.mail.gq1.yahoo.com ([98.137.68.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wuro3-0002oS-99
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 09:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1786713519; bh=rzNM7wrNIM1ZAo3lFVCGJnUCLF2XiQRYvmh/CjNxmIE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To;
 b=lHsvcmtBIBHevgRJpwopk/WC7UXs3NCDIkL6ZQsWCPxEoQevEbOl7uSGCO8azpJZDvwqrZXmL0e4BeQz2MgIgncwsh/47kKFXlQxJ700byMQL/Y5BrVUdOwsh6R2Pa4t9y506SpoLZj1FIh9IgMlbMcrI60Sp9fP3cs6S2fCgVQn6oCvKvbEMRlMkYQWtZyvggRJiIyOf9hiH7321shwjPKUa6VsmKA7NcfyVkBuvqLi5Hmb/5hRd7h4JsvlRMGqRJnIXEaTc+OILfKMoTY1lQH9OxRupX3XYWOHg2ADqAFmM4faHA/GuijbaTTVk/iP5d6Gb0HAebsfp+68KOnLog==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1786713519; bh=SRfdPmMEftdtgGI8CmKwgeoibl5WUmfX+908MSE94Qi=;
 h=X-Sonic-MF:Date:Subject:To:From:From:Subject;
 b=Sc6t4Oz+3fYeQA2N07uB9QpC2p9sVApB8SzAgDOYwa1osnVhVsrwBddgIAy7Axyj6RwEUjm/23awi95wtovyiLXUOINUgSoY9JsPFumVQT7UwkJWoSkvOvbyYElf7h+kOT99xdWb8sXc+N6M3h3Yk1zAlMsav7Sm1Op69nmFlgDXetH7AJhT4tHZDKzuDkwXpDSMRwPqJaDn1MZnhVWGtlcqoohUrjotfOg99YDEtELtql5FJEK7Ce5EhHRSO8RUZRc7B3oHmt38WEBFyhNeO9Mxyia6sE/gHIEj6+TRvokOuBlZB62CCqAN2ogn4lhYzQeW9t01GtegLpEQNv5Y1g==
X-YMail-OSG: kTBiCAoVM1mEGyd65SZUN0OSW9oZm4N3pVBq1xF73yCSm3yoXQW4Juu4J6yAazc
 CaOR3jTd5TgchZn0RXO4UJoVDPg9cbld06ETA2XZ9s0jItjW6w8o6syH4MqBtDcg9Xp5shjw7vRB
 9ilxgKx61446vKf6.bwARyTbAfLcMDztwB.vZubVvS2pkm9S0bJ5cHdC117.AwDD0xMJ4Cx_m5y1
 gvem_WkqFbcnJy7E75AEeIn_3v062DkFQTvx5uH4_jYgGf_PikzsX9ECZ8i3gayp6Es66qv_7jpu
 v_v9rBS85c0TYHS_xqEoAJUXGOs6EyH8LkY7OEW3PkY44wVX2IUSIefK4GHDAAJ1_FcmNvrNrhjY
 c6V120T8H5Dzl1WSJSzgq3iVlu4ADY5hk3oOwtYO.hR2M0zIyg46pyMv7h2uIhFdu8iOexX0Yuwf
 c.eYlBn9vNrVacHY7oL_0LsHuoYmkPzKbsHfYBgbKWKoPArpB3cT.gaV4Td9xseINTZDmI7xe9Jc
 3E8JT3kOJ_39FS11Y7868Rb9.11ABGcpOg5uIBu5y7c0bqdtOpvVBN9nVX.3XXTJQyY_REMuWDN_
 y5RMAhusNA49_JE3XNi0qUhcFgGTqvPJd9s_vg18MfMGN9o2N_5j3nmxtxFNaEOeFwqaCNUF34vF
 HH2UpUSOfusu4o0FNpqxbeCeA2l9CoHY9sEUF9RlxOLNy1X9iWORHONbHqdXLLeX7hob4iB8Kld6
 87j94ea2kf2Yl_R6.ub0oYYQHhMBEaR_YIL7Z4KgVQXtFXkT8n0i6wzo.TPHEBbG0gvUy8VWAdgA
 7XcMN3kVABXVS9K5hSlAYAZyhEeRAGBob8AFe05CaE.cJFedYfnriB1A_BFzcWPNlodEbAE0Bdrb
 NFOdNWRRjmrMpvAqA0YIqOE2Qz0yTILY.ozXyv0cSHPgM6cye5ru.YyJv4nFwdoQ0pGGqpvjCuCb
 vDq2EsiI9Awpk2MbeP6ZjnRwpBvalj4L.nbONgQ1_Y6mVDc7O1vkmbwDsoGkdPtUEmblwyVhIZYu
 9Mq8GaR2OL.56A36l0bpzSxiesZb1Q4qiOyMhSDa9zoRILDPTj43uOWGSamh2J4OylWkzM1jq84Q
 LEIARn00q9eBnnLZhV6K.jspVh5gBbI1Lybwky.5XFtnxm_aYOMk2i7p0KGWa5Ofcca11hDgYy4a
 OkhG0cRuO2S7ZQmoY6cJl4eFyGHMdtiwFuJnRhz1C4XFiwXb_aHhQFdfmvaY28xdaY5qVPe45Hz0
 lcygru.2A7LRtT6AmI3SL29OuJZYNZC9Y3Do3bZRIV1IXuwh8pzqFCTps4pA_L2lJ2iJnPiL9sUx
 EoESvng2LfULg60LgdjgPjtzavOuky86jkLEgb0_KfBVVNb6gTlQy61I29cXDbPFZGs2yWNsET4j
 3E02M85ilR8qtFbEdIjysxkzIrBaXeoyXLTiIo3OmTb.xRNl_aQp_MjqHidqU_lJDYAc2c7zoJG2
 uQW9DD7bQ7EXjauX5UgBpgTuBLdD5DTG.C_GiGFRdlSrM2T9E9Adwnvx3ru.7NNFKBNSeM9mmf4O
 _gb90USbJPIbq_vSj5u8xzGozR3cLElpMgRTsDTi52VeyMnK7_JyMPwy2HpPZ_dO3aJEgo3Ok8XW
 OsBM36KDle5Ax_uTd3ue8JBh_1GRqfDomS.yejKr0lLwyOB1eLtMhVU00ZfF8KUiONtbBFAmDTv4
 ReYE7vVwrbwqvGLzBgufgSD6wmcFK7aHH7Gf69sGgY8SzJIyXzHI3ed9ISO.JeRGzb599cSHFVxu
 7_uVA3GwBLhGSeMlfaCQnQRc6FzDi5XGJFf6_ZZEOY65Y3sXa2DQp605NoKyCn9FpJuJ7AgWwwVI
 2yhy8y_p8Zp9DGpThv9roYerjbdx8Hd_KmOKmsF8lnIB_QjzL9Drqjh3RQkHP6eQ0.wMJJBEUwVn
 o7ZGxu_nMOY38q4hGiNDE5UoN5IsTqFCt8Gu.dqr596hqvKM0FysIBSRls6CnbWNKluakl6laXv3
 AYlnOSbWx5Np2DgIfGptPe6UOKYqIps0nfunCpLozB2xBOjqYBNETe5hxE5.8Wsn6PK63Tgb_x7J
 XTqMat_7_o7FvN68XfV5UJ6Aotf3OFQt8ZZiZnmGj_r0FqxvSbcV.FcQBk1iztEk4h6l6VSXzQUS
 hNu4kW.oy1T0k6jdzQ4rcIwRdUZ8CG1NvB0rst0M6.JAxTQQhOKwqm6xCrTYZINjNcHUxrlYIv8e
 uPqJaLvei4AcIihtwQp1aoYu_lElP3rsnsws7dgwQ9.6klTgd
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: bbc3b853-d096-4694-a59f-59507dee7903
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic302.consmr.mail.gq1.yahoo.com with HTTP; Fri, 14 Aug 2026 13:18:39 +0000
Received: by hermes--production-ne1-6dbcb84f44-rfx9b (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 417548e2e1190c980fd08d9070b940d0; 
 Fri, 14 Aug 2026 13:18:34 +0000 (UTC)
Message-ID: <de56c8bd-f0e8-4fe9-8cf5-f6807698176c@aol.com>
Date: Fri, 14 Aug 2026 09:18:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tools/hvmloader: implement Intel IGD extended VBT
 support
To: Jan Beulich <jbeulich@suse.com>, Chuck Zmudzinski <brchuckz@netscape.net>
Cc: qemu-devel@nongnu.org, Andrew Cooper <andrew.cooper3@citrix.com>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger@xenproject.org>,
 Teddy Astie <teddy.astie@vates.tech>, Tomita Moeko <tomitamoeko@gmail.com>,
 xen-devel@lists.xenproject.org
References: <20260802050824.10554-1-brchuckz.ref@aol.com>
 <20260802050824.10554-1-brchuckz@aol.com>
 <2110d4b7-ae37-47aa-99be-ab59e16f6167@suse.com>
 <67579eba-e222-41dd-84bf-8440d2eaf2a9@netscape.net>
 <da2200cd-def7-4cce-a6c2-9f9ac9e202ce@suse.com>
Content-Language: en-US
From: Chuck Zmudzinski <brchuckz@aol.com>
In-Reply-To: <da2200cd-def7-4cce-a6c2-9f9ac9e202ce@suse.com>
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

On 8/14/2026 3:35 AM, Jan Beulich wrote:
> On 14.08.2026 02:45, Chuck Zmudzinski wrote:
>> On 8/13/2026 6:35 AM, Jan Beulich wrote:
>>> On 02.08.2026 07:08, Chuck Zmudzinski wrote:
>>>> -- snip --
>>>> To address this problem, this patch implements support for
>>>> Intel IGD devices with an extended VBT and OpRegion version 2
>>>> and higher which is required for most modern Intel IGD devices.
>>>
>>> First of all: Where's the spec of all of this?
>> 
>> Well, your first question is quite provocative. Certainly more
>> social/legal than technical.
> 
> Well, it was very much meant to be technical. I've had a hard time following
> what your new code does, and having a spec to hand would likely have helped.

I agree that having the spec at hand would be better. To be more precise, I
can say that what this patch essentially does is port the support for
the extended VBT with OpRegion 2+ for the Intel IGD passthrough that exists
in KVM/vfio to Xen. Should I explicitly say in the title of the commit
message that this is a port of KVM/vfio support for extended VBT to Xen?

> 
>> I presume by "all this" you mean code in this patch such as:
>> 
>> #define IGD_OPREGION_RVDA 0x3ba
>> #define IGD_OPREGION_RVDS 0x3c2
>> #define IGD_OPREGION_VERSION 0x16
>> 
>> which defines the offsets of the rvda, rvds, and version fields from
>> the base address of the Intel OpRegion.
>> 
>> Also, I presume that "all this" includes the meaning of the 8-byte
>> rvda value, the meaning of the 4-byte rvds value, and the meaning of
>> the 2-byte version value.
> 
> "All this" certainly goes beyond this, i.e. also covering the intended
> interactions.
> 
>> So my answer is as follows:
>> 
>> I do not have access to the official spec that defines "all this" but
>> I do have access, as does the general public, to the Linux kernel's
>> implementation of support for the Intel IGD from many sources such as
>> git.kernel.org. The Linux kernel has enough accurate information about
>> the spec of "all this" to provide very good support for the Intel IGD
>> on bare metal.
>> 
>> To elaborate a bit more, the spec of "all this" can be derived from the
>> Linux kernel code that supports the Intel IGD.
> 
> So you expect every reader to locate and decipher the underlying information
> from a (afaik) pretty large piece of code in the Linux kernel? If the Linux
> kernel sources are the reference, please can you at least provide pointers
> into there?

No, I do not expect every reader to decipher the underlying information...

That is why I provided these two links at the bottom of the commit message.
Perhaps you did not notice them:

Link: https://lore.kernel.org/kvm/20211012124855.52463-1-colin.xu@gmail.com/
Link: https://lore.kernel.org/kvm/20210325170953.24549-1-fred.gao@intel.com/

They are the patches to the vfio kernel driver that added support for the
extended VBT for KVM/vfio guests. I could provide links to more patches, such
as the ones in Qemu, Seabios, and patches provided by Intel to support extended
VBT in builds of OVMF for the Qemu/KVM platform, but I thought the two patches
above are sufficient for the purpose of this patch. For example, in those patches,
the #defines I added to config.h in hvmloader are included in the two links
I added to the bottom of the commit message.

I think adding more patches to the commit message would make it more difficult to
decipher the essential information needed to do this port of support from KVM/vfio
to Xen. Those two patches are not so large and they do provide the information
needed to add support for the extended VBT on a virtualization platform such
as KVM or Xen. How best to implement such support for the current Xen platform
is what we should focus on in these discussion.

> 
>>>> --- a/tools/firmware/hvmloader/config.h
>>>> +++ b/tools/firmware/hvmloader/config.h
>>>> -- snip -- 
>>>>  #define PAGE_SHIFT 12
>>>>  #define PAGE_SIZE  (1ul << PAGE_SHIFT)
>>>> +#define tools/hvmloader/pci.c3
>>>> +#define IGD_OPREGION_SIZE ((IGD_OPREGION_PAGES - 1) << PAGE_SHIFT)
>>>
>>> This is odd, and hence wants a comment.
>> 
>> Yes, I could add a comment, probably a long one, to explain this
>> oddity. It is a problem of backward compatibility where we have a
>> definition, IGD_OPREGION_PAGES, that is currently set to 3 both here
>> in hvmloader and in the Qemu DM, but should be 2 because the OpRegion
>> size is really exactly two pages but the current implementation set it
>> to 3 because the host OpRegion is not always aligned on a 4k page
>> boundary so three pages are needed to map the entire host OpRegion to
>> the guest. I could re-write the patch setting IGD_OPREGION_PAGES to 2
>> and avoid a comment here, but that would complicate the logic of how
>> igd_opregion_e820_pages is calculated and probably introduce the need
>> for comments in other places. 
>> 
>> I am open to suggestions about how best to handle the backward compatibility
>> problem and the problem of ensuring compatibility between hvmloader support
>> for Intel IGD passthrough and DM support for that same feature. For now,
>> however, I am trying to keep what is applicable to the current implementation,
>> and this odd value of 3 for IGD_OPREGION_PAGES is one of those things
>> I am keeping for backward compatibility.
> 
> Personally I don't view breaking backward compatibility as an option. Hence
> a comment is going to be needed, and preferably not an overly long one.

OK.

> 
>>>> +#define IGD_OPREGION_RVDA 0x3ba
>>>> +#define IGD_OPREGION_RVDS 0x3c2
>>>> +#define IGD_OPREGION_VERSION 0x16
>>>> +#define IGD_OPREGION_MASK 0xfff
>>>> +#define IGD_OPREGION2_SUPPORT_MASK 0x1
>>>> +#define IGD_OPREGION_SIGNATURE "IntelGraphicsMem"
>>>> +#define IGD_VBT_SIGNATURE "$VBT"
>>>> +extern unsigned long igd_opregion_pgbase;
>>>> +extern uint32_t igd_opregion_e820_pages;
>>>> +void intel_opregion_setup(uint32_t vga_devfn);
>>>
>>> Blank lines please ahead of the new #define-s you add and between those new
>>> #define-s and the new decls.
>>>
>>> For igd_opregion_e820_pages I further cannot spot any use which would justify
>>> the use of a fixed-width type; unsigned int will do, and will then be in line
>>> with ./CODING_STYLE.
>> 
>> Ok I will pay more attention to CODING_STYLE. I know that libxl
>> has a specific CODING_STYLE document. Is there a specific one
>> for hvmloader? I do not see one in the tools/firmware/hvmloader
>> directory. I assume the one that matters for hvmloader is the
>> one at the top level of the Xen code source tree, not the libxl one.
> 
> Yes, hvmloader follows (better: ought to follow) hypervisor style.

OK.

> 
> 
>>>> --- /dev/null
>>>> +++ b/tools/firmware/hvmloader/intel_opregion.c
>>>> @@ -0,0 +1,297 @@
>>>> +/*
>>>> + * intel_opregion.c: HVM Intel OpRegion setup.
>>>> + *
>>>> + * Leendert van Doorn, leendert@watson.ibm.com
>>>> + * Copyright (c) 2005, International Business Machines Corporation.
>>>> + *
>>>> + * Copyright (c) 2006, Keir Fraser, XenSource Inc.
>>>
>>> What do these cover?
>> 
>> I am considering this new file to be a modified/derived version of
>> tools/hvmloader/pci.c, so if I understand correctly this file needs
>> to retain the copyright information of tools/hvmloader/pci.c. At the
>> very least, the #include statements at the top of this new file which
>> are from tools/hvmloader/pci.c are covered by these copyrights. I also
>> consider the statements that are moved from tools/hvmloader/pci.c to
>> this new file to be covered by these copyrights. IANAL, so to be safe,
>> I include these copyrights even though the covered code is relatively
>> small compared to the rest of the file.
> 
> Nowadays our preferred option is to omit such copyright statements
> altogether, but we wouldn't insist on the omission. I further don't think
> #include-s are copyrightable.

Ok.

> 
>>>> +    static unsigned long rvda_host;
>>>> +    static unsigned long rvda_guest;
>>>
>>> Why static? The function can't be called more than once, if I'm not mistaken.
>> 
>> I think you are right that we only do the setup once so I will
>> drop static here. I still think if I drop static I will want to
>> initialize these to zero later, because (correct me if I am wrong)
>> only static variables are initialized to zero if not explicitly
>> initialized, and without either static or an initialized value,
>> these would be initialized to some undetermined random value
>> until explicitly set to the desired initial value. Of the two,
>> I think that the more important one to intitialize to zero is
>> rvda_host, because I use an initial value of zero for that variable
>> to test for the case when we do not need extended VBT support.
> 
> Well, like all variables, these ones also will need to be sensibly
> initialized. That's entirely unrelated to the use of static; all
> static gets you in this regard is that there's implicit default
> initialization. Yet that alone is no reason to use static.

Ok.

> 
>>>> +    igd_opregion_pgbase = mem_hole_alloc(IGD_OPREGION_PAGES);
>>>> +    /*
>>>> +     * Tentative value for the number of pages to reserve
>>>> +     * in the E820 map for the OpRegion and VBT.
>>>> +     *
>>>> +     * This will be the final value for the E820 map if
>>>> +     * the device model lacks support for OpRegion 2 or
>>>> +     * if the host OpRegion version is < 2 or if we never
>>>> +     * allocate more pages in the E820 map for the VBT.
>>>> +     */
>>>> +    igd_opregion_e820_pages = IGD_OPREGION_PAGES;
>>>> +
>>>> +    /*
>>>> +     * Read the value the device model is initialized with.
>>>> +     * If the device model supports OpRegion 2, it will
>>>> +     * return the host IGD OpRegion address. If not, it
>>>> +     * will return 0. If the device model does not support
>>>> +     * OpRegion 2, the device model expects us to give it
>>>> +     * the address to which it will map the OpRegion in the
>>>> +     * guest and then expects us to do nothing more to setup
>>>> +     * the OpRegion, so that is all we will do in that case.
>>>> +     */
>>>
>>> Hmm, exposing the host opregion to a guest certainly feels like an issue.
>> 
>> Well, that is how it is now. I am only retaining it to maintain backward
>> compatiblily with DM versions that do not support the extended VBT and
>> OpRegion 2+. My previous comment about backward compatibilty and DM
>> compatibility also applies here. If we don't worry about that, we can do
>> away with any cases where we are permanently mapping the host opregion to
>> the guest and implement this new approach of always exposing a copy of
>> the OpRegion and VBT to the guest instead.
> 
> How does "permanently mapping" matter? hvmloader runs inside the guest, so
> exposure just to copy the data isn't any better in terms of this being a
> layering violation. The more correct thing to do might be for the DM to
> put in place a copy before the guest (i.e. hvmloader) even gains control.
> (How in turn the DM would learn of the contents of the opregion is a
> separate question then.)

OK.

> 
>>>> +    const uint32_t igd_host_opregion = pci_readl(vga_devfn,
>>>> +                                                 PCI_INTEL_OPREGION);
>>>> +    if ( !igd_host_opregion ) {
>>>
>>> Nit (style) Brace placement (throughout).
>> 
>> Ok. I see this is not the proper coding style.
>> 
>>>
>>>> +        printf("device model lacks extended VBT "
>>>> +               "support. Continuing with legacy support only\n");
>>>
>>> This message can easily confuse / worry people. (If it was to be kept, it
>>> would also need style adjustment.)
>> 
>> I think some message is needed here to indicate the incompatibility of
>> versions of the DM that do not support the extended VBT with versions
>> of hvmloader that do, especially if we are not going to worry as much
>> about the backward compatibility / DM compatibility problem I mentioned
>> multiple times in previous comments above.
>> 
>> This message could encourage upgrading the DM to a version that supports
>> the extended VBT instead of just giving this scary notification.
> 
> But someone expecting legacy behavior could be misguided by the message
> (e.g. into wondering whether there's something wrong.)

It may take a while to arrive at what exactly the message should say here.
I will think about it and propose what seems reasonable in the next version.

> 
>>>> +    const uint32_t igd_host_opregion_page_offset =
>>>> +                   igd_host_opregion & IGD_OPREGION_MASK;
>>>
>>> I think like in the hypervisor we don't want to mix declarations and
>>> statements just yet.
>> 
>> The only way I could separate the declaration from the statement would be
>> to drop the const modifier because if I do:
>> 
>>     const uint32_t igd_host_opregion_page_offset;
>> ...
>>     igd_host_opregion_page_offset = igd_host_opregion &
>>                                     IGD_OPREGION_MASK;
>> 
>> The compiler will report an error. If I drop the const modifier from
>> the declaration, the compiler will not report an error but I lose the
>> protection the compiler gives me from making mistakes by modifying a
>> variable's value that should be constant.
>> 
>> I am not a C guru but some research indicates that while it is legal in
>> C to declare a variable with the const modifier without also assigning
>> it a value at the same time with a statement, it is not recommended to
>> do this because the variable will be initialized with some undefined
>> random value that cannot be changed because we used the const modifier
>> in the declaration. This implies strict enforcemnt of the rule "we
>> don't mix declarations and statements" results also in the corollary
>> rule "we never use the const modifier for variables in C."
> 
> Indeed we rarely use const on variables (or parameters) themselves. It's
> primary use is on pointed-to types.

Ok.

> 
>>>> +    pci_writel(vga_devfn, PCI_INTEL_OPREGION,
>>>> +               (igd_opregion_pgbase << PAGE_SHIFT) |
>>>> +                IGD_OPREGION2_SUPPORT_MASK);
>>>
>>> This looks to imply qemu is the only possible device model.
>> 
>> Yeah, this is an issue. Other device models that intend to support
>> the Intel IGD with hvmloader will also have to be compatible with this.
>> It would be easier if we did not have to worry about backward
>> compatibility and supporting what we had in the codebase for many years
>> in both hvmloader and Qemu and we would not need IGD_OPREGION2_SUPPORT_MASK
>> in that case. Instead, we would just completely deprecate all previous
>> implementations of the Intel IGD passthrough feature in both hvmloader and
>> the Qemu DM as unsupported. So my previous comments about backward
>> compatibility apply here again.
> 
> As said, I don't think backward compatibility can be dropped. My comment
> also didn't really mean to hint in that direction. Instead I was wondering
> in how far, even if perhaps by only a few #define-s, the necessary
> interfacing couldn't be put down in a public header, for any DM to consume.

Ok. Perhaps the IGD_* defines could be moved to a public header to define the
interface to be used to support the Intel IGD. Would it be OK to move those
to a separate igd.h header and include it in hvmloader/config.h?

> 
>>>> +    printf("guest OpRegion tentative "
>>>> +           "address: 0x%x\n", igd_guest_opregion);
>>>> +
>>>> +    if ( !verify_opregion(igd_guest_opregion) ) {
>>>> +        printf("error: IGD OpRegion signature "
>>>> +               "not found.\n");
>>>
>>> No full stop in messages please.
>> 
>> Would it be OK to just get rid of the error message here?
> 
> That would then leave ...
> 
>>>> +        BUG();
> 
> ... an un-annotated BUG(), which generally isn't very nice.

I don't think I understand what you mean by "No full stop in messages..."

We have code like this in hvmloader/e820.c:

    if ( rc || !nr_entries )
    {
        printf("Get guest memory maps[%d] failed. (%d)\n", nr_entries, rc);
        BUG();
    }

> 
>>>> +    }
>>>> +   --snip --
>>>> +        rvda_host = 0;
>>>> +    }
>>>> +    const uint32_t rvda_host_page_offset = rvda_host &
>>>> +                                           IGD_OPREGION_MASK;
>>>
>>> Why host_page_offset here when ...
>>>
>>>> +    const uint32_t rvds = *(uint32_t *)(opregion_scratch +
>>>> +                                        IGD_OPREGION_RVDS);
>>>> +    const uint32_t rvds_page_offset = rvds & IGD_OPREGION_MASK;
>>>
>>> ... it's just page_offset here, and when further you use it below to set
>>> rvda_guest?
>> 
>> The size of the VBT, rvds, is the same on both host and guest, so we do not
>> need to specify host or guest, but the base address of the VBT, rvda, is
>> not the same on the guest as it is on the host, so we need to specify which
>> one for rvda. I can change this to rvds_host_page_offset because it is
>> not wrong, but it might be confusing because I use that value later on
>> for computations involving the guest also.
> 
> Why not simply drop the "host" infix, when it's not relevant?

Ok.

> 
>>>> +    printf("VBT size: 0x%x\n", rvds);
>>>> +
>>>> +    if ( !rvds || !rvda_host ) {
>>>> +        printf("guest OpRegion address: 0x%x\n", igd_guest_opregion);
>>>> +        rvda_host = 0;
>>>> +    }
>>>> +    /*
>>>> +     * Write rvda_host as 2 successive 32-bit values
>>>> +     * to communicate location of the VBT to the device
>>>> +     * model. If rvda_host is not 0, The device model
>>>> +     * unmaps the OpRegion and eventually maps the VBT
>>>> +     * after we also write the guest address where the
>>>> +     * VBT will be mapped.
>>>> +     *
>>>> +     * If we send rvda_host = 0 to the device model, it
>>>> +     * will assume we do not need OpRegion 2 support and
>>>> +     * it will not unmap the OpRegion.
>>>> +     */
>>>> +    pci_writel(vga_devfn, PCI_INTEL_OPREGION,
>>>> +               (uint32_t)(rvda_host & 0xfffffffful));
>>>> +    unsigned long rvda_host_upper_32 = (uint64_t)rvda_host >> 32;
>>>> +    pci_writel(vga_devfn, PCI_INTEL_OPREGION,
>>>> +               (uint32_t)rvda_host_upper_32);
>>>
>>> Why would you need to communicate a host property to the DM?
>> 
>> The DM cannot access the host rvda value because it is only accessible
>> from the host kernel, and the DM is only a user-space process on the host.
> 
> I don't follow this: Anything the guest can access should also be accessible
> by its DM.

I think the host OpRegion is not currently accessible by the DM. On the KVM
platform, this is made possible via the kernel vfio driver and then Qemu exposes
the OpRegion to the guest using the Qemu FwCfg device interface. How should we make
the OpRegion and VBT accessible to the device model and then, to the guest, on Xen?
I think it could be done via the xen-pciback kernel driver. Should we do that
instead? I think to do that we would have to convince the kernel developers that
the Intel OpRegion, as you say, "should" be accessible by the Xen device model.
I can imagine them saying, why not use the vfio driver?

Teddy Astie, on the Cc: list for this patch, is actually working on this:

https://xcp-ng.org/blog/2024/04/18/iommu-paravirtualization-for-xen/

These decisions about the best approach to support the Intel IDG on Xen are
above my pay grade, obviously. I need some guidance here, please.

> 
>>>> +    /*
>>>> +     * Update the number of pages the device model
>>>> +     * needs to map for us to get a copy of the VBT.
>>>> +     *
>>>> +     * N.B.: Here, igd_opregion_pgbase is really the page
>>>> +     * base of the location where the device model will
>>>> +     * map the VBT.
>>>> +     */
>>>> +    uint32_t vbt_pages_needed = rvds >> PAGE_SHIFT;
>>>> +    if ( rvds & IGD_OPREGION_MASK )
>>>> +        vbt_pages_needed++;
>>>> +    if ( vbt_pages_needed > igd_opregion_e820_pages ) {
>>>> +        igd_opregion_pgbase = mem_hole_alloc
>>>> +                              (vbt_pages_needed - igd_opregion_e820_pages);
>>>
>>> Nit: Indentation.
>> 
>> Ok. It should always be a multiple of four spaces, I presume. I admit I did
>> not check that.
> 
> Not quite. Within a wrapped expression, you need to determine what I like
> to call the "anchor point". In a function call that's the start of the
> function name. The wrapped part of the expression would then start one
> extra level (4 spaces) deeper than the anchor point. Things are different
> when there are pending open parentheses: There the wrapped part of an
> expression starts with as many extra spaces as there are pending open
> parentheses, with the outermost pending open parenthesis being the anchor
> point. E.g. (taking the example above and adding extra wrapping in the
> function argument expression just for demonstration purposes):
> 
>         igd_opregion_pgbase = mem_hole_alloc
>                                   (vbt_pages_needed -
>                                    igd_opregion_e820_pages);
> 
> Or alternatively
> 
>         igd_opregion_pgbase =
>             mem_hole_alloc(vbt_pages_needed - igd_opregion_e820_pages);

Ok.

Thanks,

Chuck

> 
> Jan


