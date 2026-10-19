Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC96606A335
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=YtsVf9kS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIq2C-0005q0-MF; Mon, 19 Oct 2026 12:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIq25-0005pF-DQ
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 12:16:23 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIq22-0000Gn-H8
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 12:16:15 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8b0d126f631so17579537b3.2
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 09:16:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792426572; cv=none;
 d=google.com; s=arc-20260327;
 b=CXnO0nB0daR56HlgKsQruDm0xL18JxAI5VFMQUtPe1Obw97rKJl5viZ7y3siFPVv+6
 OBEFH9UhWs7bvZ4B3f+NVFnbNGWwUvLOLX02VNw5kKWD7KErod2rSbAbFrdb1ZWZOx5i
 ++AaO955aqFTdcXLpDm1wulb7oczuLIcmkxN6tYKfX7sNLqZmVzlfkQIRa+j5VXKslTi
 F+Qb4n8YSyF361mIiAmAgTE3dxFxj1+ypP3+KpuDfT2Adgw/LVwDaqfbGOKwiTwdw1CE
 MGdVBYFiRdiHlM1vKmED2xyBq376som8WOCBsiZEqz0estkQqgVgw32X+W/7N50v/7+2
 bXcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cjTRbU1LBZ9spSw2mK1PCuLTMulEv+5KOYY8wSAXEXw=;
 fh=2pP+O1em66D2PRn9aGMPVObofMcBhXtCuMqUbD3jSgI=;
 b=KCnopNTpd98DJ69TD1h6zcaTkTrmjWfsVfpHHtvVgzR6dZgPGRTaewNHeEeZaZyIJa
 42fBp4zT1gBQ1r/wRG0U/+YvH70UPFX/hQEjmyydTAXLAGF2I8GKKaY+7pBYr+rESIw+
 A5LgOKZM8JvU+sJ0CmnQpGPByB6dq22FDJ3mBU7dkH5rCsV5wRN8djwN37U62MTHQoC8
 yhBFXm6vO4cdbUjiztD/P6Hu6sl2PljG8DJVF4GzdiVO2NLpseuGYUVyWXzXqxjexFKX
 RS6k5f4/sFBl2LyAStV+3SB9rbZH2kkN+rD2alxSCpbyceUsv0vXCor4ZGqK4f7XDws/
 oC4A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792426572; x=1793031372; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cjTRbU1LBZ9spSw2mK1PCuLTMulEv+5KOYY8wSAXEXw=;
 b=YtsVf9kSQDjjeB1HYJNk1vnwOLensmS/Z7nnU8bewQrRwus36y6eIYuprC0pOFq34V
 ybxLUeq/4bJT34RcsP4m9ryNmU3Lj7iMzirJAQsdSz1S5wGVymwpiFopKe1XY5v6y4yG
 WTMCKuhoT9pqHgsQn9dl+zVd5o4L7uISazYY1ygA4F1BtuMRxSFvjWuzqFuIfTD6NQLW
 scV6npIMtvxi6Pgbfx7UIVCOQaOYnysvU8vTsemSlfxl/2GxRwdAr57QNwIYXiCBQvdx
 itpW8gPKxITXKpgemmY9eJMv3s3DF0upT7TifUSzJ+4B5qccvo7wK+g54wEqLOGXj6pm
 Om+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792426572; x=1793031372;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cjTRbU1LBZ9spSw2mK1PCuLTMulEv+5KOYY8wSAXEXw=;
 b=MVVjEG07CzCjaZYIXDuls+G0vH0NPAAcDYWg5bn8y7BEFUd3EEtVZC87R0gqzbNr/G
 Zv9hLEqHriYArjjWn+QP+ay2rwr+eFlzAu6klLy4ZiWhIPox4nfbdjC9cOVwgAn2mKSw
 2nH1PCoHnsO6OshZnS365qniGpsawkfPIWkF7FRQZ7t9LCDOTns3ViQKF/uWFTuRFCWc
 AHBcf4WbpB5KSrY7Hijn5SON9Z2tT0ayNjZzRfrZlLDz6fYKl+KnI+yB4RAagsy8Vhcj
 fUzpkIQOHL68wH93eHiwyGZ5pNbpAWd25t99D6a7clWDjGR4ywnExuURNTcEfhZ29LwX
 0RwQ==
X-Gm-Message-State: AFq9FYJAhA7+n0pU/HdhNm2/RJ5LV+wke3ayey62MOEyF6ljop+DuhyK
 d3K2qyzcnhx9Hi1wygnKyqHsfI57XGe6Hleu3NE5/mVKN9TxXip21g151QEhOX0U18C5tncE5+5
 /zDomVLoKjPCoSuP1JXgdWpHZFP53bW5Jo0kI0ryzlw==
X-Gm-Gg: AYBFou1olmp0lHikbECxACEiHfSX2r/JjJq8VFsKYkbhcCbSZiB4J5+7OsxsiReE4Fc
 pR7dW1+Rvy2drAZMQDthOHAXkXuDWecORkZp3vc7EXxrm8c++tSBeXDD2JLJU8bNaMWjRbpwJCA
 wWfDivDsp5bBg9vOjyZB0UanLitXvTuM0D32vx5p80ntDfix5o0Iqc/3on+ntsee86841WooN6h
 ZC3Q6xXMPFfqdG9FiixtBM5U8xqREgXrJQlhBHppZE1ApIMmoBIHuGpOlVVKFQ3mQdmT904W4Ow
 stK7uNWs/+LY4AzQBxouKxHUNpFrVh4tJiGIr/D9w70Lyt13O8WZBWMKSWHypSLXDvxRACOjqiP
 j9blfTrzc5DxhI3SDLr7+LltMR921SiSOsmNdZFhbsrOLJRwjHQ==
X-Received: by 2002:a05:690c:298:b0:8b0:a176:fa5b with SMTP id
 00721157ae682-8b0f21e1720mr28769197b3.64.1792426571839; Mon, 19 Oct 2026
 09:16:11 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019155519.1302964-1-samanyu.goel16@gmail.com>
In-Reply-To: <20261019155519.1302964-1-samanyu.goel16@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Oct 2026 17:15:59 +0100
X-Gm-Features: AclHuK8ez5_ajExezvsC1O8Vj8rqTc91RB6BJ4JOKwGWecPbsGmlu_WHh9eqrO4
Message-ID: <CAFEAcA_QYXpjXdC8oiTfn2Z3E99hW0j-mcDSqGLhKfKKex8VsA@mail.gmail.com>
Subject: Re: [PATCH] hw/intc/exynos4210_combiner: Fix out of bounds access
To: Samanyu Goel <samanyu.goel16@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 19 Oct 2026 at 16:55, Samanyu Goel <samanyu.goel16@gmail.com> wrote:
>
> In exynos4210_combiner_write(), the bounds check used req_quad_base_n
> instead of grp_quad_base_n. Because req_quad_base_n counts 4-group blocks
> rather than individual groups, invalid offsets were allowed through.
>
> For example, writing to offset 0x100 resulted in req_quad_base_n = 16,
> passing the check (16 < 64). As verified in GDB, this caused
> grp_quad_base_n to reach 64, leading to an out-of-bounds write at
> s->group[64].
>
> Signed-off-by: Samanyu Goel <samanyu.goel16@gmail.com>
> ---

This is https://gitlab.com/qemu-project/qemu/-/work_items/4709.

You've missed the equivalent check in the read function.

As it happens I was working on this bug this afternoon; I have
a patch nearly ready to send which fixes this and also cleans up
some other oddities about the checks in these functions.

thanks
-- PMM

