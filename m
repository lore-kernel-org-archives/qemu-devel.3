Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17382C677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 12:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPKPX-0008EN-LQ; Wed, 11 Jun 2025 08:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uPKPV-0008Dz-If
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 08:18:29 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uPKPS-0007Zs-Kp
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 08:18:29 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-601dfef6a8dso11485507a12.1
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 05:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749644304; x=1750249104; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7uR241IcqfKLYE95UiAd7frDVEkDQ7vELA4thWeKapM=;
 b=pytxGZZyKmbJdaQpVtYosMDFBfWsxigRfxF8lhs8UJdSaI+6foYTpIKg/HtiLAbYfW
 Lno17+XTKFcim0dyu26xS9E538Ffb0U8bBj5Rm1qh8CSq10qgOmkAtZqDFwfiVr9l8ib
 7crf83y5yyibb2NjeyYnO3nCknPjAqX+x1yBZGQU6osawQqzndQphKr2OP8r6Z0JG0Lr
 QdnHC5dFI/eMt6mfeK+MYwllXpgFf+p8y3jWDyAuLIkJKmwHJ36nNxEAUg9DnXPgLHXi
 5qVeyKfBKWg1yKWZG2Cu6DSJXm6KLA8+XuFTMktIkNid71U7WMmMt+fb73cBb5XhFQLc
 I6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749644304; x=1750249104;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7uR241IcqfKLYE95UiAd7frDVEkDQ7vELA4thWeKapM=;
 b=vHp1Vbda+Fu4kq5Vl/v1B03qcQYKcIMhykXkbncEYj7zJ3IloDaY1jybZTItg+cSGP
 jS0wf6gYgzZXAN66g3ChmEt+AzkVtOVKwtlN3byNNuAw3eQkUWcfOivkF4DS7YVZnW67
 ru7hjhoXgZk2EZr6n0jEmbUmf/P9Q+PZT3yMcdA0ORcvzKWs33x9ZO4pj6eb/XMwK+Dl
 sf4Ta/iwDctolwS3qPCxieVf9Al9smWBu/JAQXkIenTPsPnqyReNimeqwbLa7YsnBQYp
 5LfzhuWkihaKzOAWh719dR7vL/vjQPZb1vCVC184PocbYoYxy5k1tK5q26VPdKvK0BPE
 2RNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKNnCxAhrviNAacJhlLosFfzC+cSQd/MAaegPTfLr1Uabj4nTWcWbe08DP8cvfvhPLCi6tpYunQjHN@nongnu.org
X-Gm-Message-State: AOJu0YyQTSXJi/Eu476LmoytNLmdhTduwJrYKVXhLBO8sNBj41+/x6Er
 jT3xTKOB+uSNoFKDtMC8DLLeII4jznWU2weOaTFJw1C6J76uk5ohiNYTHTv8w8R9nzJWl1WBNZC
 DS+pTO3Rd0je6SHH8YyAcTkfNDatPRh3p6HEHNdSe4g==
X-Gm-Gg: ASbGncvj/t98ARGM5FRR748NFEerZfGMYL1o/vpM7ZEemQe91INgvK0UCdcno/gP0bD
 oeOPjmriXsOdldGORSL5nBtGlNqv0k+y3DkpQA1X6v8/sCgkB9ID9IbQLN/T0k+iVWwE0MBegiT
 mxLN59BmNJnAHwD9oQ9B59Pa4Xy1+az56xaKCJcNR0m66geZRNYBp8
X-Google-Smtp-Source: AGHT+IF2capRDFDndMArNWrti0+WDfXgpWYmKKQ0Ne3/64MicG+Qwx4TaHRmT7NNhyArjcAT8ZWSviQD7eqC+meljVU=
X-Received: by 2002:a05:6402:26ca:b0:602:225e:1d46 with SMTP id
 4fb4d7f45d1cf-60846abeda9mr2956769a12.3.1749644303823; Wed, 11 Jun 2025
 05:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250610202110.2243-1-shentey@gmail.com>
 <20250610202110.2243-2-shentey@gmail.com>
 <CAAjaMXbtcyB3J3AvGh8ZW3MSi41uMaE+TkZwipCs5pg6wvYJ=w@mail.gmail.com>
 <CABgObfYgoYBJmZjin_Wj8JeEviFMM+vFa_QX_8Np+1n9apq4kw@mail.gmail.com>
In-Reply-To: <CABgObfYgoYBJmZjin_Wj8JeEviFMM+vFa_QX_8Np+1n9apq4kw@mail.gmail.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 11 Jun 2025 15:17:57 +0300
X-Gm-Features: AX0GCFv1eTdqet1u8LBX8UHVvFtF6ksoPXLe1jeXIpf405FnKWGyJx8sLJB--F4
Message-ID: <CAAjaMXZ5S7GUPmhwxsyuVmF4tvUh3vgjnK8OLKv-A+h7JCPqBA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rust/qemu-api: Add initial logging support based
 on C API
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Jun 11, 2025 at 2:05=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On Wed, Jun 11, 2025 at 12:57=E2=80=AFPM Manos Pitsidianakis
> <manos.pitsidianakis@linaro.org> wrote:
>
> > Maybe we could take this chance to remove the requirement for trailing
> > newline? Not urgent, and also something we could change afterwards
> > anyway. We could also introduce log_mask_ln! macro but now I'm just
> > bikeshedding.
>
> Good idea; there is no "formatln!" but I think you could use concat inste=
ad.

I think `let formatted_string =3D format!("{}\n", format_args!($fmt
$($args)*));` might be sufficient, but I haven't checked it myself

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

