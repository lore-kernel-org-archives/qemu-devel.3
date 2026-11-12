Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D7E606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 11:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=abaUWxZG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRTLH-0007du-SK; Thu, 12 Nov 2026 06:51:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRTKh-0005L6-Qi
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 06:51:11 -0500
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRTKa-0003J8-CL
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 06:51:07 -0500
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-67be9601f31so4250728d50.3
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 03:51:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794484263; cv=none;
 d=google.com; s=arc-20260327;
 b=XEmMKk/cw4eULFVrnSDOqYp9mvBStm+9IQCABR+QSGCbaXx1ow2TetyptOeCMA1yDB
 Q00e7TN0HAKOYyniUqInjZqJ++3scNddezgwyLkEvse6twOsCogKIW0WZz7sR/ejkFNh
 nmpv6qde6dDiz/CrIxhcN4YyxyAil4+2OD7bv+wX/80uEP6/M2iIsS3tv0hv9a33f4YE
 JMHCQPIBg3YFY2fUtQMwBdKzU0ua6r2jdf8FUvho4eaM9VaVkofxtdZ9Z7G/lqkd40ZR
 ePz/dWFdUOjjCj56IWcmtG40FIjO/A5K57UGXS4ZkWhcBrAXP210/s640+UUMIkeAQds
 2ZkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Eq92dp7V42l6tWs0m/vtKLLV8TNAYBtM2Nh+ISG7lEk=;
 fh=F/FpjlXIj1KWEO85ewDjzuQZMTNXt786FkXtcC+rrkk=;
 b=YG4Pov6EJPh91rBjTPgWhLGtnVIlZ1HNS0b3Num1e2M+Lzpm/RjO8AocsmIpwDyVKK
 PCSAsIh8UdUWQlkNy5huHxq2SVVxuSxS+rF5/2/hv4APGCVz4B4JN0dE06gF8xvACmlC
 Q9t+z23P/VGV4kddwasv8d4z8vPI5Nm/NXPTVl9q7KmGJuPdiBlY4Iq8nyTN8/5T+t9u
 xaNVWzoh+dH6aZQL+d20/gaxHhpau3NPwVMvL2Qb1BBqQLIF1BLrxu2EaCc1RxDlF8hp
 Z+VZ+bULnxUkIHS4VU3vQ4uOy43RL4aHHt9MqAOkW5MuRFz2nSQEFkPrkpynsSE+Vis0
 37QA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794484263; x=1795089063; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Eq92dp7V42l6tWs0m/vtKLLV8TNAYBtM2Nh+ISG7lEk=;
 b=abaUWxZGkdqSFTroODKnHjdWcl3q6aMJh3+kMnnFQRfzT46HaElIcHAYj62Sz4BuU/
 xtcBivfhRuxkgh/q4UmOW8OFo/wBBHjc97QgjFBlBXxYV9P4BzhDMN1o7xSNyi97cnjq
 n+YIK+6BhETHGHh9PW4fPK6e3JeaTy7k1U15nKrjb8qp30KyMuuWL0VHv6/02N9F2V/U
 88HRnIz05S4VTFuSVGq5xg41neZWmbP4h1T+H5XSZONCA6vMILUT9kfAm9QUV9rI2f+J
 HMFgBEvt++r6/6Lem8NQPP6IjXNRradzUdRsjI4VqV3i7y/PNXJ+OqwYdrcsiGl7mT0a
 pLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794484263; x=1795089063;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Eq92dp7V42l6tWs0m/vtKLLV8TNAYBtM2Nh+ISG7lEk=;
 b=s+6CE0TKBzkNOU2F+ler1fV4wx5dgg79TzusOeZIg7ZVJxBMCRCKPdWSyBmKuPluKc
 6+WkKqGGvxcBl4GryPBlYHsnNjIUGlF/R5XlW3YF/6wqLHKzWMZ46Fb5pESQC9A6Bbbd
 2WrH/dwtQO2QRWBOda95/CbdW2YB/Dp0yMvpa9dC+G34SiYCGKYm6VJ61jjoyv6DDSX1
 l4ygBqqFh2+8y93K0078L3xv5wtn93b3oP47HrlxDuK0xN99DpJ/lL+LV8rcylhSRmnu
 vvlXY/3jHiSW6t5Hwf6fWOgsZtUSdW6OoLauAPFAzqf0i3Eigz9RQHyEtxPTcSde+IJm
 ry2w==
X-Gm-Message-State: APuU4Z+Z9ZRIe1xTcl+5qVXVUsFKQqCuQJ9tWBqVVfs8qKA7hAyqXF+n
 YMDqNC/JQuFDyRDiATcXBIGJJh9FgEhyIPEZozMractTY6PZB5wj3Y8oQ9jllnDOanuQ0B64jDe
 rkEPmkkIQu5fa0hP55466l982WurdOdkVN9rjNeRVFQ==
X-Gm-Gg: AYBFou3up2coel2tri9gRpEUVxVGWqdRtftYjkEelzj3Olmwg7/4MtYsypXkPPnTqBg
 VXQEY5zL5kcqj8rb6z00q5l97/z+h2gLkQibVI302KjRQOo7gVjMPxR7usXPhM3Z2kubL7AI8Ri
 kSGHdrSoD8ASBnzGrsmO5Mw/z/KscnmGccSbnJC81aNDqw9Q2OZ4pcXZhWp6BRdsz7TG7A2Dqnw
 yF0JTXujayw6PdOAqdhFnyNnIkSbCfVMDslfu1raghAfT57qzBBjm9k2BExQg2ZkjWs/5PkfZEY
 wUHIwuVrJHwnO1qqjUtNPc2/pIUSCQ0mf2cDe/9uhCXyw66Zfyky32uIVoBGLxQCWahO2F+XpeF
 XbtI5PPkiRBBLxO3Wh665OuBFsN9r61Pcp3QBnRUrvy/we1W24EO78yQXFpVpGkCymMX7Vctc3I
 um0iMDznlB/cuno8JdnCYu
X-Received: by 2002:a05:690e:80b:10b0:67c:271e:c29b with SMTP id
 956f58d0204a3-67c67eff337mr2342116d50.25.1794484262559; Thu, 12 Nov 2026
 03:51:02 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112112714.357297-2-marcandre.lureau@redhat.com>
In-Reply-To: <20261112112714.357297-2-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Nov 2026 11:50:51 +0000
X-Gm-Features: AclHuK8ObP32nVe1LDv1Oqf7-VStzQ4vRhOPRfUktTXKC4SCUfvv3mqKZhQzgF0
Message-ID: <CAFEAcA_wv2OKP+nV6ZuijL0j2LZ00Se48woVeS9xcmiaERHFTQ@mail.gmail.com>
Subject: Re: [PATCH] tests/functional: update tuxrun kernel hashes
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 12 Nov 2026 at 11:27, <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> tuxboot rebuilt the 6.18.54 kernels, so the recorded hashes no longer
> match and the tuxrun tests fail to fetch their assets. Update the
> kernel and vmlinux hashes for x86_64, arm64 and s390. The buildroot
> rootfs images are unchanged.
>
> We may want to go back to a fixed/time tagged version to avoid future
> breakage.

Yes, that seems like the right thing to me: the URLs without a datestamp
will change, but we want immutable ones so we don't have problems with
the test cases in stable branches. We're already doing that for the
rootfs URLs.

I've listed below the datestamp URLs for both the old and new images.
I guess I favour continuing to use the same (old) image rather than
implicitly updating to a new one, though it's not a big deal either way.

Fixes: 8ac1aab21fca ("tests/functional: update arm64 tuxrun images")
Fixes: 09961fafc5a0 ("tests/functional: update s390x tuxrun images")
Fixes: 467c9eb7dd31 ("tests/functional: update x86_64 tuxrun images")

We also have three riscv64 tests that refer to non-datestamp URLs:

tests/functional/riscv64/test_milkv_duo.py:
'https://storage.tuxboot.com/kernels/6.11.9/riscv64/Image',
tests/functional/riscv64/test_milkv_duo.py:
'https://storage.tuxboot.com/kernels/6.11.9/riscv64/dtbs.tar.xz',
tests/functional/riscv64/test_tt_atlantis.py:
'https://storage.tuxboot.com/kernels/6.11.9/riscv64/Image',
tests/functional/riscv64/test_tuxrun.py:
'https://storage.tuxboot.com/kernels/6.11.9/riscv64/Image',

These should all be using
 https://storage.tuxboot.com/kernels/20241122/6.11.9/riscv64/

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/functional/aarch64/test_tuxrun.py | 4 ++--
>  tests/functional/s390x/test_tuxrun.py   | 4 ++--
>  tests/functional/x86_64/test_tuxrun.py  | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/tests/functional/aarch64/test_tuxrun.py b/tests/functional/a=
arch64/test_tuxrun.py
> index 2ff321582d38..6c4367c8a20d 100755
> --- a/tests/functional/aarch64/test_tuxrun.py
> +++ b/tests/functional/aarch64/test_tuxrun.py
> @@ -18,10 +18,10 @@ class TuxRunAarch64Test(TuxRunBaselineTest):
>
>      ASSET_ARM64_KERNEL =3D Asset(
>          'https://storage.tuxboot.com/kernels/6.18.54/arm64/Image.gz',
> -        '39f4633bbcb444267d4d829bd28d8868a287c4c160cda64b0fd23fb090571c4=
e')
> +        'e297f12682af7e88735a0aae38e6fbd137192b516ab5f0fc1a81c4bcc3992e8=
0')

If we want to keep using the same image file:
https://storage.tuxboot.com/kernels/20260930/6.18.54/arm64/Image.gz

If we want to upgrade to the new one (with the e297... hash):
https://storage.tuxboot.com/kernels/20261110/6.18.54/arm64/Image.gz

(plus matching change to the vmlinux.xz URLs)

>      ASSET_ARM64_VMLINUX =3D Asset(
>          'https://storage.tuxboot.com/kernels/6.18.54/arm64/vmlinux.xz',
> -        '6487eb113ef6e841aedab6cb6fa704006377d68f64dd544570aa42f462a52b8=
5')
> +        'aa9b984337e975528162ed873cf18a072b27be8e4f48e6cf0723e9b490c6317=
1')
>      ASSET_ARM64_ROOTFS =3D Asset(
>          'https://storage.tuxboot.com/buildroot/20260924/arm64/rootfs.ext=
4.zst',
>          '4ab8cec9d1e17dbb1abdf2ae1939ad4f9d0dc2466230f6a119a7c1845cdef0b=
1')
> diff --git a/tests/functional/s390x/test_tuxrun.py b/tests/functional/s39=
0x/test_tuxrun.py
> index 1dd662aaaf05..be38fcded2e9 100755
> --- a/tests/functional/s390x/test_tuxrun.py
> +++ b/tests/functional/s390x/test_tuxrun.py
> @@ -18,10 +18,10 @@ class TuxRunS390xTest(TuxRunBaselineTest):
>
>      ASSET_S390X_KERNEL =3D Asset(
>          'https://storage.tuxboot.com/kernels/6.18.54/s390/bzImage',
> -        '5efeb31754b211440e1595ab11355bb006fe78a2c0604ed0a8c55c4598b71ae=
c')
> +        'b5022f97e243b8ecd51fc7ce4290a15806ecc51a41edbe777fc0fcdda567269=
e')

Old image:
https://storage.tuxboot.com/kernels/20260930/6.18.54/s390/bzImage

New one:
https://storage.tuxboot.com/kernels/20261110/6.18.54/s390/bzImage

(and ditot for the vmlinux.xz)

>      ASSET_S390X_VMLINUX =3D Asset(
>          'https://storage.tuxboot.com/kernels/6.18.54/s390/vmlinux.xz',
> -        '5bbd4d34e0950f88053a9bfd16078896df4b1ee1696fc2ad62488e681a6bdd8=
e')
> +        'cd70050ddb638e81c2f1b96a4629c224aedd36bf8ae3b56b264b070e94642e2=
5')
>      ASSET_S390X_ROOTFS =3D Asset(
>          'https://storage.tuxboot.com/buildroot/20260924/s390/rootfs.ext4=
.zst',
>          '5ba18c4d18831c50a0c743990f7bdee1d3b520629d423c55b668d8fbbac9c6f=
5')
> diff --git a/tests/functional/x86_64/test_tuxrun.py b/tests/functional/x8=
6_64/test_tuxrun.py
> index 1a1138d16aea..efe907bed820 100755
> --- a/tests/functional/x86_64/test_tuxrun.py
> +++ b/tests/functional/x86_64/test_tuxrun.py
> @@ -18,10 +18,10 @@ class TuxRunX86Test(TuxRunBaselineTest):
>
>      ASSET_X86_64_KERNEL =3D Asset(
>          'https://storage.tuxboot.com/kernels/6.18.54/x86_64/bzImage',
> -        '24a3ade610c2cc426ff821050de8a35930b0371357d94cc2c334abac6658552=
b')
> +        'ba98a8a07d5f3f3e20119341059c0f0096fda499d30e30049c1ea64553b7e7c=
2')

Old image:
https://storage.tuxboot.com/kernels/20260930/6.18.54/x86_64/bzImage
New image:
https://storage.tuxboot.com/kernels/20261110/6.18.54/x86_64/bzImage

(and similarly for vmlinux.xz)

>      ASSET_X86_64_VMLINUX =3D Asset(
>          'https://storage.tuxboot.com/kernels/6.18.54/x86_64/vmlinux.xz',
> -        '77bf44cca48c9c1b9c142e16a2311d58b8ae3462b61bce44bcaf9243b5f2662=
8')
> +        'bc8af37608753c6ba47c6fe85f4034188b5f15bb757a0cbd79672c65122278a=
b')
>      ASSET_X86_64_ROOTFS =3D Asset(
>          'https://storage.tuxboot.com/buildroot/20260924/x86_64/rootfs.ex=
t4.zst',
>          '8e310455b0244414ccff29c507f7ccfd4032e3587cc405e49ab0322738e3e27=
c')
> --
> 2.56.0.116.g6de20f6092dc

thanks
-- PMM

