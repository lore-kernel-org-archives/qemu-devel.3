Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DBDCC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 13:04:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx2RA-0007yF-FV; Thu, 20 Aug 2026 09:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wx2R8-0007vq-LO
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 09:04:02 -0400
Received: from sonic311-23.consmr.mail.gq1.yahoo.com ([98.137.65.204])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wx2R6-0006h7-Py
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 09:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1787231038; bh=i5Eu7usWgUNGH7tQ609dvRBkhY6X77619nihwt8Hxck=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To;
 b=L9a2au6QajmBAYpRVifTYsRA9xIrE/C6fhoUacu7q71HnOUzCK9v68r3sGqaf+JKr6f2sMsguAyGVxIr0J+trl5q7zQYSqLAPN/5CRnK9bhiFP0q0mV2jr0sPxpKQMc8WHkiPaFj9tcdB2Wo3HkeSrY2NEs8EdmvHyaO7muMlVlJySiNLXPnUZitg3ADJatsWEG9GN3fClN3DUji4IUBtveaUZnuswYnGWjX8BMb46SoqtzEGACZoL78+L/BwtRO4u8jAtyW3ODBefYD1YhBovYjCBsOHdcWeTMkNbkkRfpEE0LzMQAmwZ8p8u84sV1h4CKJ1pHg31TzavobbMeUeA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787231038; bh=9Wap8fShXxd0pgpjiAndfj3Ogrx9UFL9/1kJ2NV0ulk=;
 h=X-Sonic-MF:Date:Subject:To:From:From:Subject;
 b=ulVqXCPlZEb7NJOGoGCfOqFyccJkjDZVnXH7HAdoq+zELagISbn23qxEoIsvX4QS/TyyXR7JYf9eLpz+LvYi1cwtFjg0sIKv2MSt8Xg9NU4/uBz8chA+h0q5dYCtt0FZjARJvMyd4jcWCXLPFo3anuLIZ1O2hG9TJS7OA537TOzuhyRjyns4bTaC4heP7sn8AkSz8gzHortWotnwVsjta2okiGs9/8KL8z/t5KAZaiZ562LgBGWa4jfgx/ywd93TyDlrGrQqbH9nOGIYtI5tPvWpzoRcYrXbrYLpIyM2PLDbbRHo80spiNobxUUq9nz7sDPefPFB6Pkw7iAKrm9IDA==
X-YMail-OSG: _8Jqip0VM1mym9x9D7e3N8UllgSpYO8byynk1hmAkca4Z4RcxhZJIES6LJDP23M
 L5TjHHo0yHBzpbQLYXofs7HpFmbN6LER3dIbAJTXTR9zLYARBc6yUAvWPYwX_E0tkEAAsqrMRHoW
 EsqOjXYAd3E0p6f8CyFQIryfrWm4lCnr2Thg2n40AVkpMTma9r.PjhBT4PtByhRKgLLHs39sFI77
 CzH8Xb6CQKm4Lj8PCoV_8ZLFZefGp0ZXKzBRgPQPZbHAwZyXwerXJ5HSgY2Vgu_Jx8qj82CJR4zj
 xgjNaN4AAx4gWKdePAh5mln8AbYcEENJ3tKXrehSnS6_LdKe4GRAirYuVqpo400NeCp7YiCPvwG0
 ffKM1AQKneX1ydLeG.bnbHtTKplWbLhDOZZRNeNDTUgAAOXnHok9Ve7ab0qMZQsAeMB0nWi_7xgk
 9PeOmdzdncTDoP3XPc8k_Dd6tMNbhmEhFgC6LzWS1J4cSf_AsGx_PdfDlXXjNbygeN0skFfeTCGj
 dEqlcNonbRB.kTAQp10fTFuIIV39P3BihwARbvae9.v3FU_hb.UYSainf9d1j3kY6r3nHc7Zwz0b
 m3Df4ilLie1th1z5bamtIKCVXEvK64a3TC8xpnD5wD_reqUJ77lJ0ECB7XoXMQA27MnJKUPMEtet
 DfmzR_9ltjPHMw60oDDxeFLN_poDC1QOiKQjtDuqdZOvLlPXKu7bD6qLSAaHGbD96ckVt0fohErM
 6EF15lXCVUhn3oFWUFk5K9L3nRImzIm4tuLKRoZ9BARbjWOFTyWyDJEFwr4cCJyrxL4WOQf6fUNL
 uhmODDzRHoWu6fFMTJe1NPjxW2XyDbXC5FjoAQfYgctWvkbxmMC0C89wmrD3XmZYwKvebcLf9KoU
 MsgN8GFWlZY_CZhv0XSSyrY00YU57W1sI2nCBQ.lUjrbWRZd6jO_Xa.PozlZUDGMzpF8mrsbKs2L
 v1xKPBNhQoQIFm5IKGlL7z5ZAKliNlD8hy8fz6lx15Ahgt0inxZylIzMqVvfY3P1cxQa95h3CybX
 2A1aEIM6MJdQcNl4FJvPixwqMdb06a1E3PewQp78SCcRPpu0vKtrY._SvUKt8ZJsEdXkytKzP_.W
 QFcMPPX2.klOk0pO1dofHrSizgxEhmREoq4Z.N9HSEYRoS.MAqN6EgNC.dBPG.JenGf6VsXTblgb
 YAETT6Ci6Pb2Igw9qJixpRib9cznCH3efj6Zn0B7qEcNiXleDpYtpD2X_htJYGzXGk2B21PL9W7g
 6CWTMbl4vrt52lVQkog.nVP3QQa8.huZgSFwJtqJgQS6g7joAP6qxk6a_zSWQVFozGNIILo60FUi
 FK_j27hwn_plhHQrb60I9vxFqYg0q2goARcwefcNKE6.1YRjDPTtohPol9boyH18BSiMYch0oWeI
 oj3NMhRt7yjf9jwiDMGLdH7QiCVRk5Xb0o6LkAEyA96FF72rF1fcQLVhuZy7Kotk2FMlFW.w26Sr
 Y5UuSfvaETsCQh2U7W8YPgB1OKsIO8uD34.OMUWYArDAuOMDMRm9bCU2f.kQo.g1g26vDdg1mdx3
 slfhHcjs4q4CJ.0XpfoirA9SPnFBztdm3t6O6A9m1tQElCyTQhlx9ifRY9bW7eOSUK7sdDYAmPkc
 9uRYmJKM2Xe1pPwGgSEZrzV6r8e3zCSxO.l6snXWR1YV1Dw9A17RstfdHnog6NttMTMiE0GtmG_P
 NcwtEHCjUKVcT_XSlLlhmz22RrN_QmQ6G4t2Iz3_LsrutRGOJBUzvDjKu4tf7NEBqJfH8REi_wit
 XJGpeEE1ztepOiHEHPC37_p9ape_IReiWaIjzHZAhRB8rpFkRQXYfwkeCx2hvhB_0q3SqkU60SoE
 LMdRlevYJY_zPTU2AbYrBqU0oEu.kPPq0OziAjfIAL_6dpSi.UvUKpwUa7Xp.3ES6TSUtWHOIWxQ
 cr87xjJBsFhQJ.aUixBRoT0x4Pn_2BtrlEgxdLnSyOJx7YpSWrqFcrPv0g0qpv2jA3x15nlhsZHL
 p8Lgk4VKj2RkvxnmS.yhlZtY1qW9fwa0egN53SQKwDQ1.xfdxgKFhxpg1fCS3WsxvKCisHnnOyod
 mxRF7aySDYo7UjuyI2XPE8UfZXp8bgmf1iD6zDtk413HV2CT6VtbTG5hNg1KUzgat8eyMojBZ6RW
 WyMPVLew6geHpbowXcAed18VEU_tI.M9K42ATR8j8WpOFg3YJ6XbDpYL9UKOmVZTkySAaOZ8cQuG
 wuSFiNBVLupWIpY0YGMycRkoVeyrUD4yXkYIxuWFaL_5J
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: 373cb663-2d27-4eb2-81bf-d41bc8c998ce
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic311.consmr.mail.gq1.yahoo.com with HTTP; Thu, 20 Aug 2026 13:03:58 +0000
Received: by hermes--production-ne1-6dbcb84f44-46rwf (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID a8e2a332f422a3d65c31f2075610e6e2; 
 Thu, 20 Aug 2026 13:03:54 +0000 (UTC)
Message-ID: <17066d50-9809-47c4-87b2-7f33bfb528ad@aol.com>
Date: Thu, 20 Aug 2026 09:03:55 -0400
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
 <efd82852-484d-4b59-8d04-887533c13dea@suse.com>
Content-Language: en-US
From: Chuck Zmudzinski <brchuckz@aol.com>
In-Reply-To: <efd82852-484d-4b59-8d04-887533c13dea@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26254
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
Received-SPF: pass client-ip=98.137.65.204; envelope-from=brchuckz@aol.com;
 helo=sonic311-23.consmr.mail.gq1.yahoo.com
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

On 8/20/2026 3:53 AM, Jan Beulich wrote:
> On 19.08.2026 19:49, Chuck Zmudzinski wrote:
>> On 8/19/2026 11:47 AM, Chuck Zmudzinski wrote:
>>> On 8/19/2026 9:51 AM, Jan Beulich wrote:
>>>> On 19.08.2026 14:36, Chuck Zmudzinski wrote:
>>>>> On 8/19/2026 8:16 AM, Chuck Zmudzinski wrote:
>>>>>> Yes, I agree that v3 of the patch to hvmloader should presume that the DM can get
>>>>>> a copy of the OpRegion and read its contents so most of this can be done in the
>>>>>> DM instead of in hvmloader. So from hvmloader's perspective, the patch will be more
>>>>>> about avoiding the layering violation than anything else.
>>>>>
>>>>> However, there is one advantage, from the viewpoint of the Xen virtualization platform
>>>>> as a whole, to do the patching of the OpRegion in hvmloader instead of in the DM.
>>>>>
>>>>> If we patch the OpRegion in hvmloader as v2 of this patch does, we provide a common
>>>>> solution for extended VBT support for Intel IGD devices that would be compatible with
>>>>> all DM implementations, not just with Qemu. So why not do the patching of the OpRegion
>>>>> in hvmloader?
>>>>
>>>> As indicated before: If the OpRegion holds data that is needed to drive the
>>>> device, and if the OpRegion is exposed writable to guests, then guest can
>>>> screw up that data such that subsequent guests won't work anymore. Hence
>>>> exposing to guests (which includes hvmloader) needs to be stopped, or at
>>>> least be limited to r/o. That, in fact, includes exposing to any privilege-
>>>> restricted DM as well.
>>>>
>>>> Exposing r/o may be entirely okay (i.e. may not be a layering violation),
>>>> depending how exactly an OpRegion surfaces for a device (on the host). Aiui
>>>> it's not addressed by any of the BARs, yet it looks like it needs similar
>>>> treatment. Earlier on we also talked about the region not necessarily being
>>>> page-aligned. That poses, even with r/o exposure, the question of other
>>>> data on the same (leading / trailing) pages. This may imply that the
>>>> copying needs to be done strictly in Dom0, for both DM and guest to only
>>>> ever act on copies (which may then as well be r/w).
>>>
>>> Yes, I am thinking the DM should make a copy host OpRegion and never expose
>>> the host OpRegion to the guest but only a copy of it.
>>>
>>> The reason we need a patch like this is that with the introduction of the
>>> rvda/rvds fields into the OpRegion, the OpRegion is not always position-independent
>>> so its contents might be unsuitable in the guest address space, so in those cases
>>> we need to patch the copy of the OpRegion that will be exposed to the guest.
>>> If there is an extended VBT the DM will also get a copy of it, make a copy of
>>> it, and expose it to the guest by appending it contiguous with the OpRegion.
>>> Since in this scenario we are assuming the DM knows the contents of the OpRegion,
>>> then it can find the host VBT and make a copy of it without needing hvmloader
>>> to send the rvda and rvds values to it.
>>>
>>> Then, the remaining question is which component (DM or hvmloader) will patch it
>>> if it needs to be patched to make the guest's copy of it compatible with the guest
>>> address space.
>> 
>> As I noted earlier, it think it would be advantageous for the Xen platform as whole
>> for the patching to be done in hvmloader. That way, support for extended VBT is
>> automatically added for all implementations of the DM, not just for Qemu. But the
>> downside is that for hvmloader to do the patching, it needs to know the host OpRegion
>> address, which one could argue it should not need to know. This is the only reason I
>> can think of to do the patching of the OpRegion in the DM instead of in hvmloader: to
>> avoid disclosing the host OpRegion address to the guest.
>> 
>> But we trust hvmloader, don't we, to not abuse this knowledge of the host's OpRegion
>> address?
> 
> No, we cannot (fully) trust hvmloader.

That is good to know.

Chuck

