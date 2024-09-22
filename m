Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2613BCF9C69
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2024 19:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssSHl-0000wx-7x; Sun, 22 Sep 2024 15:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1ssSHj-0000w6-Bg
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 15:30:19 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1ssSHg-0000l0-C9
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 15:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=Cqsz0cqk6OhLiipbNFGl3ThzTke/E2rxtY4Wroghn68=; b=OFa1/DoA0sjhiHhpJbnwFwG8et
 WMlmmcBPs25wBOkmYbGsDz9w8YtfVAz4UbNlXKSFypA5nJj/vwoIBIOVIGcb0x5ZpBrYWhul/5Vd0
 ajAew2UKs4V+g0VS72cQ2ld6ggXVGY8REefOf/sLZeppivvRu8yv0sI/L2ACVJ+vbIzwM11Yv61DZ
 KBQgSfRp0ESMtTgS0/MWL6274q+I7AItcaRGGieTMlsFtAyByuobTheqdguqCd8JaMWfmJc/Fng+I
 LAmp/ROqwBhDPSO5wcI+Q3ntka5dDpxB0Sa8XPZztFbPNktT+MhyoFizxEe4eZMDdHc0sdztTRFlM
 yH9DzFn0hTdQRzXpTncJb0M1rZ3ThoYqIL+Fje2KSYiErW38n3uZi/ySWzJWTUkVhNIFP3wQoQUx3
 QHRA5ekJV8T7ORlxSD8dmSVwI4LuWg4Li/OCIQeKGFNtt6Ponvlz9utuEo/X3PoSkYWBDp3uN+LNp
 B4Q1+KDB++VBM5IuxTPfhZMqmRjzaacXckFEErpC5iKhPfXK7kOatacyBj9Nks4oF7M9xV3qtzeki
 alK95TDOU2aguHvIROvPxDhwBOfkg0JyXhgIQrJNy8TTs5kc7KGrfNBBWY36sQjO57rl/f9LsaK7x
 k+QM+eltC1lqiw7l0xfHAPF13Ffsg5sEarmVe18e8=;
Received: from [2a00:23c4:8bb8:7000:1f10:bbb5:a62c:f41d]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1ssSHS-000BPK-Eq; Sun, 22 Sep 2024 20:30:06 +0100
Message-ID: <97971f2e-aa25-49ae-a1cc-c5faddb8abb0@ilande.co.uk>
Date: Sun, 22 Sep 2024 20:30:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ricardo Ribalda <ribalda@chromium.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
References: <20240922143216.662873-1-ribalda@chromium.org>
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
In-Reply-To: <20240922143216.662873-1-ribalda@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:7000:1f10:bbb5:a62c:f41d
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 0/3] Fix WinXP ISO boot using the dc390/am53C974 SCSI
 device
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

On 22/09/2024 15:31, Ricardo Ribalda wrote:

> Mark Cave-Ayland reported that after landing the pre-computed _PRT, the
> above mentioned testcase failed to pass.
> 
> It seems that it is due to WinXP not handling properly a variable
> package. Let's replace it.
> 
> 
> Unfortunately, the ASL diff is not the best (or I cannot produce
> something better):
> 
> 12c12
> <  *     Length           0x00003917 (14615)
> ---
>>   *     Length           0x00003914 (14612)
> 14c14
> <  *     Checksum         0xD9
> ---
>>   *     Checksum         0x09
> 
> Ricardo Ribalda (3):
>    tests/acpi: pc: allow DSDT acpi table changes
>    hw/i386/acpi-build: return a non-var package from _PRT()
>    tests/acpi: pc: update golden masters for DSDT
> 
>   hw/i386/acpi-build.c                 |   2 +-
>   tests/data/acpi/x86/pc/DSDT          | Bin 8527 -> 8526 bytes
>   tests/data/acpi/x86/pc/DSDT.acpierst | Bin 8438 -> 8437 bytes
>   tests/data/acpi/x86/pc/DSDT.acpihmat | Bin 9852 -> 9851 bytes
>   tests/data/acpi/x86/pc/DSDT.bridge   | Bin 15398 -> 15397 bytes
>   tests/data/acpi/x86/pc/DSDT.cphp     | Bin 8991 -> 8990 bytes
>   tests/data/acpi/x86/pc/DSDT.dimmpxm  | Bin 10181 -> 10180 bytes
>   tests/data/acpi/x86/pc/DSDT.hpbridge | Bin 8478 -> 8477 bytes
>   tests/data/acpi/x86/pc/DSDT.hpbrroot | Bin 5034 -> 5033 bytes
>   tests/data/acpi/x86/pc/DSDT.ipmikcs  | Bin 8599 -> 8598 bytes
>   tests/data/acpi/x86/pc/DSDT.memhp    | Bin 9886 -> 9885 bytes
>   tests/data/acpi/x86/pc/DSDT.nohpet   | Bin 8385 -> 8384 bytes
>   tests/data/acpi/x86/pc/DSDT.numamem  | Bin 8533 -> 8532 bytes
>   tests/data/acpi/x86/pc/DSDT.roothp   | Bin 12320 -> 12319 bytes
>   tests/data/acpi/x86/q35/DSDT.cxl     | Bin 13148 -> 13146 bytes
>   tests/data/acpi/x86/q35/DSDT.viot    | Bin 14615 -> 14612 bytes
>   16 files changed, 1 insertion(+), 1 deletion(-)

This passes my WinXP test (and also a local run of "make check") so it looks good to 
me. I'm not familiar enough with ACPI to give an R-B tag, but it certainly solves the 
issue so:

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


