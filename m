Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6950FC5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 06:11:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOsBk-0004UO-6B; Tue, 10 Jun 2025 02:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uOsBi-0004Tv-0q
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 02:10:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uOsBg-0008Hw-Dr
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 02:10:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749535818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Kbn+EfrDZJX1Pm+papJea/cZgKonNjU9RC7a8/ncJOo=;
 b=LEhBxyHr7a4fFc/nHxPwRl8SulrWLcTFxLaNdnw6OxHTg/2wZYTnn/jnP5KlcZP5BcU35Z
 inzEqNvJ7HN1d+XUUE8r16FFiuvdBVSp+R5laBrpq78B47A3TMEoHTG0jppbPxXvxSmvPM
 lPkGGORhvt+0hrRDuOqkK2mXYH79VJk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-CgMfEA3HNm6nmtSFxH6U-g-1; Tue, 10 Jun 2025 02:10:16 -0400
X-MC-Unique: CgMfEA3HNm6nmtSFxH6U-g-1
X-Mimecast-MFC-AGG-ID: CgMfEA3HNm6nmtSFxH6U-g_1749535815
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a37a0d1005so3322264f8f.3
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 23:10:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749535815; x=1750140615;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kbn+EfrDZJX1Pm+papJea/cZgKonNjU9RC7a8/ncJOo=;
 b=eKY/FMoUxncews1BJkuJ2c4g4YfSoyvSTn4xrbTGUlmYSRW/KSF7ulEMjL+QdnVi/8
 t8Oxg1s30e0Rk2ruylr/hmiKumgTfIJoRMZnKmWeM/byLLUOOpxq33V6VlWUkM6yat7Z
 ddivJpa2oD12BCeHFaakmaD5Qj7tUTo9cR9n864gPgYQVwGLIYb6o6kl02JJepDW+O/N
 t9bKTxHP/WzwdD13IdVLQfFVheYDY1yIip/nk4llRVXnmY8PrxFN8ArxTsj3gFtCMAwK
 yrOEEoIckaAIrZo/ZzSdJGYXBu6nhs0/C8b7BYCkz9rReLuZu4Lq14pKjF0wq6oDcf2H
 yvzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXhtZuqeoedEw+r1jQovNHLLHCmY2vc9YMH6LLIP0DCyv18+G8gkIxrEOSWiW6OGhTgUI3aUMxzzFF@nongnu.org
X-Gm-Message-State: AOJu0YxHvRbOhbTZRZ8Qa/2lvBYMAC5qAMTr/XBmylZZkWAKlzK7ODgx
 Ezv+DHNAhp1HtlmmOa8XIellTE5ZC5ODw3tgD9KXCfwzDuqrI/H3pFXWP4rMicB2rcVEJjpF458
 a87yRB0E5UhiYsG0AiUn0O7d1vvcEBFa6DrHGgp2j04NQkd98vRihzvNt
X-Gm-Gg: ASbGnctKQxiopMVihyrl2YMzryoxC8RIzOAFHgoObnZWm6eKDm/Iry+LVjt1anHp5Zn
 Ryqj98Bxh/dlwCMEcFYFf5+1i7R52Ze1u1HgTY6FQaGoQtr3JlymrCHXgYlnqvhn46+Ww9SsPaY
 0tKVDeHgMe8qlHfGx03YcaVM3lzG1hVj9fhwEoEsXg2f8kaSJB4v8oIqSfmjg5+b9yneraO7CLH
 O51chX9IT8OgKy/sGERiRbN9KXn1JAZoBJTF11LFaSWw0gQ6QbtXqZ5yz80hPi1KBAwd4LS90XL
 7RnIx0iN6xGG1Khi83X99aV5ytca3p1yIRr3RHQiBRCyPwMagxGESuZKk2AZ
X-Received: by 2002:a05:6000:18a9:b0:3a3:6595:921f with SMTP id
 ffacd0b85a97d-3a531cdd3e7mr10267936f8f.41.1749535815285; 
 Mon, 09 Jun 2025 23:10:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfmAeGutminY/3w+TQ+Ge2FGTSOe6lMgCl8ygSZ9FdxwDA4G3RBIJq9U8F51xv8FkafSlfjw==
X-Received: by 2002:a05:6000:18a9:b0:3a3:6595:921f with SMTP id
 ffacd0b85a97d-3a531cdd3e7mr10267914f8f.41.1749535814882; 
 Mon, 09 Jun 2025 23:10:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53244f4e7sm11272895f8f.77.2025.06.09.23.10.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Jun 2025 23:10:14 -0700 (PDT)
Message-ID: <7137a52d-6920-4d86-ba50-de74493e5e4b@redhat.com>
Date: Tue, 10 Jun 2025 08:10:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 32/43] vfio/iommufd: invariant device name
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
 <1748546679-154091-33-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1748546679-154091-33-git-send-email-steven.sistare@oracle.com>
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

On 5/29/25 21:24, Steve Sistare wrote:
> cpr-transfer will use the device name as a key to find the value
> of the device descriptor in new QEMU.  However, if the descriptor
> number is specified by a command-line fd parameter, then
> vfio_device_get_name creates a name that includes the fd number.
> This causes a chicken-and-egg problem: new QEMU must know the fd
> number to construct a name to find the fd number.
> 
> To fix, create an invariant name based on the id command-line parameter,
> if id is defined.  The user will need to provide such an id to use CPR.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/device.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 9fba2c7..71fa9f4 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -300,12 +300,17 @@ bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
>               error_setg(errp, "Use FD passing only with iommufd backend");
>               return false;
>           }
> -        /*
> -         * Give a name with fd so any function printing out vbasedev->name
> -         * will not break.
> -         */
>           if (!vbasedev->name) {
> -            vbasedev->name = g_strdup_printf("VFIO_FD%d", vbasedev->fd);
> +
> +            if (vbasedev->dev->id) {
> +                vbasedev->name = g_strdup(vbasedev->dev->id);
> +                return true;
> +            } else {
> +                /*
> +                 * Assign a name so any function printing it will not break.
> +                 */
> +                vbasedev->name = g_strdup_printf("VFIO_FD%d", vbasedev->fd);
> +            }
>           }
>       }
>   


