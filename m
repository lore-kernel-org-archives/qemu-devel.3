Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B7D4ECD6E9
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 21:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqHpE-0000SF-At; Wed, 11 Feb 2026 16:32:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.r6ligpcxvx2q776=r6umbrf73lte=n52niarm7nf5nq@em483429.getutm.app>)
 id 1vqHpD-0000S5-I7
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 16:32:43 -0500
Received: from a4i986.smtp2go.com ([158.120.83.218])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.r6ligpcxvx2q776=r6umbrf73lte=n52niarm7nf5nq@em483429.getutm.app>)
 id 1vqHpB-0000z3-Df
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 16:32:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getutm.app;
 i=@getutm.app; q=dns/txt; s=s483429; t=1770845545; h=from : subject :
 to : message-id : date;
 bh=LhOYtRwgfAtZqTN9EGv/ljT+k01axXafFzosXIVHVdE=;
 b=WRfFgIgG5IRUctKEL0clwUcJz7yIcZP7D1tXwGuJzNU4TKixUE1+hLHA/ciRoudIU/srJ
 KB0PyQJddIG+3Xd0iDpsVUXvrQ+QNd5ShK/fuabWuuGh1WOVnkCtRZKVgwYciGLTzuLxh/R
 Y3iHJoh+FrKwoAU+gvkSIYKvPKU8abivBtpIZhWrwJ6aVITRDV8L/t0nwZ0M28Epmf2SHkx
 5CsClHV/nuC3P4n0PZidte2D4vXtjOK/5kC3s417s2IIRfmgCnVxZc40OQJjq/uawqX0rfT
 SRQnqZg2q18BN+2d3R/CegomR9IinZAynU6pKxLYgVZLAMT1UD2JfU0PmyHw==
Received: from [10.159.238.187] (helo=mail-ej1-f41.google.com)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
 (Exim 4.99.1-S2G) (envelope-from <j@getutm.app>)
 id 1vqHou-4o5NDgrotAO-gtNr for qemu-devel@nongnu.org;
 Wed, 11 Feb 2026 21:32:24 +0000
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-b7cf4a975d2so361531366b.2
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 13:32:23 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUyooOoMsdIAaTWRCx0X31goBEqwlz1t6/49uc5nU8Ozl9f5EKt3AabzWlRnkm8ahMo0c0ZGqsFHPyI@nongnu.org
X-Gm-Message-State: AOJu0Yz6D15xYPW5im6Y4LbljMPC5Btc9mlFmCbeoaT1+lPMDCudONZT
 V0FHpGgRumWkZozdzGCgxUMYEx1EjSPpyP3AGl6vIXFTIdbRKprTlDxJJmSQLCcDcATmipaag9/
 x5eUgSrUC1ZxxWSZCSDHF4Q/s3tz8z5s=
X-Received: by 2002:a17:907:9705:b0:b86:e937:d097 with SMTP id
 a640c23a62f3a-b8f8f6a087fmr26813566b.38.1770845543146; Wed, 11 Feb 2026
 13:32:23 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a98:9ad1:0:b0:251:ac4:a2b4 with HTTP; Wed, 11 Feb 2026
 13:32:22 -0800 (PST)
In-Reply-To: <4eb93d7a-1fa9-4b3c-8ad7-a2eb64f025a0@collabora.com>
References: <cover.1770231744.git.mst@redhat.com>
 <81cb15cf3774140da7c17341018a3852f920acb5.1770231744.git.mst@redhat.com>
 <4eb93d7a-1fa9-4b3c-8ad7-a2eb64f025a0@collabora.com>
From: Joelle van Dyne <j@getutm.app>
Date: Wed, 11 Feb 2026 13:32:22 -0800
X-Gmail-Original-Message-ID: <CA+E+eSDta5wSBs+=iuPm9yzFnxRihrOmeXrDSVJYoAAiYNQ9fA@mail.gmail.com>
X-Gm-Features: AZwV_QjSzrcbMgp6PYvHBMnSHjIW0SpwX_DJ-iRMZT37JqWmPiPr9fkkwtCr5YM
Message-ID: <CA+E+eSDta5wSBs+=iuPm9yzFnxRihrOmeXrDSVJYoAAiYNQ9fA@mail.gmail.com>
Subject: Re: [PULL 41/51] virtio-gpu-virgl: correct parent for blob memory
 region
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Joelle van Dyne <j@getutm.app>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000008d2aee064a931bb1"
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 483429m:483429abrvJvs:483429scVmEp7XNq
X-smtpcorp-track: h5wb7YQS7dng.lERMVZZlMF_B.vbRocg_d61Y
Received-SPF: pass client-ip=158.120.83.218;
 envelope-from=bounce.r6ligpcxvx2q776=r6umbrf73lte=n52niarm7nf5nq@em483429.getutm.app;
 helo=a4i986.smtp2go.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--0000000000008d2aee064a931bb1
Content-Type: text/plain; charset="UTF-8"

Yes, it does seem like v1 was picked up and not v2. v1 was broken for this
reason.

On Wednesday, February 11, 2026, Dmitry Osipenko <
dmitry.osipenko@collabora.com> wrote:

> On 2/4/26 22:04, Michael S. Tsirkin wrote:
> > From: Joelle van Dyne <j@getutm.app>
> >
> > When `owner` == `mr`, `object_unparent` will crash:
> >
> > object_unparent(mr) ->
> > object_property_del_child(mr, mr) ->
> > object_finalize_child_property(mr, name, mr) ->
> > object_unref(mr) ->
> > object_finalize(mr) ->
> > object_property_del_all(mr) ->
> > object_finalize_child_property(mr, name, mr) ->
> > object_unref(mr) ->
> > fail on g_assert(obj->ref > 0)
> >
> > However, passing a different `owner` to `memory_region_init` does not
> > work. `memory_region_ref` has an optimization where it takes a ref
> > only on the owner. That means when flatviews are created, it does not
> > take a ref on the region and you can get a UAF from `flatview_destroy`
> > called from RCU.
> >
> > The correct fix therefore is to use `NULL` as the name which will set
> > the `owner` but not the `parent` (which is still NULL). This allows us
> > to use `memory_region_ref` on itself while not having to rely on unparent
> > for cleanup.
> >
> > Signed-off-by: Joelle van Dyne <j@getutm.app>
> > Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Message-Id: <20260103214400.71694-1-j@getutm.app>
> > ---
> >  hw/display/virtio-gpu-virgl.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/display/virtio-gpu-virgl.c
> b/hw/display/virtio-gpu-virgl.c
> > index 07f6355ad6..6a83fb63c8 100644
> > --- a/hw/display/virtio-gpu-virgl.c
> > +++ b/hw/display/virtio-gpu-virgl.c
> > @@ -120,7 +120,7 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
> >      vmr->g = g;
> >
> >      mr = &vmr->mr;
> > -    memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
> > +    memory_region_init_ram_ptr(mr, OBJECT(mr), NULL, size, data);
> >      memory_region_add_subregion(&b->hostmem, offset, mr);
> >      memory_region_set_enabled(mr, true);
> >
> > @@ -186,7 +186,7 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
> >          /* memory region owns self res->mr object and frees it by
> itself */
> >          memory_region_set_enabled(mr, false);
> >          memory_region_del_subregion(&b->hostmem, mr);
> > -        object_unparent(OBJECT(mr));
> > +        object_unref(OBJECT(mr));
> >      }
> >
> >      return 0;
>
> Hello Michael,
>
> This patch introduces regression. Running any venus application results
> in a crash:
>
> Thread 2 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
> (gdb) bt
> #0  0x00007ffff56565e2 in __strcmp_evex () at /lib64/libc.so.6
> #1  0x0000555555841bdb in find_fd (head=0x5555572337d0 <cpr_state>,
> name=0x0, id=0) at ../migration/cpr.c:68
> #2  cpr_delete_fd (name=name@entry=0x0, id=id@entry=0) at
> ../migration/cpr.c:77
> #3  0x000055555582290a in qemu_ram_free (block=0x7ff7e93aa7f0) at
> ../system/physmem.c:2615
> #4  0x000055555581ae02 in memory_region_finalize (obj=<optimized out>)
> at ../system/memory.c:1816
> #5  0x0000555555a70ab9 in object_deinit (obj=<optimized out>,
> type=<optimized out>) at ../qom/object.c:715
> #6  object_finalize (data=0x7ff7e936eff0) at ../qom/object.c:729
> #7  object_unref (objptr=0x7ff7e936eff0) at ../qom/object.c:1232
> #8  0x0000555555814fae in memory_region_unref (mr=<optimized out>) at
> ../system/memory.c:1848
> #9  flatview_destroy (view=0x555559ed6c40) at ../system/memory.c:301
> #10 0x0000555555bfc122 in call_rcu_thread (opaque=<optimized out>) at
> ../util/rcu.c:324
> #11 0x0000555555bf17a7 in qemu_thread_start (args=0x555557b99520) at
> ../util/qemu-thread-posix.c:393
> #12 0x00007ffff556f464 in start_thread () at /lib64/libc.so.6
> #13 0x00007ffff55f25ac in __clone3 () at /lib64/libc.so.6
>
> There is a v2 version of this patch that doesn't crash [1]. Was v1
> applied by mistake instead of v2?
>
> [1] https://lore.kernel.org/qemu-devel/20251223184023.1913-1-j@getutm.app/
>
> --
> Best regards,
> Dmitry
>

--0000000000008d2aee064a931bb1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, it does seem like v1 was picked up and not v2. v1 was broken for this =
reason.<br><br>On Wednesday, February 11, 2026, Dmitry Osipenko &lt;<a href=
=3D"mailto:dmitry.osipenko@collabora.com">dmitry.osipenko@collabora.com</a>=
&gt; wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex">On 2/4/26 22:04, Michael S. T=
sirkin wrote:<br>
&gt; From: Joelle van Dyne &lt;<a href=3D"mailto:j@getutm.app">j@getutm.app=
</a>&gt;<br>
&gt; <br>
&gt; When `owner` =3D=3D `mr`, `object_unparent` will crash:<br>
&gt; <br>
&gt; object_unparent(mr) -&gt;<br>
&gt; object_property_del_child(mr, mr) -&gt;<br>
&gt; object_finalize_child_<wbr>property(mr, name, mr) -&gt;<br>
&gt; object_unref(mr) -&gt;<br>
&gt; object_finalize(mr) -&gt;<br>
&gt; object_property_del_all(mr) -&gt;<br>
&gt; object_finalize_child_<wbr>property(mr, name, mr) -&gt;<br>
&gt; object_unref(mr) -&gt;<br>
&gt; fail on g_assert(obj-&gt;ref &gt; 0)<br>
&gt; <br>
&gt; However, passing a different `owner` to `memory_region_init` does not<=
br>
&gt; work. `memory_region_ref` has an optimization where it takes a ref<br>
&gt; only on the owner. That means when flatviews are created, it does not<=
br>
&gt; take a ref on the region and you can get a UAF from `flatview_destroy`=
<br>
&gt; called from RCU.<br>
&gt; <br>
&gt; The correct fix therefore is to use `NULL` as the name which will set<=
br>
&gt; the `owner` but not the `parent` (which is still NULL). This allows us=
<br>
&gt; to use `memory_region_ref` on itself while not having to rely on unpar=
ent<br>
&gt; for cleanup.<br>
&gt; <br>
&gt; Signed-off-by: Joelle van Dyne &lt;<a href=3D"mailto:j@getutm.app">j@g=
etutm.app</a>&gt;<br>
&gt; Reviewed-by: Akihiko Odaki &lt;<a href=3D"mailto:odaki@rsg.ci.i.u-toky=
o.ac.jp">odaki@rsg.ci.i.u-tokyo.ac.jp</a>&gt;<br>
&gt; Reviewed-by: Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">=
mst@redhat.com</a>&gt;<br>
&gt; Signed-off-by: Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com=
">mst@redhat.com</a>&gt;<br>
&gt; Message-Id: &lt;<a href=3D"mailto:20260103214400.71694-1-j@getutm.app"=
>20260103214400.71694-1-j@<wbr>getutm.app</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/display/virtio-gpu-virgl.c | 4 ++--<br>
&gt;=C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/display/virtio-gpu-virgl.<wbr>c b/hw/display/virtio-gp=
u-virgl.<wbr>c<br>
&gt; index 07f6355ad6..6a83fb63c8 100644<br>
&gt; --- a/hw/display/virtio-gpu-virgl.<wbr>c<br>
&gt; +++ b/hw/display/virtio-gpu-virgl.<wbr>c<br>
&gt; @@ -120,7 +120,7 @@ virtio_gpu_virgl_map_resource_<wbr>blob(VirtIOGPU =
*g,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 vmr-&gt;g =3D g;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 mr =3D &amp;vmr-&gt;mr;<br>
&gt; -=C2=A0 =C2=A0 memory_region_init_ram_ptr(mr, OBJECT(mr), &quot;blob&q=
uot;, size, data);<br>
&gt; +=C2=A0 =C2=A0 memory_region_init_ram_ptr(mr, OBJECT(mr), NULL, size, =
data);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 memory_region_add_subregion(&amp;<wbr>b-&gt;hostme=
m, offset, mr);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 memory_region_set_enabled(mr, true);<br>
&gt;=C2=A0 <br>
&gt; @@ -186,7 +186,7 @@ virtio_gpu_virgl_unmap_<wbr>resource_blob(VirtIOGP=
U *g,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* memory region owns self res-&gt;m=
r object and frees it by itself */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_set_enabled(mr, false)=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_del_subregion(&amp;<wb=
r>b-&gt;hostmem, mr);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_unparent(OBJECT(mr));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_unref(OBJECT(mr));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
<br>
Hello Michael,<br>
<br>
This patch introduces regression. Running any venus application results<br>
in a crash:<br>
<br>
Thread 2 &quot;qemu-system-x86&quot; received signal SIGSEGV, Segmentation =
fault.<br>
(gdb) bt<br>
#0=C2=A0 0x00007ffff56565e2 in __strcmp_evex () at /lib64/libc.so.6<br>
#1=C2=A0 0x0000555555841bdb in find_fd (head=3D0x5555572337d0 &lt;cpr_state=
&gt;,<br>
name=3D0x0, id=3D0) at ../migration/cpr.c:68<br>
#2=C2=A0 cpr_delete_fd (name=3Dname@entry=3D0x0, id=3Did@entry=3D0) at<br>
../migration/cpr.c:77<br>
#3=C2=A0 0x000055555582290a in qemu_ram_free (block=3D0x7ff7e93aa7f0) at<br=
>
../system/physmem.c:2615<br>
#4=C2=A0 0x000055555581ae02 in memory_region_finalize (obj=3D&lt;optimized =
out&gt;)<br>
at ../system/memory.c:1816<br>
#5=C2=A0 0x0000555555a70ab9 in object_deinit (obj=3D&lt;optimized out&gt;,<=
br>
type=3D&lt;optimized out&gt;) at ../qom/object.c:715<br>
#6=C2=A0 object_finalize (data=3D0x7ff7e936eff0) at ../qom/object.c:729<br>
#7=C2=A0 object_unref (objptr=3D0x7ff7e936eff0) at ../qom/object.c:1232<br>
#8=C2=A0 0x0000555555814fae in memory_region_unref (mr=3D&lt;optimized out&=
gt;) at<br>
../system/memory.c:1848<br>
#9=C2=A0 flatview_destroy (view=3D0x555559ed6c40) at ../system/memory.c:301=
<br>
#10 0x0000555555bfc122 in call_rcu_thread (opaque=3D&lt;optimized out&gt;) =
at<br>
../util/rcu.c:324<br>
#11 0x0000555555bf17a7 in qemu_thread_start (args=3D0x555557b99520) at<br>
../util/qemu-thread-posix.c:<wbr>393<br>
#12 0x00007ffff556f464 in start_thread () at /lib64/libc.so.6<br>
#13 0x00007ffff55f25ac in __clone3 () at /lib64/libc.so.6<br>
<br>
There is a v2 version of this patch that doesn&#39;t crash [1]. Was v1<br>
applied by mistake instead of v2?<br>
<br>
[1] <a href=3D"https://lore.kernel.org/qemu-devel/20251223184023.1913-1-j@g=
etutm.app/" target=3D"_blank">https://lore.kernel.org/qemu-<wbr>devel/20251=
223184023.1913-1-j@<wbr>getutm.app/</a><br>
<br>
-- <br>
Best regards,<br>
Dmitry<br>
</blockquote>

--0000000000008d2aee064a931bb1--

