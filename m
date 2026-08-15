Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D09C5CFDB
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 02:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wv42p-0001FE-E3; Fri, 14 Aug 2026 22:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wv42n-0001Em-Qb
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 22:22:45 -0400
Received: from sonic314-21.consmr.mail.gq1.yahoo.com ([98.137.69.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wv42k-0001vf-NL
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 22:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1786760559; bh=CLpGYCy7VH9tbCFcx31pYD25f1NCaJP0agxFleGx21w=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To;
 b=hPUs3/T220imsYRwTnTs3SNyEy29C9a4YXSDp9BxfEPmPg+p7ZDlFYDDU5GIw0scjBep0WbNhImUJtMZ+s3Dv26ep12nvailMqPCBgGkFcSZiKfIVnJBlJ/E36WJ5juxiLKNCGry93lZgp6+4lT6AK4yDJCXm/E09P5mgJ1fbYHeK0oAG0UwGrVgybsIS1+FTHJR1gv/uiHwner6avhLdseF8dmltuPMEAMCB5eUxHPal4PWOHmzHmmCIWJCLoCABocKvV4jYPsI2CJ4wY6UDscuOn6OESlTJ524u/yN0PD+/eQZ8eVpPI54wVIp0KfKW6jNd5BzxrIFoNBhjzTkBw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1786760559; bh=h96SNf96bcHIDxH1RsNcztY/Vg4ZK3Hcpqd89dIfhgn=;
 h=X-Sonic-MF:Date:Subject:To:From:From:Subject;
 b=Z/ekAq26F0eH12LalJNV6fgSf6IZuMcQdqQlW80dVKdvrFnvHUE8EY3gjHT+Vb+TPlFTSbTum65uSvC3/rC9IE1/K8WCw/H/pcpalInUfnXNNu4u5Rxd4HImJYK02QI0awN+SEldJIUGZZb2qbAJe83/tLO4+lZCHeS9O+FW5vqSixlT2FJO2rodfqsL9GDgM1fmvpgHHdmPJkHRyE3e+VYhz0sHvQSOHF3jQDWWqAohT5fqIze3cjfF1txatfHeATGz8JEV6Lv18pAUp9NmL9H2uzvyRkwkk9tgfCIajCDHANTs+Oh3LWzdtA8Q9zkrUyFgR5VVcFrW3Rr+mgxRNw==
X-YMail-OSG: kyDeJDUVM1m5N.EDhqlg8Zjz2pz7Gg81Re3vcuDClo5eDZlDUL07aTzgrL6TDjb
 7BXAYOovtrgs.0ocyyCeJdnKGgU9bSoMhehaaOhosrdrWFdoTkkoR.B7paQWHooB3FkbivnRhpPE
 5fG6AbfwtDkvKjuh67gUiWkf5ZoTPFIkzJ5Pb2f_XNiCsHmzOI.o0lx39oAHM_FrDvLwDcWvsdcd
 rNZjXrIsTrspMZih5rKjojkqlFr7vgjxSCkCRK1XssYYObb1VfFRU6G9fTw6GAqmMT.E_NgWVGi5
 B6tAiHoQWY0hf3eUXJ9wKIK2I.rImQvMTW3Ihd0D8e97Hv.lE67JfHpVihaZLXIl9kb1OL6gjuk.
 _A7S5y18dpflgPaxtOJRLvTEsLyHjHpKM7OI7hWQMG96e4DlC0EBQ__nM91LVqnBeGGSh5nlD8qH
 lbdoPbEpzDvXU2K.lTm.hTPmpco055hX3IIAdy1MvvS6V_hOoeNUasksD3naR1g0q2zr6mbVFaMf
 LwmQ.EYSZA4kJu2c9cBvLVQFKO8LdchHXd_C4xkkLbFvMTaDpIWJBjcguYiNl4gN02YcpY2Jdk6s
 _9zm5rhA2pLjfDOT8nvPzO.pwQ2Vo5wE5TFVNxEZ6B4XvnQfOrMAB04G2AVXVIjHCip8hamX9Pu9
 87dyxQuwGvWsbtvfAdYQb3JRkCC029FioteDecD7ULfNKAlySg_jY.YIHVCOIKGxVsejthF3myfm
 Wiy7YWCLr5NIHIstZ_zCmhRH7TX4f_s6f_tzpxBvA0CQRKY1DmCwc5fJQjO1NXFRBop71N6v0d6p
 0k0Hq79oKpbpe3ealU0NDFqMfXkQ4cY3UpW_.AOG7CJnwcX0rd3TpodPRusQvxxD4XeD_wMACDg3
 iNsz5j_HUTQdHisAqzXOzvDQhtIDRFHjPjxzFIqd.hv9sagBngHocWGlNm9SKNlOYjeX6lqQH53d
 u9G_s7hjvGQxo0akid4OaM99jVyHYNW6AgHfNvKp.R_m94Ih0tKX52CVLTdVGwV7kLpr7jSjEChr
 97hky5csWo02Iw_1G37GPGQLhgEiP8TBC4jjJO5E9GY3XhCXE0EmjjixwQNkdKocO_Kq6OhDj76N
 bfAkiOhrXz2iOEKQFZQtxvzfjqh_oSSaaN24AsQIm3mStUMkEhDLvZAAw2PfuaE3vMUbYg4Jvkh.
 t9b9nt6WJBkMg..9sp46NaHdt5jv.d2Rh4K70Spfrf69l7UXkYoMtEdhYmHGZqhL3C88BGEgbiWW
 EewFUzEeFORs28jAvJMOnZYGR_pTbCKJ5CnTeYDqBe0Q289i5PdhjlzquJYq4BNr9tRTi6FY4z4j
 9jY.F09gk5XhIVz7_.5vo_4K_JKgUEazmccSJEQyya1Og3GFYxJ2SkooqHKE55HtDm4wFuzNaE4K
 IbN4QVfluL8i2O6bEis9ZKlQpl0DwsHE0j5DOTTMA.GkbdQZG29RomROpWFUy74vspQTHpnMZZ9U
 1WJHGTAfvWqr4189j_kfxKAAhu0_VY2.znku1_PMfAhAs4ar19xlevsh5q.ib4KFOrsxUsho73Pk
 GnC9hpL0q.zwnb5XaK7vGHkgHadcVZcMxFm19ebgqlDZN_Y49JoA4eHsV2CzFOXufxFXuoXhR_AR
 JD7WyWPZhYtxo0GChvYLcJ0N2VrUpf1f6OQ7CMRO_SrssvlEiYxK1eHAqg0j.CVxnHmwc7xaFpO7
 ASdeYABxe7a64lUjvqnFZSc4iNlu90OJ5affqIMa8XQbUaDw2o3CrUGYgf14XZIRrWlWBykaQpkH
 EXOMCNf6JnWMPcu7oLZaGo126YLQQOBds1KnHvOOCUOtESPXjCdMz8DTSxjh0zhvuMJt_SXlw5hv
 Fa531zAA7yah7xL5M6Ryq6rXpYESIrlwTe74EGxJrCySHQmMcpuPiDILR2P.2.Hgs0GEb_75rkjW
 uY2.NOmNYWZLlgIqpwAENfL_31t9u5sha6GNJyiaBw1JE6ycBUdyXFNfVjgfhs4cLCiVRbFKXAI7
 aLDJfMqkiqVa2i5H.ls9Yjr7o0y46fBRzyUw6QQEnJS8OP_dZ5ptOeJ_DFIktEZhcTOdifqumfWA
 _ZlZp9xHZOfbJCciSLTvSjd5bRCgeJjDNqIMtSayKBa3xwitzCBZQMEWA5n_OMLcWo3i0ueG8NHD
 w9iFuRAlI52pD5NsqHzCj9.cH4tPYJqg3E0.91ZSrWVWdhzhEA4VsrlTTwcsgx1s_bc3UrZivG67
 v6p8_QwFdkboyfP3hBxvpQI3oT8O3.hPJKGaYuKE2.94kZDY-
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: a9182707-1c7c-4e68-8f12-489dc0538d02
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic314.consmr.mail.gq1.yahoo.com with HTTP; Sat, 15 Aug 2026 02:22:39 +0000
Received: by hermes--production-ne1-6dbcb84f44-46ggn (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID a5e795f747df51b797a85135c10a6553; 
 Sat, 15 Aug 2026 02:22:37 +0000 (UTC)
Message-ID: <9cf5c34b-65a9-4e19-8dfb-9f1264988d5b@aol.com>
Date: Fri, 14 Aug 2026 22:22:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tools/hvmloader: implement Intel IGD extended VBT
 support
To: Jan Beulich <jbeulich@suse.com>
Cc: qemu-devel@nongnu.org, Andrew Cooper <andrew.cooper3@citrix.com>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger@xenproject.org>,
 Teddy Astie <teddy.astie@vates.tech>, Tomita Moeko <tomitamoeko@gmail.com>,
 xen-devel@lists.xenproject.org, Anthony PERARD <anthony.perard@vates.tech>
References: <20260802050824.10554-1-brchuckz.ref@aol.com>
 <20260802050824.10554-1-brchuckz@aol.com>
 <2110d4b7-ae37-47aa-99be-ab59e16f6167@suse.com>
 <67579eba-e222-41dd-84bf-8440d2eaf2a9@netscape.net>
 <da2200cd-def7-4cce-a6c2-9f9ac9e202ce@suse.com>
 <de56c8bd-f0e8-4fe9-8cf5-f6807698176c@aol.com>
 <02a7dc18-4184-4e86-84cb-121769187f71@suse.com>
Content-Language: en-US
From: Chuck Zmudzinski <brchuckz@aol.com>
In-Reply-To: <02a7dc18-4184-4e86-84cb-121769187f71@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26254
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
Received-SPF: pass client-ip=98.137.69.84; envelope-from=brchuckz@aol.com;
 helo=sonic314-21.consmr.mail.gq1.yahoo.com
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

This is what I don't understand about your objection to how both the current
implementation and my proposed changes makes the host OpRegion accessible to
the guest. What do you mean when you say any MMIO and I/O ports assigned to
a guest are also assigned to its DM? What does it mean to assign an MMIO
region to a DM? Is it the DM you mean or the DM domain, which need not be
dom0 if we are running the device model in an unprivileged domain. I also
am presuming you know that dom0 for Intel IGD passthrough is a PV dom0,
not a PVH dom0. I have never tried Intel IGD passthrough with a PVH dom0,
because as far as I can tell vt-d is not supported with PVH dom0.

Take a look at this code from our current implementation in qemu-xen. This
is from the current master branch of qemu-xen on xenbits.xen.org, the
hw/xen/xen_pt_graphics.c file, the igd_write_opregion function:

--- snip ---

#define XEN_PCI_INTEL_OPREGION_PAGES 0x3
#define XEN_PCI_INTEL_OPREGION_ENABLE_ACCESSED 0x1
void igd_write_opregion(XenPCIPassthroughState *s, uint32_t val)
{
    int ret;

    if (igd_guest_opregion) {
        XEN_PT_LOG(&s->dev, "opregion register already been set, ignoring %x\n",
                   val);
        return;
    }

    /* We just work with LE. */
    xen_host_pci_get_block(&s->real_device, XEN_PCI_INTEL_OPREGION,
            (uint8_t *)&igd_host_opregion, 4);
    igd_guest_opregion = (unsigned long)(val & ~XEN_PCI_INTEL_OPREGION_MASK)
                            | (igd_host_opregion & XEN_PCI_INTEL_OPREGION_MASK);

    ret = xc_domain_iomem_permission(xen_xc, xen_domid,
            (unsigned long)(igd_host_opregion >> XC_PAGE_SHIFT),
            XEN_PCI_INTEL_OPREGION_PAGES,
            XEN_PCI_INTEL_OPREGION_ENABLE_ACCESSED);

    if (ret) {
        XEN_PT_ERR(&s->dev, "[%d]:Can't enable to access IGD host opregion:"
                    " 0x%lx.\n", ret,
                    (unsigned long)(igd_host_opregion >> XC_PAGE_SHIFT)),
        igd_guest_opregion = 0;
        return;
    }

    ret = xc_domain_memory_mapping(xen_xc, xen_domid,
            (unsigned long)(igd_guest_opregion >> XC_PAGE_SHIFT),
            (unsigned long)(igd_host_opregion >> XC_PAGE_SHIFT),
            XEN_PCI_INTEL_OPREGION_PAGES,
            DPCI_ADD_MAPPING);

    if (ret) {
        XEN_PT_ERR(&s->dev, "[%d]:Can't map IGD host opregion:0x%lx to"
                    " guest opregion:0x%lx.\n", ret,
                    (unsigned long)(igd_host_opregion >> XC_PAGE_SHIFT),
                    (unsigned long)(igd_guest_opregion >> XC_PAGE_SHIFT));
        igd_guest_opregion = 0;
        return;
    }

    XEN_PT_LOG(&s->dev, "Map OpRegion: 0x%lx -> 0x%lx\n",
                    (unsigned long)(igd_host_opregion >> XC_PAGE_SHIFT),
                    (unsigned long)(igd_guest_opregion >> XC_PAGE_SHIFT));
}

--- snip ---

This function is called when the guest (i.e. hvmloader, seabios/ovmf, or
guest kernel code) tries to access (write to) what is known as the ASLS
register in the PCI config space of the Intel IGD. The config space is
256 bytes long, and the ASLS register is the last four bytes of that space
according to the proprietary spec from Intel for the OpRegion. So the address
for the ASLS register in the config space is 0xfc, and the four bytes stored
there is supposed to be the address of the OpRegion according to Intel's spec.
That is fundamentally what we are trying to do here - program that ASLS register
so it points to the location, in the guest, of the OpRegion. If you examine
the code above, you will notice the call to xen_host_pci_get_block(), with
XEN_PCI_INTEL_OPREGION as one of the parameters. Did you look up its value?
It is 0xfc, the value for the ASLS register in the Intel spec. How does the
DM, qemu-xen, get the value stored there? Well, the xen_host_pci_get_block()
function accesses the PCI config space from the device model not directly as
kernel code or platform firmware code such as hvmloader or OVMF/Seabios could,
but only indirectly, through the 256-byte config file that is exposed by the
Linux kernel sysfs interface at /sys/bus/pci/devices/0000:00:02.0/config in
the Linux host filesystem. If you don't believe me, take a look at the code
in hw/xen/xen-host-pci-device.c where the xen_host_pci_get_block() function is
implemented in qemu-xen.

So the device model can, indirectly, access the PCI device's config space
because the Linux kernel exposes it via the sysfs interface. The point is,
the DM's access to these resources of the passed through PCI device has
nothing to do with MMIO or I/O port mappings, but is entirely dependent on
the host dom0 kernel for access. But sysfs does not provide access to the
OpRegion, that is, the actual two pages that comprise the OpRegion whose
base address is the value stored in the ASLS register. That is fundamentally
why the DM does not have access to the OpRegion.

Do you understand now?

Chuck

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
> 
> Jan


