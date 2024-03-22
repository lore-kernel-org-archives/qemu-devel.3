Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA931C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 01:58:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnUAC-0006wJ-Az; Thu, 21 Mar 2024 21:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rnUA9-0006vz-Gr
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 21:57:41 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rnUA6-000498-Bf
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 21:57:41 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5ce07cf1e5dso962432a12.2
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 18:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1711072534; x=1711677334;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EzIedkjP0LEiwr8PUCzEsIhUTFBbw9IsPgV6MMV2IDk=;
 b=KeV7yh0xRK9IdOgj5PPQQ7+GpcjBoqgMTjjN/Ckab1pzYMr7MKC0L9cLko6iTYSnSl
 2P+uUlmdTrsjJ0qiwgU4hAWxCigvkQPi4eLBep16yUc+RnA39ttoyldloTsD9DlTfOwI
 esjCb+tC9Qln+FeqVmXIn190FawktJkXmpkm+ZLKJjdAsVYdnnv2bsBQJvYIkZEmfqeS
 +AxXpYwFo1U/LrDsp30zSf2BVB/qiq3RqPYQUUQsllj9ehhFBbVccQExeHShMAt7j3jj
 ejgb1p2ktPseIXjdTcQjbryAFNX73vC+5QR5AQsXFrRrqyci9bVCRS8ew7V/CfKPGA6N
 UpkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711072534; x=1711677334;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EzIedkjP0LEiwr8PUCzEsIhUTFBbw9IsPgV6MMV2IDk=;
 b=vTgf+JuFQ8Zv7KetZWoEy9EPMqlljw/8inf6AJWjHR/rB9/swmmH1aBtjKErcVWJ4N
 HYqgP0mCOnXYAgtSBOoOI5AFW0ESpz/4kvjHFBH4rbt2XxDoFOJsFaIYC7rGEECuMGCL
 dRm8yNdF7bZuYwRNrw9hDjOELM030DRH5TzqDapVyIVq9+Cnm2VrVg5XM1xgdoRSHPrY
 wIMO1ivNtLK8H/JEvXk1/JI75n/pAbFfoIqtlKE3jMvc7uaUC3t9Ml0intDXOCmOQIRz
 bh3Ac9/J8jcaytiINcl/U/K9Cr28oe6caHkyMjwHD/kylvPuF1rxTtQIe+HpudLNZhW6
 Qv5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxJeeEIJLYuCgTij6742FxRSbE0RHv+efMMUcYxJMoudJ7ZXWYYwkdcmBlS1gSefbFYXg3Oe/4GpExFuOYYTKlvFyxeMg=
X-Gm-Message-State: AOJu0Yzr6G6X6Hm27vWVLKnMKwSF+3mxqeX7WKWBoyEEYwIPMXX9NTsT
 zmbbBoJLW7fsS1PzC/f4z59VQWMPaitI3BVAu7KFTO2/xzy11VyGoL2LLDS0vqHUJ2gCG6jq/77
 61sHaYedUdWvKiziyTkj4MOeLQslmni4qfI7YzA==
X-Google-Smtp-Source: AGHT+IEbo5r7yzg00gqOHO1oaR9WuKR/d65AU7VaDJ8KqEEbxNGXkejY0G5rWbPV2hOyHqThe5iTa82tY2r5TYnRxNo=
X-Received: by 2002:a17:90a:d705:b0:2a0:2b14:9593 with SMTP id
 y5-20020a17090ad70500b002a02b149593mr1169651pju.6.1711072534302; Thu, 21 Mar
 2024 18:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240320064911.545001-1-clg@redhat.com>
 <20240320064911.545001-12-clg@redhat.com> <Zfr-W0aubJC_lfaK@x1n>
In-Reply-To: <Zfr-W0aubJC_lfaK@x1n>
From: Yong Huang <yong.huang@smartx.com>
Date: Fri, 22 Mar 2024 09:55:18 +0800
Message-ID: <CAK9dgmYyV-vH8YA=vkL8afXMByCTdnYUNM=XtG8xv5kpu4t6_A@mail.gmail.com>
Subject: Re: [PATCH for-9.1 v5 11/14] memory: Add Error** argument to the
 global_dirty_log routines
To: Peter Xu <peterx@redhat.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, 
 Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Alex Williamson <alex.williamson@redhat.com>, 
 Avihai Horon <avihaih@nvidia.com>, Markus Armbruster <armbru@redhat.com>, 
 Prasad Pandit <pjp@fedoraproject.org>, xen-devel@lists.xenproject.org, 
 Hailiang Zhang <zhanghailiang@xfusion.com>
Content-Type: multipart/alternative; boundary="00000000000097d4950614361ece"
Received-SPF: none client-ip=2607:f8b0:4864:20::52d;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--00000000000097d4950614361ece
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 11:19=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote=
:

> On Wed, Mar 20, 2024 at 07:49:07AM +0100, C=C3=A9dric Le Goater wrote:
> > Now that the log_global*() handlers take an Error** parameter and
> > return a bool, do the same for memory_global_dirty_log_start() and
> > memory_global_dirty_log_stop(). The error is reported in the callers
> > for now and it will be propagated in the call stack in the next
> > changes.
> >
> > To be noted a functional change in ram_init_bitmaps(), if the dirty
> > pages logger fails to start, there is no need to synchronize the dirty
> > pages bitmaps. colo_incoming_start_dirty_log() could be modified in a
> > similar way.
> >
> > Cc: Stefano Stabellini <sstabellini@kernel.org>
> > Cc: Anthony Perard <anthony.perard@citrix.com>
> > Cc: Paul Durrant <paul@xen.org>
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Hyman Huang <yong.huang@smartx.com>
> > Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
>
> Just to mention that for the rest users (dirtylimit/dirtyrate/colo) the
> code still just keeps going even if start logging failed even after this
> series applied as a whole.  Migration framework handles the failure
> gracefully, not yet the rest.
>
> That might be an issue for some, e.g., ideally we should be able to fail =
a
> calc-dirty-rate request, but it's not supported so far.  Adding that coul=
d
> add quite some burden to this series, so maybe that's fine to be done
>
Indeed, for the GLOBAL_DIRTY_DIRTY_RATE and GLOBAL_DIRTY_LIMIT
dirty tracking, they should handle the failure path of logging start.
The work may be done once the current patchset is merged.


> later.  After all, having a VFIO device (that can fail a start_log()), pl=
us
> any of those features should be even rarer, I think?
>
> It seems at least memory_global_dirty_log_sync() can be called even witho=
ut
> start logging, so I expect nothing should crash immediately. I spot one i=
n
> colo_incoming_start_dirty_log() already of such use.  My wild guess is it
> relies on all log_sync*() hooks to cope with it, e.g. KVM ioctl() should
> fail with -ENENT on most archs I think when it sees dirty log not ever
> started.
>
> For those bits, I'll wait and see whether Yong or Hailiang (cced) has any
> comments. From generic migration/memory side, nothing I see wrong:
>
> Acked-by: Peter Xu <peterx@redhat.com>
>
> Thanks,
>
> --
> Peter Xu
>
>

--=20
Best regards

--00000000000097d4950614361ece
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 20, 20=
24 at 11:19=E2=80=AFPM Peter Xu &lt;<a href=3D"mailto:peterx@redhat.com">pe=
terx@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:so=
lid;border-left-color:rgb(204,204,204);padding-left:1ex">On Wed, Mar 20, 20=
24 at 07:49:07AM +0100, C=C3=A9dric Le Goater wrote:<br>
&gt; Now that the log_global*() handlers take an Error** parameter and<br>
&gt; return a bool, do the same for memory_global_dirty_log_start() and<br>
&gt; memory_global_dirty_log_stop(). The error is reported in the callers<b=
r>
&gt; for now and it will be propagated in the call stack in the next<br>
&gt; changes.<br>
&gt; <br>
&gt; To be noted a functional change in ram_init_bitmaps(), if the dirty<br=
>
&gt; pages logger fails to start, there is no need to synchronize the dirty=
<br>
&gt; pages bitmaps. colo_incoming_start_dirty_log() could be modified in a<=
br>
&gt; similar way.<br>
&gt; <br>
&gt; Cc: Stefano Stabellini &lt;<a href=3D"mailto:sstabellini@kernel.org" t=
arget=3D"_blank">sstabellini@kernel.org</a>&gt;<br>
&gt; Cc: Anthony Perard &lt;<a href=3D"mailto:anthony.perard@citrix.com" ta=
rget=3D"_blank">anthony.perard@citrix.com</a>&gt;<br>
&gt; Cc: Paul Durrant &lt;<a href=3D"mailto:paul@xen.org" target=3D"_blank"=
>paul@xen.org</a>&gt;<br>
&gt; Cc: &quot;Michael S. Tsirkin&quot; &lt;<a href=3D"mailto:mst@redhat.co=
m" target=3D"_blank">mst@redhat.com</a>&gt;<br>
&gt; Cc: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D=
"_blank">pbonzini@redhat.com</a>&gt;<br>
&gt; Cc: David Hildenbrand &lt;<a href=3D"mailto:david@redhat.com" target=
=3D"_blank">david@redhat.com</a>&gt;<br>
&gt; Cc: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" target=3D=
"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; Signed-off-by: C=C3=A9dric Le Goater &lt;<a href=3D"mailto:clg@redhat.=
com" target=3D"_blank">clg@redhat.com</a>&gt;<br>
<br>
Just to mention that for the rest users (dirtylimit/dirtyrate/colo) the<br>
code still just keeps going even if start logging failed even after this<br=
>
series applied as a whole.=C2=A0 Migration framework handles the failure<br=
>
gracefully, not yet the rest.<br>
<br>
That might be an issue for some, e.g., ideally we should be able to fail a<=
br>
calc-dirty-rate request, but it&#39;s not supported so far.=C2=A0 Adding th=
at could<br>
add quite some burden to this series, so maybe that&#39;s fine to be done<b=
r></blockquote><div><div class=3D"gmail_default"><font face=3D"comic sans m=
s, sans-serif"></font></div><div class=3D"gmail_default"><font face=3D"comi=
c sans ms, sans-serif">Indeed, for the=C2=A0GLOBAL_DIRTY_DIRTY_RATE and=C2=
=A0GLOBAL_DIRTY_LIMIT</font></div><div class=3D"gmail_default"><span style=
=3D"font-family:&quot;comic sans ms&quot;,sans-serif">dirty tracking, they =
should handle the failure path of logging start.</span></div></div><div cla=
ss=3D"gmail_default"><span style=3D"font-family:&quot;comic sans ms&quot;,s=
ans-serif">The work may be done once the current patchset is merged.=C2=A0<=
/span></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-=
left-color:rgb(204,204,204);padding-left:1ex">
later.=C2=A0 After all, having a VFIO device (that can fail a start_log()),=
 plus<br>
any of those features should be even rarer, I think?<br>
<br>
It seems at least memory_global_dirty_log_sync() can be called even without=
<br>
start logging, so I expect nothing should crash immediately. I spot one in<=
br>
colo_incoming_start_dirty_log() already of such use.=C2=A0 My wild guess is=
 it<br>
relies on all log_sync*() hooks to cope with it, e.g. KVM ioctl() should<br=
>
fail with -ENENT on most archs I think when it sees dirty log not ever<br>
started.<br>
<br>
For those bits, I&#39;ll wait and see whether Yong or Hailiang (cced) has a=
ny<br>
comments. From generic migration/memory side, nothing I see wrong:<br>
<br>
Acked-by: Peter Xu &lt;<a href=3D"mailto:peterx@redhat.com" target=3D"_blan=
k">peterx@redhat.com</a>&gt;<br>
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

--00000000000097d4950614361ece--

