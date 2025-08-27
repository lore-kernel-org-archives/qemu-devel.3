Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7E0C8303F
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 08:58:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urByE-0000Hk-LH; Wed, 27 Aug 2025 04:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1urByC-0000Gz-T3
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 04:57:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1urByA-0003Fy-0U
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 04:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756285044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hOj0GMoZUJLr+gp3ACtbZj71ye6Vm/4oNrCYZrjr4Zo=;
 b=GAA03GtzS1/7EoIy02FZx0khAMFc1bOp67NIpHFobovdqhuCfnwqeRxYqKTGYJBe2D4L2R
 uxeJLQdFm/+Hq1CbgGj497l6L+d0Spyw6gch9F/s5Lg0iS5/XAHaoO4PYucWxdZvOuXltf
 YWAVEXeZ6UIELi9Z/oRy5hh6v4NEEeE=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-zRU2gX3OPbGuergxMqo_kw-1; Wed, 27 Aug 2025 04:57:21 -0400
X-MC-Unique: zRU2gX3OPbGuergxMqo_kw-1
X-Mimecast-MFC-AGG-ID: zRU2gX3OPbGuergxMqo_kw_1756285040
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-771f28ed113so2165934b3a.0
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 01:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756285040; x=1756889840;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hOj0GMoZUJLr+gp3ACtbZj71ye6Vm/4oNrCYZrjr4Zo=;
 b=Be4VCgpMuJOi2eBLCSP147i+A7ALhJmgnUxrANRRMjKGOJqCwe+9Aj1ErJpshBM0G+
 lbEVYTTEI/svqdwoC+bzhkmQRvAnrRSarwECZhZHInBQO5op7tJySiROAQmKo/HA666n
 uBnc1Lfv6ztZioVp2sq1OTAfS8JIfsH45447YEoQOCZg+mprMgR0dGqcKoUoGYE3b0iX
 Kr3nOQiKlTvxloM5LM9CJ7zCSYD7j4jA1Y2Bie6fEBcInpCNp44xIUHe3lhz3izgsG+h
 oGDus70xMuPDRvCkuBdSXZgXgsSyyZn/vR7n32XoxaTTSf82ZcNcnGqxJQ1dviOydGJ3
 D5Nw==
X-Gm-Message-State: AOJu0YyDKMZGNE5Jwn4zG7mTC3Rfjb+OI+KV+0G1VKks+pjow6wNjglj
 BUn8+cc5Uqi2vteCJv77JSt/bvAthWyy31qZngegaCke+gpTFqm7yCHkcvrTPFNIyCnEWhIUgiW
 xAWNEZ54gebujEitxJUKq7dmritX86uaHQs3OiagFMptR/sUAeG6MOVRoMMOiPHwcr6IjK8lHvi
 8s5brvrbCwKyIjzE7XVU3UmLLicxR0UyY=
X-Gm-Gg: ASbGnct0SHBV7x1j3HaX5ZPYsQl9ZESpmCyMUbDdH6AZJeAUf6sOkXip3brFq4ABxOt
 dh6O9oDS1CV6ZrvmdrPZ3+S2gTljH3mr3QOH+RGGe/x+uFoBffEttyQDmjSwkFZk7HJSXu1rLMq
 brhIefYI88mnh8h3fptYdyvq0/0LmBm62G2R2d/wDz6DuKbTJJGagkxg==
X-Received: by 2002:a05:6a20:1596:b0:243:78a:827e with SMTP id
 adf61e73a8af0-24340dbe972mr26755394637.54.1756285040042; 
 Wed, 27 Aug 2025 01:57:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFD/1dxnzM9c4Y1sfysbBUWX4kEELJkDlhSlLJ4mG/U8n75DvR/cVJ2gwCUOlWa5SIjcDi+dsyICyAgcL+rCE=
X-Received: by 2002:a05:6a20:1596:b0:243:78a:827e with SMTP id
 adf61e73a8af0-24340dbe972mr26755364637.54.1756285039566; Wed, 27 Aug 2025
 01:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250826140449.4190022-1-marcandre.lureau@redhat.com>
 <20250826140449.4190022-11-marcandre.lureau@redhat.com>
 <aK6r0AytZGSOkWYF@intel.com>
In-Reply-To: <aK6r0AytZGSOkWYF@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 27 Aug 2025 12:57:07 +0400
X-Gm-Features: Ac12FXyYebGOrLuiflTZLojTojoyj0qpqhBoxVe8T0vJ_M2hk0XgJ8bFIpfSeKc
Message-ID: <CAMxuvaxeqgtpKDPwxuRd-bqdy5We=pEpy_FKRo0AysKKFa9kHg@mail.gmail.com>
Subject: Re: [RFC 10/18] rust: split "qom" crate
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-rust@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000e87e2f063d54f92f"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000e87e2f063d54f92f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Aug 27, 2025 at 10:33=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com> wro=
te:

> > diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/
> device.rs
> > index 7cffb894a8..a3bcd1297a 100644
> > --- a/rust/hw/char/pl011/src/device.rs
> > +++ b/rust/hw/char/pl011/src/device.rs
> > @@ -21,10 +21,13 @@
> >      memory::{hwaddr, MemoryRegion, MemoryRegionOps,
> MemoryRegionOpsBuilder},
> >      prelude::*,
> >      qdev::{Clock, ClockEvent, DeviceImpl, DeviceState, Property,
> ResetType, ResettablePhasesImpl},
> > -    qom::{ObjectImpl, Owned, ParentField, ParentInit},
> >      sysbus::{SysBusDevice, SysBusDeviceImpl},
> >      vmstate_clock,
> >  };
> > +use qom::{
> > +    qom_isa, IsA, Object, ObjectClassMethods, ObjectDeref, ObjectImpl,
> ObjectMethods, ObjectType,
> > +    Owned, ParentField, ParentInit,
> > +};
>
> These QOM parts are frequently used and very common. at least for qom,
> I think prelude would help a lot.


ack


> A qom prelude could help reduce the changes in other parts (pl011/
> hpet/memory...).
>
> > diff --git a/rust/qom/meson.build b/rust/qom/meson.build
> > new file mode 100644
> > index 0000000000..6e95d75fa0
> > --- /dev/null
> > +++ b/rust/qom/meson.build
> > @@ -0,0 +1,61 @@
> > +_qom_cfg =3D run_command(rustc_args,
> > +  '--config-headers', config_host_h, '--features', files('Cargo.toml')=
,
> > +  capture: true, check: true).stdout().strip().splitlines()
> > +
> > +# TODO: Remove this comment when the clang/libclang mismatch issue is
> solved.
> > +#
> > +# Rust bindings generation with `bindgen` might fail in some cases
> where the
> > +# detected `libclang` does not match the expected `clang`
> version/target. In
> > +# this case you must pass the path to `clang` and `libclang` to your
> build
> > +# command invocation using the environment variables CLANG_PATH and
> > +# LIBCLANG_PATH
> > +_qom_bindings_inc_rs =3D rust.bindgen(
> > +  input: 'wrapper.h',
> > +  dependencies: common_ss.all_dependencies(),
> > +  output: 'bindings.inc.rs',
>
> There're many binding files with the same name. What about adding a prefi=
x
> like "qom-bindings" to distinguish it? This can help search and locate
> specific binding file.
>

they are already under different directories :)


>
> > +  include_directories: bindings_incdir,
> > +  bindgen_version: ['>=3D0.60.0'],
> > +  args: bindgen_args_common,
> > +)
>
> ...
>
> > diff --git a/rust/qom/tests/tests.rs b/rust/qom/tests/tests.rs
> > new file mode 100644
> > index 0000000000..49f1cbecf5
> > --- /dev/null
> > +++ b/rust/qom/tests/tests.rs
> > @@ -0,0 +1,47 @@
> > +use std::{ffi::CStr, sync::LazyLock};
>
> LazyLock is useful, but it became stable since v1.80. So if Paolo
> decide pick this series after v1.83 support, it's fine.
>

ah, right. I wonder why rust-version didn't warn me about this. I'll check

>
> > +use qom::{qom_isa, Object, ObjectClassMethods, ObjectImpl, ObjectType,
> ParentField};
> > +use util::bindings::{module_call_init, module_init_type};
>
> ...
>
> > +fn init_qom() {
> > +    static ONCE: LazyLock<()> =3D LazyLock::new(|| unsafe {
> > +        module_call_init(module_init_type::MODULE_INIT_QOM);
> > +    });
>
> But for now, we can still use a static BqlCell<bool> as the workaround,
> just like rust/hwcore/tests/tests.rs did, to decouple with MSRV
> dependency.
>
> And it seems rust/hwcore/tests/tests.rs has already covered this test
> case, do we still need this test?
>

I wanted a simpler test that focuses on QOM only. But this may not be
desirable after all.


>
> If so, then it's better to add this new test in a seperate patch, which
> makes current patch focus on the splitting :-).
>

Agree, I'll drop it for now.


>
> > +    bql::start_test();
> > +    LazyLock::force(&ONCE);
> > +}
> > +
>
> Otherwise, LGTM,
>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>
>

--000000000000e87e2f063d54f92f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 27, 2=
025 at 10:33=E2=80=AFAM Zhao Liu &lt;<a href=3D"mailto:zhao1.liu@intel.com"=
>zhao1.liu@intel.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">&gt; diff --git a/rust/hw/char/pl011/src/<a href=3D"htt=
p://device.rs" rel=3D"noreferrer" target=3D"_blank">device.rs</a> b/rust/hw=
/char/pl011/src/<a href=3D"http://device.rs" rel=3D"noreferrer" target=3D"_=
blank">device.rs</a><br>
&gt; index 7cffb894a8..a3bcd1297a 100644<br>
&gt; --- a/rust/hw/char/pl011/src/<a href=3D"http://device.rs" rel=3D"noref=
errer" target=3D"_blank">device.rs</a><br>
&gt; +++ b/rust/hw/char/pl011/src/<a href=3D"http://device.rs" rel=3D"noref=
errer" target=3D"_blank">device.rs</a><br>
&gt; @@ -21,10 +21,13 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 memory::{hwaddr, MemoryRegion, MemoryRegionOps, Me=
moryRegionOpsBuilder},<br>
&gt;=C2=A0 =C2=A0 =C2=A0 prelude::*,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qdev::{Clock, ClockEvent, DeviceImpl, DeviceState,=
 Property, ResetType, ResettablePhasesImpl},<br>
&gt; -=C2=A0 =C2=A0 qom::{ObjectImpl, Owned, ParentField, ParentInit},<br>
&gt;=C2=A0 =C2=A0 =C2=A0 sysbus::{SysBusDevice, SysBusDeviceImpl},<br>
&gt;=C2=A0 =C2=A0 =C2=A0 vmstate_clock,<br>
&gt;=C2=A0 };<br>
&gt; +use qom::{<br>
&gt; +=C2=A0 =C2=A0 qom_isa, IsA, Object, ObjectClassMethods, ObjectDeref, =
ObjectImpl, ObjectMethods, ObjectType,<br>
&gt; +=C2=A0 =C2=A0 Owned, ParentField, ParentInit,<br>
&gt; +};<br>
<br>
These QOM parts are frequently used and very common. at least for qom,<br>
I think prelude would help a lot.=C2=A0</blockquote><div><br></div><div>ack=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
A qom prelude could help reduce the changes in other parts (pl011/<br>
hpet/memory...).<br>
<br>
&gt; diff --git a/rust/qom/meson.build b/rust/qom/meson.build<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..6e95d75fa0<br>
&gt; --- /dev/null<br>
&gt; +++ b/rust/qom/meson.build<br>
&gt; @@ -0,0 +1,61 @@<br>
&gt; +_qom_cfg =3D run_command(rustc_args,<br>
&gt; +=C2=A0 &#39;--config-headers&#39;, config_host_h, &#39;--features&#39=
;, files(&#39;Cargo.toml&#39;),<br>
&gt; +=C2=A0 capture: true, check: true).stdout().strip().splitlines()<br>
&gt; +<br>
&gt; +# TODO: Remove this comment when the clang/libclang mismatch issue is=
 solved.<br>
&gt; +#<br>
&gt; +# Rust bindings generation with `bindgen` might fail in some cases wh=
ere the<br>
&gt; +# detected `libclang` does not match the expected `clang` version/tar=
get. In<br>
&gt; +# this case you must pass the path to `clang` and `libclang` to your =
build<br>
&gt; +# command invocation using the environment variables CLANG_PATH and<b=
r>
&gt; +# LIBCLANG_PATH<br>
&gt; +_qom_bindings_inc_rs =3D rust.bindgen(<br>
&gt; +=C2=A0 input: &#39;wrapper.h&#39;,<br>
&gt; +=C2=A0 dependencies: common_ss.all_dependencies(),<br>
&gt; +=C2=A0 output: &#39;<a href=3D"http://bindings.inc.rs" rel=3D"norefer=
rer" target=3D"_blank">bindings.inc.rs</a>&#39;,<br>
<br>
There&#39;re many binding files with the same name. What about adding a pre=
fix<br>
like &quot;qom-bindings&quot; to distinguish it? This can help search and l=
ocate<br>
specific binding file.<br></blockquote><div><br></div><div>they are already=
 under different directories :)=C2=A0</div><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 include_directories: bindings_incdir,<br>
&gt; +=C2=A0 bindgen_version: [&#39;&gt;=3D0.60.0&#39;],<br>
&gt; +=C2=A0 args: bindgen_args_common,<br>
&gt; +)<br>
<br>
...<br>
<br>
&gt; diff --git a/rust/qom/tests/<a href=3D"http://tests.rs" rel=3D"norefer=
rer" target=3D"_blank">tests.rs</a> b/rust/qom/tests/<a href=3D"http://test=
s.rs" rel=3D"noreferrer" target=3D"_blank">tests.rs</a><br>
&gt; new file mode 100644<br>
&gt; index 0000000000..49f1cbecf5<br>
&gt; --- /dev/null<br>
&gt; +++ b/rust/qom/tests/<a href=3D"http://tests.rs" rel=3D"noreferrer" ta=
rget=3D"_blank">tests.rs</a><br>
&gt; @@ -0,0 +1,47 @@<br>
&gt; +use std::{ffi::CStr, sync::LazyLock};<br>
<br>
LazyLock is useful, but it became stable since v1.80. So if Paolo<br>
decide pick this series after v1.83 support, it&#39;s fine.<br></blockquote=
><div><br></div><div>ah, right. I wonder why rust-version didn&#39;t warn m=
e about this. I&#39;ll check=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
<br>
&gt; +use qom::{qom_isa, Object, ObjectClassMethods, ObjectImpl, ObjectType=
, ParentField};<br>
&gt; +use util::bindings::{module_call_init, module_init_type};<br>
<br>
...<br>
<br>
&gt; +fn init_qom() {<br>
&gt; +=C2=A0 =C2=A0 static ONCE: LazyLock&lt;()&gt; =3D LazyLock::new(|| un=
safe {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 module_call_init(module_init_type::MODULE=
_INIT_QOM);<br>
&gt; +=C2=A0 =C2=A0 });<br>
<br>
But for now, we can still use a static BqlCell&lt;bool&gt; as the workaroun=
d,<br>
just like rust/hwcore/tests/<a href=3D"http://tests.rs" rel=3D"noreferrer" =
target=3D"_blank">tests.rs</a> did, to decouple with MSRV<br>
dependency.<br>
<br>
And it seems rust/hwcore/tests/<a href=3D"http://tests.rs" rel=3D"noreferre=
r" target=3D"_blank">tests.rs</a> has already covered this test<br>
case, do we still need this test?<br></blockquote><div><br></div><div>I wan=
ted a simpler test that focuses on QOM only. But this may not be desirable =
after all.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
<br>
If so, then it&#39;s better to add this new test in a seperate patch, which=
<br>
makes current patch focus on the splitting :-).<br></blockquote><div><br></=
div><div>Agree, I&#39;ll drop it for now.</div><div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 bql::start_test();<br>
&gt; +=C2=A0 =C2=A0 LazyLock::force(&amp;ONCE);<br>
&gt; +}<br>
&gt; +<br>
<br>
Otherwise, LGTM,<br>
<br>
Reviewed-by: Zhao Liu &lt;<a href=3D"mailto:zhao1.liu@intel.com" target=3D"=
_blank">zhao1.liu@intel.com</a>&gt;<br>
<br>
</blockquote></div></div>

--000000000000e87e2f063d54f92f--


