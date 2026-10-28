Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A1B606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hn1PzVRw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM6Aa-0000eL-JP; Wed, 28 Oct 2026 12:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM6AV-0000e7-Qk
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:06:28 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM6AN-0004tY-R2
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:06:23 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-6768403e9bbso1142673d50.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 09:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793203577; x=1793808377; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eDgPxF2vMsf0ZGmqcmz75ycsEOh/DZQhtVRMh8yAd+s=;
 b=hn1PzVRwwu13noqvkMPcT/GPvVgsHyU1RTDbWMt6gjY0Wdedi5pDv1jAGdiRQzWk0S
 9MrTV0lozZGzXGeb+c6GRklOuudwoD9eZBD8KoEDu0TYEJwQXNG12jbWIMUMZ2x3ClQt
 N335S2ZeX2MiRgmqSlaH20gr7+lwqR33nfEQHfxDjVhrkb+CLF45B60XGNY7amkrZo56
 ufHZcfDl+XkrEAzFGbqSOcNjLOXodr6GGufzRIokEqG1LetGLkplCMeLjHMfzRrIlJmA
 Iti/Sg0kAn0LNvin8K2MK+AnecsdZP8Y2iZ20e5kK1sEVF2B0IbnDn6P2luWxJDN2BJX
 jSgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793203577; x=1793808377;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eDgPxF2vMsf0ZGmqcmz75ycsEOh/DZQhtVRMh8yAd+s=;
 b=BnzXmMtBbAvbM0G8+PHTrglYhHyKlPBdq8iir6ZenXv8V0KgG6oQqjdiQT6QfB0o3o
 hvEtBYZpMA2y253fzP8TUwwrrue/rynt8VhgJP62kiikSvXquYHH8Y3H31y2/CNHnX0F
 3w+OeanLhnxBDdsKiOdQ63vEEOL21CfngQ8pDZPefHtcdlPYaMLWtQcjK1uGa9ajyef8
 KiJ7I8qGbNIQegcNxsDjTu5ALe7Z9sw64fhs7yjZ+dQ5LY+RfgjKFLb441zQteLg/ESk
 iLiJc68Zzi9rlPtZ98xsp2Sl8OpkJ+rpi7+/ilKxDd3fc1DoFLYmUU/U4EmE16kvA2Cw
 cqvQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw/YOFirIwsRY1CruAgrZAUPMhMDhA0ggwY5/KKm8kTUi3gKFHHWTr4lEnPG3VRNmyotcX/z+2VuPCD@nongnu.org
X-Gm-Message-State: AFq9FYJFt71D3UoDJMzCgnjw5oQtlTT8t1Fk536pazCy6+UX/y1XBSXE
 XnE5vJUluwuqkTq6MgpjVW25sLKNhmecRHvfQ0Da+/UqOvExSzKk7h8+yEmyMB4upWM=
X-Gm-Gg: AYBFou3KED9qsH/tVnIyv/LMsNy0rzS6UYFX71T5p6yw6AHFOd4Jo6I47YO1Ef5Gq1+
 0BJmT8iJoA12wMuntzZIw3B55MtsAnU2Kl2z94GZgbJxeR6joNpdG3zUC7UXupo0vDXhzqMuJih
 zYM3GaZC9zeM55O9oXDwmQ+zEeNEFe3Dr9yrmVl1xFoY8tkdGjgtXn4fARShk1iNSrffwGj9FdK
 JZQ+QJJncQSBl/SSbgLZ606xBRR03BgL99aeATZ6V/Ns+AHAAACdwtBBMUSjTvJQS81hs9KixAu
 ZON6rUpe/JUE1Mhw48DVF/S0T/XDFNIq/7a72DmE7LaCGz2xrnCuP52bNXUwglHlUqNIp91xCHA
 sx+Tbr3zRnvhvKzHHNg3f7FJZxr1so6mtnyvI1iGd4EuOe38BKuhzEFaZaJNTl3sAOn3OHFtoV7
 wkIbHlpchHbWTQoMJEArkKUPGhg+WqgaJdn9diotTVpxDZ+DA6gicoUtMPuL88fqvjTuHFWS0X+
 CEGcuhJ5OHcz5LSguVmEp0S+Dkp4QSC65EOeGzlomliOfgE8x+5t2gtkI44gzbLy30jVRK7JESS
 rBCcTF6m807IX9+66v6w5rJJAx6ZHcYjV8msNLF/RWMA0v9ZPYHsI8iTYgxe5kUtApmx5ZPf0aB
 2qU9usPtavFM=
X-Received: by 2002:a05:690e:441a:b0:67a:551f:920b with SMTP id
 956f58d0204a3-67a7bcea72fmr1980907d50.23.1793203576577; 
 Wed, 28 Oct 2026 09:06:16 -0700 (PDT)
Received: from ?IPV6:2607:fb91:2c2e:8a8c:60fa:827:925e:3bb6?
 ([2607:fb91:2c2e:8a8c:60fa:827:925e:3bb6])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67a7a165a95sm1986764d50.19.2026.10.28.09.06.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 09:06:16 -0700 (PDT)
Message-ID: <36de0be2-5bb4-4fc8-b9a3-9eac3a719671@linaro.org>
Date: Wed, 28 Oct 2026 11:06:14 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/14] target/mips: Determine microMIPS insn size
 before delay slot check
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno <aurelien@aurel32.net>
References: <20261026162034.32711-1-philmd@oss.qualcomm.com>
 <20261026162034.32711-5-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261026162034.32711-5-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=richard.henderson@linaro.org; helo=mail-yx1-xb133.google.com
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/26/26 11:20, Philippe Mathieu-Daudé wrote:
> Compute whether the instruction is 16-bit or 32-bit unconditionally,
> then use the result for the delay slot size check. The default case
> is unreachable. No functional change.
> 
> The size will be used to select the 16-bit or 32-bit decodetree
> decoder in the next commit.
> 
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   target/mips/tcg/micromips_translate.c.inc | 59 ++++++++++++-----------
>   1 file changed, 30 insertions(+), 29 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

