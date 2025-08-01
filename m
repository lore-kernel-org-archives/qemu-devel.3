Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF62C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 13:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhpvc-0004jX-Ux; Fri, 01 Aug 2025 09:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hsiangkao@linux.alibaba.com>)
 id 1uhjog-0001MA-BC; Fri, 01 Aug 2025 03:04:34 -0400
Received: from [115.124.30.132] (helo=out30-132.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hsiangkao@linux.alibaba.com>)
 id 1uhjoc-0007A4-4k; Fri, 01 Aug 2025 03:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1754031853; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=fDfFJ1fFDeQcGk1MtzyoBt7qqCdc5Nzmffg9FTcOGdA=;
 b=kLROwh9qPmAn0YvMZiFlqU08+0P2KOpRf0RdHoigcOkV06MLNedDwV5ZZNmQUaLamgLKzzxHiQDpm8sL9QA4wpxLXmVCXjuHVEfCDaj2ypco0vyw2tVy2k2ovW+iBMs7cwl+AkJUop/pu00p4ncea2WrDMteBRdewIIp0pS9bXk=
Received: from 30.221.131.201(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0WkcxLJW_1754031535 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 01 Aug 2025 14:58:55 +0800
Message-ID: <db65aa49-7323-49f4-8531-7c617e9d8a1b@linux.alibaba.com>
Date: Fri, 1 Aug 2025 14:58:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RE: [PATCH] hw/arm: add static NVDIMMs in device tree
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>
References: <20250730-nvdimm_arm64_virt-v1-1-f843596ab995@linaro.org>
 <20250731110036.00003a0a@huawei.com>
 <e8203af151ea4f9696b809dd5de6b155@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <e8203af151ea4f9696b809dd5de6b155@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.132 (deferred)
Received-SPF: pass client-ip=115.124.30.132;
 envelope-from=hsiangkao@linux.alibaba.com;
 helo=out30-132.freemail.mail.aliyun.com
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
X-Mailman-Approved-At: Fri, 01 Aug 2025 09:35:51 -0400
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

Hi folks,

On 2025/7/31 19:14, Shameerali Kolothum Thodi via wrote:
> 
> 
>> -----Original Message-----
>> From: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Sent: Thursday, July 31, 2025 11:01 AM
>> To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> Cc: qemu-devel@nongnu.org; Peter Maydell <peter.maydell@linaro.org>;
>> qemu-arm@nongnu.org; Gustavo Romero <gustavo.romero@linaro.org>;
>> Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
>> Subject: Re: [PATCH] hw/arm: add static NVDIMMs in device tree
>>
>> On Wed, 30 Jul 2025 15:21:41 +0300
>> Manos Pitsidianakis <manos.pitsidianakis@linaro.org> wrote:
>>
>>> NVDIMM is used for fast rootfs with EROFS, for example by kata
>>> containers. To allow booting with static NVDIMM memory, add them to
>>> the device tree in arm virt machine.

Just another question about the image passthrough via pmem,
I wonder if it's possible for QEMU to support one nvdimm,
virtio-pmem device with multiple memory backend files rather
than just one single file?

Because EROFS can use this way to support multi-layer images,
for example:

  filesystem1:  metadatafile + layerfile1 + layerfile2
  filesystem2:  metadatafile + layerfile1 + layerfile3

so that multiple pmem devices can share the same layer1 page
cache on the host.

More details also see:
  https://erofs.docs.kernel.org/en/latest/merging.html


Many thanks!
Gao Xiang

