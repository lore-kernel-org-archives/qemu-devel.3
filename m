Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D979606A329
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 18:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nO8+bQpA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP2N7-0007ur-0S; Thu, 05 Nov 2026 13:39:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xP2Mt-0007th-Tp
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 13:39:27 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xP2Mm-0000Ig-MW
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 13:39:19 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa2848d2so3615576a12.3
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 10:39:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793903954; cv=none;
 d=google.com; s=arc-20260327;
 b=TsX/RJTpEaQu0kjTnRDY/9ZsX4iMYvXu174bSpRw5z5Lcn4RT9MUGEswN44Dv7KlRM
 x9u4V84FMdPuhrFyxnbkn8eeyaMfLWc1jpQQyh7qcs1tnZNq3/IpLqJFObjqKhPQYqpp
 zwoTNzYkygICDphSe6W3qYreLq5TCTG7VKOAKpKwSnEOQReiQ7Y+xx+/XM2dF22AZyb5
 H242DvpWPowFcvvGoG/gVASvmkx9ZyacY6MzATtI/fC44ib2B+Ekh9JMtMlAYoBv2+hB
 HJg9S2+nle+KipFEGJVMgZkElFGebgAGeeGbN4mb1iQ+EP+Kg4+uArQPx1hi739m5/ug
 CbXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=Cpv6sDznG9g3PaHx8Dfr1poUMNRDYjzIMu1KmTb/P7Y=;
 fh=TI2oGfIF0p6zKKJF5E+45C/3l4jXEEOFjNpKWzczuO4=;
 b=hfgYXcwry23ii8aETHDuWrvFqHEICrTPzQP6EJaKKko6QG8B7d2k8nNru7gFncpFDh
 mtikdCDbDryTQKKC0a91evVtFLAVC2utaqjgRiOvRvjnhrevcsCfbmoZnuyRI1ccsMHk
 GWtIedONTdduw3EL5L3w5mkZVM85KSLYhQSMt5js6EMCajJndu5Vvwmv9LgLqKWMwxEq
 ehPDXBmsamAehZo8vkUbfGB6ppgH451NwSjOsqvqe6yEZa/BfklyMsi2qtZPBqnHMm/O
 3r31wUry1H6vHA+SF5/brYlkmxLWJq2O0oHvzpzalIiXUbgNJOdv2NHEBzsgR8TVR/P7
 qbMQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793903954; x=1794508754; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Cpv6sDznG9g3PaHx8Dfr1poUMNRDYjzIMu1KmTb/P7Y=;
 b=nO8+bQpA167g88vqA0QbGgwHvL+UTdlMXJKC9ffeoWKkuI6X4EJGOs6/7e3c5tJP20
 uBB49djbfOw7o2foflOX3gxZbAkUj69JK2eWX1CURnnGLMyi0tvwIcJs5gwBSAn7WRir
 j0C1Uy1njlQ88rigoQXk4hNQEk17FNk7J6vDk35mpxRRNjNPLMIg8N1NN2in79AA54l5
 v9jCPzonoFxlMKv4O94OSyt6pANMe98RWH8J3Q2DaQaH2uKcNYMO0TKiHkkvms4aMyxB
 Cr/ALfUbsTTFdhQwscM37cFVZ4Dbpzil9mtjcNi5EMHdZuPFlQn3bDXqRwbV5RDAtEhD
 HYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793903954; x=1794508754;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Cpv6sDznG9g3PaHx8Dfr1poUMNRDYjzIMu1KmTb/P7Y=;
 b=d4Eq1YrQyiqonad+XCQXWTEpqsuIILL4O6ZH4yAqGirg1TidYOS7ZA+yIXB/2oJcXS
 Dw57wrC1p5eiZBB1L4jgpv0OWGxQW7QlkeM3INrhi4FjKVXjekk5kdOR7rPuBP7h+nIR
 2hHxeWseZ5pOeVElZJD70ivCQZyxGIT4SGTO98G1BIvDFJspCAav4tBKmEqtPE+cOaT7
 pHHMBUoe0bY8SmSlT5fULYc+YxFL0Hgn/ngxWEKvUt1xxdQBM1ezgTYRChcy47VASohF
 dWNFTlUFF1JyNcB//qbq7P6m35HlR44kY7KgWcO5KJDV6u5kRsHdgoVUGdxNB1LqNUaV
 0nmg==
X-Gm-Message-State: APuU4Z8cp1SxcnP5UYVpbE4zLmZAlbZ5u3eWaa9ox5OA2o8VYTr/vsJW
 BUzydb9O6UUSCWxuzOn0pu7xZuWjngkFylcJjvG4OfZ4RO647XnKwcYkiWt/z3PLCP/3ZM7GpfC
 KVj271HabVnJuczWAy2oBxg8FZVg4jdw=
X-Gm-Gg: AYBFou2osIbi2IcYGr0U8cmjyXYpjag0fbWDcm+H3OlG/3uL6hTyLclukaTPMDTmk8P
 f1EKRMnr/ecZij0T+Q8mLkq1ihnCuav/wbyphAeHoTnQYL4PERWg/bIkVwzubf20e7zrQoObHk2
 rU+31y73/qaaGX9Wx8nv8+85jvsXmHsmE4ALAHKCeX4A3kvm7bZe4fmbeTHJzLlGA6Ig4/FabzQ
 ezgP66PM+g8NKb2nuyHcHG0KZDrGh57TwHdrTtQSE7KbKMSBt5r4DWvVhqaJf9YckrII+ydJMQH
 6bJs1q2/l2L0yzMDHS5lLiQtRJWqtpoGzDHoESijEGnw5bCLOiqN67afiFGFfWeYmiwQv+4Wy/p
 GYv5Niq9LuXui8stXIFPXA662mxe0aRPjBE38
X-Received: by 2002:aa7:d30b:0:b0:6b5:4f86:3be2 with SMTP id
 4fb4d7f45d1cf-6b5977f756fmr36343a12.35.1793903954081; Thu, 05 Nov 2026
 10:39:14 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105181449.1691-1-luoyonggang@gmail.com>
 <CAFEAcA8ScuuOgjaYNpQOZS37yx=WBzZaKLcVGQs8Tj3JYB3jOw@mail.gmail.com>
In-Reply-To: <CAFEAcA8ScuuOgjaYNpQOZS37yx=WBzZaKLcVGQs8Tj3JYB3jOw@mail.gmail.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Fri, 6 Nov 2026 02:39:02 +0800
X-Gm-Features: AclHuK8Q4qpjZn9C27E95aueS306ZtFu8jCOr9ECSyJl-Ro9W33ud9_1OycCjRk
Message-ID: <CAE2XoE_eMkfA9=fjvN1GOVsKqDi1HhN4CEB-z0LpFuXCa52Yrw@mail.gmail.com>
Subject: Re: [PATCH] meson: generate qemu-version.h with a custom target
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 John Snow <jsnow@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Philippe Mathieu-Daude <philmd@mailo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: luoyonggang@gmail.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 6, 2026 at 2:34=E2=80=AFAM Peter Maydell <peter.maydell@linaro.=
org> wrote:
>
> On Thu, 5 Nov 2026 at 18:15, Yonggang Luo <luoyonggang@gmail.com> wrote:
> >
> > configure_file() writes qemu-version.h at setup time. That result is
> > not a ninja edge, so a missing header is never rebuilt and compiles
> > that include it do not order on it. Generate the header with
> > custom_target and list it in genh. scripts/qemu-version.py reads
> > scripts/qemu-version.h.in and substitutes -version. An empty
> > pkgversion drops the QEMU_PKGVERSION line.
> >
> > Link: https://lore.kernel.org/qemu-devel/CAFEAcA8bGODxRfRzrimhGN1v2HtcW=
vApRsyucemZbMUUBVkYwA@mail.gmail.com/
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>
> If we're going back to having an external script, the other
> way to fix this would be to just revert ab78ac76f44a12 and
> maybe fc35f2438770, since their commit messages suggest the
> main aim was to not have an external script.

I personally think the external script(not have) is mainly about when
git presents.
That's the most used case for developers maybe. And we always need to
calling to git when .git and git present, that's the case we always need
dealt with.

And if we call git executable in an external script, it's far more
complicated to
handle. Either a complicated python script or a not-wanted bash script.

>
> thanks
> -- PMM



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

