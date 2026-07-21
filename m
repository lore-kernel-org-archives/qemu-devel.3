Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE75C4452D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 20:41:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmHGc-00055p-W9; Tue, 21 Jul 2026 16:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wmHGa-000550-B2
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 16:40:40 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wmHGY-00070t-Eb
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 16:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=nUjY9jZ/4fxfhOPn+DFGSfgewlMRznly5mZ+3RNN6Rk=; b=VkHnq3KqbvD6BaLV6WgZbRVSM6
 DwQvezG07ZM4Y0EViFg+mAoXrE10xUjUB0eJ/OxJtM1JA8xML9vyuKGNZ/RFEAgvoQ0RDiZX6JJHd
 JzyVnI2eaND/iH+jEkgaFa5rddchXeqR4nODzOfAP5cj6wjQhEBbN/dXFC28xvZFdNrziciyys2Qv
 A2Vv4TjFwP5+lO63P/uG+637fjY295xKWG1A2l1NLlFeil/RiwHk9TtxTCGKO+GAsCzDr1Dqie+qI
 xoQ+WpFvkDb2o2mH0TvcyC4DC6upa1QzZ/4XaQD/Bsg1oh+/yygQPF0vgZDgSclppf4/G8KaEh6j7
 W5JlAAbBb9zeEhueFYrViKyANtpufKZAwt96hgnWST2HxtE0iEN7Dyn8xS9+JljupdS6SUFKmOeR4
 0mywvNUY5/+9u3rJZjG5QBj1/n0edungxIpfoYTj1xuq+xuMqotLpnRSPrAceQ597O1P4YpFaBLCa
 fvPidAZPCHTZSzxVKdXG3455u4DqzmJe1gx4lP/2HJ0b640/wn6Rsm5o3AcSYKihy+PXTHl/kyDKD
 oklUqFFo7KTqinBEn9nX4+fPzpXA00TkJYavX/c6/tiz9zfF6vJa6AsWAZrMOOGbyJw0wnRfkrUN2
 rJLS3VWOVIIr2lBrvKFUQT1Irne17aPBf+0I6MOSk=;
Received: from [2a02:8012:2f01:0:34d0:4e6f:4b12:1620]
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wmHGK-003qWi-8t; Tue, 21 Jul 2026 21:40:24 +0100
Message-ID: <48a8eb25-4d26-47f4-8cf2-7cb81760f50a@ilande.co.uk>
Date: Tue, 21 Jul 2026 21:40:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20260721161904.363367-1-pbonzini@redhat.com>
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
In-Reply-To: <20260721161904.363367-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:34d0:4e6f:4b12:1620
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] scsi-disk: protect against guest sending truncated data
 for MODE SELECT commands
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

On 21/07/2026 17:19, Paolo Bonzini wrote:

> scsi-disk has a MODE SELECT path where a truncated mode page can be
> allowed by a compatibility quirk, but the parser continues to use the
> page's declared length rather than the number of bytes actually remaining
> in the request buffer.  This means that scsi_disk_check_mode_select() and
> scsi_disk_apply_mode_select() can read beyond the valid part of inbuf[],
> potentially up to the emulated age's length.

page's?

> Clamping page_len (the size of the page) to len (whatever the
> guest provided) ensures that scsi_disk_check_mode_select() and
> scsi_disk_apply_mode_select() do not access anything beyond bounds;
> however, this requires care to accept and handle truncated input in
> those two functions.
> 
> In particular, until scsi_disk_check_mode_select()'s first call to
> mode_sense_page() the number of bytes to be cleared in mode_current[] is
> unknown, so zero it completely.  And for everything else, be conservative
> and use len when providing inputs to other functions; but at the same time,
> ensure all accesses to inbuf[] are bound by expected_len.
> 
> Note that pages longer than the emulated one are still rejected.
> 
> Fixes: 389e18eb9aa4 ("scsi-disk: add SCSI_DISK_QUIRK_MODE_PAGE_TRUNCATED quirk for Macintosh")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4051
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/scsi/scsi-disk.c | 21 +++++++++++++--------
>   1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 5ba5b46c4f4..85d0bd0b811 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -1524,7 +1524,7 @@ static void scsi_disk_emulate_read_data(SCSIRequest *req)
>   static int scsi_disk_check_mode_select(SCSIDiskState *s, int page,
>                                          uint8_t *inbuf, int inlen)
>   {
> -    uint8_t mode_current[SCSI_MAX_MODE_LEN];
> +    uint8_t mode_current[SCSI_MAX_MODE_LEN] = { 0 };
>       uint8_t mode_changeable[SCSI_MAX_MODE_LEN];
>       uint8_t *p;
>       int len, expected_len, changeable_len, i;
> @@ -1543,21 +1543,21 @@ static int scsi_disk_check_mode_select(SCSIDiskState *s, int page,
>       }
>   
>       p = mode_current;
> -    memset(mode_current, 0, inlen + 2);
>       len = mode_sense_page(s, page, &p, 0);
> -    if (len < 0 || len != expected_len) {
> +    /* The guest may send a truncated page, but not a longer one.  */
> +    if (len < 0 || expected_len > len) {
>           return -1;
>       }
>   
>       p = mode_changeable;
> -    memset(mode_changeable, 0, inlen + 2);
> +    memset(mode_changeable, 0, len);
>       changeable_len = mode_sense_page(s, page, &p, 1);
>       assert(changeable_len == len);
>   
>       /* Check that unchangeable bits are the same as what MODE SENSE
>        * would return.
>        */
> -    for (i = 2; i < len; i++) {
> +    for (i = 2; i < expected_len; i++) {
>           if (((mode_current[i] ^ inbuf[i - 2]) & ~mode_changeable[i]) != 0) {
>               return -1;
>           }
> @@ -1565,11 +1565,15 @@ static int scsi_disk_check_mode_select(SCSIDiskState *s, int page,
>       return 0;
>   }
>   
> -static void scsi_disk_apply_mode_select(SCSIDiskState *s, int page, uint8_t *p)
> +/* Note p may be truncated, so check any bytes you access against len.  */
> +static void scsi_disk_apply_mode_select(SCSIDiskState *s, int page,
> +                                        uint8_t *p, int len)
>   {
>       switch (page) {
>       case MODE_PAGE_CACHING:
> -        blk_set_enable_write_cache(s->qdev.conf.blk, (p[0] & 4) != 0);
> +        if (len > 0) {
> +            blk_set_enable_write_cache(s->qdev.conf.blk, (p[0] & 4) != 0);
> +        }
>           break;
>   
>       default:
> @@ -1612,6 +1616,7 @@ static int mode_select_pages(SCSIDiskReq *r, uint8_t *p, int len, bool change)
>                   goto invalid_param_len;
>               }
>               trace_scsi_disk_mode_select_page_truncated(page, page_len, len);
> +            page_len = len;
>           }
>   
>           if (!change) {
> @@ -1619,7 +1624,7 @@ static int mode_select_pages(SCSIDiskReq *r, uint8_t *p, int len, bool change)
>                   goto invalid_param;
>               }
>           } else {
> -            scsi_disk_apply_mode_select(s, page, p);
> +            scsi_disk_apply_mode_select(s, page, p, page_len);
>           }
>   
>           p += page_len;

Thanks for looking at this, Paolo. I've just done a quick check of the q800 machine 
and the CDROM still appears to be working with this patch so:

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


