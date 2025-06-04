Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C381FC5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 09:05:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMk3v-0003bW-LK; Wed, 04 Jun 2025 05:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uMk3b-0003Sj-Mh
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 05:05:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uMk3Y-0003tV-Qu
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 05:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749027907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WQjsfbTrufx1syYMmwd3M2v2wMUixYJJWfyFJ5+b/Ak=;
 b=RzYWkFJBzMml9q1aIABd5Rf3ZHiLPZqBXjO4Bxzts57GfcDJjst78ORJ1ClfVNcIaJRhFj
 t9j+f+qS5IAXxoD77QHcNh7oo5tJczeLc993cWkQHJGew11s2wGMBM5sGbWStj3auvcs4J
 oX4E0aD0B5B5aA6dCwYC7ASdeBPMRJE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-7_4i_RPdMjioEV04vrHo5w-1; Wed, 04 Jun 2025 05:05:05 -0400
X-MC-Unique: 7_4i_RPdMjioEV04vrHo5w-1
X-Mimecast-MFC-AGG-ID: 7_4i_RPdMjioEV04vrHo5w_1749027904
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-450cb8ff0c6so31712125e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 02:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749027904; x=1749632704;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=WQjsfbTrufx1syYMmwd3M2v2wMUixYJJWfyFJ5+b/Ak=;
 b=pJpZMXGOnZ8TTon5X6Af2v2TTVITRXAJTC4Pq94Wmg4wxpDuhfPlGETcOhj+5v56Yq
 cYuXJOPGKIZmy59TSX1BvJX0ywUm4dTU/EiNb80oM65+K3YaTQHG4GXLhcHpqVEqmaF0
 7GvkVKblJl61C0IR8UTAS4MseLM9Xgv6waRZzUPzmpijJQzuUb3YfhSHXt45h5Z7mWil
 k1BuS2HrcfTdN8z1YS+jv+g/i0ZO0F9c4am9uLh6yzALuzDamCDoWTqnWBcgccpY46mY
 jUPsHoFh6njN1aQ0XV0QNlmxj1IN8kGEty/Z1byPWk4X1aGcBO+MhZzSTOXHfKWGT7Am
 C/BA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkwuiktWC/uhhbWR1LxTprn6ZkiTuA5rXILm9zKtXXBfMhABDPjvjcA25EqnmZA9GQR9QkSS/VFL8I@nongnu.org
X-Gm-Message-State: AOJu0YwpwmklV/k95/vSOoPfZJ8hWzIXzufVa8RkGxpWPhBm8hS5Lr6R
 hErVuOonorE0QiGWZoxgO0VrGCTzUt1zWsrS+VQ/vCBz/ynPv3luUd/3h1nBJAre/rGb2Hc0Gl+
 QBrzpn7NKyJ6/cX5uensft6iK5aqbbWqYFOUkwCfxEc35emqB5QwmA4Ww
X-Gm-Gg: ASbGncv/X78i+KZzKqxre7Kr1PAmC6/Po8zkr103m7KQO857566U4aA+HgTlrs0JqmN
 Y2OX0+HptSU+d9e3C8t5uY5ZJyozJRYZNSZeGaPgPxJF58IRn6zVSTjuGGZ7txfooT/Z61gDB7z
 f/69ovDu7PfPeZEpPM1rzWXMQlhyRebBbYwuTyHNc20XhafTr1U29iRDXIIrxts2WwRxGvgdmld
 pCXmba/W9oV7r6EF4VY4JokWof3/1Iw1ETn/ZoFv0upUA9VaWAmE0RSRcbXeC6sgRmyoWUHL5JK
 ndl5ZQzB0aEdny6EW1K4AZaoDm1Fenwy300/WiliMgs5vVNu3wtBndX3KGUKSlsCxdsbwAUXR2I
 rWkIB49Z33RSDCW76nSVx/2eDf9a3rq5VFZTb5Gg=
X-Received: by 2002:a05:600c:a14:b0:43d:fa59:be39 with SMTP id
 5b1f17b1804b1-451f0b3d270mr14782235e9.33.1749027904316; 
 Wed, 04 Jun 2025 02:05:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8lXnxCmcdbJcUoWLY4QqZsg6Yqf6hHoKQym01dhxbCW0XrgMiaNmVcxPc62giRIv0eNHodA==
X-Received: by 2002:a05:600c:a14:b0:43d:fa59:be39 with SMTP id
 5b1f17b1804b1-451f0b3d270mr14782025e9.33.1749027903925; 
 Wed, 04 Jun 2025 02:05:03 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1b:b800:6fdb:1af2:4fbd:1fdf?
 (p200300d82f1bb8006fdb1af24fbd1fdf.dip0.t-ipconnect.de.
 [2003:d8:2f1b:b800:6fdb:1af2:4fbd:1fdf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fc28f3sm193547145e9.39.2025.06.04.02.05.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 02:05:03 -0700 (PDT)
Message-ID: <d80f0f29-056a-4828-aec9-dccb7a3e23c6@redhat.com>
Date: Wed, 4 Jun 2025 11:05:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-mem: Fix definition of VirtIOMEMClass
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: chao.p.peng@intel.com, "Michael S. Tsirkin" <mst@redhat.com>
References: <20250604084757.4035354-1-zhenzhong.duan@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250604084757.4035354-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

On 04.06.25 10:47, Zhenzhong Duan wrote:
> Parent of VirtIOMEMClass is VirtioDeviceClass rather than VirtIODevice.
> 
> Fixes: 910b25766b33 ("virtio-mem: Paravirtualized memory hot(un)plug")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/hw/virtio/virtio-mem.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/virtio/virtio-mem.h b/include/hw/virtio/virtio-mem.h
> index bc4f787772..93fdf9e432 100644
> --- a/include/hw/virtio/virtio-mem.h
> +++ b/include/hw/virtio/virtio-mem.h
> @@ -134,7 +134,7 @@ struct VirtioMemSystemReset {
>   
>   struct VirtIOMEMClass {
>       /* private */
> -    VirtIODevice parent;
> +    VirtioDeviceClass parent;

Reviewed-by: David Hildenbrand <david@redhat.com>

I assume it's not currently a real problem because VirtIODevice is 
bigger than VirtioDeviceClass?

Or are you aware of any existing problems with that?

-- 
Cheers,

David / dhildenb


