Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48DF4C4828C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 13:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVXBo-00016z-7i; Thu, 01 Feb 2024 08:33:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVXBa-00013y-O0
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 08:33:01 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVXBY-0007JY-Ho
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 08:32:58 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-55a179f5fa1so1260329a12.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 05:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706794374; x=1707399174; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sTyLqxBvF7AffE5fzyt1MkAV5qLzgRzowEuXzJFsWjA=;
 b=eljcTMpEeKjZ3GBwTG7zdMO3wZON6ppWc9+oZAWd88FaRH+k4skwsUqpSbhGjLdfgy
 QdVQfaBtFhjRLcIJnsdu8iXAUwDBZkzXjkZcScnV/FAT6IVBkM7fkUxSOttUEwo+4Mvu
 HFQU8XGRxVcDSw3IuA/r5oOUBB0vO3NlWVn7Bgn6teVcvotJrxbcv+SlYSZJxGbZldOM
 XagBCd/uBWac0+jFdsSCzzq+s7fyuIoM50fbTMN0NQI4kRA6AfploqDVgrsLF+ObsSxU
 /t+/SdBOXqNQjokuAGUUxdNC1+GinQ0dd8ST6Tc2bLErAQ2SeC0qwWLfwYDWpBf9W639
 nfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706794374; x=1707399174;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sTyLqxBvF7AffE5fzyt1MkAV5qLzgRzowEuXzJFsWjA=;
 b=YfBF4BqR0nCuNO8wlSzMFoER5pM6aokRQFROxhZ5daUzN+76m4RlpEPuxOKmLJn4mw
 Y+OBkGuwpTgWSnV0YARetIokWDksobjX1XZFCkDP/W/pYpTjqlhriRfJXD/aDCX2jScs
 YAK1c6RYUibPQR20xkwiVI2xlOO5y1gxArYPnggQIxN5klrJ9Ups5iT4R4b6RJn7TdEV
 NHew/7qsEc906Y7OfaFVU5RjJ6Myf5c6omVnaA5y4Uo9AHEqGBcFuXnn4seNXL7Xh7ws
 UI4Hgn9uT1eZumQpb0K0Lt7cuFLBGJEVEhmRoT4V6QNbMyyhMUyHdfv/OMBEKpGvzPz5
 79Yw==
X-Gm-Message-State: AOJu0YxTTfuViUqIejV3jo8nFCh8DObq5kiEBVUs/g9AcEhe/XOEtgM4
 YqLppIzUMpYAd6Oi2Kdp1T9xupX5Z3WVcxUcEKoQgFYJdjIyR8+KNP6YwETB3T0jLSa8LFTssE1
 OqHdLFnJzSGGBSwKZN3/0eijHkySzEhhqyXX/zg==
X-Google-Smtp-Source: AGHT+IG8mSJVpBC789nuzoiKSyHuEXGMVVA669uf2tu8hGjD4/7loJXEuFV7rNpvMJOgQA+lyBXcqLRImcRruHdlehA=
X-Received: by 2002:a50:9b57:0:b0:55f:3d12:eb3c with SMTP id
 a23-20020a509b57000000b0055f3d12eb3cmr3687641edj.14.1706794374344; Thu, 01
 Feb 2024 05:32:54 -0800 (PST)
MIME-Version: 1.0
References: <20240112134640.1775041-1-peter.maydell@linaro.org>
 <eaf71668-fe0d-45db-817e-fe052df91c17@redhat.com>
In-Reply-To: <eaf71668-fe0d-45db-817e-fe052df91c17@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Feb 2024 13:32:43 +0000
Message-ID: <CAFEAcA-jV1z0M+i=pjrgJ6DJc2ofnjeSvUqtkpxzWVbU1S3gWA@mail.gmail.com>
Subject: Re: [PATCH] hw/pci-host/raven.c: Mark raven_io_ops as implementing
 unaligned accesses
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 23 Jan 2024 at 11:03, C=C3=A9dric Le Goater <clegoate@redhat.com> w=
rote:
>
> On 1/12/24 14:46, Peter Maydell wrote:
> > The raven_io_ops MemoryRegionOps is the only one in the source tree
> > which sets .valid.unaligned to indicate that it should support
> > unaligned accesses and which does not also set .impl.unaligned to
> > indicate that its read and write functions can do the unaligned
> > handling themselves.  This is a problem, because at the moment the
> > core memory system does not implement the support for handling
> > unaligned accesses by doing a series of aligned accesses and
> > combining them (system/memory.c:access_with_adjusted_size() has a
> > TODO comment noting this).
> >
> > Fortunately raven_io_read() and raven_io_write() will correctly deal
> > with the case of being passed an unaligned address, so we can fix the
> > missing unaligned access support by setting .impl.unaligned in the
> > MemoryRegionOps struct.
> >
> > Fixes: 9a1839164c9c8f06 ("raven: Implement non-contiguous I/O region")
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > Spotted by code inspection: I was looking for devices whose behaviour
> > might be changed by a patch I'm reviewing that adds that missing
> > support for unaligned accesses in the core memory system. But even
> > if we do implement it there, it's more efficient for the raven MR
> > to correctly mark it as handling unaligned accesses itself.
> >
> > Tested with 'make check' and 'make check-avocado' only.
>
> It doesn't affect the prep machine boot with OpenBIOS and a
> "Debian GNU/Linux 3.0 6015" image.
>
> Tested-by: C=C3=A9dric Le Goater <clg@redhat.com>
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>

Thanks for the review -- is this patch going to go via a
ppc queue, or should I throw it in with my upcoming
target-arm pullreq?

-- PMM

