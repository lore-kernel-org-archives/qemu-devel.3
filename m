Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3F9C02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 07:40:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfwTu-0006YC-Tt; Thu, 06 Feb 2025 02:39:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tfwTq-0006XW-VK
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 02:39:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tfwTo-0003Uv-Og
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 02:39:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738827559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fW6d0rh/sab5Rc+h/l9LV8v3OQfoX6KJtj86yo6bDSk=;
 b=YxMWIEa+t4LKxzZDoKV7UDsWA3DEXDsv3lP3fp9u22SvmFtaEMvqmkfuEIEGfI4r3kTQQv
 c4rZNMZbU44cY8wNA/hVRzJWFKfN5065mbC0xIXcBLJLe0LpCfDc8ZtgHcKDAEHI7Rdot6
 6KzVF3lSA7ss2P01eM+p6P62na7Nee0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-f6dZj2fTPoS-iDjXw_X7PA-1; Thu, 06 Feb 2025 02:39:15 -0500
X-MC-Unique: f6dZj2fTPoS-iDjXw_X7PA-1
X-Mimecast-MFC-AGG-ID: f6dZj2fTPoS-iDjXw_X7PA
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-438da39bb69so4816165e9.0
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 23:39:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738827553; x=1739432353;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fW6d0rh/sab5Rc+h/l9LV8v3OQfoX6KJtj86yo6bDSk=;
 b=Go63leliu6L6mtdH385KhPq61Ik5NUgTMDd0y8++YBy0oJabiaul8Eniy9NrWsJqEJ
 DlbdCa9tiVT8XuOHfgHupI5axX8i8nma+yDZfAt0XKtqRUlkADk0EvjpReBerfv3fN89
 VrOGNrIKBhBbx4NYkMQOXUiVSmHE9zgRQilbx1npCTCTHqgquOwCg99/hKxUNPS+qPE6
 tLCRh/iygEV+HUQh11U2Thl/in/jvsyIhynVe82Pgt1ZsGrFc7Ojz8hGTJ4e9eJugqct
 xKzwW3uKcqcNulB5ZCMtLJlR4MQ2Tg26SauPBXjr/4z3fePfyZT0SlZbWRBHxXslcGBl
 R0SQ==
X-Gm-Message-State: AOJu0YxcEs1NG8p8m+ArTMW/4a6lHGjvnhPooCbbjXxhftZWJwI3kFPK
 vZS1ny0TAjkVmVDGrXQ9VRQciGggMjuTfz1RuTB08P948SYrx5vQunoN34ijG0RjxaIkdOu/HBR
 yqxNsFKEBaR/PqOK74ZNWs1rELZwHwd4TaAXYOCUlVp2ZdIUHwpsxoDNwqIaUlEImLxyOYWiXfv
 YgUVde6LUtObenOcQJwz0HlAmzAv82Uep4Ad1NPYUM
X-Gm-Gg: ASbGncui/hw6vKpX18YRdXHxuPmdBxfdrPmqdvVUZD3js956Pk8RH1HfIfzURoZnAua
 al+LG+xc29Dlu3/gAiBzCkO412c3Sf6HG6KQfxrgg1edhd3rfPaQnXxYd7k7f
X-Received: by 2002:a05:600c:1d26:b0:436:17e4:ad4c with SMTP id
 5b1f17b1804b1-4390d42d923mr42627705e9.6.1738827553215; 
 Wed, 05 Feb 2025 23:39:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGP3M8EphEfRgQSkb2ZRA6uNgr+FM/IHVhGmuPhrJb2iQ4DFZI8AgCnwDy2mQU0BzuXGtyltGgbKzeEaWik35U=
X-Received: by 2002:a05:600c:1d26:b0:436:17e4:ad4c with SMTP id
 5b1f17b1804b1-4390d42d923mr42627565e9.6.1738827552890; Wed, 05 Feb 2025
 23:39:12 -0800 (PST)
MIME-Version: 1.0
References: <20250117194003.1173231-1-pbonzini@redhat.com>
 <20250117194003.1173231-4-pbonzini@redhat.com>
 <Z6RpfkKHEjsQowOW@intel.com>
In-Reply-To: <Z6RpfkKHEjsQowOW@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 6 Feb 2025 08:39:01 +0100
X-Gm-Features: AWEUYZlqeDcJPwic7yFv0zwSgqjyHMywQfp6M2Xze30xAhBwB7YyvTaDeFk2tCY
Message-ID: <CABgObfYLMm-iQuu5u2pDeNSQ=ZR=M5rJVeTu2fO9LZ-fwcXh=w@mail.gmail.com>
Subject: Re: [PATCH 03/10] rust: qom: add object creation functionality
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Feb 6, 2025 at 8:29=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com> wrote=
:
> The ref count of Owned<> is decreased on exit, so we need to use
> sysbus_realize() instead of sysbus_realize_and_unref() to ensure ref
> count is correct at C side.
>
> Initially, I hesitated here for an entire morning because this didn't
> seem to conform to the usual usage of sysbus_realize_and_unref() (or,
> further, qdev_realize_and_unref()).
>
> But now I realize that qdev_realize() is used for embedded objects,
> while qdev_realize_and_unref() is used for non-embedded cases. Therefore,
> moving forward, perhaps qdev_realize_and_unref() should not exist on the
> Rust side.

Correct, all unref() operations are handled implicitly by the Drop
implementation of Owned<>

> Owned<> will automatically drop and thus automatically unref, while
> Child<> will not unref.

No, Child<> will also unref. The point of Child<> is to prolong the
life of the child object, so that it dies after instance_finalize
instead() of dying during object_property_del_all(). In C that has to
be done manually (as is the case in the clock creation functions), in
Rust it will be enforced by the type system.

> In the future, maybe we need some wrappers on qdev_realize()/sysbus_reali=
ze().

Yep, I'll add a conversion of pl011_create to safe Rust to clarify the
rules around usage of Owned<>.

Paolo


