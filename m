Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D6FC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 11:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVrey-0005Mr-WF; Mon, 22 Jul 2024 07:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sVrew-0005Aw-9F
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:56:54 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sVreu-0005VX-HP
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:56:54 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52f04b4abdcso50516e87.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 04:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721649410; x=1722254210; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GW53BARDoHWD00cOBNaBMr/nIXFp8X8VrLnIPXNfOYc=;
 b=tpF6/HHznAzles/kesbsNdG9niaCcRq36rZSzPo3jkU1wQq85vWx19HrftlXJC3KqW
 Jr/78XM3Y9mwdrovHbUBMyHzCwIlD7t5MF8VeUd1VD/cTmuTFBEtSrIL4IQOXdAnySNl
 J1PodGISWnERdjuBwF81Sf4QeMsc69EketA1a2Q435oyesMqRCRtOBnrkV2w1BDUkNO2
 z92DMlB9R8IPYFeBBeqNTMpZKq8/yHyZu1SY7l5fNhra2xI+UZOCUq/dMd0F0apXqPcr
 svU0yxpXMmP8GbbrPPw/AsI2zHPGa+Hgh7Xf84OmF/pfz3jm1ZlyefkocgSSwZBVcLYw
 kEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721649410; x=1722254210;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GW53BARDoHWD00cOBNaBMr/nIXFp8X8VrLnIPXNfOYc=;
 b=JUsJwTKZ3wEeSW0wq6xAeejK4X/Ya6mv4EY+1X8jRB16kpIIdCbKM7wOn0mDkk2UZR
 2+RIhU4z6Js9WIsRxQ4Pv6Q6IQsI5UnyqRoWEd81dVV6Kqaad6+wjLrU7Sx26NcxXh3E
 BgpItGkePn5RWcPVfp2B3Rks6NaDWLjnrVuyv/CkbeKqX4cXKh8NMI5XA8GY1KWiS+6C
 T7E9pdLMLTsWKRvhg6yRpldyurW45MHx3atQ5NzHA/QehzR4K9S5UWOGv6K8+nvn8WYC
 sma3gzWgvD6sdFAM6R014/cMKwHPd2PTPy8yOUY+9M7Ov/DGbovimnylEbCRCwbioI27
 +B1A==
X-Gm-Message-State: AOJu0YykYxrdxMx6SZJFp02G/VS8N/JVBSa2Oll2jBBMilqWj29Mq7FL
 s5MEEHG5rzUCkNOiLSjSn8r3OHPi3ZbcaZzD/477+PIb0M62Pdxa32KIoWlsPYoOwY/ki792MYc
 mTuua/IhZ9FngjYFCK4DzUEmj8otagMrOSdKgbk8FZJnOXtuK
X-Google-Smtp-Source: AGHT+IGJGQOfPTvYKB0SFLZP5usuIDbVStysQPsWc3u9+2G9gSzZMjlr8lzY2VpLGSZ8Rx6FpdmPMDIAU9bqAaTozls=
X-Received: by 2002:a05:6512:3d1a:b0:52e:7684:a385 with SMTP id
 2adb3069b0e04-52efb7e8f75mr4258408e87.52.1721649410248; Mon, 22 Jul 2024
 04:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240719010707.1319675-1-richard.henderson@linaro.org>
 <20240719010707.1319675-4-richard.henderson@linaro.org>
In-Reply-To: <20240719010707.1319675-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jul 2024 12:56:38 +0100
Message-ID: <CAFEAcA_+vkQfkDY9eYF02gQ_89CrCb8t8gW2wbo2m+3pHskK0w@mail.gmail.com>
Subject: Re: [PATCH v3 03/12] target/arm: Use set/clear_helper_retaddr in SVE
 and SME helpers
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongu.org, 
 qemu-s390x@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x136.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

On Fri, 19 Jul 2024 at 02:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Avoid a race condition with munmap in another thread.
> Use around blocks that exclusively use "host_fn".
> Keep the blocks as small as possible, but without setting
> and clearing for every operation on one page.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

