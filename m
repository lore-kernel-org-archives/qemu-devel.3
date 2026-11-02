Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C553160A6F64
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Ni0NbxLP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNqQB-0002O3-UO; Mon, 02 Nov 2026 06:41:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNqQ9-0002My-F6
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 06:41:49 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNqQ7-0004qV-TG
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 06:41:49 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-8ae8607e8afso19975227b3.3
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 03:41:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793619705; cv=none;
 d=google.com; s=arc-20260327;
 b=kyM1hkGyfsQ+OibuyQtKEo0vb6cPgPWcbk+FOdBxceGEFZSMQma//UV7X0Oss6Q/5w
 n8Jox2tP8OI6n5tZkFGku4juSkYEyILAT7wKhYW2yS262rcPYEWLS/VvLQxiKeMJjcgg
 6ZZuy2wjeFcNk9pnRltD0SQwFwXEXgj/hSbjzEg5HEOmpK4VJVuJ7l8EhvKMnfh2kQyz
 doUM/OOE9/fM6RDsgQ49pxYAhMSYgnAOcCwH5PssbE5Tgz168KnWGXtFyeHlWbjzZTPx
 /4oDL/SvVVMG0kGvJ0ZHztCWcSeStr85UyaupXRvM4qV1dOoLu9kaT4Xp6Gjvk334ySA
 dJ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=J6EZf8qA8tZJdJ5lD4a2jL+sEaX15FOMmTXo2WHYSyw=;
 fh=5Pmahbx9qiuY0/ciWFYXo9MkH+eOx2AOyAapaCKQ3CA=;
 b=HyLTnqt9xUvUwjDgYoiDMDHSyCo1kJ3s3/19wp7hzVw8yes6kbX7+w6cJwHwxdk8tT
 KdIFr/eJU6+l+7tJBio30YBQEtsTiOn+Kro781d4W23harXQDjeVBlSpAQ4ccuu5biKS
 VKzmBE8H0XftcBZorX/aTYBt7vTEo5wD2CuM+dspgwqqsrwVtscIZnk31JRCpM5oYCna
 QXMGPmfXs9K40SQrq7gkUwHG0LNw6P85jFHwIjsMTgwP9cqhlwgP73UM216YTVx/1DGy
 UzWJqMF3hDEUvyXna3L7EUbY8bnD2k0wsoAVV0wIbfJ+uRaW9tHlRrxtPdbYQoKT8IsF
 aFbA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793619705; x=1794224505; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J6EZf8qA8tZJdJ5lD4a2jL+sEaX15FOMmTXo2WHYSyw=;
 b=Ni0NbxLPA/7ZgcfQJ/AttcgHoX33Hdubsg1lvadiVgvn+tAeTb5euniHbMuE1i1rnV
 rGpQSWPqD18gcZbwE76CpmgRGlINRj+Ea/2uSdH1/EuzsCXPnbvcLxQUAdhGIHwV5IRo
 Qd3DUhXx4sjUX6avr/R3byY5uFnopFOt0W1ryaCziKM5zoLfhBiIT0Ja0GJsYmmTDQHg
 zOKfsFyr7NjzPUwz3fGjcaIZZhSiYw1xsqcEcysnx4qOFIo5orJNfW+5c9lp2M7dbo6f
 TyH4Y4aijHr6wou2tNCDFDTna38yUXM7mM6Jadab5iAq2LE+PdNw+El17y2ys0PEs/lf
 RENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793619705; x=1794224505;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J6EZf8qA8tZJdJ5lD4a2jL+sEaX15FOMmTXo2WHYSyw=;
 b=O0KgsiW54jMaKMPwwzV4MkD+DPf5YBtoAi6rvPlZtYSqbel9QwHD+EHdQB+9/uYltm
 HkgGNyKAsiAxbgl30UsMGohTAKcv6k1D+sN+ecjHCDYLKllKdVuh9gfCKMRkRQf9yGy7
 yO1IZ90In41UWg0THgEIVrdaSNNuW971pdIqTVcKIguGIbqKwp4dKLhJnjeWqlyG93LE
 rXNJ37DFcNxJxrcL4APhyUGlwlzaXxGZj18WY2/Hv20E7yhMcC2JXWT+is43jybjh2IR
 cg2dGMk7S/cQj/5/tX2klSxzrOLN8AXBIHkCR+LJGx/mETinmFqQPI2NXHurEY3ZIx37
 SDWQ==
X-Gm-Message-State: APuU4Z8rdCCWOcW7DuDFPGOcSxY2N0NWzx7D0kNKxCPPDE247m/7Lqcj
 t4QFRZGZaWx4k+1Z6hHnhDnKv8UqjWsVafFk2Vpj1p76ul74OeKLl1SJlJp0tasDOriDkJKOtXU
 7FcltHGA19Wgf95KN6bnkwTUvg3hMPKv5JXrz4KDxLQ==
X-Gm-Gg: AYBFou1hEArAJrrmKVOdQq3gef/DmNpVEcGb28FjQZG+SmgLulfKkNxon7qPG/JiBZH
 BUAq6pc9aGyYyLuJZ0z+9cWk6Z3TaYvm4bDHV7yDDYRpzBC3N42iMv1DoWLAekdDi6SkOO1Smif
 AFxC8PzMNGvAKnz96GGHN2P+tyqkPHtXPj9r3s2tIn7M47n53nJQeVQVKzz2X3H4rbq0eqB4a/z
 kC2wXjk129Cd67YJfO4U3k6v6SmE2OgQbxav24dmhEyuK8UbhDUjJEATFi7k4DoyGy/bGpCA7FZ
 0oRRsBB1w7MlPJ+/lwSeO8pg+Shj0CNxk+Q48klhNa2HJXmHG3olIOZ5uWZDwcv2+JPYAfzwJEb
 bzP7PxxhenrJd5dsNpX2zaxI2AULcQ7Dwcdj8EyROh93owykkstwMRGs3cJhQ1+hHxagukxtCO2
 neZlXqrw01lXdWG7TjmlfV
X-Received: by 2002:a05:690c:c4e5:b0:8ae:c724:42b5 with SMTP id
 00721157ae682-8b2b65b203cmr54042567b3.5.1793619705400; Mon, 02 Nov 2026
 03:41:45 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030141046.2710206-1-alex.bennee@linaro.org>
In-Reply-To: <20261030141046.2710206-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Nov 2026 11:41:34 +0000
X-Gm-Features: AclHuK-5BGHNHE_EWVrkZ3Wr5PSoUFBoJuZg5o7gp0G3JxldCy2-KEl7JPCJT3A
Message-ID: <CAFEAcA-kPe9iko_mqgB7FTC8n1PeaOk0MhhFpntiWf8gLz+jNA@mail.gmail.com>
Subject: Re: [PATCH 0/4] arm fixes (WxFT, bcm2835_fb)
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 30 Oct 2026 at 14:10, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> These are the arm specific fixes from my last series. All reviewed and
> ready to pull.
>
> Alex.
>
> Alex Benn=C3=A9e (4):
>   target/arm: hold bql when SEV sets the event_register
>   target/arm: don't pass env to the sev helper
>   target/arm: simplify wfxt_timer_cb to only trigger cpu_interrupt
>   target/arm: fix bcm2835 migration issue

I've applied patches 1, 2 and 4 to target-arm.next; thanks.

-- PMM

