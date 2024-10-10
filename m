Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B37CCF07DF
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 09:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sypLa-0007VN-OQ; Thu, 10 Oct 2024 05:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sypLY-0007Uy-Kz
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 05:20:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sypLX-0003Bs-2c
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 05:20:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728552033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=M3k9SHo3qRUM4EuysHne9bzHFPEfdZrIFuqywt8xra8=;
 b=WkvilCgxMmWbZlUuHkkURoqRfqvNI/9E/G1r2FnpKmU/SMhEVCiVod6qzz6C2filOaDGg+
 d97IsVUGuDoqgwDI0L3plr+eB38yBUTnYzJW5uLjiikH+GrkYfcUrRtDIvzj7LulUJzIHw
 cV9ey2bXJaEpBih/JNGA6hoS96DNiVQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-gSP0Nu_0OIirZuPKxb_SiA-1; Thu, 10 Oct 2024 05:20:31 -0400
X-MC-Unique: gSP0Nu_0OIirZuPKxb_SiA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5c9338a16cdso853051a12.0
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 02:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728552030; x=1729156830;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M3k9SHo3qRUM4EuysHne9bzHFPEfdZrIFuqywt8xra8=;
 b=cDh8P8POdoNxUdasY+yJEYbk73mZf7zsUUuD/i5HlF4InblTItZNSDDZdfWoqzps3S
 Vvh2nUSYvqeyZFfXeTWGu2B8eeR8Bg7gLJRMPZxGNz4NhiqR5PKjrWq9gnzNuUz2Jvq4
 ksiXWunYbC7ZdOAMNL7sWEyMOp+gTvFMt4FcPKFKA6/mAGQl5NPSq7tQQ5XKhCcJodDr
 48JTuonyNxfCWxarie/OB96H/eDzQ3Or1oL2IFhXGOh4dyMCPV70XPGMBAQw3OOdZ4sF
 6Jyjjmo4mL0jO2eZpdLNUppeQTGhzIOpohsa/QlaOyrmoDuHfU+171u8haqtYzC41u6n
 wvdg==
X-Gm-Message-State: AOJu0Yw0JYCxo0OHbpFlw1plCudlcrFB9u9G/dw+QnkOssLAAMd3Eyj4
 qyzlaEN/CCY0Z5XM/N3SmoZ2kPHUlPqDEn5U1gE33Cg0moSwb3+vbOAzrnTF4Kqpac/nGKjEvXn
 kBqzvs2QdCUHbMYJehtUfkuXZrXe1MTC2ytprO83VueE+659ncSnV
X-Received: by 2002:a05:6402:4308:b0:5c8:d9b8:9325 with SMTP id
 4fb4d7f45d1cf-5c9335447a3mr2362524a12.5.1728552030309; 
 Thu, 10 Oct 2024 02:20:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfn5hihk3l2YYgo5NBxJTJlEu59ccpvs2MN/1MNE38AlCTZuPAygfJT+KgUkHe4I620HZ3DA==
X-Received: by 2002:a05:6402:4308:b0:5c8:d9b8:9325 with SMTP id
 4fb4d7f45d1cf-5c9335447a3mr2362504a12.5.1728552029852; 
 Thu, 10 Oct 2024 02:20:29 -0700 (PDT)
Received: from [192.168.10.81] ([151.81.124.37])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-5c93711a195sm527348a12.34.2024.10.10.02.20.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Oct 2024 02:20:29 -0700 (PDT)
Message-ID: <59b7a93e-7acb-4a73-9aae-bbfb36101c5d@redhat.com>
Date: Thu, 10 Oct 2024 11:20:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/tcg: Do not use inttypes.h in
 multiarch/system/memory.c
To: Ilya Leoshkevich <iii@linux.ibm.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20241010085906.226249-1-iii@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241010085906.226249-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/10/24 10:58, Ilya Leoshkevich wrote:
> make check-tcg fails on Fedora with the following error message:
> 
>      alpha-linux-gnu-gcc [...] qemu/tests/tcg/multiarch/system/memory.c -o memory [...]
>      qemu/tests/tcg/multiarch/system/memory.c:17:10: fatal error: inttypes.h: No such file or directory
>         17 | #include <inttypes.h>
>            |          ^~~~~~~~~~~~
>      compilation terminated.
> 
> The reason is that Fedora has cross-compilers, but no cross-glibc
> headers. Fix by hardcoding the format specifiers and dropping the
> include.
> 
> An alternative fix would be to introduce a configure check for
> inttypes.h. But this would make it impossible to use Fedora
> cross-compilers for softmmu tests, which used to work so far.
> 
> Fixes: ecbcc9ead2f8 ("tests/tcg: add a system test to check memory instrumentation")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

> ---
>   tests/tcg/multiarch/system/memory.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/tcg/multiarch/system/memory.c b/tests/tcg/multiarch/system/memory.c
> index 65a6038a241..7508f6b916d 100644
> --- a/tests/tcg/multiarch/system/memory.c
> +++ b/tests/tcg/multiarch/system/memory.c
> @@ -14,7 +14,6 @@
>   
>   #include <stdint.h>
>   #include <stdbool.h>
> -#include <inttypes.h>
>   #include <minilib.h>
>   
>   #ifndef CHECK_UNALIGNED
> @@ -511,8 +510,8 @@ int main(void)
>       int i;
>       bool ok = true;
>   
> -    ml_printf("Test data start: 0x%"PRIxPTR"\n", &test_data[0]);
> -    ml_printf("Test data end: 0x%"PRIxPTR"\n", &test_data[TEST_SIZE]);
> +    ml_printf("Test data start: 0x%lx\n", (unsigned long)&test_data[0]);
> +    ml_printf("Test data end: 0x%lx\n", (unsigned long)&test_data[TEST_SIZE]);
>   
>       /* Run through the unsigned tests first */
>       for (i = 0; i < ARRAY_SIZE(init_ufns) && ok; i++) {
> @@ -529,8 +528,8 @@ int main(void)
>           ok = do_signed_reads(true);
>       }
>   
> -    ml_printf("Test data read: %"PRId32"\n", test_read_count);
> -    ml_printf("Test data write: %"PRId32"\n", test_write_count);
> +    ml_printf("Test data read: %lu\n", (unsigned long)test_read_count);
> +    ml_printf("Test data write: %lu\n", (unsigned long)test_write_count);
>       ml_printf("Test complete: %s\n", ok ? "PASSED" : "FAILED");
>       return ok ? 0 : -1;
>   }


