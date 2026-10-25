Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A146A606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 09:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=RYLw719D
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKuyD-00031D-I9; Sun, 25 Oct 2026 05:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKuxu-000308-30
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 05:56:36 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKuxq-0000yE-M9
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 05:56:33 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-8ab43af5e97so20253927b3.1
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 02:56:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792922189; cv=none;
 d=google.com; s=arc-20260327;
 b=mV9MhW77bLUpf5SEdZfuKjTnznuJmixMbkuubyt3g1pnCZL6PEffVZCR0Ujo5K54jS
 GDz0K5UNHBunH1dinnRRqNYF1jRBCaGbaY8xTcyqgDTQJ22OZzr6Q1q6Vs2fWn0WYkbx
 n9ODtpv/2tDnGsBIrvhQTaVqkKR1MZmW+5OccOz1B3yjyeZWB0Clqazql2oRHeV01os8
 UHCjHU2vWihRhFD8MI3icwhJt2bMWDi2hrbpj4QkfRgMXVqGBFh9husLtQwrchGGZqGZ
 zTUc02vzVBP6b4Ec+TpxSfvR8hlgXG09g96TtJUynS/aukOKKiwfile2h4xb1WRVU8Kj
 2h8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=h0l+ojj5sB1J/f1DDKsR0fDF26ZMQzeqNQMEOYiQMT8=;
 fh=9vbVNIdRsO0paNhZWc2/4JcInsvPbgZ5nIOMIbgIuW4=;
 b=TlU22Kr1xhSE1Ntg94u4/dYvU243nPVfthMmbAwkfGRIZb1R0bzCoMcq2JrE/CNK3v
 2TPGFNgRkWgjb+CHw76n8H1630AbkD9nlQrBGteIUxfHSemQiycKDMEQtbCnYAFGZsjH
 GDM1m9js66hHc5fRyohYIdJ6s1MtH21q7gciGS2hCiRUGp9fpzod4M1XYAwJsuacs/uH
 nwJ7+7Ntf/W2fLor4fhai7XbRTnEI8ar0pbe3avmvgUGiR2dXFoDTrAXcXmzu5Jersca
 KJ+cWHfjevrSLVNDrXKVmvdUmaU5vmXnGwYQ2P7ffzoZ+vV5u9bQvDPWubo2ZcGiUX9x
 t8Lw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792922189; x=1793526989; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=h0l+ojj5sB1J/f1DDKsR0fDF26ZMQzeqNQMEOYiQMT8=;
 b=RYLw719DpzL+9Hu9NFU5LY1neySe2fPd9nYnuolM6v8ZY9Jm1MQCidRnvAtqtmLDRx
 3/pctZrLlQHOMd1mXJj0M9+tlbobnahsd2qTVEIgUMz9YCnN0AuSaqS2ylRRaMhxYulU
 VZPGY3ehXbACTEdiYaqmEryCEJKzhx8wQBLtYjveez+bhEGlETSA+kDnU8MOth6sDrql
 Qhaa9UjgrTrEaoIUCHLXonHUT8nIaiR+eCmyTBskFNp+oWUyLgq8ZUTOE3Yz+7R2jfnZ
 Bsh56qGFbopP315ryNW8JM5cpN98dm9yxz1s5IIOCL8IjOWeUzj5z75riZlJGqs+LOg8
 c2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792922189; x=1793526989;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=h0l+ojj5sB1J/f1DDKsR0fDF26ZMQzeqNQMEOYiQMT8=;
 b=iKiK1bBHv8ygfCvyNUDdXlX9g7EUL7Qk2uoN/A5OiQGFvPks0nU0DhPqRpWukedCuZ
 rbpn6Cuo+pgmIoqHqiJL5+ds15N6dtuW/9FmxmoOA6NGN26fOv1cAmcYVkZfI+dsGi7M
 SnZZKK2Rk/rcQsSfMwJuj0F4u6OWDIumAgaKA9/EmH0FXKV0X/RxpzalxTIG8dnNttAv
 8OJLKnpe+vB/mrHejiwrmRV2REy6vkx/IfjDEWShze7XgiyGz5jvPNpi9BK+iCHWDUSE
 dxZUdbfzVXdENlxgWkr1c/+BpGiN/Kg+aUKGPzp/Jn1fIU18wHXgb07vAr2QMAPiZ4f2
 LwgQ==
X-Gm-Message-State: AFq9FYJty/XRPy/RVYBtcV19kcuXKsXAu2bhOwwHv2RKoNxzx5IJHml5
 1s5vZLb5In2VcJM/4FaVwTujxsxY3co0vT5R+nOOCBOUM+Fn8GsIEAl+xd40vc81qcJOWmDwFRI
 xKo+HinWh8IDC16z+ebmXxsUGClF4pIMXLrHuXh58Bg==
X-Gm-Gg: AYBFou3vMleumofI6qBuhY2+Z8t5QXvpq1gqcPxdEi+bFZcuDR7nSKfmdUiuDxj2jz7
 B7mEQrvwFhg8NJOG5P9hLCvQ5lHXtf3ilUrB0iIckhMRCStucPlg4WSDRKu6hi0xsdE8Nvk0+pw
 0+XRdmMFybwYyxo30FmIYSyzb8gHgyamJdCYYnMV4LwfzmEPnefQjuM/CO2igWK+6/4NYs5zwy2
 1PdbE5XbYczsMopkxFcqiM+5QTmiBlPk2/l8CmpQbeD6/ilQ673wQE6jvk8ZN+bLyXZ7tXfeCUU
 ffzNwJJXnYveTlAi6AAKRaQ5LTzhB8ULKEDWheGnKAQZ84TWpZQNpE6LsqC2Yjo/T3FKFU6Yox3
 jJv8Lx5tcUMubKxCrj9DdQgaZAy2V5m7hiaMlNJ1oYE+/9e04KJXVKlFwjSsdyDf6qNootf/bj3
 B2qet9gBzCEra+jif4eFE2
X-Received: by 2002:a05:690c:28b:b0:8b0:d206:16c1 with SMTP id
 00721157ae682-8b1672b8498mr30220497b3.24.1792922189011; Sun, 25 Oct 2026
 02:56:29 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <DB8PR04MB7177C8ED1A20409414A573EF87622@DB8PR04MB7177.eurprd04.prod.outlook.com>
In-Reply-To: <DB8PR04MB7177C8ED1A20409414A573EF87622@DB8PR04MB7177.eurprd04.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 25 Oct 2026 09:56:16 +0000
X-Gm-Features: AclHuK-ObOQZb4FNm3SbmMLELXO4FWJlsv3oNzCJC-28TZNxR6bY0K-dU6hWuPM
Message-ID: <CAFEAcA-dpfXTLk9KNJ0OsOEaCYppcZLLgcnOCqhUXmOVE2jfaw@mail.gmail.com>
Subject: Re: [RFC] target/arm: Correct MPIDR.MT handling for i.MX95 Cortex-A55
 Aff1 topology
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Cc: QEMU <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 25 Oct 2026 at 07:14, Gaurav Sharma <gaurav.sharma_7@nxp.com> wrote:
> I am looking for guidance on the appropriate scope for correcting Cortex-A55 MPIDR topology in QEMU.
> I have enabled and tested i.MX95 machine model that boots the complete NXP firmware/software stack from the emulated boot ROM:
>
>   Boot ROM
>     -> System Manager firmware (SCP) running on Cortex-M33
>     -> A55 SPL
>     -> TF-A / BL31
>     -> U-Boot
>     -> Linux
>
> For testing, I am using the Yocto-generated WIC image from NXP's official i.MX95 Yocto BSP as the emulated SD-card image.
> i.MX95 represents its Cortex-A55 CPUs using Aff1 as the core identifier, with Aff0 fixed at zero.
>
> Current QEMU returns these Aff1-based affinity values through MPIDR_EL1 with MT clear. It is not sufficient for the i.MX95
> firmware and Linux secondary-CPU startup path.

This is https://gitlab.com/qemu-project/qemu/-/work_items/1608

but fixing it is complicated, because it runs into complexity
with how it should interact with user-specified CPU topology
command line arguments.

Some of the discussion on this old thread may be relevant:
https://lore.kernel.org/qemu-devel/20240419183135.12276-1-dorjoychy111@gmail.com/

> With MPIDR_EL1.MT clear:
>
>   - The complete ROM-to-Linux boot chain reaches Linux.
>   - Linux begins bringing up its secondary CPUs.
>   - CPU1 reaches Linux secondary initialization.
>   - CPU2 through CPU4 time out and fail to come online.
>
> With MPIDR_EL1.MT set while retaining the same Aff1 affinity values, the same complete boot chain succeeds and all secondary CPUs presented
> to Linux come online.

This seems a bit odd and maybe worth investigation as to why exactly
the secondaries don't boot. What QEMU presents is architecturally
correct even if it doesn't precisely match the real CPU, so
if it causes some bit of software to not work right that software
is perhaps buggy and perhaps being unnecessarily specific to
the exact CPU behaviour. Or is this perhaps a "DTB encodes
affinity values that don't match what QEMU uses" problem?

> I found QEMU issue #1608 and the previous qemu-devel discussion about Cortex-A55 using MT=1 with the core index in Aff1. The discussion suggests
> that this should eventually be a generic CPU-model correction.
>
> If there is already a planned patch for resolving this, I would prefer to align the i.MX95 work with it.

No, there's no planned patch. Somebody needs to think properly
about the intersection with the user topology stuff, which has
just never seemed to me to be worth the time and effort for a
corner-case of "we don't quite do what the real CPU does".
Since you've found some real-world software that does care,
we should probably look again at it.

> Otherwise, would a generic 'mpidr_core_in_aff1' like property, initially used by the i.MX95 machine and later extended to the other affected CPU
> models, be a reasonable direction?

I don't think this should be machine-specific. We know what the CPUs
which should behave like this are, and how they ought to behave.
We probably need a QOM property for backwards compatibility
for versioned machine types, but that can get set by the usual
back-compat machinery.

thanks
-- PMM

