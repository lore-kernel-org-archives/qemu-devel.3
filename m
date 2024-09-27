Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B12CEBF69
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 02:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su13q-0005zP-U2; Thu, 26 Sep 2024 22:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1su13o-0005yv-3n
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 22:50:24 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1su13l-0002rC-1r
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 22:50:23 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-277f35c01f5so860714fac.0
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 19:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1727405419; x=1728010219;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vTAom9xeL8MHhLseDr7d74lB1OqL1948p0FeGvCYKGM=;
 b=BzfUVAfm28bTkwvN7+2H765VAj4GirQI8d8LLpQRbKBBQ1L91qCnk/OutrvMy88x6X
 efySJvIQx2Fyyp0OMfzphLZABWysTrqqka50EI3Cc+owF6KbeZtMO7e3LPjJ+Ty2LiXv
 y2thzcOi4oXScWlhVF20CpEHjxOp+7MbJxzvrdgJ376O9Zedgk1sDor2wDk91d9sUftq
 D0kYAtTJRaJCZnZySnVSRebfRTuhKrDUKsp7pP3IdZp22LirSZloe0wzfW5IHn6/Wu4Q
 Hvatpd40LQ+TAGr9Nb5uylo4rc6F5tlFZYvUMWre4wLynipyeNbJDpNDhtsZhfjwuzN2
 ORFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727405419; x=1728010219;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vTAom9xeL8MHhLseDr7d74lB1OqL1948p0FeGvCYKGM=;
 b=wm2mnU2XheE/kE2jESucsJXelnj0XOR4o9QuXone1eeV3hVmanfLh8B3yOiKatmpLC
 n78s621Jtgl8kDdPftIEzJeTvNXbWOlXITH4fpVZoSBHYwWLnPxXQ65KQjkiKMrYyXH0
 71VgvLniYyFAUfaeHeyk+hlAv9guMF/tjWtmBHQQ6tJM6BBQ7qnuHWgiSBYxv1kA1ONH
 zrLFP50dz75PxYDB2sEaYoaxZdG3vurgg4L9/6gRuMy0m2asQxHXINLI4bQ/V7kvs33Y
 G8wvH6QWk6hzx0NcUL/UImjFOxLUxIurDNC5vFFc49tTIy4bpBx8dC6qFIQZdtbKkvHp
 mOfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzNaDM02oSHirOJKwCAf349hGxOyWl9g8/uJ74Rq8YDBuHMC5xl0U5falt20KIvjRtZogWPozKFD9k@nongnu.org
X-Gm-Message-State: AOJu0YzovlpIXBRkpfUEQ89Y7VbGR7rKFGonyC++ArdOQ9G6fvtrz6y0
 cenL49liRHJ8UpOHVr3kkQX+mn7x8OFm4guT8tcApFjxVkesQhwRtmkHps1NJFhp9/ZYYvq6/Zk
 mUeQQAo5P+9yI3Y9YwCJc1qxp18Jz22d1fP0qzA==
X-Google-Smtp-Source: AGHT+IECtSfSzO4ZCzzwuMkYRV1z3HQ4WnHLAGxXdk5nMwmCayH0t4/yF9WxxNEpXNjPb24onk+DiNE+/7l9rMrhoEc=
X-Received: by 2002:a05:6870:6b8b:b0:278:157:25bb with SMTP id
 586e51a60fabf-28710ad5eeamr1731940fac.26.1727405418054; Thu, 26 Sep 2024
 19:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1726390098.git.yong.huang@smartx.com>
 <531750c8d7b6c09f877b5f335a60fab402c168be.1726390098.git.yong.huang@smartx.com>
 <87msk7z4l3.fsf@suse.de>
 <CAK9dgmb_rK5HJOGTG=KXKgH=e2e8JV8aqoOWUHBEyjnc-+kiqg@mail.gmail.com>
 <ZuxxOObKqS_G0Ela@x1n>
 <CAK9dgmYaE=poiwLQqD6qbjJQdgPLMn8cW8VO47xYFTBkNiUVLA@mail.gmail.com>
 <ZvRh0RhkUC-eLbjo@x1n>
 <CAK9dgmbi1VSXvxFjziH5PjaoiaQwBJ3z4ff1BAojtm26VTThUQ@mail.gmail.com>
 <ZvW8LxJsv3pRWom_@x1n>
In-Reply-To: <ZvW8LxJsv3pRWom_@x1n>
From: Yong Huang <yong.huang@smartx.com>
Date: Fri, 27 Sep 2024 10:50:01 +0800
Message-ID: <CAK9dgma-RFQ3akWDFHW5VhMPOdbT4nizSrixQK9x4W7W249raQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] migration: Introduce structs for background sync
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000053a180062310eafc"
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=yong.huang@smartx.com; helo=mail-oa1-x33.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
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

--00000000000053a180062310eafc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 3:55=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:

> On Fri, Sep 27, 2024 at 02:13:47AM +0800, Yong Huang wrote:
> > On Thu, Sep 26, 2024 at 3:17=E2=80=AFAM Peter Xu <peterx@redhat.com> wr=
ote:
> >
> > > On Fri, Sep 20, 2024 at 10:43:31AM +0800, Yong Huang wrote:
> > > > Yes, invoke migration_bitmap_sync_precopy more frequently is also m=
y
> > > > first idea but it involves bitmap updating and interfere with the
> > > behavior
> > > > of page sending, it also affects the migration information stats an=
d
> > > > interfere other migration logic such as migration_update_rates().
> > >
> > > Could you elaborate?
> > >
> > > For example, what happens if we start to sync in ram_save_iterate() f=
or
> > > some time intervals (e.g. 5 seconds)?
> > >
> >
> > I didn't try to sync in ram_save_iterate but in the
> > migration_bitmap_sync_precopy.
> >
> > If we use the migration_bitmap_sync_precopy in the ram_save_iterate
> > function,
> > This approach seems to be correct. However, the bitmap will be updated =
as
> > the
> > migration thread iterates through each dirty page in the RAMBlock list.
> > Compared
> > to the existing implementation, this is different but still
> straightforward;
> > I'll give it a shot soon to see if it works.
>
> It's still serialized in the migration thread, so I'd expect it is simila=
r
>

What does "serialized" mean?

How about we:
1. invoke the migration_bitmap_sync_precopy in a timer(bg_sync_timer) hook,
   every 5 seconds.
2. register the bg_sync_timer in the main loop when the machine starts like
    throttle_timer
3. activate the timer when ram_save_iterate gets called and deactivate it i=
n
    the ram_save_cleanup gracefully during migration.

I think it is simple enough and also isn't "serialized"?

to e.g. ->state_pending_exact() calls when QEMU flushed most dirty pages in
> the current bitmap.
>
> >
> >
> > > Btw, we shouldn't have this extra sync exist if auto converge is
> disabled
> > > no matter which way we use, because it's pure overhead when auto
> converge
> > > is not in use.
> > >
> >
> > Ok, I'll add the check in the next versioni.
>
> Let's start with simple, and if there's anything unsure we can discuss
> upfront, just to avoid coding something and change direction later.  Agai=
n,
> personally I think we shouldn't add too much new code to auto converge
> (unless very well justfied, but I think it's just hard.. fundamentally wi=
th
> any pure throttling solutions), hopefully something small can make it sta=
rt
> to work for huge VMs.
>
> Thanks,
>
> --
> Peter Xu
>
>

--=20
Best regards

--00000000000053a180062310eafc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 27, 20=
24 at 3:55=E2=80=AFAM Peter Xu &lt;<a href=3D"mailto:peterx@redhat.com">pet=
erx@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:sol=
id;border-left-color:rgb(204,204,204);padding-left:1ex">On Fri, Sep 27, 202=
4 at 02:13:47AM +0800, Yong Huang wrote:<br>
&gt; On Thu, Sep 26, 2024 at 3:17=E2=80=AFAM Peter Xu &lt;<a href=3D"mailto=
:peterx@redhat.com" target=3D"_blank">peterx@redhat.com</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; On Fri, Sep 20, 2024 at 10:43:31AM +0800, Yong Huang wrote:<br>
&gt; &gt; &gt; Yes, invoke migration_bitmap_sync_precopy more frequently is=
 also my<br>
&gt; &gt; &gt; first idea but it involves bitmap updating and interfere wit=
h the<br>
&gt; &gt; behavior<br>
&gt; &gt; &gt; of page sending, it also affects the migration information s=
tats and<br>
&gt; &gt; &gt; interfere other migration logic such as migration_update_rat=
es().<br>
&gt; &gt;<br>
&gt; &gt; Could you elaborate?<br>
&gt; &gt;<br>
&gt; &gt; For example, what happens if we start to sync in ram_save_iterate=
() for<br>
&gt; &gt; some time intervals (e.g. 5 seconds)?<br>
&gt; &gt;<br>
&gt; <br>
&gt; I didn&#39;t try to sync in ram_save_iterate but in the<br>
&gt; migration_bitmap_sync_precopy.<br>
&gt; <br>
&gt; If we use the migration_bitmap_sync_precopy in the ram_save_iterate<br=
>
&gt; function,<br>
&gt; This approach seems to be correct. However, the bitmap will be updated=
 as<br>
&gt; the<br>
&gt; migration thread iterates through each dirty page in the RAMBlock list=
.<br>
&gt; Compared<br>
&gt; to the existing implementation, this is different but still straightfo=
rward;<br>
&gt; I&#39;ll give it a shot soon to see if it works.<br>
<br>
It&#39;s still serialized in the migration thread, so I&#39;d expect it is =
similar<br></blockquote><div><br></div><div><div style=3D"font-family:&quot=
;comic sans ms&quot;,sans-serif" class=3D"gmail_default">What does &quot;se=
rialized&quot; mean?</div><div style=3D"font-family:&quot;comic sans ms&quo=
t;,sans-serif" class=3D"gmail_default"><br></div><div style=3D"font-family:=
&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">How about we:=
</div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=
=3D"gmail_default">1. invoke the=C2=A0migration_bitmap_sync_precopy in a ti=
mer(bg_sync_timer) hook,</div><div style=3D"font-family:&quot;comic sans ms=
&quot;,sans-serif" class=3D"gmail_default">=C2=A0 =C2=A0every 5 seconds.</d=
iv><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D=
"gmail_default">2. register the bg_sync_timer=C2=A0in the main loop when th=
e machine starts like</div><div style=3D"font-family:&quot;comic sans ms&qu=
ot;,sans-serif" class=3D"gmail_default">=C2=A0 =C2=A0 throttle_timer</div><=
div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gma=
il_default">3. activate the timer when ram_save_iterate gets called and dea=
ctivate it in</div><div style=3D"font-family:&quot;comic sans ms&quot;,sans=
-serif" class=3D"gmail_default">=C2=A0 =C2=A0 the ram_save_cleanup graceful=
ly during migration.=C2=A0</div><div style=3D"font-family:&quot;comic sans =
ms&quot;,sans-serif" class=3D"gmail_default"><br></div></div><div style=3D"=
font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">I=
 think it is simple enough and also isn&#39;t &quot;serialized&quot;?</div>=
<div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left-width:1px;border-left-style:solid;border-left-color:rgb=
(204,204,204);padding-left:1ex">
to e.g. -&gt;state_pending_exact() calls when QEMU flushed most dirty pages=
 in<br>
the current bitmap.<br>
<br>
&gt; <br>
&gt; <br>
&gt; &gt; Btw, we shouldn&#39;t have this extra sync exist if auto converge=
 is disabled<br>
&gt; &gt; no matter which way we use, because it&#39;s pure overhead when a=
uto converge<br>
&gt; &gt; is not in use.<br>
&gt; &gt;<br>
&gt; <br>
&gt; Ok, I&#39;ll add the check in the next versioni.<br>
<br>
Let&#39;s start with simple, and if there&#39;s anything unsure we can disc=
uss<br>
upfront, just to avoid coding something and change direction later.=C2=A0 A=
gain,<br>
personally I think we shouldn&#39;t add too much new code to auto converge<=
br>
(unless very well justfied, but I think it&#39;s just hard.. fundamentally =
with<br>
any pure throttling solutions), hopefully something small can make it start=
<br>
to work for huge VMs.<br>
<br>
Thanks,<br>
<br>
-- <br>
Peter Xu<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--00000000000053a180062310eafc--

