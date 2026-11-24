Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B635E606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 17:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=eBQ6hH3y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVuD9-0003xY-BF; Tue, 24 Nov 2026 12:21:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jorge.merlino@canonical.com>)
 id 1xVuD5-0003wV-Io
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 12:21:39 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jorge.merlino@canonical.com>)
 id 1xVuD3-0006Dq-MH
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 12:21:39 -0500
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8D4633F4CB
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 17:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1795540896;
 bh=8tn4E2XGA0ft/j+yojoxt+eM8NDb9/EwuesJ680Hzek=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=eBQ6hH3yPNHasQz2CMMROoJGHK3qkPovppYajnkT15gGBGb4LswDDEtKAITL9NlzD
 UoaIkS7w0pUwyjJpN/9CUUb+pqhd6ONH+T1DN8YMWuDshuU/b08ciVEubAAXCY8mRm
 jsRJJlqOzylL50jSaSRy7RbdYyB7/qVooFGCUnjQmLtMmhjcTbPkxA6ckvICR8l2af
 765/5Azl/vmkGda02EsFdErqW9ik9qlMkwecoEqJaxzVQhvInPDd/uUt57ZMd5mfh1
 rnOGnzvX5G5BLJxRnkonR2KTeYZDMIO1WHS2u8F/elzw2WYXEQ+7b2MyGoWLrN8U+w
 Et9TTMDRLYv/6m+1Kc1B6df2ah4G7NcEnJOTO6DSSRsAThD5/y+1+UEImLwjsQGmA0
 BDhsGvAYnEf6qHfCrFFhoju8xp32h2dpIDIESttI/8i1I5t5IbfahK2KeA8JYcsJH7
 v8eXMTkHAbycpVEazkXw8KG7eLpZQuqtQjuSBxAc6L2aHKmJ6gcat+poPpgcpmEmsy
 Fw/laSY+CebtK7S01H08Sf+gb3U9JH/8/UqY8DbkczCY4sg1b+/AuEzKq0fm0MvWkP
 CJSVTu9FcPLi+m68ZeCTzWybDAc71wNhAMWYVc2H2Z3O3i9BFDncCTLQUsavqdcd8j
 0ItgpUkZcsxiu7kUk6mUfkxo=
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-9907539aff7so3173695241.2
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 09:21:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795540895; x=1796145695;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8tn4E2XGA0ft/j+yojoxt+eM8NDb9/EwuesJ680Hzek=;
 b=ZrALYV95O4dnK5meCFC7NXxuEBZEedKWztzsyBEdVu/HAtPS7nue2ATA0KFRQc9Nnr
 fwGrWqEDNg8QECdCNLUy211DvCY5U/vTQgZ7Q1I6Yw6se67pbCHev2wiHNspQL90JDQT
 MS98vRazi05NvVcwWCf5RgpuSD3Qh6n+g5uPZE7jC535PheHJwE8+8jeGmG8noZzPWfH
 qkjRPY1TgaP0HNBV3sqspjfRvOrWOtbaSMWfkhs7SfNManL2SvtPdKh2tTzwIPY3NL5U
 oITUyTEnGuzxHC8is9afD2cSQfRxq1MY8HsfKQ0BVzZu6wOnPTllXFow6g0eue5VeWX3
 ASCA==
X-Gm-Message-State: APuU4Z9nsZOIt5Y6ezasnAHHJpufz4p7N2D/vzdeD6EM1rIJgWKxVrz3
 wIjsw8KxRC2qtq7d6wyBQpzQ8loNDs7MS9w3uf0IWQRUXBunZgSJL4zvqxlYzMTYeFW2PPHD7e7
 x5QUpzSVInbrTrU30jFeiqkFYCcDyBG3kVQ8vTsBy8ZGG4lfihWdti4Pwjlyr2Z21KCZMNK5QkI
 l/pGeekt4=
X-Gm-Gg: AZFdTZeb8RCt7dFFyiPWhbhGPTWE9VVz/EhR/sKZpvY2vgo6Y/InsGLgn5Jvz/Ho0QG
 TqpmR19AhGud+nxzDnBProy106jWCWvlvE6nwDSrzHjeVfvf1H39pb4lrSEyTJSOeuXv3bpORoq
 CzveypWyClZXzb307RUDrc0e9D4bewLqvV+XuMmzUWyo43BlFQX0sQqdGsWwkTCMcNBkcSrFrbS
 yTva5iN0HVWhyrHciSF50ICigKG8mQn0Pj4c/f2adkRe/nQW3tNt06Yt/UJwN8D1TAsdda06M9o
 yxYdB3gVNQzFxpN/Am8HpEYDMVyO4PwAYvHQKdBBeqIBnufO0kDTe5rrrr9cVraVjaCFsuxXh4+
 M3Z+Flwzww0CLRdS4V1GtsgtJC4o9S6FAt6YzuiD/gX2YsGLiTBPtzqrQ717V9fjrYwh+l+MNZm
 UbGPXc/ARwpKL3ZkXRGo3OgJNVXm4iUw1m
X-Received: by 2002:a05:6102:4245:b0:7ab:af4a:f2f3 with SMTP id
 ada2fe7eead31-7d739628997mr8760617137.26.1795540895450; 
 Tue, 24 Nov 2026 09:21:35 -0800 (PST)
X-Received: by 2002:a05:6102:4245:b0:7ab:af4a:f2f3 with SMTP id
 ada2fe7eead31-7d739628997mr8760579137.26.1795540895090; 
 Tue, 24 Nov 2026 09:21:35 -0800 (PST)
Received: from [172.17.2.13] (r167-56-144-32.dialup.adsl.anteldata.net.uy.
 [167.56.144.32]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7d6e7f92680sm16258752137.5.2026.11.24.09.21.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 09:21:34 -0800 (PST)
Message-ID: <99859580-7f76-4c70-bd80-28c686cf07c7@canonical.com>
Date: Tue, 24 Nov 2026 14:21:31 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add debug for block operations
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, qemu-block@nongnu.org
References: <20261124171537.198694-1-jorge.merlino@canonical.com>
Content-Language: en-US, es-UY
From: Jorge Merlino <jorge.merlino@canonical.com>
In-Reply-To: <20261124171537.198694-1-jorge.merlino@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=jorge.merlino@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Please disregard this patch. I had already sent this to the list but I 
forgot. Sorry for that.

On 24/11/26 14:15, Jorge Merlino wrote:
> Add debug tracepoint when block operations finish
> 
> Signed-off-by: Jorge Merlino <jorge.merlino@canonical.com>
> ---
>   block/block-backend.c | 2 ++
>   block/trace-events    | 2 ++
>   2 files changed, 4 insertions(+)
> 
> diff --git a/block/block-backend.c b/block/block-backend.c
> index 656c0aed67..97a7e74c09 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -1365,6 +1365,7 @@ blk_co_do_preadv_part(BlockBackend *blk, int64_t offset, int64_t bytes,
>   
>       ret = bdrv_co_preadv_part(blk->root, offset, bytes, qiov, qiov_offset,
>                                 flags);
> +    trace_blk_co_preadv_done(blk, bs, offset, bytes, ret);
>       bdrv_dec_in_flight(bs);
>       return ret;
>   }
> @@ -1443,6 +1444,7 @@ blk_co_do_pwritev_part(BlockBackend *blk, int64_t offset, int64_t bytes,
>   
>       ret = bdrv_co_pwritev_part(blk->root, offset, bytes, qiov, qiov_offset,
>                                  flags);
> +    trace_blk_co_pwritev_done(blk, bs, offset, bytes, ret);
>       bdrv_dec_in_flight(bs);
>       return ret;
>   }
> diff --git a/block/trace-events b/block/trace-events
> index 950c82d4b8..842c3fc809 100644
> --- a/block/trace-events
> +++ b/block/trace-events
> @@ -7,6 +7,8 @@ bdrv_lock_medium(void *bs, bool locked) "bs %p locked %d"
>   # block-backend.c
>   blk_co_preadv(void *blk, void *bs, int64_t offset, int64_t bytes, int flags) "blk %p bs %p offset %"PRId64" bytes %" PRId64 " flags 0x%x"
>   blk_co_pwritev(void *blk, void *bs, int64_t offset, int64_t bytes, int flags) "blk %p bs %p offset %"PRId64" bytes %" PRId64 " flags 0x%x"
> +blk_co_preadv_done(void *blk, void *bs, int64_t offset, int64_t bytes, int ret) "blk %p bs %p offset %"PRId64" bytes %" PRId64 " ret %d"
> +blk_co_pwritev_done(void *blk, void *bs, int64_t offset, int64_t bytes, int ret) "blk %p bs %p offset %"PRId64" bytes %" PRId64 " ret %d"
>   blk_root_attach(void *child, void *blk, void *bs) "child %p blk %p bs %p"
>   blk_root_detach(void *child, void *blk, void *bs) "child %p blk %p bs %p"
>   


