Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49249606A6CA
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FqIo04Lk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUUWk-0003Ee-3j; Fri, 20 Nov 2026 14:44:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xUUWh-0003EF-0V
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 14:44:03 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xUUWf-00059E-Dd
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 14:44:02 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-8b271e573adso637992b3a.2
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 11:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795203839; x=1795808639; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cHfpN5umEE+vuB+XeslktVacwlkPQ6rgxMeWggcMjgE=;
 b=FqIo04LkFf+DeJwZtqhqotTXqVYes8nSF6MaF7dsp/7ddf+3wy263sGdC8D8AgAO81
 T67zd4Gw5FfgFqgDLrUXKNUUdF1feZTI2jEWswaUbF2K3/w+Sc/naCOhQGURWsymBvuP
 ExfBdjYxAgbrbDLgNTj6wKLojYHhj6SE3kCEm/sUx2plQwFhjOYCmGhPKS80+DYPyrQZ
 TpFfWEg4DWEerxQ5xX/SFiopV+z0wEjF/DomGxQX4TDfDd7aL9PsL/jYPZMpfsxsXOX6
 Mhy98BC+Kf0+JqdyUkn+47mJFs0PC/yNOa2R3GUQ3FjIQrHvw4D666O2+BIQCz9PdWp4
 +nEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795203839; x=1795808639;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cHfpN5umEE+vuB+XeslktVacwlkPQ6rgxMeWggcMjgE=;
 b=HSkjBDzci2ErWk+S/MzSiV9oayYnzX432M2xRd5nPVf1aW6ebBY+A8DGhhuxFcBpkj
 PqW5AYuAenMAxTtUuOo7Swp9psCfIcPlrzlAYIXr4o4rBIY6+HKd/0Fd9//EzxtHzh6z
 0raFLrIV8Y9FnNzCEeuTBE14mJUPcFO3T/L1tJx+oIY7kGTTrT5ju7CUidErGdoAwfVl
 kB/fWH7QOJIrRgBodht72QvsnBwMxs3uGfci+wWaj3S0dLAqwxuMnIM3k4qoNBrAQFR5
 g3uXWXGKs5UpjnUYvchUuANfyJogPFbckW12lYIt/gVQdzrBAn96TZpbVcM7v+G2fAaJ
 hk7g==
X-Forwarded-Encrypted: i=1;
 AL+hErFG01sGGVdql4r3smot/eqVM972IljX5KB/JPsVr/0NA6QZRSJzOg+q+pZAUD1+DJ+DYqwhRd8dcQ6e@nongnu.org
X-Gm-Message-State: APuU4Z+Lul8fw5OS6zhI/BgyMEn4zezDdQkKBsPrplhBSw70xuRHSKDl
 4pddb9eu2ndaa+b38+W+HieFMeMdmTLyFbwyBn9TcPKnmPKm20yCiaPiiaBFXurqrys=
X-Gm-Gg: AZFdTZfGx45yE5Ghozw1WbSBlTyhEYcZ7z/OFahH4CZxjhnpjlP9jlQT+iA2JcBG5XM
 2zl6GKK+4ELnNRq0kPB5yGRQnbkZjWbqt67m2nakxyQKY4+WymVsdFrxOMZR/UIHV/dlR029Ejo
 5qmqgVRQCMdMX+ZeyvvQHRNZyAt9t6TSnxgPH7wXPe6ICZCGJWazcftkHxTOtJwy4TLSixa8bSg
 V03XcV7ye+/nl2YAnNpin+MrTNO3qvFvO+TLax7PqRdFiQkoP7sb4jfzTYvGdaT1t2oJ3vwRYn9
 nM+SAIaw+nED33jTxt5+6mVJAmy18hmaODvACvR7uMQSR+t8iPfp8XNJ6gvy+UmdbEufEmlMrpS
 divgn3uKi3tZ8UuDWjdbnkBIXPdxmROJF6Q4opcxkgfHOrAijrhyCV4KvgnE3rfpWig2Vf0BKtf
 UQpqyObVcP0sLfnxeU8syRWVgnqPkVdLEGaCNrwBym2PuAdVDgN/3PyaracYFJWWJvyomwqfkA1
 O+y2RBhm0XbVg+GXtZvcQqx2EAJwOfR8MnT2n0p6JHbopDKfdHOmnn8pbWdIlyIInSugPDjHN5H
 X1juJhrlIScWblSjiL/uUOPcvXl4xzgrApoc9FOUQeNIGhLyHIETBP6iXhqh4XrgIIiUOGX8bSc
 ZSMrKJf3Dsz3I+gCs
X-Received: by 2002:a05:6a00:368e:b0:89f:db69:1adc with SMTP id
 d2e1a72fcca58-8c87b8da5b2mr4049321b3a.11.1795203839453; 
 Fri, 20 Nov 2026 11:43:59 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c873c1cfa0sm1902763b3a.48.2026.11.20.11.43.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Nov 2026 11:43:59 -0800 (PST)
Message-ID: <e744fb55-5161-4168-9a0f-f49df2c177a7@linaro.org>
Date: Fri, 20 Nov 2026 11:43:57 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/4] Hp715 fixes patches
To: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
Cc: Keith Monahan <keith@techtravels.org>, Helge Deller <deller@gmx.de>
References: <20261119224744.31309-1-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261119224744.31309-1-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 11/19/26 14:47, Helge Deller wrote:
> From: Helge Deller<deller@gmx.de>
> 
> The following changes since commit 45b7c3e45e2b778e560a0734daa6aa0059bc0edc:
> 
>    Merge tag 'pull-ppc-for-11.2-rc2-20261119' ofhttps://gitlab.com/harshpb/qemu into staging (2026-11-19 09:17:10 -0800)
> 
> are available in the Git repository at:
> 
>    https://github.com/hdeller/qemu-hppa.git tags/hp715-fixes-pull-request
> 
> for you to fetch changes up to 42497091287f8ddbcb7537a8d1f28073430062d0:
> 
>    hw/hppa: preload a BTLB entry for the soft power button page (2026-11-19 22:58:20 +0100)
> 
> ----------------------------------------------------------------
> HPPA 715 core fixes for v11.2
> 
> Four patches from Keith for the 715 machine which fix interrupt issues, and
> netbsd boot issues due to a badly mapped power button. For the latter a
> previous commit from me needs to be reverted.

Applied, thanks.

r~

