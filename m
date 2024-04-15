Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 402F8C00A94
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 10:52:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwJwD-0005Er-NE; Mon, 15 Apr 2024 06:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rwJwC-0005Eh-Jw
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 06:51:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rwJwA-000388-Nt
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 06:51:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713178305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Vb5Z8IaKIcGxjdavaFjlYXpK/HtQXD7d8zT72u2jVM=;
 b=ItQVuMFofdQm+QvIBBWaRqs11Gze7By+dyUhS1k9HALY/viduFhMPdlBGgU//wAQGLW3lt
 lAXqYCcLSUJ2S5DdaMe4gpwu32r65m7I9AgDwaouO+6Mdhe+voC5CLK6o1ibq63krPSSjG
 SjST7RTcl8MakSo96+iuIiB+Ab1YDw4=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-UTRbOOuhMJSRXc8HkDySqg-1; Mon, 15 Apr 2024 06:51:44 -0400
X-MC-Unique: UTRbOOuhMJSRXc8HkDySqg-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-dccc49ef73eso4370800276.2
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 03:51:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713178303; x=1713783103;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Vb5Z8IaKIcGxjdavaFjlYXpK/HtQXD7d8zT72u2jVM=;
 b=v9AZjfxzW0O4CRqTRd5zldFW5rXCqMDoEF2X/ovVSNck1wm+ayloLdQrefqVU6Miu6
 Hrvt9Vp751w36RB0z8jpx6TQRUKXcjfvuWAKIfV9Agz8VHPnwDW/Zj1jifJPO0JsNDUz
 ILUiKIT1BD8KN9rB0TATHseJxyZzwJVuTivJaTStzFJZKOF4R3Sd/OdOI6L4+S0tWksI
 FSVtwJaG3kYfHwOa0pyM2j4kkQVGGS9nf4PiW0YgKnkSi+am0FqY2VXt3HSw3zXItzRU
 kht5aR/x0rZgGT+ntKBGneda0/IyPrhCJ1ix6FzXJdIyze24TFKZ20xOqSXtyDnaWMkU
 AbEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlk23BwZ2sGtPh0es0d8URu0Zu/aCkTrXWEMYe+7oTNd2alwWq5mL0apuhqH7UTEYW0FocyTklUO1SUxG4nQGIXAplmQU=
X-Gm-Message-State: AOJu0YwWqPWZtBhNE+cmBZdFDCIORbn6w2Foln+/11xmYQVcjS+HrJq1
 yyLwhmelk9mzZ+MyeacpHlZM691P8H5VEULggbX79lab259n4Mk8hHJ5hj+Fo51/+BhdfQNQBom
 Y3LZDJOIY+F1RhaH7XQ8kRBYKfinNEnUJL5/4YWdVePQEpTl5/kIY7OEyTktTVZ+l/x7Ckjabbp
 dhWf5cPWxV2LbPsQhp68NSC+Dzroo=
X-Received: by 2002:a25:dc92:0:b0:dc2:2041:fc49 with SMTP id
 y140-20020a25dc92000000b00dc22041fc49mr9066430ybe.5.1713178303673; 
 Mon, 15 Apr 2024 03:51:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6KnIB5YiwH7CuaPq/+ry0D3a10aWEBPHNewBP9S4d5Mw4Bo8Il7WORXS+FMEFKdYTS9qRZb28J+1qtPIC+5k=
X-Received: by 2002:a25:dc92:0:b0:dc2:2041:fc49 with SMTP id
 y140-20020a25dc92000000b00dc22041fc49mr9066424ybe.5.1713178303429; Mon, 15
 Apr 2024 03:51:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAJaqyWcL7DRSj7bPK=MfAZoTw-GgZCKr4on3U0Q8jmRd2OZSPg@mail.gmail.com>
 <20240414044353-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240414044353-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 15 Apr 2024 12:51:07 +0200
Message-ID: <CAJaqyWfgSYXn4UXxnzKRquJZegKuY0n9USd0TfO0k2t+jTME5A@mail.gmail.com>
Subject: Re: Discrepancy between mmap call on DPDK/libvduse and rust vm-memory
 crate
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, German Maglione <gmaglione@redhat.com>, 
 Hanna Czenczek <hczenczek@redhat.com>, Xie Yongji <xieyongji@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.127,
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

On Sun, Apr 14, 2024 at 11:02=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Fri, Apr 12, 2024 at 12:15:40PM +0200, Eugenio Perez Martin wrote:
> > Hi!
> >
> > I'm building a bridge to expose vhost-user devices through VDUSE. The
> > code is still immature but I'm able to forward packets using
> > dpdk-l2fwd through VDUSE to VM. I'm now developing exposing virtiofsd,
> > but I've hit an error I'd like to discuss.
> >
> > VDUSE devices can get all the memory regions the driver is using by
> > VDUSE_IOTLB_GET_FD ioctl. It returns a file descriptor with a memory
> > region associated that can be mapped with mmap, and an information
> > entry about the map it contains:
> > * Start and end addresses from the driver POV
> > * Offset within the mmaped region of these start and end
> > * Device permissions over that region.
> >
> > [start=3D0xc3000][last=3D0xe7fff][offset=3D0xc3000][perm=3D1]
> >
> > Now when I try to map it, it is impossible for the userspace device to
> > call mmap with any offset different than 0.
>
> How exactly did you allocate memory? hugetlbfs?
>

Yes, that was definitely the cause, thank you very much!

> > So the "straightforward"
> > mmap with size =3D entry.last-entry.start and offset =3D entry.offset d=
oes
> > not work. I don't know if this is a limitation of Linux or VDUSE.
> >
> > Checking QEMU's
> > subprojects/libvduse/libvduse.c:vduse_iova_add_region() I see it
> > handles the offset by adding it up to the size, instead of using it
> > directly as a parameter in the mmap:
> >
> > void *mmap_addr =3D mmap(0, size + offset, prot, MAP_SHARED, fd, 0);
>
>
> CC Xie Yongji who wrote this code, too.
>

Thanks!

>
> > I can replicate it on the bridge for sure.
> >
> > Now I send the VhostUserMemoryRegion to the vhost-user application.
> > The struct has these members:
> > struct VhostUserMemoryRegion {
> >     uint64_t guest_phys_addr;
> >     uint64_t memory_size;
> >     uint64_t userspace_addr;
> >     uint64_t mmap_offset;
> > };
> >
> > So I can send the offset to the vhost-user device. I can check that
> > dpdk-l2fwd uses the same trick of adding offset to the size of the
> > mapping region [1], at
> > lib/vhost/vhost_user.c:vhost_user_mmap_region():
> >
> > mmap_size =3D region->size + mmap_offset;
> > mmap_addr =3D mmap(NULL, mmap_size, PROT_READ | PROT_WRITE,
> >             MAP_SHARED | populate, region->fd, 0);
> >
> > So mmap is called with offset =3D=3D 0 and everybody is happy.
> >
> > Now I'm moving to virtiofsd, and vm-memory crate in particular. And it
> > performs the mmap without the size +=3D offset trick, at
> > MmapRegionBuilder<B>:build() [2].
> >
> > I can try to apply the offset + size trick in my bridge but I don't
> > think it is the right solution. At first glance, the right solution is
> > to mmap with the offset as vm-memory crate do. But having libvduse and
> > DPDK apply the same trick sounds to me like it is a known limitation /
> > workaround I don't know about. What is the history of this? Can VDUSE
> > problem (if any) be solved? Am I missing something?
> >
> > Thanks!
> >
> > [1] https://github.com/DPDK/dpdk/blob/e2e546ab5bf5e024986ccb5310ab43982=
f3bb40c/lib/vhost/vhost_user.c#L1305
> > [2] https://github.com/rust-vmm/vm-memory/blob/main/src/mmap_unix.rs#L1=
28
>


