Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A28C54E66
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 07:15:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl1mR-0001tU-UP; Fri, 15 Mar 2024 03:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1rl1mP-0001t5-3v
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 03:15:01 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1rl1mN-00039W-DT
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 03:15:00 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6e6cadfffdbso1506584b3a.3
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 00:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710486897; x=1711091697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nN00p1goZ6PQ989OHEk60XO6aAEKzaDhvEXFwjTjPLI=;
 b=ne019nRcJeRKOZo6LEItuX93hIaPRvXDMv7xe3qJf9Ilof6yAbgHbxXSUGCrEw3AA+
 iyk0uy4XOkiH3EUaHMfwauble7fV8R3E1VyAHJq3kEgehqTe89Zw8yD0TdpLuqZqt3Kx
 e2iK7bn8gpQSeHxD9aY08M+y9hIY7pcOZlx4F1GvZLzOY2JbxPRWhHAwsOWjCV1gIrPY
 U4sSFlHOY+fgeWI5eTNF/k+jfey1EbvjgfCiBXmnCsYjhkmQJ0xa4gkr0YJ4jo0gb2RB
 FxZYT7+3w9VH2JZ9xMwRU2P3i+K3xzWgaYngqDL/mO6XtOTMsClu9gZsj+F9wvEQttMP
 v8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710486897; x=1711091697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nN00p1goZ6PQ989OHEk60XO6aAEKzaDhvEXFwjTjPLI=;
 b=FZU7Utl3RWCkcBeqEtN6JijEla1nkcsgykYh7v3xC0I7omcCZpZ+CD7Cooa/wyzNzo
 0/RZHgZASJCbI1NNSd+rEAfCqJgYrs2r6LUGoULVa2HaxPHeQMOkeuIqWrN4LeL5VTWo
 7AcnmnbNHm81qAeT9CSBkHpaaeuA/fge750AlKEOQq9FkMeXIvaSSlXjVy0SKYs2H+MB
 IlhBYRmzvyU8+WXAH8/M1n53mqlpUYiOICfLfubZRzPBWWyq5S8xuQuDHUij5rqvDUiv
 /K+0u/RO+vqgIyBNalaS9MZ3gzvV2RjVcNj4n+Z3hhW3zIgl0zpdUcUZl607J2f0bMdp
 WqOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6ZO29S/H6BCgqev0RdWKxdQQV789Am6HXBRnWaSUCfT37An25LBjElCFs58xKwY9XRY2lt9ramhrByknICrkJo7e7ttQ=
X-Gm-Message-State: AOJu0YxhDDBoUOYT6HnGbvI/izMhNrkfqf7V4xkR5+GFc+1TGAxAphlC
 In7KBOivz0F8Z89z7Mx4iqvvnGHsEIyanK4qKL6crVHNqg/czKT5
X-Google-Smtp-Source: AGHT+IEtj00xOhA4NWmd4DPnYM616RQ6sO1/j7mVzrwzwCGDxodbUfrkv2OedQRkxvjFz7U2YUgBXg==
X-Received: by 2002:a05:6a20:bb05:b0:1a1:876a:9cce with SMTP id
 fc5-20020a056a20bb0500b001a1876a9ccemr1994644pzb.42.1710486896667; 
 Fri, 15 Mar 2024 00:14:56 -0700 (PDT)
Received: from valdaarhun.localnet ([223.233.86.143])
 by smtp.gmail.com with ESMTPSA id
 l10-20020a170903244a00b001dde0e74e5fsm2989198pls.63.2024.03.15.00.14.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 00:14:56 -0700 (PDT)
From: Sahil <icegambit91@gmail.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>
Subject: Re: Intention to work on GSoC project
Date: Fri, 15 Mar 2024 12:44:51 +0530
Message-ID: <1786176.VLH7GnMWUR@valdaarhun>
In-Reply-To: <CAJaqyWcuU_kQpCN+U3ejWgfm+zBv3Mofe0zyi-RB+rbqgDHEgg@mail.gmail.com>
References: <13625712.uLZWGnKmhe@valdaarhun> <6022175.lOV4Wx5bFT@valdaarhun>
 <CAJaqyWcuU_kQpCN+U3ejWgfm+zBv3Mofe0zyi-RB+rbqgDHEgg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=icegambit91@gmail.com; helo=mail-pf1-x436.google.com
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

Thank you for your email.

On Thursday, March 14, 2024 8:39:45 PM IST Eugenio Perez Martin wrote:
> Hi Sahil,
> 
> It's being hard to find a good self-contained small task related to
> the project to be honest. As it would be out of SVQ, would it be ok
> for you if we start straight to the task of adding the packed vq
> format to SVQ?
> 
> Thanks!

Sure, this works too! I would love to get started with the project.

I have a small update as well. I have read through a few docs and
articles to familiarize myself with the relevant terminology and
technicalities.

1. "About", "system emulation" and "user mode emulation" sections of
    the user documentation [1]
2. The migration subsystem [2]

Some sections in the above docs were difficult to grasp. For the time
being, I have focused on those parts that I thought were relevant
to the project.

I have also read through the following articles:

1. Introduction to virtio-networking and vhost-net [3]
2. Deep dive into Virtio-networking and vhost-net [4]
3. Virtualized Hardware Devices [5]
4. VFIO - "Virtual Function I/O" (Just the introduction) [6]
5. Virtio-net failover: An introduction [7]

I hope I haven't gone off on a tangent. I was planning to finish reading
up on the following articles as well:

1. Virtqueues and virtio ring: How the data travels [8]
2. Packed virtqueue: How to reduce overhead with virtio [9]
3. Virtio live migration technical deep dive [10]
4. Hands on vDPA: what do you do when you ain't got the hardware v2 (Part 1) [11]

I believe the hands-on vPDA article will have me set up a development
environment for the project as well.

Please let me know if I should amend my roadmap. I am
excited to get started :)

Thanks,
Sahil

[1] https://www.qemu.org/docs/master/index.html
[2] https://www.qemu.org/docs/master/devel/migration/index.html
[3] https://www.redhat.com/en/blog/introduction-virtio-networking-and-vhost-net
[4] https://www.redhat.com/en/blog/deep-dive-virtio-networking-and-vhost-net
[5] https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/virtualization_getting_started_guide/sec-virtualization_getting_started-products-virtualized-hardware-devices
[6] https://www.kernel.org/doc/html/latest/driver-api/vfio.html
[7] https://www.redhat.com/en/blog/virtio-net-failover-introduction
[8] https://www.redhat.com/en/blog/virtqueues-and-virtio-ring-how-data-travels
[9] https://developers.redhat.com/articles/2024/02/21/virtio-live-migration-technical-deep-dive
[10] https://www.redhat.com/en/blog/packed-virtqueue-how-reduce-overhead-virtio
[11] https://www.redhat.com/en/blog/hands-vdpa-what-do-you-do-when-you-aint-got-hardware-part-1



