Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747B9C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 09:20:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA3ax-0006C8-Is; Wed, 30 Apr 2025 05:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uA3at-00069k-PN
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 05:19:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uA3ar-00021K-Ft
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 05:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746004744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jzwE6QCq91tArz4D84Pao3ihQ5y7mMKVo1ptewkYyKc=;
 b=hp8MDlTSqI3sAIRvoDFlp160cJ0U14b1UXFFFAei43dcwlqv53cp4v0kkDeDPGhU9dDV0w
 UZTUgsPXyQxZojN6zyWS7WxTP5I4UomAO8Ssa2mQnIskhR26cprp5buSt3BTKVwJ1tLxG+
 V0O8NzCm+aMyF3cqvqt+Mx1j5+So9pc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-TpG7hx0hN9qvaqeVXm8J7A-1; Wed, 30 Apr 2025 05:19:00 -0400
X-MC-Unique: TpG7hx0hN9qvaqeVXm8J7A-1
X-Mimecast-MFC-AGG-ID: TpG7hx0hN9qvaqeVXm8J7A_1746004739
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d0a037f97so36434545e9.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 02:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746004739; x=1746609539;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jzwE6QCq91tArz4D84Pao3ihQ5y7mMKVo1ptewkYyKc=;
 b=qBbw5OD+xGqFAkGD5SWbUPBRFKsX/GguaY1krFLtpmCQWSwqHmSTcGOldjQD6dt/oF
 a6rsEsfbntjTzfOK8XE2kcWdBZlTHtsvJ+Ep5fK69TGQ+kzpW/+4MnwnM2msn94yXQv1
 IBKlCdq7wUY6OBCGyqlVnz8viH087WID3tas3J3e4q7nEWXsaI9V0G5lsB14el9LI24e
 8fTgznEqQ88KvNHgLIN89wHdDp47O0V/oIrDM5qGBnuCVQ2MqOlHoPhpo+ImCuvwtted
 MEACD+OmyV/DurYzwcyDgupJrPv4DBsByeJ8kRd5MOTu0NeLj+IcPJWIoD1pxEABsB7B
 GEBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrkh6svPiCdVvNaxDLJBTBXbs+ZPoc3UXvSqLpOLjttSnw01NRzFjdjPTDDmi2gCzr3XsB9y5lldtG@nongnu.org
X-Gm-Message-State: AOJu0YyHIXTSbqOuDk+IjdxdFtqK52IgtUwjd0heXDGAo/4y9U7uLHq/
 4WlpWj0LXeCPQ/6tyiRLgakgxB3wzaTMyBX6hkliMPuqpafW6QNUbjr7ZrZB2j4TxibBeYeDHA1
 qQyl7ZlltLDtoW0Iqsct9+8Zs5s48KqTYiK7SHrb2ykPlnAuVPqDj
X-Gm-Gg: ASbGnctUYcJty62/v3F5AsG8vQa3Slf28Wfz/722DmMw1cqlvg+EiPljbDa1KkzC4lg
 p4WYbeI2zOD67zM3Cr2xrlxKNLlqpiFkQNm1WGFpi4I3V1+ngsm8m0zY0RfJcNzKPJq3VKdRL4p
 x5J8SL+1N+KhZ9giLUTRNgdzoGT0ft3WkJ+s+X6SK1MYMTNbnZGusXs/cPyZCAip2sJJMDXdrGM
 wULHv6juoIkFnZS2iGUaiRusdyi4XyjAm2vlPKvmlVYaD/lURIbKvhwr+wIhg6rsq7HIfhP80Ch
 gKFndw6SLJn4lTQEcWp+1PkhD17NhDkMrI1aMnNQ/MIEk8VRADI=
X-Received: by 2002:a05:6000:40dd:b0:390:df75:ddc4 with SMTP id
 ffacd0b85a97d-3a08ff50ae7mr1245303f8f.44.1746004739459; 
 Wed, 30 Apr 2025 02:18:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvaVvKpyGT3HHGFb7GzEO6hjGXQIkZOJvBvoIatA+/SaNGiOt7EgC1KawguG20UH4MdWd1vQ==
X-Received: by 2002:a05:6000:40dd:b0:390:df75:ddc4 with SMTP id
 ffacd0b85a97d-3a08ff50ae7mr1245289f8f.44.1746004739153; 
 Wed, 30 Apr 2025 02:18:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e10:ef90:343a:68f:2e91:95c?
 ([2a01:e0a:e10:ef90:343a:68f:2e91:95c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca4cbcsm16184688f8f.25.2025.04.30.02.18.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 02:18:58 -0700 (PDT)
Message-ID: <33cf1878-643e-4eb4-9a4c-9ae90abba0f2@redhat.com>
Date: Wed, 30 Apr 2025 11:18:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Running with `--enable-ubsan` leads to a qtest failure:
To: Nabih Estefan <nabihestefan@google.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, farosas@suse.de, sriram.yagnaraman@ericsson.com,
 akihiko.odaki@daynix.com, QEMU Trivial <qemu-trivial@nongnu.org>
References: <20250429155621.2028198-1-nabihestefan@google.com>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 xsFNBFYFJhkBEAC2me7w2+RizYOKZM+vZCx69GTewOwqzHrrHSG07MUAxJ6AY29/+HYf6EY2
 WoeuLWDmXE7A3oJoIsRecD6BXHTb0OYS20lS608anr3B0xn5g0BX7es9Mw+hV/pL+63EOCVm
 SUVTEQwbGQN62guOKnJJJfphbbv82glIC/Ei4Ky8BwZkUuXd7d5NFJKC9/GDrbWdj75cDNQx
 UZ9XXbXEKY9MHX83Uy7JFoiFDMOVHn55HnncflUncO0zDzY7CxFeQFwYRbsCXOUL9yBtqLer
 Ky8/yjBskIlNrp0uQSt9LMoMsdSjYLYhvk1StsNPg74+s4u0Q6z45+l8RAsgLw5OLtTa+ePM
 JyS7OIGNYxAX6eZk1+91a6tnqfyPcMbduxyBaYXn94HUG162BeuyBkbNoIDkB7pCByed1A7q
 q9/FbuTDwgVGVLYthYSfTtN0Y60OgNkWCMtFwKxRaXt1WFA5ceqinN/XkgA+vf2Ch72zBkJL
 RBIhfOPFv5f2Hkkj0MvsUXpOWaOjatiu0fpPo6Hw14UEpywke1zN4NKubApQOlNKZZC4hu6/
 8pv2t4HRi7s0K88jQYBRPObjrN5+owtI51xMaYzvPitHQ2053LmgsOdN9EKOqZeHAYG2SmRW
 LOxYWKX14YkZI5j/TXfKlTpwSMvXho+efN4kgFvFmP6WT+tPnwARAQABzSNMYXVyZW50IFZp
 dmllciA8bHZpdmllckByZWRoYXQuY29tPsLBeAQTAQIAIgUCVgVQgAIbAwYLCQgHAwIGFQgC
 CQoLBBYCAwECHgECF4AACgkQ8ww4vT8vvjwpgg//fSGy0Rs/t8cPFuzoY1cex4limJQfReLr
 SJXCANg9NOWy/bFK5wunj+h/RCFxIFhZcyXveurkBwYikDPUrBoBRoOJY/BHK0iZo7/WQkur
 6H5losVZtrotmKOGnP/lJYZ3H6OWvXzdz8LL5hb3TvGOP68K8Bn8UsIaZJoeiKhaNR0sOJyI
 YYbgFQPWMHfVwHD/U+/gqRhD7apVysxv5by/pKDln1I5v0cRRH6hd8M8oXgKhF2+rAOL7gvh
 jEHSSWKUlMjC7YwwjSZmUkL+TQyE18e2XBk85X8Da3FznrLiHZFHQ/NzETYxRjnOzD7/kOVy
 gKD/o7asyWQVU65mh/ECrtjfhtCBSYmIIVkopoLaVJ/kEbVJQegT2P6NgERC/31kmTF69vn8
 uQyW11Hk8tyubicByL3/XVBrq4jZdJW3cePNJbTNaT0d/bjMg5zCWHbMErUib2Nellnbg6bc
 2HLDe0NLVPuRZhHUHM9hO/JNnHfvgiRQDh6loNOUnm9Iw2YiVgZNnT4soUehMZ7au8PwSl4I
 KYE4ulJ8RRiydN7fES3IZWmOPlyskp1QMQBD/w16o+lEtY6HSFEzsK3o0vuBRBVp2WKnssVH
 qeeV01ZHw0bvWKjxVNOksP98eJfWLfV9l9e7s6TaAeySKRRubtJ+21PRuYAxKsaueBfUE7ZT
 7zfOwU0EVgUmGQEQALxSQRbl/QOnmssVDxWhHM5TGxl7oLNJms2zmBpcmlrIsn8nNz0rRyxT
 460k2niaTwowSRK8KWVDeAW6ZAaWiYjLlTunoKwvF8vP3JyWpBz0diTxL5o+xpvy/Q6YU3BN
 efdq8Vy3rFsxgW7mMSrI/CxJ667y8ot5DVugeS2NyHfmZlPGE0Nsy7hlebS4liisXOrN3jFz
 asKyUws3VXek4V65lHwB23BVzsnFMn/bw/rPliqXGcwl8CoJu8dSyrCcd1Ibs0/Inq9S9+t0
 VmWiQWfQkz4rvEeTQkp/VfgZ6z98JRW7S6l6eophoWs0/ZyRfOm+QVSqRfFZdxdP2PlGeIFM
 C3fXJgygXJkFPyWkVElr76JTbtSHsGWbt6xUlYHKXWo+xf9WgtLeby3cfSkEchACrxDrQpj+
 Jt/JFP+q997dybkyZ5IoHWuPkn7uZGBrKIHmBunTco1+cKSuRiSCYpBIXZMHCzPgVDjk4viP
 brV9NwRkmaOxVvye0vctJeWvJ6KA7NoAURplIGCqkCRwg0MmLrfoZnK/gRqVJ/f6adhU1oo6
 z4p2/z3PemA0C0ANatgHgBb90cd16AUxpdEQmOCmdNnNJF/3Zt3inzF+NFzHoM5Vwq6rc1JP
 jfC3oqRLJzqAEHBDjQFlqNR3IFCIAo4SYQRBdAHBCzkM4rWyRhuVABEBAAHCwV8EGAECAAkF
 AlYFJhkCGwwACgkQ8ww4vT8vvjwg9w//VQrcnVg3TsjEybxDEUBm8dBmnKqcnTBFmxN5FFtI
 WlEuY8+YMiWRykd8Ln9RJ/98/ghABHz9TN8TRo2b6WimV64FmlVn17Ri6FgFU3xNt9TTEChq
 AcNg88eYryKsYpFwegGpwUlaUaaGh1m9OrTzcQy+klVfZWaVJ9Nw0keoGRGb8j4XjVpL8+2x
 OhXKrM1fzzb8JtAuSbuzZSQPDwQEI5CKKxp7zf76J21YeRrEW4WDznPyVcDTa+tz++q2S/Bp
 P4W98bXCBIuQgs2m+OflERv5c3Ojldp04/S4NEjXEYRWdiCxN7ca5iPml5gLtuvhJMSy36gl
 U6IW9kn30IWuSoBpTkgV7rLUEhh9Ms82VWW/h2TxL8enfx40PrfbDtWwqRID3WY8jLrjKfTd
 R3LW8BnUDNkG+c4FzvvGUs8AvuqxxyHbXAfDx9o/jXfPHVRmJVhSmd+hC3mcQ+4iX5bBPBPM
 oDqSoLt5w9GoQQ6gDVP2ZjTWqwSRMLzNr37rJjZ1pt0DCMMTbiYIUcrhX8eveCJtY7NGWNyx
 FCRkhxRuGcpwPmRVDwOl39MB3iTsRighiMnijkbLXiKoJ5CDVvX5yicNqYJPKh5MFXN1bvsB
 kmYiStMRbrD0HoY1kx5/VozBtc70OU0EB8Wrv9hZD+Ofp0T3KOr1RUHvCZoLURfFhSQ=
In-Reply-To: <20250429155621.2028198-1-nabihestefan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

CC Trivial

On 29/04/2025 17:56, Nabih Estefan wrote:
> v2: used ldl_le_p and lduw_l_p instead of memcpy as per upstream
> suggestion.
> 
> ```
> ../tests/qtest/libqos/igb.c:106:5: runtime error: load of misaligned address 0x562040be8e33 for type 'uint32_t', which requires 4 byte alignment
> ```
> Instead of straight casting the uint8_t array, we use memcpy to assure
> alignment is correct against uint32_t and uint16_t.
> 
> Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> ---
>   tests/qtest/libqos/igb.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qtest/libqos/igb.c b/tests/qtest/libqos/igb.c
> index f40c4ec4cd..2e0bb58617 100644
> --- a/tests/qtest/libqos/igb.c
> +++ b/tests/qtest/libqos/igb.c
> @@ -104,10 +104,10 @@ static void igb_pci_start_hw(QOSGraphObject *obj)
>       e1000e_macreg_write(&d->e1000e, E1000_RDT(0), 0);
>       e1000e_macreg_write(&d->e1000e, E1000_RDH(0), 0);
>       e1000e_macreg_write(&d->e1000e, E1000_RA,
> -                        le32_to_cpu(*(uint32_t *)address));
> +                        ldl_le_p((uint32_t *)address));
>       e1000e_macreg_write(&d->e1000e, E1000_RA + 4,
>                           E1000_RAH_AV | E1000_RAH_POOL_1 |
> -                        le16_to_cpu(*(uint16_t *)(address + 4)));
> +                        lduw_le_p((uint16_t *)(address + 4)));
>   
>       /* Set supported receive descriptor mode */
>       e1000e_macreg_write(&d->e1000e,

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Tested-by: Laurent Vivier <lvivier@redhat.com>


