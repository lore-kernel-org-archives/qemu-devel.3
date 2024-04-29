Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3251CC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 14:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1S7v-00071U-3T; Mon, 29 Apr 2024 10:37:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1S7t-00070j-Fo
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 10:37:05 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1S7q-0004oZ-HB
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 10:37:05 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5709cb80b03so4564404a12.2
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 07:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714401420; x=1715006220; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ES2PvFD4VSSRvipp+Prc0bQhFZNh16A04qRuCZEs8wM=;
 b=bX1UbWGNF3Eoem1BlTWf5X4G9aDcGtkE2OoE84TYmLcPYjmMKMazqQFIts0ZVAW07B
 SBELl1So1SLSE48JvXxqDUlk2i3iCLi5RvEpE6aSorsky2poOeHPn5VUIBG+dG99aJd4
 8Ef4/jX3KW4khh2Rkqbp6GO7qEraSYBmyAHDvLgihTW9k1YFtycLxkdJtt27hOqU5NDH
 8ZDh+Nt3gdhDKlNEQ8i0imRI8CNZ2w++APTXNZq/6fC4U694ECIibMePHvMiUlO1KV/L
 2xbLDcgdvp8w7/rftm8bEl62r2ib3u/yaERsjWtXQu0Yy6+4GTN10YqlFN8VZdYWDK9f
 kwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714401420; x=1715006220;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ES2PvFD4VSSRvipp+Prc0bQhFZNh16A04qRuCZEs8wM=;
 b=K3yV7/FswL68oHzjeIxduLWZtS5zfrnlr0oSFObX3933pSBnsJLRBmY7hbS7wnmMsv
 s08w8VuJ5/P0LB1vU5l4B7lCj5zorJcS/vfM2r8qb1GOKFCRmOApeN9QiR5ZstWtZXly
 pBHfGRYUZAgfdOwHr0hBgm/eODMOwJ65/rI5nbRJ5rGpaCImwbg252DUeJrP4Sh8FPUk
 WLMQiC0VDM0M22QeEkUFQN09b82uRccxvA2u46uQvKfmtnRH5psqVau1mREFCFq8PuxX
 +6LBnUz+W/NBHaMSuUYC3+2Eyenxnre50U4YeRqGjis6fnHJiPOImxttgiCObGBHgxL2
 5fnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+edlCNj7JxR310M4X7zPhmwfbRfbM+VpgT+PW59IoCbS6C0UbEcb9OT2B3iB9Zg2N9xikN5LIePms0Nqiue214Ka59Eo=
X-Gm-Message-State: AOJu0YyLdsdZgAoc5nxevcob58AllmXi8pypsADjHNb5YRgHiDvnxzmM
 JZoADLptxMYXjXjAOpl4wnts92roTlXej1e0hmP8mnFH3vteGQEs5tOqIcr1WMU=
X-Google-Smtp-Source: AGHT+IHxBEyO1zi7b6trsBtWukBd/wKpJHMJLaJ04/DEEexo9f+D4p3YUDdxUwC3qp0Yrqv97sIudg==
X-Received: by 2002:a50:ab0c:0:b0:570:1ea8:cd1c with SMTP id
 s12-20020a50ab0c000000b005701ea8cd1cmr6975661edc.35.1714401419756; 
 Mon, 29 Apr 2024 07:36:59 -0700 (PDT)
Received: from [192.168.69.100] (bny92-h02-176-184-44-142.dsl.sta.abo.bbox.fr.
 [176.184.44.142]) by smtp.gmail.com with ESMTPSA id
 g4-20020a50ee04000000b005727ea3026asm1460725eds.6.2024.04.29.07.36.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 07:36:59 -0700 (PDT)
Message-ID: <befd2718-526e-4407-8620-476dfa290c48@linaro.org>
Date: Mon, 29 Apr 2024 16:36:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block/copy-before-write: use uint64_t for timeout in
 nanoseconds
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org, hreitz@redhat.com,
 kwolf@redhat.com, vsementsov@yandex-team.ru, jsnow@redhat.com,
 f.weber@proxmox.com
References: <20240429141934.442154-1-f.ebner@proxmox.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240429141934.442154-1-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Fiona,

On 29/4/24 16:19, Fiona Ebner wrote:

Not everybody uses an email client that shows the patch content just
after the subject (your first lines wasn't making sense at first).

Simply duplicating the subject helps to understand:

   Use uint64_t for timeout in nanoseconds ...

> rather than the uint32_t for which the maximum is slightly more than 4
> seconds and larger values would overflow. The QAPI interface allows
> specifying the number of seconds, so only values 0 to 4 are safe right
> now, other values lead to a much lower timeout than a user expects.
> 
> The block_copy() call where this is used already takes a uint64_t for
> the timeout, so no change required there.
> 
> Fixes: 6db7fd1ca9 ("block/copy-before-write: implement cbw-timeout option")
> Reported-by: Friedrich Weber <f.weber@proxmox.com>
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>   block/copy-before-write.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/copy-before-write.c b/block/copy-before-write.c
> index 8aba27a71d..026fa9840f 100644
> --- a/block/copy-before-write.c
> +++ b/block/copy-before-write.c
> @@ -43,7 +43,7 @@ typedef struct BDRVCopyBeforeWriteState {
>       BlockCopyState *bcs;
>       BdrvChild *target;
>       OnCbwError on_cbw_error;
> -    uint32_t cbw_timeout_ns;
> +    uint64_t cbw_timeout_ns;

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


