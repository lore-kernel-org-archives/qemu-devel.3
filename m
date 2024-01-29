Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291FBC47DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 19:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUXUC-00031G-GJ; Mon, 29 Jan 2024 14:40:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rUXUA-00030k-DQ
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 14:40:02 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rUXU8-0005cz-FU
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 14:40:02 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6ddf26eba3cso2025152a34.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 11:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706557198; x=1707161998; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zEICr1QmXRFmGfhgJTC8MTvyADukMO2VuiYXvG5FET8=;
 b=Pi70bAlAdbw0tt5wJFjMWB5+gH3e9INbwkUZ8RDtK5HFIGID0B/vaP1lqMV4AAPanK
 C8M2zDNzYhJvqDzqdvppz7s3HoCDlbWWA7iaOJGWIIm9ctYRHVrbMY1DyU6YtBHKtwju
 zXMmXxi3l/KSy6BdWvbxyHc/hvZzTmWa1wdbRAKxfHlCbt+yd8GQ2bVdrV1iNryKdNZ9
 7K1l+rOP3QwrifS75XEhaTyXjMlhnQNXVoIjlcujh70nrfBJTklTfwZ0r73LmniFx6P/
 RUAwpwj5FVvzTmEVJVHq/cTyFSK/rgrViUeGKTPtbApbAJgPQH3kkyR81MjRQg/hvisZ
 ZCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706557198; x=1707161998;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zEICr1QmXRFmGfhgJTC8MTvyADukMO2VuiYXvG5FET8=;
 b=vBrsccLTlffALFlf5cxqXIdVsOBj2PnMehpd7z9tshbjYVzNzUunlyFPb8AAT/x9e5
 Ah8lYx9cr083+TYlPGCImWgYPkD9zMJZB/8nHB3zWpWpNLu0tdiQW5clNMQFPM2apx+V
 6C00niiKpS+MlVIfUm5CbmdKRr9Ib5oHVJJs6/ZsIOs9JdLH7auR2uz1au1vlRSkJh5N
 0Bx0fCVrPyGTNky7nSEW6n9nffmpvrp/0M5f2w+MMVNzgkQzNnJszSrSUCo6kAAI+oIq
 HNvzR2t5OC0aBLQoEAUesOhLBYZqflQMfkxB5x38yRXLhN+COTApvhX+sTeLkxCMiI2P
 HnOw==
X-Gm-Message-State: AOJu0YwnG7FNs65Wr4V3Zi8tJCC9N6EqW/XyJRemT/lpUStFLBqUVdT4
 4tVunmPkOspHxZXdaDUkFunqGh/BIrfgmUfJpenmiZJtf05AIdHIgnr0asmm7ZXUyHVe0osD5ll
 d+2/CQPU7sypSpGi/EF7iD4KXNrA=
X-Google-Smtp-Source: AGHT+IGrqlz3fxhPT8BNhS56XLZfowmZNWfb6WVzUXdMMpDIIupZxON6sLvwqAbUGsBHFsIUXDgnRRjBZyFAaFLq7Yo=
X-Received: by 2002:a05:6870:4341:b0:218:6ff5:a190 with SMTP id
 x1-20020a056870434100b002186ff5a190mr4369413oah.39.1706557198088; Mon, 29 Jan
 2024 11:39:58 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QX9TQ-=PD7apOamXvGW29VwJPfVNN2X5BsFLFoP2g6USg@mail.gmail.com>
 <CAJaqyWdMNP3V=JL6C8SSbXV5AP_2O9SNJLUS+Go7AjVsrT1FdQ@mail.gmail.com>
In-Reply-To: <CAJaqyWdMNP3V=JL6C8SSbXV5AP_2O9SNJLUS+Go7AjVsrT1FdQ@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 29 Jan 2024 14:39:45 -0500
Message-ID: <CAJSP0QXMJiRQFJh6383tnCOXyLwAbBYM7ff-mtregO3MKAEC1A@mail.gmail.com>
Subject: Re: Call for GSoC/Outreachy internship project ideas
To: Eugenio Perez Martin <eperezma@redhat.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=stefanha@gmail.com; helo=mail-ot1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, 29 Jan 2024 at 13:53, Eugenio Perez Martin <eperezma@redhat.com> wr=
ote:
>
> On Mon, Jan 15, 2024 at 5:33=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.c=
om> wrote:
> >
> > Dear QEMU and KVM communities,
> > QEMU will apply for the Google Summer of Code and Outreachy internship
> > programs again this year. Regular contributors can submit project
> > ideas that they'd like to mentor by replying to this email before
> > January 30th.
> >
>
>
> =3D=3D=3D Add packed virtqueue to Shadow Virtqueue =3D=3D=3D

Yes! I'm a fan of packed virtqueues, so I'm excited to see this project ide=
a :).

> Summary: Add the packed virtqueue format support to QEMU's Shadow Virtque=
ue.
>
> To perform a virtual machine live migration with an external device to
> qemu, qemu needs a way to know which memory the device modifies so it
> is able to resend it. Otherwise the guest would resume with invalid /
> outdated memory in the destination.
>
> This is especially hard with passthrough hardware devices, as
> transports like PCI imposes a few security and performance challenges.
> As a method to overcome this for virtio devices, qemu can offer an
> emulated virtqueue to the device, called Shadow Virtqueue (SVQ),
> instead of allowing the device to communicate directly with the guest.
> SVQ will then forward the writes to the guest, being the effective
> writer in the guest memory and knowing when a portion of it needs to
> be resent.
>
> Compared with original Split Virtqueues, already supported by Shadow
> Virtqueue, Packed virtqueue is a more compact representation that uses
> less memory size and allows both devices and drivers to exchange the
> same amount of information with less memory operations.
>
> The task is to complete the packed virtqueue support for SVQ, using
> the kernel virtio ring driver as a reference. There is already a setup
> that can be used to test the changes.
>
> Links:
> * https://www.redhat.com/en/blog/virtio-devices-and-drivers-overview-head=
jack-and-phone
> * https://www.redhat.com/en/blog/virtqueues-and-virtio-ring-how-data-trav=
els
> * https://www.redhat.com/en/blog/packed-virtqueue-how-reduce-overhead-vir=
tio
> * https://www.youtube.com/watch?v=3Dx9ARoNVzS04
>
> Details:
> * Skill level: Intermediate
> * Language: C

I have added this project idea to the wiki. I made minor edits (e.g.
consistently using "guest" instead of both "virtual machine" and
"guest" to minimize the amount of terminology). I also added a link to
the vhost-shadow-virtqueue.c source code so applicants have a starting
point for researching the code.

https://wiki.qemu.org/Internships/ProjectIdeas/PackedShadowVirtqueue

Please edit the page to clarify the following:
- Project size: 90 (small), 175 (medium), or 350 (large) hours
- A list of suggested tasks for the coding period that applicants can
research and refine for their project plan

Possible stretch goals if the intern completes packed svq support
early or maybe you have your own ideas:
- Split/rename vhost-shadow-virtqueue.c into a VIRTIO driver-side
virtqueue API (which could be used by any other feature that acts as a
VIRTIO driver, like vhost-user clients) and shadow virtqueue logic
- Implement packed virtqueue support in other components where it is
not yet supported (like kernel vhost)

Stefan

