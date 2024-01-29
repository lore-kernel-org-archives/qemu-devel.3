Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3451CC47DDB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 18:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUWlW-0003hv-F9; Mon, 29 Jan 2024 13:53:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rUWlO-0003hM-HP
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 13:53:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rUWlL-0005yD-8m
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 13:53:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706554422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CNWB/ajDc7ZxXIARdz0w+/Ja27yu2wtNUORHpJEA5kU=;
 b=EfnrK5KyupQx0b/xK2u/NXjGVpeSnZEF0Pg9gKdbJEbRk4w7kh6kLTdK777fVAydIch6Yw
 oCwgGxSr6K0oWmTZUGi0k9S4HcI1b899gxed/ChHKoXjCUIlwPSHNauV816z7oEtR3NRGk
 2AX6yapLfTDkND7vlQtXv8ksTBiqZoc=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-pJ1Ea5wPO72TTqIJ_q7LeQ-1; Mon, 29 Jan 2024 13:53:40 -0500
X-MC-Unique: pJ1Ea5wPO72TTqIJ_q7LeQ-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-603cbb4f06dso27660047b3.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 10:53:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706554419; x=1707159219;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CNWB/ajDc7ZxXIARdz0w+/Ja27yu2wtNUORHpJEA5kU=;
 b=TloP4Lb1+dkAP3rNq8aGheTTlFk/vGbrPYUezfFJ96zY2ScPypRS104kvjPaSF+ys0
 I04bSoBvXKDgLftp5n3SwYPfzA+cSRWSQ+i3Yp9256bEbszXMsvRkY3VGc3CZSnQgVc9
 s6tUYXfrvcsQVALSLZaRLWPLEDayXK33fpdATg1cPDfsmnbYd53/a1HJDa1q9X/hN9Gp
 zFoIobNjilAW9C2ZdM4D+6tPXwX2ZSYh/n96xY7z+OEDwdGkZG01/J4XQDxC0fsIT2rP
 eC2TYT5MzqrfFd19X1rs2trfeD9OQn+I1Kg+Eq2RIlK4AJHzqbrD6jiZ2aWonOy3S17z
 H7Rg==
X-Gm-Message-State: AOJu0YySW2TgrVwyWzMm79O/vXGOjctaU4/nn0+sODR1Unv2kV3a/py4
 wArq/llUPrnVRWAxaA8cMLTOIwxGber6Ks4KvGKX/iNbAfw1kJovYQz2sv2MVKQJgqjdyczbnZI
 r7lFV3UcnbCy8ByxQ+Sy4ln/fWkCKCmbwPW5b6TRFuXynS/AJvfu00syyhroEK4V64nu+vJ39mU
 orMdm4F19EYVAgAzgcRS8/xM7Dtqo=
X-Received: by 2002:a0d:cb10:0:b0:5f8:9b55:98e6 with SMTP id
 n16-20020a0dcb10000000b005f89b5598e6mr5128326ywd.105.1706554419358; 
 Mon, 29 Jan 2024 10:53:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7RbUJu6LGvnDDP0G95gDqnmecPeCtTyTnmn3FAjoF8sMshgZEgFW3ejA/oSLugXuXfj3wFR52wT3NwVR/ylU=
X-Received: by 2002:a0d:cb10:0:b0:5f8:9b55:98e6 with SMTP id
 n16-20020a0dcb10000000b005f89b5598e6mr5128314ywd.105.1706554419122; Mon, 29
 Jan 2024 10:53:39 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QX9TQ-=PD7apOamXvGW29VwJPfVNN2X5BsFLFoP2g6USg@mail.gmail.com>
In-Reply-To: <CAJSP0QX9TQ-=PD7apOamXvGW29VwJPfVNN2X5BsFLFoP2g6USg@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 29 Jan 2024 19:53:02 +0100
Message-ID: <CAJaqyWdMNP3V=JL6C8SSbXV5AP_2O9SNJLUS+Go7AjVsrT1FdQ@mail.gmail.com>
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
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jan 15, 2024 at 5:33=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.com=
> wrote:
>
> Dear QEMU and KVM communities,
> QEMU will apply for the Google Summer of Code and Outreachy internship
> programs again this year. Regular contributors can submit project
> ideas that they'd like to mentor by replying to this email before
> January 30th.
>


=3D=3D=3D Add packed virtqueue to Shadow Virtqueue =3D=3D=3D
Summary: Add the packed virtqueue format support to QEMU's Shadow Virtqueue=
.

To perform a virtual machine live migration with an external device to
qemu, qemu needs a way to know which memory the device modifies so it
is able to resend it. Otherwise the guest would resume with invalid /
outdated memory in the destination.

This is especially hard with passthrough hardware devices, as
transports like PCI imposes a few security and performance challenges.
As a method to overcome this for virtio devices, qemu can offer an
emulated virtqueue to the device, called Shadow Virtqueue (SVQ),
instead of allowing the device to communicate directly with the guest.
SVQ will then forward the writes to the guest, being the effective
writer in the guest memory and knowing when a portion of it needs to
be resent.

Compared with original Split Virtqueues, already supported by Shadow
Virtqueue, Packed virtqueue is a more compact representation that uses
less memory size and allows both devices and drivers to exchange the
same amount of information with less memory operations.

The task is to complete the packed virtqueue support for SVQ, using
the kernel virtio ring driver as a reference. There is already a setup
that can be used to test the changes.

Links:
* https://www.redhat.com/en/blog/virtio-devices-and-drivers-overview-headja=
ck-and-phone
* https://www.redhat.com/en/blog/virtqueues-and-virtio-ring-how-data-travel=
s
* https://www.redhat.com/en/blog/packed-virtqueue-how-reduce-overhead-virti=
o
* https://www.youtube.com/watch?v=3Dx9ARoNVzS04

Details:
* Skill level: Intermediate
* Language: C


