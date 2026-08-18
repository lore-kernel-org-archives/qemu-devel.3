Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF12C5DF74
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwIxF-0007Wi-8U; Tue, 18 Aug 2026 08:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wwIxD-0007TL-2s
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 08:30:07 -0400
Received: from sonic309-20.consmr.mail.gq1.yahoo.com ([98.137.65.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wwIxA-0005gd-Cd
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 08:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1787056201; bh=jz0lsF7UaR5cFtfwz1uDrwFu8gHUr1wVACs9npDuP/I=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To;
 b=uL2qU2pLXjrDAW5zX4VClWEZ0aiLaXI/yO/XM4bHVUvsRJDmtfH5xQtYQPMN1ehzyMjQ5+wMDYe+KA9vww5fL9Ano0H5iDroljAe5pSpdxX+a/pDdx0Ti8lbsCyGyoueJ59hk5+W+ePqwuIsZbuYh67HPQy1YTSALsz08h3K1Gxb94VTbEen49f691UIjWKaZVdUSwscCsJd0dz20+aIG+9g1Cqy2R1hHxl73n0cOAGG462RgyOFMw89xH3jNBx9idtZgcoo3nixKPX2t4/oQSYDifID1RNPBalOyMZDBoNinbWPMez3nHGGFRuMR0CrS7wgSy/dQmOFqyROTXSoQg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787056201; bh=DdppHNbovwvCrHmNHrOUpcghqG/ObVCcXyDuVFT/Mb0=;
 h=X-Sonic-MF:Date:Subject:To:From:From:Subject;
 b=GwOcGaT8YLWUmlvX0c6iR7IsCTDfnyL59TWHqpEiuZamceYZU4zCOYzH5MGBcb7oqbQxy9znU5KlshcwJQWpSB0U0O5R5AXzgzaaHVMopxzUzwRiHHr117KTYhPeFHjRGcdlmx8Hb/YYR11JJf1dtZZ40b0K5mHeYs24Bql2Z02CrxWh/lXBPzfd/GPCvaxCmeDwEisabSsgms9wtNHiSvbFMR0Lw4oBkFiDKJ/adrutDYuTqu9ZMquKtgqX+QME5O+T8ROx2MyQTlmGyR7BfBha/8/4kIlL/9onyibAdJoWzbVJk9yhvH/SoNapjJJqN0OMAvbT7IP0d+BwRgnv6g==
X-YMail-OSG: _RgedzsVM1lCNngddMq0FFkG2OfsZ9VNbhI.CmnFjYpNxp47JVb9_CZs9bNI3mw
 27LwFJWq77gMSgfTqDeURmQv.tTupW88MwtG2QVMeEayxoBl7oe3ZJ8Sk6N.jfCmLRQFOuVs.4n6
 idJeV9ByJiiEaVU8QXhuW.V.rd6DFJ4JM8ysVSVAoh.xSymCJ5sqh7ODlOb5yWi6IzAZEkhG2Djx
 MWdyMe9QNggu6zKmITmk9ezCB057wyyZBIME96r_nA1rX5jwcw_nqhLooPWHysV2k.cocJJz4qVf
 gXDdvbo.4kP4VjNJxBWC.DFaXhb9jdsf7xKhgcDoPozUfDC.pg.yWtKROyLOEQkqYD3Th8jmeNMM
 vqTuWRKWfRYBNhHvwUXMTUD.Ps2UgSZiIWrPtrgnmoHpfWUHJEFmWEKGrSQV5Y1TBeIEfzp6ylvi
 sPAl6dSNcvjI2WiC2f0ZtJQQhUKfmTrkzTEhJJWTnBO2HT7b9yCRt6A1D9OqTUYRIEkhxcPLSCDq
 viZPcQWeoZI3WxN.c_PS7ExCQsleEDJzVvlzvZSOmsG6cQ_qByCcLRUu8l7d5cPq21OUBzzr2Lyh
 V23bquTnBvWuGquWw9oqIBEJp1wsrFzAsk_JfJaDBAPrPoMBCi.W37isi9xQUai5JZZHlAGfSGeZ
 mczWFgp5ioFvDoG79Fq3lrMvQNl1dfk_O8EBzrpjh2hE6SXhy.NjElHq6GL86vbjP5XshcmpwGGq
 6DT1dCabxtYuTyYGVslPMXqOg69KTF7XaK8afp0OYtMZK6y03us.32PsCTZwFcMnDCTVxAyg8FEg
 mxxOAZYVp1JqzePFISiDpoWtMTRwynl04YIMV2.1UQYjuhzMsl2U9q6oHXx6Q.ohYpVPk1vfRC1f
 6aQYV4cM1rE3NleN.9LN3p5ZzkKKE3ogRxh6xklvvVFR.uBdHYdPQxYMguyMnmqPjTveuW7MFTCb
 WCpycdw35m_PhN1L876m60ALNGVktD8bhwFAwEe3dxw0zFJDixvRyFkGPrnf_eNGo2AbKRxOBTsq
 hT.2C3jTKVkJBiPoUdfUWfhJLrP0JFWnIIVNKmSwBv5Xy_eiWcFBG8mDPR7d5CjtlRpZAUMts7h5
 PFnWf83IqoAQl9i9Zb093NsOzWbycsdsqQusdnM4ny8r6a.HqzAJrJ6wLD9YXIbSSSS3vyn9pI41
 n.Ep.G7Cv1U1S4fBLR8cVodyTmwy2zh0Ih1Cvng.KGs1bXrilwg.c2tg_JdK15cYBXOlO4y1P0Fl
 bOyI8VFXWHM0ziKnShysmRZBQ8Jr28X4vOUZmRw1091Yzs0VU3CrOxObbOWNDjLPKD3XHuckNqo.
 _9fGJK.GI1rI7XEsL2Mkvz7bFQ82kj8E8bq8VFdelxDB5OczLkDTbL_gI09NhO2u3bBJExGV7ogo
 qkRGrMeKSbRYxcEh73h25iRvMqD8tKB.XzYsaPU97zG_U8R91xF5OOdGKnYdF7nf2qUXMpGfEtOl
 cIuZeXvQd1hvZT0IvpkKULakrgS3z939dhlvvN4nGXK7PMajY8pZH7BU7EudVQbF07cwQTe5iY0y
 EPZooGHDFejw8kBFgb_e.gI8O_avQT46l1dHlDy2GWuyT3WH8RzPK3n.sxnRjbAVao1EwFbPdd.I
 mQsqAdon8.Hn7QqXobT4lqLVcd0cchRMJAwqxFMz7ctWeLXBElKYo2lCilejE7V8.Ys8ZrEghPmz
 GpKApktwuAkNYZVDjuYhx6tsa3jed48DFfE3siACv.TzU7JAPM0xhFbJTWokEgLJyACaP8QviFyZ
 QAE.f8.tMAiWo3EZX10IQiy2G95dKZnA2nvuJycW74jdt4aEG.mb4EuQ_FToJObQcPRuooT.JWNG
 hwo5Eglarp9s6_MLIdFK9uG1r9Bvdk.j_cdOMg2C1Czv3J8ZhpgzwWlm6WNHH1LtuQ2OKiAzEN1O
 16CJBgroC84WXR5USkvEcTEydb6xr1uZNIPvH2EvGBxX4qMw7e5xonVOUqVkVQAIdmI6Ah1TeoqF
 S6d3Po1TjZuKiYX0s9MfLlVwEMAGY9wkB14RJf1hMvzgSLwA3yyK22OGEM3YTgAWdBXWiinu5aNv
 8VNYZnap0U5prYHd6v.ww3SPeu8W5lgYjCUnNTSrlKqMqhPFcT_YIcgBsXTVTASEX_O9TLVJiMnf
 QE7O4C1gGvgjP9pAWugQHb.6iSsWj52uyV2QXX7BF__WzdaxqCrKxD98buMRnd096kXEO3sqwplx
 oFHayQxcPsQ9fuyOKN40Hk9xPIH3rp4MWM5X.ABHSZTuS
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: c47e0327-5137-42a7-963d-da8cd16b4b6f
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic309.consmr.mail.gq1.yahoo.com with HTTP; Tue, 18 Aug 2026 12:30:01 +0000
Received: by hermes--production-ne1-6dbcb84f44-9jslv (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID e5dc29c1a1be5ea329f6254e372ba29b; 
 Tue, 18 Aug 2026 12:29:58 +0000 (UTC)
Message-ID: <31a5870f-2a4d-4dc0-af9c-f0567e0f6fb3@aol.com>
Date: Tue, 18 Aug 2026 08:29:59 -0400
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
Content-Language: en-US
From: Chuck Zmudzinski <brchuckz@aol.com>
In-Reply-To: <4c58bda6-e9ed-438d-b96e-feda74a6c4c7@suse.com>
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

On 8/18/2026 8:18 AM, Jan Beulich wrote:
> On 18.08.2026 13:52, Chuck Zmudzinski wrote:
>> On 8/18/2026 3:17 AM, Jan Beulich wrote:
>>> On 17.08.2026 18:04, Chuck Zmudzinski wrote:
>>>> On 8/17/2026 4:42 AM, Jan Beulich wrote:
>>>>> On 14.08.2026 17:23, Chuck Zmudzinski wrote:
>>>>>> On 8/14/2026 9:46 AM, Jan Beulich wrote:
>>>>>>> On 14.08.2026 15:18, Chuck Zmudzinski wrote:
>>>>>>>> On 8/14/2026 3:35 AM, Jan Beulich wrote:
>>>>>>>>> On 14.08.2026 02:45, Chuck Zmudzinski wrote:
>>>>>>>>>> On 8/13/2026 6:35 AM, Jan Beulich wrote:
>>>>>>>>>>> On 02.08.2026 07:08, Chuck Zmudzinski wrote:
>>>>>>>>>>>> -- snip --
>>>>>>>>>>>> +    /*
>>>>>>>>>>>> +     * Write rvda_host as 2 successive 32-bit values
>>>>>>>>>>>> +     * to communicate location of the VBT to the device
>>>>>>>>>>>> +     * model. If rvda_host is not 0, The device model
>>>>>>>>>>>> +     * unmaps the OpRegion and eventually maps the VBT
>>>>>>>>>>>> +     * after we also write the guest address where the
>>>>>>>>>>>> +     * VBT will be mapped.
>>>>>>>>>>>> +     *
>>>>>>>>>>>> +     * If we send rvda_host = 0 to the device model, it
>>>>>>>>>>>> +     * will assume we do not need OpRegion 2 support and
>>>>>>>>>>>> +     * it will not unmap the OpRegion.
>>>>>>>>>>>> +     */
>>>>>>>>>>>> +    pci_writel(vga_devfn, PCI_INTEL_OPREGION,
>>>>>>>>>>>> +               (uint32_t)(rvda_host & 0xfffffffful));
>>>>>>>>>>>> +    unsigned long rvda_host_upper_32 = (uint64_t)rvda_host >> 32;
>>>>>>>>>>>> +    pci_writel(vga_devfn, PCI_INTEL_OPREGION,
>>>>>>>>>>>> +               (uint32_t)rvda_host_upper_32);
>>>>>>>>>>>
>>>>>>>>>>> Why would you need to communicate a host property to the DM?
>>>>>>>>>>
>>>>>>>>>> The DM cannot access the host rvda value because it is only accessible
>>>>>>>>>> from the host kernel, and the DM is only a user-space process on the host.
>>>>>>>>>
>>>>>>>>> I don't follow this: Anything the guest can access should also be accessible
>>>>>>>>> by its DM.
>>>>>>>>
>>>>>>>> I think the host OpRegion is not currently accessible by the DM.
>>>>>>>
>>>>>>> Can you explain to me how the region becomes accessible to the guest?
>>>>>>> That would then (hopefully) help me understand why the DM would not have
>>>>>>> access. Fundamentally any MMIO and any I/O ports that are assigned to a
>>>>>>> guest are also assigned to its DM.
>>>>>>
>>>>>> Currently, in the device model (Qemu) we have:
>>>>>>
>>>>>>     ret = xc_domain_memory_mapping(xen_xc, xen_domid,
>>>>>>             (unsigned long)(igd_guest_opregion >> XC_PAGE_SHIFT),
>>>>>>             (unsigned long)(igd_host_opregion >> XC_PAGE_SHIFT),
>>>>>>             XEN_PCI_INTEL_OPREGION_PAGES,
>>>>>>             DPCI_ADD_MAPPING);
>>>>>>
>>>>>> That statement is in the igd_write_opregion(...) function in the
>>>>>> hw/xen/xen_pt_graphics.c file of the upstream Qemu source.
>>>>>>
>>>>>> If I understand our current implementation correctly, this statement
>>>>>> is what gives the guest access to the host OpRegion (3 pages as defined
>>>>>> by XEN_PCI_INTEL_OPREGION_PAGES, and in agreement with IGD_OPREGION_PAGES
>>>>>> in hvmloader code).
>>>>>
>>>>> No, it introduces mappings of those pages into the guest's P2M.
>>>>>
>>>>>> I don't think this statement makes the host OpRegion
>>>>>> accessible to the device model, though, so I think, if I understand your
>>>>>> comment in an earlier about my patch resulting in what you called a "layering
>>>>>> violation" correctly, that our current implementation is also guilty of this
>>>>>> same kind of "layering violation."
>>>>>
>>>>> That code, if it can be successfully executed, indeed doesn't grant any
>>>>> permissions (to the DM or the guest). Instead it proves that the DM has the
>>>>> needed permissions to access the pages itself.
>>>>
>>>> So, are you saying it should be possible, without any patches to either Xen or
>>>> the Linux kernel, for Qemu to get a pointer to the OpRegion? If so, how?
>>>>
>>>> I think I could implement what you proposed in an earlier message and do
>>>> all (or most) of this in the DM instead of here in hvmloader:
>>>>
>>>>> The more correct thing to do might be for the DM to
>>>>> put in place a copy before the guest (i.e. hvmloader) even gains control.
>>>>> (How in turn the DM would learn of the contents of the opregion is a
>>>>> separate question then.)
>>>>
>>>> Actually, when I was developing this patch, I tried first to do it that
>>>> way, but the problem was, I could not find a way to get a pointer to the
>>>> host OpRegion in Qemu.
>>>>
>>>> So, how can I get a pointer to the host OpRegion in Qemu?
>>>
>>> You don't ask me this question, do you?
>> 
>> Are you offended I asked this question? If so, I am sorry. You make me
>> afraid to ask it again so I will not do so unless you permit to do so
>> again.
> 
> "Offended" is the wrong word; "very puzzled" may better get it. I'm not a
> qemu person, and I never have been. I can't really help much there.
> 
>> All I can say is that surely qemu
>>> has an existing way to map (host) physical memory; see e.g. how
>>> xen_pt_msix_init() (imo bogusly) maps the physical MSI-X table of a
>>> device. "Bogusly" there because that's another layering violation. Plus
>>> (independently) there and here there's the issue of how to accomplish
>>> things when not running in Dom0, or when running de-privileged in Dom0.
>> 
>> Well, that only proves Qemu *might* be able to access the MSI-X table of
>> a device, that is, if the calls to open /dev/mem and mmap it succeed.
>> Why is the MSI-X table all of the sudden relevant? Even if Qemu
>> can access the MSI-X table of some device, that does not prove that
>> Qemu can access the host OpRegion of an Intel IGD. So I think my point
>> still stands: I still don't see proof that it is possible for Qemu
>> to get a pointer to the host OpRegion without any patches to the current
>> implementations of Xen and the Linux kernel.
> 
> The MSI-X table (and it being accessible to qemu) is the best analogy I
> could come up with, as that's one tiny area of qemu that I know at least
> a little.
> 
> From a Xen perspective, this analogy should be sufficient: All you need
> from Xen is for it to permit to establish mappings of the underlying page.
> As I've pointed out when commenting on a code fragment you presented, the
> DM (domain) looks to have permission. Everything else is a matter of
> establishing such a mapping. There the MSI-X table code may also guide
> you. (Sadly it may also misguide you, since (a) I don't know whether it's
> appropriate to do things this way in qemu, and since (b) it is, as said,
> imo a layering violation.)

I agree that accessing the host /dev/mem directly is cringy. I would not
really want to do it that way for the host OpRegion.

Chuck

> 
> Jan


