Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B76DAC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 15:38:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH2Z8-0007oR-Cn; Mon, 19 May 2025 11:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uH2Z5-0007gZ-AL
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:38:07 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uH2Z2-0007S2-H0
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:38:07 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-703cd93820fso40502867b3.2
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 08:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747669083; x=1748273883; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UTyg3KKxLAz6/kpwgi2CoJ6gaTf37AQ3cfdkNk5Fnno=;
 b=oR2w4gHkaM0cpfRWVM3gXZWLbYwbeSm+WhZE4pZ4iVJ5csExidojphOTVrCOBBmGFp
 CpEXFJitPDLeGxcopEzc5qaCpVH1kOeZayqcwNfBCnPtc/jtsnwmeshNR2vtk3ETilBV
 C0u6nCuTGEnrqlCCQizzVxd/kVOY5UR3iPInpaWrdLv61Fi907pedLJEQ8rrEu9pPFcR
 An/PbCwg9OEdvRKEPnM95jE0dJfkO3Da3W4rpLglr6gGyQLLVhb+s7GwspyfFa76npNY
 8FxDOTJE2XMH4n2TlbPQEB3aSeb5jy+4JPzzpZYhJ6SpZ6hVoa0EKCtdEhmVYPqGgscO
 +9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747669083; x=1748273883;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UTyg3KKxLAz6/kpwgi2CoJ6gaTf37AQ3cfdkNk5Fnno=;
 b=kJ2CxvGA3DX3i65PdbSuh03cyF9RN9T50OZQJ7yjFnDXlB/4yS4JnMfWr0oLtzHZHJ
 aZPB5x+NpCOsprDjWNl5d5fhav9LjJ5qlMy83HUJGVYk00CqadnRlQsEWB/mvstUgv5u
 H+4DWn3X19t/Lsxlu1p7GyM2nif0YCNQoKSsHm+c2XMDFwgnfX2D8Uw9Yf9+/F/McbPK
 u8PhHQbXYnwFrV+NUvUEOb565W62itnk54ZbPSVMNuS6aahdSTyl85T0GNWW2VIdQRMn
 Tq+FPPbQWmhD+dpxUvvCRsN/LhPjAfFhDCMGraitREjP5tT64qgGE04WzeIqZPWj9sI3
 Mpxw==
X-Gm-Message-State: AOJu0YxQgRngWg25nXqmueHMZki/jsXd+HSlordcic6vVuhorxyxQ3Be
 5KdmPeR4ot1vtzVxF+u95jWAz7VOBQ/LCQhnib+Lg75+sxVzb/FsPULzIDENOexK0E/da1KoCZC
 vFC2kE4DmzaH0NRYl5DbLUz1VcmOD95Ae8dpioFFDVQ==
X-Gm-Gg: ASbGncszT58mVFuc+cPKsHaOnHk9Z65JgX+gWrfKM5V/HXfO71afQUFJInxW49FyXY7
 CPDbSWIInJGV0TvBXRlMtWa82KdNPr0HGaLi1HLCebQttMseNvFm0kykwNNknQhNXmJqe9ig5Gn
 RYnpqT40FWogNOau7EhWPK51tme6JJ6vpWUg==
X-Google-Smtp-Source: AGHT+IEnxWRXNIlBhPvtBtBArJ/ZWi+tX9dsb9T18HFZujNv37NHPZhzEj3XF0k/kz4tcSPLmd+GF80cg1AiShdRzWg=
X-Received: by 2002:a05:690c:660c:b0:708:16b0:59bf with SMTP id
 00721157ae682-70cab0bb8b4mr181576317b3.26.1747669082768; Mon, 19 May 2025
 08:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250513141448.297946-1-chigot@adacore.com>
 <20250513141448.297946-5-chigot@adacore.com>
In-Reply-To: <20250513141448.297946-5-chigot@adacore.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 May 2025 16:37:51 +0100
X-Gm-Features: AX0GCFu3jjc_yELAUeeYct48GUQy9tp5v2mEXKVH2mleh-jOQG75mmHSIUVFGxA
Message-ID: <CAFEAcA8qA-ZyWihgSkw3Ubnz-WyXMB3m_MT9facnktqbXAM7MA@mail.gmail.com>
Subject: Re: [PATCH 4/4] hw/arm/xlnx-zynqmp: adapt cluster-id based on the
 boot cpu
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, edgar.iglesias@gmail.com, 
 alistair@alistair23.me
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

On Tue, 13 May 2025 at 15:15, Cl=C3=A9ment Chigot <chigot@adacore.com> wrot=
e:
>
> When gdb is being connected to QEmu, it will be attached to the first

(QEMU is all-caps, by the way)

> CPU cluster. However, the ZynqMP board has two clusters, those being of
> two different architectures.
> Therefore, when gdb is connecting to the ZynqMP, it receives the target
> descriptor of the first CPU cluster. Up to now, it was always the APU
> cluster, which is AARCH64.
>
> When booting on a RPU, gdb will still connect to the APU. If gdb is
> supporting only ARM32, it will receive the APU target descriptor,
> resulting in:
>   | (gdb) target remote :1234
>   | warning: while parsing target description (at line 1): Target
>   | description specified unknown architecture "aarch64"
>
> Adjust the cluster-id based on the boot cpu will resolve the above
> issue; allowing a pure ARM32 toolchain to debug programs running on
> RPUs.

I'm not really enthusiastic about renumbering the clusters
like this. I think you should be able to get gdb to connect
to the second cluster via the multiple-inferior support:

https://www.qemu.org/docs/master/system/gdb.html#debugging-multicore-machin=
es

thanks
-- PMM

