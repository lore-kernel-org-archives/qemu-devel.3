Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811D960A2606
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 19:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=LLpfGDrY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQUup-0000TB-Ha; Mon, 09 Nov 2026 14:20:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xQUuH-0000FI-K4
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 14:19:58 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xQUuE-0008VC-QR
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 14:19:52 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-8b58d6f67a5so734134b3a.2
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 11:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794251987; x=1794856787; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=56for/20TF6QZet2WkXyOgbnBmklobWA7PQmqpyyNjU=;
 b=LLpfGDrYzI1vcetBZA2Ku+f0emBBW7HwSPjIMQZuANEpRLYJqK3S9Lf4t0dYRIGCEX
 RzXi1aGb4s7kAbVIWa/2yZV3wZFW4rGqlTn8ag0c7QrfAcOEAwd1Asb4VBjhdrFzXvPF
 73pmELqXMt4btQfntEczgktBfNHBFl+iT52iFaaDbeX/qt7EmIbVBvha+rKq26J3AsM0
 NhUpz8KSJaucd4EcYY6VsC+5izyPomlHw4V2zBTsSELX907exWtFBJfsF6Z3KlSYGFzd
 /CUzBL316VA+vjMX2zeR6CiIEwquaVVegR1CBqpqHwAr51NRScyatCFgUyq9lyXKgf5r
 lKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794251987; x=1794856787;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=56for/20TF6QZet2WkXyOgbnBmklobWA7PQmqpyyNjU=;
 b=GKeH+yl8m9GeTy0NxfM0WnaBr4hWl4+pKuBZABZMUx3aSh56qKZCAlUg6vOAFCdGZZ
 OFxR+1oErYGortAbVr7p7mZEZzk3xfgarMyJlEOIFmlfzrCA194M3OX9X22DMOImWnZY
 IKVaMfmUSEB8cCuuPM+esuqN3jNk7YacT7Cogdaduwg6kMusJm7A78Y52JA8JQkRbWWk
 2Cd8BvkAAMFkofqLUax7yqe5TnWwTAVlnSb4n7Zzepq6AoqQr5OHzcPd6sy9EDSZVP8G
 +5Sluhg6UtRzttrvU/zPSjub0zZILoC03eVj+5fjD9lnE7bW8igcFlnR40NXxCgsI61D
 xYBA==
X-Forwarded-Encrypted: i=1;
 AL+hErHVScu6iMUzVwDWExUV41ZSQ0fulLbJ3Zeyjv7fMrXxopOIxfqMbHTZ0FHpJOO28oFBpK0XC7s7EYTO@nongnu.org
X-Gm-Message-State: APuU4Z8Lv4F+9+6yHVra7t3pa7RCUq8no/INtOZl0IiEy8cxlzMs/tVg
 rKfTL0XJh7J6T85iHBJKvQCQ2xj4qXh317qieV0qnY87FrZp/LQPTBxQ8h/y6Qn28xU=
X-Gm-Gg: AYBFou3eX26oNiHk+mLfTI0U0OcWDVBFIrecI/dmVcFtA/nkRHPXuFDn9BfFLXvx24R
 R9i5rK4Bcpdxz3kTOMGwmVoxoIDaU2mhXCJdawxvaC61mmCaSyWQZQYicwdoi3oXH7cin4Y90sf
 0Y6zv1uU8uzHRXO4+lm88P4K3thTdE7ZN33aIZOIi5T4RxnkNKuAglWRlQ3h/p4s4m6WPKg27Nt
 L5GdlJQWdJLZnOIJ7hCrpgJeakVEyL+db8awoHLA3Z57qbouaOF1cldXodQTwpxbVIIkV+lx+vw
 sLAB85LsQQDNoYh37ymQ6kvK0tVrPZfgJtcX3QNUWbL5YLhVYQg5ojttJUlIinmftkMKCMYwyCE
 Kdxvm/LnqvUTUOMqoLPm3+15zAOvEFYjyzb2ETYnFqLP9ooQW259Q9UqdnDiiKospKaFMZ7L/gT
 TyG2p/H81hE2bKPzeWuwN4VjhFY+vKHeaoZArAJ/E3LNU+LURiuCGPMBTXHG9AEvxney9lN6L6S
 1ByRcyho3Bh9AXsAq9xAr2qGo+agFp0rQMDKScVOcdVXk0hXDsJ+Xgq1HNGSyf6JKW1ToX4SbI9
 j5TL22dYHlz1ODdQm0otJNM71ywWbON5rl2aPyNvPZKicXBbBFySdYvO7ceTOv80/YMjpPnDAwk
 iQdwtnja+RsVijic=
X-Received: by 2002:a05:6a00:9a7:b0:8b6:12fd:7286 with SMTP id
 d2e1a72fcca58-8ba886bf28cmr553977b3a.58.1794251983978; 
 Mon, 09 Nov 2026 11:19:43 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baaa96367dsm38612b3a.25.2026.11.09.11.19.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 11:19:42 -0800 (PST)
Message-ID: <2dcc70d2-1e06-43fa-9200-24f8e4cf5df6@linaro.org>
Date: Mon, 9 Nov 2026 11:19:41 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/9] target-arm queue
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20261109140523.240161-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261109140523.240161-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 11/9/26 06:05, Peter Maydell wrote:
> Hi; here's an arm pullreq; these are all bug fixes.
> 
> thanks
> -- PMM
> 
> The following changes since commit 71f25c75417d31c214ba2cd26b273c114fc99987:
> 
>    Merge tag 'pbouvier/pr/multi_target-20261106' ofhttps://gitlab.com/p-b-o/qemu into staging (2026-11-06 12:28:21 -0800)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20261109
> 
> for you to fetch changes up to e927ac974c94ce98c36ba3e84563a94ca8237358:
> 
>    hw/intc/hex-l2vic: avoid shift into sign bit (2026-11-09 13:52:08 +0000)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * target/arm/ptw: check XN for ARMv6 in get_S1prot()
>   * hw/net/bcm2838_genet: various bugfixes
>   * arm/cpu: fix GIC v3 flag for a64fx
>   * hw/intc/arm_gic: do not hardcode GICv2 minimum binary point
>   * target/arm: Clear the local monitor on AArch32 (v8) exception returns
>   * hw/intc/hex-l2vic: avoid shift into sign bit

Applied, thanks.

r~

