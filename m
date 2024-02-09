Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA03C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 18:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYW1l-0000iJ-0W; Fri, 09 Feb 2024 13:55:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYW1i-0000iB-91
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 13:55:06 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYW1f-0001JV-OM
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 13:55:06 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33b1d7f736bso737800f8f.3
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 10:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707504901; x=1708109701; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AJzWnves6eRh9mYWq0SCFhU9e5lDWuptM9DFd6uvw58=;
 b=JeUt7J+J6C2WOvyq3p5EVp4lnsp6z+TZ8rAih9a+GB2RNWG64Wz/GT3xk60Lr/ES6P
 YuOZgbIdtpc6a79xAePx9FlX5dCUDgHwbV47Xji5J3sq7Evq51DMuw6wC4mqJh2VFH8l
 IwVTqpur8pHuns8k9w9BHzt63hMhHRxxGRW18I1X5x/9ubn80iIqRIr6aczscf5FFXaC
 RyKweomjTxY+udIv2G17AQ1AgxUUMbdTY0VVLnY9p/zPjgQVHj/rPY3S1N8THbjHXzfO
 QCmwTKXn0+SyJ9fDVt7EsNFrz5sdV4yVuQSMYHgRI8LiCjprsKf3r1lBW5UF8y197jTs
 R0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707504901; x=1708109701;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AJzWnves6eRh9mYWq0SCFhU9e5lDWuptM9DFd6uvw58=;
 b=Z2ShBA+LmvNNu1OR6kH2aCQASJY3OwPC38qfNBQrso7VKs5hGwa0xf21bAiSaFZ2AF
 TQdkHv7yyBpLz7GAdztSQp3l0MQFfxyzbzYWh+Mf95glDqruZUYGOQvyfM31PloDH6WR
 J72vu3hYzLm8DfgH+Twt9LSrYIKLc6jUMizSN/EdaKiZwb74YGnH9/QOrKArURUYpRzB
 S1bZ6VmrsAMKof2qMe+bk9/FnlxVsJGDCcBtLiFUHTkoOYe9ZK/gKU7Bip7ii0ufhgFt
 tIV2psPz2gRZB2ZwtSBBV7UljFYNSsINuZPY7ANwbfQLodqMAoqjr+Lb8E15ySMoHI5Y
 PyWg==
X-Gm-Message-State: AOJu0YyjZsmeIArGSwRlypfzxJ43Hc4RCCe4bacUSbvgEwuQfqjPzEq/
 KJNXgok2g4K9WvxTVQ1JqKguygv+/VCsQrIbQw5JOarwx8z23GklmrZuGm66AVw=
X-Google-Smtp-Source: AGHT+IGV9lL9JiO1jrXcb82nSShyTwG7fcJj3GIxdOGvs9jmUxiKZXUaQtgQz8X4Nry2f9mTSoyIBg==
X-Received: by 2002:a5d:5150:0:b0:33b:28df:c370 with SMTP id
 u16-20020a5d5150000000b0033b28dfc370mr1607898wrt.14.1707504901541; 
 Fri, 09 Feb 2024 10:55:01 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWvMJUqRXYFWMM4joTOnV91KC65iaJh/5L0bNYvPtMKtkucQ55ACK7PIySj6/Z7cKJ0QUmDlPFV7yatFDRyXz+tIGo/s2N6hn/ajo330/wgorlC7b3BAplj466fy+nS8wQrZnaCuqUVe8IYDFgXSASQigLVTQ16WZncAz8ZASEHvDFLtIpDQDShCWK131hHMD97uY7uCt+m9ex7lAmcuydPmrmls9DrQTmXSrLaQv0EF97kgBs/MuiBhfPhOclQXaKVzKTnKMZJkbjPDUzKcp5lG5x5w5+v5LqsP3oSZuvPpFr27berlZPfDq/lGUWX/2jv1j760lELTj8Q3rkXGOJcMlyQsc89ukY=
Received: from [192.168.69.100] ([176.176.147.207])
 by smtp.gmail.com with ESMTPSA id
 o15-20020adfeacf000000b0033b5a6b4b9bsm2452528wrn.71.2024.02.09.10.54.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Feb 2024 10:55:01 -0800 (PST)
Message-ID: <dec65342-859f-4b52-9bc4-10f3be633270@linaro.org>
Date: Fri, 9 Feb 2024 19:54:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 3/5] target/arm/kvm: Add helper to detect EL2 when using
 KVM
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, miguel.luis@oracle.com,
 haibo.xu@linaro.org, peter.maydell@linaro.org, richard.henderson@linaro.org,
 maz@kernel.org, gkulkarni@amperecomputing.com
References: <20240209160039.677865-1-eric.auger@redhat.com>
 <20240209160039.677865-4-eric.auger@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240209160039.677865-4-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 9/2/24 16:59, Eric Auger wrote:
> From: Haibo Xu <haibo.xu@linaro.org>
> 
> Introduce query support for KVM_CAP_ARM_EL2.
> 
> Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
> Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/kvm.c     |  5 +++++
>   target/arm/kvm_arm.h | 12 ++++++++++++
>   2 files changed, 17 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


