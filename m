Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B9CC5DF88
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 11:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx1FE-0005iq-9g; Thu, 20 Aug 2026 07:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wx1FC-0005ie-SD
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:47:38 -0400
Received: from sonic304-24.consmr.mail.gq1.yahoo.com ([98.137.68.205])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wx1FA-0004Mg-IP
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1787226453; bh=+5d7AXa171OJ5dCFJA/kzsOo57trTNuDzCDddNQRDSs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To;
 b=YhXHa4yIXFkIUn5D7ALa0kF23LKD0NMA9xEKV9E1JwM7PMfNogzCYhl9uInPWtUMV8tPG28fbSvyIPOz4TRLAf32a54eXzZGXGujXfWmk6PDpPv8KrfebTjdLAZH7mNv8hu5UII10/l4iU6CZy0EyPbVCAvcDuK+pGcrpvmGG/gTP5Fdd3GuieTptn/fU998G2uEisWniYbgEk3aIV+6G1PCDRvMSPNiEcaXRoPqhygPzZbi0ulSJIh2dRt9EvnPB6Pej/I4Kh+1V65FzahFPPPZ/VfVOgDuNVpziTab8T8ZwVLeVarZuA7i9aC2vMZqLjl7q2y3mzHU94PehhvqJw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787226453; bh=cboGAWkQw2RHs/mc7qoC16boWmdtbzQ7JsaGLyaSP1h=;
 h=X-Sonic-MF:Date:Subject:To:From:From:Subject;
 b=TSK6RyH+M5Uqmd2PNjyMnY2wHeHsev2R82cGooSaeyh3k5Ti6POleiu6vhSsJ+a9WXiMz+Oy/yzH85ex74QckDrJ3HefeZ31e71Brfh8rBLW8DVeo+KCqKw1nvkDOqnLHiK4XqxZx7Sti8QxR9G2z4dut/lu2HmzJkwAm4JVFhicfdtfmIGEEN7sWOvYVfIzeDZylMPn8Qaq1/ZTyuyAcbr0pbPqthuUrioUpYJr2YK29/ekTESF5oJ1iznOUDCtQ+aaAei0z1TiTC24uawzoeRvZp27s5/Fw45HkBthLsKRPtxPXTDInoSuG1FQlFpOH99YgPpgz2GwUoNXs2jDvA==
X-YMail-OSG: GB7pZAUVM1mKxvBYwiVVEQClL7phZxOtEowzSykRFZ_SNvou9Pooum6eEVCtvST
 KR99QwhKJYRm8St16heiflFZSUwXclnywRhdFuanNGA8AgCKEhsBXKfpTbgYSVBZsxJ2K.VCTqZF
 aFEa1Z20LBmIixLlp5ggTOawykJ8ogUxwH_a78P0y9Nk3nmbdXmtj7w2MOh.qPo0TS5ter5E0AGj
 k_Tc7TXE5hSSaMBBUhOSW3P33Vgp8NvzcctRbS3_aYb9.Z9OrKXeCM_ZaMDBNl6oLqIPgJq1GtDs
 bIxr8xebpfxYWuKZTmfgNBkjQ50jktZRRDQEzU6wH4nL9c3OPErQizw6BpDn2wcud0AiYpe_6zlz
 kLIcEnK1azNIPWfHyDdB3JhwcmjcetU5G3yYBg0H9KJHbIlnmoJoZVA4BDJ2S6lQIbNYTiawzd1Z
 OavVACl.WzCLRss2FxnfmbJ_P4fo6DrJyE1y_8PbwqUUYJpGuG9m44672sEGGkaM0EtcNmHic.Q3
 9vU_z2YFC9gtxjG3GUck7lC22Fdc_D3iKVBuJJRjemKtbIhmM1GFFTtm.6.2Db9FmXedZzzZEZwa
 0rSoa.dG62XXMjETea2j7GOToF8mBw5PguYZfY96kViGASt2Buiikj8v9JeWYZHHAt4mrR9mUJQu
 Un..9C2eGNulEMkqd4Bb53cgBal55rq_1KHjiPLXN8BDPf6_hGR38heeLfBq2Ql1BxxlcPmXGKKL
 TUk.Cyp2Evxshyz65aKiaxezAGbQdq.t7zXUouzEEbPPyuCq2nhVjVj4xe7mqXwFOAPkxZMhmb9x
 qMOUwasjigjX3z06WrZNfqssN.gsbNP_EKXh0fbNDiPaQ949APs0cDqjaz_npMmmDTqK2uoUePVh
 2ux0tfklBQQGNJSHsxFReEeqcxl.bYY2hYyUIu_vS5OgBwQRJVX4S4GlcEj_vAubFSHDrI6Y258C
 aZy00VJvgme9sVWb_2T5OgNHBZgpEjD.t5FfACrGSVUCUaG7tpB9uyP.OfUrA5.l0YbhS_y6p_sm
 TWCCJZubrAtXWM1NBEq2uHmfpvzz0WqkOUqIGeRFz0XKreEquUN0Cb_w6qGiU_QbCXwvKDpMbStb
 t.3OoGz6ymjxRBzgtDzOvHIVSJRJLoVD25KqzllWxwQsYgrEpIpt2DuBgIrvUeyweXy_QmlH7i0P
 6PwkNrPPJYqEsAM9wp8e3vKSwmwtoxVmTVjweCUxx9Jrz8oO_qwyjJ4j6DP9zZHPJJZzjw9hsdme
 Sj33rzt.LB7.eyr4k_7PifYlgaQGOdSPMBajmL2O6ESWjVXD9N4z6P84JcVY0PRkWjfMO2oXWz2O
 yfQh5qwfuI4PbhJO6BH.HAPFEu08I2TzNvUvIhdGqPyv5S2DIkWSTEt0.BVDT66DpeSX_v_TUdMI
 oNT2eMs_r3oDko25jbJOPiKdFR.pBEou4Es.7KcuYRsHblFz.r44GIn8qcQGaoXlKsEKs_coHh5m
 F74Y5I0T1xhbBjOKdNC8TsAnFpmzea_o6AaqBuu0nzMky6yNMtyNQixhpFI5sJoOIiJnaLi35Hrq
 OFYypaLNbIHUcV..jgoxW..5loz.PVmCEdoBMzvh6L9IbB.WdPacq1Gh7CE3waXiq6pUpO.Dg8mS
 9YZgSeMkt0jd45i88.URGhSkcqwQUuPRK1t9f1rePnPsgW1cqNm36Ht0KZJ8dPdUVqieQqt6Qi4Z
 MtSu5T8c8P9I_8g_rPlKrm2Xj_70U1psXtNoPSjT1gH2yrisfA_TrzPRvJ639aPkYSWPzZZcK0wK
 OYbX_KKEpcZ6KgxBOJJTclllvUCf.suBuCcBP5uSHDZLLAp35BzkgZ2OVk497UROZAepLl8yIFYi
 Lw_JXvlDiZx9VkG3dqxLcrkXaFGG5Ae5HedX0RIj1WBVkxm5nuOEDpqR5WdJUNjsYH3y9uh68Cnd
 hxCuLfzPPP7f.1eDbGtfszzJO1rUy11a09tbdCNv2N5CqERbqEbkY4UIMmrDDe_nVStXfcMDWknc
 ZWW6lITEQBIBr6Up.p7KE.9vr8z6TG_gV15evD6Q.LkNhitvkkFXc08J.uTJHUiZbYtP.UyjoyEn
 u_.sXz0VYmJG67ee_FPpp5xMPu5sAsLPrBn_.rumsNbK.payEqqGs0UMq2.hyw.zRrAv_vnk5oCm
 .k3geMXIdcH9o2R0K1970jT8umlw7bEmbaADkkNCJYCOyIW22KdKSR8T576azE3ipshKJfDmU2tN
 QTr0yKgsaVQvTbrlSmqmrBgx4m0km_zUUdej2zJ7qSLVhgA--
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: c579781b-b73c-4576-82d6-8f0825eada4c
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic304.consmr.mail.gq1.yahoo.com with HTTP; Thu, 20 Aug 2026 11:47:33 +0000
Received: by hermes--production-ne1-6dbcb84f44-s2v5v (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 05be46735015b05d69f7fafd25a3fb31; 
 Thu, 20 Aug 2026 11:47:28 +0000 (UTC)
Message-ID: <fa497825-c8f0-4caf-94f5-b37108e31952@aol.com>
Date: Thu, 20 Aug 2026 07:47:28 -0400
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
 <cdae1785-4d9a-4aab-929e-de55c26b7b94@aol.com>
 <10cd9f6b-678b-407b-a51e-70e9ed7a35fd@aol.com>
 <131b1252-b108-4b4c-8457-673ff0d20d5e@suse.com>
 <b14969c8-9676-404e-b7cc-ce13a6d7ff94@aol.com>
 <92022f85-9a53-4db8-b489-fc91c86b413c@suse.com>
Content-Language: en-US
From: Chuck Zmudzinski <brchuckz@aol.com>
In-Reply-To: <92022f85-9a53-4db8-b489-fc91c86b413c@suse.com>
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

On 8/20/2026 3:51 AM, Jan Beulich wrote:
> On 19.08.2026 19:13, Chuck Zmudzinski wrote:
>> On 8/19/2026 9:51 AM, Jan Beulich wrote:
>>> On 19.08.2026 14:36, Chuck Zmudzinski wrote:
>>>> On 8/19/2026 8:16 AM, Chuck Zmudzinski wrote:
>>>>> Yes, I agree that v3 of the patch to hvmloader should presume that the DM can get
>>>>> a copy of the OpRegion and read its contents so most of this can be done in the
>>>>> DM instead of in hvmloader. So from hvmloader's perspective, the patch will be more
>>>>> about avoiding the layering violation than anything else.
>>>>
>>>> However, there is one advantage, from the viewpoint of the Xen virtualization platform
>>>> as a whole, to do the patching of the OpRegion in hvmloader instead of in the DM.
>>>>
>>>> If we patch the OpRegion in hvmloader as v2 of this patch does, we provide a common
>>>> solution for extended VBT support for Intel IGD devices that would be compatible with
>>>> all DM implementations, not just with Qemu. So why not do the patching of the OpRegion
>>>> in hvmloader?
>>>
>>> As indicated before: If the OpRegion holds data that is needed to drive the
>>> device, and if the OpRegion is exposed writable to guests, then guest can
>>> screw up that data such that subsequent guests won't work anymore. Hence
>>> exposing to guests (which includes hvmloader) needs to be stopped, or at
>>> least be limited to r/o. That, in fact, includes exposing to any privilege-
>>> restricted DM as well.
>>>
>>> Exposing r/o may be entirely okay (i.e. may not be a layering violation),
>>> depending how exactly an OpRegion surfaces for a device (on the host). Aiui
>>> it's not addressed by any of the BARs, yet it looks like it needs similar
>>> treatment.
>> 
>> Yes, the OpRegion is not one of the BARs as specified by the PCI specs, but
>> it functions more or less like a BAR region with the devices's ASLS register
>> at offset 0xfc in the PCI device config space of the device acting like the
>> BAR for that region.
> 
> That is, on real hardware a write to that register moves the OpRegion? That
> would need following by the DM then, i.e. the DM would need to indicate the
> original position in the register, and the guest (incl hvmloader) would
> then be free to relocate it.

Why would that "need following by the DM" when the register in the guest is
fully emulated, [1] which means that when the guest (incl hvmloader) writes to the
register, the register on the real hardware is not touched, nor is the OpRegion
in the host address space moved?

Here is how I understand how this works in the current implementation and how
this should be done:

Intel's spec (an old version of it that does not yet define the rvda and rvds
fields) is available online. [2] What that spec says (it is for skylake processors,
released c. 2015 IIRC) is that the ASLS register is a write once register. The
system firmware is to place the OpRegion into memory anywhere below the 4 GiB limit
(because it is a 32-bit register) and mark it as type ACPI NVS memory in the E820 map,
and write once to that register the location of the OpRegion in the address space.
The spec says that from then on it is read-only for the OS graphics driver to consume.

When the IGD is passed through to a Xen HVM guest in the current implementation,
all 32 bits of the ASLS register are emulated from the guest's point of view. That
is, when the guest (hvmloader or seabios/ovmf) writes to it, the register on the
host (i.e. the register on the real, physical hardware) is not touched at all, nor
is the OpRegion moved in the host address space. I am fairly certain this setup of
having the ASLS register emulated is not specific to Qemu but applies to all DMs
that are to interface with the current implementation in hvmloader, because in
hvmloader we have this comment in tools/firmware/hvmloader/pci.c:

                    /*
                     * Write the the OpRegion offset to give the opregion
                     * address to the device model. The device model will trap 
                     * and map the OpRegion at the give address.
                     */

What does it mean to say the device model will trap? I think it means the
device model is to emulate all 32 bits of the ASLS register which will leave
the position of the OpRegion in the host address space unchanged and the ASLS
register on the real hardware untouched.

So, hvmloader need not need know the position of the OpRegion in the host address
space since the DM maps the host OpRegion into the guest address space at the
location it is to be accessed at in the guest. That is what the current
implementation in hvmloader presumes the DM will do, as evidenced by the comment
from hvmloader code quoted above, and it is also exactly what Qemu currently does.
Indeed, it is clear that in the current implementation, the host OpRegion address
is not disclosed to the guest (hvmloader) and the guest is able to access the host
OpRegion without knowing the OpRegion address in the host. That is my understanding
of how the current implementation works.

Now, we are proposing that the DM should expose a copy of the OpRegion to the
guest instead of mapping the host OpRegion into the guest address space. Even with
such a change from the way it is done now, hvmloader still need not know where the
OpRegion is on the host as long as the DM remains responsible (as it is in the current
implementation) for making the copy of the OpRegion for the guest accessible to the
OpRegion at (or near, because currently the address hvmloader writes to the register
is just a hint because the DM adds the offset from the page boundary to the address
in the current implementation) the address hvmloader has requested.

I think there are multiple ways for the DM to do this. It could place the copy of the
OpRegion into the guest memory at or near the address hvmloader requested without
disclosing the address of the OpRegion on the host. It could place the copy of the
OpRegion into the DM domain's memory and grant the guest access to it using grant tables.
There are probably also other ways to do it. IIUC, if the DM uses grant tables, it
would not need to disclose the address of the OpRegion in the host address space to
hvmloader.

There are even more options to accomplish this. For example, in a previous comment
you suggested that perhaps the DM should place a copy of the OpRegion *before* the
guest (hvmloader) ever gains control. I noted that would require making the spec
for how hvmloader computes the position the OpRegion will be at in the guest address
space public, and in that case the DM would compute the correct guest address
for the guest and place the suitably patched copy of the OpRegion into guest memory
at the correct address for the guest and program the ASLS register with the correct
guest address.

In this case, the patch to hvmloader would add a read of the ASLS register which
will allow hvmloader to determine, for example, if more space is needed in the E820
map to accommodate an extended VBT and adjust the E820 map appropriately, and also
in that case the device model would ignore any write that hvmloader currently does
to that register because in this case, the DM has already programmed the register
with the correct address.

So with all the different options about how to do this, my head is spinning and
since with your comments you are confusing me about what approach you think is best,
I cannot at the present time write v3 of this patch. What I need is for you or one
of the other maintainers of hvmloader to *make a decision* about how support for
extended VBT is to be added to the Xen platform. I think I have given you and the
other maintainers enough information to make a decision about how best to add support
for the extended VBT to the Xen platform. I understand it may take some time for
you to process all this information and make the decision, but at the present time
we seem to just be going around in circles discussing this, which is not really the
best use of either your time or my time.

Chuck

[1] The specification for how PCI config space registers are programmed for emulation
    vs. passthrough, please refer to the official PCI specification.
[2] https://www.intel.com/content/www/us/en/docs/graphics-for-linux/developer-reference/1-0/opregion-specification.html

