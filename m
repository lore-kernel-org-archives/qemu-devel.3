Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2290C982FA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 10:37:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9KL2-0000F8-1Y; Wed, 23 Sep 2026 06:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1x9KKv-0000Em-B4
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 06:36:25 -0400
Received: from mail-ej2-x10.google.com ([2a00:1450:4864:34::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1x9KKt-00080r-Oa
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 06:36:25 -0400
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c254fa663bfso120388666b.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 03:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790159782; x=1790764582; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BGDcKiJNUvfcjNCgFV7XGVUXBYKHwfNOY0NhwgTQgeY=;
 b=pPXkluX2wjrqh7pwcBW/yFS0YMdoWTXgdoBQ2UD7mJBnpaxcv9z5BOz8FBqQMzpndN
 AA1APoXHQJyhtxLLw8Qc3l6ojJTfuAd+XUS4PwYch2G2l3DaBqDpHikyvv8BqZDD2P24
 8KHrMY1udTx2HjtUBFeFF7Ilax/ySoQYDsu80Elpf9ZVCbzftPprN1lc7vYAf/wvOgzL
 TgwojgQZd2z26aj+t2Nu+eJXtCCgXbkIZhHQ+SHThmP4EMDfIiTVKA70rZDUSD5UFt5F
 WrWhYI29c+2Acazj+or+xVpm1PqbGBfO5u72WW8Bsg7I33i7z0LPTvwe5jdpZxeET7MZ
 hHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790159782; x=1790764582;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BGDcKiJNUvfcjNCgFV7XGVUXBYKHwfNOY0NhwgTQgeY=;
 b=k0gvBGGBiWKku4ozRAhKKsSjD9ZPes4AAC2FZ8XCRSW3wpY/k6qW4dnWoeUmf30gCc
 PFUUYsFZbDL8x2PTmvoWkvOWSCzcEil9sx0EoxrjGQPW/CiY8ODbIiSvfoep1M0kPxlK
 Kr9uQM3GZQsbXErKxzWOAumPsL0Tnz01efhEuKuwisz6h64hV8bJmngSSWkj/UPc58z9
 RYqLlJbdfuX0MQoaEnVcWwUd5Bybsc2nVeLb3cC4jPvQyoNFmNJ6F3W1RIbN18uRW7w6
 RrrhL8ex54eIKlWIyNS0b26io35T0mBkI/hu5PnxDMbwTCfs1K21BTVP7Zt6NDZKWfqi
 1Saw==
X-Gm-Message-State: AFuF++ncIWPcxlMV2o8GwQKsMalEUoNh1N4ye6zvMe7/hwdEl/WOAKHY
 AT4lQGeHIzuLNCEY+eMrA/owXTCBJYv/uey2CFAUs7yfP7sxl3wgwCLMkRXvSc6/o47jgAUNmH/
 F+3TL61k=
X-Gm-Gg: AYBFou3eU5UxHS34zcHFsw3BCTI5OpOn4tHNC5bDEulRb4lrVMISsWAm67D4D156luF
 94A4oodvSCann9uIuhwk8hF+RmjzBAlhiPGtwHJ1DQhVtjOjl4zkvUx1FNc5UGMrrKIS5lMTsMT
 E49wNB5ZO/h+UsOnAQwPj2vcccrEwSIq9Vg5FK3tf6KR2TLpAbYZGRBdqVuSaUm/ePEIMbz9NJX
 CgT7vPH5yY4pKdsB8mTxc9jMLxKjZSwEzkMnXnYZn73vOPy2ib+Fj+iBVbypR7FdNxFkT1LQkay
 Ep6b1UftZDtEKyYreBXl5pqgLeGCT1LYH4AoluW2lsnmV7pU4j5hmokM1mkVbfzm33EGA9KpJ/m
 lDhNx0Yu/OiYyYSe/Kx6hjTCFyJoYA+8yV4OF6Ict9/1SdK2mt8FmyWSBWauih3XSEWwzzRB1MU
 8JjCLGP27/cMHnrbJyXGTR6msxO85GsgX9bm/fT06Qc0qlZYJmm5r+Xsy5D8vWJYYCuW1N8Zup
X-Received: by 2002:a17:906:478f:b0:c20:9447:bd5e with SMTP id
 a640c23a62f3a-c2aadeab4c9mr155720866b.9.1790159781952; 
 Wed, 23 Sep 2026 03:36:21 -0700 (PDT)
Received: from linaro.org ([2a10:d582:31e:0:805c:5b2c:d225:9d51])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2aae6c14acsm93914966b.52.2026.09.23.03.36.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 03:36:20 -0700 (PDT)
Date: Wed, 23 Sep 2026 11:36:17 +0100
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: Re: [PATCH 2/2] tests/tcg/arm: Add regression test for #4448
Message-ID: <arOroV0yRdESzLTu@linaro.org>
References: <20260915014115.1809286-1-richard.henderson@linaro.org>
 <20260915014115.1809286-3-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915014115.1809286-3-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:34::10;
 envelope-from=jim.macarthur@linaro.org; helo=mail-ej2-x10.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Sep 14, 2026 at 03:41:15PM -1000, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tests/tcg/arm/issue4448.c | 51 +++++++++++++++++++++++++++++++++++++++
>  tests/tcg/arm/meson.build |  1 +
>  2 files changed, 52 insertions(+)
>  create mode 100644 tests/tcg/arm/issue4448.c
> 
> diff --git a/tests/tcg/arm/issue4448.c b/tests/tcg/arm/issue4448.c
> new file mode 100644
> index 00000000000..180ff4029a2
> --- /dev/null
> +++ b/tests/tcg/arm/issue4448.c

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>


