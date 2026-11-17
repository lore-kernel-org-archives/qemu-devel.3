Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF6A606A329
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 10:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pbizmTHj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTG0x-0002hb-RN; Tue, 17 Nov 2026 05:02:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xTG0t-0002hI-Ba
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 05:02:08 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xTG0r-00038E-H8
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 05:02:07 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-8b4e04eda5aso15645487b3.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 02:02:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794909722; cv=none;
 d=google.com; s=arc-20260327;
 b=ZGB2G+v7tsiXrOUFyTlR8MVYgx4BU2s67IIr6uC7SDglyxiJbL6o2lbJiP45ydQAAb
 mASQPT4k+DBUuOCk92Nvr0vNf3TCF+az0J81C6xmLMiweKjM0c6UtkDIkXgH/7we4qVK
 0csNqTjOd4qpCShtW5QeLW1Ls3Khf1sXkITzllhpVwDbbCYOFUFegbyOlTKE0FByAY1S
 w+l/y1fSevlk/+Wj1W4jn8sedtOg1TJYlvvAuSGJzzdXE9zPOurzyE1sEJ2VwcPV7dKd
 t4jUMww0lmm/DXob2uNfu8nSt7kymmkoEzoGC5ecnwvNF56ySx9CsvVZDoMo6Yh+1Qnv
 LBUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=X52QVyqdHp41gs9AgwE4wKPDWmnSa8R+j1eld2H27ao=;
 fh=1NoHjPbfx8qCmu/I1dIx55GA200r7cj0quL0JFtuMi0=;
 b=KNFUQyTX+X/lI2KS8ZjtWnNfmjmqtS0E3JZGgTDEjggpAHF4M03FpFRXj7gpmX4nOs
 vUJ2cvwGzZ7A0mnqeRvJmNe4yQqDNERmKJ9UukjuyfD8WeKvzA+tLyqILWJP27/bsFVm
 FRsqqcfnekVb8iokepsLfQtqWV8uWvvLeHej7XDXB03ZVRkyLfGzvkapFuNU6c2/WeOR
 KyT5fv8c0g0y/nFJ/HzIRwrDZfmShxeq7lB3wDCDjt0dPyfZkARHzQ2nFpKgqrcO+p6O
 aX7T+zKnRuEcsH6TaP9hlpjBMq4anO1Q7V7bCd7Ofy9AEU7eeuCI0CvS0GzEhS0VXhCN
 98BA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794909722; x=1795514522; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=X52QVyqdHp41gs9AgwE4wKPDWmnSa8R+j1eld2H27ao=;
 b=pbizmTHjQ74ec8FQna74XVNBvmiH78eDvXAMPMOUlmYnbEITgBQfCGXjMstapRYCro
 vF1TudAadoyOR/MiW/rTZS5MJfBtibXy1aESZRzq6xhfgTviEeUkFYAb4sxyh0mpqJ65
 nSxD2mWEtL5oopmJBo3hmz9yNRXfYzzgzBsAe7nIUtP/vPHPRGPTEUT//WZWUtAbsHiw
 htVh4W7T0UDIb1AGN6CCbK2+WEAOdCuDkrrobUlmIuhPkjA1uFq0H8U015U0lgKGG34P
 pHhNb5h5jVVsAgh9eKXrwrFIBPiZskpk2qDpdCVFdk/kU2jgsZk4q0E5qRtm4+A7p+lz
 v5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794909722; x=1795514522;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X52QVyqdHp41gs9AgwE4wKPDWmnSa8R+j1eld2H27ao=;
 b=kOK/FPz6hvGUzRUmlOH0RZvT0nOyNobKyFg8Ev1YnpEbCu/uJLhlFFLHQ0vCWQsJXX
 PTPqfzG/YOanwLKeRX0o8Fb5MBi3LBsSQCY6pFmDQ/oDx4x1grA8x2tjcQ8F5moOh4Sn
 iceOAD5wiRto9yYyAwMtYJahT5yyZfj9ctylF8Gd7IBUYO8UGwKEAEJf7Hb/LA9X9alc
 keoGmlIRQBd1xbqTNtnEdS7GOnWpkIJJaId7mI3TOqhnCmKpqpzsMi+fbkaGwSWk3rL6
 7mgZQFzfgcteDLGpV+Gq3IIVhajSoRpFamKWbY9LmvG5j4YOSA5fooz4k49GMQ96xEew
 hdxw==
X-Forwarded-Encrypted: i=1;
 AL+hErF8YGce1Z9lQst2GHTVrL3aGwx2KCPGK85Zg7dzAl2Gk+wJBX9RrYLCGGzHUbuXbhaU8kuuWl95Mh49@nongnu.org
X-Gm-Message-State: APuU4Z9amVvT+7j8q5ArOq7iyA9SBPo7N5yGk8crCU5i42nlmFn8gdVC
 YxUGtrk6kgP2+9JNNYkVMfxn3HEkpjtbhTVdZPXjYYF2YvyKmJ589njSt6XDjBscdBNYB2v1sHf
 0t6NC1HDDBaw4yYZybx2Mhg1CH3rehkzb8kmZ7tJFhQ==
X-Gm-Gg: AZFdTZdv3cnzI3tuP/FVluGhzZTesKIUFyjXgWEk9SvDB4rV0fHYQIntNbQYiXqQnRu
 VFoGiSn5ysnscCjCfHHBspPhIxqJjIvIIsL+/zh4LXB9nHe+mffG8RwsUnLhSYlYhPKPy59hJLM
 etg7TGO+UcZRBwkEPo9SexgsfkO1AVJy1fmqVknJ4g2dJXj3zetD3pIQ1ubX1fX3aEs9BLLHSfF
 7W+Y8E6zy954SL++kOeDXmQQfcgQ2tKfd3FDRfL9aTiTkQNsuDOWlsFh29aKL0USjlUqxW2bd2V
 7b5cqwF44ZqCpV81dZs6TggwqqSt6Vpo0YhM6Vz3Qe1Y6gsvIXll4EDLPjG3bzGYqUGBUnFTDRw
 /xscwGXf6GWEFX8IePTAPrLRDAvW5UAu+lu/EHci2fYyEYN305PbRrwwA6GctZU9CDsgMZM7xNy
 TnMKRUupF/KA8QRctEK4Ac1b1rh93COSJz8JRi8RN5/w==
X-Received: by 2002:a05:690e:810:20b0:67c:6cfe:877 with SMTP id
 956f58d0204a3-67d896a3d64mr5659692d50.19.1794909721600; Tue, 17 Nov 2026
 02:02:01 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112180859.85380-1-philmd@oss.qualcomm.com>
 <9b64d3d9-736d-4878-80d7-4caa75eee778@linaro.org>
 <CAFEAcA8La+8TqFY0yCxRsXY2Ad9MA5Uu-sVEbysExZPkUXVawg@mail.gmail.com>
 <ccfcea11-ada8-4753-a71f-f59ed1bcb067@oss.qualcomm.com>
 <CAFEAcA9FE_dTUo5s2g7DMw9-ZhbjBUOfF0RJxdT7gMwm-rYuGQ@mail.gmail.com>
 <558f35d3-5a10-4652-8af4-4a88f382ca3d@oss.qualcomm.com>
 <CAFEAcA_gBzv7URWJNjXwjUbKOJuRQ=bd1NS9enpU_AW_tCZzvg@mail.gmail.com>
 <b0633aca-736d-479e-b6fd-743f5ef23035@oss.qualcomm.com>
In-Reply-To: <b0633aca-736d-479e-b6fd-743f5ef23035@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Nov 2026 10:01:50 +0000
X-Gm-Features: AclHuK8q0Ekle5D-RGnJzaenwgDJy9yrVxM1qenuO8FOjMFd1_hvQsyse2a5Oug
Message-ID: <CAFEAcA-538oi8UrcevGYGbzjb0ouKN2Qm47YBckgUUOVPvUpGQ@mail.gmail.com>
Subject: Re: [PATCH-for-12.0 v2 00/12] linux-user/aarch64: Support both
 endianness at runtime
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 devel@lists.libvirt.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 16 Nov 2026 at 17:05, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
> On 16/11/26 17:53, Peter Maydell wrote:
> > For aarch64 in particular I would prefer to deprecate-and-drop
> > big-endian support (probably starting with the deprecation for
> > 12.0, rather than pushing it into 11.2), since the kernel just
> > did that in 7.4.

> Tangent to this, it makes sense to deprecate quickly enough on
> QEMU side when a host-related project we use deprecates / removes
> it; when this is guest related I don't see the urge, in particular
> when the maintenance is almost zero cost. For the particular
> aarch64_be I agree what we lacks is coverage testing; but for
> other features I'd prefer we keep them as long as there is interest
> within QEMU users, independent of external projects change like
> the Linux kernel.

I'm not in a huge hurry about deprecating aarch64_be (as you
say it's not a huge cost to us to carry it, though it is
a small extra amount of compilation time in CI). It's more
that I would favour dropping it over doing any future work
or refactoring on it. In terms of QEMU user interest, I really
don't think we actually have much of it (though of course it's
difficult to tell since users don't tell us about stuff that
works for them). About the only thing I can remember is
https://gitlab.com/qemu-project/qemu/-/work_items/3958
which is a report from one user that it doesn't work for them at all!
(My suspicion is that this is because their userspace is built
with some custom local kernel / libc changes which aren't upstream.)

As Richard says, BE AArch64 on Linux has pretty much never been
something with much serious interest, and the config has been marked
BROKEN in Linux for some time prior to removal. I don't think there
is a big stock of BE userspace binaries out there that people want
to try to run.

thanks
-- PMM

