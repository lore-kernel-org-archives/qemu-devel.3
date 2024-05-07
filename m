Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A2EBC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 13:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4LDG-0003D0-NQ; Tue, 07 May 2024 09:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1s4LDB-0003Ci-ST
 for qemu-devel@nongnu.org; Tue, 07 May 2024 09:50:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1s4LD9-0007Mp-8W
 for qemu-devel@nongnu.org; Tue, 07 May 2024 09:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715089824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V5sPZCr6dUEd3EwBv93lKADL61nA+68qv50OL1eF2GY=;
 b=M3+paIWHby2wowfScrGMsrSikKhkRl7rligA3nJRsS3e+eN+SomAjsFnc8ZbaF8/L9zXy8
 v/z8DDaiYhCGskYkelkQ25Ow8wIOIUdbtMdXHT1xQu+2bSMi2/7BXsIaUw4lTt1rKC03L1
 9xkvJWWEucAG0P8LA9gXiO/ZFgJID10=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-jrgLWKwOM4-gJyq5EdKZvg-1; Tue, 07 May 2024 09:50:23 -0400
X-MC-Unique: jrgLWKwOM4-gJyq5EdKZvg-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-572ef3eb368so474496a12.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 06:50:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715089822; x=1715694622;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V5sPZCr6dUEd3EwBv93lKADL61nA+68qv50OL1eF2GY=;
 b=k4rAzDDcG2cV4cQ48Edd1Tj1wqYi3y6Gn030iZIO7iivomUfuUSmprXDXzkixZNayE
 rUnPsjTwu9XnuuppsWx7bv+/4R3GWBc1SZdYBhQH0jCaBjWurWgDiyOlrD3Yxi7AHHxT
 zRVd0Cn/9/AaqEtq17EhXBCItNszRb6a5X47UQdVs9BiHTj238MyyeOpS4N2CofZIBEj
 MtEIOjvLSEWOpJ0kOjMXXH0489w76qCl6+GuEBxq19kEm8fEhMTYqldwgUQJ1OQPQZbS
 UrOpfOm6TaPcSUtJOF7u/7qq7XHZZO/VwMlsunXWKEIdLak4z5/nfXt0f3Sd9ZKxp25R
 8Pqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWV9oJt2a9JtIceM+eh+/7Rsoj5sR9strN66cz5t8zaIZGQf8zto1B6MECQeq7wnMRtMc0MraGN/ozisToH+s/pc7fuuek=
X-Gm-Message-State: AOJu0Yw1CZSVezuH7XDKF/2nMwoxUqIjPHpm64D+F+iVqqu7R+jMLg9F
 EgxDV5DhET17mQPxXiGOwp/XBzFOvcHhve1DDVywa9XOwX76+kdYoLpm9y2KhnV7gcryQsWsjpz
 4PpHX8gDex8M7lGO+f25vk+x5WRXCGcW50oYAr1lxNFlrlVzzD7LthU/GaQkqPSGLueGgGIRU9w
 0b/D4oFNi02Or0pYZb8yAyuhNNapA=
X-Received: by 2002:a50:9992:0:b0:572:a07a:677d with SMTP id
 m18-20020a509992000000b00572a07a677dmr8836661edb.23.1715089821810; 
 Tue, 07 May 2024 06:50:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/Fj9oODGRERFF4b3fWEoaXjekMUDNJ6iTlxPfB7ql1lkjJ4RDSzpusbD7lpW66eBbDt+Vu7qzlgKyPxj1kas=
X-Received: by 2002:a50:9992:0:b0:572:a07a:677d with SMTP id
 m18-20020a509992000000b00572a07a677dmr8836653edb.23.1715089821445; Tue, 07
 May 2024 06:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240403055002.890760-1-justinien.bouron@gmail.com>
In-Reply-To: <20240403055002.890760-1-justinien.bouron@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 7 May 2024 17:50:09 +0400
Message-ID: <CAMxuvazcUfBo04ecH+PDXYWfC=cU-Gp-_y2nAUaN2X4+e=qDuA@mail.gmail.com>
Subject: Re: [PATCH v3] input-linux: Add option to not grab a device upon
 guest startup
To: Justinien Bouron <justinien.bouron@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On Wed, Apr 3, 2024 at 9:51=E2=80=AFAM Justinien Bouron
<justinien.bouron@gmail.com> wrote:
>
> Depending on your use-case, it might be inconvenient to have qemu grab
> the input device from the host immediately upon starting the guest.
>
> Added a new bool option to input-linux: grab-on-startup. If true, the
> device is grabbed as soon as the guest is started, otherwise it is not
> grabbed until the toggle combination is entered. To avoid breaking
> existing setups, the default value of grab-on-startup is true, i.e. same
> behaviour as before this change.
>
> Signed-off-by: Justinien Bouron <justinien.bouron@gmail.com>
> ---
>
> Changes since v2:
>     - Added missing (since 9.1) to the new option in qapi/qom.json
>
>  qapi/qom.json    | 14 +++++++++++++-
>  ui/input-linux.c | 20 +++++++++++++++++++-
>  2 files changed, 32 insertions(+), 2 deletions(-)
>
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 85e6b4f84a..2067e41991 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -508,13 +508,25 @@
>  # @grab-toggle: the key or key combination that toggles device grab
>  #     (default: ctrl-ctrl)
>  #
> +# @grab-on-startup: if true, grab the device immediately upon starting
> +#     the guest.  Otherwise, don't grab the device until the
> +#     combination is entered.  This does not influence other devices
> +#     even if grab_all is true, i.e. in the unlikely scenario where
> +#     device1 has grab_all=3Dtrue + grab-on-startup=3Dtrue and device2 h=
as
> +#     grab-on-startup=3Dfalse, only device1 is grabbed on startup, then,
> +#     once the grab combination is entered, grabbing is toggled off
> +#     for both devices (because device1 enforces the grab_all
> +#     property) until the combination is entered again at which point
> +#     both devices will be grabbed.  (default: true)  (since 9.1).
> +#
>  # Since: 2.6
>  ##
>  { 'struct': 'InputLinuxProperties',
>    'data': { 'evdev': 'str',
>              '*grab_all': 'bool',
>              '*repeat': 'bool',
> -            '*grab-toggle': 'GrabToggleKeys' } }
> +            '*grab-toggle': 'GrabToggleKeys',
> +            '*grab-on-startup': 'bool'} }
>
>  ##
>  # @EventLoopBaseProperties:
> diff --git a/ui/input-linux.c b/ui/input-linux.c
> index e572a2e905..68b5c6d485 100644
> --- a/ui/input-linux.c
> +++ b/ui/input-linux.c
> @@ -44,6 +44,7 @@ struct InputLinux {
>      bool        grab_request;
>      bool        grab_active;
>      bool        grab_all;
> +    bool        grab_on_startup;
>      bool        keydown[KEY_CNT];
>      int         keycount;
>      int         wheel;
> @@ -400,7 +401,7 @@ static void input_linux_complete(UserCreatable *uc, E=
rror **errp)
>      if (il->keycount) {
>          /* delay grab until all keys are released */
>          il->grab_request =3D true;
> -    } else {
> +    } else if (il->grab_on_startup) {
>          input_linux_toggle_grab(il);
>      }

The patch looks ok to me, but you don't handle the case where keys are
pressed at startup and the grab is delayed. You could add a if
(!il->grab_on_startup) goto skip_grab, probably instead.

>      QTAILQ_INSERT_TAIL(&inputs, il, next);
> @@ -491,6 +492,19 @@ static void input_linux_set_grab_toggle(Object *obj,=
 int value,
>      il->grab_toggle =3D value;
>  }
>
> +static bool input_linux_get_grab_on_startup(Object *obj, Error **errp)
> +{
> +    InputLinux *il =3D INPUT_LINUX(obj);
> +    return il->grab_on_startup;
> +}
> +
> +static void input_linux_set_grab_on_startup(Object *obj, bool value,
> +                                            Error **errp)
> +{
> +    InputLinux *il =3D INPUT_LINUX(obj);
> +    il->grab_on_startup =3D value;
> +}
> +
>  static void input_linux_instance_init(Object *obj)
>  {
>  }
> @@ -498,6 +512,7 @@ static void input_linux_instance_init(Object *obj)
>  static void input_linux_class_init(ObjectClass *oc, void *data)
>  {
>      UserCreatableClass *ucc =3D USER_CREATABLE_CLASS(oc);
> +    ObjectProperty *grab_on_startup_prop;
>
>      ucc->complete =3D input_linux_complete;
>
> @@ -514,6 +529,9 @@ static void input_linux_class_init(ObjectClass *oc, v=
oid *data)
>                                     &GrabToggleKeys_lookup,
>                                     input_linux_get_grab_toggle,
>                                     input_linux_set_grab_toggle);
> +    grab_on_startup_prop =3D object_class_property_add_bool(oc, "grab-on=
-startup",
> +        input_linux_get_grab_on_startup, input_linux_set_grab_on_startup=
);
> +    object_property_set_default_bool(grab_on_startup_prop, true);
>  }
>
>  static const TypeInfo input_linux_info =3D {
> --
> 2.44.0
>


