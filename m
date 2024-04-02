Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3381CD1293
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 04:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrWEI-0005O5-IE; Tue, 02 Apr 2024 00:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1rrWEG-0005Ni-Lg
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 00:58:36 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1rrWEE-0000SV-Qd
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 00:58:36 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1e0000cdf99so38069365ad.0
 for <qemu-devel@nongnu.org>; Mon, 01 Apr 2024 21:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712033913; x=1712638713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wBxzpRtUuuR8/TWqMENyLtogYheP28+AYeh52Ro5lV8=;
 b=WhI41cVVLC0cXoySKYMK78b4Yu9naWPmxuH79Yj9LyKcuRdmxi/1x54IjIRlKl+M+F
 AlOvCDGhLSOhZQyluRmyLiClTd5jijCFlj62ty4MkeAYMFTBKyvAyMBLDRHzOE2FB3ov
 LXvDtA4VJ8Jb9Ln+KUHKXCZcK3cOrOcuVWCIim84sznue707p7J7UlVdr/6s3WjMgdpR
 Kv7+ytmqZu/3hLSMQH4JutJ8iLTocnqRFawdfGrnprjs1dS8R+irlHmhVqSQirCbtbHi
 RDZ3hsLnUW86tOSXmOJYvOjNsWQrLsONCtzwpBuGyJwrEzClH845z3riqLRT+YAsnnvr
 XbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712033913; x=1712638713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wBxzpRtUuuR8/TWqMENyLtogYheP28+AYeh52Ro5lV8=;
 b=eoPI2zxl1FapXfeHD3W2XzsHocCWyj0+RXavP1i5Y9F7zZRnTUvuoYuKjHBnSYrboN
 7udzrVuMGWm+EVsVyaGi3IwAtkO342W55kfzIkQcYkoZF0Ydo6b4a0kYE1CZ+u8I6fYU
 e1nSY5/RdwSxU7OeX2t7xMaiEhpdExC9K/QWh8RWHM+cuQ50ZuIbH92Rfd2omBu/VfiT
 0JhWsexM/nB9VHmo439LMAG4bZ0jjcK5nFj6fz7nTGRSnEwjZ9e7VMBNlZ0gGWsJwlVN
 OuZvAjCo9n5fpNyos36M/Gi0VqVzF1Y3BU82PfAx7G550703Xnl2balBBIYNNwsNkxDE
 ixog==
X-Gm-Message-State: AOJu0YxlZUioYqX2rbD2DSXn/V8Qco1oZpOrgB3145f/I+VuVzVLFrcC
 ipQ+nBP9L8/m8I7Mvxy5S/VaFn5euJpKZIj6wCNvMfYcELUNZ1kzMUrVFRW1D0s=
X-Google-Smtp-Source: AGHT+IFvIv0r+OJaAQbE9rKep7oYypSqM8oC0VOgbkJV9b7xGDbOmeX3gUWbBYgzsAbOmTUYKlRQYw==
X-Received: by 2002:a17:902:74c5:b0:1e2:6d58:c8d0 with SMTP id
 f5-20020a17090274c500b001e26d58c8d0mr714029plt.50.1712033912734; 
 Mon, 01 Apr 2024 21:58:32 -0700 (PDT)
Received: from valdaarhun.localnet ([2409:4081:2d9b:3168:a289:f071:d2b7:600])
 by smtp.gmail.com with ESMTPSA id
 t1-20020a170902e84100b001e0da190a07sm9920754plg.167.2024.04.01.21.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Apr 2024 21:58:32 -0700 (PDT)
From: Sahil <icegambit91@gmail.com>
To: qemu-level <qemu-devel@nongnu.org>,
 Eugenio Perez Martin <eperezma@redhat.com>, daleyoung4242@gmail.com
Cc: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: Intention to work on GSoC project
Date: Tue, 02 Apr 2024 10:28:28 +0530
Message-ID: <10440822.nUPlyArG6x@valdaarhun>
In-Reply-To: <10693205.CDJkKcVGEf@arch>
References: <13625712.uLZWGnKmhe@valdaarhun> <8390729.NyiUUSuA9g@valdaarhun>
 <10693205.CDJkKcVGEf@arch>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=icegambit91@gmail.com; helo=mail-pl1-x62f.google.com
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

On Monday, April 1, 2024 11:53:11 PM IST daleyoung4242@gmail.com wrote:
> Hi,
> 
> On Monday, March 25, 2024 21:20:32 CST Sahil wrote:
> > Q1.
> > Section 2.7.4 of the virtio spec [3] states that in an available
> > descriptor, the "Element Length" stores the length of the buffer element.
> > In the next few lines, it also states that the "Element Length" is
> > reserved for used descriptors and is ignored by drivers. This sounds a
> > little contradictory given that drivers write available desciptors in the
> > descriptor ring.
> When VIRTQ_DESC_F_WRITE is set, the device will use "Element Length" to
> specify the length it writes. When VIRTQ_DESC_F_WRITE is not set, which
> means the buffer is read-only for the device, "Element Length" will not be
> changed by the device, so drivers just ignore it.


Thank you for the clarification. I think I misunderstood what I had read
in the virtio spec. What I have understood now is that "Element Length"
has different meanings for available and used descriptors.

Correct me if I am wrong - for available descriptors, it represents the
length of the buffer. For used descriptors, it represents the length of
the buffer that is written to by the device if it's write-only, otherwise it
has no meaning and hence can be ignored by drivers.

> > Q2.
> > In the Red Hat article, just below the first listing ("Memory layout of a
> > packed virtqueue descriptor"), there's the following line referring to the
> > buffer id in
> > 
> > "virtq_desc":
> > > This time, the id field is not an index for the device to look for the
> > > buffer: it is an opaque value for it, only has meaning for the driver.
> > 
> > But the device returns the buffer id when it writes the used descriptor to
> > the descriptor ring. The "only has meaning for the driver" part has got me
> > a little confused. Which buffer id is this that the device returns? Is it
> > related to the buffer id in the available descriptor?
> 
> In my understanding, buffer id is the element that avail descriptor marks to
> identify when adding descriptors to table. Device will returns the buffer
> id in the processed descriptor or the last descriptor in a chain, and write
> it to the descriptor that used idx refers to (first one in the chain). Then
> used idx increments.
> 
> The Packed Virtqueue blog [1] is helpful, but some details in the examples
> are making me confused.
> 
> Q1.
> In the last step of the two-entries descriptor table example, it says both
> buffers #0 and #1 are available for the device. I understand descriptor[0]
> is available and descriptor[1] is not, but there is no ID #0 now. So does
> the device got buffer #0 by notification beforehand? If so, does it mean
> buffer #0 will be lost when notifications are disabled?
> 

I too have a similar question and understanding the relation between buffer
ids in the used and available descriptors might give more insight into this. For
available descriptors, the buffer id is used to associate descriptors with a
particular buffer. I am still not very sure about ids in used descriptors.

Regarding Q1, both buffers #0 and #1 are available. In the mentioned figure,
both descriptor[0] and descriptor[1] are available. This figure follows the figure
with the caption "Using first buffer out of order". So in the first figure the device
reads buffer #1 and writes the used descriptor but it still has buffer #0 to read.
That still belongs to the device while buffer #1 can now be handled by the driver
once again. So in the next figure, the driver makes buffer #1 available again. The
device can still read buffer #0 from the previous batch of available descriptors.

Based on what I have understood, the driver can't touch the descriptor
corresponding to buffer #0 until the device acknowledges it. I did find the
figure a little confusing as well. I think once the meaning of buffer id is clear
from the driver's and device's perspective, it'll be easier to understand the
figure.

I am also not very sure about what happens when notifications are disabled.
I'll have to read up on that again. But I believe the driver still won't be able to
touch #0 until the device uses it.

I think going through the source should better explain these concepts.

Thanks,
Sahil




