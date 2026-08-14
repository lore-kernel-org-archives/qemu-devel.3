Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACECEC5CFCF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wutlF-0006zF-HD; Fri, 14 Aug 2026 11:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wutlC-0006yz-65
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 11:23:54 -0400
Received: from sonic308-55.consmr.mail.gq1.yahoo.com ([98.137.68.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wutl8-00041U-Ir
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 11:23:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1786721027; bh=kWABo+M8UTCM8OR7VjnLl19mzMxfmSiG8dC6uCq4Ie8=;
 h=Date:Subject:To:References:From:Cc:In-Reply-To:From:Subject:Reply-To;
 b=JTKBpC7w61n4lwWyzhlzKW32T8K134hxvSqWhYyki1r8MRXmzLy1NKl/m9W1twN0e0XI9jNX5Slq59xOFtaCaoL2GhoTJ1HRYVPM90vSLQtS0E35U1hkGpMmydKsqFEIprObkHKo2dxQ1wTF4zHm1u+rHQu7GLeMfS++nzGkC8jtexa7fR20ezLijgwS/oGFQ7pVO+hJCYKDCAbJg6tfoMJ04IFEqLRY4bo8tEUh+Ez9O1UrLM5EqqH9jVfTheRO9MaARO9yzpwr8xrbnR0+uVoLSb0Ba0/ijfH4eSMOZmJRk64G6W6xGMmjP3dZ4Z2RlwdU9AfhEe6EBtWAmv/1nA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1786721027; bh=9X576LiXnRvQdmdVNRAnjKREUeBFxrVd8qV7sjoPk19=;
 h=X-Sonic-MF:Date:Subject:To:From:From:Subject;
 b=JA2HV5PZ71fw1ssYa2s/Z7gTJbaQvlQ6OTL5k01ibEV65vcMWQJhGGWOhAAtJGqC5AMx9kT3suHS4J3holqhc106c4AT8JMS+x0lfR+FsYlygHd5QqbfvGCCv/0SY0S/I8zyS9PjW/4Oc1xpBBcjXX8LuUifZkt+TxohpTc6B4AOWb1fe3p7FViBK/hUWMP4pEnS3Cv+vNuthshbeuf37rtmhNZUso2n7w9leBXW4T8m7mRJ7/hmVFYOZ1hAfa74x0S/9S//izxL5qWWwGsd4P3z6mVlJRxO8Bj/pqGZsJDp2rxAkyqC7egss1khSv3ilDM1sPrZr5do9mQCspbjNg==
X-YMail-OSG: X7iH8.8VM1mJ7dS_Szv82CuzafYlwVhKwEQPARIG6Tc6VtCAWIeA1KjV1nTTHYe
 bp50W0shTvTdVysfXAn0cUKJo7aejrmPH2rPaCcY9efNeQAHj2pwzV0rkYJHAwYU36Ra00BpAMFh
 eR1I6Zu5eWgX5ZjM3nnIKAW8hnFfuGgl2CHTVEwygrXuvl1Y6NfGRnZ4ubxAdTyQ6m9ZxNIt.GvU
 kY3FgXoAswASuaTN3zl0osIlohYhhxqvabnUaz.bzhfOiPukOu9f8X0ACHCKOXyFP.3C2r3q07pk
 oj3WPboPoQ0aQMRX.6S9oUO0qOfkr_VHgdgxLTK3zsVpZxx2FM0ehrxRuhS5CN45t1.Z4REJWnVU
 71DL8FCMnfIlfjZIafVFwuE6NOtBrLLddr0af80v5MMgl3Fb910s.d__StrrExrsH25xHUUPwd19
 4l7lXcuNQLJwzBcOYpeGCLHrCUI5Aa1YzY476TTGnid4fK7X0lLfcRmMQMX9m39iQY6baCSngMPl
 IsTW7psujJ6mIjaUMN1qn9U2_E501ctzbqU9s4yXYjSG45jlph11qjkRUW4W8KtEBYA751_wLSZ_
 8u21K23o1GbVcFzhRtLBBajkvzJIV3u.EJ7fE1CSDVmldbFbs0rk_Cx77vs0mCuAa4V0_xFFvwKi
 DHh.MBs8BXLPOucckixi5nRGN9642Pha5eEt9H51rTOx7w82Oy3Zk9C2iF9N62EnwWPJfla7eM.o
 SSlmotKbte2VQknzQFGEPoEGCjvS1n7LFzozoO.KDvDotugKrqVGhIwugs9NkJxXnrIgJ0XZvpBB
 .dwkBnNi8JO2ZTcZUpj0GXbn794u.nzpN969xiBXjoG.iiEGUdM7FC0ADR9zOtdLJU0t3iDe0mkm
 wtQouroEIIv.gwjCojqapksHlPqOKkWkh_bYp7Lwz62HLNghbFAgrMuVf_jbjnQtil8GOP132l0F
 BZcWF.jqxKGlo.zuXuGb4.xV84CYeFjXdWrwvs5Syzrt6B5Jj9OQeIIk5oIRquBHN6cwUXQEBYX3
 Mdd7p2hnOG7ltmhBTarHeiy8rLUvI5PSY1NN9dO2RJfJ2Tg2dxDi0QraiNqElkLDNMbMEn6sCfNJ
 IFrnCs.xGPkS72.xGmt8OLjxHi3hAasxFJe3TBI6vQZovr_iAg8AkOT9kOhde8165zsh14W.LqR1
 6yDTn8ypFCHekZYJVReWyKSHTQhB9pMd6ZAXQgHChsWu31mBieUTv4B0asjApLMWGEAgNRLzeO6i
 aSPLeZ0tzEaKSz2w1UlA4_t_iaXgmYAR7dA2BjZ6AVcVuz_B7wQBdbkeZITqozJdIBgl5PdKxPOT
 Y64vUlT4TIKQD4.wsahLGfQDtEIeYLCVSo8iRs5sFddSar.E3wfB46dg6QH5lhQy7.woFwsC1gW5
 NROxQnYHi.B_EpizyGivp0Fn7HT6S45lgf7mwL.Rhl1ggB3tA5TeW5_EjbNqzjSdcP_WPHJvjJF0
 idKIgvJQcgLFh4zNupeJn2g7XQ3JJys8IQ6Be1LrxlDbTyB3bis.Zmy3y3MalT7BpEZ1ZZWMVxEt
 fcAuLXZN_ja.9v4PcDywO79fli1jy7ppd5ylKTMvNhDKStM2WIhO5FHqCSNtPZxNmixTOur4L6Fm
 vUSGwTaAEp1s2eYg3EWFeia0iWprnmS1o5n7a1LZtv6jK_V6n4JsRXIXgKXW_9i4eI2D9bN5fldc
 v.AGtsHSp6yjsNr6nwu98oso4JI7xfY4I5E5j5pPDb5va_FAnGrd8fFmZ1y1xSsk9MtY_MW8M2Pa
 l1TuXX8Kz1w1D5gP55_cFyfrc52J23chrX2WD1.iqmGjFQEg.LVVNgdc3N7pgFR5Y_y3q5UXpHsw
 Si29mdyH42FmHEYSO.sy2PrNfytZAcZYBdEgGBmdpOHo19DAjHKTFu_NRzr1.kSsHBgQJ5k1338J
 HH9Wvn0kVxlc3XCbBUSv8gdeEMMK4JScnE0QyZxB5Bf67A3ttF3nnm8pnu2NuwViMSL5PBiYbw8q
 q7kpdW_zWFllX_xxvH66QDpfssrtwbi3jR3XtZtWWxjKoYbp8UihwybpvSPyUreANS2AWpsyp_pu
 fyjXKdF9pbpWhTMsR4INNLLRtHQoQRJtCB0YivNT3SpYU7ByWQnBySQ9nOchDkX.bep9RT2IJBdc
 24qCTzxc1W8xbvMu9N6CnnnljwfV36lep6XG95P74UdqtSCrEeJAnZQc4mzUbGjoy34O3SLn7IRm
 IUsADlNmE7tFp81zdhAgA8bNY8PrL8QouPBL8l9ldtYo7_SU-
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: 3bcd5e70-24d2-4964-8f13-551d301ac199
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic308.consmr.mail.gq1.yahoo.com with HTTP; Fri, 14 Aug 2026 15:23:47 +0000
Received: by hermes--production-ne1-6dbcb84f44-xtsvv (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID d1d2b98acc5c03388ed30a9ee0960e39; 
 Fri, 14 Aug 2026 15:23:45 +0000 (UTC)
Message-ID: <1858e8e6-73fa-4017-93e2-c733fbf0ec8d@aol.com>
Date: Fri, 14 Aug 2026 11:23:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tools/hvmloader: implement Intel IGD extended VBT
 support
To: Jan Beulich <jbeulich@suse.com>
References: <20260802050824.10554-1-brchuckz.ref@aol.com>
 <20260802050824.10554-1-brchuckz@aol.com>
 <2110d4b7-ae37-47aa-99be-ab59e16f6167@suse.com>
 <67579eba-e222-41dd-84bf-8440d2eaf2a9@netscape.net>
 <da2200cd-def7-4cce-a6c2-9f9ac9e202ce@suse.com>
 <de56c8bd-f0e8-4fe9-8cf5-f6807698176c@aol.com>
 <02a7dc18-4184-4e86-84cb-121769187f71@suse.com>
Content-Language: en-US
From: Chuck Zmudzinski <brchuckz@aol.com>
Cc: qemu-devel@nongnu.org, Andrew Cooper <andrew.cooper3@citrix.com>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger@xenproject.org>,
 Teddy Astie <teddy.astie@vates.tech>, Tomita Moeko <tomitamoeko@gmail.com>,
 xen-devel <xen-devel@lists.xenproject.org>
In-Reply-To: <02a7dc18-4184-4e86-84cb-121769187f71@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26254
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
Received-SPF: pass client-ip=98.137.68.31; envelope-from=brchuckz@aol.com;
 helo=sonic308-55.consmr.mail.gq1.yahoo.com
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

On 8/14/2026 9:46 AM, Jan Beulich wrote:
> On 14.08.2026 15:18, Chuck Zmudzinski wrote:
>> On 8/14/2026 3:35 AM, Jan Beulich wrote:
>>> On 14.08.2026 02:45, Chuck Zmudzinski wrote:
>>>> On 8/13/2026 6:35 AM, Jan Beulich wrote:
>>>>> On 02.08.2026 07:08, Chuck Zmudzinski wrote:
>>>>>> -- snip --
>>>>>> To address this problem, this patch implements support for
>>>>>> Intel IGD devices with an extended VBT and OpRegion version 2
>>>>>> and higher which is required for most modern Intel IGD devices.
>>>>>
>>>>> First of all: Where's the spec of all of this?
>>>>
>>>> Well, your first question is quite provocative. Certainly more
>>>> social/legal than technical.
>>>
>>> Well, it was very much meant to be technical. I've had a hard time following
>>> what your new code does, and having a spec to hand would likely have helped.
>> 
>> I agree that having the spec at hand would be better. To be more precise, I
>> can say that what this patch essentially does is port the support for
>> the extended VBT with OpRegion 2+ for the Intel IGD passthrough that exists
>> in KVM/vfio to Xen. Should I explicitly say in the title of the commit
>> message that this is a port of KVM/vfio support for extended VBT to Xen?
> 
> Not in the title, as that would likely make it too long, but perhaps in the
> description.

Ok.

> 
>>>> So my answer is as follows:
>>>>
>>>> I do not have access to the official spec that defines "all this" but
>>>> I do have access, as does the general public, to the Linux kernel's
>>>> implementation of support for the Intel IGD from many sources such as
>>>> git.kernel.org. The Linux kernel has enough accurate information about
>>>> the spec of "all this" to provide very good support for the Intel IGD
>>>> on bare metal.
>>>>
>>>> To elaborate a bit more, the spec of "all this" can be derived from the
>>>> Linux kernel code that supports the Intel IGD.
>>>
>>> So you expect every reader to locate and decipher the underlying information
>>> from a (afaik) pretty large piece of code in the Linux kernel? If the Linux
>>> kernel sources are the reference, please can you at least provide pointers
>>> into there?
>> 
>> No, I do not expect every reader to decipher the underlying information...
>> 
>> That is why I provided these two links at the bottom of the commit message.
>> Perhaps you did not notice them:
>> 
>> Link: https://lore.kernel.org/kvm/20211012124855.52463-1-colin.xu@gmail.com/
>> Link: https://lore.kernel.org/kvm/20210325170953.24549-1-fred.gao@intel.com/
>> 
>> They are the patches to the vfio kernel driver that added support for the
>> extended VBT for KVM/vfio guests.
> 
> Patches can still be in flight, so provide only limited help. Would it be a
> problem to instead reference commits, or the actual localtion in Linux
> sources?

No problem. I will format references to kernel commits the way it was done in
this commit message of commit 99794c8a8ff8 in the Xen tree that references
some Linux kernel commits unless you suggest a better way to reference Linux
kernel commits:

 xen/acpi: Import PPTT definitions from Linux

Import the Processor Properties Topology Table (PPTT) definitions
from the Linux kernel header (include/acpi/actbl2.h) into Xen.

Signed-off-by: Hirokazu Takahashi <taka@valinux.co.jp>
Origin: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git b8355bcac253
Origin: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git e62f8227851d
Origin: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git 091c4af3562d


> 
>>>>>> +    pci_writel(vga_devfn, PCI_INTEL_OPREGION,
>>>>>> +               (igd_opregion_pgbase << PAGE_SHIFT) |
>>>>>> +                IGD_OPREGION2_SUPPORT_MASK);
>>>>>
>>>>> This looks to imply qemu is the only possible device model.
>>>>
>>>> Yeah, this is an issue. Other device models that intend to support
>>>> the Intel IGD with hvmloader will also have to be compatible with this.
>>>> It would be easier if we did not have to worry about backward
>>>> compatibility and supporting what we had in the codebase for many years
>>>> in both hvmloader and Qemu and we would not need IGD_OPREGION2_SUPPORT_MASK
>>>> in that case. Instead, we would just completely deprecate all previous
>>>> implementations of the Intel IGD passthrough feature in both hvmloader and
>>>> the Qemu DM as unsupported. So my previous comments about backward
>>>> compatibility apply here again.
>>>
>>> As said, I don't think backward compatibility can be dropped. My comment
>>> also didn't really mean to hint in that direction. Instead I was wondering
>>> in how far, even if perhaps by only a few #define-s, the necessary
>>> interfacing couldn't be put down in a public header, for any DM to consume.
>> 
>> Ok. Perhaps the IGD_* defines could be moved to a public header to define the
>> interface to be used to support the Intel IGD. Would it be OK to move those
>> to a separate igd.h header
> 
> This may require input by others, as in the given situation I'm not quite
> sure what is best. Anthony - do you possibly have any suggestion here?
> 
>> and include it in hvmloader/config.h?
> 
> I don't see why that would be needed. The few files which need the #define-s
> can include that new public header, without impacting anything else.

So I would just include it in the new intel-opregion.c file. Also, maybe igd-related
declarations should be moved there too, such as the currently existing extern variable
igd_opregion_pgbase and my newly proposed extern variable igd_opregion_e820_pages,
which would mean the new header would also need to be included in hvmloader/e820.c.

> 
>>>>>> +    printf("guest OpRegion tentative "
>>>>>> +           "address: 0x%x\n", igd_guest_opregion);
>>>>>> +
>>>>>> +    if ( !verify_opregion(igd_guest_opregion) ) {
>>>>>> +        printf("error: IGD OpRegion signature "
>>>>>> +               "not found.\n");
>>>>>
>>>>> No full stop in messages please.
>>>>
>>>> Would it be OK to just get rid of the error message here?
>>>
>>> That would then leave ...
>>>
>>>>>> +        BUG();
>>>
>>> ... an un-annotated BUG(), which generally isn't very nice.
>> 
>> I don't think I understand what you mean by "No full stop in messages..."
> 
> That's the period at the end of a sentence (when in log messages the term
> "sentence" is of questionable nature).

Ok. I thought you were referring to the BUG() statement which fully stops
the guest.

> 
>> We have code like this in hvmloader/e820.c:
>> 
>>     if ( rc || !nr_entries )
>>     {
>>         printf("Get guest memory maps[%d] failed. (%d)\n", nr_entries, rc);
>>         BUG();
>>     }
> 
> Well, you'll almost always be able to find bad pre-existing examples.
> 
>>>>>> +    printf("VBT size: 0x%x\n", rvds);
>>>>>> +
>>>>>> +    if ( !rvds || !rvda_host ) {
>>>>>> +        printf("guest OpRegion address: 0x%x\n", igd_guest_opregion);
>>>>>> +        rvda_host = 0;
>>>>>> +    }
>>>>>> +    /*
>>>>>> +     * Write rvda_host as 2 successive 32-bit values
>>>>>> +     * to communicate location of the VBT to the device
>>>>>> +     * model. If rvda_host is not 0, The device model
>>>>>> +     * unmaps the OpRegion and eventually maps the VBT
>>>>>> +     * after we also write the guest address where the
>>>>>> +     * VBT will be mapped.
>>>>>> +     *
>>>>>> +     * If we send rvda_host = 0 to the device model, it
>>>>>> +     * will assume we do not need OpRegion 2 support and
>>>>>> +     * it will not unmap the OpRegion.
>>>>>> +     */
>>>>>> +    pci_writel(vga_devfn, PCI_INTEL_OPREGION,
>>>>>> +               (uint32_t)(rvda_host & 0xfffffffful));
>>>>>> +    unsigned long rvda_host_upper_32 = (uint64_t)rvda_host >> 32;
>>>>>> +    pci_writel(vga_devfn, PCI_INTEL_OPREGION,
>>>>>> +               (uint32_t)rvda_host_upper_32);
>>>>>
>>>>> Why would you need to communicate a host property to the DM?
>>>>
>>>> The DM cannot access the host rvda value because it is only accessible
>>>> from the host kernel, and the DM is only a user-space process on the host.
>>>
>>> I don't follow this: Anything the guest can access should also be accessible
>>> by its DM.
>> 
>> I think the host OpRegion is not currently accessible by the DM.
> 
> Can you explain to me how the region becomes accessible to the guest?
> That would then (hopefully) help me understand why the DM would not have
> access. Fundamentally any MMIO and any I/O ports that are assigned to a
> guest are also assigned to its DM.

Currently, in the device model (Qemu) we have:

    ret = xc_domain_memory_mapping(xen_xc, xen_domid,
            (unsigned long)(igd_guest_opregion >> XC_PAGE_SHIFT),
            (unsigned long)(igd_host_opregion >> XC_PAGE_SHIFT),
            XEN_PCI_INTEL_OPREGION_PAGES,
            DPCI_ADD_MAPPING);

That statement is in the igd_write_opregion(...) function in the
hw/xen/xen_pt_graphics.c file of the upstream Qemu source.

If I understand our current implementation correctly, this statement
is what gives the guest access to the host OpRegion (3 pages as defined
by XEN_PCI_INTEL_OPREGION_PAGES, and in agreement with IGD_OPREGION_PAGES
in hvmloader code). I don't think this statement makes the host OpRegion
accessible to the device model, though, so I think, if I understand your
comment in an earlier about my patch resulting in what you called a "layering
violation" correctly, that our current implementation is also guilty of this
same kind of "layering violation."

So, how do you suggest we fix that?

> 
>> On the KVM
>> platform, this is made possible via the kernel vfio driver and then Qemu exposes
>> the OpRegion to the guest using the Qemu FwCfg device interface. How should we make
>> the OpRegion and VBT accessible to the device model and then, to the guest, on Xen?
>> I think it could be done via the xen-pciback kernel driver. Should we do that
>> instead? I think to do that we would have to convince the kernel developers that
>> the Intel OpRegion, as you say, "should" be accessible by the Xen device model.
>> I can imagine them saying, why not use the vfio driver?
> 
> I can't answer this; all I can say is that it feels wrong to involve e.g.
> xen-pciback here.

Ok. I guess we need to wait for other experts to weigh in here. I have never looked
carefully at what xen-pciback does. I suppose one of it's jobs is to hide access to
the resources of the passed through device from the dom0 kernel but I am just
guessing about that.

> 
> Jan


