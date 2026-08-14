Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF2BC5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 16:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuucA-0008LS-Mg; Fri, 14 Aug 2026 12:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wuuc8-0008L4-Pu
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 12:18:36 -0400
Received: from sonic301-22.consmr.mail.gq1.yahoo.com ([98.137.64.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wuuc6-0006qC-RX
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 12:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1786724311; bh=sZ2U0ZHbr1dOUcGv8Quuw66Z7ftlvoQtcvfayzdgWQw=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From:Subject:Reply-To;
 b=Jvgo/H+jlQPsdqphZXsdSX/FlYIHbhT9JUyxuNlQKMwfWNZVEGe7Fct/xnz8DOycCW2YEK5+Sz45GuW7S3kLrMcS7qe5GJd/nLcYUndtdHcrxhRuAKqPh8ljlCWq/8KbGiT5aNryFmbF736Z84OFeZcQV9kUQgEwdm/373OpvQZwB5OSNex6HaofmaRqry7Jtr9cP318bIGIGXxVz30v0RCiqD5BcadjKyuN456XuKVUv5mXF3RY5drMC1zkIooDmXv5+q47pZlvvGI4L+TUvNViPPsII0bC879AwauILGDtfagbFPL+anJwo6C6pXfBp/XXvW/zD1Yw1F+VMIDRuA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1786724311; bh=UTWYcY0Ukx5zq3PjBqv7g7E/uZqyleHthvEJnpNUFcc=;
 h=X-Sonic-MF:Date:Subject:From:To:From:Subject;
 b=Qw1NJVsUJmr4wc7AioDXdMRjq747ZgtNgLWXYTvgehC0vWLaMSmJzmRKdDMq1zeEJzYIa20rVbXpydF+hmIz6G7QxI0glBS3tKPjBBzHSQz/GNcWF6+m8fJ5TCTad9U4rAgKePI5ih+ng27EBmEtK7RswjVRwi9H80/7FXUn92P6LY4P8rCW7H3q5zQ9BrYYzkSC+FKUvc8oHnefWxBSvPzMHhZs10+jep8MD7+yFJonzV/ea9QjbKNVOQ7+s6kaggOLBW1+5eF5I0GtUWknn3hX55QnAubI887G7Jz25TzyAl202pn5C0ZzJER8oZU0fAm2OVP/4ppVJ1M1fUnIjQ==
X-YMail-OSG: Os7DNC8VM1kKN70GE6kcUT8_Oq835oQDRm_ae4i03DweMwSJspxFt_NrIvUblkT
 EMXlDa.wrDjdnLIKFWYNZeQXQDLHQvGl7pR892Y2Sqewz18pDgakFbVKOODOaZCCjazNpF_eJ0QN
 kTt0A6iRAtIVkh9RtRV0Raj_Vr0jG_7EZL7g0P2AXWfVKnh.PW1vyuUDYG_nM0WFlWNu2igwMexg
 n.JhxGqdkNVxVaF9y7_KMnRbvIto84__vw60j2xr51Ni.qZxh2UKK4taUOqRS45R_lgSbQHR5ec8
 m5HUFT2n6pOdKqJDqwCWxI6uMYqZHnKt1Tnb1pbJkwpqpO1_a5CIZUYI68FUffeNmfKj88oC96VZ
 aR5K1qn5IIsYqjPaMfloaW329SkLm2M0clML_DNhQU18AhRd4wJqLumbsD.ZkW5kf0.FVHmWobgt
 e47yl.vuhfa1e0yWk1x5nozpe2FZbD2mUqx9R_h0_6dgdXc68PhM20UUgCOayepGecsb2_d2eLLZ
 ZCTZqSkT_Kp.KeM4aUHxl1zIEfwaemyRjmPsF78h91HnLZtSci7U.jrM.5T41JG6hVHIu_vMit_C
 mliiFlfjniU9QuSphtkWnFEWJCbuwFKQDqtb3x50vCg9EuONEDy7ltQfuFBmXT2tJr3hOP2wpcLR
 eZewrDphCWDukD5lxYiUEnMPVATSRZQyQ1JCkO_nNGvDZCwQ4r9CYWH6STwh0MA4d0YU7vGBs_Vv
 yWscYisX_mdcp2VcB0J8rqVJuv3T1QQV.pnjIoa8LmTsgjjt.BErlNWCk5wmNfc6dcX5bT4ux0ec
 YFMo740wnDzuSbxuoTXLjPjrdVKAXsaISnD22q1gDnwiLu4NUI0JWzs253UG6NUYMm6XLVSzcsXG
 kQV5Qz_87t1LpmXW2VgsNO82hMsqoCUd9wL6racK8mAUEomXvhq1Accx8KTjrIk_Bc3lwnf_CfMs
 K9YgQw9CuKYwhIzgHADP7EuIaHZsdXKRPPm5lcHSR_2yvhrD3ebo0zCdtQvrAjfbe_E.FQk2xIlK
 gAvNh2Uihs1.0KlwKE0zKHuYyJcbajU7ix9ijTAcdb3NcwV5R6VKpI.g6kQ06ERTmjCF3BHyZa1e
 22DqvsxhtVnlh5deI6SWmestCKzSDFBcWLJCUH9rRcxzDcCRZEvnXA3DPtPnkfUQ02T2dKZqErN.
 nRC4kHraHIkjeCgKOgs9Nmk7Qy50r6vlmqoKwFv9GmwjvMbfZkqYF5vaK_Sxsir3nPTD72aF7U6D
 X3YSGzKatVc.ttXU77aEp5CSv_24MyfAUlcQF8DPUR3spzfZBdV2ROoIdtXaI2J_O_NgnajqRWZ4
 Z7Wt9HOI7kq4f4zgm_IGnuPiD78yBjBIgpTn8I0x_tI865ZJgh3UnwA3FHOceXt9vna9Liov.3V3
 .ZZNUoF9_iaJg.NSukllRKMPAsA34dElIHxUpYAeOAS3bB2MMV1ngfmnfhPk7gDjGgBbnJeyFELe
 9gt8rhGJMdSPohKnYdeCI7tyY5.52ldpoBtOQz7_8TFy4A14g6P.DLKeoqYT5jxkmH4T2olmOIwa
 SwdB33U41SL7XX8wb2v85g.dgdxW5TUXYBDeLf1LQCSEqe8F3A6gMMuICCgHJMFpg4gtjTSW6fxB
 FEORjJkuhXmPBBQ3tHfMRd9x0UCHByKcou.zsirOzocOGqU8kP2zQFIlSsdzTqqjq7zX_kC1Njs.
 BVgOyYXeG353j1tVisCXvbcKN4.FvXKnWLO93apxLqjJr7lC83rF7LGwv0dLctXl.YeOrjufru2Z
 aUc3fyahR3mMfn_TloHA.YySi34EA14R3oIYtvPY.52VT4HsIoBT4P4jRH16Kwt0LCr2DKQnJaMs
 n68HxaxiTBPCKJB9reZvcE3P02hGbfztlRLTbeajagXH8UF4ESU0vNYOezLWPQGmwCyGOX.EfEMy
 NN.lRZRyHtAZQCPak5BEEp4Gq5gg1DMfDtJLZ.Rl_HnnxeREkasSWQDg4rttWrlBvKS3o8FjWqkq
 Lpb89l8bE5IVDYYTyz3ULMrGmaY6RsHAOa3rQepAJ7fwjMXZffCNBARD3d3hSxnckohu0n1VvOvI
 5aDUHnQ9nVVmmqHatNAvmhbdnz3YhUq7aRukyWtW7aLyYVoJAZ_xQQ1b.qmLVoUjXam1l2ee4hJd
 dHpnL3MWXDAL4KFJmJClOeSl_JPTB0xb3OGqkcRrA.yOg8swos.UbYOr91vbgYQ8ZmzVLpQWuw.Z
 Ajh5WwouIBj2lwD8oXKCgRZJkC.HL_B_GjRzO_W2fuA--
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: b8452a40-21fd-4249-b0e5-ba6658385c4b
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic301.consmr.mail.gq1.yahoo.com with HTTP; Fri, 14 Aug 2026 16:18:31 +0000
Received: by hermes--production-bf1-54b5569bdc-z2x8g (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 4cc625440026d205cb1396754a1ab4df; 
 Fri, 14 Aug 2026 16:18:27 +0000 (UTC)
Message-ID: <1522d7a3-eb9d-40df-9a34-7b1cfeb3680e@aol.com>
Date: Fri, 14 Aug 2026 12:18:26 -0400
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
 Anthony PERARD <anthony.perard@citrix.com>
References: <20260802050824.10554-1-brchuckz.ref@aol.com>
 <20260802050824.10554-1-brchuckz@aol.com>
 <2110d4b7-ae37-47aa-99be-ab59e16f6167@suse.com>
 <67579eba-e222-41dd-84bf-8440d2eaf2a9@netscape.net>
 <da2200cd-def7-4cce-a6c2-9f9ac9e202ce@suse.com>
 <de56c8bd-f0e8-4fe9-8cf5-f6807698176c@aol.com>
 <02a7dc18-4184-4e86-84cb-121769187f71@suse.com>
 <1858e8e6-73fa-4017-93e2-c733fbf0ec8d@aol.com>
Content-Language: en-US
In-Reply-To: <1858e8e6-73fa-4017-93e2-c733fbf0ec8d@aol.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26254
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
Received-SPF: pass client-ip=98.137.64.148; envelope-from=brchuckz@aol.com;
 helo=sonic301-22.consmr.mail.gq1.yahoo.com
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

On 8/14/2026 11:23 AM, Chuck Zmudzinski wrote:
> On 8/14/2026 9:46 AM, Jan Beulich wrote:
>> On 14.08.2026 15:18, Chuck Zmudzinski wrote:
>>> On 8/14/2026 3:35 AM, Jan Beulich wrote:
>>>> On 14.08.2026 02:45, Chuck Zmudzinski wrote:
>>>>> On 8/13/2026 6:35 AM, Jan Beulich wrote:
>>>>>> On 02.08.2026 07:08, Chuck Zmudzinski wrote:
>>>>>>> -- snip --
>>>>
>>>> I don't follow this: Anything the guest can access should also be accessible
>>>> by its DM.
>>> 
>>> I think the host OpRegion is not currently accessible by the DM.
>> 
>> Can you explain to me how the region becomes accessible to the guest?
>> That would then (hopefully) help me understand why the DM would not have
>> access. Fundamentally any MMIO and any I/O ports that are assigned to a
>> guest are also assigned to its DM.
> 
> Currently, in the device model (Qemu) we have:
> 
>     ret = xc_domain_memory_mapping(xen_xc, xen_domid,
>             (unsigned long)(igd_guest_opregion >> XC_PAGE_SHIFT),
>             (unsigned long)(igd_host_opregion >> XC_PAGE_SHIFT),
>             XEN_PCI_INTEL_OPREGION_PAGES,
>             DPCI_ADD_MAPPING);
> 
> That statement is in the igd_write_opregion(...) function in the
> hw/xen/xen_pt_graphics.c file of the upstream Qemu source.

I forgot to mention: In our current implementation, this statement is
executed in the DM when hvmloader executes this statement, currently in
hvmloader/pci:

                    pci_writel(vga_devfn, PCI_INTEL_OPREGION,
                               igd_opregion_pgbase << PAGE_SHIFT);



> 
> If I understand our current implementation correctly, this statement
> is what gives the guest access to the host OpRegion (3 pages as defined
> by XEN_PCI_INTEL_OPREGION_PAGES, and in agreement with IGD_OPREGION_PAGES
> in hvmloader code). I don't think this statement makes the host OpRegion
> accessible to the device model, though, so I think, if I understand your
> comment in an earlier about my patch resulting in what you called a "layering
> violation" correctly, that our current implementation is also guilty of this
> same kind of "layering violation."
> 
> So, how do you suggest we fix that?
> 
...

