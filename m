Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FD5606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 11:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=QOPnx52V
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNTlz-0001JS-Ij; Sun, 01 Nov 2026 06:30:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNTly-0001JF-FS
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 06:30:50 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNTlw-0007ja-Sa
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 06:30:50 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8ab395abf79so17921127b3.0
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2026 03:30:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793532647; cv=none;
 d=google.com; s=arc-20260327;
 b=eVEmydK7uFm6z5sXJfjRPO2tv+RzjjdZvWOa2LyWZhiGAzxIAUygR7DOpIYhee/lB5
 9vO2t6mN3L2qaK14kcABClpFtJmJIQyPQ04IrBm7o80jawb0YLhIxlp2tzY4hnC04dIg
 PU1yOjsbKf7onlPJCRlTIlY52/CIxpBHR0AIgZSCBBBfw6DYKcYuBvJGVmfRDFTyXY4m
 RrSKyE5lWGkeYcEr5CZB/JRvsk7yN0cNTxvdBr+hL9xAWDHqR2a6zvT8DX2jLMyxhh0H
 9onBwR3Bamx9ff64+woteRWt6N/Z76mRcf+AASWfmLlFk3jeiwwxsr3zcAygF2xc3Jpd
 9VrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DI70ust5Tu1bw47efY9J2PK95lAe87Ob6K0mO50b274=;
 fh=4sbipowM06A2rl5+LJZRkzpBD7npyvc47QuPcga0ZdE=;
 b=TVChWSy182jE7ES2Ei6MLkt6mm+dJzykzLqxl0FzD7fqWnrYTKGlBsUSkuMbVX0Czh
 adokyK1W+z8mRNTs4xlNNARdyEy0LHfnV+SzfYvpTQnBVzFEfK4FxLzyTZ71yBgibJ8j
 wrVK/nuBg9IG4jcUyqRC0wpGKk7UH9GjSrxYvfLg+7qA8B1anPDPYPXcrdojkRVCJcxL
 t7elCyaZKG9NHekOOhw+LM0JMwuHJG7WN8sHo5OI1MCnc6V4nkbGDcYb3HYmBNmSiAhj
 zi37cjb4mpTWJvE8HwzcA7L6BWhx4btToDBRW8IrdOoTbocD5Rbogb3+PzazZk96e8+n
 mGoQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793532647; x=1794137447; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DI70ust5Tu1bw47efY9J2PK95lAe87Ob6K0mO50b274=;
 b=QOPnx52VS4ek7R2akVNRLpqO03gVA6VvwZ7IiHhhUoMpGaQw5rv+KaNkCSz7m5uOg6
 Ezz6j9a5j7SMVXNY048lbP6gNY5WDKGU/ApPL6EmbNLqiFJ5uCtv+zjs1bSXYmEI5gQF
 1Ex22Ie0yoTFNmajM3/zbiUIxz4CzlPQGpwgR8c153zHuk+w2n2C5huex5U0ZWwu199A
 Kivy6Bssfkk/n8cy0F8qxUhJq/S+yXRoXa8ggikeDnjjNyw2LFPQJOgcomnFuGEeD9QV
 ASvy4KLUBnhjsyRzV9HmBzunIhHAA7lcsll6W+6He+BMfkFP4R50/DT8W9DiqY3O0yGE
 TdFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793532647; x=1794137447;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DI70ust5Tu1bw47efY9J2PK95lAe87Ob6K0mO50b274=;
 b=sQDHkEyoNap7+ebY1FOw/1HXzQld/6umJakI95M1OWqW5rCRxSzzNNma6d+FRM8YuW
 5eO3f7L6I7D/EqXj7HihPvolBNwYDHO1nMI+xbbbMLGJ9XdjgJS8IwYs4qBcRGkdRm7H
 +qPZDUDzxwkbJCCynn7GM8BYyHfQQsWqh4wZaWrq+T+9M7qv+AnQY+1mwJ60fV4cJ3v8
 aL7Cg0gJUHtroIbqYcz64ntwmUlnB6A3H8BqO2UnKP042ta6r3J2MBu6aMiRsATeHepy
 q8D9pMy+mtUJM9OqtZkqA1ma8Lq5IWWBsudPQshuQ2Xl3z4X03NQS8x2Tn2LQM9JxgPo
 3wSg==
X-Gm-Message-State: APuU4Z9/QB/7i8A+7V67Af1lg+tECiJWDi94KSOEcQXnCLG316I4rB4U
 bQrVkwqkfvr318Xy6PhWGIWDfxAbG9XQdD/BSPMg2iW6B2AVcb7bcAB9pvjJqbXwNs0Hn/Za+FP
 D3TUiGxgtdAI+NaW6Qe1h9Zxr+mEzE9rFVQPGixDbVA==
X-Gm-Gg: AYBFou2U8lUGczi1XoTycty6hooxuFVyT7VowNCRs10rZe6PgEyz2lkqSN+ZycYb7JO
 SBoR+5+T/7onOEzxkHWLzQi3SNfKGb4R6UDJ+C7KjVU+ChJ5usaNQ4+KUBhP54Ufn8ZXeeOI0az
 TuVAeWo/8wey12/M+SdRDPRlXEbk3j8NIDRek3NiXGaBtZJWLdx4REXmxtPBUZMA0jhZ2ZyLvfi
 /KRByM4SFKkJ9E+7aHhK0daoQK+hytC83tjGuuL32+KlK/uy1gbvsvbTgR0m7Pb0wpFmY9oZVch
 S2u4aXEH6g8cOkhuGW3nafo2L0Tq+6NBz6DR1yWD3UxMcqiWsVIcPD61AqXVQA8pqZYv3eEKHHQ
 Xjbb4u0bJBu2f5ZLF9KdWWnjJydTxCljUo01yiM9eH+uEhOuJbHAIgo0WnM1al9UwSBdt0whE5I
 sm5XdV/maXG5CrsZwJfnxSEw==
X-Received: by 2002:a05:690c:c510:b0:8b0:cd2b:a43c with SMTP id
 00721157ae682-8b2b67eae80mr47802127b3.53.1793532647011; Sun, 01 Nov 2026
 03:30:47 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030131554.41208-1-richard.henderson@linaro.org>
 <20261030131554.41208-14-richard.henderson@linaro.org>
In-Reply-To: <20261030131554.41208-14-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 1 Nov 2026 11:30:34 +0000
X-Gm-Features: AclHuK-e22-Yl00CjuMoRkT57WDnFka2G6uwB6W6goDzAcLE0RNgBYWtgEeucuU
Message-ID: <CAFEAcA-Bb0PrHh4MCiWt8QZSAm-o=9ENiP-EBBVDrfU5WQCHAw@mail.gmail.com>
Subject: Re: [PULL 13/19] tcg/x86_64: Introduce TCG_REG_NONE
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Matt Turner <mattst88@gmail.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 30 Oct 2026 at 13:18, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Rather than hard-code -1, or compare < 0, use something
> more descriptive.  This also allows more use of TCGReg.
>
> Reviewed-by: Matt Turner <mattst88@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

>  typedef enum {
> +    TCG_REG_NONE = -1,
>      TCG_REG_EAX = 0,
>      TCG_REG_ECX,
>      TCG_REG_EDX,

This has resulted in Coverity producing a set of new complaints
(CID 1689946, 1689949, 1689951, 1689952, 1689953, 1689954,
1689955), because it now assumes that variables of type TCGReg
can be -1, and that therefore code like:

                TCGReg reg = order[i];
                if (tcg_regset_test_reg(set, reg)) {
(from tcg_reg_alloc_pair(), but the others are similar)

might be buggy, because it hands a TCGReg to tcg_regset_test_reg(),
which uses it as a shift count without checking for the -1
possibility (which would be UB if it happened).

Should we just mark all these as false-positives, or is it
worth maybe having operations that work on a TCGReg but
don't expect TCG_REG_NONE add assertions against that ?

thanks
-- PMM

