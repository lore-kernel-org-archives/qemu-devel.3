Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2742DC54E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 21:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riLIL-0005w7-A1; Thu, 07 Mar 2024 16:28:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1riLIJ-0005vu-Sq
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 16:28:51 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1riLII-0006RZ-8C
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 16:28:51 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1dd3bdb6e9eso10120105ad.3
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 13:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709846928; x=1710451728; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Zjmr0WVGj8oiIKzLEgtKZgPDzr7+fpHn7kLRhayF8oc=;
 b=FuoZZ1b7ojg1KdpSrThPi7YUkPI+TdyRBN49E8bchI0xHvB37nwf/0DpF/8t7oINp2
 p4ECY9cx9NJDtcF++hrLNm/RdTQoDdmRKbwoOGOd3MMxOqnY3sz1o/nWjh5UuOf0fcPy
 7bog974EXPb4R5YFqOFR4GUSPJ7jiz7KCWQ7R/85jndTqIVYfSGJMjNhU8xbMWXYdXQU
 +kiR2nUCicDuRfp3G0tYdH1XRx5ab40UgwSZwcE2sj1AQQWwFFWUMqYNMhWuXvpp6YU7
 hLE9aVvGHBhW/WawJRctYFNGOFA/AfN452EG1+ba/ocr9S5gFfjpEpfsbgiD9aoOJCEg
 J8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709846928; x=1710451728;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zjmr0WVGj8oiIKzLEgtKZgPDzr7+fpHn7kLRhayF8oc=;
 b=KxNjswy1KbNYDuJJs/Z2IDseAhq+7fTiGMreOOhR33/jWA91JS/rQjnmKNSCEH2zpv
 4MUuEC0mov2dE1ZTsk2PGm4ulq38z2sU1DgOzpxwzxLXg0rY4y2Sht/zcyp3gIqGbSAy
 +AZy1i3naXF+0Kb5+wjn25dfGGvZOLjlVH9T4EAk6nlZQ9S+uQNHPnsHv8bPXWNyZI9H
 kmP49/7cXdcAhD3z6TbaWFeoQlleqBmtFkMZtyMTfo9p48iU9XAcf4oq1ml8Usz6jzle
 338wV/b6DeyAP16ehP8ikQ5WGf7Yyis86kDh8qdyY/sCKDIfqE1/IV/JEu7tsjC/oMeC
 pTGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+u+EeV2x6W5oCEt4IqWPIA4Vy4BYvFpBEdF2di7PNDF9DXfOtXf3ZSYaokQivo/esXx2q+9XrZYliyw2W4yEFrHxzU1U=
X-Gm-Message-State: AOJu0YyTrj7kbvF8npO9yY+w5oM9uwHFBnVKQ9uG4Aod3IlbNSka4Qhj
 1/uKv9kI+vrgADUcX4ohf57Hj/J5AHhg6tnYx37WCaHvKtl/32BiGApn9icw5PU=
X-Google-Smtp-Source: AGHT+IEJazwISUNEB3oo3SwZE0vn6WjKubW1Znvb5/2LVxdmG2meWC/NQ/BErxHcxNPN+6duGOOM4Q==
X-Received: by 2002:a17:902:e9cc:b0:1dc:30d7:ff41 with SMTP id
 12-20020a170902e9cc00b001dc30d7ff41mr8770253plk.58.1709846928464; 
 Thu, 07 Mar 2024 13:28:48 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 v10-20020a170902f0ca00b001dd635551f1sm518770pla.255.2024.03.07.13.28.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 13:28:47 -0800 (PST)
Message-ID: <daae9318-8e51-40ee-8f23-e1d4b589c123@linaro.org>
Date: Thu, 7 Mar 2024 11:28:44 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] target/sparc/cpu: Avoid spaces by default in the CPU
 names
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240307174334.130407-1-thuth@redhat.com>
 <20240307174334.130407-3-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240307174334.130407-3-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/7/24 07:43, Thomas Huth wrote:
> The output of "-cpu help" is currently rather confusing to the users:
> It is not clear which part of the output defines the CPU names since
> the CPU names contain white spaces (which we later have to convert
> into dashes internally) For example:
> 
> Sparc TI UltraSparc II IU 0017001120000000 FPU 00000000 MMU 00000000 NWINS 8
> 
> At a first glance, should the name for -cpu be "Sparc TI Ultrasparc II"
> or "TI UltraSparc II IU" here? Both would be wrong, the right guess is
> "TI UltraSparc II" only. Let's start cleaning up this mess by using
> dashes instead of white spaces for the CPU names, like we're doing it
> internally later (and like we're doing it in most other targets of QEMU).
> Note that it is still possible to pass the CPU names with spaces to the
> "-cpu" option, since sparc_cpu_type_name() still translates those to "-".
> 
> Buglink:https://gitlab.com/qemu-project/qemu/-/issues/2141
> Signed-off-by: Thomas Huth<thuth@redhat.com>
> ---
>   target/sparc/cpu.c | 56 +++++++++++++++++++++++-----------------------
>   1 file changed, 28 insertions(+), 28 deletions(-)

I think the names are still a bit too long, and the case sensitivity is a titch annoying. 
But it's still an improvement, and I don't want to bike-shed this too much.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

