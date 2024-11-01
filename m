Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 999DFE6F06C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 15:31:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6tbw-0001PN-4j; Fri, 01 Nov 2024 11:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6tbu-0001Ox-OI
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 11:30:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6tbs-0003Xt-65
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 11:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730475043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3lfwdotJ8PS1vtQC6/LpcXLJdqm3/JvvR9uQJwNBSyA=;
 b=c/crbBx+pOd5nzjK+1bLNoQBzWye0Uq4VoKxnk64ICdFve87No7/pklfU5ClMo4CBg9jEl
 OgQNoIRS/AefDVRK86jwUehm8011L+cdSbUFDX2j7GQNZRVIKMvVSq8GrDRucqPcSPbEKF
 FlUMXNEM6MvDmlbEj5xTraCzApweEG0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-bMsNignfM5az4cdS3ZZCPA-1; Fri, 01 Nov 2024 11:30:41 -0400
X-MC-Unique: bMsNignfM5az4cdS3ZZCPA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d589138a9so904486f8f.1
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 08:30:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730475040; x=1731079840;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3lfwdotJ8PS1vtQC6/LpcXLJdqm3/JvvR9uQJwNBSyA=;
 b=gRH2BEFk5AiwNUc3Duwoj8aeA1e72dZT55l+qfk0xyfDLLt4EcDqxmN8Ko2MVNVCii
 o4mqsih/Sm+FlgHBArmDXUxgeM5MXK0WqspuWcjBERJaaJJWRnSuXGXt4sODYhjrCctp
 GNNi9JOYOhCVncnp36xMk+ZJgQqOxCWYPRul/Wod/7TMEJFcPA6Y4bRd2r9RFKoUbJ4m
 jV7O5afQEGjkZB4yns7r/uOw5BVbEaUnZYe4LuMxBgvfecaC7gF2Ra9gSz2H9gLAgKcO
 naca7lOpmkyYtibYZ+9BHF4sZcIlRXje+O692OphM2mYZbMuZXfLp23HYfNxEZQ2J0fI
 n3zA==
X-Gm-Message-State: AOJu0YwrB6vHbfNFTfi5Pz6NGyNPvX38n53EYUSGpmtRJlofZtklxyuL
 QN2d4T0l3ikqjt2lfxVtiS2oUS9C+Slaako2rWUKOksOpLYXyHDJq2ZNJ5NXHGMCf5XuhVJTXVf
 vBufjigy5fuMwoxSwTcT6wDzJmuYblrj7u4q1np//1XlQnXRPkhWM5g+Bu9EW06I0ysoBwWGaG6
 v4PcKPrKh0eQwLoy3NE1+pVZcAJmQ=
X-Received: by 2002:a5d:6946:0:b0:37c:d2f0:7331 with SMTP id
 ffacd0b85a97d-38060fff529mr17384063f8f.0.1730475040624; 
 Fri, 01 Nov 2024 08:30:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwEJkVDQTwUqqRbaswsLECo6fa7hHeG0EO8Wj2VAr1USq97rGbz3hG73NVCiKW4CPrtAYIhvpId21F5cK+QwQ=
X-Received: by 2002:a5d:6946:0:b0:37c:d2f0:7331 with SMTP id
 ffacd0b85a97d-38060fff529mr17384048f8f.0.1730475040307; Fri, 01 Nov 2024
 08:30:40 -0700 (PDT)
MIME-Version: 1.0
References: <20241025160209.194307-1-pbonzini@redhat.com>
 <20241025160209.194307-14-pbonzini@redhat.com>
 <ME0P300MB1040C0B24C8ED1775CB0673795562@ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM>
In-Reply-To: <ME0P300MB1040C0B24C8ED1775CB0673795562@ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 1 Nov 2024 16:30:28 +0100
Message-ID: <CABgObfZKK4UYgox3sYfOG8a9fCS+h9ouLCwydgq1TQfEoc4t9Q@mail.gmail.com>
Subject: Re: [PATCH 13/23] rust: synchronize dependencies between subprojects
 and Cargo.lock
To: Junjie Mao <junjie.mao@hotmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, 
 "P. Berrange, Daniel" <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000012169e0625db9edc"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

--00000000000012169e0625db9edc
Content-Type: text/plain; charset="UTF-8"

Il ven 1 nov 2024, 11:21 Junjie Mao <junjie.mao@hotmail.com> ha scritto:

> How about specifying also the exact version in Cargo.toml, e.g.:
>
>  [dependencies]
> -proc-macro2 = "1"
> -quote = "1"
> -syn = { version = "2", features = ["extra-traits"] }
> +proc-macro2 = "=1.0.84"
> +quote = "=1.0.36"
> +syn = { version = "=2.0.66", features = ["extra-traits"] }
>
>
Unfortunately, versions of nested dependencies, such as either and
> unicode-ident, may still have newer patch versions after a lockfile
> regeneration. That can be worked around by turning nested dependencies
> to direct ones with fixed version constraints, but looks quite ugly.
>

Yeah, that's the reason why I didn't do it... Since we don't have any
security-sensitive dependencies, changes to the lock files are going to be
rare and it's easier to just look at them more closely.

Paolo

--
> Best Regards
> Junjie Mao
>
>

--00000000000012169e0625db9edc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il ven 1 nov 2024, 11:21 Junjie Mao &lt;<a href=3D"mai=
lto:junjie.mao@hotmail.com">junjie.mao@hotmail.com</a>&gt; ha scritto:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">How about specifying=
 also the exact version in Cargo.toml, e.g.:<br>
<br>=C2=A0[dependencies]<br>
-proc-macro2 =3D &quot;1&quot;<br>
-quote =3D &quot;1&quot;<br>
-syn =3D { version =3D &quot;2&quot;, features =3D [&quot;extra-traits&quot=
;] }<br>
+proc-macro2 =3D &quot;=3D1.0.84&quot;<br>
+quote =3D &quot;=3D1.0.36&quot;<br>
+syn =3D { version =3D &quot;=3D2.0.66&quot;, features =3D [&quot;extra-tra=
its&quot;] }<br>=C2=A0<br></blockquote></div></div><div dir=3D"auto"><div c=
lass=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Unfo=
rtunately, versions of nested dependencies, such as either and<br>
unicode-ident, may still have newer patch versions after a lockfile<br>
regeneration. That can be worked around by turning nested dependencies<br>
to direct ones with fixed version constraints, but looks quite ugly.<br></b=
lockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Yeah, t=
hat&#39;s the reason why I didn&#39;t do it... Since we don&#39;t have any =
security-sensitive dependencies, changes to the lock files are going to be =
rare and it&#39;s easier to just look at them more closely.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
--<br>
Best Regards<br>
Junjie Mao<br>
<br>
</blockquote></div></div></div>

--00000000000012169e0625db9edc--


