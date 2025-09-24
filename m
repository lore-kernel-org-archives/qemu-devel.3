Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A945CAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 14:34:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1QYB-0005Xy-0L; Wed, 24 Sep 2025 10:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v1QXz-0005WT-HK
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 10:32:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v1QXq-0004fp-9x
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 10:32:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758724350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=m2m8ayslDhtGPUqqUmfnZtkGL464Tk+903UZErCe3bw=;
 b=hgvDJHO9iJGsgxQ36GJaMvz7o4Ki0NRI/D/ydbw+ziEyc8KNrJ+TJXWnw3PY3tnDOcqf67
 RteCFBN2naAdyDbG7/9ctSltEPDDAhXEARptTFPcApO5WRor4gaR+8BAIBWllnVby+Kbp+
 dHh/gR8EDWOpTmHkp3ChdYP23Q7H6lU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-mXq7b2rANTSrlehTz_8CQA-1; Wed, 24 Sep 2025 10:32:29 -0400
X-MC-Unique: mXq7b2rANTSrlehTz_8CQA-1
X-Mimecast-MFC-AGG-ID: mXq7b2rANTSrlehTz_8CQA_1758724348
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e19f00bc2so27079715e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 07:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758724348; x=1759329148;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m2m8ayslDhtGPUqqUmfnZtkGL464Tk+903UZErCe3bw=;
 b=JWP6UpZmE534EnZoC2ZGn49HB+qjZ0O2gce8QAhV+sHyOFiRvq41jejasG4/R2PmTf
 a05Cuy+iZsQMgGplWH/hl203bD6APhgkgWaIFu5fjcaE71JX+z1+hRQjh0cKwn6TfxMJ
 SpRXk3XDawdEjOQdkabhgMvkINoWmu1HVzsMNZekZOwWnuVFjP8SiOVWtFacon4gCNW5
 7pQvlFtwoN3Wv+CLLeLB0J4bIteDOQRuQvwIWPY2EZhXUvWVEFlbT+3gjtrY9OU+kT0q
 oU66EUcjWoaJUpDAbDDqJT46GcJLymxBQXWlN3rTyQb3tIldB+6ry+2WiE8gxdVhUXLd
 1f3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhRtwyxLlBep1GUbOGpM/I9AG68Q63dWEQprXkZXBWyZX2b3gtGYYMT/eZG5ZaxdeFGYJH5EWTqShR@nongnu.org
X-Gm-Message-State: AOJu0Yz5wYignwANVFuuy4XE6hDCx/HJegWAY6vZ/bKPnK0XRriGceHE
 3TzRfIodxueKQ6EjKR8AgI9pH7EteowLi23Ynraqw68+Ufrz1un1oNO/ZhKHXekM4gWBt4fITiq
 zK/IYVjva5/mopeXy69zRiXmsowFHio3OB9vSgoSCTSoAKBIPicRPGlLX
X-Gm-Gg: ASbGncs8LkKjPJiqlNpWJIwlNyEL1J2wHTQzUH9XE59sgOe4VCGh10wREk1OB1RrkKs
 isC52GY0vpxgQFmjhZGXUjpnHcI1v4dpjt593VpTdlHhGLes15K65hjKaysqqaLcXjjYESUtZ28
 MdUyUIyuRuZTlKxJI41ZK0u4FxHDesrGGxsqIJP78DSFPwhoiXpqbq+dXk50Io+sAjXED+0mgMD
 ImFxb//TwRezMY2/fOuel77coB5m+gOqyfDDy9HkwJV6BegvEspBJnWM1zElos87+rg+dgWokYc
 6LpvS7WYCiZ4GvYvf6ov2uKZRPhMY7yTcmBK92tLSdRQE4otTSis3JCxqWOPX7TYU0UDhAVTqY5
 H/2Q=
X-Received: by 2002:a05:600c:848f:b0:46e:2d8a:d1a1 with SMTP id
 5b1f17b1804b1-46e329b2d10mr1097605e9.10.1758724347806; 
 Wed, 24 Sep 2025 07:32:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyV/oX4g9ztzsIBEqc8NZKpaAZrz1VPmHs7TJKIcqsLTep6wfN2lLh3W+5hJFv3W0dTi+MLg==
X-Received: by 2002:a05:600c:848f:b0:46e:2d8a:d1a1 with SMTP id
 5b1f17b1804b1-46e329b2d10mr1097285e9.10.1758724347393; 
 Wed, 24 Sep 2025 07:32:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e1ce0f019sm36452295e9.0.2025.09.24.07.32.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 07:32:26 -0700 (PDT)
Message-ID: <51001861-b641-4584-9aaa-e1d8e5379057@redhat.com>
Date: Wed, 24 Sep 2025 16:32:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/27] vfio/pci.c: rename vfio_instance_init() to
 vfio_pci_init()
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 harshpb@linux.ibm.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, steven.sistare@oracle.com, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
 <20250923135352.1157250-13-mark.caveayland@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250923135352.1157250-13-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> This is the more typical naming convention for QOM init() functions, in
> particular it changes the prefix to match the name of the QOM type.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/vfio/pci.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index d14e96b2f8..9046244e7f 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3629,7 +3629,7 @@ post_reset:
>       vfio_pci_post_reset(vdev);
>   }
>   
> -static void vfio_instance_init(Object *obj)
> +static void vfio_pci_init(Object *obj)
>   {
>       PCIDevice *pci_dev = PCI_DEVICE(obj);
>       VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
> @@ -3920,7 +3920,7 @@ static const TypeInfo vfio_pci_dev_info = {
>       .name = TYPE_VFIO_PCI,
>       .parent = TYPE_VFIO_PCI_BASE,
>       .class_init = vfio_pci_dev_class_init,
> -    .instance_init = vfio_instance_init,
> +    .instance_init = vfio_pci_init,

I would have preferred vfio_pci_instance_init. This is minor.

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



>       .instance_finalize = vfio_instance_finalize,
>   };
>   


