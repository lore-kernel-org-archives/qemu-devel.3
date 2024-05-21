Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D0FC25B77
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 02:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9FHk-0007Vp-Oc; Mon, 20 May 2024 22:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhexu@redhat.com>) id 1s9FHj-0007VC-WC
 for qemu-devel@nongnu.org; Mon, 20 May 2024 22:31:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhexu@redhat.com>) id 1s9FHi-0007HZ-9R
 for qemu-devel@nongnu.org; Mon, 20 May 2024 22:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716258684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Ly5NYUuY/Q0GikDH0D7Ozq+sYGCLSdR6b72cZGkuZ0=;
 b=B+nz1PzBbmGhcgXYTIXPV5BaOmLCLUg/K+pD6qsHISLAKLYwW6l8JTS2D5Jr4FdDk5exE2
 qBAxkrE8c3+hXJjFMb2z0FSRGiUXCfJw3XKmS1H98fF08GRd/dl/lJTudn4Qx6pJsWiVDh
 Ju9U0Y+YEm8C8arxlL5oLywWU+7dTWQ=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-d3LX_CV4POm7TjYdqVoGnA-1; Mon, 20 May 2024 22:31:21 -0400
X-MC-Unique: d3LX_CV4POm7TjYdqVoGnA-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-61bea6bcba3so24018817b3.0
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 19:31:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716258681; x=1716863481;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4Ly5NYUuY/Q0GikDH0D7Ozq+sYGCLSdR6b72cZGkuZ0=;
 b=PCiIrY0/UfluX5w2zaeDaDVWOkZk39Fwe7emZ5LP9YZYGiv03o72N1bPLH0hrO7JsF
 PY4NlEUAeN/2JiNShlnz1wZB5+XjesvHi3y3WGymVoMnGYuc3X3e7jvsdgDhu98O5aez
 dHEaA4ApKLoB+YXtsTPlceLyo+td8TRHaSh2TbvtBNjMw8TJv0n7yzJME8aOuEomH4b0
 NrKF45ceEJg86Q2xffiVI+lvXrPnkido/AMI1Rj+i6FkAytaLkjbyMMsg+BwnU+LVbTG
 RPG0xs5VYpDAFsgoOKcM8GJh+MrDEoHSqBRQjEDkMo0UrRlm/npb/P0Qql1U/8CU7RD6
 56jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgRMuCCNgVoK0klPFX8j/ps5keSpn3sukHxhmSEnODZ46QqqlhK+lSZE4JE94i/ub/8gGWYkV6LlCIapdsdP1V6ZFgANU=
X-Gm-Message-State: AOJu0YyIcLgR06CoscI0x2hrpxZGlhsLR8ktrUxcX9AIeL4OPmnHGBYg
 mJ8c22Qe5SImvHCIwLvx0/pEta2BcIyQ6f03PgSSnXbgH4uh8zxcqR/PFrif5VHeCSkvjlAyGp8
 BqMdQyHgDj89aWo48/vNRzupr5IJmNyUfgUbq46CUwk35iexFJ8AS3UrwX38JxmMXwNXqnPiaph
 NqPzsWDm9qEF4qu2ZpeXvsWqkJggs=
X-Received: by 2002:a05:6902:114e:b0:dee:633a:dfa1 with SMTP id
 3f1490d57ef6-dee633ae7ebmr22529943276.3.1716258680757; 
 Mon, 20 May 2024 19:31:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhUYfeZJYZ/S17J8lMO61UfqIHf8xHOInClFohlqEIfgq3t1TbwJR6flO6cT/BetAR5FeUjBMZjEMat/rnPSw=
X-Received: by 2002:a05:6902:114e:b0:dee:633a:dfa1 with SMTP id
 3f1490d57ef6-dee633ae7ebmr22529917276.3.1716258680121; Mon, 20 May 2024
 19:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <cf8e13ae-cac6-4a8a-82a2-92b63a32b7b8@oracle.com> <87ed9wjey7.fsf@suse.de>
In-Reply-To: <87ed9wjey7.fsf@suse.de>
From: Peter Xu <peterx@redhat.com>
Date: Mon, 20 May 2024 22:31:08 -0400
Message-ID: <CADLect=ODs+-JrT4xOJazVveCtYPyDOCMsfK=2hcR-EJAdWDAw@mail.gmail.com>
Subject: Re: [PATCH V1 00/26] Live update: cpr-exec
To: Fabiano Rosas <farosas@suse.de>
Cc: Steven Sistare <steven.sistare@oracle.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000f8c45e0618ed9cf7"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=zhexu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--000000000000f8c45e0618ed9cf7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Conference back then pto until today, so tomorrow will be my first working
day after those. Sorry Steve, will try my best to read it before next week.
I didn't dare to read too much my inbox yet.  A bit scared but need to face
it tomorrow.

On Mon, May 20, 2024, 6:28=E2=80=AFp.m. Fabiano Rosas <farosas@suse.de> wro=
te:

> Steven Sistare <steven.sistare@oracle.com> writes:
>
> > Hi Peter, Hi Fabiano,
> >    Will you have time to review the migration guts of this series any
> time soon?
> > In particular:
> >
> > [PATCH V1 05/26] migration: precreate vmstate
> > [PATCH V1 06/26] migration: precreate vmstate for exec
> > [PATCH V1 12/26] migration: vmstate factory object
> > [PATCH V1 18/26] migration: cpr-exec-args parameter
> > [PATCH V1 20/26] migration: cpr-exec mode
> >
>
> I'll get to them this week. I'm trying to make some progress with my own
> code before I forget how to program. I'm also trying to find some time
> to implement the device options in the migration tests so we can stop
> these virtio-* breakages that have been popping up.
>
>

--000000000000f8c45e0618ed9cf7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Conference back then pto until today, so tomorrow will be=
 my first working day after those. Sorry Steve, will try my best to read it=
 before next week. I didn&#39;t dare to read too much my inbox yet.=C2=A0 A=
 bit scared but need to face it tomorrow.=C2=A0</div><br><div class=3D"gmai=
l_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 20, 2024, 6:28=
=E2=80=AFp.m. Fabiano Rosas &lt;<a href=3D"mailto:farosas@suse.de">farosas@=
suse.de</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Steven Sista=
re &lt;<a href=3D"mailto:steven.sistare@oracle.com" target=3D"_blank" rel=
=3D"noreferrer">steven.sistare@oracle.com</a>&gt; writes:<br>
<br>
&gt; Hi Peter, Hi Fabiano,<br>
&gt;=C2=A0 =C2=A0 Will you have time to review the migration guts of this s=
eries any time soon?<br>
&gt; In particular:<br>
&gt;<br>
&gt; [PATCH V1 05/26] migration: precreate vmstate<br>
&gt; [PATCH V1 06/26] migration: precreate vmstate for exec<br>
&gt; [PATCH V1 12/26] migration: vmstate factory object<br>
&gt; [PATCH V1 18/26] migration: cpr-exec-args parameter<br>
&gt; [PATCH V1 20/26] migration: cpr-exec mode<br>
&gt;<br>
<br>
I&#39;ll get to them this week. I&#39;m trying to make some progress with m=
y own<br>
code before I forget how to program. I&#39;m also trying to find some time<=
br>
to implement the device options in the migration tests so we can stop<br>
these virtio-* breakages that have been popping up.<br>
<br>
</blockquote></div>

--000000000000f8c45e0618ed9cf7--


