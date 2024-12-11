Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B0A0E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPFj-0002l6-KM; Wed, 11 Dec 2024 11:07:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPFS-0002hq-Mz
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:07:40 -0500
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPFQ-0005U8-8g
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:07:38 -0500
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e3989d27ba3so5369151276.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733933254; x=1734538054; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QiAv8VaHWBVzN7pAElATdirdUWbd5FLcw9NJ8tS8z60=;
 b=O/Pj2aaEVxvh0hAiIvXGUPtPTy3YmdCtMSgJ8ahzP2b+NsaIG+kGfLdGIjRBczjU2s
 coifqJv4oTTqQdu9c4NA4XlbLlSVwwNPf7AoNrP8r13Syo0zuKvVWJt1DZ0atYHyPWzo
 YpIwqq7VEyeXFFGPEgLJt7EqL0rWg4Nt6chj7nwlHw0wMj2UXrJHfWZ+B+XBV3McHUsf
 mYuQhDE/BJF86LRHT3NOPJV1jKsj5YNe5dYhQZMqzp7Dqd7WwnxIQIF9WSG4Vmcascns
 z7hIPAhLvkTql25lkfABfJ6aHkJ2v4PRcna4PToKGNQ3O+c0rFRVLC192/bkfKLwlgq3
 K0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733933254; x=1734538054;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QiAv8VaHWBVzN7pAElATdirdUWbd5FLcw9NJ8tS8z60=;
 b=fBe76JMPkzJDp+PavlFBAQPC570VbBophIcR8tRvM3lxzeJVPsPvDjSV5LSUv4ivsU
 UHj05DfVgoaUs0kxpU2bP1QnOb16RFkVSEsPO8W9O37E6HzFAbRGbnafUaWNhi5IykTJ
 n+n5TJYyucAEfSaSv+0pDAb9mFQiLLbaRvLCYBKDHXlbV9x4AS0PIrb0zbUVhzub1un+
 Wg7mYmdC7kjDqBemBz7+4pfh1gGdIW+qvhLQFOQQswPBN6e6RX+oT/Zs42/lsPL0wcHQ
 if1Pr3V9ibfrWxPWUaJExToR4nn1wGBIuU9u1RlJwkBkH5UVlx5eogdGXi2XE1iuwL+n
 3bvw==
X-Gm-Message-State: AOJu0YxyrZuzPCg1ieuEXXEtW5F9NBOiVTG5C+FNPk49aTYba+6F4fmZ
 JZDLkY+ptabFZH51Z4GG80LU4iMaw3TubdNbmHjnRjZsE62/a0Y8vXY+yH6kXvCpFdRCBhrMCvM
 TP1GzNJG51YnVZGfrVVtgwB46I0Oaw8PNQmp85ULYA5Kbz/uA
X-Gm-Gg: ASbGncvKd11Bf06kxQJvTyk5fS3wLiygK1fI+Osb2pKarOIJChOagLxMZqN7+fCnsvy
 FzcaGlDKee/GaR6DbhmZdP1ZnQmIwdKAvQWlX
X-Google-Smtp-Source: AGHT+IGDGNOVpdhXuVdU+BBXUHGBab0+0+aseOShHVXaC5C8q7eBvQ2UFbGKswZ33s+5ygs2JgoalTxI4pQVA5pGY5Y=
X-Received: by 2002:a05:6902:2b0e:b0:e39:a1a1:f042 with SMTP id
 3f1490d57ef6-e3c8e42e5c5mr3776220276.2.1733933253957; Wed, 11 Dec 2024
 08:07:33 -0800 (PST)
MIME-Version: 1.0
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
 <20241210161733.1830573-64-richard.henderson@linaro.org>
In-Reply-To: <20241210161733.1830573-64-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Dec 2024 16:07:22 +0000
Message-ID: <CAFEAcA-psixV51nP0oee5+DjXjcztH7--01=S4z-6Pc0BOKvwg@mail.gmail.com>
Subject: Re: [PATCH v2 63/69] target/arm: Convert FCVTZ[SU] (vector,
 fixed-point) to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 10 Dec 2024 at 16:29, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Remove handle_simd_shift_fpint_conv and disas_simd_shift_imm
> as these were the last insns decoded by those functions.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

