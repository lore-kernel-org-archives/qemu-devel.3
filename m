Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8BA8C5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 19:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuxLX-0004ZV-Bv; Fri, 14 Aug 2026 15:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wuxLT-0004ZI-JK
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 15:13:36 -0400
Received: from sonic311-24.consmr.mail.gq1.yahoo.com ([98.137.65.205])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wuxLP-0001oR-Ik
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 15:13:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1786734808; bh=N5mOhM3pcLYxdtmPCBlPtPi8tMcEy9IQ0eVheW8E5UU=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From:Subject:Reply-To;
 b=XIKpz409dKAEE+vxWMLVrkmW42Rwnqb3TSUSAiPkcb8WQgFZQkwqfwrWJMJoUX0El3l+ebga7DKEf/jfuNqAfgYLM4jaSseGWP8/NMscfzdqq06qbgsrVA0uXg9byp14njB7JBHbupGSXz8Gn17IpZBXi1xrEOr8vbmelmZcyCGVxL8IW8Uqw1eYKPQo2b7XirvgS/ePl95iKHk2eh9IrdoiUMNlQ/XYS321R+ofmb2gURNTBONbzUH+N465Mpd0nnL8ZwgKVtCaA2z1Vl+KeJ62Eun1fRpau+VNMn/w2OBqWY0UtcZvTf4kWg3/wWQz1Xd35JUp5HQAiw6FQcBJ7A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1786734808; bh=W2GOJvWm0oO20Hcw38oTUdca3Leq4Wzq6VMhVFb8EY5=;
 h=X-Sonic-MF:Date:Subject:From:To:From:Subject;
 b=kbpn/uOAcFJG5q7w6zEIGJElWZ7r87ql24PIq/BCNqyoSNRvWKuslz2CWHPZotKZLSxjqcmNOskCLpapdFmnRjPInhXxnxe9nGdM+sPg4PgvCLhVKctpxMq3t4jsNE8riLckWCIa+/Sn3RIl5rpBHmlbyFLVPR8m590QPm/deQFAFf4pg3I90ZSNBnLGiHvARkDkmgyCqKyDuCqGD6amPKJJNa42De2c6F7C3NdCgU8eGRJxguXAXfSfB0VeAhLgq1K0N1TWlSW250/wBEb/HR3iy9QRi8GBJECH6BW7VU9yeYkacU4MbhFtjC13+oWwwqY+uhugRy3cZ2KAKi7Abg==
X-YMail-OSG: odNvy4wVM1nwqvG_z1AEeE6RgFZbu0hYKl3eOTRJrKUNm2lZOFmXGVFN0yha3Cj
 4FSwEKb2iYImKMO8eBnus6aNOQSRVdeveieDG_lpAK7TmZ5Y2d0Wlzwgc7DS79wj.0zaB0pTZ2cU
 ve20aJ3cRIaFaduambdkkG_kA5xoubaNRv8mA9aQNc0G_SSUWNTeIyxxx4x.nipY3NlxTMsVbffq
 e0fM3UnOQpQLyKV4MbTMcrUIYPb_6frE5jBVplUa_FN2ai.1qFHAp0SJbmHQPgPqdoLgfl.1di3Y
 KkRQWTOVZWhe6C.SV_JFGde30EwsH2v_gXJW05U9XfQJ6pomfLSSnuXof7bSQSDdpk9jsd40LxSl
 WtI1PhpJYLwgCbdfnXpR9W9NRF3wmc6H.85uJx1pqwbIMR87bs8Nr49f11CGGNuQVnw6ZSU1z_mQ
 hyOxZDRfKDTdpdduIq8Q5BuNBsJLse3yB3D5lnhsDdt8HEA4idOzWw_T9AIbYwqEoUsm_Nrlxb5o
 2julYMdgTrEG5SulcDKlm8GwzsNTcxaw8R5UQ1sRQj8DIFYK3nG0KvSKfJVslqBiWOwIs4w90Pp4
 KpBV8IH6FR_bBAUCvW1_j9E0xcAizcZ_ZmU6xG1UdqFnjG.VUXMlqmEnoleni86NaAB5bnKSeY5r
 GfL2Jul0VvRCnJwoqHqCtkPiKE384hKWsWk.wWVLwZFR5DKVTT.TS.CiXRpuQ.tNXB7NCpNGBr9W
 pXQng6SRqUE4NUeMZM.hH3mwAk3xid4pWOyIm_oN.B9jFt4gIDHzhaqbP8k5YBsFCWBaMwjykGGB
 SU80gI4fVT6DOOB7THvylvTnEqoWjF_Oi2IIBRU6MCYz3M0hXMb3V9hhl06ASfSNfygm2LVBCZpA
 ildzE3RpKYbgKnrponecBmtHeYM7YIzH6pTjIIUEB_Nc3_pzQ28PuoEm13hPMwEB9xNBoBme4toO
 607CBneSf3ratd._AeiOba4x_cDLHFpRKxnzP2ClfUd2ZmjnJ6XxwZbvTAOEr51h70wsJXEPLnTa
 C_p_mrnKy6Z7PTbib6NVEhB1xhdshMt.fAFThQ7cSGLimVf3_ARWY7R1SWVoZGzPuHUVt_2b.DaS
 WMfbdiSkBs0DcOIzA6F6bty7Pie77dLG1VpS87hEw4hZJqfK0IHlacWJTTK5WYR_sSjgUUlOdmy6
 erllfM5w7GiLsQhjRUS7pOZ8.6JP7blhtqGdAQhXMjy9D7wtjaqzqVf2aZC0eWEr47wjYS9i6w1j
 SwgqTrS87._ZEaR6sCy8fS4ZIpQbSB_eV.3jpK7FSeR6N6Hwl0sT0cqekG1g71CA7L43x2sM8L2F
 1PE3jWPx5PtSerYnKurNx5p0_AOoyP_p9ttPKk.6RVshhH_G51GDRNsNYT4cRlax1C.cHCRJjXNK
 PO3kV5flrL1OfKWEPDsVn6PxpVZj2.4iGOcqwuaHlZ7.vHiJn6xMZ4SzPXU9_cip3kSCjsGhNEWF
 SriNnGWvWd0niC8qBGI0jkCwzRN6Ikpr3uTBsLyYG.Rw_djkpY.qSKg4bgYQKPRlCvEqCNjttuL4
 9S5ZzHgU5X_bMdlxk4Ty7eJGb4R5RRPNEdBQTtYqB6DKTYydFrrCO2VJ0kZaSSLcPAI_rwVGZUfV
 pmgT0gCYYhSeN3VbrP2Ko94GQGgKvauNE39npwZ1Bzqhz2ATSCBihYQfrAXPeVadN4TUi0U3zczV
 YHU3CVV7AWgqyGqq08j3q75nyVcLpm1UIRUtumGDwk.mFmzNJ9yM6fP_rOzvdF9Dlx2Oi_IP2m39
 oyfaSKUKE1DnVmEjXKVY_56aXkkstUabd7yyLTn71qeR61laFmZ33SEcX3KrvsjDU.yfeewV1iub
 vSUL58409BDv2AOUEr1RumQ1B2JDYZVnhqRl.UV6HFMyUS6Gh8G4nUZTgsEIZktkpDKrbnKfW0Gc
 _Xf7Om2B2QNJvm.ndk.8_Uimhe3ksVvDyxtV6GYZDn84Pxjfvu9z2dM2Rd6.OXtxViJqFEAhWv.D
 K_RwhRpOFKTW_67Ty0.OzJYgvY5VqLQmLrUBQaNAXdD6q2eKmuS9natcopC7mlEjAJ4JWVoJG39N
 NYUNOqU_z7GV8KbRycs.HpC302RXsqe7RfmhLxmziJLM3WbOpZVc5.9DU18Lcib7oWBi8ICqSs3U
 LySoSojXkESmXM.XyL46HoGxLWvaasAkD2hAaK5LwyXm4k6Dg5PJgM1497iiBOS3BYCu3hDtf5GS
 qZT98tFsOEe1LVZDp_XBMBfwJwZ3VYGPde7uGK_Xb4so-
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: eb36d364-e082-4610-afec-7ad2f07bf6fe
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic311.consmr.mail.gq1.yahoo.com with HTTP; Fri, 14 Aug 2026 19:13:28 +0000
Received: by hermes--production-bf1-54b5569bdc-bl9f6 (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 1ccd2e992eb17031340ef65d0eddba97; 
 Fri, 14 Aug 2026 19:13:25 +0000 (UTC)
Message-ID: <7a3b86dc-2036-47ac-a696-bfb15b648b73@aol.com>
Date: Fri, 14 Aug 2026 15:13:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tools/hvmloader: implement Intel IGD extended VBT
 support
From: Chuck Zmudzinski <brchuckz@aol.com>
To: Jan Beulich <jbeulich@suse.com>
Cc: qemu-devel@nongnu.org, Andrew Cooper <andrew.cooper3@citrix.com>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger@xenproject.org>,
 Teddy Astie <teddy.astie@vates.tech>, Tomita Moeko <tomitamoeko@gmail.com>,
 xen-devel <xen-devel@lists.xenproject.org>,
 Anthony PERARD <anthony.perard@vates.tech>
References: <20260802050824.10554-1-brchuckz.ref@aol.com>
 <20260802050824.10554-1-brchuckz@aol.com>
 <2110d4b7-ae37-47aa-99be-ab59e16f6167@suse.com>
 <67579eba-e222-41dd-84bf-8440d2eaf2a9@netscape.net>
 <da2200cd-def7-4cce-a6c2-9f9ac9e202ce@suse.com>
 <de56c8bd-f0e8-4fe9-8cf5-f6807698176c@aol.com>
 <02a7dc18-4184-4e86-84cb-121769187f71@suse.com>
 <1858e8e6-73fa-4017-93e2-c733fbf0ec8d@aol.com>
 <1522d7a3-eb9d-40df-9a34-7b1cfeb3680e@aol.com>
Content-Language: en-US
In-Reply-To: <1522d7a3-eb9d-40df-9a34-7b1cfeb3680e@aol.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26254
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
Received-SPF: pass client-ip=98.137.65.205; envelope-from=brchuckz@aol.com;
 helo=sonic311-24.consmr.mail.gq1.yahoo.com
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

On 8/14/2026 12:18 PM, Chuck Zmudzinski wrote:
> On 8/14/2026 11:23 AM, Chuck Zmudzinski wrote:
>> On 8/14/2026 9:46 AM, Jan Beulich wrote:
>>> On 14.08.2026 15:18, Chuck Zmudzinski wrote:
>>>> On 8/14/2026 3:35 AM, Jan Beulich wrote:
>>>>> On 14.08.2026 02:45, Chuck Zmudzinski wrote:
>>>>>> On 8/13/2026 6:35 AM, Jan Beulich wrote:
>>>>>>> On 02.08.2026 07:08, Chuck Zmudzinski wrote:
>>>>>>>> -- snip --
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
> 
> I forgot to mention: In our current implementation, this statement is
> executed in the DM when hvmloader executes this statement, currently in
> hvmloader/pci:
> 
>                     pci_writel(vga_devfn, PCI_INTEL_OPREGION,
>                                igd_opregion_pgbase << PAGE_SHIFT);
> 
> 
> 
>> 
>> If I understand our current implementation correctly, this statement
>> is what gives the guest access to the host OpRegion (3 pages as defined
>> by XEN_PCI_INTEL_OPREGION_PAGES, and in agreement with IGD_OPREGION_PAGES
>> in hvmloader code). I don't think this statement makes the host OpRegion
>> accessible to the device model, though, so I think, if I understand your
>> comment in an earlier about my patch resulting in what you called a "layering
>> violation" correctly, that our current implementation is also guilty of this
>> same kind of "layering violation."
>> 
>> So, how do you suggest we fix that?

Well, that is a difficult question to answer, and if no one gives an answer
then I ask, what is the harm in making the unorthodox mapping of the OpRegion
from the host to the guest temporary for the purpose of allowing hvmloader
to setup the OpRegion properly for newer devices with new and updated specs
for the OpRegion and VBT when our current implementation permanently maps
the host OpRegion into the guest in the same unorthodox way also, that is,
without following the normal PCI MMIO interfaces?

I think the fundamental problem is the fact that the Intel IGD is an
unorthodox PCI device that does not follow the normal PCI specs and
requires adherence to Intel's proprietary specs instead.

Would that be a fair description of your problem with this patch? Are
the unorthodox requirements of the Intel IGD at the root of your issue
with this patch?

I think the reason this was allowed in the Xen codebase many years ago, I think
over 10 years ago now, is simply because the Intel IGD is such an ubiquitous
device that an exception for it was allowed.

So, to summarize what I am being asked to do in this thread, I propose the
next version of this patch should:

1. Fix style problems in this version.
2. provide a public header to define two protocols for providing
   Intel IGD support via interaction between the DM and hvmloader.
   The first protocol is the legacy protocol version, and it
   is the version that our current implementation follows. The second
   version is the new proposed protocol that is able to allow
   support for an extended VBT, which is required for newer Intel
   IGD devices.

3. For now, since only hvmloader currently has access to the host
   OpRegion in both our current implementation and the proposed new
   protocol, hvmloader will drive the decision about which protocol
   version to use for setting up the guest OpRegion. First, if the
   device model lacks support for the new protocol proposed here that
   supports the extended VBT, then hvmloader has no choice but to
   implement the current legacy protocol. Even in that case, instead
   of just printing a scary or confusing message about lack of support
   for extended VBT and continuing, which is what this version of this
   patch does, we can read the OpRegion and then print an error message
   and BUG() (or just a WARN?) only in the case when extended VBT
   support is needed for this hardware but such support is not available
   in the device model. The message could say something like:

   IGD: error: This device requires extended VBT support in the device model.
   Please upgrade the device model to a version with extended VBT support
   and try again.

   If the device does not require extended VBT support, we silently continue
   and can expect the guest will operate correctly if all else is also good.

   Now for the case when the device model does support extended VBT but the
   device is a legacy device that does not need an extended VBT. In that
   case, I think it is better to, instead of implementing the current
   legacy protocol which unconditionally maps 3 host pages into the guest
   when only 2 pages are actually needed, so an extra page from the host
   of unknown content is being exposed to the guest, we implement the new
   protocol proposed here that will reserve only two pages for the OpRegion
   in the E820 map and use a copy of the two-page OpRegion in the guest instead.
   This will be a change from this v2 of this patch which just uses the three-page
   mapped region in this case.

   Then there is the fourth case when the device model supports extended VBT
   and the device needs such support.

   To understand the approach to this problem that I have implemented in this
   patch and plan to implement in future versions until a better alternative
   is proposed, please refer to these Linux kernel commits which added support
   for extended VBT for KVM/vfio guests and which explain why this patch is
   needed for the newer Intel IGD devices that need an extended VBT:

   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git bab2c1990b78 ("vfio/pci: Add support for opregion v2.1+")
   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 49ba1a2976c8 ("vfio/pci: Add OpRegion 2.0+ Extended VBT support.")

   So, in this case, we have to implement some means for exposing both the
   OpRegion and the VBT to the guest, and we may need to also modify the
   OpRegion in some cases. Specifically, the value of the rvda field in the
   OpRegion needs to be modified in at least two cases:

   A) Host OpRegion version is 2.0. In this case, rvda is the absolute address
      of the VBT and will need to have a different value in the guest than its
      value in the host.

   B) OpRegion version is 2.1 or higher. In this case, rvda is the VBT address
      relative to the OpRegion base but if our memory map does not allow us to
      maintain the same relative offset of the VBT from the OpRegion base on the
      host, rvda will need to have a different value in the guest than its value
      in the host.
     
   For now, until a better way is proposed to expose the OpRegion and VBT to the
   guest in a way that allows the guest OpRegion to be modified as described above,
   I plan to propose the same approach of temporarily mapping the host IGD OpRegion
   and VBT so that hvmloader can obtain a copy of each region and configure the
   OpRegion and VBT appropriately for the guest that I have use in this patch,
   despite Jan's objections which, as far as I can tell, also apply to our current
   implementation.

Thanks,

Chuck

