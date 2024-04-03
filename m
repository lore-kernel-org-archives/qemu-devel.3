Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E121CD1288
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 14:37:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rs1j4-0001Mn-To; Wed, 03 Apr 2024 10:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1rs1j2-0001MT-R3
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 10:36:28 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1rs1j0-0005gT-JR
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 10:36:28 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1dff837d674so51045425ad.3
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 07:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712154985; x=1712759785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xSOuRBBtJS3Fa6a5Q+NqvLkZ2qG7jB+dmN1l6vRJfRA=;
 b=e0CqyrA7iNhxGotmJUaBKq6P/wQHf0xr3N1MgT6e4Ks9ITU+DtR6eveGfV1aU8jJ8C
 pNMdYNqkNXdLDBrOPvzVzThQ2749CRJTK/H0TXWsA+eNOUhZNqcc+agavqKw92GIuTLy
 sQ+nxPntMRPdb0zpkmGXLvlWewKfFYzAs2EKrtqeQJ/T8ou8iUUuwgmAw+thS/TgRHC4
 DV+tPDCYF3AItyY/jqijIKDcaOMrAncc0ilem4uo7Kn250gQRAutGkiFtnbdVGM8ogy6
 0yFP8doRtq9yfqH+GDEfcZ6xkKfr4pLngq9V86qFwDDB2YwXn0CpAH5EoIGE4wuhnNR8
 GBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712154985; x=1712759785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xSOuRBBtJS3Fa6a5Q+NqvLkZ2qG7jB+dmN1l6vRJfRA=;
 b=l7cxXRsFRQijDLAoWm8G4de5GyRSHFo8vT0DvGVwQqaJgaFuqLSnJfSdpxWf/54Li+
 cmYT6DQW08q+765neP7s27OMFQroYRcdZqnY41VLLYynPdU3l9X+QW1HubQkQk56YQ8a
 psbz64jQ+aosxs/zdEmapAAtT0wueJy5zt2rotJV9hU0ghwe4uYviT6aMWHE0UcTpSN4
 LQ1HAzEL03ApVQ2X8w95gQp20SA3rJkqT3CTtg9hZOExaUwxYM+JmnoW0CgKfH5Bsq/q
 22hrO5Z7KZjgx0WBK3nJ4opTZl4l869CVjCUjAgQleTcEsr9L3SZEF1so0wnTsL45TLn
 wqEw==
X-Gm-Message-State: AOJu0Yw4e+fJ2kzFE3w9IYSKX5Jgn3V87F3CRAUiseJntp8CgJ/UD8ff
 fVneW0/mRN6vylr9qvBtOdl881KqmSma/+UcvfnZV+VSbcbm5h1aOS/MSm9C
X-Google-Smtp-Source: AGHT+IG1ZGRYgtf1ve35UR+Mc3p+LKuar7ciSukiucKTa88jQ3LXYfcQHxnQ6orjtstL/8DCDlC8vg==
X-Received: by 2002:a17:902:e548:b0:1e2:6724:cf39 with SMTP id
 n8-20020a170902e54800b001e26724cf39mr5879404plf.64.1712154984579; 
 Wed, 03 Apr 2024 07:36:24 -0700 (PDT)
Received: from valdaarhun.localnet ([2409:4081:2d9b:3168:a289:f071:d2b7:600])
 by smtp.gmail.com with ESMTPSA id
 x10-20020a170902ec8a00b001e284b9b28asm2802012plg.129.2024.04.03.07.36.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 07:36:23 -0700 (PDT)
From: Sahil <icegambit91@gmail.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-level <qemu-devel@nongnu.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: Intention to work on GSoC project
Date: Wed, 03 Apr 2024 20:06:18 +0530
Message-ID: <1934013.taCxCBeP46@valdaarhun>
In-Reply-To: <CAJaqyWfeUHTEj6F-uBzA57gPLZhD70w1+FY2sDCTFBHEDkzzPA@mail.gmail.com>
References: <13625712.uLZWGnKmhe@valdaarhun> <10440822.nUPlyArG6x@valdaarhun>
 <CAJaqyWfeUHTEj6F-uBzA57gPLZhD70w1+FY2sDCTFBHEDkzzPA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=icegambit91@gmail.com; helo=mail-pl1-x62a.google.com
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

Thank you for the reply.

On Tuesday, April 2, 2024 5:08:24 PM IST Eugenio Perez Martin wrote:
> [...]
> > > > Q2.
> > > > In the Red Hat article, just below the first listing ("Memory layout of a
> > > > packed virtqueue descriptor"), there's the following line referring to the 
> > > > buffer id in "virtq_desc":
> > > > > This time, the id field is not an index for the device to look for the
> > > > > buffer: it is an opaque value for it, only has meaning for the driver.
> > > > 
> > > > But the device returns the buffer id when it writes the used descriptor to
> > > > the descriptor ring. The "only has meaning for the driver" part has got me
> > > > a little confused. Which buffer id is this that the device returns? Is it related
> > > > to the buffer id in the available descriptor?
> > > 
> > > In my understanding, buffer id is the element that avail descriptor
> > > marks to identify when adding descriptors to table. Device will returns
> > > the buffer id in the processed descriptor or the last descriptor in a
> > > chain, and write it to the descriptor that used idx refers to (first
> > > one in the chain). Then used idx increments.
> > > 
> > > The Packed Virtqueue blog [1] is helpful, but some details in the
> > > examples
> > > are making me confused.
> > > 
> > > Q1.
> > > In the last step of the two-entries descriptor table example, it says
> > > both buffers #0 and #1 are available for the device. I understand
> > > descriptor[0] is available and descriptor[1] is not, but there is no ID #0
> > > now. So does the device got buffer #0 by notification beforehand? If so,
> > > does it mean buffer #0 will be lost when notifications are disabled?
> 
> I guess you mean the table labeled "Figure: Full two-entries descriptor
> table".
> 
> Take into account that the descriptor table is not the state of all
> the descriptors. That information must be maintained by the device and
> the driver internally.
> 
> The descriptor table is used as a circular buffer, where one part is
> writable by the driver and the other part is writable by the device.
> For the device to override the descriptor table entry where descriptor
> id 0 used to be does not mean that the descriptor id 0 is used. It
> just means that the device communicates to the driver that descriptor
> 1 is used, and both sides need to keep the descriptor state
> coherently.
> 
> > I too have a similar question and understanding the relation between
> > buffer
> > ids in the used and available descriptors might give more insight into
> > this. For available descriptors, the buffer id is used to associate
> > descriptors with a particular buffer. I am still not very sure about ids
> > in used descriptors.
> > 
> > Regarding Q1, both buffers #0 and #1 are available. In the mentioned
> > figure, both descriptor[0] and descriptor[1] are available. This figure
> > follows the figure with the caption "Using first buffer out of order". So
> > in the first figure the device reads buffer #1 and writes the used
> > descriptor but it still has buffer #0 to read. That still belongs to the
> > device while buffer #1 can now be handled by the driver once again. So in
> > the next figure, the driver makes buffer #1 available again. The device
> > can still read buffer #0 from the previous batch of available
> > descriptors.
> > 
> > Based on what I have understood, the driver can't touch the descriptor
> > corresponding to buffer #0 until the device acknowledges it. I did find
> > the
> > figure a little confusing as well. I think once the meaning of buffer id
> > is clear from the driver's and device's perspective, it'll be easier to
> > understand the figure.
> 
> I think you got it right. Please let me know if you have further questions.

I would like to clarify one thing in the figure "Full two-entries descriptor
table". The driver can only overwrite a used descriptor in the descriptor
ring, right? And likewise for the device? So in the figure, the driver will
have to wait until descriptor[1] is used before it can overwrite it?

Suppose the device marks descriptor[0] as used. I think the driver will
not be able to overwrite that descriptor entry because it has to go in
order and is at descriptor[1]. Is that correct? Is it possible for the driver
to go "backwards" in the descriptor ring?

> > I am also not very sure about what happens when notifications are
> > disabled.
> > I'll have to read up on that again. But I believe the driver still won't
> > be able to touch #0 until the device uses it.
> 
> If one side disables notification it needs to check the indexes or the
> flags by its own means: Timers, read the memory in a busy loop, etc.

Understood. Thank you for the clarification.

I have some questions from the "Virtio live migration technical deep
dive" article [1].

Q1.
In the paragraph just above Figure 6, there is the following line:
> the vhost kernel thread and QEMU may run in different CPU threads,
> so these writes must be synchronized with QEMU cleaning of the dirty
> bitmap, and this write must be seen strictly after the modifications of
> the guest memory by the QEMU thread.

I am not clear on the last part of the statement. The modification of guest
memory is being done by the vhost device and not by the QEMU thread, right?

Q2.
In the first point of the "Dynamic device state: virtqueue state" section:
>The guest makes available N descriptors at the source of the migration,
>so its avail idx member in the avail idx is N.

I think there's a typo here: "...avail idx member in the avail ring is N"
instead of "...avail idx is N".

Regarding the implementation of this project, can the project be broken
down into two parts:
1. implementing packed virtqueues in QEMU, and
2. providing mechanisms for (live) migration to work with packed
    virtqueues.

I am ready to start working on the implementation. In one of your
previous emails you had talked about moving packed virtqueue
related implementation from the kernel's drivers/virtio/virtio_ring.c
into vhost_shadow_virtqueue.c.

My plan is to also understand how split virtqueue has been implemented
in QEMU. I think that'll be helpful when moving the kernel's implementation
to QEMU.

Please let me know if I should change my approach.

Thanks,
Sahil



