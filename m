Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FECFCCF9FE
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 13:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEor5-00074G-9T; Fri, 31 Oct 2025 09:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vEor0-00073U-GL
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 09:07:43 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vEoqq-0002TR-HS
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 09:07:42 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b6d53684cfdso474971066b.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 06:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1761916045; x=1762520845; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dCh79gukQOj5RawR5z60tm9X3ZETwqBDGTH06NjDPpc=;
 b=gduWDuyw1rM5U807KYNeNnHD9nRaWCUqfzys1aXtB0ME55ScL0/6CypeIRvlSzqLmf
 Y29A+eHNxG5N3h17Ft0Mjx7LJFPZYjPeP87YNkaA7t+msH5Ac02bqHDE239GJrewZiDQ
 wX1L6BTKr3Ype8VxeuI29bosruBYzW0u5Vy2XnWjrs4Lkfe/o2/vuldzh53wbYYtGojK
 GiubJ8zwO+hwWvuKTIpNh/+wwdkAHRziO5vrgS9WEQbw9KgOqt8GorOHS+UBUGX+y1iQ
 ukyFU7vsawQqizLwxw2TKrhLR9C+uWC6zkciDS892mWMa4OwD0SfimU11OKbvjuJOMuS
 OS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761916045; x=1762520845;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dCh79gukQOj5RawR5z60tm9X3ZETwqBDGTH06NjDPpc=;
 b=Yam6soxClrBXkTwHQh3WS8AtcsamJsnFZP5w0DEMNHs8QwfPueBOyDOxJtyQwekqMz
 4F15tpIkFsRdytJZrDKbMB+kkUmuZomAfiVu1kuviq7+HPROJnIkZSoA9RR1llmSgrzd
 ksrluRD08kIs/zxsRtigDAYqRkLTsDCDmiHKKocEPQleWmtQFrIQZo+eF0T5YL+lm+f2
 q++QF2o0d7ZNzZDZuRoFjCUocbKlbBf6MIuXGJ+U8zr8KFKIG3f48ZZHSZVIoGeZgCjh
 z0xgPZIPIBzWCGaQorrU/ubzSZG4YvWF3fJZhSMxjgNUA5fjIfd+Tou1sAiYwlApbktc
 3P0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCURRjRSHzdj9QWKXjTZb/J/QyUJYE6ZuJ5yX5dfqhXY3UR1jhUBsgqa/KiWXMkYhVNKh93lmZnAaki9@nongnu.org
X-Gm-Message-State: AOJu0YzTyH0SBnwUhtzOv8pEFACaDu/PRtm4QIVuGUZkmbUdOizpcMnB
 zqlq4XOt2IIxDNgOmKaM5CoGbvSfTZBDRJtZWR8PXWdFaQK/aYh3MW7b/ZkNfqLeSAFO9Doop4h
 pWU5ULNt+opTV6tg14Z3fTsvWK1jk+tvKeWqYcLIv
X-Gm-Gg: ASbGncuyWpnUzLqzbTLdZIqRGD/LVY6IvWTGFNtGeR4sD9xAQLXuxenpjEcJo6ik4Vr
 6Y89YRetq2tMydzxecmn0e32w5gHxMluG3qfVQq5bt8gp2hOep8CY7mLDpXOcIUtOc73Huu63u+
 0oZriJQpqu/D0B0oDK9/8GXy44OEokULaSMeqyG02xsJPfwdUonJqRmJL5E9bdGj+M/5B34PoxP
 cU1yQSIABbDuA2DxZ+E03OJyaVwlPQyds7A+nzjZ8xvYuCezVqidtB6yZXulPM/VzMoKk6hY9Vi
 S+cSJTGfc8K5bj4oyokWdF3CV26GEQ==
X-Google-Smtp-Source: AGHT+IFWeaGGKjNyVH/BIjzguiwl4drLKgpyayOm+SFOaEbVwM0GxZ/A5eh5jr0EVf5PjrbPCZt3pnHalAuvr7L/0RU=
X-Received: by 2002:a17:907:d7cb:b0:b3b:9832:f9b with SMTP id
 a640c23a62f3a-b7070191794mr348883466b.25.1761916045333; Fri, 31 Oct 2025
 06:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250903075721.77623-1-chigot@adacore.com>
 <20250903075721.77623-6-chigot@adacore.com>
 <aPqCJRNCjxcZ6jq5@redhat.com> <87ms5g3dnq.fsf@pond.sub.org>
 <CAJ307EjFXNyEwDTeXEwdc02PxBLHGENbPJCM+-v_6FRQ2VYEcw@mail.gmail.com>
 <87ms5cmtqh.fsf@pond.sub.org>
 <CAJ307EhFGHrTYcVJZghCNgGFmXZf1vTNg2E=7AA41jFvRqtGcg@mail.gmail.com>
 <877bwbcy3e.fsf@pond.sub.org>
 <CAJ307EiBBKDiLAX=CCx3d9n6PQQ5JnBv8RCWZpQqartVzWcBKg@mail.gmail.com>
 <aQSkCSjgyoDRZCB6@redhat.com>
In-Reply-To: <aQSkCSjgyoDRZCB6@redhat.com>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Fri, 31 Oct 2025 14:07:14 +0100
X-Gm-Features: AWmQ_bmobTz6cyswuh6wexO3kamzXl14GHRgR-cMijhtz3Yj66GsSOqQGHAvNZg
Message-ID: <CAJ307EgK9sqa6TNHRWo9uOkB=UXtu6CU+Zsaa_T6wcQjaUPngg@mail.gmail.com>
Subject: Re: [PATCH 5/5] vvfat: add support for "size" options
To: Kevin Wolf <kwolf@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 hreitz@redhat.com, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=chigot@adacore.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Fri, Oct 31, 2025 at 12:57=E2=80=AFPM Kevin Wolf <kwolf@redhat.com> wrot=
e:
>
> Am 31.10.2025 um 10:47 hat Cl=C3=A9ment Chigot geschrieben:
> > > > I was unable to make `vvfat.c` recognize the "size" argument passed
> > > > along `format=3Draw`, even if hardcoding the value in `vvfat.c` did=
 make
> > > > a difference. And that's why I'm adding the warning in the commit
> > > > message.
> > >
> > > This one:
> > >
> > >     Some limitations remains, the size parameter is recognized only w=
hen
> > >     "format=3Dvvfat" is passed. In particular, "format=3Draw,size=3Dx=
xx" is
> > >     keeping the previously hardcoded value: 504MB for FAT16 and 32 MB=
 for
> > >     FAT12. FAT32 has not been adjusted and thus still default to 504M=
B.
>
> I actually wonder if we should give the vvfat option a different name to
> make it less error prone. Forgetting format=3Dvvfat is easy and then raw
> will be autodetected and size will be interpreted as an option for raw.

We can clearly name it "fat-size".

> > > > I've also realized that following my patch, the mismatch in between
> > > > the disk and the partition in Linux was going away when using `-dri=
ve
> > > > format=3Dvvfat,size=3Dxxx`. Making it not just QNX-oriented.
> > > >   | (host) $ qemu-system-aarch64 -M raspi4b -kernel raspi4b-kernel
> > > > -nographic -no-reboot -append "earlycon=3Dpl011,mmio32,0xfe201000
> > > > console=3DttyAMA0 noreboot" -dtb bcm2711-rpi-4-b.dtb -initrd
> > > > rootfs.cpio.gz  -drive
> > > > id=3Dsdcard,file=3Dfat:rw:<host_folder>,format=3Dvvfat,if=3Dsd,size=
=3D256M
> > > >   | (QEMU) # fdisk -l /dev/mmcblk1
> > > >   | Disk /dev/mmcblk1: 256 MB, 268435456 bytes, 524288 sectors
> > > >   | 1024 cylinders, 16 heads, 32 sectors/track
> > > >   | Units: sectors of 1 * 512 =3D 512 bytes
> > > >   |
> > > >   | Device       Boot StartCHS    EndCHS        StartLBA     EndLBA
> > > > Sectors  Size Id Type
> > > >   | /dev/mmcblk1p1 *  0,1,32      1023,15,32          63     524287
> > > >  524225  255M  6 FAT16
> > >
> > > EndLBA matches disk size.  EndCHS still matches EndLBA.  Good.
> > >
> > > The difference to the command line you showed above is format=3Draw (=
bad)
> > > vs. format=3Dvvfat (good).
> > >
> > > With format=3Draw,size=3D256M you get that size, but a bogus partitio=
n
> > > table.
> > >
> > > With format=3Dvvfat,size=3D256M you get that size, and a sensible par=
tition
> > > table.
> > >
> > > Correct?
> >
> > Yes and the main reason for that is because I don't know how to
> > retrieve the size given to "raw" within `vvfat_open`.
> > My understanding is that raw-format.c is suppressing that option,
> > through `qemu_opts_del` in `raw_read_options`, before calling its
> > block childs (here vvfat). Hence, it assumes the default size 512M.
>
> The order is the other way around. You always get the protocol level
> openen first and only then the image format level.
>
> Imagine the simple case of a qcow2 image file used for the VM. You get
> things stacked like this:
>
>         virtio-blk
>             |
>             v
>           qcow2
>             |
>             v
>           file
>
> You need to open them from bottom to top. Opening a qcow2 image must be
> able to read from the file, so first the file layer must be opened. And
> obvious a virtio-blk device can only use the image after the qcow2
> layered has been opened.
>
> In your case, this is raw over vvfat. vvfat gets opened first, and then
> raw gets instantiated on top of it. (If you use format=3Dvvfat, then the
> raw layer is left away.)
>
> Top level options you give to -drive go to the topmost block driver. You
> should be able to still set it on the vvfat level with -drive
> format=3Draw,file.size=3D... Deciding which option goes to which node is
> part of the (rather complicated) bdrv_open() logic in block.c.
>
> What raw does when a size option is given is that it just truncates the
> lower level to the given size. So as vvfat doesn't know the size, it
> still creates a 504 MB image, but raw shows only the first part of it to
> the guest. This results not only in an invalid partition table, but also
> means that as soon as vvfat decides to put a cluster after your limited
> size, you'll see filesystem corruption in the guest.
>
> So your approach to deal with this in vvfat and create a smaller
> filesystem to start with does look right to me.

Ok thanks for the explanation. It's a bit counter-intuitive that
"size" does not propagate to lower levels, especially if it generates
wrong ones behind the scene. But IIUC, this would be a much more
complex patch (i.e. changing bdrv_open logic).

Hence, I'm fine keeping this series narrowed to "format=3Dvvfat".


> Kevin
>

