Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABBD2C7EE2A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 08:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTzP5-0001Br-7W; Tue, 24 Jun 2025 04:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uTzP0-0001Ba-KM
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 04:53:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uTzOy-0002Lh-Tf
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 04:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750755189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uilP0wP9PORR7DwoaoAuSI3rrkKEiah92kF3JgsON8Y=;
 b=gnoeppvH2Rsjl5UqDNKGW60SclCJpR53Py01+b0XhtRDchtaNUt/s4OzVQDuC9T1+h4JMc
 sqMlAtGPymEeFxm3SF7/Xqou3HvlMusiKKpNYwnZgyjaETx3DfAkhIgYbmzPlscBDDNF4B
 gAA6V4FTgnBloGTCkCqnKGuYaUmVXWw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-EG6dGUJ5O_ys0Bw-2wAUgQ-1; Tue, 24 Jun 2025 04:53:07 -0400
X-MC-Unique: EG6dGUJ5O_ys0Bw-2wAUgQ-1
X-Mimecast-MFC-AGG-ID: EG6dGUJ5O_ys0Bw-2wAUgQ_1750755185
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4535ad64d30so40982995e9.3
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 01:53:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750755185; x=1751359985;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uilP0wP9PORR7DwoaoAuSI3rrkKEiah92kF3JgsON8Y=;
 b=jAPS5F8nZNRiDx+QsAyfhayg7FioA4j6Xn9Q6mbHb9+EIC+nKyBItqSNbSjO/2T9Yk
 ppZQ52vP4v29DEKIgJYAvLNdjPJHKWY2oXCSNo+YQK4GLQzEcUt2C+fUG/qlbUXeGt+D
 ZVx98oXb5uEsA2E1h9oRrKF8ueuLpGFQscUr3fDHBOURRdLbERtcFr+z+esa7fk99sAd
 nk6atd+QImF+hR8gxZD8yXRR5WWb5hd0a9rRSYZ9th5TgS0f8LRCWYT1kAfLNXWOgIP8
 wdOyxoVJC8ZVx545Cjmbtd4OZZ1uERSlmIUnQI2oOERNmiaY22Sh3GsfF827RIHE5a2b
 pEsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLq4CAidubhm/ohLYG0Dwh4CscbOOfUQE7wCtGgPxcTaby7QlkJZKf5EbBirlE8fvtX4KuQZo0GHaN@nongnu.org
X-Gm-Message-State: AOJu0Yz64IYBcnuyYFbPclvQqDw6112SC5Aa5raMyqHH324uN+P/Uv00
 jRcNKlQvn46eGDF+D3LS0FZ5q77FAYcM9ZIbZZ/gXqb9w1JpywLPo1Q2VL7/infpU7mwsRKnZ0M
 iOi6zcxw92U0Ia9X48s1bf4tN6hTFdYLt5XFkAX1tc/579DOWcamVHkv1yrVATxfL
X-Gm-Gg: ASbGncskgheeGTzzIM3y1Nx5xEWWUdRJztqHGzOOq0mNoc1jVhPkd/U3KibZlw98OWy
 f64e/Wf/NNhS8FUwURL5ywvz2+8QOMy/MlsCcW0GyGnkRPxg4Q6w5KT1QdgZ1NF0nNYVE6ageb2
 1DU/vS1itM+Sypw3FpYXDCHnIVFaa2M3ALlv+pbtKI9xDBjtwqbHbGvPWLv9RFdvQ5SJIvOG34s
 MTiwinnHFAkW6R7eYHEURD5jaCNnwnvK7l9t6H+CeNyVL4Pas9zjH86eRHa0eY5BnIt0tuLkQ6r
 HMTUMmUdLjsJpTEuCHKDPcirxcHoixGbjFxS4fXtkZ+91mRIRj4RMC/Ax5mf
X-Received: by 2002:a05:600c:630c:b0:450:d104:29eb with SMTP id
 5b1f17b1804b1-453656c2163mr141595705e9.5.1750755185087; 
 Tue, 24 Jun 2025 01:53:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzWTQTSftjAPxmMkDsdpIgqQHqxCtLGXd9TMH5EQKGHAUDUgkRjrvg8iGaV16cgOnAOn8eIQ==
X-Received: by 2002:a05:600c:630c:b0:450:d104:29eb with SMTP id
 5b1f17b1804b1-453656c2163mr141595385e9.5.1750755184601; 
 Tue, 24 Jun 2025 01:53:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535e97a795sm170933735e9.5.2025.06.24.01.53.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jun 2025 01:53:04 -0700 (PDT)
Message-ID: <27bb353a-8e3e-4795-96f0-0b4a1134b15a@redhat.com>
Date: Tue, 24 Jun 2025 10:53:03 +0200
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
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


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


