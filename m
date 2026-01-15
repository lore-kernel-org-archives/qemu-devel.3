Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37BADD44C57
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 14:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgONJ-0008N8-2Z; Thu, 15 Jan 2026 09:31:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgONG-0008Ks-Cc
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 09:30:58 -0500
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgOND-0005ve-5z
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 09:30:58 -0500
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-6420c08f886so1341040d50.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 06:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768487454; x=1769092254; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N0zShav1UQbJe+jlx8+ggbM8hQrgaYliCuFXZ6Edzt0=;
 b=zxixuDT7LGfjUwesw+2UIAB5VjeWWndlI7fHhjTx+jr90ai9AE6v9GsV0yHjHMOTJC
 XyDmE3jTpgH2SWIj58KHLwQVQFmDuVUCDL+y8OuDHiMf8K8MwObC+85v9DiU4ZMd22sl
 Z53499xE79WFc6ULk31vPs7ahGZWUIUWbvr946hdg2raCe/BTsHhWguqtJVouqdf41wJ
 yGZVt+pVhJ5H9udNGSvzS0VsDejVpoMrUSQHZmxslEw5Gd/Z46MzFtLYv5Arr6xfxMtq
 RiFs+i2Y5L2yOX5L+szoIlwcjNkWDP4bnm68RDiHbou7Wd8BothM0ZItzZiBwf8NfGk7
 xscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768487454; x=1769092254;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N0zShav1UQbJe+jlx8+ggbM8hQrgaYliCuFXZ6Edzt0=;
 b=IZMgyFRj1zLMh5mk0WvqNcD5CXCGVHltJ69o10iXxmD0OpSV+h8AqTZ+Y/ZCFvYRLJ
 +xyIQm0sg6E1+ZbDy7oqftHByoWZwx0LQacwqPdKDcSAjoVpyRq6zrRoQzIwjgdG7QJB
 564yO2EKfrWqU0UpeWY5R6p+PCR+1TSnHAP4ohBhLh8pKjCER98Dw6wuSDplZbuU+UwD
 APJ0iSGZxxU84wh9gBrG2gsYYrKEba1Phn3wCzsrcTg+ekd1CAE/vR+8TPVAwFM7UL1e
 DLlqatYJxXCfyHvPP2od2jFuBNb+5KGNVDOS9ZhMcLvBW1CbKRoxDVwyZb07Vm/jxACn
 SATQ==
X-Gm-Message-State: AOJu0YzEGpW6XaakgXvjTgMAQHE04hGv7P3Qvfans10STPgJqNYrQnGL
 ac4YzPRNguRSYHgsjHZ0aSMwJQCqrZ5KAUvVkb9KxvedIRARgLYqEDXpeIF3NPR/YwVNDJNk1bo
 hhLreAD4lZMqrKIfPmKBC/klqyxqisEXX90m5PLnLYw==
X-Gm-Gg: AY/fxX62MK3OXm8WRLJimsFeFUZF3SqY8sgnlHn74pbFNpkmmOuQsNBQfq/3rOeu6Le
 nulc38YpKT8XIwx4tKatevJJ9wMip9fHysPcjlrVc1wJPxxEYLNXTYAJKxLUIGWaMnUs2KYGuvE
 Z4ZXrTl4i2Ojz1lm5rEp39U4jsFoR/jC1kdC0fk5jLD7JmCqQw51EhSbfsAhxpNGgCNuHDxxc8P
 5wyULNCEr3mXsdCx+QtvHUkdaGOjxh5tMd2XrYX2urIVRJaPtSN+k56TBsM06lfLDth0jQFc3vD
 VvYbQOgJkDNKWXH8Y/GKpH0=
X-Received: by 2002:a05:690e:408b:b0:635:4ecd:5fcc with SMTP id
 956f58d0204a3-64901ac9ec3mr4862107d50.41.1768487453776; Thu, 15 Jan 2026
 06:30:53 -0800 (PST)
MIME-Version: 1.0
References: <20251204093502.50582-1-corvin.koehne@gmail.com>
 <20251204093502.50582-16-corvin.koehne@gmail.com>
 <CAFEAcA-fU1qxTCoHaEQfGOmPPHyFL2Q74DXvLyti+28xe2bM+Q@mail.gmail.com>
In-Reply-To: <CAFEAcA-fU1qxTCoHaEQfGOmPPHyFL2Q74DXvLyti+28xe2bM+Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Jan 2026 14:30:41 +0000
X-Gm-Features: AZwV_QgteSE8okzAl33qDtrQ7GDZTMm0OVRS36h5g7vTevGkxuceuZICwVCRlNw
Message-ID: <CAFEAcA9fLQS=UTcRgd2oztkPK9g=dXzt7ZkMAO=H8Dxn=TTJEw@mail.gmail.com>
Subject: Re: [PATCH v5 15/15] docs/system/arm: Add support for Beckhoff CX7200
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-arm@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, 
 =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>, 
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Yannick_Vo=C3=9Fen?= <y.vossen@beckhoff.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Thu, 15 Jan 2026 at 11:57, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Thu, 4 Dec 2025 at 09:35, Corvin K=C3=B6hne <corvin.koehne@gmail.com> =
wrote:
> >
> > From: YannickV <Y.Vossen@beckhoff.com>
> >
> > This commit offers some documentation on the Beckhoff CX7200
> > qemu emulation.
> >
> > Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
> > ---
> >  docs/system/arm/beckhoff-cx7200.rst | 57 +++++++++++++++++++++++++++++
> >  docs/system/target-arm.rst          |  1 +

> This doesn't render very nicely in the HTML documentation,

I noticed also that the nested bulleted lists in this
file come out a bit odd, and so I checked the existing
xlnx-zynq docs, which also have that issue. I just sent
this patch to docs/system/arm/xlnx-zynq.rst which fixes
various minor rendering issues:

https://patchew.org/QEMU/20260115142629.665319-1-peter.maydell@linaro.org/2=
0260115142629.665319-2-peter.maydell@linaro.org/

You might find it useful to refer to in updating your
patch here.

-- PMM

