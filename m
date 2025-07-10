Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EEDFC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 19:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZx0P-0007AL-6Z; Thu, 10 Jul 2025 15:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZx02-00077d-1H
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 15:32:06 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZx00-00021S-Go
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 15:32:05 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-711756ae8c9so10627107b3.3
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 12:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752175922; x=1752780722; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=if/o3OZIv0NWye2a6o+2WkfS6wL0R89SGx6jJ6K10lM=;
 b=A5Nv5yc2olKxUq4mfI+kod8JlT+Nx1eGFt1bfkevE0s7R8LrnYLpwrvd9pZuzOPjZV
 JWEuFrZfem69+LNfeRLlKroEHqmPMSkmZp21wUgrSDas5ZiX9PJkc0jihjw+iAQSFUQd
 Vo+KJyLvCpqYIQR+4/nsnL6mIPnI0+FJaGzuU8YEl3Dy0JEY+js1gOrWCvkQixgnCRxJ
 jbrQMofkV/vWWXqwElY+m5K7U7jVd/VHVRQK4q0PmsdyurcPhZtklncu0NlVb1jd6dft
 e6EqsbrK1TcqSyWvQCUbvKr+wBVYd2PgrsT28rc+Qca+5bxLHCHOxkitoXFSct/wAeTP
 kZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752175922; x=1752780722;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=if/o3OZIv0NWye2a6o+2WkfS6wL0R89SGx6jJ6K10lM=;
 b=IN0ng2f7PR2zjl/bN9twQuSLJC30rjT1XBBAj/hvQDBw8S48cvEyLZ2++jEAfH5weq
 7xB3ROZzV7wLhxGn6wa4SCsGU+4ics0JSoY6zvASQN81c/45Kfrs03NCK+mYoDhVvsex
 5d5C6HZXPAEdfo9IibrA18fcWvLVPhSadGzjWwJd1COuOyliyvvqgYlxUoaXAx3U9wyI
 zqTAP9AgkLFXHXrNhfzJa9QUDqAFMv683eqjHLwF4ABCF5DlN0BYBCbLiERIv6gWitfC
 kOmnHAZ/oV84fzWSTdOPqXPZxA3XEE9cIF5OnjRNeG/UGU7Ol9DxzjWLvEmB/7RX4ZPe
 r8NQ==
X-Gm-Message-State: AOJu0YxPUrVkpxjoAFLc+VYEoJLBaqoVfewkYKIX15U5TDGb+USGShkW
 RZBZpDIwTKp9k7QRUOouvbHTmPqKJIc9O+zsu4FZlIy9siLXwRL04NpbKS1CIJnbUMemKgqQ4NS
 QkhBRx6NE8+pmfQvi6Kxd3X2McH1zbcCNyHr2fffevw==
X-Gm-Gg: ASbGncvxdm9ZyTlRjV/rGgfaHgF6Yc/vjU3LhqQCp/C3p6qFIb0eP5yzacda/UmeNuj
 m5QTT9sK1q9sbCPYwBNqRMkDRkkfEhHemCO6jRKAgrCz1WQD+09KEMXQITMS85P6GQ0ZQsTF7p/
 7Wq45XSSn2d032Sgw9n8DopShrCu4/pzOI+N9s3jtlwmaB
X-Google-Smtp-Source: AGHT+IGR1wIsYRgl8FsljCbudTv+6/mPHDvwviWdXndhgiobof6/ZlDEyqqlN6t4PwIW0FIpsx8ALo0lKpfN8+91iAs=
X-Received: by 2002:a05:690c:6705:b0:70d:f237:6a53 with SMTP id
 00721157ae682-717d5d79294mr12202267b3.9.1752175922020; Thu, 10 Jul 2025
 12:32:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250710170707.1299926-1-peter.maydell@linaro.org>
 <98ea92b7-d078-4976-8511-d68818270cf6@linaro.org>
In-Reply-To: <98ea92b7-d078-4976-8511-d68818270cf6@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Jul 2025 20:31:50 +0100
X-Gm-Features: Ac12FXz9-PXp8qVLcTagDctsJJf0oe68fPLJ_iVJgXVAkq_5pVc5MacXJ5_NK0c
Message-ID: <CAFEAcA8AcyZRH6U4Dv+XUV5o_6Fk8DL5ECm3s+VpF3tffWDb0Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] linux-user/gen-vdso: minor error handling improvements
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Thu, 10 Jul 2025 at 18:58, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 7/10/25 11:07, Peter Maydell wrote:
> > These two small patches improve the error handling in the gen-vdso
> > program. Error handling isn't particularly critical here because
> > the tool only gets run during the QEMU build process on input
> > that we trust (because we generated it by calling a compiler
> > for the guest architecture), but these were easy to do.
> >
> > The main motivation here is that Coverity complained about not
> > checking fseek()'s return value.
> >
> > thanks
> > -- PMM
> >
> > Peter Maydell (2):
> >    linux-user/gen-vdso: Handle fseek() failure
> >    linux-user/gen-vdso: Don't write off the end of buf[]
> >
> >   linux-user/gen-vdso.c | 16 ++++++++++++++--
> >   1 file changed, 14 insertions(+), 2 deletions(-)
> >
>
> Queued, thanks.

Would you mind fixing up the read/write thinko in the subject
line of patch 2?

thanks
-- PMM

