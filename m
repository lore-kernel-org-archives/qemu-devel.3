Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF1A606A339
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 16:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tQs79OBN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUR8P-0000qC-Ue; Fri, 20 Nov 2026 11:06:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUR7v-0000nq-4r
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 11:06:30 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUR7q-0001SB-8l
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 11:06:11 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4bb702a7548so8561755e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 08:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795190768; x=1795795568; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dABwUC/EGiZ0nTjHQ6yW7QTKnoZCAoG825FE9x4uINw=;
 b=tQs79OBN83TiADh6aiskaleYb2A9lVcHlrWcXoIZfY+p1FaBhBLNKJjWKdyF/B4abf
 gQi2BzG2E2sNWKmmzhBLhHr+gqpkRu9MH0QgvAwZeXBy23NKO2T6SI2HyaMfXswA+UBD
 IIXS3MGYOfCmT2628S/tpfldUD9xFX3aVaxMDlOufGMOzM/45O1BJuqJ2Xu/lfgevpXy
 rmwKq7ymZASocEaBCyH6hSky7tMpSLV+eTfjheUyy8exS4svcr6AjD3ssPRLrSDBhvRG
 vm8pzGKDpVmpYm5mBbMir2Iq4aWqHhhpc9uolw5tixEGDcCVhakoY/3/nHEUKxEh+HBT
 o+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795190768; x=1795795568;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dABwUC/EGiZ0nTjHQ6yW7QTKnoZCAoG825FE9x4uINw=;
 b=pGWAjs8R1+orxcnRkLEJqW30yfSViZDGFppgh3QV/SudbTyQ/0FNoAdSrBh5CYP8BD
 sOvNeo9uVLT00PSLiqt7ErnhzWwVABasnov2IOEyTLzD2IJkLkHlF4YIGAkOumLBIOwC
 nxXzdyRPIWEQG92g7cfMRWPxM4n5zciiIqyF7whgNNtS4Zlw5Z3/Gk3w5fWkLYyOe2yQ
 DnwpoaxvVUxfcQ7faz9byoxhiTweFuGpZo2AtlHWR1gMIRtkzTRpj76uRW+xc0Qm8twp
 Ob3bXsc3FyadcH9E7JyYauO9s6KlgAKokUW4JX7hqQbX6LjknHmxpFnKLMC6H6SmrawA
 NCBg==
X-Gm-Message-State: APuU4Z+1yAZJ+PYRutXu0TgUuTU0DYM6zZXaH5QC2bchPxNR38Ta08wr
 8uqGUajOqupimKaEPR04EglY2eX1b/FCaq7p+ZSy+tkoaff5YbYIau0EcW4TxNIj5yo=
X-Gm-Gg: AYBFou2FFg9cP7fX9Y6RZxA22DILbwzJmuH1HmPDGjpVSz4rK/UDRera0ALuT5ahlxH
 oFjHP9alLpkR/F0m2/kfgVi6LxdBIAWGGdynCl4SvkOcXQKKUZ4dOigkeXmbDAbdgpDyCq6+/z7
 7OWDfbx8KElTe4t3PIFcU8ICmrBz+s/Iu/t8XPRWMv6CZIvosa2T/aP1p+5qst5mfHwt+9KfaOX
 4swdfO1gfAa1GUBuDUUGoWsUjOx7esrYdUYMQ4l55gNl7JmJYxYnSmpf88TCKhhJWWaHKFVwS32
 uf75ckglD73r8fguraJRWKe/XQtvsWsQIZNYq+AVxvCQzP4mPxJiE3m99J5DD7e0DEfihpCDl6N
 Lpx/5FpBv9EZp0yOnR9Y+m+eMV1je6UFM1Oasp8Sr78s+ra01R5jAZhCnVPUGCY5twnB8vPNDgL
 +Q8D1Cz3DVnJT4ndtjVDxbmN2UpPga8PkMjeqq6ggZ8mj9m4ul2n62sQwRzSI6fwss6bZELu7N4
 5X2kuLS60rujVD0qfGY0ut04RikcRDxWWOvoUVBfjC0INfbFQAskxarwAHUAcAK2gWon6dno2Fq
 FsOV3GC8wuecKva+vwNKbiL3aILZ
X-Received: by 2002:a05:600c:468b:b0:4ab:cc03:7f60 with SMTP id
 5b1f17b1804b1-4bb8881b511mr80822165e9.18.1795190768444; 
 Fri, 20 Nov 2026 08:06:08 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d1bsm6693990f8f.8.2026.11.20.08.06.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 08:06:07 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9D9785F7FE;
 Fri, 20 Nov 2026 16:06:06 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Aniket Sahu <asahu1x@linux.ibm.com>
Cc: qemu-devel@nongnu.org,  qemu-ppc@nongnu.org,  peterx@redhat.com,
 farosas@suse.de,  npiggin@gmail.com,  adityag@linux.ibm.com,
 milesg@linux.ibm.com,  harshpb@linux.ibm.com,  rathc@linux.ibm.com,
 anushree.mathur@linux.ibm.com,  misanjum@linux.ibm.com,
 gautam@linux.ibm.com,  thuth@redhat.com,  amachhiw@linux.ibm.com
Subject: Re: [PATCH 0/5] tests/functional/ppc64: Fixes and improvements for
 hypervisor tests
In-Reply-To: <20261120095854.35941-7-asahu1x@linux.ibm.com> (Aniket Sahu's
 message of "Fri, 20 Nov 2026 15:28:53 +0530")
References: <20261120095854.35941-7-asahu1x@linux.ibm.com>
User-Agent: mu4e 1.14.5-pre1; emacs 30.1
Date: Fri, 20 Nov 2026 16:06:06 +0000
Message-ID: <87y0an4he9.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Aniket Sahu <asahu1x@linux.ibm.com> writes:

> This series fixes several issues in the PPC64 hypervisor functional tests
> and improves their robustness and reliability.

Just a quick note to say the power hardware we have from OSUL doesn't
expose a hypervisor so we can't currently run these tests in the
upstream CI. Do you know of any way we could get such hardware added to
the CI?

Also I should note it would be nice to get:

  https://gitlab.com/qemu-project/qemu/-/work_items/3207

addressed. Let me know if you need access to the system.

>
> Changes in this series:
> -----------------------
>
> 1. Replace deprecated datetime.utcnow() with datetime.now(timezone.utc)
>    to avoid deprecation warnings in Python 3.12+.
>
> 2. Pin machine types to avoid CPU compatibility issues between the L0
>    QEMU (which now defaults to power11) and the L1 Alpine guest's
>    packaged QEMU (which doesn't recognize power11). This fixes
>    "Register sync failed" errors in L2.
>
> 3. Add kernel command line parameters (console=3Dhvc0 usbcore.nousb) and
>    early panic detection to fail fast when L2 encounters issues, plus
>    retry logic for apk update to handle transient network failures.
>
> 4. Dynamically resolve the NVMe device path in L1 instead of hardcoding
>    it, as the device name varies by machine type (nvme0n1 vs nvme1n1).
>    Also adds comprehensive debug logging throughout the test flow and
>    writes the L2 launch command to a script to avoid terminal line-wrap
>    issues.
>
> 5. Increase the test timeout from 1000 to 6000 seconds to accommodate
>    the longer runtime due to apk update retries and additional testing.
>
> Testing:
> --------
> All tests pass on our PPC64 test machines running Ubuntu 26.04 in an
> LPAR.
>
> Aniket Sahu (3):
>   tests/functional/ppc64: replace deprecated datetime.utcnow()
>   tests/functional/ppc64: add kernel params and early panic detection
>   tests/functional/ppc64: dynamically resolve NVMe device path
>
> Misbah Anjum N (2):
>   tests/functional/ppc64: pin machine types for hypervisor tests
>   tests/functional/ppc64: increase timeout for hypervisor tests
>
>  tests/functional/ppc64/meson.build |   2 +-
>  tests/functional/ppc64/test_hv.py  | 140 +++++++++++++++++++++++++----
>  2 files changed, 117 insertions(+), 25 deletions(-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

