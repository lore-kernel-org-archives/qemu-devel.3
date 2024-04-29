Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 945C1C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 12:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Q3W-0006wd-I2; Mon, 29 Apr 2024 08:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1Q3R-0006vR-P5
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 08:24:23 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1Q3P-0001LI-CA
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 08:24:20 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6f30f69a958so3718688b3a.1
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 05:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714393456; x=1714998256; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pRVgv2WOeah7BJAKrPAXEgqWlL6upqOcFmDDTGRJHY8=;
 b=ihfCFeOxtBRTAb5GFIS5IlKsZ2CiZV8GOV5ohQi9rgO/+CtYtYcxpAEDsZhSXuEmlF
 SV9EQ+PPXzC4XwMVFni+E/qSj2j82I1ciwLhE/3mmrlZ16XaqChSlDqy1UfgrYYdmlN/
 yJmKS8uM86zTiWyIT7H/lFz/MoZtA5atSgm0gUl1WQKMM+nA+Q71YFV+ubA0FqadsEhb
 BhequY0t4jD9mwFzoYJWaGANJVvGs7RVknDqIpo61+AJrGcVS/xU6THLc58nsVxBFHt0
 GEQFhweIJIpQ4rnMPGQUxEluofeCBWr6nJNr55I9oUx/GCnFqAW2Qvxq3W3Iy4oBRcLw
 xJiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714393456; x=1714998256;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pRVgv2WOeah7BJAKrPAXEgqWlL6upqOcFmDDTGRJHY8=;
 b=qiDslLrYgxDUum3uGhGIqP2ppMgNxq6auGZ28x1OZDB83H9uTC7humrh9g4uReQiBF
 TOsLIn21wT3aUrm7Q3xt98GNaZe0/N8XCpZGECJ6PtM1qPONmh6h1aeMIgCKIdUlvukG
 Qkd7aXQTdCYgRryet5bYgq/NWmQqgWY6VHhacz7M1Va+q/CbrzbXaFDsWu2IDsV43Wm9
 6C5ABI++rNLnzGVqPIGCJ2vFVV30pUjBZf7RBfbc7FvfOXDoKRcbDwQ5VUmkoMz5KKAa
 5AZopsBY9scGZAyM7jfwQCMMXqD4dMQjcAP6w2RfzUe+UrtvYuMA5JGK2xdTeaU6jTvj
 BrWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6p46UJ/fBhfLpDHvl7EaqkAPPNbs32H2z5y9RTi/UjR8v/yJvEA19TqcpMgIr9psHX6doCR1yy/BeNeC0Sfe76zhRePQ=
X-Gm-Message-State: AOJu0Ywd0Ta5eNz6PT0NNVk+XGIDTmivkVz4/9amqkvKnMRc9o5lQJcR
 G8CXHrLZxHdoslQvcD1dTsgpK8vMjfBJ0iDpkEvds+kaEk3CSTMc7YQ21N5txNI=
X-Google-Smtp-Source: AGHT+IGrm73KVZJ0VQomk4NUveLxmJKobG4XcWzKGjkFj/lux8+u+gbA6rqW2Zu+PJyZjXyNtheMEg==
X-Received: by 2002:a05:6a00:3a0b:b0:6e6:970f:a809 with SMTP id
 fj11-20020a056a003a0b00b006e6970fa809mr11745111pfb.20.1714393456412; 
 Mon, 29 Apr 2024 05:24:16 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 b8-20020a056a000a8800b006f388e6546asm6606256pfl.214.2024.04.29.05.24.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 05:24:15 -0700 (PDT)
Message-ID: <1fc6ba9b-11aa-4084-8cbc-42a5f2a8d326@linaro.org>
Date: Mon, 29 Apr 2024 05:24:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] accel: Fix NULL deref in NVMM / WHPX vCPU init
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Reinoud Zandijk <reinoud@netbsd.org>
References: <20240429091918.27429-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240429091918.27429-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 4/29/24 02:19, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (2):
>    accel/whpx: Fix NULL dereference in whpx_init_vcpu()
>    accel/nvmm: Fix NULL dereference in nvmm_init_vcpu()

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

