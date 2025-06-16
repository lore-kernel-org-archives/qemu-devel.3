Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53DC3C71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 19:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRFRA-0007Sa-Mk; Mon, 16 Jun 2025 15:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uRFR8-0007SM-Os
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 15:24:06 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uRFR6-00014W-UC
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 15:24:06 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ad89333d603so903527266b.2
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 12:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750101842; x=1750706642; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B3k0kpoT27CvhHBwVEaSoLXbx2YTlJQWvxSphhJG/F0=;
 b=MLdrucwa1Co3TrvNcJxWg8BleOr7I0ViyIwLKLP8qTDXsL46y7c9OxIiEpVwFHhzIA
 9QmZU9xSuJehgGeCZJ88/07Vj1db6Jjx9BqGx2lO1THm59zpizwIPRL72JfgHD6EfczV
 ALjFdN/887I7vCBESdbAVMwmPzE8gY7OEV4SqkezUlahdlUV4such+Kq7YAVH+/1Q4N/
 9akoZKEAIVbKrGxU2LBhGL3Mh6tHfys77PhaMWZ8ulcOWdyDApDUcELqSm9TzDhagQmZ
 74nd0cfIm1iK8Gk4wX0V1TWFc4PvzDHqMPNZI+u6rvF8ml7BMK8VpgSFubMf2Kve8YMP
 h51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750101842; x=1750706642;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B3k0kpoT27CvhHBwVEaSoLXbx2YTlJQWvxSphhJG/F0=;
 b=VHBhZ/hdyA8aV7W0Bj6PrI8aLyheF7MxR/3IJo8wylo9zc4CqJDITAbiW7tcZbioYQ
 pDUu6ARJ4OZM+IpAEZH46Gp54eZLThskNGjsyw7okcYFNvQPhxIu+b1mEf4gcZf9Ovpw
 ZX3Fp9wS0Qg9VTcx5OuU1PaRQZC9wQWYu7lv201ZtImiYP6LrZ8QQODVEE4zSgOv/2hI
 9vtAj/KZqGMvYQrHADVqeTpQp+LHlG8jOovdtVkeSvEvAI7tb/CtnRXirlHukZvJqfi5
 clox78VNCA3mRaAjyh0IwN9862STQuGCmY9Zrj691dvJ5wQCs0pG9ReQnlLflE3irgdy
 nn3w==
X-Gm-Message-State: AOJu0YwcrgceJ8EdpRQo8+NbjsF+LRYBPWcgZyFH6Mpex9Phv51WXkJe
 yQJoMWHepWnAvhJC0l2Ji/jqkgHV8VCJi7nrvvaPRNmwq/ISoGG7nEvm9IKJMCg43G9wjoa59xH
 Vrpu+NuVZFOYnwgTXu58CFHIsB09YHvr3wqJP
X-Gm-Gg: ASbGncth16jWg3X78GwzWVnbhpbskNjwSoHG2/k2La90ME5RIZst70NcpJaObLhAxR1
 +jGwOQrvOyL+YJZtMaNDP4t8LRe7gwNqPnQ1r8BCo2XTX3ff1cDP5y7lpwN9n+IpR3ZPpOFO5b3
 Hfc9k3aUC9NAVeL5dearqLmau3u++V1kZLBF+Hu78wySI=
X-Google-Smtp-Source: AGHT+IFSxO1hKWLC1JprIS60NhLXaVLhe1eW21hzqfiiFst1alt2bDzomxMQPR/lzWP4FroVvd4zWJxVokvsRRdZRJ4=
X-Received: by 2002:a17:907:1b0d:b0:ade:5fb:53bd with SMTP id
 a640c23a62f3a-adfad3c5445mr1074354866b.20.1750101841907; Mon, 16 Jun 2025
 12:24:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAH_Y1jddDfA+Vnc+G9MZ55C87-=7h_kEiJJVBQOs6sW1WRtaKw@mail.gmail.com>
 <CAJSP0QXOKrRKnzQpuRdEiON7MWbaS7M2b6cNvsE3opfcCzX2nw@mail.gmail.com>
In-Reply-To: <CAJSP0QXOKrRKnzQpuRdEiON7MWbaS7M2b6cNvsE3opfcCzX2nw@mail.gmail.com>
From: Tanish Desai <tanishdesai37@gmail.com>
Date: Tue, 17 Jun 2025 00:53:50 +0530
X-Gm-Features: AX0GCFtj7aiqfOerJwSeWfPzYQY1ruzv8ox4AAu0WfQ6K8omr3ShWjbVRQkQaIE
Message-ID: <CAH_Y1jc9nG1jX6zBKSs-+Sib5JHc=171s+Hjzqc63YWTEa2rxQ@mail.gmail.com>
Subject: Fwd: Some doubts regarding scripts/tracetool/backend/*.py
To: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000009b95c50637b556a6"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=tanishdesai37@gmail.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--0000000000009b95c50637b556a6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

---------- Forwarded message ---------
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, Jun 17, 2025 at 12:00=E2=80=AFAM
Subject: Re: Some doubts regarding scripts/tracetool/backend/*.py
To: Tanish Desai <tanishdesai37@gmail.com>


On Mon, Jun 16, 2025 at 12:48=E2=80=AFAM Tanish Desai <tanishdesai37@gmail.=
com>
wrote:

Please CC qemu-devel and Paolo Bonzini so that others can participate
in discussion.

> Why do we use a _no_check_trace_foo function when trace_foo ultimately
just calls it in all backends?
> Why wasn=E2=80=99t the logic of _no_check_trace_foo directly included ins=
ide
trace_foo during the module's design?

I found the history of nocheck using `git log -p
scripts/tracetool/format/h.py`: nocheck was originally used by the TCG
tracing feature but was removed in commit 126d4123c50a ("tracing:
excise the tcg related from tracetool").

As far as I'm aware nothing needs nocheck anymore so code could be
refactored without worrying about existing users.

> I=E2=80=99m asking because I=E2=80=99m working on unifying the two if sta=
tements: one
unconditional if (true) in trace_foo, and another conditional if
(trace_event_get_state(...)) inside _no_check_trace_foo for older backends.
Removing this redundancy could improve performance by eliminating an extra
branch instruction per trace call, along with minor memory savings.(This
was inspired by the patch of simple backend which also did somewhat similar=
)

"if (true)" was also left over from the TCG tracing feature removal.

Removing nocheck and "if (true)" would be nice cleanups since they are
remnants of an old feature and no longer necessary today.

I see this more as tidying up, rather than a performance optimization
opportunity. _nocheck__trace_foo() and trace_foo() are both static
inline in the same header file. The compiler can trivially optimize
them. If "if (true)" is removed and the nocheck function is no longer
generated there probably won't be any change in the machine code
because the compiler already figured that out. debuginfo should be
smaller, but that does not affect performance at runtime and most
users will not have it installed on their systems.

Stefan

--0000000000009b95c50637b556a6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">---------- Forwarded message ---------<br>Fro=
m: <strong class=3D"gmail_sendername" dir=3D"auto">Stefan Hajnoczi</strong>=
 <span dir=3D"auto">&lt;<a href=3D"mailto:stefanha@gmail.com">stefanha@gmai=
l.com</a>&gt;</span><br>Date: Tue, Jun 17, 2025 at 12:00=E2=80=AFAM<br>Subj=
ect: Re: Some doubts regarding scripts/tracetool/backend/*.py<br>To: Tanish=
 Desai &lt;<a href=3D"mailto:tanishdesai37@gmail.com">tanishdesai37@gmail.c=
om</a>&gt;<br></div><br><br>On Mon, Jun 16, 2025 at 12:48=E2=80=AFAM Tanish=
 Desai &lt;<a href=3D"mailto:tanishdesai37@gmail.com" target=3D"_blank">tan=
ishdesai37@gmail.com</a>&gt; wrote:<br>
<br>
Please CC qemu-devel and Paolo Bonzini so that others can participate<br>
in discussion.<br>
<br>
&gt; Why do we use a _no_check_trace_foo function when trace_foo ultimately=
 just calls it in all backends?<br>
&gt; Why wasn=E2=80=99t the logic of _no_check_trace_foo directly included =
inside trace_foo during the module&#39;s design?<br>
<br>
I found the history of nocheck using `git log -p<br>
scripts/tracetool/format/h.py`: nocheck was originally used by the TCG<br>
tracing feature but was removed in commit 126d4123c50a (&quot;tracing:<br>
excise the tcg related from tracetool&quot;).<br>
<br>
As far as I&#39;m aware nothing needs nocheck anymore so code could be<br>
refactored without worrying about existing users.<br>
<br>
&gt; I=E2=80=99m asking because I=E2=80=99m working on unifying the two if =
statements: one unconditional if (true) in trace_foo, and another condition=
al if (trace_event_get_state(...)) inside _no_check_trace_foo for older bac=
kends. Removing this redundancy could improve performance by eliminating an=
 extra branch instruction per trace call, along with minor memory savings.(=
This was inspired by the patch of simple backend which also did somewhat si=
milar)<br>
<br>
&quot;if (true)&quot; was also left over from the TCG tracing feature remov=
al.<br>
<br>
Removing nocheck and &quot;if (true)&quot; would be nice cleanups since the=
y are<br>
remnants of an old feature and no longer necessary today.<br>
<br>
I see this more as tidying up, rather than a performance optimization<br>
opportunity. _nocheck__trace_foo() and trace_foo() are both static<br>
inline in the same header file. The compiler can trivially optimize<br>
them. If &quot;if (true)&quot; is removed and the nocheck function is no lo=
nger<br>
generated there probably won&#39;t be any change in the machine code<br>
because the compiler already figured that out. debuginfo should be<br>
smaller, but that does not affect performance at runtime and most<br>
users will not have it installed on their systems.<br>
<br>
Stefan<br>
</div></div>

--0000000000009b95c50637b556a6--

