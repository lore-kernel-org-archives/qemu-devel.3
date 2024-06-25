Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFF7C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 12:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM5Rl-0003ET-Vu; Tue, 25 Jun 2024 08:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sM5Ri-000348-Bj
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 08:38:50 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sM5Rg-0001zF-Tx
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 08:38:50 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a724440f597so344292966b.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 05:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719319127; x=1719923927; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MLeZl3QmhuuLGvbd3nbflAjflso1c1oqt71wUt/s65M=;
 b=vteUZUNpVOQ5qFJlIfwD9fEwALrXuVGdkYaK2rzTeKyBE0AhpWCQBcxc+47liRLfJb
 dSkSHkMxfnXqcQMIUh3zy/zAfcwrh/rbgVI4Pc4HuBw0CdN1xyujCUHITkpsYH8z19GD
 VuuNKu6LLVGM8MjNSK0XXv9uipmgB4G2F1rKiH+UEFfnF4F8qLTfF5QcXSvDNSt5f07f
 NuTjPG52PZanVKO+YY0lanO0nytKI7B8WjN8TvQP/lMEplEGLqEaeVk/fOfuaHloZZNf
 DHBsBFvfcsRkqHX841KIYv83hJ1RmiWYKCjl/J1W1KbmlrYYE3yjM5l4Yo9iSxnHn1gV
 hY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719319127; x=1719923927;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MLeZl3QmhuuLGvbd3nbflAjflso1c1oqt71wUt/s65M=;
 b=UQ1ynvltkcaZORXH83wYR5HjLqpoyvjeafXpueJvtjF7251ULnix2eBUFp3ISjXLJ9
 oD/n/rW5IHX0Lst1NQnlaLa6pnS7lZc5gMFU8r+MT9YljerpNJsVw/h8/TALSXr+WOZj
 YDWkJGfluD14/K6mzIeYN7x1HE3FfbwsHCuHuIdSG2CI71gYyYAvssCZlxxdnKqp7j/u
 QwyY4Y/IljzSdEwD4ymWGvEbOZ/HRKCX2WxoexRLW4RMKiWeDnhA7dGhuYLtVGwBYRS5
 odligBamVaDOgB+vwzbYWeSx2TUMCwWhuch/h4oVL/YkEFRx14L08AmGtcR5532WaI+j
 k1jQ==
X-Gm-Message-State: AOJu0YxVsjn30t6Eq8tk+PkZVFTfgvGISyYIB096LL25FRDZMyFmdUqz
 l1ys2ei9Di5bEUJCMttVQZ64e9re5ltYjWGLYpb55beMGdlXKvwddZPDbqBVOwrOXTltPtGVBxl
 e3UEr5UalvQcEp+BcmwTQuQXJY7nOla4+sPx4Cg==
X-Google-Smtp-Source: AGHT+IGy8rq4EmGtn6uDRKFZX0fOv6ywB0NrJdLbKasw4bl6Zxi7/iOO9sTQh6eNXlyX4O0PZVRzKh1rc7JigJO10Z0=
X-Received: by 2002:a17:907:a64b:b0:a72:46f3:ffc5 with SMTP id
 a640c23a62f3a-a727f67c2femr17090566b.28.1719319126663; Tue, 25 Jun 2024
 05:38:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240625050810.1475643-1-richard.henderson@linaro.org>
 <20240625050810.1475643-9-richard.henderson@linaro.org>
In-Reply-To: <20240625050810.1475643-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Jun 2024 13:38:35 +0100
Message-ID: <CAFEAcA87Fp3PfLZPaRxcaQo2MbajjWf59ZNrFifZDf8DFRzHrw@mail.gmail.com>
Subject: Re: [PATCH 08/13] target/arm: Convert BFMLALB, BFMLALT to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62e.google.com
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

On Tue, 25 Jun 2024 at 06:10, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/a64.decode      |  2 +
>  target/arm/tcg/translate-a64.c | 77 +++++++++++++---------------------
>  2 files changed, 31 insertions(+), 48 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

