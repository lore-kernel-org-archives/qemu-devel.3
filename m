Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E90C63685
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 15:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjKsu-0005PC-MC; Wed, 28 Aug 2024 11:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sjKsr-0005Fl-W0
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 11:46:58 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sjKsp-0007rU-Nf
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 11:46:57 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2f4f2868621so67827801fa.0
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 08:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724860013; x=1725464813; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qB2tNlA469fN+yySD6uB/Djd8BhieUFfb8UEhL4V4SA=;
 b=A+57MIQq9gv+jPOTDdwru23f02bKHTEVc3FzPJMOdqYshFCBqSxmG+ungk7W9NvNNK
 QcxEQU/VIna7ovQ7gdd2hrJ03OiY2SMcNCvvLFTQNol2HbqtWDWUqNzXa3OEizwHpJwM
 VMJtMoOrOapVnqvopOoqV8Y37DQ+ykay6s2XklC6kx2gjcyGo2fmFXRbFNy7S3yMbldv
 11yKL/u9RPT8Sk2okCPCB31n7oM+/60RPVvEppgqvY7KXoQ4CyHZokf+hMZQ2sQsG7UA
 vWHEiUwzh4l/bQiFL4Sxmt+AHcPROotv/cJSc8X8tj4O3lmIbgsk5v7z6s+T8Sq0mojV
 yabA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724860013; x=1725464813;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qB2tNlA469fN+yySD6uB/Djd8BhieUFfb8UEhL4V4SA=;
 b=m7OuaHy1a8+doo49Yh1b6yvbHzdj/x7Vwj8ZlKK5bVfHOebAFrtzSG9AVZtYr+YnoW
 ADXwqIrfTdsjDT9tIXn3KPU87YdhUyWcyKh9ERVE6KwNamgY+pDjcyX2itqlYsCsMi5z
 mvEUORW1YvABDH92abuqRhtXXEYiTFMmrB5ORu06bwrbXTTLp8Ojzy68Oai6KGY2Mu9u
 D1pTMvY5z1jAlWKxr8DSVqBBdbIdtqLRng12ardWfOtgFAIvH/KmxKh5VRGZA9uSVykd
 Zkv+b2A8mMPxSeUjvMWieff9+nIra8Q79K2YwEdj1rJTFMShXZ+qelyaaGNSkpnKH1r5
 AsuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXU0U/Wl9irzJwyY9MgLdXtd6AfmBvZ/r25wXEYNh/nkuCE1oVF4KbnbhHM/I47exhLCV3cdZO5RHw6@nongnu.org
X-Gm-Message-State: AOJu0YyiIzfFsdETjhE+ueaeWqSvw3sQYi/y86dQztGUrOaLM7UugQQ7
 Gjs3vSexUfBZaMRv61Jzc6POwC2HgCDtkLzgMue6weWdGs6orvurLQ4qjh/1qzYFhTIciWR5rFz
 W5qe0FiVY30wuBkB0ryjVoFODs0I47jmSz1rmwA==
X-Google-Smtp-Source: AGHT+IEkbQHReR/F77zXRRaa/3d/90C3/LR16Zjk81Qg4liNxL5HBYfijhyrnh/L9HeSLhGugEfTWgSqCYmHafATuug=
X-Received: by 2002:a05:651c:2105:b0:2f3:f170:8ec3 with SMTP id
 38308e7fff4ca-2f6103e3093mr1220191fa.21.1724860013281; Wed, 28 Aug 2024
 08:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
 <14c38495-131f-4798-bf41-da442ede23eb@linux.ibm.com>
 <CAFEAcA8FFiiMXTcMR0WRP=Nhw3-+LYoP=X4OYrm5tnrp4L-wGQ@mail.gmail.com>
 <8050216dbbdd0762347d8e14f17d030ff8874283.camel@linux.ibm.com>
 <172467410002.31767.12365606864399178508@t14-nrb.local>
 <172483282308.162301.11735420619446380771@t14-nrb.local>
In-Reply-To: <172483282308.162301.11735420619446380771@t14-nrb.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Aug 2024 16:46:42 +0100
Message-ID: <CAFEAcA-wVqbuW1aG2fd6O9BwMKrFXTLzcvuF4xd6j_4x5WUQ+Q@mail.gmail.com>
Subject: Re: [PATCH for-9.2 00/10] s390: Convert virtio-ccw, cpu to
 three-phase reset, and followup cleanup
To: Nico Boehr <nrb@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>, qemu-devel@nongnu.org, 
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, 
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Michael Mueller <mimu@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, 28 Aug 2024 at 09:13, Nico Boehr <nrb@linux.ibm.com> wrote:
>
> Quoting Nico Boehr (2024-08-26 14:08:20)
> > There was a little hickup without the fixup to patch 2, but after Nina
> > pushed the fixup, we did not observe any failures related to your
> > changes in our CI. Thanks!
>
> Peter, after a few CI runs, we unfortunately did find some issues with your
> patch :-(
>
> Rebooting a guest in a loop sometimes fails. Michael was able to bisect it
> to your series.
>
> The problem is intermittent. The guest is unable to load its initramfs:
>
>   [    0.560674] rootfs image is not initramfs (no cpio magic); looks like an initrd
>   [    0.588605] Freeing initrd memory: 95680K
>   [    0.593143] md: Waiting for all devices to be available before autodetect
>   [    0.593144] md: If you don't use raid, use raid=noautodetect
>   [    0.593145] md: Autodetecting RAID arrays.
>   [    0.593146] md: autorun ...
>   [    0.593147] md: ... autorun DONE.
>   [    0.593156] RAMDISK: gzip image found at block 0
>   [    0.609110] RAMDISK: incomplete write (29120 != 32768)
>   [    0.609113] write error
>
> ...and then a panic because the kernel doesn't find a rootfs.
>
> It seems like the compressed initramfs is corrupted somehow, since "rootfs
> image is not initramfs" doesn't appear on a successful boot.
>
> initramfs and kernel are loaded via direct kernel boot. Running under KVM.
>
> Some vhost error messages do appear before the guest panics, but it is not
> entirely clear to me whether they are related:
>
>   [...]
>   2024-08-28T06:56:29.765324Z qemu-system-s390x: vhost vring error in virtqueue 0: Invalid argument (22)
>   2024-08-28T06:56:32.210982Z qemu-system-s390x: vhost vring error in virtqueue 0: Invalid argument (22)
>   2024-08-28 06:56:35.430+0000: panic s390: core='0' psw-mask='0x0002000180000000' psw-addr='0x00000387b028c67e' reason='disabled-wait'
>
> Any idea?

Well, the series is *supposed* to be just a refactoring, not a change of
behaviour, so I'm not sure. I don't suppose you have a reproduce case
that I can run? (I do have access to an s390 machine if that helps.)

thanks
-- PMM

