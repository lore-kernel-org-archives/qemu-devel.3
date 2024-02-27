Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59930C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 12:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reweY-0001ZO-5e; Tue, 27 Feb 2024 07:33:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1reweW-0001Yw-EV
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 07:33:44 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1reweQ-0007s4-GL
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 07:33:44 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-565ef8af2f5so2625587a12.3
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 04:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709037216; x=1709642016; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r23O8HIQb7dtjo/BiOJDwMMH5t6omzMtKOwdsa/Qpq0=;
 b=gXMkEYxvBIdJRN9jBmLUmwE80gSwh2Tw4l4pw4K9tmfhEl0x3Z9HzSXZ9ROyzrJWrB
 FAa68j/WyttE7kLtQI/puce0CYF76zyHz0RZgxw43SpNfp5iL02luF6Pucb83tsTrDNU
 KVVnfRxmhqWa75r9Da0OLTmfjbG2zfK98CIkD91cfoSDnCq+SGPHZIgXzqJgEA22iGXj
 a0Cq4MojxXavNJFYooSS4KQI5tg9VyPurOHL32+ExXtsWSdIQ/weIDK1zPE+6zruuZIZ
 eIlRXeeeUycjfZS5aUQlov4RLXDpv40ThTBFiqUgnMQH5xy+HGgdKLfJhoVJnGI2XTFa
 ZOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709037216; x=1709642016;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r23O8HIQb7dtjo/BiOJDwMMH5t6omzMtKOwdsa/Qpq0=;
 b=BuSDWmLgqlvc38sCcOUQvkRa6i9Blxa6J0uQnPkwVXNHW6jdIVOXFTE28z1gKvNAQp
 B7C0MwEq58h704hVysbbBfpbCsKrKCSUVfbCs3jnZCT9jwNDbYJ0mDpsHG6lXTrgDl1R
 BV4AbhoIwwhyCvj1emBJynX7OQLXEysc7kxsiA9r3ImVRvvXjtjHtOuItdu3XC2uf5Tg
 TuZwnT/sUyGrzcYDi6UgM1sHNYIlwL7gv0xHjYxMeAZe0rGSvySpJEBrMXygpv73jrBg
 z+Ju4NIdLYcS8uWoLxC0AXKnHNaXcgi2oV+1ugqibY50V1Bmdt0pRxdazvHuWYw4+P7v
 GdnA==
X-Gm-Message-State: AOJu0YwpId/ElX4sXA3nS1m+aMY8aD4HrzSCLEsfBzbkTp4zqDXPePNh
 w45cCzfwCkMQ/PjboOAofXc32pvFLcBC4G4dLFFy5f48k/TygS6JFmfI+UlCpT9UbINvBjTrAF7
 pvXb6xqc1fQjlUu18hqQxZgdaF3Errh8x8SAP5Q==
X-Google-Smtp-Source: AGHT+IHM936Mf3jj77hy7pi9RW8CxBYa4iQpJ6cEVjFqRZj8Y43916ZCppxZ64BA3hulJ2VSpRbJmBB7RPnGGig+YJI=
X-Received: by 2002:aa7:c908:0:b0:565:edd9:1acb with SMTP id
 b8-20020aa7c908000000b00565edd91acbmr4080278edt.23.1709037216608; Tue, 27 Feb
 2024 04:33:36 -0800 (PST)
MIME-Version: 1.0
References: <20240227083948.5427-1-philmd@linaro.org>
 <CAFEAcA_SzY7nJd_s670g8qttsszLxynDiVXH-=7feyq-vVfixQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_SzY7nJd_s670g8qttsszLxynDiVXH-=7feyq-vVfixQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2024 12:33:25 +0000
Message-ID: <CAFEAcA8emi5=ra=LQrFYNO4_GdXCQbnaYS+4-m4SC2AQJ3E7gA@mail.gmail.com>
Subject: Re: [PULL 00/30] Misc HW patches for 2024-02-27
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Tue, 27 Feb 2024 at 12:33, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Tue, 27 Feb 2024 at 08:40, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.=
org> wrote:
> >
> > The following changes since commit 03d496a992d98650315af41be7c0ca6de2a2=
8da1:
> >
> >   Merge tag 'pull-qapi-2024-02-26' of https://repo.or.cz/qemu/armbru in=
to staging (2024-02-26 11:22:32 +0000)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/philmd/qemu.git tags/hw-misc-20240227
> >
> > for you to fetch changes up to 0316482e876988f7526ebe62d579ad069f485957=
:
> >
> >   hw/ide: Include 'ide-internal.h' from current path (2024-02-27 09:37:=
30 +0100)
> >
> > ----------------------------------------------------------------
> > Misc HW patch queue
> >
> > hw: Remove sysbus_address_space() (Phil)
> > hw/nubus: Add nubus-virtio-mmio device (Mark)
> > hw/usb: Remove usb_bus_find() (Paolo)
> > hw/usb: Extract sysbus-ohci from ohci (Paolo)
> > hw/nvme: Fix invalid endian conversion
> > hw/i386: More PC machine housekeeping (Bernhard, Phil)
> > hw/ide: Restrict "ide-internal.h" (Zoltan, Phil)
> > qom: Expose object_resolve_type_unambiguous() (Paolo)
> >
> > ----------------------------------------------------------------
> >
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Whoops, wrong canned response again. I meant:


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

