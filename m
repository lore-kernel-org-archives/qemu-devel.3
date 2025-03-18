Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D0FC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 16:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tua3t-0003Si-7F; Tue, 18 Mar 2025 12:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tua3l-0003Na-BG
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 12:44:58 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tua3i-0008AB-Q9
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 12:44:57 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e637669ef11so4693298276.1
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 09:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742316293; x=1742921093; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DxymLJOtCZRQU9k/3n/xUwbsWZOIVp57KGBRdzEeaYk=;
 b=ug1jV8fOCmJHWfvTmQLMbLXzluorxZp0nhFQqss5mucD1tKcaLYC0hqEYDZ7TlZ/iO
 11Xt+okR8U5SYv2FNm9TpuIy/h5aYKb1egAYwmMV+mNJYxVzuf6HbrapLWzZzllqV6ta
 +aILQ90Ar7qIEaZNDHOgU1aIuMG1T7delWlvtOFEo++inhdzVkh1XKLqGHS1Etcbualg
 uqh+M5uzZ5+kWjk8wY6XW00GBLoCSP3PfxDb3PKKk2xWP9DrQ99gw0z6F4I9BwWEJ+bx
 qRELoWb6QmrKTS7BTKZWEEcj5hcoZvNZkMXzy/IK8rWxDBtGBRQ+8kX2B8RvVPJjqwDH
 MK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742316293; x=1742921093;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DxymLJOtCZRQU9k/3n/xUwbsWZOIVp57KGBRdzEeaYk=;
 b=WVYG5GfcPq3KU3Ol6UldsqhrSZ2lGf7qK9SfQXBi1AQh/XfsWC2ZiBrS5+yF1ec02h
 z8x8gk3hjjvZ9sCDeIJutWDPmNecGezd2PMUznEe0LVEeemc0XJfl9jiiEXg9jEJELg2
 jq2i7FfLkauGxqOda7kTJz6n15YdyTHykTYK0yF5fzG1Zd44Z2g0RiyzuThipMseI3as
 lCAGazO6SLExhBzuMt/sQTKBscrYqysu3Qb56rB2Mp//YNAF8kNH4xJdFzMeIMaxt7Ru
 JMKNT+kYGA38Nn2a8cua/s/Z0cItAyAtuXF1XQCR/R9PokR0FXo2FadAA+TeRJM4zvY2
 jI7w==
X-Gm-Message-State: AOJu0YwTC4xSxq3BW4AW4Bakc2IL1PQHiKXSbhMqw3kFujyH+vGfQnxR
 iLXPy95X4ORCbwGbFCHPPqF6Yb/ldAi+fHjiKZLAa7PsaHLw0cVkEKvo4elYp4JcuEtsWtoiAaw
 ynVTWFmIMJv1ymbKf7jlCa5l81LiHsZYnVng0pQ==
X-Gm-Gg: ASbGncvG2cWvhMPKPJHuETWtvr39PPuEjvnWiFDx5YGOjU0/+HT+Z5iSAMCmeB674hs
 m2aM0x6OIDaYkLESVetAlix9wobWSuuNtXE3v0dPZGtyzwFYmWPol9/TUDVOjDC64WYMrxAIZ2T
 DI+Rawkw22AWNiFx2xfAdBK48PVhk=
X-Google-Smtp-Source: AGHT+IFidgrF62xu/KhYGUfEuhYnyfJ5OB82z04KbQKXl+tPGeEMRcC0hdJWr/UZaMzGgow+3V/qNBuTu1Fx6lRYJek=
X-Received: by 2002:a05:6902:2686:b0:e60:af56:73ea with SMTP id
 3f1490d57ef6-e64af11e781mr6429815276.11.1742316293166; Tue, 18 Mar 2025
 09:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240909141635.1459701-1-berrange@redhat.com>
 <20240909141635.1459701-11-berrange@redhat.com>
In-Reply-To: <20240909141635.1459701-11-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Mar 2025 16:44:41 +0000
X-Gm-Features: AQ5f1JqYldacM9PDtx-DkZq7TGfoD4R0hghMdu2nfo8CYg0SKPdWX2yfpch70PQ
Message-ID: <CAFEAcA_xCa4NjyDt6M+n6KdXTUWRfdSkymW-AqupXRQC97DKcQ@mail.gmail.com>
Subject: Re: [PULL 10/10] crypto: Introduce x509 utils
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Hyman Huang <yong.huang@smartx.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 Dorjoy Chowdhury <dorjoychy111@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2c.google.com
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

On Mon, 9 Sept 2024 at 15:21, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
>
> An utility function for getting fingerprint from X.509 certificate
> has been introduced. Implementation only provided using gnutls.

Hi; recent changes in the codebase mean that one of Coverity's
"maybe this needs an error check" heuristics is now triggering
for this code (CID 1593155):

> +int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
> +                                      QCryptoHashAlgorithm alg,
> +                                      uint8_t *result,
> +                                      size_t *resultlen,
> +                                      Error **errp)
> +{
> +    int ret =3D -1;
> +    int hlen;
> +    gnutls_x509_crt_t crt;
> +    gnutls_datum_t datum =3D {.data =3D cert, .size =3D size};
> +
> +    if (alg >=3D G_N_ELEMENTS(qcrypto_to_gnutls_hash_alg_map)) {
> +        error_setg(errp, "Unknown hash algorithm");
> +        return -1;
> +    }
> +
> +    if (result =3D=3D NULL) {
> +        error_setg(errp, "No valid buffer given");
> +        return -1;
> +    }
> +
> +    gnutls_x509_crt_init(&crt);

gnutls_x509_crt_init() can fail and return a negative value
on error -- should we be checking for and handling this
error case ?

thanks
-- PMM

