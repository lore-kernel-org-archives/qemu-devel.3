Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3998C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 19:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwlf4-0004wS-1f; Wed, 19 Aug 2026 15:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wwlf1-0004wE-Ul
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 15:09:15 -0400
Received: from sonic313-20.consmr.mail.gq1.yahoo.com ([98.137.65.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wwlf0-0001nh-0s
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 15:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1787166551; bh=Y+hqqQPJMhkzNUsx8sqJNX2kHqtYWU34FayrXcsDCNQ=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From:Subject:Reply-To;
 b=g+tHZepq0Eg46owsVlJgEu1pKXa6fVW1QFczW2+nS35rjljg9KVrTKpcgzYV1UmmqMXzVWQOabmM8tUU1QvVbME9N8mkPX7XiR0Ofn+BqOKDb3dufin8lGy20XNpnYwRHfo5qtXXbN86CB2pSaIXj3+vp0GZTOZUlpg0Gv357OwGfT6eG3DPtMyvhiARCoiqP+zWxRQHzc7I/QASH4IGhmUi47aDCt7ycakVRc7kzvDJBDsB1/rIPqNdpWZ3SfAuHgSdygtMNNPA16I/PvQ0K6nUzTCfpJRzzPdOT2oJ9SRdGJM8ZZhBWktnFswBqG1wn0pOCVFAxyJimHF+t6iwkw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787166551; bh=BNV/t1p3CmCpvWRkvTXmn7BJ8vHrJFw84E9OFGhTd3z=;
 h=X-Sonic-MF:Date:Subject:From:To:From:Subject;
 b=LZWKtE1xw25aNUTEbvUvtsrWElvRGJ7Gl6IZ8dFAbGF7+7FxCFw9+UEDMiyiRhGLUHQXZAPfjGx2BofZ9b/z3ewKIxzNMkSW6aZ497YxpBuECu4fZBTBGWKVnp6sZl6tCiEYMucbHTRyycIlnIhTfxGoj8CGZkVouN922wkxijlb2Q2HNTbEM6uvIvtSFD53MtmTY/C8XyA8hVarGiQuYJVkhMCCWQcNmZZZde38MnispDM+24QsdcnMWGA/FchDVMB+7p3skRRTLSGmN5EJaWkUtLCDViu+1OCZWTINsvmtNkX0AT5xiGa25pAaIaApkzTZ5J0AQ+uFOU1Efand6g==
X-YMail-OSG: EUiA.UkVM1nauO91Zrsn4JRKzkxz8niXGiN4Tm5IO29C03Ej6LzlDF0gU8j2JBC
 MAvBw5RuK5rGmGNmiiHG5smxostK106O69XXn8NNsU654.2fT5vGcK7oCdRapKBpsw_.v9diI6ZY
 1nNwuH9dseuHXwVlPQxloCtaqhOJ1ikN1npszz3oJIwlx7GkSNlDn8.BMopLHbdUyqmxEv4HM3fA
 Jw8qW3.E_rszsevm14mmXfwLvBY5_kNTUr4YoOJgBfS8zdeGVxvUKzMfYQQfFOSeLJYaIqY5BJIg
 kYTx5u3qe0RDK8skKBqdmT2.M2itQ2.q2SthIfvms07mfllAocQ7i5FhBx6.GZB34gSikN7W7tEx
 .Vt0L2FUSFD9TDzG7Qnt25Ge56imBgwDq6VjIJsK9PUDbVl7PQnLAP1aOyxXRS4DU16rt2wa2Y3n
 26fPMJP_lqS7af00gY3RHbHs7sNysXKSYIJL.VA9JCq.YyTmNN1aWsr1RYOSkWpiYGHlA3fqeEF0
 IqicxsMqbUy.FI5pVu0C8vn8n1.867_NACYL6O20hivtLWvv1U8.qpruqCAvA_2ygnYO_6.EYxKL
 H7Db4_3zEHux3_DhFBVJUELBn4hAQhJUivqXaTvX0lT5bJOPhvPm0zi59b7JfiJUzFzml7f37GrY
 Alt1ehgeJWmiSwU7K1ilYZyyYui1WPhCu5CmgCVXk7IVveIu0Pbp6bPlnfbFQDGkHhpRMBCrmSUV
 tyMYt0pTuMoVxOQ_.kC9aoMirZBY4EFw7z0iQZRRErbk0wpGklpMCiMkLI9uspydHbdTt21BqamO
 eN3.BVv2NZWg5EmmivLuoGR5e7q.SOhC5oUv4Yt9njI_8NKyUkIqYu3FCejwn9tbzWyv1vswiCEx
 ySqd0IKZUePhgpvvZABzzSwyBrPxEAKjBo6qRlIxomPqXC.XnocG_.R8kQgYP3iLGIEfbmYhmjeE
 D8Bf71CHZhipRmF6ABWYykaheqOm52DLyeJr.9v2jU2C40cz834mFZtLw.oRG_zV1P1.En6rc59D
 ZogvhBKzWuca4COBUIKHc77JxkkLgQWX0TqxcJJBTGQWJMT6I8yrhwRKjYQmXBAMYDc0JF_NPKzt
 ckBu5Fr.9rxBzjc37kt7ex7eTyu7ELuP3Ahwa1TNZWgL6h1RPE5iVCYczmSipqu4087ORfiUo06g
 YBg3jtLxr04kDGLoYZn7e24VZ9S3VNAS4W5F3ScdrJQijZIRIHpf49d0LhS4.t1I8Gm2BaJ4vJEZ
 slmE3w0op_h_RcD_1KBRpuk_tX9np_bJoBoHMxMVWHRy3IQpaakiDmEOYfgdODo6XWdychMh7X80
 EO4HlVqgFgySEP.92r9y6SKFLkQjPPsiEPSG48jNhr9dfyt3nb6.KOwm1CgFfLB4V7XEuVGfbtWL
 XVTMDV0IzS12JIkSWhcxfjR53u2gT8xTo3BiLF9pUWq6IT78xDO_SPOYav8RuFrlPWza_gpTbNPE
 chul_0USpDsEU0Wmnyr8ddSQvjjcFgLwt_pGFYXu8nlDOjDrSRXUrf52PWHo.THfS5qydGVxKQLO
 CuK9ar5ao81b0KD.9vsiEN8C7fHqo7QS2bjGfjaxUaB1BTNEse1def3w7H9dSPnwN44zUR2eWSsA
 U1bk0TuXrjKxpYRWxaZdRz2s_t_rybyCUUpn39YUaj3Lv6wPho4sjLWXrcjAIedces39dMD7OQQ3
 L89_Ngq7fFZ3wqUXRo8IR72QD1nVdUMGAYPaDlUGr0A6I9M4hmdrHT41kYYX9OnQWnl.pelsgn4I
 9UhTL8E308s7U.aF1AQ0FtQ_TfcOU.W3FXF4AjhF5SL57hlWp2ETyYkj_rqmTNlIHHhri2roT8P9
 HtvOGpaSQB6S22SHpy114L1qfYzrv6Ag7krN60zBjdSf8qgDMl_XKYGZNULVQaRlXy_cr75_JsSG
 gmQWUTvG__NDjaLQVYFVhd6Yi_uxssupBEYOQoUnZGf59r_PEEoFj_SZMTNQvxnzIBZozpPvpVSE
 bzheOsj1Im6ZzYmYAXaq9HuVCUpzbGvmaCjSva_86mQxkTh5bjFluPmM7VIFAp988FTqSa1CxtDC
 YjlyG5c71I.W_2NrhUfO1Bridbmp6.C5LScB4hPlLwllNAq2hmFdCarW9_OkpYOu_hznbzIQacbM
 8SA6pjCXTNu3G8Gy4Z88A5iN6qBh2uiQjfC766cu1k7rW75ssDK1LBXfH2K177Pv7iYQt.L_jVWV
 yhNxFuJTgc7Y2HLsn9Ij_99SefOeZR1p13XFRkknVbbhTow--
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: ac5ef29e-e26b-4b88-9572-1a7679b59f89
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic313.consmr.mail.gq1.yahoo.com with HTTP; Wed, 19 Aug 2026 19:09:11 +0000
Received: by hermes--production-bf1-54b5569bdc-qwskm (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID a90e575e3ebcc0470bae79e8d3e34cf5; 
 Wed, 19 Aug 2026 19:09:07 +0000 (UTC)
Message-ID: <f0ffe015-1bc5-4091-8dbe-2b4eee9cec2d@aol.com>
Date: Wed, 19 Aug 2026 15:09:06 -0400
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
 <7ab98288-0c5e-472d-87dd-5586e60027bb@aol.com>
Content-Language: en-US
In-Reply-To: <7ab98288-0c5e-472d-87dd-5586e60027bb@aol.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26254
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
Received-SPF: pass client-ip=98.137.65.83; envelope-from=brchuckz@aol.com;
 helo=sonic313-20.consmr.mail.gq1.yahoo.com
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

On 8/19/2026 1:49 PM, Chuck Zmudzinski wrote:
> On 8/19/2026 11:47 AM, Chuck Zmudzinski wrote:
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
>>> treatment. Earlier on we also talked about the region not necessarily being
>>> page-aligned. That poses, even with r/o exposure, the question of other
>>> data on the same (leading / trailing) pages. This may imply that the
>>> copying needs to be done strictly in Dom0, for both DM and guest to only
>>> ever act on copies (which may then as well be r/w).
>> 
>> Yes, I am thinking the DM should make a copy host OpRegion and never expose
>> the host OpRegion to the guest but only a copy of it.
>> 
>> The reason we need a patch like this is that with the introduction of the
>> rvda/rvds fields into the OpRegion, the OpRegion is not always position-independent
>> so its contents might be unsuitable in the guest address space, so in those cases
>> we need to patch the copy of the OpRegion that will be exposed to the guest.
>> If there is an extended VBT the DM will also get a copy of it, make a copy of
>> it, and expose it to the guest by appending it contiguous with the OpRegion.
>> Since in this scenario we are assuming the DM knows the contents of the OpRegion,
>> then it can find the host VBT and make a copy of it without needing hvmloader
>> to send the rvda and rvds values to it.
>> 
>> Then, the remaining question is which component (DM or hvmloader) will patch it
>> if it needs to be patched to make the guest's copy of it compatible with the guest
>> address space.
> 
> As I noted earlier, it think it would be advantageous for the Xen platform as whole
> for the patching to be done in hvmloader. That way, support for extended VBT is
> automatically added for all implementations of the DM, not just for Qemu. But the
> downside is that for hvmloader to do the patching, it needs to know the host OpRegion
> address, which one could argue it should not need to know. This is the only reason I
> can think of to do the patching of the OpRegion in the DM instead of in hvmloader: to
> avoid disclosing the host OpRegion address to the guest.

Correction: Actually, with this new scenario, we need not disclose any confidential
host addresses to hvmloader if the DM removes such information from the copy of
the OpRegion that it exposes to hvmloader. Then, all hvmloader needs to know to
ensure the OpRegion is compatible with the guest's address space is the guest
address of the OpRegion. It need not know either the host OpRegion address or the
host VBT address.

So the guidance I need from you to do v3 of the patch is simply to answer these
two questions.

1. Should I write v3 of the patch not only assuming the DM will never expose the
host OpRegion to hvmloader, but also assuming that the DM is responsible for
patching the OpRegion to ensure it is compatible with guest address space?

Or

2. Should I write v3 of the patch assuming that hvmloader is responsible for
patching the OpRegion so it is compatible with the guest address space?

Chuck

