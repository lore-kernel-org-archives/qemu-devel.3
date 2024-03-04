Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2A4C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 17:12:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhBrZ-0007Al-AK; Mon, 04 Mar 2024 12:12:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhBrX-00079j-5g
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:12:27 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhBrO-0004LJ-Nl
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:12:26 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-566e869f631so3580547a12.0
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 09:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709572334; x=1710177134; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4LfOMCUWElaLQCseVTFR5rKlr+ZKIwfpeoeyHpX9pkw=;
 b=yg3R4NLb2Ns8neYyLvAWLuxKL1dOr1mtS1NaLuQxAFFfCrExamN0QyvSTYM1aJH+1W
 6AaFty8/PIrR+gemgoWTBZI65wazZOfOByeTSiYGXWYg0n4E6OOpsZhBiLH9hlATFNKp
 MXQGsgQ60U6rjABbRijlx1zpHsXo5BjPvgVgpn+Rxgbr0+fCjCxM9iF7uGEWrMlhWm+I
 8Nn/dHqTXR01BXXrNJFh0EieiJ/GMkDzgfy1zM9dtF5zrTrktTPrp/Tl/DnxOyUUv3Tb
 F7YDim24lIkPDFg0FULGFUEvvH0oa8PjNsSEgEWDvfayhX7XjUentf4M1tIKaVIpvYPv
 U0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709572334; x=1710177134;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4LfOMCUWElaLQCseVTFR5rKlr+ZKIwfpeoeyHpX9pkw=;
 b=Gvjvl8uBZ8Zul6x/nso9Ou5bLEWIVdiS7uf2wD2WmaOKAuKMaRbKWizZm3VGhHrvXS
 DE/G7NmaRNPxE/H12y4dLb4SLHblrmqaheXee63P0xH3GJBzM6mpmAJ0vIpfV/pP1V9e
 3eRZmbFwhH0D0e0G2C5LbcC1gvDnUJH4KBCFvXlhN0iE13ilYH4IgXXkVOfOKkoGZ6Is
 HlBq1D2IqJ+EAgUlV02P7g0ttgY+9fj793LiDSp1bljTs94LXhAabA1JGrSw9ywmjVQb
 M38Tf3OZDRYCkatcJecKnSVBx5AcRvRo7gdEonBaM6n+3MJWscEjueLDxTnSb3HbSNFM
 zt4Q==
X-Gm-Message-State: AOJu0Yz9ZcERIuGh/aeTAQu+v1RtHi1hpd+nBnfOUcMQFuIFrvwJ76pg
 0I82YrpWzWTBJofA7/xagEj5VXcW3IbYBRRFvkzDGJ4JKrdLGLDBuo04SvgEfHjnY7dbRrYqWwH
 YhbHIrc+vt75Ujvm4OpnYpFb5VBPhebmZKrsbFg7m5K92HDeK
X-Google-Smtp-Source: AGHT+IHmyAlWGexNN6VmzAIz8FAp2zS0xfMsvGCgRM1VV/BKuSlYl3KXAw5OwJwGuEXKHch3lW5QoMNqQ5E7EGWeb00=
X-Received: by 2002:a05:6402:5c3:b0:566:66cc:633c with SMTP id
 n3-20020a05640205c300b0056666cc633cmr6693150edx.7.1709572333737; Mon, 04 Mar
 2024 09:12:13 -0800 (PST)
MIME-Version: 1.0
References: <20240301204110.656742-1-richard.henderson@linaro.org>
In-Reply-To: <20240301204110.656742-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Mar 2024 17:12:02 +0000
Message-ID: <CAFEAcA89y3vhSNsgYaFXP6ku1-UNVk8DbH+AKeHfMWbzNinCsw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] target/arm: Do memory alignment check for device
 memory
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 1 Mar 2024 at 20:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> v1: https://lore.kernel.org/qemu-devel/20230223204342.1093632-1-richard.henderson@linaro.org/
> v2: https://lore.kernel.org/qemu-devel/20230621121902.1392277-1-richard.henderson@linaro.org/
>
> Some of the v2 patch set was merged last June, but the rest languished.
> No substantive changes from v2; only fixed rebase conflicts.

Applied to target-arm.next (with the comment tweak to the last
patch as noted there), thanks.

-- PMM

