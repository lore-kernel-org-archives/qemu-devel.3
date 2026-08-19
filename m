Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9663FC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwiVn-0006Ab-7w; Wed, 19 Aug 2026 11:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wwiVl-0006AQ-Nj
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 11:47:29 -0400
Received: from sonic303-24.consmr.mail.gq1.yahoo.com ([98.137.64.205])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wwiVj-0003Vn-SX
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 11:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1787154445; bh=oieMMDfhAvwhqSEpTV4R3AjOTw3bjj4ZSJt6BKoklFA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To;
 b=Ox+DNJdXYUbNkufDgz9xh0D4eFJWxkQCLxn9CD02nCm+FY0GbybNQatwuH3LYPVty9Jmi2GWfiVQzTCSUBwLydMkaALn/dJkdY61frw5fEgHFcUJYkezxG1k7A4s2ticj6K0oFVkIMA87fw/BgSiPX3rFhm/lLx9ZGh2zrXUV5L6/sbd5NMDFiAnL+PCDEw7L0OEFXJFMNIt3BuXA7eQ1bT6RwEW9gkuude3sqLBRAQYinQrKnYDxg+MqEw3ZfEJo+Ctl1yT66nZJ6Vj65bzNf0P3CcaxcYvZ77LWd+OjvWh27MZsSeVfE4OCefxdnKuaiQDsGq05o3oV7A3Rq8gcA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787154445; bh=uC5weUnpcDDd3XniiqwsBOch23gP3/nSZjOV+JMK1zI=;
 h=X-Sonic-MF:Date:Subject:To:From:From:Subject;
 b=NrRLYBEna+pKDQ3Kgan1kwfSF3A5Ieb+rGl8hvGY+IRJL2FGUTo2JYQ39Xicm61fwUU52ClZbtb49hpRgmBYLKt7ULAXNVUZ4tCWmrOQX/pNdiF9n44YclgXe5UFqTUqAPT944qNQduQAuimYH1lbfiVzBig9qxA1Zma1bqcywN4v6ya6U/zsVaP4d0F8j3k+SPuN6czFmbb3BJXB0fIvmr1idzVaQAT1vbFKvu6op2mvB+qlxYp3DHPSx996/ZAD47+7Ix6wMVWcvAszIxk2mmL7Jk+JV1Ruo/qElJIQaugEukT2PCgOQ1ykIqxSDv56XFbLJMh01jfigKPDpjo9g==
X-YMail-OSG: JB_skrgVM1nw1pTvkxWZx0qbHvp8TRhlfta8ZAe82lTJpG021Ijyfa6MZsEAMfH
 uikSlncdGFidtMnpbucsAQDCfubh1zPjUSxJ4gEjwcDxdUThMnrHKEsRODxXEAGjGYMWnszx977a
 4xGLBllAVD1mYoYcpO3b6EInOztKyhtDH_D3HlaOoF8Wcm_8p6ovDpDXFc.zE7RgjTgSC_0UNqoR
 ciiXdj3ytgFbwC8a9VJXTGw1Ij_HtOe3HCbEUZ3yp0FQnwLhpwwRx2XQKm0seJ5S_zjkRz9XurNC
 M6jqbvXIvalSpW611NmE1vYom_e1ZczXWzyFS_XMyKAU_D8sp8OnQ_XjyJwCCseXOLsMVBEvvVDR
 9BDiH0gOk0YzKuBou__692HSBPPA2lsrcEj69ny6hmUjxSvN_oAB4LbQgk_b4JATnwW7R4I.x4DC
 06J_WZNfX0BAr.k1ArXqJrwAjVkzhd1rAsiMXWvq3aQBHHFUYxM.1lzHEoVzeWk1M8JvLu6Q6Cdk
 5o85oi8DPZ1XXkxkXIzsG4.IQTfV79UidZyyvc9aWBQy0h.nworHFQ7JMi.wGaZgjVTTVsztjZyG
 pLgGusbu75q2B7yIJ7d07Dy7T_iLnXHesdfyD_esSFfRdhkAH6O9MpT.pHn1F4HyO2JQkx8sUC1d
 NjoF8KvU0wxOuiESGpma_QjMR1aodHkNyAUjMSdQTb5exOhAoCCFd1Q1eFTk_slgZTe47ZKa7XR.
 qijJXz9iVrJ2oxHKLX4_1T8X_jpvuBRf5_pzrI21G.3FdfDA6bPoJn.Ja_lAwQM9rBPAeC0JBf81
 BaU0nmJa2m50KxpHfmmLmfOEsaJvFSuvQLcGEXGqWhU7B8XYnhQT2eSIM3q7PCFIMknmzVoL5lww
 xiplkAzT_jXpA4I5YA_O9.ulMx1MSw68SvlizdBFHFwZ3S4ILHvyB22RiOg6f7fP8vNghByMliTj
 AmDWOQjh1uRYxa69WGvinw85G4YcG0i2zq3fGE.m9.KfgegQQAF6JXTECcdWjCH9hJ_LjNdMehK4
 oU0EXfksn6HYFz2VmKCHzqpl56xpBIjTiy2ZcYs9QCNdqZ.3wHf52ARCfXgmfGMz5EYYQIk8TMOc
 XXGgR_oYgPLqYUsF1q4ByVaYMZ8HSv1uMid7DuXSKvgWyf7dNbW4fMxilLTCzud8cRvrHSiRbsJB
 DubHdJwIz0sIDnft9ugeP7zlET3sXNZxJ0D9jjHqLVYUKqFo8iBD6WRCPeFfdAf9dHwELZkf6yan
 DcOrWgQPNTU80jhN25zIWI3kmZyQ3o22dT37tr6nVJbEuiDCpzq2YvHD0831oFcDhDfYUybeXOLb
 wlRpam94j.FE1Vr2xdmi6Pp9UXxyxuNhXoBngz_mze9nNeczUr3IBhRo633pNnrOd4TphzYKAx9I
 US4.ZXKPToamLH9bd.HcoJ.tYZ.PUHz30Dg1wsl7pCNflpX9vwQ4JrGZAq026tvZrHJxMUCzQEYC
 8xeEUkH6xwAaU_n0bv5OxWqtUrD.hIz34UKWLSlpcvvxtcja2Pg2KQcQGwv8q7kTkwupbOIcWhzV
 v3NOWpgo5scqDe0GAfkPD2AV9E7FEMVUvESgV2fqg9VbmaOaXqC3dPBHkH7vBnxG6CyUz72lDvE4
 iWnXqfrztqn5ktHAIOzb2aioYrN4XFZeLVHJpFxjA4lRjeiJRB_5tBbVkFZveAnOaegxfyf3KYJK
 cEZ5ZJIkICHLvngCZVWP68Tw4dzQNwCgwog5gzakSVPC61e_1pSqN9NYlYMRSBGW2g5LpmgT3zfy
 akcatDzXeXs1EVjLLZet7zNUoJ40M0cr3p_yq7fNZJhdP.SZtKzLtfJNDfWZu8vXB5aGqvbfGYp2
 uu8Mmr73GPSKRPbwATQjUsz851FcnTFiVaGtakEhRsfDskyRCmR7EJIEtpzOzCymtmiDQ9.eBxZu
 Bkksm8vvjkJfWFUBLVJvt3UAUWJLAoyrXOvobC1gNWcXqTdRIv08dZUFYAUAsJWx.bYOtv_96lJU
 dhJ.WfibIzyevq49aWIbob1AywjN5h7k.bdKM8fGcMFngk9LcBn85KgiZKL3UCKxCHzUUybarnqB
 FVbUC2Tnm4yy351CVHs8rpL4988Uz6NfMo7ZMA1ryBQjEzayTdysZp0focoV0gcDw9McjJh6Cev9
 xItsKmsS8ymySETRI0Z8fNShR_N8RDh8IzV_X3q6SpUuqFk6as2TTJ_z4_1OwEVBWx9Iq8qfpMn4
 xotzNZrCKVdshE90cQ8IYBG41oVC7GMcmermzFK_w3gLk.YT8
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: 8687901d-e9a8-4fa7-9114-bfc7157ed932
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic303.consmr.mail.gq1.yahoo.com with HTTP; Wed, 19 Aug 2026 15:47:25 +0000
Received: by hermes--production-ne1-6dbcb84f44-7k4wv (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID b43061383b4c87a44dcdb958addcba99; 
 Wed, 19 Aug 2026 15:47:19 +0000 (UTC)
Message-ID: <682975cc-4857-42b2-badf-b638869f3268@aol.com>
Date: Wed, 19 Aug 2026 11:47:18 -0400
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
Received-SPF: pass client-ip=98.137.64.205; envelope-from=brchuckz@aol.com;
 helo=sonic303-24.consmr.mail.gq1.yahoo.com
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
> treatment. Earlier on we also talked about the region not necessarily being
> page-aligned. That poses, even with r/o exposure, the question of other
> data on the same (leading / trailing) pages. This may imply that the
> copying needs to be done strictly in Dom0, for both DM and guest to only
> ever act on copies (which may then as well be r/w).

Yes, I am thinking the DM should make a copy host OpRegion and never expose
the host OpRegion to the guest but only a copy of it.

The reason we need a patch like this is that with the introduction of the
rvda/rvds fields into the OpRegion, the OpRegion is not always position-independent
so its contents might be unsuitable in the guest address space, so in those cases
we need to patch the copy of the OpRegion that will be exposed to the guest.
If there is an extended VBT the DM will also get a copy of it, make a copy of
it, and expose it to the guest by appending it contiguous with the OpRegion.
Since in this scenario we are assuming the DM knows the contents of the OpRegion,
then it can find the host VBT and make a copy of it without needing hvmloader
to send the rvda and rvds values to it.

Then, the remaining question is which component (DM or hvmloader) will patch it
if it needs to be patched to make the guest's copy of it compatible with the guest
address space. It could be done in the DM only after hvmloader informs the DM
where in the guest it will be in the memory map unless we make the specifications
for how hvmloader determines where it will be in the guest address space public so
the DM can compute where the OpRegion will be in the guest address space. Currently,
the DM learns this from hvmloader when hvmloader writes the guest igd_opregion_phbase
value to the ASLS register of the device (in hmvlmoader code we currently name the
ASLS register for the OpRegion using the PCI_INTEL_OPREGION macro, which is defined to
be 0xfc). 

Chuck

