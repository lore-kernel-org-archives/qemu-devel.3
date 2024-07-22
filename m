Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E2A1C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 21:25:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW0WT-00018y-2J; Mon, 22 Jul 2024 17:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sW0WH-0000Nb-4N; Mon, 22 Jul 2024 17:24:33 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sW0WD-0008RC-Ll; Mon, 22 Jul 2024 17:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=NKqTZKbxY0DRlQy87302mXYMYJxfvGIWK2T3dznCNv0=; b=AXGqyKhh3ssOrmVcd1BJ2z8OwC
 IzrdrO+uKke1/g9BKEeK4l0nrtIPHONu0BYu1I3BBWvnQYte3Tyx0Ep7Wv3XJyb4U1z1NKSw3DU1s
 LDRBv63I9ZbPRjPn2KiBBWo9S44H87vpRcLsltPJzBygIX9NpKLeuAK7QyzoJK7z+sSEK8/6MNldi
 Tshexb2H7kcXtrMm2yD0viTMU/twPs0ycEDN5MpGzUVcIkgOB8nhciJfxMHPsotanPvRpEDQD3zCo
 QrCnOmKB1nzcpWf7Wq7oQsd1cW44dy0Zcg46Rr1CQPTg0oUfdRFyHkP5lmydzWIj7+qRPbKqO7ZJl
 D9CXeFqRzPtKZxMakD0hhIX0E9aSD1ebMyyprIxmv//XLMFSKxAHgAJtqdCpzOwUWDnMMt1N6b1aI
 PzU5eKNCeMf82vcpQTxftVTSoEPIfkPrlPlvyzedFJa8tDi4xRrK0f+paUkHEyY+I4KGJ43pPCfMv
 +ECOo9E+P+9YH9qWyb8J/HK2tf3fpQZpzpoAo8W9GfQDvHZno2vfUjf4lDD2+puFfId3U0u7KXK1n
 5FOFM6YWVd6bpVRhIJCAbKlZvUTJsy4pa6QISfaJ4RELRaX9IwQLPJ5iTKLKvGj9IW6q1REMjYuP4
 d8EYBOUmjkpzwtS4Lq1uMXi6WyL9dBwnfbZ9MGhTo=;
Received: from [2a00:23c4:8bb4:4000:c7ab:2566:bad6:7dfd]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sW0Ud-0003NV-9I; Mon, 22 Jul 2024 22:22:55 +0100
Message-ID: <21d354aa-b0ed-424e-8453-eae493693d61@ilande.co.uk>
Date: Mon, 22 Jul 2024 22:24:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20240722160745.67904-1-philmd@linaro.org>
 <20240722160745.67904-6-philmd@linaro.org>
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
In-Reply-To: <20240722160745.67904-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:c7ab:2566:bad6:7dfd
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 5/7] util/fifo8: Rename fifo8_pop_buf() ->
 fifo8_pop_constbuf()
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

On 22/07/2024 17:07, Philippe Mathieu-Daudé wrote:

> Since fifo8_pop_buf() return a const buffer (which points
> directly into the FIFO backing store), rename it using the
> 'constbuf' suffix. This will help differentiate with methods
> *copying* the FIFO data.

Similar comment re: fifo8_pop_bufptr() as before, but still:

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.

> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/qemu/fifo8.h    | 4 ++--
>   chardev/msmouse.c       | 2 +-
>   hw/char/goldfish_tty.c  | 4 ++--
>   hw/net/allwinner_emac.c | 2 +-
>   hw/scsi/esp.c           | 4 ++--
>   ui/console-vc.c         | 2 +-
>   ui/gtk.c                | 2 +-
>   util/fifo8.c            | 2 +-
>   8 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/include/qemu/fifo8.h b/include/qemu/fifo8.h
> index 79450f4583..686918a3a4 100644
> --- a/include/qemu/fifo8.h
> +++ b/include/qemu/fifo8.h
> @@ -63,7 +63,7 @@ void fifo8_push_all(Fifo8 *fifo, const uint8_t *data, uint32_t num);
>   uint8_t fifo8_pop(Fifo8 *fifo);
>   
>   /**
> - * fifo8_pop_buf:
> + * fifo8_pop_constbuf:
>    * @fifo: FIFO to pop from
>    * @max: maximum number of bytes to pop
>    * @numptr: pointer filled with number of bytes returned (can be NULL)
> @@ -86,7 +86,7 @@ uint8_t fifo8_pop(Fifo8 *fifo);
>    *
>    * Returns: A pointer to popped data.
>    */
> -const uint8_t *fifo8_pop_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr);
> +const uint8_t *fifo8_pop_constbuf(Fifo8 *fifo, uint32_t max, uint32_t *numptr);
>   
>   /**
>    * fifo8_peek_constbuf: read upto max bytes from the fifo
> diff --git a/chardev/msmouse.c b/chardev/msmouse.c
> index a774c397b4..08836d92e8 100644
> --- a/chardev/msmouse.c
> +++ b/chardev/msmouse.c
> @@ -81,7 +81,7 @@ static void msmouse_chr_accept_input(Chardev *chr)
>           const uint8_t *buf;
>           uint32_t size;
>   
> -        buf = fifo8_pop_buf(&mouse->outbuf, MIN(len, avail), &size);
> +        buf = fifo8_pop_constbuf(&mouse->outbuf, MIN(len, avail), &size);
>           qemu_chr_be_write(chr, buf, size);
>           len = qemu_chr_be_can_write(chr);
>           avail -= size;
> diff --git a/hw/char/goldfish_tty.c b/hw/char/goldfish_tty.c
> index f8ff043c39..2c5004851d 100644
> --- a/hw/char/goldfish_tty.c
> +++ b/hw/char/goldfish_tty.c
> @@ -69,7 +69,7 @@ static uint64_t goldfish_tty_read(void *opaque, hwaddr addr,
>   static void goldfish_tty_cmd(GoldfishTTYState *s, uint32_t cmd)
>   {
>       uint32_t to_copy;
> -    uint8_t *buf;
> +    const uint8_t *buf;
>       uint8_t data_out[GOLFISH_TTY_BUFFER_SIZE];
>       int len;
>       uint64_t ptr;
> @@ -109,7 +109,7 @@ static void goldfish_tty_cmd(GoldfishTTYState *s, uint32_t cmd)
>           len = s->data_len;
>           ptr = s->data_ptr;
>           while (len && !fifo8_is_empty(&s->rx_fifo)) {
> -            buf = (uint8_t *)fifo8_pop_buf(&s->rx_fifo, len, &to_copy);
> +            buf = fifo8_pop_constbuf(&s->rx_fifo, len, &to_copy);
>               address_space_rw(&address_space_memory, ptr,
>                               MEMTXATTRS_UNSPECIFIED, buf, to_copy, 1);
>   
> diff --git a/hw/net/allwinner_emac.c b/hw/net/allwinner_emac.c
> index 989839784a..3b0a2ee07e 100644
> --- a/hw/net/allwinner_emac.c
> +++ b/hw/net/allwinner_emac.c
> @@ -349,7 +349,7 @@ static void aw_emac_write(void *opaque, hwaddr offset, uint64_t value,
>                                 "allwinner_emac: TX length > fifo data length\n");
>               }
>               if (len > 0) {
> -                data = fifo8_pop_buf(fifo, len, &ret);
> +                data = fifo8_pop_constbuf(fifo, len, &ret);
>                   qemu_send_packet(nc, data, ret);
>                   aw_emac_tx_reset(s, chan);
>                   /* Raise TX interrupt */
> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
> index 526ed91bef..64384f9b0e 100644
> --- a/hw/scsi/esp.c
> +++ b/hw/scsi/esp.c
> @@ -208,7 +208,7 @@ static uint32_t esp_fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, int maxlen)
>       }
>   
>       len = maxlen;
> -    buf = fifo8_pop_buf(fifo, len, &n);
> +    buf = fifo8_pop_constbuf(fifo, len, &n);
>       if (dest) {
>           memcpy(dest, buf, n);
>       }
> @@ -217,7 +217,7 @@ static uint32_t esp_fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, int maxlen)
>       len -= n;
>       len = MIN(len, fifo8_num_used(fifo));
>       if (len) {
> -        buf = fifo8_pop_buf(fifo, len, &n2);
> +        buf = fifo8_pop_constbuf(fifo, len, &n2);
>           if (dest) {
>               memcpy(&dest[n], buf, n2);
>           }
> diff --git a/ui/console-vc.c b/ui/console-vc.c
> index 899fa11c94..e9906aae59 100644
> --- a/ui/console-vc.c
> +++ b/ui/console-vc.c
> @@ -287,7 +287,7 @@ static void kbd_send_chars(QemuTextConsole *s)
>           const uint8_t *buf;
>           uint32_t size;
>   
> -        buf = fifo8_pop_buf(&s->out_fifo, MIN(len, avail), &size);
> +        buf = fifo8_pop_constbuf(&s->out_fifo, MIN(len, avail), &size);
>           qemu_chr_be_write(s->chr, buf, size);
>           len = qemu_chr_be_can_write(s->chr);
>           avail -= size;
> diff --git a/ui/gtk.c b/ui/gtk.c
> index bc29f7a1b4..a4db90e8cb 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -1820,7 +1820,7 @@ static void gd_vc_send_chars(VirtualConsole *vc)
>           const uint8_t *buf;
>           uint32_t size;
>   
> -        buf = fifo8_pop_buf(&vc->vte.out_fifo, MIN(len, avail), &size);
> +        buf = fifo8_pop_constbuf(&vc->vte.out_fifo, MIN(len, avail), &size);
>           qemu_chr_be_write(vc->vte.chr, buf, size);
>           len = qemu_chr_be_can_write(vc->vte.chr);
>           avail -= size;
> diff --git a/util/fifo8.c b/util/fifo8.c
> index 21943c6032..31f0d34c0c 100644
> --- a/util/fifo8.c
> +++ b/util/fifo8.c
> @@ -97,7 +97,7 @@ const uint8_t *fifo8_peek_constbuf(Fifo8 *fifo, uint32_t max, uint32_t *numptr)
>       return fifo8_peekpop_buf(fifo, max, numptr, false);
>   }
>   
> -const uint8_t *fifo8_pop_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr)
> +const uint8_t *fifo8_pop_constbuf(Fifo8 *fifo, uint32_t max, uint32_t *numptr)
>   {
>       return fifo8_peekpop_buf(fifo, max, numptr, true);
>   }


