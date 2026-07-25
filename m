Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40C7C531C9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 09:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnYc9-0004Yb-8U; Sat, 25 Jul 2026 05:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wnYc3-0004Y0-GI; Sat, 25 Jul 2026 05:24:07 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wnYc1-0001tZ-Pa; Sat, 25 Jul 2026 05:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=mjU2PvTRVuCoR3KcEKhn5dModOBxiK2ItqfG9ux+1UA=; b=I6wRcUU/OdNBhL4wkA5hjgbKGB
 s6pC3wvLCENrbXg0ITIUF1HuInV09K1620tWXURXO+4zNYu1OMYyED/IO3sJonoKmsfdh1hMtsNOz
 AYqV6o/x1fU3IVU35Y3japAaPnEEj1omZ6HktKDVXmtzj52OKufIjaDPWRFHqFgdC5DnDxYVMhERW
 pnNcjYuXu9p7jsl+h8aW4WjOgAh+P1BW8usvH+7YcrGvFAmiOpkBU1Va/CwXaB2cLp2BkfTQp7xaT
 lgkPhMXPxfZWX6LfaNmsJ+OnAASNdKLnPjvdL6w2NxesuOgoV77YL8T/NPgKWZrDHOVvEOlZGp/jW
 3qE8TMSdYby9q8Ym7dU+7v2dy6NM8G/3I4FD/luOR4nYjHUvtMHsCAVTJ5HtEqQBhq1p8a5aZ+KMi
 z6BlugjbQn/IF+iKsiV1sRsoHFldHg1LMOfKoBtwDzwWOkozRFssspcxNEl2MLpFLMKSER/7k4bkK
 tuLOjnkZtsgVQtoN0JCi7UE5FDtrXe3A0Zt1M3lumniIadejQo0vMrhcsJLa3bkLSGBeb9/LtFtas
 lTtoAfF78W5qkLtk3avu0JnnxZPqi2OV1CpZjaLZ16P6GL8r46ZsTSpsB0tcxCpMyBMjupqtHOb+u
 7MJ/d9RsCSbaLXtL/dKVp/027frGA7rZegoG8shwI=;
Received: from [2a02:8012:2f01:0:34a6:6cc:a7a8:2b1e]
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wnYbo-004Un7-KT; Sat, 25 Jul 2026 10:23:53 +0100
Message-ID: <ddea23d0-0371-4836-8b2f-5facef24e0fc@ilande.co.uk>
Date: Sat, 25 Jul 2026 10:23:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 qemu-stable@nongnu.org
References: <20260313170938.449538-1-peter.maydell@linaro.org>
 <48fdece2-5b98-4785-9b47-9eb2528803e2@ilande.co.uk>
 <CAFEAcA_zf5joZKeiU=c5qP+PzbkrPEVOBZ0nMrOhidiywi_s8w@mail.gmail.com>
 <CAFEAcA-MQ8tObH=9j-O-bqfGMLc2oTwaM1xEzv__GU2qrncmgw@mail.gmail.com>
 <CAFEAcA_boBOkNAaUgX=QEQvm3Mgy2ewkSNtx8zR9e=P58aWmmQ@mail.gmail.com>
 <CAFEAcA-VF47TGkRQBh_phZVvZ36tN5OJepbb1z=t=O=R3CwZDg@mail.gmail.com>
 <db7478f3-3cfa-43bc-901c-01842f180a92@ilande.co.uk>
 <CAFEAcA8j+W7eqJqBj-3Rq5ZBkOTapOKHSZFf+7ds4==5kKk-Tg@mail.gmail.com>
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
In-Reply-To: <CAFEAcA8j+W7eqJqBj-3Rq5ZBkOTapOKHSZFf+7ds4==5kKk-Tg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:34a6:6cc:a7a8:2b1e
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] target/sparc: Set reg window data structures currently
 after vmstate load
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

On 24/07/2026 09:48, Peter Maydell wrote:

> On Tue, 21 Jul 2026 at 22:01, Mark Cave-Ayland
> <mark.cave-ayland@ilande.co.uk> wrote:
>>
>> On 18/07/2026 09:46, Peter Maydell wrote:
>>>>>> Are you OK with this patch as it stands, or would you like me to
>>>>>> change it?
>>
>> Sorry about the long delay getting to this one. Looking through the migration code,
>> the current approach uses get/put handlers for registers that need to do more than
>> just update value in the state. Longer term that code could do with an update to use
>> .post_load, but for now I think it makes sense to use the existing pattern,
>> particularly as it keeps the separation between 32-bit and 64-bit.
>>
>> The following diff gives the same output in analyze-migration.py and I think should
>> solve the issue based upon your analysis:
> 
> Yes, that should also work. There's a minor bug in it, though:
> 
>> +static int put_cwp(QEMUFile *f, void *opaque, size_t size,
>> +                   const VMStateField *field, JSONWriter *vmdesc)
>> +{
>> +    SPARCCPU *cpu = opaque;
>> +    CPUSPARCState *env = &cpu->env;
>> +    uint32_t val = cpu_get_cwp64(env);
> 
> This should be "val = env->cwp;" (cpu_get_cwp64() returns
> "env->nwindows - 1 - env->cwp", but we just want the plain env->cwp
> value because that's what we used to migrate and what the get_cwp()
> function wants to see.)
> 
> With that change, the sanitizer is happy with the migration-test.
> 
> Do you plan to send your version as a proper patch?

Thanks for confirming. I'll tidy it up and send it through as a proper patch later.


ATB,

Mark.


