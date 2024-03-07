Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED20C54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 13:10:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riDW2-0006bF-2A; Thu, 07 Mar 2024 08:10:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1riDVs-0006Yi-2b
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 08:10:20 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1riDVq-0001lT-8u
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 08:10:19 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5649c25369aso967873a12.2
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 05:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709817016; x=1710421816; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1+2jVj7ih1sfzzhMg2kPlLZDLX+SZc3ZcHvuPfR1QEs=;
 b=yxdLPpcilcWJTqjj3WWhBcWhPWIcxKlc2KmMR6iLIaE9w6F6R2o7nSSQ7f/FpN6FfL
 NvVXazEEfgQ8vemLcjTPVzpQR7/rxD5kAEZ2SMmHUM/tHhGdtWtwaTewFI3px12yGL5Z
 tfD2j9m0GHZ1CiM7QAnJ9iwk0FZC8Y9/+0THXTydLxiuVO9CdlPd1OXu4KZ0EoRqiYf2
 HvHOev5e+JPTYbqe5WB1/b4mi1u/P4RJJpB4H3nKWAmVKM7TT9Zubi1bq7B/UnyvhTy3
 ZbBaur5cZXsz96PXw6z3slbUoCTMrVRMMUnPvrin6+g+Mp3j1vLLm/SwwX9EhNRNvoP3
 8U3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709817016; x=1710421816;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1+2jVj7ih1sfzzhMg2kPlLZDLX+SZc3ZcHvuPfR1QEs=;
 b=Z9aFkz3i4wasxVaGXEhXG1cMnShqgSTk3lUZI/tLyh6lzfov5yWtvzose7jpedK2L5
 8tuJeNIXf+huKYzkCGNSNlOWzzkjnIY/6eKI19PFUNI1U/UhNo3NRGd7Z92TsVyEYpQB
 hM1Cr10Sa8OnXjaXW1DbRXAwKTApHJE2j24JMYzrELUtjrMqTYW8v+3GCIM5MdeaSicG
 luUZukgKDa6w4k1LJwoBNBYALSXTBjfPrqGavL2ccX09oftfDjYRNu2wG8blYHIjmFTC
 ZoCxi+7s620+dN9IOliwK7h6ISXCW++Ycl228ZmEoa6Nvfh+PNgqlA3DSonDToA14M5T
 LEOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkkamlmnAq95AkuxsBMyjq7gkADoqvhyFZLRc8PQJP9B/fH1sjoBrafYkjJXFr6HVWQMbZY6KVcSA44y+yUR912NrLLdQ=
X-Gm-Message-State: AOJu0YyGZ8Xv8TL6GQrSit270QBrGL+3FR6fPCk2INg0WgdJt0+nVNy3
 O6DxzXF7DPQeXxCbzfYGyr8jJFh5RNZuJ2FBs/n9Z7DQcP98AHbrm5KSGFsjIK79OF12+EjYtf3
 qEneaMo4XYXJY3XP8fj3Lfk9jH2AqYreGxNGA0w==
X-Google-Smtp-Source: AGHT+IFkgnD+aCWwnweIxLiEnrA1iMeFg0BtyYPMb1coEL3ZepDgQ94xn1tA2mi3j/0eMzBlkjaP5xfzyvfW+iUgJ3o=
X-Received: by 2002:a50:d54a:0:b0:567:17df:6bed with SMTP id
 f10-20020a50d54a000000b0056717df6bedmr958214edj.25.1709817016548; Thu, 07 Mar
 2024 05:10:16 -0800 (PST)
MIME-Version: 1.0
References: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
 <20240307-elf2dmp-v4-7-4f324ad4d99d@daynix.com>
In-Reply-To: <20240307-elf2dmp-v4-7-4f324ad4d99d@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Mar 2024 13:10:05 +0000
Message-ID: <CAFEAcA9qpFSxaDr05igUho6=tTgWkyTWxWk4uojUtkQDwh=Q0Q@mail.gmail.com>
Subject: Re: [PATCH v4 07/19] contrib/elf2dmp: Fix error reporting style in
 pdb.c
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Thu, 7 Mar 2024 at 10:21, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> include/qapi/error.h says:
> > We recommend
> > * bool-valued functions return true on success / false on failure,
> > ...
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  contrib/elf2dmp/pdb.h  |  2 +-
>  contrib/elf2dmp/main.c |  2 +-
>  contrib/elf2dmp/pdb.c  | 50 +++++++++++++++++++++++++-------------------------
>  3 files changed, 27 insertions(+), 27 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

