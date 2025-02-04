Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC7DC02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 16:19:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfLeB-0000ZJ-Av; Tue, 04 Feb 2025 11:19:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfLe7-0000YW-9Q
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 11:19:32 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfLe4-00012G-J6
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 11:19:31 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-6f6ae4846c7so36269107b3.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 08:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738685967; x=1739290767; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8MW5tuW2gKGotYFpUS5F9VTI/Y9qqqDQDzPWrbVRau8=;
 b=e2cloNvYqp2XfZJm16Psc6iPSYe3t4lD+D8aSZTNcqmnredNADwoahnza+tFcyVHO4
 M/T6W5lCTkuo550coLSwDVQozhFM0fQyRWA9svgAzChg/zbepM5IE0ZUkD1U772U2RBk
 ouxdSaBA4fiaZTBD4n9l0rcb5FOUNFXU+6KVKsWnrpIE8PgyRdoWq9qmhA//vDunlzl9
 nLnL2teLoc64x+xycjaZ+5o/Ywegz48mOLi3E8kgJSZC+zG4ZG75rU7QA2Ldkq08RxfH
 L6s91/b5mJNufvSYAiHsAwqrOhzS1R9eJURhS6mxhEslscLHkP5bUq2QvNkwKt7adC7c
 mfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738685967; x=1739290767;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8MW5tuW2gKGotYFpUS5F9VTI/Y9qqqDQDzPWrbVRau8=;
 b=my4W8pFPdw1Gs45/0JtlYrZlrXoVWK7spyow9SQ6J7jOVfVrjfU99bD5ZnFMIWi4Ml
 3Q6FZUrdotb4rcmusUJl1Y778w2p27sKGHm9oeidD7IFjGpLsnKUnaV428hqIcZuDMNU
 v3x2Bei9RGWI46Mu45ZtOeXV1TBJ8gL33e4TRKj6vFEL/GRkhO89CzW6E0GRbjaiDp25
 J8EKRub0pFbu1Sq99wp0ZZuAnrhl/DJXLYqLrrSX0cen0nFz9sa/7WBo/BihHeE0u/dX
 /cyrinAEThRhnoVxLEZrOHl5SAqD8E/pdefYYBCVv1f6ZrjCtHH3lOla5WvhOhbzq0E2
 +6nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWKXTuxrWZLiAmh6mMbWUkovgW+vMq51LkMMC0yKCaCM9obwHBs3DdSmML/b8SRvGvCZg+qifLWEnE@nongnu.org
X-Gm-Message-State: AOJu0YxiiOPE0MhapiVf7TSxdwDbZ+iL8bn41RISIcsXbW4/z2r/cVq+
 YXcfyowpXqT0+oO+5JE7eBiQZICTjsCZvgmH98zti1jihtkGPn8Zn7bb+ChgpM38j2cnLdmjx93
 6LIkIoGaJ9xpdbBBsUmlq0V0WKAoYOpMAO4GS1w==
X-Gm-Gg: ASbGncvjODPPIccH4q2si9HPBGJtJfiLSCdV9M6J1dnroc2EIjeFcbxt2v9j+V56Nhl
 qdQRCUCEqTNCUtFQrDnvYD40c0TmVsUcmypvy3g/5UgAB/C18zqSX0+Kp0PZENFVKzFVs00SRtA
 ==
X-Google-Smtp-Source: AGHT+IGjN34GP+lTReTclDofjMTkXRkl8KjIhx7anA8mG99dgY86aarWLoJ1Wx2iIRtrC8JDube/3PV7gqFC7slx5yo=
X-Received: by 2002:a05:6902:1703:b0:e5b:1746:7fa2 with SMTP id
 3f1490d57ef6-e5b174681f3mr2265570276.47.1738685967167; Tue, 04 Feb 2025
 08:19:27 -0800 (PST)
MIME-Version: 1.0
References: <20241226082800.2887689-1-wuhaotsh@google.com>
 <20241226082800.2887689-16-wuhaotsh@google.com>
In-Reply-To: <20241226082800.2887689-16-wuhaotsh@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Feb 2025 16:19:15 +0000
X-Gm-Features: AWEUYZm-5RmDaqWTDbReZw7uVeALP41h8Gx2Boup1-geX_D0aipJU6zT34pfxio
Message-ID: <CAFEAcA-dRMcUL2oHygJOnGZvzT4yWPUgBDYhkfPOgexB9w7_Tg@mail.gmail.com>
Subject: Re: [PATCH v2 15/17] hw/net: Add NPCM8XX PCS Module
To: Hao Wu <wuhaotsh@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, titusr@google.com, hskinnemoen@google.com, 
 venture@google.com, pbonzini@redhat.com, jasowang@redhat.com, 
 alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Thu, 26 Dec 2024 at 08:28, Hao Wu <wuhaotsh@google.com> wrote:
>
> The PCS exists in NPCM8XX's GMAC1 and is used to control the SGMII
> PHY. This implementation contains all the default registers and
> the soft reset feature that are required to load the Linux kernel
> driver. Further features have not been implemented yet.
>
> Signed-off-by: Hao Wu <wuhaotsh@google.com>
> ---
>  hw/net/meson.build        |   1 +
>  hw/net/npcm_pcs.c         | 410 ++++++++++++++++++++++++++++++++++++++
>  hw/net/trace-events       |   4 +-
>  include/hw/net/npcm_pcs.h |  42 ++++
>  4 files changed, 455 insertions(+), 2 deletions(-)
>  create mode 100644 hw/net/npcm_pcs.c
>  create mode 100644 include/hw/net/npcm_pcs.h
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

for basic structure, but it would be good if somebody
who knows the hardware reviewed it for whether it's
actually implementing the right thing.


thanks
-- PMM

