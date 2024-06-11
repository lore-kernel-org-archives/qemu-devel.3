Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB257C25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 06:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGui1-0004gj-C0; Tue, 11 Jun 2024 02:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sGuhv-0004gL-Uf; Tue, 11 Jun 2024 02:10:12 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sGuhu-0002Ay-7m; Tue, 11 Jun 2024 02:10:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=hq15L9/FMiQMesRM9Nhu/p9g/XjYCS23k8N7bNPwzAE=; b=uhaO35XA+MTMqI8DIQqCuhpHLZ
 BVAFsus6tFA1sLg80jrVE0g3vJIOuZ2ZfFYIIF+T2ukEwseAzEJAkhyshRlgQmRJL2RYtWJZZNG/b
 +U4F2UT0mBwfHu+nk6SnZc91W+ZhvZJQ70P/G5ccg0EjbBFu3ZR7J2hyV79xDuNnga+orrSVTIqqi
 09tzlKAS/GRwEPBIOKhSAKUi2gmijx9HYA0D7GwYzO7kD8Bs5zjdXXXYmuA5McabWA7EYUqqQ77HV
 mnTJMX+lrnfZzaq9YpWtR29t0mvJ96DQ4fflNI1jb/bKH3gzvwAjyft15wPbCYszuqn2ItCMeHzxh
 LlhTl1xIfcCHDvexByKiwewvAXHVDQmgFgHk0kc0scF2l+cFJl94YvTBozhUyZ7GrT7uQrmmHtxDO
 czEgxU9mfRnDhnw+YyAIRfjRXo9k/tuUvFPDpJfWnRrbC+lyTlVA3J4WY18gnK7PdZCZQlsL7edn7
 7y4ODWz2gqvxVcFB8CPJZvO6y3Ay4QTJlCKUnoUXwIwz5rbfJGKe1P5ST0ZCNrZHqF3R+meXuctM8
 qeLfo9SllnxdRMKCMi40sGWoMzIhp9Dd5qzB8+A3JBhf3Bs6wOKZfGBQ/uIAin66nRwzo5z9kofkB
 eJv3X6VqVyBTJ0FM1LHZxrOXWTtW8Y06XJtxoq0A8=;
Received: from [2a00:23c4:8bb4:4000:6a6e:c7d9:b2e6:455b]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sGugU-0005Ix-Ie; Tue, 11 Jun 2024 07:08:46 +0100
Message-ID: <e0d03597-a9d1-4386-83b4-519aae23f679@ilande.co.uk>
Date: Tue, 11 Jun 2024 07:09:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240610150758.2827-1-philmd@linaro.org>
 <87h6e0uizr.fsf@pond.sub.org>
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
In-Reply-To: <87h6e0uizr.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:6a6e:c7d9:b2e6:455b
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

On 11/06/2024 06:49, Markus Armbruster wrote:

> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> Officialise the QMP command, use the existing
>> hmp_info_human_readable_text() helper.
> 
> I'm not sure "officialise" is a word :)
> 
> Taking a step back...  "info via" and its new QMP counterpart
> x-query-mos6522-devices dump device state.  I understand why examining
> device state via monitor can be useful for debugging.  However, we have
> more than 2000 devices in the tree.  Clearly, we don't want 2000 device
> state queries.  Not even 100.  Could we have more generic means instead?
> 
> We could use QOM (read-only) properties to expose device state.
> 
> If we use one QOM property per "thing", examining device state becomes
> quite tedious.  Also, you'd have to stop the guest to get a consistent
> view, and adding lots of QOM properties bloats the code.
> 
> If we use a single, object-valued property for the entire state, we get
> to define the objects in QAPI.  Differently tedious, and bloats the
> generated code.
> 
> We could use a single string-valued property.  Too much of an abuse of
> QOM?
> 
> We could add an optional "dump state for debugging" method to QOM, and
> have a single query command that calls it if present.
> 
> Thoughts?

I agree that there should be a better way of doing things here. The aim of the 
original "info via" series was to allow the command to be contained completely within 
mos6522.c, but unfortunately due to the way that qemu-options.hx works then you end 
up with #ifdef-fery or stubs to make all configuration combinations work.

As you point out ideally there should be a way for a QOM object to dynamically 
register its own monitor commands, which I think should help with this.

IIRC in the original thread Daniel or David proposed a new "debug" monitor command 
such that a device could register its own debug <foo> commands either via DeviceClass 
or a function called during realize that would return a HumanReadableText via QMP.

In terms of "info via" it is only used by developers for the 68k and PPC Mac machines 
so if it were to change from "info via" to "debug via" I don't see there would be a 
big problem with this.


ATB,

Mark.


