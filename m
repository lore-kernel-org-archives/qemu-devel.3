Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B478C77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 09:56:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU0NY-0008Fj-5q; Tue, 24 Jun 2025 05:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uU0NV-0008ET-Q8
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 05:55:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uU0NT-00048M-OJ
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 05:55:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750758942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Tyq0vQiPhFKssc6Iyf+H9dyoBOJhIGExX+lOQ2aEmek=;
 b=RaHKk+XbsBbjWweaegmYLfzjwggGH6DenUy6ia9z1K/5vTW8jkTOJr7LCs7GXqmIsiZuNK
 hZw6aUrx0YhLA46OWnS0BMENvO9QwpKWtlqvLrkxTG25gok11O+2Mn+9v8EZDdauwnuTJ1
 NDivyZFZaCPz6iO+l1B/gTHLZZ+aaIQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-X6ypdTPAN92HeEZL42RMhQ-1; Tue, 24 Jun 2025 05:55:40 -0400
X-MC-Unique: X6ypdTPAN92HeEZL42RMhQ-1
X-Mimecast-MFC-AGG-ID: X6ypdTPAN92HeEZL42RMhQ_1750758939
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45311704d22so33531755e9.2
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 02:55:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750758939; x=1751363739;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tyq0vQiPhFKssc6Iyf+H9dyoBOJhIGExX+lOQ2aEmek=;
 b=FeGN53nv3GMc4yoDT8aEFQjjNztSfM6yfe8Xd5z1WTQLEQAJb7rXZ0HISumEhEdE+4
 ZHZcnyqIlTVAnXD7ZI+r5sfylROANMDUQyTx1WeouFSfyRmRDzo0NQdvP1GyFf/JpSv3
 20qv9oortL0PGGQOeKmJYeBj+o915e7FzdEz8oPFNN16f9DqUakMmZ9dnikMCbY+PgKL
 8LxjI4IS3HWA01z1B7uMWw04YHQZcDMtYNxIQfiZvvkIO+o7ZVcDXl2goUH4ubV1ulVG
 VXLjfKS2dcK9TPQLXcY2g9BA47vK3LJVS3iCI1FbWsx2moygQ8bAS+CkiGSqf0X0Jexx
 cdgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1LA669KeR4EIkhJaljJWwZpQ4A7F4Vp6JGKIF7V5pcrwhORRIKNGYW5oL/Dxo4mDg9X8MhUXHa88T@nongnu.org
X-Gm-Message-State: AOJu0YyhHBo5V0KSfy+kIMn4a6+CGpuFzWBGG8CrAamlxYWTLG3JvGAS
 obgsuBx4omMhBB2cRuCqanWxoCmvV920SzJ+ZlRvh/jWTsyj/LWicJ5U7BxBLeTL8jijLFvAziy
 kgl3qKMhrMiWmYuUDCbiX4FFToyxZFwN5aDzzpISgK9mgpBs6VPL/vzf8
X-Gm-Gg: ASbGncuA736C6/ZlLJBlZy8Gxsmf8sAISg5B3kltgIt6lLj2wuNGII49t9PO/bLLUTR
 4wtNw9q8aWeVrj5LXa6oHhj7XM6bSonS9KlgXhiyb0l/SHbW9uqvDJn5BiDDJeiiJ35JssdRLMi
 gnHXCYjMF43ILsjW5QVZ1ull/e8hbTr6P47btvhT7AqfGTjpVkwhYwIj9dJKSVLAJEge4B8m9GE
 v9pnSVcsPRl3q/giqXXBpbgn/k5WTI4ps/WIWxnPEdlBtSyIKmnk2X1xS+ETLbXpEJs8rD267QU
 OFsj9pD2b2djMCGYoiYnExmc8QAChRmXEqQiu2LVLQVMLtLYcI0zDmtECP1Y
X-Received: by 2002:a05:600c:8b70:b0:445:1984:247d with SMTP id
 5b1f17b1804b1-453653aa3afmr139666955e9.7.1750758939266; 
 Tue, 24 Jun 2025 02:55:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWM6YF6UblF1sg0x6oRE2gZ26aOwjGPJzlWAZgCiQCj6D1Gbekt5F/YqfmlEp/ARGF+di1dQ==
X-Received: by 2002:a05:600c:8b70:b0:445:1984:247d with SMTP id
 5b1f17b1804b1-453653aa3afmr139666655e9.7.1750758938840; 
 Tue, 24 Jun 2025 02:55:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453632312a3sm146903905e9.1.2025.06.24.02.55.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jun 2025 02:55:38 -0700 (PDT)
Message-ID: <cb3ab990-9e19-45b5-be37-4add96cec010@redhat.com>
Date: Tue, 24 Jun 2025 11:55:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] vfio/container: Fix SIGSEGV when open container file
 fails
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com,
 steven.sistare@oracle.com, chao.p.peng@intel.com
References: <20250623102235.94877-1-zhenzhong.duan@intel.com>
 <20250623102235.94877-2-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250623102235.94877-2-zhenzhong.duan@intel.com>
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

On 6/23/25 12:22, Zhenzhong Duan wrote:
> When open /dev/vfio/vfio fails, SIGSEGV triggers because
> vfio_listener_unregister() doesn't support a NULL bcontainer
> pointer.
> 
> Fixes: a1f267a7d4d9 ("vfio/container: reform vfio_container_connect cleanup")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/vfio/container.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 3e8d645ebb..2853f6f08b 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -710,7 +710,9 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
>       return true;
>   
>   fail:
> -    vfio_listener_unregister(bcontainer);
> +    if (new_container) {
> +        vfio_listener_unregister(bcontainer);
> +    }
>   
>       if (group_was_added) {
>           vfio_container_group_del(container, group);



Applied to vfio-next.

Thanks,

C.



