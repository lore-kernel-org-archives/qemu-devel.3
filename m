Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 844F5C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 06:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkHRa-0002yT-0l; Tue, 18 Feb 2025 01:50:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tkHRY-0002yE-7q
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 01:50:56 -0500
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tkHRV-0007ML-N5
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 01:50:56 -0500
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5fc0c06e1deso2339843eaf.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 22:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1739861452; x=1740466252;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8zZGbwlXGZiTogtB63SL5UmsCOdhGO0rFVW3ofx7WKU=;
 b=AgnRDT7KYbOdjA4lwGRtALmr/leuGhyhhgxJas3aD3tqvacRbJSqdfFV1xmZceeUMe
 +7Sm1YSXgJZZpfqRnWnO7WYgXL7pqNDZjl8yMB0vuVXxgFZSG+09/NiG17Em6TeWW+eu
 fbpDvQqN5sNbE+vSiCI34ogV/H24MC2PHt+8Z9tHdlR1F/9ToAVL/9XRQ7cQA09SyHkk
 P4T3LwlZfBCv9wz+Xt/EVEdjgYyDWu/DptfmFfoUh7Z7zgOPTDPu3hhMoPB/5dkKbQ7l
 zBODoJPW3n8jTDgFYoVeHg/2yomG9AOQGuVznr4UgwK31OZqvgeNzgXnEfpe0bXi7uMg
 v8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739861452; x=1740466252;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8zZGbwlXGZiTogtB63SL5UmsCOdhGO0rFVW3ofx7WKU=;
 b=QrUFHqUsqT9GA2um4b10025WTiF3ii/bvFaK1JocMIh6ZK+zbz8AaDBuoc2U7w6sCH
 UuDEcA2Tajem5/25CFySo8k7HZTy67XQ88Drqpdrl45KGzwar2NaXfO63nXZ5CPZdvh4
 aLcurfM328cia6Ot4hGTCeUJplju/HxjJt06/t9ZNplINuDlRw97QeOYGj3cb39Feryg
 8wqBB9dDT7OyeBfWg4Cp99K66or8hFOXnxnKS/iDa7+lM/dvggl+ov0kgt0EPLkQvr0m
 M31p6fKF2b48yhx/UJc0pHS0Z/cGXkTY+OxLlT35QYvoFJQQEDXxpTVJiYiyM38HmoWn
 jGYQ==
X-Gm-Message-State: AOJu0YxdIteCsMPtyk6O1/+feEDM4OAFNG7ti/x30K9gUGv0AyykN9zf
 1FTRXoRdwd9cZ0vYMU5xREjFNGntRO7ZJWubx2GgbZGk7980MIwYJnON1H4afRar1Xfb2ZZIPFR
 LcpzUkBMstHA2T+cSr2GAby1c5+eArD5uTsZhOA==
X-Gm-Gg: ASbGnctgTeszhhGtIU3KjqNmrFc2/h0AU4UmvuBPSEXOWntQRWVt2Ri39vhvfXRUJHx
 z1RWBioiebuE0Hqo4aL8R8PPYcwMpuZozYjo9OEuU5FHe7ldzImPR5VteKPsGw8r8xFXmPsXiEk
 w=
X-Google-Smtp-Source: AGHT+IG9EkVSLUaV6pFU0o8LkyoXzSqRBK78FY8Z+SMUm8QaIWzbiCwpeXCq3ojfat/s1C3ay9L26b/ML+g3nE0J91E=
X-Received: by 2002:a05:6808:2dcb:b0:3f3:d963:3e2 with SMTP id
 5614622812f47-3f3eb0c04bbmr8878706b6e.19.1739861451508; Mon, 17 Feb 2025
 22:50:51 -0800 (PST)
MIME-Version: 1.0
References: <4df13a8005170ad42cbbc883a0a8fdbb1ab94ac1.1739846274.git.yong.huang@smartx.com>
 <87cyffiz7d.fsf@pond.sub.org>
In-Reply-To: <87cyffiz7d.fsf@pond.sub.org>
From: Yong Huang <yong.huang@smartx.com>
Date: Tue, 18 Feb 2025 14:50:34 +0800
X-Gm-Features: AWEUYZnyCL15Hm2T6AZYJT6tRPjPhqATJvnOkNauJF2vPmI_kTFoLx-R2m2jyoU
Message-ID: <CAK9dgmY2jHXOZbdngREwUOYazwbw+rd1yu=WywASjM1pZr-6AA@mail.gmail.com>
Subject: Re: [RFC] migration: Introduce migration throttle event
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c6a6f7062e650f66"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=yong.huang@smartx.com; helo=mail-oo1-xc33.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

--000000000000c6a6f7062e650f66
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 1:44=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:

> yong.huang@smartx.com writes:
>
> > From: Hyman Huang <yong.huang@smartx.com>
> >
> > When the developer is examining the time distribution of
> > the migration, it is useful to record the migration throttle
> > timestamp. Consequently, include the migration throttle event.
>
> Can you explain what you'd like to do with the information in a little
> more detail?


Throttle degrades guest performance during live migration;
with respect to the performance degradation aspect, migration
can be divided into the following phases when there is an excessive
memory load:

1. setup -> throttle
2. throttle -> switch-over
3. switch-over->finished

In the 1st phase, performance degradation is mostly affected by dirty
tracking.
In the 2nd phase, performance degradation is affected by dirty tracking +
throttle
In the 3nd phase, performance degradation is affected by stopping vCPU

To help differentiate between these three stages, determine which
has the biggest influence on performance degradation, and do some
performance optimization or generate a performance report or whatever,
a throttling timestamp can be included.

This patch has 2 goals, logging the throttle timestamp and generating
an event for management applications.


>
> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > ---
> >  migration/ram.c     |  1 +
> >  qapi/migration.json | 15 +++++++++++++++
> >  2 files changed, 16 insertions(+)
> >
> > diff --git a/migration/ram.c b/migration/ram.c
> > index 589b6505eb..725e029927 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -524,6 +524,7 @@ static void mig_throttle_guest_down(uint64_t
> bytes_dirty_period,
> >
> >      /* We have not started throttling yet. Let's start it. */
> >      if (!cpu_throttle_active()) {
> > +        qapi_event_send_migration_throttle();
> >          cpu_throttle_set(pct_initial);
> >      } else {
> >          /* Throttling already on, just increase the rate */
>
> I guess the percentage is uninteresting because it changes too quickly.
> Correct?
>
>
QMP could query the throttle percentage already, but there is no way
to peer the throttle initiation timestamp.


> Would it make sense to track cpu_throttle_stop(), too?
>

IMHO, the CPU throttle stop event might be less helpful when considering
the three phases I described above because it isn't an essential event for
guest performance deterioration investigation.


>
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index 8b9c53595c..0495065b5d 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -1393,6 +1393,21 @@
> >  { 'event': 'MIGRATION_PASS',
> >    'data': { 'pass': 'int' } }
> >
> > +##
> > +# @MIGRATION_THROTTLE:
> > +#
> > +# Emitted from the source side of a migration at the start of vCPU
> throttle
> > +#
> > +# Since: 10.0
> > +#
> > +# Example:
> > +#
> > +# <- { "event": "MIGRATION_THROTTLE",
> > +#      "timestamp": { "seconds": 1267041730, "microseconds": 281295 } =
}
> > +#
> > +##
> > +{ 'event': 'MIGRATION_THROTTLE' }
> > +
> >  ##
> >  # @COLOMessage:
> >  #
>
> Standard question for events: if a management application misses an
> event, say because it restarts and reconnects, is there a way to obtain
> the missed information with a query command?
>

During live migration, such an event is not inevitable: the management
application ought to be aware of this.

Thanks for the comment,
Yong
--=20
Best regards

--000000000000c6a6f7062e650f66
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Tue, Feb 18, 2025 at 1:44=E2=80=AFPM Markus Armbruster &lt;<a href=
=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204);padd=
ing-left:1ex"><a href=3D"mailto:yong.huang@smartx.com" target=3D"_blank">yo=
ng.huang@smartx.com</a> writes:<br>
<br>
&gt; From: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" target=
=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt;<br>
&gt; When the developer is examining the time distribution of<br>
&gt; the migration, it is useful to record the migration throttle<br>
&gt; timestamp. Consequently, include the migration throttle event.<br>
<br>
Can you explain what you&#39;d like to do with the information in a little<=
br>
more detail?</blockquote><div><span class=3D"gmail_default" style=3D"font-f=
amily:&quot;comic sans ms&quot;,sans-serif"><br></span></div><div><span cla=
ss=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-se=
rif">Throttle degrades guest performance during live migration;</span></div=
><div><span class=3D"gmail_default" style=3D"font-family:&quot;comic sans m=
s&quot;,sans-serif">with respect to the performance degradation aspect, mig=
ration</span></div><div><span class=3D"gmail_default" style=3D"font-family:=
&quot;comic sans ms&quot;,sans-serif">can be divided into the following pha=
ses when there is an excessive</span></div><div><span class=3D"gmail_defaul=
t" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">memory load:<=
br></span></div><div><span class=3D"gmail_default" style=3D"font-family:&qu=
ot;comic sans ms&quot;,sans-serif"><br></span></div><div><span class=3D"gma=
il_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">1. s=
etup -&gt; throttle</span><br></div><div><span class=3D"gmail_default" styl=
e=3D"font-family:&quot;comic sans ms&quot;,sans-serif">2. throttle -&gt; sw=
itch-over</span></div><div><span class=3D"gmail_default" style=3D"font-fami=
ly:&quot;comic sans ms&quot;,sans-serif">3. switch-over-&gt;finished</span>=
</div><div><span class=3D"gmail_default" style=3D"font-family:&quot;comic s=
ans ms&quot;,sans-serif"><br></span></div><div><span style=3D"font-family:&=
quot;comic sans ms&quot;,sans-serif;color:rgb(0,0,0)">In the 1st phase, per=
formance degradation is mostly affected by dirty tracking.</span><span clas=
s=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-ser=
if"><br></span></div><div><font face=3D"comic sans ms, sans-serif"><span cl=
ass=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-s=
erif">In the 2nd phase,=C2=A0</span></font><span style=3D"font-family:&quot=
;comic sans ms&quot;,sans-serif">performance degradation is affected by dir=
ty tracking<span class=3D"gmail_default" style=3D"font-family:&quot;comic s=
ans ms&quot;,sans-serif">=C2=A0+ throttle</span></span></div><div><span sty=
le=3D"font-family:&quot;comic sans ms&quot;,sans-serif"><span class=3D"gmai=
l_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">In th=
e 3nd phase,=C2=A0</span></span><span style=3D"font-family:&quot;comic sans=
 ms&quot;,sans-serif">performance degradation</span><span class=3D"gmail-Ap=
ple-converted-space" style=3D"font-family:&quot;comic sans ms&quot;,sans-se=
rif">=C2=A0<span class=3D"gmail_default" style=3D"font-family:&quot;comic s=
ans ms&quot;,sans-serif">is affected by stopping vCPU</span></span></div><d=
iv><span class=3D"gmail-Apple-converted-space" style=3D"font-family:&quot;c=
omic sans ms&quot;,sans-serif"><span class=3D"gmail_default" style=3D"font-=
family:&quot;comic sans ms&quot;,sans-serif"><br></span></span></div><div><=
span class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;=
,sans-serif">To help differentiate between these three stages, determine wh=
ich</span></div><div><span class=3D"gmail_default" style=3D"font-family:&qu=
ot;comic sans ms&quot;,sans-serif">has the biggest influence on performance=
 degradation, and do some</span></div><div><span class=3D"gmail_default" st=
yle=3D"font-family:&quot;comic sans ms&quot;,sans-serif">performance optimi=
zation or generate a performance report or whatever,</span></div><div><span=
 class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,san=
s-serif">a=C2=A0</span><span style=3D"font-family:&quot;comic sans ms&quot;=
,sans-serif">throttling timestamp can be included.</span></div><div><span s=
tyle=3D"font-family:&quot;comic sans ms&quot;,sans-serif"><br></span></div>=
<div><span style=3D"font-family:&quot;comic sans ms&quot;,sans-serif"><span=
 class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,san=
s-serif">This patch has 2 goals, logging the throttle timestamp and generat=
ing</span><br></span></div><div><span style=3D"font-family:&quot;comic sans=
 ms&quot;,sans-serif"><span class=3D"gmail_default" style=3D"font-family:&q=
uot;comic sans ms&quot;,sans-serif">an event for management applications.</=
span></span></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;=
border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
&gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com=
" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 migration/ram.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
&gt;=C2=A0 qapi/migration.json | 15 +++++++++++++++<br>
&gt;=C2=A0 2 files changed, 16 insertions(+)<br>
&gt;<br>
&gt; diff --git a/migration/ram.c b/migration/ram.c<br>
&gt; index 589b6505eb..725e029927 100644<br>
&gt; --- a/migration/ram.c<br>
&gt; +++ b/migration/ram.c<br>
&gt; @@ -524,6 +524,7 @@ static void mig_throttle_guest_down(uint64_t bytes=
_dirty_period,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* We have not started throttling yet. Let&#39;s s=
tart it. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (!cpu_throttle_active()) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qapi_event_send_migration_throttle();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_throttle_set(pct_initial);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Throttling already on, just incre=
ase the rate */<br>
<br>
I guess the percentage is uninteresting because it changes too quickly.<br>
Correct?<br>
<br></blockquote><div><br></div><div><font face=3D"comic sans ms, sans-seri=
f">QMP could query the throttle percentage<span class=3D"gmail_default" sty=
le=3D"font-family:&quot;comic sans ms&quot;,sans-serif"> already</span>, bu=
t there is no way</font></div><div><font face=3D"comic sans ms, sans-serif"=
>to peer<span class=3D"gmail_default" style=3D"font-family:&quot;comic sans=
 ms&quot;,sans-serif">=C2=A0</span></font><span style=3D"font-family:&quot;=
comic sans ms&quot;,sans-serif">the throttle initiation timestamp.</span><s=
pan class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,=
sans-serif"></span></div><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:=
solid;border-left-color:rgb(204,204,204);padding-left:1ex">
Would it make sense to track cpu_throttle_stop(), too?<br></blockquote><div=
><br></div><div><span class=3D"gmail_default" style=3D"font-family:&quot;co=
mic sans ms&quot;,sans-serif">IMHO, the CPU throttle stop event might be le=
ss helpful when considering</span></div><div><span class=3D"gmail_default" =
style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">the three phases=
 I described above because it isn&#39;t an essential event for</span></div>=
<div><span class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms=
&quot;,sans-serif">guest performance deterioration investigation.<br></span=
></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-=
color:rgb(204,204,204);padding-left:1ex">
<br>
&gt; diff --git a/qapi/migration.json b/qapi/migration.json<br>
&gt; index 8b9c53595c..0495065b5d 100644<br>
&gt; --- a/qapi/migration.json<br>
&gt; +++ b/qapi/migration.json<br>
&gt; @@ -1393,6 +1393,21 @@<br>
&gt;=C2=A0 { &#39;event&#39;: &#39;MIGRATION_PASS&#39;,<br>
&gt;=C2=A0 =C2=A0 &#39;data&#39;: { &#39;pass&#39;: &#39;int&#39; } }<br>
&gt;=C2=A0 <br>
&gt; +##<br>
&gt; +# @MIGRATION_THROTTLE:<br>
&gt; +#<br>
&gt; +# Emitted from the source side of a migration at the start of vCPU th=
rottle<br>
&gt; +#<br>
&gt; +# Since: 10.0<br>
&gt; +#<br>
&gt; +# Example:<br>
&gt; +#<br>
&gt; +# &lt;- { &quot;event&quot;: &quot;MIGRATION_THROTTLE&quot;,<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 &quot;timestamp&quot;: { &quot;seconds&quot;: 1=
267041730, &quot;microseconds&quot;: 281295 } }<br>
&gt; +#<br>
&gt; +##<br>
&gt; +{ &#39;event&#39;: &#39;MIGRATION_THROTTLE&#39; }<br>
&gt; +<br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 # @COLOMessage:<br>
&gt;=C2=A0 #<br>
<br>
Standard question for events: if a management application misses an<br>
event, say because it restarts and reconnects, is there a way to obtain<br>
the missed information with a query command?<br></blockquote><div><br></div=
><div><font face=3D"comic sans ms, sans-serif">During live migration, such =
an event is not inevitable: the management</font></div><div><font face=3D"c=
omic sans ms, sans-serif">application ought to be aware of this.</font><br>=
</div></div><div><br></div><div><span class=3D"gmail_default" style=3D"font=
-family:&quot;comic sans ms&quot;,sans-serif">Thanks for the comment,</span=
><br></div><div><span class=3D"gmail_default" style=3D"font-family:&quot;co=
mic sans ms&quot;,sans-serif">Yong</span><br></div><span class=3D"gmail_sig=
nature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><di=
v dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font><=
/div></div></div>

--000000000000c6a6f7062e650f66--

