Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6DCFC5DF8A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:55:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx61f-0004pu-Nh; Thu, 20 Aug 2026 12:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wx61e-0004pa-4Z
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:53:58 -0400
Received: from sonic306-20.consmr.mail.gq1.yahoo.com ([98.137.68.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wx61a-00064n-Kg
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1787244831; bh=/yV4R5NzJGPzKwxTljvmVXReS9/rwKyLShBsLglW/rs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To;
 b=Cx2zSdmcK3MChGRdKASNki1ezPweR2xOnmlyMXFVhbX0plAJUG87GrvSqOEGEfXa3CsUxwzXjzPaXP8DanH08u92M5Zejc5NhEXWQhG07oP1BxNFGMpMPYN+4PV5hvBaQNuiitzYKL3v2f4rpOmcm5lcN2FtPVF9Fu+cYKkMhQ+8iRBb3TTU3njkNAnYf51u8JI1/l/J94gXIT0n4OrIO17V3jjqjq0UnGdycFEWHeoGzhqVKSTIqNfkOyte72I3A9AGPPWRA5kwZP1BMYOlbjqwNCAiZPTNijYeLfQxiBjFMG6L8P2o35UWZXs0psfVBAfsqDTK9i16X3IQnLddHw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787244831; bh=CE2JA2Sclqf9mkH9no660+GL2stY3IEaJeUjOtGsGJy=;
 h=X-Sonic-MF:Date:Subject:To:From:From:Subject;
 b=VNVtLCU7r3dVtH1GLSsgeucHqjtYYqrprgXOFvcScPQ5DVDfZ6A6aFd2GbeeMiRvpkXEPBnUWo6M2j4mP7WaLRw0blUpzL1D0PL7AuJ7TxE1uf43sEZl0oWhYzrafTY/YEh2BWVZs8ZF/INStc7OQpECmaNkOWISn8Weq+IYtsPxVXeaYLoRkXoBIWKK+5eCJtTvfsIZzQcXWhfX44RXr33zOQvh0Mty8JFurPrOS7GSriTWd2Lm0leVuButqkMYRRZk6WPPoa54b7vBWBR+AV3Z6XFCjXAwUZV8ESVtmqlqKtPSITkwmSo6mevCR5raqVDghtYmL7IRoJ8VNBYLoQ==
X-YMail-OSG: k13RWPQVM1nofh4wzMQKD2h6h7VfI.0eJE92YP.9a6hPYZG5nHx7N6xXjaPMX5Q
 rIGK5WO31wGLAQe2WRy6QQtHHEFvj9pNriILh7SkQAMCgkzKGgspxEYhbMIwmZ62nRO.vq8ZHMXY
 LJqHTojYZItq.E9k24SiPpLMpMQxhA1n3p0n.WKCrDD7AP_V3p69t2RGjk9i01iB8MZj9lfs1JQF
 ye0Hx_8vb8FWPhdlpmxHa3hF8hVPtuZ426M967pG2fYnNfBP9A5Y4.ngpsbwYJLspw7h8Z3Sfxgn
 HOqfOTQqt8fmgQuNmWitOPaFb_He9THaonZ9MWxbQGU8WL6ObkexMIjMsc2o9dkXNzD4yRRjFHJZ
 xNewFtmm3s2AXPVRi4qNQo6Re..8A.7Q4TY1sg6zhzV1VEvWsQFSFktB0O.sBE3EmmPwnsAmq3kg
 AneFvaHaYxJ3l6g6B.bQnYCYMxLNQ1PCQ9XYM4XK3jsVO7Ehb9x8yZtvGeByd1ScvnBPw.EyuSVA
 hk_MOa7z0E6MbR3Ic3Qn4F1szKoSNwsJ5ow.vsdMS_CWXjdnHJgnGyKx.zb97Uq7Gw64F33Gaa0c
 UHxw_FWRYjXrSyA.9NO6VIKfvCDk7rjPp_XSLsO4zVm7A0JkUlXXq70CTvlk3ltGmHcLupfDhcz5
 dSKaaPbh28b9Vzafjj10aMiVDq40ZuhO18_SalrwBxVMGjhjmKGeFgOAy0ydt1wAEsYqwg7pn9Mx
 rKhoAPCxQVBhvj3Z8WjAPsaTOoXFuWVxXAwPuTyp7WKSJ81bnEpJnEsfavDj1UiWJrAFJQUezqhe
 7Nl86Fyz2vm6gxFqS2NTwuzQoQIxtOvuQB4x0rx92FucGjDO1M_gWuW4TGSxgpLD6NYRY_VYfUIk
 U5VPwint5K4ch4SbApRW4PaF223dyTSAV0oupYPlU.RyVMwd8Q7MCt_Txkue585iTsgeP23tJt74
 qPycLfZ53k0JIqp76F_AO1zUughMz_KIvbLRvZPgvax_Zd7YnNnxsWuCdyMQD_vyeCrD6LFGRTFd
 5ceJjgwfAmehfloEcvDZGLZ7bqyCKf3coRkLSvhsmAoUaS2nGJtAycAbjssVGaqrVFaUmF8Ok_ln
 LpNA6xliW42FP479dZYnm8YyiQ5WaMv2QdYiuUzkU7x2JEKok0s8opSn7C.X_.UbJP6L3brh5P1q
 7w8m5VX0F6DfuYeEDEbzIFOdWbW_IPgF00XsjeUMyfrzFB8LT6ehhp59bR3Xn2iKnZWaCKpcltB9
 5bR_PiA_whlKU4IZJxwW.KyNDSbaKh9QOXEyrfhI.r9mp.x.tV0s6ujopnwnE1Z.H1X2_NWMhAiF
 lYvsDxdxNGRdRy6h8s_oBQLAQ60CxudXPs7rH1ofU7WyuqAajemOoP1W9Y_a3SIqrA4U2chGXF73
 Dk4rOuDFP8MS_llz9LJgus8oXcauzNgYI7_R1hDuNk5pVnIP9NPMSkcNhUtZ0JzeUw3Sv8OnLulG
 bUo7R.vh_6dcamdAkgBUSqTZoFpCHyy_bbPM3hIuRM9U5SM_WN00RfDY4TVERkAt3q3AydWMFhyN
 1vgZ8wC.4TTmVxlR2pzDPu1Vsij91Oe8H4eyXbGnHgLIhtVhguQ75ocnyXHhEhrPBLBZBTRMcHnb
 L8DDJD3eiX6Ukepk8IUlZSEJVA0B44ux64eL9HEe4ARjlnKvhFK30NkovxHKKdAcLSLbDeP1_GXx
 .9F4BoO9UwEijCv6qfkzplb3Enbq9r80XwirEvkvZuI5tL9JiMTojBE_FmdGTTcujQQoSLiPEhPp
 yhCQ3TqhqtJp5D1CXpXo0CgczLgXcl9yarCGEIxaZWFGMXTrr1TVssRdVGvUSoDDoLXvEOR.Sqgs
 PO_b2fj1HG.lvhiOP.6lM0MPnfXUKmsB6GnX2TXITgzsAkJ9hQRuIJSqbPLXmlwptIv25SJfLqql
 L4XRpf1ZgDZDzTuCDRJX6Jwe1LQJj0Dxd2d7TJtov.EjvQF46I5PYd2ZTT9tv4GujeVqaCRz879n
 qlFqkoqODnkv7FAV7A8azFOlxJQVZr0i.feGOaSYx8BI2MsBD7BslQVbLRM5oyiBfeN.LSVPz5Wi
 hMD6.goD0NbWUYmUcJT2KVpopBNzzfbysHoETZDyJbn8l9tYl5G5e9c1nPnpgbZmKaZ25PF_8fqR
 AcD.B_TwM8E9j.4u8Y5QexDyF6hzyOBg6peg_0aDBpLtUXh6nlysACV4uDImz207WGLT6EmJDEAk
 BFkkv2ldbJ2bCbVfzdCUHqWtLzwH_8O.E1EOLdEkqVpXWRw--
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: e1a62dcc-4c51-4a7c-b09c-19a8a2cc0f22
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic306.consmr.mail.gq1.yahoo.com with HTTP; Thu, 20 Aug 2026 16:53:51 +0000
Received: by hermes--production-ne1-6dbcb84f44-zgjzx (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 0e1f3b90d557886b25a60727f48865c3; 
 Thu, 20 Aug 2026 16:53:46 +0000 (UTC)
Message-ID: <e86404e8-9966-44ab-86d1-4bd01a551313@aol.com>
Date: Thu, 20 Aug 2026 12:53:47 -0400
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
 <fa497825-c8f0-4caf-94f5-b37108e31952@aol.com>
 <42521391-885c-4b96-96e9-5da2e4b5efa1@suse.com>
Content-Language: en-US
From: Chuck Zmudzinski <brchuckz@aol.com>
In-Reply-To: <42521391-885c-4b96-96e9-5da2e4b5efa1@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26254
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
Received-SPF: pass client-ip=98.137.68.83; envelope-from=brchuckz@aol.com;
 helo=sonic306-20.consmr.mail.gq1.yahoo.com
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

On 8/20/2026 11:17 AM, Jan Beulich wrote:
> On 20.08.2026 13:47, Chuck Zmudzinski wrote:
>> On 8/20/2026 3:51 AM, Jan Beulich wrote:
>>> On 19.08.2026 19:13, Chuck Zmudzinski wrote:
>>>> On 8/19/2026 9:51 AM, Jan Beulich wrote:
>>>>> On 19.08.2026 14:36, Chuck Zmudzinski wrote:
>>>>>> On 8/19/2026 8:16 AM, Chuck Zmudzinski wrote:
>>>>>>> Yes, I agree that v3 of the patch to hvmloader should presume that the DM can get
>>>>>>> a copy of the OpRegion and read its contents so most of this can be done in the
>>>>>>> DM instead of in hvmloader. So from hvmloader's perspective, the patch will be more
>>>>>>> about avoiding the layering violation than anything else.
>>>>>>
>>>>>> However, there is one advantage, from the viewpoint of the Xen virtualization platform
>>>>>> as a whole, to do the patching of the OpRegion in hvmloader instead of in the DM.
>>>>>>
>>>>>> If we patch the OpRegion in hvmloader as v2 of this patch does, we provide a common
>>>>>> solution for extended VBT support for Intel IGD devices that would be compatible with
>>>>>> all DM implementations, not just with Qemu. So why not do the patching of the OpRegion
>>>>>> in hvmloader?
>>>>>
>>>>> As indicated before: If the OpRegion holds data that is needed to drive the
>>>>> device, and if the OpRegion is exposed writable to guests, then guest can
>>>>> screw up that data such that subsequent guests won't work anymore. Hence
>>>>> exposing to guests (which includes hvmloader) needs to be stopped, or at
>>>>> least be limited to r/o. That, in fact, includes exposing to any privilege-
>>>>> restricted DM as well.
>>>>>
>>>>> Exposing r/o may be entirely okay (i.e. may not be a layering violation),
>>>>> depending how exactly an OpRegion surfaces for a device (on the host). Aiui
>>>>> it's not addressed by any of the BARs, yet it looks like it needs similar
>>>>> treatment.
>>>>
>>>> Yes, the OpRegion is not one of the BARs as specified by the PCI specs, but
>>>> it functions more or less like a BAR region with the devices's ASLS register
>>>> at offset 0xfc in the PCI device config space of the device acting like the
>>>> BAR for that region.
>>>
>>> That is, on real hardware a write to that register moves the OpRegion? That
>>> would need following by the DM then, i.e. the DM would need to indicate the
>>> original position in the register, and the guest (incl hvmloader) would
>>> then be free to relocate it.
>> 
>> Why would that "need following by the DM" when the register in the guest is
>> fully emulated, [1] which means that when the guest (incl hvmloader) writes to the
>> register, the register on the real hardware is not touched, nor is the OpRegion
>> in the host address space moved?
> 
> You said it's BAR-like. If the guest writes to a BAR, the referenced MMIO
> region moves accordingly.

It's BAR-like, but it is not actually a BAR (and the OpRegion is not exactly
an MMIO region either (it is actually and ACPI thing), so that is not relevant
to this patch.

Also, it is fully emulated so when the guest writes to it, the real register on the
real device is not touched, as I have said multiple times in my responses to your
question.

> 
>> Here is how I understand how this works in the current implementation and how
>> this should be done:
> 
> I'm sorry, but this is getting out of hand, at least as far as I'm concerned.
> I've been trying to help, but even just reading your replies has already been
> taking way more time than I would have wanted to spend here.
> 

Fair enough. Thank you for the time you have spent on this patch, and also thank
you for clearly stating that you don't want to spend any more time on it. So
I consider this patch dead unless and until another maintainer shows some interest
in it.

Chuck

