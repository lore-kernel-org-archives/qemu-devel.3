Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2356C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 20:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxXzL-0004Ac-FQ; Thu, 18 Apr 2024 16:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rxXzJ-00040t-Rz
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 16:04:05 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rxXzH-0005WW-Od
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 16:04:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zh6bwDMg9wSO13XE1xlNhBYynGq63LizwSUV97VeoZA=; b=vM407O4paQHzqS2t0kK99U5JYK
 UjwkXl5HHJy2qmhgRalHsD4ZfCII2fp2AaTDpoXLgimypjqXsUOPGX3lB1udH/b2yVlTEUp7bpoW6
 +JwWRLAYVo83tF+9cwHiu+Kf3dJAzyWk1o4w5UREBsMM8MZMElgHQHYLarG0MxakjqCHZ+/3HKt3P
 jeDaqyY6iGqP2yBKZ30HymKRmTqvPW3zqTaNKew6fuek+5p9Dnt4TeEED8CCnSrUUDjbdkwUAn6HJ
 MVeMZvhwmJgK1GfRCBv5B8rrC+SKkYeeFUZSo0FhADBQ+ubeDM5iBwF6Lz+yZdm6XEHIZGZnlM0oO
 /N7ThiW52D04ji2Ds4G527d6AkOcqylSKmDvL9m6TwPuHpCev05yaniKj2UeG7jBW7uYr4qH99+kr
 Nn5B05nxx2/r2wks+wStcxaPzmOq5Yj6EDCH1lbzPZIVrBi8ZOY8lJPs7FNIN+TbnUVBo/uihIaJy
 7SLiVV/MUjeaj39iAtyouycvH5BuVQSIRFtGQaGMBkQucwba7BPTwEkEAAMPzPCyg96WTp22pyMwM
 fEHvsx6RtuLaTIxmZ1/GI1Nmwc1sAMioKWRTPH5GUltlEUchS2Ixcql6lDTf1PJn6SVyZVImokRAe
 ui91SI8edDWUweDoFgcYlRYSMpldZmYMJsBC0rgKY=;
Received: from [2a00:23c4:8bb4:4000:aae1:b0e7:6998:7ece]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rxXyA-00067w-UU; Thu, 18 Apr 2024 21:02:59 +0100
Message-ID: <91bc6db9-7270-4bfb-a0e6-22988dbfcd9f@ilande.co.uk>
Date: Thu, 18 Apr 2024 21:03:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240307174334.130407-1-thuth@redhat.com>
 <20240307174334.130407-2-thuth@redhat.com>
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
In-Reply-To: <20240307174334.130407-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:aae1:b0e7:6998:7ece
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 1/5] target/sparc/cpu: Rename the CPU models with a "+" in
 their names
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
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

On 07/03/2024 17:43, Thomas Huth wrote:

> Commit b447378e12 ("qom/object: Limit type names to alphanumerical ...")
> cut down the amount of allowed characters for QOM types to a saner set.
> The "+" character was not meant to be included in this set, so we had
> to add a hack there to still allow the legacy names of POWER and Sparc64
> CPUs. However, instead of putting such a hack in the common QOM code,
> there is a much better place to do this: The sparc_cpu_class_by_name()
> function which is used to look up the names of all Sparc CPUs.
> Thus let's finally get rid of the "+" in the Sparc CPU names, and provide
> backward compatibility for the old names via some simple checks in the
> sparc_cpu_class_by_name() function.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   qom/object.c       |  8 --------
>   target/sparc/cpu.c | 14 ++++++++++++--
>   2 files changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/qom/object.c b/qom/object.c
> index d4a001cf41..759e194972 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -158,14 +158,6 @@ static bool type_name_is_valid(const char *name)
>                           "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
>                           "0123456789-_.");
>   
> -    /* Allow some legacy names with '+' in it for compatibility reasons */
> -    if (name[plen] == '+') {
> -        if (plen >= 17 && g_str_has_prefix(name, "Sun-UltraSparc-I")) {
> -            /* Allow "Sun-UltraSparc-IV+" and "Sun-UltraSparc-IIIi+" */
> -            return true;
> -        }
> -    }
> -
>       return plen == slen;
>   }
>   
> diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
> index 313ebc4c11..651e49bfeb 100644
> --- a/target/sparc/cpu.c
> +++ b/target/sparc/cpu.c
> @@ -316,7 +316,7 @@ static const sparc_def_t sparc_defs[] = {
>           .features = CPU_DEFAULT_FEATURES,
>       },
>       {
> -        .name = "Sun UltraSparc IV+",
> +        .name = "Sun UltraSparc IVp",
>           .iu_version = ((0x3eULL << 48) | (0x19ULL << 32) | (0x22ULL << 24)),
>           .fpu_version = 0x00000000,
>           .mmu_version = mmu_us_12,
> @@ -325,7 +325,7 @@ static const sparc_def_t sparc_defs[] = {
>           .features = CPU_DEFAULT_FEATURES | CPU_FEATURE_CMT,
>       },
>       {
> -        .name = "Sun UltraSparc IIIi+",
> +        .name = "Sun UltraSparc IIIip",
>           .iu_version = ((0x3eULL << 48) | (0x22ULL << 32) | (0ULL << 24)),
>           .fpu_version = 0x00000000,
>           .mmu_version = mmu_us_3,
> @@ -767,6 +767,16 @@ static ObjectClass *sparc_cpu_class_by_name(const char *cpu_model)
>       char *typename;
>   
>       typename = sparc_cpu_type_name(cpu_model);
> +
> +    /* Fix up legacy names with '+' in it */
> +    if (g_str_equal(typename, SPARC_CPU_TYPE_NAME("Sun-UltraSparc-IV+"))) {
> +        g_free(typename);
> +        typename = g_strdup(SPARC_CPU_TYPE_NAME("Sun-UltraSparc-IVp"));
> +    } else if (g_str_equal(typename, SPARC_CPU_TYPE_NAME("Sun-UltraSparc-IIIi+"))) {
> +        g_free(typename);
> +        typename = g_strdup(SPARC_CPU_TYPE_NAME("Sun-UltraSparc-IIIip"));
> +    }
> +
>       oc = object_class_by_name(typename);
>       g_free(typename);
>       return oc;

I've seen some references in Sun documentation to processors in the form "UltraSparc 
IIIi plus" so I'd be inclined to use that form for the new type names e.g. 
"UltraSparc-IIIi-plus".

Otherwise looks good to me, thanks for having a look at this!

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


