Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A651606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 06:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=6hZEU623
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVNrA-00084p-Es; Mon, 23 Nov 2026 01:48:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1xVNr8-00084V-Tf; Mon, 23 Nov 2026 01:48:50 -0500
Received: from canpmsgout10.his.huawei.com ([113.46.200.225])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1xVNr5-000718-Eo; Mon, 23 Nov 2026 01:48:50 -0500
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=gnTy0RGlslLdUhVICgrBqPKPG6nWM/aA5V5WlF9atrg=;
 b=6hZEU623vfvRrKrjxlFtbiubNJt1ICaZa69x39fdbxZxiXYtpGOXtNGIAhXFSkW26BzRFvwYn
 KfluKRykg3TxQFbN5u3koVlGbJvP+ZhsVYquuhccXo2G1iov3LyGCZWFkMalKQzoTuXWT6L1Ru2
 XT/8JTzPcDX2bllUnS8Kvcs=
Received: from mail.maildlp.com (unknown [172.19.163.127])
 by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4jXxNF3nTPz1K9Bl;
 Mon, 23 Nov 2026 14:48:13 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
 by mail.maildlp.com (Postfix) with ESMTPS id 31D1940561;
 Mon, 23 Nov 2026 14:48:30 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 23 Nov
 2026 14:48:29 +0800
Message-ID: <78870156-085d-4cfb-87c8-748b74874454@huawei.com>
Date: Mon, 23 Nov 2026 14:48:28 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/37] hw/acpi: Build PPTT rev 3 with cache IDs for MPAM
 cross-references
To: Jonathan Cameron <jic23@kernel.org>, Jinjie Ruan <2118537295@qq.com>
CC: <anisinha@redhat.com>, <armbru@redhat.com>, <eblake@redhat.com>,
 <imammedo@redhat.com>, <michael.roth@amd.com>, <mst@redhat.com>,
 <pbonzini@redhat.com>, <peter.maydell@linaro.org>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>
References: <20261016094733.1898485-1-2118537295@qq.com>
 <tencent_F9C68A515AC6C40BE2C32DB314E14CCB7106@qq.com>
 <20261103001524.6f182b3d@jic23-hlaptop>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20261103001524.6f182b3d@jic23-hlaptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk200008.china.huawei.com (7.202.194.74)
Received-SPF: pass client-ip=113.46.200.225;
 envelope-from=ruanjinjie@huawei.com; helo=canpmsgout10.his.huawei.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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



在 2026/11/3 8:15, Jonathan Cameron 写道:
> On Fri, 16 Oct 2026 17:46:58 +0800
> Jinjie Ruan <2118537295@qq.com> wrote:
> 
>> From: Jinjie Ruan <ruanjinjie@huawei.com>
>>
>> The MPAM ACPI table points at cache MSCs via a cache_reference that
>> the kernel resolves against a PPTT cache node carrying a Cache ID
>> (only present in PPTT revision 3, with the Cache ID valid flag).
>> Without it, a guest MPAM driver cannot associate cache MSCs with
>> caches and rejects them.
>>
>> Bump the PPTT to revision 3 and give every cache node an ID derived
>> from its type, level and the first CPU of the topology container it
>> belongs to. The virt machine's MPAM cache MSC creation uses the same
>> topology levels (L3 at socket, L2 at cluster) as the PPTT builder and
>> derives the same IDs, so MSC locators resolve to real cache nodes.
> 
> Good. We dropped this from the last PPTT revision upgrade on basis
> we had no user without MPAM.  Now we do indeed need an upgrade.
> 
> PPTT is tested though so you need to add the two wrapping commits
> described at the top of tests/qtest/bios-tables-test.c
> and upgrade any effect tables in tests/data/acpi/arm/...

OK, have added it.

> 
> Given the implementation defined aspect of this is how the cache
> IDs are derived, I'd add a description of that here.
> 
> 
> With that stuff tidied up.
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Thank you for the review.

> 
> 
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> 


