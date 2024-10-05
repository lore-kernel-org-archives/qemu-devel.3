Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E92CF8877
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 08:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sx0Q8-0003sC-Cl; Sat, 05 Oct 2024 04:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sx0Q6-0003rx-RT
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 04:45:46 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sx0Q5-0000RS-BR
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 04:45:46 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2e0af6e5da9so2206454a91.2
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 01:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728117944; x=1728722744;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4Cxzo3Z2Um+oN9NudvtuYFAc7ahlT7eDcuSq4SxpTsg=;
 b=X24bGEM2KW4JYKRrwJLsKib1ENRT0h/rArn8kJ8H0AUQCIZjSJymeL77mraYws4T+G
 rcp8iybl/7bmPraTsTU5ZB7fo4Fa36f6egLfBG3ImVFnnor/8+AkfK2EHdPWLbvO80Qj
 3GjQnM1cG6BiJn5cJrm54GImpbposUgWVW1MCnREOhVGJSaE9OEFQOET6YSokzwlnQIj
 ocaWCW0WjC6aVsq67rEdv1Mk8fHY+liGnOCErtmNrtcNUpzs8K/u6hgM1dmBlPWtSdJQ
 CGAlKRYCCnpo2w1FV0Y28KhJwQANi0zpa3qUHDyGUDP/rJ5mPXwJrYnSFf0X+aLNvt1R
 22wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728117944; x=1728722744;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4Cxzo3Z2Um+oN9NudvtuYFAc7ahlT7eDcuSq4SxpTsg=;
 b=mXXYhEXrOdYKKx8BTWl5Nx/E7D7RLo9ZMZ9EYQpKDn8cBpE6rquwldmQRB7dGwI2AK
 pdJhE5jWqsA7IxUQo8H23VaylxVPIfzL4lUNwrxTOJdIzg4Uv/Old35uNy0r4+7DpSgL
 cYwfJv1v/5H3AeoOdHjdw17dsVVNJXDXZ3TC57sRYEWbfxOUbBqSR4SiLHy6OfgOsHYK
 ulbI1vAb1L60SDYLLNhCEEItuBVyV9WX2XD1pdDUSMQq6O3A0aTA6H9aQxYtEF9RzsTW
 cw469sQghRqjsGRIzV6NjxKjy+pV/Za8go4/EKJXJixZUnkflaotdXZjHkRBx6PeBabE
 hqAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSV4srS1TsVdnRo4XdmYEn3DcAss0g6rx0ePIKsKQQGIrgaTVkTuTNurqRH5/WHMdofirGfqdclksX@nongnu.org
X-Gm-Message-State: AOJu0Ywf2pP7o73AXLVYFOmIv+4zCPsCldVXq1tjCV1wJqJ2ooB0bWWu
 hIU54vSLXIKDY3t7cjGjxcQksKyGzkuXs8fq4tBxXItQPrYCKU8zr+TuxSe7OnQ=
X-Google-Smtp-Source: AGHT+IFOQ8m6/0L8ex0eYSYcdmHlP6G8sEWZmiQZt94kmYiBnc24ucIZUFS7neCpbLj7bXP7z3zGRg==
X-Received: by 2002:a17:90a:a412:b0:2e0:db81:4f7a with SMTP id
 98e67ed59e1d1-2e1e6211a19mr6355447a91.4.1728117943980; 
 Sat, 05 Oct 2024 01:45:43 -0700 (PDT)
Received: from [157.82.202.230] ([157.82.202.230])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e20ae71516sm1357818a91.12.2024.10.05.01.45.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Oct 2024 01:45:43 -0700 (PDT)
Message-ID: <db9f3849-adce-4362-afaa-b580829e8934@daynix.com>
Date: Sat, 5 Oct 2024 17:45:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/16] ui/dbus: discard pending CursorDefine on new one
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 belmouss@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20241003112244.3340697-1-marcandre.lureau@redhat.com>
 <20241003112244.3340697-8-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241003112244.3340697-8-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/10/03 20:22, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Similar to scanout updates, let's discard pending cursor changes.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/dbus-listener.c | 23 +++++++++++++++++++++++
>   roms/openbios      |  2 +-
>   2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
> index 23a4633fa4..020c05198b 100644
> --- a/ui/dbus-listener.c
> +++ b/ui/dbus-listener.c
> @@ -87,6 +87,7 @@ struct _DBusDisplayListener {
>   
>       guint dbus_filter;
>       guint32 display_serial_to_discard;
> +    guint32 cursor_serial_to_discard;
>   };
>   
>   G_DEFINE_TYPE(DBusDisplayListener, dbus_display_listener, G_TYPE_OBJECT)
> @@ -102,6 +103,14 @@ static void ddl_discard_display_messages(DBusDisplayListener *ddl)
>       g_atomic_int_set(&ddl->display_serial_to_discard, serial);
>   }
>   
> +static void ddl_discard_cursor_messages(DBusDisplayListener *ddl)
> +{
> +    guint32 serial = g_dbus_connection_get_last_serial(
> +        g_dbus_proxy_get_connection(G_DBUS_PROXY(ddl->proxy)));
> +
> +    g_atomic_int_set(&ddl->cursor_serial_to_discard, serial);
> +}
> +
>   #ifdef CONFIG_OPENGL
>   static void dbus_scanout_disable(DisplayChangeListener *dcl)
>   {
> @@ -502,6 +511,8 @@ static void dbus_cursor_dmabuf(DisplayChangeListener *dcl,
>           return;
>       }
>   
> +    ddl_discard_cursor_messages(ddl);
> +
>       egl_dmabuf_import_texture(dmabuf);
>       texture = qemu_dmabuf_get_texture(dmabuf);
>       if (!texture) {
> @@ -745,6 +756,8 @@ static void dbus_cursor_define(DisplayChangeListener *dcl,
>       DBusDisplayListener *ddl = container_of(dcl, DBusDisplayListener, dcl);
>       GVariant *v_data = NULL;
>   
> +    ddl_discard_cursor_messages(ddl);
> +
>       v_data = g_variant_new_from_data(
>           G_VARIANT_TYPE("ay"),
>           c->data,
> @@ -1027,6 +1040,16 @@ dbus_filter(GDBusConnection *connection,
>           }
>       }
>   
> +    discard_serial = g_atomic_int_get(&ddl->cursor_serial_to_discard);
> +    if (serial <= discard_serial) {
> +        member = g_dbus_message_get_member(message);
> +        if (g_strv_contains((const gchar *[]) { "CursorDefine", NULL }, member)) {
> +            trace_dbus_filter(serial, discard_serial);
> +            g_object_unref(message);
> +            return NULL;
> +        }
> +    }
> +
>       return message;
>   }
>   
> diff --git a/roms/openbios b/roms/openbios
> index c3a19c1e54..af97fd7af5 160000
> --- a/roms/openbios
> +++ b/roms/openbios
> @@ -1 +1 @@
> -Subproject commit c3a19c1e54977a53027d6232050e1e3e39a98a1b
> +Subproject commit af97fd7af5e7c18f591a7b987291d3db4ffb28b5

An accidental change of roms/openbios.

