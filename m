Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5085CD206AC
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 07:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0ypM-0002XC-Vt; Wed, 16 Oct 2024 03:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0ypI-0002Wf-SW
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 03:52:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0ypF-00007V-5i
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 03:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729065127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4pjJL3TzOmqSg8OzsBffwHo8tSAJmrGgrN5gd4FR9/c=;
 b=ArUiUNK2dpr/yHJ9DevSfPmXSTXXhzh8R4w0UGk7deSMUsV9PNkuxyGOdNlE1i2aVR+ru8
 j8SluOnSWWS9HjL5DYv5J5VPQN8/iO+d3jvMXPTGn93B93dBitvUkrlnr8m3C19jVx6kEc
 qdP5eN9mC4SI4nDaNS4Yj2KmzFpXGIM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-tmIbimiVPUCi23e1cg7ifA-1; Wed, 16 Oct 2024 03:52:05 -0400
X-MC-Unique: tmIbimiVPUCi23e1cg7ifA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d531a19a9so2482589f8f.1
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 00:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729065123; x=1729669923;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4pjJL3TzOmqSg8OzsBffwHo8tSAJmrGgrN5gd4FR9/c=;
 b=C3I5iWsGaWmrxh+7LzjInFAez+HzBgdakzyZBIa1Wwu5dBBhWaNdPDHuDCVWtVSUXn
 0Bh9OEYT1/WYFlICSk6bE83EC0vWoXtY/a5hJhvzHffmFlePTtw1NgOZZ1rbcejiAqeP
 yVkHfU+X+EkF1Ey6Y+4QJtlGuRl1nGh1vzZeKLuevLIU5ZEqWQY4KP/nCmvcSgAEFvIw
 01Pk2L4ciPfk63XqfmA6ZSoSCulLMeV7DeC+C1v+7V4oE9Eln7TDbc6fT3XmC/eVbSQj
 hiBwxGt1V0kek5iLNTcrc4FeRzKPLEDYpb/jiQaU6yYhHDf4qSBQZUZe3MIQdKZN7eb3
 nBQA==
X-Gm-Message-State: AOJu0YxWG4XVw2bBBjVjcPn7M/Me3h1fy209epMyw5wcdBhLQdaLLLyW
 jmhlZNCDYuAevneW64RaId1PEoEQzf6lMa0Zl+v+Z/MsMDGkvraokZaEnYIIeEaj5lBw9dcnPUn
 zhPMkg5CHR7yPnR1SxlfDCstJJdv3G/vkaSYQZglPPY1orF3HK6TV0YQ6hzYzxNVpNzIW2qRhOO
 MaoHa83ynvEqmphPbRa0C8zNK6zdQLMGG41asGpw==
X-Received: by 2002:a05:6000:194f:b0:37d:4e03:ff8e with SMTP id
 ffacd0b85a97d-37d551fc0bbmr12087404f8f.28.1729065123313; 
 Wed, 16 Oct 2024 00:52:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRINVcCWmCf6hRLQF9QZcJ/vX0kN8PSxzLvWNDi035m1fL8DvC7rW9pK4oS1j/DpsrDGX6VlQOYhmiGY35EWY=
X-Received: by 2002:a05:6000:194f:b0:37d:4e03:ff8e with SMTP id
 ffacd0b85a97d-37d551fc0bbmr12087386f8f.28.1729065122719; Wed, 16 Oct 2024
 00:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <20241015131735.518771-1-pbonzini@redhat.com>
 <20241015131735.518771-13-pbonzini@redhat.com>
 <SY0P300MB102670D06E55A6B463CD1BDA95462@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
In-Reply-To: <SY0P300MB102670D06E55A6B463CD1BDA95462@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 16 Oct 2024 09:51:51 +0200
Message-ID: <CABgObfbqhmr=45c9ZiYoDAanM7Gsinz4RnwGMrivYDQgzP8kTw@mail.gmail.com>
Subject: Re: [PATCH 12/16] rust: allow version 1.63.0 of rustc
To: Junjie Mao <junjie.mao@hotmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000006efefd0624935881"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--0000000000006efefd0624935881
Content-Type: text/plain; charset="UTF-8"

Il mer 16 ott 2024, 08:10 Junjie Mao <junjie.mao@hotmail.com> ha scritto:

> In my Ubuntu 22.04 environment (rustc 1.76.0 and bindgen 0.59.1 from
> apt) the feature `proc_macro_byte_character` is not yet stablized but
> used in proc-macro2. Downgrading proc-macro2 to 1.0.79 [1] and syn to
> 2.0.58 fixes that issue for me.
>

This is handled by patch 5. Try "meson subprojects update --reset".

Paolo

[1]
> https://github.com/drmingdrmer/openraft/commit/d496b6db4c6128d33f0f211165c08a7925cf20f7
>
> Here're my changes:
>
> diff --git a/subprojects/proc-macro2-1-rs.wrap
> b/subprojects/proc-macro2-1-rs.wrap
> index 7053e2c013..d5713b45d7 100644
> --- a/subprojects/proc-macro2-1-rs.wrap
> +++ b/subprojects/proc-macro2-1-rs.wrap
> @@ -1,7 +1,7 @@
>  [wrap-file]
> -directory = proc-macro2-1.0.84
> -source_url = https://crates.io/api/v1/crates/proc-macro2/1.0.84/download
> -source_filename
> <https://crates.io/api/v1/crates/proc-macro2/1.0.84/download-source_filename>
> = proc-macro2-1.0.84.0.tar.gz
> -source_hash =
> ec96c6a92621310b51366f1e28d05ef11489516e93be030060e5fc12024a49d6
> +directory = proc-macro2-1.0.79
> +source_url = https://crates.io/api/v1/crates/proc-macro2/1.0.79/download
> +source_filename = proc-macro2-1.0.79.0.tar.gz
> +source_hash =
> e835ff2298f5721608eb1a980ecaee1aef2c132bf95ecc026a11b7bf3c01c02e
>  #method = cargo
>  patch_directory = proc-macro2-1-rs
> diff --git a/subprojects/syn-2-rs.wrap b/subprojects/syn-2-rs.wrap
> index 13ffdac3c3..9d413a0c57 100644
> --- a/subprojects/syn-2-rs.wrap
> +++ b/subprojects/syn-2-rs.wrap
> @@ -1,7 +1,7 @@
>  [wrap-file]
> -directory = syn-2.0.66
> -source_url = https://crates.io/api/v1/crates/syn/2.0.66/download
> -source_filename
> <https://crates.io/api/v1/crates/syn/2.0.66/download-source_filename> =
> syn-2.0.66.0.tar.gz
> -source_hash =
> c42f3f41a2de00b01c0aaad383c5a45241efc8b2d1eda5661812fda5f3cdcff5
> +directory = syn-2.0.58
> +source_url = https://crates.io/api/v1/crates/syn/2.0.58/download
> +source_filename = syn-2.0.58.0.tar.gz
> +source_hash =
> 44cfb93f38070beee36b3fef7d4f5a16f27751d94b187b666a5cc5e9b0d30687
>  #method = cargo
>  patch_directory = syn-2-rs
>
> --
> Best Regards
> Junjie Mao
>
> >      if get_option('rust').enabled()
> > -      error('rustc version ' + rustc.version() + ' is unsupported:
> Please upgrade to at least 1.80.0')
> > +      error('rustc version ' + rustc.version() + ' is unsupported:
> Please upgrade to at least 1.63.0')
> >      else
> > -      warning('rustc version ' + rustc.version() + ' is unsupported:
> Disabling Rust compilation. Please upgrade to at least 1.80.0 to use Rust.')
> > +      warning('rustc version ' + rustc.version() + ' is unsupported:
> Disabling Rust compilation. Please upgrade to at least 1.63.0 to use Rust.')
> >        have_rust = false
> >      endif
> >    endif
>
>

--0000000000006efefd0624935881
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mer 16 ott 2024, 08:10 Junjie Mao &lt;<a href=3D"ma=
ilto:junjie.mao@hotmail.com">junjie.mao@hotmail.com</a>&gt; ha scritto:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">In my Ubuntu 22.04 =
environment (rustc 1.76.0 and bindgen 0.59.1 from<br>
apt) the feature `proc_macro_byte_character` is not yet stablized but<br>
used in proc-macro2. Downgrading proc-macro2 to 1.0.79 [1] and syn to<br>
2.0.58 fixes that issue for me.<br></blockquote></div></div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">This is handled by patch 5. Try &quot;meson =
subprojects update --reset&quot;.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cla=
ss=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
[1] <a href=3D"https://github.com/drmingdrmer/openraft/commit/d496b6db4c612=
8d33f0f211165c08a7925cf20f7" rel=3D"noreferrer noreferrer" target=3D"_blank=
">https://github.com/drmingdrmer/openraft/commit/d496b6db4c6128d33f0f211165=
c08a7925cf20f7</a><br>
<br>
Here&#39;re my changes:<br>
<br>
diff --git a/subprojects/proc-macro2-1-rs.wrap b/subprojects/proc-macro2-1-=
rs.wrap<br>
index 7053e2c013..d5713b45d7 100644<br>
--- a/subprojects/proc-macro2-1-rs.wrap<br>
+++ b/subprojects/proc-macro2-1-rs.wrap<br>
@@ -1,7 +1,7 @@<br>
=C2=A0[wrap-file]<br>
-directory =3D proc-macro2-1.0.84<br>
-source_url =3D <a href=3D"https://crates.io/api/v1/crates/proc-macro2/1.0.=
84/download-source_filename" rel=3D"noreferrer noreferrer" target=3D"_blank=
">https://crates.io/api/v1/crates/proc-macro2/1.0.84/download<br>
-source_filename</a> =3D proc-macro2-1.0.84.0.tar.gz<br>
-source_hash =3D ec96c6a92621310b51366f1e28d05ef11489516e93be030060e5fc1202=
4a49d6<br>
+directory =3D proc-macro2-1.0.79<br>
+source_url =3D <a href=3D"https://crates.io/api/v1/crates/proc-macro2/1.0.=
79/download" rel=3D"noreferrer noreferrer" target=3D"_blank">https://crates=
.io/api/v1/crates/proc-macro2/1.0.79/download</a><br>
+source_filename =3D proc-macro2-1.0.79.0.tar.gz<br>
+source_hash =3D e835ff2298f5721608eb1a980ecaee1aef2c132bf95ecc026a11b7bf3c=
01c02e<br>
=C2=A0#method =3D cargo<br>
=C2=A0patch_directory =3D proc-macro2-1-rs<br>
diff --git a/subprojects/syn-2-rs.wrap b/subprojects/syn-2-rs.wrap<br>
index 13ffdac3c3..9d413a0c57 100644<br>
--- a/subprojects/syn-2-rs.wrap<br>
+++ b/subprojects/syn-2-rs.wrap<br>
@@ -1,7 +1,7 @@<br>
=C2=A0[wrap-file]<br>
-directory =3D syn-2.0.66<br>
-source_url =3D <a href=3D"https://crates.io/api/v1/crates/syn/2.0.66/downl=
oad-source_filename" rel=3D"noreferrer noreferrer" target=3D"_blank">https:=
//crates.io/api/v1/crates/syn/2.0.66/download<br>
-source_filename</a> =3D syn-2.0.66.0.tar.gz<br>
-source_hash =3D c42f3f41a2de00b01c0aaad383c5a45241efc8b2d1eda5661812fda5f3=
cdcff5<br>
+directory =3D syn-2.0.58<br>
+source_url =3D <a href=3D"https://crates.io/api/v1/crates/syn/2.0.58/downl=
oad" rel=3D"noreferrer noreferrer" target=3D"_blank">https://crates.io/api/=
v1/crates/syn/2.0.58/download</a><br>
+source_filename =3D syn-2.0.58.0.tar.gz<br>
+source_hash =3D 44cfb93f38070beee36b3fef7d4f5a16f27751d94b187b666a5cc5e9b0=
d30687<br>
=C2=A0#method =3D cargo<br>
=C2=A0patch_directory =3D syn-2-rs<br>
<br>
--<br>
Best Regards<br>
Junjie Mao<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if get_option(&#39;rust&#39;).enabled()<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 error(&#39;rustc version &#39; + rustc.version()=
 + &#39; is unsupported: Please upgrade to at least 1.80.0&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 error(&#39;rustc version &#39; + rustc.version()=
 + &#39; is unsupported: Please upgrade to at least 1.63.0&#39;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 else<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 warning(&#39;rustc version &#39; + rustc.version=
() + &#39; is unsupported: Disabling Rust compilation. Please upgrade to at=
 least 1.80.0 to use Rust.&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 warning(&#39;rustc version &#39; + rustc.version=
() + &#39; is unsupported: Disabling Rust compilation. Please upgrade to at=
 least 1.63.0 to use Rust.&#39;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 have_rust =3D false<br>
&gt;=C2=A0 =C2=A0 =C2=A0 endif<br>
&gt;=C2=A0 =C2=A0 endif<br>
<br>
</blockquote></div></div></div>

--0000000000006efefd0624935881--


