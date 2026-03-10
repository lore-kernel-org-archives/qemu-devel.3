Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00395FCC9CB
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 05:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzq6P-0002W9-45; Tue, 10 Mar 2026 01:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzq6L-0002DR-Ru
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:57:54 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzq6K-0006Pi-4P
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:57:53 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48535a0ef86so17717005e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 22:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773122270; x=1773727070; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JOeE7ZKmjwJq+X451rY59ohF0DUiOay3c5oi3jd/bug=;
 b=ubkbHFkaCllZaa+//Us8iS4U9Ur/4JMCioqtKviMc4p8is/BLerJjMC97og+/xpPMn
 itdyvE/UB1MSI1E9NQcb7pWUwCpYEuYBlzjDKnrh1Wjpry40iEv83QjV4GGcUm761XPE
 Rw+BmPAJt1J9q06EDAosPLSTJjcT/GGlunMaO5xOfE3b6HmaO+ndLANNGPSxYQudF/cO
 Vm8i9uSqX1BrVKduzFy2PayqZPKx6z6q1DBBZqmdMmSvwORpxQNXyetyoxOrccovpWrZ
 dUH/vFVf0mKjkhXT32YfUpZeBrbLekhvOqbSQNxcdEd2KJSu5a9KTSa6/FWhjPl/z02K
 xAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773122270; x=1773727070;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JOeE7ZKmjwJq+X451rY59ohF0DUiOay3c5oi3jd/bug=;
 b=l1eiA42Io0lSj4TH7Im8uNA4FZQC4kjNdKM/mulACT59ICojxUWXpO4LsvF+/9ehlO
 C0SdfRIbQfmoMv1X9P9ZoXGTbUXW577BNSROdZ4F23aP71MDGEWaS+QI8orrMJ6wGxMR
 sBdAWXtNhwATiDTnUdnIvhr9spJuPlz5zlFIR2ptdrZ500WI/+A78RXNRe7cci1rwbdq
 tfEu1rnrkldSNw2/2HXmM87ViCyHsN9H/Y39yOOlKbHmOMc7DXsWqOWjFOsNi+4pgy9y
 UoO4oPBv5gHIA+VOMNOADTkGbrIooPuQd6DDa4Y5H/AH+yNtW8cclV7lxtGdFqui+T6c
 jOag==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6RtFSJJf+MpE54ENQrJE9fYHjZEtk7omoiIVvHLbpsiaY1mdFjNsB5WHq+6x7agDWJ51Sa5Wex94f@nongnu.org
X-Gm-Message-State: AOJu0YwRT8blNgDF07Q5xHHaYHVtcnmif0AX+PGSRhlgASWNtG6vSJJG
 S5vamtfsI5j1rv6eWU7DZ/Ah5khhSOMVwd79i7bTs2ZwXSA+ytdrd3tsF2FqA8c/KQgZdZrLonV
 MNv43DBw=
X-Gm-Gg: ATEYQzzAidJk87ICvxyIkPfkLSnneTfbZZnq8RALtdJ4EcU8dSspNuTgSr0Gly5kIe4
 nlYY+Qy2uY43d+03GHC58dCy3pWpsrC2+ou24fHdRYI1IshjKQWMVN1ymtclj0GxYx0+s4TI+pQ
 zGzHBEJeog4mILVboF7xd8o0O9eHqqfL2fv51PMMLHiTWn1NU6hV99Hf84qZ8g/d3bwLZpJ+MMe
 Oc6ejN5Qq01Pw+GqmemOzwT4PmjS/wMET0+3EuKXbGcwEcEo0gpMyyixHpgRyD/s2mhVg/IMnPs
 L35z+69U8dAxfWR73NyA8Q3+D4WNnphu262NDSv+C1NMQIsXeCFsKhNTBJEuykvO3wzuae3oXob
 1orvJS/V1hfcKDyUDLtqpTPSmviIeSXIzI2Xpns952utYNsRa7namszI01ZqK7CojoMd2q70V7r
 QS0VVrqny9e+9rSKMB/GQfsKfE9tlXAHblbyut91WCrV4Dyjl9VRSF+KlmJ/Bhhzrodw==
X-Received: by 2002:a05:600c:3b0c:b0:477:5b0a:e616 with SMTP id
 5b1f17b1804b1-485269188admr226872025e9.5.1773122270547; 
 Mon, 09 Mar 2026 22:57:50 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541b6f6e6sm90970965e9.10.2026.03.09.22.57.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 22:57:50 -0700 (PDT)
Message-ID: <18a50a29-1deb-41c5-91f1-ae5f76129a05@linaro.org>
Date: Tue, 10 Mar 2026 06:57:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ati-vga: Fix sign extension in DEFAULT_SC_BOTTOM_RIGHT
 read
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Chad Jablonski <chad@jablonski.xyz>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260309212206.2457691-1-chad@jablonski.xyz>
 <1931a6d0-d351-cc43-1b3d-fa3b3b0809a9@eik.bme.hu>
 <e2824e5c-4d1d-4d08-ba24-a8c3056c2edc@linaro.org>
 <de83d589-99c0-9d40-b29e-61f8deb3d249@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <de83d589-99c0-9d40-b29e-61f8deb3d249@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 9/3/26 23:59, BALATON Zoltan wrote:
> On Mon, 9 Mar 2026, Philippe Mathieu-Daudé wrote:
>> On 9/3/26 22:41, BALATON Zoltan wrote:
>>> On Mon, 9 Mar 2026, Chad Jablonski wrote:
>>>> Cast default_sc_bottom to uint32_t before shifting left to prevent
>>>> sign extension when assigning to uint64_t.
>>>>
>>>> Fixes: CID 1645615
>>>> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
>>>> ---
>>>> hw/display/ati.c | 2 +-
>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/display/ati.c b/hw/display/ati.c
>>>> index 6cf243bcf9..f9773e1154 100644
>>>> --- a/hw/display/ati.c
>>>> +++ b/hw/display/ati.c
>>>> @@ -514,7 +514,7 @@ static uint64_t ati_mm_read(void *opaque, hwaddr 
>>>> addr, unsigned int size)
>>>>         val |= s->regs.default_tile << 16;
>>>>         break;
>>>>     case DEFAULT_SC_BOTTOM_RIGHT:
>>>> -        val = (s->regs.default_sc_bottom << 16) |
>>>> +        val = ((uint32_t)s->regs.default_sc_bottom << 16) |
>>>>               s->regs.default_sc_right;
>>
>> What about using deposit64() which is uncontroversial?
>>
>>            val = deposit64(s->regs.default_sc_right, 16,
>>                            13, s->regs.default_sc_bottom);

(alternatively deposit32)

> I can't make sense of that without going and looking what the arguments 
> of this function are so I'd rather keep it simple. As I said, the values 
> here can't be large enough to sign extend and there may be other similar 
> cases that are already marked in Coverity. But if we still want to fix 
> all of them then maybe we could try to make val uint32_t then do 
> something about it once at the return for all cases. That seems better 
> than trying to handle in each case inconsistently. The simplest would 
> still be to tell Converity it's wrong here.

Until the next register is implemented and Coverity complains again,
and another round-up on the mailing list until Peter manually marks it.
I was hoping for a way to avoid all that hassle.

