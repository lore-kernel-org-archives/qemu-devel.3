Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C25FBC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx4Dw-0007SV-9b; Thu, 20 Aug 2026 10:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wx4Dt-0007Rs-Rw
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 10:58:29 -0400
Received: from sonic309-20.consmr.mail.gq1.yahoo.com ([98.137.65.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wx4Dr-0007IN-9R
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 10:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1787237903; bh=p77KaGKTsaeXAG5o+cyXNB9f2yKatwNXCTXLE+YTHAg=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From:Subject:Reply-To;
 b=NoyC9rOw8RWey/V1PO1SpvZNZ3zEsvyRn74id8qDU9s5/MhzXmXKzMPiU6ymTi2JO/Hjy6azBbH791NRec7SLnzJYqFWvu51toQDqy8cPhRopvUKvxjC5WD0pN7lswKpexRUxY3R8sdKtl6A1Mwe9x9DldHDf0fULrGtZ+JDGiBbjkJkMdYmw0869opX+M98EWCPJoiyFwtI8b/QHsMPIz2SeiZ/vTCBS87s7VIjmLK8vGo5xqdO5ibr8KSJXcfDOFce5JuufNHaHHmIDVaO0jhUKf4D+Vwi3jhz43xQZ6JmiRn502pH6CJFUb2gm1+5W1yn+Dt3ekBIiFuI+KCfkQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787237903; bh=ngpd+xLtVTuYPkIPTLJVC9xtovhuqBfKTw9DyvAO0ov=;
 h=X-Sonic-MF:Date:Subject:From:To:From:Subject;
 b=EO2W8p9FNou5eztq8nu0QOg88NTzcLJvA2XCxLMsTPioan1lAOSq9v5LRBs8nsyRKpp/N2CcpGKB9m9Xsl4WJxU77BmZqncdb2zB1QBcB5iRSZb6+PxmmbSeKjIVx66SsC96bCQV3XNs8r6tLHZh3k3zUzjhKRA3jkjPbi8cu389nJ3n8/n13Q4wGa2TEghZ67w8DNjO16AEL6AZpjodwNRlOSbg4FW6WvFroqFeokcNZGL+KBumy7yyOryDcAU3+Lk+zMCeJ4Bgh3VfOuvYKMA3piqL/j9zyIPOHtcryYOGqvjcInNgxdffU2Xbl7ZwgFY6gN72FutfVfgqNa1YNQ==
X-YMail-OSG: 4m.E8lEVM1lobNUVJSQfmBbsGPNSHtIk7w8KuisfZQNf.TPOO.iJ86AmnWbvhBQ
 aiGyhOTLAQ6SWmCpumRQZIR9nAFXmH_doE45.snMJWsAOpwJVVhx2hUZjw03_rzHxmsFyqjC.FTs
 Z4XPKjMlvvIIegazg9BuKyJXu7TR_IO_C5ei6qTx0ryNPHOwfK7SRrBIMk_eu6.mCOjsDaEtD6hF
 lZAMoweJpB_gUhiJefDyPk1CgN0gM.z0hj4uG74R5xGP1SMekKp3EU27tZT9cXTmh0J3XFRF.hBX
 rs5PRluGBLw7sTqspVveQ05W.lHPb9C7xZKPol0.Bcc3eLuBKaY9..MPbVU7ZKHtXH_UVb9YfBSK
 I8kvbktx8NH0aukIyzRX2KdFmPxg7RdqmQqLme65UOTndRc9.xj9d1.aGIyw4Zio2_qv0MJcTl1N
 k3qM_Hzfx5zJ2zwgLD7c7KIw_QT3GY1q2osDq3veW24E1PWM3E2d9I4jG48JXOMfBARbfs122OtJ
 nlbpFFvS2R1OnD0UQKIHtpAT4C.7jpS9XlkrMGvjsd5Bfo1jHj9fva4re7v4x3oJdU6f7eMMOnFS
 sAuVWX4c3M6uDCKOEU1octUs.IMZpM87Y7h5XB9aNL4CIhdsy_evwv9ZV9hKDgRjcH94DbTbkNwX
 P628gydnPs.Y8w8FctL6_jtljedK47bW9Kd9NmE8dxb_YtXSoQ0MfbZA7Otga9QNYNB6EEiSrbEe
 K40HMdYJ_FVcDV199I9rhUsPDsNTYia3RW30PHaqvDoxj2gKdP5p7NBQ9X8nie2KPmttYp7ZtSdc
 c5cQ73ZiXpdEhNhuYHshfB0DC06jKHaiyTdhX8_RQKGqH5zpWAvvtXmvutLa1OTbst1l4p1REoMz
 RDtdA9HuVpdnx2hNYDQv0H3mxSz31qTcfEg5tUOQvBwRydC_f8avi0FO7zzkj84i29FvqrlXfHVf
 0OnkrS9Td9RjZNuaGqq_G9OJWv_lhb67l.UJYBM7.75m42QST7EcFaoExNLJ1MYwNdZKKg5qI67_
 U4zHKA_88uusMGsFCP55igjWg_Bya8rW4xqyVlsiwmZwBVANtEPB.cM.zZD04onuerhnYQwXWY7Y
 okBGLvVKdeV5hbPQ1aBw5c3Qai_4FbcsAgpK8VQylkt07.JeXLyjp_epj71azR_TxQXI.2XtrKsT
 sKAYlmhshOwgJ24xQQqA1Z6iLoLbegVgCqUSyofiMl2yeOjAxLGSE..vdXlcgS_tCz6GYUELEm7H
 VnyWMoa.FNL0S5.aOYIQRgfMw0zFOGprEyTO8UMPjjedYqe.Te9KQ3PNMcz2uR44TEvgZ1ogEfKr
 X0OH_pyXZojtTFdWO0J8bTsUEZBFAnSQztYQ5bZCibCNY76r73NgjPTT8PZJussU8UB_8QOKOzYE
 uluE_XAWWT9MI2zq0_LbMrND2Gw0hpDGE1ejqpg2A.YeBYPFHfub6ST1ONY8tPdNhzTiOa7.D6Dd
 yL3ns3Ck_9nr7MqYwrXrCtyDtkXzcNpoqNadABPpI4ogRq0x4fiaK5EjEM2FwQ9P2bIVP9MsvM1s
 hVOdr67mYTk0AOj0kqQRlnOOtti9XaVc9qVESrQP_o_gIW4HNFYBHeWCzpGz0sbz5yLOaNKIRqwe
 Dpm4DF62yMfL3Bip0OWWr0RBXqZ9t_D4uFcD07k..86V7XCd8bv7pOW5JGN77jfqPiUGaC72of_u
 7OzcqBb.10dKxN1qX6v1LieOF0hYW5GIvhoCamI3V0o4LgCRPhSRL2chprnmGqMnDrsq264MQCWB
 0v.lBNmyxgHhb8nQ8v0bNZSuuTi_Dd6t6SJE_HUqXvGLsPQ_Vqbrk1g6U3Q7A2NQOtMSV._6ukK0
 WhRsY326FGk56Epi_IyM0iuE5qjQ.E0q3hCewUhretDV.YCAkLZhUNTuBrmO2ruKfsQDVQiInVNZ
 LKLUqiHQWZ.qErKNmE6HkguQi1YwXMseeGeu.6qu__MBB8Iux93EU4GNwGFlwuGZIhgRuKvaWV.z
 Vl_pfUEGF957n9_yGgLVIoODueJIej8IV.WspGygn.AJJuEiarWBVtbm8BVwo7OEV41bm6CnfRo3
 IpmbafeGzWOdo0PNskx7Lnzcu6kI01NRHK6eS1iezFCbuJNYDRFloDey.GM1vDdm9APp41XhtLK2
 b1cNNwtZrbt9nIQ7sDH_IVYNodGIQHLNs_.PifD39uKcLHRZotMhrrjAUb9BD8KTTTTEKWtGXY5X
 ADJzUjb_aCYtCZm5vFjQgW4HxsVJb51I32mfFstzIgNtEyz0A
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: e23b1bdc-5454-427f-903c-24bde30c282a
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic309.consmr.mail.gq1.yahoo.com with HTTP; Thu, 20 Aug 2026 14:58:23 +0000
Received: by hermes--production-ne1-6dbcb84f44-vcvxd (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 16eeb344b7bc8d6ce5e46c7023ef40a1; 
 Thu, 20 Aug 2026 14:58:20 +0000 (UTC)
Message-ID: <ef5995a3-10c3-40e3-95f6-3bd678aef4c4@aol.com>
Date: Thu, 20 Aug 2026 10:58:21 -0400
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
 <682975cc-4857-42b2-badf-b638869f3268@aol.com>
 <7ab98288-0c5e-472d-87dd-5586e60027bb@aol.com>
 <f0ffe015-1bc5-4091-8dbe-2b4eee9cec2d@aol.com>
 <b05a3553-398d-4ed0-bbf1-6e93cf385fe2@suse.com>
 <0762fb50-01b5-4ae2-8587-7574020082b4@aol.com>
Content-Language: en-US
In-Reply-To: <0762fb50-01b5-4ae2-8587-7574020082b4@aol.com>
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

On 8/20/2026 9:03 AM, Chuck Zmudzinski wrote:
> On 8/20/2026 3:58 AM, Jan Beulich wrote:
>> On 19.08.2026 21:09, Chuck Zmudzinski wrote:
>>> On 8/19/2026 1:49 PM, Chuck Zmudzinski wrote:
>>>> On 8/19/2026 11:47 AM, Chuck Zmudzinski wrote:
>>>>> On 8/19/2026 9:51 AM, Jan Beulich wrote:
>>>>>> On 19.08.2026 14:36, Chuck Zmudzinski wrote:
>>>>>>> On 8/19/2026 8:16 AM, Chuck Zmudzinski wrote:
>>>>>>>> Yes, I agree that v3 of the patch to hvmloader should presume that the DM can get
>>>>>>>> a copy of the OpRegion and read its contents so most of this can be done in the
>>>>>>>> DM instead of in hvmloader. So from hvmloader's perspective, the patch will be more
>>>>>>>> about avoiding the layering violation than anything else.
>>>>>>>
>>>>>>> However, there is one advantage, from the viewpoint of the Xen virtualization platform
>>>>>>> as a whole, to do the patching of the OpRegion in hvmloader instead of in the DM.
>>>>>>>
>>>>>>> If we patch the OpRegion in hvmloader as v2 of this patch does, we provide a common
>>>>>>> solution for extended VBT support for Intel IGD devices that would be compatible with
>>>>>>> all DM implementations, not just with Qemu. So why not do the patching of the OpRegion
>>>>>>> in hvmloader?
>>>>>>
>>>>>> As indicated before: If the OpRegion holds data that is needed to drive the
>>>>>> device, and if the OpRegion is exposed writable to guests, then guest can
>>>>>> screw up that data such that subsequent guests won't work anymore. Hence
>>>>>> exposing to guests (which includes hvmloader) needs to be stopped, or at
>>>>>> least be limited to r/o. That, in fact, includes exposing to any privilege-
>>>>>> restricted DM as well.
>>>>>>
>>>>>> Exposing r/o may be entirely okay (i.e. may not be a layering violation),
>>>>>> depending how exactly an OpRegion surfaces for a device (on the host). Aiui
>>>>>> it's not addressed by any of the BARs, yet it looks like it needs similar
>>>>>> treatment. Earlier on we also talked about the region not necessarily being
>>>>>> page-aligned. That poses, even with r/o exposure, the question of other
>>>>>> data on the same (leading / trailing) pages. This may imply that the
>>>>>> copying needs to be done strictly in Dom0, for both DM and guest to only
>>>>>> ever act on copies (which may then as well be r/w).
>>>>>
>>>>> Yes, I am thinking the DM should make a copy host OpRegion and never expose
>>>>> the host OpRegion to the guest but only a copy of it.
>>>>>
>>>>> The reason we need a patch like this is that with the introduction of the
>>>>> rvda/rvds fields into the OpRegion, the OpRegion is not always position-independent
>>>>> so its contents might be unsuitable in the guest address space, so in those cases
>>>>> we need to patch the copy of the OpRegion that will be exposed to the guest.
>>>>> If there is an extended VBT the DM will also get a copy of it, make a copy of
>>>>> it, and expose it to the guest by appending it contiguous with the OpRegion.
>>>>> Since in this scenario we are assuming the DM knows the contents of the OpRegion,
>>>>> then it can find the host VBT and make a copy of it without needing hvmloader
>>>>> to send the rvda and rvds values to it.
>>>>>
>>>>> Then, the remaining question is which component (DM or hvmloader) will patch it
>>>>> if it needs to be patched to make the guest's copy of it compatible with the guest
>>>>> address space.
>>>>
>>>> As I noted earlier, it think it would be advantageous for the Xen platform as whole
>>>> for the patching to be done in hvmloader. That way, support for extended VBT is
>>>> automatically added for all implementations of the DM, not just for Qemu. But the
>>>> downside is that for hvmloader to do the patching, it needs to know the host OpRegion
>>>> address, which one could argue it should not need to know. This is the only reason I
>>>> can think of to do the patching of the OpRegion in the DM instead of in hvmloader: to
>>>> avoid disclosing the host OpRegion address to the guest.
>>> 
>>> Correction: Actually, with this new scenario, we need not disclose any confidential
>>> host addresses to hvmloader if the DM removes such information from the copy of
>>> the OpRegion that it exposes to hvmloader. Then, all hvmloader needs to know to
>>> ensure the OpRegion is compatible with the guest's address space is the guest
>>> address of the OpRegion. It need not know either the host OpRegion address or the
>>> host VBT address.
>>> 
>>> So the guidance I need from you to do v3 of the patch is simply to answer these
>>> two questions.
>>> 
>>> 1. Should I write v3 of the patch not only assuming the DM will never expose the
>>> host OpRegion to hvmloader, but also assuming that the DM is responsible for
>>> patching the OpRegion to ensure it is compatible with guest address space?
>>> 
>>> Or
>>> 
>>> 2. Should I write v3 of the patch assuming that hvmloader is responsible for
>>> patching the OpRegion so it is compatible with the guest address space?
>> 
>> My tentative response is to use option 1, not the least because a mid to long term
>> plan is to see about removing hvmloader altogether. However, a more firm response
>> here depends on an answer to the question raised in
>> <92022f85-9a53-4db8-b489-fc91c86b413c@suse.com> (sorry, the list archive hasn't
>> caught up yet).

Ah, I see this message is the one you sent me earlier today about this patch and now
the list archive has caught up so for those who might be reading this thread here
is the link:

https://lore.kernel.org/xen-devel/92022f85-9a53-4db8-b489-fc91c86b413c@suse.com/

Well, I did try to answer this question here:

https://lore.kernel.org/xen-devel/fa497825-c8f0-4caf-94f5-b37108e31952@aol.com/

My answer is based on the fact, as far as I understand it, the ASLS register
on the real hardware is not touched when the guest writes to it because in our
case the register is fully emulated and the guest can only access and write to or
read from the emulated virtual register, not the real register on the hardware.

Also, we have this code in Qemu (hw/xen/xen_pt_config_init.c):

static XenPTRegInfo xen_pt_emu_reg_igd_opregion[] = {
    /* Intel IGFX OpRegion reg */
    {
        .offset     = 0x0,
        .size       = 4,
        .init_val   = 0,
        .emu_mask   = 0xFFFFFFFF,
        .u.dw.read   = xen_pt_intel_opregion_read,
        .u.dw.write  = xen_pt_intel_opregion_write,
    },

Do you see that emu_mask setting of 0xFFFFFFFF? As I understand it, that means
that all 32 bits of the register are emulated, and none of the bits are passed
through to the real device.

Also, I can quote from the (admittedly outdated) spec for the OpRegion that is
available online [1] which says this about the ASLS register of the IGD PCI device
in section 5.1.2 of that document:

> This register is a software scratch register and is not used by hardware
> other than to hold the state software has set.

I think this means that even if the real hardware register on the device was exposed
to the guest and the guest wrote a different address to the register, it would
*not* "move" the host OpRegion anywhere because, as the spec says, the register is
not used by hardware but by software (the system BIOS software) to let the graphics
driver know where it can find the OpRegion. But the guest *cannot* access the real
ASLS register on the device in our implementation nor in my proposed implementation
in v2 of this patch or in any of the other ways to solve this problem that we
have discussed in this thread.

So I don't understand how the question you raise poses a serious problem.

But if you are not an expert on the PCI specification and how the PCI config space
registers can be programmed with emulated bits and passthrough bits, and if you
don't trust my understanding of it either, then I think we need to wait for
experts on the PCI specification to weigh in and answer your question before we
can move forward.

Chuck

[1] https://www.intel.com/content/www/us/en/docs/graphics-for-linux/developer-reference/1-0/opregion-specification.html

    To actually see the spec, click on the "OpRegion Specification" link in the page
    shown above and download the pdf file that link points to. It is still live, I
    checked it today.

