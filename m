Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C17C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 12:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXJ4M-0002LW-83; Thu, 03 Jul 2025 08:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXJ4K-0002L9-I9
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:29:36 -0400
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXJ4F-0005bD-FV
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:29:36 -0400
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e7d9d480e6cso4241443276.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 05:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751545769; x=1752150569; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qqeYmTZOQ1J4jUBfsP801wja9Cm6P1BqauDBfzgFlh4=;
 b=oFNWFZ7Kz8z41Cy2KcO8dyMMTh5lE30lmgKakZbP2mvyY4ZZH+z1e2jDWDBto/ACPO
 DIq4jsKJ8aR6FqGXJpnJtjtVWDHpDtRm9YaGwflI+En1SkXKqMLC93O0YjKxGGaLsD+i
 h4IWOHnNkjQm6bxF21tfcXeyPKwCBDLHz5VhvUG/O7i2N3Tf2zXQ6t8MetiXmeHCAh1h
 7UyMSj/1Y3+1Sm+0BhuMdI8Emu0m3IWXiW8TwgxHhztwHepG42qo6XOZhOQpkM2ty5Ge
 /5IvQ/TGL12VX3EHdj4o2qPU8nYXG/FCRAvOmT5HO8vA8x7MouYZ/RcV1AOWNhnF0ziE
 dfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751545769; x=1752150569;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qqeYmTZOQ1J4jUBfsP801wja9Cm6P1BqauDBfzgFlh4=;
 b=iM6f1NQgeTG5r0hsMSTwvufjiUIxe3T3IVK62TIcfEJ4Oh6sjygUlGxCEfsbPJjfPe
 TcHb/7tiuN0p/ZDcUCExrKtr3JN2l2CTSYvf2G1FeVf9lirN9VOpbhn4SR18p6tb8X9s
 znw8nZHTpSZsofMP/HhIkRduSSCZo9VbihL7wIrSZ0Qko8ru6dvcL+e4zIQFFZr07TLZ
 dWovgv8Dx0Ab8ZWVzDy8tq+5fSyn+O9WY1WIcfiSMOPZLZsrVhnwG47z6DbnLWJt/eJ3
 sGo0r/cHdsdlDBKHoQclkcXUpIionz4JDjBgjkfkrGq2eHDqMv5Zj3tYrdpSF26l6n1T
 QGyQ==
X-Gm-Message-State: AOJu0YxALYHfZ0GRduw8gH3gzguHjU+ZBEGdL+8AAFhas4aqADHDBvVu
 k58QR8gRR4BkkAbhMZu7hypO+ZEHLO+MMl6JRdBOTzYZCa2YK6zpBwng10qbUvZdowOf8POOwXP
 5Z7zO+0+SVLmJm4OWetNzs3sz7g4Xe0dEp/s2EBmqqA==
X-Gm-Gg: ASbGncswxZFfe/Onv3Q7aMC9EJv2czkssmD9n2uu2fNHa4lKIwjEzA1TCY8uqEyUNFq
 W6x1kjna4n1zdHu5P64H+73s1q/MEbbYOYnUuiB1uWD2oyfHcaDLSdPsc2XFl/l+oPbOqC3dmcB
 nbJdMfxMt+Y6HSebJvwq1vSCd44AvGyMVzoBMPYV45DKCF
X-Google-Smtp-Source: AGHT+IE6LQAnC9Oi5AjzBbnV0RnW60/RwyvEtsqLH23ljK0owK3xhxunV8cGsVrvsAMc6aJZmhTVsAyOfL2Bg/qD7DM=
X-Received: by 2002:a05:690c:9b03:b0:712:e333:d3a6 with SMTP id
 00721157ae682-7164d3f1544mr97006657b3.19.1751545769158; Thu, 03 Jul 2025
 05:29:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-82-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-82-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 13:29:15 +0100
X-Gm-Features: Ac12FXyyAznOVbocJGYEvZUx_VjP0HWeyYWJuw1uHp9MzpwS7mg-YRgM--TdW14
Message-ID: <CAFEAcA_GrTBoPbHXS7Co3Do_MKiggOrg6g7HE3ywmptsWMgf2Q@mail.gmail.com>
Subject: Re: [PATCH v3 81/97] target/arm: Implement TBLQ,
 TBXQ for SME2p1/SVE2p1
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2e.google.com
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

On Wed, 2 Jul 2025 at 13:41, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-sve.h    | 10 ++++++++++
>  target/arm/tcg/sve_helper.c    | 10 ++++++++++
>  target/arm/tcg/translate-sve.c | 14 ++++++++++++++
>  target/arm/tcg/sve.decode      |  3 +++

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

