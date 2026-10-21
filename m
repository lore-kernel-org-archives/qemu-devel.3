Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EA8606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hJVuYNYS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXaV-00044b-NR; Wed, 21 Oct 2026 10:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXZR-0003qO-3x
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:45:40 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXZL-0004Of-EN
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:45:35 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48441a2ba1bso575349f8f.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792593929; x=1793198729; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3CekQSbFBvqQG9PVcoZJUGLkF4ACoEGRFwVzo4LEq2c=;
 b=hJVuYNYSdMBa7sDsZqhNG220bLl0Io7G/HDNvsWCnuC1GS+nFuJJqsmR403dsy3B5n
 j+01BGrAq+42YfKVf7NLVKY3DtwavGmvZKgtf/167e8S8iiWyxP5QVnjyVOfu7xZ3ysf
 z+NcEIYsJmUORm8K6GJII2P7v/aSvVgBQ1l8a50MYPTjLBNdTfKz6MUR2vhGJK3oo7Gs
 vCQN3gWnLl0MOOQZKFo3qJX4RxpT0O+DOkhuPM1ly3JEIzOnd7xMWbbJRXer9k8npPe7
 oZXn2JFRQRGP29VBgUgdSRtMRa0tGj0ruS743F5uY7NlR/aAbKws3/NqZBFXhH8+Zh+U
 DyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792593929; x=1793198729;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3CekQSbFBvqQG9PVcoZJUGLkF4ACoEGRFwVzo4LEq2c=;
 b=nm9rRaGYPtKfgeN2sHCec8YiI0r3P24rEDna0k1S7FCJY9xxPO3cS3c99d/r8jSv3R
 58iU/IWgddT4uDv5XIde427JGq7UyqiNwB02CTf876Rq/ZNybRcfhtZAN2rBcNPCtJUm
 uKWFpEd6Innl1mirH+97Kkr2oBS5vnCIGqZ94O+jD1LtXaPl2VAhqYE4LXYR9VmPlIaK
 Z7MLPwoLfkly92X/XaWq9zE5YK8rMtc+vVmTaGXYjBVPDh3EYVYMYN5+ZbyhKzceNqMI
 GUXgY4DuCUFfi5OSi/St494CzEXQQaW4X9jNhfe78jNtDVVSJZQuFc+nTecwwF4mDjb3
 BIdA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzzvtmWwWZwCug4U/5/zJc3cyVAj8VHW+Gj8CTEeYEpQT9re/p3eSbf7CUrWkCXC3Z/Qba4tyMOLtp+@nongnu.org
X-Gm-Message-State: AFq9FYKZg4s8+QtQPzKmMUAxx9ezMcxKnrMdtm6DOcCxUD43XlwWhkZ3
 1YYYJ0h8f7eVDQsVJn9PxTQBQ1qu0rp3HpO3jyB+j1RJFMtw9+LYz8mdZqCvlUugWWlw2qFne8m
 jL2+1Ua8=
X-Gm-Gg: AYBFou27JLbOSbQlAA508ib3XX9HYfFRTuuzNeJ/FtPGk3aUsOacpeNEv6UWjtEraby
 RANbo8zMr53NXJzMCxoDfr22nWbLP4Lo5L5J55EyGmjAyOPhgCQEHfXUPNJjRyjpcbgYYU/ls9T
 FrP8b96u1K0ver9ausUR2K8mO16xqj16N9UsvC7xCY7AMZJMRwu9J/Bt7W57vYL+3/XNUsVeOx6
 ZdiaiaygvlJS8IOxN+dYFsN54CRoCOGsqc12K/bD8tyME/ExKa4MpFdyEgqyQpX2TQUZnT7i99f
 OUBQlM6UFlBcV6yZxK6VQ78C03T7e3lYgOf4+59a+PVdRaLh5C2q7igJVGBFRNkDFbQK8KM/NIt
 nI3KA7Jh/0p6EtKBmhoh15w6Sbz3NqNF/fv1fkbNv0VEDznj64+eQI6+PkDzVe9h7quPV4l7gCj
 yiaZMcxahKQIgD04Ras08F2lSlMVQnwFzG45X3t7BOiF5sMpnpg+kLY56Gvn3OxslxpTPXPHL7K
 OeL+KR1OqCwQZKYzXrkLhhfKReNVLdKZY7AB89QfBKQw2HJsoS4XLNo0DE9jzTyzwe93viZoRpx
 zm7F3t+35qDl4yyktV4YqhhNd0o=
X-Received: by 2002:a05:6000:4025:b0:48d:ff81:5201 with SMTP id
 ffacd0b85a97d-48e265015acmr4696041f8f.41.1792593928894; 
 Wed, 21 Oct 2026 07:45:28 -0700 (PDT)
Received: from [192.168.2.121] (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2584c3b0sm6600845f8f.57.2026.10.21.07.45.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 07:45:28 -0700 (PDT)
Message-ID: <370c9e06-1b04-4bee-8b10-7dab6fadd47d@linaro.org>
Date: Wed, 21 Oct 2026 16:45:26 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] hw/intc/exynos4210_combiner: fix misc range check
 issues
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20261019162217.3272337-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261019162217.3272337-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x433.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/19/26 18:22, Peter Maydell wrote:
> Peter Maydell (4):
>    hw/intc/exynos4210_combiner: Fix group register range check
>    hw/intc/exynos4210_combiner: Clean up reg_set[] bounds checks
>    hw/intc/exynos4210_combiner: Make reg_set[] only as large as it needs
>      to be
>    hw/intc/exynos4210_combiner: write default case is unreachable, not
>      guest error

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

