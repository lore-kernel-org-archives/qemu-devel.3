Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD97C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 16:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taH49-000683-So; Tue, 21 Jan 2025 11:25:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1taH46-00067r-8o
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 11:25:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1taH43-0006xo-LE
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 11:25:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737476718;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JewqLMilWCp5rzsJaPINSBrnhbqDPCnvENh3ePrHyhc=;
 b=H40DXHAhGor0EuGcR1bfgQZYSZgmVlEGxT8ti1dhX5MP8/IFl30ssGENBtSOA2ohex7PA3
 8oy8EIRiTBvoP5uhyJZutOyzygr3R/KLR3B3STUth6WMpasNsc0cU+VJqhMHTSrVsrCaNl
 qXK650zYoWaxb/9auVmFuECm6QExO8Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-PMEea0bYPt2a_6dpp9zNLQ-1; Tue, 21 Jan 2025 11:25:15 -0500
X-MC-Unique: PMEea0bYPt2a_6dpp9zNLQ-1
X-Mimecast-MFC-AGG-ID: PMEea0bYPt2a_6dpp9zNLQ
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43628594d34so32286675e9.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 08:25:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737476715; x=1738081515;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JewqLMilWCp5rzsJaPINSBrnhbqDPCnvENh3ePrHyhc=;
 b=A0S5mx7KWdKzLtUKmHjA23OmuCe3kPzkki2EUE2Yz/TDk6YmCPI8Wt8v3tX9uK79Da
 lUbEl44PVC4mdkEhiQIkv2sG5dvT7Sok9x52kebjAjQLd7IIPouh0+kZY7gObeIilizl
 Ij9iuKw45mJpXG7WMxqAq086O07fZGgkXzF/3ZP5suPeIBwB5lPo2qaKz6ij78GeHjNW
 zCxDKi8mmJ67PbTX/FcFA43IefO9Y0SyBxE1xlHHhtOR0npc+bAytMFdpWNP+/9XaDau
 fUGA1FsMipArcSlTufR87wG262UpsZk3MuP0NTeME4byaml5JIfXlNxjlq0Ayi4c3qkl
 HRtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMuObBcbs0T/obrld234lnD1HqDXzPQccxQd3LlEAer4gvJ3AOViDs9dr8/UvWVHrGPHZGvfCii/wl@nongnu.org
X-Gm-Message-State: AOJu0Yy0wGfXV3VzhZAo38CiczW4E45R78+malL14xNn/d/EURuBiIS7
 vqIpksdEVO/51S88dHMqkAB2hW0OL2KI3Lz0PI29OhqoMp4k+zGIW9KGA3NVzVFg7nGv4umntXp
 LJhXlXX/RDSKPTfsdyD77JpHmN7I9AR+K5kPqn5ETGgsoEDo9k6z6
X-Gm-Gg: ASbGnctX1jN8PpvT7+qfQ3MUNed87HgTUAPtSwNL3MvbSfjF/sS4nSSDnmy91piEHvM
 TUJK6Uxwuqhz5Ziko4fybZZTA2chvdgg4gTkbDc2/hXWx1EP9rqNzRHa9t+TA1k80psHwaitF63
 u06ULDeh+gjg9EbY0xBgAKywmqEiZmEqT+eh7u4f0hjE2Yg4JIsuBajWTiaX5BKQD3hZjBMfepI
 +prHppwCkxzayBnhGUN+bBK/PAScb5UdlZIHvk9Wfy5li7BQ1NsTD9O/bn/KxkQAK/Hz9tKAnK2
 thBPnwtSZoexn+U0NY7rJMrWn6IHvLrkeIVtZzgJ3A==
X-Received: by 2002:a05:600c:a09:b0:435:9ed3:5688 with SMTP id
 5b1f17b1804b1-438913f86dcmr171274135e9.18.1737476714613; 
 Tue, 21 Jan 2025 08:25:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmSu+D6t8To1RjBWsv+hj9g8/0P2QFSW1FnBUxzs28klcRha6wfYu3a2tUZwjFb12TOPnjqQ==
X-Received: by 2002:a05:600c:a09:b0:435:9ed3:5688 with SMTP id
 5b1f17b1804b1-438913f86dcmr171273915e9.18.1737476714228; 
 Tue, 21 Jan 2025 08:25:14 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43890468869sm183034885e9.35.2025.01.21.08.25.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 08:25:13 -0800 (PST)
Message-ID: <5a55011a-af8f-483a-99fa-5cb2cdf3841f@redhat.com>
Date: Tue, 21 Jan 2025 17:25:12 +0100
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
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.086,
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

sorry I initially misunderstood the above comment. Indeed in the reboot
case assumption 2) happens to be wrong. However what I currently do is:
stop listening to iotlb miss requests from the kernel because my
understanding is those requests are just spurious ones, generate
warnings and we do not care since we are rebooting the system.

However I do not claim this could handle the case where the IOMMU MR
would be turned off and then turned on. I think in that case we should
also flush the kernel IOTLB and this is not taken care of in this patch.
Is it a relevant use case?

wrt removing assumption 1) and allow IOMMU enabled after vhost start. Is
that a valid use case as the virtio driver is using the dma api?

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


