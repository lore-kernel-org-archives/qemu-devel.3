Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6890C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 07:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ3YR-0005sN-3P; Wed, 31 Jul 2024 03:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sZ3YN-0005pp-Sr; Wed, 31 Jul 2024 03:15:19 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sZ3YM-0004ey-0T; Wed, 31 Jul 2024 03:15:19 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3db15b4243dso3329658b6e.0; 
 Wed, 31 Jul 2024 00:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722410116; x=1723014916; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N3jkv6yO/P8lw3cZUV5i3N0INOf5g4ZghcjUD2Cndz8=;
 b=gP/ODFXCkJVd57tqGoVGIZzOei21+LALzL99DecfwL0Rcb1m9Su5/JUHSWhgD4KTIu
 6hVIk/rhGL3y0Uv4JiSsGVsR6y0Y6/yHeXHFfZVwNKieE+AudHkR2/sEcuvzfGwsCMz/
 fK4LdU9COdsU3oe3rcluTDW1w+4rIPKIjS6XRqZ/dui04cUQxHq4WYPD95EvdHOCE0z8
 fMrEXo+pabubVx9CJjRrUsbhYyCa06UeCOjMnzu7Iv5uEwiSachirzt1KA5WEVyikYtn
 WaoIjpvWEs6LFnYB4WoN8Ap9VHjRTiiDRqaUBSxp4FhmEp1jFWc+HGhbC3dg9WCXCu3B
 CJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722410116; x=1723014916;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=N3jkv6yO/P8lw3cZUV5i3N0INOf5g4ZghcjUD2Cndz8=;
 b=tampeZLabumR5JZPFayRjAex0Etyq4vYCYyDo+R9XuKUehj15T72IcaExEAgCEuzo0
 KeaNkd/Jy5iwIC/oyN9SSQ/80BeNwWej5VvNTl95midZ5R6kbqWI32iWdAqQJzRqnH4v
 Dz6Xr06SoMgoPYJdNdNa4+0aHw1JFEGidtq5rKnUMZf8yEXxgrBr+j/2+u7f6q7/uXVM
 OZWwPQQx788Y+j9N2Uw+vuJcU1fCFfJuO5uqIqGY/6s214mudwDzCKwc16bAbOGG3M6o
 ZogdZ8B/RgaZE+K6NlgcwHyICiow5VGLte4GcDoz3ZrFEap4bXGybAV5gbc49SV85vwt
 mruw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXxOsOqrMo0iEA9wBGPBVrCpa9bA2/W/B1pMkWFV10o2Is0kayWES3PFHzKtPB1ACSZNgdmCFqR+T/3GIZAAa8uhy5
X-Gm-Message-State: AOJu0Yzn8SyFL2dbWdBqjlW5kLw2weuU2Lw4MAzxGJ4TSkmoaC00S1EN
 N3uhsZjL8oLRDWXcnGvk5qNOySN3POGnT98bWflNwnJPfCgoIxAy
X-Google-Smtp-Source: AGHT+IHL3ntB33cDOeUpZbzugtlzOAeynciMecD/VvbWNyfbx8gaz6/GPKbnsy0m8kJ4dYVtgj3OXw==
X-Received: by 2002:a05:6870:1d1b:b0:261:b48:3c99 with SMTP id
 586e51a60fabf-267d4d8ed7bmr15670091fac.23.1722410115972; 
 Wed, 31 Jul 2024 00:15:15 -0700 (PDT)
Received: from localhost ([1.145.22.167]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead874af9sm9716540b3a.170.2024.07.31.00.15.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 00:15:15 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 31 Jul 2024 17:15:10 +1000
Message-Id: <D33JFD9PR5ZW.171C8DZQ4YE9T@gmail.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
Subject: Re: [PATCH v6 0/5] Power11 support for QEMU [PSeries]
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Aditya Gupta" <adityag@linux.ibm.com>, "Mahesh J Salgaonkar"
 <mahesh@linux.ibm.com>, "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "Harsh Prateek Bora"
 <harshpb@linux.ibm.com>
X-Mailer: aerc 0.18.2
References: <20240730192325.669771-1-adityag@linux.ibm.com>
In-Reply-To: <20240730192325.669771-1-adityag@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hey Aditya,

Thanks for this, I think since we're past the hard freeze it may have
to wait until next release. If it was simply a new PRV maybe it could
be squeezed in, but since it has this PCR tangle then it's a bit
non-trivial. Apologies I didn't get to reviewing it earlier, will get
it in 9.2.

Thanks,
Nick

On Wed Jul 31, 2024 at 5:23 AM AEST, Aditya Gupta wrote:
> Overview
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Split "Power11 support for QEMU" into 2 patch series: pseries & powernv.
>
> This patch series is for pseries support for Power11.
>
> As Power11 core is same as Power10, hence much of the code has been reuse=
d from
> Power10.
>
> Power11 was added in Linux in:
>   commit c2ed087ed35c ("powerpc: Add Power11 architected and raw mode")
>
> Git Tree for Testing
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> QEMU: https://github.com/adi-g15-ibm/qemu/tree/p11-v6-pseries
>
> Has been tested with following cases:
> * '-M pseries' / '-M pseries -cpu Power11'
> * '-smp' option tested
> * with compat mode: 'max-cpu-compat=3Dpower10' and 'max-cpu-compat=3Dpowe=
r9'
> * with/without device 'virtio-scsi-pci'
> * with/without -kernel and -drive with qcow_file
>
> Linux with Power11 support: https://github.com/torvalds/linux, since v6.9=
-rc1
>
> Changelog
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> v6:=20
>   + reorganised patches such that Power11 introduction is at end, and
>   cleanups and fixes is done before
>   + patch #1: renamed macros from POWER_* to PCC_*
>   + patch #2: rename 'logical_pvr' to 'spapr_logical_pvr' to better conve=
y
>   the context
>
> v5:
>   + split patch series into pseries+powernv
>   + patch #1: apply harsh's patch to reduce duplication
>   + patch #2: simplified, by removing duplication
>   + patch #3: update docs, according to harsh's suggestion
>   + patch #4: no functional change, #define used for P9 & P10 pcr_support=
ed
>   + patch #5: no change
>
> v4:
>   + patch #5: fix memory leak in pnv_chip_power10_quad_realize
>   - no change in other patches
>
> v3:
>   + patch #1: version power11 as power11_v2.0
>   + patch #2: split target hw/pseries code into patch #2
>   + patch #3,#4: fix regression due to Power10 and Power11 having same PC=
R
>   + patch #5: create pnv_chip_power11_dt_populate and split pnv_chip_powe=
r10_common_realize as per review
>   + patch #6-#11: no change
>   - remove commit to make Power11 as default
>
> v2:
>   + split powernv patch into homer,lpc,occ,psi,sbe
>   + reduce code duplication by reusing power10 code
>   + make power11 as default
>   + rebase on qemu upstream/master
>   + add more information in commit descriptions
>   + update docs
>   + update skiboot.lid
>
>
> Aditya Gupta (4):
>   target/ppc: Introduce 'PowerPCCPUClass::spapr_logical_pvr'
>   target/ppc: Fix regression due to Power10 and Power11 having same PCR
>   target/ppc: Add Power11 DD2.0 processor
>   ppc/pseries: Add Power11 cpu type
>
> Harsh Prateek Bora (1):
>   target/ppc: Reduce code duplication across Power9/10 init code
>
>  docs/system/ppc/pseries.rst |  17 +++-
>  hw/ppc/spapr_cpu_core.c     |   1 +
>  target/ppc/compat.c         |  11 +++
>  target/ppc/cpu-models.c     |   3 +
>  target/ppc/cpu-models.h     |   3 +
>  target/ppc/cpu.h            |   3 +
>  target/ppc/cpu_init.c       | 188 +++++++++++++++---------------------
>  target/ppc/cpu_init.h       |  92 ++++++++++++++++++
>  8 files changed, 205 insertions(+), 113 deletions(-)
>  create mode 100644 target/ppc/cpu_init.h


