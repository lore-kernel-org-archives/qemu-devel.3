Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4081CC7EE30
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 16:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUpLP-0008Il-Ml; Thu, 26 Jun 2025 12:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1uUpLN-0008GI-Sj
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 12:20:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1uUpLL-0006ff-PV
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 12:20:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750954853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mibrzmvrz5XGlavJ78bUtxsGtdBP7YPz+yoHAlVEcb0=;
 b=OFjMR6J8+KfuTBLM2NTXocPUDE4Ec076cHZwGCV1SF4cZgh8g0nbAX4eAHapipmJeV1WoR
 NGSuXKr+AhUKd9Xg6ksinNUxUtO4IzQrhnTcbAdjBGfVCiYIHZ3JeaJFKatKPfPEllwoNG
 QBOpdggJgYFsNOAVdEpP+VzOYD9TZr4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-o-FRlQ5HMHKWjxO97Sp0QA-1; Thu, 26 Jun 2025 12:20:50 -0400
X-MC-Unique: o-FRlQ5HMHKWjxO97Sp0QA-1
X-Mimecast-MFC-AGG-ID: o-FRlQ5HMHKWjxO97Sp0QA_1750954849
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7d097fd7b32so308540585a.2
 for <qemu-devel@nongnu.org>; Thu, 26 Jun 2025 09:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750954849; x=1751559649;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mibrzmvrz5XGlavJ78bUtxsGtdBP7YPz+yoHAlVEcb0=;
 b=JC8qCfWWN63UDH8t8+G4lRvEKKkHXiRZR56L7TKFkNHBaglaWbftrLqwgws3KHsmjg
 U57N8CFC+8JYwl1py1jltlTMX3yt6QmhCbflbB7HbrpCZL0Bz4ywBGIpJugWgSC2nK/V
 VAo/ukGPtLDTihP5TvIj08ZVk5i2wu5eTzGL0v5GiGUZhMvef7IJv/8A47X478GItXz8
 YgaU0KrXkZ1IH9e5RmrMznFspY9aHkUUo+qibsazaUox7EGMoGwXQJcHXWFr0pRGG5Fd
 +e9uHHdvFaDQWx+CbSpRIhoc2xAm/N9GoUMLBvRoo00dcHvRsmiWStXuJ4qPG4Zb9i/x
 9Zew==
X-Gm-Message-State: AOJu0Yxpsyy93K9/YauK2mbD1DNpTITAMbBi/UOXV1m23vEPVGUViPpu
 c7OlDokbRT2GAbzrWlxuchfm/SUvZ74qchfNPO0zPXDBGarmt/wO67P9sdHxIShDyGAhcGH9GCe
 EwCIEh5g0jYF5WO4WnQGVUjMxN5+R1b7Xqn3HHg+qQt0Ut7Jnn11fttEiILHyUY8HlEwtic73IZ
 jNPjDVMfArFKi7sd5vCpIiy2YlhRJYfZU=
X-Gm-Gg: ASbGnctWX8aewx121JHt8CzfBtndshNe3LvVu2K3aEVNRSa4LRINiwq5ff5u0jB7KXS
 3/op9GGPAniDcNcbgEXYseJqpLjGnFCHpeWc4QG3KMqyxO3nwM2eMdVW0OReXcVM3npRxHlk6/5
 v2
X-Received: by 2002:a05:620a:178e:b0:7d3:8ca0:65c6 with SMTP id
 af79cd13be357-7d44391a4e6mr19449085a.20.1750954849418; 
 Thu, 26 Jun 2025 09:20:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMnZSXXyWIEgf88nbSd7nBnGzjB2XzZhexT5yHsUwuXJfs7G3qNiV3phVPOCcVqPO/ybZe+j6Od4vfplKahNg=
X-Received: by 2002:a05:620a:178e:b0:7d3:8ca0:65c6 with SMTP id
 af79cd13be357-7d44391a4e6mr19445385a.20.1750954849023; Thu, 26 Jun 2025
 09:20:49 -0700 (PDT)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Jun 2025 09:20:48 -0700
From: Andrea Bolognani <abologna@redhat.com>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-94-richard.henderson@linaro.org>
 <CABJz62OFyaXitSdge4M9_oTk34a5aocLJLFYfkOGXc0BToOgVA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABJz62OFyaXitSdge4M9_oTk34a5aocLJLFYfkOGXc0BToOgVA@mail.gmail.com>
Date: Thu, 26 Jun 2025 09:20:48 -0700
X-Gm-Features: Ac12FXxBNO3k6BieMMEOTIDO0pBJZdkIDoF3AF3CD3HViVwezSpurTu2xAIhPlg
Message-ID: <CABJz62OMmmbDjWpp6YkXu2d+hB4HeShgqaa05ZigAVqNQSwjZA@mail.gmail.com>
Subject: Re: [PATCH v4 093/163] tcg: Convert extract to TCGOutOpExtract
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Jun 09, 2025 at 06:52:21AM -0700, Andrea Bolognani wrote:
> On Tue, Apr 15, 2025 at 12:24:04PM -0700, Richard Henderson wrote:
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >  tcg/tcg.c                        | 20 +++++++++
> >  tcg/aarch64/tcg-target.c.inc     | 28 +++++++-----
> >  tcg/arm/tcg-target.c.inc         | 23 +++++-----
> >  tcg/i386/tcg-target.c.inc        | 77 +++++++++++++++++---------------
> >  tcg/loongarch64/tcg-target.c.inc | 33 +++++++-------
> >  tcg/mips/tcg-target.c.inc        | 35 +++++++--------
> >  tcg/ppc/tcg-target.c.inc         | 35 +++++++--------
> >  tcg/riscv/tcg-target.c.inc       | 54 +++++++++++-----------
> >  tcg/s390x/tcg-target.c.inc       | 14 +++---
> >  tcg/sparc64/tcg-target.c.inc     | 16 ++++---
> >  tcg/tci/tcg-target.c.inc         |  8 ++--
> >  11 files changed, 191 insertions(+), 152 deletions(-)
>
> Hi Richard,
>
> this seems to have introduced a regression when running on a riscv64
> host.
>
> Before the change:
>
>   $ timeout --foreground 1 \
>     ./build/qemu-system-riscv64 -machine virt,accel=tcg \
>     -display none -serial stdio 2>&1 | grep -i opensbi
>   OpenSBI v1.5.1
>
> After the change, no output is produced.
>
> This causes the
>
>   qemu:func-quick+func-riscv64 / func-riscv64-riscv_opensbi
>
> test to stall and eventually fail due to the built-in test suite
> timeout kicking in.
>
> Interestingly, I can't reproduce this by running the exact same
> commands and using the exact same git commits on an x86_64 host.
>
> Do you have any idea what could be going wrong? I'll happily
> investigate further if you give me pointers.

Hi,

this is still an issue as of f9a3def17b2a.

Any idea where to look?

Thanks.

-- 
Andrea Bolognani / Red Hat / Virtualization


