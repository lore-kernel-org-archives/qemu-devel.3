Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457C6606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 17:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Id8NcrQe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWzb6-0006CX-5A; Fri, 27 Nov 2026 12:18:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWzb1-00066t-Vd
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:18:52 -0500
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWzaz-0006ql-Se
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:18:51 -0500
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-67be1e468a8so7954302d50.0
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 09:18:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795799928; cv=none;
 d=google.com; s=arc-20260327;
 b=ZFZsCHXb7js2JRMCO75y8IZQ1gxAZ/nOcRaRBrDLAWcjMnY6qUo0QXiEwTrMWBcNbR
 4IMECAD40cmEjCuX65TUmL90U6NhZzVYpLxQjCK2CzRw25yv4Z54af7WOTT07LBK4wjz
 M7aSj3XaXb/HRW6deMDNbu+/rWX+ctQiJDkp5f88nnzc2/Bk1FZqqJhB5lTco5Cm+TcD
 DH2t8wd8zTu4yQ7/3om7W50gVXfxkcTafMuRaHEGW9bv565iyI3n6KSY2sWW5iNZiTdj
 5wKHTDrqMpQOXJig6w59qvG+/hkxHczslotQ1Lfwnmh6sSonCu30qdfhE3tMSlUHM2xX
 YDxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DkExGWsAVhbP89rZ5UXR8iSrPhkB24HeUdkibJZMJfo=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=FrJB0R9bucWDq8fOxqS2v9Rvs/bD8Fkx/KCIKnwKdeUeWCnZIUY6e/9hWu1En1FxBK
 O0NrTLCrR58ZIecwHjgK71uLMn2DPO5nnfEilOxLyB9Ze1Gjlgy9RJxwvnE1rc1VIS95
 85SmvTt2pRhr5v0XF1rWgwrrr9XqjjKFlgIMTMLD1xulYOwjUYA9vJESFi7RajzgTe9d
 xlxs1FomPeHXAzl7/ditIVwd6+xhaKcDu42W4xcO862dPrb4Lnv/LR1Y9DHBP/hTYwwU
 pEBTRvLqZRpEWcayeRv8vKcw5h7KvTt46F5E1G5CkxfIPbfov4FL6c7XTJadFPE3e9FJ
 GY8g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795799928; x=1796404728; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DkExGWsAVhbP89rZ5UXR8iSrPhkB24HeUdkibJZMJfo=;
 b=Id8NcrQek0do8eSylcpA9AD3lHg3ORo8VH/KMQrVJ7iq61JtRZbxUfuzLbdWDrvTes
 wBh8Q2R/Kl3jv3JZywJZc4mxBEK8/4QOUP245kcPMDQ3xuuNCCmHhspUDMyTEVw3mMhP
 A4N7MjNM2iapYOLpvoZIIq+yKdX//4Uf0gb3rHl7dU7OrxEfuLfFD58hZqfVJ7woXPU/
 CdMfsfk+NtLyjMMZOw7+pqtmr6o08XMs0KL1fTiBtBjM/kubYiL1ZWbFOqKw4M7xHIF2
 R3jvKivHIICVWtEmSvyfyHdKfDSHD82SkJYWXfbUtLH05rH03oTSQ6Bj6fgckM2Wr3GE
 0K3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795799928; x=1796404728;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DkExGWsAVhbP89rZ5UXR8iSrPhkB24HeUdkibJZMJfo=;
 b=IGijG9hyQO5SkM0gSKFoW2AxpK33LzAFNagFU3TrHqsxQdbp8KbneXr43PWZjIwjgM
 3Ky88Ha/uIPOzeYcBRBazl+9F7ebX8HXmGGJ2Cmm7yD1a0mWqDuM8Q5bJRGTNXxuSNZe
 RNQJW7CZsOUsat6wqG6RWxZWbMxSStziK2vKD/8MTti0RxBT5tk2HHfcv/chSLFai95b
 /OTx4yByElULn0A0KiiYbCj1NbQ54Qd3cVhPr5HofwjeVT6ZSWHA7Xj6iKtMvwJxMi1g
 lRRwc1osupZDcKcWkaPK5oGxu6GzfMGVED3SLnITvA6pVmORwdG8RYNEddDMGMDrScG1
 Y5yA==
X-Gm-Message-State: APuU4Z/OFV5ok4pFzVBGT9PsdhgFRT7maAl7C7EiZMc003RQuzCEQsvf
 m/o5asI2zRnDmrzHeQTYtkiWQAYBwkgan4Uz7R7AcLf8puSJjIawFNcncGaIEWRDOTNC2+QMQYR
 Ff5aXQxU0u3BPGHz09d9yl6ogpyxX4O2y8T1YkDbLJg==
X-Gm-Gg: AZFdTZfPxCKoQPSG9QeHlZkWezwZuLaAC9JWT/xWCNAKzvW+MIv2V706QZcgevo/ee5
 UHNL+GK7D9x3ryWTbtz8aCdyChqOVkpkYH+OM4Y/Z5H7mbCedlWxpeCxbsJT0P5lNPeCK9lSAAS
 L1DpYlLP6c5t1h/JqkL/ip1EP9H1b9TA4O2EP/YxIdbbh+awX3z+UIdH7MsGwkL3dXzVpBIUH1L
 orB4uXg66DF7hXkRmLyDRRaNOxB0TqZri+AaZ8fkHZMadiINf0YkagjuSK6OhCYrs5AikOTUIYN
 toQ8fC5bPUKyklhrvBpyW7CnvEkng2NQoQvqBQlwE14cyVMfyVkzIt4lsn4r5abKwlvCYfaM/qI
 iMUNXuWhCdrlV2oT8xi4rCXL57Ghezezybz6a9CEkOsjQYdeJHo9lBb/7TBRM1QrD3A8OD4DS0Z
 WZMgffTp29NJIy6PDQ6fND
X-Received: by 2002:a05:690e:169b:b0:67c:1ebe:3850 with SMTP id
 956f58d0204a3-67df42bb2dcmr11115904d50.12.1795799928447; Fri, 27 Nov 2026
 09:18:48 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030194318.319310-1-richard.henderson@linaro.org>
 <20261030194318.319310-10-richard.henderson@linaro.org>
In-Reply-To: <20261030194318.319310-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Nov 2026 17:18:36 +0000
X-Gm-Features: Aa3M54rxGfqHeCqJI5HNjHlsMvrEjtYkP6DYPk23C0_ilfzP6TLxhR_jlyXQKxI
Message-ID: <CAFEAcA_s9K3rwbA15CGJ9TFJnhDWGt5JNEQ+1479wu97oi14Yg@mail.gmail.com>
Subject: Re: [PATCH 9/9] target/arm: Use tcg_gen_goto_jc3_i64 for aa64 branches
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 30 Oct 2026 at 19:44, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Assuming FEAT_BTI hasn't needed a page-table lookup to
> determine the BTYPE for the destination, we can compute
> the tbflags for the target.  Pass all that to goto_jc3.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index edbf67b03c..4a56fa70b7 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -566,8 +566,11 @@ static bool gen_indirect_branch(DisasContext *s)
>  {
>      if (s->ss_active) {
>          gen_step_complete_exception(s);
> -    } else {
> +    } else if (s->tbflags_invalid) {
>          tcg_gen_lookup_and_goto_ptr();
> +    } else {
> +        tcg_gen_goto_jc3_i64(cpu_pc, tcg_constant_i64(s->tbflags.flags2),
> +                             s->tbflags.flags);

Why does tcg_gen_goto_jc3_i64() take "flags2, flags" rather than
the more intuitive "flags, flags2" order ?

-- PMM

