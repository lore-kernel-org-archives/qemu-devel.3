Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFE6606A324
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 09:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gvUb/QRh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJSVa-0007cc-Vk; Wed, 21 Oct 2026 05:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJSVV-0007cF-PV
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 05:21:13 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJSVU-0004hx-5z
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 05:21:13 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-8ab395abf79so4356117b3.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 02:21:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792574469; cv=none;
 d=google.com; s=arc-20260327;
 b=WxtYpWh82YDVCpNAzjMVhV0sDuQhzqvpdkOAE3XcHNky5/5bj/WqGtrbiHsu1fd4bs
 KbdFWTbpoUmWx4xSaYm1sDb88d9gdIPeNBSWl2VX5SGMPvHIQZV5dfOv94JZu7vkARLC
 oNYeyJA0jTWLnjGMVncGREhq+7PYqJgXfgTsIVwVCqfRi1aKUsJFFc3HtG8AEcWJ9wul
 X9YIxWRgUtf9VYQM3oiXm8a3EZnj8JCRlM1+CyRTmxwyBAXsDgBx/uSh7RcmHvSFYS2r
 xPI8L/HKHdOheMmKC6GIvi5Io3fDZt4UDzX0FR6Pu+IySqrFJunws1etkT75fW2hGKOf
 Hlnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mwCW/RMRNWdbtFnsMPcVhq6D29tb+I8RwtKdnIwQDq4=;
 fh=6QH51j6kQA+30mYltVCTHeF1XafQFhS15IrB+CrEUmk=;
 b=RKtkrpLnceG5o3cYsbH+K3nXjTPhKnYFL90BxEvgps5dmz1Alvu8WsH1oOVzSdK94i
 YHRyppCsUO6UKSGn/HJRsuTZWeILWEJ8VITKRb2H4RbsA/dM2jNhZHOIc7RiOHC0NWxG
 B9dh7cRkeZT14pf6T6ss5MXA8B8HmRJesVfqB26mDWDp1WiclbkWizM2mFPKjCTWu/vx
 hKPuO+gwwUiLLbIKqr+D8QbaBeO2AT8abzjzltaN5aLNcpS4eSRAsD/ZGzp388iCEbxE
 pNUQ5Zv+Bh+E+Rz3Wt7Elz2uPbHwAjfp3P/cxTOmAtdFcR7G55nj+NizgeQkCeOXmWI1
 /BqA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792574469; x=1793179269; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mwCW/RMRNWdbtFnsMPcVhq6D29tb+I8RwtKdnIwQDq4=;
 b=gvUb/QRhZZXGCTsNc+RgUvP4lFtj4NsISpv0GD0vk4zrzOA0DFwVcVzdb7q0ILxJyZ
 oVbgjVwGV3lqZPBgZkWqIFoyx+YBIn/1/+DWCqIJnc91vUTHRFItrZyB6jxmvSep3ejQ
 LbWjs4YGXylpajly98yB9MDk94nh7+VQIvixCErCibhY/UxQ6H3E828leF9/jcUFPsX/
 8d9EH5L2yyqweXll9tb5fJJ8mKaTaFf8HdEtaqYNOLe4B4hBOCBS1Vu7Gqw0SOlSZnV9
 UaXqOEjGnE9Jwo4pJQpLmkJGZ4Ezv3+72QTq0h5KSo6kpl+eeBY+EflAucOlJlimf88A
 nJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792574469; x=1793179269;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mwCW/RMRNWdbtFnsMPcVhq6D29tb+I8RwtKdnIwQDq4=;
 b=qCPTlkB8wzH8F/MJBPMpn91CPuV9ZBFbUeA1iUu48E2GKezx8q1Yzb1biG3t3SfCtD
 ITQjcz/YJ2O9JvO9pQcE0xjJQR+EdlchW1ju3AqHZrb0RN1nQ1+6hPuILDgN35Tsy1r/
 2goVBgfPT3hh58R28JSK0pxZfX9nD6uPgOI5xa7MdBNBxu5VeFdbyIjpPUQQxpRQKdsJ
 8dO0VHeSL5ZHj74v/Bky6zgxm0TP1Pxi/yuH5Y715h4uaMnaQIM8mYS478DxKmCjgycj
 4KwYWo2Xv4xSkrzfIP6S+rKp+Ry7Tb2P0UYY6sZGExYh16RfvTvcGYLfbdArt8UwItjL
 yRng==
X-Forwarded-Encrypted: i=1;
 AKwUvByo0P72CudH97rmWJongWTmSM7V8EQvSUHM6YSb5xfK2PD0MS/IX5g52PgmGKzyx5OXb8xS84bOAGDf@nongnu.org
X-Gm-Message-State: AFq9FYJI1jvcHQTzqCv+FOsXuzN62d00+suvghdld9wHjoyRo3ys1SvZ
 WD8VhbtSR4u7p8fAQ9C29XqgwMDpIwHfD6thwjAcYeJbSPWj6oM8+vfJ8/r7JqKMUKT+g+YYSLD
 /wCe/SIU2BHwjxIoLvEoOUEVHqwuGITlxP9v/DvxJJg==
X-Gm-Gg: AYBFou31zbISdBZjeivZP0tswbQJe9UU4c0Jyd2kgJyML51yspF6994bAMHTkrDhOpR
 n2d36+t6O+mojxPrqvmKpv3cxnW/z+fk2EoK5aGk/mg8K1Lhk9n29jejs4Qe83ZDeXHKYCcy0ZN
 fViSSWwI8nLRyEkplMlKm+yPXbxijoUgr+GM8XZzLfeLkBG98YbUw+0ct9DbFz3EyunvJfb3OBq
 phCqsMqwexOdwzcc2+vl06yIpXdiPKm2d+n7j/F/O9fL9l7C9Tk6jBM3Me74donnFkx8Gq/KpKl
 JqKW4DmFeFGXnGy+QVc19KNnPG68Jw/RZ77ahq1AnnsYepUB3YbFy8Lxz6PcmAbjx5PhAx60/tF
 cXwylvdaSxwAgKYxr2/nWVlien/PNzIVlnNOL+cEi2aE/C9jrxoARUxpTxa/ls9MXWS4vB+rlHD
 ScyQOJwZgOFsmz7d8O4Nwv
X-Received: by 2002:a05:690c:660c:b0:8a8:6fac:21af with SMTP id
 00721157ae682-8b133c99130mr8616917b3.12.1792574468902; Wed, 21 Oct 2026
 02:21:08 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261020231602.24344-1-pierrick.bouvier@oss.qualcomm.com>
 <ceab474d-ea17-41f8-817c-86f90c0feef0@oss.qualcomm.com>
In-Reply-To: <ceab474d-ea17-41f8-817c-86f90c0feef0@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 21 Oct 2026 10:20:57 +0100
X-Gm-Features: AclHuK9NZebCGnYkwx54C2-MRsPU1lo0CqNMt-QfflXf9j2guh_CBxOhvbR_G9c
Message-ID: <CAFEAcA8-evgTa4GgvHV7HjUAeqnee1CN3onAK-EBH42saRqNag@mail.gmail.com>
Subject: Re: [PATCH] ci: add automatic retry
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 21 Oct 2026 at 03:41, Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>
>
> On 10/20/2026 6:16 PM, Pierrick Bouvier wrote:
> > When merging PR on the project, it's possible to observe failures on CI
> > that can be related to sporadic test failures or infrastructure issues
> > (pod eviction with Kubernetes). As a result, it adds latency on the
> > process and workload for our top maintainers.
> >
> > This patch sets an automatic retry (supported by gitlab out of the box),
> > so failing jobs are automatically retriggered.
> >
> > It's important to note that in case there is a real test or build
> > failure, concerned jobs will run a second time, and fail again. That
> > said, it happens seldomly since sub maintainers are supposed to test for
> > this before sending it. Also, the retry is limited to the job that
> > failed, so it should be cheap in terms of CI minutes.
>
> Will this effectively mask those flaky failures so that no one hears
> about them?  Is there a way to find out about them with something like a
> weekly/monthly digest of failures?

Broadly speaking, it's already the case that flaky failures are masked.
Random infra-type failures / random timeouts /etc are common enough
that when I'm doing a merge CI run I will just hit the retry button
without much deep investigation.

In an ideal world we'd pull down the gitlab job history and look
through it for cases of "job X failed running against commit hash Y,
but we also saw job X succeed on commit hash Y" (i.e. the retry
worked second time) and then check the failure logs for what
kinds of things are intermittent like that. But that requires
somebody to put in the work to do that analysis. Gitlab's own
CI job history web UI is very bad and doesn't let you do even
basic things like "show me just the history for job X".

thanks
-- PMM

