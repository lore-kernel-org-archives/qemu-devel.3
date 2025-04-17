Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB479C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 14:12:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Pyt-0004oH-2V; Thu, 17 Apr 2025 10:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.nesterov@gmail.com>)
 id 1u5Pyr-0004o6-1d
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 10:12:41 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.nesterov@gmail.com>)
 id 1u5Pyn-0008Nt-QQ
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 10:12:40 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ac73723b2d5so150060366b.3
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 07:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744899155; x=1745503955; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RlnkcTtsPgIczGT6m8P4wsg+T/AhK0jRk6bsSiDCr0U=;
 b=VvGPXsGlKrkmI7/pj2ufHLVB46aty8XnEZK+epM74Fwn0kjOLl7IkfbCx2TeeNGDiV
 2F2xF/0rZr5dK0PEhtKyDFz3A9gQCwlyQO1KcJ3FeQBpYK+i2eQhgyrBm83aGByWjIgK
 468NE6t29/txqIIR1LuOQPHUZXFwMiS1TYuIOHFjj0ortyUK+NXncQmSLHc1C+6pgd84
 L+8B/hNE7wxKHuwUPg0TL+7zCApgr9oKtkzmBoq+RdiEzNvLjCSbMIBhMMVMHDzfftER
 CGaP3W1f4yj4E0zpA8s+bHokqjC6wdDDxg5IRgssXdwAijpe18Bls709k09LWlOAQWOd
 h24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744899155; x=1745503955;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RlnkcTtsPgIczGT6m8P4wsg+T/AhK0jRk6bsSiDCr0U=;
 b=hhGgb8ShQzbiT41oPK3235C/C0ZwKewD/4QWWox6vJeaD7r2v9Dq46Z+HJP39j1Abt
 N4/NHQnV9/U579J8rxgAQE/dK44cOsumGa/af6uQkAT52XyHsmRFvMMiHumlCsvunosL
 TLG7zgqY7PS0uyb3n50XM692ot2tKKjvUDYkGxzdHNoYRDXSVrxgw8kBU1obEBG8ATVx
 MOWH2QUnYihNh0wP7idsT4s1W75R403DnuccDDDC9AXszrilqehWJ+NXeIP3E3JorTgp
 2Ivx59yG8w9fvrQ7k39mj+te2V1IDG2wwVuJ1Ib8jIXj5Qsvt8Aww1yNC6ON5xjXh5kD
 yHPQ==
X-Gm-Message-State: AOJu0YwJqSyGm0dxrTefH9CgqYBOjJ4eyZkH6pJxl1hvVyhyEUNEeXQ2
 Z0nGrh6a2CG7KjZ1fky7yrKD9EnbdC+HPg2psp91sps5HDysBPUlDA4YrSZlb5btOBoYwMlQMuz
 yA5EvCoO0HJ/LgkxYd3kvndksdr0=
X-Gm-Gg: ASbGncs8e4LKN66IzBMQ3jQUj7d5Cj4AvhlMNx5U0RIkmV7tuAq9vRYnvLbIH1vRJ8P
 UENZ+cbGpnWRFXx27XonFPPMMRsxQ1wM2EeebXbHGARGLnoXxOXQ9nOdntBfwhMJhP5Smtm9sYN
 A6AwVzt6gRSULihG1CaOy0Ux8tVrFWKHStl0Q=
X-Google-Smtp-Source: AGHT+IEDSaRXjwOwIi+lObV3WQqMH1wOrh7N5zFyQTzXsNA+olpQWy2jYwT/bQzXuJp8XxTjilGsyMNa7042MsglJ8w=
X-Received: by 2002:a17:907:3cc6:b0:ac7:ec90:2ae5 with SMTP id
 a640c23a62f3a-acb42997607mr615014966b.25.1744899154852; Thu, 17 Apr 2025
 07:12:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250416161929.2846102-1-yuri.nesterov@gmail.com>
 <Z__jtQe0nYsaGnoH@redhat.com>
 <CAB_o470VGNmj_4LKvo3-Y6O7LiKiJ4QXczt6ZqRua_mpM1LN2A@mail.gmail.com>
 <aADMttudIP3zC85W@redhat.com>
In-Reply-To: <aADMttudIP3zC85W@redhat.com>
From: Yuri Nesterov <yuri.nesterov@gmail.com>
Date: Thu, 17 Apr 2025 17:12:23 +0300
X-Gm-Features: ATxdqUFtUEJe6kBQspAT3nSoC7uIg568vP4rHiyJlmZh9ysmWdvAWQmg5tTN1K0
Message-ID: <CAB_o471Vcf4AxZoucvuye7bG=yM_0g3TAfu5Kc=ZQJXR9vdr=A@mail.gmail.com>
Subject: Re: [PATCH] usb-host: enable autoscan for bus+addr to survive host
 suspend/resume
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=yuri.nesterov@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Apr 17, 2025 at 12:41=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> On Wed, Apr 16, 2025 at 10:27:54PM +0300, Yuri Nesterov wrote:
> > On Wed, Apr 16, 2025 at 8:07=E2=80=AFPM Daniel P. Berrang=C3=A9 <berran=
ge@redhat.com> wrote:
> > >
> > > On Wed, Apr 16, 2025 at 07:19:29PM +0300, Yuri Nesterov wrote:
> > > > Currently, there is a special case for usb-host devices added using=
 the
> > > > hostbus=3D and hostaddr=3D properties to avoid adding them to the h=
otplug
> > > > watchlist, since the address changes every time the device is plugg=
ed
> > > > in. However, on Linux, when the host system goes into suspend and t=
hen
> > > > resumes, those devices stop working in both the guest and the host.
> > > >
> > > > Enabling autoscan and adding those devices to the watchlist allows =
them
> > > > to keep working in the guest after host suspend/resume.
> > >
> > > So IIUC what you're saying is that on suspend the host device
> > > is removed by the kernel, and on resume, the USB device is
> > > recreated. So QEMU's open file handle for the USB device is
> > > invalid after resume.
> > >
> > > If the /dev/bus/usb/NNN/NNN file goes away and then gets
> > > re-created by the kernel though, we can't assume QEMU is
> > > going to be able to re-open the new /dev/bus/usb device
> > > file though.
> >
> > I'm not sure if the file actually goes away. It looks like the internal
> > state of the device changes and QEMU receives a "no device"
> > response in usb_host_req_complete_data. However, the file
> > remains in place. At least I don't see any changes in udevadm
> > monitor or inotifywait aside from attribute modifications.
> >
> > After resuming from suspend, the device doesn't work on either
> > host or guest. Probably the device stays with a detached kernel
> > driver since QEMU can't reattach it after receiving the "no device"
> > error. Adding such devices to the hotplug watchlist causes QEMU
> > to reopen them the same way it does for devices specified by
> > vendorid and productid or hostport.
>
> This is a bit odd, as AFAICT from reading the code, the
> usb_host_auto_check wll only trigger close + re-open of
> the device, if there is a period of time in which the
> /dev/bus/usb device node does not exist, but you're
> saying it remains existing across suspend/resume.

I guess it depends on how it's configured, both in hardware
and software. I'm testing on a regular ThinkPad with Ubuntu
and default settings. It's probably possible to configure USB
to turn off power during suspend. In that case, it might
reappear after resume with a new address. However, with
the default settings, it seems to keep the same device node
and address. I assume the driver just switches it to
low-power mode and then back to normal.

In usb_host_auto_check, it reopens the device when the
handle s->dh is NULL. This happens after
usb_host_req_complete_data receives the "no device" status
and closes the device. Maybe one of the kernel functions
returns -ENODEV at some point, but after that, the device
continues to work fine.

