Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86564F513F1
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vytol-0006u9-Kz; Sat, 07 Mar 2026 10:43:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vytoD-0006gE-AB
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:43:18 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyto9-0002gO-0f
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:43:17 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-439cd6b0aedso2479944f8f.1
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 07:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772898191; x=1773502991; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K8bdIpUsSaDWT9yjEAOcaZ+kceZGFEszMZs5LMnF+b4=;
 b=plmG/IJ+JrwSyiHle0bKpuPr9SlHsZS1cE3EIBZlyluwt6CUvVk2x1oFdwRTaj35AT
 8hAM08qXuDrbsXBEJXXEjo9Za/zjAGbDcBDin7AIp5JCxGw8hqNExokG7f/7vSxxIFEm
 DFKLlHvi7wipWNqqxy3qOdPqGxUQ5HKtdZe8V9FIMa4HyseGW2Rd9e7ZuTf5sVSMhQjy
 KpyUj5X2EWAnTmV8yyZCxT93eRKevi0Rz9TlfVdTxIWpgnuEoFAbkcVWWZE72YpVk0e0
 HEJsmRXmN2puV2R+g2HOh/gGkHmn8LbKdNcoipY4LNJ+S/8QHHNMNDpZhP+2U0V8qNUA
 GE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772898191; x=1773502991;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K8bdIpUsSaDWT9yjEAOcaZ+kceZGFEszMZs5LMnF+b4=;
 b=oqm/JgXQYTrAmZC27F/6KnQrDqcgH6Xv/2tF6Kfg0J65rRzxtMLyUqa8kBJLhYFCfc
 f0SJQ2Ar282brQs6X7AtfpMsTntbJrNpmrYBDSgGb0f/MWHVibRBttdfwSr97MUUGbzv
 fouwhZcZE+dy7r02VD+fnLH3TgZE0g83OdLE1LPMfa9lf5xyS+9Uh6KAI6OUMEAHIr31
 I8KNvpRQGKMKpKCGYOE5BxofNgrG7P3NY7ts8rvlDFQ6bHedDLbUNGJNJHWH68NvpuZR
 iQVxtTd+urgR9mu5jxHdN9cRpEHM9hzaWgiXBlTicV30qnF07NPZx+lXUcDmwHCl1/vB
 itUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX70PEgPAL5zgY9NIA8roJrM5y10yF7aXoqFvTqfxq66znmKw0eDrhx+ALcOtDOpPTfBus3RcqmDTRb@nongnu.org
X-Gm-Message-State: AOJu0YyTf+U3/t3Hn0Uxf4f7Bf6Tfn03CVY+WYpYhr7H/vMUbCj9NpkE
 FfRwrQYyFSK3W4eO/cX0ediidMUGqRHpu+Qvs053nIQHODGBaCd9I8CQTROxIoRx5jk=
X-Gm-Gg: ATEYQzywX4KT2H7EWhe0yErV7UB87iVwEIjy16qk7rg9Q1nRHGbwKlEZgxCwpyXJUgv
 Hp5U/3i8ZTd1EKjskU2P8Ks8S+qP6c41PnHyeVd8zRe9OpQgrrlBUZLyAg53/uoQRmJC45Nh5MT
 LhI69eCiJK1+2r2mou6dLqYH/dlCh0OMTtX3QoWJjcFMtsPVRRgBzuUewN+O6Id1tJZsBxG1s0m
 a2U2HE8TjD31X3nZVyaHi5Puf0iiO99Y7CPZtMwxkMaDqB4Rbo5LmoQ6gXy3Txk2nThxr/4fp1H
 U2Prh7Imyl3NZ3aFDHaVUUK/WUECRfZM7VMnRZZDWjCuke5dzeL2DdN6jN8C+DZM/FL6lV8y41d
 5x8Dm/wsxSwM0IN7HfULbuWq0LMsWkPzFc9dUu2NMXbIEKzc7tjnzIbWoFw4d29YDuenlbQUYVW
 ClJSIe3ymgSJkHP6278nEGkRmRrAIkNUv3S0EN6mtaMCQnInBbyf5dj7CzXTvZblYYUg==
X-Received: by 2002:a05:600c:6992:b0:483:c490:8c0 with SMTP id
 5b1f17b1804b1-48526923bdfmr96416755e9.11.1772898191060; 
 Sat, 07 Mar 2026 07:43:11 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485276b75eesm100159865e9.14.2026.03.07.07.43.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Mar 2026 07:43:10 -0800 (PST)
Message-ID: <4cdbd6df-cf0e-4fb1-8d23-4fe52b7dcf52@linaro.org>
Date: Sat, 7 Mar 2026 16:43:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 12/13] hvf: arm: disable SME when nested virt is active
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>
References: <20260307153143.76893-1-mohamed@unpredictable.fr>
 <20260307153143.76893-13-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260307153143.76893-13-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/3/26 16:31, Mohamed Mediouni wrote:
> Currently, Apple doesn't support the nested virtualisation + SME combination.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   target/arm/hvf/hvf.c | 2 ++
>   target/arm/hvf_arm.h | 5 +++++
>   2 files changed, 7 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

