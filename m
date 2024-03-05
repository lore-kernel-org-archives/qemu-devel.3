Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA25C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 14:30:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhVnd-00034c-Iu; Tue, 05 Mar 2024 09:29:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rhVnb-00034P-NQ
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 09:29:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rhVna-0005aU-6G
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 09:29:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709648981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xQ12VNbAY5cZCxz0Lo9Pxxqh0oFiv+9Nm6t32IAbGAk=;
 b=K/TYa4/9KRmh2ZeoI1zyRDhwK2Av/AuUT62OtEGMd5wAPaJsMWmeO+BzOIj/WWNiNj//RO
 +XAii4evVW7/kOcvhXV89Mf7/lx/vNqj+mpvO5hF3B47FM2HJvLN/zrl4tEfzOCT52oD49
 MSAklym3bHPzwut+/spwYcSglXb23VM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-Y8aPQjEYMyyuhWPKA2hobw-1; Tue, 05 Mar 2024 09:29:39 -0500
X-MC-Unique: Y8aPQjEYMyyuhWPKA2hobw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-412e99244dbso6837545e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 06:29:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709648978; x=1710253778;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xQ12VNbAY5cZCxz0Lo9Pxxqh0oFiv+9Nm6t32IAbGAk=;
 b=IXjlcOcPXs/yKMMZ6pYViCwIflb3nyZvK07U5YwfdKIljYN9iM/Eb9MCsOLqNVjXJt
 /ntD3ab3noMYci3L89YixoqwbYH4jgJkWFr4UANqU6+2NuQdP4ew9rYnb8zkDhtq0dVS
 UVGUZvGwqsWkpzG/RvnU9vjL/ZQyHfXDCQB6MM1vV+brWi5rUxNLEUhbcQrztQE5qEbr
 XsGP1l1IQvcUqbgIoxxLfXxEAsu61517xVNvBKg1bvUTAJNGjGX8+/Y45im5m+z9LrIW
 ANpodfDAK489p6d2EPR/l9mdWOUI0WWoJQQ5p1dliN3Z+ew58sVBBmaVqif4742JiUKQ
 A6fA==
X-Gm-Message-State: AOJu0YzJ+JKUGpTaKVfVESK94Y2MQeKfZ4JNlMEdbaAWFnaJyOMq9Lio
 fJMj0WtB0jqCSsnwtcR6y/qy0KV4cdOzukDEuXCzrOSNnYPKXYKLWEDJFCdMc+bvrpQhoPR80ny
 joyaAjkykwUxCHS+twsiTZGWOjDz/im82j4yBLb45RaFp/etjguDDQDqJ7KRbEQfZGrhcsVycpu
 hN/9b/vKxC6Pkj7bimkSTK4Rrn2Es=
X-Received: by 2002:a5d:4ec7:0:b0:33d:3098:3ccf with SMTP id
 s7-20020a5d4ec7000000b0033d30983ccfmr7753374wrv.33.1709648978376; 
 Tue, 05 Mar 2024 06:29:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFl1mLQgfIVcd9e27bry/ouNUClwnij23QAWVus608gWu+PwXwFrv/zTjorKX7YvjRPjacNADmd99EcHBqFPUk=
X-Received: by 2002:a5d:4ec7:0:b0:33d:3098:3ccf with SMTP id
 s7-20020a5d4ec7000000b0033d30983ccfmr7753362wrv.33.1709648978033; Tue, 05 Mar
 2024 06:29:38 -0800 (PST)
MIME-Version: 1.0
References: <20240223161300.938542-1-peter.maydell@linaro.org>
In-Reply-To: <20240223161300.938542-1-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 5 Mar 2024 15:29:25 +0100
Message-ID: <CABgObfZ_FOs29mZJKcXWTJurWO8wDDWkhfFW9g9ppzOGG2_dKA@mail.gmail.com>
Subject: Re: [PATCH] hw/rtc/sun4v-rtc: Relicense to GPLv2-or-later
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Feb 23, 2024 at 5:13=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> The sun4v RTC device model added under commit a0e893039cf2ce0 in 2016
> was unfortunately added with a license of GPL-v3-or-later, which is
> not compatible with other QEMU code which has a GPL-v2-only license.
>
> Relicense the code in the .c and the .h file to GPL-v2-or-later,
> to make it compatible with the rest of QEMU.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Before we can commit this to either head-of-git or any stable branch,
> we need a Signed-off-by: from everybody who's touched this file (or,
> for corporate contributions, from somebody from the relevant company
> who can confirm that the company is OK with the licensing, which is
> RedHat and Linaro in this case).

All contributions from Red Hat are GPLv2 or later (though it's nice
that Markus signed off on his own), so

Signed-off-by: Paolo Bonzini (for Red Hat) <pbonzini@redhat.com>

Paolo

> The full list of people who've made changes to the file is:
>  Artyom Tarasenko <atar4qemu@gmail.com>
>  Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>  Markus Armbruster <armbru@redhat.com>
>  Eduardo Habkost <ehabkost@redhat.com>
>
> (Artyom is the original author; everybody else's changes are largely
> mechanical, refactoring, etc.  We've done some behind-the-scenes
> coordination so I don't anticipate any problems getting the
> signoffs.)
> ---
>  include/hw/rtc/sun4v-rtc.h | 2 +-
>  hw/rtc/sun4v-rtc.c         | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/hw/rtc/sun4v-rtc.h b/include/hw/rtc/sun4v-rtc.h
> index fc54dfcba47..26a9eb61967 100644
> --- a/include/hw/rtc/sun4v-rtc.h
> +++ b/include/hw/rtc/sun4v-rtc.h
> @@ -5,7 +5,7 @@
>   *
>   * Copyright (c) 2016 Artyom Tarasenko
>   *
> - * This code is licensed under the GNU GPL v3 or (at your option) any la=
ter
> + * This code is licensed under the GNU GPL v2 or (at your option) any la=
ter
>   * version.
>   */
>
> diff --git a/hw/rtc/sun4v-rtc.c b/hw/rtc/sun4v-rtc.c
> index e037acd1b56..ffcc0aa25d9 100644
> --- a/hw/rtc/sun4v-rtc.c
> +++ b/hw/rtc/sun4v-rtc.c
> @@ -5,7 +5,7 @@
>   *
>   * Copyright (c) 2016 Artyom Tarasenko
>   *
> - * This code is licensed under the GNU GPL v3 or (at your option) any la=
ter
> + * This code is licensed under the GNU GPL v2 or (at your option) any la=
ter
>   * version.
>   */
>
> --
> 2.34.1
>


