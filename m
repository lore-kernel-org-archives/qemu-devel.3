Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE77C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 20:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcWb2-0003Gi-Uf; Tue, 20 Feb 2024 15:20:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcWb1-0003GJ-Iz
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 15:20:07 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcWaz-0007q0-2w
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 15:20:06 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1dc1ff3ba1aso7445425ad.3
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 12:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708460403; x=1709065203; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d03HZYpwR0PudwujZqAxSyhosRBRw1TU4DXhcz5VG6U=;
 b=yZP0PG6jxsSwbkLPYlM1+QxFs8a06W5bv66+CDVAbKALzoLi41kq6FNveFaf5iouHD
 vPR5AmS/fvMUYan52KV55NrTjlNVTDnY6gPL69Ze8jvJzQyz/svLJ7g6iurkrpcOtpri
 RQng+v5xLlAy2411wWbe+HoRCzTeKtsUnN7yeVfq2w4QOZ2zPLgkx+eHtmrmP+7RKy92
 FJCSanHg3ObFGnQJgWCECWo9v+kEwNRBb6vn3FtObCQQywJUHryuMjltp3idNMP+uM4d
 s7GQPl8kDXtnXwn5/zghSMNoTucB5ZDIk6lHGYPXzBWfHRthNUcDB5RJrcoQF5cZK7/v
 vpyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708460403; x=1709065203;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d03HZYpwR0PudwujZqAxSyhosRBRw1TU4DXhcz5VG6U=;
 b=pq1N0yuySDcbwf2OcUelqPnPkjZOXNFVL7Pzzju/VfSnZFnhi80deogBhBHN3HT2Nv
 691kiJo4Rll/xbTPsLQRZPUZ6mlarN6Vr9lrfg+56zbgdNRuTcnCPGgdffGDJmfyfj8i
 c7tw7sDXWg38ehDOUKBXYJ0byPJtvKCt4DCYvJVnyblwQe6ew2vT/QLiUU/8uc1iYHzU
 lIPHgF5L5jz03aEfCOnDW8YBLkWdOTJ6EHr7a6bdP3QK+w6YFtNK44zW86a5ugv0ziK+
 texYooIpShr0Bwn8juzFeKEPJU+8VlLO1wfMoe0r2w0tLuW4uwroaNkE2Zd3l6nDuhLP
 n8jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSx2kwqXkP4WkYCu89HJRim67Vz+Ua7YvT8T+Mh3GuzryRdXl+0vMDSeFMQOnJCDBjBHTryasbpR6qHGG++GGdYPa6ZEI=
X-Gm-Message-State: AOJu0YxaJMbrZpLGxSNAP4MzPZAFtXPqMWKShFLRuqU44fGTv6QfbBLF
 PGXKBBOH75sN6J3Yg6UkuYVCI5iL6TxcIfxHG6ZLMlrTBQmXn+iOdP+RSDmSt0g=
X-Google-Smtp-Source: AGHT+IEsKLopHFwM8F8y5UNTtXFc6VO2ddP5eeFeIYtgULxaLf0VPrmfhZ1v9A+dZq37ih1KGX9aWw==
X-Received: by 2002:a17:903:18b:b0:1db:f01f:fafb with SMTP id
 z11-20020a170903018b00b001dbf01ffafbmr7062466plg.0.1708460403547; 
 Tue, 20 Feb 2024 12:20:03 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 6-20020a170902e9c600b001db45b65e13sm6580544plk.279.2024.02.20.12.20.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 12:20:02 -0800 (PST)
Message-ID: <6fef7f94-f1d4-4c57-b6b1-0e3c4da42890@linaro.org>
Date: Tue, 20 Feb 2024 10:20:00 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] target/riscv/vector_helper.c: set vstart = 0 in
 GEN_VEXT_VSLIDEUP_VX()
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 max.chou@sifive.com
References: <20240220192607.141880-1-dbarboza@ventanamicro.com>
 <20240220192607.141880-4-dbarboza@ventanamicro.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240220192607.141880-4-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 2/20/24 09:26, Daniel Henrique Barboza wrote:
> The helper isn't setting env->vstart = 0 after its execution, as it is
> expected from every vector instruction that completes successfully.
> 
> Signed-off-by: Daniel Henrique Barboza<dbarboza@ventanamicro.com>
> ---
>   target/riscv/vector_helper.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

