Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F275CC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 14:20:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmvnH-0005u0-Ua; Tue, 25 Feb 2025 09:20:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmvmz-0005pB-Mu
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 09:20:15 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmvmm-00076v-1p
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 09:19:57 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-6fb73240988so36960177b3.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 06:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740493180; x=1741097980; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y/5EpwWbz1TsNvc/h4VPdcsoE/3Ja0cJXiJhf1wslL0=;
 b=JLQ0mVc+m+fpVuBk6KX56txEV3KPefYpaY8lhfepufaTEDixODnTQSib1EOQOQogzg
 AGpSTXGijSobV5oNv33f5k0wZu6h7rRjekVe71Rh+zYDZwgpnVGjFVtg/jdXin7FRA/j
 iLCzoHGVCvPD5EwOLEy5vAtnNw8EgXjgtSCxz21949PMrRzBv4yyB8+0ITHHW/vNbmX2
 +jeRKoJt6VzthK4zeTb2nBg5ZtfXlB3YP2Iq7j7A04dBPK1GpmaJlCvYDHVdx72bHwsR
 zkAM/sRCOF1zP4phn2yYVN6kWJL+/DTsGGn4YBpRFoQE4MR3RK4gIR9cUkRC5e0csR+z
 fJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740493180; x=1741097980;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y/5EpwWbz1TsNvc/h4VPdcsoE/3Ja0cJXiJhf1wslL0=;
 b=jOfoNLHufQURbgTWxvcjZAWcqMyPLZms+/yUf2gcr8jhjSDftypeKjlWjt4706N32O
 jJ6avRvKDJnfjQW01HpViCBNIr5Ujh9xC/+mTN4ChuAiHfwOKO/zNakQ+DoTrTd6qRMd
 r/UR91VykIRyhH2/pieZwoa5CuWD419TmAoyMQScjbg/+6VddDJsBybSdbuIjADGEUMz
 DlCMOUSnHyxGOarku+ctOzfn4nfH94EssPeSc7ojznZoW0FRm61971mxAFZQekqGmGql
 ifj5d/pEI/ndxcTuGgxhlc4yYtLcRX39nQWArQ1zjajfGHRCXFhI14DMeFCcI3lEY5SM
 Jv1Q==
X-Gm-Message-State: AOJu0Yx59ffmd8+L+z/unIK8Bxoc5+gDkecmhgESCvpp4BtkhAisVbIz
 YIpW3gT7uOBV1tfBXsWTXLM5Ol6njR7xJnrxMuVUxTsw3/n8teGlVejq/G2gQHBTZf7fe4AWEmI
 OUpTfMup6Vh9+mtQ2//gqlB6tgkpcr2+55dxMjA==
X-Gm-Gg: ASbGncs37+SVAa6qKesGfVOMK1O2YtTOvHWvjtN85OOMapbHfmH408VACRUxpqw9YEs
 XlIhMPtJKAwFwb7/SznLkKdH2SEBaLO1QKwyD2NQnsCtraZn0t2sJ3ZnryNtYH7kDPvP1pvXmri
 GgqOPkLEN7
X-Google-Smtp-Source: AGHT+IEnuhA3euBFugdkJxI2MlLSR6MnBGzJc/PcbnmnkzqiqGbWEOsuuA+YDoGLtcOxy2I0HWAfiOnozdlY5eKb1/I=
X-Received: by 2002:a05:690c:67ca:b0:6fb:47d8:79ba with SMTP id
 00721157ae682-6fbcc23b1b4mr151642087b3.16.1740493179972; Tue, 25 Feb 2025
 06:19:39 -0800 (PST)
MIME-Version: 1.0
References: <20250223114708.1780-1-shentey@gmail.com>
 <20250223114708.1780-5-shentey@gmail.com>
In-Reply-To: <20250223114708.1780-5-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Feb 2025 14:19:28 +0000
X-Gm-Features: AWEUYZkiA8ylBJMOBdzMDx0ZNe4uoEr-BaRu_jet4eEXXg69S3CM_V--L4J8aog
Message-ID: <CAFEAcA_96RMUx68NTG=c0vwevD9LcCp0u7SKNnMx48yEePxYzQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/18] hw/arm: Add i.MX 8M Plus EVK board
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Andrey Smirnov <andrew.smirnov@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Sun, 23 Feb 2025 at 11:47, Bernhard Beschow <shentey@gmail.com> wrote:
>
> As a first step, implement the bare minimum: CPUs, RAM, interrupt controller,
> serial. All other devices of the A53 memory map are represented as
> TYPE_UNIMPLEMENTED_DEVICE, i.e. the whole memory map is provided. This allows
> for running Linux without it crashing due to invalid memory accesses.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

