Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3212DD78337
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI9s7-0001jj-M0; Mon, 02 Dec 2024 12:06:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI9s6-0001jA-8i
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:06:06 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI9s4-0002pv-Qj
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:06:06 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5d0c8ba475bso3065519a12.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733159163; x=1733763963; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6Vu+/68lzUatqjL0/T5i1zwePKtaz9y/5OrwufSccdQ=;
 b=kcNv/hi7NiQHr1pjrm5iKsiDPnRpQbh3NGunoulxNHmHxtvy5zyex42x1n5UPhVxvf
 /gijtx6dbAwP2tFym80pYuTQrW4Ou/YtKCqcThouaW8nAFAVVK3tpwhzL3D9vZH6DObG
 E8XijQq4yPwXT3ePidZjTJCkGjiufsVF1xZrNtxUHFqwg3dn6X218+brgSCyoag6t0I6
 2ltyAdlFXpNIBuGwg7nsaZmIrFQQmTGfyDS6FuXkfLsHafZuDXv/2ZjyuUwt1N9JPHpE
 xkphaYmWXBDR+XvMBOIcc+SmOIi5L2LHIlamw1MeS9+EuwgcKzvBQyEAb+tT7+3/iOxp
 c6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733159163; x=1733763963;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6Vu+/68lzUatqjL0/T5i1zwePKtaz9y/5OrwufSccdQ=;
 b=U65tIQRZf9fA0iktrCQqjlJJ4GzGzDFIJjCuNUac5/pC4yfluzmCJGE8j9KEfEZW7X
 amTJ/6ToukQNpD4YbmygygrAuTroO5+t+VB+RfHwZeInHJUL9KVmH27IKOLm0w/k5Ee4
 Af+34NfRDmmY01pxcqGlkeacZEriEECGFSyjJkhVuHXtL/VvP1ApmALcrWGoPNdb4z1C
 HTfe05unKvwHrlutXqTQd65sG+5cXITUXhBTjbSTdeEgY3p5DxkUms4DqnbjD3T4Xby+
 gwcG8H2fKpLB5Pxt1lDY31rW2iB2EF45kHDgLQl6yok2hNb7EVajhtexT4QoIEzpqjrz
 BW1w==
X-Gm-Message-State: AOJu0YzDvFnknmvZxPxAkSHuXI+QJxqohszAOXzmP/KnPTVv2xKdF0QL
 DtOuC/W/+nEY4Ht1+4pZ8StxqiiDGAj2jdKcYI9mL2q1fC6eTv5GC5A8h2DJcETqG01Je/cgL6N
 NBB1tPJjqLZvK4n4+/pU8uhkvQr1OmzNp07Jo3g==
X-Gm-Gg: ASbGncstG9Hm07ODEHEEHNRi+N1p6UcHaLmfJLXOx8rILpQEYVohf1TrHrs18bvaoJT
 uk5uvi+umTf7SHlcAbrXMObUP1dl8VcJ6
X-Google-Smtp-Source: AGHT+IEAWymmkGwjfqRRG2T5Ma5rGaS5TEv16jJ/N7G+8q2jDuuKO8DAW5sy1wFxqKHzPdKWaWBUfGVrqap6qAG5Xlw=
X-Received: by 2002:a05:6402:d0e:b0:5d0:8498:8bed with SMTP id
 4fb4d7f45d1cf-5d084988dd9mr22288714a12.15.1733159161495; Mon, 02 Dec 2024
 09:06:01 -0800 (PST)
MIME-Version: 1.0
References: <20241202131347.498124-1-peter.maydell@linaro.org>
 <20241202131347.498124-5-peter.maydell@linaro.org>
 <32ba634a-5797-4eab-8806-d691563ca46d@linaro.org>
In-Reply-To: <32ba634a-5797-4eab-8806-d691563ca46d@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Dec 2024 17:05:50 +0000
Message-ID: <CAFEAcA8JTfEaxK2F_n3Ufo_jpyt3P7d3jnWvZ8FoXWF+AhROEA@mail.gmail.com>
Subject: Re: [PATCH v2 for-10.0 04/54] tests/fp: Explicitly set inf-zero-nan
 rule
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Mon, 2 Dec 2024 at 17:04, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 12/2/24 07:12, Peter Maydell wrote:
> > Explicitly set a rule in the softfloat tests for the inf-zero-nan
> > muladd special case.  In meson.build we put -DTARGET_ARM in fpcflags,
> > and so we should select here the Arm rule of
> > float_infzeronan_dnan_if_qnan.
> >
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >   tests/fp/fp-bench.c | 5 +++++
> >   tests/fp/fp-test.c  | 5 +++++
> >   2 files changed, 10 insertions(+)
>
> Lost your SoB.

Whoops; here it is:

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

-- PMM

