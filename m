Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 503B9C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 17:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww0la-0000A6-UI; Mon, 17 Aug 2026 13:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1ww0lY-00008i-EF
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 13:04:52 -0400
Received: from sonic301-22.consmr.mail.gq1.yahoo.com ([98.137.64.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1ww0lW-0004at-76
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 13:04:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1786986285; bh=dKCFa0rAtVsUjE9N0GIBIR9kWQqOCx0gZuyJuHmbClo=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From:Subject:Reply-To;
 b=EqZOWt9rp4kr0xE2+G240h12ep/4D5tUP+5FXxkaZ1NfbAL3rb4KK97DNfN17zwYTw5eeQy1fsUZSLE1A3qSQ+xy/6nlDiRTB6wZCrUzFlVk6fcEWN3tXrnvVyLQMnA223VBlLIoK7zE65XXhn//Pwb+NoDPn00GCQaZ/Bp3TyL0tm5R4EtLy7D/pcPpNXr084zJoXKV6Aq0m7xd+KUTBmJXJ8KsUY9mOvyRfGgvRt/jZT4aeSIYZx/RG4u8IX1HgvpColO+mPO/UxeudL5p2w+dSrOEWXFQ7OJt9vweon9cASxJcW2xz1+ItJ/yaeVRMeYMW7+I/am6pN/nubBWNg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1786986285; bh=YMugPLm0BjCU7MzeFkJmnzvlixlt5tHRiUI8AtnehZj=;
 h=X-Sonic-MF:Date:Subject:From:To:From:Subject;
 b=pVAIs/n/5HfDadYtzdPAISb2JmvqXAfHszFD0aFOVzqEL9uj7rlw+sKTGrdSeo3NHxSJ1U7sJzwNWg6O1km3V54b8RLs4/z4iEpFU0pxUpnk/l9/Hrm55fE+oOpb7t8kPVY0FhyK5L8hSHWsFeVDTnc+ykxVzzeG6SWMJL6DOOAbXtr8+D3vafz6fYYmrmksfT6NcZnVn8V8jnIJDXrI02NSxpN0uqKQ0Wiv5LD56BQG+mYkYMRHvNJ0v0v5WW+olSUXhKQikmfla9ppedw36JomjFROlpcf+6ttFwq1nIKLx2GW8ckV56t1kM2QoS/xEKie2vVlolK2A3v1CG8w7w==
X-YMail-OSG: qSONq3sVM1lckBhJ74iZ_Z7xf9_0ur2G_QgE9cGPHyXXRxNvzRf1aEJVjOFkw7x
 PF7bIk4ER2Wx4tCOVE2X4uMYtNGYr36nirrlNrwNQmrE358mu.AWMi5eo6J4a2N5q8GcfRlhfab3
 mEBsoU_ZkZrSz72cvAUw7rSGilF6ZnG_kkPAIkoK1odJCmrBTtLKNL.PcT1Z4Z3IDu4zNQGEyevB
 WaiRgL.Uv7jpPQ_t7hVwTiHMMw5tsK0HfKyw.Oja85XY1cf_7wQLJ7Im7qeEjTp11VXRirZvHlKE
 E94d2QCx0LyL9fVEeznDpqjBc9sr_Z3_sruh841JwP0GUXJ45LvDYEYoFfqWehPrh0YrzmUcEYoe
 sVNDgDtphl_3wv2.P5x5i6CQ8VVhcRr6095tzj9dC8_WKCXKYWaJ7KJ529GUrGtKwS126q6.R3fl
 nsrgPYkemmADk2BsChiM0dK1xMwzVuw5sIEUM9fFC.6lNpNb7w4O8B64qNunocAh..1aBHQ8d3pX
 tysL8ITyzrCcUVWJ2WcgyFSnHJnmOd4ppYdk4ZNd_1ejTNKDAkPK2aLBWR7j9iLkwViGAt9tltO8
 Z2Xxa7j5py47pTh7QPpy_RWQ_B4ca324nhg8z4fR7gAF0W9j8HRnTzxCOSS_MyNZdQj1gpg3e1w.
 BYjfDYlc0bZxLPKlEEywWLJOx1rmyEqI4QE3iUMUqO.rrZF5ylnO0ghb1p5xx.4BM5e9q2RKVHGk
 mwBJ8bWl2eFEH3LVVatv55ierRLZX4hV8ZjQuyMysvcD1rC2a5WGktqwwomiFIy8wF_b7KB8t264
 oOiQ0YPxNy8KfAcQeMVaLFHDvdvuG9gN0FNBVYwr_Q2YXYvH._jkvX3xuoGngfpiPstdMvSVfnOA
 PQR1UmMeJzcK7HbYPJy2RwFApfYwLu_Tawlx7xpQXtonSgEkKHadzAeSUFoGr8xzAhND_m_nTgh8
 m8lOVCJjaCD0TDIvYu1ufDLozYdtXal_0RaLlMYJ2ddk2wYoIXCA6D2Xgt.TczkVMK5C8iWi_eWk
 o9yd50PRUl95terARdX_TDAl6wNXT5GQLbwlj_DYtVe3wZU21NxLId_QV1BpO2Ve1ZwxFlUaHazr
 XwKmLcoBH4huVP6brXd64.6ZpHjcgg5uIRMV7xYZbdBxmAMzZ_FL.QkRLTo6JjArfHR0yxFgYkh4
 Z5SRT9uTE.XhuKmT42tJJkS6mMM53GskKfzi6fgqvMzASjEnGp0kw5NXtcWreL7mjbKWCH2Jpel6
 pG9iJhTurVNJKtMUMQM8tsU3lER9RRFFauPbuh.Oe64.jkVeOMwIXMl_Cn4i7W7CVJow3Fnio3wX
 nuIAQBbzmY0pAM9EU0PwJgNxAa6gguKJOeFxcXJFiDDJQY3Amv4DMm_SZqVyn5rEqJnMt5idRiH.
 x6eIb_tyqedEyQVhVHrbha.AcwNGPPyLfpRowahr6RArwjdr9q.8euyF9kebeysbWVzhrtRUVVNd
 UPRQitf2zR35Okh5NlMvGDXIvGM9j_WbeAI9QJ_r4FsQUae0JlWteTImHuy65i4hkxKsgA2EH2MQ
 v1eS7Tm9KKmrdM7eQjQkD4JG6JRwFZPlePCtnVfWmcqkHCpE_SCUe3pIm99USh9GnUrKsDkS5XyD
 ERWVRUTZdNhqdvbUFNdLTiYPmga3u.WxrLCiBRdx7f85huccBdCUrrf.1Njm9lvnT7bDWhHfCXNH
 rkIFlszzQbMYowQRu19wX0NpVy3hL7l4rst63Vxh.F924N794UxoJ6g9CLt2zrHB7rtktqBmOAek
 vppbYrjz_NJ.QyuD9RqOPDByKLhdSl_4xA9i.XFFJYCxMRxa3UaJ_QsVNaFjxtXM.ErtNmdrXMYD
 B4JDIsk9wk.dk0wr5.bXSpEDwRNMtsUytLu0c8SmY.XUBBmoVZetjUoC1rYRbsVdeb10ysJTsY7i
 C36t6J2p_1OMLimM4zkC3KdhMGjuhtQYzbamprg30._v_mxrkG2f08SPcXlh.p4nqGQZTDlNwUaO
 V7j_S.1w18L_iQiRB73bMtYqJrNi8_Tb269SVyxU62hc8MMw6BDwrEHfv8Wn3sNy7ifj5c2sb3CP
 aW_DjgX2K0UXC0VO4Zr76FPYyUeh7t8Qk6NvVRM4EiIpR930kr3GfSyVeMtXWTDwggwi4X34S36j
 Pndv45hVrDvwZx4vD1ur6gkGPsFoZGD5vcm8M9EeYwUVo9wdPv8pxaF3FIuXNbAYdoCEVYguiWzq
 Tb7UFl9buywcNznLssytPO1mCxZg76p4icFAOiAFRZXdZJQ--
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: ab4fd652-7052-4c36-ba60-b8fd1f94624a
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic301.consmr.mail.gq1.yahoo.com with HTTP; Mon, 17 Aug 2026 17:04:45 +0000
Received: by hermes--production-bf1-54b5569bdc-z2x8g (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 4afd9ff1b6f04a95f703b0a0ed0588a5; 
 Mon, 17 Aug 2026 17:04:42 +0000 (UTC)
Message-ID: <5e2e43f3-812b-47ab-a54d-ae0973e08880@aol.com>
Date: Mon, 17 Aug 2026 13:04:41 -0400
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
Content-Language: en-US
In-Reply-To: <fdec0b6b-eddf-4a36-a755-c67963daa9ea@aol.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26254
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
Received-SPF: pass client-ip=98.137.64.148; envelope-from=brchuckz@aol.com;
 helo=sonic301-22.consmr.mail.gq1.yahoo.com
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

On 8/17/2026 12:04 PM, Chuck Zmudzinski wrote:
> On 8/17/2026 4:42 AM, Jan Beulich wrote:
>> On 14.08.2026 17:23, Chuck Zmudzinski wrote:
>>> On 8/14/2026 9:46 AM, Jan Beulich wrote:
>>>> On 14.08.2026 15:18, Chuck Zmudzinski wrote:
>>>>> On 8/14/2026 3:35 AM, Jan Beulich wrote:
>>>>>> On 14.08.2026 02:45, Chuck Zmudzinski wrote:
>>>>>>> On 8/13/2026 6:35 AM, Jan Beulich wrote:
>>>>>>>> On 02.08.2026 07:08, Chuck Zmudzinski wrote:
>>>>>>>>> -- snip --
>>>>>>>>> +    /*
>>>>>>>>> +     * Write rvda_host as 2 successive 32-bit values
>>>>>>>>> +     * to communicate location of the VBT to the device
>>>>>>>>> +     * model. If rvda_host is not 0, The device model
>>>>>>>>> +     * unmaps the OpRegion and eventually maps the VBT
>>>>>>>>> +     * after we also write the guest address where the
>>>>>>>>> +     * VBT will be mapped.
>>>>>>>>> +     *
>>>>>>>>> +     * If we send rvda_host = 0 to the device model, it
>>>>>>>>> +     * will assume we do not need OpRegion 2 support and
>>>>>>>>> +     * it will not unmap the OpRegion.
>>>>>>>>> +     */
>>>>>>>>> +    pci_writel(vga_devfn, PCI_INTEL_OPREGION,
>>>>>>>>> +               (uint32_t)(rvda_host & 0xfffffffful));
>>>>>>>>> +    unsigned long rvda_host_upper_32 = (uint64_t)rvda_host >> 32;
>>>>>>>>> +    pci_writel(vga_devfn, PCI_INTEL_OPREGION,
>>>>>>>>> +               (uint32_t)rvda_host_upper_32);
>>>>>>>>
>>>>>>>> Why would you need to communicate a host property to the DM?
>>>>>>>
>>>>>>> The DM cannot access the host rvda value because it is only accessible
>>>>>>> from the host kernel, and the DM is only a user-space process on the host.
>>>>>>
>>>>>> I don't follow this: Anything the guest can access should also be accessible
>>>>>> by its DM.
>>>>>
>>>>> I think the host OpRegion is not currently accessible by the DM.
>>>>
>>>> Can you explain to me how the region becomes accessible to the guest?
>>>> That would then (hopefully) help me understand why the DM would not have
>>>> access. Fundamentally any MMIO and any I/O ports that are assigned to a
>>>> guest are also assigned to its DM.
>>> 
>>> Currently, in the device model (Qemu) we have:
>>> 
>>>     ret = xc_domain_memory_mapping(xen_xc, xen_domid,
>>>             (unsigned long)(igd_guest_opregion >> XC_PAGE_SHIFT),
>>>             (unsigned long)(igd_host_opregion >> XC_PAGE_SHIFT),
>>>             XEN_PCI_INTEL_OPREGION_PAGES,
>>>             DPCI_ADD_MAPPING);
>>> 
>>> That statement is in the igd_write_opregion(...) function in the
>>> hw/xen/xen_pt_graphics.c file of the upstream Qemu source.
>>> 
>>> If I understand our current implementation correctly, this statement
>>> is what gives the guest access to the host OpRegion (3 pages as defined
>>> by XEN_PCI_INTEL_OPREGION_PAGES, and in agreement with IGD_OPREGION_PAGES
>>> in hvmloader code).
>> 
>> No, it introduces mappings of those pages into the guest's P2M.
>> 
>>> I don't think this statement makes the host OpRegion
>>> accessible to the device model, though, so I think, if I understand your
>>> comment in an earlier about my patch resulting in what you called a "layering
>>> violation" correctly, that our current implementation is also guilty of this
>>> same kind of "layering violation."
>> 
>> That code, if it can be successfully executed, indeed doesn't grant any
>> permissions (to the DM or the guest). Instead it proves that the DM has the
>> needed permissions to access the pages itself.
> 
> So, are you saying it should be possible, without any patches to either Xen or
> the Linux kernel, for Qemu to get a pointer to the OpRegion? If so, how?
> 
> I think I could implement what you proposed in an earlier message and do
> all (or most) of this in the DM instead of here in hvmloader:
> 
>> The more correct thing to do might be for the DM to
>> put in place a copy before the guest (i.e. hvmloader) even gains control.
>> (How in turn the DM would learn of the contents of the opregion is a
>> separate question then.)
> 
> Actually, when I was developing this patch, I tried first to do it that
> way, but the problem was, I could not find a way to get a pointer to the
> host OpRegion in Qemu.
> 
> So, how can I get a pointer to the host OpRegion in Qemu?
> 

I also think that if we use a fully emulated copy of the OpRegion
instead of passing it through, we might not need to allocate space for
it in the RESERVED region and allocate it instead contiguous with the
rest of the NVS region. This means we might be able to avoid needing
to split the REVERSED region in hvmloader/e820.c which is currently
done like this:

    /*
     * If igd_opregion_pgbase we need to split the RESERVED region in two.
     */

    if ( igd_opregion_pgbase )
    {
        uint32_t igd_opregion_base = igd_opregion_pgbase << PAGE_SHIFT;

        e820[nr].addr = acpi_mem_end;
        e820[nr].size = igd_opregion_base - acpi_mem_end;
        e820[nr].type = E820_RESERVED;
        nr++;

        e820[nr].addr = igd_opregion_base;
        e820[nr].size = IGD_OPREGION_PAGES * PAGE_SIZE;
        e820[nr].type = E820_NVS;
        nr++;

        e820[nr].addr = igd_opregion_base + IGD_OPREGION_PAGES * PAGE_SIZE;
        e820[nr].size = (uint32_t)-e820[nr].addr;
        e820[nr].type = E820_RESERVED;
        nr++;
    }
    else
    {
        e820[nr].addr = acpi_mem_end;
        e820[nr].size = (uint32_t)-e820[nr].addr;
        e820[nr].type = E820_RESERVED;
        nr++;
    }

I am not sure this would work but I think the need to map the OpRegion
to the RESERVED region arises from the fact that currently it is passed
directly mapped from the host. I think I will try it out and see if that
would work.

>> This is what the handling of
>> XEN_DOMCTL_memory_mapping has in this regard:
>> 
>>         ret = -EPERM;
>>         if ( !iomem_access_permitted(current->domain, mfn, mfn_end) )
>>             /* Nothing. */;
>> 
>> Subsequently we check that the guest is also permitted access:
>> 
>>         else if ( iomem_access_permitted(d, mfn, mfn_end) )
> 
> 
> 
> 
> 
>> 
>> Jan
> 


