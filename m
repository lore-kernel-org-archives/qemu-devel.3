Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41241CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 13:46:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1mHP-0002Ke-Nn; Thu, 25 Sep 2025 09:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v1mHD-0002Il-1b
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 09:44:53 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v1mH1-00082C-1K
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 09:44:49 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-62fc2d92d34so1744835a12.2
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 06:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758807872; x=1759412672; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XEf7IIxIapDisSjejziNXR0vCW3+6EPHrcLxiF8BVZc=;
 b=nLCJenGvh8F1Mg5RXAYzcdZbSmcRl06GyhQHzWlm0kFOuj2UqYaheX0Vc4BAuR+gYg
 alwzy0kpubGtu1TSh/QLQGWwU/LcWJp71mZWhOeDw19q7YiFgOm9YaGKKbg6XoapzXwt
 G/Pjt2JjIKig/K3WeqC6LTdusnR4SL57ijCld6TIEpE38uvsGoulDRNj5oLBhNnt1V5/
 Fq09I6RuckgCvHrCeOGLEI+X5oaexfhMXO0VJR3sCwvoH37KsPfJZTxdn8yEdCbzlC3n
 tNmPQcOCMvWoeWr3sKVau9kF5BuVwTWwk9S9IjbeP4lf6uRNmaMUHPojL2F7HfWuTjOJ
 mHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758807872; x=1759412672;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XEf7IIxIapDisSjejziNXR0vCW3+6EPHrcLxiF8BVZc=;
 b=GE6Z0YJf6ySaPw90sV2zrRgJLqNUmBADX0ig1O5eFtltQ5HtPgL6aTnjIDj+7iLTv2
 Cca/P17EtVu+qmofvCGrajJWXN41SqXS16k959WCycdl2B6U2RDl8eZORB+/d9ekNm/i
 D9E6Yshn1E5cxjJ2nEHW8juexS4U5eO48/w0oSSLRonTcOH7LT+URuBdI1HSLBEPiyhm
 nZH7I0U7aqJYTjJY9WT6NTdeRyrO41MDoDx9S3XYIIFYPRABBztnfKXUR8LKs1ol8Mbv
 30C/bBBQgr9QGK3C1120OJqFl3FLjyL9iEJQ1GWTC9lYoyLln9SIKN6mVEBD5y47c2KX
 djiw==
X-Gm-Message-State: AOJu0YzN4dphUIMuPNIYLQzbnaVS8SWf8WP+Xv3Oh112v56hrVp/tW2P
 pQeQfM+NO+igKia+R2aywg2f4XoGRyqZU2Ro7kGcXaawDuutF5B4iGtaIaW3wEebv3mSMCEY2Kj
 ynxUTnDHnh60r7JJVHo+Q+J4LJSGGLUXYaJIz71wVUA==
X-Gm-Gg: ASbGncsHZv1HcPfkTbimXHA3Cni/zZ2XPpBQD80XnFs2BP7646+8AltilY7h39pp8pA
 D4mFLsiXV77ihaNM88WHYW3TPFF080cxMG1t+/lqoLuBrOUZnkP9LdtwkYYyR4kkb6thJ+ewgtN
 l/izvlibWePHZG7ny+nzuezcHJqjJzj5cPluQ6b69cbRz3M1UKa0bPMXocmG41G50qG8+ZUCNub
 L76S+UI
X-Google-Smtp-Source: AGHT+IEPlREHAglVGm+UR8760EGdaub15l8BbFZ7G/qddQeU4ygyB8pYVJII3EwHDvYOn/9i2mbkO1sGwD5rzEbgFcs=
X-Received: by 2002:a05:6402:1659:b0:62f:1e7a:f842 with SMTP id
 4fb4d7f45d1cf-6349fa91f2bmr2541411a12.27.1758807871986; Thu, 25 Sep 2025
 06:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250916142238.664316-1-richard.henderson@linaro.org>
 <20250916142238.664316-24-richard.henderson@linaro.org>
In-Reply-To: <20250916142238.664316-24-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Sep 2025 14:44:19 +0100
X-Gm-Features: AS18NWCS2lDAS0b3vGjlAjM-lBhSDWnAxOGHieYHftyIMqo_lyCGRKKAj7uF66U
Message-ID: <CAFEAcA87gjN8DsnqOFP_1avwGuLqC6hb2hmfacpvhDr6AZq+VA@mail.gmail.com>
Subject: Re: [PATCH v2 23/36] target/arm: Move cpreg elimination to
 define_one_arm_cp_reg
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Tue, 16 Sept 2025 at 15:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Eliminate unused registers earlier, so that by the time we
> arrive in add_cpreg_to_hashtable we never skip.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 123 +++++++++++++++++++++++---------------------
>  1 file changed, 64 insertions(+), 59 deletions(-)
>


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

