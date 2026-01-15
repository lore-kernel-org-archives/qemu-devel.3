Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4248BD41163
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 10:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgKqD-0003db-12; Thu, 15 Jan 2026 05:44:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgKq5-0003aP-Hd
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 05:44:29 -0500
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgKq3-0004Xf-Al
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 05:44:28 -0500
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-6446fcddf2fso619496d50.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 02:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768473866; x=1769078666; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y0qy+W4B8slotUaUKZ+AgAKzxweFIy3Nmf0uGPwfoS4=;
 b=fgB8zvsPo+Cs3hIBWC1siBnIQEAzoxm8L1bV2J4av3pVU4Uk4zh4piBA+2901FjR64
 5MdtX/JfUf3UriNdKpGeRVcm8jFrmvsDP+YZXhjBBgWlVwtF99IP69tVXbVx3yp/bS7m
 nPELGo5iFUIBuSHkfeoIyJe7XsnEwCivPd8TmNotIdJZhDTyuNxYVU8CxmWtrUKRHV2T
 +IRolxxhAvqaZuEZ2T6wGRD/gO4YcFX9YtfERq3NrvkNrDkTIY69ZUJLlKQ8dyFQOGtf
 NO0Hcp5XHh8q03VZoRopbvfLR/+tcTOD/I41v8TNH58pVrj2Ddt0gzlXkhGewbbrUvkj
 5yYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768473866; x=1769078666;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y0qy+W4B8slotUaUKZ+AgAKzxweFIy3Nmf0uGPwfoS4=;
 b=CRbYr5epRbRpJXNePc4hf6PvKs6Bfkzw9f2WZXRKs8Kkbfevu27sGzyPgpRFiGLPJp
 arMDJ+5hYC1M8VKjMOU+vfZaCn8+JF6/E6dJ9zIKD5dHI5S5qbTcnPW0N+DtCyOVbW8X
 GABemZcqxLT2wc3g6MBlaXTQJgmhCVYYmwKW/QtTn7jUBCt0T0NWxSButKxxye0fxskB
 2/zmxq7KsjN4GAxaTFvEIqjTHgiqsRby0/xm/fd2/48vOeknRZd32lnnBjd48zaah6sS
 iwj52FcskS8ornUoP/zKsWJ+mSJaolmBWMlgwFq26vf9+IxMk7Y++CR8jbYaIlvg9EnS
 00GQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8RVgo8pGfJlrkob1ot/6eIBRfgs6q2Q9w6HU/x/F2EKjLsD35aL0qQSZL2i3xWQOo/xwvXCNULnCN@nongnu.org
X-Gm-Message-State: AOJu0YwomXE/r6ch77zzT3RRr6hrBMCvWsEnb1Xjxlu83imhNJdfv9df
 36vbKTlLnQcqmv21pzsNcrPDfs7zbyum1UyYQemiRhhoGALxacNVA+D3+sIIq1ZOGe17Xu2B3AX
 e7KgFgTRQ6qBCl94qd7IaeE1lSrykgcd04Qr1cI8nng==
X-Gm-Gg: AY/fxX6VEwBzhg6HvEf4EFPH5xsfPbXsrzF8nQ+JTnPCCXNbVgX7xb0q/Gin9sjm8rF
 p6sagxY9WrckHwcKbBwQjRVVbDbkUKTEVKjEcvTXUnFBXTo3P5i6cHqoREcuhcxIEnSLgEVX63i
 Hivc5C0LJk77ftspocWmaOrZnZS65zcvcEfSDD++YHD61IkUMBxSyM0WB6BkVCsEiZrZ9CKQUfO
 cCwoSTSvZsMo0dHTyssdUCIAAXoUWbSv0R3FtKwUCttIFrRdBGceMGP27KixhgSEmaMJuBxBgdA
 YC9x30TnSuZ5FyR20hrH6/I=
X-Received: by 2002:a05:690e:b4e:b0:644:60d9:7528 with SMTP id
 956f58d0204a3-64903b61a9fmr3443195d50.90.1768473865834; Thu, 15 Jan 2026
 02:44:25 -0800 (PST)
MIME-Version: 1.0
References: <20260113135941.3361163-1-alex.bennee@linaro.org>
 <770e5e68-f8a9-4321-821a-aa0930db0d95@kaod.org>
In-Reply-To: <770e5e68-f8a9-4321-821a-aa0930db0d95@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Jan 2026 10:44:13 +0000
X-Gm-Features: AZwV_QjsnUeWMFgniBYf7EQ0VimJM_8yHx93jA4QjIPKMzD0weFUTQMmZCXVe20
Message-ID: <CAFEAcA9dz5BPdpB+2wukcJ=jgGCwkCTa7Y=FA4s+qzymg7gHRg@mail.gmail.com>
Subject: Re: [PATCH v2] tests/functional: migrate aspeed_rainier image
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, Steven Lee <steven_lee@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Tue, 13 Jan 2026 at 16:19, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> On 1/13/26 14:59, Alex Benn=C3=A9e wrote:
> > Cedric has a host for the file which allows us to keep the name.
> >
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Cc: C=C3=A9dric Le Goater <clg@kaod.org>
> >
> > ---
> > v2
> >    - host at kaod instead to keep filename
> > ---
> >   tests/functional/arm/test_aspeed_rainier.py | 6 ++----
> >   1 file changed, 2 insertions(+), 4 deletions(-)

Applied to target-arm.next, thanks.

I've added a cc:stable tag since the old URL will be going
away shortly.

-- PMM

