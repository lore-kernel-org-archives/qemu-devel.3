Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC40FC5DF6D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 12:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwfDM-0000OR-Ku; Wed, 19 Aug 2026 08:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wwfDL-0000O5-S2
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 08:16:15 -0400
Received: from sonic305-20.consmr.mail.gq1.yahoo.com ([98.137.64.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wwfDI-0001Kw-VC
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 08:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1787141770; bh=LRyWQBiH5+CH5bDb5wmPMyRE3/M8Fa6qNVzqk+Wy6xk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To;
 b=bSK2F/gCyntS8YvgAPgSQ0G55XkwzVeZJHLYHpIJrRyCWkvtY6lQhCHg44BIis/u7PpaOJ2/p+XoEwDWeVMZZOMX2Bo8x9q1zzyGS1YkctCCPgHwCLX7/OhqgHYlHXy60mL0MstYgJ9Po3lTAs8bcHSg/p1TDDgbsTHHMmn03MjrVHW/v3MiMK+9hTYSI9lUNuvpUJNSx4XM4eWJS3DVRwY1gR3IypuLH9IQAKx6TI3qKoF8Z+GCegj8awx8gGDU1pJQjlrIWomk8yzJgZiDQEGWl3K5emlXGTyQJxiSxj/jfZYAFvZXN1csNumVjpZofKcDdNcW8wARfxFVASp+wA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787141770; bh=wENHuOElFAE3RfXqFK8YOFRH1kgimdjxd5lC14xwnuR=;
 h=X-Sonic-MF:Date:Subject:To:From:From:Subject;
 b=eeNTZwrgz2EODgQmAay2DT/hwSIOXv60Duy37GQX+N/mGxgXsTDCdqkCrY5J7HnwBdjJ4mWaUB4rtDE8+i9lGpsLVLldeZ/I91i4pEe91Twi9c9fZObbfqjud2OVuAWYoPhpO7fGH/stQBArgZECu3oAcpv/w3kbckXDDURxKPt5f6TsfqcO0+sAFV8RuPLAo2Wbe7a3BhFtj/VK77y3sdG728qpjpMB2c4r2Nj6fKqqO1aiwFvHxwhs/qA0vMhT1zBC0ud0YJS1TM8b+fMUu6vFA6fkNr+oTs9mf9qh2YymwMMk33zk8k8iQiKIUFwj3AhqbaGUTEPhBvrYUtLt7A==
X-YMail-OSG: Q0BbGKYVM1kMHnHcQmlEGcWvJLp5lljiSLcbyeYvX15UOUspCsIw2ygpf6FglnN
 JQlip1UDynu.VoEsVQMmrQp3Ru5ZJHezw43BmcSGFgIGly50F.L2xskfDgLG2j0uDt3fx1QNCa._
 7_uZ5wNsHL0e7_bYTwWSW1dYxhb4Q_nGPFCXkRFIhw6u5o77EIF_i7yfUseiM7XapADGmm_U2sMi
 jWLy7oHXqWAGT7cMuhSyrAIVu3irs0EQ8RGiLQQP9Ap_hU41ZJ0uwHQv4MnTexLRSLfPrwhyKJCP
 aFMsLyaTKUbYvfrCrJ1b3CK0ykkFEkjbizjPPYBUqkhxEd1a4k_Z95g8Rf3ZTkOq1F8NtEl7PCe2
 flRnpBqCFpHfzq9gjrzGB_lKjH23sA5JANQJRei.Pj2UjN2drQnJ7m9oWzznNxBHhq6Nnknvj9Sq
 68V1w3Qm0OBBcFcj2NIif9lICkyXX1QwvSNgby6i1HcfR4NAgdc3bw7YvhpMDmFiBnJzY9o9JOxM
 pspBzkZ.SQROq1hE2bk8I._0Cv_9EdFrtcvesoQK8fxicH8F12Gdl36n4gxPTv_lZHbVp2SsWP9d
 Be0Rcre9oB10fl6Stvv5GDLj1msd4axR_hv5JufRE0Mde4pTnaNZ.JygSeWRb90AL7XGP0poFlU4
 a0ngha9A0UpxYs9ETDgY.SP27YfkHrbS3LI002DSXOxG7D0Dmzuapsy87KExyZC0XpJJYWES3Wbp
 03JyI7b.r5tzy9QovOFxIWhO5YcREsfcUajuneoa3ohslTAUoM7tRuX1xnB6u0KvPX08OZn29AKh
 wkcPAOqFT2GTaLdfX4OinFPI9Cn8P9gkawQtlSOPkGHNSR_0FHRdngrVZCUMUsOdldJ1S7pgQS_T
 8HbWXGGLzTl77jcSidqGWQ0tASkGsCqg3kaxVQkOAOIiQtCfGTi_c8Vbfk9ZICX6DfBarh81ek1l
 Vez.Pbn4Qv5qiZAPPMhs5CxdwKBcdI44cOIimnjpGwEYnzlHcfWPOx_K85Tdpy6LKFAsNS1XOTX3
 Zn4AtGSUpcLjxnqHnv7ozXo1jxV247XsAPtkW_URVjMfOqSdsFxKFDEzf12cC9kITGAaVXVibfWi
 hpn6Rz4lPzYdQUlgV8CFet0DALAvALUYt7UmDaYxufjhgdPiQySsoEhc7wh32jU3WjAjWFm1Lyk3
 xNMktLOsL1p_tQX0MNJeRrWSSekA9IMb63HX1W8yxWCzIi8cJreWkXE2kcj17kgbUk2ykFoApwXQ
 X4ZIHr6h6E8J4jqlbN9bbXcoLKEDPZyeaCvD10yIrsUZrbaADgTBKYZFREcpCxvlmhyukKnak1gc
 neUKMRjx5vyf_7BDWEy8NQa2tSmFXwTyLKZ9XmiLrr0M482YWLtttaXX3nryHDvd_KGPhyWP4ZBJ
 nylHuQ5ErzMosx4qKCW0vf2eKAhX9KnEaAcqIdsh.GRJPrwCPovfg7_tusxFrqYvguR0oDfmWrii
 mGGvCFpXVbuLHJW06ZPP.D5n0Vt0fm8IvFsnDAHOVWRdGxqpw24WPBRsnzt6eGv.Ii1SVncw6Q5X
 n49TVhSbaYp4itOUJnS7KBx_ttHrqKtNRT_xZM06AWJPcM6tp_N5hZ3F8d7PWT7m3y0krmUJbSns
 j_kLLyYmNgtADwJM71j__OwtRtr.XP9Zk4vHB01exPwVVhX1ZGqqkITie2a5ktUumXTp9CkzUSvP
 _h_JsUnhll1AG_UtqlpD9_KSTivKx9SjN8tawyoJN6.tZLql1G_.TjMN2FtFYmw9zo_wsfGRR3io
 33yehkgUP5AsXBoIgMz3CM0fWT.fnaklhPKXPt7O1S1msOqk4Qn5m3Tv2BpOcfnVg0ZbcuPyXiW5
 eCqY3eCcKaltO.spKNYysbNvxgPd.k16JuEUBkLUMPeoBpvl62YIivU5VFIOfbvsbMNJwA45xz8G
 _BtOfjUrBr8bSxRjli.itFa_hp91J6katRMglfUDeg2PZIcSQ922a1p6fDao5e0QlcYm8S8BSryN
 HDG51NrdH04TOHFt6PA8cBMFtrTR7zsna9bmR0LLR6IAMQWVVYj3lizdq9UGpjvjcxkXTaztoPMI
 gmnw4QLnJ3HEsj_poBAXzXf6IMstD7c.oI2E8BxbbWmF806OVIiqp9a25UAPJxHiQo1POw.jxs4p
 zWTtFFynAJGIBWmNVNvuzUdlP76vlvcHFqUxiVLHAOozqhXS9WfjgYNltN3x4GIrehFcPZUkkJPI
 cj3ot8OeBkus1QX09IYVQprFEElhBFg5wtvLxbVUgj0_mK_8-
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: 17daee9b-8285-43c5-91c6-181b53f8b45c
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic305.consmr.mail.gq1.yahoo.com with HTTP; Wed, 19 Aug 2026 12:16:10 +0000
Received: by hermes--production-bf1-54b5569bdc-6nq7v (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 55ce23ae771b45d3ef4426380501e0bb; 
 Wed, 19 Aug 2026 12:16:06 +0000 (UTC)
Message-ID: <cdae1785-4d9a-4aab-929e-de55c26b7b94@aol.com>
Date: Wed, 19 Aug 2026 08:16:06 -0400
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
 <302ed12f-40ca-405c-80ca-ac4f2785d754@suse.com>
Content-Language: en-US
From: Chuck Zmudzinski <brchuckz@aol.com>
In-Reply-To: <302ed12f-40ca-405c-80ca-ac4f2785d754@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26254
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
Received-SPF: pass client-ip=98.137.64.83; envelope-from=brchuckz@aol.com;
 helo=sonic305-20.consmr.mail.gq1.yahoo.com
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

On 8/19/2026 3:30 AM, Jan Beulich wrote:
> On 18.08.2026 19:15, Chuck Zmudzinski wrote:
>> On 8/18/2026 8:29 AM, Chuck Zmudzinski wrote:
>>> On 8/18/2026 8:18 AM, Jan Beulich wrote:
>>>> On 18.08.2026 13:52, Chuck Zmudzinski wrote:
>>>>> On 8/18/2026 3:17 AM, Jan Beulich wrote:
>>>>>> On 17.08.2026 18:04, Chuck Zmudzinski wrote:
>>>>>>> On 8/17/2026 4:42 AM, Jan Beulich wrote:
>>>>>>>> On 14.08.2026 17:23, Chuck Zmudzinski wrote:
>>>>>>>>> On 8/14/2026 9:46 AM, Jan Beulich wrote:
>>>>>>>>>> On 14.08.2026 15:18, Chuck Zmudzinski wrote:
>>>>>>>>>>> On 8/14/2026 3:35 AM, Jan Beulich wrote:
>>>>>>>>>>>> On 14.08.2026 02:45, Chuck Zmudzinski wrote:
>>>>>>>>>>>>> On 8/13/2026 6:35 AM, Jan Beulich wrote:
>>>>>>>>>>>>>> On 02.08.2026 07:08, Chuck Zmudzinski wrote:
>>>>>>>>>>>>>>> -- snip --
>>>>>>>>>>>>>>> +    /*
>>>>>>>>>>>>>>> +     * Write rvda_host as 2 successive 32-bit values
>>>>>>>>>>>>>>> +     * to communicate location of the VBT to the device
>>>>>>>>>>>>>>> +     * model. If rvda_host is not 0, The device model
>>>>>>>>>>>>>>> +     * unmaps the OpRegion and eventually maps the VBT
>>>>>>>>>>>>>>> +     * after we also write the guest address where the
>>>>>>>>>>>>>>> +     * VBT will be mapped.
>>>>>>>>>>>>>>> +     *
>>>>>>>>>>>>>>> +     * If we send rvda_host = 0 to the device model, it
>>>>>>>>>>>>>>> +     * will assume we do not need OpRegion 2 support and
>>>>>>>>>>>>>>> +     * it will not unmap the OpRegion.
>>>>>>>>>>>>>>> +     */
>>>>>>>>>>>>>>> +    pci_writel(vga_devfn, PCI_INTEL_OPREGION,
>>>>>>>>>>>>>>> +               (uint32_t)(rvda_host & 0xfffffffful));
>>>>>>>>>>>>>>> +    unsigned long rvda_host_upper_32 = (uint64_t)rvda_host >> 32;
>>>>>>>>>>>>>>> +    pci_writel(vga_devfn, PCI_INTEL_OPREGION,
>>>>>>>>>>>>>>> +               (uint32_t)rvda_host_upper_32);
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Why would you need to communicate a host property to the DM?
>>>>>>>>>>>>>
>>>>>>>>>>>>> The DM cannot access the host rvda value because it is only accessible
>>>>>>>>>>>>> from the host kernel, and the DM is only a user-space process on the host.
>>>>>>>>>>>>
>>>>>>>>>>>> I don't follow this: Anything the guest can access should also be accessible
>>>>>>>>>>>> by its DM.
>>>>>>>>>>>
>>>>>>>>>>> I think the host OpRegion is not currently accessible by the DM.
>>>>>>>>>>
>>>>>>>>>> Can you explain to me how the region becomes accessible to the guest?
>>>>>>>>>> That would then (hopefully) help me understand why the DM would not have
>>>>>>>>>> access. Fundamentally any MMIO and any I/O ports that are assigned to a
>>>>>>>>>> guest are also assigned to its DM.
>>>>>>>>>
>>>>>>>>> Currently, in the device model (Qemu) we have:
>>>>>>>>>
>>>>>>>>>     ret = xc_domain_memory_mapping(xen_xc, xen_domid,
>>>>>>>>>             (unsigned long)(igd_guest_opregion >> XC_PAGE_SHIFT),
>>>>>>>>>             (unsigned long)(igd_host_opregion >> XC_PAGE_SHIFT),
>>>>>>>>>             XEN_PCI_INTEL_OPREGION_PAGES,
>>>>>>>>>             DPCI_ADD_MAPPING);
>>>>>>>>>
>>>>>>>>> That statement is in the igd_write_opregion(...) function in the
>>>>>>>>> hw/xen/xen_pt_graphics.c file of the upstream Qemu source.
>>>>>>>>>
>>>>>>>>> If I understand our current implementation correctly, this statement
>>>>>>>>> is what gives the guest access to the host OpRegion (3 pages as defined
>>>>>>>>> by XEN_PCI_INTEL_OPREGION_PAGES, and in agreement with IGD_OPREGION_PAGES
>>>>>>>>> in hvmloader code).
>>>>>>>>
>>>>>>>> No, it introduces mappings of those pages into the guest's P2M.
>>>>>>>>
>>>>>>>>> I don't think this statement makes the host OpRegion
>>>>>>>>> accessible to the device model, though, so I think, if I understand your
>>>>>>>>> comment in an earlier about my patch resulting in what you called a "layering
>>>>>>>>> violation" correctly, that our current implementation is also guilty of this
>>>>>>>>> same kind of "layering violation."
>>>>>>>>
>>>>>>>> That code, if it can be successfully executed, indeed doesn't grant any
>>>>>>>> permissions (to the DM or the guest). Instead it proves that the DM has the
>>>>>>>> needed permissions to access the pages itself.
>>>>>>>
>>>>>>> So, are you saying it should be possible, without any patches to either Xen or
>>>>>>> the Linux kernel, for Qemu to get a pointer to the OpRegion? If so, how?
>>>>>>>
>>>>>>> I think I could implement what you proposed in an earlier message and do
>>>>>>> all (or most) of this in the DM instead of here in hvmloader:
>>>>>>>
>>>>>>>> The more correct thing to do might be for the DM to
>>>>>>>> put in place a copy before the guest (i.e. hvmloader) even gains control.
>>>>>>>> (How in turn the DM would learn of the contents of the opregion is a
>>>>>>>> separate question then.)
>>>>>>>
>>>>>>> Actually, when I was developing this patch, I tried first to do it that
>>>>>>> way, but the problem was, I could not find a way to get a pointer to the
>>>>>>> host OpRegion in Qemu.
>>>>>>>
>>>>>>> So, how can I get a pointer to the host OpRegion in Qemu?
>>>>>>
>>>>>> You don't ask me this question, do you?
>>>>>
>>>>> Are you offended I asked this question? If so, I am sorry. You make me
>>>>> afraid to ask it again so I will not do so unless you permit to do so
>>>>> again.
>>>>
>>>> "Offended" is the wrong word; "very puzzled" may better get it. I'm not a
>>>> qemu person, and I never have been. I can't really help much there.
>>>>
>>>>> All I can say is that surely qemu
>>>>>> has an existing way to map (host) physical memory; see e.g. how
>>>>>> xen_pt_msix_init() (imo bogusly) maps the physical MSI-X table of a
>>>>>> device. "Bogusly" there because that's another layering violation. Plus
>>>>>> (independently) there and here there's the issue of how to accomplish
>>>>>> things when not running in Dom0, or when running de-privileged in Dom0.
>>>>>
>>>>> Well, that only proves Qemu *might* be able to access the MSI-X table of
>>>>> a device, that is, if the calls to open /dev/mem and mmap it succeed.
>>>>> Why is the MSI-X table all of the sudden relevant? Even if Qemu
>>>>> can access the MSI-X table of some device, that does not prove that
>>>>> Qemu can access the host OpRegion of an Intel IGD. So I think my point
>>>>> still stands: I still don't see proof that it is possible for Qemu
>>>>> to get a pointer to the host OpRegion without any patches to the current
>>>>> implementations of Xen and the Linux kernel.
>>>>
>>>> The MSI-X table (and it being accessible to qemu) is the best analogy I
>>>> could come up with, as that's one tiny area of qemu that I know at least
>>>> a little.
>>>>
>>>> From a Xen perspective, this analogy should be sufficient: All you need
>>>> from Xen is for it to permit to establish mappings of the underlying page.
>>>> As I've pointed out when commenting on a code fragment you presented, the
>>>> DM (domain) looks to have permission. Everything else is a matter of
>>>> establishing such a mapping. There the MSI-X table code may also guide
>>>> you. (Sadly it may also misguide you, since (a) I don't know whether it's
>>>> appropriate to do things this way in qemu, and since (b) it is, as said,
>>>> imo a layering violation.)
>>>
>>> I agree that accessing the host /dev/mem directly is cringy. I would not
>>> really want to do it that way for the host OpRegion.
>> 
>> I looked at the current mainline Linux kernel code about access to memory using
>> /dev/mem and modern distros set CONFIG_STRICT_DEVMEM which forbids access to
>> ordinary system RAM but allows access to what the kernel developers call
>> non-kernel memory. Here is a quote from a comment in arch/x86/mm/init.c file
>> in the Linux source code:
>> 
>>>  * On x86, access has to be given to the first megabyte of RAM because that
>>>  * area traditionally contains BIOS code and data regions used by X, dosemu,
>>>  * and similar apps. Since they map the entire memory range, the whole range
>>>  * must be allowed (for mapping), but any areas that would otherwise be
>>>  * disallowed are flagged as being "zero filled" instead of rejected.
>>>  * Access has to be given to non-kernel-ram areas as well, these contain the
>>>  * PCI mmio resources as well as potential bios/acpi data regions.
>> 
>> So I think things like the MSI-X table and the OpRegion would qualify for
>> /dev/men access even with CONFIG_STRICT_DEVMEM set, so after seeing this
>> I expect I could get a pointer to the OpRegion running in Qemu using
>> /dev/mem and mmap, as long as it is running in dom0 with root privileges.
>> But as I said earlier, I agree that /dev/mem and mmap does not feel like
>> the right way to do it.
>> 
>> So I would like to come back to something else you said in an earlier message:
>> 
>>> (How in turn the DM would learn of the contents of the opregion is a separate
>>>  question then.)
>> 
>> Let me phrase the question like this: How could the DM gain access to the contents
>> of the OpRegion, and for that matter, also the contents of the MSI-X table, without
>> also committing a layering violation?
> 
> As said previously, I'm not a qemu person at all. Yet it's entirely a qemu
> question you raise. From Xen's perspective, as also said previously, the
> one prereq is there - the DM domain is permitted to access the page(s) in
> question.

Yes, I agree that v3 of the patch to hvmloader should presume that the DM can get
a copy of the OpRegion and read its contents so most of this can be done in the
DM instead of in hvmloader. So from hvmloader's perspective, the patch will be more
about avoiding the layering violation than anything else.

Chuck

> 
> Jan


