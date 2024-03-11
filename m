Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0066DC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 11:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rje56-0001XU-HP; Mon, 11 Mar 2024 07:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu-daude@linaro.org>)
 id 1rje52-0001X6-TN
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 07:44:33 -0400
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu-daude@linaro.org>)
 id 1rje50-0001NZ-E4
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 07:44:32 -0400
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-7c870863216so109923739f.2
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 04:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710157468; x=1710762268; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HiC8dDOnGUBNkMoleq+4j10j0htoG8uRfyRHYF7pbKs=;
 b=C9IXY2KXkIDRJZ9kr4nzPuOapCCZlnmAM5UzKtvh8YS/KHgE3x7RDGGdlZTYNm/5ho
 ugFP3dj3QLR0qFRWD9gE2mpRIhzKdMFjDvTBPEW6zeZQW5yQSqtRZEPeTcc8Z8839YU9
 mziygkqzCP0IpTgSLnl6MxU0HCweAjsWt1I3pu2svicGE1nUKSKVqNpxPTqquuurFj4m
 DqijeOkzFLLt6+Z31yGTXLRU2zdXQii3xdHfrkgGp1kE/J5aWatTlg7PhuQYhVTSvo22
 i2cXAcokEBlhsZls1g8SlRoPR1D/11umXNjl3uYMYRyBkfvY26DEHzThepC/KNHzeP1E
 EHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710157468; x=1710762268;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HiC8dDOnGUBNkMoleq+4j10j0htoG8uRfyRHYF7pbKs=;
 b=f0eQ8isundLidXKpFhDf8Vyh59sOQg/4iyizLgSJNXJVdqQc8OKg1SDe6jxDeMvEBA
 V5QvTTSZLZjhztptZOCrEd/YWfWMm0L0VopGXzoS3H9BK56zHcdqz/npRmeDU+5DJs2z
 gIPkKcWFvAkQT94hphBavieiHDEIGjX7yBknBcWSkLJh0XdV6gseI3b+2p5rQlXd56HZ
 aK8dAN1eYKTS4mzpBhL39TOjZTpHTLL1EZhYledbgb9bmJDXH9AhtBsJ0t4IabwgKrXy
 Fof4830XjzSGRLoDW4XNiXGuj3hzgDt/1aEYW/+jL7Sgky+fvxCDFbb9K7R7JymdR3Ax
 kQzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWilW7mO3EVjpen6Jd6E4ITOpvSSvsVLy71fB3S00Lj1W8VYEC5tCJVkE5dvbnRvf42f8R1OovKfptk2g0nh8di3A9hUr4=
X-Gm-Message-State: AOJu0YxlrEGKN0l+7k0UwFopkgpez+EX0xRic2nv731b8rYXbRKxGgPp
 yr96YbdesZTQjRpGAzEa+VTq91B8TE9wSrJZZ26uvN61OXA670BM6OQl+FuJHVD+xhWgdbVrTD3
 g6jAmB46qIJczGZFDztCLo0ELftGCOecW+Yk+XQ==
X-Google-Smtp-Source: AGHT+IEkwVaNp1yErUlt0b4o9hZkremMfYmnXW/1dHZ6kTqUQbUSZmLKnKFtyoTmHNvnYwh/blwVM1/LPco3ZDcDZJw=
X-Received: by 2002:a6b:c910:0:b0:7c8:b76a:84d3 with SMTP id
 z16-20020a6bc910000000b007c8b76a84d3mr3117876iof.0.1710157468263; Mon, 11 Mar
 2024 04:44:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240311075621.3224684-1-zhao1.liu@linux.intel.com>
 <20240311075621.3224684-2-zhao1.liu@linux.intel.com>
 <752e3d2b-1834-4f6d-9764-3d7e951409c4@linaro.org>
In-Reply-To: <752e3d2b-1834-4f6d-9764-3d7e951409c4@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Date: Mon, 11 Mar 2024 12:44:15 +0100
Message-ID: <CAPMQPE+7sjNxpYc5qe3k5aoMST=WDACeFogF912ZpbYfH_WK_g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] hw/core: Cleanup unused included headers in
 cpu-common.c
To: Zhao Liu <zhao1.liu@linux.intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d30;
 envelope-from=philippe.mathieu-daude@linaro.org; helo=mail-io1-xd30.google.com
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

On Mon, 11 Mar 2024 at 12:40, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 11/3/24 08:56, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> >
> > Remove unused headers in cpu-common.c:
> > * qemu/notify.h
> > * exec/cpu-common.h
> > * qemu/error-report.h
> > * qemu/qemu-print.h
> >
> > Tested by "./configure" and then "make".
>
> This isn't often enough. The safest way to catch implicit
> includes is to add #error in them and compile the source.
>
> >
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> >   hw/core/cpu-common.c | 4 ----
> >   1 file changed, 4 deletions(-)
> >
> > diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
> > index 0108fb11dbc8..4bd9c70a83f1 100644
> > --- a/hw/core/cpu-common.c
> > +++ b/hw/core/cpu-common.c
> > @@ -22,14 +22,10 @@
> >   #include "qapi/error.h"
> >   #include "hw/core/cpu.h"
> >   #include "sysemu/hw_accel.h"
> > -#include "qemu/notify.h"
> >   #include "qemu/log.h"
> >   #include "qemu/main-loop.h"
> >   #include "exec/log.h"
> > -#include "exec/cpu-common.h"
>
> Watch out, "exec/cpu-common.h" is implicitly included:
>
> $ git diff -U0
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 6346df17ce..27961bacc6 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -2,0 +3 @@
> +#error
>
> $ ninja libcommon.fa.p/hw_core_cpu-common.c.o
> In file included from ../../hw/core/cpu-common.c:34:
> In file included from include/hw/boards.h:6:
> In file included from include/exec/memory.h:19:
> include/exec/cpu-common.h:3:2: error:
> #error
>
> I'll keep it for now. No need to repost.

Forgot:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

