Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28087C369C5
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 19:28:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u58Qe-0003pk-Pj; Wed, 16 Apr 2025 15:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.nesterov@gmail.com>)
 id 1u58Qb-0003p9-MZ
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:28:09 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.nesterov@gmail.com>)
 id 1u58QZ-0007wj-Md
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:28:09 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5f435c9f2f9so31704a12.1
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 12:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744831686; x=1745436486; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qHuAyvnQJoHRi+dia0h0RJ286a+cu1nhD0EYwZxTvyM=;
 b=HitJBVdMI5yEEK7iE90rwCSUE2k6+c+JAr9sRlaxUf/8G99RCE2kk+icN2VSZWykgB
 TRx1qyXFlEg+FTcOOd3nGzzyIj3C8B4Z2OGm+tZSZRzVChG3lxbLPfaI06Qu0KkaYy/y
 0Ae6TrSohJ2/rqFdflNL9PiMWfA2iDQwmfWseALv9gwjpwCs/VWnVgA4aKG7tkwBlp+j
 Gw04NLsO8XqSi13WvwUXrTx6ZBupfFyoD0AI+2dehcvW5nu8lICEEE29ppXKTlUT6BB7
 odQY1/2pVGFI1CMKRe0VfeCDT3u73GovpUdMp4neXLeribw4Y8tMwMbtNfc1gXpTP/3E
 0JZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744831686; x=1745436486;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qHuAyvnQJoHRi+dia0h0RJ286a+cu1nhD0EYwZxTvyM=;
 b=wt4FadMUC/mq8XlwMYiUSdGC2DabrYg/lNvkgKl4h2nN/1usO00stoV6321oIJ8ZPe
 pA7YtCm1qz3Nb0g1wwxUcgkw+TDA7FHUImu+WjedVNpJPfimaA/k95o8mdU/PURWSY6A
 rpjil+1aAIpdPzmM7/kobrIC0vD+vI4ih2Y/r2IWLNMFFdORM/eO5+lh+zvh/ALPoNSW
 XkEJ038TUVpBFOg9/cOIwoayhjERCTdPKUpyOiu0GAFrpsjpWkuphTDvCoTkQQqJY6i4
 jsv5LZnxaYgSRTo04CtYAVYA2bGQF8KwVqwZL/PMvbpXQ89hnIGESq0Yj4jLPrlTu8qr
 VW8w==
X-Gm-Message-State: AOJu0YzX//cSSCtbQnVjAadfzNoC6ZRhHcElsezEIp/D9yJX8E/bkSkc
 Ba0Kf/de9eervNOgw9hE+Za24e66kdWCkVrGcVNjM2/aNtpNGn7+epGIMNHhz79cazUPoEnxMEr
 jxNFBL2IVv1Qx1UrkilHsRZ2qgUs=
X-Gm-Gg: ASbGncv3SvtEmxJASAFfv7mbd57q5ISrJy7v/hygnrJ6agOyKFD/n8xnZaNLVQvcGCo
 DHxyJRPWtUrys8z4+Pm3yKlZ7K4se+Pqw2sMabfh/HI4M4zfvLUohxot0IZFFGf+45I2Q8bgVXy
 jVpRcG5cRrhNqqnyM1q6/6oTIoTZ99rAS2
X-Google-Smtp-Source: AGHT+IHHSBqChb3Lznl0UatChaBd8v7FxTCxLWEZIEuHx/MN3ob+MXXDNWGPLfDhJvDf0mOSv2XP7FVo6oIoR5Dy37s=
X-Received: by 2002:a05:6402:210a:b0:5ed:4591:6901 with SMTP id
 4fb4d7f45d1cf-5f4b71fd47dmr2831558a12.8.1744831685461; Wed, 16 Apr 2025
 12:28:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250416161929.2846102-1-yuri.nesterov@gmail.com>
 <Z__jtQe0nYsaGnoH@redhat.com>
In-Reply-To: <Z__jtQe0nYsaGnoH@redhat.com>
From: Yuri Nesterov <yuri.nesterov@gmail.com>
Date: Wed, 16 Apr 2025 22:27:54 +0300
X-Gm-Features: ATxdqUHjYMeN10aMV_bnGmnyPErcbaequ5p7x86N5jNPCQKNh7waSg288fKrrlI
Message-ID: <CAB_o470VGNmj_4LKvo3-Y6O7LiKiJ4QXczt6ZqRua_mpM1LN2A@mail.gmail.com>
Subject: Re: [PATCH] usb-host: enable autoscan for bus+addr to survive host
 suspend/resume
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=yuri.nesterov@gmail.com; helo=mail-ed1-x52f.google.com
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

On Wed, Apr 16, 2025 at 8:07=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Wed, Apr 16, 2025 at 07:19:29PM +0300, Yuri Nesterov wrote:
> > Currently, there is a special case for usb-host devices added using the
> > hostbus=3D and hostaddr=3D properties to avoid adding them to the hotpl=
ug
> > watchlist, since the address changes every time the device is plugged
> > in. However, on Linux, when the host system goes into suspend and then
> > resumes, those devices stop working in both the guest and the host.
> >
> > Enabling autoscan and adding those devices to the watchlist allows them
> > to keep working in the guest after host suspend/resume.
>
> So IIUC what you're saying is that on suspend the host device
> is removed by the kernel, and on resume, the USB device is
> recreated. So QEMU's open file handle for the USB device is
> invalid after resume.
>
> If the /dev/bus/usb/NNN/NNN file goes away and then gets
> re-created by the kernel though, we can't assume QEMU is
> going to be able to re-open the new /dev/bus/usb device
> file though.

I'm not sure if the file actually goes away. It looks like the internal
state of the device changes and QEMU receives a "no device"
response in usb_host_req_complete_data. However, the file
remains in place. At least I don't see any changes in udevadm
monitor or inotifywait aside from attribute modifications.

After resuming from suspend, the device doesn't work on either
host or guest. Probably the device stays with a detached kernel
driver since QEMU can't reattach it after receiving the "no device"
error. Adding such devices to the hotplug watchlist causes QEMU
to reopen them the same way it does for devices specified by
vendorid and productid or hostport.

The reason bus+addr devices aren't currently added to that list is well
explained in commit e058fa2dd599ccc780d334558be9c1d155222b80.
A special case was made because the device address changes every
time it's replugged. However, it turns out that it doesn't change after
a suspend/resume cycle so adding them to the list allows them to
keep working after resume.

I haven't had a chance to test it with libvirt though.

> When QEMU runs under libvirt, QEMU won't have any access
> to the /dev/bus/usb device node unless libvirt has set the
> right permissions and (where appropriate) also set the
> SELinux label.
>
> The current autoscan logic seems rather crude. AFAIK every 2
> seconds it will re-scan every host USB device to see if any
> has gone away and close it, and/or re-open if re-appeared.
>
> If we enable this autoscan logic, then under libvirt, AFAICS,
> QEMU is going to fail to re-open the device, and a counter in
> the autoscan logic means that after 3 attempts to re-open QEMU
> will stop attempting it at all...but strangely it appears QEMU
> will keep the timer running, so every 2 seconds it will iterate
> over every USB device, but never try to open any of them.
>
> Regardless of your current patch this autoscan logic feels like
> it needs improvement. We shouldn't need to busy-poll to see that
> a USB device goes away, it should be possible to rely on event
> notifications in some way.
>
> Even then we'd still need a way to prevent this immediate auto
> re-opening when under libvirt. Libvirt would have to detect the
> reappearance of the device and perform relabelling and permissions
> changes, before QEMU is able to be told to try to re-open.
> Potentially this implies a new QMP command to tell QEMU to try
> to re-open, unless perhaps QEMU can be triggered off an inotify
> event for the permissions/label change of the device node.
>
> >
> > Signed-off-by: Yuri Nesterov <yuri.nesterov@gmail.com>
> > ---
> >  hw/usb/host-libusb.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
> > index c3d642c9d3..32c0251471 100644
> > --- a/hw/usb/host-libusb.c
> > +++ b/hw/usb/host-libusb.c
> > @@ -1227,7 +1227,7 @@ static void usb_host_realize(USBDevice *udev, Err=
or **errp)
> >          !s->match.vendor_id &&
> >          !s->match.product_id &&
> >          !s->match.port) {
> > -        s->needs_autoscan =3D false;
> > +        s->needs_autoscan =3D true;
> >          ldev =3D usb_host_find_ref(s->match.bus_num,
> >                                   s->match.addr);
> >          if (!ldev) {
> > @@ -1244,6 +1244,9 @@ static void usb_host_realize(USBDevice *udev, Err=
or **errp)
> >          }
> >      } else {
> >          s->needs_autoscan =3D true;
> > +    }
> > +
> > +    if (s->needs_autoscan) {
> >          QTAILQ_INSERT_TAIL(&hostdevs, s, next);
> >          usb_host_auto_check(NULL);
> >      }
> > --
> > 2.43.0
> >
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>

