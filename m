Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED24C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 15:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYSmj-0001yX-W9; Mon, 29 Jul 2024 11:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYSmi-0001rj-4Y
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:59:40 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYSmg-0007CK-Hj
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:59:39 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2f035ae1083so48679621fa.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 08:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722268777; x=1722873577; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O8OV2YIPYGZM7nJeJK4nmT7/vryyQIsFtOIvuWJyV0A=;
 b=Nn4SylK4TDGye2lJMh7l/AlF92SOxDlp2rgTW92ypMTcVFb0LEQGKFG3dkAU6rdFHh
 k3KBeAoNEW2yXLv7a7loRZZP2feUmKmgErNF0F16OTJPZcVQrad2gybqEUGi8Y8jK0em
 vT46pD1gcJ3Jeddyzf3i4qLeBRdU/1cO0623ke67BWUb5FRBq8lH0aBf2TCe7DfUNqtI
 ATYIZDUARptDwJGW+d5aklKyavDkThXjloItyPGep7MIXd2xEmO1hSwKKFtaYTp0hUir
 Fu8u3g/3j4NCfThotHpfzWPtbPhfeWk2LFsQ09ez2Ss4KzJrSpjZ4TFRwpSz1OFHJV0z
 +hjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722268777; x=1722873577;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O8OV2YIPYGZM7nJeJK4nmT7/vryyQIsFtOIvuWJyV0A=;
 b=IWMpyWP/F4P9QROyIpg5Cl23GBYquPX+C3AMcuJV6NbpzT2x0VmGNoUMzK+4SqlHEw
 1bc4Knt9Ek157BYo39k11cnwGoHob2AM1teIQi1bR3WPPpMjW9XaUf+VDSNfLizNXj1l
 tYhhGBpJJ5O3fghMpzc197CSn9qejq+Mt6iBZDKyPOxm4yriYRlT1pfeuE2L1lA1S6Nl
 pJywGsRFsktBguRT0O9MEy9D2NKnYjzOFUIqtntc1xIMZKBt0aolsVqHUES3CAcCjaFe
 pxl7Z+uaE6y1WPMxL5y9GZ6EqcjPYDJiePvmL7FLyyVjnRmA8BvK0wJNebZvC/XnW1Yb
 e8/g==
X-Gm-Message-State: AOJu0Yx+KdtucSJC+CG8qpqEpFjf3cTdxWcRzBYNuLqc6qNy8nlZaP6r
 uoRVJlcKnxckJWTrZRJ7upAz99dtm5Tl25kFgkuLY9r60Hp3f7Xh61wALj15pnTWNdK6T98YHB/
 MA4vaAYGPuku++lTv9Wv3YVusk5VsQUqlKZTfOIlNQSxMtIMf
X-Google-Smtp-Source: AGHT+IH1mFKhxM7C650CWRsWMK+zH+pgYmJCvBpOhI9o5/RSRuTDi19CAW1jCTYUKZcfXWbchaYfgBJSFnLNlSfy9kk=
X-Received: by 2002:a2e:2281:0:b0:2ec:617b:4757 with SMTP id
 38308e7fff4ca-2f12ee074c2mr54272231fa.13.1722268776573; Mon, 29 Jul 2024
 08:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240723154207.1483665-1-peter.maydell@linaro.org>
In-Reply-To: <20240723154207.1483665-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jul 2024 16:59:24 +0100
Message-ID: <CAFEAcA__7F=Nfi+72mG159wXGwO9yWw9brpAqmwY5iDr8J4f_g@mail.gmail.com>
Subject: Re: [PATCH] target/m68k: avoid shift into sign bit in
 dump_address_map()
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x231.google.com
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

On Tue, 23 Jul 2024 at 16:42, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Coverity complains (CID 1547592) that in dump_address_map() we take a
> value stored in a signed integer variable 'i' and shift it by enough
> to shift into the sign bit when we construct the value 'logical'.
> This isn't a bug for QEMU because we use -fwrapv semantics, but
> we can make Coverity happy by using an unsigned type for the loop
> variables i, j, k in this function.
>
> While we're changing the declaration of the variables, put them
> in the for() loops so their scope is the minimum required (a style
> now permitted by our coding style guide).
>
> Resolves: Coverity CID 1547592
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I could have just marked this as a false-positive, but it
> just about seemed worth making the change overall.
> ---

I'll take this via target-arm.next unless you prefer
otherwise, since I'm doing a pullreq anyway.

thanks
-- PMM

