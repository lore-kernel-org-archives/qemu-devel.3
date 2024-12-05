Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 314A1E7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 17:46:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJFuv-00019n-V4; Thu, 05 Dec 2024 12:45:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJFut-000190-Tw
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 12:45:31 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJFuq-0000EP-FY
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 12:45:29 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-385e0e224cbso652406f8f.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 09:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733420727; x=1734025527; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ipdLw07BS/sO3vHv/p4tnDEU/uwUsHEk/607BUAv6jU=;
 b=yQdwd+SbiLHl+iqH7WMkBqyGx1sExmrWKq0K+NBOT3psog2rVMkxHHlHYdMK4c4a0F
 hENKrDQMbYv43aZZHLKWYk/FZKsettoDLNEWcR6+GuAuQ6B14TnFhYNTB+SqF5J2TstN
 IadLG77K2MJN5RW7eBl1gjICBB89zwHDY2cby7GIPGsJYb0LZ5WcO/rNFPHzfrz145qd
 BgxsrEe5CWspc62MFimH4DOMALp42kW2DfZ+F7b5M8klatPVGstluWpOoPVI6mq0ybJe
 E5+j5q/dH6fn3bGiLQlG5Tk+wEajzmwjVe8QMd0DdBcVaDdwzhi2paUF3atY6JVJPnwz
 pGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733420727; x=1734025527;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ipdLw07BS/sO3vHv/p4tnDEU/uwUsHEk/607BUAv6jU=;
 b=NSutXkwOF7p95QTGpvdNJhtf02mGVJGdgoi6oVScZfpTvNf4rfxvg3t3ekq+h2g6yz
 2VWVt8ySV1M140mYp2LsJ8vi1RX7yVbJ0Ym5+7g4P7pq1xQFm7oxKAYxKlOXt5wvpms1
 md97/N8ln4RqF94w3FexhIum8sX+sEAJBVIcXA8KvB7eNYQsheQgXtMFQmWmpIHhFbez
 T4E3TVURJnGxGLbzleOCuKBbQhcecGazKfJNO2CMBzYGpyXdmvipBeQNKrA61e64fSPl
 SFMn1dhQTvTRlPkPYz/K3CBCNRavlnQqFCSEGNlSemHKKE7bUZA0O6/iWqtPW1BJ0sHv
 Q3zQ==
X-Gm-Message-State: AOJu0YzO8DYSZZ3L+jlDPDxGXaSoXLiRSDQUGC/TatUjH/4n+nz5JENs
 OxTA6yKcsP98b2fo1BIWgBu4JwAAJwH5mph5gD4hMFv/4pETNxRUd30pJWGTkPwyDp6cfDWFYBc
 R4HPVQTXO5Lms0koggI2YcBi9ydb261kL/VZWdQ==
X-Gm-Gg: ASbGncuW8KL/us/mF367DUc/7/yPpR5mohcKuhNfHfZYk0Li8DM+LaeqBJlUbGHL5xJ
 ojzAxmqTDRNN8SxGKy9z/zg4YcjEhhxy0
X-Google-Smtp-Source: AGHT+IEVyQDXOnDMburS9topIm/opbOwdaxiYerDWy2XPkeOu8ZBGRK2pWA0H88/s1YwdcfHH3EiJZcziR3qzknTITs=
X-Received: by 2002:a5d:6c6d:0:b0:385:fac7:89ba with SMTP id
 ffacd0b85a97d-385fd43734amr8911797f8f.47.1733420726868; Thu, 05 Dec 2024
 09:45:26 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-14-richard.henderson@linaro.org>
In-Reply-To: <20241201150607.12812-14-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Dec 2024 17:45:15 +0000
Message-ID: <CAFEAcA9rOEUPUaj=UNPc-nAKGjOcJVKuaON-PBsQfLK32sPWyA@mail.gmail.com>
Subject: Re: [PATCH 13/67] target/arm: Convert disas_add_sub_reg to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

On Sun, 1 Dec 2024 at 15:15, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This includes ADD, SUB, ADDS, SUBS (shifted register).
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


> diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
> index b4ccad34fb..4d422a7191 100644
> --- a/target/arm/tcg/a64.decode
> +++ b/target/arm/tcg/a64.decode
> @@ -718,7 +718,7 @@ XPACD           1 10 11010110 00001 010001 11111 rd:5
>  # Logical (shifted reg)
>
>  &logic_shift    rd rn rm sf sa st n
> -@logic_shift    sf:1 .. ..... st:2 n:1 rm:5 sa:6 rn:5 rd:5
> +@logic_shift    sf:1 .. ..... st:2 n:1 rm:5 sa:6 rn:5 rd:5  &logic_shift

I think this change needed to be in some previous patch.

>
>  AND_r           . 00 01010 .. . ..... ...... ..... .....  @logic_shift
>  ORR_r           . 01 01010 .. . ..... ...... ..... .....  @logic_shift
> @@ -726,6 +726,15 @@ EOR_r           . 10 01010 .. . ..... ...... ..... .....  @logic_shift
>  ANDS_r          . 11 01010 .. . ..... ...... ..... .....  @logic_shift
>
>  # Add/subtract (shifted reg)
> +
> +&addsub_shift    rd rn rm sf sa st
> +@addsub_shift    sf:1 .. ..... st:2 . rm:5 sa:6 rn:5 rd:5  &addsub_shift
> +
> +ADD_r           . 00 01011 .. 0 ..... ...... ..... .....  @addsub_shift
> +SUB_r           . 10 01011 .. 0 ..... ...... ..... .....  @addsub_shift
> +ADDS_r          . 01 01011 .. 0 ..... ...... ..... .....  @addsub_shift
> +SUBS_r          . 11 01011 .. 0 ..... ...... ..... .....  @addsub_shift
> +
>  # Add/subtract (extended reg)

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

