Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 953C9C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 07:06:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu4Yb-00031B-IS; Mon, 17 Mar 2025 03:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tu4YU-0002pM-9E
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 03:06:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tu4YR-0002V1-K6
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 03:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742195187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xx0CwcbMZhMUr5qDlX0twpMxptVYHrfNI6BB+Mujk2E=;
 b=RROdV6O2vrKTvlDP20FHzZzH0ToXS4AZSu1ize6vF3QlVO1dcNm6FrUrle45liN3zbnxRk
 D0F+RP6+H5qnvCculm/MTWyPF7UApWjlsXsaehh5GiUm1kJomJcRZP1PXkcA6id4i957LS
 I+4RR1pgvMqVQ2VeFd3SD3tFluyUPGw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-GC8vVe3INAeL7s7w14TsJw-1; Mon, 17 Mar 2025 03:06:26 -0400
X-MC-Unique: GC8vVe3INAeL7s7w14TsJw-1
X-Mimecast-MFC-AGG-ID: GC8vVe3INAeL7s7w14TsJw_1742195185
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43ceed237efso13719465e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 00:06:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742195184; x=1742799984;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xx0CwcbMZhMUr5qDlX0twpMxptVYHrfNI6BB+Mujk2E=;
 b=foI7vhwlQyZhrq3Z3lD1r99WXHamIvdeHVwSG0piBwRQp3UhWvbQMVZV6iBjqReRoQ
 UWVDSUA8Y4ZDe/KCKZHcx5olYYds7LxisspGF1a7o3VUwk+MkhSdDmLr9c3V5yO+8GyY
 2bUgdpXGGz8g3dZOT6jBKMIaEf08AHWJdyAM9GoZFrkyhQOyKNjkisPDG//09nvZXzrq
 rH7MfX+o1MhGey4hHrtqmte6IyurqhtgzjyLYzRUrNyiunFPkp2i8OLIcfoDF01aKAvN
 hNS44snHAEMeq37sAvjhSwyU3AI8dkn8pkcgsctxaB8ObfwU3ZmTFZ8eq/OZLvvQz+gf
 MlJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8A30QXyy7C7MSa2b+EI9tr7lFgkw0MzIx4LyTq43EuIzP7b71EtVlzOt7SGzufxJA/Dra2MaiKLke@nongnu.org
X-Gm-Message-State: AOJu0YwQM+599AXkAo5BDnhJIYp8UdP3ajMIGCZ+blaIZRc8pgw+Od/b
 SeTQ9+6SvCLPkgv8GVCxguxhkATJhgAFSKHK2fydiRp1zsQF0+KhF+THNnePJ5v0RYP6CaatfEC
 Ep4FGc+2LPyN/riy+CFM90ZvGs8DDmt+MPuSY/vRwnKt5JPqtAJ2DOiNIbCoz+CA=
X-Gm-Gg: ASbGnctlJFNMsdUr4kZQIG+hOc5ZcoX3YDFuxZyHUqTf5mIvKXtORkFB2nroo8Tzer1
 H7tXUAzq6Pbz0RQP6dzZbOec5XzScBQiFAvPYRaHlI8n9tSoxCBSAzNh6xge+ypsvLXcnkL4o6K
 ADf8DJf4I7IOTCC7UgLBotawCvbjtOpHPwsREALg4HFJgrMDAfd3tJgpdK1xlOv5ELlWQTdwyPP
 HK5Lo1ZRu9YzHrWZcOneOW4tbe48yisWENTZ2DPv+W2cAzOgeKKdrZZK4OvcO/c5FVpXJ74gbqg
 K3v+7+Qe1rIthZXa82aU74cxmkHzUZitom/38ZdqCHjKVqLQqxZclQ==
X-Received: by 2002:a05:6000:2c7:b0:391:30b9:556a with SMTP id
 ffacd0b85a97d-3971cd57406mr12016338f8f.7.1742195184479; 
 Mon, 17 Mar 2025 00:06:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcESucZhLUgVhK1O27Fvigw9y+J5ZAcsJvb6TGT34rHuq77pdetq28a/iwF7gvkyWKyTmmgA==
X-Received: by 2002:a05:6000:2c7:b0:391:30b9:556a with SMTP id
 ffacd0b85a97d-3971cd57406mr12016315f8f.7.1742195184077; 
 Mon, 17 Mar 2025 00:06:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c7df3512sm14561047f8f.12.2025.03.17.00.06.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 00:06:23 -0700 (PDT)
Message-ID: <30852eb7-ef37-4da1-b014-ad4131d74c29@redhat.com>
Date: Mon, 17 Mar 2025 08:06:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/amigaone: Check blk_pwrite return value
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>
References: <20250314200140.2DBE74E6069@zero.eik.bme.hu>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250314200140.2DBE74E6069@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.333,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 3/14/25 21:01, BALATON Zoltan wrote:
> Coverity reported that return value of blk_pwrite() maybe should not
> be ignored. We can't do much if this happens other than report an
> error but let's do that to silence this report.
> 
> Resolves: Coverity CID 1593725
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/ppc/amigaone.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
> index 483512125f..5d787c3059 100644
> --- a/hw/ppc/amigaone.c
> +++ b/hw/ppc/amigaone.c
> @@ -108,8 +108,8 @@ static void nvram_write(void *opaque, hwaddr addr, uint64_t val,
>       uint8_t *p = memory_region_get_ram_ptr(&s->mr);

why is the nvram never read ?

>   
>       p[addr] = val;
> -    if (s->blk) {
> -        blk_pwrite(s->blk, addr, 1, &val, 0);
> +    if (s->blk && blk_pwrite(s->blk, addr, 1, &val, 0) < 0) {
> +        error_report("%s: could not write %s", __func__, blk_name(s->blk));

hmm, guest_error maybe ? since this is a runtime error.

>       }
>   }
>   
> @@ -151,15 +151,17 @@ static void nvram_realize(DeviceState *dev, Error **errp)
>           *c = cpu_to_be32(CRC32_DEFAULT_ENV);
>           /* Also copies terminating \0 as env is terminated by \0\0 */
>           memcpy(p + 4, default_env, sizeof(default_env));
> -        if (s->blk) {
> -            blk_pwrite(s->blk, 0, sizeof(crc) + sizeof(default_env), p, 0);
> +        if (s->blk &&
> +            blk_pwrite(s->blk, 0, sizeof(crc) + sizeof(default_env), p, 0) < 0
> +           ) {
> +            error_report("%s: could not write %s", __func__, blk_name(s->blk));

This should use the errp parameter.

>           }
>           return;
>       }
>       if (*c == 0) {
>           *c = cpu_to_be32(crc32(0, p + 4, NVRAM_SIZE - 4));
> -        if (s->blk) {
> -            blk_pwrite(s->blk, 0, 4, p, 0);
> +        if (s->blk && blk_pwrite(s->blk, 0, 4, p, 0) < 0) {
> +            error_report("%s: could not write %s", __func__, blk_name(s->blk));

same here.

Thanks,

C.



>           }
>       }
>       if (be32_to_cpu(*c) != crc) {


