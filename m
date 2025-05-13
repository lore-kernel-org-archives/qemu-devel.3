Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65220C3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 09:30:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uElxY-0004dX-3i; Tue, 13 May 2025 05:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uElxW-0004d1-E7
 for qemu-devel@nongnu.org; Tue, 13 May 2025 05:29:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uElxT-0003ZD-1W
 for qemu-devel@nongnu.org; Tue, 13 May 2025 05:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747128592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GX+RyOEyFb/04KSchr3/KVvZXnW79gVY6DRLWfxso80=;
 b=dTaYdGLDfjG/LBne9Iji7F/KrrJEx2XKM0Jfh2N+RD2o8nIbk6zYz9kZiwFEW0gmp+guM1
 fuSSrDpr5ZvU2CSgh+zDojAk48glCco0F6W9iHmprUw0NC5zPKJ7sMtua0bhQJN0F7896K
 GqU0B2kZLqHdNaUnCZkDayK+szG7thE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-oQRpwvDkPPu6b3vj04uz_g-1; Tue, 13 May 2025 05:29:50 -0400
X-MC-Unique: oQRpwvDkPPu6b3vj04uz_g-1
X-Mimecast-MFC-AGG-ID: oQRpwvDkPPu6b3vj04uz_g_1747128590
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-442cdf07ad9so22330285e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 02:29:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747128590; x=1747733390;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GX+RyOEyFb/04KSchr3/KVvZXnW79gVY6DRLWfxso80=;
 b=Yxo0OYVj8ltGvzInjPGuqt1wlQqxx7k1MRWdmAk7ugGUgfEGX09wY6Y0hbTjAkYc86
 TAKqqVMdhgQxwEKmQQWJpcvRCFsHmwXC5INJEfN/hxA5T3HtcZ0oYj5cCjbeS0jMmYeU
 W777wd/81W3Uj3Nm1Ta0YJ7fWiwP2/3lCDIPVgi/p5jCU5Fg0fvhcxbnrWSjPD9w5gxW
 XPFegIlQd1DhuOIFSImN27pvqxlsUj0jmJTDUgo3ngYfOvFUtQvICeMSfbOsR1Puz8vQ
 rtonc4GOEOschmZ8Gg0e+k7AmxX48Ng94ME56Q5ZDRWorFJXnqMwo3kpXIk1rr89PquD
 za1w==
X-Gm-Message-State: AOJu0YzshE4BfUmQqpqlxVvvG5+HeKOBVF9ZDIlSm6ihwrS2OVeQj1/2
 9G82depY/ulTSC2BjJcqvF3ZtqvCYyenUATWhB6EMDEhJitKw2fORS+j6px+5ibcQujx/OKek02
 9hqyrvrrwEml/BnZa+0oNSiwLUgMUTlcLJafoLSA2d5RWI8A5oHKsnoZYrueKDPBtgS2JzB6374
 h0W9EPllp7i/+03mI6AQocxpBJo7o=
X-Gm-Gg: ASbGncvtoQVuk/Lx7lcveSDoUeh1YaBfAn41yVKhhnkmL6DSvg/8Xbsi5VCjrXT3HgM
 vmpVtUSoICM2Gx0JcQmcd0VdRZgrJGwhxPzlw5S46Q2em5kUmfIhwSg+yFR/YbG/v8ls=
X-Received: by 2002:a05:600c:4e45:b0:43d:46de:b0eb with SMTP id
 5b1f17b1804b1-442d6d44814mr147536685e9.12.1747128589538; 
 Tue, 13 May 2025 02:29:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGB+8m9WX0Jn1WMeqEgbRG1Eo+3BP20+cm5NFBM+Elx3AkS5cWmCZ38iZnm8YmH5Y+Ktxcs9jDjAwAMf4yGc4Y=
X-Received: by 2002:a05:600c:4e45:b0:43d:46de:b0eb with SMTP id
 5b1f17b1804b1-442d6d44814mr147536375e9.12.1747128589114; Tue, 13 May 2025
 02:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250513083343.148497-1-thuth@redhat.com>
In-Reply-To: <20250513083343.148497-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 May 2025 11:29:35 +0200
X-Gm-Features: AX0GCFt6xkm39Y0EmcUuZTFtWe0QcBEO6mu1BmK3-900m6RYx0iVb5tpo7TZxtg
Message-ID: <CABgObfZnEcbU24N5SQLLwK-XepuxOR_+sRFnjioLkuTbTCJRNQ@mail.gmail.com>
Subject: Re: [PATCH] meson.build: Compile common_ss files with right system
 header include paths
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-arm <qemu-arm@nongnu.org>, Brad Smith <brad@comstyle.com>
Content-Type: multipart/alternative; boundary="000000000000ee6fff063501125f"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
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

--000000000000ee6fff063501125f
Content-Type: text/plain; charset="UTF-8"

Il mar 13 mag 2025, 10:33 Thomas Huth <thuth@redhat.com> ha scritto:

> From: Thomas Huth <thuth@redhat.com>
>
> Since commit 6f4e8a92bbd ("hw/arm: make most of the compilation units
> common"), compilation of some arm machines (like musicpal) fails on
> certain host systems like OpenBSD 7.6/7.7 since headers like <epoxy/gl.h>
> don't reside in /usr/include and we currently don't add the right
> CFLAGS for the common files to include the additional header search
> paths. Add a loop similar to what we already did in commit 727bb5b477e6
> to fix it.
>
> With this fix applied, we can now also drop the explicit dependency
> on pixman for the arm musicpal machine.
>

Thanks, maybe replace common_ss with hw_common_arch_libs in the subject?
These are not necessarily compiled once.

Paolo

Fixes: 6f4e8a92bbd ("hw/arm: make most of the compilation units common")
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> [thuth: Add commit message + changes in hw/arm/meson.build]
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  meson.build        | 27 ++++++++++++++++-----------
>  hw/arm/meson.build |  2 +-
>  2 files changed, 17 insertions(+), 12 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index 5ac64075be7..7131aa2b21d 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3228,6 +3228,7 @@ config_devices_mak_list = []
>  config_devices_h = {}
>  config_target_h = {}
>  config_target_mak = {}
> +config_base_arch_mak = {}
>
>  disassemblers = {
>    'alpha' : ['CONFIG_ALPHA_DIS'],
> @@ -3419,6 +3420,11 @@ foreach target : target_dirs
>      config_all_devices += config_devices
>    endif
>    config_target_mak += {target: config_target}
> +
> +  # build a merged config for all targets with the same TARGET_BASE_ARCH
> +  target_base_arch = config_target['TARGET_BASE_ARCH']
> +  config_base_arch = config_base_arch_mak.get(target_base_arch, {}) +
> config_target
> +  config_base_arch_mak += {target_base_arch: config_base_arch}
>  endforeach
>  target_dirs = actual_target_dirs
>
> @@ -4099,28 +4105,27 @@ common_all = static_library('common',
>
>  # construct common libraries per base architecture
>  hw_common_arch_libs = {}
> -foreach target : target_dirs
> -  config_target = config_target_mak[target]
> -  target_base_arch = config_target['TARGET_BASE_ARCH']
> +foreach target_base_arch, config_base_arch : config_base_arch_mak
> +  if target_base_arch in hw_common_arch
> +    base_arch_hw =
> hw_common_arch[target_base_arch].apply(config_base_arch, strict: false)
> +    base_arch_common = common_ss.apply(config_base_arch, strict: false)
>
> -  # check if already generated
> -  if target_base_arch in hw_common_arch_libs
> -    continue
> -  endif
> +    lib_deps = base_arch_hw.dependencies()
> +    foreach dep : base_arch_common.dependencies()
> +      lib_deps += dep.partial_dependency(compile_args: true, includes:
> true)
> +    endforeach
>
> -  if target_base_arch in hw_common_arch
>      target_inc = [include_directories('target' / target_base_arch)]
> -    src = hw_common_arch[target_base_arch]
>      lib = static_library(
>        'hw_' + target_base_arch,
>        build_by_default: false,
> -      sources: src.all_sources() + genh,
> +      sources: base_arch_hw.sources() + genh,
>        include_directories: common_user_inc + target_inc,
>        implicit_include_directories: false,
>        # prevent common code to access cpu compile time
>        # definition, but still allow access to cpu.h
>        c_args: ['-DCPU_DEFS_H', '-DCOMPILING_SYSTEM_VS_USER',
> '-DCONFIG_SOFTMMU'],
> -      dependencies: src.all_dependencies())
> +      dependencies: lib_deps)
>      hw_common_arch_libs += {target_base_arch: lib}
>    endif
>  endforeach
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index 5098795f61d..8e3bf495dbf 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -8,7 +8,7 @@ arm_common_ss.add(when: 'CONFIG_HIGHBANK', if_true:
> files('highbank.c'))
>  arm_common_ss.add(when: 'CONFIG_INTEGRATOR', if_true:
> files('integratorcp.c'))
>  arm_common_ss.add(when: 'CONFIG_MICROBIT', if_true: files('microbit.c'))
>  arm_common_ss.add(when: 'CONFIG_MPS3R', if_true: files('mps3r.c'))
> -arm_common_ss.add(when: 'CONFIG_MUSICPAL', if_true: [pixman,
> files('musicpal.c')])
> +arm_common_ss.add(when: 'CONFIG_MUSICPAL', if_true: files('musicpal.c'))
>  arm_common_ss.add(when: 'CONFIG_NETDUINOPLUS2', if_true:
> files('netduinoplus2.c'))
>  arm_common_ss.add(when: 'CONFIG_OLIMEX_STM32_H405', if_true:
> files('olimex-stm32-h405.c'))
>  arm_common_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx.c',
> 'npcm7xx_boards.c'))
> --
> 2.49.0
>
>

--000000000000ee6fff063501125f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mar 13 mag 2025, 10:33 Thomas=
 Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; ha s=
critto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: Th=
omas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=3D"_blank" rel=3D"=
noreferrer">thuth@redhat.com</a>&gt;<br>
<br>
Since commit 6f4e8a92bbd (&quot;hw/arm: make most of the compilation units<=
br>
common&quot;), compilation of some arm machines (like musicpal) fails on<br=
>
certain host systems like OpenBSD 7.6/7.7 since headers like &lt;epoxy/gl.h=
&gt;<br>
don&#39;t reside in /usr/include and we currently don&#39;t add the right<b=
r>
CFLAGS for the common files to include the additional header search<br>
paths. Add a loop similar to what we already did in commit 727bb5b477e6<br>
to fix it.<br>
<br>
With this fix applied, we can now also drop the explicit dependency<br>
on pixman for the arm musicpal machine.<br></blockquote></div></div><div di=
r=3D"auto"><br></div><div dir=3D"auto">Thanks, maybe replace common_ss with=
=C2=A0hw_common_arch_libs in the subject? These are not necessarily compile=
d once.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div =
dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_qu=
ote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Fixes: 6f4=
e8a92bbd (&quot;hw/arm: make most of the compilation units common&quot;)<br=
>
Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" tar=
get=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
[thuth: Add commit message + changes in hw/arm/meson.build]<br>
Signed-off-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=
=3D"_blank" rel=3D"noreferrer">thuth@redhat.com</a>&gt;<br>
---<br>
=C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 27 ++++++++++++++++---------=
--<br>
=C2=A0hw/arm/meson.build |=C2=A0 2 +-<br>
=C2=A02 files changed, 17 insertions(+), 12 deletions(-)<br>
<br>
diff --git a/meson.build b/meson.build<br>
index 5ac64075be7..7131aa2b21d 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -3228,6 +3228,7 @@ config_devices_mak_list =3D []<br>
=C2=A0config_devices_h =3D {}<br>
=C2=A0config_target_h =3D {}<br>
=C2=A0config_target_mak =3D {}<br>
+config_base_arch_mak =3D {}<br>
<br>
=C2=A0disassemblers =3D {<br>
=C2=A0 =C2=A0&#39;alpha&#39; : [&#39;CONFIG_ALPHA_DIS&#39;],<br>
@@ -3419,6 +3420,11 @@ foreach target : target_dirs<br>
=C2=A0 =C2=A0 =C2=A0config_all_devices +=3D config_devices<br>
=C2=A0 =C2=A0endif<br>
=C2=A0 =C2=A0config_target_mak +=3D {target: config_target}<br>
+<br>
+=C2=A0 # build a merged config for all targets with the same TARGET_BASE_A=
RCH<br>
+=C2=A0 target_base_arch =3D config_target[&#39;TARGET_BASE_ARCH&#39;]<br>
+=C2=A0 config_base_arch =3D config_base_arch_mak.get(target_base_arch, {})=
 + config_target<br>
+=C2=A0 config_base_arch_mak +=3D {target_base_arch: config_base_arch}<br>
=C2=A0endforeach<br>
=C2=A0target_dirs =3D actual_target_dirs<br>
<br>
@@ -4099,28 +4105,27 @@ common_all =3D static_library(&#39;common&#39;,<br>
<br>
=C2=A0# construct common libraries per base architecture<br>
=C2=A0hw_common_arch_libs =3D {}<br>
-foreach target : target_dirs<br>
-=C2=A0 config_target =3D config_target_mak[target]<br>
-=C2=A0 target_base_arch =3D config_target[&#39;TARGET_BASE_ARCH&#39;]<br>
+foreach target_base_arch, config_base_arch : config_base_arch_mak<br>
+=C2=A0 if target_base_arch in hw_common_arch<br>
+=C2=A0 =C2=A0 base_arch_hw =3D hw_common_arch[target_base_arch].apply(conf=
ig_base_arch, strict: false)<br>
+=C2=A0 =C2=A0 base_arch_common =3D common_ss.apply(config_base_arch, stric=
t: false)<br>
<br>
-=C2=A0 # check if already generated<br>
-=C2=A0 if target_base_arch in hw_common_arch_libs<br>
-=C2=A0 =C2=A0 continue<br>
-=C2=A0 endif<br>
+=C2=A0 =C2=A0 lib_deps =3D base_arch_hw.dependencies()<br>
+=C2=A0 =C2=A0 foreach dep : base_arch_common.dependencies()<br>
+=C2=A0 =C2=A0 =C2=A0 lib_deps +=3D dep.partial_dependency(compile_args: tr=
ue, includes: true)<br>
+=C2=A0 =C2=A0 endforeach<br>
<br>
-=C2=A0 if target_base_arch in hw_common_arch<br>
=C2=A0 =C2=A0 =C2=A0target_inc =3D [include_directories(&#39;target&#39; / =
target_base_arch)]<br>
-=C2=A0 =C2=A0 src =3D hw_common_arch[target_base_arch]<br>
=C2=A0 =C2=A0 =C2=A0lib =3D static_library(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;hw_&#39; + target_base_arch,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0build_by_default: false,<br>
-=C2=A0 =C2=A0 =C2=A0 sources: src.all_sources() + genh,<br>
+=C2=A0 =C2=A0 =C2=A0 sources: base_arch_hw.sources() + genh,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0include_directories: common_user_inc + target_in=
c,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0implicit_include_directories: false,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0# prevent common code to access cpu compile time=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0# definition, but still allow access to cpu.h<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0c_args: [&#39;-DCPU_DEFS_H&#39;, &#39;-DCOMPILIN=
G_SYSTEM_VS_USER&#39;, &#39;-DCONFIG_SOFTMMU&#39;],<br>
-=C2=A0 =C2=A0 =C2=A0 dependencies: src.all_dependencies())<br>
+=C2=A0 =C2=A0 =C2=A0 dependencies: lib_deps)<br>
=C2=A0 =C2=A0 =C2=A0hw_common_arch_libs +=3D {target_base_arch: lib}<br>
=C2=A0 =C2=A0endif<br>
=C2=A0endforeach<br>
diff --git a/hw/arm/meson.build b/hw/arm/meson.build<br>
index 5098795f61d..8e3bf495dbf 100644<br>
--- a/hw/arm/meson.build<br>
+++ b/hw/arm/meson.build<br>
@@ -8,7 +8,7 @@ arm_common_ss.add(when: &#39;CONFIG_HIGHBANK&#39;, if_true:=
 files(&#39;highbank.c&#39;))<br>
=C2=A0arm_common_ss.add(when: &#39;CONFIG_INTEGRATOR&#39;, if_true: files(&=
#39;integratorcp.c&#39;))<br>
=C2=A0arm_common_ss.add(when: &#39;CONFIG_MICROBIT&#39;, if_true: files(&#3=
9;microbit.c&#39;))<br>
=C2=A0arm_common_ss.add(when: &#39;CONFIG_MPS3R&#39;, if_true: files(&#39;m=
ps3r.c&#39;))<br>
-arm_common_ss.add(when: &#39;CONFIG_MUSICPAL&#39;, if_true: [pixman, files=
(&#39;musicpal.c&#39;)])<br>
+arm_common_ss.add(when: &#39;CONFIG_MUSICPAL&#39;, if_true: files(&#39;mus=
icpal.c&#39;))<br>
=C2=A0arm_common_ss.add(when: &#39;CONFIG_NETDUINOPLUS2&#39;, if_true: file=
s(&#39;netduinoplus2.c&#39;))<br>
=C2=A0arm_common_ss.add(when: &#39;CONFIG_OLIMEX_STM32_H405&#39;, if_true: =
files(&#39;olimex-stm32-h405.c&#39;))<br>
=C2=A0arm_common_ss.add(when: &#39;CONFIG_NPCM7XX&#39;, if_true: files(&#39=
;npcm7xx.c&#39;, &#39;npcm7xx_boards.c&#39;))<br>
-- <br>
2.49.0<br>
<br>
</blockquote></div></div></div>

--000000000000ee6fff063501125f--


