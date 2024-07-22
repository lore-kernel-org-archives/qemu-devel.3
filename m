Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81799C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 21:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW0G4-0008G2-O3; Mon, 22 Jul 2024 17:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sW0Fs-0007Nr-Fp
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:07:38 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sW0Fq-0005Ec-BQ
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:07:35 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3684407b2deso2498605f8f.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 14:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721682453; x=1722287253; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Rvh+JUJrHgdNlDLuqtrHf3EboGJloUe6tLNecgIJseg=;
 b=lPOqkpZFM8u8X9dmi8Cs4qjItHV/admhk38WN8oIOAGOZ48U+NAOhkp0OONfSpLnDb
 xzirXBoBb1/nWXj4+FmXyk2pr1+iG9OFKU8CVFQ4vyIOtomDGnX/AsTH0z/e75qDecDl
 v+754GBWLxlIie9RS4gVEVAaP/JAAlOdqeDcYqPZVuX+6/X/hj7+Rvk4eO7tfkAeRJ+6
 YREJHYzhl1kSiBHppZwx8HOHy8UQB/mxAVP0/il9PtoSL0TV4CwVR88ZMlP/du2grtyX
 Nj3kOsxLQ8p0yiK14zve0DKmJ6V9s8rWJAOkHbaWFYGLS400T5LLB+pXt2zvPd1qg8dG
 I++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721682453; x=1722287253;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rvh+JUJrHgdNlDLuqtrHf3EboGJloUe6tLNecgIJseg=;
 b=a5odSzGxYHKIDyXyG8rHRDl4cjgRCZPpkpQ7s7+rMitLOPal8ebB8/tZGqIYAsu0Al
 Dc+LZTueDIlASp038N7/QFKPvhUqT2T6zRS24UlwW4UFioaFO/rw+B/n2GWYP102sySW
 1hBIegl9jBES5GQk1IYpny0LpniQ8vWsq+HyNcdjFikdypJisqly1WOITZPZs1gMjn6Z
 jgAOlhmzOmK+gSHd9se8vOZ6R02v3M8jzF7t2uMdPn7GkDybVo9o+h0yi8U/iqzed83D
 LizD5tkdNVQxKfppTJcATPjsbe0zx1by4S+JklGKuQR04Zjoh8p0bLLzqC4xgTcrUV8I
 I8Nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWEtAiWA46vehr9SMRC4pPHNu7zu6tsvedDnjaDeF9AiyvNlg+IaiyGYfhR8EPKy4LjdrFXP4ahX0PPT0rMLtI1LCz7pg=
X-Gm-Message-State: AOJu0YwoJwaKYS/vsEq4s7c6AXTBciqzqt8qhRGUa/F7OyFSEThn1df7
 io7UAIWAh27IUsNTryhDWp+xRwLwOo1IsHc0SjAOWcLHgzPxrP7AGo1WNgl2txeGIS/2GmCdHJE
 juN8=
X-Google-Smtp-Source: AGHT+IH5S7YkWnU0S/Cv96aZJ92GPT24liTghuux2DaxJJ2sA0QLL23RmUWB3TDPWl3F3bG1IHvc5g==
X-Received: by 2002:a5d:6a46:0:b0:368:334e:2d2a with SMTP id
 ffacd0b85a97d-369bae34a07mr5722650f8f.18.1721682452612; 
 Mon, 22 Jul 2024 14:07:32 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3687868b262sm9491560f8f.30.2024.07.22.14.07.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 14:07:32 -0700 (PDT)
Message-ID: <28ad74f2-1103-465f-b977-b1d48c06083e@linaro.org>
Date: Mon, 22 Jul 2024 23:07:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/16] Final bits for 9.1-rc0 (docker, plugins, gdbstub,
 semihosting)
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20240722110413.118418-1-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240722110413.118418-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Hi Alex,

On 22/7/24 13:03, Alex Bennée wrote:
> warn: No match for commit c135d5eaafe7aa2533da663d8e5a34a424b71eb9 found at https://gitlab.com/stsquad/qemu.git
> warn: Are you sure you pushed 'pull-target-arm-20240711-209-gc135d5eaaf' there?

Is this warning expected?

> The following changes since commit a7ddb48bd1363c8bcdf42776d320289c42191f01:
> 
>    Merge tag 'pull-aspeed-20240721' of https://github.com/legoater/qemu into staging (2024-07-22 07:52:05 +1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stsquad/qemu.git pull-target-arm-20240711-209-gc135d5eaaf
> 
> for you to fetch changes up to c135d5eaafe7aa2533da663d8e5a34a424b71eb9:
> 
>    tests/tcg/aarch64: Fix test-mte.py (2024-07-22 09:38:17 +0100)
> 
> ----------------------------------------------------------------


