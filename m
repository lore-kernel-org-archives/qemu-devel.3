Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8A0C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:29:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE5rV-0005eU-W5; Mon, 03 Jun 2024 07:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vilhelmgyda@gmail.com>)
 id 1sE5rU-0005dt-F5; Mon, 03 Jun 2024 07:28:24 -0400
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vilhelmgyda@gmail.com>)
 id 1sE5rS-0000gX-DY; Mon, 03 Jun 2024 07:28:24 -0400
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-7e2025c3651so171501139f.3; 
 Mon, 03 Jun 2024 04:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717414098; x=1718018898; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q0HEdcb2hGyo1mBywRq8UwhI9c7HcEXBQPB1Of57/kA=;
 b=XxMMZyFo+D0NecrhG3fmfrSHU8pOBXlAls8DoZFjz6FSCX4uY2khmoYog6b/d9jCKJ
 SM96mE6QKyDlAumTngE/FafS6yb/jdxzHE5zVisf15/BZl3Y7/Iacse6XeRGa26uY/4h
 mRWc/mvy2+wD7o5gzPu4lSBLDOtaOVmvB/uKlC0Wu25VqaBBtK0DCZ8Thzo6P/5SJTB+
 jyYt5cruMPeK4zyoUevsQ3nCfOKGrLesJmp7oXupZ1HQuf50Vf3pWCKzGGDdt8sFNcZ0
 I6x9Eqp1EQcFRsV6KxGuXZnWZXA8uR2UTywzhCCONmw3FxEumMnHa/Ilwh1b+cVyJQ8Z
 bzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717414098; x=1718018898;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q0HEdcb2hGyo1mBywRq8UwhI9c7HcEXBQPB1Of57/kA=;
 b=l9plxX+PLl0FScOzA1CXBCT0B+2oOYcjgtcd6QTD80R7AkrDRJr/nGyEFBrTe73Yas
 eHH0dGD4SfoUKMxCFBE5r9Nq+e7l/nSjUk+jUISzVdNna8zNGbdaAQF4V9xctjQAWAbU
 8pPK3LYnKzrnRu/w3RqhSZCQeh8heBvpzoKtKa8E7ZyPh/isZm+BDFq5dB4GXtLKv5QR
 1mdKWd2t1hQDamsDBk+Id1R4XJV02+yBuTfEriwkVIrNd5KIygT8jlD9G9itdvBPVEP0
 MmDQorzV3WTrBVpx8yLzcQ6yEHIkVEbc6mlMl8oyDmM6FCQQK/mNliFnoSLZgkAHhdUI
 WE3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwsapoUvRerUeKZ6O3R3Y8b1pmTta/rlhgAw0fXdLQLO8B7rMZPpRZLHKlz44qzVqv5y2chxnxyBXpwQrto3O7TYy4pBBXLw==
X-Gm-Message-State: AOJu0Yw4yjz0+FSHTIxap6sgfsyx/haLYI4S1mT/HkbNlUZHpu0YvBAP
 KGwS0MiOQeku2mSZ6RlmhFk2oFwyn1fgB+Yz+xRD2czRv1avUkcvYwwDu2uMHMmUG17djMnEOH/
 apusgpywLFExTZUetsfg2N4bYhpXpKlQW
X-Google-Smtp-Source: AGHT+IEkiUycLFonQzjB0TNMgBZ5wof4FcLWcxFwL89hzyqZe8c3MnhfhA/ZdT4TrEpGQrnbLMz4uCYeW1zDjk+HrjA=
X-Received: by 2002:a05:6602:6b82:b0:7e1:542d:7b09 with SMTP id
 ca18e2360f4ac-7eaffdd31admr978055939f.0.1717414097921; Mon, 03 Jun 2024
 04:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240602103810.21356-1-vilhelmgyda@gmail.com>
 <0666159b-9e1e-4564-abca-240c518b044f@redhat.com>
In-Reply-To: <0666159b-9e1e-4564-abca-240c518b044f@redhat.com>
From: Vilhelm Gyda <vilhelmgyda@gmail.com>
Date: Mon, 3 Jun 2024 16:58:06 +0530
Message-ID: <CADe4k3+uHDwUKXLDTecO5E0UB3T2=xog1OnAYyuPqPyXje4wfQ@mail.gmail.com>
Subject: Re: [PATCH] i386: removes microvm from default build since microvm
 doesn't support Xen accel.
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, philmd@linaro.org, 
 richard.henderson@linaro.org, eduardo@habkost.net, 
 manos.pitsidianakis@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d30;
 envelope-from=vilhelmgyda@gmail.com; helo=mail-io1-xd30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Jun 3, 2024 at 11:53=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On 6/2/24 12:38, Will Gyda wrote:
> > i386: removes microvm from default build since microvm doesn't support =
Xen accel.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2294
>
> This is already done in (what will be) QEMU 9.1;
> configs/devices/i386-softmmu.mak has:
>
> # Boards are selected by default, uncomment to keep out of the build.
> # CONFIG_ISAPC=3Dn
> # CONFIG_I440FX=3Dn
> # CONFIG_Q35=3Dn
> # CONFIG_MICROVM=3Dn
>
> So we would only have to add the "depends on".  I don't oppose that, but
> also I don't see why microvm cannot support Xen.

Yeah, this is to be discussed. If it is worth it to do so. Manos wrote
about this here:
https://mail.gnu.org/archive/html/qemu-devel/2024-05/msg05842.html

>
> Paolo
>

