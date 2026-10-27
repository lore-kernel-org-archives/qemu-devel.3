Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3254606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 07:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=CGKsZWbn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLbKB-0001UM-OJ; Tue, 27 Oct 2026 03:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1xLbK7-0001Tr-ST; Tue, 27 Oct 2026 03:10:19 -0400
Received: from canpmsgout07.his.huawei.com ([113.46.200.222])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1xLbK4-0003SN-Au; Tue, 27 Oct 2026 03:10:19 -0400
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=lKBgr6Y264FiLGGbwD+HLkpSm5Ked5zWr7Zc89h7Lww=;
 b=CGKsZWbnIHl/XBoKTvebl2RDzL0n0bfikpWslvpGfRF/RNfwDJrr2tGhlxSJ4MFuY+HdXPPPa
 H3kgcgHVOOGNUS8p4cAqfczSmnehaF7QtCEWcp4KlO3xvz9QiKXlqR/ccDkC7h1vCZI8R3m8fLb
 Y0hSujpDkvawNcauCmTc1nc=
Received: from mail.maildlp.com (unknown [172.19.163.127])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4jDM78589JzLlTf;
 Tue, 27 Oct 2026 15:09:24 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
 by mail.maildlp.com (Postfix) with ESMTPS id 7EBC040561;
 Tue, 27 Oct 2026 15:09:30 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 27 Oct
 2026 15:09:29 +0800
Message-ID: <d9e9f9dc-3ac4-4455-b27a-f9a450d319bf@huawei.com>
Date: Tue, 27 Oct 2026 15:09:29 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/37] Add Arm MPAM emulation
To: Jonathan Cameron <jic23@kernel.org>, Peter Maydell
 <peter.maydell@linaro.org>
CC: Jinjie Ruan <2118537295@qq.com>, <anisinha@redhat.com>,
 <armbru@redhat.com>, <eblake@redhat.com>, <imammedo@redhat.com>,
 <michael.roth@amd.com>, <mst@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>,
 <jonathan.cameron@oss.qualcomm.com>
References: <tencent_22E95650AA60C6E59860452C0D61A21F1105@qq.com>
 <CAFEAcA8MyrqWC7=A5Bw0G5G-2J64iTLmfY33dNDLm0jvmRb+Eg@mail.gmail.com>
 <27040691-e4b6-44f3-b588-cbbbee13cde2@huawei.com>
 <CAFEAcA_4xb3CBL9TTAdKMOG_ijWpt9wsveCp0R602VoFaWUH1Q@mail.gmail.com>
 <tencent_82895B2529E419B263EC95C8349389114407@qq.com>
 <CAFEAcA-amrQOM8+qnaxgWLyGNM=vp-vKV=OqqU7Qp17PRiH_KA@mail.gmail.com>
 <501bf5cc-cee1-4593-943d-505003541d41@huawei.com>
 <CAFEAcA8ffgrbh_gUK7wcZW5E8p=ZC+CC=3U23ah+nWHxOGpjrg@mail.gmail.com>
 <20261020013906.0ee141e5@jic23-hlaptop>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20261020013906.0ee141e5@jic23-hlaptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk200008.china.huawei.com (7.202.194.74)
Received-SPF: pass client-ip=113.46.200.222;
 envelope-from=ruanjinjie@huawei.com; helo=canpmsgout07.his.huawei.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



在 2026/10/20 8:39, Jonathan Cameron 写道:
> On Mon, 19 Oct 2026 13:28:03 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
> 
>> On Mon, 19 Oct 2026 at 13:19, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>>>
>>>
>>>
>>> 在 2026/10/19 20:01, Peter Maydell 写道:  
>>>> On Mon, 19 Oct 2026 at 12:46, Jinjie Ruan <2118537295@qq.com> wrote:  
>>>>> One honest caveat  
>>>>
>>>> Please don't send LLM output to qemu-devel.  
>>>
>>> Sorry. Here is my understanding:
>>>
>>> As mpam_csu_value() and mpam_mbwu_value() below done, the monitor code
>>> scales the base value based on the software-configured PBM
>>> (Partition-Based Monitoring) or MB MAX values, rather than just
>>> returning zeroes.  
>>
>> Thanks. So we report "you're using the full amount the system
>> is configured to let you use". That seems reasonable.
>>
>>> And most of the code are to expose the many MPAM registers, constructing
>>> the ACPI tables, and building the hardware topology of the memory
>>> controllers and caches to correctly expose the MSC (Memory System
>>> Controller) components.  
>>
>> OK, that makes sense too -- I guess there's just a lot of pieces
>> of hardware in there.
>>
>> thanks
>> -- PMM
>>
> Hi Peter, ruanjinjie,

Hi Jonathan,

> 
> FWIW the much more minimal emulation that I posted years ago and
> which I few crumbs of in here came up at plumbers this year with

With your foundational patch, it is very convenient to extend
other functionality.

> an engineer from yet another company asking if I could look at
> rebasing and upstreaming because they also found it very useful.

Glad to hear that someone else is also interested in QEMU emulation of MPAM.

> I was trying to work out if I could fit that into my todo list
> or whether to ask a colleague to do it.
> 
> As such I'm very pleased to see this surface a few days later!
> Even what I had was very useful for testing so I'm with this

Feel the same way when developing new features or adapting test cases.

> much extended feature set I'm not surprised to hear even more
> issues have shaken out.
> 
> It might take me a little while to get time to look at this series
> but I definitely plan on doing so!

Look forward to your review and suggestions.

> 
> Jonathan
> 
> p.s. On off chance that (carefully unnamed) engineer sees this I
>      had no idea ruanjinjie was working on this.
> 
>      Must have been something in the air :)

-- 
Best regards,
Jinjie


