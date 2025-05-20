Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1908DC54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 19:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHSE0-0001l1-MV; Tue, 20 May 2025 15:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uHSDo-0001js-0z
 for qemu-devel@nongnu.org; Tue, 20 May 2025 15:01:52 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uHSDm-0007Rg-2C
 for qemu-devel@nongnu.org; Tue, 20 May 2025 15:01:51 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-601dbd75b74so4260370a12.1
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 12:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747767708; x=1748372508; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JVKWJHUsC8WUiugqIyQxvTIOG0m7fYYnAvC/IknFnvE=;
 b=K6FEeSp9Pd+gCgHhGwL77ix2ivd/114OGmCb43tKwKLWU4pSMtxKvMes/NX1BG/R0I
 S1Hgy9kHzUnuflWKw6Vw66RI80z/emCKJC3iqQ2b2sc7/BcFW1yABzAOEFh4S+jMBSHO
 UZHQVP8sjq4MkHAHuNVOsBmGRJUNp/9JLjQwQ9HQfOVWtPk7tnaCAVrefpt9iJ9Qg4ZX
 YfLvnFMMI9PmNINwtAdoCigb8j0x91GVVMuGR9KP6nnmnklBMmlQIhxBmbK9QQtz9a0j
 acQS5A4pXEyqHnVfFIc+JyYnQoPhMC7XmbbldkM6KvMimo3p8LTLjnxb+UvRob87EsOx
 OtKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747767708; x=1748372508;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JVKWJHUsC8WUiugqIyQxvTIOG0m7fYYnAvC/IknFnvE=;
 b=if00FATwq+VW8oNjt+S3pLqbUcqBQVKmTOn1fvWaNopDEJGmz2K2Y2vDerLon8cyWT
 IHM7+dFrQihIYm2qFZKZ8EDPjydAMGxj5ntRV75Gwijk8W3cUrGScKrUfhfdoe+U3FTL
 bFr52LMHb54QsNg0YEqHmUGDWFJ9VsJ8FlgxjvxD/V/JjPyFBgzyVljkhVoHjLym4IGa
 yFnSLB+v041AS4IkVO0ubHVGr3PwLLzRTUDfvsA22ie6uLnrpn2jZWSpOZaLDXvRSBLj
 KkHF7u6zkM/oV6uEskvSWh9+QcGRqid20TfmJ95i9wdg8uU4I0lQyDHt9glKKMHvhbDd
 vvmQ==
X-Gm-Message-State: AOJu0YxK351XMiEK9g69oObMrBJfJIRdqXhtPxwAs/AkFP2JJyiqmfyx
 ws9XzwuvlQ0ikij+LJS9YJ461hOtr4TXPLXwv3U877id3rxozrBvX/1obLnK39VcIBgwwcdyAOM
 GoRSWTZkx0lZjW/DQQnmEptkAQC65eGU=
X-Gm-Gg: ASbGncsVM7KsPqbFqe1KFHxQJkuyrNRZYmrDyJukQPfslLn8e8LMwEJB0sICoiXMRU7
 mSKc9LxzPPZPCu89hOQHyluHBIgkubVhNWTSH90eHtqfZ+SlhJyvA7r5vLpe1SJrYoVhmgVneeR
 ITRnA9zFtrteXdW5Y7wpDWGu4Uly86gnc=
X-Google-Smtp-Source: AGHT+IE1y2CViM9dxjQ5oQhYGxU09uCVD0VEQUdNPMdgtlklh0AmvZNZ3oNNmRnKpiRvnrsAlv/rG0LSLP6BkqEsa5s=
X-Received: by 2002:a05:6402:90b:b0:5f8:e6e5:54ac with SMTP id
 4fb4d7f45d1cf-6011409bbc9mr15025042a12.14.1747767707481; Tue, 20 May 2025
 12:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250519185108.14412-1-tanishdesai37@gmail.com>
In-Reply-To: <20250519185108.14412-1-tanishdesai37@gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 20 May 2025 15:01:34 -0400
X-Gm-Features: AX0GCFsz1WdfNMubKgyFkxWS92Fhl59hLxPJ9S_aqnb6oQjLK97R7kVLsU1x-uI
Message-ID: <CAJSP0QVOSGKnt8YCay5r+HR2O6xCz9Nb5Hp4TOzsSHE9fpYgHw@mail.gmail.com>
Subject: Re: [PATCH] trace/simple: seperate hot paths of tracing fucntions
To: Tanish Desai <tanishdesai37@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, Mads Ynddal <mads@ynddal.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, May 19, 2025 at 2:52=E2=80=AFPM Tanish Desai <tanishdesai37@gmail.c=
om> wrote:
>
> Remove hot paths from .c file and added it in .h file to keep it inline.

Please include performance results in the commit description so it's
clear what impact this change has.

>
> Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
> ---
>  scripts/tracetool/backend/simple.py | 23 ++++++++++-------------

Please use scripts/get_maintainer.pl to find the emails to CC:

  $ scripts/get_maintainer.pl -f scripts/tracetool/backend/simple.py
  Stefan Hajnoczi <stefanha@redhat.com> (maintainer:Tracing)
  Mads Ynddal <mads@ynddal.dk> (reviewer:Tracing)
  qemu-devel@nongnu.org (open list:All patches CC here)

qemu-devel is a high-traffic list and maintainers may not see your
patches unless you CC them.

>  1 file changed, 10 insertions(+), 13 deletions(-)
>
> diff --git a/scripts/tracetool/backend/simple.py b/scripts/tracetool/back=
end/simple.py
> index a74d61fcd6..2688d4b64b 100644
> --- a/scripts/tracetool/backend/simple.py
> +++ b/scripts/tracetool/backend/simple.py
> @@ -36,8 +36,17 @@ def generate_h_begin(events, group):
>
>
>  def generate_h(event, group):
> -    out('    _simple_%(api)s(%(args)s);',
> +    event_id =3D 'TRACE_' + event.name.upper()
> +    if "vcpu" in event.properties:
> +        # already checked on the generic format code
> +        cond =3D "true"
> +    else:
> +        cond =3D "trace_event_get_state(%s)" % event_id
> +    out('    if (%(cond)s) {',
> +        '        _simple_%(api)s(%(args)s);',
> +        '    }',
>          api=3Devent.api(),
> +        cond=3Dcond,
>          args=3D", ".join(event.args.names()))
>
>
> @@ -72,22 +81,10 @@ def generate_c(event, group):
>      if len(event.args) =3D=3D 0:
>          sizestr =3D '0'
>
> -    event_id =3D 'TRACE_' + event.name.upper()
> -    if "vcpu" in event.properties:
> -        # already checked on the generic format code
> -        cond =3D "true"
> -    else:
> -        cond =3D "trace_event_get_state(%s)" % event_id
> -
>      out('',
> -        '    if (!%(cond)s) {',
> -        '        return;',
> -        '    }',
> -        '',
>          '    if (trace_record_start(&rec, %(event_obj)s.id, %(size_str)s=
)) {',
>          '        return; /* Trace Buffer Full, Event Dropped ! */',
>          '    }',
> -        cond=3Dcond,
>          event_obj=3Devent.api(event.QEMU_EVENT),
>          size_str=3Dsizestr)
>
> --
> 2.34.1
>
>

