Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4FFC5DF85
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 17:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwjrO-0006Wf-8n; Wed, 19 Aug 2026 13:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wwjrM-0006WW-OR
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 13:13:52 -0400
Received: from sonic308-55.consmr.mail.gq1.yahoo.com ([98.137.68.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wwjrK-0005xU-T8
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 13:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1787159627; bh=BanAkv7rgc8Cm9c0aFLe97SGo72w3NkF9rLVAthNeQQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To;
 b=HsM/Au0jM8VK870ek+t9k8ep3KXLMNzFohuKoFKvsmRYQiJCqd1ffRRWrncFnhlOUf4c1RwYb2itcnEfvQHv1CWn2zDOaLSjRwGVwjMD650PUwRM/PLvU2lXkIjraM3e6eVXzA32KODVDHmNNU1cXxA9ERatgzFppxkk1xiiaYkNivp1omXHQmXNByZVOGHsPkU6B85xUZ9STMWZkhwV2uU7X+zkIyjXimAuH546EMWctkyWDXcYgn2DqiBIV/LLkn/af/yXz+y3NEaEcZWdvd1c9m3B5FKiklo/HpdygN3zN0c1y/B6O9S3rx/LcRqcf0jz7j8X6bKAfLC5+FZmWw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787159627; bh=bOQF6M36pSZCahM7VdwAAR/NtnEHpJ7B+U55I/q8XeI=;
 h=X-Sonic-MF:Date:Subject:To:From:From:Subject;
 b=NEM5pY58Myc/T9ZHXKD+bCoPyy+KANjAW+dTokG6rrm6rtPUEXBpYYD8km+jBfrwht5DW09Gc8enknCssXJ0klmLJt83U/47lmmqgWw3v0J6nLGMOd0mphRFzHHBpancTKnpYnl/SBrontXqSpHBYiYkcTuM42vsYPkUvd7B1f4wlGTrwlX5fMQFGLxdmBpZvtTUmOoqW24U1bwa567c2V6wvipTUosMzENxvTI/kfAA68Xv6Cj3uSNqYNRs4ZLbXQlqkDwvzSsv+pFAM3hOoacYctadeZHZcKOvO+tJb824qF7dZp4GxOrZsar/gWQMDmCEgTxUcvzMZS2ZRFcPnQ==
X-YMail-OSG: I47cM1cVM1kgh0nrQvai66kGGwf.OQnEcPY_KKa6ubPsjpmNb1m.cAe9xxsraL9
 lR.agm7gh9T5pVLcVdi.lvsQfGO89Sj0Do5FjgW18spVhO4AZkw_qV4aUjyal._JJi4NiBCO9qbl
 NmKwURDqoGtPYDqEK5JmBnVDJmzlzH73pp2OHo0Xycef9Wg8GY4.M2TiH4342VfyvUyzZBiajTON
 cPRiRYqSfEtRju3UeoKKnue3vbcV4Uf5wMHivUN18JzHP.sfew3QKbhNgUKxT8OL2y.NiUPFNLM0
 C59Y2KGmBoaPtHJHd84kAAdskmsFFjOvMfXsb3NS1D5iNaVG4MoMUgW4SjT_VxBbM6PyrRcf5N79
 FgriVgpZk60SGw.GTw63IzlLLAQQras.bLwowZDY83dIW0q5bo4DGb2qY3DroeQK8XPZ7zAidWqM
 fwzfav1pMmlbdo_TPccMRXnBiCVxolelSMd6g94VL8RR618u1ehTstEa4bTBwZ0.JheWxplDGFov
 qmMBjtP0mBEeX.w5rR9PjATdL2KPR5VfVhYc23MwET2LdhS_uCS9ckViTfINclegtLugH6mJJcrm
 GCksJD4sfekYro7WglZkfcN35G4TXPY6gpOFk1_yd2oluAay4Y3jdzfACKLjvCIwNry6GBo4W0B_
 43SK.EYE5cnP6I_Sv8u.1m3gietWkqml5GPE6u5UxhGG24swj3zZ4oOsQzJcCAKr0Ujcjne8qqaK
 AOH3NDEcsxE.7XyV33mB.dWk8HOyYJ7Kn4UtvqrcLU46h2rhN9kVQ1poHKMh.hQH4DciqrURDmY5
 AW7gpddl2ebUkqXxk05UP3AA0wPqzcFFyazNwGUY6YMnEh8nOn9..dMWI9BL0vlbik0wd276e7M1
 7ceWZfrD9Mln_36kmG7ewXcqEjRBUXmy8xz3NLmvj0mnCJ0jIllSpSrh9s.jXMQ0t.ZRogXZNIr9
 pA0hN67nFSOaBBdPOoRABGzgQO0dYSaDPZhz8QsK7wdywYD6oFRquo0a2SZ2exu_67EncDq0Qe9P
 UnFjgvPKtckTz0Yx8RPxJH6oozQ_jdbFzJ9zoChY05hSOla_.ZQgnEMrIqIi1HWWwexfQxdbIMIe
 aLcEM5fiomtJXrKYVx2Q3Fpkg0nKwjFoPg.XaJvCYZP67yt8YHMmf3heBqyrvPLwyWRi0GMbGBkr
 IWaJi9lCtjvhJ.B5WNsIPW_8znlYAfbuCicRXtAxRAXs2PTGGBrDEaM_vH1YbK0DTnFdOIm4hWSU
 P6Q7mlZ_kbTn0hYnniF39NFU02S8EOHpR670ZBDOmMH8ZhH.IU49AAz4zJIujHjkWf_UbT5ILNaN
 tuWP4I9KbdJJrL6yzUkFu.77VC0bslbi7c25zT2WyyWLNKDm_uTtEC6I02kQU.fYzGtqUFXyrjOL
 S1Spa3MY2TeKmz28Pk9YQZvSzQw8XgV_gx4gPaCxdzE0P1NPgosg_VrP4zpl3WJwGz8BZMU6.hc5
 YQs8YfLctMkUEmT0k9_v0p5G20yBNKbdz9Vq6kUh.a3YcaCmj9Xh8qzi6nYhlYfNYjYB2MIGAHwT
 .jldyJB02PtyFDT.4WJ7RyiqEevt84XK3ufUCOTGkc5CCI.iEWRjpuRhFSG6ZkZnHX8m9J5WFJGi
 GbFRFZiXl8f0wQUmR3_q3jP7TVPRNIu8AnhZRXyrF_T7r4uXnSktYNXPj7e5vKa90ZikIHzaCemW
 uB7yic_0CI0.8xLe48RJC29qxsiiANI9h6_mTObTjLYLNbJqO8l_ZIbDuEq.0bb_4WOHvMK1JhyT
 ndRDqYdlr5Bjs74WnBV50YGg92hxQHnpnA9wtEXgFZLk.SYixbOUKmdcsjMSttTnhscWU4hICMOU
 zZ2.GrxVBJvdmY9uXGfhSF4jSL9RJjvasM5PAf7Zfm2G2WilzsifsDDHTGwMrA7rfWfQfj6FUkCA
 wOHE.Ivmpy5BykTKexO_h7JcM3ypWNJAA5e5YvK.vZXwYpwQwonGGjIJR.BtMvh7S3SbOmu40oqG
 dkeMJ.0Oq5L_.UW5_uMxCB6HXyycf5XZ6kVpRbdyARZ5btFtpw4mLe32RSn63zDQJr5ainQ.lIyF
 AHKHQaAI4bbMh3lmkNvzBY7xUzcWPPcfHijHpwbs2y28SPxCqG0yK8FVsg40HfBMdA7.HYsy9ria
 p7Rtqp17YdFWQWcub5KsJfi_ycoiCh2p4iIyk3YKhU_6GVVwMYNm5MK5MQHiyHd3Qh56PuWaKNox
 PVK7znSjMBroqX79WmjeeW7bsBiVslHKN2yAhR6ZlQtix
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: 7905f90b-7e4e-497a-aa21-e5becffaebf2
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic308.consmr.mail.gq1.yahoo.com with HTTP; Wed, 19 Aug 2026 17:13:47 +0000
Received: by hermes--production-bf1-54b5569bdc-t2h4f (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 742b15b49534c807090a38b8b6396e9e; 
 Wed, 19 Aug 2026 17:13:45 +0000 (UTC)
Message-ID: <b14969c8-9676-404e-b7cc-ce13a6d7ff94@aol.com>
Date: Wed, 19 Aug 2026 13:13:43 -0400
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
 <31a5870f-2a4d-4dc0-af9c-f0567e0f6fb3@aol.com>
 <db8fd04d-bbc7-41c7-8473-b821d7f77d5f@aol.com>
 <302ed12f-40ca-405c-80ca-ac4f2785d754@suse.com>
 <cdae1785-4d9a-4aab-929e-de55c26b7b94@aol.com>
 <10cd9f6b-678b-407b-a51e-70e9ed7a35fd@aol.com>
 <131b1252-b108-4b4c-8457-673ff0d20d5e@suse.com>
Content-Language: en-US
From: Chuck Zmudzinski <brchuckz@aol.com>
In-Reply-To: <131b1252-b108-4b4c-8457-673ff0d20d5e@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26254
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
Received-SPF: pass client-ip=98.137.68.31; envelope-from=brchuckz@aol.com;
 helo=sonic308-55.consmr.mail.gq1.yahoo.com
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

On 8/19/2026 9:51 AM, Jan Beulich wrote:
> On 19.08.2026 14:36, Chuck Zmudzinski wrote:
>> On 8/19/2026 8:16 AM, Chuck Zmudzinski wrote:
>>> Yes, I agree that v3 of the patch to hvmloader should presume that the DM can get
>>> a copy of the OpRegion and read its contents so most of this can be done in the
>>> DM instead of in hvmloader. So from hvmloader's perspective, the patch will be more
>>> about avoiding the layering violation than anything else.
>> 
>> However, there is one advantage, from the viewpoint of the Xen virtualization platform
>> as a whole, to do the patching of the OpRegion in hvmloader instead of in the DM.
>> 
>> If we patch the OpRegion in hvmloader as v2 of this patch does, we provide a common
>> solution for extended VBT support for Intel IGD devices that would be compatible with
>> all DM implementations, not just with Qemu. So why not do the patching of the OpRegion
>> in hvmloader?
> 
> As indicated before: If the OpRegion holds data that is needed to drive the
> device, and if the OpRegion is exposed writable to guests, then guest can
> screw up that data such that subsequent guests won't work anymore. Hence
> exposing to guests (which includes hvmloader) needs to be stopped, or at
> least be limited to r/o. That, in fact, includes exposing to any privilege-
> restricted DM as well.
> 
> Exposing r/o may be entirely okay (i.e. may not be a layering violation),
> depending how exactly an OpRegion surfaces for a device (on the host). Aiui
> it's not addressed by any of the BARs, yet it looks like it needs similar
> treatment.

Yes, the OpRegion is not one of the BARs as specified by the PCI specs, but
it functions more or less like a BAR region with the devices's ASLS register
at offset 0xfc in the PCI device config space of the device acting like the
BAR for that region.

Actually, in hvmloader code, this value of 0xfc for the OpRegion ASLS register
is added to the header file where all the other registers defined by the
PCI spec live: tools/firmware/hvmloader/pci_regs.h, but in that file it is
defined by the PCI_INTEL_OPREGION macro.

So this is another cleanup of this I could do along with this patch: Remove
the define of PCI_INTEL_OPREGION from pci_regs.h (after all, it is not part
of the PCI spec anyways) and pci.c (or the new intel-opregion.c file if some
version of it survives until later versions of this patch) can get the value
for the ASLS register from a header where specs for the IGD OpRegion are
located instead, or it can just be added to config.h where the other IGD related
definitions currently are in hvmloader code.

Chuck

