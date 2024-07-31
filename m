Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31946C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 14:50:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZAdy-0002S8-RJ; Wed, 31 Jul 2024 10:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZAdx-0002Og-Vq
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 10:49:34 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZAdw-0005by-Dv
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 10:49:33 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5a167b9df7eso9360666a12.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 07:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722437370; x=1723042170; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5NuSlD5hyOsRMOR77RKasUNaEXrV0ltqiuv56Yepehk=;
 b=Cg3JFNDsrkR2VKrb4W2z4YxNvHoIXKWOTHP/R2AyQWqI7SZbndxyJhVzXqurjDzH0i
 cDDxKXGwwnmAdWVDXWx+/8crF8jcp+zBP8WOFm0YTMh0+WSvamh8tVLScg6LAl6T1qtw
 VYtmy0GQdkFn2tuOpTaVW1MHWEL9YStlsaVDj6hJzVqxfaP6oHLMY6nimbin2gsMr7Ua
 jp5PStQe+vbZEkIHScly6eijh6FNN4YrbDOitYvapjrrSQbH5RGVKXB513D/RXbt6g1A
 5Ksl0Ho+sVfyp3UsQSWE75SYHMIZNjsKvP47L6R24pk6a8k6puVCQ2Oj1ICZsGlOKonI
 ICSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722437370; x=1723042170;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5NuSlD5hyOsRMOR77RKasUNaEXrV0ltqiuv56Yepehk=;
 b=clAZy8yM2n4Rv/NlnxCvYYgL0SUV5LrX/raZYAs3HmhknBXhFzF8wsD7As2gxUXQSI
 X0efEtdwGn3XWdn5GqeBr4vRm4pfdCiRJ53k2HIikLsNmJpKXeUs15L9lkdGWNnJT1XY
 Wx6Xis6HxEg0AMH0/mFSM0fZwCZf7XmUf74QpJUFDcNzLUJ0T06tuos7ZydI4LPAZVGL
 XIDdYEV1K3BNYzQO7mA1bmY4mqql7Y4ODY14DP89MXfkDjRxJmX3BkWVMIQz/wAsd8hC
 61vRLYTdIID1vIGwcEeNTXotUnJck1rQNjmfx0oX8gZ1D6h1trvEMjZpyXOTUpIMm7GH
 EpUw==
X-Gm-Message-State: AOJu0YyMWZRrtCssPvPN4qirR2GCwzC7vMdb40AnZF8eDwQDbZ/PoSKi
 BsOk53ANx5D5XLRxeqZOdAufOJwm/7ABxa25yPKCb0fHtdzvxCXsnYHxk6brRJuTf+BMp9xe6yM
 P3OrkAyVhY53AX6b2gJW1Rf+e86yefapr2DNdsA==
X-Google-Smtp-Source: AGHT+IFM6j/vsu5ZOQg3Smgz1SodAwiBfFFwAVfbxOZBQW2JqyYnY6YJsGRS14oX1NaKy620nVRsAFRTX1BDQUVq3O4=
X-Received: by 2002:a05:6402:34d2:b0:58c:eee0:4913 with SMTP id
 4fb4d7f45d1cf-5b021d22aa6mr9923226a12.27.1722437370170; Wed, 31 Jul 2024
 07:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240731143617.3391947-1-peter.maydell@linaro.org>
 <20240731143617.3391947-5-peter.maydell@linaro.org>
 <87bk2dliud.fsf@pond.sub.org>
In-Reply-To: <87bk2dliud.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 31 Jul 2024 15:49:18 +0100
Message-ID: <CAFEAcA8Mx-vANgzAwpzFhun0+YAtxE5erdNRMAnfsx0SLqKBiA@mail.gmail.com>
Subject: Re: [PATCH 4/7] hw/ide/atapi: Be explicit that assigning to s->lcyl
 truncates
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 John Snow <jsnow@redhat.com>, Stefan Weil <sw@weilnetz.de>, 
 "Richard W.M. Jones" <rjones@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, 31 Jul 2024 at 15:47, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > In ide_atapi_cmd_reply_end() we calculate a 16-bit size, and then
> > assign its two halves to s->lcyl and s->hcyl like this:
> >
> >            s->lcyl = size;
> >            s->hcyl = size >> 8;
> >
> > Coverity warns that the first line here can overflow the
> > 8-bit s->lcyl variable. This is true, and in this case we're
> > deliberately only after the low 8 bits of the value. The
> > code is clearer to both humans and Coverity if we're explicit
> > that we only wanted the low 8 bits, though.
> >
>
> Resolves?

Whoops.

Resolves: Coverity CID 1547621

> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  hw/ide/atapi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
> > index fcb6cca1573..e82959dc2d3 100644
> > --- a/hw/ide/atapi.c
> > +++ b/hw/ide/atapi.c
> > @@ -265,7 +265,7 @@ void ide_atapi_cmd_reply_end(IDEState *s)
>                /* a new transfer is needed */
>                s->nsector = (s->nsector & ~7) | ATAPI_INT_REASON_IO;
>                ide_bus_set_irq(s->bus);
>                byte_count_limit = atapi_byte_count_limit(s);
>                trace_ide_atapi_cmd_reply_end_bcl(s, byte_count_limit);
>                size = s->packet_transfer_size;
>                if (size > byte_count_limit) {
>                    /* byte count limit must be even if this case */
>                    if (byte_count_limit & 1)
> >                      byte_count_limit--;
> >                  size = byte_count_limit;
> >              }
> > -            s->lcyl = size;
> > +            s->lcyl = size & 0xff;
> >              s->hcyl = size >> 8;
> >              s->elementary_transfer_size = size;
> >              /* we cannot transmit more than one sector at a time */
>
> @size is int.  I wonder why it's fine with size >> 8...  ah,
> atapi_byte_count_limit() returns uint16_t, and Coverity is smart enough
> to data-flow this via @byte_count_limit into @size.
>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

thanks
-- PMM

