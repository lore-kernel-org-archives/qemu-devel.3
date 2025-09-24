Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DB7CAC5B1
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 15:14:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1RAl-00031m-SF; Wed, 24 Sep 2025 11:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v1RAi-00031V-Js
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 11:12:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v1RAg-0003Oz-82
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 11:12:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758726759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lMLc9wiYASzdSfeyzPH+ALlPI1tcOqkfgwfwQO1YBlk=;
 b=h3k9fPJY0v3q2F3Nki6yiAn/dD6Pr8IztHc+312RbhconzV/QBoEV7L62F4IWzGfWihORS
 0GpN+6O+wCUypTRVs56rIEA+tEUJGrI0j8FXloYDbKt+IQojfsl4yaD1IIbds9lI5hL1Zm
 kqdmmKos/V1Dc9PWrmeU5rdkRQ9ljvQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-D_EYc6Z6Nemw4H8JtuzaKw-1; Wed, 24 Sep 2025 11:12:37 -0400
X-MC-Unique: D_EYc6Z6Nemw4H8JtuzaKw-1
X-Mimecast-MFC-AGG-ID: D_EYc6Z6Nemw4H8JtuzaKw_1758726756
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3fba0d9eb87so1690661f8f.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 08:12:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758726756; x=1759331556;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lMLc9wiYASzdSfeyzPH+ALlPI1tcOqkfgwfwQO1YBlk=;
 b=SoyTCSO5I3hbQ3WNHa545jhpkxTzBmgUXJ2Sj0jTUpDH1TPEWeYzRJprnAiJL311/m
 0dZUqMFzmMPzGf9tiYjOI0EIF1dtNhtXzMjJAQQUP31XB+VFFKMy8I7iBSZIQzTUjDOd
 Oz6OhfVBg24VG6OI6+FW5Vwvxm0Z/nOawUwf8zZonhKKEYHO4dYHlMNO7ktljcSawDRY
 aAPctTAWjpjfa85gDWuMDjr5zfF19HPh+Q25UGLiOZLYSOgEfXA0E+rXdS2IUq5JNFwm
 1uOrPAZ2F7703vCKUgenV38krQ/BnMwsC0D9q2FgZD1XGSJ6sQKV+yT/Qopqeha9soeO
 wQ2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxGtiN8KddpKIakANWDRSXmzA+3wy+VA1KXKtAEeEUkrDoJJ5V0EGTAnS2E3xYYjtDMC6DRcBY130Z@nongnu.org
X-Gm-Message-State: AOJu0Yy6EztBvLm4K9KJwhQ+P6EU4YRNGn8mRzo6WezkPsqy0WPiGhv3
 qDlg9CHuolVKo8ZEJ+mCzkwP9nGL2oDDyBE5F4mns/47+GkRygh+WxECNIPCuQJeaLWnzoW+PCU
 GHZ4jse1frSGsSE/NVuwudNott61rLcf1Mxy731fMyuqkNSwdQ2YbranM
X-Gm-Gg: ASbGncuSh4wACD/ND2H2IZFQ0bDGLa+t9kweDZR9PzuWi7EvtG6so0gj4u/bAe18Ozv
 dtuNDyMkoEMO3OmvUN23HKNX79aAKzkQTDaHXSyQDAYtTseFisubmk0AcKy7TMyuxms2kKYR2T1
 TY/8s5287gNIxW7UOXT/H3Wdf7aLc1G69DwPJ/uSvujOlhrBgTKtIx9NTJzV0n/SypGZ5t2w6nr
 d2CL6eFz1HtP5uh1CCZTFPsTMPTagQtnc3UA41FSM9+rWgv+LzfHH/WYOKwZ1qAH7LwESehjjJz
 rqCApFndltuUOzzZHvDQoIHlA5s6/AVW3NVqK/Lt8E1tVjNW1qbENQt7FP49dNWnZ8dbMdOnJ9Z
 OP2E=
X-Received: by 2002:a05:6000:40dc:b0:3f7:ce62:ce17 with SMTP id
 ffacd0b85a97d-40e4adc1016mr257980f8f.38.1758726756402; 
 Wed, 24 Sep 2025 08:12:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdW1Y7VkCbcdrrgxsj6+oyOIVCfzEhBJA4vR+WfagEPm3/KV7/cpUxpjmNunEYh82wfogeTg==
X-Received: by 2002:a05:6000:40dc:b0:3f7:ce62:ce17 with SMTP id
 ffacd0b85a97d-40e4adc1016mr257894f8f.38.1758726755543; 
 Wed, 24 Sep 2025 08:12:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee0fbc730dsm28643445f8f.41.2025.09.24.08.12.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 08:12:35 -0700 (PDT)
Message-ID: <66e0c63a-1759-4082-8bb7-1d3a127bac38@redhat.com>
Date: Wed, 24 Sep 2025 17:12:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/27] vfio/pci.c: rename vfio_pci_base_dev_info to
 vfio_pci_device_info
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 harshpb@linux.ibm.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, steven.sistare@oracle.com, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
 <20250923135352.1157250-19-mark.caveayland@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250923135352.1157250-19-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/23/25 15:53, Mark Cave-Ayland wrote:
> This changes the prefix to match the name of the QOM type.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/vfio/pci.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index a511f99a2c..e8d2e36df0 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3672,7 +3672,7 @@ static void vfio_pci_device_class_init(ObjectClass *klass, const void *data)
>       pdc->config_write = vfio_pci_write_config;
>   }
>   
> -static const TypeInfo vfio_pci_base_dev_info = {
> +static const TypeInfo vfio_pci_device_info = {
>       .name = TYPE_VFIO_PCI_DEVICE,
>       .parent = TYPE_PCI_DEVICE,
>       .instance_size = sizeof(VFIOPCIDevice),
> @@ -3973,7 +3973,7 @@ static void register_vfio_pci_dev_type(void)
>       vfio_pci_migration_multifd_transfer_prop = qdev_prop_on_off_auto;
>       vfio_pci_migration_multifd_transfer_prop.realized_set_allowed = true;
>   
> -    type_register_static(&vfio_pci_base_dev_info);
> +    type_register_static(&vfio_pci_device_info);
>       type_register_static(&vfio_pci_info);
>       type_register_static(&vfio_pci_nohotplug_dev_info);
>   }


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



