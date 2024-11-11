Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D3CD2E9DA
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 11:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tASFA-0004Xe-Kj; Mon, 11 Nov 2024 06:06:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tASF8-0004XW-K1
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 06:06:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tASF6-0001cA-Gq
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 06:06:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731323158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hIWS1E8y6jAYBYNG8p/0XGvmnHTOuv7bZwZv5OzRbx4=;
 b=gPRZVKfiygovmvBthqaJ4EJ/8ZV97uIaN1K+Tg84HhA74kzI3gN1/pID7ujqph2K9q4WR8
 aWypsiMURUiWSqtT3NBqMVCqQwEKY3WonngwRljaPpObWxzsu5rJ+tRGvZs6oI1D6JLdUi
 Xr2Fx3ElBIhRInbdcEneCzP8/Iv93w8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-6mRln1_wPHKUMHBrLJ1g0Q-1; Mon, 11 Nov 2024 06:05:56 -0500
X-MC-Unique: 6mRln1_wPHKUMHBrLJ1g0Q-1
X-Mimecast-MFC-AGG-ID: 6mRln1_wPHKUMHBrLJ1g0Q
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4315d98a75fso34069295e9.2
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 03:05:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731323155; x=1731927955;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hIWS1E8y6jAYBYNG8p/0XGvmnHTOuv7bZwZv5OzRbx4=;
 b=mG7UlcPcuYKqia7qr9F6Q3IspvlFAYPAcnb0YEAlDPM+MlKJ3L4NqZ3umLH9d+jR2e
 GSnRT7vW/LkUyDDIQL0IIH+JEl4rSy9WQFVDVKZHGy6kM3bywsd48yh4uIPfa7vbraB8
 hFfLfB1TcWWAfoKTIuqNYNRTzvLPIzZK7mHdsGpvjFmFvY7D/CUv1WXRhIacIXYcRnZV
 G8nDu9Mp7k1iTUe9I3sJ07Tyr3N0WJ6JQyBVXoqLyLVP1oO8txHewWMZS8B90fhcC43p
 OWam74FkN6HlTxULzGAyLc1f1LpKneIIqz7pBp1WvtyiZFKKLjB4BAo/mTGD8yXtkXh/
 lk8Q==
X-Gm-Message-State: AOJu0Yz6ei0tFON6gtuWeha26ZpP6b+jp76EDJo1e/72Z6FZOZx7mm0g
 HVifs9aHtM1TyfZKGSnkF5zfA0PPupQUfTOz3MSLTdukrOjO2fXiFPozHOVBQyedsmb5+QqM08e
 oNrKg1jLyUbsez43683aTdgQBA19jls1x/Oku3z8KAbBeM8F04i4Kp1ZGDtHH9cPQUzSsp+pKNP
 Y4ykMqRUrBCLFQsBZe7x5ieXhGapw=
X-Received: by 2002:a05:600c:4709:b0:431:1d97:2b0a with SMTP id
 5b1f17b1804b1-432b7506641mr87679085e9.15.1731323155314; 
 Mon, 11 Nov 2024 03:05:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGksghRoZ3HZA77q3F0tHA+eXXdvbPLbRYYvMtAdMsBI6UbVB+Ge71/qi/cuXKsG4ZXVKlpDoHloCP38LlsPIg=
X-Received: by 2002:a05:600c:4709:b0:431:1d97:2b0a with SMTP id
 5b1f17b1804b1-432b7506641mr87678875e9.15.1731323154930; Mon, 11 Nov 2024
 03:05:54 -0800 (PST)
MIME-Version: 1.0
References: <20241111105506.264640-1-thuth@redhat.com>
In-Reply-To: <20241111105506.264640-1-thuth@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 11 Nov 2024 16:35:38 +0530
Message-ID: <CAE8KmOxO7DcEp=8AOT8jM0C=2DuCS8pgm73F5A3DPCNTEOoOow@mail.gmail.com>
Subject: Re: [PATCH] docs/system/bootindex: Make it clear that s390x can also
 boot from virtio-net
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, 
 Boris Fiuczynski <fiuczy@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.118,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.743,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 11 Nov 2024 at 16:25, Thomas Huth <thuth@redhat.com> wrote:
> Let's make it clear that s390x can also boot from virtio-net, to avoid
> that people think that s390x can only boot from disk devices.
>
> Reported-by: Boris Fiuczynski <fiuczy@linux.ibm.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  docs/system/bootindex.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/docs/system/bootindex.rst b/docs/system/bootindex.rst
> index 988f7b3beb..5e1b33ee22 100644
> --- a/docs/system/bootindex.rst
> +++ b/docs/system/bootindex.rst
> @@ -53,7 +53,7 @@ booting.  For instance, the x86 PC BIOS boot specification allows only one
>  disk to be bootable.  If boot from disk fails for some reason, the x86 BIOS
>  won't retry booting from other disk.  It can still try to boot from
>  floppy or net, though. In the case of s390x BIOS, the BIOS will try up to
> -8 total devices, any number of which may be disks.
> +8 total devices, any number of which may be disks or virtio-net devices.

Looks okay.
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


