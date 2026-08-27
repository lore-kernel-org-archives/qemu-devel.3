Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB27C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 20:13:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzgT5-000663-Mv; Thu, 27 Aug 2026 16:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wzgT3-00060p-U7; Thu, 27 Aug 2026 16:12:57 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wzgT1-0002RM-W9; Thu, 27 Aug 2026 16:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=AP6z/l/4Wm2GkR77oII8qrO61x6kGAYDU7J+IRhF+q4=; b=U9d/OlE/yPimLUNmKulGVAtGjU
 lgB9daHRHUvDJsIizT5TOkBKooBjfzCRSxFUUyXUJX+JGkSknzi0I2/O914s47gYgr3MiWUQ3k3oc
 jF+Tm8cOYqOSbC6ielXBGxfftbtBo2EU9xnmmt9YpzbVySG9Jsz+sRx/0OcmPWtQmXR2sbBm8vF6k
 YUVmBiHBcYS6RUJq0yrOk5xXWCzPcJphLwA+ISr0gKLpyfojFpcX7rTVSmbsheAT8gqOekXVtpoXI
 wNB9tnDTO+n6Md8EZREzgzaRVGOVpN4hAs9w6Z7lWA+vj5mbfiL2kWJbhqPSEusDtZ+hPbNtTZxdx
 gUPX7iuFc/fxcguIgmYtNuVQWgf7oKyE1D8r+NzFJi3wPl4JTpQO9GNcwljdLYM+mcKE7Zn8oxAJQ
 TrActf3SXuIWIezvxBg9SsOsdLFESYr6aTO8olvJMTnLSWKLXqJ+wktNf66ivycjTTiNuYKd1DlBy
 +5Ak2xKQs6MA7wGktUJhS6mx+1YT+wwJFt7RRol/e5kn+7C5qrkgRibEgVtKcGCC7xY860TkoXq1h
 ANoqlJAN0mEF9hWmaSnesEWaEIslYYm5IJcE/fYpRcAvs7zGc/eaUXSSwBp8KpEH4k+RkFKvxsA0t
 Z106o0UNr3/S9uNYGABrIiPPntBRmIcWrp0QCEM/o=;
Received: from [2a02:8012:2f01:0:fe49:60b9:9856:b8ef]
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wzgSa-00AQ22-Ir; Thu, 27 Aug 2026 21:12:29 +0100
Message-ID: <efe7ad78-d94a-4885-a443-6d1d0fe6c506@ilande.co.uk>
Date: Thu, 27 Aug 2026 21:12:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Mark Cave-Ayland <mark.caveayland@nutanix.com>
References: <20260826181725.849718-1-pbonzini@redhat.com>
 <20260826181725.849718-3-pbonzini@redhat.com>
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
In-Reply-To: <20260826181725.849718-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:fe49:60b9:9856:b8ef
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 2/2] scsi: hide MODE SELECT block size change behind a
 quirk
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

On 26/08/2026 19:17, Paolo Bonzini wrote:

> This is a dangerous operation in that the block size is not
> protected by a lock, but it can be written concurrently if
> you have a multi-queue virtio-scsi HBA.  Put it behind a quirk
> that is only enabled by the Q800 machine, since the MODE
> SELECT feature was added for A/UX.
> 
> Fixes: 356c4c441ec ("scsi-disk: allow MODE SELECT block descriptor to set the block size", 2022-07-13)
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/hw/scsi/scsi.h |  1 +
>   hw/m68k/q800.c         |  2 ++
>   hw/scsi/scsi-disk.c    | 12 ++++++++++--
>   3 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
> index c60c6e8810e..3eab339b0d2 100644
> --- a/include/hw/scsi/scsi.h
> +++ b/include/hw/scsi/scsi.h
> @@ -262,5 +262,6 @@ bool scsi_generic_pr_state_preempt(SCSIDevice *s, Error **errp);
>   #define SCSI_DISK_QUIRK_MODE_SENSE_ROM_USE_DBD             1
>   #define SCSI_DISK_QUIRK_MODE_PAGE_VENDOR_SPECIFIC_APPLE    2
>   #define SCSI_DISK_QUIRK_MODE_PAGE_TRUNCATED                3
> +#define SCSI_DISK_QUIRK_MODE_PAGE_SET_BLOCK_SIZE           4
>   
>   #endif
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index ab64250c47c..1ad3f93b294 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -710,12 +710,14 @@ static void q800_init(Object *obj)
>   
>   static GlobalProperty hw_compat_q800[] = {
>       { "scsi-hd", "quirk_mode_page_vendor_specific_apple", "on" },
> +    { "scsi-hd", "quirk_mode_page_set_block_size", "on" },
>       { "scsi-hd", "vendor", " SEAGATE" },
>       { "scsi-hd", "product", "          ST225N" },
>       { "scsi-hd", "ver", "1.0 " },
>       { "scsi-cd", "quirk_mode_page_apple_vendor", "on" },
>       { "scsi-cd", "quirk_mode_sense_rom_use_dbd", "on" },
>       { "scsi-cd", "quirk_mode_page_vendor_specific_apple", "on" },
> +    { "scsi-cd", "quirk_mode_page_set_block_size", "on" },
>       { "scsi-cd", "quirk_mode_page_truncated", "on" },
>       { "scsi-cd", "vendor", "MATSHITA" },
>       { "scsi-cd", "product", "CD-ROM CR-8005" },
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 5bb7a974d69..a42f7d8e77d 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -1673,8 +1673,12 @@ static void scsi_disk_emulate_mode_select(SCSIDiskReq *r, uint8_t *inbuf)
>           goto invalid_param;
>       }
>   
> -    /* Allow changing the block size */
> -    if (bd_len) {
> +    /*
> +     * Allow changing the block size only if the quirk is enabled for it.
> +     * Writing s->qdev.blocksize is not thread safe!
> +     */
> +    if (bd_len && (s->quirks &
> +                   (1 << SCSI_DISK_QUIRK_MODE_PAGE_SET_BLOCK_SIZE))) {
>           bs = p[5] << 16 | p[6] << 8 | p[7];
>   
>           /*
> @@ -3247,6 +3251,8 @@ static const Property scsi_hd_properties[] = {
>       DEFINE_PROP_BIT("quirk_mode_page_vendor_specific_apple", SCSIDiskState,
>                       quirks, SCSI_DISK_QUIRK_MODE_PAGE_VENDOR_SPECIFIC_APPLE,
>                       0),
> +    DEFINE_PROP_BIT("quirk_mode_page_set_block_size", SCSIDiskState,
> +                    quirks, SCSI_DISK_QUIRK_MODE_PAGE_SET_BLOCK_SIZE, 0),
>       DEFINE_BLOCK_CHS_PROPERTIES(SCSIDiskState, qdev.conf),
>   };
>   
> @@ -3352,6 +3358,8 @@ static const Property scsi_cd_properties[] = {
>                       0),
>       DEFINE_PROP_BIT("quirk_mode_page_truncated", SCSIDiskState, quirks,
>                       SCSI_DISK_QUIRK_MODE_PAGE_TRUNCATED, 0),
> +    DEFINE_PROP_BIT("quirk_mode_page_set_block_size", SCSIDiskState,
> +                    quirks, SCSI_DISK_QUIRK_MODE_PAGE_SET_BLOCK_SIZE, 0),
>   };
>   
>   static void scsi_cd_class_initfn(ObjectClass *klass, const void *data)

Apologies for this, I really didn't expect this to cause a problem with multi-queue 
virtio-scsi. The fix looks good to me.

FWIW early SPARC Solaris also requires this if using a ROM from a real machine and 
booting from CDROM: OpenBIOS has a few hacks in place that allow this to work (for now).


ATB,

Mark.


