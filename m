Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18DFC71157
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 16:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYj9-0000YF-AC; Tue, 17 Jun 2025 12:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uRYcR-0004fv-Rs
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:53:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uRYcN-00086E-Aa
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:53:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750175578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F4Gxdm+xcAbyZgNWf3Hg1JfGy7tAiBkLt6vETvm7wdo=;
 b=V3rmCg55UVC1VjDv/hSKmkEO1YF6KLrILwya6Jz6spgoUr2+bLUWD2BPQRe7FAV9q2gDwf
 YfWWmgNA1zmXYVX45tHSIPwken4iAvk9xkzWV+xJoeVi7126wHXDDM9AdzuLLqRy3zJYtu
 Eix5lswp9p92SnqWwOho4NaWf5yimYA=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-XdjMO5ScPyieNyVS9A3GPQ-1; Tue, 17 Jun 2025 11:52:56 -0400
X-MC-Unique: XdjMO5ScPyieNyVS9A3GPQ-1
X-Mimecast-MFC-AGG-ID: XdjMO5ScPyieNyVS9A3GPQ_1750175575
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2369dd58602so1860285ad.1
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 08:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750175575; x=1750780375;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F4Gxdm+xcAbyZgNWf3Hg1JfGy7tAiBkLt6vETvm7wdo=;
 b=He1Vq7a1gt/lN7gAclilBU6jR7FkHcl+KtFhOCc/xV4hLybiMmHKViCbVFvcF2VU3i
 rLE8K0Zn2iKiF8Qpe5Z9z0Pls5GyTQi6InMludJzN1UqJYO02B4sGhxOdA7zsjAyM8Oo
 sp/pvMJgIlxRTqfd0SiGR8V2Ps4ZIr6x4nzvNSuJno6cx8N/uphDUnTtZkR7HQeMm403
 YZk5/erlTc7FAtYgR7VhIOKDaVO3C/JmEtEz9LyP0t36iOqIr4JqxmvB6BgrZ6Za2XeS
 5AkRgQnEzedTlr9q9dP58L8Ei5r+ijcaXrQQFFUq+Y/YECWBo+7tStsp67hzQC4VFVBY
 XSpQ==
X-Gm-Message-State: AOJu0YxtS+ll6yFFL32/4gcub3saqRwt0uS5S8YGUgo67zK8ut9/UdS6
 j2A9YKmnDZFBw6f5+ntl3yaW87O6ADXDfVnfC5Pcb/P6ZgR+HnTNcbWaEa/H3csGXYw0HsKtayd
 q1AM9j/4GfRS5hVSgqGlE089V6ro1X4+4ZI2UJagad2zoL3F+hVG6Svy3MFz6ndXksUxfIJ9VVx
 2yv3/14FWS9MmDTba/SNXpqb6cC9/rGfo=
X-Gm-Gg: ASbGnctd2sOUAB5h8qVN5+8xS0DiABPP420tJgEf2ODQ/9CsoZ/t+MbegSPdVoZ++Qy
 3Y1MSy1Y3N5eAK0Y2CayhWhxehMs139mzghK0hm34gQRtwOoZzvhjhjw5hrJmvOLAfELkmLoHfl
 6p/RSIT2ABNUfNKlaU2xAgNYS31J8E3u/e9w==
X-Received: by 2002:a17:90b:350c:b0:312:f0d0:bb0 with SMTP id
 98e67ed59e1d1-313f1ca0fbfmr26514686a91.12.1750175574644; 
 Tue, 17 Jun 2025 08:52:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHxJrWNFcK2/79BrkP+JHwBJoHNjZIR1s2/UmP3aKYOex68AC/E6YMXKeIMAfEBsgzycaBNYong/qWkuRgv5c=
X-Received: by 2002:a17:90b:350c:b0:312:f0d0:bb0 with SMTP id
 98e67ed59e1d1-313f1ca0fbfmr26514626a91.12.1750175573986; Tue, 17 Jun 2025
 08:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250612205451.1177751-1-jsnow@redhat.com>
 <20250612205451.1177751-7-jsnow@redhat.com>
 <9C057F25-8BE4-45FC-9332-99F24440DB92@ynddal.dk>
In-Reply-To: <9C057F25-8BE4-45FC-9332-99F24440DB92@ynddal.dk>
From: John Snow <jsnow@redhat.com>
Date: Tue, 17 Jun 2025 11:52:40 -0400
X-Gm-Features: AX0GCFsuUgDDRlS0rl88kz7AniydcsMDdrQ5XUJ9XCcVPUFVLTFv0N4Feru0eFA
Message-ID: <CAFn=p-ZMB61pN6swURytd_m7vJuXEW+HyuTmVcWzkME-XNMCqw@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] python: upgrade to python3.9+ syntax
To: Mads Ynddal <mads@ynddal.dk>
Cc: qemu-devel <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 Yi Liu <yi.l.liu@intel.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Helge Deller <deller@gmx.de>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Fabiano Rosas <farosas@suse.de>, 
 Alexander Bulekov <alxndr@bu.edu>, Darren Kenny <darren.kenny@oracle.com>, 
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Ed Maste <emaste@freebsd.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Warner Losh <imp@bsdimp.com>, 
 Kevin Wolf <kwolf@redhat.com>, Tyrone Ting <kfting@nuvoton.com>,
 Eric Blake <eblake@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Troy Lee <leetroy@gmail.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Michael Roth <michael.roth@amd.com>, 
 Laurent Vivier <laurent@vivier.eu>, Ani Sinha <anisinha@redhat.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 Eric Farman <farman@linux.ibm.com>, Steven Lee <steven_lee@aspeedtech.com>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, Li-Wen Hsu <lwhsu@freebsd.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-s390x@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Qemu-block <qemu-block@nongnu.org>, Bernhard Beschow <shentey@gmail.com>, 
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu=2D=2DDrif?= <clement.mathieu--drif@eviden.com>, 
 Maksim Davydov <davydov-max@yandex-team.ru>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, 
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, Paul Durrant <paul@xen.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Jagannathan Raman <jag.raman@oracle.com>, 
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, 
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Cleber Rosa <crosa@redhat.com>, Eric Auger <eric.auger@redhat.com>, 
 Yanan Wang <wangyanan55@huawei.com>, qemu-arm <qemu-arm@nongnu.org>, 
 Hao Wu <wuhaotsh@google.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 qemu-riscv@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Michael Rolnik <mrolnik@gmail.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Alessandro Di Federico <ale@rev.ng>, Thomas Huth <thuth@redhat.com>,
 Antony Pavlov <antonynpavlov@gmail.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Qiuhao Li <Qiuhao.Li@outlook.com>, Hyman Huang <yong.huang@smartx.com>, 
 =?UTF-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>, 
 Magnus Damm <magnus.damm@gmail.com>, qemu-rust@nongnu.org,
 Bandan Das <bsd@redhat.com>, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 kvm@vger.kernel.org, Fam Zheng <fam@euphon.net>, Jia Liu <proljc@gmail.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, 
 Kyle Evans <kevans@freebsd.org>, Song Gao <gaosong@loongson.cn>, 
 Alexandre Iooss <erdnaxe@crans.org>, Aurelien Jarno <aurelien@aurel32.net>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Peter Xu <peterx@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>, 
 qemu-ppc@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>, 
 Beniamino Galvani <b.galvani@gmail.com>, David Hildenbrand <david@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Ahmed Karaman <ahmedkhaledkaraman@gmail.com>, 
 Huacai Chen <chenhuacai@kernel.org>, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Content-Type: multipart/alternative; boundary="0000000000006200220637c68115"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--0000000000006200220637c68115
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025, 5:16=E2=80=AFAM Mads Ynddal <mads@ynddal.dk> wrote:

>
> > diff --git a/scripts/simpletrace.py b/scripts/simpletrace.py
> > index cef81b0707f..a013e4402de 100755
> > --- a/scripts/simpletrace.py
> > +++ b/scripts/simpletrace.py
> > @@ -9,13 +9,15 @@
> > #
> > # For help see docs/devel/tracing.rst
> >
> > -import sys
> > -import struct
> > import inspect
> > +import struct
> > +import sys
> > import warnings
> > -from tracetool import read_events, Event
> > +
> > +from tracetool import Event, read_events
> > from tracetool.backend.simple import is_string
> >
> > +
> > __all__ =3D ['Analyzer', 'Analyzer2', 'process', 'run']
> >
> > # This is the binary format that the QEMU "simple" trace backend
> > @@ -166,11 +168,9 @@ def runstate_set(self, timestamp, pid, new_state):
> >
> >     def begin(self):
> >         """Called at the start of the trace."""
> > -        pass
> >
> >     def catchall(self, event, rec):
> >         """Called if no specific method for processing a trace event ha=
s
> been found."""
> > -        pass
> >
> >     def _build_fn(self, event):
> >         fn =3D getattr(self, event.name, None)
> > @@ -208,7 +208,6 @@ def _process_event(self, rec_args, *, event,
> event_id, timestamp_ns, pid, **kwar
> >
> >     def end(self):
> >         """Called at the end of the trace."""
> > -        pass
> >
> >     def __enter__(self):
> >         self.begin()
> > @@ -263,7 +262,6 @@ def runstate_set(self, new_state, *, timestamp_ns,
> pid, **kwargs):
> >
> >     def catchall(self, *rec_args, event, timestamp_ns, pid, event_id,
> **kwargs):
> >         """Called if no specific method for processing a trace event ha=
s
> been found."""
> > -        pass
> >
> >     def _process_event(self, rec_args, *, event, **kwargs):
> >         fn =3D getattr(self, event.name, self.catchall)
> > @@ -279,7 +277,7 @@ def process(events, log, analyzer, read_header=3DTr=
ue):
> >     """
> >
> >     if isinstance(events, str):
> > -        with open(events, 'r') as f:
> > +        with open(events) as f:
> >             events_list =3D read_events(f, events)
> >     elif isinstance(events, list):
> >         # Treat as a list of events already produced by
> tracetool.read_events
> > @@ -332,7 +330,7 @@ def run(analyzer):
> >     except (AssertionError, ValueError):
> >         raise SimpleException(f'usage: {sys.argv[0]} [--no-header]
> <trace-events> <trace-file>\n')
> >
> > -    with open(trace_event_path, 'r') as events_fobj,
> open(trace_file_path, 'rb') as log_fobj:
> > +    with open(trace_event_path) as events_fobj, open(trace_file_path,
> 'rb') as log_fobj:
> >         process(events_fobj, log_fobj, analyzer, read_header=3Dnot
> no_header)
> >
> > if __name__ =3D=3D '__main__':
>
> I'm not really a fan of the implicit default arguments, but I guess the
> rest is fine. If this is the way everyone else wants to go, I won't stand
> in the way.
>

I can manually restore it. It just happens to be the style the upgrade tool
prefers which saves an awful lot of manual work, but I have no prejudice
against explicit open parameters.

Thanks for reviewing!


> =E2=80=94
> Mads Ynddal
>
>

--0000000000006200220637c68115
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 17, 2025, 5:16=E2=80=
=AFAM Mads Ynddal &lt;<a href=3D"mailto:mads@ynddal.dk">mads@ynddal.dk</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br>
&gt; diff --git a/scripts/simpletrace.py b/scripts/simpletrace.py<br>
&gt; index cef81b0707f..a013e4402de 100755<br>
&gt; --- a/scripts/simpletrace.py<br>
&gt; +++ b/scripts/simpletrace.py<br>
&gt; @@ -9,13 +9,15 @@<br>
&gt; #<br>
&gt; # For help see docs/devel/tracing.rst<br>
&gt; <br>
&gt; -import sys<br>
&gt; -import struct<br>
&gt; import inspect<br>
&gt; +import struct<br>
&gt; +import sys<br>
&gt; import warnings<br>
&gt; -from tracetool import read_events, Event<br>
&gt; +<br>
&gt; +from tracetool import Event, read_events<br>
&gt; from tracetool.backend.simple import is_string<br>
&gt; <br>
&gt; +<br>
&gt; __all__ =3D [&#39;Analyzer&#39;, &#39;Analyzer2&#39;, &#39;process&#39=
;, &#39;run&#39;]<br>
&gt; <br>
&gt; # This is the binary format that the QEMU &quot;simple&quot; trace bac=
kend<br>
&gt; @@ -166,11 +168,9 @@ def runstate_set(self, timestamp, pid, new_state)=
:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0def begin(self):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Called at the start=
 of the trace.&quot;&quot;&quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 pass<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0def catchall(self, event, rec):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Called if no specif=
ic method for processing a trace event has been found.&quot;&quot;&quot;<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 pass<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0def _build_fn(self, event):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fn =3D getattr(self, <a href=3D"http:=
//event.name" rel=3D"noreferrer noreferrer" target=3D"_blank">event.name</a=
>, None)<br>
&gt; @@ -208,7 +208,6 @@ def _process_event(self, rec_args, *, event, event=
_id, timestamp_ns, pid, **kwar<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0def end(self):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Called at the end o=
f the trace.&quot;&quot;&quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 pass<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0def __enter__(self):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.begin()<br>
&gt; @@ -263,7 +262,6 @@ def runstate_set(self, new_state, *, timestamp_ns,=
 pid, **kwargs):<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0def catchall(self, *rec_args, event, timestamp_ns, =
pid, event_id, **kwargs):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Called if no specif=
ic method for processing a trace event has been found.&quot;&quot;&quot;<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 pass<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0def _process_event(self, rec_args, *, event, **kwar=
gs):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fn =3D getattr(self, <a href=3D"http:=
//event.name" rel=3D"noreferrer noreferrer" target=3D"_blank">event.name</a=
>, self.catchall)<br>
&gt; @@ -279,7 +277,7 @@ def process(events, log, analyzer, read_header=3DT=
rue):<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0if isinstance(events, str):<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 with open(events, &#39;r&#39;) as f:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 with open(events) as f:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0events_list =3D read_ev=
ents(f, events)<br>
&gt;=C2=A0 =C2=A0 =C2=A0elif isinstance(events, list):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Treat as a list of events already p=
roduced by tracetool.read_events<br>
&gt; @@ -332,7 +330,7 @@ def run(analyzer):<br>
&gt;=C2=A0 =C2=A0 =C2=A0except (AssertionError, ValueError):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise SimpleException(f&#39;usage: {s=
ys.argv[0]} [--no-header] &lt;trace-events&gt; &lt;trace-file&gt;\n&#39;)<b=
r>
&gt; <br>
&gt; -=C2=A0 =C2=A0 with open(trace_event_path, &#39;r&#39;) as events_fobj=
, open(trace_file_path, &#39;rb&#39;) as log_fobj:<br>
&gt; +=C2=A0 =C2=A0 with open(trace_event_path) as events_fobj, open(trace_=
file_path, &#39;rb&#39;) as log_fobj:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0process(events_fobj, log_fobj, analyz=
er, read_header=3Dnot no_header)<br>
&gt; <br>
&gt; if __name__ =3D=3D &#39;__main__&#39;:<br>
<br>
I&#39;m not really a fan of the implicit default arguments, but I guess the=
 rest is fine. If this is the way everyone else wants to go, I won&#39;t st=
and in the way.<br></blockquote></div></div><div dir=3D"auto"><br></div><di=
v dir=3D"auto">I can manually restore it. It just happens to be the style t=
he upgrade tool prefers which saves an awful lot of manual work, but I have=
 no prejudice against explicit open parameters.</div><div dir=3D"auto"><br>=
</div><div dir=3D"auto">Thanks for reviewing!</div><div dir=3D"auto"><br></=
div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">
<br>
=E2=80=94<br>
Mads Ynddal<br>
<br>
</blockquote></div></div></div>

--0000000000006200220637c68115--


