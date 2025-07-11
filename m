Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C73CC8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 06:38:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua7OS-0004M8-Lj; Fri, 11 Jul 2025 02:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ua7OJ-0004BT-12
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 02:37:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ua7OG-0004xE-UY
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 02:37:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752215864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a9UntUXKDXxseYZru5sCTPQRpRp/YIBeu6CTUMwuSIA=;
 b=HdHzyu4ETiz1NDpQPfu5Uyh7Cfo18BiIl8u5QJELQgEuVSfcvcUCGLbfdmVmmHhS9ILzMW
 nmVs2RfZnsMHOfzzFLWnjbTXwflXe4OCgT1SI2DxVA1O4Zz5oNrj+6lF+Eqjz8X2nz9ZCU
 vsqhED+2jUcl59HDNKU0M3BUleVk9Y0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-jO35mki_NFSg9geo-bO0sQ-1; Fri, 11 Jul 2025 02:37:43 -0400
X-MC-Unique: jO35mki_NFSg9geo-bO0sQ-1
X-Mimecast-MFC-AGG-ID: jO35mki_NFSg9geo-bO0sQ_1752215862
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3138e65efe2so1764226a91.1
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 23:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752215860; x=1752820660;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a9UntUXKDXxseYZru5sCTPQRpRp/YIBeu6CTUMwuSIA=;
 b=LSJC7BPGuLJ4g0eHwXg3kV92NJGXIVEO4jCrLjGwH7JCkB28B75cNMCE+80ww9LBBS
 KHSB0qk2WNrcMk9DmaNMbRE7aPHyKHoYevBR0A8KHUpoKa5lqK/Cj4beH8lv5aqmmHWM
 4rkTN2zsFFOewAfusieJgKixrtJkWOKYhTBNgq4pQ4SwZcBFyyieI3b6iL1EeChccDqF
 Ja+W2od7/0Sd+1SPvhdeM983bhSEHurkZMmi5mMBI+FTCzghbJMAGHOwkJddYZJBp24M
 crNyS9lnyqq1ATyTgGojMbN2qTsgLtpoYXgDEqCJSxdUuKV7uw4QU1Lxxjs8OWjOK/Xc
 vZ7w==
X-Gm-Message-State: AOJu0Yy7qsSXzOg6K/gVM+sl865qZgsrVtziR6tiPGqrZrC1/RmY9F6u
 dAO8HFob2Y6v9wctc2qWzKnWTf1l8aRTXx1L8u4ri0FV+e4fV7P+7xV8WP51j1wsxKxWwv1Y6mY
 QPU5srwwSw0+M0ohsttcZyX43BjI3rfgSHtrIYtSvSWTHdodR6QDVJVIQn2Deb39gpUm+Supliq
 t1FH/Vz0rWJ2gpYW36g83lrUcwE2c3+rTyVfiaRY4=
X-Gm-Gg: ASbGncsMj89DkIyUKCPgPkEJkyVPOWwRevO+aiIMhA0BhoLWvLCiV6EpnUOeh3vNX/g
 xe2lfQsYLJHSfcnXobRmhCSvpgmlChsqqxFEYPhVlOovHi3ugGAy6T0vFGOh2QD8npP2T/3eHRs
 sBwK5aaHfbZ+QpSqTgVPqVhQ==
X-Received: by 2002:a17:90b:2e03:b0:312:e744:5b76 with SMTP id
 98e67ed59e1d1-31c4cdb1cbdmr3936675a91.33.1752215859830; 
 Thu, 10 Jul 2025 23:37:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPJN75MXDPwNtnc11xxOslo3/VXL3OUulnIerEwuOyo/iYYtZrOVcMybwLBCuv22FSep4df7tqJWJufeKXK7M=
X-Received: by 2002:a17:90b:2e03:b0:312:e744:5b76 with SMTP id
 98e67ed59e1d1-31c4cdb1cbdmr3936654a91.33.1752215859433; Thu, 10 Jul 2025
 23:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250711000603.438312-1-pbonzini@redhat.com>
 <20250711000603.438312-5-pbonzini@redhat.com>
 <3c4f798e-1519-459f-b142-07ca39cf738e@intel.com>
In-Reply-To: <3c4f798e-1519-459f-b142-07ca39cf738e@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 11 Jul 2025 08:37:26 +0200
X-Gm-Features: Ac12FXxjF2VOhdrqmBQwpzD9wJUixex112yNFea5PHx-DtRXF0MHTvpuMRCLcQA
Message-ID: <CABgObfag_GRZ-Z3KG_dx7Yg4Crgh3ONV9pOr_0noXsF_h_MOJQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] target/i386: move accel_cpu_instance_init to
 .instance_init
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Zhao Liu <zhao1.liu@intel.com>
Content-Type: multipart/alternative; boundary="000000000000df2aa40639a18b63"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000df2aa40639a18b63
Content-Type: text/plain; charset="UTF-8"

Il ven 11 lug 2025, 04:26 Xiaoyao Li <xiaoyao.li@intel.com> ha scritto:

> BTW, the user's value of "pmu" and "invtsc" are still broken for TDX
> case.  tdx_cpu_instance_init() will always overwrite "pmu" and "invtsc"
> even if users explicitly request a different value via "-cpu" option.
>
> Will we leave it as intentional? or fix it as well?
>

I need to check the differences with SNP but I am leaning towards treating
it as intentional... Maybe warn if there was a user option saying the
opposite.

I will include these in my soft freeze PR, thanks both for the speedy
review!!

Paolo


> > ---
> >   target/i386/cpu.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 46d59229200..5f95bb97b82 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -6207,8 +6207,8 @@ static void max_x86_cpu_initfn(Object *obj)
> >       CPUX86State *env = &cpu->env;
> >
> >       /*
> > -     * these defaults are used for TCG, other accelerators overwrite
> these
> > -     * values
> > +     * these defaults are used for TCG, other accelerators have
> overwritten
> > +     * these values
> >        */
> >       if (!env->cpuid_vendor1) {
> >           object_property_set_str(OBJECT(cpu), "vendor",
> CPUID_VENDOR_AMD,
> > @@ -9043,8 +9043,6 @@ static void x86_cpu_post_initfn(Object *obj)
> >           }
> >       }
> >
> > -    accel_cpu_instance_init(CPU(obj));
> > -
> >   #ifndef CONFIG_USER_ONLY
> >       if (current_machine && current_machine->cgs) {
> >           x86_confidential_guest_cpu_instance_init(
> > @@ -9119,6 +9117,8 @@ static void x86_cpu_initfn(Object *obj)
> >       if (xcc->model) {
> >           x86_cpu_load_model(cpu, xcc->model);
> >       }
> > +
> > +    accel_cpu_instance_init(CPU(obj));
> >   }
> >
> >   static int64_t x86_cpu_get_arch_id(CPUState *cs)
>
>

--000000000000df2aa40639a18b63
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il ven 11 lug 2025, 04:26 Xiaoya=
o Li &lt;<a href=3D"mailto:xiaoyao.li@intel.com">xiaoyao.li@intel.com</a>&g=
t; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">B=
TW, the user&#39;s value of &quot;pmu&quot; and &quot;invtsc&quot; are stil=
l broken for TDX <br>
case.=C2=A0 tdx_cpu_instance_init() will always overwrite &quot;pmu&quot; a=
nd &quot;invtsc&quot; <br>
even if users explicitly request a different value via &quot;-cpu&quot; opt=
ion.<br>
<br>
Will we leave it as intentional? or fix it as well?<br></blockquote></div><=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">I need to check the diff=
erences with SNP but I am leaning towards treating it as intentional... May=
be warn if there was a user option saying the opposite.</div><div dir=3D"au=
to"><br></div><div dir=3D"auto">I will include these in my soft freeze PR, =
thanks both for the speedy review!!</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div c=
lass=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0target/i386/cpu.c | 8 ++++----<br>
&gt;=C2=A0 =C2=A01 file changed, 4 insertions(+), 4 deletions(-)<br>
&gt; <br>
&gt; diff --git a/target/i386/cpu.c b/target/i386/cpu.c<br>
&gt; index 46d59229200..5f95bb97b82 100644<br>
&gt; --- a/target/i386/cpu.c<br>
&gt; +++ b/target/i386/cpu.c<br>
&gt; @@ -6207,8 +6207,8 @@ static void max_x86_cpu_initfn(Object *obj)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0CPUX86State *env =3D &amp;cpu-&gt;env;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; -=C2=A0 =C2=A0 =C2=A0* these defaults are used for TCG, other accelera=
tors overwrite these<br>
&gt; -=C2=A0 =C2=A0 =C2=A0* values<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* these defaults are used for TCG, other accelera=
tors have overwritten<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* these values<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!env-&gt;cpuid_vendor1) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0object_property_set_str(OBJECT=
(cpu), &quot;vendor&quot;, CPUID_VENDOR_AMD,<br>
&gt; @@ -9043,8 +9043,6 @@ static void x86_cpu_post_initfn(Object *obj)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 accel_cpu_instance_init(CPU(obj));<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0#ifndef CONFIG_USER_ONLY<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (current_machine &amp;&amp; current_machi=
ne-&gt;cgs) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0x86_confidential_guest_cpu_ins=
tance_init(<br>
&gt; @@ -9119,6 +9117,8 @@ static void x86_cpu_initfn(Object *obj)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (xcc-&gt;model) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0x86_cpu_load_model(cpu, xcc-&g=
t;model);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 accel_cpu_instance_init(CPU(obj));<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static int64_t x86_cpu_get_arch_id(CPUState *cs)<br>
<br>
</blockquote></div></div></div>

--000000000000df2aa40639a18b63--


