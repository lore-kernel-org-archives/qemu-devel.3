Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50337C3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 11:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWZp6-0007Di-Lu; Wed, 24 Jul 2024 07:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1sWZp3-0007Cz-8k
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 07:06:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1sWZp0-0001lf-Ti
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 07:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721819172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=s4Stb9cjeXTSuZ5tugEJ6MgG93NPllCRSWCghmc9N+E=;
 b=RszUuLjVdAvKBQ2dXOTqkNtkuD7nWXdEWJ1VNfvBVeHrwIzI3aPcWW4hTySCOsbZjqu88l
 UFXhN6m1Y+h1mRlvKbj2lRNPBJY/nm/UzUncdIc42h31zAZkvOfwVbaRHmGjwN6Xw6oSVL
 srG8CvUoWb9s2Vlvst3EpWuB5VJ07DU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-rGsQ0Zv6OPeAWhyjuTmfVA-1; Wed, 24 Jul 2024 07:06:11 -0400
X-MC-Unique: rGsQ0Zv6OPeAWhyjuTmfVA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-427a7a65e7dso3516845e9.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 04:06:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721819170; x=1722423970;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s4Stb9cjeXTSuZ5tugEJ6MgG93NPllCRSWCghmc9N+E=;
 b=oHWiTcQSjcv5lAM9ZsV03F9JLysdyZc5O19bXYvsmxvLmTluWIwkkBMjQOVvbjYUnz
 U0mwwhkIxnFLuYZBUj/YAf9ro/YN9uwOIvqBZvCXDUSGqIvGXIW83Gj5D+tOBHoaHsZn
 tJmLt2lK2inNljyaBUsrK7kitHJpFiXxBTkLQhs0JtA/YsePIeTRmoTl6lbLOmk7TIoO
 zn+yfZwpYjhwKLX6DFyOTCYZJAdiT1Y0RNV37xGw7shr7JjpMyeAFyGhtvhmeWMIBfg8
 GSMaN9Ub97ayfh9hnqyqqDihCJx67kPPJNnrINooRaJ6/jUa5PeynJXVioI7Fa/ONGGE
 RZjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXXYqY8KFIkBAOZXIGYWUbEH5gTDozGUVbdqFXoWBNHlPvKs3Q3M0hs3/brk02SgTH2uLXJRHzB6tMrKRkTDiI8g/leaQ=
X-Gm-Message-State: AOJu0Yz+OITa+9mpcPKNFTsZs9PFxzqp3AdJqD6WFxYutLu01qnksKTP
 +BgoqEGFfiUc3R9reSwmQm3ziwIG7YUQ0Ki9rTvSocJhuZkib4N+0sx37pEVvRs1YbDhSwuieNN
 sZKr1mWH8kKoQL37/hS+inCBO7+koyhWiDlLq9PLYeeAmw9V0btTb
X-Received: by 2002:a05:600c:2145:b0:426:5c36:f57a with SMTP id
 5b1f17b1804b1-427f9a13d9cmr11744085e9.14.1721819169819; 
 Wed, 24 Jul 2024 04:06:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4W9MkkhzdnS/MDdQ6lwPVlAp4OsVjl8jfaBPdI1emIElTvuyAz4M+d/NJWE/B5yXYNIEg6A==
X-Received: by 2002:a05:600c:2145:b0:426:5c36:f57a with SMTP id
 5b1f17b1804b1-427f9a13d9cmr11743845e9.14.1721819169343; 
 Wed, 24 Jul 2024 04:06:09 -0700 (PDT)
Received: from ?IPV6:2a0d:e487:47f:eccc:619a:2699:ab1d:c0fe?
 ([2a0d:e487:47f:eccc:619a:2699:ab1d:c0fe])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f937353dsm24844215e9.17.2024.07.24.04.06.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jul 2024 04:06:09 -0700 (PDT)
Message-ID: <2a5dfe68-fb1f-4977-b1ec-4d41cbe1a9ff@redhat.com>
Date: Wed, 24 Jul 2024 13:06:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-rng: block max-bytes=0
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Amit Shah <amit@kernel.org>
References: <73a89a42d82ec8b47358f25119b87063e4a6ea57.1721818306.git.mst@redhat.com>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <73a89a42d82ec8b47358f25119b87063e4a6ea57.1721818306.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 24/07/2024 12:51, Michael S. Tsirkin wrote:
> with max-bytes set to 0, quota is 0 and so device does not work.
> block this to avoid user confusion
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   hw/virtio/virtio-rng.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
> index f74efffef7..7cf31da071 100644
> --- a/hw/virtio/virtio-rng.c
> +++ b/hw/virtio/virtio-rng.c
> @@ -184,8 +184,9 @@ static void virtio_rng_device_realize(DeviceState *dev, Error **errp)
>   
>       /* Workaround: Property parsing does not enforce unsigned integers,
>        * So this is a hack to reject such numbers. */
> -    if (vrng->conf.max_bytes > INT64_MAX) {
> -        error_setg(errp, "'max-bytes' parameter must be non-negative, "
> +    if (vrng->conf.max_bytes == 0 ||
> +        vrng->conf.max_bytes > INT64_MAX) {
> +        error_setg(errp, "'max-bytes' parameter must be positive, "
>                      "and less than 2^63");
>           return;
>       }

Reviewed-by: Laurent Vivier <lvivier@redhat.com>


