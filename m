Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51755E83830
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 20:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs5af-0001j4-Pj; Mon, 16 Feb 2026 15:53:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vs5ad-0001iD-VS; Mon, 16 Feb 2026 15:53:08 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vs5ac-0000cp-Gp; Mon, 16 Feb 2026 15:53:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=R1el/rlOFSvamoBqsi26pL7drExYhgH7k2YES/nJP0w=; b=IQPf5iTCfIe1t8Oho3ex7iFnVh
 Z/Pwm4DxZz6hdNqrcmRpGaNhDL8rxvm0yMk7uwT5oQL0b3rRmhMQXJYJNThEYKtYH+1LaWG5w0iIw
 5KxatrvKOhTZjtdTe6EHpAyyBrgPf4ep+CMvmIv0tbUtXytCNwz6/RAsBBtHYgUiq6uujBLCN2ppA
 1n2KQ85J6bxohfCpt/6E1uQUyEqa9ht558SW6T6F6X9wWIBjJGP11p0GwU6p07X0fmJcfJ/D7EdDv
 SiE59YpHsiK4t/h0+R8ya1k6lrFaBWFih5EN3QSi4lkQ53YDaOu1xvQN6+7sZab6tODiKxjSz8GJT
 KfRzx1uKpaHehCylHGG1vZUCW87PlHOvSOjVYLj58/5wP4EzvSzWPTza+6LHWEFubD8GUp8pELXyd
 hKOsOY2tHP4B+69oVJOmtT6J1V9Ib9Sul/3XTAmI6USBGwDs0YAM4NH6b2BiMelbS//J+bGbCWypm
 MD89zxkkUhHpOI+897QVooWH36X6NRx/GtF+kt/T4+0QJL+J3nqS39YamdvczP4wTH/NcCsWusuiL
 7MnX5Y6RWgLF5sxwuo+R9OcnDsTO1Y3RfRQHeGc04cVn21KPHnnlRP+ysuul4Z7t7LR41DQ64DAQZ
 Aq/m/zFQGNBrtRsycqpXueYfe9nmwzAhRI9NVsK/0=;
Received: from [2a02:8012:2f01:0:f01d:4e0f:6874:3706]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vs5Xi-000CXN-Cl; Mon, 16 Feb 2026 20:50:10 +0000
Message-ID: <37db014f-9fa7-48d0-b0e5-8e00d19ef295@ilande.co.uk>
Date: Mon, 16 Feb 2026 20:52:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
References: <20260214021240.58657-1-philmd@linaro.org>
 <20260214021240.58657-3-philmd@linaro.org>
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
In-Reply-To: <20260214021240.58657-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:f01d:4e0f:6874:3706
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 2/8] hw/display/macfb: Constify macfb_mode_table[] array
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

On 14/02/2026 02:12, Philippe Mathieu-Daudé wrote:

> macfb_mode_table[] is only read, never updated, so can be const.
> 
> Update the call sites accordingly.
> Make the MacfbState::mode pointer to const.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/display/macfb.h |  2 +-
>   hw/display/macfb.c         | 10 +++++-----
>   hw/m68k/q800.c             |  2 +-
>   3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/include/hw/display/macfb.h b/include/hw/display/macfb.h
> index 495dead44b5..cb7aac7a4dd 100644
> --- a/include/hw/display/macfb.h
> +++ b/include/hw/display/macfb.h
> @@ -66,7 +66,7 @@ typedef struct MacfbState {
>       uint8_t type;
>   
>       uint32_t regs[MACFB_NUM_REGS];
> -    MacFbMode *mode;
> +    const MacFbMode *mode;
>   
>       QEMUTimer *vbl_timer;
>       qemu_irq irq;
> diff --git a/hw/display/macfb.c b/hw/display/macfb.c
> index 57ad8ad5587..8ef174dc6df 100644
> --- a/hw/display/macfb.c
> +++ b/hw/display/macfb.c
> @@ -100,7 +100,7 @@ static const MacFbSense macfb_sense_table[] = {
>       { MACFB_DISPLAY_SVGA, 0x7, 0x5 },
>   };
>   
> -static MacFbMode macfb_mode_table[] = {
> +static const MacFbMode macfb_mode_table[] = {
>       { MACFB_DISPLAY_VGA, 1, 0x100, 0x71e, 640, 480, 0x400, 0x1000 },
>       { MACFB_DISPLAY_VGA, 2, 0x100, 0x70e, 640, 480, 0x400, 0x1000 },
>       { MACFB_DISPLAY_VGA, 4, 0x100, 0x706, 640, 480, 0x400, 0x1000 },
> @@ -397,7 +397,7 @@ static void macfb_update_mode(MacfbState *s)
>   
>   static void macfb_mode_write(MacfbState *s)
>   {
> -    MacFbMode *macfb_mode;
> +    const MacFbMode *macfb_mode;
>       int i;
>   
>       for (i = 0; i < ARRAY_SIZE(macfb_mode_table); i++) {
> @@ -418,11 +418,11 @@ static void macfb_mode_write(MacfbState *s)
>       }
>   }
>   
> -static MacFbMode *macfb_find_mode(MacfbDisplayType display_type,
> +static const MacFbMode *macfb_find_mode(MacfbDisplayType display_type,
>                                     uint16_t width, uint16_t height,
>                                     uint8_t depth)
>   {
> -    MacFbMode *macfb_mode;
> +    const MacFbMode *macfb_mode;
>       int i;
>   
>       for (i = 0; i < ARRAY_SIZE(macfb_mode_table); i++) {
> @@ -440,7 +440,7 @@ static MacFbMode *macfb_find_mode(MacfbDisplayType display_type,
>   static gchar *macfb_mode_list(void)
>   {
>       GString *list = g_string_new("");
> -    MacFbMode *macfb_mode;
> +    const MacFbMode *macfb_mode;
>       int i;
>   
>       for (i = 0; i < ARRAY_SIZE(macfb_mode_table); i++) {
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index 25ddddb5d9f..4767eb4298f 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -255,7 +255,7 @@ static void q800_machine_init(MachineState *machine)
>       int32_t initrd_size;
>       uint8_t *prom;
>       int i, checksum;
> -    MacFbMode *macfb_mode;
> +    const MacFbMode *macfb_mode;
>       ram_addr_t ram_size = machine->ram_size;
>       const char *kernel_filename = machine->kernel_filename;
>       const char *initrd_filename = machine->initrd_filename;

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


