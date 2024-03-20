Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783AFC6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 16:30:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmypV-0007kh-Vi; Wed, 20 Mar 2024 12:30:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rmypR-0007kT-S4
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:30:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rmypO-0006Kd-Sp
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:30:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710952210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yghPF/eNyveDIzWzZpBJ3uoxGXkclFbrrZ0YAsa1Bp0=;
 b=WPakRub+r7TX/afVTWLkF98sGmd2mx4a3zQAXDyNbLw+3QTxvyxFBpsMB2OGJhKKleAy53
 A57dJaLGabR7nzRPsbxFkqSpROwIC+a5O5cUI/+hCpb8SlEjVPoMutdXGa8nJ6KfINkfCT
 noi2L2gBUAaQsCswOq/goErstPVdFRI=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-BT12HsJcN8y1W0RrGIRVgw-1; Wed, 20 Mar 2024 12:30:07 -0400
X-MC-Unique: BT12HsJcN8y1W0RrGIRVgw-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-60a0b18e52dso888897b3.1
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 09:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710952207; x=1711557007;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yghPF/eNyveDIzWzZpBJ3uoxGXkclFbrrZ0YAsa1Bp0=;
 b=FLUdjKHM+VBzkxp+kTwdQj8C7iVqkAM7AlLPuvi3QNsU2X8OWKkiR4SS4k+v3fJ39w
 5004OPx/mwc6ml31KX8PpOaVABOPHIngj+WH8+f48a9xpD+4FvyCpK/uL+LTVV98W9at
 YugYzZMpPwj2iW/poo9Z9U/RVRBCWJxDB6Fe/dxEXR813d8hmNhConkcfCbqtzc3jJ9T
 x3xjDsR1+Cti2/EAlEnN3748QoLVPkFOqJYYuj2BiM1WqB9ZEDY+MHXAYol0WYSpHfp7
 COqbcsd9mwOWjpGBbDCHfUJxPe7Fi1FitBlMl0+bbCeNlowMAajqZSBM+azOnO1DUkrq
 lTWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAYdM34kc2u45c/Yi516LEk4n+G7sYbZ39qVc99G0HhfzK3ddYXKaoGsl0/7ry7t01QhxWGs5n1BSi3FKDsVRlekdESSo=
X-Gm-Message-State: AOJu0YyrUS/pBYcfUanfr/djuvgxhqtjfdmxO758fruWP13wJdzXx/HF
 imOpg9NBF+6jWInPe1e3DXTX0FZ+Cp6wEqa6bJZUMOJPyM+z/bad/4Q+i/HdGKdAojFeYD97Gvp
 gyKaZGcV1Tc12YxmckZPvvHB4Uqc2yMWo9bxNXrGovcGahUhX+WiMjbb0ljmDqZs7DPZyPnzBGl
 VjByfQtQcde0upWxR2YHokhDm37Tw=
X-Received: by 2002:a81:4f11:0:b0:610:f9dc:87d with SMTP id
 d17-20020a814f11000000b00610f9dc087dmr145449ywb.3.1710952206935; 
 Wed, 20 Mar 2024 09:30:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMGRZJ71AKFQ367f8JVFYlUG+IDhib574y0P903Ihgc46d0pFP/98yfhGXcMX3h3jvCSvrI6XYjtH08diqbvg=
X-Received: by 2002:a81:4f11:0:b0:610:f9dc:87d with SMTP id
 d17-20020a814f11000000b00610f9dc087dmr145426ywb.3.1710952206570; Wed, 20 Mar
 2024 09:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <13625712.uLZWGnKmhe@valdaarhun>
 <CAJaqyWdmGbYj1KjN6zcu-fRij9X6mNG-xKHqQiaVsY1zu1T-Ag@mail.gmail.com>
 <9252283.CDJkKcVGEf@valdaarhun> <3291749.44csPzL39Z@valdaarhun>
In-Reply-To: <3291749.44csPzL39Z@valdaarhun>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 20 Mar 2024 17:29:30 +0100
Message-ID: <CAJaqyWdhsXUXdP+3GN81hw9tqccy6+3=WVvigxu2yU-8F=x04A@mail.gmail.com>
Subject: Re: Intention to work on GSoC project
To: Sahil <icegambit91@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
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

On Mon, Mar 18, 2024 at 8:47=E2=80=AFPM Sahil <icegambit91@gmail.com> wrote=
:
>
> Hi,
>
> I was reading the "Virtqueues and virtio ring: How the data travels"
> article [1]. There are a few things that I have not understood in the
> "avail rings" section.
>
> Q1.
> Step 2 in the "Process to make a buffer available" diagram depicts
> how the virtio driver writes the descriptor index in the avail ring.
> In the example, the descriptor index #0 is written in the first entry.
> But in figure 2, the number 0 is in the 4th position in the avail ring.
> Is the avail ring queue an array of "struct virtq_avail" which maintains
> metadata such as the number of descriptor indexes in the header?
>

struct virtq_avail has two members: uint16_t idx and ring[]. To be in
the first position of the avail ring means to be in ring[0] there.

Idx and ring[] are just headers in the figure, not actual positions.
Same as Avail. Now that you mention maybe there is a better way to
represent that, yes.

Let me know if I didn't explain it well.

> Also, in the second position, the number changes from 0 (figure 1) to
> 1 (figure 2). I haven't understood what idx, 0 (later 1) and ring[] repre=
sent
> in the figures. Does this number represent the number of descriptors
> that are currently in the avail ring?
>

It is the position in ring[] where the device needs to stop looking
for descriptors. It starts at 0, and when the device sees 1 it means
ring[0] has a descriptor to process.

Now you need to apply a "modulo virtqueue size" to that index. So if
the virtqueue is 256, avail_idx 257 means the last valid descriptor is
at 0. This happens naturally when the driver keeps adding descriptors
and wraps the queue.

The authoritative source of this is the VirtQueues section of the
virtio standard [1], feel free to check it in case it clarifies
something better.

> Q2.
>
> There's this paragraph in the article right below the above mentioned
> diagram:
>
> > The avail ring must be able to hold the same number of descriptors
> > as the descriptor area, and the descriptor area must have a size power
> > of two, so idx wraps naturally at some point. For example, if the ring
> > size is 256 entries, idx 1 references the same descriptor as idx 257, 5=
13...
> > And it will wrap at a 16 bit boundary. This way, neither side needs to
> > worry about processing an invalid idx: They are all valid.
>
> I haven't really understood this. I have understood that idx is calculate=
d
> as idx mod queue_length. But I haven't understood the "16 bit boundary"
> part.
>

avail_idx is an uin16_t, so ((uint16_t)-1) + 1 =3D=3D 0.

> I am also not very clear on how a queue length that is not a power of 2
> might cause trouble. Could you please expand on this?
>

That's a limitation in the standard, but I'm not sure where it comes
from beyond being computationally easier to calculate ring position
with a mask than with a remainder of a random non-power-of-two number.
Packed virtqueue removes that limitation.

> Q3.
> I have started going through the source code in "drivers/virtio/virtio_ri=
ng.c".
> I have understood that the virtio driver runs in the guest's kernel. Does=
 that
> mean the drivers in "drivers/virtio/*" are enabled when linux is being ru=
n in
> a guest VM?
>

For PCI devices, as long as it detects a device with vendor =3D=3D Red
Hat, Inc. (0x1AF4) and device ID 0x1000 through 0x107F inclusive, yes.
You can also load and unload manually with modprobe as other drivers.

Let me know if you have more doubts. Thanks!

[1] https://docs.oasis-open.org/virtio/virtio/v1.3/virtio-v1.3.html


> Thanks,
> Sahil
>
> [1] https://www.redhat.com/en/blog/virtqueues-and-virtio-ring-how-data-tr=
avels
>
>
>
>


