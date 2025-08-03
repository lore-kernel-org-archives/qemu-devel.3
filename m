Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5005DC87FCA
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 10:43:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiWBV-0001Ye-9f; Sun, 03 Aug 2025 06:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiWBT-0001Vq-2S
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 06:43:19 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiWBR-0004rZ-H7
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 06:43:18 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-71b4677044bso37408517b3.2
 for <qemu-devel@nongnu.org>; Sun, 03 Aug 2025 03:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754217796; x=1754822596; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p99cb/zfjnliihvl+1KF19UzQ540CugAr43jdkelDFA=;
 b=LWXZw0VSOx85BmEwuvUijeOjjB6l9pgDFeojVPXfzAhZPEAwnqQ7wmiecE42fhaTCr
 FHHSi24jsG/vUzjxgD1SH9xP9l/OcWqSfwwr5Dss2se55URoblhhP7Jy849W9iNx0nQI
 YZvhRTR/0s0PPjcY94rR16DIwpL5pu71Uk9Jj78oU/6ZlngkGNC3cKgh5iMEUemQJFJ7
 u0YxU1bSM1rXdrlxr44U+RCwN0nzB0Qh4PUQvzdcPX5wVqX170VNmYw4HL/8DfTdzVj8
 dmWkJjOadWcp+Ykums3L6GYeGredPd2QrztBSNW/h7Jgo3tZfgTcBsVFph2OUT5Tt45j
 OrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754217796; x=1754822596;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p99cb/zfjnliihvl+1KF19UzQ540CugAr43jdkelDFA=;
 b=XpHtQHZUa1n9/sIgw7dXmuMvMsLi5J3HHktY6QS4Mijl0NsI2u7QOpwGVUpKMV6YRF
 xL8VDOIngfMM9fppyGg98+U4QGaYkcXktPvsRnF2xBAh4u3WCvEU8QVK99L33EjqUDyG
 hjexkAS7ZP9BiuLJSnJ41LRvC8yPazVycDMkiSeN2F4wBRw8sxeASEXr96jgTcM2/14C
 UpLstP0MN77tnkVIe7lmH+kx23zwCjImcvh6vaYUdlfHd3sSM4v56NIS83kEwYnm89Zk
 PUgV1jIoe15x/im7P+2CMO+iqKriWjbLw+NGdPAAu/MrGGlvYd/7FrNMV99Ijea9c+XA
 8wDg==
X-Gm-Message-State: AOJu0Yz9wFiu2hRscuV0xDcjA4WfmQita4x4hADPPhH3V4JYsRK3tGmG
 55o/jxX608gvDFasOMtVMPgAg3wNDyVxYHJH3ADa7VQAu2rV2Ww/QChK6hJPXgsxMD23BmNxSaR
 cmJKvs6k1psUAgT5uGo6cFQXW65R216JSdfFC3VlJJWcT/2Mr+kQH
X-Gm-Gg: ASbGncuEP0XjfFiE8kzlH9U1PKKWinv3WIEgtw0IgvWahZrjMO3xJayk0Tcb2tzUJc7
 z82NLN2riC/d7nSAoeXdMUZjVbdJpIhzanj5iCQtYFDekbeYX1+D8UL1I850ExMkhkRhbSxkMUQ
 CjkFuWQRbe8vBWjs25c9TOg/yaGRBMqWvCnw+HgCLQxzOhpVaG/oCnIgofKQvW6NzwulRzwXFDO
 x0KbMu9O3yxwQwGF1A=
X-Google-Smtp-Source: AGHT+IE9rbOw47s/x77F/UQHaxT1HgRhjJVp0y4erMzIk5ic0dRkR33+9zluggOeIFcAK3KkyBWymu4Ab8E3ZilBAFU=
X-Received: by 2002:a05:690c:6893:b0:719:61b8:ffd7 with SMTP id
 00721157ae682-71b7ed7407dmr68755427b3.16.1754217796215; Sun, 03 Aug 2025
 03:43:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250802230459.412251-1-richard.henderson@linaro.org>
 <20250802230459.412251-2-richard.henderson@linaro.org>
In-Reply-To: <20250802230459.412251-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 3 Aug 2025 11:43:05 +0100
X-Gm-Features: Ac12FXyCDHacuePwK-8Xw0IojA7UK3r7Gf2ValcjHwR_BVReJFdH3-9QNoGz-FQ
Message-ID: <CAFEAcA9eY5shwTt7kxiny+ms5g0m159QKRcoyUEywXxFuB7BuA@mail.gmail.com>
Subject: Re: [PATCH v2 01/95] semihosting: Retrieve stack top from image_info
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Sun, 3 Aug 2025 at 00:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Remove the write-once field TaskState.stack_base, and use the
> same value from struct image_info.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

