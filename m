Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88C2CF397F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 02:44:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srTci-00039O-S5; Thu, 19 Sep 2024 22:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1srTcf-00038G-Ne
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 22:43:53 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1srTcc-0003Sg-LU
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 22:43:53 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5e1cdfe241eso642264eaf.1
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 19:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1726800228; x=1727405028;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ePhbiQY0oDh0dQOBl+INE+Ksd6ztM0cuqXRVHJrUgyQ=;
 b=OmbJekJ0ro/DPaxsvyHghCu4FnyMka+rsP6kwRie/Dp7Blh6FUq3xxfVzNbSN9DdcP
 Zd21emkdwlQ0ZR+F9ZrKDn2aMZO7z0FfkWfOUSnXLZ4LjZ6QKIATfFy4XDjyupEYalOk
 29vLMwW6+XJSyfUI7d+BaRol+atujm6o0s+IjAEVWWCOTHdxcZQCerAVjS2PYeOk341F
 DSL58Iwo7RPEFMGYO2iVvYq+yxNIX+XXRshegoCTHd/rp6NGdTqgKSB3qcFVoVVyugDc
 +VAHVu8imvTYIf4O4lhQ27jPkI5XW1QvoK10FhuywpGPAzRJrCkByFlmwCGagWFmPjBO
 3zrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726800228; x=1727405028;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ePhbiQY0oDh0dQOBl+INE+Ksd6ztM0cuqXRVHJrUgyQ=;
 b=YBYztWRPJGvGaZuUNEJWAIyna0FNB83mntPK4+5xqfSWWBXNTVifCVAzaysBArk+zj
 yG913LEd7L+uRMGhBsuT+9l0xha2sxgMpcurTHPhk3IDYZ9jZXuA0xJZ6Qon7o8ppPYU
 pw/hWYJSdqDPoeohmbzhY72+aVtIBg0/gR/ahEcASjRd3BiKipwNiT5xXeWjA6NX1XdF
 FIwMze2726HEWwY1UVYoHAQYY21t3jtqQuDimWeuLsVk5PW3pT1dOwfi49kygX6cV9ro
 4VmWVFck0CxMjGEfXQaj9k4tCDGWR3AUCtZPlA8irSVaVznHJNfaCdgVrIbf9Vt4kg0X
 0xdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlUmXmxccq48EIw99ak06vFJkD0L0AJMQ179zgu0aHgjvRD7GZzdpk05c6jBnP31ZEd3XhONUxYu9E@nongnu.org
X-Gm-Message-State: AOJu0YzqaLxuOjs+RLHct/VcOdiLrsJNYZtwmnKqdvNtGDwuIWkZIEWF
 foTDqMdzTQo/BaVmZvsAN31rnzNc8Z+78MjQOJ+udQ1sahJVMDeGq91KIZtRV6OIFJ6baUpfmLs
 vKq4GsFuWuSGV0hLcR5OFNEAGQlse0lMC9I12bw==
X-Google-Smtp-Source: AGHT+IHbaslxZ/jux5RdkgwcATsaEx9zqm3oiCAeJYfxFABXMmfbY2+o5JcjrcgaJ/HTwLQB4KsPrVivWDsYYqXahFc=
X-Received: by 2002:a05:6870:56a0:b0:260:ff2f:9d24 with SMTP id
 586e51a60fabf-2803a78514emr757399fac.33.1726800227029; Thu, 19 Sep 2024
 19:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1726390098.git.yong.huang@smartx.com>
 <531750c8d7b6c09f877b5f335a60fab402c168be.1726390098.git.yong.huang@smartx.com>
 <87msk7z4l3.fsf@suse.de>
 <CAK9dgmb_rK5HJOGTG=KXKgH=e2e8JV8aqoOWUHBEyjnc-+kiqg@mail.gmail.com>
 <ZuxxOObKqS_G0Ela@x1n>
In-Reply-To: <ZuxxOObKqS_G0Ela@x1n>
From: Yong Huang <yong.huang@smartx.com>
Date: Fri, 20 Sep 2024 10:43:31 +0800
Message-ID: <CAK9dgmYaE=poiwLQqD6qbjJQdgPLMn8cW8VO47xYFTBkNiUVLA@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] migration: Introduce structs for background sync
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000216fd606228402a7"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=yong.huang@smartx.com; helo=mail-oo1-xc2b.google.com
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

--000000000000216fd606228402a7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 2:45=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:

> On Tue, Sep 17, 2024 at 02:48:03PM +0800, Yong Huang wrote:
> > On Tue, Sep 17, 2024 at 5:11=E2=80=AFAM Fabiano Rosas <farosas@suse.de>=
 wrote:
> >
> > > Hyman Huang <yong.huang@smartx.com> writes:
> > >
> > > > shadow_bmap, iter_bmap and iter_dirty_pages are introduced
> > > > to satisfy the need for background sync.
> > > >
> > > > Meanwhile, introduce enumeration of sync method.
> > > >
> > > > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > > > ---
> > > >  include/exec/ramblock.h | 45
> +++++++++++++++++++++++++++++++++++++++++
> > > >  migration/ram.c         |  6 ++++++
> > > >  2 files changed, 51 insertions(+)
> > > >
> > > > diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
> > > > index 0babd105c0..0e327bc0ae 100644
> > > > --- a/include/exec/ramblock.h
> > > > +++ b/include/exec/ramblock.h
> > > > @@ -24,6 +24,30 @@
> > > >  #include "qemu/rcu.h"
> > > >  #include "exec/ramlist.h"
> > > >
> > > > +/* Possible bits for cpu_physical_memory_sync_dirty_bitmap */
> > > > +
> > > > +/*
> > > > + * The old-fashioned sync, which is, in turn, used for CPU
> > > > + * throttle and memory transfer.
> > >
> >
> > Using the traditional sync method, the page sending logic iterates
> > the "bmap" to transfer dirty pages while the CPU throttle logic
> > counts the amount of new dirty pages and detects convergence.
> > There are two uses for "bmap".
> >
> > Using the modern sync method, "bmap" is used for transfer
> > dirty pages and "iter_bmap" is used to track new dirty pages.
> >
> >
> > > I'm not sure I follow what "in turn" is supposed to mean in this
> > > sentence. Could you clarify?
> > >
> >
> > Here I want to express "in sequence".  But failed obviously. :(
> >
> >
> > >
> > > > + */
> > > > +#define RAMBLOCK_SYN_LEGACY_ITER   (1U << 0)
> > >
> > > So ITER is as opposed to background? I'm a bit confused with the term=
s.
> > >
> >
> > Yes.
> >
> >
> > >
> > > > +
> > > > +/*
> > > > + * The modern sync, which is, in turn, used for CPU throttle
> > > > + * and memory transfer.
> > > > + */
> > > > +#define RAMBLOCK_SYN_MODERN_ITER   (1U << 1)
> > > > +
> > > > +/* The modern sync, which is used for CPU throttle only */
> > > > +#define RAMBLOCK_SYN_MODERN_BACKGROUND    (1U << 2)
> > >
> > > What's the plan for the "legacy" part? To be removed soon? Do we want
> to
> > > remove it now? Maybe better to not use the modern/legacy terms unless
> we
> > > want to give the impression that the legacy one is discontinued.
> > >
> >
> > The bitmap they utilized to track the dirty page information was the
> > distinction between the "legacy iteration" and the "modern iteration."
> > The "iter_bmap" field is used by the "modern iteration" while the "bmap=
"
> > field is used by the "legacy iteration."
> >
> > Since the refinement is now transparent and there is no API available t=
o
> > change the sync method, I actually want to remove it right now in order
> > to simplify the logic. I'll include it in the next version.
>
> How confident do we think the new way is better than the old?
>
> If it'll be 100% / always better, I agree we can consider removing the ol=
d.
> But is it always better?  At least it consumes much more resources..
>
> Otherwise, we can still leave that logic as-is but use a migration proper=
ty
> to turn it on only on new machines I think.
>
> Besides, could you explain why the solution needs to be this complex?  My
> previous question was that we sync dirty too less, while auto converge
> relies on dirty information, so that means auto converge can be adjusted
> too unfrequently.
>

The original logic will update the bmap for each sync, which was used to
conduct the dirty page sending. In the background sync logic, we do not
want to update bmap to interfere with the behavior of page sending for
each background sync, since the bitmap we are syncing is only used to
detect the convergence and do the CPU throttle.

The iteration sync wants to 1: sync dirty bitmap, 2:detect convergence,
3: do the CPU throttle and 4: use the bmap fetched to conduct the page
sending, while the background sync only does the 1,2,3. They have different
purposes. These logic need at least two bitmap, one is used to page sending
and another is used for CPU throttling, to achieve this, we introduced the
iter_bmap as the temporary bitmap to store the dirty page information
during background sync and copy it to the bmap in the iteration sync logic.
However, the dirty page information in iter_bmap may be repetitive since
the dirty pages it records could be sent after background syncing, we
introduced the shadow_bmap to help calculate the dirty pages having
been sent during two background syncs.


> However I wonder whether that can be achieved in a simpler manner by
>

I have tried my best to make the solution simpler but failed. :(


> e.g. invoke migration_bitmap_sync_precopy() more frequently during
>

Yes, invoke migration_bitmap_sync_precopy more frequently is also my
first idea but it involves bitmap updating and interfere with the behavior
of page sending, it also affects the migration information stats and
interfere
other migration logic such as migration_update_rates().


> migration, for example, in ram_save_iterate() - not every time but the
> iterate() is invoked much more frequent, and maybe we can do sync from ti=
me
> to time.


> I also don't see why we need a separate thread, plus two new bitmaps, to
> achieve this..  I didn't read in-depth yet, but I thought dirty sync
> requires bql anyway, then I don't yet understand why the two bitmaps are
> required.  If the bitmaps are introduced in the 1st patch, IMO it'll be
> great to explain clearly on why they're needed here.
>
> Thanks,
>
> --
> Peter Xu
>
>
Thanks,

Yong

--=20
Best regards

--000000000000216fd606228402a7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 20, 20=
24 at 2:45=E2=80=AFAM Peter Xu &lt;<a href=3D"mailto:peterx@redhat.com">pet=
erx@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:sol=
id;border-left-color:rgb(204,204,204);padding-left:1ex">On Tue, Sep 17, 202=
4 at 02:48:03PM +0800, Yong Huang wrote:<br>
&gt; On Tue, Sep 17, 2024 at 5:11=E2=80=AFAM Fabiano Rosas &lt;<a href=3D"m=
ailto:farosas@suse.de" target=3D"_blank">farosas@suse.de</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" target=
=3D"_blank">yong.huang@smartx.com</a>&gt; writes:<br>
&gt; &gt;<br>
&gt; &gt; &gt; shadow_bmap, iter_bmap and iter_dirty_pages are introduced<b=
r>
&gt; &gt; &gt; to satisfy the need for background sync.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Meanwhile, introduce enumeration of sync method.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@=
smartx.com" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;=C2=A0 include/exec/ramblock.h | 45 +++++++++++++++++++++++++=
++++++++++++++++<br>
&gt; &gt; &gt;=C2=A0 migration/ram.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 6 ++++++<br>
&gt; &gt; &gt;=C2=A0 2 files changed, 51 insertions(+)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/include/exec/ramblock.h b/include/exec/ramblock=
.h<br>
&gt; &gt; &gt; index 0babd105c0..0e327bc0ae 100644<br>
&gt; &gt; &gt; --- a/include/exec/ramblock.h<br>
&gt; &gt; &gt; +++ b/include/exec/ramblock.h<br>
&gt; &gt; &gt; @@ -24,6 +24,30 @@<br>
&gt; &gt; &gt;=C2=A0 #include &quot;qemu/rcu.h&quot;<br>
&gt; &gt; &gt;=C2=A0 #include &quot;exec/ramlist.h&quot;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +/* Possible bits for cpu_physical_memory_sync_dirty_bitmap =
*/<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +/*<br>
&gt; &gt; &gt; + * The old-fashioned sync, which is, in turn, used for CPU<=
br>
&gt; &gt; &gt; + * throttle and memory transfer.<br>
&gt; &gt;<br>
&gt; <br>
&gt; Using the traditional sync method, the page sending logic iterates<br>
&gt; the &quot;bmap&quot; to transfer dirty pages while the CPU throttle lo=
gic<br>
&gt; counts the amount of new dirty pages and detects convergence.<br>
&gt; There are two uses for &quot;bmap&quot;.<br>
&gt; <br>
&gt; Using the modern sync method, &quot;bmap&quot; is used for transfer<br=
>
&gt; dirty pages and &quot;iter_bmap&quot; is used to track new dirty pages=
.<br>
&gt; <br>
&gt; <br>
&gt; &gt; I&#39;m not sure I follow what &quot;in turn&quot; is supposed to=
 mean in this<br>
&gt; &gt; sentence. Could you clarify?<br>
&gt; &gt;<br>
&gt; <br>
&gt; Here I want to express &quot;in sequence&quot;.=C2=A0 But failed obvio=
usly. :(<br>
&gt; <br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; &gt; + */<br>
&gt; &gt; &gt; +#define RAMBLOCK_SYN_LEGACY_ITER=C2=A0 =C2=A0(1U &lt;&lt; 0=
)<br>
&gt; &gt;<br>
&gt; &gt; So ITER is as opposed to background? I&#39;m a bit confused with =
the terms.<br>
&gt; &gt;<br>
&gt; <br>
&gt; Yes.<br>
&gt; <br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +/*<br>
&gt; &gt; &gt; + * The modern sync, which is, in turn, used for CPU throttl=
e<br>
&gt; &gt; &gt; + * and memory transfer.<br>
&gt; &gt; &gt; + */<br>
&gt; &gt; &gt; +#define RAMBLOCK_SYN_MODERN_ITER=C2=A0 =C2=A0(1U &lt;&lt; 1=
)<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +/* The modern sync, which is used for CPU throttle only */<=
br>
&gt; &gt; &gt; +#define RAMBLOCK_SYN_MODERN_BACKGROUND=C2=A0 =C2=A0 (1U &lt=
;&lt; 2)<br>
&gt; &gt;<br>
&gt; &gt; What&#39;s the plan for the &quot;legacy&quot; part? To be remove=
d soon? Do we want to<br>
&gt; &gt; remove it now? Maybe better to not use the modern/legacy terms un=
less we<br>
&gt; &gt; want to give the impression that the legacy one is discontinued.<=
br>
&gt; &gt;<br>
&gt; <br>
&gt; The bitmap they utilized to track the dirty page information was the<b=
r>
&gt; distinction between the &quot;legacy iteration&quot; and the &quot;mod=
ern iteration.&quot;<br>
&gt; The &quot;iter_bmap&quot; field is used by the &quot;modern iteration&=
quot; while the &quot;bmap&quot;<br>
&gt; field is used by the &quot;legacy iteration.&quot;<br>
&gt; <br>
&gt; Since the refinement is now transparent and there is no API available =
to<br>
&gt; change the sync method, I actually want to remove it right now in orde=
r<br>
&gt; to simplify the logic. I&#39;ll include it in the next version.<br>
<br>
How confident do we think the new way is better than the old?<br>
<br>
If it&#39;ll be 100% / always better, I agree we can consider removing the =
old.<br>
But is it always better?=C2=A0 At least it consumes much more resources..<b=
r>
<br>
Otherwise, we can still leave that logic as-is but use a migration property=
<br>
to turn it on only on new machines I think.<br>
<br>
Besides, could you explain why the solution needs to be this complex?=C2=A0=
 My<br>
previous question was that we sync dirty too less, while auto converge<br>
relies on dirty information, so that means auto converge can be adjusted<br=
>
too unfrequently.<br></blockquote><div><br></div><div><div style=3D"font-fa=
mily:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">The orig=
inal logic will update the bmap for each sync, which was used to</div><div =
style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_d=
efault">conduct the dirty page sending. In the background sync logic, we do=
 not</div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" c=
lass=3D"gmail_default">want=C2=A0to update bmap to interfere with the behav=
ior of page sending for</div><div style=3D"font-family:&quot;comic sans ms&=
quot;,sans-serif" class=3D"gmail_default">each background sync, since the b=
itmap we are syncing is only used to</div><div style=3D"font-family:&quot;c=
omic sans ms&quot;,sans-serif" class=3D"gmail_default">detect the convergen=
ce and do the CPU throttle.</div><div style=3D"font-family:&quot;comic sans=
 ms&quot;,sans-serif" class=3D"gmail_default"><br></div><div style=3D"font-=
family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">The it=
eration sync=C2=A0wants to 1: sync dirty bitmap, 2:detect convergence,</div=
><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"g=
mail_default">3: do the CPU throttle and 4: use the bmap fetched to conduct=
 the page</div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-ser=
if" class=3D"gmail_default">sending, while the background sync=C2=A0only do=
es the 1,2,3. They have different</div><div class=3D"gmail_default"><span s=
tyle=3D"font-family:&quot;comic sans ms&quot;,sans-serif">purpose</span><fo=
nt face=3D"comic sans ms, sans-serif">s.=C2=A0These logic need at least two=
 bitmap, one is used to page sending</font></div><div class=3D"gmail_defaul=
t"><font face=3D"comic sans ms, sans-serif">and another is used for CPU thr=
ottling, to achieve this, we introduced the</font></div><div class=3D"gmail=
_default"><font face=3D"comic sans ms, sans-serif">iter_bmap as the tempora=
ry bitmap to store the dirty page information</font></div><div class=3D"gma=
il_default"><font face=3D"comic sans ms, sans-serif">during background sync=
 and copy it to the bmap in the iteration sync logic.</font></div><div clas=
s=3D"gmail_default"><font face=3D"comic sans ms, sans-serif">However, the d=
irty page information in iter_bmap=C2=A0</font><span style=3D"font-family:&=
quot;comic sans ms&quot;,sans-serif">may be repetitive since</span></div><d=
iv class=3D"gmail_default"><span style=3D"font-family:&quot;comic sans ms&q=
uot;,sans-serif">the dirty pages it records could be sent after background =
syncing, we</span></div><div class=3D"gmail_default"><font face=3D"comic sa=
ns ms, sans-serif">introduced the shadow_bmap to help calculate the dirty p=
ages having</font></div><div class=3D"gmail_default"><font face=3D"comic sa=
ns ms, sans-serif">been sent during two background syncs.</font></div></div=
><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"g=
mail_default"><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-=
color:rgb(204,204,204);padding-left:1ex">
<br>
However I wonder whether that can be achieved in a simpler manner by<br></b=
lockquote><div><br></div><div><span style=3D"font-family:&quot;comic sans m=
s&quot;,sans-serif">I have tried my best to make the solution simpler but f=
ailed. :(</span><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style=
:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
e.g. invoke <span class=3D"gmail_default" style=3D"font-family:&quot;comic =
sans ms&quot;,sans-serif"></span><span class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"></span>migration_bitmap_sync=
_precopy() more frequently during<br></blockquote><div><br></div><div style=
=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_defaul=
t">Yes, invoke migration_bitmap_sync_precopy more frequently is also my</di=
v><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"=
gmail_default">first idea but it involves bitmap updating and interfere wit=
h the behavior</div><div style=3D"font-family:&quot;comic sans ms&quot;,san=
s-serif" class=3D"gmail_default">of page sending, it also affects the migra=
tion information stats and interfere</div><div style=3D"font-family:&quot;c=
omic sans ms&quot;,sans-serif" class=3D"gmail_default">other migration logi=
c such as=C2=A0migration_update_rates().</div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1=
px;border-left-style:solid;border-left-color:rgb(204,204,204);padding-left:=
1ex">
migration, for example, in ram_save_iterate() - not every time but the<br>
iterate() is invoked much more frequent, and maybe we can do sync from time=
<br>
to time.</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-col=
or:rgb(204,204,204);padding-left:1ex">
<br>
I also don&#39;t see why we need a separate thread, plus two new bitmaps, t=
o<br>
achieve this..=C2=A0 I didn&#39;t read in-depth yet, but I thought dirty sy=
nc<br>
requires bql anyway, then I don&#39;t yet understand why the two bitmaps ar=
e<br>
required.=C2=A0 If the bitmaps are introduced in the 1st patch, IMO it&#39;=
ll be<br>
great to explain clearly on why they&#39;re needed here.<br>
<br>
Thanks,<br>
<br>
-- <br>
Peter Xu<br>
<br>
</blockquote></div><br clear=3D"all"><div><div style=3D"font-family:&quot;c=
omic sans ms&quot;,sans-serif" class=3D"gmail_default">Thanks,</div><div st=
yle=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_def=
ault"><br></div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-se=
rif" class=3D"gmail_default">Yong</div></div><div><br></div><span class=3D"=
gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signa=
ture"><div dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regard=
s</font></div></div></div>

--000000000000216fd606228402a7--

