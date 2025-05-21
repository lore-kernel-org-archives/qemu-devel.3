Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FEB9C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 12:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHiuA-0005A8-Pu; Wed, 21 May 2025 08:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uHitc-0004yR-KZ
 for qemu-devel@nongnu.org; Wed, 21 May 2025 08:50:14 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uHitU-0004V8-72
 for qemu-devel@nongnu.org; Wed, 21 May 2025 08:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=gkDQ3/4m3ugbdsvHmcelhgN7wH7gdpx8/dVymWbpYjU=; b=o4lra/h0WrHt63TQ+uSoyyC0Uy
 EFeMQhQwgG3GR6HIojO/E1U5JaHp2Xdp6a/BqMslb0qP8BVzkYJc3EYfD138Fou/SpKIYQHx7f6Tp
 J9lK48K6/bRFowqZWFa/gsh0s86aXp/6krY9J0MCLEhSJcWn38gbwpxwmnbd7a90zPxsohNXcCUNL
 RG9NBVFFnH361AvuYCp6kHJy7Inud4uJ6jwk3BfPA0b2Rrboa0JFm9u7UZr2NrTOXPDNJ+hceEyU/
 0t7d6B0D07GViFlKfhutzTvk77RpQgsp0KIc8sCTK5Lo40qApdWoz9TsNtYBnD5Fp+Ly3LVMQ4EGs
 XtMDcJ8lyAbktWMzdExSmngnXRKeogqk+XqBtRsxl8XvHlD+XkN+s8678A0tslvUUmmT3HnN1dD+/
 dAbJL22XJBtF4MR12Rt+qDZuxqToXSQpT5oc43oaWkuXN8ZTFP7ekHbghxEyJ63rdYB5O/Ok9lHko
 zRRJxxkFM4v6V4uwtlCXCrcZuCoeuFQzLJPPUovXSDt5kFTttObPvZQ1AcpJBi5gi6K6wRn4IimRE
 lCoh3n+J1FuX3TqNHju+PhhvYnQPTet2QuoDeA8bw47q7Ine4ZBONOGZxzJ0kB4W2T1KysJmwwcrr
 UJuLl2FpDNnSZJQZLs+GaVwUI8xzLVuayrRL+IPHs=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uHis2-000692-Po; Wed, 21 May 2025 13:48:34 +0100
Message-ID: <8ec05a12-b900-4f32-ba2f-e2ab7c60350d@ilande.co.uk>
Date: Wed, 21 May 2025 13:49:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20231128081743.2214005-1-kraxel@redhat.com>
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
In-Reply-To: <20231128081743.2214005-1-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PULL 0/2] Firmware/seabios 20231128 patches
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

On 28/11/2023 08:17, Gerd Hoffmann wrote:

> The following changes since commit 4705fc0c8511d073bee4751c3c974aab2b10a970:
> 
>    Merge tag 'pull-for-8.2-fixes-231123-1' of https://gitlab.com/stsquad/qemu into staging (2023-11-24 08:00:18 -0500)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/kraxel/qemu.git tags/firmware/seabios-20231128-pull-request
> 
> for you to fetch changes up to eb0ce1346eca79f066e571dc5845f99f9ec730c3:
> 
>    seabios: update binaries to 1.16.3 release (2023-11-28 08:49:26 +0100)
> 
> ----------------------------------------------------------------
> seabios: update to 1.16.3 release
> 
> This adds one bugfix compared to the snapshot
> merged during the 8.2 devel cycle.
> 
> ----------------------------------------------------------------
> 
> Gerd Hoffmann (2):
>    seabios: update submodule to 1.16.3 release
>    seabios: update binaries to 1.16.3 release
> 
>   pc-bios/bios-256k.bin             | Bin 262144 -> 262144 bytes
>   pc-bios/bios-microvm.bin          | Bin 131072 -> 131072 bytes
>   pc-bios/bios.bin                  | Bin 131072 -> 131072 bytes
>   pc-bios/vgabios-ati.bin           | Bin 39424 -> 39424 bytes
>   pc-bios/vgabios-bochs-display.bin | Bin 28672 -> 28672 bytes
>   pc-bios/vgabios-cirrus.bin        | Bin 38912 -> 38912 bytes
>   pc-bios/vgabios-qxl.bin           | Bin 39424 -> 39424 bytes
>   pc-bios/vgabios-ramfb.bin         | Bin 28672 -> 28672 bytes
>   pc-bios/vgabios-stdvga.bin        | Bin 39424 -> 39424 bytes
>   pc-bios/vgabios-virtio.bin        | Bin 39424 -> 39424 bytes
>   pc-bios/vgabios-vmware.bin        | Bin 39424 -> 39424 bytes
>   pc-bios/vgabios.bin               | Bin 38912 -> 38912 bytes
>   roms/seabios                      |   2 +-
>   13 files changed, 1 insertion(+), 1 deletion(-)

Hi Gerd,

Are there any plans to update the SeaBIOS firmware in QEMU soon? In particular 
someone has asked me off-list about one of my previous ESP series which depends upon 
having an updated SeaBIOS firmware.

(FWIW looking at https://gitlab.com/qemu-project/seabios/ it seems GitLab is 
complaining that hasn't been able to update from the upstream repository).


ATB,

Mark.


