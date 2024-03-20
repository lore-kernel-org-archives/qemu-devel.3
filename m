Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 795D1C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 08:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmrfC-0004y5-7i; Wed, 20 Mar 2024 04:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rmrfA-0004wO-Ek
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:51:08 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rmrf7-0001AL-0S
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:51:08 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1def89f0cfdso5519625ad.0
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 01:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1710924663; x=1711529463;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qsASAfGcmdcmGwebu10xUh05YrkgqP1B6utGVC9PIgU=;
 b=wFZtJf+mNVcWuvIMJlftiHtNQEKzy9ZNlpYEEt87gmDn/FEX3C6vral5FigW4ArFCZ
 Ay5StFj8asqy3sTBGVPzuW4tiMOZhMa1Ei2ny2m0UY+87ZgnR1qtmZ0vEWK76b197J2e
 c71rWsSve1lUuv+iNZX55ny0S8RV0KoUoJAA7T/nS6FZjH6zPJBwq+Xb9bJVVOtLu8Kr
 VanuBhvxkWazHxAoQf8wz4sxcM+mJtocTbGfhHLwx7X/x+g9S8sXxMIei2DtPrOA2Ovf
 /4ZB5DYg14o5iRlLNcfXJ+0kbtVkNGWFoQFsSjM9d5rMQcSXgE52u009YmzFQhmxDJIA
 UMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710924663; x=1711529463;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qsASAfGcmdcmGwebu10xUh05YrkgqP1B6utGVC9PIgU=;
 b=tniSmxSP0LmqwaWXSTnjWaLdjHPNFmlGq8UQ0yGqDzmrPQ5GrrLW0rbebU4gGJe2mT
 kqtpoRPNyT4v72GnQcO/y5oVX7HB0tI/5yqgt4pSbPnr2b0KoHS22LedGTG16PHnbGDj
 4h5jWQz6bYDuJ0irGHvZajfxNzBcXmjJULoGE/HHWusk1gRlU/dacUHNR+d7EiExYt+R
 uH9AmMhKZLiMdF7zpyPmRrOGtA1yaYTmQetEb4R0zMv/rtaWtO2dWp8EbqmEVVSOwWUu
 jcCPziSYMnqshcEPjleV/hK4eX3eooIbVInyFpTSRB8cK3vFxDDQhJeanbsdOkhnKDBC
 9dzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+RPfLOWi4vGgqf4hU8idBkqAck1nNDaucyk2OblgnHoCVsolnhoAo9Hezgoekz67QojWHR4QH1iBPhw1BrE6tDz7w/Eg=
X-Gm-Message-State: AOJu0YwUccUgWPs+ic62jPfTM0mhA8+V+u3zVpnfou3h+Qy6pImtiRdk
 nf+1+P03EPPQa2OReqrUrzysUZvdL+imLJtVIpxuQxprlb99BsMQ5fJB2v5Fdgg=
X-Google-Smtp-Source: AGHT+IHU9K6U84JN+YU6DZiw/DZhA+W7ItrI7+39Gnj+jmg6AWrPiF+Ny3YvXnHdbiersFTJEP5FIA==
X-Received: by 2002:a17:902:e849:b0:1e0:3861:9e41 with SMTP id
 t9-20020a170902e84900b001e038619e41mr2759820plg.19.1710924663277; 
 Wed, 20 Mar 2024 01:51:03 -0700 (PDT)
Received: from [157.82.200.213] ([157.82.200.213])
 by smtp.gmail.com with ESMTPSA id
 u7-20020a17090341c700b001dde004b31bsm8414200ple.166.2024.03.20.01.51.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 01:51:02 -0700 (PDT)
Message-ID: <9fcc5c14-130e-420b-88cf-af8c9fde0097@daynix.com>
Date: Wed, 20 Mar 2024 17:50:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] ui/console: Remove console_select()
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240319-console-v2-0-3fd6feef321a@daynix.com>
 <CAJ+F1CKOuZR5nZxcxRzZyoE56p_nNW11cySEmnFvRgiPv5OAdw@mail.gmail.com>
 <5b8160c8-6774-47b3-a495-f7dc64ebd28d@daynix.com>
 <CAJ+F1CLP_LNwWQ_4M2w7cVK-DSBy6+92SY5m37fUnZMXN6oBaQ@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAJ+F1CLP_LNwWQ_4M2w7cVK-DSBy6+92SY5m37fUnZMXN6oBaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/03/20 16:00, Marc-André Lureau wrote:
> Hi
> 
> On Wed, Mar 20, 2024 at 7:20 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2024/03/19 17:29, Marc-André Lureau wrote:
>>> Hi Akihiko
>>>
>>> On Tue, Mar 19, 2024 at 7:09 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> ui/console has a concept of "active" console; the active console is used
>>>> when NULL is set for DisplayListener::con, and console_select() updates
>>>> the active console state. However, the global nature of the state cause
>>>> odd behaviors, and replacing NULL with the active console also resulted
>>>> in extra code. Remove it to solve these problems.
>>>>
>>>> The active console state is shared, so if there are two displays
>>>> referring to the active console, switching the console for one will also
>>>> affect the other. All displays that use the active console state,
>>>> namely cocoa, curses, and vnc, need to reset some of its state before
>>>> switching the console, and such a reset operation cannot be performed if
>>>> the console is switched by another display. This can result in stuck
>>>> keys, for example.
>>>>
>>>> While the active console state is shared, displays other than cocoa,
>>>> curses, and vnc don't update the state. A chardev-vc inherits the
>>>> size of the active console, but it does not make sense for such a
>>>> display.
>>>>
>>>> This series removes the shared "active" console state from ui/console.
>>>> curses, cocoa, and vnc will hold the reference to the console currently
>>>> shown with DisplayListener::con. This also eliminates the need to
>>>> replace NULL with the active console and save code.
>>>>
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>
>>> lgtm
>>> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>
>>> I am willing to take that for 9.0. Is there any bug already opened
>>> about the issues it solves?
>>
>> No, I'm not aware of one.
> 
> The first patch "Do not inherit the size of active console" is not
> directly related and may not be suitable for merge during freeze. Are
> you ok with merging the rest for 9.0 or delay it for 9.1?

The first patch needs to be applied before the others.

It removes qemu_console_get_width()/qemu_console_get_height() calls with 
NULL as QemuConsole *con argument, which is intended to be replaced with 
the active console. The calls will make no sense after the other patches 
are applied since the concept of the active console will be gone.

