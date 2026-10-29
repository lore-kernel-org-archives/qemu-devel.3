Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D695F606A322
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 16:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=cF44LIOe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMT9P-00089M-Cv; Thu, 29 Oct 2026 12:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMT9M-00088p-Hd
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 12:38:48 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMT9J-00034J-3G
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 12:38:46 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-8b0f59a5fdeso23314157b3.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 09:38:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793291924; cv=none;
 d=google.com; s=arc-20260327;
 b=fajlIamKKJPxrzUpaLmAcpeMgk7UCjd7Qz/EZMSj9xop+6kwTdXOVS8Da4oDdN3ha+
 ozP9JDAMuKmQMhJXPwUuSjipOWjEQRHazuAjVQPCMX5EWkA/ttBqTHjGc4CpW7E3gfDa
 7IbFD1BfuLhr1sACU0iCGciuzsrPhBCq/ZGafGUOvKjgfUscdp8q50g7XOZWgVr5OwhW
 lolYWFcao9br41sCLOqxxiIe4EGsEket6iCz+8V2pfEh+T5QDrgeYpmS1IywB+BZ8sqC
 dnwJUsH4Lr5eSK9+PGsuidP/y6KzY12EFTwB65nzCSlQ/gZWcK/rgLR7oFdVSpHRisYn
 3JPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DWmAgdQQCO6JUskQB0rVpaMUkzSXFhe8eRhGQeydCEM=;
 fh=/xuVeVT5nEkboe7DLhqTl3PbYarPcBPdBeGHptwONnQ=;
 b=RPwL6BpxegbaXInuJ/lirdEs5HLIypyVxePv5B4PG35Wtlm3JiAE9FmG37Y9aztfNG
 wgEnVTnmAiZq6QWp0TzcaiEIBT8QKt5vPQ6IYurrRmK3eIDnFGfLTzbC/MoNlsWg7PuJ
 wgs+D0EPcLyNBkS9Zkm8rKMlxJ4aeS+E1R8/MvXLaOOHzLok9pxhRAENm/hdav+7zNhz
 POGxgPvwo3Zh4tHCDh5BN+3ADgoqv8ue4jRfJHRjp8HS61t6OTxtI+0ojAheRlWJejvQ
 hKoEusk3VzRs9XiG/sCE18bAIqi7FnM/e79g7WtJNDQqytXSy3zKPHVpJ1lcSlEPCtoM
 yKoA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793291924; x=1793896724; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DWmAgdQQCO6JUskQB0rVpaMUkzSXFhe8eRhGQeydCEM=;
 b=cF44LIOe1NZAltq8w3lgTqpd8JBoB0qcvn83RPv0RxJZexDHEYDwiRWZ+AmZaPqpt5
 3RIj3pr6cYHW6uxt8OFLZeqebEUuvOjQXW0TGbRIYlm3dkarpimH4KExDYvT1passyTt
 qV5+U+1jpA3bPgphoVo9aGbnu0gKGDDd70GFLyV00v7c29Ap7CFVnqKvhW15TbsJFSBr
 FQl1S0hy47dYbbBM+zJd5mhw+YEAbBjxk1fecIjc2eACQxsWH/uwA50N32YRWYJZWCLF
 oaGS5fI64cHlcJLXkrN/784shv9ur2y+nuZNz1pzSeEkmpAVwy2ZrJJbAdRB6+Xwu8Cw
 heNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793291924; x=1793896724;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DWmAgdQQCO6JUskQB0rVpaMUkzSXFhe8eRhGQeydCEM=;
 b=j6j08sKniy/LFBEeHlqmeHClp6IIiubprtLTQEissI5orvqpBtlWH/Dy7I8Bh5DyTb
 JqIZ7tCrbhJmg518OM2Bsq5L9p61OUTwnkrrqhYpRogNwB8GdCa8tB2YvqtbIijvQuNe
 R5llcTRJAr3MOf6xZG8gAeeEZTYiHnPAIaDW8TzIMfTfjs/zk2qKtDhdgMnqJzKAGGfZ
 OEnDFbSQx064ipXNgk6UEy3/469sqCSDoATsW8ffwEkeSvRurNUwADuDFrugNZKWAiJa
 D2HYiDwVE6v5BqLbphYYQw0dLcX9HHEn8Mo6QIxd1Ygqm0yuuzgJ1bRX0MXAoNq6Iyx9
 zbtA==
X-Gm-Message-State: AFq9FYJdWfSQ5sMGGjMnfXkrPay5H9BpWniBOzTJ2Yxqua6Be3kWzJlz
 hrj7vCzO3u3VD7ZPn2NwVPflZntp972WGPQ+73dqck37a1bpH6MwJe9VjP20ntIAVEXDQHgC5rF
 VdhPhs9U2HnjRzaQh/HzvZWwNCoz7KmTXKKqHqkPJxw==
X-Gm-Gg: AYBFou3OGIh2Y8HX3bNzxYsIgJ8EmIfyK21cfS9uLIkLy67LF4+4yB3LBSFj6GlR43e
 0fPBxIAA5TGfbTxl4pfxVwSErG+I6oJin2d+6LvGHgAiOqz8GAiWICRht/ugRmQlgy+VahajWG/
 8nZ9EgWvpUTVLulIyUf4tELj2aq107lPSF9WeRVXtwKrs4HgQkWTEnX3gOfpjP6MOCmbgaWaYO6
 P7aMXeSv+y6d6H6lPBDCySl4Ky1VXE5hGyZJPcvmJsSIUlqpwEtZ0hjm0ZcWBD2BAhjlegUnwMs
 BnJA1pdHQqMFZmfnJNlkNskQpPf2+LuPfpPKUtOEIzGtzXawJpqrNfHzQmJvF9xjxrtAPld+Km8
 fzM/JcYOk0uvN3WR39FoeAR43yYkkotEj0j5HGplbtE9PpQX5zoQmWi4Bx2w+gYVQyM3x/Jk7iD
 R+uT1Qyu+0u8JuZ7AevADy
X-Received: by 2002:a05:690c:e28e:10b0:8b0:881d:aadb with SMTP id
 00721157ae682-8b1b5c8ca2emr32313807b3.32.1793291923506; Thu, 29 Oct 2026
 09:38:43 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029161310.2065290-1-alex.bennee@linaro.org>
 <20261029161310.2065290-8-alex.bennee@linaro.org>
In-Reply-To: <20261029161310.2065290-8-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Oct 2026 16:38:32 +0000
X-Gm-Features: AclHuK9r1rmfsQCEHjBIglsJwxFhv-pQMBDG2HZbbOBVp73yJX7W9GtYTa6w9B8
Message-ID: <CAFEAcA_UJ=QMFwdGtWv_wWhRyzoig0_0VC+T21+kFvzv9qasoA@mail.gmail.com>
Subject: Re: [PATCH 7/8] tests/functional: remove @skipSlowTest from
 quanta_gsj test
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, 
 Chao Liu <chao.liu@processmission.com>, Tyrone Ting <kfting@nuvoton.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Hao Wu <wuhaotsh@google.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-arm@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 29 Oct 2026 at 16:13, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The full quanta_gsj test would have caught the regression caused by
> the WFxT implementation and isn't that slow (<60s) it needs to be
> gated.
>
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/functional/arm/test_quanta_gsj.py | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tests/functional/arm/test_quanta_gsj.py b/tests/functional/a=
rm/test_quanta_gsj.py
> index cb0545f7bfa..0c0f5d85874 100755
> --- a/tests/functional/arm/test_quanta_gsj.py
> +++ b/tests/functional/arm/test_quanta_gsj.py
> @@ -30,7 +30,6 @@ class EmcraftSf2Machine(LinuxKernelTest):
>           '20200711-gsj-qemu-0/nuvoton-npcm730-gsj.dtb'),
>          '3249b2da787d4b9ad4e61f315b160abfceb87b5e1895a7ce898ce7f40c8d404=
5')
>
> -    @skipSlowTest()
>      def test_arm_quanta_gsj(self):
>          self.set_machine('quanta-gsj')
>          image_path =3D self.uncompress(self.ASSET_IMAGE, format=3D'gz')
> --
> 2.47.3


It looks like this was originally marked skipSlowtest() as the
evolution of what was originally commit b6eea069ab marking
it as AVOCADO_TIMEOUT_EXPECTED because of observed timeouts.
I guess we'll see if we fixed whatever that flakiness was.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

(We do want not only to avoid running tests that are slow in themselves
but also to avoid accumulating a large number of tests that are
individually only moderately slow but together add up to the complete
run being slow. But I think we can afford this one.)

The other argument against using quanta-gsj as our test here
is that as discussed as part of a recent docs update:
https://lore.kernel.org/qemu-devel/20260627063208.33642-1-bin.meng@processm=
ission.com/
it's no longer supported by OpenBMC.

I didn't get any response from the Nuvoton maintainers in
that thread, but I kind of favour deprecating the machine
type in QEMU.

thanks
-- PMM

