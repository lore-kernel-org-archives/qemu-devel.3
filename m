Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4D6606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 09:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key, unprotected) header.d=ilande.co.uk header.i=@ilande.co.uk header.a=rsa-sha256 header.s=20220518 header.b=vujUdwFE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN539-00044f-3i; Sat, 31 Oct 2026 05:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xN535-00044I-34
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 05:06:51 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xN533-0004v2-7H
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 05:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=bRJ+BvLe/parBpI9QLuLAeGwRiQNV4v+nOSc3u4C6Kc=; b=vujUdwFEjkkGDW0ArQ8rlB/J+P
 c46CbiLXWwuzgEXMgm0zOkuDidl3H/Z8vdXryIWUOQpkHrdNGA7akIc+IFBI+iUu8ZQxhuB1VaGCI
 v/9CAh8/0K0mkdhzoCjIs0ZUkfBqTTCpuaUMB5rqGqJ7MuOG6K9YzwNoRYzcMDeGAyBca+VptO+WO
 MkQ5VBeq7pgCcB/cFilkf377O1/9TrK3dooj01sQoFMORlQHAVnL5APNHdxcdSZPO0KhLvx1LEerl
 e5Ol2bcVizjW1JtOMJ+wePijzUDeaijxfjjPD/PBka63Kq2vdbTUAqobbGMEywdBe3rnzsoJCaahl
 jhg+dspcdc/YYq/tJgfket6t6b3snzfnp8o1v51uHFxNc03OK71OzAMkueitMxG3IbmtkuMxUUx9Z
 48KZdYmid9n2QEw+sewTyP3kUmmgIPItJ+5JQuNcHCxqFDgLacCONIdSUSSGPnhIdAFirDqFlpXrt
 r69iz6Zu7DQIGKNl06Bro3vqR39hFYWmgbl+xgOY5LnGvOKbLmmXOrOX8465vDCOAR+gGCOGgUu4V
 OnW1qXl7WMWeZuNm6TY4nvizxzjL9weQezSWWf2Zi7ItNYPdqYO45CdWBp0f38nlRlqD2Ak8IijHJ
 Pa+Mobuq8XsegbRl6S4AZIK2AjhP7m52+QYWwmmM8=;
Received: from [2a02:8012:2f01:0:fe49:60b9:9856:b8ef]
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xN52G-004tNZ-5w; Sat, 31 Oct 2026 09:06:00 +0000
Message-ID: <ca0df428-9726-4b36-938f-cd3678aec697@ilande.co.uk>
Date: Sat, 31 Oct 2026 09:06:43 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Stian Halseth <stian@itx.no>, qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20261028190729.1941434-1-stian@itx.no>
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
In-Reply-To: <20261028190729.1941434-1-stian@itx.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:fe49:60b9:9856:b8ef
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] hw/sparc64: Pass hwcap-list to OpenBIOS via fw_cfg
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

On 28/10/2026 19:07, Stian Halseth wrote:

> Linux needs hwcap-list to enable crypto instructions, but only sun4v
> firmware provides it.
> 
> When the CPU has crypto, pass the list through fw_cfg for OpenBIOS
> to copy onto the cpu node. Include the capabilities linux-user reports,
> since Linux trusts the list instead of guessing.
> 
> Without crypto, nothing changes.
> 
> Signed-off-by: Stian Halseth <stian@itx.no>
> ---
> Based-on: <20261028113816.1651212-1-stian@itx.no>
> 
> This exposes the crypto hwcap to guests, so it should land after the
> block-init series, which glibc's memset needs.
> 
> The OpenBIOS side, which copies the file onto the cpu node, is on the
> OpenBIOS list as "SPARC64: set hwcap-list on the cpu node from fw_cfg".
> The kernel change to read the property on sun4u goes to sparclinux.
> 
>   hw/sparc64/sun4u.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 46 insertions(+)
> 
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index a348096aee..7e38a55102 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -121,6 +121,51 @@ static void fw_cfg_boot_set(void *opaque, const char *boot_device,
>       fw_cfg_modify_i16(opaque, FW_CFG_BOOT_DEVICE, boot_device[0]);
>   }
>   
> +/*
> + * OpenBIOS copies this list to the cpu node's hwcap-list property
> + * for Linux, which gets it from the machine description on sun4v.
> + */

I wonder if we need to make it more obvious via the property name that this is 
something that is not present on real hardware? As a lot of people use QEMU for 
testing SPARC installations, we should make sure that people understand this property 
is not expected to be present outside of an emulated environment.

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
> +        { CPU_FEATURE_CRYPTO, "aes" },
> +        { CPU_FEATURE_CRYPTO, "sha1" },
> +        { CPU_FEATURE_CRYPTO, "sha256" },
> +        { CPU_FEATURE_CRYPTO, "sha512" },
> +        { CPU_FEATURE_CRYPTO, "crc32c" },
> +    };

For the existing CPU features we have a direct mapping between the feature and the 
name, but for crypto it is split into individual instruction groups. Presumably this 
is because the crypto instruction implementation is incomplete?

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
> @@ -717,6 +762,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>       fw_cfg_add_i16(fw_cfg, FW_CFG_SPARC64_WIDTH, graphic_width);
>       fw_cfg_add_i16(fw_cfg, FW_CFG_SPARC64_HEIGHT, graphic_height);
>       fw_cfg_add_i16(fw_cfg, FW_CFG_SPARC64_DEPTH, graphic_depth);
> +    fw_cfg_build_hwcap_list(fw_cfg, cpu);
>   
>       qemu_register_boot_set(fw_cfg_boot_set, fw_cfg);


ATB,

Mark.


