Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0AA9C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:53:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwIMw-00018y-Ex; Tue, 18 Aug 2026 07:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wwIMv-00018h-1d
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:52:37 -0400
Received: from sonic314-19.consmr.mail.gq1.yahoo.com ([98.137.69.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wwIMt-0004ck-4B
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1787053951; bh=sNtOfKbb03VpboV/eXDRYXRmjekDpDgcWLU0H+gqS/c=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To;
 b=RGSSK8u6ivWLA8pbBSWRRm4kWyKoMhbwcgfd3bNsLdP2qtJ7oaBdzY9KXzcitP7s5ycE6jMFWWvppVN/LeAS3Eu/hG52ZFg9w4YJwpnC5zbEqCsdVW9R1VnkLrV3g1ioAJEFxdGWmL7hXSHv4ywcKxtJBqo314fPwdk2IsV5idDbJlxLlJn+y3aI4owTIPMdk4b4+alsAez1Qitc7GnjhSSxF7OV7zeb+oThYnp8TQtnnWsiPc3MI5+q3iTElqGCjbhu1m6YKkJ3zQhHLri8+gBhNwH0T/r/zXQbDImyK8Y/FCbMaHEAfyTF1/vnXI3EXWtW+X6EsMeWC9lp+6IsRw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787053951; bh=162KKrb6tNGVUFigS9uRpqS0iWM52o0F4QFQST5mPll=;
 h=X-Sonic-MF:Date:Subject:To:From:From:Subject;
 b=hKBlSFZ05MvCbQwwYC1k2tVo9vY6Fl2d94MikygqEJDWe3VM46YkQFizaGYWS9o3nD3cs4ImgN71mITEq8sXIoWP9VSB57wWCNaA6wqJvufkXJK5Rh6/MXwJS8YiPrV2uT/UsktDAJSqD9I6k/cZUyeH/zrih7aTOMz+Q4haJwROet7Fc/GuaCZ6Dq0bE9BgEu1uEfFpnvVvQ+lBG0RbboZpcbni5EhkLumAOqL7/28FRce/Tv1J3kbeM2ju1iR7br1YaZ3b5M4iWg1IgB4R5NGWGSFfgS+ISUBdgz9NkecpDGOe4xWgXSDmFbkZtdTw9CsS8FY+QwVQEdexb4s37A==
X-YMail-OSG: KiTq6FoVM1mVn3bZbrVWaG6dgjAKCC8Yv8a.qMQ1cyqACIXRq.c.2ho1crvBLTj
 BiPWed9iDAG3V18fxQo1wdT9cMDTqeMnpjZJ25F8BA3kuOZ7nZ.k9lqg6Bqvf36gQe7d6RyAD7h3
 k3yLUkhIJ0oaV1kqDmMMNpsp.IbHbm36GaLIhjQSeW_ZBX2A8s.v8snXt0GBs6RKOwK6r5z_6S5h
 tHsjLhcLXyeU6NBfxOQHUBm8YAVYBkAkNzcyKkJkk8qqnX9WU.CzsxkRqMfkec.48zNdLMYa5c7S
 XZiq10Uc4urT4dN2dznlQ23ctUvkz4ep_QWACIqLDuTFphmqrK5Qu9sNLdAvxq8qCCin_.yyht_U
 bf.yaCSENz.CHEDNDIJHwKE9qynUb8t5JsjEEO4FIV7jFwlCL7lJYI4q0cjnqnewEpOBHky3G6pZ
 UfS_IYnf632KwTLuSlRgCOTQ5iV6MacVUJMnHg5XUwWR33hHzbAeXWXZgJmGDFdSC3ySdUH9mIYI
 ONmmO5anRZ5_SWr5X0A9p_2QuNzDtRyDjlWLRe.ySGft.RzhhKqYvHIyLGl6hhrbwJ7aTN9UN61J
 XvGx32hq4HsrCR2nB7dS9UNhEIooesY7kuzjVwWXYRcad9KaUHuOhYhDBXJ_nQrk2DS1KKrqBv89
 gWkAsQpdLRafCLsa1WZLlkx.slX6y_USQp316X9s2.bYO5vNo89c7mbMc6z2auhXWIWR1LJOeb1g
 LAz1oWtEYzxsiJgDP_QEeKOugk3tGE_mdOD__.r7ZNqIGldCNr.tdFd_KDbugCKc.1gOcP5nFeat
 ZwkOinyILo5kizBrUIzEv6rz4Y1DoZK1yBEzQz3RmGtEi1LgnaaLSoUDkUIIWS8fO9oIzNMii4YK
 Frn3yVLOzfqYb1YP4I5tK04KzLlEn8F7HnXB458w1B3qfHqiI8mQ9CznYw06UxuGzOaUDSSL1dOM
 oGWihV1NM3SH7xdsUQ4hZK2XSA2evEBuQD7BRJ_qtCLjMXVOCi8gis5D_TO6wbPYdpqQF_wO9Ybr
 qTkjjoIBe9mRXeIOpFUEND5gb9cQ_TKzNRhRR4cXmyMpGoYkawdpxr72UpeNpWjwO3Xmr1njw5_3
 xSHGCzOXrojDvznJsdJhgHXUuijdJD0Ifm96JNzB4NUTBRG4VoVUHM5BfFtOP8htOV5R4PvTeDJW
 _PwKcDqZHyhMw.f0vlRe4eB2GHZf88E64g2WCVyuTwLHTgp3_fCi5Vvke6oJHL8BubpHJj6XQRM3
 PNe10xc3R252eEfMsOExj8I1xFeH53mg4kec6rHEknEcdsk.GIJk2HBZsinwX.HvYQ1CHw5pPHqO
 JNmB9hXGmJnSYZiuzawHVXe0HJmIUh1KpLbE8EpaC.._NIk1s7Yo_rgynGJjk1b.xpT594IJ9AJs
 0Zkzk0s00_6I5OwvfmkL2N7W3shjxT9wIzVKB.XL4UD17tJROW9.ESd1deONS2snKSs8.c951otA
 5h._PODebtDXHVDVQjCF3q6g8ZyfGo8.GlC_ACOEA73Zp6b2zAclceaQj5nF37XE8dhuLTWpbrTS
 BcekgYsSr1sLHERH1w.kvg3T989tSeobHqaZjwEVgADDkmpNcMUyIWGOERPTmMqyhKyE0Mkn1lj6
 O4eIOfi6H4_ZrH2a6dyM4rHYktmxSBYUFMDlmm_2WMrXfzucrRYXhCViyB7PtwcI81pLlaBZwswP
 7EvQOfzaeYJxCuMarwN.Bs.x7kyL.NclgcaAWIFVMtk9dpulvh6ywrwyiOKGqN_sCed05t3l_Nsx
 PTlqR10MWBBewAOuc5a2I.zKjDTtY.4BYWgukEoGGaayOijkLqGxSCPXscWR5Lt0HKv18G5ElZlw
 oeQZwLJOVcSIeKQzE2yNOyAFEOoODJjs6T9zOYRphyOGgK.6qBdqz0raVaRoPrxkeIUD9dhF55Cd
 UwCuKDOE3evToa9EWMYE0s7l0t_8MZl3JEzSaytgmSRaSl1A5HkTrw0V9RMiC_vTHNYFh5i3OWtc
 vTiCzi3sYXAMNx3JYqikyP0.RxOQVpb5cCdk3Oh.IHvK9NZu3ykHIyxgGnLcAp2lc89x_t.PZ_lm
 9LJ.vAkhFOTEEmNnHTEqNA9KVmMPEaWgFIy0_z5XaeKTZWsMU2HR1V_dSdWA66G.d8sNsJH7Rxr8
 eWsn4YH3mbTFxV2HsNhaGUCS8FtHkdlHV_5SHHSnHEC7G2plXeH2xfC.rIobb2F1QyKFeSnkxyoX
 DMsjJLQiEIFDkeorggb2SlSarQM.cpt9gvjov4cO1
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: 817225af-2dcb-4dd3-be27-e75fbd3ebedb
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic314.consmr.mail.gq1.yahoo.com with HTTP; Tue, 18 Aug 2026 11:52:31 +0000
Received: by hermes--production-bf1-54b5569bdc-mnb2s (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 84544e02033dbaed8688a630b01bbe20; 
 Tue, 18 Aug 2026 11:52:26 +0000 (UTC)
Message-ID: <bb44067c-6739-4e83-a0fd-cc7ea797048f@aol.com>
Date: Tue, 18 Aug 2026 07:52:26 -0400
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
Content-Language: en-US
From: Chuck Zmudzinski <brchuckz@aol.com>
In-Reply-To: <6ecf80ef-2f0e-44fb-beab-dbcf065a4431@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26254
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
Received-SPF: pass client-ip=98.137.69.82; envelope-from=brchuckz@aol.com;
 helo=sonic314-19.consmr.mail.gq1.yahoo.com
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

On 8/18/2026 3:17 AM, Jan Beulich wrote:
> On 17.08.2026 18:04, Chuck Zmudzinski wrote:
>> On 8/17/2026 4:42 AM, Jan Beulich wrote:
>>> On 14.08.2026 17:23, Chuck Zmudzinski wrote:
>>>> On 8/14/2026 9:46 AM, Jan Beulich wrote:
>>>>> On 14.08.2026 15:18, Chuck Zmudzinski wrote:
>>>>>> On 8/14/2026 3:35 AM, Jan Beulich wrote:
>>>>>>> On 14.08.2026 02:45, Chuck Zmudzinski wrote:
>>>>>>>> On 8/13/2026 6:35 AM, Jan Beulich wrote:
>>>>>>>>> On 02.08.2026 07:08, Chuck Zmudzinski wrote:
>>>>>>>>>> -- snip --
>>>>>>>>>> +    /*
>>>>>>>>>> +     * Write rvda_host as 2 successive 32-bit values
>>>>>>>>>> +     * to communicate location of the VBT to the device
>>>>>>>>>> +     * model. If rvda_host is not 0, The device model
>>>>>>>>>> +     * unmaps the OpRegion and eventually maps the VBT
>>>>>>>>>> +     * after we also write the guest address where the
>>>>>>>>>> +     * VBT will be mapped.
>>>>>>>>>> +     *
>>>>>>>>>> +     * If we send rvda_host = 0 to the device model, it
>>>>>>>>>> +     * will assume we do not need OpRegion 2 support and
>>>>>>>>>> +     * it will not unmap the OpRegion.
>>>>>>>>>> +     */
>>>>>>>>>> +    pci_writel(vga_devfn, PCI_INTEL_OPREGION,
>>>>>>>>>> +               (uint32_t)(rvda_host & 0xfffffffful));
>>>>>>>>>> +    unsigned long rvda_host_upper_32 = (uint64_t)rvda_host >> 32;
>>>>>>>>>> +    pci_writel(vga_devfn, PCI_INTEL_OPREGION,
>>>>>>>>>> +               (uint32_t)rvda_host_upper_32);
>>>>>>>>>
>>>>>>>>> Why would you need to communicate a host property to the DM?
>>>>>>>>
>>>>>>>> The DM cannot access the host rvda value because it is only accessible
>>>>>>>> from the host kernel, and the DM is only a user-space process on the host.
>>>>>>>
>>>>>>> I don't follow this: Anything the guest can access should also be accessible
>>>>>>> by its DM.
>>>>>>
>>>>>> I think the host OpRegion is not currently accessible by the DM.
>>>>>
>>>>> Can you explain to me how the region becomes accessible to the guest?
>>>>> That would then (hopefully) help me understand why the DM would not have
>>>>> access. Fundamentally any MMIO and any I/O ports that are assigned to a
>>>>> guest are also assigned to its DM.
>>>>
>>>> Currently, in the device model (Qemu) we have:
>>>>
>>>>     ret = xc_domain_memory_mapping(xen_xc, xen_domid,
>>>>             (unsigned long)(igd_guest_opregion >> XC_PAGE_SHIFT),
>>>>             (unsigned long)(igd_host_opregion >> XC_PAGE_SHIFT),
>>>>             XEN_PCI_INTEL_OPREGION_PAGES,
>>>>             DPCI_ADD_MAPPING);
>>>>
>>>> That statement is in the igd_write_opregion(...) function in the
>>>> hw/xen/xen_pt_graphics.c file of the upstream Qemu source.
>>>>
>>>> If I understand our current implementation correctly, this statement
>>>> is what gives the guest access to the host OpRegion (3 pages as defined
>>>> by XEN_PCI_INTEL_OPREGION_PAGES, and in agreement with IGD_OPREGION_PAGES
>>>> in hvmloader code).
>>>
>>> No, it introduces mappings of those pages into the guest's P2M.
>>>
>>>> I don't think this statement makes the host OpRegion
>>>> accessible to the device model, though, so I think, if I understand your
>>>> comment in an earlier about my patch resulting in what you called a "layering
>>>> violation" correctly, that our current implementation is also guilty of this
>>>> same kind of "layering violation."
>>>
>>> That code, if it can be successfully executed, indeed doesn't grant any
>>> permissions (to the DM or the guest). Instead it proves that the DM has the
>>> needed permissions to access the pages itself.
>> 
>> So, are you saying it should be possible, without any patches to either Xen or
>> the Linux kernel, for Qemu to get a pointer to the OpRegion? If so, how?
>> 
>> I think I could implement what you proposed in an earlier message and do
>> all (or most) of this in the DM instead of here in hvmloader:
>> 
>>> The more correct thing to do might be for the DM to
>>> put in place a copy before the guest (i.e. hvmloader) even gains control.
>>> (How in turn the DM would learn of the contents of the opregion is a
>>> separate question then.)
>> 
>> Actually, when I was developing this patch, I tried first to do it that
>> way, but the problem was, I could not find a way to get a pointer to the
>> host OpRegion in Qemu.
>> 
>> So, how can I get a pointer to the host OpRegion in Qemu?
> 
> You don't ask me this question, do you?

Are you offended I asked this question? If so, I am sorry. You make me
afraid to ask it again so I will not do so unless you permit to do so
again.

All I can say is that surely qemu
> has an existing way to map (host) physical memory; see e.g. how
> xen_pt_msix_init() (imo bogusly) maps the physical MSI-X table of a
> device. "Bogusly" there because that's another layering violation. Plus
> (independently) there and here there's the issue of how to accomplish
> things when not running in Dom0, or when running de-privileged in Dom0.

Well, that only proves Qemu *might* be able to access the MSI-X table of
a device, that is, if the calls to open /dev/mem and mmap it succeed.
Why is the MSI-X table all of the sudden relevant? Even if Qemu
can access the MSI-X table of some device, that does not prove that
Qemu can access the host OpRegion of an Intel IGD. So I think my point
still stands: I still don't see proof that it is possible for Qemu
to get a pointer to the host OpRegion without any patches to the current
implementations of Xen and the Linux kernel.

Perhaps I should accept your indications that it must be possible to get a
pointer to the host OpRegion. I will admit maybe it is possible and I have
not yet found out how to do it, but I have hardware I can experiment
with, and for me, that is the final authority. Proof for me only comes
from my own tests and experiments that I conduct on my hardware. Until I
see how I can get a pointer to the OpRegion in Qemu on my hardware and
actually realize that goal, I remain skeptical that it is possible to do
so solely by patching Qemu and not patching either Xen or the Linux kernel.

Chuck 

> 
> Jan


