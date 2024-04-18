Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4499C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 20:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxY1I-0001sd-Nh; Thu, 18 Apr 2024 16:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rxY0r-0001Yu-UW
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 16:05:43 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rxY0o-0005xt-MK
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 16:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xhhD3IECtU0BCujjzclsJSORHYThxX7WfpLijEuYieg=; b=hOU1rN7A97p+XsCmrW/9YY/hxJ
 F1KVg+U7OOQM6dDD4Mw9J/4RGJh4NmbxxL3dCRgEJtTcC0UUkUE4t8cnix+rWsUIoFQOEQWG4DPXw
 DN6VRYAS0p4IHfsahcGkBfRVf5a+nlWIVDub00AyNOjj/tURPnbiTP+VhY0uEKLdnjXNe4EP4m6k1
 PO3KiUa/54aeRdmpuOMBSm9iK7ca9SKyxvUnb/WupKM+sxuA96foTXb9SWJdC1ByAHuXkU9yBimbl
 ROrpnR49IukSypB4fLQhcVVTBB2z6c1N/qtm/y8ehgRHY37jkKdjVhY/68KakHpOAUHjU5YChkceC
 9F6t0N9r8nRyjpG/oOBRWoaA1sTMylLmXEHT4yRjRbmYomwntr0+wYSWHKSe/QNcd4NYduCpuzODA
 5N2IXiGCT3yTGhrOa3Ly2XE59bLODOrArXcK6s7c0patKjYSeABeomA5LPhYNhnJ4ynDV8BD9ABnT
 N2jFbMy0+ChBQRHJPIQBxvFmhd39Wz66HVQaRg677YX0tzYAIw0/F9gLjlbaTnVjqr8vovuM4HS1J
 Py2RzbzEvG2SPmOKrV4QDbgnwksQFTC5xALAMzyrMarcnY/f3sWJZJy+ARED35MGyBoFY53vAfgZi
 IjtJ+rmZSZW20Qo9AQW+TUTA1vzBdiv9TVU2hdz4A=;
Received: from [2a00:23c4:8bb4:4000:aae1:b0e7:6998:7ece]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rxXzl-00069m-CK; Thu, 18 Apr 2024 21:04:37 +0100
Message-ID: <9f07a313-d326-4fa9-9f4c-786e4347ec8d@ilande.co.uk>
Date: Thu, 18 Apr 2024 21:05:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240307174334.130407-1-thuth@redhat.com>
 <20240307174334.130407-3-thuth@redhat.com>
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
In-Reply-To: <20240307174334.130407-3-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:aae1:b0e7:6998:7ece
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 2/5] target/sparc/cpu: Avoid spaces by default in the CPU
 names
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

> The output of "-cpu help" is currently rather confusing to the users:
> It is not clear which part of the output defines the CPU names since
> the CPU names contain white spaces (which we later have to convert
> into dashes internally) For example:
> 
> Sparc TI UltraSparc II IU 0017001120000000 FPU 00000000 MMU 00000000 NWINS 8
> 
> At a first glance, should the name for -cpu be "Sparc TI Ultrasparc II"
> or "TI UltraSparc II IU" here? Both would be wrong, the right guess is
> "TI UltraSparc II" only. Let's start cleaning up this mess by using
> dashes instead of white spaces for the CPU names, like we're doing it
> internally later (and like we're doing it in most other targets of QEMU).
> Note that it is still possible to pass the CPU names with spaces to the
> "-cpu" option, since sparc_cpu_type_name() still translates those to "-".
> 
> Buglink: https://gitlab.com/qemu-project/qemu/-/issues/2141
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   target/sparc/cpu.c | 56 +++++++++++++++++++++++-----------------------
>   1 file changed, 28 insertions(+), 28 deletions(-)
> 
> diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
> index 651e49bfeb..ae30cded22 100644
> --- a/target/sparc/cpu.c
> +++ b/target/sparc/cpu.c
> @@ -208,7 +208,7 @@ void cpu_sparc_set_id(CPUSPARCState *env, unsigned int cpu)
>   static const sparc_def_t sparc_defs[] = {
>   #ifdef TARGET_SPARC64
>       {
> -        .name = "Fujitsu Sparc64",
> +        .name = "Fujitsu-Sparc64",
>           .iu_version = ((0x04ULL << 48) | (0x02ULL << 32) | (0ULL << 24)),
>           .fpu_version = 0x00000000,
>           .mmu_version = mmu_us_12,
> @@ -217,7 +217,7 @@ static const sparc_def_t sparc_defs[] = {
>           .features = CPU_DEFAULT_FEATURES,
>       },
>       {
> -        .name = "Fujitsu Sparc64 III",
> +        .name = "Fujitsu-Sparc64-III",
>           .iu_version = ((0x04ULL << 48) | (0x03ULL << 32) | (0ULL << 24)),
>           .fpu_version = 0x00000000,
>           .mmu_version = mmu_us_12,
> @@ -226,7 +226,7 @@ static const sparc_def_t sparc_defs[] = {
>           .features = CPU_DEFAULT_FEATURES,
>       },
>       {
> -        .name = "Fujitsu Sparc64 IV",
> +        .name = "Fujitsu-Sparc64-IV",
>           .iu_version = ((0x04ULL << 48) | (0x04ULL << 32) | (0ULL << 24)),
>           .fpu_version = 0x00000000,
>           .mmu_version = mmu_us_12,
> @@ -235,7 +235,7 @@ static const sparc_def_t sparc_defs[] = {
>           .features = CPU_DEFAULT_FEATURES,
>       },
>       {
> -        .name = "Fujitsu Sparc64 V",
> +        .name = "Fujitsu-Sparc64-V",
>           .iu_version = ((0x04ULL << 48) | (0x05ULL << 32) | (0x51ULL << 24)),
>           .fpu_version = 0x00000000,
>           .mmu_version = mmu_us_12,
> @@ -244,7 +244,7 @@ static const sparc_def_t sparc_defs[] = {
>           .features = CPU_DEFAULT_FEATURES,
>       },
>       {
> -        .name = "TI UltraSparc I",
> +        .name = "TI-UltraSparc-I",
>           .iu_version = ((0x17ULL << 48) | (0x10ULL << 32) | (0x40ULL << 24)),
>           .fpu_version = 0x00000000,
>           .mmu_version = mmu_us_12,
> @@ -253,7 +253,7 @@ static const sparc_def_t sparc_defs[] = {
>           .features = CPU_DEFAULT_FEATURES,
>       },
>       {
> -        .name = "TI UltraSparc II",
> +        .name = "TI-UltraSparc-II",
>           .iu_version = ((0x17ULL << 48) | (0x11ULL << 32) | (0x20ULL << 24)),
>           .fpu_version = 0x00000000,
>           .mmu_version = mmu_us_12,
> @@ -262,7 +262,7 @@ static const sparc_def_t sparc_defs[] = {
>           .features = CPU_DEFAULT_FEATURES,
>       },
>       {
> -        .name = "TI UltraSparc IIi",
> +        .name = "TI-UltraSparc-IIi",
>           .iu_version = ((0x17ULL << 48) | (0x12ULL << 32) | (0x91ULL << 24)),
>           .fpu_version = 0x00000000,
>           .mmu_version = mmu_us_12,
> @@ -271,7 +271,7 @@ static const sparc_def_t sparc_defs[] = {
>           .features = CPU_DEFAULT_FEATURES,
>       },
>       {
> -        .name = "TI UltraSparc IIe",
> +        .name = "TI-UltraSparc-IIe",
>           .iu_version = ((0x17ULL << 48) | (0x13ULL << 32) | (0x14ULL << 24)),
>           .fpu_version = 0x00000000,
>           .mmu_version = mmu_us_12,
> @@ -280,7 +280,7 @@ static const sparc_def_t sparc_defs[] = {
>           .features = CPU_DEFAULT_FEATURES,
>       },
>       {
> -        .name = "Sun UltraSparc III",
> +        .name = "Sun-UltraSparc-III",
>           .iu_version = ((0x3eULL << 48) | (0x14ULL << 32) | (0x34ULL << 24)),
>           .fpu_version = 0x00000000,
>           .mmu_version = mmu_us_12,
> @@ -289,7 +289,7 @@ static const sparc_def_t sparc_defs[] = {
>           .features = CPU_DEFAULT_FEATURES,
>       },
>       {
> -        .name = "Sun UltraSparc III Cu",
> +        .name = "Sun-UltraSparc-III-Cu",
>           .iu_version = ((0x3eULL << 48) | (0x15ULL << 32) | (0x41ULL << 24)),
>           .fpu_version = 0x00000000,
>           .mmu_version = mmu_us_3,
> @@ -298,7 +298,7 @@ static const sparc_def_t sparc_defs[] = {
>           .features = CPU_DEFAULT_FEATURES,
>       },
>       {
> -        .name = "Sun UltraSparc IIIi",
> +        .name = "Sun-UltraSparc-IIIi",
>           .iu_version = ((0x3eULL << 48) | (0x16ULL << 32) | (0x34ULL << 24)),
>           .fpu_version = 0x00000000,
>           .mmu_version = mmu_us_12,
> @@ -307,7 +307,7 @@ static const sparc_def_t sparc_defs[] = {
>           .features = CPU_DEFAULT_FEATURES,
>       },
>       {
> -        .name = "Sun UltraSparc IV",
> +        .name = "Sun-UltraSparc-IV",
>           .iu_version = ((0x3eULL << 48) | (0x18ULL << 32) | (0x31ULL << 24)),
>           .fpu_version = 0x00000000,
>           .mmu_version = mmu_us_4,
> @@ -316,7 +316,7 @@ static const sparc_def_t sparc_defs[] = {
>           .features = CPU_DEFAULT_FEATURES,
>       },
>       {
> -        .name = "Sun UltraSparc IVp",
> +        .name = "Sun-UltraSparc-IVp",
>           .iu_version = ((0x3eULL << 48) | (0x19ULL << 32) | (0x22ULL << 24)),
>           .fpu_version = 0x00000000,
>           .mmu_version = mmu_us_12,
> @@ -325,7 +325,7 @@ static const sparc_def_t sparc_defs[] = {
>           .features = CPU_DEFAULT_FEATURES | CPU_FEATURE_CMT,
>       },
>       {
> -        .name = "Sun UltraSparc IIIip",
> +        .name = "Sun-UltraSparc-IIIip",
>           .iu_version = ((0x3eULL << 48) | (0x22ULL << 32) | (0ULL << 24)),
>           .fpu_version = 0x00000000,
>           .mmu_version = mmu_us_3,
> @@ -334,7 +334,7 @@ static const sparc_def_t sparc_defs[] = {
>           .features = CPU_DEFAULT_FEATURES,
>       },
>       {
> -        .name = "Sun UltraSparc T1",
> +        .name = "Sun-UltraSparc-T1",
>           /* defined in sparc_ifu_fdp.v and ctu.h */
>           .iu_version = ((0x3eULL << 48) | (0x23ULL << 32) | (0x02ULL << 24)),
>           .fpu_version = 0x00000000,
> @@ -345,7 +345,7 @@ static const sparc_def_t sparc_defs[] = {
>           | CPU_FEATURE_GL,
>       },
>       {
> -        .name = "Sun UltraSparc T2",
> +        .name = "Sun-UltraSparc-T2",
>           /* defined in tlu_asi_ctl.v and n2_revid_cust.v */
>           .iu_version = ((0x3eULL << 48) | (0x24ULL << 32) | (0x02ULL << 24)),
>           .fpu_version = 0x00000000,
> @@ -356,7 +356,7 @@ static const sparc_def_t sparc_defs[] = {
>           | CPU_FEATURE_GL,
>       },
>       {
> -        .name = "NEC UltraSparc I",
> +        .name = "NEC-UltraSparc-I",
>           .iu_version = ((0x22ULL << 48) | (0x10ULL << 32) | (0x40ULL << 24)),
>           .fpu_version = 0x00000000,
>           .mmu_version = mmu_us_12,
> @@ -366,7 +366,7 @@ static const sparc_def_t sparc_defs[] = {
>       },
>   #else
>       {
> -        .name = "Fujitsu MB86904",
> +        .name = "Fujitsu-MB86904",
>           .iu_version = 0x04 << 24, /* Impl 0, ver 4 */
>           .fpu_version = 4 << FSR_VER_SHIFT, /* FPU version 4 (Meiko) */
>           .mmu_version = 0x04 << 24, /* Impl 0, ver 4 */
> @@ -379,7 +379,7 @@ static const sparc_def_t sparc_defs[] = {
>           .features = CPU_DEFAULT_FEATURES,
>       },
>       {
> -        .name = "Fujitsu MB86907",
> +        .name = "Fujitsu-MB86907",
>           .iu_version = 0x05 << 24, /* Impl 0, ver 5 */
>           .fpu_version = 4 << FSR_VER_SHIFT, /* FPU version 4 (Meiko) */
>           .mmu_version = 0x05 << 24, /* Impl 0, ver 5 */
> @@ -392,7 +392,7 @@ static const sparc_def_t sparc_defs[] = {
>           .features = CPU_DEFAULT_FEATURES,
>       },
>       {
> -        .name = "TI MicroSparc I",
> +        .name = "TI-MicroSparc-I",
>           .iu_version = 0x41000000,
>           .fpu_version = 4 << FSR_VER_SHIFT,
>           .mmu_version = 0x41000000,
> @@ -405,7 +405,7 @@ static const sparc_def_t sparc_defs[] = {
>           .features = CPU_FEATURE_MUL | CPU_FEATURE_DIV,
>       },
>       {
> -        .name = "TI MicroSparc II",
> +        .name = "TI-MicroSparc-II",
>           .iu_version = 0x42000000,
>           .fpu_version = 4 << FSR_VER_SHIFT,
>           .mmu_version = 0x02000000,
> @@ -418,7 +418,7 @@ static const sparc_def_t sparc_defs[] = {
>           .features = CPU_DEFAULT_FEATURES,
>       },
>       {
> -        .name = "TI MicroSparc IIep",
> +        .name = "TI-MicroSparc-IIep",
>           .iu_version = 0x42000000,
>           .fpu_version = 4 << FSR_VER_SHIFT,
>           .mmu_version = 0x04000000,
> @@ -431,7 +431,7 @@ static const sparc_def_t sparc_defs[] = {
>           .features = CPU_DEFAULT_FEATURES,
>       },
>       {
> -        .name = "TI SuperSparc 40", /* STP1020NPGA */
> +        .name = "TI-SuperSparc-40", /* STP1020NPGA */
>           .iu_version = 0x41000000, /* SuperSPARC 2.x */
>           .fpu_version = 0 << FSR_VER_SHIFT,
>           .mmu_version = 0x00000800, /* SuperSPARC 2.x, no MXCC */
> @@ -444,7 +444,7 @@ static const sparc_def_t sparc_defs[] = {
>           .features = CPU_DEFAULT_FEATURES,
>       },
>       {
> -        .name = "TI SuperSparc 50", /* STP1020PGA */
> +        .name = "TI-SuperSparc-50", /* STP1020PGA */
>           .iu_version = 0x40000000, /* SuperSPARC 3.x */
>           .fpu_version = 0 << FSR_VER_SHIFT,
>           .mmu_version = 0x01000800, /* SuperSPARC 3.x, no MXCC */
> @@ -457,7 +457,7 @@ static const sparc_def_t sparc_defs[] = {
>           .features = CPU_DEFAULT_FEATURES,
>       },
>       {
> -        .name = "TI SuperSparc 51",
> +        .name = "TI-SuperSparc-51",
>           .iu_version = 0x40000000, /* SuperSPARC 3.x */
>           .fpu_version = 0 << FSR_VER_SHIFT,
>           .mmu_version = 0x01000000, /* SuperSPARC 3.x, MXCC */
> @@ -471,7 +471,7 @@ static const sparc_def_t sparc_defs[] = {
>           .features = CPU_DEFAULT_FEATURES,
>       },
>       {
> -        .name = "TI SuperSparc 60", /* STP1020APGA */
> +        .name = "TI-SuperSparc-60", /* STP1020APGA */
>           .iu_version = 0x40000000, /* SuperSPARC 3.x */
>           .fpu_version = 0 << FSR_VER_SHIFT,
>           .mmu_version = 0x01000800, /* SuperSPARC 3.x, no MXCC */
> @@ -484,7 +484,7 @@ static const sparc_def_t sparc_defs[] = {
>           .features = CPU_DEFAULT_FEATURES,
>       },
>       {
> -        .name = "TI SuperSparc 61",
> +        .name = "TI-SuperSparc-61",
>           .iu_version = 0x44000000, /* SuperSPARC 3.x */
>           .fpu_version = 0 << FSR_VER_SHIFT,
>           .mmu_version = 0x01000000, /* SuperSPARC 3.x, MXCC */
> @@ -498,7 +498,7 @@ static const sparc_def_t sparc_defs[] = {
>           .features = CPU_DEFAULT_FEATURES,
>       },
>       {
> -        .name = "TI SuperSparc II",
> +        .name = "TI-SuperSparc-II",
>           .iu_version = 0x40000000, /* SuperSPARC II 1.x */
>           .fpu_version = 0 << FSR_VER_SHIFT,
>           .mmu_version = 0x08000000, /* SuperSPARC II 1.x, MXCC */

Thanks Thomas, this looks much better!

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


