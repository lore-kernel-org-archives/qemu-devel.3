Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83FC2C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 07:16:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ta8UD-00045J-S1; Tue, 21 Jan 2025 02:15:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ta8UC-00044k-8E
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 02:15:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ta8UA-0002cm-BU
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 02:15:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737443736;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f6XpwbfWkxsgRZcn3w7vmQsk+9mAlDz7J+kJ66T1Emg=;
 b=J36kiG977HGEaMnYAVEWBymmD2127F294Og9xvBJ2gPwg0tnzLOrWE6JLqAPTs4/LaITzU
 bLtpVk+NchZ0v3uT28b40Gb8ngxWMj/SG752+UDUGRbRBpeKssaaMKA4mQpixRcpxpiZmn
 wHt1/p6zSDtxqhb54askiwbIYeaHJ+o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-TPe8Y59iOfCLD_T5MO3S-g-1; Tue, 21 Jan 2025 02:15:34 -0500
X-MC-Unique: TPe8Y59iOfCLD_T5MO3S-g-1
X-Mimecast-MFC-AGG-ID: TPe8Y59iOfCLD_T5MO3S-g
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4361efc9dc6so27940655e9.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 23:15:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737443733; x=1738048533;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f6XpwbfWkxsgRZcn3w7vmQsk+9mAlDz7J+kJ66T1Emg=;
 b=m1sAltCdSl+6sCl5r9feQUAZ1aAPPRznqkKgOFgBAOeOa0hLW9yvCV0v9rsiutTh0H
 /QEeGHuOsPCw7oZAJl0TSLQjeKM/Z01r6Of2Vay67jk07ONxBgTCVYNPx9Tojo0CkZMU
 fszrY2nChWByTsAtDsS7ROBV7e58d8j3VHx4bSqBnb/bBL0WZuTCnEodv0IMv6obmbBJ
 MVYj1bgcs13XRVKBYd+TV7mvLQxA/JGB8B7a9CaRxf8ym8awVjKVXuUDIhxxUeKTeaJV
 K8YbI3sOuGXBJ0uUDXlGttNjSuCWfp4hYbCT3Na1Tn6IlaChFX1+SzlUIYB1CYe16tlB
 sUXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdRbTR6imEYh8o0efS0kwSeePDQ2gl/e3u3BrBSVFqhieTiacI3BOJi0ZCxol4hBIsf3TGsxfP6YzI@nongnu.org
X-Gm-Message-State: AOJu0YzZFYjHMQVw843xQyw9PzhF7s1qroiDqH4I5OAGRibLma+Rclf0
 WoETL6/6R5zqRjhWvIK7P+npZrCJYmtFLLb1arbdL4KVZhMiLn8gPWin35pUGDyVebvtVm/ANcg
 fIA5YI0JfkTbynYzJEELyg1iYFFOId1UM0ijDKjLwUiv6tUeK+hqo
X-Gm-Gg: ASbGncuFCLWQ7h/kD452dppTvQ8pqZqyigRFVCgb51615YG6K3LLT1jhQSGKNkGY4XC
 rt2j9lY6UXMbNTOjottq/K7Y1NTDmTOC9ghbF/azQsq67stccM/caZpnzNR93aijG1en1EYYgA3
 aXKgchOH80/dADr/6yr7/F6QHEskPAJTdTcTQM/fl5iut2GMbeYX6kUxhwQ7GFNZoCcVES+QpIQ
 semQoeB8GAZXuFBIaJEeb0lbNgqOgiVJeeMdTqW0kYbKyuI9FaNp90Z1mQFThCNgDFmiHKPhyGq
 0/QVOzXBqTMrExbrguO4MTzznWpbobP8BtUWh8B53w==
X-Received: by 2002:a05:600c:4f42:b0:434:fa55:eb56 with SMTP id
 5b1f17b1804b1-438913cf805mr152999825e9.7.1737443733309; 
 Mon, 20 Jan 2025 23:15:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHK3sCfi7IcM896D5xQmtpFdeeOWWiAKGu5cUqxdUoYP6JBYMpavazns9seW4nDdP9xNtAG1Q==
X-Received: by 2002:a05:600c:4f42:b0:434:fa55:eb56 with SMTP id
 5b1f17b1804b1-438913cf805mr152999595e9.7.1737443733011; 
 Mon, 20 Jan 2025 23:15:33 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf321503fsm12721334f8f.12.2025.01.20.23.15.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jan 2025 23:15:32 -0800 (PST)
Message-ID: <6289de17-a462-4186-a898-064c15f508a3@redhat.com>
Date: Tue, 21 Jan 2025 08:15:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/virtio/vhost: Disable IOTLB callbacks when IOMMU gets
 disabled
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, mst@redhat.com,
 sgarzare@redhat.com, lvivier@redhat.com, zhenzhong.duan@intel.com
References: <20250120173339.865681-1-eric.auger@redhat.com>
 <CACGkMEu4oMa8Sf9QXtszeoSMj_67Csr0s7kHdYfbNnJWibu2dA@mail.gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CACGkMEu4oMa8Sf9QXtszeoSMj_67Csr0s7kHdYfbNnJWibu2dA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


Hi Jason,

On 1/21/25 4:27 AM, Jason Wang wrote:
> On Tue, Jan 21, 2025 at 1:33 AM Eric Auger <eric.auger@redhat.com> wrote:
>> When a guest exposed with a vhost device and protected by an
>> intel IOMMU gets rebooted, we sometimes observe a spurious warning:
>>
>> Fail to lookup the translated address ffffe000
>>
>> We observe that the IOMMU gets disabled through a write to the global
>> command register (CMAR_GCMD.TE) before the vhost device gets stopped.
>> When this warning happens it can be observed an inflight IOTLB
>> miss occurs after the IOMMU disable and before the vhost stop. In
>> that case a flat translation occurs and the check in
>> vhost_memory_region_lookup() fails.
>>
>> Let's disable the IOTLB callbacks when all IOMMU MRs have been
>> unregistered.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  hw/virtio/vhost.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> index 6aa72fd434..128c2ab094 100644
>> --- a/hw/virtio/vhost.c
>> +++ b/hw/virtio/vhost.c
>> @@ -931,6 +931,10 @@ static void vhost_iommu_region_del(MemoryListener *listener,
>>              break;
>>          }
>>      }
>> +    if (QLIST_EMPTY(&dev->iommu_list) &&
>> +        dev->vhost_ops->vhost_set_iotlb_callback) {
>> +        dev->vhost_ops->vhost_set_iotlb_callback(dev, false);
>> +    }
> So the current code assumes:
>
> 1) IOMMU is enabled before vhost starts
> 2) IOMMU is disabled after vhost stops
>
> This patch seems to fix 2) but not 1). Do we need to deal with the
> IOMMU enabled after vhost starts?
This patch handles the case where the IOMMU is disabled *before* vhost
stops (not 2). This is what I concretely observe on guest reboot.

But maybe I misunderstood your comments/questions?

Thanks

Eric
>
> Thanks
>
>>  }
>>
>>  void vhost_toggle_device_iotlb(VirtIODevice *vdev)
>> --
>> 2.47.1
>>


