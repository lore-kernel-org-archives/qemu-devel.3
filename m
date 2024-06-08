Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49D6C25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 20:55:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sG35k-0004R3-GQ; Sat, 08 Jun 2024 16:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1sG35i-0004Ly-Cm
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 16:55:10 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1sG35f-0004Aw-Gc
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 16:55:09 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2ebdfe261f9so1472031fa.1
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 13:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1717880105; x=1718484905;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sI8y5vp4KCvT10M+vb5+2a0Wn1h5OGY2W/DJ7Z0ltiQ=;
 b=mbnATGCSvvXz5dQvov1juWmvydK/dWUcd2dYGNiTDTv9aHlOt1dbzsxvTVQz7YZVvd
 zU+J2bZfb0tQiqDXkyyH16ZbZbREuNFOl+L5CEhcXdJ+RXwzAbLF+Zrqz+TWc94XkuoV
 Ep9g8H6Au30Nl+DfFPPaChI6fLgH1B9mVgM/Mh0FmagaXkLujBaXiSFkTf4EunmJHIOZ
 DnzIsrpUk5UJhqB901KZSIcx7vp/LU5/s8ak6gxQNKNaif6Qf+e7bQMaZnxlZBkwW7WV
 Q7+E2AG71qOrLLxa7+yF5JclngMbqzbWjRFA1OvRisBuyXc2IIbQoDSDwD2k3K4qt1pU
 4iKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717880105; x=1718484905;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sI8y5vp4KCvT10M+vb5+2a0Wn1h5OGY2W/DJ7Z0ltiQ=;
 b=I0NNHw+9FkT6dju6G/bb8mBt6XExRqzOZLMcMsfkoQBqaImIIpmisqs9ScqSO25Eex
 UEm7d4IZlDZmchsUXqW3TmbSV/ME4UCRH4n4u2dXxNBYMVba+WTPAzfby2Uujdu+u0Eh
 FngywKGdbaRAz/gwVzzxtHBi06uYxFzyQ7rASMYwIMk200GONhJFeuNhgi81YB6/4KsV
 UpeFRY8ywhaaOwrwbDUXKA0y+CR1gR7KbDZ7E1wPiinv+5kuWxsrWbO+9Y0sAooHcXDa
 mIijaJIGiipvOHzivQhhJ8quHegLM1UG+eP+e3yGDjsFFhxo5QF1YhZtXT9QwvTkSJfS
 G6yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7+1mni7a4X+eg0dfTCJ3zEsT7AgvKtc3VTeyqaXN8OBAeWA8XD0MIWlu++rEvcP8mgPW8rzOrLMgO2KkXFKoXwtGXpQQ=
X-Gm-Message-State: AOJu0YxHhehMkGpRiYyGjx2JFGbcjg4NEiSDx0ZOPEhk6OiVdO+pmIUU
 xc/8o30QlxMYrYT9wXp10HyaivHHFOWcwsp+kvGpp1phP1Q5rHfy5gG02+JHodXa/ASRK4tiDvC
 YE6PdjKDceZdvj+Z/394e/fwhOPXx7dSGL6yn
X-Google-Smtp-Source: AGHT+IFbuZjQwRWTQTbAuR1mfws840jFqBphb6Tke4uYVA3kPZsBCnaiYf4b2XS+/9puSbaB+NFSOVarIBq2MZbxvHM=
X-Received: by 2002:a2e:9c09:0:b0:2eb:dced:71aa with SMTP id
 38308e7fff4ca-2ebdced72a1mr6787541fa.15.1717880104254; Sat, 08 Jun 2024
 13:55:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240322-mouse-v1-1-0b7d4d9bdfbf@daynix.com>
In-Reply-To: <20240322-mouse-v1-1-0b7d4d9bdfbf@daynix.com>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Sat, 8 Jun 2024 22:54:52 +0200
Message-ID: <CAGCz3vsuKvmWJT6yvZOLdu7AW_TiCW9847FshYhJnHsnTVC68Q@mail.gmail.com>
Subject: Re: [PATCH] ui/cocoa: Use qemu_add_mouse_change_notifier
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: neutral client-ip=2a00:1450:4864:20::22a;
 envelope-from=lists@philjordan.eu; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

This looks fine to me. I've tested it briefly with a graphical Linux
guest and some tracing in the notifyMouseModeChange on a macOS 13
host. When I hot-unplug the usb-tablet I get an absolute -> relative
notification; everything works in relative mode after hot-adding a USB
mouse. Hot-unplugging and replugging the tablet yields a relative ->
absolute notification, and pointer input continues to behave
correctly.

Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
Tested-by: Phil Dennis-Jordan <phil@philjordan.eu>

On Fri, 22 Mar 2024 at 11:55, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> This eliminates the polling in cocoa_refresh and implements the
> propagation of the mouse mode change from absolute to relative.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  ui/cocoa.m | 62 ++++++++++++++++++++++++++++++++++++++------------------------
>  1 file changed, 38 insertions(+), 24 deletions(-)
>
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index 810751cf2644..b53920b8814c 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -310,6 +310,14 @@ @interface QemuCocoaView : NSView
>      NSTrackingArea *trackingArea;
>      QEMUScreen screen;
>      pixman_image_t *pixman_image;
> +    /* The state surrounding mouse grabbing is potentially confusing.
> +     * isAbsoluteEnabled tracks qemu_input_is_absolute() [ie "is the emulated
> +     *   pointing device an absolute-position one?"], but is only updated on
> +     *   next refresh.
> +     * isMouseGrabbed tracks whether GUI events are directed to the guest;
> +     *   it controls whether special keys like Cmd get sent to the guest,
> +     *   and whether we capture the mouse when in non-absolute mode.
> +     */
>      BOOL isMouseGrabbed;
>      BOOL isAbsoluteEnabled;
>      CFMachPortRef eventsTap;
> @@ -321,17 +329,8 @@ - (void) setFullGrab:(id)sender;
>  - (void) handleMonitorInput:(NSEvent *)event;
>  - (bool) handleEvent:(NSEvent *)event;
>  - (bool) handleEventLocked:(NSEvent *)event;
> -- (void) setAbsoluteEnabled:(BOOL)tIsAbsoluteEnabled;
> -/* The state surrounding mouse grabbing is potentially confusing.
> - * isAbsoluteEnabled tracks qemu_input_is_absolute() [ie "is the emulated
> - *   pointing device an absolute-position one?"], but is only updated on
> - *   next refresh.
> - * isMouseGrabbed tracks whether GUI events are directed to the guest;
> - *   it controls whether special keys like Cmd get sent to the guest,
> - *   and whether we capture the mouse when in non-absolute mode.
> - */
> +- (void) notifyMouseModeChange;
>  - (BOOL) isMouseGrabbed;
> -- (BOOL) isAbsoluteEnabled;
>  - (QEMUScreen) gscreen;
>  - (void) raiseAllKeys;
>  @end
> @@ -437,6 +436,7 @@ - (void) selectConsoleLocked:(unsigned int)index
>      qkbd_state_switch_console(kbd, con);
>      dcl.con = con;
>      register_displaychangelistener(&dcl);
> +    [self notifyMouseModeChange];
>      [self updateUIInfo];
>  }
>
> @@ -1103,14 +1103,26 @@ - (void) ungrabMouse
>      [self raiseAllButtons];
>  }
>
> -- (void) setAbsoluteEnabled:(BOOL)tIsAbsoluteEnabled {
> +- (void) notifyMouseModeChange {
> +    bool tIsAbsoluteEnabled = bool_with_bql(^{
> +        return qemu_input_is_absolute(dcl.con);
> +    });
> +
> +    if (tIsAbsoluteEnabled == isAbsoluteEnabled) {
> +        return;
> +    }
> +
>      isAbsoluteEnabled = tIsAbsoluteEnabled;
> +
>      if (isMouseGrabbed) {
> -        CGAssociateMouseAndMouseCursorPosition(isAbsoluteEnabled);
> +        if (isAbsoluteEnabled) {
> +            [self ungrabMouse];
> +        } else {
> +            CGAssociateMouseAndMouseCursorPosition(isAbsoluteEnabled);
> +        }
>      }
>  }
>  - (BOOL) isMouseGrabbed {return isMouseGrabbed;}
> -- (BOOL) isAbsoluteEnabled {return isAbsoluteEnabled;}
>  - (QEMUScreen) gscreen {return screen;}
>
>  /*
> @@ -1784,6 +1796,17 @@ static void addRemovableDevicesMenuItems(void)
>      qapi_free_BlockInfoList(pointerToFree);
>  }
>
> +static void cocoa_mouse_mode_change_notify(Notifier *notifier, void *data)
> +{
> +    dispatch_async(dispatch_get_main_queue(), ^{
> +        [cocoaView notifyMouseModeChange];
> +    });
> +}
> +
> +static Notifier mouse_mode_change_notifier = {
> +    .notify = cocoa_mouse_mode_change_notify
> +};
> +
>  @interface QemuCocoaPasteboardTypeOwner : NSObject<NSPasteboardTypeOwner>
>  @end
>
> @@ -1968,17 +1991,6 @@ static void cocoa_refresh(DisplayChangeListener *dcl)
>      COCOA_DEBUG("qemu_cocoa: cocoa_refresh\n");
>      graphic_hw_update(dcl->con);
>
> -    if (qemu_input_is_absolute(dcl->con)) {
> -        dispatch_async(dispatch_get_main_queue(), ^{
> -            if (![cocoaView isAbsoluteEnabled]) {
> -                if ([cocoaView isMouseGrabbed]) {
> -                    [cocoaView ungrabMouse];
> -                }
> -            }
> -            [cocoaView setAbsoluteEnabled:YES];
> -        });
> -    }
> -
>      if (cbchangecount != [[NSPasteboard generalPasteboard] changeCount]) {
>          qemu_clipboard_info_unref(cbinfo);
>          cbinfo = qemu_clipboard_info_new(&cbpeer, QEMU_CLIPBOARD_SELECTION_CLIPBOARD);
> @@ -2055,6 +2067,8 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
>
>      // register vga output callbacks
>      register_displaychangelistener(&dcl);
> +    qemu_add_mouse_mode_change_notifier(&mouse_mode_change_notifier);
> +    [cocoaView notifyMouseModeChange];
>      [cocoaView updateUIInfo];
>
>      qemu_event_init(&cbevent, false);
>
> ---
> base-commit: fea445e8fe9acea4f775a832815ee22bdf2b0222
> change-id: 20240322-mouse-bbc0fa90e8dc
>
> Best regards,
> --
> Akihiko Odaki <akihiko.odaki@daynix.com>
>
>

