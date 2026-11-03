Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E37606A334
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=EWU7cGzO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOGO3-0003vY-Tz; Tue, 03 Nov 2026 10:25:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xOGO2-0003uv-Ck
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 10:25:22 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xOGO0-0002pO-LM
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 10:25:22 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3acdcfa2bd3so3378005a91.3
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 07:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793719516; x=1794324316; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YEWp9mshRSnGoOt1v4CzzkC8siNI0ENtntw6fT6S1ec=;
 b=EWU7cGzOl+jU5dqfM0iy2rf511gj+aTBZuV0mk7Yy3FSUtJtoIsH78q+hRCY2bAMdK
 +L0wxMYGRyDhT9exVZYK3BNnEGxG6mDgWagAGm6T9474cNby/7Fm/WHRW2PbJJncaSrz
 ET1spl5rZPsfzT497COWkvlCqiSRw7nWlgxQzSWhGe2KyslyEeCYsua9bYFhQu8P+4UM
 N5305m2iuSa1Tid+8TM/RGGlukOpIHNMtJdNNcUqfrlnIIblyht43DUaUYeRMGh0gkRr
 QpQ7nP0pT9DLiQ4Dh6Kb3nFWLEUTcvjDWKr7qolD+Bk/HvX2czh+Jildi7Ol/nmYFxEK
 NrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793719516; x=1794324316;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YEWp9mshRSnGoOt1v4CzzkC8siNI0ENtntw6fT6S1ec=;
 b=x99PyroiifwPFOYtpRQH3JHy69yVP1Dw4bE3NxUbJPrU269fnDywyQhngmtDGQlnjt
 lBwiG0venJe03K7GYb708bhGe2T0vnR88In6Q+0IBImYklEa/MNFvpUq1CXnK7HeVfqd
 EGmlB3vyXr2ga1MVWJNcXnIsCQDa876Vf4LjO9UVchTC0qA785NBrLJ7omCgGkvqeHyc
 3De2pj1ViyZk7eGxMIjRqhP8xHfiSu2QEdOuL/RV2/h1Q3bfpK+9ejXLBLwTGbd/t1ru
 fNw9QxPeBHz4hObRs45jC8AZl1LIrIYcWzBi6RpatJMqWr2Ey9TumdJdURXxCxlKN48H
 TDtw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwiheYLWdjj5aIfVez38wsBdUjkoeaeIXswAnctztdq2uh7J/54HhUgff5Xadp80Rt6pLYJDWEAKj7D@nongnu.org
X-Gm-Message-State: APuU4Z8EHBzhj9epM3JEBHMnrKmWtZKY3gqiLu1cN8Rm4MuDk6KShbTQ
 nLWRyOc5pJGBKA2ImkSVCHPknl6K6GzSseT2I4qx9/B1yEHzaaveo6hNI4bLvzfMaq7PZuB1yoz
 3EI9f
X-Gm-Gg: AYBFou0FgSy6JvAUqUAit2IV4779/NcadSUGlp17nseROMRzVfQX7EzXW54gLayueOn
 BdUD/u3HYhtzhMAXhJU9qTXjvRjTdSW5ooPlIHhwySPYSIWPqucIRze/aBvETSCirnhbb6Iwehd
 Vl/jE6AH4t5CNj4/ZiMGcAY+m4oMJHRhBET+vs+2dxYD8G4oRPPtgiXsYhLHUGxUTndZ0xQ5B/M
 2deusMQThuyhwX5UkPP/8ruWKd7u7RE0vZ9OijES6VEDjDmtOVldupSgooJBYJw/3Eykjq2McW+
 1eSdxJMHuP2dqIQeWCBaCacc/XXDrtPfjmHjG03e9e+7XkoU/d3t4fJlTAsBuXncVRMEpmRwFGP
 iaSa2+3qN/H4Kt6tUVW/IdzP6WcxVpOydNV2Ds2ybI3ZEQT3un5PR95C+6OLD4yxesBW2uE05tK
 GW4ohD3rlH/G0Lizq999GsBiD40t4USowgGeIq6KWC+8cAqdmzNs4nKy22b/v0Yb/C1uAS14u8R
 WXnz2ptydFt/AdSpAih4vXNvzQCCs4P+0DWZhix65w3ufm81w375zo1BA1tpWP/lVaIiYe24IgH
 o77yTRJ9DceVZo7vKvZWA/FrHmUz3Y2K9w9B7Sb1i6DbZ99/0Yr2Jd7uVfXrMiApc4pUQ/UG6Bs
 K5b33T/IRBlNId84=
X-Received: by 2002:a17:90b:448c:b0:3ac:a7ee:6766 with SMTP id
 98e67ed59e1d1-3ae8980ed36mr11053194a91.36.1793719516277; 
 Tue, 03 Nov 2026 07:25:16 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b07c666cdcsm4717075a91.11.2026.11.03.07.25.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 07:25:14 -0800 (PST)
Message-ID: <ac5523d7-253a-479f-885c-f0e7deb01242@linaro.org>
Date: Tue, 3 Nov 2026 07:25:13 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/12] Misc fixes patches
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20261102170658.3649401-1-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261102170658.3649401-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 09:06, Daniel P. Berrangé wrote:
> The following changes since commit 56afd82bd4db9688f1c1c9d0e2ea163b8cde3283:
> 
>    Merge tag 'qemu-sparc-20261101' ofhttps://github.com/mcayland/qemu into staging (2026-11-01 08:37:48 -0800)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/berrange/qemu tags/misc-fixes-pull-request
> 
> for you to fetch changes up to b95f1036d5f8b35d8d5b4c18d33bb6564fcbf2e5:
> 
>    accel/nitro: mark 'nitro' accelerator as secure (2026-11-02 17:05:33 +0000)
> 
> ----------------------------------------------------------------
> * Mark virtualization related machine types as secure
> * Mark KVM, Xen and Nitro accelerators as secure
> * Use getexecpath on OpenBSD

Applied, thanks.

r~

