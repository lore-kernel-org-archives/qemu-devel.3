Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0460C54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 13:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rokFn-0007NF-OI; Mon, 25 Mar 2024 09:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1rokFk-0007Mx-LH
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 09:20:40 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1rokFi-0005I6-J9
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 09:20:40 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6e782e955adso3679073b3a.3
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 06:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711372837; x=1711977637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bvn32dFXv/6xheZxRIppG2aWjR1g4SG6/JFkduvJ5bA=;
 b=DCTJn9ZI4czAW1ga+NHmxn/gT4W3xptDrjnytdPxFPYa0IvvlG5HKVvETzJ+AoucgZ
 wZquwFrobK7pBMzd+yPEAdYOdzJg2Xo6qAJb/Nyn1PyFBT4+mVRHYiv30y1O8aKBZiAa
 vyTW/qlEbphk47eUvjBO9VkcQ6HM3LRC03DGU5pOK/SdsarnwjkfImuHp8aNwaQ1r/cQ
 CRDqAGbU2Bg479sLsFxJxzEugQBJLKkOHVLZeXf5vQV781sMNE9wjLppuqjPKVl4hiyK
 0dCdssNV6IH2y1nC7o4rb8aUKzYIJt/RvgVdIC8QngRMRkUm4vxZYbFGfghZgQ/MUlfC
 7Isg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711372837; x=1711977637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bvn32dFXv/6xheZxRIppG2aWjR1g4SG6/JFkduvJ5bA=;
 b=YFboHjlFrgHi5mNw0LVyJkYo/BdxeOTOznoXiWqpPOObPpLVU5YodYyr/x9cCklPuF
 I8RZnRwiZt2YYnR2do3fQRyxFTh8CFkWvFXSkHGP0bgKgS1EM0EKo5CoQeeiBcZxeMcq
 VVhWulXfizeKt2RuKvTytBB3o0gFY1ZR3lshBL72uf+HFNLR4Qxsg05ErKBipzZPm16H
 hA+8R8GzTzdHzXPmNk+LgFcIBsRrUB7EJFvt8MogX4cwTA+B64bScA6T3fj3N/DgdI3r
 +ZtyIRFNNLFWr+tbKW5KR3JmXOduXwYvBfNE3xo0Eqp/z5jhistNG6ohkWhWgzw3ddRK
 /GcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMWSXlekM1KZbmbBz0SwXCn1Drm9FyzG27mkAIwehikIDy7d15nKN2wOekg+gqhJbWCsHbHV1j961ybKqlt3OxBxhJrxc=
X-Gm-Message-State: AOJu0YwCJ8ERm786zvV6bLoWnB+3RQtvUVTBJ7oAn7qsU5Gt3fIvY2eH
 1DmLPfWv8DmMZZxcM+NcxA1f971UaK21qu7rc9mH3pK/2l3t2gZog//YN3I/
X-Google-Smtp-Source: AGHT+IFxgFgpjGakLpko5DVrTW1lBzZPTHXO5GxKLtwN5/lQn125Qe1Spw/pGyPPqu748E9pxtM8jQ==
X-Received: by 2002:a05:6a21:3948:b0:1a3:d27a:40c3 with SMTP id
 ac8-20020a056a21394800b001a3d27a40c3mr694250pzc.25.1711372836542; 
 Mon, 25 Mar 2024 06:20:36 -0700 (PDT)
Received: from valdaarhun.localnet ([182.48.211.62])
 by smtp.gmail.com with ESMTPSA id
 gl3-20020a17090b120300b00298cc4c56cdsm9877889pjb.22.2024.03.25.06.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 06:20:36 -0700 (PDT)
From: Sahil <icegambit91@gmail.com>
To: Eugenio Perez Martin <eperezma@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: Intention to work on GSoC project
Date: Mon, 25 Mar 2024 18:50:32 +0530
Message-ID: <8390729.NyiUUSuA9g@valdaarhun>
In-Reply-To: <CAJaqyWdhsXUXdP+3GN81hw9tqccy6+3=WVvigxu2yU-8F=x04A@mail.gmail.com>
References: <13625712.uLZWGnKmhe@valdaarhun> <3291749.44csPzL39Z@valdaarhun>
 <CAJaqyWdhsXUXdP+3GN81hw9tqccy6+3=WVvigxu2yU-8F=x04A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=icegambit91@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hi,

Thank you for your reply.

On Wednesday, March 20, 2024 9:27:00 PM IST Eugenio Perez Martin wrote:
> [...]
> > Q1.
> > Regarding the "Deep dive into Virtio-networking and vhost-net"
> > article [3], the "Introduction" subsection of the "Vhost protocol"
> > section mentions that sending the available buffer notification
> > involves a vCPU interrupt (4th bullet point).
> 
> Now I realize we used a very misleading term there :). Without
> ioeventfd, when the guest writes to the PCI notification area the
> guest vCPU is totally paused there, and the control is handed to
> host's KVM first and QEMU after it. The same physical CPU of the
> machine needs to switch context because of that.
> 
> Is an interruption of the execution and a context switch. Maybe
> "paused" is a better term.
> 
> > But in figure 2, the arrow for the "available buffer notification"
> > indicates a PCI interrupt. Initially I thought they were two different
> > interrupts but I am a little confused about this now.
> 
> They are different, but at that part of the blog is just the direction
> of who interrupts / notifies who :).

Thank you for the clarification. This makes sense now.

On Wednesday, March 20, 2024 9:59:30 PM IST Eugenio Perez Martin wrote:
> [...]
> > Q1.
> > Step 2 in the "Process to make a buffer available" diagram depicts
> > how the virtio driver writes the descriptor index in the avail ring.
> > In the example, the descriptor index #0 is written in the first entry.
> > But in figure 2, the number 0 is in the 4th position in the avail ring.
> > Is the avail ring queue an array of "struct virtq_avail" which maintains
> > metadata such as the number of descriptor indexes in the header?
> 
> struct virtq_avail has two members: uint16_t idx and ring[]. To be in
> the first position of the avail ring means to be in ring[0] there.
> 
> Idx and ring[] are just headers in the figure, not actual positions.
> Same as Avail. Now that you mention maybe there is a better way to
> represent that, yes.
> 
> Let me know if I didn't explain it well.
> 
> > Also, in the second position, the number changes from 0 (figure 1) to
> > 1 (figure 2). I haven't understood what idx, 0 (later 1) and ring[]
> > represent in the figures. Does this number represent the number of
> > descriptors that are currently in the avail ring?
> 
> It is the position in ring[] where the device needs to stop looking
> for descriptors. It starts at 0, and when the device sees 1 it means
> ring[0] has a descriptor to process.
> 
> Now you need to apply a "modulo virtqueue size" to that index. So if
> the virtqueue is 256, avail_idx 257 means the last valid descriptor is
> at 0. This happens naturally when the driver keeps adding descriptors
> and wraps the queue.
> 
> The authoritative source of this is the VirtQueues section of the
> virtio standard [1], feel free to check it in case it clarifies
> something better.

I have understood this as well. Reading the virtio specification was
definitely helpful.

> > Q2.
> > 
> > There's this paragraph in the article right below the above mentioned
> > diagram:
> > > The avail ring must be able to hold the same number of descriptors
> > > as the descriptor area, and the descriptor area must have a size power
> > > of two, so idx wraps naturally at some point. For example, if the ring
> > > size is 256 entries, idx 1 references the same descriptor as idx 257,
> > > 513... And it will wrap at a 16 bit boundary. This way, neither side
> > > needs to worry about processing an invalid idx: They are all valid.
> > 
> > I haven't really understood this. I have understood that idx is calculated
> > as idx mod queue_length. But I haven't understood the "16 bit boundary"
> > part.
> 
> avail_idx is an uin16_t, so ((uint16_t)-1) + 1 == 0.
> > I am also not very clear on how a queue length that is not a power of 2
> > might cause trouble. Could you please expand on this?
> 
> That's a limitation in the standard, but I'm not sure where it comes
> from beyond being computationally easier to calculate ring position
> with a mask than with a remainder of a random non-power-of-two number.

Understood.

> Packed virtqueue removes that limitation.

Right, I noticed that "queue_size" does not have to be a power of 2 for
packed virtqueues.

> > Q3.
> > I have started going through the source code in
> > "drivers/virtio/virtio_ring.c". I have understood that the virtio driver
> > runs in the guest's kernel. Does that mean the drivers in
> > "drivers/virtio/*" are enabled when linux is being run in a guest VM?
> 
> For PCI devices, as long as it detects a device with vendor == Red
> Hat, Inc. (0x1AF4) and device ID 0x1000 through 0x107F inclusive, yes.
> You can also load and unload manually with modprobe as other drivers.

Got it. The linux documentation in "documentation/driver-api/virtio/virtio.rst"
covers this as well. I must have missed this before sending the email.

> Let me know if you have more doubts. Thanks!

I have also read through the "Packed virtqueue: How to reduce overhead
with virtio" article [1] and the relevant section from the virtio specification [2].
This has been slightly difficult to grasp. Going through the source in
"drivers/virtio/virtio_ring.c" is helping a bit but I am still confused about
a few things.

Q1.
Section 2.7.4 of the virtio spec [3] states that in an available descriptor, the
"Element Length" stores the length of the buffer element. In the next few lines,
it also states that the "Element Length" is reserved for used descriptors and is
ignored by drivers. This sounds a little contradictory given that drivers write
available desciptors in the descriptor ring.

Q2.
In the Red Hat article, just below the first listing ("Memory layout of a packed
virtqueue descriptor"), there's the following line referring to the buffer id in
"virtq_desc":

> This time, the id field is not an index for the device to look for the buffer: it is
> an opaque value for it, only has meaning for the driver.

But the device returns the buffer id when it writes the used descriptor to the
descriptor ring. The "only has meaning for the driver" part has got me a little
confused. Which buffer id is this that the device returns? Is it related to the
buffer id in the available descriptor?

Thanks,
Sahil

[1] https://www.redhat.com/en/blog/packed-virtqueue-how-reduce-overhead-virtio
[2] https://docs.oasis-open.org/virtio/virtio/v1.1/csprd01/virtio-v1.1-csprd01.html#x1-610007
[3] https://docs.oasis-open.org/virtio/virtio/v1.1/csprd01/virtio-v1.1-csprd01.html#x1-650004




