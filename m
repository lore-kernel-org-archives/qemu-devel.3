Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DA8CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 13:50:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFuwd-0004os-TP; Mon, 03 Nov 2025 08:50:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vFuwV-0004m9-9I
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:49:55 -0500
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vFuwN-0006oV-Sw
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:49:54 -0500
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-63fbed0f71aso503259d50.0
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 05:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762177777; x=1762782577; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Pf0d+7uUDDTfb7k4gRwxqL397dLC+m9IoZdhODFwRz4=;
 b=tIZDQJWyoznliZH7Buri054qldAWuAMhUx0WCApW9nHeafZT/E79QLrbSF24ZdmsNs
 RUIaFAZf7oGX0O7exuNTOce7mYXPK1UQlL66zF38+pwFNS21Foc1uHkO6uFbuzu4/5fX
 jV+BC6Oxh5Zui1nbbkaSVHUNnUuncVy2fOV3y1z6SCVMyIsIBIboOejzDIayoiP1OPBP
 RKF3nPg5MyyrfZN3+hb8SmgeU+y3GAcSmqzV20VhInb0VAQ78JSFjdLx6usJ8BdloaeA
 Bh36jnH8il8aRpsWmCxNYtZ8lYw23oplu1R/buTZn5CtvjlpNxBU+CGgdJqZiF86U4br
 Rb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762177777; x=1762782577;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pf0d+7uUDDTfb7k4gRwxqL397dLC+m9IoZdhODFwRz4=;
 b=n7/KyhHmf57ERY7+gFXtDdkMTWZTJIqsUzg+YUs7GQz3a4UT49MKvr2qMRReM2MB4m
 X+588I39kzdkWlhl9oCdKk/aYQ2KqequdAui42ZNHVWjDc7Xpj9gZHr2RCBr8x2Hz1ux
 O9LITovDSQ7SsLYRburQj4kPwYdiSS+wskx79VHH5YZT8ccH+VPzH5DNswEWAMGkVQOt
 m3v4kC948mLTV8ORYpniSBI6/TQFgDwDCh7i1Xf+sCivcCeveJq6MyDv4wLRM3nMR+Gd
 9ASFRpAYlGz54lfHnpNEHDYUtgyRm0cUE+cQ9peZ/Q1NK5SX2283LBtKP22sBC9LvvXG
 n5Dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQWZ/xGftaSRc9ceyYFnWqKN9mleKbgQQHpnZaXk/4RCI5UNtfiGu2yjjsnUVVG0RPIv8HXSsoWjXi@nongnu.org
X-Gm-Message-State: AOJu0Ywn/ID7vHA9rVNGK+pNxmu71HSXxbwQjm1k6Dq85NQKMaRJYio+
 cV8hIKlzsXuygVVyMU5OjFDVmDWKrb4yaemVxslfDcuy1bF3DgUxp/kvNLeRb3tEd/IZ02E/gpP
 r+WYjkAyM0TFmoC/Fgajt4+28AO5SRCWKN2lzY1EYgg==
X-Gm-Gg: ASbGncv4JCYOVHKT+CtymoCRd2/Ww0DNmvKzFBQq9ndvE8G+7w8ndB0kKiYQE+KfvnB
 mi0Arxs+uM9ysS95N5bC+m4cvfiRLd2oA9CPsDAWq9oKghwnJWJiC98Mr7+3x8Ip1vQ3lRrSsBa
 nr/XRVkLugOm0DI6jDk2P8DRekHsCnfGFRokjz+B+Sdz6hNIPFZlCwNO3449F5asHyoQEbGWLaQ
 qoqR7jv7pIZTt+/Du7rWHE3gPxLBPmBE1Nk6BeFnjeNfCVqzoFvUxbEhoBjPb9dd2eUT3Smn2wf
 hemXjn4=
X-Google-Smtp-Source: AGHT+IFgIZnpVGgILl3MzYMFblgcoNPue89Wm1h+LCNdBobUcy4BU6C1x4smNe2S8QMjQn4ZMqHOWt0Vyv8zYjMjMdI=
X-Received: by 2002:a05:690c:9a0e:b0:786:91ac:e145 with SMTP id
 00721157ae682-78691acfc59mr3909337b3.12.1762177777411; Mon, 03 Nov 2025
 05:49:37 -0800 (PST)
MIME-Version: 1.0
References: <20251101082231.8681-1-soumyajyotisarkar23@gmail.com>
In-Reply-To: <20251101082231.8681-1-soumyajyotisarkar23@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Nov 2025 13:49:25 +0000
X-Gm-Features: AWmQ_blPxJc2AD8DcTIjwPoLSgIjnbNjV7c1RXHMl0j11bZEYQGx887-RpjdkpI
Message-ID: <CAFEAcA-174urTg0fyePbM47PxM+YB=nTsVTFziR475JmBR0BWw@mail.gmail.com>
Subject: Re: [PATCH v3] hw/scsi/ncr53c710: Fixing defects reported by Coverity
 Scan for QEMU
To: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Cc: deller@gmx.de, qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk, 
 stefanha@gmail.com, sarkarsoumyajyoti23@gmail.com, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Sat, 1 Nov 2025 at 08:23, Soumyajyotii Ssarkar
<soumyajyotisarkar23@gmail.com> wrote:
>
> From: RemZapCypher <soumyajyotisarkar23@gmail.com>
>
> Fixing Null pointer dereference & Async/Sync IDENTICAL_BRANCHES

Commit messages should generally try to explain what the
patch is doing in more detail than this. Ideally I should
be able to understand from the commit message why the
change makes sense and is the right way to fix the bug.

> Reported-by: Stefan Hajnoczi <stefanha@gmail.com>
> ---
>  hw/scsi/ncr53c710.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
> index b3d4593b72..dd9884c8bf 100644
> --- a/hw/scsi/ncr53c710.c
> +++ b/hw/scsi/ncr53c710.c
> @@ -834,13 +834,11 @@ void ncr710_transfer_data(SCSIRequest *req, uint32_t len)
>          }
>      }
>
> -    /* Host adapter (re)connected */
> -    s->current->dma_len = len;
>      s->command_complete = NCR710_CMD_DATA_READY;
> -
>      if (!s->current) {
> -        return;
> +        s->current = (NCR710Request *)req->hba_private;
>      }
> +    s->current->dma_len = len;

This looks odd. We already have code (the s->wait_reselect
check) earlier that says "in this situation, we need to
update s->current with req_hba_private and update s->current_len".
Now here we're making this code unconditionally do "if s->current
isn't set, set it from hba_private". This seems like it's
confused about when s->current is valid and when it's not.

When we call this function:
 * when is s->current non-NULL and valid to use?
 * when should we be updating s->current from req->hba_private?
 * when should we update s->current->dma_len?

I think that either:
 (a) there's a particular set of conditions like s->wait_reselect
     that tell us when we should update s->current, and we
     only need to do that then, or
 (b) we need to do it basically unconditionally

We shouldn't have both "do this on a particular
condition" and then "do this always".

>      if (s->waiting) {
>          s->scntl1 |= NCR710_SCNTL1_CON;
> @@ -1367,11 +1365,6 @@ again:
>          case PHASE_DI:
>              s->waiting = NCR710_WAIT_DMA;
>              ncr710_do_dma(s, 0);
> -            if (s->waiting != NCR710_WAIT_NONE) {
> -                /* Async - stop and wait */
> -                break;
> -            }
> -            /* Sync - continue execution */
>              break;
>          case PHASE_CO:
>              ncr710_do_command(s);
> --
> 2.49.0

Please don't fix two unrelated issues in the same commit:
these should be separate patches (you can send them as
part of a 2-patch patchset).

thanks
-- PMM

