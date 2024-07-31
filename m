Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB184C52D1D
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 16:27:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZCA8-0001QM-SE; Wed, 31 Jul 2024 12:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZCA7-0001Ny-0f
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 12:26:51 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZCA5-0003YY-AI
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 12:26:50 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5a156557026so8226376a12.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 09:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722443207; x=1723048007; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dTgzw8LbRLQQ+Ao5I6BNPM2fyUclgXHfYs/zqJ9BFA4=;
 b=aMa4o6rFEVjjSZj+NX9XoXWRT0FH5HXmjButlx/XmminlPeFL+JsKAy2sRsKIyyvHb
 vDKcMeCFEfer4ZH5Qi5K4ZwI77HydJPTOeRc7puFagfjalEHNKPKvSg1sbhz7Wd5wC4H
 INX0IcUTlSraeB4woLwnxsgncu7D5HPeGSOBAXV9zWuZUXF2AzE23RsTUS8pjx01StFn
 Fm8VKM6je2ewTOwTbkxNxcNox0xueHi6FBZNdmTLMgEt6SPCm3pQfMAwXEylOKnP+QoD
 WJ27Gb3Zeg0sk+0A3Yr9TvrEcqlaPr5VBnZNRFwFwd3GMCtPpIKQ2HwEdOzJlOaCKV+B
 8xZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722443207; x=1723048007;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dTgzw8LbRLQQ+Ao5I6BNPM2fyUclgXHfYs/zqJ9BFA4=;
 b=RAZQM/gLx3Mf10OGl7ZWpkSXIKJf7JmvEQDdJkRRHH361E1+guTVJ4xMG0qlVma3i4
 4MFHTmVkaA9GOqxt49S3c5uEqvA9RdkqjlIcPBJcTzNfdsGB+3mkqcs6vfnKQDS6h9EC
 d0iJi++gIFeQK0U+kY8wUpm57OfITzZYpTyqpelqE7VYR7jeFl6tvVz+U1eKBjq4tV6v
 mxVJ4prcWquJuHjfmkc737YwltnMKB+hf19vr2sOAXIUqj599h4I7fnFXKtn7NzwOKo4
 tnPCoYW04o6Ng8H03QmsxWPZ+ZUaLIy+2RwUE1bMEcn1fvCvVXvUvMd+Y2vQ5pVqwwyi
 wXjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUX+duDt4ItG7LcRkuLiZLI4qHwwDtRTkRO7ChJZmUuHYgyQXpPv8AI6gABCQY8F+nGrVO1J0wRY8mc/VTFMQHGCvTKgz8=
X-Gm-Message-State: AOJu0YyTKFMs0clQqJoFL2gZ2FztaSHKc71MzWbmOiwdtBNm6Xrxa9OU
 b5CutY/V1YN5fCXcifSIhJPfgoDf7LH8vGeSEenskYZM3d8Xq7q9DIRa9bh9oeBfwAs29tFwXcc
 73CvVc8rlTQL9YF4ZyUuOlUZU4KZ3d8Wl2m0lSQ==
X-Google-Smtp-Source: AGHT+IETfHh2H+X1GzNSHvN6cVddH+aMFAA+K+6KPaJ+fO5kIjzEFn7uks8Fy9nR4V/32N810VXxOn9mLVIGchtzYAk=
X-Received: by 2002:a50:cd5b:0:b0:5a1:3b03:d0cb with SMTP id
 4fb4d7f45d1cf-5b0221f08aamr11163380a12.32.1722443206919; Wed, 31 Jul 2024
 09:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240730155819.2958924-1-peter.maydell@linaro.org>
In-Reply-To: <20240730155819.2958924-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 31 Jul 2024 17:26:35 +0100
Message-ID: <CAFEAcA8xiaKYm1KZt_GU8jwkRqv7ZbO+QdtQgj_oTj9G=XZJAA@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Handle denormals correctly for FMOPA
 (widening)
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Tue, 30 Jul 2024 at 16:58, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The FMOPA (widening) SME instruction takes pairs of half-precision
> floating point values, widens them to single-precision, does a
> two-way dot product and accumulates the results into a
> single-precision destination.  We don't quite correctly handle the
> FPCR bits FZ and FZ16 which control flushing of denormal inputs and
> outputs.  This is because at the moment we pass a single float_status
> value to the helper function, which then uses that configuration for
> all the fp operations it does.  However, because the inputs to this
> operation are float16 and the outputs are float32 we need to use the
> fp_status_f16 for the float16 input widening but the normal fp_status
> for everything else.  Otherwise we will apply the flushing control
> FPCR.FZ16 to the 32-bit output rather than the FPCR.FZ control, and
> incorrectly flush a denormal output to zero when we should not (or
> vice-versa).
>
> Pass the CPU env to the sme_fmopa_h helper instead of an fp_status
> pointer, and have the helper pass an extra fp_status into the
> f16_dotadd() function so that we can use the right status for the
> right parts of this operation.
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

I just noticed that there's an associated bug in gitlab
and that we had a go at fixing the denormal-flushing of this
insn in commit 207d30b5fdb5 recently. So I'm adding a note

 (In commit 207d30b5fdb5b we tried to fix the FZ handling but
 didn't get it right, switching from "use FPCR.FZ for everything" to
 "use FPCR.FZ16 for everything".)

and

Fixes: 207d30b5fdb5 ("target/arm: Use FPST_F16 for SME FMOPA (widening)")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2373

to the commit message for this. (I've taken it into target-arm.next.)

thanks
-- PMM

