Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E77C3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 10:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDKc0-0004np-GO; Fri, 09 May 2025 06:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDKby-0004kM-Ey
 for qemu-devel@nongnu.org; Fri, 09 May 2025 06:05:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDKbw-0000qo-Lf
 for qemu-devel@nongnu.org; Fri, 09 May 2025 06:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746785142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hIoMzm6lreubKYxvMKfQaU7ljPiPfl3x3BiVrgaef/8=;
 b=im2Lwt1pJChL29mCE8BqJ4pjuuCMJV45ZPHmIbpzxs5+EwcQWifsF2GB4XAlPDF+sycBBb
 oe1qnv9e+6oenSVtpJTka9bzxy4EyrDXZVeSEzbbG2N1FNU2TnRI4025c/69Wgz9Qd4b4M
 ix5ENMEgDDSFVuKar21kEAy1I5rlQJo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-Dh6O-Py_OWGeFAm3QifCDw-1; Fri, 09 May 2025 06:05:41 -0400
X-MC-Unique: Dh6O-Py_OWGeFAm3QifCDw-1
X-Mimecast-MFC-AGG-ID: Dh6O-Py_OWGeFAm3QifCDw_1746785140
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-39ee4b91d1cso1327861f8f.0
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 03:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746785140; x=1747389940;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hIoMzm6lreubKYxvMKfQaU7ljPiPfl3x3BiVrgaef/8=;
 b=mY6qcgbLMfwgFZQlJmy/tzLTfxQ+MHNtzbYfn1KUb41qnYtdBwILd+m2gAem6GrAMh
 SCK3hm58HFd/77PUftHk1DpzF+nXF+j6bl50Njv7ddhNH7BxLjZ3m0AJPcCO0/27mrq4
 //TTRgxvaTt8l35M/yggjVp5qvKr96NhfzJu2KIVThZIxhFQeMU8NgV084UVT7L3Vf5l
 ZrAd9eSSicqqjFA6ieL13dSfpaQsx2b424XNnbapX04Ek+WblERkzdgTtYlqooVklrJW
 SjaxYZccaJlb7+nRyN9dRNZGmgvkM+a24neKq5X1jbQD2IF9hOzuEn90xBMWzi8bSsDX
 R5Qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhRub88/Ek5Etp8t+bUdTykFvjcKld6eESgyOHzEICZR2rNt9FPUK53WcDxu4WzMslOFIQd358o56s@nongnu.org
X-Gm-Message-State: AOJu0Yy+ZtyFQxAxj0vav6VZ2Gz/4oiID9EJeXl3nLGGW1UYz0lanADc
 aC4lxnqYUwSfqxoNzD6TSO89kcJnMRWNVolFZ97yIATaz4oMaRDyMei1DSkcOLUqlA3SS6nqN90
 +Gc4lKlqNtMf8oIrGdKolnINVKF/zrkE2yPb1gdrgG360P1n7F+DF
X-Gm-Gg: ASbGnctG7MWEjpSOwhBXOUmab9bevWYbbtkBalAYcQpyPsyWyH04TzhmDNkjG4vWB3q
 qkvGE/ICDYbDRXY7jw+eCwrBlgPBfb44R8UIx19nnspvQrTWFfUuvc4s3Mqhe6VDuCh/9dNq5/V
 WeOZ7dFF/+SomCAOZDEow+rohcdLdu42u0OadICWMHMS2Pa27VgmaTEUJXJI2BhjxCeVdlyxGjE
 VRepL++/owgFgmlx7ftSCQiTLUUjW1aM2CaYAXGwmot5WeUSmt1No5BZI2PJG3K1SLzjtKOkfyE
 WrNMwwV2Bzgyrg3DG74HrTOWlHI59q2v0ohmklEq72QYgLIIU+3W85jD
X-Received: by 2002:a05:6000:144f:b0:39c:30f7:b6ad with SMTP id
 ffacd0b85a97d-3a1f6c984a1mr2462855f8f.18.1746785140277; 
 Fri, 09 May 2025 03:05:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYedQ3X1oEOMDrbmxPjYQToYUDNSTsnmaT5efypYb31/rVfwCJ0j6uXebLqRlVX255dewDUw==
X-Received: by 2002:a05:6000:144f:b0:39c:30f7:b6ad with SMTP id
 ffacd0b85a97d-3a1f6c984a1mr2462826f8f.18.1746785139921; 
 Fri, 09 May 2025 03:05:39 -0700 (PDT)
Received: from ?IPV6:2a01:cb1d:89d7:6e00:da58:edc2:d8ef:4b9f?
 ([2a01:cb1d:89d7:6e00:da58:edc2:d8ef:4b9f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a4d0dbsm2699282f8f.88.2025.05.09.03.05.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 03:05:39 -0700 (PDT)
Message-ID: <73a82f2f-b942-419a-aa64-f8f36bb60b36@redhat.com>
Date: Fri, 9 May 2025 12:05:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/15] vfio: add strread/writeerror()
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Tomita Moeko <tomitamoeko@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Tony Krowiak <akrowiak@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 qemu-s390x@nongnu.org, Jason Herne <jjherne@linux.ibm.com>
References: <20250507152020.1254632-1-john.levon@nutanix.com>
 <20250507152020.1254632-7-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250507152020.1254632-7-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/7/25 17:20, John Levon wrote:
> Add simple helpers to correctly report failures from read/write routines
> using the return -errno style.
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   include/hw/vfio/vfio-device.h | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index a7eaaa31e7..4a32202943 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -115,6 +115,20 @@ struct VFIODeviceOps {
>       int (*vfio_load_config)(VFIODevice *vdev, QEMUFile *f);
>   };
>   
> +/*
> + * Given a return value of either a short number of bytes read or -errno,
> + * construct a meaningful error message.
> + */
> +#define strreaderror(ret) \
> +    (ret < 0 ? strerror(-ret) : "short read")
> +
> +/*
> + * Given a return value of either a short number of bytes written or -errno,
> + * construct a meaningful error message.
> + */
> +#define strwriteerror(ret) \
> +    (ret < 0 ? strerror(-ret) : "short write")
> +
>   void vfio_device_irq_disable(VFIODevice *vbasedev, int index);
>   void vfio_device_irq_unmask(VFIODevice *vbasedev, int index);
>   void vfio_device_irq_mask(VFIODevice *vbasedev, int index);

I am not thrilled about the naming nor the location  (why not use
hw/vfio/vfio-helpers.h instead ?) but this is minor and we can refine
later.


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

  



