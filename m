Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526BCCDDE7B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 15:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3cyw-0006kL-H1; Wed, 23 Oct 2024 11:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t3cyu-0006e4-3c
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 11:09:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t3cys-0002bZ-Nu
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 11:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729696142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=t0KfrKZRgo4H8w2xNybSOozL3+7lDVD1nHGkCTWBdE4=;
 b=WNr4Z5Ke78d86XzEKQLIP23Fzxn9GQTm//Fk+84QY1rxGT4GBruQ2GsKjR6la3ZnUJPfdK
 T4XBZVBI0rN2Rbh8+f1cwu8zr2HCEJTzPV7yVOeYFVZwGPPSanRnfoQx6YlFjDaH6vKNJM
 zerYUPEw07CmR3mtoWNJQjmTLK/ZowU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-OfH-ehbpOCq7DCYXlf7lgw-1; Wed, 23 Oct 2024 11:08:58 -0400
X-MC-Unique: OfH-ehbpOCq7DCYXlf7lgw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7b141ea40dcso1114522985a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 08:08:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729696138; x=1730300938;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t0KfrKZRgo4H8w2xNybSOozL3+7lDVD1nHGkCTWBdE4=;
 b=jT+Bv9LR7+jAku4aYfpkLPRE8DJu4uRs5GF2CpFuGTfRjyJAarGgaMb3b5TxSLEOlY
 yL30r8YjPYoJ/VeYImtHs10J/fPe2gz1XHhjhaCANvHiaMe1TIClf6Ueqsg/z+wBaC6k
 oNVr8F3s3j1N1JyLkeJfbAdlP64JarDJ6HrpEJChsWqKMKtT+SOVHxuXVPVGTAOHaIzo
 ghm3bSBZH+KU2U8X3iUZj/Gh/xPl61nLCN3D1IzG7R3KHXHgH4CdJVgXWRNAmYWhRNJz
 MdK4Zq7cia++mQh0HL1DNF2HqM/3n2G+uW5Y33xW+WlLBI1Afrg1zpDN7VTZM3XrsRod
 xQLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNX8iLm+UXKKxvMg1Q38rG4sofFIPYTs4L0J+wS6+KGE4V3m6r7tYWl6jYHa7Sdm0XB2BBn/TQ5+ZH@nongnu.org
X-Gm-Message-State: AOJu0YyN8n+R8o6s7+DJS/JidvRIKcu7yzInPpSyueOgj112Lr8u2A3M
 V4xx0+RgUL3BMCkAS0inBQDUYWRW3DAMIxooBeAOk5euhno1FhMieD/liBNih40H+pt1OFZBCXB
 nW4xEiua1Vzdj3NKUj2VGoEuK1StpEcjGxugJ8whQRixqf+++FtyN
X-Received: by 2002:a05:6214:3a8c:b0:6cb:5f28:6b73 with SMTP id
 6a1803df08f44-6ce3413c3e8mr32816176d6.9.1729696138164; 
 Wed, 23 Oct 2024 08:08:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxM15+x8VAixnoSMY2/s9E9SIfNoF2TYBelUVOTwnZo/W1x9YvDrYZEcuymozP71Ry7jTBeQ==
X-Received: by 2002:a05:6214:3a8c:b0:6cb:5f28:6b73 with SMTP id
 6a1803df08f44-6ce3413c3e8mr32815916d6.9.1729696137814; 
 Wed, 23 Oct 2024 08:08:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72?
 ([2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce008b2505sm40103366d6.3.2024.10.23.08.08.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2024 08:08:57 -0700 (PDT)
Message-ID: <1e378ace-ab4c-47eb-82fb-70a2c2abbe20@redhat.com>
Date: Wed, 23 Oct 2024 17:08:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] vfio: Align mmaps
To: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com
References: <20241022200830.4129598-1-alex.williamson@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20241022200830.4129598-1-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/22/24 22:08, Alex Williamson wrote:
> As described in patch /2, newer kernels may support pfnmap with PMD or
> PUD sized mappings.  Mappings must be aligned in order to see the full
> benefit of this support.  We're largely able to get PMD alignment for
> free from mmap, but PUD alignment requires some effort.  Further, we
> don't actually have an easy way to determine PMD or PUD alignment,
> therefore we align all mmaps to the nearest power-of-two relative to the
> region size, up to the maximum PUD size known the be currently available.
> 
> Enabling debug prints in the kernel shows that this exclusively enables
> 1GiB mappings for a GPU with a multi-gigabyte BAR whereas previously the
> BAR is mapped with a combination of 2MiB and 1GiB mappings, only using
> 1GiB when opportunistically crossing an alignment boundary.
> 
> If there are ways to determine discrete alignment intervals or better
> ways to generate a properly aligned address value for mmap, please share.
> Thanks,
> 
> Alex
> 
> Alex Williamson (2):
>    vfio/helpers: Refactor vfio_region_mmap() error handling
>    vfio/helpers: Align mmaps
> 
>   hw/vfio/helpers.c | 66 +++++++++++++++++++++++++++++++++--------------
>   1 file changed, 47 insertions(+), 19 deletions(-)
> 


Applied to vfio-next.

Thanks,

C.




