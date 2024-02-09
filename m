Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB55BC4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 21:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYYQX-0004oZ-1x; Fri, 09 Feb 2024 16:28:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rYYQV-0004oP-NB
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 16:28:51 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rYYQU-0000tY-1j
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 16:28:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=a4v+mKWCOpO0LFSJftm3ab0uDaJaunyu7XlYuJCL0M0=; b=kuCWjgQYo7TQjJuleV4zARKUN1
 v3VtWbWBnUhy75n2kvNtHHGXZUxxFwXIMFqOeRkkuxtbS8Ch+QcHID4OpFrWiHAVXRtXjGLLCXmB9
 DN+YbMoqLL9sv65GsFp/nOKlsJfroaZ+YLrPRcVFjgki4pMabeH/RdVSRnJ4sY3leG7x06uBz5On9
 A2gjz/fix6zpe9CVxCEAfFH9D8v9NoPO3tvBfGMUCiT79j7UQZLxSmaXYLwN2gR8EAnDINyN/dKKK
 IyjPvo0I5XYs0QGV2TxY7CkdAddnJ9UnHFkBqb0kTKxJ6kXRT+iPvO9RWm48HkKzDFq7xE5xXk2l+
 Udq9/eWdaRsYhYzp9FVZKfVBe2r4no4NpzBOB7jzPr/ssXzMa4zEb8YpgXBkGUVN3jk1/xipymwhl
 ykZ6EkBEQNa1Jr20IllhueYXWhbkb4yZVZZfJ+PxMkTqO26/oSkB6thcSL0g3IrZg2gNyXxME7z81
 RAwBZWbU7M0s7/THsIAgLuIXuKKDPUj0toYaomTWVpfGdj2UH+FKMON2OKRPEaJ/ajUcUjgGlC2YP
 S7d0X/+4fpyRe0cC+RX/aan2hjR7dVrbTa7IUiPlYDmkjQm2HI+ayt7V+z5O2ShHQ+A+L+5LevKz5
 0iFH5ztn069fOo8CAVYOe5iCroTlePdaf7rnEAkn4=;
Received: from [2a00:23c4:8bb2:1300:1032:5a09:fd17:2b9e]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rYYPa-0002PI-OI; Fri, 09 Feb 2024 21:27:58 +0000
Message-ID: <4fc506bf-717e-4177-9aeb-62eaa9155b27@ilande.co.uk>
Date: Fri, 9 Feb 2024 21:28:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>, Laurent Vivier <laurent@vivier.eu>,
 Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
 <20240112125420.514425-10-mark.cave-ayland@ilande.co.uk>
 <CABgObfZ3VY84p8A=+3nOnkttQk=64vQAyNk76VRHqzURwHrYww@mail.gmail.com>
 <c9dfd1d3-c784-456f-ba6e-dc56388fd79e@ilande.co.uk>
 <CABgObfbWqHBq0udoqaPxe=H=oGQe4WwdsfU6+iJVJMF9LoGRow@mail.gmail.com>
 <f18b34b6-449f-4926-b353-bf3b830919d0@ilande.co.uk>
 <CABgObfbF-R2O7Ly0jVRWF08Y-P3tbkQbUaF4N6oB5Dtcy_FswA@mail.gmail.com>
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
In-Reply-To: <CABgObfbF-R2O7Ly0jVRWF08Y-P3tbkQbUaF4N6oB5Dtcy_FswA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:1032:5a09:fd17:2b9e
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 09/88] esp: update TC check logic in do_dma_pdma_cb() to
 check for TC == 0
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 08/02/2024 18:11, Paolo Bonzini wrote:

> On Thu, Feb 8, 2024 at 10:46 AM Mark Cave-Ayland
> <mark.cave-ayland@ilande.co.uk> wrote:
>>
>> On 01/02/2024 11:36, Paolo Bonzini wrote:
>>
>>> Il gio 1 feb 2024, 12:25 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk
>>> <mailto:mark.cave-ayland@ilande.co.uk>> ha scritto:
>>>
>>>      On 01/02/2024 10:46, Paolo Bonzini wrote:
>>>
>>>       > On Fri, Jan 12, 2024 at 1:55 PM Mark Cave-Ayland
>>>       > <mark.cave-ayland@ilande.co.uk <mailto:mark.cave-ayland@ilande.co.uk>> wrote:
>>>       >>
>>>       >> Invert the logic so that the end of DMA transfer check becomes one that checks
>>>       >> for TC == 0 in the from device path in do_dma_pdma_cb().
>>>       >>
>>>       >> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk
>>>      <mailto:mark.cave-ayland@ilande.co.uk>>
>>>       >> ---
>>>       >>   hw/scsi/esp.c | 24 +++++++++++-------------
>>>       >>   1 file changed, 11 insertions(+), 13 deletions(-)
>>>       >>
>>>       >> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
>>>       >> index fecfef7c89..63c828c1b2 100644
>>>       >> --- a/hw/scsi/esp.c
>>>       >> +++ b/hw/scsi/esp.c
>>>       >> @@ -602,21 +602,19 @@ static void do_dma_pdma_cb(ESPState *s)
>>>       >>               return;
>>>       >>           }
>>>       >>
>>>       >> -        if (esp_get_tc(s) != 0) {
>>>       >> -            /* Copy device data to FIFO */
>>>       >> -            len = MIN(s->async_len, esp_get_tc(s));
>>>       >> -            len = MIN(len, fifo8_num_free(&s->fifo));
>>>       >> -            fifo8_push_all(&s->fifo, s->async_buf, len);
>>>       >> -            s->async_buf += len;
>>>       >> -            s->async_len -= len;
>>>       >> -            s->ti_size -= len;
>>>       >> -            esp_set_tc(s, esp_get_tc(s) - len);
>>>       >> -            return;
>>>       >> +        if (esp_get_tc(s) == 0) {
>>>       >> +            esp_lower_drq(s);
>>>       >> +            esp_dma_done(s);
>>>       >>           }
>>>       >
>>>       > I'm only doing a cursory review, but shouldn't there be a return here?
>>>       >
>>>       > Paolo
>>>
>>>      (goes and looks)
>>>
>>>      Possibly there should, but my guess is that adding the return at that particular
>>>      point in time at the series broke one of my reference images. In particular MacOS is
>>>      notorious for requesting data transfers of X len, and setting the TC either too high
>>>      or too low and let the in-built OS recovery logic handle these cases.
>>>
>>>
>>> Absolutely, just noticing that there is a functional change but the commit message
>>> showed it as a refactoring only.
>>
>> Would you like me to come up with a reworded commit message here?
> 
> If you want to change it, it's okay because len is zero at this point
> and the code after the "if" therefore does nothing. And the "if" will
> become esp_dma_ti_check() so adding a return is kind of messy here.

Okay I'll leave it as it is - I'm not too worried about the detail here, since that 
particular section ends up being removed.

>>> The fact that this is bisectable is quite insane, and I am not asking for any code
>>> changes. TBH I wouldn't have blamed you if you just sent a patch to create esp2.c and
>>> a patch to delete esp.c...
>>
>> Heh... spending a chunk of time rewriting the emulation of a 30 year-old SCSI
>> controller is probably an odd choice, but the result is something that is
>> considerably more maintainable than the current implementation.
> 
> I absolutely agree, you went above and beyond and sorry if it wasn't
> clear from the joke.

No worries, I wasn't taking it seriously either :)

>> Anything else that you'd like me to change before the series can be considered for merge?
> 
> No, go ahead!

Thanks! I'll take that as a nod to send a PR over the next few days.


ATB,

Mark.


