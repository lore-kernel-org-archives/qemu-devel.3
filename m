Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2765E60A2626
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 21:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tJU424mk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQtZF-0003Ca-Jq; Tue, 10 Nov 2026 16:39:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xQtZ4-000392-Ma
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 16:39:40 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xQtZ2-00035f-VX
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 16:39:38 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-3b0a519049aso1696618a91.1
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 13:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794346775; x=1794951575; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jojP+pOZwI96Xj4Nx/lkjBkOzLCVCkd6TL8DCixUr/g=;
 b=tJU424mkU8CnK3eJXa1QLaTFPzGWHrhLYyW6cztE+K7FFbgNMl+M3Za58kFyd7IYVn
 H2UO81gKYjf0dnaUpKqgBumflWI7g4gjIGxkdos3oI9LeUifKg2rKeAwzeXeTvfV+SRG
 c7xtSrKvvuIk7IQcrkXWQevvJNR+a6PzpkF/t2DPfaSCbhXawn9T6DKnWCe9PuAp7nVL
 ulZQ7KSHepK1RRXzYb5JKNHXMvUkCFO7ayyX7XzoLsIOWHL+pm/a15u8wJQlGeRehdfq
 J5l1py5lQcMHKoDetkz324Z7mwVx9ltDiRIT5/Z67KnYoVS3xqQ2v6w58FfMLTVfR2DS
 Nddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794346775; x=1794951575;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jojP+pOZwI96Xj4Nx/lkjBkOzLCVCkd6TL8DCixUr/g=;
 b=znSvRr5JjvpMFHp5HXvmiy41tATa/CZGqKf+xoZo1tPedmgrxJUaCjn9503wSKD0dP
 cL5VqGBXb9ZskzcJC4C+GOHJqHjOBh5pM1MQQ9Z7T8G5/sZOVVT/Oyb16cMcZEWKZh0y
 cM3mwFd1Bl1zZiQkmSMytu+u47rsWbw2sL4LSlYP+MS6D6A7igOEeZLp9N4F5R+Uxc4o
 gKqlvtbDOsq094JjxAzEifvIa2IRBDg6DTJ0kee1ciyGf7nRv9EvUJ+GJAjAk2lVI/Y2
 hpN7HpKAF0P7cGnRHItpWqbz4Dbm48/khFpjkcAUW2uN2+fVbu398r6mqfbuTWC6Odl7
 9rLA==
X-Forwarded-Encrypted: i=1;
 AL+hErFJDefYCHSB2Ke77VCPiROPlaHCV2wlG26/fBM8DgBHBiKxZrafnFORYRv+mxUhVCFVWE2sD4pEPU4g@nongnu.org
X-Gm-Message-State: APuU4Z/ua2T09wVofN83fb3qfO/B82ktd9QLpR1b1xr3ZEqInyNgbJs0
 bzKo6mhzHqZ8zJ+C/sVh/p59DzHWg875gMoxoTps+G5DP1rGDfX2G/3NVc1qKK+5238=
X-Gm-Gg: AYBFou0VPfNkewDKvLSvE6O8IS+84BWkNUQDBaiPCxHoGUf2vb7dMdcQtMwEoLKFwOH
 NmdK7o8ubnIRI1KlJg5J3t7kwBWjjqeYOE09Ej5T2Zby4+182BtxoEPyF+ef7ibUH0In0bMCmwn
 PezoFbMV3tbW6eDSBeXeQlWlZCXswAnQ75BIwVKUR12jlSUH/5hA9IgAT68fryH60MHiR9XzU4/
 TXxO1e455eRb0VgRZjTH3APkDNlVn+zdMNzeVWfBwhNcrOdPVPyWspx/gqf3DZlxQSZp4gmlWUA
 EnsARFWlPcZ4iWqYb55x8w2SGOwvGOHV/Dif1wVA0q5Cu0xuAHWS/E5OpbtVhWXiwOcTUKa9xdI
 MYXw2rId5RjgNUdmr+V53OMh7mS6TJsSH04p90c1R/Tt7LXMslWq72zbSl+kY5N62cNNblQ3u5p
 DKhsSnOsESbgBC51XEAxXfPCmi0eTTU/5aPKxTb9IZ2r/jex1x0ykH+GCRlHqSt51Xz+96s02Gs
 2Lle9baU7+o125NLgShXtKfRXWpuNk4o/YNkUhWzjlBDQC4ZnKR8PRvYF0RZuqOVjucW5MiPz7+
 o7gEBRUNN+NMZkjeS4mTdygRt80W7532J4Wk8FIfvNmtpI1cZVfpTKzBlRZy/qmxKPt6TUrL
X-Received: by 2002:a17:90b:51c8:b0:3a0:ca1d:b40d with SMTP id
 98e67ed59e1d1-3b182f595d9mr275739a91.55.1794346775047; 
 Tue, 10 Nov 2026 13:39:35 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b17db56c7esm1280672a91.8.2026.11.10.13.39.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2026 13:39:34 -0800 (PST)
Message-ID: <c6f33d14-941e-4753-9f78-eefed7b56230@linaro.org>
Date: Tue, 10 Nov 2026 13:39:32 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] meson: Revert recent changes to qemu version header
 handling
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 John Snow <jsnow@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Philippe Mathieu-Daude <philmd@mailo.com>
References: <20261106155858.3779237-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261106155858.3779237-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/6/26 07:58, Peter Maydell wrote:
> This patchset is two git reverts, to revert ab78ac76f44a124 and
> fc35f24387703da. Those commits try to move the handling of version.h
> to entirely within the meson file with no external script, but
> unfortunately if you do that then there is no dependency information
> about it passed to ninja, so the file isn't recreated if it's
> missing. In particular this breaks incremental builds from a build
> tree that pre-dates those two commits.
> 
> There's been some on-list discussion:
> https://lore.kernel.org/qemu-devel/20261105181449.1691-1-luoyonggang@gmail.com/
> Since it's not clear how we want to proceed, I'm posting this as
> the "revert to the situation we had before", so we can discuss
> what we want to do with a bit more leisure.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~



