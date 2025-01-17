Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80375C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYrJz-0003lE-JJ; Fri, 17 Jan 2025 13:43:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYrJw-0003kj-Vq
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:43:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYrJu-0002Ow-FO
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:43:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737139429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fP7I+7ZvJh7Ba16bfVNTaTOb20T2GjstRw5JtMGzZZY=;
 b=c9WNhUZXPLBQyalCDIlZd0Xf5BReM0d9iWthNkDdxe15lQQgS9xEzkkLR69nPrd7jBBVrm
 02W/IbzXfn2v8XxxXG5sVkwuai2BwYu/Q1QvLdyK9aumQrk+jFOOzP60vybiSH3jv0MKtu
 l7tWbLGm5KUWQsP85GSqdIxrOiSlkhU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-L5t3G-_RMfCP_Qmb6vcQmQ-1; Fri, 17 Jan 2025 13:43:45 -0500
X-MC-Unique: L5t3G-_RMfCP_Qmb6vcQmQ-1
X-Mimecast-MFC-AGG-ID: L5t3G-_RMfCP_Qmb6vcQmQ
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4361f371908so17612085e9.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:43:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737139424; x=1737744224;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fP7I+7ZvJh7Ba16bfVNTaTOb20T2GjstRw5JtMGzZZY=;
 b=UcOVKfZkR35wmn8AHRxymCvABM9iZ+1NyfqMde5l2xyng0KxMNgPVori+ttTs88WyA
 68V1tgyL7lsijncbub8Xkj/Y9aU36AQiwTq1TifKGDo+LHsA8uWBHNDQVwgIfJ0QfCPr
 OkRzSPg0/xWq6cyt+aJYOYEn5C2b5a5G9sMpadbMDUSNBOKONYVAM2AwZl4oN4m6WSQI
 GGntUeuMvswS4oGOhENWbIC1KZdixLuknbZdWOgwdyzikimrQUhHCEgzeEdsVa4R/h59
 gI9xjSAse9VZNtjJbTVl2evsiFj6USw6msuILvFm968D7GyW0RWgGf7vhDMpBEOPDXby
 QX0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZ0s+rt/+wlV785XJLasp97N/NH2RfVIJYQrQrHdvX8Rmfq1qIWSICIyCCPSzJTov47ujA+65v72es@nongnu.org
X-Gm-Message-State: AOJu0YzPxokUerxEwfoOKWJVacauxewW/sZQbpcY9OYYglH/iErwJ3MV
 K1rE+FshSmMobx4vJBL22Qi3AVv9N5e8cmw6aplCf1pMMfpFLkdszBQTsbMlbzv3HzdE6Y4IfyY
 SNP0hPrtIUGrl0OV7d1jemFZ1hoKmIwc/dNdRuwZhWmjjpgWsJ6OY
X-Gm-Gg: ASbGncsSkt8P4uIWR19vbI+D2GwtQlL4kHQUKoSvwAHwjVxPrOch8kZXYspAuGVPVJE
 1EOVIkWReLnhWbVINkHrhsRztAocqSkRVS7gbW4ID9yu/uARfvvOVIHK7vYHQmpg8oZurhVz+Qy
 MNwcPvce1rNd4Gy/qSQh1QGzjb6azPUJRMNrgUGeTLkKSPbGamAlPoKasP3l3Fmbl76W5OTtpO0
 tfEmOrOIrARNyxJA/r7e6yxnzBxxkKO1Drr+TP52M/JxyBfvYH16I+DG7kS2lZMxMnKY4hKOADP
 JmWEuOvhKmUs
X-Received: by 2002:a05:600c:4743:b0:434:a802:43d with SMTP id
 5b1f17b1804b1-438914315afmr34324625e9.27.1737139423955; 
 Fri, 17 Jan 2025 10:43:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFG/MRLOTDNjR+xeojUpYL30qgnmET+XokFUQqNwu0CKcyn4bHQGEYJPCbUGxJG795CMm5QKA==
X-Received: by 2002:a05:600c:4743:b0:434:a802:43d with SMTP id
 5b1f17b1804b1-438914315afmr34324395e9.27.1737139423573; 
 Fri, 17 Jan 2025 10:43:43 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-119.web.vodafone.de.
 [109.42.51.119]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c7499932sm101797355e9.7.2025.01.17.10.43.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2025 10:43:43 -0800 (PST)
Message-ID: <ed04717a-0522-4898-913b-6f473b82fd21@redhat.com>
Date: Fri, 17 Jan 2025 19:43:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/21] hw/virtio/virtio-pci: Remove
 VIRTIO_PCI_FLAG_DISABLE_PCIE definition
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
References: <20250115232247.30364-1-philmd@linaro.org>
 <20250115232247.30364-11-philmd@linaro.org>
 <aa863f22-57fb-4ddd-bce4-1b0a86c9023b@redhat.com>
 <6b916259-da1a-4a16-84a3-64eb466714c8@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <6b916259-da1a-4a16-84a3-64eb466714c8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 17/01/2025 17.43, Philippe Mathieu-Daudé wrote:
> On 17/1/25 10:08, Thomas Huth wrote:
>> On 16/01/2025 00.22, Philippe Mathieu-Daudé wrote:
>>> VIRTIO_PCI_FLAG_DISABLE_PCIE was only used by the
>>> hw_compat_2_4[] array, via the 'x-disable-pcie=false'
>>> property. We removed all machines using that array,
>>> lets remove all the code around VIRTIO_PCI_FLAG_DISABLE_PCIE.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   include/hw/virtio/virtio-pci.h | 4 ----
>>>   hw/virtio/virtio-pci.c         | 5 +----
>>>   2 files changed, 1 insertion(+), 8 deletions(-)
>>>
>>> diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/ virtio- 
>>> pci.h
>>> index dd6eb9a4fc7..1ca7419cd43 100644
>>> --- a/include/hw/virtio/virtio-pci.h
>>> +++ b/include/hw/virtio/virtio-pci.h
>>> @@ -33,7 +33,6 @@ enum {
>>>       VIRTIO_PCI_FLAG_BUS_MASTER_BUG_MIGRATION_BIT,
>>>       VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT,
>>>       VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT,
>>> -    VIRTIO_PCI_FLAG_DISABLE_PCIE_BIT,
>>>       VIRTIO_PCI_FLAG_PAGE_PER_VQ_BIT,
>>>       VIRTIO_PCI_FLAG_ATS_BIT,
>>>       VIRTIO_PCI_FLAG_INIT_DEVERR_BIT,
>>
>> I assume it's ok that the other following bits change their value here?
> 
> I followed previous commit 9a4c0e220d8 ("hw/virtio-pci:
> fix virtio behaviour"):
> 
> diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
> index e4548c2f970..25fbf8a375d 100644
> --- a/hw/virtio/virtio-pci.h
> +++ b/hw/virtio/virtio-pci.h
> @@ -61,8 +61,6 @@ typedef struct VirtioBusClass VirtioPCIBusClass;
>   enum {
>       VIRTIO_PCI_FLAG_BUS_MASTER_BUG_MIGRATION_BIT,
>       VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT,
> -    VIRTIO_PCI_FLAG_DISABLE_LEGACY_BIT,
> -    VIRTIO_PCI_FLAG_DISABLE_MODERN_BIT,
>       VIRTIO_PCI_FLAG_MIGRATE_EXTRA_BIT,
>       VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT,
>       VIRTIO_PCI_FLAG_DISABLE_PCIE_BIT,

Ok, if it has been done before and nobody complained, the exact numbering 
likely doesn't matter here :-)

  Thomas


