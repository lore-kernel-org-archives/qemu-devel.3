Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A15C98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 12:40:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAoAd-0002Qr-0I; Sun, 27 Sep 2026 08:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xAoAa-0002No-Ol
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 08:39:52 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xAoAZ-0005hH-6b
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 08:39:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=fS3f2RWo5VZ+NsK+DGFfuRHEnRzS3A6AWrnI2kmae7I=; b=RQvAo8FaSM2sfDhmuFxWMgXzD6
 KgE3hsmpy5WR7YweC0WrFifByQCF+H7+C3B5o8txkNZvs4KNb4FJyvs1ZFbB7NzFc3htqTtWEfSf+
 Fa5lKqzkPJgTfin3tfCIFEW3Ol1wUPfIa2M63nGlSI9cmOqjEkJIPcs8TMA4p6fKXWN0eD0DCKRx3
 US+OSU1rTr6AE3AI772hhahl5lgnKdWBWg84SRwlDhyZljNW/s2Hs/61bhxaMhzthwW8tSwKIEq1B
 u89M/HnmhIqLgKg8OpHphp1n9aWOAehrQY0TCFRgbQ/uxll9FYxtDjFBcDajvibAlpHJz2F0kzGBh
 /xP9utWyoL3YsFhLD4gDIJTGuAnrMShE+fvTc6OVpxVpy1wDbZIOLQic1lRuVhxFQUzO5q5ibpSPJ
 SyVkHKxrcH1EJc9XBlZMAAtj50B+i96VHkuVHKKEUBdtCcioY+H5PnpN6e1VBxOS04JYyIgESfhFf
 1QaH1A7WZZ9iZfzkijQdwpeTJYBwnUHQ2X9eY0+W3Df5hbFnRvNhU2DK/JT1Jw2/1QsxmUPVYgxY3
 A2LXZZnSyDAFAx1gvZdAuChCbaMchmAfy1N16fPH9IA2VxG1OD2oRxlizh87krdUqSkqSaAqrbWsG
 RQ5Qfo3fiJKHAHkHiR5ag65gad6pNzlWWxCt2jogc=;
Received: from [2a02:8012:2f01:0:fe49:60b9:9856:b8ef]
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xAo9z-00G0Hj-Hu; Sun, 27 Sep 2026 13:39:15 +0100
Message-ID: <cc6f98a8-22a1-4a56-8499-7d7873671f37@ilande.co.uk>
Date: Sun, 27 Sep 2026 13:39:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Richard Henderson <richard.henderson@linaro.org>, pbonzini@redhat.com,
 qemu-devel@nongnu.org
References: <20260926072815.467722-1-mark.cave-ayland@ilande.co.uk>
 <b85730f0-ced2-432c-87a8-3b21c6342ad8@linaro.org>
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
In-Reply-To: <b85730f0-ced2-432c-87a8-3b21c6342ad8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:fe49:60b9:9856:b8ef
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] target/i386/tcg: fix lea address for instructions with an
 override prefix
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

On 26/09/2026 18:09, Richard Henderson wrote:

> On 9/26/26 00:27, Mark Cave-Ayland wrote:
>> Always add the segment base when an override prefix is specified in segmented
>> mode. Otherwise the generated address is calculated incorrectly when an override
>> prefix is specified and HF_ADDSEG_MASK is not set.
>>
>> Fixes: 55a15eb3504 ("target/i386/tcg: simplify effective address calculation")
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   target/i386/tcg/translate.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>>
>> Paolo/Richard: I'm not sure if this patch is exactly correct, however it fixes
>> a regression when launching the OpenWatcom installer under MS-DOS. Current
>> git master aborts the installer with a GPF error in the guest caused by this
>> instruction:
>>
>> 0x0041e0b5:  66 2e 8e 1d 0c 00 00 00  movw     %cs:0xc, %ds
>>
>> where def_seg == 3, ovr_seg == 1 and ADDSEG(s) is 0. Without this fix the target
>> address is calculated as 0xc instead of 0x41e00c.
> 
> It isn't the root cause, no.  Here we go:
> 
> x86_update_hflags:
>>             hflags |= ((env->segs[R_DS].base | env->segs[R_ES].base |
>>                         env->segs[R_SS].base) != 0) << HF_ADDSEG_SHIFT;
> 
> cpu_x86_load_seg_cache:
>>             new_hflags |= ((env->segs[R_DS].base |
>>                             env->segs[R_ES].base |
>>                             env->segs[R_SS].base) != 0) <<
>>                 HF_ADDSEG_SHIFT;
> 
> So we've been incorrectly including CS in ADDSEG since 55a15eb3504.
> 
> Thus
> 
> -    has_base = ovr_seg >= R_FS || (ovr_seg >= 0 && ADDSEG(s));
>      switch (ovr_seg) {
>      case R_DS:
>      case R_ES:
>      case R_SS:
>          has_base = ADDSEG(s);
>          break;
>      case R_CS:
>      case R_FS:
>      case R_GS:
>          has_base = true;
>          break;
>      default:
>          assert(ovr_seg < 0);
>          has_base = false;
>          break;
>      }
> 
> might be the most legible way to fix the above expression.
>  
> r~

Hi Richard,

Thanks for the explanation: I've just sent through an updated patch based upon your 
example above with an updated commit message.


ATB,

Mark.


