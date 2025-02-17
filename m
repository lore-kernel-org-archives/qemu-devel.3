Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F34C021AB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 16:43:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk4Cu-000630-Hc; Mon, 17 Feb 2025 11:42:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk4Cs-0005rh-9a
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 11:42:54 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk4Cp-00084Z-B0
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 11:42:52 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5deb1266031so8022251a12.2
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 08:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739810569; x=1740415369; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kvaAb01HNcWfLd6UopGyk/zXIjjv/WR9CTT4cfI1NWc=;
 b=kMQE+vxy/zm3zrr0Oseh7lIjOun7CGZMiTUNEPyz7VX0sfqqdOUx+k6iykFTHTRt8a
 9qAipRcr461s5dz0xngS4OagYplhAzBDhewg5mHxzyeHIEOCyxANeoX98ajsiJutjKdp
 BSfV22GoScjuW1Bk0mbLgwyj5aI1tTfMitlgIYvynKFpAppMGoG7nxQ732Mb2xFicHX+
 rripUGPpRN+QPZZjovkQPmw1r3pOy1rAmpjbX0BUJwXgeYV7HliLx4TsCDnGXfzLvYG7
 fctNruWb1+uwlFa9Y2J6KwBv58wGGXjCZl+FlqkKs9bkcI5Bqoa6Kow70mzbB+yC6aX3
 a1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739810569; x=1740415369;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kvaAb01HNcWfLd6UopGyk/zXIjjv/WR9CTT4cfI1NWc=;
 b=rL97nDYtWTatpw4PrGEepT6Up1GN5w9LCd8Y2mb0Hy/E5OI9di7n/te0gHzHkgY10F
 rNwUqNH3rKbD05C0OCgh+iF8RoaCqj3K3SnE8l2h7Di/pOVw1EIeG42ZpNV3DWkUZp1N
 INUwM6dx2woFzzyL0Gax0NWvXfelkk2Uw3tsMGs78onNQYlj4UU6mkh+cIjx9MtXH92H
 qAz2HAifPfrqzlCulOGt6hV5lmqUwQcsBMFETw7y4Y4+Zknffv+m4XCVn0J8ZdbmHxEa
 D0tu4cN0qONism2nqKD3KrV7jt76LcBfKDRhWVdB8C3F5IbFR+ywzCv5jioceq9/uZxv
 vIcQ==
X-Gm-Message-State: AOJu0YwQEvJ5gLrXGE8NMhEV8PFkT15Tqutg9WSpxBv+yQcSXbxjFJa/
 BoMew2EhM2dGbMCdkOQYyjuiuoNa7pw+OfbWSiDjsmvhmd8NI7UMsQ5s/jt5tGBkpL65kOO5nyt
 niwqNy+3Y/KjNX5n5gFL2bLH9lYse5+CvLG7FYQ==
X-Gm-Gg: ASbGncsTVuhmDBsS15+AprqilIJVF7vaMN/47AqlFgwZPt9Zn7ri8EuYtZgcOfV5lYm
 mRTgDpMB9A/YdDfv974HUZqhdIEEmeX1Mi0pgEApkyndHnavNYoioIRNnBrp/M11RRlM00qwl0A
 ==
X-Google-Smtp-Source: AGHT+IHoMKEPnQMcZ6g6C4eU29ISG06R9rnydYXJ22WGEag3wC7aIn5aF5iOWnlQXeAkwmghWmroZgs09EjzSZARe60=
X-Received: by 2002:a05:6402:4609:b0:5de:3747:cddf with SMTP id
 4fb4d7f45d1cf-5e036044232mr9774962a12.7.1739810569122; Mon, 17 Feb 2025
 08:42:49 -0800 (PST)
MIME-Version: 1.0
References: <20250217163732.3718617-1-kchamart@redhat.com>
 <20250217163732.3718617-2-kchamart@redhat.com>
In-Reply-To: <20250217163732.3718617-2-kchamart@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2025 16:42:32 +0000
X-Gm-Features: AWEUYZmsWoTAkpuHOEcSF_yIx1KWwvcDMOBoK627n6UBb0N5ZDDqj8z_1CqHpuo
Message-ID: <CAFEAcA_bg-KdNV52oD55YrbzF8z0-i0nJPbhFgzKW-5AfdfvoQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] docs/cpu-features: Consistently use vCPU instead
 of VCPU
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, Ninad Palsule <ninad@linux.ibm.com>,
 sebott@redhat.com, 
 maz@kernel.org, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>, 
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Joel Stanley <joel@jms.id.au>, Eric Auger <eric.auger@redhat.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Yi Liu <yi.l.liu@intel.com>,
 qemu-arm@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Mon, 17 Feb 2025 at 16:38, Kashyap Chamarthy <kchamart@redhat.com> wrote:
>
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> ---
>  docs/system/arm/cpu-features.rst | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

