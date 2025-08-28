Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F47CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgIz-0008Ed-Ei; Thu, 28 Aug 2025 13:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdVn-0001vj-PL
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:22:00 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdVf-0006Oc-Na
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:21:56 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-71d6083cc69so8534187b3.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756390910; x=1756995710; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pFEzSAcRzVI3QtQq7LI7q9p9gfMqUdP21aBednSXEqs=;
 b=smxnFXlzpM6PlGIsP7p+KOnqdCxc6FSHYBoUPycEmkJ+qeK1E5qicIvyE1BAzu/Xst
 MlDw5lgzT5ZtyGGZYWKYquWYdectzU1L05KnUme1elnO4A398QmxfDaXTvG++w53iAGn
 7Ah2eq7nqjNY2ct/waDpjk7lKVJZ5Gg+sTrA0urHOKLXRwP48HIVp9K26j65Hx01B9um
 45cQZI6nkA91bBh15FSz3BjM4d3zfjCb1Tm236weYiAwZQxEEhYB3lvMXqKQOMpoD3cd
 FegdN2iYT8KjEX0rtcLDbvTcC33mrEhV5Z5SRFTUeph8eGUTaeIYNI9wKlZ/dVWp7i0O
 HgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756390910; x=1756995710;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pFEzSAcRzVI3QtQq7LI7q9p9gfMqUdP21aBednSXEqs=;
 b=uk2Nhha+pREz4O2+PNE2L5M7+XbU74j/HSJNsIM9ostDSRntvar5FqdT+rVk7eapEq
 09cbbZtDawilT1KX30tyPtHTwjQAlBD9LL6cDRKY2zlDH9+cYxYWak94qtYf41WcCDI1
 GZIdBmw4cPKLSH47azqcf1Ot6DkGZtt9G1IGuXpZjXqyXoW8CwfjHzyLMYkU1To0CaXk
 jDKVnju7EIHmvkjOivmt+UebcSA2OoQL/IW+J8fD199V7aeb1EMWWiZ4f9Dmpl83E6dS
 qcn2PxFW8KY2kxJIkBg0rmdzdCMUilDB+C2p/Yu+XDrJmSdDNjx9eh5qI+rBQJNh/63i
 lb1g==
X-Gm-Message-State: AOJu0Yz963/nbpuLT6ysELMz5Iz5vDfBHDPJ/nAyJm5NT0/fGk7V/nAb
 VCCd/5M7on3Y9itdMh+mwrKx44nFzbbnj7dkgmIALsBcqT/WVfTozSs+cN5793XAl8DNoyzcQNa
 6MwopolWTC7Y1aHljK+sBWsFFstMLWCUI8CA1PvkV75IDDFWY0NCQ
X-Gm-Gg: ASbGnct3gUSFROIRsksuGR5ToHZ9LiBbDKLJp9K2O5KSOjM6CKXD/zUpWlbteboU/Ge
 24dA4QaLk5zuHtpveaWBp2Fi7zGbUz8F1cGR8cATfHvxPhjvgxxfDYbyzOqgC8qxf44nD6cMjg4
 OXZw+i37AmRE+9D8LcasogKHbMP2++Q07QGYp56KJHeRvqyPPp5koF9AstvLtPBrb7HSgsyDyZ/
 cVcs/O2
X-Google-Smtp-Source: AGHT+IH9TVnRgnAdg3l9ysJk84P0hRUrVdiK0r5+mQ5O4AyhhOjCdGThxILA7KNgdMCK5f0oNJyPG2U5cWo14ZBBoQ4=
X-Received: by 2002:a05:690c:64c8:b0:720:c20:dc29 with SMTP id
 00721157ae682-7200c20e1acmr173582747b3.51.1756390909978; Thu, 28 Aug 2025
 07:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-12-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-12-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:21:37 +0100
X-Gm-Features: Ac12FXwPFP45LdVs0Zu3wgKCFN6-8okwwC0FyQoi2-C4BpVCOwKP1S6_4BQTnIY
Message-ID: <CAFEAcA_Ps0aKXqnyR28hfq+rORHXNEpGOP1u1X1cOEVcDSWXtQ@mail.gmail.com>
Subject: Re: [PATCH v3 11/87] linux-user/m68k: Convert target_elf_gregset_t to
 a struct
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Thu, 28 Aug 2025 at 13:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c | 46 +++++++++++++++++++++++---------------------
>  1 file changed, 24 insertions(+), 22 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

