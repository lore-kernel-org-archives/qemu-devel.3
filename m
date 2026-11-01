Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF97C606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 13:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key, unprotected) header.d=ilande.co.uk header.i=@ilande.co.uk header.a=rsa-sha256 header.s=20220518 header.b=N0Daw6La
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNVYN-00061Y-Dd; Sun, 01 Nov 2026 08:24:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xNVYE-00061F-Lq
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 08:24:48 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xNVYC-0001sV-Kj
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 08:24:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=fYtUshqMa4Mz4ezJdtPYUwwD2GAhmfQs/131yb1od3Y=; b=N0Daw6LaoxVeEOabQSVM/e5c7Q
 TQqooisS7bciwfDrRhW5zlWQXMJj4s33+umcMzAxg8j+5iOzInKg4kZmJ124Kq0c9lAAvaWK24rlI
 a9C3smpe7U0CADvqheJZRKArzQE/aJnydAlcCK/97lAelpYy2NorkVuOfzAlpzTLmLfT/uROke2zt
 MxQbENcjd/eCsSUVB7jSCBb+aJRJDk8i9pPziLukfiwYJWJYlqVVQZZPJJm1/JoqwbPElNK+t1Hc4
 t0lBaSX9nO9Gf+Qvush28p2CDzhSb6iG9UCXtC9exFYWtZg3n4KhHFM0ALepZC3ntDu/Za+VCg+da
 cl/Ea7OgjnHHE4gYdqn6vHjK/GXDnGYmW6oiIm0KFfYzdfIYbFfoYQpYZv4Lgc/z2SnOrajfHGalF
 32I/98PYuKw/R6SZBAkG+QUDTrKVDrKbt8sfR6tiITDBDAS+EVA3+8LrZRBh2FOgqItAtkeAySuLc
 QdVj6P6gwqQ2OzFVK/++g4q5cwSC/UF0s8r1RuXrWW7KF0kBznSWIeXnO+q1/Bp/H/XtnmwPipbXC
 vzH48h6GhbOzgwRvs6+0R9i5zgurVevSChI8Nyegm3Jxal5w8PxQxZv2DF35qXsZBmNEvgOtHdYzS
 5B6F55vTPdXMyZWVAkBHVGVsZ27LEmxTc2hP6svU8=;
Received: from [2a02:8012:2f01:0:fe49:60b9:9856:b8ef]
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xNVXJ-0054qo-Rg; Sun, 01 Nov 2026 13:23:50 +0000
Message-ID: <7a40ba68-3ed0-4ff9-9d7c-2cfc04615f13@ilande.co.uk>
Date: Sun, 1 Nov 2026 13:24:29 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Stian Halseth <stian@itx.no>, qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20261031094841.3407049-1-stian@itx.no>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <20261031094841.3407049-1-stian@itx.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:fe49:60b9:9856:b8ef
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2] hw/sparc64: Pass hwcap-list to OpenBIOS via fw_cfg
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 31/10/2026 09:48, Stian Halseth wrote:

> Linux needs hwcap-list to enable crypto instructions, but only sun4v
> firmware provides it.
> 
> When the CPU has crypto, pass the list through fw_cfg for OpenBIOS
> to copy onto the cpu node as qemu,hwcap-list. Include the capabilities
> linux-user reports, since Linux trusts the list instead of guessing.
> 
> Without crypto, nothing changes.
> 
> Signed-off-by: Stian Halseth <stian@itx.no>
> ---
> v2:
> - The property is now "qemu,hwcap-list", to mark it as emulator-only
>    (Mark). The fw_cfg file name is unchanged.
> - Comment that the crypto entries are the groups in the CFR value (Mark)
> 
> v1: https://lore.kernel.org/qemu-devel/20261028190729.1941434-1-stian@itx.no/
> 
> Based-on: <20261028113816.1651212-1-stian@itx.no>
> 
> This exposes the crypto hwcap to guests, so it should land after the
> block-init series, which glibc's memset needs.
> 
> The OpenBIOS side, v2 with the same rename, is on the OpenBIOS list as
> "SPARC64: set qemu,hwcap-list on the cpu node from fw_cfg". The kernel
> change to read the property on sun4u goes to sparclinux.
> 
>   hw/sparc64/sun4u.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 47 insertions(+)
> 
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index a348096aee..1057c59152 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -121,6 +121,52 @@ static void fw_cfg_boot_set(void *opaque, const char *boot_device,
>       fw_cfg_modify_i16(opaque, FW_CFG_BOOT_DEVICE, boot_device[0]);
>   }
>   
> +/*
> + * OpenBIOS copies this list to the cpu node's qemu,hwcap-list property
> + * for Linux, which gets it from the machine description on sun4v.
> + */
> +static void fw_cfg_build_hwcap_list(FWCfgState *fw_cfg, SPARCCPU *cpu)
> +{
> +    static const struct {
> +        uint32_t mask;
> +        const char *name;
> +    } capabilities[] = {
> +        { 0, "popc" },
> +        { CPU_FEATURE_FSMULD, "fsmuld" },
> +        { CPU_FEATURE_VIS1, "vis" },
> +        { CPU_FEATURE_VIS2, "vis2" },
> +        { CPU_FEATURE_FMAF, "fmaf" },
> +        { CPU_FEATURE_VIS3, "vis3" },
> +        { CPU_FEATURE_IMA, "ima" },
> +        /* The groups in the CFR value, see CFR_* in target/sparc/translate.c */
> +        { CPU_FEATURE_CRYPTO, "aes" },
> +        { CPU_FEATURE_CRYPTO, "sha1" },
> +        { CPU_FEATURE_CRYPTO, "sha256" },
> +        { CPU_FEATURE_CRYPTO, "sha512" },
> +        { CPU_FEATURE_CRYPTO, "crc32c" },
> +    };
> +    uint32_t features = cpu->env.def.features;
> +    GByteArray *array;
> +    size_t len;
> +
> +    if (!(features & CPU_FEATURE_CRYPTO)) {
> +        return;
> +    }
> +
> +    array = g_byte_array_new();
> +    for (size_t i = 0; i < ARRAY_SIZE(capabilities); i++) {
> +        if ((features & capabilities[i].mask) == capabilities[i].mask) {
> +            const char *name = capabilities[i].name;
> +
> +            g_byte_array_append(array, (const guint8 *)name, strlen(name) + 1);
> +        }
> +    }
> +
> +    len = array->len;
> +    fw_cfg_add_file(fw_cfg, "etc/sparc64/hwcap-list",
> +                    g_byte_array_free(array, FALSE), len);
> +}
> +
>   static int sun4u_NVRAM_set_params(Nvram *nvram, uint16_t NVRAM_size,
>                                     const char *arch, ram_addr_t RAM_size,
>                                     const char *boot_devices,
> @@ -717,6 +763,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>       fw_cfg_add_i16(fw_cfg, FW_CFG_SPARC64_WIDTH, graphic_width);
>       fw_cfg_add_i16(fw_cfg, FW_CFG_SPARC64_HEIGHT, graphic_height);
>       fw_cfg_add_i16(fw_cfg, FW_CFG_SPARC64_DEPTH, graphic_depth);
> +    fw_cfg_build_hwcap_list(fw_cfg, cpu);
>   
>       qemu_register_boot_set(fw_cfg_boot_set, fw_cfg);

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


