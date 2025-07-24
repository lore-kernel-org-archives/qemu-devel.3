Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB1DBC83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 11:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueuAg-0006Ye-Er; Thu, 24 Jul 2025 07:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ueuAU-0006Cq-Oe
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 07:31:25 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ueuAT-0003hG-0y
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 07:31:22 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-608acb0a27fso1547699a12.0
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 04:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753356676; x=1753961476; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EhGhOkkpDFl7VWDNFxvKOdEYRyaP3QTDR0n8AklBARA=;
 b=nj2x+zk0+Swl35cPfRhX8csPjDFUBoKlDGU5oW4PLGMknETA1ca5O8fhpLDOiMxu/E
 i/FVxojxhtP4QeBymcBunjpt0cMP/jf3+a2ZMU96yEAC1Ms+Z78kAmkHalWc/zRJnpwx
 BdImnOK1CCxMVSliF9edj7TET9Ai832Vzpr6hqAzjiNH8WmAko4h/WmSrvJYhBmh6A19
 tvIdkZUfX/l3a6iynC3++oQ8+JzyXxHsgR4neZw7N6rwjHynkPJTdbv/+JnYLFXeEWPs
 8XSc21+zv43qdqIinIR9gdsgT//ntE9VHYyHwPRCj3fl7NFHUhEv/lq3rC3RxhkLAnPl
 Dr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753356676; x=1753961476;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EhGhOkkpDFl7VWDNFxvKOdEYRyaP3QTDR0n8AklBARA=;
 b=Y/XsK1xQ9gbVMhLweEDjUWK42+59E2bkxPn+R1zOeq7giboZWg+yBW2lbNLUdWb/BC
 bSdwpocahFs0LwbJSXo1g0aVASl7GZeVe75YfX9KMX1a4fDul0VlYUXYcUtwXCOZDI2H
 mMbtIVMoOeEooedKVQrAull6bNTBFSqPqEJwA1vMvafHtD7iSm9CIYIrrwWTld8peTde
 A/fxNcVWbBwE0l0J+QxusdsInQicsHQ6nHH4llmyUvCTICRuSlfTpQEfMhkgfat1qaGD
 fE5WT/KH37M4vvRyPkajwZGNcQanDa/fEB8vPq2gwp0VaypKSVcqkhmp26qyCLf28Xx/
 w65A==
X-Gm-Message-State: AOJu0YwDpzxSkujT0g4CedNHaOWCxxYj5+l/w1cTFToFyNzgXSlaGVAR
 SO5El+hDBBteSzavEV8tN9EmShTTEouEjHJtCrSZuH4d4zyowCcP1fKxSW51BHDGX16vlVOXU5x
 6q2lWh9DNhnJiFLKRIMgXesTG6U6pVYK6bJ473KvonQ==
X-Gm-Gg: ASbGncsAcR+3cL59EcDCq01I9frBMNCfMMx57W1IzunFF9S1EISNn5pj6QUIDDK3fKi
 fMBsnd6hZtBf0XbKae4X3smjf3OWXO7Q7v4m3KyfFY6KCE4PseVZVw8ID1b1oh2lw8dMEgGKZyq
 YAl8rCOjIQbJdehLeuZECBzrsx6NYE3XlyJ7Lk0/3fRbJ+F/ei2C+chcChJcpx+adaOVEvGPLjX
 vNlBw==
X-Google-Smtp-Source: AGHT+IFj34DmJ2HX8s7QIdgzMfJIP/vDCHQ/4VcvtP+yt3K2UOJ10P3fdBmDtltnIXzjcek6pdC5J0BcWqdydkqFkNw=
X-Received: by 2002:a17:907:7205:b0:ade:3bec:ea30 with SMTP id
 a640c23a62f3a-af2f66c5e0fmr598125466b.1.1753356675951; Thu, 24 Jul 2025
 04:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250724105939.2393230-1-alex.bennee@linaro.org>
 <20250724105939.2393230-13-alex.bennee@linaro.org>
In-Reply-To: <20250724105939.2393230-13-alex.bennee@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 24 Jul 2025 14:30:49 +0300
X-Gm-Features: Ac12FXxGpWlldqtydoOGlnbIkeSxdWLmbBcJfn0ufq3c269FkS0uDeNMCB86rxw
Message-ID: <CAAjaMXaJobP5Vyv0FEMujVWZD1YOVqBku_S-JCGaZC10C+5Cew@mail.gmail.com>
Subject: Re: [PATCH for 10.1 12/13] tests/docker: add --arch-only to qemu deps
 for all-test-cross
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52b.google.com
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

On Thu, Jul 24, 2025 at 2:00=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> If we want to build this container on non-x86 systems we might not
> have all the cross-compilers needed for the ROM blobs we don't
> actually build. Use --arch-only to avoid stalling on these missing
> bits.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/docker/dockerfiles/debian-all-test-cross.docker | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/test=
s/docker/dockerfiles/debian-all-test-cross.docker
> index 8ab244e018a..5aa43749ebe 100644
> --- a/tests/docker/dockerfiles/debian-all-test-cross.docker
> +++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
> @@ -15,7 +15,7 @@ RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>      apt-get update && \
>      apt-get install -y eatmydata && \
>      eatmydata apt-get dist-upgrade -y && \
> -    apt build-dep -yy qemu
> +    apt build-dep -yy --arch-only qemu
>
>  # Add extra build tools and as many cross compilers as we can for testin=
g
>  RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> --
> 2.47.2
>
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

