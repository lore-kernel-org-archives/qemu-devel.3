Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3563DC25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 18:16:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4PLP-0000VG-5d; Tue, 07 May 2024 14:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1s4PL6-0000NN-Dl; Tue, 07 May 2024 14:14:58 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1s4PL4-0002l3-Nr; Tue, 07 May 2024 14:14:56 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2b2bc7b37bcso3001509a91.2; 
 Tue, 07 May 2024 11:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715105692; x=1715710492; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=darRKVJjCTh+cD23wYc6yj8pxz31pAEK6v1QtVB0M70=;
 b=Jwkw/EAPRiz7nN9DsqEvjHnQZgzJHJ4zz08iKDiRKLLherHzimiijxYqE8kXuN7FWw
 jiwpZzFRSfhZ47m9CBLFifi/tl6t1QqDdSj4HaFBk3GOFJXvkxNE5cJ7D/l/wj4C5LIW
 0D5Z0kIZixiU8zIl/aJNgtwy2IKbR3Vx6F4J6sthUX7hVkRMOex0dIZMQz420zCqosk5
 tVMymprWq1Pf88rAA/BOdMGVBhGQs3gKIaGYT1l/sTY2jSMqmiEqhYhk/anRafoLftDm
 FvU35AbRxHUV9/NXSagm+IBvNdiDqc3f3G626Qpj/9SL5BHwzV4cDFodOlteUZuQuzkp
 mfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715105692; x=1715710492;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=darRKVJjCTh+cD23wYc6yj8pxz31pAEK6v1QtVB0M70=;
 b=HqI88dQsRj1f3BXOphtAZnW6p9z0FYQlmd1HN3n5xoPkHL5zZYnKP+usBgx6obrcqk
 XOyWeMBpgzm7WOTfUS4uswa8ahKAZCTn/AmiI5yNrRdDAkYFuU2+0sF1D+UiCp36k+cd
 mcdkxViK33cyj2kJ8K98QEaCyz1C2QvDk1sW6OTL2YS1uvHOEFJN/o6Z1on0hib88+//
 e9iVQe4ginzPmX/m5JQkej3hk5+hfF9SZ4AKcAn8IEU04pXePmbIED0Zw+43c+imb/6w
 Ec/lDrkep6orj5Nhfgc5o3k+LrIfQ4CL7Hs7KZVfqDaIxLo6xmm7vey+LLPP7Vlbsn8W
 iibQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWL8gntgVs41nxBHZmXXfBMKw4JjkvkN6gf164IYsXq2kE4ZGOsxm9QVyV+QNQHgjM1S0uNZabcjYc97KCPEuvSqPOqaE=
X-Gm-Message-State: AOJu0YxWq48zsX+dB54E51RTfeaH7u1acOT5w4tIAWZDL+2ewbj2CGjP
 O6/kZksXj1Qw7ZSJqpjkU5MTG/qD6tstXwnplxTqLjwC3elMmf03ixKJ9l/BxTQVArqr2PX0U6b
 v2iTKY13woYdR0RFne4h1MJGE94g=
X-Google-Smtp-Source: AGHT+IGi5+TltaTG8F2lnd0BtV8c0TpqOS/2TOFE/OQUPELYuQXO7mXygvypLPW9c7NS6/N5OcuNmGpO3v5K8hGCSzs=
X-Received: by 2002:a17:90a:598e:b0:2b2:81c0:4d85 with SMTP id
 98e67ed59e1d1-2b616be550dmr298586a91.45.1715105692203; Tue, 07 May 2024
 11:14:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240507180558.377233-1-stefanha@redhat.com>
In-Reply-To: <20240507180558.377233-1-stefanha@redhat.com>
From: Sam Li <faithilikerun@gmail.com>
Date: Tue, 7 May 2024 20:14:25 +0200
Message-ID: <CAAAx-8JOSj6qqmbqk-gSBi0Ksxa_bJ=rvyM69nb_y1rr4hPpxg@mail.gmail.com>
Subject: Re: [PATCH] qemu-io: add cvtnum() error handling for zone commands
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=faithilikerun@gmail.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Stefan Hajnoczi <stefanha@redhat.com> =E4=BA=8E2024=E5=B9=B45=E6=9C=887=E6=
=97=A5=E5=91=A8=E4=BA=8C 20:06=E5=86=99=E9=81=93=EF=BC=9A
>
> cvtnum() parses positive int64_t values and returns a negative errno on
> failure. Print errors and return early when cvtnum() fails.
>
> While we're at it, also reject nr_zones values greater or equal to 2^32
> since they cannot be represented.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Cc: Sam Li <faithilikerun@gmail.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  qemu-io-cmds.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 47 insertions(+), 1 deletion(-)

Reviewed-by: Sam Li <faithilikerun@gmail.com>

Hi Stefan,

Thank you for fixing that. I've been a little busy with moving house lately=
 :)

Sam

