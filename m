Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E59606A328
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 01:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=kJsZmB3x
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJKvF-0001uw-Pm; Tue, 20 Oct 2026 21:15:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1xJKvE-0001tr-AS; Tue, 20 Oct 2026 21:15:16 -0400
Received: from canpmsgout04.his.huawei.com ([113.46.200.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1xJKvA-00018G-8l; Tue, 20 Oct 2026 21:15:16 -0400
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=55oZ58121bCTpAVf7xgNQu1APHrYbskEt3/x9lr/ko8=;
 b=kJsZmB3xFjyzCMmg7i6J67776SbBDQixeaJOAHdr+DwUh5rT/GmComsSu2fWJC+/xj+FKxk2t
 5VnYOsAKvQMja6gaXZkRqDjkykKUuYuyytkq6j1/CfGWz+LzbUna8Yv4Wa7SvUOMktTUCMOG5ii
 U1oAs+I1VahSQmXjqGjYb9k=
Received: from mail.maildlp.com (unknown [172.19.162.140])
 by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4j8WXj10myz1prL7;
 Wed, 21 Oct 2026 09:14:45 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
 by mail.maildlp.com (Postfix) with ESMTPS id D2C6720333;
 Wed, 21 Oct 2026 09:14:48 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 21 Oct
 2026 09:14:47 +0800
Message-ID: <89a1d9cf-fa0b-47bf-a54f-338e1339effd@huawei.com>
Date: Wed, 21 Oct 2026 09:14:46 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] RISC-V: ACPI: Add PPTT support
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, Drew Fustini
 <fustini@kernel.org>, Sunil V L <sunilvl@oss.qualcomm.com>
CC: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Chao Liu
 <chao.liu@processmission.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor
 Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, Anup Patel
 <anup.patel@oss.qualcomm.com>, Prajwal N <prajwal.n@oss.qualcomm.com>,
 Shankar C <shankar.c@oss.qualcomm.com>, Jinjie Ruan <2118537295@qq.com>
References: <20261015064957.4076464-1-sunilvl@oss.qualcomm.com>
 <atfrQY1w-er0onXV@thelio>
 <9c468ae3-e303-40da-bbc8-a22a82b9bc97@oss.qualcomm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <9c468ae3-e303-40da-bbc8-a22a82b9bc97@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk200008.china.huawei.com (7.202.194.74)
Received-SPF: pass client-ip=113.46.200.219;
 envelope-from=ruanjinjie@huawei.com; helo=canpmsgout04.his.huawei.com
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



在 2026/10/21 8:39, Daniel Henrique Barboza 写道:
> Hi Drew!
> 
> On 10/20/2026 7:29 PM, Drew Fustini wrote:
>> On Thu, Oct 15, 2026 at 12:19:53PM +0530, Sunil V L wrote:
>>> Hi all,
>>>
>>> This series adds ACPI Processor Properties Topology Table (PPTT)
>>> support to
>>> the RISC-V virt machine. PPTT allows the guest to discover the
>>> processor and
>>> cache topology exposed by the machine, which is useful for making better
>>> scheduling and cache-management decisions.
>>
>> Thanks for picking up PPTT support. I can now rebase the RQSC support
>> [1] on this series.
>>
>> However, RQSC actually needs PPTT revision 3, because it adds cache IDs
>> to the PPTT. The RQSC table references a capacity controller's cache by
>> the PPTT cache ID. In Linux, find_acpi_cache_level_from_id() and
>> acpi_pptt_get_cpumask_from_cache_id() return -ENOENT if PPTT rev < 3.
>>
>> There is a new MPAM series by Jinjie Ruan which contains the patch
>> "[PATCH 04/37] hw/acpi: Build PPTT rev 3 with cache IDs for MPAM
>> cross-references" [2]. It bumps build_pptt() to revision 3 and gives
>> every cache node an ID.
>>
>> I could just base the RQSC series on this PPTT series and that patch
>> 03/37. But maybe there is a better way to coordinate adding PPTT v3?
> 
> This PPTT support is acked and I believe we'll queue it in riscv-to-
> apply.next
> shortly.
> 
> As for the PPTT rev3 patch in the "Add Arm MPAM emulation", my
> suggestion is
> to put that on top of your series (i.e. your series will contain that
> patch).
> That ARM series has 37 patches and might take awhile to go through, and
> your
> work relies only on patch 04 ...  which happens to be an arch agnostic
> patch.
> I believe it's fine for us to push it via the riscv queue.
> 
> I see that the author from the ARM series is CCed here.  Jinjie Ruan,
> are you
> okay with us pushing your patch via the RISC-V tree?  It'll unblock
> Drew's work
> and you'll have one less patch to worry about in your ARM MPAM work.

Hi Daniel,

I'm fine to do so.

> 
> 
> Thanks,
> Daniel
> 
> 
> 
> 
> 
>>
>> Thanks,
>> Drew
>>
>> [1] https://lore.kernel.org/all/20260202-riscv-rqsc-v1-0-
>> dcf448a3ed73@kernel.org/
>> [2] https://lore.kernel.org/all/
>> tencent_F9C68A515AC6C40BE2C32DB314E14CCB7106@qq.com/
> 

-- 
Best regards,
Jinjie


