Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B33CEF17C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 14:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syApa-0001O6-GA; Tue, 08 Oct 2024 10:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syApZ-0001Nb-7A
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 10:04:53 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syApX-0005aj-PW
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 10:04:52 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2f7657f9f62so56769361fa.3
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 07:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728396290; x=1729001090; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qlZ7kynNNkwRnX79N2/XULKM6T4JjrNnGdfb2QLSUeM=;
 b=hIlWASSEHSQSgy1PFdJsW1W/IBS+aej5XwI+5eqISghv/yBcsJQsyKFcnK5MqbYAEW
 qf62sLQro7t/UnLrv1l47RV5SWwQ2jKkyfaPDPErwP8MSA0IAzL77eRQHGmFhIXuddAB
 vzXGgBu1FbyEuu3kkSbN/L0a3MqxZojghLiYmCZpluVKI5NKnihF3JHAb520W+eJ/9MS
 p90TT2wHgljg8ZVWtQdIkt8czUrEPS3QQqVWXaVvWcMmdeMYUPAPzsA1wKdGgT9N4D4k
 zUMmpxkkFoSyQGmXAfuwpiKAI4V6N1VaJtEYYfWurtZibi7HMGWDve/gXUONzY20Rimd
 jStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728396290; x=1729001090;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qlZ7kynNNkwRnX79N2/XULKM6T4JjrNnGdfb2QLSUeM=;
 b=GOKc7LDb753b1/eYlZ+iItYeu012Wtws22YWpO3vrpTDU3ki6MAk8MqITr01fsUtjf
 emAAFa7ufiQvz2HucFDWrKxiXNVpnzieQPI0SoN8twboyHNrcF3BERW2yfrukzdxTSPs
 ugBmJh1t+OYeyOMTvPV50BBEN7YD0V8R1m4P7rTT93yPlRaLxJufCo465fhQhkNSnIeP
 uTiY6mbljwMtjY8OJggkGyRBTkbloJnkSn6ZLRfQxj9UaA5At/8bJ+IE8bdNDl0KnlHf
 hVCAKY2pAFe7zEaiemvDoFoN06nouZOaP8DK7jVdXFvw8DxjcEiujrGIGFR5E4mg5/y1
 frYA==
X-Gm-Message-State: AOJu0Ywi2XquUbPwCZp/dw22Ugbf6CWNjANz6XwlyRq4PNsWUfW5WPK8
 cSvtZKTSVgKy0dlxJwmoSF8ntXM0JabeY5+8mi3DusblXAR8IgKpyAv+Vu45WgyjSiriXOvSOr2
 jTClPnh+elncoRSB114YmdayJQsLXCzkzjuD3ng==
X-Google-Smtp-Source: AGHT+IG5RlYXNeodhVLGDi/7fTEdmhf55OOWgTnAe+5B6xjOHVP5BpVmse45R1Lu4UuYqVvHbs+dftA15Kb4+IdNUoo=
X-Received: by 2002:a2e:a584:0:b0:2fa:fc3f:d606 with SMTP id
 38308e7fff4ca-2fafc3fd7b4mr57722201fa.22.1728396289753; Tue, 08 Oct 2024
 07:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <20241005200600.493604-1-richard.henderson@linaro.org>
 <20241005200600.493604-3-richard.henderson@linaro.org>
In-Reply-To: <20241005200600.493604-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Oct 2024 15:04:38 +0100
Message-ID: <CAFEAcA-RP3ap-ofbxFZbLuy0CXeDJQPYSvv2SAkJ-1LvtAQEWw@mail.gmail.com>
Subject: Re: [PATCH v2 02/21] accel/tcg: Expand tlb_fill for 3 callers
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@kernel.org, alex.bennee@linaro.org, 
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x229.google.com
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

On Sat, 5 Oct 2024 at 21:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/tcg/cputlb.c | 33 ++++++++++-----------------------
>  1 file changed, 10 insertions(+), 23 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

