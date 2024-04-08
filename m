Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF631CD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 10:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtlwR-0001Hh-08; Mon, 08 Apr 2024 06:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtlwP-0001Dm-LF
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 06:09:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtlwO-0000TI-9R
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 06:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712570967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kemf8yPR/dSOS9zjAGQAFXrwo2ngD5NRPPoUXt3i+Bs=;
 b=TO0FKZ1Y0oepNOETYWdrMq3Mc9IzSwoul51rns0acbycPoQWj0rmJNr6gAx/JU1HlaZLfY
 u78QxBxxFQlLpsaBpDh6t2SeEYWNC08P02ih/Azy36Gq8sPiKJwaHJ9mSvz1iatXGdMjck
 xAqmESt/SvwV2zzhKmuVe/v8ibi09uM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-meYciDcmNuKftJCT7pw_cQ-1; Mon, 08 Apr 2024 06:09:26 -0400
X-MC-Unique: meYciDcmNuKftJCT7pw_cQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-343c6a990dbso1747534f8f.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 03:09:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712570965; x=1713175765;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kemf8yPR/dSOS9zjAGQAFXrwo2ngD5NRPPoUXt3i+Bs=;
 b=DHhw+Zk9v4RXTiTEbfZg7oz5/MtyTfdVtSr2p8iqdZrfw0SoL8CACg/t4ICNeE3+oY
 2voDshv+bfBzH0P1W0bzoGe1uNCXfO908FETGV4c36404/JJAZqZvlv5PYt9uyVZJ/mh
 q/wY4A027Fa/JxdwZ+hDrgBQnHfFBYOMaTcdqJILSHcfrnfNljpfEKb/bkBdWbwL7a5b
 76IohEyEmYGeK/dKZ6PIPPxysWkRDFu0YgAl4acD7MQMg5+VT/B40MesoWuWO2D7msAx
 qA7UWxqfWGg52i4FpBzP7ssfs+MUyUya+p/UElNNqGBBnxOI/lUJk6QnZmLNvIaeDFfm
 S4MA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWamy5RRHmMH6Mv/Eo0sdZlOdWA4iBUnPaAfr+peo4gpKlQUAZON/WOX5XosKg2V2bbxUckinWa8JDrA3DOOjarg9shUcI=
X-Gm-Message-State: AOJu0YyQWaMONw7kxr2VWErrxevIObjs3/6WHHc6Wy0QOw35NRe3L0R/
 vrNhVbm6VBtTWUKBsxyMk5WvR9iz3MlZo+/+W6+DHelCyWK0FDToXfgiJdj86DmikhG++gCSaRz
 jCmds5mIbXiVKKx2PypHDJIvpJD8mkaKqVX7aOsVy1LJnDdzlIgR1y/NvSmzowyAOyIqWa4LEVA
 1QGmJFP+yGb+RVOoa5qE7HbWEt7S8=
X-Received: by 2002:adf:cf06:0:b0:343:4170:f3f1 with SMTP id
 o6-20020adfcf06000000b003434170f3f1mr7975237wrj.33.1712570965068; 
 Mon, 08 Apr 2024 03:09:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCxsmkz5ntrRrIIYwy2GQn8XI9RWuLEuMQjEbGtWnPtxkrmfkqrPa0l6z5gjOvfNkD5qSJN6QjwtO5jzZIMAM=
X-Received: by 2002:adf:cf06:0:b0:343:4170:f3f1 with SMTP id
 o6-20020adfcf06000000b003434170f3f1mr7975219wrj.33.1712570964778; Mon, 08 Apr
 2024 03:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240404194757.9343-1-philmd@linaro.org>
 <20240404194757.9343-6-philmd@linaro.org>
In-Reply-To: <20240404194757.9343-6-philmd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 8 Apr 2024 12:09:13 +0200
Message-ID: <CABgObfaT=xxHiO=Wx8wvkGu1EoMY+taNko+Vk46+1JjUsM51qQ@mail.gmail.com>
Subject: Re: [PATCH-for-9.1 5/7] hw/core: Restrict reset handlers API to
 system emulation
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org, 
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.355,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Thu, Apr 4, 2024 at 9:48=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> Headers in include/sysemu/ are specific to system
> emulation and should not be used in user emulation.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/core/reset.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/hw/core/reset.c b/hw/core/reset.c
> index d50da7e304..167c8bf1a9 100644
> --- a/hw/core/reset.c
> +++ b/hw/core/reset.c
> @@ -24,7 +24,9 @@
>   */
>
>  #include "qemu/osdep.h"
> +#ifndef CONFIG_USER_ONLY
>  #include "sysemu/reset.h"
> +#endif
>  #include "hw/resettable.h"
>  #include "hw/core/resetcontainer.h"
>
> @@ -43,6 +45,7 @@ static ResettableContainer *get_root_reset_container(vo=
id)
>      return root_reset_container;
>  }
>
> +#ifndef CONFIG_USER_ONLY

Wait, this does not make sense. The only thing left in the file is a
single static function, which contradicts the other patch's commit
message "reset.c contains core code used by any CPU,".

Let me rework these two patches so that reset.c, qdev-hotplug.c and
hotplug.c can be moved to system_ss. I'll post a v2 shortly.

Paolo

>  /*
>   * Reason why the currently in-progress qemu_devices_reset() was called.
>   * If we made at least SHUTDOWN_CAUSE_SNAPSHOT_LOAD have a corresponding
> @@ -185,3 +188,4 @@ void qemu_devices_reset(ShutdownCause reason)
>      /* Reset the simulation */
>      resettable_reset(OBJECT(get_root_reset_container()), RESET_TYPE_COLD=
);
>  }
> +#endif
> --
> 2.41.0
>


