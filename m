Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5027C48BF6
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Mar 2024 20:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlacL-00054j-St; Sat, 16 Mar 2024 16:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1rlacJ-00054G-VE
 for qemu-devel@nongnu.org; Sat, 16 Mar 2024 16:26:56 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1rlacI-0000hx-6S
 for qemu-devel@nongnu.org; Sat, 16 Mar 2024 16:26:55 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e71af27f2bso96822b3a.1
 for <qemu-devel@nongnu.org>; Sat, 16 Mar 2024 13:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710620812; x=1711225612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XweVfwwtTeYhEgwcdfzTu1w0VzAR0mdA6H+ThJRbhb0=;
 b=SvwYUUTtme8yL6dYzrA/WlOZhVRllAirTQu8VwEvyZJMlX4o5jzoYtSuiJxHM1jE4c
 6q66/lqY/tZnxRCTSUuemrdGdX07liDnOaTXQqWKUp8ChLbSxxbyOLEIMhwbj6ESPyGC
 9FgzkyqrYAlZlnBmGKpbZ2uDuqsQ9dapU1+DARImYIkd0cOat6QkduDVfwHmDljrV1mM
 wCqy5zqTALHs9vUL5ff4+dQFt6oaphdIl5bgaYwR6vQRyQ146mYnBFZA8FsqYYq2ybG6
 WZRLkEqQzEDuAj7Ti7u4cdTJyT+D+/wTTrZSmXGqgaAYofj84Emwy5mrzbql9inxc7GH
 4C7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710620812; x=1711225612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XweVfwwtTeYhEgwcdfzTu1w0VzAR0mdA6H+ThJRbhb0=;
 b=OPaV59jMunYh1xAdYlut89ZUKvAh9rVgRs8kD9HrQhLS7lW4nOqeFzLUoSATLbJksz
 6XS/+NLwkJTqCNWyH9YcfgCqhOqfNHPDpqX+opqijMRKkG7+7i+ZlRqp+eEDanN1V1nL
 VV+WK1O7n0n2EUKz8ckecCBep3IdUzXrYlis/rqY04kQ6rxXhEZjLJ8m1y4f/dMvjyj1
 EAziKlYv0WPmj7XBaOtlhil3rUhCI/8DbrQ/p0eRNaf3cKlrdebWYuqPxlsmOvfCAFgC
 esuLoOVeGrU2V/PPRFqYUaVT2oMA/E9zrZt0vKLu8TgWbo5EqhrzyZ+qwayNwx2olEA9
 rxUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPE4HAnXAo5V0h17Wr9XdjP7advmH2iaFSqk7eoJqj/KYY17W3d/s0ITuaxLp09ebYWoU3zeJHGadwGS/InOXAvteloYU=
X-Gm-Message-State: AOJu0YzryWX2NSCUv7tNz2YiSqOZQnJcsnxCq76hvB22vTE/0sxykmOB
 h+D5mra35rlUQOhdKJhALFhshsKYJ7oBV+L05+AnaSqlKwnl78XL
X-Google-Smtp-Source: AGHT+IG/Brs5dSYZ0cIES4JqWpJGb/nxM0Hyv5i/tJ2SuO80GQRdmqGEEuQJl/rSIAWS3l/gT1cSig==
X-Received: by 2002:a05:6a00:3982:b0:6e6:c38e:e8cf with SMTP id
 fi2-20020a056a00398200b006e6c38ee8cfmr12399401pfb.2.1710620812176; 
 Sat, 16 Mar 2024 13:26:52 -0700 (PDT)
Received: from valdaarhun.localnet ([223.233.84.232])
 by smtp.gmail.com with ESMTPSA id
 f31-20020a056a000b1f00b006e6bcda8481sm5376087pfu.164.2024.03.16.13.26.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Mar 2024 13:26:51 -0700 (PDT)
From: Sahil <icegambit91@gmail.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>
Subject: Re: Intention to work on GSoC project
Date: Sun, 17 Mar 2024 01:56:47 +0530
Message-ID: <9252283.CDJkKcVGEf@valdaarhun>
In-Reply-To: <CAJaqyWdmGbYj1KjN6zcu-fRij9X6mNG-xKHqQiaVsY1zu1T-Ag@mail.gmail.com>
References: <13625712.uLZWGnKmhe@valdaarhun> <1786176.VLH7GnMWUR@valdaarhun>
 <CAJaqyWdmGbYj1KjN6zcu-fRij9X6mNG-xKHqQiaVsY1zu1T-Ag@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=icegambit91@gmail.com; helo=mail-pf1-x429.google.com
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

Thank you for your reply.

On Friday, March 15, 2024 4:57:39 PM IST Eugenio Perez Martin wrote:
> [...]
> > Some sections in the above docs were difficult to grasp. For the time
> > being, I have focused on those parts that I thought were relevant
> > to the project.
> 
> Please feel free to ask any questions, maybe we can improve the doc :).

I understood the introductory sections of the documentation such as the
"About QEMU" section and the first half of the "system emulation". Sections
and subsections that went into greater detail were a little overwhelming
such as the "QEMU virtio-net standby" subsection [1] or the "migration
features" [2] subsection. But the red hat blogs and deep-dive articles helped
cover a lot of ground conceptually.

I feel once I start getting my hands dirty, I'll be able to absorb these concepts
much better.

I did have two questions that I would like to ask.

Q1.
Regarding the "Deep dive into Virtio-networking and vhost-net" article [3],
the "Introduction" subsection of the "Vhost protocol" section mentions that
sending the available buffer notification involves a vCPU interrupt (4th bullet
point). But in figure 2, the arrow for the "available buffer notification" indicates
a PCI interrupt. Initially I thought they were two different interrupts but I am
a little confused about this now.

Q2.
In the "Virtio-net failover operation" section of the "Virtio-net failover: An
introduction" article [4], there are five bullet points under the first figure.
The second point states that the guest kernel needs the ability to switch
between the VFIO device and the vfio-net device. I was wondering if
"vfio-net" is a typo and if it should be "virtio-net" instead.

> [...]
> There is a post before the first in the series:
> https://www.redhat.com/en/blog/virtio-devices-and-drivers-overview-headjack-
> and-phone

Got it. I didn't know this was the first in the series. I have now covered this as
well, so I can move on to "Virtqueues and virtio ring: How the data travels" [3] :)

> > 1. Virtqueues and virtio ring: How the data travels [8]
> > 2. Packed virtqueue: How to reduce overhead with virtio [9]
> > 3. Virtio live migration technical deep dive [10]
> > 4. Hands on vDPA: what do you do when you ain't got the hardware v2 (Part
> > 1) [11]
> I think it's a good plan!
> 
> If you feel like you're reading a lot of theory and want to get your
> hands dirty already, you can also start messing with the code with the
> blogs you already read. Or, maybe, after reading the Packed virtqueue
> one, your call.
> 
> In a very brute-forced description, you can start trying to copy all
> the *packed* stuff of kernel's drivers/virtio/virtio_ring.c into
> vhost_shadow_virtqueue.c.

I would love to start with some hands-on tasks. I'll take a look at
the kernel's "drivers/virtio/virtio_ring.c". I think I should also start
going through the "vhost_shadow_virtqueue.c" [4] source code.

> There is a lot more in the task, and I can get into more detail
> if you want either here or in a meeting.

Thank you. Either means of communication works for me although
the latter will require some coordination.

> If you prefer to continue with the theory it is ok too.

A good balance of theory and practice would be nice at this stage.
It'll keep my brains from getting too muddled up.

Thanks,
Sahil

[1] https://www.qemu.org/docs/master/system/virtio-net-failover.html
[2] https://www.qemu.org/docs/master/devel/migration/features.html
[3] https://www.redhat.com/en/blog/deep-dive-virtio-networking-and-vhost-net
[4] https://www.redhat.com/en/blog/virtio-net-failover-introduction
[5] https://www.redhat.com/en/blog/virtqueues-and-virtio-ring-how-data-travels



