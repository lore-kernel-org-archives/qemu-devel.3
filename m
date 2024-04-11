Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549DEC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 20:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rv15g-0001SC-1i; Thu, 11 Apr 2024 16:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rv15X-0001Qn-5r
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 16:32:04 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rv15U-00020y-KY
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 16:32:02 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6ed2170d89fso826816b3a.1
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 13:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712867519; x=1713472319; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rDaDuhg4QCXHieIPmS4w3WKtXr9zKaoXJqLSM2te/Xo=;
 b=iN5Zhs+84kIkhoZNXHM4yua8wJFZ78tok9iteyBGvYSqlAp5dPQXMYsYo7vMA3ITgM
 /YmmnG12G9a3AdQbFlTw0KYePV6TfFsY7KjW8PY0gN8J+4NIF8L7HW481UN2l4JVldz7
 vriw6LiNJ9+S0eUmLusTfu8BwKz+SSriOXSreVM7pDKxf2mU2tEm4//S83LSCW5m2AhM
 toSa0RRBPyDvwAmuyEST/L3TEKvjb0CaxW6KFPXK3rNcPwXyALz9qZEV9Fq7oUle1OD4
 CohbP1f/Ax0maURCwLbwbhm1yos9k2R/1RvoSo6xvsJrAghz+SgJucs4E2PzEfOO5j7j
 Oeyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712867519; x=1713472319;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rDaDuhg4QCXHieIPmS4w3WKtXr9zKaoXJqLSM2te/Xo=;
 b=b8Udi1gKJV3KWI8+rmH+SA/T6iHyIFsK32FjRQ+HgSX8plQSyjWJYVRUbz/aC5bgc3
 ByDYxEVwZpInsqObtM8qarSji6KirSGknNBzq6NDrcI3xUx9p5m1LfajWLuTOX403SNe
 rtlTk5i5bxBMVU0y58snK5zqfBB7PYHtbj0tGquMgsVzCKkZgSbjYy0sh3H9LA1x8Qk3
 3iiwzdF4ZtxOsp2QQlLtFEKbDskx8prvn9/WL3h7eG1lJTSLKgkyyqAjGbLH/q9CCCmh
 JNiu3rAsYTcQSZ4hTqFKf5TNKJTRIQBd2/LeaXFrEaoJEoGg7xrWyAxvAnKwamG8NVWY
 Y0RA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtKLeMIhN9n52IzqSfs/CKUkCalOZMXZFiBCb3DNmmgToTk9w6dAP6gZlm9UJRw7oMgOExHzJf7AJtxGpnI9XQbvdC6Qo=
X-Gm-Message-State: AOJu0YxlOuocIJk9aZ/ScA5ZLN46tDY/Wi4Z8jicZeRNaPreLokLWUF3
 lmaMK1EpD/15RJYTis5eDsR2MQmS2WZgd4u/VtaWvNmSojCkeQ57+cupuaBnm6o=
X-Google-Smtp-Source: AGHT+IHfNPt+q1Di+/35PNp0N2MOX9Wzf55kVJBGzq8IGBL4gMgWs7+QCIQZ/KdQ6ltqOGLYY6dv4w==
X-Received: by 2002:a05:6a20:7347:b0:1a8:2cd1:e493 with SMTP id
 v7-20020a056a20734700b001a82cd1e493mr968622pzc.29.1712867519025; 
 Thu, 11 Apr 2024 13:31:59 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 gb10-20020a056a00628a00b006e6ae26625asm1581948pfb.68.2024.04.11.13.31.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 13:31:58 -0700 (PDT)
Message-ID: <40d41dde-6fb6-4667-9761-e15c52f9d5b1@linaro.org>
Date: Thu, 11 Apr 2024 13:31:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/13] hw/mips/malta: Add re-usable rng_seed_hex_new()
 method
From: Richard Henderson <richard.henderson@linaro.org>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20240411101550.99392-1-philmd@linaro.org>
 <20240411101550.99392-5-philmd@linaro.org>
 <89453f6f-1ffe-4141-a8aa-fde7319f3e17@linaro.org>
Content-Language: en-US
In-Reply-To: <89453f6f-1ffe-4141-a8aa-fde7319f3e17@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 4/11/24 13:07, Richard Henderson wrote:
> On 4/11/24 03:15, Philippe Mathieu-Daudé wrote:
>> Extract common code from reinitialize_rng_seed() and
>> load_kernel() to rng_seed_hex_new().
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/mips/malta.c | 20 ++++++++++++--------
>>   1 file changed, 12 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/mips/malta.c b/hw/mips/malta.c
>> index af74008c82..9fc6a7d313 100644
>> --- a/hw/mips/malta.c
>> +++ b/hw/mips/malta.c
>> @@ -850,15 +850,24 @@ static void G_GNUC_PRINTF(3, 4) prom_set(uint32_t *prom_buf, int 
>> index,
>>       va_end(ap);
>>   }
>> -static void reinitialize_rng_seed(void *opaque)
>> +static char *rng_seed_hex_new(void)
>>   {
>> -    char *rng_seed_hex = opaque;
>>       uint8_t rng_seed[32];
>> +    char rng_seed_hex[sizeof(rng_seed) * 2 + 1];
>>       qemu_guest_getrandom_nofail(rng_seed, sizeof(rng_seed));
>>       for (size_t i = 0; i < sizeof(rng_seed); ++i) {
>>           sprintf(rng_seed_hex + i * 2, "%02x", rng_seed[i]);
>>       }
>> +
>> +    return g_strdup(rng_seed_hex);
>> +}
>> +
>> +static void reinitialize_rng_seed(void *opaque)
>> +{
>> +    g_autofree char *rng_seed_hex = rng_seed_hex_new();
>> +
>> +    strcpy(opaque, rng_seed_hex);
>>   }
> 
> Though it isn't deprecated, strcpy isn't really any safer than sprintf.
> We don't need to be copying text around quite as much as this.
> 
> How about:
> 
> #define RNG_SEED_SIZE 32
> 
> static void rng_seed_hex_new(char buf[2 * RNG_SEED_SIZE + 1])
> {
>      static const char hex = "0123456789abcdef";
>      uint8_t rng_seed[RNG_SEED_SIZE];
> 
>      qemu_guest_getrandom_nofail(rng_seed, sizeof(rng_seed));
>      for (int i = 0; i < RNG_SEED_SIZE; ++i) {
>          buf[i * 2 + 0] = hex[rng_seed[i] / 16];
>          buf[i * 2 + 1] = hex[rng_seed[i] % 16];

Hmm.  Maybe a

static inline char hexdump_nibble(unsigned val)
{
     return (val < 10 ? '0' : 'a') + val;
}

static inline void hexdump_byte(char *out, uint8_t byte)
{
     out[0] = hexdump_nibble(byte >> 4);
     out[1] = hexdump_nibble(byte & 15);
}

in "qemu/cutils.h", for use elsewhere including util/hexdump.c.


r~

