Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74BEFE7DEEE
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 15:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmvSC-0002sL-5r; Mon, 02 Feb 2026 10:03:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vmvS9-0002rw-Ql
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 10:03:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vmvS6-0005eL-4m
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 10:03:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770044575;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yn/KZSp/3OpzMS7JiLu6gWmreyeVVT9rIffbH8JPOr8=;
 b=DKdFys+0hunxRu5bcK3UwxFrdkikh0uDuIZa1qR2fKk2nAp0YhYjancDQdftIekxu8344p
 W0u2XeUJBwxD0WJR+vBLUqIDoGVZ1t77WCdB8LvtHvldkuli7FffeWCEkgB3UvjvwGGsx5
 93ot/I5tBj+hnknb7JOj+sR5HEjJA6g=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-U_PAPqvVNpe5Yi6fIDGqQg-1; Mon, 02 Feb 2026 10:02:53 -0500
X-MC-Unique: U_PAPqvVNpe5Yi6fIDGqQg-1
X-Mimecast-MFC-AGG-ID: U_PAPqvVNpe5Yi6fIDGqQg_1770044572
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b8db12d8c65so693232566b.3
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 07:02:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770044572; x=1770649372;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yn/KZSp/3OpzMS7JiLu6gWmreyeVVT9rIffbH8JPOr8=;
 b=ODlDHqrIDjNe8a5syX2QzLtdlTPUnEZRhHMC9NUDqrb1ZryqXfOzA7efhAMm3ikS8w
 +Ts89rLpfl4xna8+EVljabNBYFt5UUM7kjhtYN4RAWV7KoDTdpRKoyV0XP0hKrBSuph9
 VsU2W/E8Mo9pobxdOhvqD5WiLhba0R8ZDIO79I1n5XgSeFBb19v+Z6Kom86Y5AePj+ir
 wxBgVtb0IOR72wwCPQXJ6TFEQuFWGyeN7ZjqZ0XZEwukucuvnD0U6tTULyVtm4EH1IuD
 utLoA1rG5j7SNKFAIRGUC49LwPdjSEOch62fnGtDmwG+mFJqVh3oOx9/TJsB4ScKRrjg
 8cog==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkK1gjiKppPbPPe7WOxiFILoQ/MCSnCJAQ//F6w65VW+fdMbqkI0KMYnpsrlWhRcrlKLno+JOzeSnU@nongnu.org
X-Gm-Message-State: AOJu0Yw1qJXfJ7hf9Pm//p1vTYnWRKep9kUcIXbZOuq7l7hDyc6BS6lq
 LyMEFleBMy65ETy+m020R3Wh5kERDdJcqupNjfjAckUaFPQrNTzssvdpYSkhsozPmePnRDuXx9y
 T2ojtSOKVSWUEmpiz1Jpx88ZpqiHV3YedjMljwyCj8hGGZ3UVUYc+hatk
X-Gm-Gg: AZuq6aIrs+we6Q70dkuWO9VlKUvflujrWNx+WkLhibvqu2iuItdbniGPoDT337hXbZi
 7/ePF7W/aNgDa4PqoloOR5hOBrxGqCS694WGHkBgqcbobgYngWkURl6GNLb7nRL7XE5XF6K5/F4
 o836Gr3WcNqzZlWpWaN1yM7T+1l2wKTR6aSP8IObiZ7rbyzD0vgSxY7fmTkL3V0tExXtOyToY6W
 Y6WYEBXG++JCHboIZoYAHZ/WiHq+VI/QtlxKkSvrQH4i18sOCnHlq+Ff0jVLBucM3EbRb+rSzjB
 Nnqu+9Be3GupH/NhwnIdunvLbRJ6q2GiKabBeS6S375aKMkKeqYtZTIBW/GzVSPIASNO4txloR6
 6NjC2lOMBf11biMxUN3Kv8QbICn8eT7ApBN/aOhMM+8myTC3289KfiosxEw==
X-Received: by 2002:a17:907:3d56:b0:b87:3174:9bdd with SMTP id
 a640c23a62f3a-b8dff61c70amr800496366b.28.1770044571620; 
 Mon, 02 Feb 2026 07:02:51 -0800 (PST)
X-Received: by 2002:a17:907:3d56:b0:b87:3174:9bdd with SMTP id
 a640c23a62f3a-b8dff61c70amr800493166b.28.1770044571149; 
 Mon, 02 Feb 2026 07:02:51 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8dbefc6995sm867121866b.24.2026.02.02.07.02.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 07:02:50 -0800 (PST)
Message-ID: <d6899c99-de05-4c0d-abb8-97247fe3fbda@redhat.com>
Date: Mon, 2 Feb 2026 16:02:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] hw/arm/smmuv3-accel: Read and propagate host
 vIOMMU events
Content-Language: en-US
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>,
 Matt Ochs <mochs@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
References: <20260127103328.255382-1-skolothumtho@nvidia.com>
 <20260127103328.255382-5-skolothumtho@nvidia.com>
 <0bbdecdc-f997-4a3e-8023-f50ed629128f@redhat.com>
 <CH3PR12MB7548DB2591BCB7ABB47136D3AB9AA@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CH3PR12MB7548DB2591BCB7ABB47136D3AB9AA@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 2/2/26 3:12 PM, Shameer Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: 02 February 2026 12:59
>> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; qemu-
>> arm@nongnu.org; qemu-devel@nongnu.org
>> Cc: peter.maydell@linaro.org; Nicolin Chen <nicolinc@nvidia.com>; Nathan
>> Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>; Jason
>> Gunthorpe <jgg@nvidia.com>; jonathan.cameron@huawei.com;
>> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; Krishnakant Jaju
>> <kjaju@nvidia.com>
>> Subject: Re: [PATCH v3 4/4] hw/arm/smmuv3-accel: Read and propagate host
>> vIOMMU events
>>
>> External email: Use caution opening links or attachments
>>
>>
>> Hi Shameer,
>>
>> On 1/27/26 11:33 AM, Shameer Kolothum wrote:
>>> Install an event handler on the vEVENTQ fd to read and propagate host
>>> generated vIOMMU events to the guest.
>>>
>>> The handler runs in QEMU’s main loop, using a non-blocking fd registered
>>> via qemu_set_fd_handler().
>>>
>>> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
>>> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>>> ---
>>>  hw/arm/smmuv3-accel.c | 60
>> +++++++++++++++++++++++++++++++++++++++++++
>>>  hw/arm/smmuv3-accel.h |  2 ++
>>>  2 files changed, 62 insertions(+)
>>>
>>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>>> index e8028d4be5..ab57eae575 100644
>>> --- a/hw/arm/smmuv3-accel.c
>>> +++ b/hw/arm/smmuv3-accel.c
>>> @@ -390,6 +390,60 @@ bool
>> smmuv3_accel_issue_inv_cmd(SMMUv3State *bs, void *cmd, SMMUDevice
>> *sdev,
>>>                     sizeof(Cmd), &entry_num, cmd, errp);
>>>  }
>>>
>>> +static void smmuv3_accel_event_read(void *opaque)
>>> +{
>>> +    SMMUv3State *s = opaque;
>>> +    SMMUv3AccelState *accel = s->s_accel;
>>> +    struct {
>>> +        struct iommufd_vevent_header hdr;
>>> +        struct iommu_vevent_arm_smmuv3 vevent;
>>> +    } buf;
>>> +    ssize_t readsz = sizeof(buf);
>>> +    uint32_t last_seq = accel->last_event_seq;
>>> +    ssize_t bytes;
>>> +
>>> +    bytes = read(accel->veventq->veventq_fd, &buf, readsz);
>> in case we receive a header with LOST_EVENTS at the end of tail, no data
>> is expected. So I am not sure you will be able to handle that case.
> Good catch. We need to check bytes < sizeof(hdr) first to cover
> that.
>
>>> +    if (bytes <= 0) {
>>> +        if (errno == EAGAIN || errno == EINTR) {
>>> +            return;
>>> +        }
>>> +        error_report("vEVENTQ: read failed (%m)");
>> _once?
>>> +        return;
>>> +    }
>>> +
>>> +    if (bytes < readsz) {
>>> +        error_report("vEVENTQ: incomplete read (%zd/%zd bytes)", bytes,
>> readsz);
>>> +        return;
>>> +    }
>>> +
>>> +    if (buf.hdr.flags & IOMMU_VEVENTQ_FLAG_LOST_EVENTS) {
>>> +        error_report("vEVENTQ has lost events");
>>> +        accel->event_start = false;
>>> +        accel->last_event_seq = 0;
>> actually I read again the include/uapi/linux/iommufd.h and nothing tells
>> sequence == 0 after a LOST_EVENTS.
> Yes. Sequence looks to be continuous.
>
>>> +        return;
>>> +    }
>>> +
>>> +    /* Check sequence in hdr for lost events if any */
>>> +    if (accel->event_start) {
>>> +        uint32_t expected = (last_seq == INT_MAX) ? 0 : last_seq + 1;
>>> +
>>> +        if (buf.hdr.sequence != expected) {
>> But can this happen? Normally you should have a LOST_EVENTS reported by
>> the kernel, no?
> From the header:
> "
> And this sequence index is expected to be monotonic to the sequence index of
> the previous vEVENT. If two adjacent sequence indexes has a delta larger than
> 1, it means that delta - 1 number of vEVENTs has lost, e.g. two lost vEVENTs:
> "
>
> It doesn't say the FLAG_LOST_EVEN will be set for above.

agreed. I missed that. 

Thanks

Eric
>
> AFAICS,  the only case where the flag set is for below one:
> "
> If a vEVENT lost at the tail of the vEVENTQ and there is no following vEVENT
> providing the next sequence index, an IOMMU_VEVENTQ_FLAG_LOST_EVENTS
> header would be added to the tail, and no data would follow this header:
>  "
>
>  *
>>> +            uint32_t delta;
>>> +
>>> +            if (buf.hdr.sequence >= last_seq) {
>>> +                delta = buf.hdr.sequence - last_seq;
>>> +            } else {
>>> +                /* Handle wraparound from INT_MAX */
>>> +                delta = (INT_MAX - last_seq) + buf.hdr.sequence + 1;
>>> +            }
>>> +            error_report_once("vEVENTQ: detected lost %u event(s)", delta - 1);
>>> +        }
>>> +    }
>>> +    accel->last_event_seq = buf.hdr.sequence;
>>> +    accel->event_start = true;
>>> +    smmuv3_propagate_event(s, (Evt *)&buf.vevent);
>>> +}
>>> +
>>>  static void smmuv3_accel_free_veventq(SMMUv3AccelState *accel)
>>>  {
>>>      IOMMUFDVeventq *veventq = accel->veventq;
>>> @@ -397,6 +451,8 @@ static void
>> smmuv3_accel_free_veventq(SMMUv3AccelState *accel)
>>>      if (!veventq) {
>>>          return;
>>>      }
>>> +    qemu_set_fd_handler(veventq->veventq_fd, NULL, NULL, NULL);
>>> +    close(veventq->veventq_fd);
>>>      iommufd_backend_free_id(accel->viommu->iommufd, veventq-
>>> veventq_id);
>>>      g_free(veventq);
>>>      accel->veventq = NULL;
>>> @@ -439,6 +495,10 @@ bool smmuv3_accel_alloc_veventq(SMMUv3State
>> *s, Error **errp)
>>>      veventq->veventq_fd = veventq_fd;
>>>      veventq->viommu = accel->viommu;
>>>      accel->veventq = veventq;
>>> +
>>> +    /* Set up event handler for veventq fd */
>>> +    fcntl(veventq_fd, F_SETFL, O_NONBLOCK);
>> Looks this can fail.
> Ok. Will add a check.
>
> Thanks,
> Shameer


