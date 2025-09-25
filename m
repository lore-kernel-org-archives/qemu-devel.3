Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4838CAC5BA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 19:56:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1s3E-0000KL-So; Thu, 25 Sep 2025 15:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1v1s32-0000Fs-5q
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 15:54:36 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1v1s2u-000297-Vt
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 15:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=2rOtZUVj6iu/wGQXtNOiQ9U1tovETYiT4TfHj08ev1o=; b=MFYYYPOLaS2nJERDJ3R3/4beQR
 JbDPF2yOQ8WMw36TPHFB/9/iY6ppvWkqgIYDc9mXWWaUNOVj1zb3yVsksgpH8i9mDi5BtyJTdxmh/
 AP0wPMegaMdXLpWgubGZg95toTHxuVuoh8XB00DONA4OrUPEZ6toNjMXGskSKwqExummdLPg24rPE
 7Vw8HhAPSVfNh6fixQWKvb6UWiE/HkMpfUIGk3eBALjhK7bJncGrZPAkMrWSXleQoPUAbTtjrL4ZW
 gXWtgIryZzogcbCxjGne3WTpeDrl1MRrIkBL1jJHgxhItf6a9OooWItC1pZw9Pff4sigjOHCtEtg0
 qx7A+4ECL1saQXPlI6bc5VZk7eFroWfIOPGs6TDaEkkqA4ZiAdEVPLpzE/80j3siWMedMG5vJyBvc
 DFseFsvHpiBHV/APTEf9rm1FyxqZ8lEDzhFgB++erXv8SAXyNNcpyuhojZMWODJi4ucY2n7JFQumg
 ef+s0wsRk+IR73snvIMleRNAEm+vShxiRQz48qP3DH2+g68kaIVAyx40/U94CqKtivq0EGLJL1mW8
 j3uG12phTNw9dUE2tWKD9tWTm9HEXjg8iXKdcVKC2gBiloSOmwmBMltTW5YK7XsvRgzhBlVBwIJRo
 RQG+gdZlAEaYvY1K8j+kNydUbmPL8NYO1k6NA3Rio=;
Received: from [2a02:8012:2f01:0:a298:a473:7634:a781]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1v1s0j-000C27-Vp; Thu, 25 Sep 2025 20:52:14 +0100
Message-ID: <425733d8-98f3-45bb-80e3-b8bc9785e80b@ilande.co.uk>
Date: Thu, 25 Sep 2025 20:54:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 pbonzini@redhat.com, fam@euphon.net, farosas@suse.de, lvivier@redhat.com,
 qemu-devel@nongnu.org, Alexander Bulekov <alxndr@bu.edu>
References: <20250925122846.527615-1-mark.cave-ayland@ilande.co.uk>
 <20250925122846.527615-2-mark.cave-ayland@ilande.co.uk>
 <f5655322-fc2b-4577-a802-1ea736e08f4c@linaro.org>
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
In-Reply-To: <f5655322-fc2b-4577-a802-1ea736e08f4c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:a298:a473:7634:a781
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 1/2] esp.c: fix esp_cdb_ready() FIFO wraparound limit
 calculation
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

On 25/09/2025 14:33, Philippe Mathieu-Daudé wrote:

> On 25/9/25 14:28, Mark Cave-Ayland wrote:
>> The original calculation in commit 3cc70889a3 ("esp.c: prevent cmdfifo overflow
>> in esp_cdb_ready()") subtracted cmdfifo_cdb_offset from fifo8_num_used() to
> 
> "substracted"

I had to look this one up, and I'm disappointed to report that it's considered 
obsolete these days ;)

>> calculate the outstanding cmdfifo length, but this is incorrect because
>> fifo8_num_used() can also include wraparound data.
>>
>> Instead calculate the maximum offset used by scsi_cdb_length() which is just
>> the first byte after cmdfifo_cdb_offset, and then peek the entire content
>> of the cmdfifo. The fifo8_peek_bufptr() result will then return the maximum
>> length of remaining data up to the end of the internal cmdfifo array, which
>> can then be used for the overflow check.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Fixes: 3cc70889a3 ("esp.c: prevent cmdfifo overflow in esp_cdb_ready()")
> 
> Buglink: https://issues.oss-fuzz.com/issues/439878564
> 
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3082
>> ---
>>   hw/scsi/esp.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
>> index 1d264c40e5..2809fcdee0 100644
>> --- a/hw/scsi/esp.c
>> +++ b/hw/scsi/esp.c
>> @@ -447,7 +447,9 @@ static void write_response(ESPState *s)
>>   static bool esp_cdb_ready(ESPState *s)
>>   {
>> -    int len = fifo8_num_used(&s->cmdfifo) - s->cmdfifo_cdb_offset;
>> +    /* scsi_cdb_length() only reads the first byte */
>> +    int limit = s->cmdfifo_cdb_offset + 1;
>> +    int len = fifo8_num_used(&s->cmdfifo);
>>       const uint8_t *pbuf;
>>       uint32_t n;
>>       int cdblen;
>> @@ -457,7 +459,7 @@ static bool esp_cdb_ready(ESPState *s)
>>       }
>>       pbuf = fifo8_peek_bufptr(&s->cmdfifo, len, &n);
>> -    if (n < len) {
>> +    if (n < limit) {
>>           /*
>>            * In normal use the cmdfifo should never wrap, but include this check
>>            * to prevent a malicious guest from reading past the end of the
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks for the review!


ATB,

Mark.


