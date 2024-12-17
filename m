Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199D8E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 15:24:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNZR0-0008HD-MN; Tue, 17 Dec 2024 10:24:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNZQz-0008Gm-Cj
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 10:24:29 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNZQx-0004mY-RW
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 10:24:29 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5d3e9a88793so9069844a12.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 07:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734449066; x=1735053866; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KGacxlOZQAptlHnSzuUMpoaURNl1rAufdDjm6Dz77lg=;
 b=Fhu2+pmU2KLcS8D2MVUh+b5RGSoguHDZ0fFyYTUwJhgOAROYZGTyvMDAnU5NT8PCeh
 L8cXWi6pH+A2RQIpKaXJYja5GWC6tmb8n1Eg75nZV3Qe+dYYAfRnugzLH/jUHRZqHyfw
 1KztJmQKWW7kQyHqry87/XVdyM33ZIPP3zFPSW5E+rub0F2W7FmRTcywbIEy8pl+9z9y
 WECPBxxpaorJ7meGyDppY7X2y0awIBgfXvGzWo66RSCjlD2QQlRPPDzZ9pq7jkrcdXX4
 o/fBtQvS6Pj3FVREgFuRtJjs4yLID23Ip2PNtY3vFYe/g0h6UNqt24CJN78z5OYLX+9R
 B7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734449066; x=1735053866;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KGacxlOZQAptlHnSzuUMpoaURNl1rAufdDjm6Dz77lg=;
 b=WjMB+aBThd7xoVz3cap+1Fc+GLyInMkUSDEWtRX2krKz8VhVgQWg3CaoDxQsnsReUT
 4hijXXJODQuk5li4M/YS0PxAjbwCCXFOG4+bYPM3hkiKhvLD2pTuRrCsUf3AU3N0aUcW
 mS9IFAqdrkF2VueHIV5pHfY1vXcni8GTvqtehCxHEDXyinpm///XFDa+xVciVtxtvZME
 mt9nip6tbPImJkm7pBVjSxg3cBRbkaDqhuFXF/ZpnNPMjQqEU9jKffKl8fFm6ysnUA0L
 RpvRI+7/5TasZh2ybyyz7GcU/2gvcB/C7Af33Nv3dTyHDqym51IFhlOf+q+JMaF8JEOy
 rJMQ==
X-Gm-Message-State: AOJu0Yw7eRe91twZvqwckgkQmB1IS1R183EUSjlV0+khjcz2dT75e83D
 cErPKeCIgyyC5tvIUxwjwi9wMOUxB41OkFYsiBLrklreODY4jgc/fmKmVbk1Tq7uuOGHxd8ZHO+
 lg975RHxjzv8kkKI8FS+/isK3JLqdJGLRCd23ngh09/Dyd9f3
X-Gm-Gg: ASbGncuPslesasUSMHCJja6EV7t/UkZyzaw7YyXiAuVFdp9reZqfWMzYvF/OkS++61N
 JHuuPm9g8/JbXdtENjUcMRzb8vXsOfoz/JV6bVgQ=
X-Google-Smtp-Source: AGHT+IEPREsy3tCxR+oa0KRXVtr1Fc/ptbRSHNDCph9czTN2LKZENDbeysVTapx4FpC/zfsUXHN+wuQ5ujL9rd0KaiI=
X-Received: by 2002:a05:6402:35c2:b0:5d0:ea2a:726c with SMTP id
 4fb4d7f45d1cf-5d63c307086mr14679256a12.8.1734449065664; Tue, 17 Dec 2024
 07:24:25 -0800 (PST)
MIME-Version: 1.0
References: <20241125125448.185504-1-marcin.juszkiewicz@linaro.org>
 <CAFEAcA-V3PGF7vst8QFjh+bWVx5EGDt_B9ZCe1OryNV8e39N4w@mail.gmail.com>
 <CAFEAcA_SRU5UtttB=G2=L2YSK2D1U7Rumbc6eafioxR3yfnYUQ@mail.gmail.com>
 <7d5f349e-761c-459c-93db-cc32ec2a207d@linaro.org>
In-Reply-To: <7d5f349e-761c-459c-93db-cc32ec2a207d@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Dec 2024 15:24:12 +0000
Message-ID: <CAFEAcA_xRN_yjn1UCpD9xyv2Rkn0X0QzDzqUCd70W7L4ZNZb=A@mail.gmail.com>
Subject: Re: [PATCH 1/1] tests/avocado: update sbsa-ref firmware
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-devel@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>, 
 Leif Lindholm <quic_llindhol@quicinc.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Tue, 17 Dec 2024 at 07:10, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> W dniu 16.12.2024 o 13:46, Peter Maydell pisze:
> > On Mon, 25 Nov 2024 at 13:25, Peter Maydell <peter.maydell@linaro.org> wrote:
> >>
> >> On Mon, 25 Nov 2024 at 12:54, Marcin Juszkiewicz
> >> <marcin.juszkiewicz@linaro.org> wrote:
> >>>
> >>> Firmware is built using Debian 'bookworm' cross toolchain (gcc 12.2.0).
> >>>
> >>> Used versions:
> >>>
> >>> - Trusted Firmware v2.12.0
> >>> - Tianocore EDK2 stable202411
> >>> - Tianocore EDK2 Platforms code commit 4b3530d
> >>>
> >>> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> >>
> >> Hi; what's the benefit to taking this update? Would it be better
> >> postponed until the 9.2 release is complete?
> >
> > We're now past the 9.2 release, but it would still be good
> > to know what the benefit to updating the firmware images
> > for this test is.
>
> We tend to update firmware to the latest in all places it is used.
> Previous one was built from pre-selected git commits due to changes done
> during cycle.
>
> Now we got both components (TF-A and EDK2) from stable releases.

Thanks; I've applied this to target-arm.next with the commit
message updated to include the rationale for the change.

-- PMM

