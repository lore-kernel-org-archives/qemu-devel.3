Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7016606D809
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=f/nWzUKU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOWgf-0004Zq-GE; Wed, 04 Nov 2026 03:49:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1xOWgd-0004ZE-64; Wed, 04 Nov 2026 03:49:39 -0500
Received: from canpmsgout04.his.huawei.com ([113.46.200.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1xOWga-00055B-7g; Wed, 04 Nov 2026 03:49:38 -0500
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=bn64/az0sa8YBc3qSn5zUZYbRR4n8GiJeEtOfsCCx1Y=;
 b=f/nWzUKUdUe5yBpleuCn3Hi9AYGXoG3Embd5R9ASE92iV1ifYHPSF5XTvBmET5bk+4aL3TPjd
 /RE+PoCcXaWAV08+fT+7YAE3NMN7npsr2l6byZOSwXPCCvr7VfPgOb4z4h6V9Rvucn/aGpMq0tC
 VOdJeXLHvtD4TPe+/i0xtx8=
Received: from mail.maildlp.com (unknown [172.19.162.140])
 by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4jKJyc0DB3z1prnC;
 Wed,  4 Nov 2026 16:49:12 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
 by mail.maildlp.com (Postfix) with ESMTPS id 99A732011D;
 Wed,  4 Nov 2026 16:49:16 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 4 Nov
 2026 16:49:15 +0800
Message-ID: <f015a1ca-af03-489e-b967-a36536673415@huawei.com>
Date: Wed, 4 Nov 2026 16:49:15 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/37] hw/arm/virt: Add mpam and mpam-min-msc machine
 properties
To: Jonathan Cameron <jic23@kernel.org>, Jinjie Ruan <2118537295@qq.com>
CC: <anisinha@redhat.com>, <armbru@redhat.com>, <eblake@redhat.com>,
 <imammedo@redhat.com>, <michael.roth@amd.com>, <mst@redhat.com>,
 <pbonzini@redhat.com>, <peter.maydell@linaro.org>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>
References: <tencent_4A73E52B4D6BC21D11E7564A8A6EA6EF5805@qq.com>
 <20261103015138.2191fa9b@jic23-hlaptop>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20261103015138.2191fa9b@jic23-hlaptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk200008.china.huawei.com (7.202.194.74)
Received-SPF: pass client-ip=113.46.200.219;
 envelope-from=ruanjinjie@huawei.com; helo=canpmsgout04.his.huawei.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



在 2026/11/3 9:51, Jonathan Cameron 写道:
> On Fri, 16 Oct 2026 18:10:35 +0800
> Jinjie Ruan <2118537295@qq.com> wrote:
> 
>> From: Jinjie Ruan <ruanjinjie@huawei.com>
>>
>> Add the two MPAM machine properties: mpam=on enables MSC emulation
>> for the virt board, and mpam-min-msc=on collapses the per-node
>> memory MSCs into a single MSC with one RIS per node.  The state
>> fields and the property accessors only; MSC creation arrives with
>> the later patches.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> 
> I'm curious to get more viewpoints on the somewhat weird mpam-min-msc
> though.  It is kind of handy for testing IIRC but not sure it is realistic.

Hi Jonathan,

I think the code is already in fairly good shape now. Perhaps we can
drop this option in the official submission?


-- 
Best regards,
Jinjie


