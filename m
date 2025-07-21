Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF82C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 20:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udx33-0000R1-5B; Mon, 21 Jul 2025 16:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1udx2b-00007d-Tc
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 16:23:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1udx2W-0002VI-PY
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 16:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753129390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SW2YZH8VPu84epFVDwEIGlufhFH/BOapke+MHbnLBRU=;
 b=W6mAD80LOJHfWliYDg2CPYw5w9betvlW1P6IN10iqx5+dJ/hXlEwF5bn5/VDXByN8aqJQ5
 agY5BtmJV6wJX2dbVQ99ZbtzzX38hq1lAx3sqAj9vs+uU7gXpwMgn++Vh402o4yHs3tQOE
 sPjLfqvJMid4UkPUciTYoLZtl/aZCXI=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-pv9INo2_P368mkdFWXlDIQ-1; Mon, 21 Jul 2025 16:23:08 -0400
X-MC-Unique: pv9INo2_P368mkdFWXlDIQ-1
X-Mimecast-MFC-AGG-ID: pv9INo2_P368mkdFWXlDIQ_1753129388
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-235196dfc50so46286525ad.1
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 13:23:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753129387; x=1753734187;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SW2YZH8VPu84epFVDwEIGlufhFH/BOapke+MHbnLBRU=;
 b=RdZCetYWvKBtDGXB4mbf5KeKcvu1joU2urwOVzCHfgIwHZp1UFaLTvIP9vXFhmnUZU
 pXcEX8fa2zNouqJq8/KpdE/lKG4g8GmOXkKVUCq9M/ICL4hh6CbHpexaIbNfGVK9eh0c
 XOIbgds+jt0OW43JXnDVyYSpezaP0ZCEHzP6yIhFbNPDCC1DGfJPKtDXJnSCRPrUKI4x
 9aDfHG1IdNbqygHGGjXociwyhOlmPCD1plOHMQBmngaGnyaupSY1wsmbjoJiFlArqCvm
 JmLoKpLjl6ncgBdHqAyb3BxM6GmqOqEWgNV8UxE/wQHEOE1nx2qniAYRkIxUzjHDBPIx
 rSeg==
X-Gm-Message-State: AOJu0Yy28a3cqYjPEVosHBOxmrq6YLrEk1rFselj+NdSjs9lIVkxa2BB
 2zCxnB2W4L88gcYtzAVoMLT98Wi6ChTIwsdT+IBziEDh+S511PO3uUPeMiim+dcNRE+1FxmCDnC
 YrhBw7XLLOMDal8sctTBeEKQ7AEU3oIsCCrsBAswr9VklsdsHYR9OE1uj8Ud6bj2TyYHLQwwhwb
 fcL0dYZCtHU7KUicF7Y1hjsqNfRFOWr40qnj2JtGQ=
X-Gm-Gg: ASbGncuHV7Pj5/7CuEj++GT13WqBMx4PyMFuNLEYhK5h+pz44IyRxUtK7Xh5qOTi30U
 NX/I1YkVKf1Z5j+lHeL8Idg2Qmn3GtTeG1QPfqxHvyv/mrzE/qj5fGVfKMskX5b1muUklEcGNRp
 PW/rLaliSMRBPKkxSCDnpIsZsqWH5QrDVK74fXfsOsewZwmJdtxYeJ
X-Received: by 2002:a17:903:1446:b0:233:d3e7:6fd6 with SMTP id
 d9443c01a7336-23f8acccc85mr12172475ad.19.1753129386737; 
 Mon, 21 Jul 2025 13:23:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVWdrH/XweNOqtMCDsHQ7VRAghnTcZEbI7W6qprYngq4iDLQYZrAjoG4cmYTKXlLY55JV1HOyWj027CYbe0VE=
X-Received: by 2002:a17:903:1446:b0:233:d3e7:6fd6 with SMTP id
 d9443c01a7336-23f8acccc85mr12172215ad.19.1753129386242; Mon, 21 Jul 2025
 13:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250717115751.3832597-1-armbru@redhat.com>
In-Reply-To: <20250717115751.3832597-1-armbru@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Mon, 21 Jul 2025 16:22:52 -0400
X-Gm-Features: Ac12FXwng3wvA5onVCgLLH9bqk3a7qSJ8RO7r4eTeI1Ru6rty1gnGz9rUHaGLNI
Message-ID: <CAFn=p-ZB5K_++-6SwvoMN59dBdrdCvXaeBPmsUGYQxqToRRpBg@mail.gmail.com>
Subject: Re: [PATCH] qapi: Add more cross-references
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jul 17, 2025 at 7:57=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> We recently (merge commit 504632dcc631) enclosed command and type
> names in `backquotes`, so they become links in generated HTML.  Take
> care of a few we missed.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/dump.json      | 2 +-
>  qapi/machine.json   | 2 +-
>  qapi/migration.json | 4 ++--
>  qapi/misc-i386.json | 2 +-
>  qapi/run-state.json | 2 +-
>  qapi/sockets.json   | 2 +-
>  6 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/qapi/dump.json b/qapi/dump.json
> index 32c8c1f06e..726b520870 100644
> --- a/qapi/dump.json
> +++ b/qapi/dump.json
> @@ -79,7 +79,7 @@
>  #
>  # @detach: if true, QMP will return immediately rather than waiting
>  #     for the dump to finish.  The user can track progress using
> -#     "query-dump".  (since 2.6).
> +#     `query-dump`.  (since 2.6).

Funny. Offset and in quotes, so it got missed.

>  #
>  # @begin: if specified, the starting physical address.
>  #
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 6f59f70ca6..038eab281c 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -2087,7 +2087,7 @@
>  #
>  # @deprecated-props: an optional list of properties that are flagged as
>  #     deprecated by the CPU vendor.  The list depends on the
> -#     CpuModelExpansionType: "static" properties are a subset of the
> +#     `CpuModelExpansionType`: "static" properties are a subset of the

"What are the odds that a name we want to turn into a reference will
be immediately followed by a colon?" 100%, I guess.

>  #     enabled-properties for the expanded model; "full" properties are
>  #     a set of properties that are deprecated across all models for
>  #     the architecture.  (since: 10.1 -- since 9.1 on s390x --).
> diff --git a/qapi/migration.json b/qapi/migration.json
> index e08a99bb82..2387c21e9c 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -641,7 +641,7 @@
>  #
>  #     This mode supports VFIO devices provided the user first puts the
>  #     guest in the suspended runstate, such as by issuing
> -#     guest-suspend-ram to the QEMU guest agent.
> +#     `guest-suspend-ram` to the QEMU guest agent.

Missed because it's indented?

>  #
>  #     Best performance is achieved when the memory backend is shared
>  #     and the @x-ignore-shared migration capability is set, but this
> @@ -1704,7 +1704,7 @@
>  #
>  # .. admonition:: Notes
>  #
> -#     1. The 'query-migrate' command should be used to check
> +#     1. The `query-migrate` command should be used to check
>  #        migration's progress and final result (this information is
>  #        provided by the 'status' member).

Indent miss.

>  #
> diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
> index c8c91a241c..d1ce8caf25 100644
> --- a/qapi/misc-i386.json
> +++ b/qapi/misc-i386.json
> @@ -8,7 +8,7 @@
>  #
>  # Reset the RTC interrupt reinjection backlog.  Can be used if another
>  # mechanism to synchronize guest time is in effect, for example QEMU
> -# guest agent's guest-set-time command.
> +# guest agent's `guest-set-time` command.

Why'd I miss this one, I wonder?

>  #
>  # Use of this command is only applicable for x86 machines with an RTC,
>  # and on other machines will silently return without performing any
> diff --git a/qapi/run-state.json b/qapi/run-state.json
> index 54ba5c9a3f..4757947ca6 100644
> --- a/qapi/run-state.json
> +++ b/qapi/run-state.json
> @@ -20,7 +20,7 @@
>  # @inmigrate: guest is paused waiting for an incoming migration.  Note
>  #     that this state does not tell whether the machine will start at
>  #     the end of the migration.  This depends on the command-line -S
> -#     option and any invocation of 'stop' or 'cont' that has happened
> +#     option and any invocation of `stop` or `cont` that has happened

Rare instance of actually *wanting* these to be cross-refs. :)

>  #     since QEMU was started.
>  #
>  # @internal-error: An internal error that prevents further guest
> diff --git a/qapi/sockets.json b/qapi/sockets.json
> index 82046b0b3a..32fac51728 100644
> --- a/qapi/sockets.json
> +++ b/qapi/sockets.json
> @@ -143,7 +143,7 @@
>  #
>  # @str: decimal is for file descriptor number, otherwise it's a file
>  #     descriptor name.  Named file descriptors are permitted in
> -#     monitor commands, in combination with the 'getfd' command.
> +#     monitor commands, in combination with the `getfd` command.
>  #     Decimal file descriptors are permitted at startup or other
>  #     contexts where no monitor context is active.

Presumably another indent miss.

>  #
> --
> 2.49.0

Reviewed-by: John Snow <jsnow@redhat.com>


