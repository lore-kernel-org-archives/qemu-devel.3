Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08169CF2564
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 03:40:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMI09-0000ie-OA; Thu, 20 Nov 2025 22:40:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vMHzz-0000dk-B1
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 22:39:51 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vMHzw-0002vI-Nd
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 22:39:51 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5AL3dUtk090934
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 21 Nov 2025 12:39:30 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=kRtr1BBlFDZGhuiV2TXqyXyKRDeMUyY7+fAg/iYP4YY=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1763696370; v=1;
 b=v7sjk0I65HA7bo4nkJ6MK7+tMl4GXaJCiMVsSMuml23s04AzYyFDjDVIh1HTfLHL
 be7MyRpasjobjkZ14Kg91pNn6Cksio6ZWTC8OWGT7hT6nYSr04WM7+F5ANHLPWbi
 Unbp3rcud96cIS44rozpy8PYHJjV/BKTfJOH75T33cGz+kSgPEd0m6wQFsUN4ykK
 2w7tBS7Oy7pwGAA+J4Wv29NF0wsibl69aGBmTytJTzXLMqBZYIHlGZ5VunQHnbCc
 QGGSpbfbrrYoG2qbNfvmJNq+pmPRqBn9RR8rZz7yrBbMpS2EryX/41HF9rHGe1y9
 kokZxeCyYWALCvo0VHyOVQ==
Message-ID: <ca2e398e-8158-4845-9798-6f444a73b103@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 21 Nov 2025 12:39:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 1/3] virtio-gpu: Add support for
 VIRTIO_GPU_BLOB_FLAG_USE_USERPTR flag
To: Honglei Huang <honghuan@amd.com>
Cc: mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, Ray.Huang@amd.com,
 dmitry.osipenko@collabora.com, alex.bennee@linaro.org
References: <20251121024705.1403042-1-honghuan@amd.com>
 <20251121024705.1403042-2-honghuan@amd.com>
 <b6f4cc26-7ebe-4b07-8e50-257b6f53d309@rsg.ci.i.u-tokyo.ac.jp>
 <db263884-6159-4d25-8c40-44dd78291714@amd.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <db263884-6159-4d25-8c40-44dd78291714@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/11/21 12:14, Honglei Huang wrote:
> 
> 
> On 2025/11/21 10:56, Akihiko Odaki wrote:
>> On 2025/11/21 11:47, Honglei Huang wrote:
>>> Add support for the USE_USERPTR blob flag in virtio-gpu to enable
>>> user pointer mapping for blob resources. This allows guest applications
>>> to use user-allocated memory for GPU resources more efficiently.
>>>
>>> Changes include:
>>> - Add VIRTIO_GPU_BLOB_FLAG_USE_USERPTR flag definition
>>> - Enhance blob resource creation to handle userptr flag properly
>>> - Remove arbitrary nr_entries limit (16384) in mapping creation
>>> - Add conditional handling for userptr vs regular blob mapping
>>
>> I don't see the added conditional handling.
> 
> Sorry, the additional handing is replaced by the fixing of value check.
> I will correct this commit message in the next version.

Not just the commit message, but it also questions the utility of 
VIRTIO_GPU_BLOB_FLAG_USE_USERPTR and VIRTIO_GPU_F_RESOURCE_USERPTR. 
Neither of them adds a new functionality. They should be dropped if they 
are also replaced with the fix.

> 
>>
>>> - Support guest_blob_mapped parameter for virgl renderer
>>> - Fix value check issue in virtio-gpu
>>>
>>> This enables more flexible memory management between guest and host
>>> for GPU virtualization scenarios.
>>>
>>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>>> ---
>>>   hw/display/virtio-gpu-virgl.c               | 2 +-
>>>   hw/display/virtio-gpu.c                     | 7 -------
>>>   include/standard-headers/linux/virtio_gpu.h | 1 +
>>>   3 files changed, 2 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu- 
>>> virgl.c
>>> index 07f6355ad6..c927275c79 100644
>>> --- a/hw/display/virtio-gpu-virgl.c
>>> +++ b/hw/display/virtio-gpu-virgl.c
>>> @@ -705,7 +705,7 @@ static void 
>>> virgl_cmd_resource_create_blob(VirtIOGPU *g,
>>>           ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, 
>>> sizeof(cblob),
>>>                                               cmd, &res->base.addrs,
>>>                                               &res->base.iov, &res- 
>>> >base.iov_cnt);
>>> -        if (!ret) {
>>> +        if (ret != 0) {
>>>               cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>>>               return;
>>>           }
>>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>>> index 43e88a4daf..956dc811fa 100644
>>> --- a/hw/display/virtio-gpu.c
>>> +++ b/hw/display/virtio-gpu.c
>>> @@ -808,13 +808,6 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
>>>       size_t esize, s;
>>>       int e, v;
>>> -    if (nr_entries > 16384) {
>>> -        qemu_log_mask(LOG_GUEST_ERROR,
>>> -                      "%s: nr_entries is too big (%d > 16384)\n",
>>> -                      __func__, nr_entries);
>>> -        return -1;
>>> -    }
>>> -
>>>       esize = sizeof(*ents) * nr_entries;
>>>       ents = g_malloc(esize);
>>>       s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
>>> diff --git a/include/standard-headers/linux/virtio_gpu.h b/include/ 
>>> standard-headers/linux/virtio_gpu.h
>>> index 00cd3f04af..b85e781a2d 100644
>>> --- a/include/standard-headers/linux/virtio_gpu.h
>>> +++ b/include/standard-headers/linux/virtio_gpu.h
>>> @@ -405,6 +405,7 @@ struct virtio_gpu_resource_create_blob {
>>>   #define VIRTIO_GPU_BLOB_FLAG_USE_MAPPABLE     0x0001
>>>   #define VIRTIO_GPU_BLOB_FLAG_USE_SHAREABLE    0x0002
>>>   #define VIRTIO_GPU_BLOB_FLAG_USE_CROSS_DEVICE 0x0004
>>> +#define VIRTIO_GPU_BLOB_FLAG_USE_USERPTR      0x0008
>>>       /* zero is invalid blob mem */
>>>       uint32_t blob_mem;
>>>       uint32_t blob_flags;
>>
> 


