Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CAC8C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 07:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKYRr-0008Ps-BX; Fri, 21 Jun 2024 03:12:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKYRp-0008Kg-QA
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 03:12:37 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKYRn-0006yA-W4
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 03:12:37 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a6e349c0f2bso196181866b.2
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 00:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718953954; x=1719558754; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+X3r3iWIZnsDCFWQKHQoaKS+fjEdqxnm5cTkv/byPH8=;
 b=i3L3ethMBrdazVPR9bcqAnkuoOliHWGueg1db3Zr/XCu0tKHdgMThxFyl3XhDUrzv6
 hY44JSAMcXKki+APdEAEce+PqSGq6zJdHVuhgIcY72EDsPgJ62e6r1uTFhebW4j3M29P
 QydNkFnAYzavN9cadWMyxOiEjX+aoLEHBzFfAfBu8z5cfx2ZUFVWFgd34aVWKA/9fq/V
 8PcZFM5rQR4T/jP8GJIdMfpMIQPM33e7BMx0WN4wglu56FZ534dqHnTlpkvIR2XAertd
 W+jR1ngK9mN9J8Y7mXSucOTBHqKGABqtIer+/wZ2bSeHcI2rJgUQveHpxLxf//YmsrH3
 OxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718953954; x=1719558754;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+X3r3iWIZnsDCFWQKHQoaKS+fjEdqxnm5cTkv/byPH8=;
 b=rTC5Mn12/l5GTLi5PrgMtfDsWQVz5uQ3mJP9mvaErcilqnd2s7LKcHXbgOsvG5DuNG
 +LkldW7MnjVhA25LTG9Cre1EB/2YyM1stT9eAeAXh2CyjRGQohNEqxL8tTzC4BMA2ydm
 PYoTPZ+2G/c4lm5uYOYz3cxxFgCslz6C1OHiGLBek3GOtPj2KTJGWxVm2se2iTYJuRtj
 yV0SAyigwG8uqSWS1ZG/BPv5F7gsCuMooLXp5aFtwibLqKdD87ZolwlmlC4gSryVTDvf
 qv8PmiX4/xzV3vtLROoSdxRB3jQzubmmg/v4aaJD3YUBkWRGnLUvgyRrNgG4xs6URTR5
 JPlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXca16NT3A3sWr/OcSeS93kQNBFLZHwt98M7xhnb+/f0PWoe/HibUM6PWNaWYuedvjtPASgnxn29pWtV1hSp4zQi7pqhsI=
X-Gm-Message-State: AOJu0YwzWdgmP8d5rNut3oeyG7z93SkX7AV71olXXgmyaol1qkuo1SF6
 9IaSyaaf9lUZzH1hLqjOZa/3P4Va74QbAD2enketsJjQn8DnzwRuLoLr/F8qeJ8=
X-Google-Smtp-Source: AGHT+IGDJt4eeNhXv751/YEEHTjXvtvEWkZD5alLeIkIR1Kuc8t5AALKvfHYqcG3IrFQoZbVt7a9rQ==
X-Received: by 2002:a17:907:1888:b0:a6f:ae81:174 with SMTP id
 a640c23a62f3a-a6fae81070dmr532101366b.18.1718953954206; 
 Fri, 21 Jun 2024 00:12:34 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.128.209])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6fcf5490eesm50524766b.111.2024.06.21.00.10.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jun 2024 00:12:33 -0700 (PDT)
Message-ID: <140c112f-450c-4cc8-a57c-36a96d29130c@linaro.org>
Date: Fri, 21 Jun 2024 09:10:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/4] bswap: Add the ability to store to an unaligned 24
 bit field
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Michael Tsirkin <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>
Cc: linux-cxl@vger.kernel.org, linuxarm@huawei.com,
 Ira Weiny <ira.weiny@intel.com>, Michael Roth <michael.roth@amd.com>,
 Dave Jiang <dave.jiang@intel.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Mike Maslenkin <mike.maslenkin@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20230526170010.574-1-Jonathan.Cameron@huawei.com>
 <20230526170010.574-2-Jonathan.Cameron@huawei.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20230526170010.574-2-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

Hi Ira & Jonathan,

On 26/5/23 19:00, Jonathan Cameron wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> CXL has 24 bit unaligned fields which need to be stored to.  CXL is
> specified as little endian.
> 
> Define st24_le_p() and the supporting functions to store such a field
> from a 32 bit host native value.
> 
> The use of b, w, l, q as the size specifier is limiting.  So "24" was
> used for the size part of the function name.
> 
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   docs/devel/loads-stores.rst |  2 ++
>   include/qemu/bswap.h        | 25 +++++++++++++++++++++++++
>   2 files changed, 27 insertions(+)
> 
> diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
> index d2cefc77a2..dab6dfa0ac 100644
> --- a/docs/devel/loads-stores.rst
> +++ b/docs/devel/loads-stores.rst
> @@ -36,6 +36,7 @@ store: ``st{size}_{endian}_p(ptr, val)``
>   ``size``
>    - ``b`` : 8 bits
>    - ``w`` : 16 bits
> + - ``24`` : 24 bits
>    - ``l`` : 32 bits
>    - ``q`` : 64 bits
>   
> @@ -65,6 +66,7 @@ of size ``sz`` bytes.
>   Regexes for git grep
>    - ``\<ld[us]\?[bwlq]\(_[hbl]e\)\?_p\>``
>    - ``\<st[bwlq]\(_[hbl]e\)\?_p\>``
> + - ``\<st24\(_[hbl]e\)\?_p\>``

Interestingly this regexp mentions st24_be_p() but this patch
only adds st24_le_p() and st24_he_p().

No need to update the regexp, I'll post a patch with st24_be_p()
since I have use for it.

>    - ``\<ldn_\([hbl]e\)?_p\>``
>    - ``\<stn_\([hbl]e\)?_p\>``
>   
> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> index 15a78c0db5..933a66ee87 100644
> --- a/include/qemu/bswap.h
> +++ b/include/qemu/bswap.h
> @@ -8,11 +8,23 @@
>   #undef  bswap64
>   #define bswap64(_x) __builtin_bswap64(_x)
>   
> +static inline uint32_t bswap24(uint32_t x)
> +{
> +    return (((x & 0x000000ffU) << 16) |
> +            ((x & 0x0000ff00U) <<  0) |
> +            ((x & 0x00ff0000U) >> 16));
> +}
> +
>   static inline void bswap16s(uint16_t *s)
>   {
>       *s = __builtin_bswap16(*s);
>   }
>   
> +static inline void bswap24s(uint32_t *s)
> +{
> +    *s = bswap24(*s & 0x00ffffffU);
> +}
> +
>   static inline void bswap32s(uint32_t *s)
>   {
>       *s = __builtin_bswap32(*s);
> @@ -26,11 +38,13 @@ static inline void bswap64s(uint64_t *s)
>   #if HOST_BIG_ENDIAN
>   #define be_bswap(v, size) (v)
>   #define le_bswap(v, size) glue(__builtin_bswap, size)(v)
> +#define le_bswap24(v) bswap24(v)
>   #define be_bswaps(v, size)
>   #define le_bswaps(p, size) \
>               do { *p = glue(__builtin_bswap, size)(*p); } while (0)
>   #else
>   #define le_bswap(v, size) (v)
> +#define le_bswap24(v) (v)
>   #define be_bswap(v, size) glue(__builtin_bswap, size)(v)
>   #define le_bswaps(v, size)
>   #define be_bswaps(p, size) \
> @@ -176,6 +190,7 @@ CPU_CONVERT(le, 64, uint64_t)
>    * size is:
>    *   b: 8 bits
>    *   w: 16 bits
> + *   24: 24 bits
>    *   l: 32 bits
>    *   q: 64 bits
>    *
> @@ -248,6 +263,11 @@ static inline void stw_he_p(void *ptr, uint16_t v)
>       __builtin_memcpy(ptr, &v, sizeof(v));
>   }
>   
> +static inline void st24_he_p(void *ptr, uint32_t v)
> +{
> +    __builtin_memcpy(ptr, &v, 3);
> +}
> +
>   static inline int ldl_he_p(const void *ptr)
>   {
>       int32_t r;
> @@ -297,6 +317,11 @@ static inline void stw_le_p(void *ptr, uint16_t v)
>       stw_he_p(ptr, le_bswap(v, 16));
>   }
>   
> +static inline void st24_le_p(void *ptr, uint32_t v)
> +{
> +    st24_he_p(ptr, le_bswap24(v));
> +}
> +
>   static inline void stl_le_p(void *ptr, uint32_t v)
>   {
>       stl_he_p(ptr, le_bswap(v, 32));


