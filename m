Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC32BC3DA49
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 06:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sV42O-0000oT-Ch; Sat, 20 Jul 2024 02:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sV42B-0000lF-2n
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 02:57:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sV428-0004qE-Nb
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 02:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721458649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YXMsCmeXKhC38wpL3NNuJlhVAfBISSTjp4BIt8SDGGU=;
 b=OtZ27GTIW3XdY0p6LnOE0ZZRTq7OLeNGHpxYSPWqtOcgGkqFptj9/ix7D/a5UXkJdp09ob
 43b+B8VgvGMXbadaqAHyHMMq8TFjja5O2cU6jpaUsfuClZF3Su0whPmVvyOjrtHCJhikX3
 vwFJD62pMowbjmRFvCWUBHxXwW+p3GE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-XP1qiY38P-e3sWvUNRBBTA-1; Sat, 20 Jul 2024 02:57:27 -0400
X-MC-Unique: XP1qiY38P-e3sWvUNRBBTA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3684ea1537fso1074342f8f.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 23:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721458646; x=1722063446;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YXMsCmeXKhC38wpL3NNuJlhVAfBISSTjp4BIt8SDGGU=;
 b=RexyyKczQQ29c6iJvRzk0HQKZnCTyYTcfCx63jm91wNoXbw7p4iaCPEioaU5139DLO
 sux0NvVc3lbYNSQdldEGmsExPJkboJs4WgaCjIw1WUPOaHQIVmbaqaj90gt6MLBiXFSS
 oMQ5I3v2EQrfBiUmy4hMxYNXwKYp/CYj36Xma52CVuSZ9cHdFf+N7/IW9rUY9o5zEXac
 u5AZLtxM9O9Q8yiF1mvp1kJv/SliPCkxNKiwIix15HmQLB/VyGnkApmGxKKH/RAf3pgO
 lmvBV+BL9uzQ9qlBgn4PAoulFau+KyAS7xIfSR1OtQK68rVLflSEXG0WHv3XPc5MspgW
 GrVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTxcOm0bZv8DQ0CxIrl5ZMQ536hw0qZF9wCqaYu0q38gBuFJj9NU4qg5NjSDxB7vOZUWQjIKQIhtqvZFz3c2dE/mfdkNU=
X-Gm-Message-State: AOJu0YxbHAdP0SI7F7fBWTtFNu0L8Uhc8DVlvRzl4lw5ZzxfI3pEZg4l
 q4mhrg62YyLFEn0m1U4AGIlP6Td+47WmGxkB4DDzRWVOYggYpYnqx2mb2fOdWSPTa6nlfTp3pUX
 O/a+Q5PMVIlYmGoZ53ma50Z4uNA8Oy/MHj4r2MPZWyLYULbt6qcGD
X-Received: by 2002:adf:f94b:0:b0:367:89fd:1e06 with SMTP id
 ffacd0b85a97d-369bae86ae4mr379249f8f.36.1721458646676; 
 Fri, 19 Jul 2024 23:57:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXFzd6g8EVkwVEJLYWejZnfJQyyfqYp4/eBTiDpX0/kZT5xpYj/P0ubyNVhmglrkLwEVSLXw==
X-Received: by 2002:adf:f94b:0:b0:367:89fd:1e06 with SMTP id
 ffacd0b85a97d-369bae86ae4mr379235f8f.36.1721458646250; 
 Fri, 19 Jul 2024 23:57:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:530f:c053:4ab2:f786?
 ([2a01:e0a:9e2:9000:530f:c053:4ab2:f786])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787ed572sm3259039f8f.110.2024.07.19.23.57.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jul 2024 23:57:25 -0700 (PDT)
Message-ID: <6a46981d-8c36-4a83-b3bb-49f8cc5450c7@redhat.com>
Date: Sat, 20 Jul 2024 08:57:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/vfio/container: Fix SIGSEV on
 vfio_container_instance_finalize()
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, zhenzhong.duan@intel.com,
 alex.williamson@redhat.com
Cc: yanghliu@redhat.com
References: <20240719165011.1751831-1-eric.auger@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240719165011.1751831-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/19/24 18:50, Eric Auger wrote:
> In vfio_connect_container's error path, the base container is
> removed twice form the VFIOAddressSpace QLIST: first on the
> listener_release_exit label and second, on free_container_exit
> label, through object_unref(container), which calls
> vfio_container_instance_finalize().
> 
> Let's remove the first instance.
> 
> Fixes: 938026053f4 ("vfio/container: Switch to QOM")
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Oh. Nice catch !


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/container.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 425db1a14c..d8b7c533af 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -657,7 +657,6 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>       return true;
>   listener_release_exit:
>       QLIST_REMOVE(group, container_next);
> -    QLIST_REMOVE(bcontainer, next);
>       vfio_kvm_device_del_group(group);
>       memory_listener_unregister(&bcontainer->listener);
>       if (vioc->release) {


