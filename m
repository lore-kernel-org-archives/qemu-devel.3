Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B926C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 17:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwkQ5-0006zN-NS; Wed, 19 Aug 2026 13:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wwkQ3-0006zF-Od
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 13:49:44 -0400
Received: from sonic304-24.consmr.mail.gq1.yahoo.com ([98.137.68.205])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wwkQ1-0004EN-UG
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 13:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1787161776; bh=aQBDs8cBxZftUk4yBhPCLxwhUgL2bs2msElB1ZoQnbo=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From:Subject:Reply-To;
 b=DRcpEVhFG+ZMoXSbrJqQuLJzIhTL4+CtgUsikg6B+Z0RKDz8tP2k1W9RtptrdSCPDbwUSRBKElGfAOt8/eLotANxfHHp4UN4u4pMHO678gVwvZMYhkEC9U43nS0+Pp67hAIPdHwgQw9AWFnxaYlrVXsYxt18h6+s1oX2KKa6E19fcqx0NJduJvaFpPVgTkQG1w+xwA2hBPvD9yAcksQTJxjGI5GJ24LxvVDy9ccRLrMwXbySqbWamizQb28lYQicm09Xw9DhYzQ/U9sv+6grsMBKkPUv1CIPNLVMdWInTaewQvqQKDQzp7Iczl/3tBeUD1S7pDFuEWl7RucFFDMiog==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787161776; bh=A2jYJ0csOKeu5XX5nbNwAL5CZFsk/5zB0L07+WMgGsG=;
 h=X-Sonic-MF:Date:Subject:From:To:From:Subject;
 b=XuY0OhckUAhmzqT/x96kH5qdVAMlyntmawgFEgQJoSKXgknmAf2bkpd/NpQUcZm79r2udTegFqBKMsrXXSliweyIReztfgyffpGvXeBMsAHoviQ1axrfXWyywR95dozGxQ4wODJJRryxRQl9z8WaNP5lH+aaX6Psqbn+Qy6W/dMfr/QOQZ8NxpXlYwf7Uq+QwN87h/xhM5IFtYPQxH2eBTEhWkGHfiuE+zn+DfTK932FUxq88IheYoLRw42VHR7p/sAs+tC2w/YHEJ1poSMo0wi32zdBCiFMuOCQTfcWSe7z9TCsUvIFG2eC4QsWDT8/Q+fdfmbZUl5z5BVU4NUENA==
X-YMail-OSG: vpiwb_oVM1npxKwmB_8iAt2Shxm4hpqAdUBP.6qpElbhIZtNbpsgv5C.IxkkYJG
 tmk7cTnmhZ4X8vPmwAo7FNPfjelBKrVYPmZ.7GzPvKYbO6x29AJSNlkt2ku21Jp5ENo8ZTRMC_qk
 MWaBNkV4uL9vXYAWU9tv1Zs3NicQcaVYvPAf0tLCYx5R1Ka9sNnF3GQaQV53JVtvtYnvSly5Uh4C
 3CF3VAiXsXYoPxomm0AX1O08fRmAFs4CAbQ.CDanPFWazk6XNWh5jwvEuhbj_B6YgGdU6AkO7gq2
 J1V.YGlNrHepe9Hi0QU9vDhWnZ2jbT2b_JLFP7ZBU.V3pPMxuDtLkpe5HlkX0R2MvX_xuE7U4sK2
 L.OpRw2YvZwXz9KXYE_Di3hFwwnLARC8MH0nIzTMtkF.Jc2Loku5JhcZIJzg7p0QEp.Od5Y1jqeS
 6YoGVi4x9hfnaRJvGLCYAjHckaaZfZ4Nrd.sBwn5c1qa0v1vFmYTjrZAylBK50oRCBY.qHSZAELP
 CRWPZvHM.8f.cQQL6JDDC6lQzUNiyqxYv7nWbQ73rBPK.rwOq8ZbLXavDYI8RAyZiDp3oRgSb75x
 5pyl1EXWW5Kdw3iODOAgNbCqAqNs082Nra3dSh9Zzsl3kdO4cteR2349.AQhQZUPG.iBTe9aikgi
 8IRzvqGuaezbLxqwIRh6bhcRQ6iPirebxJsz84zCIijNeq2ukf_wlwHY0tBfeEs9cmyGeGc3hLEn
 yjL5C3HBGypJYTZp_gj5Pg4zkoZHZo1Zf_F35vd6TfJ1odxwXpxhUvHHKTEaH_5bsUtkTVviJ6Yg
 KudDvMjUPE.WIy6muH8HY.LuQ_1AROQWUYcpYuCow5EacG10F7XKwIHhff2fQo58den87h7.H9te
 ySyWA90U5pFFtxjYpiJOI.VtMmWSaPdtFn9YNaTEH1BumbSRNgcvKOIf4CfZdqc7ytpSOAw3T6j8
 rTzk7rUi0TQdwxkN2r6ll3fDlklpyzrvhLuFDWW4NyPhbnSN72MFsfqxDPj4QmmCCf99rmT8hZFa
 VvBJcpaAm70nMPWtPXF.u5ulf2sntm3l6KGm5qULEht9e_UkCoRsA92AvR0Akl5O0iBxn3eMvroI
 oM7RYp.B93j6cp2Y84jLaOyiu_lOnvV9hAUJ_jVjx7.hV7jJyR6S9vO46JpywlceOv79aqJf1hYl
 ak.oMkRMYTmq8RwD52H.HshwcWDlkSDDwciq6NzsDh.nmIA3Pa5FYW6xLkbO37zU9JjU8OJ5TB49
 uA.tjgN7LdjkbyonsqE56WpqEMdZiekdSZ.hc6paMSK1cdreN2ROTcBQbJoVpkdEGBWWVkDWH036
 4KmAqiGvzHv22K1RW0iqgmSmwKJZqPMpj9AxEBw7XkDJo2eRdCbMEoawOM0J.nVboqrpAAlfJveB
 .tWaP3AKAUruk5J4xvanijsUcRGHZvqhdCM23pbcdvH93WbfZUWwSWKoznIbu8B64yNQRu_Vhvo5
 .H08ma8cRj2sTcArSDta43D0GHhOywbGGoFd0oxlebqX_8PL3x6ABR6iDAZDy2WCvrA1Zf5t_rRf
 7mUItYbbOT5K0ovhAs0J8kf22LPiYjPIDv4ePdFbJi0ME3cJN.JxetmMdkZGoHAVjRthCchyR9oQ
 UDfVFg5HegKzrVSm6sDfgjDxAQHu5rdrc.6m9ePTdy0uTtJSHfum2O9MECxSfRsnvbguHfyzqGZC
 df.q.oR9fwV5d9vr.PkAIfr6IC3iwUlTkq7vkRY.HGQOQb_tbEr1QCQ4620MR8_fl0s4hMDPcLMK
 IZbgH021s.IxuxLO52_DxY.9_c.BJznex7.mNMRgrWwVcYRCp3aApYg_nTzHdD9Omtc_ge3Rnm6h
 4A.hWN5Zg7orVniAc5HRQgA2IJJCBZtuNObLYjEB2xl1PuNRe.W6f_pC44ARVeDXbyGcL4XpxzCe
 xJxIXsx7CowwjGyJC.cC2FxGbgMXIzBE2.JKUkaxuCNVG3Q34k3SOzwXAipIwQE281bD8a8C21CC
 IOudOJYHfBjziQtlCLqRslsyyoMREUg4GM8BNOk4VoJoAsMKxRtc_IMBnaq3qtGa_WomPoUJ0XxW
 gFB_z37cf0I5lmUWBIZ_nvFj3e6fynZhbrwgtE5Md2xJVrEzNwOzqUzq18D5zBaxYFTXiPkPHqAX
 0SY0SAYrVa6ltpW1VCEFM4J3OgvyNLvnXu59g95HhWEDWVNM4rD485PNo_kC9jY5Jk645KDkfNzG
 Ql_8UT1M3vGVkCtTtf4fFdL6ABLvwmRK3ReTlxMmW8d3V
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: db1ac486-3527-4366-88c2-78fc9a2ac78d
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic304.consmr.mail.gq1.yahoo.com with HTTP; Wed, 19 Aug 2026 17:49:36 +0000
Received: by hermes--production-ne1-6dbcb84f44-s2c5h (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID bcdd50cfdd69c45373e572de97e837a0; 
 Wed, 19 Aug 2026 17:49:33 +0000 (UTC)
Message-ID: <7ab98288-0c5e-472d-87dd-5586e60027bb@aol.com>
Date: Wed, 19 Aug 2026 13:49:31 -0400
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
Content-Language: en-US
In-Reply-To: <682975cc-4857-42b2-badf-b638869f3268@aol.com>
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

On 8/19/2026 11:47 AM, Chuck Zmudzinski wrote:
> On 8/19/2026 9:51 AM, Jan Beulich wrote:
>> On 19.08.2026 14:36, Chuck Zmudzinski wrote:
>>> On 8/19/2026 8:16 AM, Chuck Zmudzinski wrote:
>>>> Yes, I agree that v3 of the patch to hvmloader should presume that the DM can get
>>>> a copy of the OpRegion and read its contents so most of this can be done in the
>>>> DM instead of in hvmloader. So from hvmloader's perspective, the patch will be more
>>>> about avoiding the layering violation than anything else.
>>> 
>>> However, there is one advantage, from the viewpoint of the Xen virtualization platform
>>> as a whole, to do the patching of the OpRegion in hvmloader instead of in the DM.
>>> 
>>> If we patch the OpRegion in hvmloader as v2 of this patch does, we provide a common
>>> solution for extended VBT support for Intel IGD devices that would be compatible with
>>> all DM implementations, not just with Qemu. So why not do the patching of the OpRegion
>>> in hvmloader?
>> 
>> As indicated before: If the OpRegion holds data that is needed to drive the
>> device, and if the OpRegion is exposed writable to guests, then guest can
>> screw up that data such that subsequent guests won't work anymore. Hence
>> exposing to guests (which includes hvmloader) needs to be stopped, or at
>> least be limited to r/o. That, in fact, includes exposing to any privilege-
>> restricted DM as well.
>> 
>> Exposing r/o may be entirely okay (i.e. may not be a layering violation),
>> depending how exactly an OpRegion surfaces for a device (on the host). Aiui
>> it's not addressed by any of the BARs, yet it looks like it needs similar
>> treatment. Earlier on we also talked about the region not necessarily being
>> page-aligned. That poses, even with r/o exposure, the question of other
>> data on the same (leading / trailing) pages. This may imply that the
>> copying needs to be done strictly in Dom0, for both DM and guest to only
>> ever act on copies (which may then as well be r/w).
> 
> Yes, I am thinking the DM should make a copy host OpRegion and never expose
> the host OpRegion to the guest but only a copy of it.
> 
> The reason we need a patch like this is that with the introduction of the
> rvda/rvds fields into the OpRegion, the OpRegion is not always position-independent
> so its contents might be unsuitable in the guest address space, so in those cases
> we need to patch the copy of the OpRegion that will be exposed to the guest.
> If there is an extended VBT the DM will also get a copy of it, make a copy of
> it, and expose it to the guest by appending it contiguous with the OpRegion.
> Since in this scenario we are assuming the DM knows the contents of the OpRegion,
> then it can find the host VBT and make a copy of it without needing hvmloader
> to send the rvda and rvds values to it.
> 
> Then, the remaining question is which component (DM or hvmloader) will patch it
> if it needs to be patched to make the guest's copy of it compatible with the guest
> address space.

As I noted earlier, it think it would be advantageous for the Xen platform as whole
for the patching to be done in hvmloader. That way, support for extended VBT is
automatically added for all implementations of the DM, not just for Qemu. But the
downside is that for hvmloader to do the patching, it needs to know the host OpRegion
address, which one could argue it should not need to know. This is the only reason I
can think of to do the patching of the OpRegion in the DM instead of in hvmloader: to
avoid disclosing the host OpRegion address to the guest.

But we trust hvmloader, don't we, to not abuse this knowledge of the host's OpRegion
address? The point is, hvmloader will discard the host OpRegion address and not
disclose it to guest firmware (ovmf/seabios) nor to the bootloader or guest OS, so
I think the advantage of adding support for extended VBT to all DMs that rely on
hvmloader outweighs the risk of disclosing the host OpRegion to the guest (hvmloader,
which, for security reasons, should not disclose it to ovmf or seabios).

Chuck

