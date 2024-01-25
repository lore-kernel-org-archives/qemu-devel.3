Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAFE5C47DDF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 08:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSv0Q-00053G-Vu; Thu, 25 Jan 2024 03:22:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rSv0P-00052v-Lm
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 03:22:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rSv0O-000231-BQ
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 03:22:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706170955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7CesC0aXpcrv3PQ7Jpq0GxxSP79vJC9J/tOoC9Fw16o=;
 b=VJrK6FF0dU9/pj1IZPPioCzgnwdXkhZKeOoMDW2SKaeFamz6lO1uESvOBEw4T+kUNxe8zN
 CGpfzr9FqQH4hFiMb57AUE9APbZmY1cAdZSEKRvvGh+9YVtDYHSyAknsZrT//MbcdHtV5G
 6DXL18v9lyn0GCtP2pblSeJcdO/ux6E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-VzE5juUQO0W1SDkhOmnXiw-1; Thu, 25 Jan 2024 03:22:32 -0500
X-MC-Unique: VzE5juUQO0W1SDkhOmnXiw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40e49906305so36425215e9.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 00:22:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706170952; x=1706775752;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :references:cc:to:content-language:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7CesC0aXpcrv3PQ7Jpq0GxxSP79vJC9J/tOoC9Fw16o=;
 b=XCdnappgEIP7rTeDcQJIYyxDPwipXYO7gcdvLqFIck/EF8EKDUzsGTViLTdR0g9TTv
 lui0FTP5uTFxbWVK4KeB2/5+9HKnkwFvfBX48uJbNEjNy8KFnsN7drWbC4D8ES66dzW0
 xIrfepB+vY9N4+HBHNANFKkp7Fr1m7CHJOy4y1YRKCSGViVxMOWDc82jNR9Pt6bLymjq
 4Sgm9176gDJdCcmTISo1CQS3PKs3pof6MMIz6EGL7QU1M7IJIISJ1Eo8gXZR//RwrHcw
 KRmMy5MWk70v97FWxKwaamguehIQUlCI1MUCdGHnOhbIuYEq3pj1+BvqbYR2wmAWFdAq
 urKw==
X-Gm-Message-State: AOJu0YwO1Z3b7WpiP02n2ZCi4x/GFzrcBRCwx7au36J3ewNSWdw3/a0C
 bfiAYpCwDdIlSsSRhQq0l1utyl3PmGxVMnxBU/eezt/HmDc5pZk30GtqxcufGzCkmcb4vtDzgoj
 qne3ByNElQQDzZvYPWDzJkQtN85OIHFcvvboJXZ2aord7OXipMwJO
X-Received: by 2002:a05:600c:1f0d:b0:40e:b93e:6908 with SMTP id
 bd13-20020a05600c1f0d00b0040eb93e6908mr253524wmb.131.1706170951768; 
 Thu, 25 Jan 2024 00:22:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0RoFZcxuaFnCkiBTVAzE6eyswFa01v9tsYlOqg/Bz+/l/bc1vyU40lc3unKZYzDqK6/2K8g==
X-Received: by 2002:a05:600c:1f0d:b0:40e:b93e:6908 with SMTP id
 bd13-20020a05600c1f0d00b0040eb93e6908mr253515wmb.131.1706170951384; 
 Thu, 25 Jan 2024 00:22:31 -0800 (PST)
Received: from ?IPV6:2003:cb:c70a:7600:9a0b:ceef:a304:b9a7?
 (p200300cbc70a76009a0bceefa304b9a7.dip0.t-ipconnect.de.
 [2003:cb:c70a:7600:9a0b:ceef:a304:b9a7])
 by smtp.gmail.com with ESMTPSA id
 bg42-20020a05600c3caa00b0040e54f15d3dsm1687918wmb.31.2024.01.25.00.22.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jan 2024 00:22:31 -0800 (PST)
Message-ID: <7d586878-4b0d-401d-a706-9d18ffd52435@redhat.com>
Date: Thu, 25 Jan 2024 09:22:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] physmem: replace function name with __func__ in
 ram_block_discard_range()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240125023328.2520888-1-xiaoyao.li@intel.com>
 <9943c88e-3ccd-4a3b-bbe0-65a8a58755d1@linaro.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <9943c88e-3ccd-4a3b-bbe0-65a8a58755d1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 25.01.24 06:06, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On 25/1/24 03:33, Xiaoyao Li wrote:
>> Use __func__ to avoid hard-coded function name.
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> ---
>>    system/physmem.c | 38 +++++++++++++++++---------------------
>>    1 file changed, 17 insertions(+), 21 deletions(-)
> 
> 
>>        if ((start + length) <= rb->max_length) {
>>            bool need_madvise, need_fallocate;
>>            if (!QEMU_IS_ALIGNED(length, rb->page_size)) {
>> -            error_report("ram_block_discard_range: Unaligned length: %zx",
>> -                         length);
>> +            error_report("%s: Unaligned length: %zx", __func__, length);
> 
> Pre-existing, should we enforce 0x prefix for %*x format?

Likely yes, but then, most of these errors here are more similar to 
assertions that we never ever see unless we have real bugs in QEMU. So I 
wouldn't lose sleep over it.

-- 
Cheers,

David / dhildenb


