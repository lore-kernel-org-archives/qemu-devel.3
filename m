Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8140DC87FD2
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 12:21:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulRVb-0007fb-Es; Mon, 11 Aug 2025 08:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ulRVY-0007ec-NI
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 08:20:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ulRVN-0005yJ-6m
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 08:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754914791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gZP0ezekiADeo7N0/2cco6PxDYGjeD1W8uTnzIIHNqo=;
 b=QTE/OWARXQh9vykUe1yw/64ijox+BnI7yfh8mm0VekUVBVGBBF2TgGZtTkIDVvY79Mwsyj
 N0bJMfcRU9kHz1zq1dFDt5hZjWs3SXSgq8KNfQpPdjF8HZcRJ0mwHno715s8w/ekhId2Ma
 wVUO9nVXkZiIyeaS9w4+rMu1Jo6gWow=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-Yjt_c7exMWiLyknrpQvCHw-1; Mon, 11 Aug 2025 08:19:50 -0400
X-MC-Unique: Yjt_c7exMWiLyknrpQvCHw-1
X-Mimecast-MFC-AGG-ID: Yjt_c7exMWiLyknrpQvCHw_1754914790
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4b0791a8e8dso124024511cf.2
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 05:19:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754914789; x=1755519589;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gZP0ezekiADeo7N0/2cco6PxDYGjeD1W8uTnzIIHNqo=;
 b=MIsqRc9dRxQngYQaOg1ZMKsVfo4PybnfKK9mveAVHjuGR4Q0KxBFeh/z2dCOFujUrG
 QUQTR8PfUYNweVVDky29Q746Jn4PM/XQZc+ZhzIWp/LbYh2d6wKrn0678AAoLnsXxffe
 87D7stCa4coQ2CSk2EnSYKPSBVT7NOcOLJIDIEoRlKN7NFq7JkAwJqrUHWbp/FmoWIFP
 1ucXe8Ytr46RMh6SY0CsEMa+5gub7yk9XzL2Vy+8+nHe4tlh5FLqO6cGuY617rnGGPOR
 oeQSnD9lS5meMMHvJ0fG3P/+NrY4hOgE8AchEsMaRKbPWBjNSRtv7T9g4b0F3K8cS0cn
 YXRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQPfdY9U5cokeAThvnqEdDNcMUOOFwEQrYfo3Rvs8wTJLf557CLYe+M340MM3ZPYJfR2KC5/7viwsz@nongnu.org
X-Gm-Message-State: AOJu0YwNbZ4Mu3fVXdxTZWGrNgnvqxHcNhtz0FjuCti+v15MPuliGExD
 20+qyaDv/bJBLETMILt1jV3f6OsJZXZaw73cdedekihOS9bKuO+meV6i7/3ItiQa5o85kRHNxS2
 c+YbyjgMsHT4ZWA1vspRtaI/sR0xSGDz17LqPoDynu5I4C9bTXByZBqqq
X-Gm-Gg: ASbGncs+PMpjL69zvM6Q1zvUoH7hUDgURgfYSCc6eqDZeVxQCpyUUpoB7lDbs+QVt43
 W2GajPTgzrXLgfZExH8qSyFmmlHZ9B2UF9qlaUpGT72ig0wZWhSuwWMs/a6Fik7hr6UJ/wQSrvR
 NJ2QNrD7rCQ46xBRrtwxLFsqa2S69i9XuEa0j6z6sOaZcQR17QjxmfoveBfzNEyTrHHvG4dwqNH
 FpS5uCF/3imwCJ4C8ab2t7gDIQ4MYB5Iz6LanAyDcokAUkDkQ711V/2gOqvOP5LHLDBp73c/Srx
 jvbJuZ/toU6YC1TIQib3qJPLAP83y7T75p5JsAIVl0eE8cxcSBCpDxlcZ0w6xXk+ZxxABfiJv9V
 evA==
X-Received: by 2002:a05:622a:34e:b0:4b0:7021:50f with SMTP id
 d75a77b69052e-4b0aed15ef5mr185672111cf.33.1754914789513; 
 Mon, 11 Aug 2025 05:19:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhpQaTQsGagWWAH7vq9sSRJxS/ieJOgPa6XSmpTw4xYeTw6CsM9vTsWfDz9+9UFSjh2N7GHA==
X-Received: by 2002:a05:622a:34e:b0:4b0:7021:50f with SMTP id
 d75a77b69052e-4b0aed15ef5mr185671611cf.33.1754914789064; 
 Mon, 11 Aug 2025 05:19:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b085ad7d08sm83932491cf.53.2025.08.11.05.19.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 05:19:46 -0700 (PDT)
Message-ID: <3ee8708f-abe6-472e-98ce-4fc008176eb5@redhat.com>
Date: Mon, 11 Aug 2025 14:19:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/22] ppc/spapr_pci_vfio.c: use QOM casts where
 appropriate
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 danielhb413@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
 <20250715093110.107317-6-mark.caveayland@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250715093110.107317-6-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 7/15/25 11:25, Mark Cave-Ayland wrote:
> Use a QOM cast to convert to VFIOContainer instead of accessing bcontainer
> directly.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/ppc/spapr_pci_vfio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
> index e318d0d912..7e1c71ef59 100644
> --- a/hw/ppc/spapr_pci_vfio.c
> +++ b/hw/ppc/spapr_pci_vfio.c
> @@ -106,7 +106,7 @@ static VFIOContainer *vfio_eeh_as_container(AddressSpace *as)
>   
>   out:
>       vfio_address_space_put(space);
> -    return container_of(bcontainer, VFIOContainer, bcontainer);
> +    return VFIO_IOMMU_LEGACY(bcontainer);
>   }
>   
>   static bool vfio_eeh_as_ok(AddressSpace *as)


