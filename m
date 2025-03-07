Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0337EC282D0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 16:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqafT-00053v-Fi; Fri, 07 Mar 2025 11:35:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tqafP-00053Q-S1
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 11:35:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tqafG-0007cN-9b
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 11:35:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741365308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5Q2k50i4S+0G5S2e1KEZ2e1Mr7aBSDTJNfk9LjNNFug=;
 b=BcWB4euf7amyJaZz4CbHhjv8cfcPwU0IKmsgirk3DcH8CvJF79dMFxezrxWkrfzN/6mwqs
 EnMaeN4P7kaPaTxGdDQTxJt+8YY+5ReB4dGGDY1JdS+XQczH8YXpk1I1s7cCPjQxVjYIeM
 IP59gpJcIhlm0FrrpwSTKak3YVIgrOQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-mtSMM8YMOh6EPKfKmzthXg-1; Fri, 07 Mar 2025 11:35:04 -0500
X-MC-Unique: mtSMM8YMOh6EPKfKmzthXg-1
X-Mimecast-MFC-AGG-ID: mtSMM8YMOh6EPKfKmzthXg_1741365303
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-39134c762ebso364868f8f.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 08:35:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741365303; x=1741970103;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5Q2k50i4S+0G5S2e1KEZ2e1Mr7aBSDTJNfk9LjNNFug=;
 b=JkD8/2CeHG82cSISO6nVrZC/wHOXwcmkYwUUpyyKQNjVUNEZgJRUVB2Dr0Zn5RMHr2
 /qcym9/sA5l2+8wsJxCHVGJC630quNPplpHVURAb/Mmx4XO/Oel44NwdVAEV7IJuKZ8w
 Y8pYc42i9aKDMbKFXj3ew7JVXMbyMMNC6RQt1gPE3evU3y7galBkYp7j5BHuh8ofajG1
 9+O44HGkqHRsAqs0OYTwfFNC+V3p/dhEdiz0CDEAJtC0eJviqDc9gLyA8dCqsRjuCu8p
 YJnYgGTkcwwLpIIYNirysL7Kr4XKV12JOEICG0A5w4G61bK5ZUsecqHk6Gjd89MEBywW
 eXHw==
X-Gm-Message-State: AOJu0YyxpKmNch4tk46rWz1Ys+ddjEP1cdY3EQfQHi8or3yYIhVv1+Cf
 gOsMXmvzm3swzUV9UY1fVHY37xTFyWaDSHlm5mEvulbCkE0LDZmLBJF4faQhBwgf+CqsT/j35ao
 /MYk6Asjl8BmliHMOeY3L1e1MdkdQ8JhpajqN/hH51T72GsG0uogdldt0a5U9howyg8RCFfx7Nv
 APa/JX/Qjvzniavo+mHlKNguucJ14=
X-Gm-Gg: ASbGncsb8O3u57Zf6DKvNh3MJcSp5nGlUu3qkiwD92IRO0A0s1go2hPTcFj7EPBLhqP
 bRxd8doqqTgBKhfzemDZnKxLlvysLng207FMleJWOJePd6FYOzbaUvgS07MuehCDwtJK3apnBvQ
 ==
X-Received: by 2002:a05:6000:1864:b0:391:39ea:7866 with SMTP id
 ffacd0b85a97d-39139ea7d93mr822765f8f.19.1741365302933; 
 Fri, 07 Mar 2025 08:35:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtllXKt2QrHhuLxteIQwsN0HNsYbtqjiKP2dFoKTMFQuV4O9M+CNqniL+v0SKagNnSFrkirFOCRuIDH+sMn88=
X-Received: by 2002:a05:6000:1864:b0:391:39ea:7866 with SMTP id
 ffacd0b85a97d-39139ea7d93mr822751f8f.19.1741365302610; Fri, 07 Mar 2025
 08:35:02 -0800 (PST)
MIME-Version: 1.0
References: <20250307151703.2564073-1-alex.bennee@linaro.org>
In-Reply-To: <20250307151703.2564073-1-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 7 Mar 2025 17:34:50 +0100
X-Gm-Features: AQ5f1Jpj03e9JbLOV0MHvQ0WOFMSGQ5A0GDnQUmYzrv0JXLL4ufAtPfW_Q26G0I
Message-ID: <CABgObfZjftWtFcp6soMijA2mfKTnnh7Oq85oGkMCJf=fjajLaw@mail.gmail.com>
Subject: Re: [PATCH v4] meson.build: default to -gsplit-dwarf for debug info
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000049611a062fc334f3"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

--00000000000049611a062fc334f3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il ven 7 mar 2025, 16:17 Alex Benn=C3=A9e <alex.bennee@linaro.org> ha scrit=
to:

> This option is supported by both gcc (since 4.7) and clang (since
> 7.0). Not only does this make the linkers job easier by reducing the
> amount of ELF it needs to parse it also reduces the total build size
> quite considerably. In my case a default build went from 5.8G to
> 3.9G (vs 1.9G for --disable-debug-info).
>
> The --disable-split-debug option allows distros to keep all the info
> together for ease of packaging.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>

Queued, thanks.

Paolo


> ---
> v1
>   - add --disable/enable-split-debug
>   - move to option_cflags
> v2
>   - removed unneeded []'s
>   - fix stray whitespace
> v3
>   - set qemu_cflags instead of option_cflags
>   - move up to the rest of the qemu_cflag setting code
>   - update build size numbers with --disable-debug-info
> v4
>   - we don't need to pass -g, due to meson doing it under the hood
>   - add comment around option_cflags to make mesons roll clear
> ---
>  meson.build                   | 6 ++++++
>  meson_options.txt             | 2 ++
>  scripts/meson-buildoptions.sh | 2 ++
>  3 files changed, 10 insertions(+)
>
> diff --git a/meson.build b/meson.build
> index 8d0abe7f12..a8db76fccc 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -601,6 +601,10 @@ if get_option('tsan')
>    qemu_ldflags =3D ['-fsanitize=3Dthread'] + qemu_ldflags
>  endif
>
> +if get_option('debug') and get_option('split_debug')
> +  qemu_cflags +=3D '-gsplit-dwarf'
> +endif
> +
>  # Detect support for PT_GNU_RELRO + DT_BIND_NOW.
>  # The combination is known as "full relro", because .got.plt is read-onl=
y
> too.
>  qemu_ldflags +=3D cc.get_supported_link_arguments('-Wl,-z,relro',
> '-Wl,-z,now')
> @@ -4589,6 +4593,8 @@ if have_rust
>    summary_info +=3D {'bindgen':         bindgen.full_path()}
>    summary_info +=3D {'bindgen version': bindgen.version()}
>  endif
> +# option_cflags is purely for the summary display, meson will pass
> +# -g/-O options directly
>  option_cflags =3D (get_option('debug') ? ['-g'] : [])
>  if get_option('optimization') !=3D 'plain'
>    option_cflags +=3D ['-O' + get_option('optimization')]
> diff --git a/meson_options.txt b/meson_options.txt
> index 59d973bca0..3432123fee 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -362,6 +362,8 @@ option('debug_mutex', type: 'boolean', value: false,
>         description: 'mutex debugging support')
>  option('debug_stack_usage', type: 'boolean', value: false,
>         description: 'measure coroutine stack usage')
> +option('split_debug', type: 'boolean', value: true,
> +       description: 'split debug info from object files')
>  option('qom_cast_debug', type: 'boolean', value: true,
>         description: 'cast debugging support')
>  option('slirp_smbd', type : 'feature', value : 'auto',
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.s=
h
> index 3e8e00852b..aca6e68830 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -504,6 +504,8 @@ _meson_option_parse() {
>      --disable-strict-rust-lints) printf "%s" -Dstrict_rust_lints=3Dfalse=
 ;;
>      --enable-strip) printf "%s" -Dstrip=3Dtrue ;;
>      --disable-strip) printf "%s" -Dstrip=3Dfalse ;;
> +    --enable-split-debug) printf "%s" -Dsplit_debug=3Dtrue ;;
> +    --disable-split-debug) printf "%s" -Dsplit_debug=3Dfalse ;;
>      --sysconfdir=3D*) quote_sh "-Dsysconfdir=3D$2" ;;
>      --enable-tcg) printf "%s" -Dtcg=3Denabled ;;
>      --disable-tcg) printf "%s" -Dtcg=3Ddisabled ;;
> --
> 2.39.5
>
>

--00000000000049611a062fc334f3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il ven 7 mar 2025, 16:17 Alex Be=
nn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro.=
org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">This option is supported by both gcc (since 4.7) and clang (since<b=
r>
7.0). Not only does this make the linkers job easier by reducing the<br>
amount of ELF it needs to parse it also reduces the total build size<br>
quite considerably. In my case a default build went from 5.8G to<br>
3.9G (vs 1.9G for --disable-debug-info).<br>
<br>
The --disable-split-debug option allows distros to keep all the info<br>
together for ease of packaging.<br>
<br>
Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.or=
g" target=3D"_blank" rel=3D"noreferrer">alex.bennee@linaro.org</a>&gt;<br>
Reviewed-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.=
com" target=3D"_blank" rel=3D"noreferrer">berrange@redhat.com</a>&gt;<br></=
blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Queued=
, thanks.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo=C2=A0</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote =
gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
---<br>
v1<br>
=C2=A0 - add --disable/enable-split-debug<br>
=C2=A0 - move to option_cflags<br>
v2<br>
=C2=A0 - removed unneeded []&#39;s<br>
=C2=A0 - fix stray whitespace<br>
v3<br>
=C2=A0 - set qemu_cflags instead of option_cflags<br>
=C2=A0 - move up to the rest of the qemu_cflag setting code<br>
=C2=A0 - update build size numbers with --disable-debug-info<br>
v4<br>
=C2=A0 - we don&#39;t need to pass -g, due to meson doing it under the hood=
<br>
=C2=A0 - add comment around option_cflags to make mesons roll clear<br>
---<br>
=C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 6 ++++++<br>
=C2=A0meson_options.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 =
++<br>
=C2=A0scripts/meson-buildoptions.sh | 2 ++<br>
=C2=A03 files changed, 10 insertions(+)<br>
<br>
diff --git a/meson.build b/meson.build<br>
index 8d0abe7f12..a8db76fccc 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -601,6 +601,10 @@ if get_option(&#39;tsan&#39;)<br>
=C2=A0 =C2=A0qemu_ldflags =3D [&#39;-fsanitize=3Dthread&#39;] + qemu_ldflag=
s<br>
=C2=A0endif<br>
<br>
+if get_option(&#39;debug&#39;) and get_option(&#39;split_debug&#39;)<br>
+=C2=A0 qemu_cflags +=3D &#39;-gsplit-dwarf&#39;<br>
+endif<br>
+<br>
=C2=A0# Detect support for PT_GNU_RELRO + DT_BIND_NOW.<br>
=C2=A0# The combination is known as &quot;full relro&quot;, because .got.pl=
t is read-only too.<br>
=C2=A0qemu_ldflags +=3D cc.get_supported_link_arguments(&#39;-Wl,-z,relro&#=
39;, &#39;-Wl,-z,now&#39;)<br>
@@ -4589,6 +4593,8 @@ if have_rust<br>
=C2=A0 =C2=A0summary_info +=3D {&#39;bindgen&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0bindgen.full_path()}<br>
=C2=A0 =C2=A0summary_info +=3D {&#39;bindgen version&#39;: bindgen.version(=
)}<br>
=C2=A0endif<br>
+# option_cflags is purely for the summary display, meson will pass<br>
+# -g/-O options directly<br>
=C2=A0option_cflags =3D (get_option(&#39;debug&#39;) ? [&#39;-g&#39;] : [])=
<br>
=C2=A0if get_option(&#39;optimization&#39;) !=3D &#39;plain&#39;<br>
=C2=A0 =C2=A0option_cflags +=3D [&#39;-O&#39; + get_option(&#39;optimizatio=
n&#39;)]<br>
diff --git a/meson_options.txt b/meson_options.txt<br>
index 59d973bca0..3432123fee 100644<br>
--- a/meson_options.txt<br>
+++ b/meson_options.txt<br>
@@ -362,6 +362,8 @@ option(&#39;debug_mutex&#39;, type: &#39;boolean&#39;, =
value: false,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 description: &#39;mutex debugging support&#39;)=
<br>
=C2=A0option(&#39;debug_stack_usage&#39;, type: &#39;boolean&#39;, value: f=
alse,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 description: &#39;measure coroutine stack usage=
&#39;)<br>
+option(&#39;split_debug&#39;, type: &#39;boolean&#39;, value: true,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0description: &#39;split debug info from object =
files&#39;)<br>
=C2=A0option(&#39;qom_cast_debug&#39;, type: &#39;boolean&#39;, value: true=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 description: &#39;cast debugging support&#39;)<=
br>
=C2=A0option(&#39;slirp_smbd&#39;, type : &#39;feature&#39;, value : &#39;a=
uto&#39;,<br>
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh<=
br>
index 3e8e00852b..aca6e68830 100644<br>
--- a/scripts/meson-buildoptions.sh<br>
+++ b/scripts/meson-buildoptions.sh<br>
@@ -504,6 +504,8 @@ _meson_option_parse() {<br>
=C2=A0 =C2=A0 =C2=A0--disable-strict-rust-lints) printf &quot;%s&quot; -Dst=
rict_rust_lints=3Dfalse ;;<br>
=C2=A0 =C2=A0 =C2=A0--enable-strip) printf &quot;%s&quot; -Dstrip=3Dtrue ;;=
<br>
=C2=A0 =C2=A0 =C2=A0--disable-strip) printf &quot;%s&quot; -Dstrip=3Dfalse =
;;<br>
+=C2=A0 =C2=A0 --enable-split-debug) printf &quot;%s&quot; -Dsplit_debug=3D=
true ;;<br>
+=C2=A0 =C2=A0 --disable-split-debug) printf &quot;%s&quot; -Dsplit_debug=
=3Dfalse ;;<br>
=C2=A0 =C2=A0 =C2=A0--sysconfdir=3D*) quote_sh &quot;-Dsysconfdir=3D$2&quot=
; ;;<br>
=C2=A0 =C2=A0 =C2=A0--enable-tcg) printf &quot;%s&quot; -Dtcg=3Denabled ;;<=
br>
=C2=A0 =C2=A0 =C2=A0--disable-tcg) printf &quot;%s&quot; -Dtcg=3Ddisabled ;=
;<br>
-- <br>
2.39.5<br>
<br>
</blockquote></div></div></div>

--00000000000049611a062fc334f3--


