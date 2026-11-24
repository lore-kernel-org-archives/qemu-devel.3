Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4B1606A685
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=uLG0iQ67
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVnjY-00062c-8n; Tue, 24 Nov 2026 05:26:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVnjW-00062E-DN
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 05:26:43 -0500
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVnjU-0002G0-Ps
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 05:26:42 -0500
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-67da7d18f2fso4888175d50.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 02:26:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795515999; cv=none;
 d=google.com; s=arc-20260327;
 b=BNHSI5zq2CXqIAdOQfFmOEHo7ZEUO6bWSuYUOl9ELaN5KdchYcYMuqaJBnWyfVcjcV
 F7lxMX4dmYxNvST4j2YravKolcVJ3JgNu/uODxKxrfjuxXxuw/RJs5+YpmanbR6kO2x1
 IxE5VltdaSEv+PMIBSSr1gxYXIQyczhp9XaiizHCJq0TnA8C226eYtTMrlHH9rSty9Gc
 R6BkYdxxOEUnjJBdlslB/O46arjcRoVqRXo81pki7/36agU1Hie4PTGxZmh+y6CtVrgq
 dLBaIlY1a2WL3DTzyj862rscEcf9EMi89sqXYr1SF6R3AH8ZoaFgUuq8/3GB8SfkcnIc
 8xqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/Bbq7GI2p8BTRkrw6fCPgHzICqGIhAo/aM51QptNobE=;
 fh=x5PLh64jxIm4S9G3IqN+4Ac0FqRRnkliLZHX9/pdl2Y=;
 b=TC5VNWB95G+BAcfF7adKKKokK9LvhATgFFr5yx6Fivbzf9Jc53RNgO5r4OaPNC5+sY
 DBE8rwmPrJ0keLkTbpnnwXzzOkg4KiTvHn7uq9IjcZQt7grVvft2phSgDej0PnZJHnsx
 262K+Jj71WEqSnaJAnYiFuzUs5SkzWUaMjmQB9ipeiOZtfSJhOBUGNMHYF4PHDAysuaT
 gSOfiTuuebAsqe6OEH/dbsp6CD68UsLXdBCBFlqh5vUXTl0Rsny8MnGlF0OaBNIaSEfr
 oOCfkxMMZb6J/NF8W/YErVZJf44ttt2Mb/dKXvwNMnD2a7Qz5eIaKxlPD+U7+hCOmc/R
 jrRg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795515999; x=1796120799; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/Bbq7GI2p8BTRkrw6fCPgHzICqGIhAo/aM51QptNobE=;
 b=uLG0iQ67ld3SeDmblLgeOP/7p7OzcwHhvZvYP7isxGhpe6CrfWL09KlTgGPELY3DS9
 EW9ea/wx/FtkMnMRue5MQd97JbSGkpHAyM1UqvvJbqwra65bxYQb/KM8e1LI6txjeT7E
 bxq9xtivSjEBifOusjDVhcT54jJ8OsWNCkdJsQuZarZk+dAZVLgRG6+9CNfEm9woCVOy
 NZxZ0V435CgSEr9k/OCjtZBTza1wmqzklJgmRSb5Ql+e4vfGtyOT01WP52C7kgx8gthM
 j2q4cC9TBiC4Z5LNBICDvd5CLxEnSCsM2FEC92V7OyPoyjlyjCwK5rxkbIM/2qc1t/SA
 y4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795515999; x=1796120799;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/Bbq7GI2p8BTRkrw6fCPgHzICqGIhAo/aM51QptNobE=;
 b=C2QkCa5ZnpKJosKAXK9w0MH0cS2IRLM6cKL8CuOjUn4FcUo/lyDn+keT97Od5TNSEi
 91wCi1jCthP2bHafatvJJHehdbi/4Ch6DkoXcSkG2Nk7icBLk2b7NJ2Iky8Ij5tlu1sz
 ZD34vn7GHjU/4g1Pi4++vLU67LdUZJFPRlBp321ugMUxVfo7qjUqfBZNa4f+NZnbMJ9v
 f+M/1Gp+ClJAslUwDQVLuI2NrNJGpaTFRmru2JKPqOay206XeNVLrnKCIPLj5TgULn/h
 meCM4BnW+EzCAaUwe4BKO8eqgKwF2nFiW0PnmuKGAfqwE885LsLUgzVaJKp7BgjgJ7NO
 Tb7A==
X-Gm-Message-State: APuU4Z9xPssTRwe2NIa7J+6uTAXAmv0ipxPReaKw+su/C5rtiIF5FSLP
 imc8CEskYR8F/g5a+r+B6L1vR2h+DuqBCuK+gi3lGOY5jhFTa2+RDpr4/1o1g+UHNYD3LJRZkoZ
 VoA23Nte0B48QFJbSCsnXlRCv5PI2T5nxhxBwgowNFw==
X-Gm-Gg: AZFdTZcRycNc5gvll1m8SSIylOkUsvuzBy5C7MBhv5h30Qq108LzwDAn75gQ56Z2kv4
 QhyDrQyGSmO/ZBxWknYlvkqkoh9yzYWzeuic/lpKbt1bMvVo66NDD07J8EuFs0ZK9T2wZlKRem/
 /KO8AB31ismjNQ6Bmdim3DbTh30K4ry+E/Hho6WbL983O+mAx5lllGJukjqNfNmmHCvbAfOFpGi
 fZPffJe2W9VVPACQmfystvP7NLKnQ4RuxQXtEkWA9AeSFIj866UIbilfhSCEOFDcXPZO5krBQJg
 Q62GiGdSen8YMslz0IILW6Eusi5AZGKROTI7jmrYXbfzJDAgx+v9oDLgDU1vceKl9yfQu+Cn10n
 njtl/+9N/NFvIHcAlz+ukIwrjGcquB8gMqdVOZLzoTfmDCn6+JFS6IAMh7DpyW125IQmrWmNYva
 vtiY5JLVpKfzycPscBs04/
X-Received: by 2002:a05:690e:1c09:b0:67d:bc4d:4524 with SMTP id
 956f58d0204a3-67dec47a61bmr7064532d50.30.1795515999407; Tue, 24 Nov 2026
 02:26:39 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261124095719.4126146-1-peter.maydell@linaro.org>
 <20261124095719.4126146-3-peter.maydell@linaro.org>
 <69976e65-ae0d-4fe7-abe4-1894b4005873@oss.qualcomm.com>
In-Reply-To: <69976e65-ae0d-4fe7-abe4-1894b4005873@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Nov 2026 10:26:28 +0000
X-Gm-Features: Aa3M54rEAzu-cBcS4ggakKeGqhy-pwtocVD6N36MtvBWGgFj0mjaCqrXNnSo-Vc
Message-ID: <CAFEAcA8vR=NuQaY7TMQBEixcMcgfYeQYmkuzbzQeyU8rCdB_AA@mail.gmail.com>
Subject: Re: [PATCH for-11.2 2/4] hw/display/vmware_vga: Check for bogus
 FIFO_STOP and FIFO_NEXT values
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 24 Nov 2026 at 10:20, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 24/11/26 10:57, Peter Maydell wrote:
> > The guest should never program the FIFO head and tail offsets (in the
> > FIFO_NEXT and FIFO_STOP registers) to something outside the bounds of
> > the memory area it has defined as for the FIFO via the FIFO_MIN and
> > FIFO_MAX registers. If it does that, return a zero fifo length as
> > we do for various other bad values.
> >
> > Bad values here won't cause any serious problems as we were rejecting
> > offsets that would cause us to index outside the s->fifo[] array; but
> > they're better rejected. For safety's sake we add an assertion on
> > the fifo cursor before we read it.
> >
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   hw/display/vmware_vga.c | 11 ++++++++---
> >   1 file changed, 8 insertions(+), 3 deletions(-)
>
>
> >   static inline uint32_t vmsvga_fifo_read_raw(struct vmsvga_state_s *s)
> >   {
> > -    uint32_t cmd =3D s->fifo[s->fifo_stop >> 2];
> > +    uint32_t cmd;
> > +
> > +    assert((s->fifo_stop >> 2) < SVGA_FIFO_SIZE);
>
> s->fifo is a uint32_t * array, shouldn't we check the index as:
>
>         assert((s->fifo_stop >> 2) < SVGA_FIFO_SIZE / 4);
>
> ?

Yes, or probably more simply
   assert(s->fifo_stop < SVGA_FIFO_SIZE);

-- PMM

