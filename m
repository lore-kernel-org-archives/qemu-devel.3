Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB9CC54E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 20:48:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riKee-0005WZ-Mu; Thu, 07 Mar 2024 15:47:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1riKeM-0005WC-LL
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 15:47:35 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1riKeH-0003Pc-UN
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 15:47:34 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6e5c0be115aso1163008b3a.3
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 12:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709844447; x=1710449247; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dFRU3SPnto+fhcNYTLJc3KMMkKnvJZHqpUU+08/X1rU=;
 b=c2pD1bg7877fBo5SZQrNtK0Hli5aOkJVUZCRwfC5z9P/dfIilhnxeFG9goXKYusskw
 H4JHsGBrACRG/DVofDtt66xr92Av72oBB9ctR8z9yfo2UBmjc2/RolN0fAUMUyhk+Ec+
 y2q6BymX/EjpAAaWie41kYyOx1RPYqbyEXR00VfM0ZDSTBDJpwwfGm4kk3i8yzIXGi0G
 ceGPTh8oo9YvnrJFbOPElIh5b659YpfFJT6OqXMUPEWIYwxwBOnNAAITM5i/qP8Xa7JW
 riPLrWpqRaChn3DG7PYZVqx6nqcYnuInf2sLbiknU0i/a8aJc6SJY1JHq04pNn9PTajx
 RT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709844447; x=1710449247;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dFRU3SPnto+fhcNYTLJc3KMMkKnvJZHqpUU+08/X1rU=;
 b=Ipb9WzX7ULdx1kgmjl0rZUI3xLxG4Z6pOlPZWi8DQLXmDv9Ctx8bRpT+iTKdxOJ8sm
 v1FNbKMZCQW+qDmgaUWXu6ZFlGuQaP7+nmppheBKA3bNh2V8YKNklwcPNleEwmx4bY/y
 syVTimbp5lmcoKldl2X4Ieh5TDYj2DMBU3XPMQvVOSEYcYXPUXNO+YrhJHPfUhhzREo/
 CFAsOB23658XC3SbF65ocjxRiyKPNP5C5525Or0gMuMHeEjhLHYdgz0EnJNS+zFNEmze
 iN346dk3SzulJSDy2EVsQ9yFowqB3q9AA+xPDkNeGmGYHFbFR3PIM7lKG3Pzfs/koSNS
 yGOA==
X-Gm-Message-State: AOJu0YzA25TBqXCRZMTyCJLPptotqpB8QV6z/blUKB/pbRW5shQVolai
 P5Pxjro78hCIGfi3ORm+YRAElDQIUmtPbR6FPFRVmLAy+8idpZoNA+r5jm29RRM=
X-Google-Smtp-Source: AGHT+IFsqt0k55mbmSdxz/DPMvbdCmJt0nzFPxvPnO+Ver94uFY9AiRvoI5Bzg3SvtdA5deA1G3KlQ==
X-Received: by 2002:a05:6a00:310f:b0:6e5:bdfb:bcd2 with SMTP id
 bi15-20020a056a00310f00b006e5bdfbbcd2mr15025577pfb.9.1709844447651; 
 Thu, 07 Mar 2024 12:47:27 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 d19-20020a630e13000000b005dcc8a3b26esm12801490pgl.16.2024.03.07.12.47.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 12:47:27 -0800 (PST)
Message-ID: <6c75b77c-b13a-428b-85c6-eccdf2036522@linaro.org>
Date: Thu, 7 Mar 2024 10:47:23 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] linux-user: Move tswap_siginfo out of target code
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, laurent@vivier.eu,
 philmd@linaro.org
References: <20240307182623.1450717-1-gustavo.romero@linaro.org>
 <20240307182623.1450717-2-gustavo.romero@linaro.org>
 <874jdhvof0.fsf@draig.linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <874jdhvof0.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 3/7/24 09:21, Alex Bennée wrote:
>> +    /*
>> +     * Writes out siginfo values byteswapped, accordingly to the target. It also
>> +     * cleans the si_type from si_code making it correct for the target.
>> +     */
>> +    tswap_siginfo(&k->info, &k->info);
>> +
> 
> I'm not sure I like this, you have the same pointer to both a const and
> non-const arg. Do we assert we come through this once per signal and
> don't risk double swapping the contents?
> 

I suggested this as an intermediate step -- the function will work perfectly fine with 
dest == source.  Follow-up patches should clean this up further, but I told Gustavo to not 
get distracted from his goal with *too* much cleanup.


r~

