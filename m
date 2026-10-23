Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8311606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 12:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sE/hJgCW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKEI7-0005jN-Rd; Fri, 23 Oct 2026 08:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKEI6-0005iV-4V
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 08:22:34 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKEI4-0003el-Am
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 08:22:33 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-8b0f59a5fdeso7210477b3.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 05:22:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792758151; cv=none;
 d=google.com; s=arc-20260327;
 b=sD6v7Ecuz9Fl5iG0oZ93V31fkyLpjq9EQfjEiSBjqSxG9sl7vYBuhPgBtdaaRucKZG
 13VZoB5ey3PKcWoDuiSOebZy6cN/WgPy3AKNVdJZpi6yQCGRGMwJnFFwSMzZeCTGT1/D
 gy8oSAPqfc5r3yuX2nJeHlwot3wnKU7El3xrTHWwX9MwFg6Mw3VXsVXUQHTpV6M8HYD0
 bOIRsAoc1uSzBZPcydfJpfqCuz+mJr+Fs/tY9cG8RAB71HlszE08JhgZ+GkocOKuB7/i
 zO2nPyibZOfNvwBVecK/A4Ef8KgDdlituJ7SXxn5jYXwLA1LQkpuFOYpOvFif8aiUxqM
 R4MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Si/zMrYbvAA1FBGBmaojS43YWyPfsmCfr5xq6CLJxHE=;
 fh=Ooov+i9AeS1BcC1vonK1zlp0+cy8hPMIIb5HY6/nc/g=;
 b=E+auM4kB1WLTK6kuMDUI8NkCtOuxPTZPzKnL3+hlXHXda0Kny2Eakn39+50hhh3oxK
 7gkBJB/VOKoqi2+h9S0JGqxsVUDx6tsNuppGcJP+em1xPpKZYBtwsuDvP2Wdb5Et7x+m
 oc93XpsRYwc+CO4RBV+/kvOP/VWkAxUVkbEcddfJ/WNTN88pSWTs5zTc3euTKUFOEum7
 QWf+zQrVQrepexqqflP7Gynh+vJEdUPLDMl0XwXWNK0PP/CZWpt4/RTOXbZu9YF/ZQfZ
 +QewF9c/ud4cLAZ5xJvh9d12FBf5XbeSo3xj5YIvHHhJ15POJo46/bKKTUl1FSwMIZaC
 JwYw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792758151; x=1793362951; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Si/zMrYbvAA1FBGBmaojS43YWyPfsmCfr5xq6CLJxHE=;
 b=sE/hJgCWJErTBDdKQt1XByFTlZ6B1qP/7+cwtnSNL22egyM27vhp+424i5zXPsj/Lk
 TA/bkxhZHD/C0pMv0C7fRePaf8ZB5YBDYxfJDln61FXIPW47u6WEjzAXxmBA20QAUXcP
 xuy/26X/rQD05rSohaFvzs4rg52CA/Dt4MRItlA1OUCeIXZYMJy6rXnXBWWT4DATu+rj
 rzKe76Y/IXjwlOGvcezKfXe6zbsqt2LUymcE7DFtYivLPVPXtVia4zvd/MX5N6HwkVpB
 dCMM/7LnO0peOzahBNFWKifqtKDssC61N6DAvMOQe3UvLLzuDOD2BtDyDLSby4yJKan/
 n61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792758151; x=1793362951;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Si/zMrYbvAA1FBGBmaojS43YWyPfsmCfr5xq6CLJxHE=;
 b=pF0S+Ozh6OmmLDom4UjQ2JErEsXyrPKPnNBr6RJcLfT8AJ2M/rScO7z22yJY6pG2W5
 pp6Y/E1edJ3r7/cL9T00d1Ss2C0SIYtiKpgiqjtkzyIPq20To7AIjfsJkrrvE3WW1DC4
 zpGzs2QX7g+DsKuBiLVw8x9X9n3itwQ85sC5hCkZVQZB9QogNcODIpJUgqdxWZcFhYVz
 z2iNdfUgZIdCWbOcl4+4HW1EZltvvIH8CwjYITkSaJmAU11Xk9Rc0E7FlPSMverOkqor
 Fsxu0aI2zQpVAKxF44cMiKMzPI4CCAaCOnHAe3NJ2yXrWB5BZyFSXEQTYSwIh+ABf4/2
 C3oA==
X-Gm-Message-State: AFq9FYJx7Ehp3tcB87OEck1Ypf9XeIgkrbkBGIPeYHU31cJaCIvtb2Mr
 txJmNDp1fXhevUHe3fffpIuY5IO3Wq1cZ6N1EEFJDlWjhTsxOM6MGNx3ppkKNWFrFQrofy+Dxf9
 wM6tnjmdz/8JYJCI3hhyu22jeUURdPjMvGBkqHpH11w==
X-Gm-Gg: AYBFou0WbGaokM+9UhrcVIBaBypA6xYrkKJq08uvB824LK6lJWqSiSg6tV5dL17pGQQ
 VN6F+Hh9XPDxkHlluYpdH0aSuJ//WRlsyLu85UDpqvr0run5vHnxRAOA5UzlhS4sYhUGxODTMvr
 QWTPnoBCPaWnYeIgp3Zl1ItuRfRE/8axJJSiuZPnb0varKEJ4Kf6BB3rA1Jw+zv+UWVug/50oKc
 49cCVdhaaD+fnPThN1jBM++ggXsiCh0/qo9Qh6NxtbdS48/uRVLgwdnij3zetj/NpTfESBoR7Gx
 ldaCzOJX2Wb1nAsjgssN1IJRKrgvmnw682FR11cImKfz7awHjdTyUEZ7gzWn4uPJAfJp3xjQd7s
 ZUqhQ4U52TvsqERq5ZXmKSY+YSvF+insGm/dlSLSrfH2S0nNGvx0ih3JxG3DWVmBVPgtxLvO6qI
 10GF/+CqPnl/IOQKXawL5zVdpMjfgLHLLsREGdKiBIOg==
X-Received: by 2002:a05:690c:c505:b0:8a8:c71e:d83c with SMTP id
 00721157ae682-8b157da8f62mr17192697b3.14.1792758151161; Fri, 23 Oct 2026
 05:22:31 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022213647.21665-1-mohamed@unpredictable.fr>
 <20261022213647.21665-5-mohamed@unpredictable.fr>
In-Reply-To: <20261022213647.21665-5-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Oct 2026 13:22:19 +0100
X-Gm-Features: AclHuK9iBuR0ekiA_HJtYvV8btVvIBsUx7iXXm1qL7f0P09OUTY9vDkbVDrlKJc
Message-ID: <CAFEAcA-Vw5z1qe-=a-JPLSX4q+8b+Fet-7ek7taoBEd6Mi117g@mail.gmail.com>
Subject: Re: [PATCH 4/6] hvf: arm: remove broken ID_AA64PFR0_EL1.GIC sync
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 22 Oct 2026 at 22:36, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> The GIC is only realised after this executes
> in arm_gicv3_common_realize.
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

