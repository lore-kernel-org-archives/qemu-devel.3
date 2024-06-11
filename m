Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79BBC27C5E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 08:07:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGwX4-0006e2-Hb; Tue, 11 Jun 2024 04:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sGwX1-0006cV-ET; Tue, 11 Jun 2024 04:07:03 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sGwWz-0008A6-M6; Tue, 11 Jun 2024 04:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=byBcklKYUQEdOEfI1YCEmgotQYzOgrLN7hxMv0IAl3c=; b=XTDR4KFmIFnBMQVFkt93brxJNf
 BHzdCz8hcpTUgTCd4RkuQs8L9cT32zIT3jKIIRDrYOf42N8ovIUIwVV+AK1TItGp8AkyPxylIaB+J
 OFfYaLiRkllIIHdw6zwRTcXBHxHLuK58KN15tDdIUslJ1VzHj/Ay4Npoj4TaJO4or9KR6ATeiqd5R
 FpDz/HA+48NFjXHTfLTvG/CriBe7lebzOEsmjD4fwsdor1bvQzmh7LveJ/q1ovwRLljNp8q4/dES8
 TsIzRm9D7PnD76kTQp5iuwbrQ0FE5g//WrIznyZ8GTMek6iRf/pbqkUn04jvRx/DqjOpxcplvPvV7
 OC7TRDjGT73AGVXGGj0PZa7Vz/DLoDb25iVsoE+DTCwOt13+gQQ5Pzsj0xx90yKoOQ3Mhb8gT995s
 64AhAXPOGBSFm2gB4BxuuJmf3KuzGFs0PLUnZvUUh7y7zrGff05VB00GhHwN0gW2mxsOCdpiJ+BAc
 ymul1IwgIlymM4U3A2xDNeWYJOkCf6A3XQ3v1eTnOM7/+eaVV/b2CSVKCp3i6xEx7/iooE67PvQhs
 XPuG0NOdlkbjpJWe32V2gSv2IAVgW1WFCDx8h4AOgiZArvpRCse6heHQIbUAAITlLn9B9mYvc7pgf
 HBbTgLDrUkfDlQtkE4ZtUq7rFeMEl7TmtAjNJ52kE=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sGwVd-0005zA-Iu; Tue, 11 Jun 2024 09:05:41 +0100
Message-ID: <0ab2a2e6-7695-4445-b1e3-7e2550ee6860@ilande.co.uk>
Date: Tue, 11 Jun 2024 09:06:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240610150758.2827-1-philmd@linaro.org>
 <87h6e0uizr.fsf@pond.sub.org>
 <e0d03597-a9d1-4386-83b4-519aae23f679@ilande.co.uk>
 <CAAjaMXad7b7SvAkAmvt+4RuLqZoTGCpELN0YMoVu7xGazwPRug@mail.gmail.com>
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
In-Reply-To: <CAAjaMXad7b7SvAkAmvt+4RuLqZoTGCpELN0YMoVu7xGazwPRug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: Examining device state via monitor for debugging
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

On 11/06/2024 07:58, Manos Pitsidianakis wrote:

> On Tue, 11 Jun 2024 at 09:11, Mark Cave-Ayland
> <mark.cave-ayland@ilande.co.uk> wrote:
>>
>> On 11/06/2024 06:49, Markus Armbruster wrote:
>>
>>> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
>>>
>>>> Officialise the QMP command, use the existing
>>>> hmp_info_human_readable_text() helper.
>>>
>>> I'm not sure "officialise" is a word :)
>>>
>>> Taking a step back...  "info via" and its new QMP counterpart
>>> x-query-mos6522-devices dump device state.  I understand why examining
>>> device state via monitor can be useful for debugging.  However, we have
>>> more than 2000 devices in the tree.  Clearly, we don't want 2000 device
>>> state queries.  Not even 100.  Could we have more generic means instead?
>>>
>>> We could use QOM (read-only) properties to expose device state.
>>>
>>> If we use one QOM property per "thing", examining device state becomes
>>> quite tedious.  Also, you'd have to stop the guest to get a consistent
>>> view, and adding lots of QOM properties bloats the code.
>>>
>>> If we use a single, object-valued property for the entire state, we get
>>> to define the objects in QAPI.  Differently tedious, and bloats the
>>> generated code.
>>>
>>> We could use a single string-valued property.  Too much of an abuse of
>>> QOM?
>>>
>>> We could add an optional "dump state for debugging" method to QOM, and
>>> have a single query command that calls it if present.
>>>
>>> Thoughts?
>>
>> I agree that there should be a better way of doing things here. The aim of the
>> original "info via" series was to allow the command to be contained completely within
>> mos6522.c, but unfortunately due to the way that qemu-options.hx works then you end
>> up with #ifdef-fery or stubs to make all configuration combinations work.
>>
>> As you point out ideally there should be a way for a QOM object to dynamically
>> register its own monitor commands, which I think should help with this.
>>
>> IIRC in the original thread Daniel or David proposed a new "debug" monitor command
>> such that a device could register its own debug <foo> commands either via DeviceClass
>> or a function called during realize that would return a HumanReadableText via QMP.
> 
> This is starting to sound like OOP: A Monitor interface defines
> monitor commands, and QOM type classes can implement/define their own.
> A Debug interface would do this.

I like this idea: having a QOM interface that objects can implement to register their 
own monitor commands feels like a good solution.


ATB,

Mark.


