Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A947AC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 09:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWBX5-0006mb-QY; Tue, 23 Jul 2024 05:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sWBX3-0006eT-3s
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 05:10:05 -0400
Received: from mail-vs1-xe30.google.com ([2607:f8b0:4864:20::e30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sWBWy-00029i-Hx
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 05:10:04 -0400
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-4928fb6fdceso902132137.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 02:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1721725797; x=1722330597;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xrTcZcCQTfrwQTMiEVQL0wH3s9wf348RiRKQQ3JBNBE=;
 b=mQWKGvL8yt11Sfg9Z1/j2oXsKqFU/KsQRunfpxF0e2AoeT8nst08/Tw3Nk4chEMPvu
 WFzkN0piZueoAc+eOp+BVIp6ME0s8opC7r9Ntex7AiwTxhUVGNzcMJGTNjDwYCLXXrxx
 h11F8rd3IpX0tMGXAEk3KAoWdj9tuO7X0OmGWq9pfMv2a51VPm7O4FfjRdxc08tsTCJm
 PDmJm5kdDlm8Muf6zcda0nX1831QYV8DReJJUrOHK9nokYjmDtSsPoSuMQqkFEqmFj0+
 59Btqo+7KmCDwVm+GuwzNsMndWHa2PXF5AGOtMXJuaqdaQglP5btAKyhPGAddGt9xmal
 zChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721725797; x=1722330597;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xrTcZcCQTfrwQTMiEVQL0wH3s9wf348RiRKQQ3JBNBE=;
 b=qPbJfY50hAmCtS2yK1vTMpKaH57J4yl4tkwBm/KqjJ1Uq0t1b3StiYgjdVm/C8TFIY
 g5XTMDfccpc3E2/wEIYoQRYoIdRNoYJA6DanAXCVQbqOO6AD4s+SyZNnwMbJQAQfzbw+
 lHIrXDFQyE5nDTspycZieYA/EJVsPoy/SOho5mPrGguVWFjq09j+5cOlmFpOcpcfa7UH
 Bxc9m3LUSKrGHMqKMgDKuRJN8vX9CkHCU8ZPK6M45k3H0uNZ15aZG60tGRYYrw0eDFhF
 waxjqEJIT9rkd+mOIoRhOcYDmnSAi8ROlHXDrtnU6rm0Z4OG5+yuL5eXFj0MgGBiZQ53
 2I1w==
X-Gm-Message-State: AOJu0Ywkgu+M31eewRC8cKFRpw6QVJrTMsbvNJF6mIu0wWQvsG+cWKis
 Ju36SMNVFjaX8BFZj+0BACIRXf4jJ5RmByslutgWviLxGUwDOHJnDhRgO7iC5ZevaQdZpP1Q3BR
 YMRENq6uv8Ekps+hUbPOcybSCYCFYijy7NTKp
X-Google-Smtp-Source: AGHT+IHl/eTJDwvy+ylxN0SaljYAxj6ZpojduHUMbdNpcsO0Vg+U/BwVUWDXyhQmhqjQXqEkUwQ4SAl6wTQhmTxIlOQ=
X-Received: by 2002:a05:6102:149a:b0:48f:c2dd:3520 with SMTP id
 ada2fe7eead31-4928b9b0d5amr12582336137.11.1721725797241; Tue, 23 Jul 2024
 02:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240723085902.98572-1-philmd@linaro.org>
In-Reply-To: <20240723085902.98572-1-philmd@linaro.org>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Tue, 23 Jul 2024 11:09:46 +0200
Message-ID: <CAAibmn1U=47wJOYhhpETHZihTu-aHcohm4eHK0JqK3epSEB8jQ@mail.gmail.com>
Subject: Re: [RFC PATCH] macos: Allow coredump generation
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Alexander Graf <agraf@csgraf.de>, Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Roman Bolshakov <roman@roolebo.dev>, 
 Francesco Cagnin <fcagnin@quarkslab.com>
Content-Type: multipart/alternative; boundary="0000000000008baf1d061de686e1"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::e30;
 envelope-from=phil@philjordan.eu; helo=mail-vs1-xe30.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--0000000000008baf1d061de686e1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This can certainly be useful in various situations! However, wholesale
enabling get-task-allow will enable other processes on the system to inject
code, connect a debugger, etc. to the Qemu process. Normally, this is only
something you'd enable for builds that are specifically intended for
debugging. I'm not sure users running Qemu in production environments will
necessarily appreciate this - do we perhaps want to gate this behind a
build configuration flag?

(Related: Would it perhaps make more sense to dynamically
generate/preprocess the entitlements file based on configuration flags than
have a bunch of variants of the file? You'll end up with a combinatorial
explosion sooner or later - I'm also thinking of com.apple.vm.networking
and com.apple.vm.device-access which we can't enable by default because
they require Apple to grant the entitlement but which currently require
patching if you have those entitlements.)

What do you think?

Phil


On Tue, 23 Jul 2024 at 10:59, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g>
wrote:

> QEMU is allowed to generate coredump on other POSIX OSes,
> bring that functionality to macOS. Admin users still need
> to enable the kern.coredump sysctl manually running:
>
>   % sudo sysctl kern.coredump=3D1
>
> the normal users have to enable their shell running:
>
>   % ulimit -c unlimited
>
> Reference used:
>
> https://nasa.github.io/trick/howto_guides/How-to-dump-core-file-on-MacOS.=
html
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> Cc: Alexander Graf <agraf@csgraf.de>
> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Phil Dennis-Jordan <phil@philjordan.eu>
> Cc: Roman Bolshakov <roman@roolebo.dev>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Francesco Cagnin <fcagnin@quarkslab.com>
> ---
>  MAINTAINERS                  | 2 ++
>  meson.build                  | 6 ++++--
>  accel/hvf/entitlements.plist | 2 ++
>  accel/tcg/entitlements.plist | 8 ++++++++
>  4 files changed, 16 insertions(+), 2 deletions(-)
>  create mode 100644 accel/tcg/entitlements.plist
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d5ff6c2498e..c6f57d77b19 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -611,6 +611,8 @@ M: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>  S: Odd Fixes
>  F: .gitlab-ci.d/cirrus/macos-*
>  F: */*.m
> +F: accel/tcg/entitlements.plist
> +F: accel/hvf/entitlements.plist
>  F: scripts/entitlement.sh
>
>  Alpha Machines
> diff --git a/meson.build b/meson.build
> index a1e51277b09..aae35e93420 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3983,9 +3983,11 @@ foreach target : target_dirs
>        ]
>        if 'CONFIG_HVF' in config_target
>          entitlements =3D 'accel/hvf/entitlements.plist'
> -        build_input +=3D files(entitlements)
> -        install_input +=3D meson.current_source_dir() / entitlements
> +      else
> +        entitlements =3D 'accel/tcg/entitlements.plist'
>        endif
> +      build_input +=3D files(entitlements)
> +      install_input +=3D meson.current_source_dir() / entitlements
>
>        emulators +=3D {exe['name'] : custom_target(exe['name'],
>                     input: build_input,
> diff --git a/accel/hvf/entitlements.plist b/accel/hvf/entitlements.plist
> index 154f3308ef2..af4bb45dbea 100644
> --- a/accel/hvf/entitlements.plist
> +++ b/accel/hvf/entitlements.plist
> @@ -4,5 +4,7 @@
>  <dict>
>      <key>com.apple.security.hypervisor</key>
>      <true/>
> +    <key>com.apple.security.get-task-allow</key>
> +    <true/>
>  </dict>
>  </plist>
> diff --git a/accel/tcg/entitlements.plist b/accel/tcg/entitlements.plist
> new file mode 100644
> index 00000000000..9acd12816c9
> --- /dev/null
> +++ b/accel/tcg/entitlements.plist
> @@ -0,0 +1,8 @@
> +<?xml version=3D"1.0" encoding=3D"UTF-8"?>
> +<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "
> http://www.apple.com/DTDs/PropertyList-1.0.dtd">
> +<plist version=3D"1.0">
> +<dict>
> +    <key>com.apple.security.get-task-allow</key>
> +    <true/>
> +</dict>
> +</plist>
> --
> 2.41.0
>
>

--0000000000008baf1d061de686e1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>This can certainly be useful in various situations! H=
owever, wholesale enabling get-task-allow will enable other processes on th=
e system to inject code, connect a debugger, etc. to the Qemu process. Norm=
ally, this is only something you&#39;d enable for builds that are specifica=
lly intended for debugging. I&#39;m not sure users running Qemu in producti=
on environments will necessarily appreciate this - do we perhaps want to ga=
te this behind a build configuration flag?</div><div><br></div><div>(Relate=
d: Would it perhaps make more sense to dynamically generate/preprocess the =
entitlements file based on configuration flags than have a bunch of variant=
s of the file? You&#39;ll end up with a combinatorial explosion sooner or l=
ater - I&#39;m also thinking of com.apple.vm.networking and com.apple.vm.de=
vice-access which we can&#39;t enable by default because they require Apple=
 to grant the entitlement but which currently require patching if you have =
those entitlements.)</div><div><br></div><div>What do you think?</div><div>=
<br></div><div>Phil</div><div><br></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Tue, 23 Jul 2024 at 10:59, Philippe Ma=
thieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@linaro.org=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
QEMU is allowed to generate coredump on other POSIX OSes,<br>
bring that functionality to macOS. Admin users still need<br>
to enable the kern.coredump sysctl manually running:<br>
<br>
=C2=A0 % sudo sysctl kern.coredump=3D1<br>
<br>
the normal users have to enable their shell running:<br>
<br>
=C2=A0 % ulimit -c unlimited<br>
<br>
Reference used:<br>
<a href=3D"https://nasa.github.io/trick/howto_guides/How-to-dump-core-file-=
on-MacOS.html" rel=3D"noreferrer" target=3D"_blank">https://nasa.github.io/=
trick/howto_guides/How-to-dump-core-file-on-MacOS.html</a><br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
---<br>
Cc: Alexander Graf &lt;<a href=3D"mailto:agraf@csgraf.de" target=3D"_blank"=
>agraf@csgraf.de</a>&gt;<br>
Cc: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com" target=3D=
"_blank">akihiko.odaki@daynix.com</a>&gt;<br>
Cc: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" target=3D=
"_blank">peter.maydell@linaro.org</a>&gt;<br>
Cc: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjordan.eu" target=3D"=
_blank">phil@philjordan.eu</a>&gt;<br>
Cc: Roman Bolshakov &lt;<a href=3D"mailto:roman@roolebo.dev" target=3D"_bla=
nk">roman@roolebo.dev</a>&gt;<br>
Cc: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_bla=
nk">pbonzini@redhat.com</a>&gt;<br>
Cc: Francesco Cagnin &lt;<a href=3D"mailto:fcagnin@quarkslab.com" target=3D=
"_blank">fcagnin@quarkslab.com</a>&gt;<br>
---<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 2 ++<br>
=C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 6 ++++--<br>
=C2=A0accel/hvf/entitlements.plist | 2 ++<br>
=C2=A0accel/tcg/entitlements.plist | 8 ++++++++<br>
=C2=A04 files changed, 16 insertions(+), 2 deletions(-)<br>
=C2=A0create mode 100644 accel/tcg/entitlements.plist<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index d5ff6c2498e..c6f57d77b19 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -611,6 +611,8 @@ M: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:ph=
ilmd@linaro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
=C2=A0S: Odd Fixes<br>
=C2=A0F: .gitlab-ci.d/cirrus/macos-*<br>
=C2=A0F: */*.m<br>
+F: accel/tcg/entitlements.plist<br>
+F: accel/hvf/entitlements.plist<br>
=C2=A0F: scripts/entitlement.sh<br>
<br>
=C2=A0Alpha Machines<br>
diff --git a/meson.build b/meson.build<br>
index a1e51277b09..aae35e93420 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -3983,9 +3983,11 @@ foreach target : target_dirs<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0if &#39;CONFIG_HVF&#39; in config_target<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0entitlements =3D &#39;accel/hvf/entitleme=
nts.plist&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 build_input +=3D files(entitlements)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 install_input +=3D meson.current_source_dir() =
/ entitlements<br>
+=C2=A0 =C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 entitlements =3D &#39;accel/tcg/entitlements.p=
list&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0endif<br>
+=C2=A0 =C2=A0 =C2=A0 build_input +=3D files(entitlements)<br>
+=C2=A0 =C2=A0 =C2=A0 install_input +=3D meson.current_source_dir() / entit=
lements<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0emulators +=3D {exe[&#39;name&#39;] : custom_tar=
get(exe[&#39;name&#39;],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input=
: build_input,<br>
diff --git a/accel/hvf/entitlements.plist b/accel/hvf/entitlements.plist<br=
>
index 154f3308ef2..af4bb45dbea 100644<br>
--- a/accel/hvf/entitlements.plist<br>
+++ b/accel/hvf/entitlements.plist<br>
@@ -4,5 +4,7 @@<br>
=C2=A0&lt;dict&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;key&gt;com.apple.security.hypervisor&lt;/key&gt;<br=
>
=C2=A0 =C2=A0 =C2=A0&lt;true/&gt;<br>
+=C2=A0 =C2=A0 &lt;key&gt;com.apple.security.get-task-allow&lt;/key&gt;<br>
+=C2=A0 =C2=A0 &lt;true/&gt;<br>
=C2=A0&lt;/dict&gt;<br>
=C2=A0&lt;/plist&gt;<br>
diff --git a/accel/tcg/entitlements.plist b/accel/tcg/entitlements.plist<br=
>
new file mode 100644<br>
index 00000000000..9acd12816c9<br>
--- /dev/null<br>
+++ b/accel/tcg/entitlements.plist<br>
@@ -0,0 +1,8 @@<br>
+&lt;?xml version=3D&quot;1.0&quot; encoding=3D&quot;UTF-8&quot;?&gt;<br>
+&lt;!DOCTYPE plist PUBLIC &quot;-//Apple//DTD PLIST 1.0//EN&quot; &quot;<a=
 href=3D"http://www.apple.com/DTDs/PropertyList-1.0.dtd" rel=3D"noreferrer"=
 target=3D"_blank">http://www.apple.com/DTDs/PropertyList-1.0.dtd</a>&quot;=
&gt;<br>
+&lt;plist version=3D&quot;1.0&quot;&gt;<br>
+&lt;dict&gt;<br>
+=C2=A0 =C2=A0 &lt;key&gt;com.apple.security.get-task-allow&lt;/key&gt;<br>
+=C2=A0 =C2=A0 &lt;true/&gt;<br>
+&lt;/dict&gt;<br>
+&lt;/plist&gt;<br>
-- <br>
2.41.0<br>
<br>
</blockquote></div></div>

--0000000000008baf1d061de686e1--

