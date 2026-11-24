Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A219F606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 09:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rbEkfW65
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVmP4-0005Cc-3k; Tue, 24 Nov 2026 04:01:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVmOj-00057w-DK
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 04:01:10 -0500
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVmOd-0002Bt-UT
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 04:01:06 -0500
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-6767d92cde6so4586813d50.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 01:01:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795510862; cv=none;
 d=google.com; s=arc-20260327;
 b=rRX6WkQ8RyAcnBCV87hsK34JRRYSPh3VhXqpyulZbbjqd+ZRFG1bWLTD37d889fg1F
 lvF8nQNbqfmDTlGlpaW1et3Dhxc/k2RURzx4sTO5KEJd4L4Bk8MPHU9ppnnjT+7u91cb
 Amhtkjw4xSl7p/MM4iXd8edqFLYKrIkbUc/rz9IHaDWGJ05L76kJdIIylWza944Y3m9Y
 G8FJhK74Dw5LbCi05U/eX40Hu18cL/kBg7T1lqTvaW+LJkltThS0a0ZxRKnyIpuzoX8P
 VMdZmw1DwUqG/OfxjRApItQrY8UgTP5y9wIR4UBxNtSBCoDlDoJdclUbfsS4YZymeZFF
 XHQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=f7J2Bb6ofoI2IDgrYAe7OxCTHbHfMsQPF/z0Y+0Aw3M=;
 fh=BDwl6k36vHIQV6sScPDazfHk6uBiFN5kniFo/3yYgzY=;
 b=ShDSmwWM2E6g5dstYQVtptTYr4U75AtHo2rFMRbm4LZccTfB9mlQvi32nUgZqeF3i2
 /qjOY807wLeJZCxAW1I9mIxvE3A+Go//V3e4xFkkEyh68DftR7PghPhGl0wXzoLkGXpG
 Yb5KTcQlA4jPAkYxLDOiCSMVlLQ+K8DcmX0lGVmUbJjx8jYe+CdZ60h+uqIyg6cZawNd
 xIzaiNGi6vZW/+rKznyzRU2mnAPZeVoHzwkU/6fjdDC4qgsUgXvT0qyY3f0lbqYJ/ZLU
 gBoFvkbCVyEssilMilHAcNZ3HoXYcBjORw0cIZhbV7+uEl37d3dP9tl8/GtBwiIx4zEK
 48ig==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795510862; x=1796115662; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=f7J2Bb6ofoI2IDgrYAe7OxCTHbHfMsQPF/z0Y+0Aw3M=;
 b=rbEkfW65WACfabb7fdiesT78yRXBPzjhn9mIZMSDd/v1HfsAjWTtRSqGWAxw2LW44p
 Ls+CgAUWZ+02BwglGsdhR+HimM4/UJxpT0QYQvojPZDL6e6jJkZfK5Vulk8bjG99532T
 3Vj6QQd6NS/HNf3yb0Lc26CHDWQkLXPe137arTGBRm4/+lrqrGhIeh+EuZdtbqBOD4n2
 oR08k082hvnMv1Y5T1jeGc5B1PReuJFSA/5WKSfFsgWJ01sLbmpykGBm9w6++Me/SLmW
 CIdPvIjM44jUzdFL27iMG+gGarIQ0AZASPCDaTWM4W446P3sSPHKAGwlhInUuJmWQH43
 K5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795510862; x=1796115662;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=f7J2Bb6ofoI2IDgrYAe7OxCTHbHfMsQPF/z0Y+0Aw3M=;
 b=f2Mcy8EvlFrFg1R5AcMyADgwbPo4X5qOjxhRqYjMOMiKH8A71Bmd98f705eB1SJkyH
 5ARrLTgKsmaglwyi/NBGs5dxRaFYimAyMdnR34JsRULOC/QTfriPiX/hk7jVT93XhaM6
 fmWIbFEG2SyC1t7Cq7gYv4cSsJDqoWAjlXek5j6GO8ObtLHq4477/2SWN4jd28ESeCH2
 T/MJmVyrAruPjO4Nfq6WqaTD/oiVHeuOtYysEXDF+GAmYSZyVdD6Ey91cC6XIK23xkVW
 2SffeHG9CxrqwEkl6nfFEFmVr9wdj4/yntgOihVZKHzUN8XulbEFINpq2ifos/FmX1EE
 BNsg==
X-Forwarded-Encrypted: i=1;
 AL+hErHpzQT5m26f3MJlFT+BntlyGtiC8lX5t1ds2uuTqN6eWduunf67wwxPwPFQfjudWwEzKU76dkRvmoaj@nongnu.org
X-Gm-Message-State: APuU4Z8UhGDlN5DUtnHniDBgimZByg4znljwOEKerir7tBNwMjPpy0oy
 BYegHU2B1O9KxynTZoHx1shG/EfauRDf+Hkz44MFe4jYLx/AUH/Le8BlJi/ioqBVc07vxDSApB4
 jU351gQ+MfIsutSyyffIrjpiHuIwRexO4vVBB6n0sBQ==
X-Gm-Gg: AZFdTZdPbGy8nEfrOhGFB4OK022JOjxV66S3T2KDSsKVzMiNgA/wvkYO1gFqIgvKB8w
 J1cNhsRvDXNUE6YStKZ3po1d9WI2UhHiI7wiJCpkdCUvHgvLDia+M3D+2lQZmIBprZoBx1wb7Vb
 zHrf+HP/kiA9dtPjNgO5kGdc6aYa1rRZlMBDEFfzMxA6MeqpMcdRPwSK7Yx9SDh6PKpDsB42bKP
 rdQNShQWB9mMi8zosleolgFU0ghjlTQ9E2qnvrloMw9NyLUW81iGG2W7+sBtbHa5d3fDX2H+RTz
 BQY6Ahxsg+sWXSplQQerIuJkoINiR3cmqzR2DP8HxEwgq/u1jEs4C062pqhqW+1pSnw+n0zBtR4
 CwlvIQqkqmeyaGIchRZuKcUpRtmcAUKrfaGqIJj31n1/mEWQlFOpT2w6+wfuSdcXMppYw/LMFf2
 5lr3wo7mN2Su1dS7s9hoBw
X-Received: by 2002:a05:690e:1185:b0:67d:e36c:6beb with SMTP id
 956f58d0204a3-67e03d05eebmr4224825d50.96.1795510861655; Tue, 24 Nov 2026
 01:01:01 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261119165546.3050013-1-peter.maydell@linaro.org>
 <20261124062150.75285-1-kmehltretter@gmail.com>
In-Reply-To: <20261124062150.75285-1-kmehltretter@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Nov 2026 09:00:49 +0000
X-Gm-Features: Aa3M54rAY9w6g9b6dmqzSs9hdoXVXBEQZ3JVccFVLHYCk5KFRo1jd4ymZ5s5qZE
Message-ID: <CAFEAcA8kLHD9MXqYVma8mpHNL4eN2DoizXJtuYiSb638XNLtaQ@mail.gmail.com>
Subject: Re: [PATCH for-11.2] target/arm: Handle "PMU disabled" in migration
 validate functions
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Jim MacArthur <jim.macarthur@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 24 Nov 2026 at 06:21, Karl Mehltretter <kmehltretter@gmail.com> wrote:
>
> On Thu, 19 Nov 2026 at 16:55, Peter Maydell <peter.maydell@linaro.org> wrote:
> > @@ -693,14 +694,16 @@ static bool s_rnr_vmstate_validate(void *opaque, int version_id)
> >  {
> >      ARMCPU *cpu = opaque;
> >
> > -    return cpu->env.pmsav7.rnr[M_REG_S] < cpu->pmsav7_dregion;
> > +    return cpu->env.pmsav7.rnr[M_REG_S] < cpu->pmsav7_dregion ||
> > +        (cpu->pmsav7_dregion == 0 && cpu->env.pmsav7.rnr[M_REG_NS] == 0);
> >  }
>
> the second clause checks rnr[M_REG_NS] == 0. Should this be M_REG_S too ?

Yikes, thanks for catching that cut-and-paste error.

-- PMM

