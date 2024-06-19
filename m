Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85548C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 02:41:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJlGE-00006P-F5; Tue, 18 Jun 2024 22:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJlGC-00005z-Ld
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 22:41:20 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJlGB-0004nm-4V
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 22:41:20 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2c2c6b27428so4768852a91.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 19:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718764877; x=1719369677; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eey5CwDEoK4Tj9IoIG6YGpUiix2ArYCy4Snf1KNYUvY=;
 b=CWSw6F2IAaxMd+/Jv+XYwC1GO54KK5qJedE14PMwUCuIF9tImEvX950u7sj1KhBVqy
 XbNqF8JhQ0+8bdWIR5MGIUNkQW7xHWprdeBiUHt+nYrcBI8g8F9clqGSoWjzyOHkP7Hf
 7Z08tN1chtxGVkXjOveftR12FJJR3csI16Fbc7v/NWSL3vwp1eSLx+4gr9w3NTYzelPm
 i833rnMt3OYxZnklBdSrnAlv+DXEANanTxls+Ap7vp7WV3PoGtd06/wXxz6vJw6TerlU
 QhOinFsohSP4Ywtija8R/2d6qKAGYZXNnhmbFbHQk3RrWYKKpK5lJ9jaAfYT12SJqjdP
 +7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718764877; x=1719369677;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eey5CwDEoK4Tj9IoIG6YGpUiix2ArYCy4Snf1KNYUvY=;
 b=cFMxvqKhpa87hDQhKwHzLmqn6cwrB2b2grjgLvR+/pl4P73Rf+jXrD/S7LP+UB8EG6
 X/9Aej3l72CIdChdus0VlKHGz537/Hk1goPFcJwSNHLWL0sTrj5mJ74sIyvdb97u1qw7
 BdKKzURnwxZwjc6G8UFXeIq79URUk/kHyWDZcd15kuUgSMRgMC13X1CtIx1xNfrWAnZb
 f71vURhE5aru6JRnWBk8QzlYIgQBF+qQi2mTvwee4dTDUvRteVQPkT1WNjvOpfJbuUNr
 +Q8Yx6LjHtpDoCObLhO5J43c0oKygRSpIZlJNCRw+1xkbWT4xjlN4bMfBipiGXcj7tcW
 3xyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBbIChGZNpBQYLNw3dcqoWYBxMyFOdW8fsD+eoM//9uqZ1y7Bii/kkGAMfkNa3Oucg4VD6dqyhUpFyy+Osn2DBL4AmYqs=
X-Gm-Message-State: AOJu0YxplpmDAp5jJ1JOLYtORwOyvOIj6wvQwykNpFxx1IN7bYrFyHby
 8eti4qg8N4Wz173lrDu1ityAlgGnThXdkEDkf6INuy2xSNfE/c2xT/L/IAm1IRcbWVrBoA9e+oU
 +
X-Google-Smtp-Source: AGHT+IHCq+KA426uO6lIxlyqBQSLM2hfKgZKjJlnHPbfZd+4/p/RIC/zzOfHZjE05ij0qLJSklvk3A==
X-Received: by 2002:a17:90a:db82:b0:2c3:7e3:6be0 with SMTP id
 98e67ed59e1d1-2c7b5d6aea2mr1573034a91.31.1718764877471; 
 Tue, 18 Jun 2024 19:41:17 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c4a75ee4e8sm14057149a91.16.2024.06.18.19.41.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 19:41:17 -0700 (PDT)
Message-ID: <e66581c8-9216-496a-b7c7-7ad92f90e565@linaro.org>
Date: Tue, 18 Jun 2024 19:41:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/virt-acpi-build: Drop local iort_node_offset
To: Nicolin Chen <nicolinc@nvidia.com>, peter.maydell@linaro.org,
 mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 shannon.zhaosl@gmail.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20240619001708.926511-1-nicolinc@nvidia.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240619001708.926511-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

On 6/18/24 17:17, Nicolin Chen wrote:
> Both the other two callers of build_iort_id_mapping() just directly pass
> in the IORT_NODE_OFFSET macro. Keeping a "const uint32_t" local variable
> storing the same value doesn't have any gain.
> 
> Simplify this by replacing the only place using this local variable with
> the macro directly.
> 
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> ---
>   hw/arm/virt-acpi-build.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

