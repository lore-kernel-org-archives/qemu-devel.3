Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE883E6FE49
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 08:03:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snZLs-0004dt-8G; Mon, 09 Sep 2024 04:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sw@weilnetz.de>) id 1snZLq-0004dM-2N
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 04:02:22 -0400
Received: from mail.weilnetz.de ([37.120.169.71]
 helo=mail.v2201612906741603.powersrv.de)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sw@weilnetz.de>) id 1snZLn-0005qn-O4
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 04:02:21 -0400
Received: from [134.155.50.234] (dock02.bib.uni-mannheim.de [134.155.50.234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.v2201612906741603.powersrv.de (Postfix) with ESMTPSA id 9869ADA07E9;
 Mon,  9 Sep 2024 10:02:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weilnetz.de; s=dkim1; 
 t=1725868935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YdpqqyfOfgAomvLkscIJaJOK7zgS+bUHsboiArP6X60=;
 b=Z2ilk0lGeLgj8Cd7YiYbAfCBLviP59ntSWd3ralFnrJjGlX8aSsqt0srjmwJ1S0NQ653Jv
 v7n9uyjoFNXTQ0n5pTziwS6eie3ZwplKzBx1Vh7+bR+0LUQpjUjNU4s6YYRYGNFSyY/KBj
 OUUQsdbopUlm97EVXKlXLBAMBP2kjHE=
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=stefan.weil@weilnetz.de smtp.mailfrom=sw@weilnetz.de
Message-ID: <e06b0915-c819-4e03-8864-03afe72dbdae@weilnetz.de>
Date: Mon, 9 Sep 2024 10:02:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ui/sdl2: reenable the SDL2 Windows keyboard hook
 procedure
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Cc: Howard Spoelstra <hsp.cat7@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
References: <ae9b2c56-dab2-4b8f-bb5e-2087e9ccaa92@t-online.de>
 <20240909061552.6122-1-vr_qemu@t-online.de>
 <CAMxuvay4vRm6ZYQoUx=cmD5mr-8-qR4Z4iLEJ6-f0m2eUSbdOg@mail.gmail.com>
Autocrypt: addr=sw@weilnetz.de; keydata=
 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
In-Reply-To: <CAMxuvay4vRm6ZYQoUx=cmD5mr-8-qR4Z4iLEJ6-f0m2eUSbdOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9869ADA07E9
X-Spamd-Bar: -
X-Spamd-Result: default: False [-1.60 / 14.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[t-online.de,gmail.com];
 TAGGED_RCPT(0.00)[]; ARC_NA(0.00)[];
 ASN(0.00)[asn:553, ipnet:134.155.0.0/16, country:DE];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_ZERO(0.00)[0];
 TO_DN_SOME(0.00)[]; FREEMAIL_TO(0.00)[redhat.com,t-online.de];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[weilnetz.de:s=dkim1]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,nongnu.org];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url, dock02.bib.uni-mannheim.de:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: v2201612906741603
Received-SPF: pass client-ip=37.120.169.71; envelope-from=sw@weilnetz.de;
 helo=mail.v2201612906741603.powersrv.de
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Stefan Weil <sw@weilnetz.de>
From:  Stefan Weil via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 09.09.24 um 09:26 schrieb Marc-André Lureau:

> Hi
>
> On Mon, Sep 9, 2024 at 10:22 AM Volker Rümelin <vr_qemu@t-online.de> wrote:
>> Windows only:
>>
>> The libSDL2 Windows message loop needs the libSDL2 Windows low
>> level keyboard hook procedure to grab the left and right Windows
>> keys correctly. Reenable the SDL2 Windows keyboard hook procedure.
>>
>> Because the QEMU Windows keyboard hook procedure is still needed
>> to filter out the special left Control key event for every Alt Gr
>> key event, it's important to install the two keyboard hook
>> procedures in the following order. First the SDL2 procedure, then
>> the QEMU procedure.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2139
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2323
>> Tested-by: Howard Spoelstra <hsp.cat7@gmail.com>
>> Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
>> ---
>>   ui/sdl2.c           | 53 ++++++++++++++++++++++++++++++---------------
>>   ui/win32-kbd-hook.c |  3 +++
>>   2 files changed, 38 insertions(+), 18 deletions(-)
>>
>> diff --git a/ui/sdl2.c b/ui/sdl2.c
>> index 98ed974371..ac37c173a1 100644
>> --- a/ui/sdl2.c
>> +++ b/ui/sdl2.c
[...]
>> @@ -877,6 +883,17 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
>>       SDL_EnableScreenSaver();
>>       memset(&info, 0, sizeof(info));
>>       SDL_VERSION(&info.version);
>> +    /*
>> +     * Since version 2.16.0 under Windows, SDL2 has its own low level
>> +     * keyboard hook procedure to grab the keyboard. The remaining task of
>> +     * QEMU's low level keyboard hook procedure is to filter out the special
>> +     * left Control up/down key event for every Alt Gr key event on keyboards
>> +     * with an international layout.
>> +     */
>> +    SDL_GetVersion(&ver);
>> +    if (ver.major == 2 && ver.minor < 16) {
>> +        win32_kbd_grab = true;
>> +    }
>>
> Note: there is no 2.16 release. They jumped from 2.0.22 to 2.24 (see
> https://github.com/libsdl-org/SDL/releases/tag/release-2.24.0)
>
> The windows hook was indeed added in 2.0.16, released on Aug 10, 2021.
>
> Given the distribution nature of the Windows binaries, I think we
> could simply depend on a much recent version without worrying about
> compatibility with < 2.0.16. This would help reduce the potential
> combinations of versions and bugs reports.

[...]

I agree. My builds for Windows typically use the very latest versions, 
for example mingw-w64-i686-SDL2-2.30.7-1-any for the next build. So 
depending on a recent SDL version would be fine for me.

Stefan W.


