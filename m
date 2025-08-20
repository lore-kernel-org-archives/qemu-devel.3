Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8520CA0EED
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 10:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uofnB-00073J-NN; Wed, 20 Aug 2025 06:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hsiangkao@linux.alibaba.com>)
 id 1uofnA-000738-GT
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 06:11:40 -0400
Received: from [115.124.30.111] (helo=out30-111.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hsiangkao@linux.alibaba.com>)
 id 1uofn3-0007WW-0S
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 06:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1755684680; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=9D8Zmoi/5arGCXWGuuMT4FXCraGBebx4iC1KItUtxDA=;
 b=p0NW9MWBjdLS0GwzTP2sxdtM11+mIc+aKv30WRQzxz8wtS9uAeQIfcfXZAEz2z6EM4tUormjD3D58gJVd0WC2OVn1RSO21OLgSsCsx/POM1/N29Lg64sbSWwqg59aC0B1Y0PsbZKLheeKWC03o1KzvqCEkMCGPYcPNN8h+amssM=
Received: from 30.221.129.108(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0WmC2Sqt_1755684678 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 20 Aug 2025 18:11:19 +0800
Message-ID: <44b3d7a7-3f85-4dd1-97e5-9b2c1069c7d9@linux.alibaba.com>
Date: Wed, 20 Aug 2025 18:11:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm: add static NVDIMMs in device tree
To: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>
References: <20250730-nvdimm_arm64_virt-v1-1-f843596ab995@linaro.org>
 <20250731110036.00003a0a@huawei.com>
 <e8203af151ea4f9696b809dd5de6b155@huawei.com>
 <db65aa49-7323-49f4-8531-7c617e9d8a1b@linux.alibaba.com>
 <dd4fff02-7c73-412f-bf8c-ee8446cd9b11@linux.alibaba.com>
 <45c2fe3a-fb71-4cc2-96ff-20612da34627@redhat.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <45c2fe3a-fb71-4cc2-96ff-20612da34627@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.111 (deferred)
Received-SPF: pass client-ip=115.124.30.111;
 envelope-from=hsiangkao@linux.alibaba.com;
 helo=out30-111.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi David,

On 2025/8/20 17:29, David Hildenbrand wrote:
> On 20.08.25 06:10, Gao Xiang wrote:
>> (try to Cc David and Paolo for some discussion...)
>>
>> Hi David and Paolo,
>>
> 
> Hi!
> 
>> If possible, could you share some thoughts about this, because
>> currently each `memory-backend-file` has their own page cache
>> on the host, but if QEMU can provide one nvdimm device backed
>> by multiple files, so that EROFS can share memory in finer
>> layer granularity on the host.  (we don't need to attach so
>> many devices, because some container images can be dozens of
>> layers.)
> 
> Sounds a bit like what virtio-fs does?

Thanks for your reply!

 From the use cases themselves, I think it's similar. I also think
it's even closer to use virtio-blk to pass a golden image to the
guest: using a memory device to provide a golden image filesystem
(with many layers) is better for security and data integrity
checks, especially since the user already has a single secure
hash (for example, sha256) of the golden image.

It also avoids certain performance issues, such as unnecessary
metadata messages and virtio-dax slot reclaim problems.

> 
>>
>> Without further investigatation, I wonder which direction is
>> better:
>>
>>     1) one memory-backend-file backed by multiple files;
> 
> No.
> 
>>
>>     2) nvdimm, virtio-pmem, .. backed by multiple
>>        `memory-backend-file`s..
> 
> Better.

But it sounds like needing a per-device modification...

> 
>>
>> Currently I don't have extra slot to look into the QEMU codebase,
>> but if the idea is acceptable, I will try to work on this later.
> 
> But is this really better than just using many devices?

I think hot-plugging too many devices might be a problem (they
could be many container images in a pod (VM), and each container
image can have dozons of layers), since I've heard similar
concerns about block device hot-plugging from our internal virt
team and folks from other companies, though I haven't looked
into it myself.

And also I heard PMEM devices needs to be aligned with guest
sparse memory SECTION_SIZE, it seems it's unfriendly to
small-size layers, I don't know the latest status and the
details since I'm not actively working on this stuff.

Thanks,
Gao Xiang

> 


