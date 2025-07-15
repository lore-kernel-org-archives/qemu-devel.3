Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2942DC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 05:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubYbD-0004L7-Fv; Tue, 15 Jul 2025 01:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubYb8-0004Il-TT
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 01:53:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubYb7-0005iO-5E
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 01:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752558779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=v3xigmgM8ytoSmUEVRkdJqLYA7Sad2hnQEzItXbx6E8=;
 b=ZUGa3X0WzCFm3gv1xPjFdmp5XMPWON/EIKv7pws1jCxdgywqKPJMsDTsIvCN8Zm52IuRe7
 Kkg19Y58wbVtdnDI+zeZdtLcs9WdLaa/WDHc5RHTnlz61BYFWqnZcQcw0RCOGHkmxQJtHe
 4L7m/n1aHhJQR0YTwj6fMjiW9SW+zFU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-fZt-HaOnNAOX3mv8KOGtVQ-1; Tue, 15 Jul 2025 01:52:58 -0400
X-MC-Unique: fZt-HaOnNAOX3mv8KOGtVQ-1
X-Mimecast-MFC-AGG-ID: fZt-HaOnNAOX3mv8KOGtVQ_1752558777
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4560b81ff9eso16958245e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 22:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752558777; x=1753163577;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v3xigmgM8ytoSmUEVRkdJqLYA7Sad2hnQEzItXbx6E8=;
 b=OhoSOUAcrJfpflclglZ2FOfPlBCij4eQC8IRfeFezXomPdc4d2fPVRyBD4e///bP4p
 y/GAw3jyHg+shGPfc95ZGlBFLljQ9m80wzRzD3XWrP+UdM9ouXjmNiGInSWd06QtQ7tO
 6m0f5fAX07zDeOWBBG0wkg16ZFLTLOZV0/sxJOKWFCQ6SvIdIb+emX3CjKjjlrs8MBv/
 +yYC82kCSOKGjzqoBwSh7Cnon02JTLfWx0kXvitgs2RykZSfcoiBVmZdPnu8BD4S8We9
 q4j5lpmcgxNLkG3U1d5MsfSg6ghdHz8/V+3XEtsJr6rvJFRmvXaKL9/XSlz4y3S6N0RW
 84Fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCULVsGjir4RNeg8T0nZCpfzU59R6c8MoJLFpNdkamsbsz71lvkZKNLYX4wsSpkb3OcrHOff8lHn+16/@nongnu.org
X-Gm-Message-State: AOJu0Yyj+gqRBHiRHoqgjgknZKgt+17YgW3RnVq4nDz9mVyn0uDmDmQ5
 Iv0+rfl5AEdw1nYsQgz44zB9ntP65HESxVwkjCG8DBTTiPoRTJ7jhLo/JkJMttV/xoV7DIO9cfI
 Tt8oG+4sr3i5UMFL2gNeal0Hvup2UwrWFiKBJuS93zaDoNYx79iicp01K
X-Gm-Gg: ASbGnctr53d88z4TZCT+X3KbSqsALmxz/32wtJExKsnwNKXJLQ9NxMsoG1CKiEIy7qX
 6FN8Bw6AFVrqR91NdoqzmZ85xiB4okcDRkQ9sojv1Gia5WoQ87sWCDu1WFuLo1IQo0+JRHzcNmV
 ao9Ibx2EQ7WfEeJHRmp07oXWETsCgum4LtBYGqoGJeOC3bf5E1ex1ZeRAsm6TrK/9hCPeEHC01V
 2BjIqs8rAoFi15R3KneSXfLuckN8oKMEhwlC11lmedJFZ2QdB6wcGCuoZxIVEy7VJ6vfXLuy3zg
 sv29sLdK6MlJ5zLjLNPyBddBbw9kBYWd4uVh5ckpejDjcUIyPGStlZSGo2h0UaFFWo3g68J8HWg
 =
X-Received: by 2002:a05:600c:8b21:b0:43d:42b:e186 with SMTP id
 5b1f17b1804b1-454f427c7a3mr154731375e9.8.1752558777007; 
 Mon, 14 Jul 2025 22:52:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4L5oZckRmFrqlLtscbR5H/FpQin2BlvLg00zQRniZeynJ1eo9FIgAR3WA/cCfyOEAfNkM4g==
X-Received: by 2002:a05:600c:8b21:b0:43d:42b:e186 with SMTP id
 5b1f17b1804b1-454f427c7a3mr154731225e9.8.1752558776626; 
 Mon, 14 Jul 2025 22:52:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:266c:b13b:afd7:40fd?
 ([2a01:e0a:165:d60:266c:b13b:afd7:40fd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e1e3bdsm13995593f8f.81.2025.07.14.22.52.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 22:52:56 -0700 (PDT)
Message-ID: <6fa745d7-25af-46e5-a143-5a419098b162@redhat.com>
Date: Tue, 15 Jul 2025 07:52:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/vfio-user: fix use of uninitialized variable
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>
References: <20250708154948.483480-1-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250708154948.483480-1-john.levon@nutanix.com>
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

On 7/8/25 17:49, John Levon wrote:
> Coverity reported:
> 
> CID 1611805:         Uninitialized variables
> 
> in vfio_user_dma_map(). This can occur in the happy path when
> ->async_ops was not set; as this doesn't typically happen, it wasn't
> caught during testing.
> 
> Align both map and unmap implementations to initialize ret the same way
> to resolve this.

This is not a strict rule, but a trailer like the one below is
usually added for Coverity fixes :

   Resolves: Coverity CID 1611805

In case you resend, please do so.


> Reported-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: John Levon <john.levon@nutanix.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio-user/container.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
> index d318e6a339..d589dd90f5 100644
> --- a/hw/vfio-user/container.c
> +++ b/hw/vfio-user/container.c
> @@ -64,8 +64,6 @@ static int vfio_user_dma_unmap(const VFIOContainerBase *bcontainer,
>                                 0, &local_err)) {
>               error_report_err(local_err);
>               ret = -EFAULT;
> -        } else {
> -            ret = 0;
>           }
>       } else {
>           if (!vfio_user_send_wait(container->proxy, &msgp->hdr, NULL,
> @@ -92,7 +90,7 @@ static int vfio_user_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>                                                   bcontainer);
>       int fd = memory_region_get_fd(mrp);
>       Error *local_err = NULL;
> -    int ret;
> +    int ret = 0;
>   
>       VFIOUserFDs *fds = NULL;
>       VFIOUserDMAMap *msgp = g_malloc0(sizeof(*msgp));
> @@ -135,8 +133,6 @@ static int vfio_user_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>                                 0, &local_err)) {
>               error_report_err(local_err);
>               ret = -EFAULT;
> -        } else {
> -            ret = 0;
>           }
>       } else {
>           VFIOUserFDs local_fds = { 1, 0, &fd };


