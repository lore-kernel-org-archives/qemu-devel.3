Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6AA2C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 13:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOcwU-0006ZM-Kd; Mon, 09 Jun 2025 09:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1uOcwT-0006Vn-3L
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 09:53:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1uOcwP-0003TN-Sp
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 09:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749477210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1b2gd14zEq3qj6mIs0BabRlM+kwHMD4d6RI98T2kfUw=;
 b=VL663vc1vJrw9BClP6NbE4mXx+grZwK+Y7agWbhs6J0uH11OIHE1aVcWgHP8JVnfTWXuTP
 Gp3WasUxquNUN8vEbP2aw7fRMGE9lFoOEx+JBnnnzbJ5vc2e/YFzXTd0bU20+Nx8RwpTYm
 3jZ8FaoAgem40Ko0/rq9scmCAqm9QvQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-0_jxT6B3M7OowOZOsGjayQ-1; Mon, 09 Jun 2025 09:52:24 -0400
X-MC-Unique: 0_jxT6B3M7OowOZOsGjayQ-1
X-Mimecast-MFC-AGG-ID: 0_jxT6B3M7OowOZOsGjayQ_1749477143
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4a6f4b20944so30493731cf.1
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 06:52:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749477143; x=1750081943;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1b2gd14zEq3qj6mIs0BabRlM+kwHMD4d6RI98T2kfUw=;
 b=UOaohHqVsPFxa3SNYekHfN1xaL9XJFSEV7I/kVvn2sAsHOxC1CHXhD3DJelwhSCF7b
 pDrSNxEW5o3rRPJ5HznZDHZQot92n0U7XR8dWQiiWVU48HdhCMzL9gZNBDQGJ9mi1iGn
 g56J0/9P2V7aE3ARfVyTNqiU+bWHl3LQ8AOZ0dtvU/Jr96cY1MjGHhY2z6tAnGlM+T/O
 EZc7+QK81U2KFaV8RZhxv8s7/9Wht8DhioIeEUZVGYHgxC1DoeiQP6D/uGeZNuCrsmms
 BOSIYlNgyQygeQcqVmfdf1zkdDR72jZHk/uNkhZx7Lg8mLLMwL6tZK0re2CeqkbgxLiL
 hXXA==
X-Gm-Message-State: AOJu0Yys9JcTXLxMz/qTfwzKLuhr96A0PeY4zwCcEFEYnoYIFFhZhJNG
 qstYwF/YJ2m11WLEhUoEu2WbhVvuIgAsLWZ12tB9Cn5ATg4llGusXTj4emg6pn49i4SemqT4fJy
 GR4+1o7YMnxwyoqJlyB5eEzpX036SipzsjaEDihjgnN3hh3Bqhv2T/Ek9AY0l3pz4xCBRTbLE4u
 +RO5s23XmHOXcVtCJSQVomRN4H1rdwtd8NUFHji0c=
X-Gm-Gg: ASbGncvYGSdGkigI/PweYlgXBFRTZ3cSx8zc53tUDBl/t6co2GVP4oEt8YnKYE3UgUm
 pSEBWHxBGCxf0OWxj0W5JBoCCAVsLvNmKo/utoCYq/tAnJ1eDj9DzUaBkVAlGli+q6CgEDshxz2
 qdF0Q0
X-Received: by 2002:a05:622a:5909:b0:4a5:a5df:d1f9 with SMTP id
 d75a77b69052e-4a5b9db110fmr241551631cf.43.1749477143209; 
 Mon, 09 Jun 2025 06:52:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGinLPy/iBjgcnVFpXICny2Ewz1NLrN+E4anKqajjJUI+2t36R5LkueoTFnvPN+mK9pEfVl/35eW8UR25QyCFQ=
X-Received: by 2002:a05:622a:5909:b0:4a5:a5df:d1f9 with SMTP id
 d75a77b69052e-4a5b9db110fmr241551191cf.43.1749477142786; Mon, 09 Jun 2025
 06:52:22 -0700 (PDT)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Jun 2025 06:52:21 -0700
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Jun 2025 06:52:21 -0700
From: Andrea Bolognani <abologna@redhat.com>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-94-richard.henderson@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20250415192515.232910-94-richard.henderson@linaro.org>
Date: Mon, 9 Jun 2025 06:52:21 -0700
X-Gm-Features: AX0GCFtc2Shz74OSRmQ-Nq3PKNc37RC043aE6uMuMNyUX28kBIytjo4ViPJDPMw
Message-ID: <CABJz62OFyaXitSdge4M9_oTk34a5aocLJLFYfkOGXc0BToOgVA@mail.gmail.com>
Subject: Re: [PATCH v4 093/163] tcg: Convert extract to TCGOutOpExtract
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=abologna@redhat.com;
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

On Tue, Apr 15, 2025 at 12:24:04PM -0700, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/tcg.c                        | 20 +++++++++
>  tcg/aarch64/tcg-target.c.inc     | 28 +++++++-----
>  tcg/arm/tcg-target.c.inc         | 23 +++++-----
>  tcg/i386/tcg-target.c.inc        | 77 +++++++++++++++++---------------
>  tcg/loongarch64/tcg-target.c.inc | 33 +++++++-------
>  tcg/mips/tcg-target.c.inc        | 35 +++++++--------
>  tcg/ppc/tcg-target.c.inc         | 35 +++++++--------
>  tcg/riscv/tcg-target.c.inc       | 54 +++++++++++-----------
>  tcg/s390x/tcg-target.c.inc       | 14 +++---
>  tcg/sparc64/tcg-target.c.inc     | 16 ++++---
>  tcg/tci/tcg-target.c.inc         |  8 ++--
>  11 files changed, 191 insertions(+), 152 deletions(-)

Hi Richard,

this seems to have introduced a regression when running on a riscv64
host.

Before the change:

  $ timeout --foreground 1 \
    ./build/qemu-system-riscv64 -machine virt,accel=tcg \
    -display none -serial stdio 2>&1 | grep -i opensbi
  OpenSBI v1.5.1

After the change, no output is produced.

This causes the

  qemu:func-quick+func-riscv64 / func-riscv64-riscv_opensbi

test to stall and eventually fail due to the built-in test suite
timeout kicking in.

Interestingly, I can't reproduce this by running the exact same
commands and using the exact same git commits on an x86_64 host.

Do you have any idea what could be going wrong? I'll happily
investigate further if you give me pointers.

Cheers.

-- 
Andrea Bolognani / Red Hat / Virtualization


