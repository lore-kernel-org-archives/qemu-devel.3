Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8277C87FD2
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 12:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulRkj-0008TM-8y; Mon, 11 Aug 2025 08:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulRkh-0008Sz-6g
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 08:35:47 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulRka-0000P7-4o
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 08:35:46 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3b785a69454so2387196f8f.2
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 05:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754915737; x=1755520537; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ih5VkWpw7ztt++4HgYduX1lWPx3usHZTVJ6QOLz4sBM=;
 b=RdcQH45IuhIjQPNuYj5lvcPGXNoGyPvq4Y62dGHa48UwWok/pgGe1tvdHzPHuxrwRh
 HjJJq8nNKEtHz/fz7vZdbbJSMebRO9uCOLZuQUIHgQJqQioDumukzW9vkDL2LWY6tj+1
 tXFKwZ1ZW9+faYCmsQhsvaeQJi3mQ1Zoz9W4Adp2av7KzvLSu1w8do6xGdYA7T5GDpry
 3E+5l1hsSFcdmy9I8GubXc7IoXFhpAPqsOtlQJfCIZir4raMak1KKBNdcP+knUmYhGbR
 qZjNsCVwWlNqbxnUhEBaUEIaPr7vaNFzu24KguITYyk75BNwRVf6BcsNQUfqAANf5e4r
 y0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754915737; x=1755520537;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ih5VkWpw7ztt++4HgYduX1lWPx3usHZTVJ6QOLz4sBM=;
 b=VsWRsre/mu/saDWQO3SxeOkakG26vEo4D1YaLp3JeOZgNZ5sP7Fj54h/ysHSx++ldB
 HhXWMXVIFn406CrrcvhP2o+9Vid6JzCmPy952jIobp2n1ErwxmplAOgMHVFHvp8dTUJC
 +pMYP22FNOPRAK9GWWM85bFkLvnAWQFWdCgMP6ODybR3cN37TSOlIpxxGP7k+7xItqKN
 ecHJCw4nM89ehl4PWMacUSLj0IwaZB64fzKXiJj/qzQTmL9lGBJtPRCLSbeqoF76Xk8C
 MqoyCD4jkeRV/6ebj0BnMU6Mz647mSKvX7Kf3fJSox0IYCALBBv87dVDH8lVf0ADuGQO
 9ZSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnMDFY4uWqYwjOEg9IHOo0/wIXDjpaULfXzWyJSq06YIdosNrIfN2MMsHqX7Euk1UmV7aCMTNqfjbZ@nongnu.org
X-Gm-Message-State: AOJu0Yy3yZZV29W0zKe4Sb40jABPeSAJBXksqGWV5SLV2q7lvj5UkblI
 xtUt8X9aWLZNYiA0vHeBs/qOTK/4WNc6oG768geux+lbYO5ivgSRawB9kTJRIyPTv7s=
X-Gm-Gg: ASbGncvSjw/u8s3NoLeRaxZRjZ0x+Qvmi/kizmrNsQZkdTe9XnoNBAirMmmWwvp/f8e
 /1qMywa5JEPLkPYQfrGlQ+HRkBh7VrKFcYA8QSIsdBnkTWWGFhgwi5o1Z+pyp2Y/np2VUGbPlir
 QhRSluO5iFTmB2aZBOlqPIZJ0/9YffuuWAd4HJbxTp6xNNPW2aIYSKPRSWLkcEyC90Y7WnvgENq
 Yce4qb+852MhDO1f37kkaNWH+MKvQnPV2anjpODAflk+iKVr7x3JQ1wZVFhWgyt2zqpIp8TrwNJ
 hdznPep8pNkiXBGGUoN+E1+mFWadQYPFOd8TbvLSFrtlpcUwJY9OwJepmkVmxQPwEytfy/8GG1n
 tZhcc5Wd3RtzX5wlZ2lLzlpY6qUnzWSQvx0D3gst1IcpMkKTszNwXHc1JXvLbb2Z+Lg==
X-Google-Smtp-Source: AGHT+IHSmkUYViYqb2rJk+JFyUceGluZqJetPGTZ5etaTQ3YEerXaoIp6GYVorcSwNs4LwjW8HNMRg==
X-Received: by 2002:a05:6000:381:b0:3b7:9c28:f84b with SMTP id
 ffacd0b85a97d-3b900b5050dmr10128435f8f.36.1754915737438; 
 Mon, 11 Aug 2025 05:35:37 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458bb04c612sm372925755e9.0.2025.08.11.05.35.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 05:35:36 -0700 (PDT)
Message-ID: <7402c0f3-326b-4a98-bd62-b8da998b4401@linaro.org>
Date: Mon, 11 Aug 2025 14:35:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] target/arm: Trap PMCR when MDCR_EL2.TPMCR is set
To: Smail AIDER <smail.aider@huawei.com>, qemu-devel@nongnu.org
Cc: alexander.spyridakis@huawei.com, zhangyue165@huawei.com,
 liuyutao2@huawei.com, mjt@tls.msk.ru,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org
References: <20250811112143.1577055-1-smail.aider@huawei.com>
 <20250811112143.1577055-2-smail.aider@huawei.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250811112143.1577055-2-smail.aider@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Hi Smail,

(no need to Cc qemu-stable with this patch, it is a simple refactor)

On 11/8/25 13:21, Smail AIDER via wrote:
> From: Smail AIDER via <qemu-devel@nongnu.org>
> 
> Trap PMCR_EL0 or PMCR accesses to EL2 when MDCR_EL2.TPMCR is set.
> Similar to MDCR_EL2.TPM, MDCR_EL2.TPMCR allows trapping EL0 and EL1
> accesses to the PMCR register to EL2.
> 
> Signed-off-by: Smail AIDER <smail.aider@huawei.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20250722131925.2119169-1-smail.aider@huawei.com>
> ---
>   target/arm/cpregs-pmu.c | 33 +++++++++++++++++++++++++--------
>   1 file changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/target/arm/cpregs-pmu.c b/target/arm/cpregs-pmu.c
> index 9c4431c18b..13392ddc4c 100644
> --- a/target/arm/cpregs-pmu.c
> +++ b/target/arm/cpregs-pmu.c
> @@ -228,22 +228,27 @@ static bool event_supported(uint16_t number)
>       return supported_event_map[number] != UNSUPPORTED_EVENT;
>   }
>   
> -static CPAccessResult pmreg_access(CPUARMState *env, const ARMCPRegInfo *ri,
> -                                   bool isread)
> +static CPAccessResult do_pmreg_access(CPUARMState *env, bool is_pmcr)

"bool is_pmcr" vs ...

> +static CPAccessResult pmreg_access(CPUARMState *env, const ARMCPRegInfo *ri,
> +                                   bool isread)

... "bool isread".

I suppose we want to use "is_pmcr" here instead of "isread".

> +{
> +    return do_pmreg_access(env, false);
> +}
> +
> +static CPAccessResult pmreg_access_pmcr(CPUARMState *env, const ARMCPRegInfo *ri,
> +                                   bool isread)
> +{
> +    return do_pmreg_access(env, true);
> +}
> +
>   static CPAccessResult pmreg_access_xevcntr(CPUARMState *env,
>                                              const ARMCPRegInfo *ri,
>                                              bool isread)
> @@ -1187,14 +1204,14 @@ void define_pm_cpregs(ARMCPU *cpu)
>               .fgt = FGT_PMCR_EL0,
>               .type = ARM_CP_IO | ARM_CP_ALIAS,
>               .fieldoffset = offsetoflow32(CPUARMState, cp15.c9_pmcr),
> -            .accessfn = pmreg_access,
> +            .accessfn = pmreg_access_pmcr,
>               .readfn = pmcr_read, .raw_readfn = raw_read,
>               .writefn = pmcr_write, .raw_writefn = raw_write,
>           };
>           const ARMCPRegInfo pmcr64 = {
>               .name = "PMCR_EL0", .state = ARM_CP_STATE_AA64,
>               .opc0 = 3, .opc1 = 3, .crn = 9, .crm = 12, .opc2 = 0,
> -            .access = PL0_RW, .accessfn = pmreg_access,
> +            .access = PL0_RW, .accessfn = pmreg_access_pmcr,
>               .fgt = FGT_PMCR_EL0,
>               .type = ARM_CP_IO,
>               .fieldoffset = offsetof(CPUARMState, cp15.c9_pmcr),


