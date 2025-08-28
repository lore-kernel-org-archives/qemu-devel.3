Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD1FCA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 07:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urXEF-0004K0-54; Thu, 28 Aug 2025 03:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roger.pau@cloud.com>)
 id 1urXEC-0004J6-12
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 03:39:24 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roger.pau@cloud.com>)
 id 1urXE9-0007GX-AS
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 03:39:23 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-45a1b0c82eeso4868345e9.3
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 00:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.com; s=google; t=1756366755; x=1756971555; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=p7y1pXqs8Qboeyi6xLd7khLJJ/lz+M3UYVy7YPrYBQ8=;
 b=uD57CGAdKFeWfZLog1OdTjSbLRGlcdhG6z1w7N1XfTd5AJegQPJno68Ui4zmiLcIH5
 ACcSJQMso9O5FzqQB2gMwQIw9jI2oqezsTd5DzcC4rXbfD8R2onyy/bk5ujfwXf47xRy
 fPhaMVwU+bfBzt7JWxdvXU9jnW/f83b3DuJTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756366755; x=1756971555;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p7y1pXqs8Qboeyi6xLd7khLJJ/lz+M3UYVy7YPrYBQ8=;
 b=iXjVThlIF0aziU71ovGfrzZz0J7dH3Jn8owmufS7ER+BtNhRjoPIQcZZiP2qQesdbd
 DAERGvfTypqn5U17+DB0on+77vbGqj8Lx7jne9yAoZ+FvYCreGkyHKI/xN9gV9NxD9/o
 7KyE50nqIauz4lBwh7JnBFSVcwdaCHquOEUZTtAcpEkVt47bcHOCoV4X/pqw083GPco9
 +GLjbRuzKCqZl8Jl1EgoNnvWoTmgkJFkn8aCT0VWUlU2uo+tjwSAHnDURQD7zg+vc9pl
 SSlx0OoGyLR1wed3HuqHTk0aFO+9ojA5UJl4DHpRnnTtMVNN92sunBt+E7dZ14Flt3KM
 vldg==
X-Gm-Message-State: AOJu0YxipwR6hBLnHrYJNO0BUXi7RDbqWwnRt4u1tUQsuRvy0m5i7XJ4
 IwKohnvi+kiRo1ggPRehDYdj5Xl7CjjMhr5Qb3Wim8xjzZDj5gUjSW5PCyt1QOxsODY=
X-Gm-Gg: ASbGncsx0lvTPdTjzID6+3ciSpdZrFmRgp/W2cKQ3wToFcmbMsz78kRXwJtxuTb7X15
 jEwGk5ryMzYzKoMBbhjaFiM9wampbKeLfb+4Rd6ye6j9/2YyILELnFyd2udXPN9N/f76GmJyb1Y
 gz19UfSeue1MfTSu8G5ZflVlzz7xlJuvsNPfRWOBGhc9VzkfP8NpoohGcRkMvKuS57fg4ofrGXn
 /eRMAEivD70f2MGZDJtzN0RsqVY6gmPzo2uKj8aCM1dtkB2cGbS4PiaynCjBey26EG6l/rY3pgv
 JmAvWfee7VIpKf3xMf8qztve3v3SAGUT5rcFx4hQw1S5ym7CsVgSLUDAZKswWJxlHPB263mUSgE
 Jjkf1wW3qBM6gjbqdhX/HG9B/SLq/toIXzNsWK7DS+8tA4UIalrsee88e2vss25vM3TiEyCWlr4
 zm
X-Google-Smtp-Source: AGHT+IF/qerpWkSJLtedLgTezRR9OurNxz0AUUbm/plI/17+q7CkqC5pjccRmdIn+bquSalrWAoNDA==
X-Received: by 2002:a05:600c:1389:b0:455:f59e:fd9b with SMTP id
 5b1f17b1804b1-45b517c584cmr219260515e9.24.1756366754927; 
 Thu, 28 Aug 2025 00:39:14 -0700 (PDT)
Received: from localhost (112.pool92-178-7.dynamic.orange.es. [92.178.7.112])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-45b66b6985bsm54411745e9.2.2025.08.28.00.39.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 00:39:14 -0700 (PDT)
Date: Thu, 28 Aug 2025 09:39:13 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Mark Syms <mark.syms@cloud.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org,
 sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org
Subject: Re: [PATCH] [xen-block] Return BLKIF_RSP_EOPNOTSUPP for unknown
 operation
Message-ID: <aLAHoR3BtBz9G9Q0@Mac.lan>
References: <20250827160841.351707-1-mark.syms@cloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250827160841.351707-1-mark.syms@cloud.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=roger.pau@cloud.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Aug 27, 2025 at 05:08:41PM +0100, Mark Syms via wrote:
> Returning BLKIF_RSP_ERROR if an operation is not supoprted does not
> allow the frontend to exercise any discretion on how to handle the
> response and may lead to an operating system crash. As different
> backends may support different feature sets and we might, during a
> migration, switch backends, an in-flight request might be issued (or
> reissued) which is then not supported by this backend.

Linux blkfront at least will empty the ring on resume, and re-process
and queue the requests after having negotiated the (possibly) new set
of features with the backend.  That however doesn't avoid finding
flush requests that might not longer be supported by the new backend,
in which case Linux blkfront will drop such requests.

I assume the fixes done here are not targeted at dealing with a Linux
blkfront?

> Signed-off-by: Mark Syms <mark.syms@cloud.com>
> ---
>  hw/block/dataplane/xen-block.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
> index 48c2e315f3..32cf919a97 100644
> --- a/hw/block/dataplane/xen-block.c
> +++ b/hw/block/dataplane/xen-block.c
> @@ -167,7 +167,8 @@ static int xen_block_parse_request(XenBlockRequest *request)
>          return 0;
>      default:
>          error_report("error: unknown operation (%d)", request->req.operation);
> -        goto err;
> +        request->status = BLKIF_RSP_EOPNOTSUPP;
> +        return -1;

The comment in blkif.h contains:

 /* Operation not supported (only happens on barrier writes). */
#define BLKIF_RSP_EOPNOTSUPP  -2

So in principle BLKIF_RSP_EOPNOTSUPP is only to be used as a response
for BLKIF_OP_WRITE_BARRIER or BLKIF_OP_FLUSH_DISKCACHE requests,
however blkback already uses it as a response to unknown request
types (like you propose here).

Would you mind also sending a patch to adjust blkif.h in Xen to remove
the "(only happens on barrier writes)" part of the comment?

Thanks Roger.

