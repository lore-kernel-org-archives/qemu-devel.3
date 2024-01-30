Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498CFC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 12:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUmvw-00054B-JL; Tue, 30 Jan 2024 07:09:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rUmvu-000541-G3
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 07:09:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rUmvs-0004ZN-NO
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 07:09:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706616579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=weD+the6P/YGsb581YptEdJXrN2BVcNlkR6AsE3kIes=;
 b=LYg5pMhj4sOWso1KwKwDcC4JPza8Vx719yY5/hckXAqVK8IN1o2Mj5vNLLBbXxcNgpsw3H
 ah/wfZX+EqMq1HTmHIsIbihjVuKkZ8biDkgA77O6QcgV5O1lnTWUZJ6r0s9xi00merojPA
 Nhstoj52ZqBU86bs2tYclqdTp2SUKd4=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-J54haIwhNLW7AL19fTqUAw-1; Tue, 30 Jan 2024 07:09:38 -0500
X-MC-Unique: J54haIwhNLW7AL19fTqUAw-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-5ffac5f7afeso70546087b3.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 04:09:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706616575; x=1707221375;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=weD+the6P/YGsb581YptEdJXrN2BVcNlkR6AsE3kIes=;
 b=h/q1z2ZIluShoSqMBq9msK9cjXKjb0qup3HxyDrS2xEk2wqf+B1wF8dJnq2HcwaBqf
 VDN0Eyo/Wnp0iDv1//D50/NQ0Y8nMkPVBjzNGNP26Y1YayUfidHeyBfT3yDIohp4KLVJ
 olgYFRspdO/Calyehfa5BwKGfHdAIsFAM3LFM3R+yAKwhBE5MBKmQjfSRg4tHWyGIGv+
 bGq5r6kJAdR6Q/wZ2+/Thbx+Qx2S9mCLcrrMJ1mCrUmvG/UW13dMQp8CWu38Xk5ccx3p
 FxYtdGOCSdRTK/Ws/v5VbFkryuHS1ctIvxMB26v1QE4Cfo7EkIbeObLsny5TOZ8wTCuf
 ep/A==
X-Gm-Message-State: AOJu0YwVNmiVMYovxO7o4g2HJpqR7bTUcwDoHWwFBrPuBTayioOwziOJ
 ZzjcvHH72zqWFPKTez4otBKPSQBWvcQuP8TezbF1CiqJoRLR5NecMnpQ+vXwc4D12vIWsN/3xWT
 f+IzldsLOpy6YL5SKnrkx5yxazUrzmv1MLiZRvN9rKvGZ4noLF3hXf22asnHozLrAt5xXsZoksl
 LgWNXk+gPXMF6Wzub1wlgBEIHO83c=
X-Received: by 2002:a05:690c:448c:b0:5ff:af99:54f2 with SMTP id
 gr12-20020a05690c448c00b005ffaf9954f2mr7002651ywb.50.1706616575486; 
 Tue, 30 Jan 2024 04:09:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuvm/Fsb++wzRmvzrvL6YuxtDMI6YLt0w48tsCmlNHGEpn9QBEzXOXTK4aWDJa2FGczp87hgJ+53pkUnS7SN0=
X-Received: by 2002:a05:690c:448c:b0:5ff:af99:54f2 with SMTP id
 gr12-20020a05690c448c00b005ffaf9954f2mr7002633ywb.50.1706616575171; Tue, 30
 Jan 2024 04:09:35 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QX9TQ-=PD7apOamXvGW29VwJPfVNN2X5BsFLFoP2g6USg@mail.gmail.com>
 <CAJaqyWdMNP3V=JL6C8SSbXV5AP_2O9SNJLUS+Go7AjVsrT1FdQ@mail.gmail.com>
 <CAJSP0QXMJiRQFJh6383tnCOXyLwAbBYM7ff-mtregO3MKAEC1A@mail.gmail.com>
In-Reply-To: <CAJSP0QXMJiRQFJh6383tnCOXyLwAbBYM7ff-mtregO3MKAEC1A@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 30 Jan 2024 13:08:59 +0100
Message-ID: <CAJaqyWeKrjjMyRXo1LK4_2Q=HYKqd=omjDJ+by_=do9ppdCk3w@mail.gmail.com>
Subject: Re: Call for GSoC/Outreachy internship project ideas
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, 
 Alberto Faria <afaria@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 German Maglione <gmaglione@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "Richard W.M. Jones" <rjones@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, Song Gao <gaosong@loongson.cn>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Bernhard Beschow <shentey@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Sean Christopherson <seanjc@google.com>,
 Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Jan 29, 2024 at 8:40=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.com=
> wrote:
>
> On Mon, 29 Jan 2024 at 13:53, Eugenio Perez Martin <eperezma@redhat.com> =
wrote:
> >
> > On Mon, Jan 15, 2024 at 5:33=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail=
.com> wrote:
> > >
> > > Dear QEMU and KVM communities,
> > > QEMU will apply for the Google Summer of Code and Outreachy internshi=
p
> > > programs again this year. Regular contributors can submit project
> > > ideas that they'd like to mentor by replying to this email before
> > > January 30th.
> > >
> >
> >
> > =3D=3D=3D Add packed virtqueue to Shadow Virtqueue =3D=3D=3D
>
> Yes! I'm a fan of packed virtqueues, so I'm excited to see this project i=
dea :).
>

It's about time! :).


> > Summary: Add the packed virtqueue format support to QEMU's Shadow Virtq=
ueue.
> >
> > To perform a virtual machine live migration with an external device to
> > qemu, qemu needs a way to know which memory the device modifies so it
> > is able to resend it. Otherwise the guest would resume with invalid /
> > outdated memory in the destination.
> >
> > This is especially hard with passthrough hardware devices, as
> > transports like PCI imposes a few security and performance challenges.
> > As a method to overcome this for virtio devices, qemu can offer an
> > emulated virtqueue to the device, called Shadow Virtqueue (SVQ),
> > instead of allowing the device to communicate directly with the guest.
> > SVQ will then forward the writes to the guest, being the effective
> > writer in the guest memory and knowing when a portion of it needs to
> > be resent.
> >
> > Compared with original Split Virtqueues, already supported by Shadow
> > Virtqueue, Packed virtqueue is a more compact representation that uses
> > less memory size and allows both devices and drivers to exchange the
> > same amount of information with less memory operations.
> >
> > The task is to complete the packed virtqueue support for SVQ, using
> > the kernel virtio ring driver as a reference. There is already a setup
> > that can be used to test the changes.
> >
> > Links:
> > * https://www.redhat.com/en/blog/virtio-devices-and-drivers-overview-he=
adjack-and-phone
> > * https://www.redhat.com/en/blog/virtqueues-and-virtio-ring-how-data-tr=
avels
> > * https://www.redhat.com/en/blog/packed-virtqueue-how-reduce-overhead-v=
irtio
> > * https://www.youtube.com/watch?v=3Dx9ARoNVzS04
> >
> > Details:
> > * Skill level: Intermediate
> > * Language: C
>
> I have added this project idea to the wiki. I made minor edits (e.g.
> consistently using "guest" instead of both "virtual machine" and
> "guest" to minimize the amount of terminology). I also added a link to
> the vhost-shadow-virtqueue.c source code so applicants have a starting
> point for researching the code.
>
> https://wiki.qemu.org/Internships/ProjectIdeas/PackedShadowVirtqueue
>

Good points, thank you very much!

> Please edit the page to clarify the following:
> - Project size: 90 (small), 175 (medium), or 350 (large) hours
> - A list of suggested tasks for the coding period that applicants can
> research and refine for their project plan
>
> Possible stretch goals if the intern completes packed svq support
> early or maybe you have your own ideas:
> - Split/rename vhost-shadow-virtqueue.c into a VIRTIO driver-side
> virtqueue API (which could be used by any other feature that acts as a
> VIRTIO driver, like vhost-user clients) and shadow virtqueue logic
> - Implement packed virtqueue support in other components where it is
> not yet supported (like kernel vhost)
>

Added, good ideas! Please let me know if you think something should be
further corrected or feel free to modify yourself.

Thanks!


