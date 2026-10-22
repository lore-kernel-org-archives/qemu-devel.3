Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D40606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 07:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fg/eTJ3+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJnJD-0005GQ-6C; Thu, 22 Oct 2026 03:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJnJ8-0005G1-Jz
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 03:33:51 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJnJ5-000125-Kh
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 03:33:49 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so1271210f8f.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 00:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792654425; x=1793259225; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nBr7YOQMmpRKMsFEccKCMk1peJeeiGq2VMx4PADvopc=;
 b=fg/eTJ3+ase1MDtV9CZVSAJhlpBWTxqc2TO4VIYnHRelqBFnNOjIpJnKWTlXfA7+E6
 j7+7UmrvXkd6LxxoV3hTrUADkk9N1+Za+2W21t4VofMGmW2DyQdAqvLSd4pFJJLS12MG
 +qeiNGtX74mHQICxZlf1gUI0H51GIslczFzG81fBcnXWwlfv+IwtaAdepV/6e+z2cZLh
 /uRNeKCJc8MRDOMqT6doEzvdXO23EppJ/1DuOBYURo86RR3as606ZyJZP/JuUSyYrzdJ
 9/gcdSMKrKoBUdMbFRTXgEAAHBvt+CTKPQRnYezXJer6EZodkhI5I8LEzebmH95W/pv8
 gjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792654425; x=1793259225;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nBr7YOQMmpRKMsFEccKCMk1peJeeiGq2VMx4PADvopc=;
 b=NDQbT5iE/Cq8q7Cmgv6tw7AAfVFcevzN+wtKCOxYd0U/XXXSmJxOKTZsUJFCGR51mh
 BqsfF0ZmrqcKFYL6vr5vv+LgugrCxxAaz443J5aFUC9BdYBerZ73QbTe99pFaMTZK7zN
 FzCY8YkVK41DJx6xNRmX1uoK5zIBJTofJORKe/qk6mXLacG1qqIbw00U4Ko7bS5MFtsg
 F2dGiVzDMcQH74MZVouOTYRZjtcbZ8Uq9ou7VFPsjnvuPFBveMTFrbSMiLuvWOZXXaTb
 rkw21DHmb7BX4kkQyOQ/I0i/16a82VpNkE7nDb9dTWJ/3c8yD+mDbnk+WB+7cGDQsbyy
 JvMA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwRr0wTZ8Xy5RRkXDiS9UsfB1f70BJ/uQz+6tw6E3eS+LptU9yjA8FzYvFEcPxjPpfRkV9NYQITDxCN@nongnu.org
X-Gm-Message-State: AFq9FYISJWnjirIYFEC65L5z9kQTqcb+FxVfD6q8l8tmuDYEukH1mrMt
 FiE8PdTq7pXtVbougM197WiBQuMTBc04WeftVvjX9aIuY0JvZDPgNcQ9IINARheB5kw=
X-Gm-Gg: AYBFou1r+w1Uwzw/iIwOlyX7wk5oEgzgHsjoOGe1dKmA8yjzY6xMOM45SOjaPt42oyL
 JNLVg08eyuBCQSrSdUUk0BxjMamPmC+6nx5rDesL8elhrKZOX1DszB7fghR3vSKOO97TQF23TgW
 aA4gW5ruHemiR4r8TFfybKSPkRZ38gcZmJjWW45jawBy12HYVYYuGQ8xdPT2OWSq5V//4sJQWDP
 w3hjdBhE1SUIsZpzPxlUpPKKv7NLVpwVaaZPjMn568sXSxEQiRoaHFOGCtj+IV/kskRmTpnALIZ
 9D82NHohxUz3LM/XPGyTEFIiH3c1ATzm0bnhMShmAhF6Oih5Y+Jgf3iyEX+HEFk0yiYSmooVY4g
 jIiyXf1+y3HjRkZAhEku39e5b8127+Svd05q+e8W5GICtHPAx483zQgfWc6mLf+fk2d1Q2o5nzQ
 L5LHkCf7fxOJb/fF7+QTFe7Rit9anFH7SteZfjJMSV0R7NG4oxWSuienZN2Dn84WZgVt034Ampt
 GMnXkxxE1rvKRm4ZQCT/WSXWcTf8atKDL6WMASXlrePH3HgoYcg3CIV/LEy9OfbLb1GpwGuq/2y
 LaV7ybHvNwu/NiXTMQR2vnPBiWA=
X-Received: by 2002:a05:6000:4310:b0:48c:6a6b:69b2 with SMTP id
 ffacd0b85a97d-48e264b5185mr9474297f8f.27.1792654425107; 
 Thu, 22 Oct 2026 00:33:45 -0700 (PDT)
Received: from [192.168.2.121] (pd95f64bf.dip0.t-ipconnect.de.
 [217.95.100.191]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2581f0d4sm10692517f8f.13.2026.10.22.00.33.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 00:33:44 -0700 (PDT)
Message-ID: <9d5de336-72b8-43d0-8d6b-0d38118099d9@linaro.org>
Date: Thu, 22 Oct 2026 09:33:42 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] ci 20261021
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 stefanha@redhat.com
References: <20261021181932.9555-1-pierrick.bouvier@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261021181932.9555-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42d.google.com
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/21/26 20:19, Pierrick Bouvier wrote:
> The following changes since commit 8967b2fe1b2aaae3c29e207d85fab901d580a2dc:
> 
>    Merge tag 'pull-9p-20261019' of https://github.com/cschoenebeck/qemu into staging (2026-10-20 07:04:06 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/ci_gitlab-20261021
> 
> for you to fetch changes up to 3a6d37c9883d21529a01e3615960696f91499153:
> 
>    ci: add automatic retry (2026-10-21 18:18:33 +0000)
> 
> ----------------------------------------------------------------
> Changes:
> - [PATCH] ci: add automatic retry (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
>    Link: https://lore.kernel.org/qemu-devel/20261020231602.24344-1-pierrick.bouvier@oss.qualcomm.com
> 
> ----------------------------------------------------------------
> Pierrick Bouvier (1):
>        ci: add automatic retry
> 
>   .gitlab-ci.d/base.yml | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.

FWIW, the first pipeline containing this was entirely green without 
intervention, which otherwise has not happened this month.  I don't know 
how (or if it's possible) to see which jobs may have been retried.


r~

