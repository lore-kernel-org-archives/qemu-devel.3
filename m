Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4C7C25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 14:06:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA95T-0001LP-6Q; Thu, 23 May 2024 10:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA95R-0001Kb-M2
 for qemu-devel@nongnu.org; Thu, 23 May 2024 10:06:29 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA95Q-00027K-4V
 for qemu-devel@nongnu.org; Thu, 23 May 2024 10:06:29 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2e6792ea67fso95066351fa.1
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 07:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716473186; x=1717077986; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9rFSUfimECnsvmjfdVjPqkmnRMPFPCgoStLOvy9N2Rs=;
 b=RKIibIPjvphB4IfvZ3ei8I3Joe3HKUjXAkJAA2QeICfq5Z9U42yglwDDY19GMxJR/e
 61pnpqeCmQIJ2/84exGjJZxsXF8KIHQ3V4vX1c1YLyoZAsPVDdG/+NTHbrCQJzTh5kF9
 TSrgtGJnt2+ebq90eoL7I24Fq48BlKHJYVq+K65zvkFOkH/ZYdzXJjvR01S2JNzhTFW+
 GfR8CgbC9RDdNTIctWqZAq+GCbzaP7OhfRqz8kEjcpbQ06qihOn8aSqTmkcef9QqtwnK
 Tg/9YHc+XNXbhUs0Pw0bZOtjxBxePaYo6n2pES1U931TGWFmAQxt7143Ob8CtB0a04Aw
 OYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716473186; x=1717077986;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9rFSUfimECnsvmjfdVjPqkmnRMPFPCgoStLOvy9N2Rs=;
 b=qsaIOHVJqycXnTcLaMnNOIdaCO8GvxL8wxc0GszOtDTI8AE3tacp621OyViYwPAI3Z
 FDAurkMWirhHnm3cYow4hTt9MJzcH68FkJ9CaQPum/3HR4QpuPoAuy5yj6bkPjvrE5sj
 0EOImPiJwqkemnsdaz83mDV7C+npvMoii5/CIUnjVuc8dV067nupdtj5bIsOStOO3upq
 Zr42KC3cHh6QNRqJ4rONz1LVGsEFhxvGuLvmiBez17Xcoe8nGb1PILwBlb80X8jMeR7a
 hZxq7+lNGzg5Z9ImPHNSOESIf7Y3BRUA2YWs7pSTlmpIo4gWK9YVblKYXravtYQEyEDi
 900Q==
X-Gm-Message-State: AOJu0Yyi5nOFvi4iHIhfB4wVCvbj/PPB0Bn5Ku65uIYKIZRJCLIB/WlZ
 8rlTOjWnD1lAuxO/KGlQ62CT1sMew+YmyWmZpi6QM+xUv3L/2eBvD0HThvsNw2O08xes14n1mNx
 XcWD25FuGkHMu69Hhlf/ymIqxyIsAa38P0xDs5y8QVRCt1hJ3
X-Google-Smtp-Source: AGHT+IH8jReCyFA8pEHOqhTnu2ti0caJaFoL14cNNoAOW80uIzf3mg/5mWHurD8WzKu9ldbC6DN7EotdDXgKpikeVSE=
X-Received: by 2002:a2e:914c:0:b0:2e9:5389:f4bf with SMTP id
 38308e7fff4ca-2e95389f520mr10678061fa.7.1716473186397; Thu, 23 May 2024
 07:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240506010403.6204-1-richard.henderson@linaro.org>
 <20240506010403.6204-29-richard.henderson@linaro.org>
In-Reply-To: <20240506010403.6204-29-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2024 15:06:15 +0100
Message-ID: <CAFEAcA8pt44cfB-f+2F4J7du+MvktZfBozUvjJoeOug7Q+FUyw@mail.gmail.com>
Subject: Re: [PATCH 28/57] target/arm: Convert FMLAL, FMLSL to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x230.google.com
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

On Mon, 6 May 2024 at 02:05, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/a64.decode      |  10 +++
>  target/arm/tcg/translate-a64.c | 144 ++++++++++-----------------------
>  2 files changed, 51 insertions(+), 103 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

