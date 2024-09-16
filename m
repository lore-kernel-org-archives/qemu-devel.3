Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB8AC3ABA2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 12:14:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqAcP-0006Yt-Dm; Mon, 16 Sep 2024 08:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sqAcM-0006Vc-M0
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 08:14:10 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sqAcK-0000A0-DN
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 08:14:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=MTkAbvY/okSbIK3sQsAHXC5W187IFsx5mof5sw3h+jQ=; b=z3gfEzqGMlXxCYPUM8jDR3a+Ng
 jsHFtUKsztnnt+DgD/VxqHUq8GVTZdfUChyNUH/S0Bp9VA0fGmwl8n88QTpYo8rn/gDOifUSlV4Ex
 PoN/l1lO1RKub5r23IKAizhI30Do5D/+l1NfHn4pIrtQTVnug9yskAbYiXqihoMyZS0kCC20SNIRl
 vj9mEkIOdXvjf/8NmOw57x7bA0YcBN8IwGiKWr8NEhAZzINiZUgcAXpdAuBJ2/ZHduq4HDDDXzRBN
 JMxFn394FhBHXvkYPpcseynDBSW1gs06L0AKZclivfysgI8I3FGO0awMPZqFyVisf8m6waKMst3YO
 EChXDyd9+tHUxSdb84FOHz9ElHPunN1sYwVnBkClhQ2TDatlP+J83kC7W1Jx00Z7rJShVHvOAfPoN
 uvYMBQ6XZ4F4f/gQfROGjM9Mmjxl66/YLNtWg8lrNZXYi3M+/M6/hr6MB4hx2/aBKRUTZH31Eg/cH
 6G0UIZfXfTTK0e3owNrt5njICPyPC4XWzFROHTUrJQB10IbxzUySaT7Bp+YJdAvIRhchuQAo6mON2
 1KH5Yw9EaHGUI5oGPLwQVYY+5KXCt2zeERaeXTKBuCa7dv1oxwywO/qZDzIlDbt88dj2eQahSFBoU
 ag7i1XuQcXwfTLI07TzHsvC0Yht0RHMdxETXyHNWs=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sqAc4-0006eX-Eo; Mon, 16 Sep 2024 13:13:56 +0100
Message-ID: <10b76006-4cb5-485e-aff2-87c9e511ad2b@ilande.co.uk>
Date: Mon, 16 Sep 2024 13:13:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Mattias Nissler <mnissler@rivosinc.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20240909201147.3761639-1-peterx@redhat.com>
 <20240909201147.3761639-2-peterx@redhat.com>
 <441f797f-a377-45de-bfe6-042542c917d8@kaod.org> <ZuRQirmjwWGj1N2D@x1n>
 <CAGNS4TaDVs9eqb9jO5kgi9bL1t1tmc-GywiyP3xpbgFGgvbkLg@mail.gmail.com>
 <0d4c42a4-352d-4b14-905d-ef4839c68ad1@ilande.co.uk>
 <CAFEAcA80SmMbNOhUqgB8h+16RR+d_hOeoVqUCJQZJHvDUtCaYw@mail.gmail.com>
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
In-Reply-To: <CAFEAcA80SmMbNOhUqgB8h+16RR+d_hOeoVqUCJQZJHvDUtCaYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PULL 1/9] softmmu: Support concurrent bounce buffers
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

On 16/09/2024 12:44, Peter Maydell wrote:

> On Mon, 16 Sept 2024 at 12:29, Mark Cave-Ayland
> <mark.cave-ayland@ilande.co.uk> wrote:
>>
>> On 16/09/2024 09:23, Mattias Nissler wrote:
>>> Looking at the code, the dma_memory_unmap calls in hw/ide/macio.c seem
>>> to be passing buffer=NULL unconditionally, since the dma_mem field in
>>> struct DBDMA_io is never set to anything non-zero. In fact, I believe
>>> after commit be1e343995ef81fc05d9a4e1ec263ca171d842e7 "macio: switch
>>> over to new byte-aligned DMA helpers", the dma_memory_unmap calls in
>>> hw/ide/macio.c aren't doing anything and should probably have been
>>> removed together with the dma_mem, dma_len and dir fields in struct
>>> DBDMA_io. Speculative patch:
>>>
>>> diff --git a/hw/ide/macio.c b/hw/ide/macio.c
>>> index e84bf2c9f6..15dd40138e 100644
>>> --- a/hw/ide/macio.c
>>> +++ b/hw/ide/macio.c
>>> @@ -119,9 +119,6 @@ static void pmac_ide_atapi_transfer_cb(void
>>> *opaque, int ret)
>>>        return;
>>>
>>>    done:
>>> -    dma_memory_unmap(&address_space_memory, io->dma_mem, io->dma_len,
>>> -                     io->dir, io->dma_len);
>>> -
>>>        if (ret < 0) {
>>>            block_acct_failed(blk_get_stats(s->blk), &s->acct);
>>>        } else {
>>> @@ -202,9 +199,6 @@ static void pmac_ide_transfer_cb(void *opaque, int ret)
>>>        return;
>>>
>>>    done:
>>> -    dma_memory_unmap(&address_space_memory, io->dma_mem, io->dma_len,
>>> -                     io->dir, io->dma_len);
>>> -
>>>        if (s->dma_cmd == IDE_DMA_READ || s->dma_cmd == IDE_DMA_WRITE) {
>>>            if (ret < 0) {
>>>                block_acct_failed(blk_get_stats(s->blk), &s->acct);
>>> diff --git a/include/hw/ppc/mac_dbdma.h b/include/hw/ppc/mac_dbdma.h
>>> index 4a3f644516..c774f6bf84 100644
>>> --- a/include/hw/ppc/mac_dbdma.h
>>> +++ b/include/hw/ppc/mac_dbdma.h
>>> @@ -44,10 +44,6 @@ struct DBDMA_io {
>>>        DBDMA_end dma_end;
>>>        /* DMA is in progress, don't start another one */
>>>        bool processing;
>>> -    /* DMA request */
>>> -    void *dma_mem;
>>> -    dma_addr_t dma_len;
>>> -    DMADirection dir;
>>>    };
>>>
>>>    /*
>>>
>>> Cédric, can you try with the above patch and/or share more details of
>>> your setup so I can verify (I tried booting a ppc64el-pseries dqib
>>> image but didn't see the issue)?
>>
>> I'm fairly sure that this patch would break MacOS 9 which was the reason that
>> dma_memory_unmap() was added here in the first place: what I was finding was that
>> without the dma_memory_unmap() the destination RAM wasn't being invalidated (or
>> marked dirty), causing random crashes during boot.
> 
> dma_memory_unmap() of something you never mapped is
> definitely wrong. Whatever is going on here, leaving the unmap
> call in after you removed the dma_memory_map() call is just
> papering over the actual cause of the crashes.
> 
>> Would the issue be solved by adding a corresponding dma_memory_map() beforehand at
>> the relevant places in hw/ide/macio.c? If that's required as part of the setup for
>> bounce buffers then I can see how not having this present could cause problems.
> 
> The only purpose of this API is sequences of:
>    host_ptr = dma_memory_map(...);
>    access the host_ptr directly;
>    dma_memory_unmap(...);
> 
> The bounce-buffer stuff is an internal implementation detail
> of making this API work when the DMA is going to a device.
> 
> We need to find whatever the actual cause of the macos failure is.
> Mattias' suggested change looks right to me.
> 
> I do wonder if something needs the memory barrier than
> unmap does as part of its operation, e.g. in the
> implementation of the dma_blk_* functions.

It has been a few years now, but I'm fairly sure the issue was that dma_blk_read() 
didn't mark RAM containing code as dirty/invalid, and since MacOS 9 used overlays 
then it would crash randomly trying to execute stale memory. dma_memory_unmap() 
checks to see if the direction was to RAM, and then marks the memory dirty allowing 
the new code to get picked up after a MMU fault.

If the memory barriers are already in place for the dma_blk_*() functions then the 
analysis could be correct, in which case the bug is a misunderstanding I made in 
be1e343995 ("macio: switch over to new byte-aligned DMA helpers") back in 2016.


ATB,

Mark.


