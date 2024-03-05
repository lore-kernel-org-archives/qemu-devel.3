Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A8D4C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 20:47:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhbgd-0007gp-D4; Tue, 05 Mar 2024 15:46:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhbga-0007eE-Ml
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 15:46:52 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhbgZ-00025C-BL
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 15:46:52 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e56787e691so137889b3a.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 12:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709671609; x=1710276409; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uAxI2BjsGU0eD+OlV5CSjt6wFJwiXSfAof/OQXK+c4g=;
 b=kCONZay6Ed3Dr8pQpWgp3/ckeIrTIvmLq+eA8c+emSJXHgnB0W0jBgnd9dOr3wFj9t
 3MdGn8gaMOtUYa1Z+8lZDLy53SvN+ccHyGNfSjqeR8lvMn2QfRb7+MpekyLc96omM+Y4
 0ipyACreYfsubckAcVCmFOuVmppPIMhvoB+vHPDfSA1I4rCPg29QQcmobgi874VKC1va
 MCBq8cIs4oVbo6Gp6MVajqQhPJdGavcipujJAnyFCQVIzbZqkZW9Hl0ELRTvsmwezE1l
 NuNSrMM1Sdh9DxCpJjIAx8jtAWFw4omlwRvWO9uRmsQskoaqr+dcDjgk+cVDyFMY3fa/
 W8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709671609; x=1710276409;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uAxI2BjsGU0eD+OlV5CSjt6wFJwiXSfAof/OQXK+c4g=;
 b=u4lWkAafxhkoPFHtQLXKhi8zIH5/+TvK2qv8PEtz4eSisO2RTzdnSxdEslXZ5mo1Ys
 3pwRNBuci01CsQVYF1g09tzpz1+2Erxeq+F91uwrCdFjI5MJS6G6VTyH958U0kN4fG+G
 YZtsJP6u3P9PnPEe9z5HjS1QTjUjGA1MVxCc60VbvAPMjrukhQdoGaCOhq5BPdRZ8Wg6
 ND5VeGjuLUuw2brq1PFk0C2fTIMszibDTPZXPmQ7IZF6mQ0o9cBl7RAffvH31TBW8LNx
 57knj0de0VYXGyyDCSm3SIuZ8LOzcs6GbJe+/hqwxcqwWX0g/ka8RW0/QOYBKpVbZXUK
 d4Uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlFxuoHl2A/SmsX1vR6v7+NnEn9qVANMvQHtfdkRzCvxGWXdUmB+Bg1imgI/sQVLLwWOn3GmdEB/Y64McnXFGII3xHihc=
X-Gm-Message-State: AOJu0YyrPk/ER0hZLFHwLZvDRtBSnKnD3974gsthEXsSKDSnMrBpsYEK
 SnXx5xrkuVV8YjkkOIjGIfZx1YAbd3dJkqeJA0hNEjACC71M7gKEDCotQ1LJEopWHmjeRODhH/h
 E
X-Google-Smtp-Source: AGHT+IFEEeQsvcb4Tjb1nqyPGjwHefnSOaFH4pV+tS+CrwxzSYQ4jLUDTMF8nGd8r3lNkLYeXGB2CQ==
X-Received: by 2002:a05:6a20:9e4a:b0:1a1:420e:f26f with SMTP id
 mt10-20020a056a209e4a00b001a1420ef26fmr4282000pzb.22.1709671609462; 
 Tue, 05 Mar 2024 12:46:49 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 q67-20020a634346000000b005dc49afed53sm9621106pga.55.2024.03.05.12.46.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 12:46:49 -0800 (PST)
Message-ID: <17681f16-5fe0-4191-814c-0c261ba82b86@linaro.org>
Date: Tue, 5 Mar 2024 10:46:47 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/29] disas/hppa: honour show_opcodes
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20240305121005.3528075-1-alex.bennee@linaro.org>
 <20240305121005.3528075-28-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240305121005.3528075-28-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 3/5/24 02:10, Alex Bennée wrote:
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   disas/hppa.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

