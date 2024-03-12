Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39ABC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 21:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk9jT-0007IF-R0; Tue, 12 Mar 2024 17:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rk9jS-0007GH-9p
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 17:32:22 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rk9jQ-0002Gz-Oj
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 17:32:22 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-56829f41f81so6721441a12.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 14:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710279138; x=1710883938; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1A6MRbfjDccmU5+W23Sxazt4uixdLckis2pL93+GZ04=;
 b=UEOtawKGpu0yKyWzvvC6MkL5FFpTuqFXP3tCmbjfOnByxby2/GdLaAmQoXfO+X1JXK
 uHU1ep0WY3Ekc6vr0GaPhV9HWnBBlrodlFuj9GKe2O6NqZ5gz+jwJz4UxRM+GW/KxVhW
 2yqfn/0RPv5/UTosh5+MHWeHCHA4TNCBnvK4xhKCp3oVCs9kSDfbrqsj5N7uFPZcURRC
 q1arAEZvuCxmwdA1zubqT9RPDu8/BZ9WbIC5kMsyVvabzAU1jsitd8pBBMvQOuPGvUih
 UQW/J5c1pX3orMKNV5ZVfyFBlsSFHfGKxukA83NfiSi4kX6mau6Rle5+7FQqYjrs0lOJ
 uOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710279138; x=1710883938;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1A6MRbfjDccmU5+W23Sxazt4uixdLckis2pL93+GZ04=;
 b=HUogvxYoWeG+4EkE7suH1S09bLfQl9n7s6MM30AbU6sykZqgsspaMFYi6O40vArFPY
 gwhWhdZDHzqgm5IhKfiRKvAYSzUOYUU+c3vDCmKScgTal2vBYNyc9NIwidZdzfuzCsyI
 OKgLJCEfNx9PrfF6THqOpia/X1UWAfnk5EFD5+zCpLq6zg2jwLEwIBu7dWkcVfxaGz/T
 DafEa8wJ6vEcOLr54ELCar7RVnkQ/SnJIFygy0ygETZM+sKnZE2k7D40e2zRJDAE0nvt
 QsVc1ejBXUQDWF3RiAK6OE2Tj+WyzvY0euB8iB2qZGDBf06AXjpXRvSI4ajSHnHxzs37
 KYXQ==
X-Gm-Message-State: AOJu0YxYZfkoR3mA8faHLYI5/z92F7SZ+28wwxRWuHHl2DH1jwhPU6GV
 3WGZjU4oLtn4f3NFfqoJdgZbUDH+kE8exTFf0QPAYaWQnEVLVwX6vQ0bx5wOfO4cNoiMYurZeyP
 iZ/Cr38MEDqvYjS8A5cx3KpefngAZg4JGkEa52w==
X-Google-Smtp-Source: AGHT+IHnkmdYcqgdYNGBUZAted+2ww7M/4RfFLiBfw31zU3bxEfsyGQ/1vjLsHkUHB6YDdrMwBRwgePr5LF42l6LQ58=
X-Received: by 2002:a50:c311:0:b0:566:de7:ac4a with SMTP id
 a17-20020a50c311000000b005660de7ac4amr7969267edb.6.1710279138374; Tue, 12 Mar
 2024 14:32:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240312140216.313618-1-marcandre.lureau@redhat.com>
In-Reply-To: <20240312140216.313618-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Mar 2024 21:32:07 +0000
Message-ID: <CAFEAcA-9F8JNEwu7DHJXbEFSkAxknA3b6n0yJ7tKfRaS+63pDw@mail.gmail.com>
Subject: Re: [PULL 0/5] UI patches
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 12 Mar 2024 at 14:02, <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The following changes since commit 8f3f329f5e0117bd1a23a79ab751f8a7d3471e=
4b:
>
>   Merge tag 'migration-20240311-pull-request' of https://gitlab.com/peter=
x/qemu into staging (2024-03-12 11:35:41 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pull-request
>
> for you to fetch changes up to dfcf74fa68c88233209aafc5f82728d0b9a1af5c:
>
>   virtio-gpu: fix scanout migration post-load (2024-03-12 17:57:58 +0400)
>
> ----------------------------------------------------------------
> display/ui: pending fixes
>
> - ui/vnc: Respect bound console
> - ui/dbus: optimize a bit message queuing
> - virtio-gpu: fix blob scanout post-load
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

