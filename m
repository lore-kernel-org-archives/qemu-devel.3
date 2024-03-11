Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A41C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 10:37:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjd1l-0004cw-W8; Mon, 11 Mar 2024 06:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjd1i-0004bW-5G
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 06:37:04 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjd1N-0003TO-AM
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 06:36:57 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5683247fd0fso3854113a12.3
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 03:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710153399; x=1710758199; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zp/MywqdKGQLriABJtnLsQNpE22xitl9JDyNyvgP+3k=;
 b=PFNIUILztkORRpTmMuHC76NlWJrBWI5MzPz+fI2hjFCpx3TzXFOyuKzNbmoVVhMQPQ
 /hQhKXhNy205Fh0MLhlvDwftjdqvAP0z+NsdCqzdcmf2UuMdInTQM+P2hwu6iQOQlC88
 Z7MHn1Kex1ahym6ycWZiyt0HPyWymRHGVIYcpyZg7cRmiQ9KsQYjoVNfdGUoV8g9bNBP
 RgpMTshQK3UDXU9rxWH6KkdW3ynvLiE5764ABzev0Xo1wzDvgR8yDh0hkdMRDRG9ZZhU
 qb2XQofPZv5p9zsSyzpVpqeCqQSGZvsQDFQJBtZ+rPts65IkUMuo80Uip0OcdS1nB/1e
 i54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710153399; x=1710758199;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zp/MywqdKGQLriABJtnLsQNpE22xitl9JDyNyvgP+3k=;
 b=dTMmD8LlRCGEeeKQrBLUYZxS+ton2zyonMHIqZsf8TplSRZBVW1MO8ADf7YkhwhOps
 y66tmc7gacY9Bm4ErjqrwGm09x0N6hn0BHh47WrIICFxqSwiBHme1zU6IYzS9b40ckcy
 On5HOIZRzRDDj486vHbugZC559fv6tGtROpBuyL3+Z9L961MZMqDr8uBT5t0mqCl4Dty
 YfPvss0Mm0o3SrPTEOyXAk114MxmTYQQ5GygGcGl/xWLkGOcPt4VTCkgxmd1abFXV7Pt
 dWmNYznHb+8ZNMCDv6OcgMu/c5oR6Hej9ORxS9irIn1gbraOVsWJDY1RgneuQG26oZyO
 LUSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnQ764VlSBFti/bO2el3ptEew6rWIdGzTsaavJTXscsa4E6ozGLBsZ6GGhs+yzrWe9FtWnUZJhUIw8j8RPcxnyK47Vrp0=
X-Gm-Message-State: AOJu0YyN9QTxbUablNjMPfysiIvTpQyBWal0MWpiiTuOO5gcRYZqNv0u
 EbdU2VxCJXkwpVxLU4Nn9uaXIqRVVuE4M84Pu8c68myKJQpHnwkXUeW+DTpSuOaOjmGcTNhVef4
 D7jyh8fkivA88X25Pp9wt2ogvOOYMxNxBua+1Qg==
X-Google-Smtp-Source: AGHT+IFUU4fHzML81mQWlfET72fKjipGxBePkHMQYxPSEJEEjZketkvgdrC+y4V2DyRSaajBCHzkfIhz/WduJfhUfGw=
X-Received: by 2002:a50:c35d:0:b0:566:95e3:1759 with SMTP id
 q29-20020a50c35d000000b0056695e31759mr4235768edb.26.1710153399038; Mon, 11
 Mar 2024 03:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240306035721.2333531-1-ruanjinjie@huawei.com>
 <fd515ea4-ca4b-4d54-9d9b-59683ccd683e@linaro.org>
 <c57f3338-0f38-1768-7c9f-d2b00a0cb158@huawei.com>
In-Reply-To: <c57f3338-0f38-1768-7c9f-d2b00a0cb158@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Mar 2024 10:36:27 +0000
Message-ID: <CAFEAcA93u-W5nr1bfQJPp91w0pXRomgoAUMxgyuVeTVFYGNpaA@mail.gmail.com>
Subject: Re: [RFC PATCH v7 00/23] target/arm: Implement FEAT_NMI and
 FEAT_GICv3_NMI
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, eduardo@habkost.net, 
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

On Mon, 11 Mar 2024 at 04:00, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> Ping.

Hi; this is on my list to look at, but since it's not going into
9.0 I'm afraid I'm prioritising things for softfreeze/freeze
period ahead of it. I promise I'll get to it before we unfreeze
for 9.1, though :-)

thanks
-- PMM

