Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36EE2C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 20:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7hqG-0005Bk-Kv; Thu, 16 May 2024 16:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s7hqC-0005AJ-Sc
 for qemu-devel@nongnu.org; Thu, 16 May 2024 16:36:41 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s7hqA-0005Dg-Th
 for qemu-devel@nongnu.org; Thu, 16 May 2024 16:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ukQvhjy+lfoRas69TGGEOFuTc9MnHaqr2DUutMNupLU=; b=h5hKlFtlil6OSFgActWTIhmAYE
 xKukx1djRRPJekmgX3KbCZ+yikwJUlWA98eFc8h0JTjU4U1apH/oKG8Gg4/LATinH3MQTGeFbnC9t
 7OTPhYebpohfDIp4peTW38pnSX3JoT2YtanbPuOXobUnqqEzj7LlcYquNpWT9m9WGAGkYJFQJTRYC
 wZKw8gbDzv6oRJ3mnw+mZpUtBuNP7BJ8xYNCZWIW7WwcHj+vmfjpPwbvDF1h5Ad5Vep9x0/jIdyYb
 uoHtruS7B6BIFd0TPLtJqMv/B1KdX8SBSEF6Mj1X0X5Sve0/0UGByFBD3aTu2gZaL61jKOtM+78XT
 UqjsvY7woNzhQLIedPOTPDMaFqVIdjubIzXeBqZV+XT5t7G1VRSMw4P76RYd0BFUYi67LQtc4z8Z3
 7Dk60oLAEYwvRbcDigxuqdaYbtgz0GDSCej9jg7J+ouU8jpH9VfY174igED44yzZDkobmjqq3zx6H
 rG/Z2E4QWIo6UkjVV81wfDH7l+6eLG7CAkUIb9q7AQkA0ak5A3t+dV5f2cezHBg1J+TBDhhtcAGqR
 YYTnE4Vj1TTB25qJDu53yUrT2xKsFoUMBJULDLsv4l/wNSc3w74ZztKK/oAYUHhu/SMPZno3/iBXg
 XlaxXIzYowL/z+bPqUJWBL8uRfXA9D2WI06dRDKiY=;
Received: from [2a00:23c4:8bb4:4000:b9f5:bb19:df0e:ea5c]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s7hoy-0003Y0-2K; Thu, 16 May 2024 21:35:24 +0100
Message-ID: <a929e15f-f558-44a3-ae43-4c5b5bd2c1f5@ilande.co.uk>
Date: Thu, 16 May 2024 21:36:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: atar4qemu@gmail.com
References: <20240302051601.53649-1-richard.henderson@linaro.org>
 <7b5e744c-7fc5-4bf2-9602-1d2cc97913be@ilande.co.uk>
 <f38d59f4-3cf9-470e-962a-c888970b5a21@linaro.org>
 <3048a39d-9d14-46f3-9672-317a034fa5b5@linaro.org>
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
In-Reply-To: <3048a39d-9d14-46f3-9672-317a034fa5b5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:b9f5:bb19:df0e:ea5c
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 00/41] target/sparc: Implement VIS4
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

On 15/05/2024 16:30, Richard Henderson wrote:

> On 4/29/24 23:02, Richard Henderson wrote:
>> On 4/29/24 13:52, Mark Cave-Ayland wrote:
>>> No objections here about the remainder of the series, other than that I don't have 
>>> an easy/obvious way to test the new instructions...
>>
>> I was thinking about adding support to RISU, but the gcc compile farm sparc 
>> machines have been down for ages, so no way to generate the reference traces.
> 
> Update: I have successfully ported RISU to Sparc64, Solaris and Linux.  There is a 
> limitation in that I cannot find how to extract %gsr from the signal frame, which is 
> unfortunate, but I can work around that for now.
> 
> I have added descriptions of VIS1 instructions to RISU, and it turns out we have 
> failures relative to a Sparc M8.  I have not yet analyzed these failures, but it 
> proves the effort was not wasted.  :-)
> 
> I'll clean up these patches and post them here when I next get some downtime.
>  
> r~

That's great news, thanks for the update. I've had confirmation that there is work 
underway to repair the SPARC hardware hosting Linux for the gcc buildfarm, so 
hopefully it will be back in service soon.


ATB,

Mark.


