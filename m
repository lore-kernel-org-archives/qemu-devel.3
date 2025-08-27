Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0C5CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 05:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur8pi-000475-Q5; Wed, 27 Aug 2025 01:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ur8pf-00045y-VU
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 01:36:28 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ur8pb-0006Ww-TA
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 01:36:27 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-61cb4370e7bso499881a12.3
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 22:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756272980; x=1756877780; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XWjpvW4nGcyMMq97r7sdMDBa3Xrnx37bVQFmRrJB7ks=;
 b=VYsk95ESLWu01/a8e9zcqSlzq7tRyZ2WPWKJdammoppfPv2qcd0n5+0BMIb2cPXqIR
 Hj2SXVbOgMB9qr75TqpbAak3D3BQWiHwhTSFKeoGw7SKEAH9fW9lLuLWdCbFV9wx0yrO
 Tuhl+1kILC8Rs/DrqO8WS6mOFBB9oaiJPLAstryfvewFJJIDTO70nR9+iXn0Bfb9r9zc
 vMa+oKEj6itxrcD1z+cubg2F2PtFuxSulEtCEnBbwy1ZtyYOopIhlNfsLuIZQJYFayBr
 Q1ww5/4KB/hdTDU2jsxYtZoUuTC0r1oq5+PKjNJvUXXqI/tAYbTFR2CDmNDPpe8sT30Z
 TjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756272980; x=1756877780;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XWjpvW4nGcyMMq97r7sdMDBa3Xrnx37bVQFmRrJB7ks=;
 b=YMDm/hIEdibqdzDQ2XBcR8ijnm75mPFI4Gc4Zfx1ClK83+JB+ayDUhi+L+asKxIN+N
 IyuAn+qsMZaZWU5Mnl+cUu9b07wdsH5yyXr34QFTFQqmu5J6ZvNnGRe1yaMGC/Tn8fq8
 Bs3tA3onCTzEYH8a7nBsaV77eQYphf93BDnJg6ba8jKSD+iGcKYHHgA43OfCIda/QgyE
 KHgQLOGBAtOklkx/T+KD9Ocp5/0lNeN/bh6jGvRlBzS4Fo9w4YASbi8CoD7RXsaMu7K+
 0UCA7dIC/vBCm5gLD6hQ2D5jLXhQYPJROtaTMAMg6bEWwXBljkOiHzZM8UCMbuFqYxNA
 AS/w==
X-Gm-Message-State: AOJu0Yz8or4Ol6QCMaepkMOKwxSJI1cTy8cylT0GARB07PhNFuWKdHlc
 eat661kir7LpnD5PkdznXyUDr55wSg+IcasLp81eUhoNs+wSsoss6VqgRY3PeYzRSG/G0pWJWaM
 pqoRokfQaWhsy3d8ItvvFrmh4TMMxZIZW9a93pqG5VA==
X-Gm-Gg: ASbGnctRQlI4wwPRYsHtcoK/LHJkFIrUCmV1lTGu30lRFyVCZHGvDymryHHWACSuDmz
 y33FzAWbW+Jy6UiLcU6GWPO3a6Sx/Z1gJf5xqzUbGV2Y9cA46NArvY2+sjXDoXR2PqT9J/+EL8b
 MvrvZoBGRmaJB/Hb5w3ddsdwmiYjbCra3V9uJlZJP8riNDcrE3kEv+m8XiUv2sTkANUTGXjdz3r
 dGx/JiD
X-Google-Smtp-Source: AGHT+IFdoK4jDgQ+pLhv2mNE0XnG3GYYsGtDf4WsVrx9mkHvJ3JIFSlFVe+U64M7VLnTedC+D5bykVLAlKp7/hWLsYw=
X-Received: by 2002:a05:6402:270f:b0:61c:6968:d1a5 with SMTP id
 4fb4d7f45d1cf-61c6968e6b3mr7386563a12.25.1756272980491; Tue, 26 Aug 2025
 22:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250827001008.22112-1-gustavo.romero@linaro.org>
In-Reply-To: <20250827001008.22112-1-gustavo.romero@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 27 Aug 2025 08:35:53 +0300
X-Gm-Features: Ac12FXyGyrB3gRYj7azs_0b0wgiRExdAeYwqn_EqtzER5Q87RG3OkFtboNXSC3Y
Message-ID: <CAAjaMXZX9cCbYjpx4LJ+gzwKmqsEFraqXT75oZOLKN9dYOcKgw@mail.gmail.com>
Subject: Re: [PATCH] tests/functional: Fix reverse_debugging asset precaching
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com, 
 qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000021a8fa063d522bce"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--00000000000021a8fa063d522bce
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 3:12=E2=80=AFAM Gustavo Romero <gustavo.romero@lina=
ro.org>
wrote:
>
> This commit fixes the asset precaching in the reverse_debugging test on
> aarch64.
>
> QemuBaseTest.main() precaches assets (kernel, rootfs, DT blobs, etc.)
> that are defined in variables with the ASSET_ prefix. This works because
> it ultimately calls Asset.precache_test(), which relies on introspection
> to locate these variables.
>
> If an asset variable is not named with the ASSET_ prefix, precache_test
> cannot find the asset and precaching silently fails. Hence, fix the
> asset precaching by fixing the asset variable name.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  tests/functional/test_aarch64_reverse_debug.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/functional/test_aarch64_reverse_debug.py
b/tests/functional/test_aarch64_reverse_debug.py
> index 58d4532835..8bc91ccfde 100755
> --- a/tests/functional/test_aarch64_reverse_debug.py
> +++ b/tests/functional/test_aarch64_reverse_debug.py
> @@ -21,7 +21,7 @@ class ReverseDebugging_AArch64(ReverseDebugging):
>
>      REG_PC =3D 32
>
> -    KERNEL_ASSET =3D Asset(
> +    ASSET_KERNEL =3D Asset(
>          ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
>           'releases/29/Everything/aarch64/os/images/pxeboot/vmlinuz'),
>
 '7e1430b81c26bdd0da025eeb8fbd77b5dc961da4364af26e771bd39f379cbbf7')
> @@ -30,7 +30,7 @@ class ReverseDebugging_AArch64(ReverseDebugging):
>      def test_aarch64_virt(self):
>          self.set_machine('virt')
>          self.cpu =3D 'cortex-a53'
> -        kernel_path =3D self.KERNEL_ASSET.fetch()
> +        kernel_path =3D self.ASSET_KERNEL.fetch()
>          self.reverse_debugging(args=3D('-kernel', kernel_path))
>
>
> --
> 2.34.1
>
>

--00000000000021a8fa063d522bce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Wed, Aug 27, 2025 at 3:12=E2=80=AFAM Gustavo Ro=
mero &lt;<a href=3D"mailto:gustavo.romero@linaro.org">gustavo.romero@linaro=
.org</a>&gt; wrote:<br>&gt;<br>&gt; This commit fixes the asset precaching =
in the reverse_debugging test on<br>&gt; aarch64.<br>&gt;<br>&gt; QemuBaseT=
est.main() precaches assets (kernel, rootfs, DT blobs, etc.)<br>&gt; that a=
re defined in variables with the ASSET_ prefix. This works because<br>&gt; =
it ultimately calls Asset.precache_test(), which relies on introspection<br=
>&gt; to locate these variables.<br>&gt;<br>&gt; If an asset variable is no=
t named with the ASSET_ prefix, precache_test<br>&gt; cannot find the asset=
 and precaching silently fails. Hence, fix the<br>&gt; asset precaching by =
fixing the asset variable name.<br>&gt;<br>&gt; Signed-off-by: Gustavo Rome=
ro &lt;<a href=3D"mailto:gustavo.romero@linaro.org">gustavo.romero@linaro.o=
rg</a>&gt;<br><div>&gt; ---</div><div><br></div><div>Reviewed-by: Manos Pit=
sidianakis &lt;<a href=3D"mailto:manos.pitsidianakis@linaro.org" target=3D"=
_blank">manos.pitsidianakis@linaro.org</a>&gt;</div><div><br></div>&gt; =C2=
=A0tests/functional/test_aarch64_reverse_debug.py | 4 ++--<br>&gt; =C2=A01 =
file changed, 2 insertions(+), 2 deletions(-)<br>&gt;<br>&gt; diff --git a/=
tests/functional/test_aarch64_reverse_debug.py b/tests/functional/test_aarc=
h64_reverse_debug.py<br>&gt; index 58d4532835..8bc91ccfde 100755<br>&gt; --=
- a/tests/functional/test_aarch64_reverse_debug.py<br>&gt; +++ b/tests/func=
tional/test_aarch64_reverse_debug.py<br>&gt; @@ -21,7 +21,7 @@ class Revers=
eDebugging_AArch64(ReverseDebugging):<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A0R=
EG_PC =3D 32<br>&gt;<br>&gt; - =C2=A0 =C2=A0KERNEL_ASSET =3D Asset(<br>&gt;=
 + =C2=A0 =C2=A0ASSET_KERNEL =3D Asset(<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0(&#39;<a href=3D"https://archives.fedoraproject.org/pub/archive/fedo=
ra/linux/">https://archives.fedoraproject.org/pub/archive/fedora/linux/</a>=
&#39;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;releases/29/Everythin=
g/aarch64/os/images/pxeboot/vmlinuz&#39;),<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&#39;7e1430b81c26bdd0da025eeb8fbd77b5dc961da4364af26e771bd39f379c=
bbf7&#39;)<br>&gt; @@ -30,7 +30,7 @@ class ReverseDebugging_AArch64(Reverse=
Debugging):<br>&gt; =C2=A0 =C2=A0 =C2=A0def test_aarch64_virt(self):<br>&gt=
; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.set_machine(&#39;virt&#39;)<br>&gt=
; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.cpu =3D &#39;cortex-a53&#39;<br>&g=
t; - =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_path =3D self.KERNEL_ASSET.fetch()<b=
r>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel_path =3D self.ASSET_KERNEL.fetch=
()<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.reverse_debugging(args=3D=
(&#39;-kernel&#39;, kernel_path))<br>&gt;<br>&gt;<br>&gt; --<br>&gt; 2.34.1=
<br>&gt;<br>&gt;<br></div>

--00000000000021a8fa063d522bce--

