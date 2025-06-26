Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2805C7EE31
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 19:31:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUsJE-0003xf-75; Thu, 26 Jun 2025 15:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uUsIw-0003vP-OO
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 15:30:52 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uUsIn-0001uh-RZ
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 15:30:37 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ade58ef47c0so304991766b.1
 for <qemu-devel@nongnu.org>; Thu, 26 Jun 2025 12:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750966224; x=1751571024; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vJE06tnG0dlXGCSdZ8zdchHW1UBmff3Whee/A5+3REs=;
 b=JWIgn2XEYdh55Zereh7Zo3YbzDzCj7h0HHM6Gfj+Sp48SXzNzM9ay1vkgCR4G73W/X
 OZmQu2w8bL4T9H4RP91Q80X76cyebP2dfiVlbPDt1LIqbnbkGg6fHW/JPH/jW9mwSsBy
 LyGP/J0qRMwncHXQDe1HtDddts6lVlb+38f0TDHHwAJNqVZLw/ND5WIFjPmBUlr3G83B
 kGEHkLcAMazFlNpc8ot2f64jS9+XxLDoa4/qcFTxjarJG0duAAWiEJuTkrMajGnY9pbG
 scVUs57wfY/m0duZ8lc8wV7qjjftM65Qn2aV9o0RyCDvvHgfTggymla09XpiFi8PxTTg
 14vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750966224; x=1751571024;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vJE06tnG0dlXGCSdZ8zdchHW1UBmff3Whee/A5+3REs=;
 b=xA2SfCBqyhm+gvsy9JPkNxy/MXiiliEEcrdQX0zK55mIk2SM43nbhNGNK93NrUL5wF
 lTS3rlA7yhG9DhQb6E8fxdZXNJj6cvzn9KD+uLhKMD+ug77j9+Y4P+gtJCJR9RLu4wzY
 GemuVeLe6izvSyTUBnr681pqlmwpoNCO8ESGrxR8If7lV+pczQJtxC3IC9zBt/r7ozMi
 M6pUq9aFZza7o5BFvzkTCnJ0vgrqeTfyh9X46SOAkcziP1vHCfcYr9omKJZ4eA3UOYG/
 kTziDSsyKpopKo53LrThKaTXRzVDx7E2khPF2SLEvRPkTDxvL57GkskvEL+Murpc88oQ
 +H8A==
X-Gm-Message-State: AOJu0YwuafxKee/Wvle2G4Bno6ZskLMy5roel67v5Y1YuS6dT0/qnFEX
 XgtmPMuU4z9vtpe0Jav6pzka/Wx9710yOeTvA/6WmivpykZqQWw8HbTK98xW2MT/AsO+Mrs6fpK
 sAicauMWm8pkwxl7eQ4drsiO+CbTY9EK4LOew3fA=
X-Gm-Gg: ASbGncsR9p+9W+WJjn7BMZNJ3DWXOHwDeAvsmexHfeSy0csgTxIPWO4dQPRORA4DCfC
 /x6PuS5nwPPQ5en4R3eHJQ7L/eUoAurbaCQ1MRi/MPIUPUZzXuv+gwLaplwhbHfWJx4cbMIxzAB
 KuPA9t5dMyXLWpYA+Bgvk38gdDYmuX5RBKl3USBMRe3w==
X-Google-Smtp-Source: AGHT+IFLYC1yXv5gXB8ImV5FG6UpdHtahHSui9Aie3GNJbdKaHSEczY/D0fJnKukh6pxpQNS6edsElcPtkf29DCbXEM=
X-Received: by 2002:a17:907:9623:b0:ae0:d4ef:e35e with SMTP id
 a640c23a62f3a-ae350486cacmr20649266b.20.1750966224005; Thu, 26 Jun 2025
 12:30:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250624190336.GA19307@fedora>
 <20250625123023.33428-1-tanishdesai37@gmail.com>
 <20250626184335.GA152840@fedora>
In-Reply-To: <20250626184335.GA152840@fedora>
From: Tanish Desai <tanishdesai37@gmail.com>
Date: Fri, 27 Jun 2025 01:00:12 +0530
X-Gm-Features: Ac12FXyV2BAJ4xwCbgDYL4pYT5h6Z-d7gFDJ9DGhh5lhfpnnSTg9l9NfAj-d-Nw
Message-ID: <CAH_Y1jdswvVGdh-qYg3Pu7RjP_riR4LyMtByJ-8nM8Z2gBfirg@mail.gmail.com>
Subject: Re: [PATCH v3] tracetool: generates conitional checks when needed
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, mads@ynddal.dk, pbonzini@redhat.com
Content-Type: multipart/alternative; boundary="000000000000cbb40e06387e9776"
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=tanishdesai37@gmail.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--000000000000cbb40e06387e9776
Content-Type: text/plain; charset="UTF-8"

>
>
> > This patch does not apply to qemu.git/master. When posting new revisions
> > of patches, please resend the entire patch series that this belongs to
> > or send it as a separate patch with the Based-on: <message-id> trailer
> > to let people (and tools) know which unmerged patch series it depends
> > on.
>

Noted


> > The hasCondition list argument can be avoided by returning bool from
> > generate_h_conditional() instead of modifying the argument. That's a
> > little cleaner than the pass-by-reference trick where each backend has
> > to logical-or in their value.
>

I thought of this earlier as well and even tried to implement but
the problem
with this is h.py calls backend.generate() which calls _run_function which
inturn loops it for all backends and runs the respective generate function.
Now if I want generate_h_conditional() to return that means I need to
add a return in _run_function(..) and also need to add a return in
generate_unconditional(..) as well.
Adding a return statement to _run_function(..) didn't make much sense
to me and then I would also need to find a way to merge all the return
value(from individual backend) as well so I skipped this approach.

> The generate_h_conditional() function could also be replace with a
> > module variable like the existing PUBLIC variable. That way backends can
> > simply declare what they want instead of implementing a function:
> >
> >  CHECK_TRACE_EVENT_GET_STATE = True # or False
> >
> > And the code in h.py would know whether to call the generate function
> > inside the conditional or not. (I snuck in another suggestion: changing
> > the name from "conditional", which is a general term, to
> > "check_trace_event_get_state" to be more specific about what it does.)
>

Yes, I can do this.
Wrapper Class has attribute check_trace_event_get_state which will
be *"or"* of all CHECK_TRACE_EVENT_GET_STATE which is derived
from getattr(module, "CHECK_TRACE_EVENT_GET_STATE", False)
and finally in h.py I will have code like this

backend.generate_unconditional(...);
> if backend.check_trace_event_get_state:
>    out("if(check_trace_event_get_state(...)){")
>         backend.generate_conditional(...);
>    out("}")

--000000000000cbb40e06387e9776
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex"><br>&gt; This patch does not apply=
 to qemu.git/master. When posting new revisions<br>&gt; of patches, please =
resend the entire patch series that this belongs to<br>&gt; or send it as a=
 separate patch with the Based-on: &lt;message-id&gt; trailer<br>&gt; to le=
t people (and tools) know which unmerged patch series it depends<br>&gt; on=
.<br></blockquote><div>=C2=A0</div><div><span style=3D"white-space:unset">N=
oted</span></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">&gt; The hasCondition list argument can be avoided by returning =
bool from<br>&gt; generate_h_conditional() instead of modifying the argumen=
t. That&#39;s a<br>&gt; little cleaner than the pass-by-reference trick whe=
re each backend has<br>&gt; to logical-or in their value.<br></blockquote><=
div>=C2=A0</div><div>I thought of this earlier as well and even tried to im=
plement but the=C2=A0problem</div><div>with this is h.py calls backend.gene=
rate() which calls=C2=A0_run_function which <br>inturn loops it for all bac=
kends and runs the respective generate function.<br>Now if I want=C2=A0<spa=
n style=3D"white-space:unset">generate_h_conditional() to return that means=
 I need to=C2=A0<br>add a return in=C2=A0</span><span style=3D"white-space:=
unset">_run_function(..)</span><span style=3D"white-space:unset">=C2=A0and =
also need to add a return in=C2=A0</span></div><div><span style=3D"white-sp=
ace:unset">generate_unconditional(..) as well.<br>Adding a return statement=
 to=C2=A0</span><span style=3D"white-space:unset">_run_function(..) didn&#3=
9;t make much sense</span></div><div><span style=3D"white-space:unset">to m=
e and then=C2=A0I would also need to find a way to merge all the return<br>=
value(from individual backend) as=C2=A0</span><span style=3D"white-space:un=
set">well=C2=A0</span><span style=3D"white-space:unset">so I</span><span st=
yle=3D"white-space:unset"> skipped=C2=A0this approach.</span></div><div><sp=
an style=3D"white-space:unset"><br></span></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">&gt; The generate_h_conditional() function could als=
o be replace with a<br>&gt; module variable like the existing PUBLIC variab=
le. That way backends can<br>&gt; simply declare what they want instead of =
implementing a function:<br>
&gt;<br>&gt;=C2=A0 CHECK_TRACE_EVENT_GET_STATE =3D True # or False<br>&gt;<=
br>&gt; And the code in h.py would know whether to call the generate functi=
on<br>&gt; inside the conditional or not. (I snuck in another suggestion: c=
hanging<br>&gt; the name from &quot;conditional&quot;, which is a general t=
erm, to<br>&gt; &quot;check_trace_event_get_state&quot; to be more specific=
 about what it does.)<br></blockquote><div><br></div><div>Yes, I can do thi=
s.<br>Wrapper Class has attribute check_trace_event_get_state which will</d=
iv><div>be <b>&quot;or&quot;</b> of all=C2=A0<span style=3D"white-space:uns=
et">CHECK_TRACE_EVENT_GET_STATE which is derived=C2=A0</span></div><div><sp=
an style=3D"white-space:unset">from=C2=A0</span><span style=3D"white-space:=
unset">getattr(module, &quot;</span>CHECK_TRACE_EVENT_GET_STATE<span style=
=3D"white-space:unset">&quot;, False)</span></div><div><span style=3D"white=
-space:unset">and finally in h.py I will have code like this</span></div><d=
iv><span style=3D"white-space:unset"><br></span></div><div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex"><span style=3D"white-space:unset"><font f=
ace=3D"monospace">backend.generate_unconditional(...);<br></font></span><fo=
nt face=3D"monospace"><span style=3D"white-space:unset">if backend.</span><=
span style=3D"white-space:unset">check_trace_event_get_state:<br></span></f=
ont><font face=3D"monospace"><span style=3D"white-space:unset">=C2=A0 =C2=
=A0out(&quot;if(</span>check_trace_event_get_state(...)<span style=3D"white=
-space:unset">){&quot;)<br></span></font><font face=3D"monospace"><span sty=
le=3D"white-space:unset">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0</span><span styl=
e=3D"white-space:unset">backend.</span><span style=3D"white-space:unset">ge=
nerate_conditional(...);<br></span></font><span style=3D"white-space:unset"=
><font face=3D"monospace">=C2=A0 =C2=A0out(&quot;}&quot;)</font></span></bl=
ockquote></div></div></div>

--000000000000cbb40e06387e9776--

