Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DAF2F3C995
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 15:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuuFd-0000CQ-Jp; Tue, 24 Feb 2026 10:23:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vuuFc-0000Bt-21
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 10:23:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vuuFa-0001Mv-0Y
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 10:23:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771946579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CPX1QWrLmJrKwsZUOyyX7ZJo2ruRgp6e/I/xOr8QNS8=;
 b=jD4EGjShQwyt+6f8Jc4pEUNu8Cq3T3+p5WG+ZFzm7dlEXqVt3vgiOs/JISHOyhJaApuVjM
 wE9HS8w4RH5o9gKoX4qyEFWO/fp9r8T4mIqufa8Mq7J/w4VEt/S4HwlSaJbbsfskAUCN/Z
 LUXu6L8RC5C4vP1yOYoLy3K3wVpAu/E=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-QL2s4J00MGi67omMdGPpug-1; Tue, 24 Feb 2026 10:22:57 -0500
X-MC-Unique: QL2s4J00MGi67omMdGPpug-1
X-Mimecast-MFC-AGG-ID: QL2s4J00MGi67omMdGPpug_1771946576
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-503342386a8so244613531cf.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 07:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771946576; x=1772551376; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CPX1QWrLmJrKwsZUOyyX7ZJo2ruRgp6e/I/xOr8QNS8=;
 b=fQo9TjOHhN2ryr9bY9fn3Dy50H58njNCf9BZH6phGaKVxITJpz+JWASxPSya/WG3iO
 gn0h+7XrtNyjQlwee2Cu8wQ2rSLSapVubwf7oAuIqhfLasP5AL/q6M5uLwnRYKgL3Om1
 ORe9NkgZx2MMbrTBW7cJ0lset83M7fMGzMjfiBeYtD0FHVY5IAiZD7WaKW9LS4tkrTpb
 9ZifX+br9XBCA4bwSMAp1Lut3LqyYsAXQtfAsOwT910gjwoWv9CvxOsXmI8u3s4nsNof
 yuDFUz1uIz4EjC7Sjt56IxsSj/zAiegn5HWwgdJAec4V642wfCC8QZBkYIa1P2yevINS
 aOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771946576; x=1772551376;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CPX1QWrLmJrKwsZUOyyX7ZJo2ruRgp6e/I/xOr8QNS8=;
 b=qYXtvKpddzWyDv4h7MQARQsx9z/LkiXOEAAxyrvuxTt5h4+RnIQlwa4Yinn5dyW6fV
 4HlvDV5lvv+v3cNKgGqt29Pj9IVwkxwDV4mgE3bx//DaOy9miIRSPbzHHlmG78D0n+/f
 XF2l+AZt0vBIut8ScvhYnCB3s/1vTKA4YEpRJgnzKj2aaZbdWRI5DG1rkdkUhnRE0bHL
 d92EfYvTtRkmCpQKrSfIqXKqzmnlZj6GQxPTA2rMEDUleDHOj7CNtln8ZmS7746VTVe0
 /XS/rAXOeSxg5mKUOi8W0mIpImguORzqLYn+3naotwh4ylulWKbNsrweStGPOem6b3s3
 bWuA==
X-Gm-Message-State: AOJu0Yya2NGMxBqQbqGdFUnwXTGoPQ9dwvqmNMzyh8PkRnCSjIX/zQ9m
 +B77wq8jCcx3lioiVKQbBZ7Cd/7d7Vse7J5IUh80M14/e0EYNnxugTRbG+fNrDQWKNyyjBFOWni
 k7wqnhvZ80hSS8bj/e8BDEr2w3DzfdxwKapXNwRagMqVSPDrgjvWLRLiEPHY3/fbJ
X-Gm-Gg: AZuq6aInCIh/ABD/Ojz5yOYUboce3jx1YuOo4en0v7tt5g4NDtPnOXRwFRVLQnx3hkR
 RcSGqnRe3kxYE9+oJMh4ZeJWBfN4nxh9idZV3Bn6gEGDSIhcANENMRC3xoLTebj0/1o5ZLxnCfz
 hbKXo7wPijfJIIzcAyDxmeV5z6mYM9TAXD9tyAFqStRKnXPr3SGPaNM+X6WN12Qai7F465fDuXL
 td+vQR9O+/tmWKx84MB6sz4yCc+1B4bY2QA7Ha/9ny6v4w7SQCOo/RWHNO8A9XT5iHdL6rpEqTc
 4pPGl60hvj3fbh/QcvZ5SrszH0XvmgelvV8v/XUil8DZdw6ccQC9hgKTtN6vW7DKqcG9XF8BJ2m
 p6CbgGhPOCtkUoQ==
X-Received: by 2002:a05:622a:142:b0:502:f26f:136d with SMTP id
 d75a77b69052e-5070bcebf78mr167782761cf.71.1771946576173; 
 Tue, 24 Feb 2026 07:22:56 -0800 (PST)
X-Received: by 2002:a05:622a:142:b0:502:f26f:136d with SMTP id
 d75a77b69052e-5070bcebf78mr167782261cf.71.1771946575617; 
 Tue, 24 Feb 2026 07:22:55 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5072afdef0bsm30795351cf.16.2026.02.24.07.22.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 07:22:55 -0800 (PST)
Date: Tue, 24 Feb 2026 10:22:43 -0500
From: Peter Xu <peterx@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 0/8] memory: Remove most _nomigrate variants
Message-ID: <aZ3CQw2ad5cVc-Mm@x1.local>
References: <cover.1770253186.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1770253186.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Feb 05, 2026 at 02:13:18AM +0100, BALATON Zoltan wrote:
> v4:
> - separate patch converting Sun machines from memory_region_init_ram_nomigrate
> - split helper to init ram into two functions: setup and error_propagate
> - also use memory_region_init_io in memory_region_init_ram_device_ptr
> 
> v3:
> - rebased on master after some patches were merged
> - drop some more line from memory-region-housekeeping.cocci
> - added comment to explain what factored out helper does
> - some more clean ups included
> 
> BALATON Zoltan (8):
>   hw/display/{cg3,tcx}: Do not use memory_region_init_rom_nomigrate()
>   memory: Remove memory_region_init_rom_nomigrate()
>   sun4m,sun4u,tcx: Do not use memory_region_init_ram_nomigrate()
>   memory: Remove memory_region_init_ram_nomigrate()

Could you help explain why we need to remove the above two small helpers?

Not saying that we can't remove them, but I don't yet see the point of
open-code those readonly=true setup either, or any problem with having the
smaller helpers when ram_flags=0.  Small helpers sometimes help readability.

Some of them are going backwards againist what the cocci scripts were
suggesting previously, like:

- memory_region_init_ram_nomigrate(E1, E2, E3, E4, E5);
+ memory_region_init_rom_nomigrate(E1, E2, E3, E4, E5);
  ... WHEN != E1
- memory_region_set_readonly(E1, true);

So you suggest open-code instead.  Why?

Is it required for your follow up cleanups?

Thanks,

>   memory: Factor out common ram region initialization
>   memory: Add internal memory_region_register_ram function
>   memory: Shorten memory_region_init_ram_device_ptr and
>     memory_region_init_rom_device
>   memory: Factor out more common ram region initialization
> 
>  docs/devel/memory.rst                         |   9 +-
>  hw/display/cg3.c                              |   6 +-
>  hw/display/tcx.c                              |  11 +-
>  hw/display/vga.c                              |   4 +-
>  hw/sparc/sun4m.c                              |  15 +-
>  hw/sparc64/sun4u.c                            |   9 +-
>  hw/xtensa/xtfpga.c                            |   4 +-
>  include/system/memory.h                       |  49 ----
>  .../memory-region-housekeeping.cocci          |  47 ---
>  system/memory.c                               | 269 ++++++------------
>  10 files changed, 120 insertions(+), 303 deletions(-)
> 
> -- 
> 2.41.3
> 

-- 
Peter Xu


