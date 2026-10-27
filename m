Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E052606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fqYcxc3D
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmlF-0000t4-D8; Tue, 27 Oct 2026 15:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xLmlA-0000sN-Jk
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:23:01 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xLml6-0001kT-L8
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:23:00 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-6767d92cde6so267589d50.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793128974; x=1793733774; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yirEt+hIClpNVBjOeVGQTbEqiF5ykbu11QdgxdKgCYc=;
 b=fqYcxc3D3VF08ioBc8MXgSKlmdMTqbVV8s0GvaqvrSS+4WQivHUKdfJKsc/KsVTrd6
 pXG4gc5Hm+hGr9JVwqVNp+SwjcWOY3KKcmrtrXZhSYFStNSVkHKtkrq/KDrVeKPCMgkf
 jb0Pny0v402VOd51se6lyueM/3/3cOdwUtLyL9SXxWl2ob7xAdiNMMjxALZrtSC2q7+O
 FfI8gFwdrnT2aJ0kzL7LjUAloVDJr6pktKNe+nL++/zrIJCiktLUA8jfUFtvKglx+kMX
 tXwiX7okBmjW/z0+J5YvAXltKsHzpbEv6FX2HKUj1CJ+S7mB7WhzY6RG/KpfK8N08tH1
 1y4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793128974; x=1793733774;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yirEt+hIClpNVBjOeVGQTbEqiF5ykbu11QdgxdKgCYc=;
 b=YfaRfwmxln4qXV9W63PXzHUrcD2a6j+WyAUxE1oDy4hPuxliEeC9gTSDCK6fcrNrBh
 vjewV+ls6lrjy1s2N0/7A7kbvUk8CsNn86Xas/yjibFKLPaHh/ABXoEXk1/nP/ofAB2Y
 LzzmNJDm4tsV7a/qxP/E8qC0aTIfK+aJfs0FbtXjVwXVxFgZp+iUVn0ZNelXXeDiEMoU
 R+rQsSlA46+c7/OfqAa1H82by6a9SqtlphAqN4DxEAPg1zCOGQ2YNtlXujNLoHnyKHQM
 JhjJ8CW+6DiAmzo1Rjic93QsbEvqaOOiw5QZnddJkqn1daWajyUZTNMh0k768MFhWvAH
 6kAQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy8wwmEJijxIwlLZhlyHTRmofUEpumceUVeNLH1ZNWild9w9exYMNNHfSL9ZBt8Lvscsoy8Z9gayE3e@nongnu.org
X-Gm-Message-State: AFq9FYIl66wP37rgBI1LKL42NRnQbHe0BWv+O7Ok4C078w3gWZYJ1ZSs
 IEQQCqKENMfqjSzzb5MoWuLCXGkfwL7WN++p61c0gWq6tzD2A4yMMSCP9F040/Qtc9I=
X-Gm-Gg: AYBFou3j1P2U3mMygYAXdbWBAxNhk8ALv9WI2IYTlT6xSEcWyBRVeH7tAYTAgRm0/Zs
 CK14dFoDPVrlbWVoDrmFcgdHn2i5PViOxiJ8sD1aXbH/5n4FzuW6JLn+Zj5djTRFzgjb0pVqUtg
 U7vRtGG6MqwnlL58l/6ZGuvOC0Z2GN8BYcEsn1BCO6dMOVdAI4YMZF5n6ffE1tDsN8Vbqoe0zlU
 stxMPZiROi0VqvgkJF6KzMI9rL5xFQSQLtfXJUnqTDNTklqmLNHVbHmEBuTQJSW8vpDDLMwzjir
 mZECl6kIIg9PSNsUhYVV0Fnj9MFyAMD1dfp8KJn4hYijud5hA1VTw44QkJY/w4iLTp+/1sUeKCm
 HHfTGbk0biDIBo5As2nEs+i4xun/hJAfxFPPuHYEPt9Ph8I471kl9mW/Pdnjx/MU4ls8BHhbU0+
 11qfNOu/dh3C44WPhU8QASOJ4XNHTRUmgYPbFhqpHsaulbqVXiblXcOrUtw6YRJnMdwt/WnNpKo
 veFxiJ3vpiciiZFxnBpsca0CaNwcf+e0IkYZLGz3C/usbjZIkQWpHeeGTe3jpjspqodvjuAsf0U
 odAnJXpBQJwc1rp+rA3ARDwttNBDz3uYhjvJKb8UW5tq3dVp6Qmdx10PTWxhOg==
X-Received: by 2002:a05:690e:450d:20b0:679:c4a2:8bd3 with SMTP id
 956f58d0204a3-67a7bc9ae86mr315689d50.41.1793128974020; 
 Tue, 27 Oct 2026 12:22:54 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1a92:cc30:c99c:ffaa:d5ed:3274?
 ([2607:fb91:1a92:cc30:c99c:ffaa:d5ed:3274])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67a79f35b0bsm650474d50.2.2026.10.27.12.22.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 12:22:53 -0700 (PDT)
Message-ID: <40a40d98-45f9-4749-9b07-b2fd6542c836@linaro.org>
Date: Tue, 27 Oct 2026 14:22:51 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v4 00/42] hex queue
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
References: <20261027143721.4125584-1-brian.cain@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261027143721.4125584-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=richard.henderson@linaro.org; helo=mail-yx1-xb134.google.com
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

On 10/27/26 09:36, Brian Cain wrote:
> The following changes since commit 2c0584588c9fedc2a8abc087c01a498ce80997d0:
> 
>    Merge tag 'pbouvier/pr/multi_target-20261024' ofhttps://gitlab.com/p-b-o/qemu into staging (2026-10-27 06:08:01 -0500)
> 
> are available in the Git repository at:
> 
>    https://github.com/qualcomm/qemu tags/pull-hex-20261027
> 
> for you to fetch changes up to 16dba888bdeac0430d9dc7ed5dc13d6bbd384820:
> 
>    scripts/clean_functional_cache: tolerate missing .stamp files (2026-10-27 07:23:27 -0700)
> 
> v4:
> - added "tolerate missing .stamp files" to address clean cache issue
> - rebased on pbouvier/pr/multi_target-20261024, fixed helper
> architecture qualification in "implement SSR.SS single-step".

Applied, thanks.

r~

