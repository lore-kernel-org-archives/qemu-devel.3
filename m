Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DFA9C25B5C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 12:16:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2roY-0000dS-PU; Fri, 03 May 2024 08:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s2roW-0000bk-Mp
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:14:56 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s2roH-0006jp-Jw
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:14:56 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a599a298990so96716466b.2
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 05:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714738479; x=1715343279; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=50yuEz0hGDCIwoiq3GTP9VO4htj2JLkjzp/bmPCAGW0=;
 b=x92bio9fjwjY1TfxZzKBLXVTA9jkCzP3SBbbRB+UFsBSGf84ArGxupLWQIeFP7D35P
 lW+gwcaiTVbyq7EkY3c/dwdC8oXenXtcb2IdVY4PQOeA+FjH8HVuyCgV6vwT7iEg3PmB
 YLBh9/T8O1JQCw5BqFw1G1To5oxPhZYMQj57PRk5B56fyN54+ApFy/Q9ca7mMyf3axTI
 3t1NnWWGU9DzKBOxBkuAqcxJFMiq0xb5Kp9tC/WTS0rl40D6c88GXQMj+Yy+THbxlJgo
 QFIotpZqLwcjrRW/s5GDQGKnDevB1uDNVM5iraUSmSrq+Rs6P3DhRO/hE0gMs7fN8Zmt
 HSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714738479; x=1715343279;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=50yuEz0hGDCIwoiq3GTP9VO4htj2JLkjzp/bmPCAGW0=;
 b=EseYq+F66S006795UU5YoA7TMGr34FRSIw5LV5xK49HNvXQ4ZvLPmKkvOTZ8u2GvZP
 EsR2nxdEh2qg6IbdS5xg7tgXf0DxCGFlcFdvCt5rapy0vJK5d4PImMa1fwesljSj4VCd
 zAuCifxfKbtsIXcxYUugzreS2dmJtAiR7KWAy65XiTyw3zvB5yQwSawjGg0XVzoBD3iS
 Let5Q0UXMdZzyqOaZ6T3JZoDE7mltV0CAtHrAPKGjJLclCRm8/pWkzvOQJKf35E0BPZE
 4FfXmAVmPZBvafF0KLnPr/IsamW/+z9EEYGznV9bZRaS3e0wF0rPvkiBUYwotf3uqUFW
 GQqw==
X-Gm-Message-State: AOJu0YymGJ/8IPZPB0OH1r06LpJ8KuT5mz7h/gmWsqgHXc0sSO7Z7b5Q
 hWUcSHsTOnYWbVJQ5c8bY+NU+9JIDIPLKTZYo6OF1fVMlk3iFPCjdZ6C3/Rr3Wqq5zlnb0fkzkY
 ZiQU0a7qlKtDI+tbmbkkEns9VNQnp1BXN+da9WA==
X-Google-Smtp-Source: AGHT+IESgQukHb6rprC1H2LZzKBzIhjmjRYaZ2xb/HgnsXz2pEIOqSDAqZ8Lk+sdmM7f08XhhvVZTdN6sQujLnvSfHs=
X-Received: by 2002:a50:d581:0:b0:572:71b2:e200 with SMTP id
 v1-20020a50d581000000b0057271b2e200mr1529037edi.22.1714738479509; Fri, 03 May
 2024 05:14:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240501182759.2934195-1-berrange@redhat.com>
In-Reply-To: <20240501182759.2934195-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2024 13:14:27 +0100
Message-ID: <CAFEAcA9LTsdjHpip1F=BPhrRUbH++3eW4HjjH4Xn6yN18pHtjQ@mail.gmail.com>
Subject: Re: [PATCH 00/14] hw: define and enforce a standard lifecycle for
 versioned machines
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>, 
 Halil Pasic <pasic@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-arm@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org, 
 David Gibson <david@gibson.dropbear.id.au>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62a.google.com
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

On Wed, 1 May 2024 at 19:28, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
> I wonder, however, whether we would benefit from changing how we
> update the VERSION file.
>
> eg instead of re-using the micro digit to indicate a dev or rc
> snapshot, represent those explicitly. eg "9.1.0-dev" and
> "9.1.0-rc1", "9.1.0-rc2", etc in VERSION.
>
> We don't use the full QEMU_VERSION in the code in all that many
> places. It appears in some help messages for command line tools,
> and in QMP query-version response, and in a few other misc places.
> At a glance it appears all of those places would easily handle a
> tagged version.
>
> For release candidates in particular I think it would be saner
> to show the user the actual version the release is about to become,
> rather than the previous release's version. This would make the
> reported version match the rc tarball naming too which would be
> nice.

I think the theory behind the VERSION file is that we want
to be able to express the version:
 * purely numerically
 * in a strictly ascending order

We expose the assumption of numeric versions in places like
QMP's query-version command, which reports it as a set of ints.

I think there's probably scope for making the "human friendly"
version string be surfaced instead of the strictly-numeric
one in more places, but I worry that breaking the "always
numeric and ascending" rule might have subtle breakage for
us or for downstream uses...

thanks
-- PMM

