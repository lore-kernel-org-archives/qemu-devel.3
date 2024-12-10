Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EDB9E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 17:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL3yO-00086x-LZ; Tue, 10 Dec 2024 12:24:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tL3yM-0007xA-AA
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 12:24:34 -0500
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tL3yK-0002o3-NW
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 12:24:33 -0500
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-6ef7640e484so67634697b3.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 09:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733851471; x=1734456271; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EgEYCeg0sBi60ySjQQV8yapCAvyGZXUCPWx5/9JamWE=;
 b=PXzoZpljFve0lPWo1yrbn1WAgsySmBq8Y1fNsAPM3gPIj5VzVZepysmbB8v6meNDvQ
 u5M3Ep/ZaJnKLNp+iLf+A6oacKtQ9lgpB6GYIBknrTBh8RV0+xWtcz7rwH4ySNXl/H1R
 ASB7dUvbVnMzN8jRb0s0NY9jc9SNU0cWhmjbt5IxLiGWPHPqhe77mUfy1T0AbAS1PsC1
 oq1+Tu1wJNf4oK7G4gmsS8IzlS22jyHH3aAGJf7G796cSA6ZCFSyBXUHzDx+R78G3S9g
 TAa+RY6+dXh2vrX4uOf/WpsyCd2CkPVL8obP+ZzQTyTfD5hiXxaL1PdkniT51+7u85Dd
 xs7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733851471; x=1734456271;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EgEYCeg0sBi60ySjQQV8yapCAvyGZXUCPWx5/9JamWE=;
 b=YUjmlsPDcqmrPkssmA4DYI18e+MBpZNk9rC4l1/zugkC1O44ENAZA9yLtuIJhl+Xw0
 okNXRWxlsIs6bQUUTSAAtOpMjyDfVSkhK9w6ZTmXDMBx6eYttazMaIZUF1mEAjIaMkse
 wRz63VdZCPKhE+MpEUESFVf8AC7EBiVOgrEmLO0lc6VZ7mOuSNAKhLvg/wuOtkSVSJGr
 5tN5wJpDNnp/28T6tFMw4tFGnhjdEgGh/TTRaXYKZWJ88nFaiezWzkaKdFQL3m97A4Ls
 BlcOJ2SoWu7zWAQNqOr4JZ7SwRdcMqciIAgwDX2eYUaPDyvcsexxdnHqjTQHSpkgkYst
 mccg==
X-Gm-Message-State: AOJu0YzDdFRz2sy4VHh5Bo+xbGKzJfbCArS9qaJqxIp/Bh5h8mAoAwvg
 rjXumCCeQMugNDt1lkl8/nprU9C2RtfcXhOm34bO2hHRbLYQuZK34Fi9DuwtXXO7/9WIGLQPWG9
 ICU6od+sgFhL5uIeVTezXjiOI4lbAB5HgNo86Dw==
X-Gm-Gg: ASbGncspk8qqJwO5yXn85Cb/EWRIEEBcUidzSSonDA7kt7qpLvjQPgddto9/lHWnumg
 m5wk7pG/UnXPZLsCzNYz8aD0whwWSFJ4IjMGT
X-Google-Smtp-Source: AGHT+IEcphesZm7T1dY5gyrF705H+h5RF4pqKYa/tPVyZWTubJK97vF6R04jXqHUDoaim/Vz427m5R5xMiimbw5ZeCk=
X-Received: by 2002:a05:690c:4a05:b0:6e7:e340:cd36 with SMTP id
 00721157ae682-6f022f99537mr56104587b3.40.1733851471307; Tue, 10 Dec 2024
 09:24:31 -0800 (PST)
MIME-Version: 1.0
References: <20241205114047.1125842-1-leif.lindholm@oss.qualcomm.com>
In-Reply-To: <20241205114047.1125842-1-leif.lindholm@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Dec 2024 17:24:19 +0000
Message-ID: <CAFEAcA_mRNGo6TOhSK-AciVmLC23Hmbvgtrgx8O=-BvtYM_hzg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update email address for Leif Lindholm
To: Leif Lindholm <leif.lindholm@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>, 
 Leif Lindholm <quic_llindhol@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Thu, 5 Dec 2024 at 11:40, Leif Lindholm
<leif.lindholm@oss.qualcomm.com> wrote:
>
> From: Leif Lindholm <quic_llindhol@quicinc.com>
>
> I'm migrating to Qualcomm's new open source email infrastructure, so
> update my email address, and update the mailmap to match.
>
> Signed-off-by: Leif Lindholm <leif.lindholm@oss.qualcomm.com>

Applied to target-arm.next for 10.0, thanks.

-- PMM

