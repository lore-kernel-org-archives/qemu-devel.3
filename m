Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC9DC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 13:41:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0LpN-00089P-Dm; Fri, 26 Apr 2024 09:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0LpH-00088X-Ln
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 09:41:19 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0LpF-0008PZ-I5
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 09:41:18 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a58be618a17so216157966b.0
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 06:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714138876; x=1714743676; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l/4AH35C5XtdQ3eRtyDUDGjjFvIonN4wg2bdDSTpV4M=;
 b=UMDZ3J921GvAk+cTuOFn/GJncOp6Q+4eaRuxoEYRpn+ci63Sgl9Fsq0mrW8UU5pwva
 GNYxTQWq5WatXrWU4BwitAeLZz/fuFcWBlsbMNBhylh+/PhnU3ln4wq5dCD6Jj9vVNO2
 dPRQSgm6jZGtOQP7OIqXzW5UWu3MptGzULQm5nVsFMetoO8J6lbGXDV71+vw+7Tf2qlS
 I9wXW3UGUG2XpeZ0NBvHqpgK93wP+HX3ZMlfM6GvW2zQixKuonJ3gyue8gPq+9dpFfwa
 DYIJrb1LQe8dusU7v8wKYZqol+G19LwwcWWPl7UvlD0H3YHybvheEtPWJXjHK8Uxa990
 ZIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714138876; x=1714743676;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l/4AH35C5XtdQ3eRtyDUDGjjFvIonN4wg2bdDSTpV4M=;
 b=MqdMWrR1DrnEB4XAn40MRlAywMo71Ves5HQeyQWZrDn5Px9NfqVZRDUxUGjCjA0nnG
 3X33KsYfVxxyjx2qUzsp3zdx2olvPpvsLYHbze/pvxxS9p9aAJT81REAF7s7YixEVTol
 yCwapVYWsAq3u91pealEcQKMvPoj7Z9dNkqRnCpIic27wDvxlE+sxhZ8kNAA6d8k+7L3
 IMdQSMuPTe4zYDNuwbQNG2eNUgrvasGBMKdFBlac7TxtA+u73qiQrmRFMpMmj7dE6SuG
 T9dEIwIcotrs0j8XolD5V4yGo4kA75Facz2MZcxJXqyFW4Jke5hWW6H0B3JySbhrxWne
 3roA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUipPzn6mWxaRTpP7TEqJDXwuV8NqpkoMOe4AlzFMcXFOb2WzxXbcowhX5e4lPXuEYyq3t6Q/HQ+qAG6S6WUyYc6WmCLHQ=
X-Gm-Message-State: AOJu0YzwbgdYPcS1M+yf7xnCjzoLCCu1gympNkwYvwqEaSOBOX77AgGj
 zwyBfhwDZbD0jiPzgrKFjmogVe0OcsFyB4lEKxs8sWIENt5PquGh3KZqQxGGw+k=
X-Google-Smtp-Source: AGHT+IER2aPna6CkjpqAcgxX1ewLKzzslG6kFiS6RABsG8hj3EhOaGgB7qCFwOwm5c6mOf9L2AzY5A==
X-Received: by 2002:a17:906:3655:b0:a58:be32:b454 with SMTP id
 r21-20020a170906365500b00a58be32b454mr2039327ejb.27.1714138875741; 
 Fri, 26 Apr 2024 06:41:15 -0700 (PDT)
Received: from [192.168.69.100] (aul93-h02-176-184-11-147.dsl.sta.abo.bbox.fr.
 [176.184.11.147]) by smtp.gmail.com with ESMTPSA id
 bk5-20020a170907360500b00a58a67afd2fsm2220272ejc.53.2024.04.26.06.41.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Apr 2024 06:41:15 -0700 (PDT)
Message-ID: <69fb04e9-c4af-4d71-a60c-b21a94896fed@linaro.org>
Date: Fri, 26 Apr 2024 15:41:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] hw/arm/sbsa-ref: Force CPU generic timer to 62.5MHz
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Radoslaw Biernacki <rad@semihalf.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
References: <20240426122913.3427983-1-peter.maydell@linaro.org>
 <20240426122913.3427983-3-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240426122913.3427983-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 26/4/24 14:29, Peter Maydell wrote:
> Currently QEMU CPUs always run with a generic timer counter frequency
> of 62.5MHz, but ARMv8.6 CPUs will run at 1GHz.  For older versions of
> the TF-A firmware that sbsa-ref runs, the frequency of the generic
> timer is hardcoded into the firmware, and so if the CPU actually has
> a different frequency then timers in the guest will be set
> incorrectly.
> 
> The default frequency used by the 'max' CPU is about to change, so
> make the sbsa-ref board force the CPU frequency to the value which
> the firmware expects.
> 
> Newer versions of TF-A will read the frequency from the CPU's
> CNTFRQ_EL0 register:
>   https://github.com/ARM-software/arm-trusted-firmware/commit/4c77fac98dac0bebc63798aae9101ac865b87148
> so in the longer term we could make this board use the 1GHz
> frequency. We will need to make sure we update the binaries used
> by our avocado test
>   Aarch64SbsarefMachine.test_sbsaref_alpine_linux_max_pauth_impdef
> before we can do that.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I leave it up to the sbsa-ref maintainers exactly when they
> want to shift to 1GHz (probably after a TF-A release with the fix?)
> ---
>   hw/arm/sbsa-ref.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


