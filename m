Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE3ACCA0EC4
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 07:29:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1um5tu-0003d7-Q2; Wed, 13 Aug 2025 03:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1um5tt-0003cr-9d
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 03:27:57 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1um5tl-0006np-Sf
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 03:27:56 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3b78294a233so5141823f8f.3
 for <qemu-devel@nongnu.org>; Wed, 13 Aug 2025 00:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755070065; x=1755674865; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xPhQztxu+5MVuCb+8IVmaAasg+E0H4sa0+DQZfGsVDc=;
 b=zsEpEOizw5V+M/keBwpltCKYSkuHxvVZdOq1malmEs+Jfi34c6FGaHJKIp5wsjf6wK
 gTGVSscHkftj6Sd++qLK1wOIrOZJ1GvIRpLT4bQWvHKMDE7iwGlw2/z/bf4ubxTfLTTr
 hfusWM/Q3iaCa00I1mAkVBUPjsJNdPYH/wxubgouoW4VXf+QZ6PL4MZycYY0CPCUtydx
 jcwLAVWhEs0xywa+uckGQ1EHwoNnp8XMe7jiLbVgcf0fuGGZP+kvUrxh+ejnW2p6btIg
 Rj+2i6XtIcCtxiFQO6htokFpRgVxU6gBckAUc5BOJsU0mepakcPJwdZx/rprz1xr2EkR
 oJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755070065; x=1755674865;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xPhQztxu+5MVuCb+8IVmaAasg+E0H4sa0+DQZfGsVDc=;
 b=GKk/Y+PYtzY9zMhUVzDu56QfRmgaioTx1uHiQoCDxPZgCR4sj66dHwj3TrtgF10q+X
 Z0nISlkh1Dbynd8g+lNhArh77f6zFqVdk98LPr64TDUO+Gx0L5xo1JD4x9z8UhBZNSmu
 x6Cypl3NAq6Acexb4dQYr4qs8ORTllSE3dB81/kQx6m2oH+kabqBHTcUYAkr/hPDh1Lj
 UQjJQUM8d56gW7p6ABDCPu0CZYVp15K5/wr363B7UmLQSxZjACHnqt5cSiUc8v+xo2JW
 XNICSDVfIS71fQwKQTGAn94fT2fszq78eEdVD2Enn6dNvm0c2BjzfsXHOlLRTYxGKQYK
 mPTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAHkrbiSbbizJM98rwoSjt4V9PgkL+BPrD6h0PhaP6ZMD3eRSC04zY2TyAwGgSdJDG2+D2a1LCUlPk@nongnu.org
X-Gm-Message-State: AOJu0YztoqDUMKCZ3SF3hqzh7gcO9YOE46TbvZTJlYjRBlvYI0Dv4E9h
 1DgKDMOOHJH1FDw8dV7PMoaDWDYVcy30pNNoVb0XwuP4W9XHcafwFl9qTCrAZ87sLfQ=
X-Gm-Gg: ASbGncuIldt/2uB268qs2qkzIOQpU7vcuMQqI4tzKXhycmCJZnEqWMfSKF+IRW3cDOZ
 32pLN9fBMTU/cYvV6slxcFrNRsyPTjRQLRO7yuMJIjHGGAfdw2iDflNO4jjcXx+i1rBJGbZcurp
 O1vLFOXkPNE+7djMaC3T5K1n18/snWVfwM/Nv9tatn0e4FzFfrVT+4+JhbxuLTBpxhwHS0gjNLD
 B8o4lbPkUqVkowYKCEQPSAN9+EUsnSaRUMFWdsFc89DXknZ06E18FgXabBwZ1ANPWD4UvOejYGe
 JmdHLHvgzVNtsYsN9zEMawlTwH6idFzzgSiZzOchGqDifPM1cIUPOJlVgjknvcjbRXChoBPuJdj
 uHjX9O6nm55wx4y8uOusyRqJU67egDBrv9yQOldh6YkINVmjrr4hw8u8FVVgQFopDew==
X-Google-Smtp-Source: AGHT+IEJWkkCESYBq7S4iBKcs2OmIXEKUNRLVfA8Rdlen6nPN00zf2C3gY9aEoauwoXZLs6OIkKbNQ==
X-Received: by 2002:a05:6000:1a86:b0:3a4:f8fa:8a3a with SMTP id
 ffacd0b85a97d-3b917e457cfmr1145821f8f.18.1755070064661; 
 Wed, 13 Aug 2025 00:27:44 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3b9eddsm46770792f8f.22.2025.08.13.00.27.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Aug 2025 00:27:44 -0700 (PDT)
Message-ID: <dd353f4a-74cd-4c37-b9ea-5486168c52ce@linaro.org>
Date: Wed, 13 Aug 2025 09:27:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 06/14] tests/functional: add hypervisor test for aarch64
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20250727083254.3826585-1-alex.bennee@linaro.org>
 <20250727083254.3826585-7-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250727083254.3826585-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 27/7/25 10:32, Alex Bennée wrote:
> This is a simple test case that runs an image with kvmtool and
> kvm-unit-tests which can validate virtualisation works. This is useful
> for exercising TCG but can also be applied to any nested virt setup
> which is why it doesn't specify an accelerator.
> 
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Tested-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-ID: <20250725154517.3523095-7-alex.bennee@linaro.org>

You merged v1, not v2, was that deliberate?
https://lore.kernel.org/qemu-devel/20250724094214.93330-1-philmd@linaro.org/


