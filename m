Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E43EC5DF86
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 12:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwf86-0007Dx-Hf; Wed, 19 Aug 2026 08:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wwf84-0007Db-S8
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 08:10:48 -0400
Received: from sonic304-24.consmr.mail.gq1.yahoo.com ([98.137.68.205])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wwf82-0000P6-AA
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 08:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1787141442; bh=fQPOdOsF7VLzOoXGlPvMjMuPS4+j5ip1AlTMsRA9OX8=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From:Subject:Reply-To;
 b=c2T1CmTnZwk0QPjYhKDqmt2CxYxh4A4LGTsw2zOGgkcZPuasFq3l3AOmbVZZK2FVeaiNmKTaJ07eayK+SQ3nA4V6J+EMCo10Aaco0PMbj9fcugfWl63XjJPA6R1h2J/nWMSh6hdkHW7HPaxNqeJvrmCM4/3SCmtLvdV4Q2YLxprQuUip86aMEhD0RJRun7awdCIuxOm099RmDhStHql+Y6bQUhQ2EzAP61HYr5b5GeBqyTxwei0W/zerxFDlkOlDcVKBtR5nNNfvbjH+qfJ55DVwTE976Bgivrd6tpiVFWkF7qdUcpEU94BsuzRADtoaAOCToYXCElrmXY6o3GsMRw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787141442; bh=/XDTVlVGNJfBHN5HwLVyLYJ5ur/xhq9Iv0e9z/T4vMk=;
 h=X-Sonic-MF:Date:Subject:From:To:From:Subject;
 b=uUHDY/w9aSG0+UBCR2ASot1d2Vp69yrA3WS0pfvzhq8aj3ZCE14dC46FbbsgzqSP/IrxFfZWJgf0E3uX+y0QFFf3kEMu80VXI6z2w60pAIjfTgVrrkIwnaVOMzQQGuLJ6MUjZEdXteEb734F9JQIXOR9u/uDaMD4ogGw41xDjWOLLKFSbvwnLYkhM5+RToiOAa7ZbYES/AcF8tr+UcBtaqq7bT7hMcqaaC9GmUBS26fRT7HHiKtTRspquWhYicV5aofC8p5pwrvwPfwr7nbP8+erA58ZnsoSy8/Lj6Uas3UYbzO5xp/aB/WwX/HZOAd1g5F1ngjCgX6Q10R/3VrH/w==
X-YMail-OSG: jdaRoe4VM1lFa1atrVrdAGXP8_khn7C2lNiVoRmqTjcZRAlT1yPjrnQmK734jJy
 3bXi0Wr2OHI6k6eCOKm897TuXgtW3hR_HR4h6YL8jYj_arE5qrKx.fcFKfWz9GyqntKuwaGwYqtX
 73tsurDZVYaL4MHMW3xplnPVMCTi.Vf85g0dSs_i9_STaWxJnmMQAxVyE63HA0naR0hzv9BPRw9W
 6Zo_vpW5nBXSw4tFT3XPP5m5YnUtE9TM.jCkv7x5jrLZtCXdktRXWwta5kRceM.AotNTF8JA_ETB
 NtLHVgDtF8ADugYERCOCOP8INnSrvdvUEDqQgz7LAt95CGCvXU5m0TCH6tfrXTauTmMutt6q2YFb
 v91VhxYu4TU.Lii3gh5685OMVK08W6.8GAma9GvGJ83f4ZNy9KyMX3NTQceq5ixwpyqh1bz5Nru_
 S.dvyE5JC9RJrrDs9fck7WR6GqNcrFRxbs1VFPmzV72Hq1LMR.I0dB6IShL_7g3v5nDzrvNcbbfs
 R8rWukEGavlyH90UFOUi5FrA8CSgKWtrEUDcH7zQvgDql0G13FWPxOLi7qmiYiFoFlSKC5c9agXx
 sYxKmeySg6pv1e2a6YxdSXJBsNhiu8ZI3766pn6eAoXb1xOtZGzmqnXL.GxLe9hI41Mhr3Nrn6sq
 4ndVsnHMkrcbmPYqsVyoqBVzYebK1R8qfwRXhCDuINpffKPF0xjsSRrAK3Emy.VWM9PqdcSBCJdx
 AmPpmgEO0f_fNzCmEPNN_mTTgInad0AfuhaU6kQzJVedAAAmYngBBMvdp8gjXFsp6dlnKXLmYn_b
 WFgOk6USmNGhZsY5j4a9.1bQ.rSlijQ6BP2lgQWL0br4wnPO.UyGrKQ5WL0jFKU.wLkQ05P4exlR
 jD.5S2wHaK4aJ74tJuzlbYeZiezJDHvyb0ACv3aheZ75dh3JTaH.pcHk_YcM63s.oXFAjiusWDx8
 bcbl7.N7QQzTuiy9snDke2KJOt1yR.WpAhVjxd9iEkpX7qC1eT6AuXL1Tpc3tOtDc6A5UTtXN9Ra
 V8oBJ7q1ZGIJsPzvmVWg9BH9F_ntcEaEMfl2OibN8D1oCGfi_jDKaSWwd3DAYaXYO1eycTbpBsLH
 1WEOJzjUmZEWwYAwWakIpEhbQpuYnvYBxUhVMFsXxbnmHtPxAcdsZeggnS3TlG9s_QySt6DCIVKV
 uw8UCP3IhuQKGaLcW5G5GSx1AkBPO9qRmBvf1uQLtaysmiV6RptkNzdiKNYTIeV7rSW7n2jX_n3h
 gJ9qUgidQZHxHBJj0l3BE1YkFM2pmnN_xoPxg2CAsNEHFfLeD67uTclD0rgTNaafQNjXen0D0xx.
 dTMybE7ZBp2sOS6M9BXB_iyA9ATvd.e0gwkwSAhP_MESlv_lKg6UuzQnhV6g_rP6Gp17SpZXXQxy
 _gUtOJUf5CuR9uSUG6JQYxXEbDVC0uY4RKT6eO6O4mv6ww7YHPpdp1BmbmwzA5Z_pgG4SHa_lTHp
 NayMaLMD0SsS1ie4SkSIobvbZZVgVwhAHkEowy7T_g34.OdS9Lry2QJlCwmdsjQPKLmGD2H5L5eA
 HpV3WCugYx4d34aXcHEBCzoFeSctLQlaQ_rHGkgMTnTAHsV9T_5l78QiDtpM.3zyC9PjLi9ACgde
 pBuLveKSiagzwteppdGl9eo5bgyOUTgUwZ_vGhlboFgOHfNGa7LIdcNNQS6zeTKpRILIcAy.H9wF
 r4BAP8dHyPxC9R6SUFy.mJDs29rvQzaiOVYeot_DN8Zng2LRemidtm5QSvSZASWKfArBfsNBBBKe
 7Dfy5ivmFIGRGzRvr5KDuLI0CCZkI_DaJKXVGcEnNiIKRzzoxJ13cdoTtpbT_m8F5D44a0SkR.3E
 JLwccXixIuwA4YeRwDy4_yW28.5Tvttmf11HUNd6rBr7svvtA2hDBaXpXnUIC6DAZ2J6y.7KvTGr
 hCYaDHI2BcFgMor7WmBHXyupwACmqMjmfJ5lK8iEn1LTOMswnG95R7P_iehcYCWloTsn55Os7BKC
 vrRj0N0eS3EW6PoTPizjk2_bbReqd6czsJx_0v98azF327LX0w9nRd.UQoLoJ5M0bmKiVq1qZ1tt
 zB4O5Os_7rL_jYvgsxo2Z8LLyeG0S7v2uyU7kjcoCfoWjYcsEJRxfS7MZ.mCzD3xuC1_9aHT5RMc
 NG5SCpLNXG_Nl8EVaBPyIBPM58Xcj.YvQ08xE14b4s6GHdDd2TP9TmCIXD4pix4_11XE.0c59t7a
 XJAwBUPw0zDcAkPUyZfknBdaiM7_pz93G6aEPKA22.6fV
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: 3fbe1c6f-0ebe-4df9-9310-2351d8ac13c6
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic304.consmr.mail.gq1.yahoo.com with HTTP; Wed, 19 Aug 2026 12:10:42 +0000
Received: by hermes--production-bf1-54b5569bdc-bl9f6 (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID fc9d868b60d516231b4456f7cd23fd55; 
 Wed, 19 Aug 2026 12:10:36 +0000 (UTC)
Message-ID: <e750110e-13f8-427d-b93e-08c49ab3550e@aol.com>
Date: Wed, 19 Aug 2026 08:10:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tools/hvmloader: implement Intel IGD extended VBT
 support
From: Chuck Zmudzinski <brchuckz@aol.com>
To: Jan Beulich <jbeulich@suse.com>
Cc: qemu-devel@nongnu.org, Andrew Cooper <andrew.cooper3@citrix.com>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger@xenproject.org>,
 Teddy Astie <teddy.astie@vates.tech>, Tomita Moeko <tomitamoeko@gmail.com>,
 xen-devel <xen-devel@lists.xenproject.org>
References: <20260802050824.10554-1-brchuckz.ref@aol.com>
 <20260802050824.10554-1-brchuckz@aol.com>
 <2110d4b7-ae37-47aa-99be-ab59e16f6167@suse.com>
 <67579eba-e222-41dd-84bf-8440d2eaf2a9@netscape.net>
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
Content-Language: en-US
In-Reply-To: <db8fd04d-bbc7-41c7-8473-b821d7f77d5f@aol.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26254
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
Received-SPF: pass client-ip=98.137.68.205; envelope-from=brchuckz@aol.com;
 helo=sonic304-24.consmr.mail.gq1.yahoo.com
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

On 8/18/2026 1:15 PM, Chuck Zmudzinski wrote:
> On 8/18/2026 8:29 AM, Chuck Zmudzinski wrote:
>> On 8/18/2026 8:18 AM, Jan Beulich wrote:
>>> On 18.08.2026 13:52, Chuck Zmudzinski wrote:
>>>> On 8/18/2026 3:17 AM, Jan Beulich wrote:
>>>>> On 17.08.2026 18:04, Chuck Zmudzinski wrote:
>>>>>> On 8/17/2026 4:42 AM, Jan Beulich wrote:
>>>>>>> On 14.08.2026 17:23, Chuck Zmudzinski wrote:
>>>>>>>> On 8/14/2026 9:46 AM, Jan Beulich wrote:
>>>>>>>>> On 14.08.2026 15:18, Chuck Zmudzinski wrote:
>>>>>>>>>> On 8/14/2026 3:35 AM, Jan Beulich wrote:
>>>>>>>>>>> On 14.08.2026 02:45, Chuck Zmudzinski wrote:
>>>>>>>>>>>> On 8/13/2026 6:35 AM, Jan Beulich wrote:
>>>>>>>>>>>>> On 02.08.2026 07:08, Chuck Zmudzinski wrote:
>>>>>>>>>>>>>> -- snip --
>>>>>>>>>>>>>> +    /*
>>>>>>>>>>>>>> +     * Write rvda_host as 2 successive 32-bit values
>>>>>>>>>>>>>> +     * to communicate location of the VBT to the device
>>>>>>>>>>>>>> +     * model. If rvda_host is not 0, The device model
>>>>>>>>>>>>>> +     * unmaps the OpRegion and eventually maps the VBT
>>>>>>>>>>>>>> +     * after we also write the guest address where the
>>>>>>>>>>>>>> +     * VBT will be mapped.
>>>>>>>>>>>>>> +     *
>>>>>>>>>>>>>> +     * If we send rvda_host = 0 to the device model, it
>>>>>>>>>>>>>> +     * will assume we do not need OpRegion 2 support and
>>>>>>>>>>>>>> +     * it will not unmap the OpRegion.
>>>>>>>>>>>>>> +     */
>>>>>>>>>>>>>> +    pci_writel(vga_devfn, PCI_INTEL_OPREGION,
>>>>>>>>>>>>>> +               (uint32_t)(rvda_host & 0xfffffffful));
>>>>>>>>>>>>>> +    unsigned long rvda_host_upper_32 = (uint64_t)rvda_host >> 32;
>>>>>>>>>>>>>> +    pci_writel(vga_devfn, PCI_INTEL_OPREGION,
>>>>>>>>>>>>>> +               (uint32_t)rvda_host_upper_32);
>>>>>>>>>>>>>
>>>>>>>>>>>>> Why would you need to communicate a host property to the DM?
>>>>>>>>>>>>
>>>>>>>>>>>> The DM cannot access the host rvda value because it is only accessible
>>>>>>>>>>>> from the host kernel, and the DM is only a user-space process on the host.
>>>>>>>>>>>
>>>>>>>>>>> I don't follow this: Anything the guest can access should also be accessible
>>>>>>>>>>> by its DM.
>>>>>>>>>>
>>>>>>>>>> I think the host OpRegion is not currently accessible by the DM.
>>>>>>>>>
>>>>>>>>> Can you explain to me how the region becomes accessible to the guest?
>>>>>>>>> That would then (hopefully) help me understand why the DM would not have
>>>>>>>>> access. Fundamentally any MMIO and any I/O ports that are assigned to a
>>>>>>>>> guest are also assigned to its DM.
>>>>>>>>
>>>>>>>> Currently, in the device model (Qemu) we have:
>>>>>>>>
>>>>>>>>     ret = xc_domain_memory_mapping(xen_xc, xen_domid,
>>>>>>>>             (unsigned long)(igd_guest_opregion >> XC_PAGE_SHIFT),
>>>>>>>>             (unsigned long)(igd_host_opregion >> XC_PAGE_SHIFT),
>>>>>>>>             XEN_PCI_INTEL_OPREGION_PAGES,
>>>>>>>>             DPCI_ADD_MAPPING);
>>>>>>>>
>>>>>>>> That statement is in the igd_write_opregion(...) function in the
>>>>>>>> hw/xen/xen_pt_graphics.c file of the upstream Qemu source.
>>>>>>>>
>>>>>>>> If I understand our current implementation correctly, this statement
>>>>>>>> is what gives the guest access to the host OpRegion (3 pages as defined
>>>>>>>> by XEN_PCI_INTEL_OPREGION_PAGES, and in agreement with IGD_OPREGION_PAGES
>>>>>>>> in hvmloader code).
>>>>>>>
>>>>>>> No, it introduces mappings of those pages into the guest's P2M.
>>>>>>>
>>>>>>>> I don't think this statement makes the host OpRegion
>>>>>>>> accessible to the device model, though, so I think, if I understand your
>>>>>>>> comment in an earlier about my patch resulting in what you called a "layering
>>>>>>>> violation" correctly, that our current implementation is also guilty of this
>>>>>>>> same kind of "layering violation."
>>>>>>>
>>>>>>> That code, if it can be successfully executed, indeed doesn't grant any
>>>>>>> permissions (to the DM or the guest). Instead it proves that the DM has the
>>>>>>> needed permissions to access the pages itself.
>>>>>>
>>>>>> So, are you saying it should be possible, without any patches to either Xen or
>>>>>> the Linux kernel, for Qemu to get a pointer to the OpRegion? If so, how?
>>>>>>
>>>>>> I think I could implement what you proposed in an earlier message and do
>>>>>> all (or most) of this in the DM instead of here in hvmloader:
>>>>>>
>>>>>>> The more correct thing to do might be for the DM to
>>>>>>> put in place a copy before the guest (i.e. hvmloader) even gains control.
>>>>>>> (How in turn the DM would learn of the contents of the opregion is a
>>>>>>> separate question then.)
>>>>>>
>>>>>> Actually, when I was developing this patch, I tried first to do it that
>>>>>> way, but the problem was, I could not find a way to get a pointer to the
>>>>>> host OpRegion in Qemu.
>>>>>>
>>>>>> So, how can I get a pointer to the host OpRegion in Qemu?
>>>>>
>>>>> You don't ask me this question, do you?
>>>> 
>>>> Are you offended I asked this question? If so, I am sorry. You make me
>>>> afraid to ask it again so I will not do so unless you permit to do so
>>>> again.
>>> 
>>> "Offended" is the wrong word; "very puzzled" may better get it. I'm not a
>>> qemu person, and I never have been. I can't really help much there.
>>> 
>>>> All I can say is that surely qemu
>>>>> has an existing way to map (host) physical memory; see e.g. how
>>>>> xen_pt_msix_init() (imo bogusly) maps the physical MSI-X table of a
>>>>> device. "Bogusly" there because that's another layering violation. Plus
>>>>> (independently) there and here there's the issue of how to accomplish
>>>>> things when not running in Dom0, or when running de-privileged in Dom0.
>>>> 
>>>> Well, that only proves Qemu *might* be able to access the MSI-X table of
>>>> a device, that is, if the calls to open /dev/mem and mmap it succeed.
>>>> Why is the MSI-X table all of the sudden relevant? Even if Qemu
>>>> can access the MSI-X table of some device, that does not prove that
>>>> Qemu can access the host OpRegion of an Intel IGD. So I think my point
>>>> still stands: I still don't see proof that it is possible for Qemu
>>>> to get a pointer to the host OpRegion without any patches to the current
>>>> implementations of Xen and the Linux kernel.
>>> 
>>> The MSI-X table (and it being accessible to qemu) is the best analogy I
>>> could come up with, as that's one tiny area of qemu that I know at least
>>> a little.
>>> 
>>> From a Xen perspective, this analogy should be sufficient: All you need
>>> from Xen is for it to permit to establish mappings of the underlying page.
>>> As I've pointed out when commenting on a code fragment you presented, the
>>> DM (domain) looks to have permission. Everything else is a matter of
>>> establishing such a mapping. There the MSI-X table code may also guide
>>> you. (Sadly it may also misguide you, since (a) I don't know whether it's
>>> appropriate to do things this way in qemu, and since (b) it is, as said,
>>> imo a layering violation.)
>> 
>> I agree that accessing the host /dev/mem directly is cringy. I would not
>> really want to do it that way for the host OpRegion.
> 
> I looked at the current mainline Linux kernel code about access to memory using
> /dev/mem and modern distros set CONFIG_STRICT_DEVMEM which forbids access to
> ordinary system RAM but allows access to what the kernel developers call
> non-kernel memory. Here is a quote from a comment in arch/x86/mm/init.c file
> in the Linux source code:
> 
>>  * On x86, access has to be given to the first megabyte of RAM because that
>>  * area traditionally contains BIOS code and data regions used by X, dosemu,
>>  * and similar apps. Since they map the entire memory range, the whole range
>>  * must be allowed (for mapping), but any areas that would otherwise be
>>  * disallowed are flagged as being "zero filled" instead of rejected.
>>  * Access has to be given to non-kernel-ram areas as well, these contain the
>>  * PCI mmio resources as well as potential bios/acpi data regions.
> 
> So I think things like the MSI-X table and the OpRegion would qualify for
> /dev/mem access even with CONFIG_STRICT_DEVMEM set, so after seeing this
> I expect I could get a pointer to the OpRegion running in Qemu using
> /dev/mem and mmap, as long as it is running in dom0 with root privileges.
> But as I said earlier, I agree that /dev/mem and mmap does not feel like
> the right way to do it.

Moreover, I tried accessing the OpRegion using /dev/mem and mmap using a
little C program, dumpmem, [1] I found but it does not work in either dom0
or in the guest when IGD is passed through to the guest: mmap returns
MAP_FAILED and reports the EPERM error: Operation not permitted. So it looks
like Qemu cannot access the OpRegion using mmap and /dev/mem with current
Linux kernels. So I am still skeptical that with current Linux kernel
implementation and its hardening mechanisms such as CONFIG_STRICT_DEVMEM, it
is not possible for Qemu to directly access the OpRegion without also adding a
patch to either Linux or Xen to provide access of OpRegion contents to Qemu. 

But the good news is I did find a way to dump the OpRegion to a file from
either dom0 or the guest when passed through, but in dom0 it works only before
xl makes the device assignable for passthrough and bound to xen-pciback, so that
is not so helpful since we need Qemu to access it when the IGD is assigned to
its guest and bound to the xen-pciback kernel driver.

Here is how I accessed the OpRegion from dom0 userland before xl assigns it
for Xen PCI passthrough:

Linux debugfs mentioned in the man page for IGT GPU tools [2] exposes the OpRegion:

https://manpages.debian.org/trixie/intel-gpu-tools/intel_vbt_decode.1.en.html

Here is how to dump the OpRegion contents to a file in the home directory:

user@dom0:~$ sudo cat /sys/kernel/debug/dri/0000:00:02.0/i915_opregion > ~/i915_opregion
user@dom0:~$ ls -l ~/i915_opregion
-rw-r--r--. 1 chuckz chuckz 8192 Aug 18 22:41 /home/chuckz/i915_opregion
user@dom0:~$

There it is, the 8k OpRegion dumped to a file.

This also works for the VBT:

user@dom0:~$ sudo cat /sys/kernel/debug/dri/0000:00:02.0/i915_vbt > ~/i915_vbt
user@dom0:~$ ls -l ~/i915_vbt
-rw-r--r--. 1 chuckz chuckz 8704 Aug 18 22:48 /home/chuckz/i915_vbt
user@dom0:~$

So now, with a copy of both the OpRegion and VBT, I can write and test
patches to hvmloader and Qemu using your approach of exposing a copy
and never mapping the host OpRegion to the guest and in that way avoid the
layering violation. The TODO is to find a way for Qemu to get a copy of
the OpRegion on the fly instead of only after the administrator places
a copy of it in the dom0 filesystem where Qemu can access it.

I think one way to make the OpRegion directly accessible to Qemu instead
of being accessible only after dumping it to a file and placing the dumped
file where Qemu can access it would be to provide a xen-intelgpuback kernel
driver whose job would be to make the OpRegion and VBT accessible to Qemu
when the device is assigned to a Xen HVM guest.

Chuck

[1] https://github.com/tchebb/memdump
[2] https://drm.pages.freedesktop.org/igt-gpu-tools/

