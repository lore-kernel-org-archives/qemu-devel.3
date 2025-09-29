Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8747ECAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 23:01:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Mra-0007PK-QA; Mon, 29 Sep 2025 19:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v3MrY-0007P9-PN
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 19:00:56 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v3MrS-0006hd-Mo
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 19:00:56 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b5565f0488bso3596600a12.2
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 16:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759186848; x=1759791648; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9sij2L0ue0j1dvYOyUzy5CprzafB5sSEoG0JUCJiYFk=;
 b=EMIUGPclPMQwLBq0tvLMkmXfK7RZ6wVhiIYEu77TZqGnRuAYnsUsIeEljVdqszJiVr
 D+jrpx2jXt+Gha5AD+qUlPx/HiJLMwyNRKvtAroHGfmybug/jR6exz+DhwBuMmvbv4Gk
 fWaS2/4FNzRv15weGe52gy4ZxcSUjwxOgSy41pf81Lxcxwi8+GyknzfmRUcUGVmNivkv
 u/vGdHn8vSBMdw5eIIvBlqo5r8DUOG3HDF/CG+8UhHvDCpCvFSOMN/Cmp/ouHUoGyJr6
 iF5S8REpDNDMjxdkXdcflgjqzkX99/PEZgV0TO/kXlRUKdW2Q9q/XhG6Jp2TooFjQwYR
 jKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759186848; x=1759791648;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9sij2L0ue0j1dvYOyUzy5CprzafB5sSEoG0JUCJiYFk=;
 b=ANlGFaioOVfYF60H/KfKFSWTIyciKDdPkTTdU2cfB7KoTGbASbosfM9S3CI9HBP0o1
 FQy/FtyzHzfrFFGqDlehHBDnUKHrzFJfWOwmonl7+DspWdxV5PCkvATv7LLOogGpuvQj
 R0xeQTXq4GjaAcnel4Eok+6mpmz+9bcorLJM5W6JX1dUUIheRhxklSnreJ+UaTbM7jC8
 KMVpTreKeYHtTKSVw4+si7G5Wq1OLYka59p30apo1iQa9u1GRr9yakBYC+wy1K6mccSe
 yj6rsZjyXYLwa6AWNZlaLDlqVK1XhmoT1NVZWba1MAT6lNIVLA7ax2PXhGXOOvOR826d
 XfXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWS16Tq/GfrFDPu92736V3/NqHVYPCcvBO5cG4jEs7lHeVqa82S4kI3afNm8Zk0xOJvFc3gHvzF5u3K@nongnu.org
X-Gm-Message-State: AOJu0YwbzUImcGK1LBrgDsASCCeAj/1lfPC+rSUjm0tesJCT6aKl8LnC
 yUdZbpIpXlmSNZEIcO0zFFc0EPPqVh0K8bYEHNsUNo+6JcpCYScTIv5FiNvM3ng0mQM+nIXB2SA
 kJNp1Nbg=
X-Gm-Gg: ASbGncvyGVdwaGrj09Qn9/0BdI80MdQ6prhFTDofEFDa5RyJpKx5EGJHAqEd99zHQgq
 j4y9NerkKrU0wyk8N+J0fx2loOKDDL2d5Cl32ZL75anGo6ijMhuzHf/aHbSQL/y0bKF2WiKnrmH
 vQ2i49mDM8HRPeOjSaZQ2DijcS6mFH6T+ohpGvD+yT7qsEmWmHfr45S7nqcKtDF1ckCSwPxqzxW
 nTZr4LcaMwyvCPDj+0hZmtPlFATuypsZhLno1jFroVdZlBtPPub1eJGHFPc2/nkekAXwWJ22KEu
 8a3Nl1hxwLy4e/kPAzN11svkdTBM5h5bfP+fPybegNEfxuY1yjKY1zNdnK01lAKGQi+2hzuSXPS
 aBiBMhjKEzbtfwHII63N8UAWTGVzQT7MzV79J2cOTx24oOONqUu4ZAr4T
X-Google-Smtp-Source: AGHT+IHgWTi/kpJphKnCl34pUOdnSJLe/jVQMMvHdCV8VwEWVdSjpme/BXCrP7mUuVEOU7TuKbRmww==
X-Received: by 2002:a17:902:ecca:b0:269:8d16:42d1 with SMTP id
 d9443c01a7336-27ed4aac32cmr177688635ad.50.1759186848477; 
 Mon, 29 Sep 2025 16:00:48 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3341be148e8sm18314777a91.16.2025.09.29.16.00.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 16:00:48 -0700 (PDT)
Message-ID: <bed5e780-4fbd-4261-a8d3-ae83f6c5bfd4@linaro.org>
Date: Mon, 29 Sep 2025 16:00:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] target/arm: Add GPCCR fields from ARM revision L.b
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250926001134.295547-1-richard.henderson@linaro.org>
 <20250926001134.295547-3-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250926001134.295547-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/25/25 5:11 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.h | 6 ++++++
>   1 file changed, 6 insertions(+)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


