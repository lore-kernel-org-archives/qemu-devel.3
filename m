Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09258C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 21:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjkxg-0000pP-Rp; Tue, 14 Jul 2026 17:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wjkxf-0000pA-MR
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 17:46:43 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wjkxe-0000am-6k
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 17:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=FUPzcJaId9mtmCDaK+OOYhhf/A7hOBKj6MYMbe31gnY=; b=LnhqMyUU1NJJX+STWoWHyM3dqY
 1RnzRpr+czMC9HBBNuOoTYivCTFWxp86O2jPMR6xGZX/LtvGiqiOkD37g3VVYW6MHB5coRbUIl6u1
 GKZXNeGqaaDJyPawcdY68i++Q+cuqNhKO2T7gkqTguOx3wLfsgZRolfflsbk/G8HSjJu3nLjxCF9r
 3p9D3iaLrZTutwMf1FYPdrwDEBWt+jkyCe5E1Qt13GQTaM2SYyMJ2r6WmacWyxa1uHk8PwX0VCR6B
 nxw7KdftRiGAN7I1DR5PMhMNl55qZwgJFPYqxl4y6VlMcxM3AZZBrh+RWRr+DyyJDNvPZxnvfEmZ6
 WnM1lbuyzDSrkO4M2hFLDNshNbEHMdZRd94JUy5EIPn7bUYgbBaSwD7I9UC6L2aVhZE3EbxyEHJ4b
 p/ssGAL57T8vtJw2YgZSLnH+0sCqN0vYyv/9dl5eyCQIIiSpUkTQiy5XaA9L4no1Q+IibM1Esx6F3
 wnXOvV2RusuYVWRyUGaF2o85DabM54JDtj5ZCju3LeITYij4gr1Ts2hrSwjHrhIdMdJEN1ZWoWwc3
 WJFKnw2/ArfC1y87gQbZl8vMapUuVXleqB2sGYB19/MyLvyYvjigvNajJtEerahRNur/bXskuaCGp
 lDN4yI+zHomaTtYxKumjaA/rCHhVYATWS3xMChe/A=;
Received: from [2a02:8012:2f01:0:15be:353c:5920:3156]
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wjkxW-002fZK-D7; Tue, 14 Jul 2026 22:46:34 +0100
Message-ID: <7ed63c06-7f36-41bd-beae-2e7cef923a88@ilande.co.uk>
Date: Tue, 14 Jul 2026 22:46:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Dmitry Pimenov <sun4qemu@gmail.com>, qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>
References: <20260710222350.9185-1-sun4qemu@gmail.com>
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
In-Reply-To: <20260710222350.9185-1-sun4qemu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:15be:353c:5920:3156
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] hw/sparc64/niagara: use int64_t for vdisk size to avoid
 truncation
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/07/2026 23:23, Dmitry Pimenov wrote:

> blk_getlength() returns int64_t, but niagara_init() stored it in an int,
> truncating the if=pflash virtual-ramdisk size for images >= 2 GiB. A ~4 GiB
> image truncated to 0/negative, failed the `size > 0` check, and exit(1)'d
> before the CPU ran, ending with:
> 
>    qemu-system-sparc64: could not load ram disk
> 
> AI-used-for: code (bug fix)
> Signed-off-by: Dmitry Pimenov <sun4qemu@gmail.com>
> ---
>   hw/sparc64/niagara.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
> index 1211ecb82d..ad5e5945a8 100644
> --- a/hw/sparc64/niagara.c
> +++ b/hw/sparc64/niagara.c
> @@ -137,7 +137,7 @@ static void niagara_init(MachineState *machine)
>          outside of the partition RAM */
>       if (dinfo) {
>           BlockBackend *blk = blk_by_legacy_dinfo(dinfo);
> -        int size = blk_getlength(blk);
> +        int64_t size = blk_getlength(blk);
>           if (size > 0) {
>               memory_region_init_ram(&s->vdisk_ram, NULL, "sun4v_vdisk.ram", size,
>                                      &error_fatal);
> --
> 2.43.0

Oh, curious - is this a static/AI analysis find, or are you actively using the sun4v 
emulation? Anyhow:

Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


