Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56BEBC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 10:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2ppb-00072J-R2; Fri, 03 May 2024 06:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s2ppa-00070T-2S
 for qemu-devel@nongnu.org; Fri, 03 May 2024 06:07:54 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s2ppX-0003QO-U8
 for qemu-devel@nongnu.org; Fri, 03 May 2024 06:07:53 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2db13ca0363so143282071fa.3
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 03:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714730868; x=1715335668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T3fOM+pl4bI+zQ6OHLH+FF4yznZmpCoizoYjHYd7lo4=;
 b=d/RQyxQ0PsVow2QKB7L3bzyPKf5sB23chXrkKKscwr7i62q7aPt6GLOOd0gI5iSboh
 0hpevmwx+e+6kGDa1DciqEEDZFOMVkZ3db8Ig/FoZ6R4ZMf+EUksRYlxm43HnUJFzmTC
 Vwgms6RnpCKaar0rga7qEFFkmnh2Vg94IbV9E34iyPe6SmZW/o9KP1pq3ZcBd5NK3FrM
 G5F9ry2/DOG1cqvZdNIUX3gZYzyHKGl8ifq9XWilNkduhFxH0KSU2086Vy22EjeZ6ZUh
 c1ZXqls9Q8Gf/7lJSgy6mJQcMLjnQPIaZMDT1qobnAeEVrxccYzdag6/A6bwOJPNZdWf
 T3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714730868; x=1715335668;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T3fOM+pl4bI+zQ6OHLH+FF4yznZmpCoizoYjHYd7lo4=;
 b=LHZdobA4VSuQYIxNuLcchVEtqGZHjeXUSNMRvJ/BQ3D6LncXAFh6fykaHMI4oExYxE
 JQrtl331iFNtHW1/jqQ95qO18/Lrl7c+Fxy4NmYW5p5dHkW3IKPZHo1Zy6rmRfVCDgkv
 PyyfzRbfYrgcg4+7kzY2tngud3d2YZdd0doaEAYozrpdA4jj+Uhk3oN5xgcUl1Snp02j
 f7rDoWHgP5Q3/k1+32p0OlkqsZn5WXmRjssyLZdu0K0/JoBH4UHycMKJ5A7nbHIIfRJv
 DzNFQL4J3S7EVVkKGBaBDKTIDsUuRw5aCw8MRUI06OIj8Hbl0V57uW+mdnmV3c2/MWdh
 dqaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV596exAjVTHALd11vMz2ZSW2c3M6h4KbCnCuwX6tzpgly7Yt08NbtxcNHxx0vDdAFvLq0hsKBni7qjJow1e3xEpSANYDE=
X-Gm-Message-State: AOJu0YyBfLGWWRersJuAGozsgT4BN2J+tC5g0rEdZuXAMwcFZvUVOuqN
 2e3g/+VYmM8w/HApZ9K9FmSwIm/Nkz1sKnp91XcMkzIh2pJ4XECV8N+ev8nOasM=
X-Google-Smtp-Source: AGHT+IHCch3O4y7cQzgXCRgL1Ii9ClFPsyuI6yJrG76IFWX35JR7zctJZS82EzuulatRlkNpUdM4jQ==
X-Received: by 2002:a2e:a23a:0:b0:2dc:fc58:9d74 with SMTP id
 i26-20020a2ea23a000000b002dcfc589d74mr1774282ljm.37.1714730868504; 
 Fri, 03 May 2024 03:07:48 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 v17-20020a1709062f1100b00a55aee4bf74sm1533281eji.79.2024.05.03.03.07.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 03:07:48 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 74FA65F753;
 Fri,  3 May 2024 11:07:47 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>,  qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2] Re-enable riscv64-debian-cross-container (debian
 riscv64 is finally usable again!)
In-Reply-To: <ZjSbRsOpJsTdTh6l@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Fri, 3 May 2024 09:07:34 +0100")
References: <20240503071634.841103-1-mjt@tls.msk.ru>
 <ZjSbRsOpJsTdTh6l@redhat.com>
Date: Fri, 03 May 2024 11:07:47 +0100
Message-ID: <87cyq32op8.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22a.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, May 03, 2024 at 10:16:34AM +0300, Michael Tokarev wrote:
>> Revert "gitlab-ci: Disable the riscv64-debian-cross-container by default"
>> This reverts commit f51f90c65ed7706c3c4f7a889ce3d6b7ab75ef6a.
>>=20
>> riscv64 in debian has been non-functioning for almost a year, after the
>> architecture has been promoted to release architecture

is this for trixie or the next release?

>> and all binary
>> packages started to be re-built, making the port not multi-arch-co-insta=
llable
>> for a long time (in debian, multi-arch packages must be of the same vers=
ion,
>> but when a package is rebuilt on one architecture it gets a version bump=
 too).
>> Later on, debiah had a long time64_t transition which made sid unusable =
for
>> quite some time too.  Both such events happens in debian very rarely (li=
ke,
>> once in 10 years or so - for example, previous big transition like that =
was
>> libc5 =3D> libc6 transition).  Now both of these are finished (where qem=
u is
>> concerned anyway).
>>=20
>> Hopefully debian unstable wont be very unstable.  At the very least it is
>> better to have sporadic CI failures here than no riscv64 coverage at all.
>
> IME of running Debian sid in CI pipelines for libvirt, it is
> way too unstable to be used as a gating job. There are periods
> weeks-long when packages fail to install, even for relatively
> mainstream arch targets like x86, let alone a new target like
> riscv.

I think testing can be more stable IME but I agree we still don't want
it gating until we have a stable release.

>
> Running the job by default is sane, but it should not be made
> gating until in a formal Debian release IMHO.
>
>>=20
>> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
>> ---
>> v2: drop a TODO comment which turned out to be confused, replacing it
>>  with the description why debian riscv64 were unusable.
>>=20
>>  .gitlab-ci.d/container-cross.yml | 1 -
>>  1 file changed, 1 deletion(-)
>>=20
>> diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-c=
ross.yml
>> index e3103940a0..dbffed3f21 100644
>> --- a/.gitlab-ci.d/container-cross.yml
>> +++ b/.gitlab-ci.d/container-cross.yml
>> @@ -77,7 +77,6 @@ riscv64-debian-cross-container:
>>    allow_failure: true
>>    variables:
>>      NAME: debian-riscv64-cross
>> -    QEMU_JOB_OPTIONAL: 1
>>=20=20
>>  s390x-debian-cross-container:
>>    extends: .container_job_template
>> --=20
>> 2.39.2
>>=20
>>=20
>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

