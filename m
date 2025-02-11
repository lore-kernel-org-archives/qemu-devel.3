Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5557EC0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 14:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thrYH-0000cI-Tu; Tue, 11 Feb 2025 09:47:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thrYC-0000bz-Vd
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 09:47:49 -0500
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thrYB-0006R5-7P
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 09:47:48 -0500
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e5b32f64ffeso4654855276.3
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 06:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739285266; x=1739890066; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=htenO4NWqgecrAFiiMaIqYD1X+buDOgn6dQTCmf8JU4=;
 b=Bt2RTNt9P5sn+dl/HjI/A1nO0btW/Y7oqbG1JZviXXh336ghBlBZrsY+zGnpLqjlCI
 NOB9xWpOLW+dCjLkzAdV9viicIeRLfWqyursfT5J5rSOjHYEgNZJz2zSQwM1nJoYLso1
 SQo7EKtpwC6y3nt72RZMknQlQxenOOWlnTh+P09a9tr0OuEPDIri2vnYdUepjbZWhNm5
 RHTtWK9OXPkPr0iAsS87FeZGjhIwbfpPEImiIfsJZ1QaP4Arvei0FwZM4lROEBQK+Z1q
 axes+vKxBsvSVzBT5tlYuk3v7I6wN7oXVCbX8kZ+XFSksCa5srFDmQ1G9cIKaK3EUWIs
 XFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739285266; x=1739890066;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=htenO4NWqgecrAFiiMaIqYD1X+buDOgn6dQTCmf8JU4=;
 b=ImT2xZh5srFWLjo3t7/Sh0ulQz0cxjUcwJ+7bP/aXSH7CUcjw4hq2RmrW4BtfuvSPJ
 EHr3IG0RvdVXZJIJgXwAk8KGe0I2JdTo2cWkyvry5T/CRBDlpIq8p2X18e5A/8nqJGLc
 eK0+D33N7YJ0g71L+1mIfHiEQaGUKiS/6aIOkONIOVoCRSv4o0X04vxF1V9lSg9lL61k
 ErOJ/0JqSJF8279qFEdoCQC2qyt64ukhg4erhzbH1sMMe3V6VDoqDc/0EMIprq4mJE8K
 dzqDgu6kcfJAwLKpRxdKpGg3YPAZRzppgAFhbtnYNbYYBZPnYMAb92ERYhSRQxbLs7Jh
 nAkA==
X-Gm-Message-State: AOJu0Yw+6rKOKd6umHwnw8GfW07KEIjWTxB0DBOBKW3JtYliy1lhUk02
 gwdzqjL3qpIoJ287dCQD1F37p8POPVSA5wDdnHAQENq7S9cOtmmnCFg+JyznCccntMM2XUsuL0c
 40d36t88w9MxnJm07JmUL+Enig96yL9I76cpl9A==
X-Gm-Gg: ASbGncvEZhRBTvIQEsz6ely7xqla5IGeS4gGzZrnxspTGUXX+uv6p6ifchrfEHzZO/r
 sr7v8LNoT4kt+hAED5Twm3N24oWRk9XZIXh2X9HV+U7iRgz3J55wDcUDFa+jfoSfh3n2whwfmdQ
 ==
X-Google-Smtp-Source: AGHT+IF274jkvJzgWFCGaambk5Hiylywpk29Gjs/QZ7DT+9E+OpDukAZBo0Qvcyg7FbtQ30Aj9OOk1cOpNnue2i9Ss8=
X-Received: by 2002:a05:6902:72d:b0:e58:5cf:bc52 with SMTP id
 3f1490d57ef6-e5d9e7e3b53mr18449276.9.1739285265596; Tue, 11 Feb 2025 06:47:45
 -0800 (PST)
MIME-Version: 1.0
References: <E1thUwq-0020ux-5f@kylie.crudebyte.com>
In-Reply-To: <E1thUwq-0020ux-5f@kylie.crudebyte.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Feb 2025 14:47:33 +0000
X-Gm-Features: AWEUYZkT2xSuM1OFcT-BDgeWlZvwvgPQguSk974Hil29fDZJemczbScuayWf3_8
Message-ID: <CAFEAcA-Gh18aqaOtw5aj2KVn75c+gVHWUUoFVRzcffc7DGKqQw@mail.gmail.com>
Subject: Re: [PATCH] 9pfs: fix dead code in qemu_open_flags_tostr()
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2c.google.com
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

On Mon, 10 Feb 2025 at 14:40, Christian Schoenebeck
<qemu_oss@crudebyte.com> wrote:
>
> Coverity scan complained about expression "|LARGEFILE" to be non reachable
> and the detailed Coverity report claims O_LARGEFILE was zero. I can't
> reproduce this here, but I assume that means there are at least some
> system(s) which define O_LARGEFILE as zero.
>
> This is not really an issue, but to silence this Coverity warning, add a
> preprocessor wrapper that checks for O_LARGEFILE being non-zero for this
> overall expression. The 'defined(O_LARGEFILE)' check is not necessary,
> but it makes it more clear that we really want to check for the value of
> O_LARGEFILE, not just whether the macro was defined.
>
> Fixes: 9a0dd4b3
> Resolves: Coverity CID 1591178
> Reported-by: Coverity Scan
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  hw/9pfs/9p-util-generic.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/9pfs/9p-util-generic.c b/hw/9pfs/9p-util-generic.c
> index 4c1e9c887d..02e359f17b 100644
> --- a/hw/9pfs/9p-util-generic.c
> +++ b/hw/9pfs/9p-util-generic.c
> @@ -19,7 +19,9 @@ char *qemu_open_flags_tostr(int flags)
>          #ifdef O_DIRECT
>          (flags & O_DIRECT) ? "|DIRECT" : "",
>          #endif
> +        #if defined(O_LARGEFILE) && O_LARGEFILE != 0
>          (flags & O_LARGEFILE) ? "|LARGEFILE" : "",
> +        #endif
>          (flags & O_DIRECTORY) ? "|DIRECTORY" : "",
>          (flags & O_NOFOLLOW) ? "|NOFOLLOW" : "",
>          #ifdef O_NOATIME

I don't think we need to make this change -- the code is
correct, and osdep.h defines O_LARGEFILE if the system doesn't,
exactly so that we don't need to put in extra ifdefs in the
code itself. Coverity often fails to understand that some
code is not dead in a different configuration or host OS
than the one that got scanned. I've marked the issue as
a false-positive in the Coverity UI.

thanks
-- PMM

