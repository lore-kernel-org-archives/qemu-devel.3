Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE055C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 20:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfQNm-0002tV-3l; Wed, 28 Feb 2024 15:18:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfQNi-0002sE-Vo
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 15:18:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfQNd-0004jI-Tv
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 15:18:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709151496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7V1Yw4M0UNjoVEOnQCXCEjVsqFjY7WDyGGYkQ1+l5QY=;
 b=EHv2NghJB+Zwxx7+RVtgXLCfE4UO2JIXeUgAmd3iF5A7yMoufUi3yCQFwxDCWYg6VB6Q8c
 ZePdfvnNc4iNIQxjkrpkqLhVk/Hv7wtV3gRaHKNXu9SgsGN1XaWAVAH1OljFmGGnkKphRB
 gUGLeIILpRY50Ssc0LLZju/ZeaZ00xU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-U-VxMpYYMJOREGXli3nNKg-1; Wed, 28 Feb 2024 15:18:15 -0500
X-MC-Unique: U-VxMpYYMJOREGXli3nNKg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-41297aeece5so523705e9.2
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 12:18:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709151494; x=1709756294;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7V1Yw4M0UNjoVEOnQCXCEjVsqFjY7WDyGGYkQ1+l5QY=;
 b=QWKlQaX7W72q43C58jl/gVsB8DqQxdnNRnT69SrFG6VAAjUlqNDg1tUcmxpaLx7S7q
 WMI/JhEcSWd0wnvT9IpfyQV0mOGmcIB0DSR1PAZXVPMV+pw/thP1p0nvqjVx6/H85Yvy
 aCWMggtdEjgaHTZsNIBy7qc6hAfjarUuBtbMLBDfaGPQwA9HoYNRAA0sSzYJ/W49RRFf
 R1pqPvkxFbUoBMpr18bax7YwCqQypyqItAfnZg0xougE2eKIj5ZgDJsvSAVx96n5YNG2
 i21rrx2hjn65sbQSg9ukImKN4z1jVX090k4TUVYyg+0uFHM6PPeW3kosiSUSu3Gfaxzs
 k0SA==
X-Gm-Message-State: AOJu0Yz8vSNPJNtykwTXQRgINHdQUT52FYgf15qUiEvVd4Pd3t15QdAh
 wolewbjFNhBYuVly7U5lS9j0wz42DK7W8sTA+Gm2LXVjKA6F+qgp2RdhC/9aRWzOx3lq6N/Zt2T
 lgJ9ZP1CDGD8pWaJBm2gd7CcZNiGJA4Pzt+FAp3cVRXWVbz6zepKti0HlEe5P2nEkOyfbNQYO2k
 ArMYyfH7ofJryhiB9iJR/hcXbSDNT0njhDUok=
X-Received: by 2002:adf:e703:0:b0:33d:2b3d:a02e with SMTP id
 c3-20020adfe703000000b0033d2b3da02emr502043wrm.46.1709151494015; 
 Wed, 28 Feb 2024 12:18:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnEAHHFEDSk7a/SqEIggqj6n0GxCv7yAK48ucZzWDz0xx3u76pDh+4AM12FP/2HQ2m4AjGWtzlLX+UN9LbQUo=
X-Received: by 2002:adf:e703:0:b0:33d:2b3d:a02e with SMTP id
 c3-20020adfe703000000b0033d2b3da02emr502033wrm.46.1709151493728; Wed, 28 Feb
 2024 12:18:13 -0800 (PST)
MIME-Version: 1.0
References: <20240228080646.261365-1-pbonzini@redhat.com>
 <20240228080646.261365-7-pbonzini@redhat.com>
 <22b4b31b-ff24-4c54-b523-3fdc5479aacf@tls.msk.ru>
In-Reply-To: <22b4b31b-ff24-4c54-b523-3fdc5479aacf@tls.msk.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 28 Feb 2024 21:18:02 +0100
Message-ID: <CABgObfZ00ufqvYZXDKXNzgpC2=-bh3Ltu8eCJmfgAnkgoS_xuQ@mail.gmail.com>
Subject: Re: [PULL 06/10] target/i386: Fix physical address truncation
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Michael Brown <mcb30@ipxe.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

On Wed, Feb 28, 2024 at 7:14=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> 28.02.2024 11:06, Paolo Bonzini:
>
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 647371198c7..ba6d7b80a7f 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -7732,7 +7732,7 @@ static bool x86_cpu_has_work(CPUState *cs)
> >       return x86_cpu_pending_interrupt(cs, cs->interrupt_request) !=3D =
0;
> >   }
> >
> > -static int x86_cpu_mmu_index(CPUState *env, bool ifetch)
> > +static int x86_cpu_mmu_index(CPUState *cs, bool ifetch)
> >   {
> >       CPUX86State *env =3D cpu_env(cs);
> >       int mmu_index_32 =3D (env->hflags & HF_CS64_MASK) ? 1 : 0;
>
>
> This is an interesting change.  It looks like previous patch
> broke this very line, and this patch restored it.
>
> This is an unrelated change to the problem at hand.

It's a rebase hiccup, indeed. :(

Paolo


