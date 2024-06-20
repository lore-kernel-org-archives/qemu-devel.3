Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 061E0C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 19:45:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKNhq-0006ag-1E; Thu, 20 Jun 2024 15:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKNho-0006aG-4e
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 15:44:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKNhl-0007TB-9p
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 15:44:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718912660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IB48XW/cshEe/cLKnIm3xfU4xeLAdeSQ4FI3dIlHtJc=;
 b=AJofYtL0u5La4P3FqNCZGBWUcnQKXk4g8p21t4wsq/1q2gn8WZ1hRsvyjVOr+TD9Pq+hqh
 hhVvx9gZqNs+IsX88DqyATRq+QsC96jNk6AxD+v+XU0fkyd6WcIGmcXU8iKWh5OxY9dKuG
 Y6sve8dfHe5LXzH7VJiEEO/xGBE9H2U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-n_y_9EZ6P26YP0gokNnZmA-1; Thu, 20 Jun 2024 15:44:18 -0400
X-MC-Unique: n_y_9EZ6P26YP0gokNnZmA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3653f54d94eso415910f8f.2
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 12:44:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718912657; x=1719517457;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IB48XW/cshEe/cLKnIm3xfU4xeLAdeSQ4FI3dIlHtJc=;
 b=fONSHOB/gTf0akKGGtSPzdL+Cr8gVt6eMKK5wVuv+A3um4xQI2v+VjFDtmiyaIgs1i
 WiUM/LUnRpDH2Gkc0DA/QuEy+PcRaYINNaRSrXm66oKlmbqpiv48SrKbFqJmbCtyESkn
 X+I7kP7ADGFeVEtUs0kZT8SbKI6jZi+23dekFEiankQNuTC5OWyHi8rAfgOqOFCa8Op5
 COJbnA1tFz4DKUbkZm6I9bN048OSVNNqHpPtuYeq2p2gqejnPCJAp+7HQ5cyX9DVcfMj
 OER6kkAKAl2mgPnzEUw9A8AF5nzEO+eyQjHON4VXc4mhuDS5gywxnuj4SMSGnCWnI8va
 LOjw==
X-Gm-Message-State: AOJu0YwNuSnxbtsFAXWM7qPx+yqV9pGNTrZhjZPOwvzyLkQplr2HF0GE
 aZPXH94dG4yxX+Ieu2s6u7NHg3r8TAJI8a4iMiSA8HuDNHWBS+1HhDMYfCIe5pA7D7nAHwhc4l9
 FnUdoY3Z5CVONHU6kLi5dUMNeVLpldsImoIjpcOOeB2Ek/0OISmzBFSkxQjtRpnj93P97oFwVZm
 mwol2eU1sw0trE/1RFc6+jQiIV80Q=
X-Received: by 2002:a05:6000:143:b0:362:93f9:cb7f with SMTP id
 ffacd0b85a97d-36317c7eb8cmr4843461f8f.29.1718912657490; 
 Thu, 20 Jun 2024 12:44:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwujZeHhJ3+bdDOV9lEJbmHFw3Nl1LWVl2VCaIibj5t/Mu5uEIAAsfO/MDDOFdCo+Xs1nb/RNNoj9xCrDTgEM=
X-Received: by 2002:a05:6000:143:b0:362:93f9:cb7f with SMTP id
 ffacd0b85a97d-36317c7eb8cmr4843431f8f.29.1718912656987; Thu, 20 Jun 2024
 12:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <rust-pl011-rfc-v3.git.manos.pitsidianakis@linaro.org>
 <e74803e6b570ab36ebc538dd84dc7c4bc2fbe4e7.1718827153.git.manos.pitsidianakis@linaro.org>
 <ae1397b5-4154-4aeb-bf5f-3a62adcc05fd@redhat.com>
 <fe5ah.cugg8hrhlzn0@linaro.org>
In-Reply-To: <fe5ah.cugg8hrhlzn0@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 20 Jun 2024 21:44:05 +0200
Message-ID: <CABgObfY8YhfVd_nRBxEf21KW8ER=-CyuSVYA11bn6bKwv=6e5g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/5] build-sys: Add rust feature option
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Alex_Benn=C3=A9_e?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com, 
 Richard Henderson <richard.henderson@linaro.org>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000051e9a4061b578aad"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--00000000000051e9a4061b578aad
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il gio 20 giu 2024, 20:13 Manos Pitsidianakis <
manos.pitsidianakis@linaro.org> ha scritto:

> On Thu, 20 Jun 2024 16:21, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >On 6/19/24 22:13, Manos Pitsidianakis wrote:
> >> Add options for Rust in meson_options.txt, meson.build, configure to
> >> prepare for adding Rust code in the followup commits.
> >>
> >> `rust` is a reserved meson name, so we have to use an alternative.
> >> `with_rust` was chosen.
> >>
> >> A cargo_wrapper.py script is added that is heavily based on the work o=
f
> >> Marc-Andr=C3=A9 Lureau from 2021.
> >>
> >>
> https://patchew.org/QEMU/20210907121943.3498701-1-marcandre.lureau@redhat=
.com/
> >>
> >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> >
> >The cargo_wrapper.py script is not used yet, so it should be
> >delayed until it's used.
>
> That's true, I just wanted to make review easier by splitting it out.
> Can we squash them later or do you think I should I do it for the next
> series version?
>

I guess it depends on what the next version looks like. If you start
working on the workspace/build tree/Kconfig parts, it might not have a lot
of cargo_wrapper.py code surviving.

Feel free to take this patch and add

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

>For the detection of the toolchain, I'd rather do everything in
> >configure since that's where the cross file is built.  Something like:
> >
> >diff --git a/configure b/configure
> >index 8b6a2f16ceb..6412a1021c3 100755
> >--- a/configure
> >+++ b/configure
> >@@ -173,6 +173,8 @@ fi
> >
> >  # default parameters
> >  container_engine=3D"auto"
> >+rust_target_triple=3D""
> >+with_rust=3D"no"
> >  cpu=3D""
> >  cross_compile=3D"no"
> >  cross_prefix=3D""
> >@@ -201,6 +202,8 @@ for opt do
> >    --cross-prefix=3D*) cross_prefix=3D"$optarg"
> >                      cross_compile=3D"yes"
> >    ;;
> >+  --cargo=3D*) CARGO=3D"$optarg"
> >+  ;;
> >    --cc=3D*) CC=3D"$optarg"
> >    ;;
> >    --cxx=3D*) CXX=3D"$optarg"
> >@@ -317,6 +322,8 @@ windmc=3D"${WINDMC-${cross_prefix}windmc}"
> >  pkg_config=3D"${PKG_CONFIG-${cross_prefix}pkg-config}"
> >  sdl2_config=3D"${SDL2_CONFIG-${cross_prefix}sdl2-config}"
> >
> >+cargo=3D"${CARGO-cargo}"
> >+
> >  check_define() {
> >  cat > $TMPC <<EOF
> >  #if !defined($1)
> >@@ -628,6 +635,8 @@ for opt do
> >    ;;
> >    --cross-prefix=3D*)
> >    ;;
> >+  --cargo=3D*)
> >+  ;;
> >    --cc=3D*)
> >    ;;
> >    --host-cc=3D*) host_cc=3D"$optarg"
> >@@ -755,8 +764,14 @@ for opt do
> >    ;;
> >    --container-engine=3D*) container_engine=3D"$optarg"
> >    ;;
> >+  --rust-target-triple=3D*) rust_target_triple=3D"$optarg"
> >+  ;;
> >    --gdb=3D*) gdb_bin=3D"$optarg"
> >    ;;
> >+  --with-rust) with_rust=3Dyes
> >+  ;;
> >+  --without-rust) with_rust=3Dno
> >+  ;;
> >    # everything else has the same name in configure and meson
> >    --*) meson_option_parse "$opt" "$optarg"
> >    ;;
> >@@ -854,6 +869,7 @@ $(echo Available targets: $default_target_list | \
> >  Advanced options (experts only):
> >    -Dmesonoptname=3Dval       passthrough option to meson unmodified
> >    --cross-prefix=3DPREFIX    use PREFIX for compile tools, PREFIX can =
be
> blank [$cross_prefix]
> >+  --cargo=3DCARGO            use Cargo binary CARGO [$cargo]
> >    --cc=3DCC                  use C compiler CC [$cc]
> >    --host-cc=3DCC             when cross compiling, use C compiler CC f=
or
> code run
> >                             at build time [$host_cc]
> >@@ -869,11 +885,13 @@ Advanced options (experts only):
> >    --python=3DPYTHON          use specified python [$python]
> >    --ninja=3DNINJA            use specified ninja [$ninja]
> >    --static                 enable static build [$static]
> >-  --without-default-features default all --enable-* options to "disable=
d"
> >-  --without-default-devices  do not include any device that is not
> needed to
> >+  --rust-target-triple=3DTRIPLE  target for Rust cross compilation
> >+  --without-default-features   default all --enable-* options to
> "disabled"
> >+  --without-default-devices    do not include any device that is not
> needed to
> >                             start the emulator (only use if you are
> including
> >                             desired devices in configs/devices/)
> >    --with-devices-ARCH=3DNAME override default configs/devices
> >+  --with-rust              enable experimental Rust code
> >    --enable-debug           enable common debug build options
> >    --cpu=3DCPU                Build for host CPU [$cpu]
> >    --disable-containers     don't use containers for cross-building
> >@@ -1138,6 +1159,20 @@ EOF
> >    fi
> >  fi
> >
> >+##########################################
> >+# detect rust triples
> >+
> >+if test "$with_rust" =3D yes; then
> >+  $CARGO -vV > "${TMPDIR1}/${TMPB}.out"
> >+  if test $? !=3D 0; then
> >+    error_exit "could not execute cargo binary \"$CARGO\""
> >+  fi
> >+  rust_host_triple=3D$(sed -n 's/^host: //p' "${TMPDIR1}/${TMPB}.out")
> >+  if test "$rust_target_triple" =3D ""; then
> >+    rust_target_triple=3D$rust_host_triple
> >+  fi
> >+fi
> >+
> >  ##########################################
> >  # functions to probe cross compilers
> >
> >@@ -1604,6 +1639,10 @@ if test "$container" !=3D no; then
> >      echo "RUNC=3D$runc" >> $config_host_mak
> >  fi
> >  echo "SUBDIRS=3D$subdirs" >> $config_host_mak
> >+if test "$with_rust" =3D yes; then
> >+  echo "RUST_HOST_TRIPLE=3D$rust_host_triple" >> $config_host_mak
> >+  echo "RUST_TARGET_TRIPLE=3D$rust_target_triple" >> $config_host_mak
> >+fi
> >  echo "PYTHON=3D$python" >> $config_host_mak
> >  echo "MKVENV_ENSUREGROUP=3D$mkvenv ensuregroup $mkvenv_online_flag" >>
> $config_host_mak
> >  echo "GENISOIMAGE=3D$genisoimage" >> $config_host_mak
> >@@ -1731,6 +1770,13 @@ if test "$skip_meson" =3D no; then
> >    echo "c =3D [$(meson_quote $cc $CPU_CFLAGS)]" >> $cross
> >    test -n "$cxx" && echo "cpp =3D [$(meson_quote $cxx $CPU_CFLAGS)]" >=
>
> $cross
> >    test -n "$objcc" && echo "objc =3D [$(meson_quote $objcc $CPU_CFLAGS=
)]"
> >> $cross
> >+  if test "$with_rust" =3D yes; then
> >+    if test "$rust_host_triple" !=3D "$rust_target_triple"; then
> >+      echo "cargo =3D [$(meson_quote $cargo --target
> "$rust_target_triple")]" >> $cross
> >+    else
> >+      echo "cargo =3D [$(meson_quote $cargo)]" >> $cross
> >+    fi
> >+  fi
>
>
> Hm that looks better indeed, thanks!
>
>
> >    echo "ar =3D [$(meson_quote $ar)]" >> $cross
> >    echo "dlltool =3D [$(meson_quote $dlltool)]" >> $cross
> >    echo "nm =3D [$(meson_quote $nm)]" >> $cross
> >diff --git a/meson.build b/meson.build
> >index c5360fbd299..ad7dbc0d641 100644
> >--- a/meson.build
> >+++ b/meson.build
> >@@ -290,6 +290,11 @@ foreach lang : all_languages
> >    endif
> >  endforeach
> >
> >+cargo =3D not_found
> >+if 'RUST_TARGET_TRIPLE' in config_host
> >+  cargo =3D find_program('cargo', required: true)
> >+endif
> >+
> >  # default flags for all hosts
> >  # We use -fwrapv to tell the compiler that we require a C dialect wher=
e
> >  # left shift of signed integers is well defined and has the expected
> >@@ -4239,6 +4244,10 @@ if 'objc' in all_languages
> >  else
> >    summary_info +=3D {'Objective-C compiler': false}
> >  endif
> >+summary_info +=3D {'Rust support':      cargo.found()}
> >+if cargo.found() and config_host['RUST_TARGET_TRIPLE']) !=3D
> config_host['RUST_HOST_TRIPLE']
> >+  summary_info +=3D {'Rust target':     config_host['RUST_TARGET_TRIPLE=
']}
> >+endif
> >  option_cflags =3D (get_option('debug') ? ['-g'] : [])
> >  if get_option('optimization') !=3D 'plain'
> >    option_cflags +=3D ['-O' + get_option('optimization')]
> >
> >
>
>

--00000000000051e9a4061b578aad
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il gio 20 giu 2024, 20:13 Manos Pitsidianakis &lt;<a h=
ref=3D"mailto:manos.pitsidianakis@linaro.org">manos.pitsidianakis@linaro.or=
g</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On Thu, 20 Jun 2024 16:21, Paolo Bonzini &lt;<a href=3D"mailto:pbonzi=
ni@redhat.com" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>=
&gt; wrote:<br>
&gt;On 6/19/24 22:13, Manos Pitsidianakis wrote:<br>
&gt;&gt; Add options for Rust in meson_options.txt, meson.build, configure =
to<br>
&gt;&gt; prepare for adding Rust code in the followup commits.<br>
&gt;&gt; <br>
&gt;&gt; `rust` is a reserved meson name, so we have to use an alternative.=
<br>
&gt;&gt; `with_rust` was chosen.<br>
&gt;&gt; <br>
&gt;&gt; A cargo_wrapper.py script is added that is heavily based on the wo=
rk of<br>
&gt;&gt; Marc-Andr=C3=A9 Lureau from 2021.<br>
&gt;&gt; <br>
&gt;&gt; <a href=3D"https://patchew.org/QEMU/20210907121943.3498701-1-marca=
ndre.lureau@redhat.com/" rel=3D"noreferrer noreferrer" target=3D"_blank">ht=
tps://patchew.org/QEMU/20210907121943.3498701-1-marcandre.lureau@redhat.com=
/</a><br>
&gt;&gt; <br>
&gt;&gt; Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcan=
dre.lureau@redhat.com" target=3D"_blank" rel=3D"noreferrer">marcandre.lurea=
u@redhat.com</a>&gt;<br>
&gt;&gt; Signed-off-by: Manos Pitsidianakis &lt;<a href=3D"mailto:manos.pit=
sidianakis@linaro.org" target=3D"_blank" rel=3D"noreferrer">manos.pitsidian=
akis@linaro.org</a>&gt;<br>
&gt;<br>
&gt;The cargo_wrapper.py script is not used yet, so it should be<br>
&gt;delayed until it&#39;s used.<br>
<br>
That&#39;s true, I just wanted to make review easier by splitting it out. <=
br>
Can we squash them later or do you think I should I do it for the next <br>
series version?<br></blockquote></div></div><div dir=3D"auto"><br></div><di=
v dir=3D"auto">I guess it depends on what the next version looks like. If y=
ou start working on the workspace/build tree/Kconfig parts, it might not ha=
ve a lot of cargo_wrapper.py code surviving.=C2=A0</div><div dir=3D"auto"><=
br></div><div dir=3D"auto">Feel free to take this patch and add</div><div d=
ir=3D"auto"><br></div><div dir=3D"auto">Signed-off-by: Paolo Bonzini &lt;<a=
 href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt;</div><div =
dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br><=
/div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">&gt;For the detection of the toolchain, I&#39;d ra=
ther do everything in<br>
&gt;configure since that&#39;s where the cross file is built.=C2=A0 Somethi=
ng like:<br>
&gt;<br>
&gt;diff --git a/configure b/configure<br>
&gt;index 8b6a2f16ceb..6412a1021c3 100755<br>
&gt;--- a/configure<br>
&gt;+++ b/configure<br>
&gt;@@ -173,6 +173,8 @@ fi<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 # default parameters<br>
&gt;=C2=A0 container_engine=3D&quot;auto&quot;<br>
&gt;+rust_target_triple=3D&quot;&quot;<br>
&gt;+with_rust=3D&quot;no&quot;<br>
&gt;=C2=A0 cpu=3D&quot;&quot;<br>
&gt;=C2=A0 cross_compile=3D&quot;no&quot;<br>
&gt;=C2=A0 cross_prefix=3D&quot;&quot;<br>
&gt;@@ -201,6 +202,8 @@ for opt do<br>
&gt;=C2=A0 =C2=A0 --cross-prefix=3D*) cross_prefix=3D&quot;$optarg&quot;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 cross_compile=3D&quot;yes&quot;<br>
&gt;=C2=A0 =C2=A0 ;;<br>
&gt;+=C2=A0 --cargo=3D*) CARGO=3D&quot;$optarg&quot;<br>
&gt;+=C2=A0 ;;<br>
&gt;=C2=A0 =C2=A0 --cc=3D*) CC=3D&quot;$optarg&quot;<br>
&gt;=C2=A0 =C2=A0 ;;<br>
&gt;=C2=A0 =C2=A0 --cxx=3D*) CXX=3D&quot;$optarg&quot;<br>
&gt;@@ -317,6 +322,8 @@ windmc=3D&quot;${WINDMC-${cross_prefix}windmc}&quot=
;<br>
&gt;=C2=A0 pkg_config=3D&quot;${PKG_CONFIG-${cross_prefix}pkg-config}&quot;=
<br>
&gt;=C2=A0 sdl2_config=3D&quot;${SDL2_CONFIG-${cross_prefix}sdl2-config}&qu=
ot;<br>
&gt;=C2=A0 <br>
&gt;+cargo=3D&quot;${CARGO-cargo}&quot;<br>
&gt;+<br>
&gt;=C2=A0 check_define() {<br>
&gt;=C2=A0 cat &gt; $TMPC &lt;&lt;EOF<br>
&gt;=C2=A0 #if !defined($1)<br>
&gt;@@ -628,6 +635,8 @@ for opt do<br>
&gt;=C2=A0 =C2=A0 ;;<br>
&gt;=C2=A0 =C2=A0 --cross-prefix=3D*)<br>
&gt;=C2=A0 =C2=A0 ;;<br>
&gt;+=C2=A0 --cargo=3D*)<br>
&gt;+=C2=A0 ;;<br>
&gt;=C2=A0 =C2=A0 --cc=3D*)<br>
&gt;=C2=A0 =C2=A0 ;;<br>
&gt;=C2=A0 =C2=A0 --host-cc=3D*) host_cc=3D&quot;$optarg&quot;<br>
&gt;@@ -755,8 +764,14 @@ for opt do<br>
&gt;=C2=A0 =C2=A0 ;;<br>
&gt;=C2=A0 =C2=A0 --container-engine=3D*) container_engine=3D&quot;$optarg&=
quot;<br>
&gt;=C2=A0 =C2=A0 ;;<br>
&gt;+=C2=A0 --rust-target-triple=3D*) rust_target_triple=3D&quot;$optarg&qu=
ot;<br>
&gt;+=C2=A0 ;;<br>
&gt;=C2=A0 =C2=A0 --gdb=3D*) gdb_bin=3D&quot;$optarg&quot;<br>
&gt;=C2=A0 =C2=A0 ;;<br>
&gt;+=C2=A0 --with-rust) with_rust=3Dyes<br>
&gt;+=C2=A0 ;;<br>
&gt;+=C2=A0 --without-rust) with_rust=3Dno<br>
&gt;+=C2=A0 ;;<br>
&gt;=C2=A0 =C2=A0 # everything else has the same name in configure and meso=
n<br>
&gt;=C2=A0 =C2=A0 --*) meson_option_parse &quot;$opt&quot; &quot;$optarg&qu=
ot;<br>
&gt;=C2=A0 =C2=A0 ;;<br>
&gt;@@ -854,6 +869,7 @@ $(echo Available targets: $default_target_list | \<=
br>
&gt;=C2=A0 Advanced options (experts only):<br>
&gt;=C2=A0 =C2=A0 -Dmesonoptname=3Dval=C2=A0 =C2=A0 =C2=A0 =C2=A0passthroug=
h option to meson unmodified<br>
&gt;=C2=A0 =C2=A0 --cross-prefix=3DPREFIX=C2=A0 =C2=A0 use PREFIX for compi=
le tools, PREFIX can be blank [$cross_prefix]<br>
&gt;+=C2=A0 --cargo=3DCARGO=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 use Ca=
rgo binary CARGO [$cargo]<br>
&gt;=C2=A0 =C2=A0 --cc=3DCC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 use C compiler CC [$cc]<br>
&gt;=C2=A0 =C2=A0 --host-cc=3DCC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0when cross compiling, use C compiler CC for code run<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0at build time [$host_cc]<br>
&gt;@@ -869,11 +885,13 @@ Advanced options (experts only):<br>
&gt;=C2=A0 =C2=A0 --python=3DPYTHON=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 use s=
pecified python [$python]<br>
&gt;=C2=A0 =C2=A0 --ninja=3DNINJA=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
use specified ninja [$ninja]<br>
&gt;=C2=A0 =C2=A0 --static=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0enable static build [$static]<br>
&gt;-=C2=A0 --without-default-features default all --enable-* options to &q=
uot;disabled&quot;<br>
&gt;-=C2=A0 --without-default-devices=C2=A0 do not include any device that =
is not needed to<br>
&gt;+=C2=A0 --rust-target-triple=3DTRIPLE=C2=A0 target for Rust cross compi=
lation<br>
&gt;+=C2=A0 --without-default-features=C2=A0 =C2=A0default all --enable-* o=
ptions to &quot;disabled&quot;<br>
&gt;+=C2=A0 --without-default-devices=C2=A0 =C2=A0 do not include any devic=
e that is not needed to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0start the emulator (only use if you are i=
ncluding<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0desired devices in configs/devices/)<br>
&gt;=C2=A0 =C2=A0 --with-devices-ARCH=3DNAME override default configs/devic=
es<br>
&gt;+=C2=A0 --with-rust=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ena=
ble experimental Rust code<br>
&gt;=C2=A0 =C2=A0 --enable-debug=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0en=
able common debug build options<br>
&gt;=C2=A0 =C2=A0 --cpu=3DCPU=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Build for host CPU [$cpu]<br>
&gt;=C2=A0 =C2=A0 --disable-containers=C2=A0 =C2=A0 =C2=A0don&#39;t use con=
tainers for cross-building<br>
&gt;@@ -1138,6 +1159,20 @@ EOF<br>
&gt;=C2=A0 =C2=A0 fi<br>
&gt;=C2=A0 fi<br>
&gt;=C2=A0 <br>
&gt;+##########################################<br>
&gt;+# detect rust triples<br>
&gt;+<br>
&gt;+if test &quot;$with_rust&quot; =3D yes; then<br>
&gt;+=C2=A0 $CARGO -vV &gt; &quot;${TMPDIR1}/${TMPB}.out&quot;<br>
&gt;+=C2=A0 if test $? !=3D 0; then<br>
&gt;+=C2=A0 =C2=A0 error_exit &quot;could not execute cargo binary \&quot;$=
CARGO\&quot;&quot;<br>
&gt;+=C2=A0 fi<br>
&gt;+=C2=A0 rust_host_triple=3D$(sed -n &#39;s/^host: //p&#39; &quot;${TMPD=
IR1}/${TMPB}.out&quot;)<br>
&gt;+=C2=A0 if test &quot;$rust_target_triple&quot; =3D &quot;&quot;; then<=
br>
&gt;+=C2=A0 =C2=A0 rust_target_triple=3D$rust_host_triple<br>
&gt;+=C2=A0 fi<br>
&gt;+fi<br>
&gt;+<br>
&gt;=C2=A0 ##########################################<br>
&gt;=C2=A0 # functions to probe cross compilers<br>
&gt;=C2=A0 <br>
&gt;@@ -1604,6 +1639,10 @@ if test &quot;$container&quot; !=3D no; then<br>
&gt;=C2=A0 =C2=A0 =C2=A0 echo &quot;RUNC=3D$runc&quot; &gt;&gt; $config_hos=
t_mak<br>
&gt;=C2=A0 fi<br>
&gt;=C2=A0 echo &quot;SUBDIRS=3D$subdirs&quot; &gt;&gt; $config_host_mak<br=
>
&gt;+if test &quot;$with_rust&quot; =3D yes; then<br>
&gt;+=C2=A0 echo &quot;RUST_HOST_TRIPLE=3D$rust_host_triple&quot; &gt;&gt; =
$config_host_mak<br>
&gt;+=C2=A0 echo &quot;RUST_TARGET_TRIPLE=3D$rust_target_triple&quot; &gt;&=
gt; $config_host_mak<br>
&gt;+fi<br>
&gt;=C2=A0 echo &quot;PYTHON=3D$python&quot; &gt;&gt; $config_host_mak<br>
&gt;=C2=A0 echo &quot;MKVENV_ENSUREGROUP=3D$mkvenv ensuregroup $mkvenv_onli=
ne_flag&quot; &gt;&gt; $config_host_mak<br>
&gt;=C2=A0 echo &quot;GENISOIMAGE=3D$genisoimage&quot; &gt;&gt; $config_hos=
t_mak<br>
&gt;@@ -1731,6 +1770,13 @@ if test &quot;$skip_meson&quot; =3D no; then<br>
&gt;=C2=A0 =C2=A0 echo &quot;c =3D [$(meson_quote $cc $CPU_CFLAGS)]&quot; &=
gt;&gt; $cross<br>
&gt;=C2=A0 =C2=A0 test -n &quot;$cxx&quot; &amp;&amp; echo &quot;cpp =3D [$=
(meson_quote $cxx $CPU_CFLAGS)]&quot; &gt;&gt; $cross<br>
&gt;=C2=A0 =C2=A0 test -n &quot;$objcc&quot; &amp;&amp; echo &quot;objc =3D=
 [$(meson_quote $objcc $CPU_CFLAGS)]&quot; &gt;&gt; $cross<br>
&gt;+=C2=A0 if test &quot;$with_rust&quot; =3D yes; then<br>
&gt;+=C2=A0 =C2=A0 if test &quot;$rust_host_triple&quot; !=3D &quot;$rust_t=
arget_triple&quot;; then<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 echo &quot;cargo =3D [$(meson_quote $cargo --targ=
et &quot;$rust_target_triple&quot;)]&quot; &gt;&gt; $cross<br>
&gt;+=C2=A0 =C2=A0 else<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 echo &quot;cargo =3D [$(meson_quote $cargo)]&quot=
; &gt;&gt; $cross<br>
&gt;+=C2=A0 =C2=A0 fi<br>
&gt;+=C2=A0 fi<br>
<br>
<br>
Hm that looks better indeed, thanks!<br>
<br>
<br>
&gt;=C2=A0 =C2=A0 echo &quot;ar =3D [$(meson_quote $ar)]&quot; &gt;&gt; $cr=
oss<br>
&gt;=C2=A0 =C2=A0 echo &quot;dlltool =3D [$(meson_quote $dlltool)]&quot; &g=
t;&gt; $cross<br>
&gt;=C2=A0 =C2=A0 echo &quot;nm =3D [$(meson_quote $nm)]&quot; &gt;&gt; $cr=
oss<br>
&gt;diff --git a/meson.build b/meson.build<br>
&gt;index c5360fbd299..ad7dbc0d641 100644<br>
&gt;--- a/meson.build<br>
&gt;+++ b/meson.build<br>
&gt;@@ -290,6 +290,11 @@ foreach lang : all_languages<br>
&gt;=C2=A0 =C2=A0 endif<br>
&gt;=C2=A0 endforeach<br>
&gt;=C2=A0 <br>
&gt;+cargo =3D not_found<br>
&gt;+if &#39;RUST_TARGET_TRIPLE&#39; in config_host<br>
&gt;+=C2=A0 cargo =3D find_program(&#39;cargo&#39;, required: true)<br>
&gt;+endif<br>
&gt;+<br>
&gt;=C2=A0 # default flags for all hosts<br>
&gt;=C2=A0 # We use -fwrapv to tell the compiler that we require a C dialec=
t where<br>
&gt;=C2=A0 # left shift of signed integers is well defined and has the expe=
cted<br>
&gt;@@ -4239,6 +4244,10 @@ if &#39;objc&#39; in all_languages<br>
&gt;=C2=A0 else<br>
&gt;=C2=A0 =C2=A0 summary_info +=3D {&#39;Objective-C compiler&#39;: false}=
<br>
&gt;=C2=A0 endif<br>
&gt;+summary_info +=3D {&#39;Rust support&#39;:=C2=A0 =C2=A0 =C2=A0 cargo.f=
ound()}<br>
&gt;+if cargo.found() and config_host[&#39;RUST_TARGET_TRIPLE&#39;]) !=3D c=
onfig_host[&#39;RUST_HOST_TRIPLE&#39;]<br>
&gt;+=C2=A0 summary_info +=3D {&#39;Rust target&#39;:=C2=A0 =C2=A0 =C2=A0co=
nfig_host[&#39;RUST_TARGET_TRIPLE&#39;]}<br>
&gt;+endif<br>
&gt;=C2=A0 option_cflags =3D (get_option(&#39;debug&#39;) ? [&#39;-g&#39;] =
: [])<br>
&gt;=C2=A0 if get_option(&#39;optimization&#39;) !=3D &#39;plain&#39;<br>
&gt;=C2=A0 =C2=A0 option_cflags +=3D [&#39;-O&#39; + get_option(&#39;optimi=
zation&#39;)]<br>
&gt;<br>
&gt;<br>
<br>
</blockquote></div></div></div>

--00000000000051e9a4061b578aad--


