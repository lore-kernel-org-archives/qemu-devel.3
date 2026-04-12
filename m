Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A81E937EE
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 18:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBzki-0003nR-7C; Sun, 12 Apr 2026 14:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBzkg-0003n3-W7
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 14:41:47 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBzke-0004uF-UH
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 14:41:46 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-483487335c2so39145005e9.2
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 11:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776019302; x=1776624102; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qYDHhqYGM8EcI9vHni2x9bluPdrBGiK5IGQ1JFljEMQ=;
 b=K1PNCOl36N+SBijFLOSVBNxRYc0NZZ/PTK7UAYMs9J9bHsg5gerNBU8dVJBAQEJE3P
 qFDvtcrmgV0ETSdd1g5ZeBI9ay66AsqCseBcWcNMBKf9rUApXZHbKJXXtdh8oOdPPOq0
 LP54zQvzQQZEA2wPUarQnWD24/eLAr388nmLgqGqV6vjazGPqZtb/acTIrNSXxavId95
 xtT/vETgS+n0WoeWD5/OFFvJZVeOrhja5aQBzzgSFU8lLaWR6+2D3BeOklSNgxkBTDdk
 ZrNBSW06yJ+3kmw5rLYRvUIH9Yy+Z8F5XZnYmSzVLm1zi5rNwvA5nTykcGCUaFqrkSum
 IG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776019302; x=1776624102;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qYDHhqYGM8EcI9vHni2x9bluPdrBGiK5IGQ1JFljEMQ=;
 b=rk+YCe/9v8qOMc9ID3n5qjfkU4VObsCJRIqleu2u1gMi6cA+T9SFIaXdAij3o9TCKX
 5sAoFeT3PSkOSNg3fSLakCukLHazMcTO0Y3WgWXo9blUOvvH8BycpF5EKK0l3rJos1uo
 7K3J+ymo+Y/UStFSXg5gPyQDXayGTckJDjnmCwgjgdCsQpBmdxdbcIa0tyOLp2NbF8Cm
 ZB8xGQ6Q5udvI0TF9vgNvdOOl039jckBvD3Um/2VgCM1jvvjHoVsX4bLsmtkUslW68PL
 RhP6zDxKchpAEEWaQSeOjRTxhA6XXHlrBRE/ZsbIexSG7ZcIE/Fx03rRLMIszYjZA53T
 6DaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHUOZ/fFeggqNCHLt2TL9JmgzI7S1zrNoJwbgqz8JziGUwZS4si89pO0BK5DsaVJlKjwETKumdH3Gz@nongnu.org
X-Gm-Message-State: AOJu0YzaDJDrPb1rya0fgt0vz/W8pLa5/z9sq5dhPZQD2R8+DeptzioW
 YseQyvXjCukgQDycVdiHmEsvQQ1rirN/eCelkrLdfEyMprxwghD/UJEEl9rLqHt+5UI=
X-Gm-Gg: AeBDiestoDgFW53ujVntIFDBB6czFT2IZef4WEe3JbyRVCTbN6WPujSAQTiwNY+ljPf
 WEdAsRI2oxxoo6AqW671id3R3x8fMzNYjQngogQXBPx2EXjl2ibeaCKdr1f+mJCTqmHuz/3Hsvj
 iZqbwOXSdowg48Deq9/mDGW0ERPkdWrvM87csU22T4icksKmaLZngviaF7C90nunjQh+KAe2Kmn
 sQRrzHYS5T07zl7V7mdnaH9SERAG8x7Lxc3I5ygZE7TmTqJ9KMDiZ0Ml4TOr/F1J1VLPB2Jh91K
 AJoyN0oXtbC72WR+5Z0goBwwVzTokeDciF3AFiUXJh1HZPIYL5Ia2UmEoVWoxygsxP1X03mENeX
 OYeRh7/2/yJDqHVK8+MmxbwthAA8IyRIFoEaucedY91CNUC4GE73lb6LV9BzOvDrIU2P+zwowQL
 zijWc5wiOjjr9340is1Tyqw3KJvXpL68ftNAu7pvRTiYv3ZssaDHGO9COdoaRljOs5yQ==
X-Received: by 2002:a05:600c:c08e:b0:480:3ad0:93bf with SMTP id
 5b1f17b1804b1-488d6864d41mr98271785e9.24.1776019302036; 
 Sun, 12 Apr 2026 11:41:42 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d531f229sm311316345e9.3.2026.04.12.11.41.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2026 11:41:41 -0700 (PDT)
Message-ID: <25a10fb5-4e3e-41d4-bc92-feba6ea21f3e@linaro.org>
Date: Sun, 12 Apr 2026 20:41:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] target/mips: add Octeon Camellia crypto support
Content-Language: en-US
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20260411070637.72421-1-james.hilliard1@gmail.com>
 <20260411070637.72421-8-james.hilliard1@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260411070637.72421-8-james.hilliard1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 11/4/26 09:06, James Hilliard wrote:
> Add the Octeon Camellia ROUND, FL, and FLINV selectors and model the
> round engine that reuses the AES RESULT/RESINP bank.
> 
> Implement the Camellia F-function and FL layers directly from RFC 3713
> so guest-managed key schedules can drive the engine through the hardware
> interface.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>   target/mips/cpu.h               |   9 +++
>   target/mips/tcg/octeon_crypto.c | 120 ++++++++++++++++++++++++++++++++
>   target/mips/tcg/translate.c     |   3 +
>   3 files changed, 132 insertions(+)
> 
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index 8249b17e8a..69f96172d8 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -595,6 +595,14 @@ typedef enum MIPSOcteonCop2Sel {
>       OCTEON_COP2_SEL_AES_DEC0 = 0x010e,
>       OCTEON_COP2_SEL_AES_KEYLENGTH = 0x0110,
>       OCTEON_COP2_SEL_AES_DAT0 = 0x0111,
> +    /*
> +     * Camellia reuses the AES RESULT/RESINP bank and adds per-round and
> +     * diffusion-layer selectors for the guest-managed key schedule.
> +     */
> +    OCTEON_COP2_SEL_CAMELLIA_RESINP0 = OCTEON_COP2_SEL_AES_RESULT0,
> +    OCTEON_COP2_SEL_CAMELLIA_RESINP1 = OCTEON_COP2_SEL_AES_RESULT1,
> +    OCTEON_COP2_SEL_CAMELLIA_FL = 0x0115,
> +    OCTEON_COP2_SEL_CAMELLIA_FLINV = 0x0116,
>       /*
>        * SMS4 reuses the AES result/input, IV, and key banks and only adds
>        * operation selectors for ECB/CBC encrypt/decrypt.
> @@ -696,6 +704,7 @@ typedef enum MIPSOcteonCop2Sel {
>       OCTEON_COP2_SEL_AES_ENC1 = 0x310b,
>       OCTEON_COP2_SEL_AES_DEC_CBC1 = 0x310d,
>       OCTEON_COP2_SEL_AES_DEC1 = 0x310f,
> +    OCTEON_COP2_SEL_CAMELLIA_ROUND = 0x3114,
>       OCTEON_COP2_SEL_SMS4_ENC_CBC1 = 0x3119,
>       OCTEON_COP2_SEL_SMS4_ENC1 = 0x311b,
>       OCTEON_COP2_SEL_SMS4_DEC_CBC1 = 0x311d,
> diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
> index 317dd89cd2..70cd1ddcac 100644
> --- a/target/mips/tcg/octeon_crypto.c
> +++ b/target/mips/tcg/octeon_crypto.c
> @@ -1584,6 +1584,117 @@ static void octeon_aes_store_block(uint64_t regs[2], const uint8_t *block)
>       regs[1] = ldq_be_p(block + 8);
>   }
>   
> +static const uint8_t octeon_camellia_sbox1[256] = {
> +    112, 130,  44, 236, 179,  39, 192, 229, 228, 133,  87,  53, 234,  12,
> +    174,  65,  35, 239, 107, 147,  69,  25, 165,  33, 237,  14,  79,  78,
> +     29, 101, 146, 189, 134, 184, 175, 143, 124, 235,  31, 206,  62,  48,
> +    220,  95,  94, 197,  11,  26, 166, 225,  57, 202, 213,  71,  93,  61,
> +    217,   1,  90, 214,  81,  86, 108,  77, 139,  13, 154, 102, 251, 204,
> +    176,  45, 116,  18,  43,  32, 240, 177, 132, 153, 223,  76, 203, 194,
> +     52, 126, 118,   5, 109, 183, 169,  49, 209,  23,   4, 215,  20,  88,
> +     58,  97, 222,  27,  17,  28,  50,  15, 156,  22,  83,  24, 242,  34,
> +    254,  68, 207, 178, 195, 181, 122, 145,  36,   8, 232, 168,  96, 252,
> +    105,  80, 170, 208, 160, 125, 161, 137,  98, 151,  84,  91,  30, 149,
> +    224, 255, 100, 210,  16, 196,   0,  72, 163, 247, 117, 219, 138,   3,
> +    230, 218,   9,  63, 221, 148, 135,  92, 131,   2, 205,  74, 144,  51,
> +    115, 103, 246, 243, 157, 127, 191, 226,  82, 155, 216,  38, 200,  55,
> +    198,  59, 129, 150, 111,  75,  19, 190,  99,  46, 233, 121, 167, 140,
> +    159, 110, 188, 142,  41, 245, 249, 182,  47, 253, 180,  89, 120, 152,
> +      6, 106, 231,  70, 113, 186, 212,  37, 171,  66, 136, 162, 141, 250,
> +    114,   7, 185,  85, 248, 238, 172,  10,  54,  73,  42, 104,  60,  56,
> +    241, 164,  64,  40, 211, 123, 187, 201,  67, 193,  21, 227, 173, 244,
> +    119, 199, 128, 158,
> +};
> +
> +static inline uint8_t octeon_camellia_rotl8(uint8_t v, unsigned int shift)
> +{
> +    return (v << shift) | (v >> (8 - shift));
> +}
> +
> +static inline uint8_t octeon_camellia_sbox2(uint8_t x)
> +{
> +    return octeon_camellia_rotl8(octeon_camellia_sbox1[x], 1);
> +}
> +
> +static inline uint8_t octeon_camellia_sbox3(uint8_t x)
> +{
> +    return octeon_camellia_rotl8(octeon_camellia_sbox1[x], 7);
> +}
> +
> +static inline uint8_t octeon_camellia_sbox4(uint8_t x)
> +{
> +    return octeon_camellia_sbox1[octeon_camellia_rotl8(x, 1)];
> +}
> +
> +static uint64_t octeon_camellia_f(uint64_t input, uint64_t key)
> +{
> +    uint64_t x = input ^ key;
> +    uint8_t t1 = octeon_camellia_sbox1[x >> 56];
> +    uint8_t t2 = octeon_camellia_sbox2((x >> 48) & 0xff);
> +    uint8_t t3 = octeon_camellia_sbox3((x >> 40) & 0xff);
> +    uint8_t t4 = octeon_camellia_sbox4((x >> 32) & 0xff);
> +    uint8_t t5 = octeon_camellia_sbox2((x >> 24) & 0xff);
> +    uint8_t t6 = octeon_camellia_sbox3((x >> 16) & 0xff);
> +    uint8_t t7 = octeon_camellia_sbox4((x >> 8) & 0xff);
> +    uint8_t t8 = octeon_camellia_sbox1[x & 0xff];
> +    uint8_t y1 = t1 ^ t3 ^ t4 ^ t6 ^ t7 ^ t8;
> +    uint8_t y2 = t1 ^ t2 ^ t4 ^ t5 ^ t7 ^ t8;
> +    uint8_t y3 = t1 ^ t2 ^ t3 ^ t5 ^ t6 ^ t8;
> +    uint8_t y4 = t2 ^ t3 ^ t4 ^ t5 ^ t6 ^ t7;
> +    uint8_t y5 = t1 ^ t2 ^ t6 ^ t7 ^ t8;
> +    uint8_t y6 = t2 ^ t3 ^ t5 ^ t7 ^ t8;
> +    uint8_t y7 = t3 ^ t4 ^ t5 ^ t6 ^ t8;
> +    uint8_t y8 = t1 ^ t4 ^ t5 ^ t6 ^ t7;
> +
> +    return ((uint64_t)y1 << 56) | ((uint64_t)y2 << 48) |
> +           ((uint64_t)y3 << 40) | ((uint64_t)y4 << 32) |
> +           ((uint64_t)y5 << 24) | ((uint64_t)y6 << 16) |
> +           ((uint64_t)y7 << 8) | y8;
> +}
> +
> +static uint64_t octeon_camellia_fl(uint64_t input, uint64_t key)
> +{
> +    uint32_t x1 = input >> 32;
> +    uint32_t x2 = input;
> +    uint32_t k1 = key >> 32;
> +    uint32_t k2 = key;
> +
> +    x2 ^= rol32(x1 & k1, 1);
> +    x1 ^= x2 | k2;
> +    return ((uint64_t)x1 << 32) | x2;
> +}
> +
> +static uint64_t octeon_camellia_flinv(uint64_t input, uint64_t key)
> +{
> +    uint32_t y1 = input >> 32;
> +    uint32_t y2 = input;
> +    uint32_t k1 = key >> 32;
> +    uint32_t k2 = key;
> +
> +    y1 ^= y2 | k2;
> +    y2 ^= rol32(y1 & k1, 1);
> +    return ((uint64_t)y1 << 32) | y2;
> +}

The previous helper aren't Octeon specific. Maybe remove the 'octeon_'
prefix in case we reuse them elsewhere?

Otherwise patch LGTM.

> +static void octeon_camellia_round(MIPSOcteonCryptoState *crypto, uint64_t key)
> +{
> +    uint64_t left = crypto->aes_result[0];
> +    uint64_t right = crypto->aes_result[1];
> +
> +    crypto->aes_result[0] = right ^ octeon_camellia_f(left, key);
> +    crypto->aes_result[1] = left;
> +}
> +
> +static void octeon_camellia_fl_layer(MIPSOcteonCryptoState *crypto,
> +                                     uint64_t key, bool inverse)
> +{
> +    uint64_t state = crypto->aes_result[inverse ? 1 : 0];
> +
> +    crypto->aes_result[inverse ? 1 : 0] = inverse ?
> +        octeon_camellia_flinv(state, key) :
> +        octeon_camellia_fl(state, key);
> +}
> +
>   static void octeon_sms4_crypt_common(MIPSOcteonCryptoState *crypto,
>                                        bool encrypt, bool cbc)
>   {
> @@ -1977,6 +2088,12 @@ void helper_octeon_cop2_dmtc2(CPUMIPSState *env, target_ulong value,
>       case OCTEON_COP2_SEL_AES_KEYLENGTH:
>           crypto->aes_keylen = q;
>           break;
> +    case OCTEON_COP2_SEL_CAMELLIA_FL:
> +        octeon_camellia_fl_layer(crypto, q, false);
> +        break;
> +    case OCTEON_COP2_SEL_CAMELLIA_FLINV:
> +        octeon_camellia_fl_layer(crypto, q, true);
> +        break;
>       case OCTEON_COP2_SEL_CRC_WRITE_POLYNOMIAL:
>       case OCTEON_COP2_SEL_CRC_WRITE_POLYNOMIAL_REFLECT:
>           crypto->crc_poly = q;
> @@ -2164,6 +2281,9 @@ void helper_octeon_cop2_dmtc2(CPUMIPSState *env, target_ulong value,
>           crypto->aes_input[1] = q;
>           octeon_aes_decrypt_common(crypto, false);
>           break;
> +    case OCTEON_COP2_SEL_CAMELLIA_ROUND:
> +        octeon_camellia_round(crypto, q);
> +        break;
>       case OCTEON_COP2_SEL_SMS4_ENC_CBC1:
>           crypto->aes_input[1] = q;
>           octeon_sms4_crypt_common(crypto, true, true);
> diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
> index 39fad07adc..625faae9d1 100644
> --- a/target/mips/tcg/translate.c
> +++ b/target/mips/tcg/translate.c
> @@ -9218,6 +9218,8 @@ static bool octeon_cop2_is_supported_dmtc2(uint16_t sel)
>       case OCTEON_COP2_SEL_AES_DEC_CBC0:
>       case OCTEON_COP2_SEL_AES_DEC0:
>       case OCTEON_COP2_SEL_AES_KEYLENGTH:
> +    case OCTEON_COP2_SEL_CAMELLIA_FL:
> +    case OCTEON_COP2_SEL_CAMELLIA_FLINV:
>       case OCTEON_COP2_SEL_CRC_WRITE_POLYNOMIAL:
>       case OCTEON_COP2_SEL_CRC_IV:
>       case OCTEON_COP2_SEL_CRC_WRITE_LEN:
> @@ -9313,6 +9315,7 @@ static bool octeon_cop2_is_supported_dmtc2(uint16_t sel)
>       case OCTEON_COP2_SEL_AES_ENC1:
>       case OCTEON_COP2_SEL_AES_DEC_CBC1:
>       case OCTEON_COP2_SEL_AES_DEC1:
> +    case OCTEON_COP2_SEL_CAMELLIA_ROUND:
>       case OCTEON_COP2_SEL_SMS4_ENC_CBC1:
>       case OCTEON_COP2_SEL_SMS4_ENC1:
>       case OCTEON_COP2_SEL_SMS4_DEC_CBC1:


