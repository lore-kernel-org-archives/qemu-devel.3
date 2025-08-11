Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C2AC87FDB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 11:57:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulR8V-0007C2-DV; Mon, 11 Aug 2025 07:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ulR8T-0007BL-RE
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 07:56:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ulR8O-0001nN-NW
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 07:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754913367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=h0Hj/urS/QqvkDQvciAiRQvUIB9RnydCnd6YYuVFLyQ=;
 b=FsvCzLeV5tWpYDhdzx0xAAgrOQVK3v0VPP21SBCwYxIU5T9XWhHnG1nus8yneeDGT3OaQt
 eWyXjwYAeGLs2JCrMjQZAvrL6EKplojiLUxFeCQQ/Yi0NxkHorBjIVFEdOAxjOVp1FUbef
 hdJljj4zlJVh4nGjMLNuvVJlMUhxXqU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-G8THOaRvNzGe55xXe24u5g-1; Mon, 11 Aug 2025 07:56:06 -0400
X-MC-Unique: G8THOaRvNzGe55xXe24u5g-1
X-Mimecast-MFC-AGG-ID: G8THOaRvNzGe55xXe24u5g_1754913366
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4b065932d0bso131253241cf.3
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 04:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754913366; x=1755518166;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h0Hj/urS/QqvkDQvciAiRQvUIB9RnydCnd6YYuVFLyQ=;
 b=cPeK2379EAYdyHe+GSzhfYq+kLaXWSKaHWwNw0CY6fBAQ7DzueZTAcsJqbd6G8a/65
 L8FxDRgSNyHW021pe74CZ1kzU4doWDQ0DCClLvaLU428AZZXQrLz5TAfl4qCb5922Zbp
 F07XG3WUtJNhu+6nNKg2aW6Hh4bvpVHA+/Gt6XL23c2cCk9Go0xvMFOktlp7Z2bwjLlV
 S+f+WSpzf6kdFvxU1LZPU5jh3s+H4njWWMcsz//z7kVuIaO9m6nSLZvBJ9o1tu1tYE1K
 j6NeKphLZl8/I6Pjwi4fu3ZT0TTjgF9SizalRAY3jvFpYMpZ9tCbv5qNGw//1gbL5Bad
 QZkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCULmc8EyA1X0rvLF1CK0kLlleIyQN95vG9au/xQVZThvu+IGSRp6zn3qI56UPWaKWkLxQPMTBG4HR7b@nongnu.org
X-Gm-Message-State: AOJu0YzjYoBXE/IeUIlE5tI1W8eSEpqODv+EcaMSU2KYtuctt5Z5f0Gh
 4cJChBQ9FuQVpkpoVr4QUDq6bnsEb8HmIwRSsjBGFHrJKlCa0fihQVmy81HjNvvDfVxgB1OvqVP
 Nqd+72inHmBz2U4T+FW7u7fepdY+OfSgmTozz4Utx4gh7N6VhgeQYRBMX2JgR1ZSY
X-Gm-Gg: ASbGncvN53rPBCIYSxhWFB57vo0sR8BFheq5M9nwRBtOr24nWUOumtVn8y5XqDXzAdd
 gy4JhaLO1BZEiBLKAcZG57c67AbE/HYT7+5ciCq1ibOVrCm1p+oycrSYDXjiaCF4dTmhC+gnmk6
 L0VF8T+reRADI47UsfoajP08S1Jw2jTpV4rBVI7UxJ5dFqdxytN9dmkpZMc0holGh1EtOO2y/tS
 UTJa4Dg47np82Tfnc9QG/9Ewj3UAP5Lm0iPclafYWeghdgGoOw7Y9g3bDVrki4wIfWnHIlAYM2z
 cu25VpyJIBIN4b93AJHnvg4hlGvh1+8bcwF2ATBqjJobN0SXsXwHZaweKC29QOt/SeF/sm21n8f
 6uQ==
X-Received: by 2002:a05:622a:1181:b0:4b0:7620:7351 with SMTP id
 d75a77b69052e-4b0aed29dfemr170609741cf.13.1754913365900; 
 Mon, 11 Aug 2025 04:56:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhCeIDdP+eTz1i06UvdLSGkVROHAymvW0wInzbsvMIRJpLnfdFucR1KZyq4qgAVgwTtmkpEA==
X-Received: by 2002:a05:622a:1181:b0:4b0:7620:7351 with SMTP id
 d75a77b69052e-4b0aed29dfemr170609181cf.13.1754913365269; 
 Mon, 11 Aug 2025 04:56:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b099b2c4c9sm67037771cf.58.2025.08.11.04.56.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 04:56:04 -0700 (PDT)
Message-ID: <8ad7794c-97a8-456c-8d52-a80f439659bd@redhat.com>
Date: Mon, 11 Aug 2025 13:56:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/22] vfio/vfio-container-base.h: update
 VFIOContainerBase declaration
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 danielhb413@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
 <20250715093110.107317-2-mark.caveayland@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250715093110.107317-2-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

One more thing we could do :

> @@ -105,14 +109,11 @@ vfio_container_get_page_size_mask(const VFIOContainerBase *bcontainer)
>       return bcontainer->pgsizes;
>   }
>   
> -#define TYPE_VFIO_IOMMU "vfio-iommu"
>   #define TYPE_VFIO_IOMMU_LEGACY TYPE_VFIO_IOMMU "-legacy"
>   #define TYPE_VFIO_IOMMU_SPAPR TYPE_VFIO_IOMMU "-spapr"
>   #define TYPE_VFIO_IOMMU_IOMMUFD TYPE_VFIO_IOMMU "-iommufd"
>   #define TYPE_VFIO_IOMMU_USER TYPE_VFIO_IOMMU "-user"

These type definitions would be better placed in the header files
defining the other software structures to which they relate.

   TYPE_VFIO_IOMMU_LEGACY  -> hw/vfio/vfio-container.h
   TYPE_VFIO_IOMMU_SPAPR   -> hw/vfio/vfio-container.h ?
   TYPE_VFIO_IOMMU_IOMMUFD -> hw/vfio/vfio-iommufd.h
   TYPE_VFIO_IOMMU_USER    -> hw/vfio-user/container.h

I don't know how possible that would be.

Thanks,

C.


