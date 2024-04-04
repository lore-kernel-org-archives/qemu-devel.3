Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C97CD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 12:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsMb7-0001fE-Cn; Thu, 04 Apr 2024 08:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsMb5-0001en-0s
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 08:53:39 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsMb3-0002LU-7Y
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 08:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ryzk9wTIoVoGHNBkiaWg16URzyG0EO3lip/k4XXZVE8=; b=vxlRjc1yCtZ6HOXOVoOtFEgRIi
 WFepuMqED7Q9Ry27tnlIUnHYvBww99tDIGnxLAmQ62yGt3N9WBuFrepFGFORy8CnTXIEcHf7suL2V
 7yN3DRYgd99YZws7LZIpfw/VJndta8Xek7Ltf8/BkgF2wt/aqxpqalv+xb3hYKjy8oniLcTPr0qXt
 E1dCqqDuEQtEv2OIbsr//n+r8FNhPhjMZk8UDX32GwlJGzhG6+aLcNqOW+6uJva5Wh7DkCjRE7hEo
 +ZeK7RkOD5w0c3u4TesbtK8vaAXVdz/3FdTHvrgl8CL2TIdlXXE5zmJ2uypoR4V0ISmCmLOs+edHV
 AmdJ7JT5q9DVfpR0S1VaHdfyG6PSnA7nvUMcEv3YuQEtIc2vB6P29UX7a1BUCKYKb2gDkZkVMvz1y
 4fzgObx4gSUpVuS68xzY1/FQaqAbXGTVhyN2eXPqPXppCPicXgTcPlwm/H1ij5hdvLt8e38hDqtAf
 t42r2tGuX4+kqk3LwhL+XnwCSzSQ5Xx4kI6mnM5fO99xhkiuNeyZPo4qO8DDJJnIW4Pw2C43B95zc
 pI+e0bL4Ysyu9070jF/b6dmSV2OzRurB4PewlqV+2DAYdWdA97dgBALiW/KNPMKoVxADCpaGLAnpd
 k3xbtGfdyRilhJpoduj8aOkA7CP6eNsrKxbQEKpZI=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsMa2-000BAz-7H; Thu, 04 Apr 2024 13:52:34 +0100
Message-ID: <14d3b0c3-53d1-4029-a2de-16918cae10a6@ilande.co.uk>
Date: Thu, 4 Apr 2024 13:53:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu, qemu-devel@nongnu.org
References: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
 <e6e59dbe-66da-434c-a9d8-1038858b70c7@linaro.org>
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
In-Reply-To: <e6e59dbe-66da-434c-a9d8-1038858b70c7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 00/17] [for-9.0] esp: avoid explicit setting of DRQ
 within ESP state machine
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

On 04/04/2024 11:28, Philippe Mathieu-Daudé wrote:

> Hi Mark,
> 
> On 24/3/24 20:16, Mark Cave-Ayland wrote:
> 
>> Mark Cave-Ayland (17):
>>    esp.c: move esp_fifo_pop_buf() internals to new esp_fifo8_pop_buf()
>>      function
>>    esp.c: replace esp_fifo_pop_buf() with esp_fifo8_pop_buf() in
>>      do_command_phase()
>>    esp.c: replace esp_fifo_pop_buf() with esp_fifo8_pop_buf() in
>>      do_message_phase()
>>    esp.c: replace cmdfifo use of esp_fifo_pop() in do_message_phase()
>>    esp.c: change esp_fifo_push() to take ESPState
>>    esp.c: change esp_fifo_pop() to take ESPState
>>    esp.c: use esp_fifo_push() instead of fifo8_push()
>>    esp.c: change esp_fifo_pop_buf() to take ESPState
>>    esp.c: introduce esp_fifo_push_buf() function for pushing to the FIFO
>>    esp.c: don't assert() if FIFO empty when executing non-DMA SELATNS
>>    esp.c: rework esp_cdb_length() into esp_cdb_ready()
>>    esp.c: prevent cmdfifo overflow in esp_cdb_ready()
>>    esp.c: move esp_set_phase() and esp_get_phase() towards the beginning
>>      of the file
>>    esp.c: introduce esp_update_drq() and update esp_fifo_{push,pop}_buf()
>>      to use it
>>    esp.c: update esp_fifo_{push,pop}() to call esp_update_drq()
>>    esp.c: ensure esp_pdma_write() always calls esp_fifo_push()
>>    esp.c: remove explicit setting of DRQ within ESP state machine
> 
> I have to prepare another PR for rc3, do you want me to take
> this series?

Hi Phil,

Thanks for the offer, but amazingly I have a little bit of time this afternoon(!), so 
I'll try and send a PR later today.


ATB,

Mark.


