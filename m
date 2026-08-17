Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3F8C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 16:04:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvzpN-0004KP-24; Mon, 17 Aug 2026 12:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wvzpK-0004Jx-Bn
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 12:04:42 -0400
Received: from sonic309-21.consmr.mail.gq1.yahoo.com ([98.137.65.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wvzpI-00078C-AK
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 12:04:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1786982676; bh=kW5c3iq1F6UiN1+G4AWz6LGpAojyDpS6Xdqm9qTL/OM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To;
 b=hpAxfWv6Gb2a8QcO+Dte9x4fOxzG5Pr6Fdd024s/I/OEywi4AUJh8ee2qNIOX4Vyt7ba95h7ZooSZ9oj42o4ZjCdhmpQAEJtEVRNJGN3EsRd28lgttmNT9ES9nyP/GQlfZ8sXW6FVwPvHwDxpV63bSJleeMkaSI5Np1rfHs3v9M13Ir1ABlg2X8cozpnfeKHHIERZMuOIM1PO58KKjV5ywL9Aqwm/jyPtS5kC5GoORzf2XRw+yiYj3+QGADZ9LmiTS7RIK3c2yRebDe4ezzWGs12cCxc496qLBSW8tYl6qMYyi3jjboBhG7O/+A/90WZV9le5AolpooakRHU3blKPw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1786982676; bh=NsuSy2jgaze1RNyCPmJ/TICjkp37hf9r0mtC19/DrcU=;
 h=X-Sonic-MF:Date:Subject:To:From:From:Subject;
 b=FctgtNKRR6HKWoLV9khJk2Xy29ZVlR1klnaG0sAWnPeO4HSgFMBS8MF6vMyIz5mxZm/69tYKiv9ulYqv0rhHZcCAJV/5dQDz9G3yD2oquOgxpvfS06J0hM8aP7Tqxl9GU5Uh9ITP4XG7oIPUypePyonwe98zaTN7ka9OuyGg8GYGNJRl7gTcUIXmqn+Z/0APlQYdq0tJMeJveoppbiO0Zlp02eBV908wI+8Cco9wyk98w93eLdbweJLH8C85ygjp8a99rKQzp1/4ecfq7bMKfgCL6phMPB+t1Pp8X49PkbGLd5uwCmulmIgR/1AfLIn4bkLPfustdow+CzredzAjIg==
X-YMail-OSG: nsFWtHQVM1maVCM_WIfpU.FdUWH6_7poqfjBjmtUjJ2ahZXT3SB_cCwkxZM1Kt1
 wtvgbJomoUQRNV5VfGii5S95KNhfu96JiB7mxBWYfjqIpgUwy.6O9iZCwrKcASSYVGJbBU9fcSBW
 eawx4vQKgAnn31bRI3vQuG3ES8iPqbpCJWCho3sqwmLWe6LpONtke59cMYlfSXAD.K.BReNsucwF
 iYTZk4uSep3mWkW.E0PWNWI_mJptAgLjID1dMdncOmxDwaDSjIF.qBsZcb_be5AaPhxcmyRQkwb5
 QkXmbGK9W6dYf0nz18EzlQJjU.cOhoYCVN7l._DOw9i0n1KN.YBIo.qBPy6RuNsBtiuvSaNNXsxx
 DqWZmYyq6rDsqKVlIQpKnXGMQULsO2QYh1nN8dGBVQ_c4YyLCcbE7RDe5yh.SSBikDU_b0TglDGH
 1ksIXUz5dnWwsvSmzzl2C2ZT5bKB13aysIo9n0b1I5Yysc.KKoAe85jy7_lKXgPy9rZmpJkj80cN
 jrKZo_gTp0xu9SMRlYlHF4lRjH9tb4sS1g1xxSoeAPDEC6Gh7n9TVwOXVZsxb04vdcySNZ57QyoP
 FQHw86V9PFxgjSPY1mGeyRJCmwxtkMBHos.m41_AIi_swP_apTuFF2KjKryO2benBSh.EVI3hHzL
 NoP2zUPYn8r1APrC6FapsWIH_SQiP6W4T7MDbKqAKY9e8IV4.YX4NpjSv9nFyecg.52m.FNXM2tr
 ol.lWOexVwkV1Ym.tIM4syT3x0BcVwfEdyJhxXM08.r0.dW_fn3aPGIoz0j7C32uEVCbnHbO.TdA
 27DIJNowBUNfhgQOgQ2Y3Tvc5.75yMAMz0MPIdmolfmzftjQh4jqRcKtH8X3zRZMM7i7Q5mRp_Ml
 eyQ3t9b4kFn1FyyTPWKniqGi7LpSL60u7ZGBhOrPQWoPjYYjpwNyud94Ka4EEq.UjkjigaLS_yjm
 pZ2W0bND50gO10mMbcE1KYIXGzqcLRpPMrZSYSwBgiImtKhbpawYq1wXk2OWhd_bKsVpWjFR1S7Z
 EZdqbh7rfxISnCrsxRMJHUJYDYBvGPUMmG8pUrdVb9meoI1C1pN_Z2Gry2_Kq9lUhRMgjhvxRxmq
 iggm8j8FoIRxrAvHVb7uBOAcu76g_I5vIJoIJFi5aEDm3DN6gA9QdIdQXUgfY1jFxEWTQubtpZxC
 p_sOyf4ICjlwio45.Njcn9gzVYSLOgQeXo4z0czae2Liq.wDcTowWSe6Q5BHNZrIqAVupyzPYgBM
 MViQTPDxNu6PIcY8bGUJ3rspCef054DI82gk0inGuiT2T1IXoJqci587ymIjuGEJLz3QEyUflk6r
 4WZ3ebEoMtaiouOrglzqetR.HuhwuWhTHSyo3gm5_BuBqRuRlkqBOEh2nyvjFiMEUxrEgFWHtAlv
 1c4BcHduZqEgcG5BKyzTErGE0lJKq4QRSdiMdaab57iV9aFs2G1VXXpvmgDQ8svEV7C5a_5xNYJp
 FslFWjyl9LqDgO0bPrKxfTcZT1vQV.OZDhNt4HnuQTFOXpMpsNtHjORZh_jlmp7vXXOC8s_i6ODR
 g7cLRX0cdoiuYctPaAGIS153rM5Z4lpSjy_hFJFgGr322J_wRqa8Q6lzL4Stk5HwVQmzjuiPAVO.
 _OfjRSMJtRCwn.ByPM9YNCy..Zwo1qul7XemewH2wt7IEEtPeX1qdG8zESxSB_TayGIbxV3aj4Be
 7swS_R.pfWZHTFb_SZsb1XDrvBE958BNeZsSZ3FjHaJdGrFbEXTGhxRk7hWigBnqNCYNn8klWMdV
 mReNf.nzN0dE2RfIN5t.MExj4InVnHZAuRLkLNUPb2UIO8k_mPPD0uaR0m1GQmSpw5fR58jAkbHC
 E_5OCfB1zA5fVIogAERWK2VwUxq.26uWMikobRvpoR28QuBdrBBeEtfgJcJr47A3tWCNgGk7eVXX
 j2HYk6.bAE2Us98mjPjTKlyMTICJiDzMfx8Lf98bQPcYxkwaLiRnQCw1tAwAeiyu1JRs4RnQrx71
 ZgMGFYS_QJKA0pdyXwkVZNDfa7hfhE_sPQ8_PafKsvkW6hjk8UFhX9GXfeRDZVvedpcdoYr4Mdz2
 GK4AH9xDWNwyFI5ZrNBTj74pGuOXmFOjC3vPv6RF1x7LhNbmXVyfJGPgaIOs4s4d7tOpGS5cZXjg
 MhjQ.XTVAR8FOWhO7F_wNQpRWI407GM7zWS6qgseeTxnKjOs1AedIcvtS.lrPUlUooOpgqIFQoHH
 BXsHEwZM09egMih1R.jCd92ovEqXw3JamRf96KIpTKbE-
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: 9e1a9e8c-efa5-495a-a07f-bf24d83300bf
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic309.consmr.mail.gq1.yahoo.com with HTTP; Mon, 17 Aug 2026 16:04:36 +0000
Received: by hermes--production-ne1-6dbcb84f44-46rwf (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 98ae4e748b194883b83f02ba26d804c6; 
 Mon, 17 Aug 2026 16:04:34 +0000 (UTC)
Message-ID: <fdec0b6b-eddf-4a36-a755-c67963daa9ea@aol.com>
Date: Mon, 17 Aug 2026 12:04:33 -0400
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
Content-Language: en-US
From: Chuck Zmudzinski <brchuckz@aol.com>
In-Reply-To: <d6e603bf-8dc5-4ac7-842f-ff9d1f67b98f@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26254
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
Received-SPF: pass client-ip=98.137.65.147; envelope-from=brchuckz@aol.com;
 helo=sonic309-21.consmr.mail.gq1.yahoo.com
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

On 8/17/2026 4:42 AM, Jan Beulich wrote:
> On 14.08.2026 17:23, Chuck Zmudzinski wrote:
>> On 8/14/2026 9:46 AM, Jan Beulich wrote:
>>> On 14.08.2026 15:18, Chuck Zmudzinski wrote:
>>>> On 8/14/2026 3:35 AM, Jan Beulich wrote:
>>>>> On 14.08.2026 02:45, Chuck Zmudzinski wrote:
>>>>>> On 8/13/2026 6:35 AM, Jan Beulich wrote:
>>>>>>> On 02.08.2026 07:08, Chuck Zmudzinski wrote:
>>>>>>>> -- snip --
>>>>>>>> +    /*
>>>>>>>> +     * Write rvda_host as 2 successive 32-bit values
>>>>>>>> +     * to communicate location of the VBT to the device
>>>>>>>> +     * model. If rvda_host is not 0, The device model
>>>>>>>> +     * unmaps the OpRegion and eventually maps the VBT
>>>>>>>> +     * after we also write the guest address where the
>>>>>>>> +     * VBT will be mapped.
>>>>>>>> +     *
>>>>>>>> +     * If we send rvda_host = 0 to the device model, it
>>>>>>>> +     * will assume we do not need OpRegion 2 support and
>>>>>>>> +     * it will not unmap the OpRegion.
>>>>>>>> +     */
>>>>>>>> +    pci_writel(vga_devfn, PCI_INTEL_OPREGION,
>>>>>>>> +               (uint32_t)(rvda_host & 0xfffffffful));
>>>>>>>> +    unsigned long rvda_host_upper_32 = (uint64_t)rvda_host >> 32;
>>>>>>>> +    pci_writel(vga_devfn, PCI_INTEL_OPREGION,
>>>>>>>> +               (uint32_t)rvda_host_upper_32);
>>>>>>>
>>>>>>> Why would you need to communicate a host property to the DM?
>>>>>>
>>>>>> The DM cannot access the host rvda value because it is only accessible
>>>>>> from the host kernel, and the DM is only a user-space process on the host.
>>>>>
>>>>> I don't follow this: Anything the guest can access should also be accessible
>>>>> by its DM.
>>>>
>>>> I think the host OpRegion is not currently accessible by the DM.
>>>
>>> Can you explain to me how the region becomes accessible to the guest?
>>> That would then (hopefully) help me understand why the DM would not have
>>> access. Fundamentally any MMIO and any I/O ports that are assigned to a
>>> guest are also assigned to its DM.
>> 
>> Currently, in the device model (Qemu) we have:
>> 
>>     ret = xc_domain_memory_mapping(xen_xc, xen_domid,
>>             (unsigned long)(igd_guest_opregion >> XC_PAGE_SHIFT),
>>             (unsigned long)(igd_host_opregion >> XC_PAGE_SHIFT),
>>             XEN_PCI_INTEL_OPREGION_PAGES,
>>             DPCI_ADD_MAPPING);
>> 
>> That statement is in the igd_write_opregion(...) function in the
>> hw/xen/xen_pt_graphics.c file of the upstream Qemu source.
>> 
>> If I understand our current implementation correctly, this statement
>> is what gives the guest access to the host OpRegion (3 pages as defined
>> by XEN_PCI_INTEL_OPREGION_PAGES, and in agreement with IGD_OPREGION_PAGES
>> in hvmloader code).
> 
> No, it introduces mappings of those pages into the guest's P2M.
> 
>> I don't think this statement makes the host OpRegion
>> accessible to the device model, though, so I think, if I understand your
>> comment in an earlier about my patch resulting in what you called a "layering
>> violation" correctly, that our current implementation is also guilty of this
>> same kind of "layering violation."
> 
> That code, if it can be successfully executed, indeed doesn't grant any
> permissions (to the DM or the guest). Instead it proves that the DM has the
> needed permissions to access the pages itself.

So, are you saying it should be possible, without any patches to either Xen or
the Linux kernel, for Qemu to get a pointer to the OpRegion? If so, how?

I think I could implement what you proposed in an earlier message and do
all (or most) of this in the DM instead of here in hvmloader:

> The more correct thing to do might be for the DM to
> put in place a copy before the guest (i.e. hvmloader) even gains control.
> (How in turn the DM would learn of the contents of the opregion is a
> separate question then.)

Actually, when I was developing this patch, I tried first to do it that
way, but the problem was, I could not find a way to get a pointer to the
host OpRegion in Qemu.

So, how can I get a pointer to the host OpRegion in Qemu?

This is what the handling of
> XEN_DOMCTL_memory_mapping has in this regard:
> 
>         ret = -EPERM;
>         if ( !iomem_access_permitted(current->domain, mfn, mfn_end) )
>             /* Nothing. */;
> 
> Subsequently we check that the guest is also permitted access:
> 
>         else if ( iomem_access_permitted(d, mfn, mfn_end) )





> 
> Jan


