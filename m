Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E4A606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 10:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=TLbxqhYH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMjzw-00079U-GF; Fri, 30 Oct 2026 06:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMjzv-00079L-73
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 06:38:11 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMjzt-0006oP-Gu
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 06:38:10 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7f84a55cc06so346500a34.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 03:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793356688; x=1793961488; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BPcSbjG1Ykp+OFiI/iKJjg/z077DqWi7U5WIV1e2lDo=;
 b=TLbxqhYHDw0uZHiMIPEO4KnCXhuCcvdu1IW1U5OmJhTuag5koxBvheWOEP4E43P/cg
 BqPjDaZuzk59Iig4/Sxxat4o40LNbp3i1QMEVWybGpXzdsKBOu4Tupcd7NeaNp6z7PIt
 6lg4pO5MWK7UwHKSknZcQlhZDxhtCVB1VqYRwTxl4W6YjPA1cIW2/CWP6FZKGMiwqMn+
 SyU6C+l4q97pP6h0ko0w3TJVErf5IA+IPFm5n71aL1Jv/ZmV2MjzAi8yzbr+Rp7RHW6G
 s6XAmrtLu+hJSrKumt0AEB9G6XQclXeXu4yklvjXhUMmJV9hk4bBTpzDoI+Ip/B7z7kC
 AqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793356688; x=1793961488;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BPcSbjG1Ykp+OFiI/iKJjg/z077DqWi7U5WIV1e2lDo=;
 b=mN/LThJQZXddxFMBwjzSPSh2gqLigCi+T3lvl2WPkpIX3rcoJyRipJNlWbm9nBvq50
 JKFI7h5n8xZPABECNV4vXEpJ2nruHeqnApp6maO9uBTBzZCbD9TRoVJGy6yNo2WUkpUr
 NpdLOfJ3rCETqEy+HEuSOFU+R+z2ecVItJGf2xDkDcXpvaKnR2I1S5v6kpEqBPNvo6oS
 Rnu3vneLI8fIdcriBgeGpB699WAoX66OZGmv4L3qe1DGJk3n9nWv/LHr/zZ0ds3hQN1B
 6SMc7XMnEPFMYVCt6kFSX4Rth6DdrgY01uG8cYTjcibGXlsuP7nQ4dUFJItjStsQSCpI
 tE3A==
X-Forwarded-Encrypted: i=1;
 AKwUvBz365LBJadsQjyu/XDgJN1esnGtf0wkj8NkhdEvPL37rOwDmRX+UaeuOkNpWGH7s2DIF7TjcroC+RZ4@nongnu.org
X-Gm-Message-State: AFq9FYKowGuduWtCOolKC6UR34FWtJEe286bcdGQ+YVpiwilaQG755mG
 n3a5ndGR/9clObLNTiceM5F3YpUSZoSbqn8T4prpRLmxNtOPF38uuwgzxYa1Y9AYyGg=
X-Gm-Gg: AYBFou3iGCcDeaMqS3teK4p88QfIfjod9VgU2DVmB7KeZfScYqtVXExLbD2HWA2t1HK
 SICXnVJ9PRvzd854IXq4w+hhdB1C0eCshFrPyMhjQGeigtbOdoIYizHbUMrASHmA2oNLjab4c85
 s9L2mNMkIwfZQxae7rtN4vJoGXvkvcypklbj81M9pKBglfApNoE4ztCxjiTqupUAwbmGalF8J0j
 FT3cjZhnfsbDv/3628uKe7oVzrai88fVn411GiGmRJ9bhimWmfhRD+zukovI8GFmOCCKKL+Wc3x
 cl9YfSh+/HoHtjHsshG3a34AkmN7hT0xxumDkOIRjmIbyKUzTdg/uwaHXW70aBXc5EuAgfswZC1
 F/p/jGzpa4qTPhF1I9NatngnOzWpAnC8MtFFPhrX+cPOf+b+/gvx2Yc7lFc03q/zorSIZcMFfR6
 enBjNWtuukHNOseJ0yubBlpXt9IPVxEWgLMDbF+lEzQBNsq/2bvHS7CJTQBkphTSvVHRrRMCBNJ
 eqO8Ien+MbYC1Sg6mN9KtBcBfH71sEelU3T83fBXxzQoshPxmoa9ASDgvEMrRmmIEcwIyW+4VUI
 bLUHjm0tkGqR9n9Gu+Tsk8HyBcJdYT/IUVFoljRZ9GguR1LjhDliZxPhfd59lMvKow==
X-Received: by 2002:a05:6830:264c:b0:845:156f:5899 with SMTP id
 46e09a7af769-85d3661f4b2mr1533812a34.29.1793356688050; 
 Fri, 30 Oct 2026 03:38:08 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d3545bfebsm1678044a34.4.2026.10.30.03.38.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 03:38:07 -0700 (PDT)
Message-ID: <47cebe93-116e-4646-84bf-b74586735f1e@linaro.org>
Date: Fri, 30 Oct 2026 05:38:04 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/8] Migration patches for 2026-10-29
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
References: <20261029184641.1973813-1-farosas@suse.de>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261029184641.1973813-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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

On 10/29/26 13:46, Fabiano Rosas wrote:
> The following changes since commit 5624b266cdd513506fb333e9041778407b6d1ac4:
> 
>    Merge tag 'qga-pull-2026-10-28-2' ofhttps://github.com/kostyanf14/qemu into staging (2026-10-28 14:53:37 -0500)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/farosas/qemu.git tags/migration-20261029-pull-request
> 
> for you to fetch changes up to 232489829c3bf5b5c13d5e1f6d8d1e63244637b4:
> 
>    migration: Postpone the outgoing preempt channel for preempt_pre_7_2 (2026-10-29 13:13:13 -0300)
> 
> ----------------------------------------------------------------
> Migration pull-request
> 
> - Compatibility fix for multifd+postcopy migration against older versions
> - Rework of early connection code
> - Adjustment to snapshot thread name

Applied, thanks.

r~

