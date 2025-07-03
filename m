Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF622C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 12:19:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXIuc-0004E7-5U; Thu, 03 Jul 2025 08:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXIuZ-0004Cz-M1
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:19:31 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXIuU-0001rT-8Y
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:19:31 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-712be7e034cso53646137b3.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 05:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751545163; x=1752149963; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a/4N0GhCEjVj8qg1Epax0AkW7elXGMI9bv2tVBfUC/o=;
 b=ww2HYrth27AgJTfm2Nj+WydzV31gwMKYzsDU4XudwkTHs6ZBOLnXkVyC7eLpEuiPau
 elNr249cIzsPXF28+sdjpu9Vn9arXAWGXrQSa/L+qmlaybv1zh0+8BSeO2ZdMHKKicHH
 kOEFfC+1fNEYE05r16dGW6hKTYNM+aSZRETa504lf3Mb6HaS2ZF9IPYYEtj9z1uhbfGS
 2Kjoe6ubG5wkKa8VD5amN+EFdtic2mUWpBhcP4NtUZR6n8Bs/JYRjPa6YRf/aoxJiJZK
 dC7Rl4WIBIUREDMh9RcRSjwyo8t+UCchseq7BJ5ZbP/KylhP962VTRA+GEdK/afU2ZlU
 N2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751545163; x=1752149963;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a/4N0GhCEjVj8qg1Epax0AkW7elXGMI9bv2tVBfUC/o=;
 b=Cj7MlN9S4nIDE5bomsMZnItNt+XskzCTSq6yBXBHNSheKuCXJNPl2NYdTlBxvn+KBl
 BvqlmvQQYgJJgd9ggjazvq4Ms9hdYt5oGHeeAFP4RnzfN0IRVoamOatOy6NCjQOwbqwH
 AkfbZnGtnLlNQPns956AQdhXP7u19q2eJg9N1GZqdULk7pvULCYLjwKihukhnJyYoT0N
 XbDrGt5jFruBjCKh0piQqQnbtnllCZByGHhEKaDaKwY/WQNNK1OpfWJaNBjUhy05WGCS
 ZtsLdfFUM+qh27fIASMYFrwq7KjH1Ke+R7/71HJidbKE3esknqB6q7E/Jp/cI0pIbVvc
 YHvw==
X-Gm-Message-State: AOJu0Yw9ZCuyY0cArizAuII2kH8cCJpaVWeB7P+AVGAcPMez2pBBN4l1
 B5MrqkuqmFQHFRAweOCCE03NoLvzlXJPOl8UVCTRLpw2WztmjKMQuyruZSu74s1E1SMg/uXnWeX
 fOXABhy87Ud+1HiR6GEeAZVtMKe15/Gm+fsfsci/gVm97Zdu56cIN
X-Gm-Gg: ASbGnctcTNxSla3xf3Sju8DaAiMHNNefSUOybNhNz6MZ119KkErvY4+CHIFmNvknpZ7
 8nGgwHr6GcSNc7b3qOfbt4QhKpcHAw2ckzBqptmABcL1Er0IoCJa+X4G/ZM7PChBRRhJSxA+Q8X
 tiHJUPsdgl90+N4nedVmnLVy77daL3Bb7OAf5EuIGdJEJL
X-Google-Smtp-Source: AGHT+IGrTMhd2aj/vOaHxki0ngpxfHynp+wtTlcBYVnaB1vL94x3YCtdX6fzqrJwLIsEusq7EPYSU7ZZnBL17dU61is=
X-Received: by 2002:a05:690c:63c7:b0:713:f7dd:5d7c with SMTP id
 00721157ae682-716590c4de8mr50277387b3.19.1751545163422; Thu, 03 Jul 2025
 05:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-72-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-72-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 13:19:11 +0100
X-Gm-Features: Ac12FXy9_4Kfy9XOlw_bLUvmXojV2lqLTl48VabTeHZH4AKg2_YLpP_MCkWIcOQ
Message-ID: <CAFEAcA_42xRCLC_J8WjMseotN28r7vGh+xvEimkHHSyOUm0d5w@mail.gmail.com>
Subject: Re: [PATCH v3 71/97] target/arm: Implement SVE2p1 PEXT
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, 2 Jul 2025 at 13:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-sve.h    |  2 +
>  target/arm/tcg/vec_internal.h  | 74 ++++++++++++++++++++++++++++++++++
>  target/arm/tcg/sve_helper.c    | 27 +++++++++++++
>  target/arm/tcg/translate-sve.c | 36 +++++++++++++++++
>  target/arm/tcg/sve.decode      |  6 +++
>  5 files changed, 145 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

