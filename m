Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C196C27C43
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 11:11:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCHCw-0005jZ-G9; Wed, 29 May 2024 07:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sCHCu-0005ii-ST
 for qemu-devel@nongnu.org; Wed, 29 May 2024 07:11:00 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sCHCs-00064g-Du
 for qemu-devel@nongnu.org; Wed, 29 May 2024 07:11:00 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-57863e2846aso1836966a12.1
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 04:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716981056; x=1717585856; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gpZKrKra7Iqk+QjOMF+QAPCTFC0C0WSuN63kFGROMUo=;
 b=PqAtdDv5AfLHrbL20FeBNlR8CZSpac0LuikSi3I3KNaoTcialgUkdN1c1rGT70KAxZ
 0NsjgWMmIQKeAAeMfMmbADFdQ96ZLvg3UVtwQna0lTzlzin8fVRoX4fJ4JY1xvSQFZx4
 lQZpm9YsIh/j5VoseciqqPhaWGsESro0GdA16LvT2D90R0Gb7mGIvuWS0HL+D6YJp8g7
 +iaIT6WZJVm3Ywch4SmSnV3+BRLEr36+40j2Rd4KlDvR8g9JF3pzfaFU6YB7xCj3OJ/t
 4P4xTfFnlHdjtT35HLDPWl6GZG6mHsdiJdPo/quwHlLY2gcozRTc7rKuF3/j+W/SVJHH
 PXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716981056; x=1717585856;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gpZKrKra7Iqk+QjOMF+QAPCTFC0C0WSuN63kFGROMUo=;
 b=U/RKkGXTqfGxjg3S+VOwP0gIq0iKYRIgGGnMnsQyCS8DWrDwOHVjgE2t6/uUaQMfOE
 DSZ01waRqPtdjLV1eybF4Jm8vldEI1yEK2N9qSjRq7T2rBXszneTRmJ2agpRDZzB57J5
 6qIN4eaN9dif8w6n+kyQT9FTEM9Ob84hBFj3H01iFMwIH/PTmAcqhIFkEahURdnyJhgw
 lHNX88K7J9rf/s7nImB8fyxt1YAuC02R55StuS6TornM2RZM5ZejH1zz1BDuoa3775fk
 1hxk7ABcGTbbO/18SmpHBSCqVJgG9ObNut3oCuPOB8bpy+lsV/wkbXIhxX45Myr1opEU
 lUAg==
X-Gm-Message-State: AOJu0YwYdjOVTIC42Bw1ohQngasZIKwfIPIGT/jf5C36rK8sXSkKTiOz
 Gom1TNKTEhYAC8uD3x2gZ6K/yXVX3qkZzu3p09xJCya4B7gtsfXCWEMjMNpA3kMo0HNAhy5kInj
 l7DbZAJZAsfvcda0g4dL1buVuDOg=
X-Google-Smtp-Source: AGHT+IGGjT/BPndtKnYGowXLebktl6eEnPT7PGwOc/WAfZDkZI+bPyxhUgP2QKo0/TNvru3Auo0+hOEzpXMHhwD4LJM=
X-Received: by 2002:a50:8a9c:0:b0:579:fb7e:210d with SMTP id
 4fb4d7f45d1cf-579fb7e2991mr2748072a12.1.1716981055398; Wed, 29 May 2024
 04:10:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240524105152.1301842-1-edgar.iglesias@gmail.com>
 <20240524105152.1301842-4-edgar.iglesias@gmail.com>
 <4025f82f-242c-4c3e-952e-8ecf7a66838f@linaro.org>
In-Reply-To: <4025f82f-242c-4c3e-952e-8ecf7a66838f@linaro.org>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Wed, 29 May 2024 13:10:43 +0200
Message-ID: <CAJy5ezpgANR4VuewnXs=MJwAfipxNq4+1r3LwY-f8-7_R6mwRQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/8] xen: Add xen_mr_is_memory()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, sstabellini@kernel.org, jgross@suse.com, 
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 David Hildenbrand <david@redhat.com>, 
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
Content-Type: multipart/alternative; boundary="000000000000e4a930061995cd5e"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000e4a930061995cd5e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 6:25=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> Hi Edgar,
>
> On 24/5/24 12:51, Edgar E. Iglesias wrote:
> > From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> >
> > Add xen_mr_is_memory() to abstract away tests for the
> > xen_memory MR.
> >
> > No functional changes.
> >
> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> > Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
> > Acked-by: David Hildenbrand <david@redhat.com>
> > ---
> >   hw/xen/xen-hvm-common.c | 10 ++++++++--
> >   include/sysemu/xen.h    |  8 ++++++++
> >   2 files changed, 16 insertions(+), 2 deletions(-)
>
> To consolidate we could add:
>
>    static MemoryRegion xen_memory;
>
>    MemoryRegion *xen_mr_memory_init(uint64_t block_len)
>    {
>       assert(!xen_memory.size);
>       memory_region_init_ram(&xen_memory, NULL, "xen.ram", block_len,
> &error_fatal);
>       return &xen_memory;
>    }
>
> and remove the extern declaration.
>

Thanks,

We have a future patch series in the workings that will add a PVH machine
for x86, I'll keep this in mind for then!


>
> > diff --git a/include/sysemu/xen.h b/include/sysemu/xen.h
> > index 754ec2e6cb..dc72f83bcb 100644
> > --- a/include/sysemu/xen.h
> > +++ b/include/sysemu/xen.h
> > @@ -34,6 +34,8 @@ void xen_hvm_modified_memory(ram_addr_t start,
> ram_addr_t length);
> >   void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
> >                      struct MemoryRegion *mr, Error **errp);
> >
> > +bool xen_mr_is_memory(MemoryRegion *mr);
> > +
> >   #else /* !CONFIG_XEN_IS_POSSIBLE */
> >
> >   #define xen_enabled() 0
> > @@ -47,6 +49,12 @@ static inline void xen_ram_alloc(ram_addr_t ram_addr=
,
> ram_addr_t size,
> >       g_assert_not_reached();
> >   }
> >
> > +static inline bool xen_mr_is_memory(MemoryRegion *mr)
> > +{
> > +    g_assert_not_reached();
> > +    return false;
>
> No need for the stub, just always declare xen_mr_is_memory() ...
> > +}
> > +
> >   #endif /* CONFIG_XEN_IS_POSSIBLE */
>
> ... here.
>
> >   #endif
>
> Removing the stub:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
>
Thanks Philippe, will remove the stubs in v8.

Cheers,
Edgar

--000000000000e4a930061995cd5e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Mon, May 27, 2024 at 6:25=E2=80=AFPM P=
hilippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@=
linaro.org</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">Hi Edgar,<br>
<br>
On 24/5/24 12:51, Edgar E. Iglesias wrote:<br>
&gt; From: &quot;Edgar E. Iglesias&quot; &lt;<a href=3D"mailto:edgar.iglesi=
as@amd.com" target=3D"_blank">edgar.iglesias@amd.com</a>&gt;<br>
&gt; <br>
&gt; Add xen_mr_is_memory() to abstract away tests for the<br>
&gt; xen_memory MR.<br>
&gt; <br>
&gt; No functional changes.<br>
&gt; <br>
&gt; Signed-off-by: Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.iglesias@=
amd.com" target=3D"_blank">edgar.iglesias@amd.com</a>&gt;<br>
&gt; Reviewed-by: Stefano Stabellini &lt;<a href=3D"mailto:sstabellini@kern=
el.org" target=3D"_blank">sstabellini@kernel.org</a>&gt;<br>
&gt; Acked-by: David Hildenbrand &lt;<a href=3D"mailto:david@redhat.com" ta=
rget=3D"_blank">david@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/xen/xen-hvm-common.c | 10 ++++++++--<br>
&gt;=C2=A0 =C2=A0include/sysemu/xen.h=C2=A0 =C2=A0 |=C2=A0 8 ++++++++<br>
&gt;=C2=A0 =C2=A02 files changed, 16 insertions(+), 2 deletions(-)<br>
<br>
To consolidate we could add:<br>
<br>
=C2=A0 =C2=A0static MemoryRegion xen_memory;<br>
<br>
=C2=A0 =C2=A0MemoryRegion *xen_mr_memory_init(uint64_t block_len)<br>
=C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 assert(!xen_memory.size);<br>
=C2=A0 =C2=A0 =C2=A0 memory_region_init_ram(&amp;xen_memory, NULL, &quot;xe=
n.ram&quot;, block_len, <br>
&amp;error_fatal);<br>
=C2=A0 =C2=A0 =C2=A0 return &amp;xen_memory;<br>
=C2=A0 =C2=A0}<br>
<br>
and remove the extern declaration.<br></blockquote><div><br></div><div>Than=
ks,</div><div><br></div><div>We have a future patch series in the workings =
that will add a PVH machine for x86, I&#39;ll keep this in mind for then!</=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; diff --git a/include/sysemu/xen.h b/include/sysemu/xen.h<br>
&gt; index 754ec2e6cb..dc72f83bcb 100644<br>
&gt; --- a/include/sysemu/xen.h<br>
&gt; +++ b/include/sysemu/xen.h<br>
&gt; @@ -34,6 +34,8 @@ void xen_hvm_modified_memory(ram_addr_t start, ram_a=
ddr_t length);<br>
&gt;=C2=A0 =C2=A0void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 struct MemoryRegion *mr, Error **errp);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +bool xen_mr_is_memory(MemoryRegion *mr);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0#else /* !CONFIG_XEN_IS_POSSIBLE */<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#define xen_enabled() 0<br>
&gt; @@ -47,6 +49,12 @@ static inline void xen_ram_alloc(ram_addr_t ram_add=
r, ram_addr_t size,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0g_assert_not_reached();<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +static inline bool xen_mr_is_memory(MemoryRegion *mr)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 g_assert_not_reached();<br>
&gt; +=C2=A0 =C2=A0 return false;<br>
<br>
No need for the stub, just always declare xen_mr_is_memory() ...<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0#endif /* CONFIG_XEN_IS_POSSIBLE */<br>
<br>
... here.<br>
<br>
&gt;=C2=A0 =C2=A0#endif<br>
<br>
Removing the stub:<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linar=
o.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
<br></blockquote><div><br></div><div>Thanks Philippe, will remove the stubs=
 in v8.</div><div><br></div><div>Cheers,</div><div>Edgar</div></div></div>

--000000000000e4a930061995cd5e--

