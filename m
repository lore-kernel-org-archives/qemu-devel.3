Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E049C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 05:57:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpMHW-0007gd-G8; Wed, 27 Mar 2024 01:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rpMHV-0007gH-F8
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 01:57:01 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rpMHT-0003Pn-VZ
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 01:57:01 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6e6afb754fcso5602076b3a.3
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 22:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711519018; x=1712123818; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R5wGegN7MeaGX9yAsuRXFenfU0VMn9PdSRLqJV42RyA=;
 b=HDXJhOHy+4QwjrY7C1zgMGCQiS7cf/0+R9aR7WDcQ03U6+O9nMdAYhKLe2XD/+NI+o
 wBpC8kcOgLtfjF6nnnSPWg4aRKJYtgiJWr/sV74Lu90yNQKvr88700Lu0Kl7Me5RU82h
 arAX9Lps6y2gqUxqKuG6JeqOMaIVEYIbCKLy/bTxvsegEd9hinhbGC3Rd+v8v0UrTxRX
 CaVXFhcvGL2wJq7R/eVVp9Md6Cfj62Tjw8UN4xQNiyFjtn0YNB/vMvYYNJIjtP7Lh6Lk
 25fUCRryZuLJXhrNyR1IRnDSHpTOt9taMSvjah7a7317QwIJZoXlOh2ENCzpDnCPPpbA
 YBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711519018; x=1712123818;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R5wGegN7MeaGX9yAsuRXFenfU0VMn9PdSRLqJV42RyA=;
 b=H+Sd6MnQRFTEt5/gf6/eq2medG2xsYLN20eRzadI3KyVAT1MOAtEpBX8f9r4yIvtAr
 y/9BaAm+onPaFC6fcEYiGc/7aZ1P4wWxFSe1MqHFIiNRNkFmQSMBTZPH2b+2UgWDzaAr
 89wkzBura9/8J4OMSSN1E8N6LiA4jioL36tPEHP9pYcXjG/0Fd4XmJCc0WjVzP94zmBl
 fEE5M33ulrnEYltljgFY0W8DmAgj9CQ3ZkIu0GtTkgGgrlOVK9ciWxIkOfe+Z+2pqkE1
 9njqwJMNHhxWSK434bBt/XyHNHJGrGPMo7VUzyt1CB/RY9q8TaEYTk/iQyRJwrVlv/YG
 htvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJT//PrXil4AWbEMjKeMYWPXyYlvaocVtt1/UJ3e5strrW+gGNiSloQD/8GgdIp5rBZvgL3Sl1jmy2TK9r0THI88Gq7Os=
X-Gm-Message-State: AOJu0Yyk0Igt+Lo8OCXObucJn39XBqVvO/G8RwH8sAIpwcUS72FCa1dm
 Mk0koFmJKl6sEIzPHhcYksXtEAa6rxJLtrCUfq69ixAykQ1cpprJ2wC4bA+xSFs=
X-Google-Smtp-Source: AGHT+IF4/2UvuPhpnuv3glWkpsReYJsRFd0M9kADSOpyw5AJc5PtyTxPaPzbDmoKVlcJ/KHv/k838w==
X-Received: by 2002:a05:6a20:d494:b0:1a3:e298:6756 with SMTP id
 im20-20020a056a20d49400b001a3e2986756mr1480514pzb.28.1711519018165; 
 Tue, 26 Mar 2024 22:56:58 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 pl8-20020a17090b268800b0029c693a1e6dsm702944pjb.17.2024.03.26.22.56.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 22:56:57 -0700 (PDT)
Message-ID: <04278132-3313-412b-9e90-bff9d5f88752@linaro.org>
Date: Tue, 26 Mar 2024 19:56:55 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v2 3/3] exec: Rename NEED_CPU_H ->
 COMPILING_PER_TARGET
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240322161439.6448-1-philmd@linaro.org>
 <20240322161439.6448-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240322161439.6448-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 3/22/24 06:14, Philippe Mathieu-Daudé wrote:
> 'NEED_CPU_H' guard target-specific code; it is defined by meson
> altogether with the 'CONFIG_TARGET' definition. Rename NEED_CPU_H
> as COMPILING_PER_TARGET to clarify its meaning.
> 
> Mechanical change running:
> 
>   $ sed -i s/NEED_CPU_H/COMPILING_PER_TARGET/g $(git grep -l NEED_CPU_H)
> 
> then manually add a /* COMPILING_PER_TARGET */ comment
> after the '#endif' when the block is large.
> 
> Inspired-by: Peter Maydell<peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

