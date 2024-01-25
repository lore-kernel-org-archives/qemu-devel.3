Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B985C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 05:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSrwc-00083J-1o; Thu, 25 Jan 2024 00:06:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSrwX-00082n-Ef
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 00:06:25 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSrwU-0002UP-8d
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 00:06:24 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40e775695c6so61611095e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 21:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706159181; x=1706763981; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Gmqrv4fvsbInb7Sp74XcN97wYzqqaxwGQuaHqjrzI+I=;
 b=rWvmfn6Hhpx6Jz+S4GjuX+UKyh7odF2K9xV4PBf88as4Kvt6tisDbaQcLEHcabNe/7
 bqykkl085oQFJVuJSwF72EGnoW8E8iVsc+EU2guD9fbnua9D7oG6u0n/q3+YcDVF+d9w
 q2do+FhYLXhM6Gp48vbXIylxPIb0jyFtVhAXJIR6yweI2kxnrAs7EZrZqFcY+llV4UWG
 jk6NEV+LY502ztl3hj7dDtRpQVpH/D4VonBF5DTfYJXo2kYt9iNgHMaJW6qfPpHL8ISA
 JsfWG5zPiH1J6/xXI7PjxtI82+0ICJ3kUHIVkNuWnLvKIM1bJOKXo3F/+kKHA8Ij5EcS
 wQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706159181; x=1706763981;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gmqrv4fvsbInb7Sp74XcN97wYzqqaxwGQuaHqjrzI+I=;
 b=lwHBCrzF6bWgK4R+1NwvQIYfgWgZQ3qSogLWLZda1pBbw+hJiMvjeU5SvnIR5QOuUK
 scK8MWLV4Noei9L74TQqXImFMuJ1wokpetCf565YXh4IviobXFh1F4bYn4z74MsJ8fVq
 3HSIICAxq9GUTpFY8veKEYxTcvc9QOWEByjc4oGp9hVTgjCUFclnxW64nT4mLleDP0AM
 cQVvrjQCBbZ4NC4FN84S+Puwv6nQaRq6e2UgbUjMExvZsS+Tu+q2hOy4ppcdXpqwsLMr
 aR7xyO8ITvmqsYIiJjim+HLNFpUGs3adUaTF6MWRzhLaEt09+gHqBER6cVF6ytJQ4VFm
 +R+w==
X-Gm-Message-State: AOJu0YyVk9oP3OxmopgjQWt31WndXmo/5WPrn1gboMVIVEC8OL2boc/+
 fDH8UaKX+CPxRNUBgSvYI+AgcSEtJew+95a5L501IxgIOIavR3GQ1cOgLSf8Ktg=
X-Google-Smtp-Source: AGHT+IEWzFd/i6V1HE4aHxBjv+I9VgW5mBGOtV3PRnvIdG+c1+oswZ5zwgn+Bkt6i2QXpxC305+R5Q==
X-Received: by 2002:a5d:4c47:0:b0:339:372e:771a with SMTP id
 n7-20020a5d4c47000000b00339372e771amr238267wrt.52.1706159180729; 
 Wed, 24 Jan 2024 21:06:20 -0800 (PST)
Received: from [192.168.69.100] (lec62-h02-176-184-19-125.dsl.sta.abo.bbox.fr.
 [176.184.19.125]) by smtp.gmail.com with ESMTPSA id
 c11-20020a056000104b00b003392cb66714sm11066228wrx.61.2024.01.24.21.06.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 21:06:20 -0800 (PST)
Message-ID: <9943c88e-3ccd-4a3b-bbe0-65a8a58755d1@linaro.org>
Date: Thu, 25 Jan 2024 06:06:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] physmem: replace function name with __func__ in
 ram_block_discard_range()
Content-Language: en-US
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240125023328.2520888-1-xiaoyao.li@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240125023328.2520888-1-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi,

On 25/1/24 03:33, Xiaoyao Li wrote:
> Use __func__ to avoid hard-coded function name.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>   system/physmem.c | 38 +++++++++++++++++---------------------
>   1 file changed, 17 insertions(+), 21 deletions(-)


>       if ((start + length) <= rb->max_length) {
>           bool need_madvise, need_fallocate;
>           if (!QEMU_IS_ALIGNED(length, rb->page_size)) {
> -            error_report("ram_block_discard_range: Unaligned length: %zx",
> -                         length);
> +            error_report("%s: Unaligned length: %zx", __func__, length);

Pre-existing, should we enforce 0x prefix for %*x format?

See https://www.qemu.org/docs/master/devel/style.html#printf-flag
and related commit c3e5875afc ("checkpatch: check trace-events code
style") for rationale.

$ git grep '[^x]%zx'
accel/tcg/perf.c:239:        fprintf(perfmap, "%"PRIxPTR" %zx 
tcg-prologue-buffer\n",
gdbstub/user-target.c:300:    g_string_printf(gdbserver_state.str_buf, 
"F%zx;", n);
migration/postcopy-ram.c:759:        error_report("%s: Failed to wake: 
%zx in %s (%s)",
migration/trace-events:100:ram_discard_range(const char *rbname, 
uint64_t start, size_t len) "%s: start: %" PRIx64 " %zx"
system/physmem.c:3511:            error_report("ram_block_discard_range: 
Unaligned length: %zx",
system/physmem.c:3564:                             "%s:%" PRIx64 " +%zx 
(%d)",
system/physmem.c:3571:                         "%s:%" PRIx64 " +%zx (%d)",
system/physmem.c:3591:                             "%s:%" PRIx64 " +%zx 
(%d)",
system/physmem.c:3598:                         "%s:%" PRIx64 " +%zx (%d)",
system/physmem.c:3607:                     "/%zx/" RAM_ADDR_FMT")",

>               if (ret) {
>                   ret = -errno;
> -                error_report("ram_block_discard_range: Failed to fallocate "
> -                             "%s:%" PRIx64 " +%zx (%d)",
> -                             rb->idstr, start, length, ret);
> +                error_report("%s: Failed to fallocate %s:%" PRIx64 " +%zx (%d)",
> +                             __func__, rb->idstr, start, length, ret);
>                   goto err;
>               }
>   #else
>               ret = -ENOSYS;
> -            error_report("ram_block_discard_range: fallocate not available/file"
> +            error_report("%s: fallocate not available/file"
>                            "%s:%" PRIx64 " +%zx (%d)",
> -                         rb->idstr, start, length, ret);
> +                         __func__, rb->idstr, start, length, ret);
>               goto err;
>   #endif
>           }
> @@ -3587,25 +3585,23 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
>               }
>               if (ret) {
>                   ret = -errno;
> -                error_report("ram_block_discard_range: Failed to discard range "
> +                error_report("%s: Failed to discard range "
>                                "%s:%" PRIx64 " +%zx (%d)",
> -                             rb->idstr, start, length, ret);
> +                             __func__, rb->idstr, start, length, ret);
>                   goto err;
>               }
>   #else
>               ret = -ENOSYS;
> -            error_report("ram_block_discard_range: MADVISE not available"
> -                         "%s:%" PRIx64 " +%zx (%d)",
> -                         rb->idstr, start, length, ret);
> +            error_report("%s: MADVISE not available %s:%" PRIx64 " +%zx (%d)",
> +                         __func__, rb->idstr, start, length, ret);
>               goto err;
>   #endif
>           }
>           trace_ram_block_discard_range(rb->idstr, host_startaddr, length,
>                                         need_madvise, need_fallocate, ret);
>       } else {
> -        error_report("ram_block_discard_range: Overrun block '%s' (%" PRIu64
> -                     "/%zx/" RAM_ADDR_FMT")",
> -                     rb->idstr, start, length, rb->max_length);
> +        error_report("%s: Overrun block '%s' (%" PRIu64 "/%zx/" RAM_ADDR_FMT")",
> +                     __func__, rb->idstr, start, length, rb->max_length);
>       }

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


