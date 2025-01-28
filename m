Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F17C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 01:01:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcZyr-00054T-0r; Mon, 27 Jan 2025 20:01:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcZyl-00053P-2g
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 20:01:25 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcZyj-0000SR-9n
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 20:01:22 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21649a7bcdcso85143885ad.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 17:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738026079; x=1738630879; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d4f8Wlt7ZRLgHSq0Is1US6HB6owDQl49+LZeNf6TGHw=;
 b=z86r1Y+toEYIbJfjfGgyHULmwQJHzcfnf+4sP+EH/LYrTH460/7iRQG/Sysy/h5o61
 JNfwKU4W8eJCEhxqxzS4AZZBozirzR9KvUVjx8+8hWspEzPrGgB9aefge8lB/8CiK9LK
 vZEnIEE5cj2VtqTXp/rjO8RkUYLKk7RFGIQpYKp9oncdXfH3CyPhLLoWXTkAIS8K3W6N
 SCrNFpgY7ElMklxnoiL7GfHrIC/relkzlVd1kTVIXE9jNqeQY9TcdsChrDckEAQRHkCU
 N4hASqVUzqVtt3tTdOMz1BADTYq5fmHVcOXsiFpA7gs8Ao6sQ5VRdpJvBgs0DGOul2J4
 Y28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738026079; x=1738630879;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d4f8Wlt7ZRLgHSq0Is1US6HB6owDQl49+LZeNf6TGHw=;
 b=IwGWsgngJHkNkcnmEwGj8iIh+Az5vT6Lex3qQTv5pxqMRU8YOSDj3pqhh9+gkzkbTB
 T0N2W1kC45ykLqcbHe3xVaKoQq3Cemvhv5F4OhNCaXWnkRbIw1oL2Wzkz/vYX5S5FeZh
 3orglpTV6WOTLPzyomoKfZ0plkM5hkJ2DpZ9uMv0te11tKXz7yF1kmO/5d9bFG1/zAcl
 OPd1HCi7tbTSUVt/EZyUw/7wHQeLrloLEHLC/0rOA1vBxgXIzOPvekl7jSaUSeNdqUgv
 GXPzwmTMnKq0gETjpDrDpyMZkkr0vu4pQu4UQwijoRItpGOzfQ9Ca16U5Q50EVVEXQyG
 N7Uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUidxDv+mqHbF1jGNR8qR+RzV9EUHJC9vOrVVyIAdJT7IKIFEajTSGhVujVFH6UhmCDK3day3Qm/jUr@nongnu.org
X-Gm-Message-State: AOJu0YyInaK1qjQjkGV3jpqVFFo5U9jORXv1gmsO6zmS7ie79WVGVblB
 upIWmin4+To2bzDLaXyzFrI/S7p3kOBrxYc+Cs+odNw8uz6tIh/+pZWuTrRREbY=
X-Gm-Gg: ASbGnctazB7a2o7wcv3DgVZWCKQJgtsYwIK4K8lzoXaMy5WW1GxTQVDhFfyiPtDyrYe
 8WZKPXAWmkKaFzN6yd/h34QnYUjgcCm06EArRfzkgnsBsqXLLmwoJU2m5D+fu5Jz3QGQWTzFBhp
 dfBTdr1hFNKO2Aairt3U1dkUrxxz6eA7HGEOwiZfO2/Dbuiij65QSmgpD3W8ixzA7E0+3cNPnnM
 BGYEQ3WwW3rwgVjbEbHIFgtFNqXTjKH1LfxNd8M6EuyIGYocHQq2V7lFEdar3PKiLREUXqfzWOq
 IciarjNFmsBFRuKtBvBuj/rdSKC8nbcqAkmj87IvgQqFeSo=
X-Google-Smtp-Source: AGHT+IGs9YcHv83/O3lcdUndbwpP/ssWtc8ruY/YwC51sF2gJWAoU+Wm0oxjQ0LKHOSq/1Ll7MBPDQ==
X-Received: by 2002:a05:6a20:841c:b0:1e0:d9a0:4ff7 with SMTP id
 adf61e73a8af0-1eb21599eecmr82198336637.32.1738026078893; 
 Mon, 27 Jan 2025 17:01:18 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a6b318bsm8082458b3a.56.2025.01.27.17.01.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2025 17:01:18 -0800 (PST)
Message-ID: <e93e5b46-d887-49ed-9aa6-3a79b7cf0f12@linaro.org>
Date: Mon, 27 Jan 2025 17:01:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/tcg/s390x: Test modifying code using the MVC
 instruction
To: Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand
 <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20250128001338.11474-1-iii@linux.ibm.com>
 <20250128001338.11474-2-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250128001338.11474-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 1/27/25 16:12, Ilya Leoshkevich wrote:
> Add a small test to prevent regressions.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   tests/tcg/s390x/Makefile.softmmu-target |  1 +
>   tests/tcg/s390x/mvc-smc.c               | 82 +++++++++++++++++++++++++
>   2 files changed, 83 insertions(+)
>   create mode 100644 tests/tcg/s390x/mvc-smc.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/tests/tcg/s390x/Makefile.softmmu-target b/tests/tcg/s390x/Makefile.softmmu-target
> index 7adde2fa087..8cd4667c63b 100644
> --- a/tests/tcg/s390x/Makefile.softmmu-target
> +++ b/tests/tcg/s390x/Makefile.softmmu-target
> @@ -42,6 +42,7 @@ $(ASM_TESTS): LDFLAGS += -Wl,-T$(LINK_SCRIPT) -Wl,--build-id=none
>   $(ASM_TESTS): $(LINK_SCRIPT)
>   TESTS += $(ASM_TESTS)
>   
> +MULTIARCH_TESTS += mvc-smc
>   S390X_MULTIARCH_RUNTIME_OBJS = head64.o console.o $(MINILIB_OBJS)
>   $(MULTIARCH_TESTS): $(S390X_MULTIARCH_RUNTIME_OBJS)
>   $(MULTIARCH_TESTS): LDFLAGS += $(S390X_MULTIARCH_RUNTIME_OBJS)
> diff --git a/tests/tcg/s390x/mvc-smc.c b/tests/tcg/s390x/mvc-smc.c
> new file mode 100644
> index 00000000000..d68f60caa85
> --- /dev/null
> +++ b/tests/tcg/s390x/mvc-smc.c
> @@ -0,0 +1,82 @@
> +/*
> + * Test modifying code using the MVC instruction.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include <minilib.h>
> +
> +#define PAGE_SIZE 4096
> +#define BR_14_SIZE 2
> +#define RWX_OFFSET 2
> +
> +static unsigned char rw[PAGE_SIZE + BR_14_SIZE];
> +static unsigned char rwx[RWX_OFFSET + sizeof(rw)]
> +    __attribute__((aligned(PAGE_SIZE)));
> +
> +typedef unsigned long (*function_t)(unsigned long);
> +
> +static int emit_function(unsigned char *p, int n)
> +{
> +    int i = 0, val = 0;
> +
> +    while (i < n - 2) {
> +        /* aghi %r2,1 */
> +        p[i++] = 0xa7;
> +        p[i++] = 0x2b;
> +        p[i++] = 0x00;
> +        p[i++] = 0x01;
> +        val++;
> +    }
> +
> +    /* br %r14 */
> +    p[i++] = 0x07;
> +    p[i++] = 0xfe;
> +
> +    return val;
> +}
> +
> +static void memcpy_mvc(void *dest, void *src, unsigned long n)
> +{
> +    while (n >= 256) {
> +        asm("mvc 0(256,%[dest]),0(%[src])"
> +            :
> +            : [dest] "a" (dest)
> +            , [src] "a" (src)
> +            : "memory");
> +        dest += 256;
> +        src += 256;
> +        n -= 256;
> +    }
> +    asm("exrl %[n],0f\n"
> +        "j 1f\n"
> +        "0: mvc 0(1,%[dest]),0(%[src])\n"
> +        "1:"
> +        :
> +        : [dest] "a" (dest)
> +        , [src] "a" (src)
> +        , [n] "a" (n)
> +        : "memory");
> +}
> +
> +int main(void)
> +{
> +    int expected, size;
> +
> +    /* Create a TB. */
> +    size = sizeof(rwx) - RWX_OFFSET - 4;
> +    expected = emit_function(rwx + RWX_OFFSET, size);
> +    if (((function_t)(rwx + RWX_OFFSET))(0) != expected) {
> +        return 1;
> +    }
> +
> +    /* Overwrite the TB. */
> +    size += 4;
> +    expected = emit_function(rw, size);
> +    memcpy_mvc(rwx + RWX_OFFSET, rw, size);
> +    if (((function_t)(rwx + RWX_OFFSET))(0) != expected) {
> +        return 2;
> +    }
> +
> +    return 0;
> +}


