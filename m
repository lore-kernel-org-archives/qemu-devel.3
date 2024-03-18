Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7913C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 19:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmIx9-0008GV-RS; Mon, 18 Mar 2024 15:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1rmIx8-0008Fv-9i
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 15:47:22 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1rmIx6-0003Vx-AF
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 15:47:22 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1e01c38f98cso8304055ad.3
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 12:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710791238; x=1711396038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iBI01Rwy1TqApQvjIM/vnv3YHAdaYDpOZ1drr5VJmW8=;
 b=K7vYk+/BAfURnXLVV2ZRQFY0X4yereAltkRK3QgAGGm/8MRs0bTzQzOOqBYJ8+Zpyt
 23u6d94OiI4D4J+sZvyK8/HDJwkOogv4DmK208n3AbEOb3+78jlQxbXDihnfZQTP6aLA
 pAMYP+BefsgjGChSaYZud6HBJRKGdbVW7SDMwjZn4EAjER8hVY0ZorUVnOYh9nB/nHZj
 fcvlSarigen47Wq9wUoGuCtkcqz5lQZNWWZ5peZKd6248eIXvd7KqGTey1/vC+mMrL55
 G2m8HNtJvayff31nwlZYAtvrhqVilPlVaJzjXK/C326G+WaIr3hqK2rpdqu/kaLlgl4/
 rOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710791238; x=1711396038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iBI01Rwy1TqApQvjIM/vnv3YHAdaYDpOZ1drr5VJmW8=;
 b=n39caT84LXhwmz6tjfSsktIeDoBn42D9//5cKUf10WCY/thcbVFhcAjhMnW5Hv3i3W
 FjnzAQJQcOzN+Y1awG2Ox2BiU2kUxqRtJYs0SeWNrjqciFYNuq0ng5zrOv2cFtlaS8/n
 ITKhyGJ26BAC9/u1FX/e+LBjWUwfA8ZIPzfwF5viO+lqtlTl6Y6pJDdojRpqwLnK1nrp
 DZCTrRZ6pFOWgPYIp/8s0dmFAc2s1Q3GAustIXdIjCRh3wJAFcGC76wWP1NYdcfxN16X
 mqhrNGWG488+aKuBtTMufZGZuLdAyi6o9hm+uD0xJpkX4zSXe3iHZXMip+vMwF1/m+zy
 amuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjphCd/j0nieKDGbR6Ky6UnBKZYp4bKU+h4ARuu3QUa9v70XNaHeE5aYH+M8MAhfJJ6FtjGnt5odoDrVDhXU7x06J2FMk=
X-Gm-Message-State: AOJu0YxuKc3KO1445YXVOIKH01pGKLl93wTWLSNhjulpk53lB4yguBn7
 ZNyeh5NwLF8zNAwOELJv31z9Fzuz8SWcLFVHIHoncvRfNaVeZ0n4
X-Google-Smtp-Source: AGHT+IEyRByeHaqgt5UsSI3/ao4UDH37E7LKT/NMGN92u+wQBpOrSgztbNCh+HcfS/1++IALUp+zWA==
X-Received: by 2002:a17:902:c949:b0:1e0:2c15:f31a with SMTP id
 i9-20020a170902c94900b001e02c15f31amr3232896pla.3.1710791238256; 
 Mon, 18 Mar 2024 12:47:18 -0700 (PDT)
Received: from valdaarhun.localnet ([223.233.82.185])
 by smtp.gmail.com with ESMTPSA id
 p20-20020a170902ead400b001db9cb62f7bsm9659854pld.153.2024.03.18.12.47.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 12:47:17 -0700 (PDT)
From: Sahil <icegambit91@gmail.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>
Subject: Re: Intention to work on GSoC project
Date: Tue, 19 Mar 2024 01:17:15 +0530
Message-ID: <3291749.44csPzL39Z@valdaarhun>
In-Reply-To: <9252283.CDJkKcVGEf@valdaarhun>
References: <13625712.uLZWGnKmhe@valdaarhun>
 <CAJaqyWdmGbYj1KjN6zcu-fRij9X6mNG-xKHqQiaVsY1zu1T-Ag@mail.gmail.com>
 <9252283.CDJkKcVGEf@valdaarhun>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=icegambit91@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

I was reading the "Virtqueues and virtio ring: How the data travels"
article [1]. There are a few things that I have not understood in the
"avail rings" section.

Q1.
Step 2 in the "Process to make a buffer available" diagram depicts
how the virtio driver writes the descriptor index in the avail ring.
In the example, the descriptor index #0 is written in the first entry.
But in figure 2, the number 0 is in the 4th position in the avail ring.
Is the avail ring queue an array of "struct virtq_avail" which maintains
metadata such as the number of descriptor indexes in the header?

Also, in the second position, the number changes from 0 (figure 1) to
1 (figure 2). I haven't understood what idx, 0 (later 1) and ring[] represent
in the figures. Does this number represent the number of descriptors
that are currently in the avail ring?

Q2.

There's this paragraph in the article right below the above mentioned
diagram:

> The avail ring must be able to hold the same number of descriptors
> as the descriptor area, and the descriptor area must have a size power
> of two, so idx wraps naturally at some point. For example, if the ring
> size is 256 entries, idx 1 references the same descriptor as idx 257, 513...
> And it will wrap at a 16 bit boundary. This way, neither side needs to
> worry about processing an invalid idx: They are all valid.

I haven't really understood this. I have understood that idx is calculated
as idx mod queue_length. But I haven't understood the "16 bit boundary"
part.

I am also not very clear on how a queue length that is not a power of 2
might cause trouble. Could you please expand on this?

Q3.
I have started going through the source code in "drivers/virtio/virtio_ring.c".
I have understood that the virtio driver runs in the guest's kernel. Does that
mean the drivers in "drivers/virtio/*" are enabled when linux is being run in
a guest VM?

Thanks,
Sahil

[1] https://www.redhat.com/en/blog/virtqueues-and-virtio-ring-how-data-travels





