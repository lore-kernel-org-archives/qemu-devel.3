Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCC6C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 09:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm8vk-0003eD-SF; Mon, 18 Mar 2024 05:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rm8vb-0003as-Qj
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 05:05:09 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rm8vY-0003Lo-Da
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 05:05:06 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6e6adc557b6so3860225b3a.2
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 02:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1710752702; x=1711357502;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=APVvWu6JG41MhfdZyWYK3Up/zLgMR7OSD5or0zyYsto=;
 b=w+F2VlAfwFSbL9yNAysvnYYm/TXf52t5DZmcgEBc3GuMlowpXXqJfCdV+LdiMr+5HC
 7FuRoMfga9JLIjaeHuO4kKgm2CIFNWcjz65Dl9O6uuMH50jdmJc1vdBaeErZObz0MLj/
 G/f59AWv1w5Cp09nkQ4StCQ1m3bsKqPvQXheXbIXsAV/Bm5ZHqzXHCy6pHVDb3ytFVOk
 k9CpkYUunSXzJZET5LwGIXgl1RWxqDWKTfBzNwEcZKD4Emimg0JjezZvFSU8odTeNbij
 PF47X7yUSNY9rz3kexoEc7toqzqLteCokeHmjD+zaSkfzhF7LXCghwFVzZ1Q8JqAD4ix
 Siag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710752702; x=1711357502;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=APVvWu6JG41MhfdZyWYK3Up/zLgMR7OSD5or0zyYsto=;
 b=vXGaQ4AgapTFzFa7ySHYd3YZUG0iGZWVtHihdFbDmb4KkHHvjdU4X0SdQ27Tot9OFi
 51ftDg0D1ycPkMfZrdu73+/kJ9dbTksTj+AP68V+BqHHFRS3kHWxfB4dNrFyZ/u/xCGz
 9ZsrMUE8cYyFxcqcxONlEq0wHuDptgxAVjJSrhdVcgJI4Ntpt+T1fmX92xr8/EaYXRuI
 KK1qCQXk4SED8WxDtJscEfykhTKtBF4c19pNJdh3ci4NPDpT1xt4UOZu/HYaPbikPfK+
 ymcJWKAiZ4AF5Eyv5zoGONqyFnkp9TxTRG0jMiwyiwCXRafsT4k6tcZ1+hEWjbkaj1b5
 RZrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzZmh8CFvu9MdOcX7SpC7v0csMZFC5VzRkTY0TRQS5WcqAnKfUA4pFIcCPRU+AuBLaJgxIQj0JHb+Sbzgjv0dvfrPPEiY=
X-Gm-Message-State: AOJu0YxSp8F5e2YeXfw4pPrGDnfGt23MkaSXaBIphHjig0yeo+tgB+Dz
 PkBvKsdmY95OgApwuRhUp+c0Vxzh1qc06lmcaY0cKhgP+3ErE91WmnSiMQLr5Mc=
X-Google-Smtp-Source: AGHT+IFgEBD/vMclRIc4f4/NQSsFoP/F8ZC9nAk0NqWWNO5abYvLOZfy6X6V1AeXKs0Cc94YtXbznA==
X-Received: by 2002:a05:6a00:988:b0:6e5:696d:9eb8 with SMTP id
 u8-20020a056a00098800b006e5696d9eb8mr13704110pfg.3.1710752701789; 
 Mon, 18 Mar 2024 02:05:01 -0700 (PDT)
Received: from [157.82.200.213] ([157.82.200.213])
 by smtp.gmail.com with ESMTPSA id
 b2-20020a056a00114200b006e6b7124b33sm7399115pfm.209.2024.03.18.02.05.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 02:05:01 -0700 (PDT)
Message-ID: <e27ee189-3b72-413a-b1ab-f4b26cb37812@daynix.com>
Date: Mon, 18 Mar 2024 18:04:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] ui/vnc: Do not use console_select()
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240318-console-v1-0-f4efbfa71253@daynix.com>
 <20240318-console-v1-2-f4efbfa71253@daynix.com>
 <CAJ+F1C+PipwudTRDF=BFJyqVkw0ORwpnXfumQ=kUadtf0HEfVA@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAJ+F1C+PipwudTRDF=BFJyqVkw0ORwpnXfumQ=kUadtf0HEfVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::431;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x431.google.com
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

On 2024/03/18 17:21, Marc-André Lureau wrote:
> Hi
> 
> On Mon, Mar 18, 2024 at 11:58 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> console_select() is shared by other displays and a console_select() call
>> from one of them triggers console switching also in ui/curses,
>> circumventing key state reinitialization that needs to be performed in
>> preparation and resulting in stuck keys.
>>
>> Use its internal state to track the current active console to prevent
>> such a surprise console switch.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   include/ui/console.h   |  1 +
>>   include/ui/kbd-state.h | 11 +++++++++++
>>   ui/console.c           | 12 ++++++++++++
>>   ui/kbd-state.c         |  6 ++++++
>>   ui/vnc.c               | 14 +++++++++-----
>>   5 files changed, 39 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/ui/console.h b/include/ui/console.h
>> index a4a49ffc640c..a703f7466499 100644
>> --- a/include/ui/console.h
>> +++ b/include/ui/console.h
>> @@ -413,6 +413,7 @@ void qemu_console_early_init(void);
>>
>>   void qemu_console_set_display_gl_ctx(QemuConsole *con, DisplayGLCtx *ctx);
>>
>> +QemuConsole *qemu_console_lookup_first_graphic_console(void);
>>   QemuConsole *qemu_console_lookup_by_index(unsigned int index);
>>   QemuConsole *qemu_console_lookup_by_device(DeviceState *dev, uint32_t head);
>>   QemuConsole *qemu_console_lookup_by_device_name(const char *device_id,
>> diff --git a/include/ui/kbd-state.h b/include/ui/kbd-state.h
>> index fb79776128cf..1f37b932eb62 100644
>> --- a/include/ui/kbd-state.h
>> +++ b/include/ui/kbd-state.h
>> @@ -99,4 +99,15 @@ bool qkbd_state_modifier_get(QKbdState *kbd, QKbdModifier mod);
>>    */
>>   void qkbd_state_lift_all_keys(QKbdState *kbd);
>>
>> +/**
>> + * qkbd_state_switch_console: Switch console.
>> + *
>> + * This sends key up events to the previous console for all keys which are in
>> + * down state to prevent keys being stuck, and remembers the new console.
>> + *
>> + * @kbd: state tracker state.
>> + * @con: new QemuConsole for this state tracker.
>> + */
>> +void qkbd_state_switch_console(QKbdState *kbd, QemuConsole *con);
>> +
>>   #endif /* QEMU_UI_KBD_STATE_H */
>> diff --git a/ui/console.c b/ui/console.c
>> index 832055675c50..6bf02a23414c 100644
>> --- a/ui/console.c
>> +++ b/ui/console.c
>> @@ -1325,6 +1325,18 @@ void graphic_console_close(QemuConsole *con)
>>       dpy_gfx_replace_surface(con, surface);
>>   }
>>
>> +QemuConsole *qemu_console_lookup_first_graphic_console(void)
>> +{
>> +    QemuConsole *con;
>> +
>> +    QTAILQ_FOREACH(con, &consoles, next) {
>> +        if (QEMU_IS_GRAPHIC_CONSOLE(con)) {
>> +            return con;
>> +        }
>> +    }
>> +    return NULL;
>> +}
>> +
>>   QemuConsole *qemu_console_lookup_by_index(unsigned int index)
>>   {
>>       QemuConsole *con;
>> diff --git a/ui/kbd-state.c b/ui/kbd-state.c
>> index 62d42a7a22e1..52ed28b8a89b 100644
>> --- a/ui/kbd-state.c
>> +++ b/ui/kbd-state.c
>> @@ -117,6 +117,12 @@ void qkbd_state_lift_all_keys(QKbdState *kbd)
>>       }
>>   }
>>
>> +void qkbd_state_switch_console(QKbdState *kbd, QemuConsole *con)
>> +{
>> +    qkbd_state_lift_all_keys(kbd);
>> +    kbd->con = con;
>> +}
>> +
>>   void qkbd_state_set_delay(QKbdState *kbd, int delay_ms)
>>   {
>>       kbd->key_delay_ms = delay_ms;
>> diff --git a/ui/vnc.c b/ui/vnc.c
>> index fc12b343e254..94564b196ba8 100644
>> --- a/ui/vnc.c
>> +++ b/ui/vnc.c
>> @@ -1872,12 +1872,16 @@ static void do_key_event(VncState *vs, int down, int keycode, int sym)
>>       /* QEMU console switch */
>>       switch (qcode) {
>>       case Q_KEY_CODE_1 ... Q_KEY_CODE_9: /* '1' to '9' keys */
>> -        if (vs->vd->dcl.con == NULL && down &&
>> +        if (down &&
>>               qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_CTRL) &&
>>               qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_ALT)) {
>> -            /* Reset the modifiers sent to the current console */
>> -            qkbd_state_lift_all_keys(vs->vd->kbd);
>> -            console_select(qcode - Q_KEY_CODE_1);
>> +            QemuConsole *con = qemu_console_lookup_by_index(qcode - Q_KEY_CODE_1);
>> +            if (con) {
>> +                unregister_displaychangelistener(&vs->vd->dcl);
>> +                qkbd_state_switch_console(vs->vd->kbd, con);
>> +                vs->vd->dcl.con = con;
>> +                register_displaychangelistener(&vs->vd->dcl);
>> +            }
>>               return;
>>           }
>>       default:
>> @@ -4206,7 +4210,7 @@ void vnc_display_open(const char *id, Error **errp)
>>               goto fail;
>>           }
>>       } else {
>> -        con = NULL;
>> +        con = qemu_console_lookup_first_graphic_console();
> 
> why this change here?

console_select() is to change the console that is used when 
DisplayChangeListener::con is NULL. console_select() is no longer called 
so DisplayChangeListener::con must not be NULL.

> 
> otherwise, lgtm
> 
>>       }
>>
>>       if (con != vd->dcl.con) {
>>
>> --
>> 2.44.0
>>
>>
> 
> 

