Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 195BDC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 23:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfpt9-0008Mr-Ub; Thu, 29 Feb 2024 18:32:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfpt6-0008L3-J2
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 18:32:29 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfpt4-00040L-By
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 18:32:28 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1dcb3e6ff3fso1782965ad.2
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 15:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709249544; x=1709854344; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XC3ZUqZdD8nYmcGUxZY7dPczGSWPL9ciFcyvzCDVRT8=;
 b=v0IiDAigJODEEBwrEOVPIDQR3ThGdY5jpB4SbNGB8rxz+AhwLZ1U364T+Ch85y+P/w
 t3vU24b9SA7i9mdt3VSlzR8XABXaJVRXPph3GMKbf6gsUuDTR1I16NMa2duy69t7X5Ys
 OIQCQ1Anbm+MOmJ5QzDnwv9DOdDqimyQ9BWDIzMhaHGkswBVFr34shLFYa2yObLOrSdG
 l9vhz2t/9xEK/br9xOjAXTuwPa8x5rfLUb+2GysQKLdO/BL2HJxJF0eHu1ttmHwxhGiX
 sr8S5vW9rvoUqFeLKtzA33b/q4Ez7ksQ1q+IBB204KGXRYWzV5TuyznA114H0rFFefqE
 x0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709249544; x=1709854344;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XC3ZUqZdD8nYmcGUxZY7dPczGSWPL9ciFcyvzCDVRT8=;
 b=FhoNKXpuVknuFFl9YLCkrpgLGYso/xowKU09zAetcKFM9rhui/YL27bM5zvaaD3wd2
 b+d3qmS70vkcGrj8Y8ip4RrhrfGEtYG/NXwRd72JOdyVLi7TupD+biZUM3wRagwDZxKe
 UqTZlOZJNesx4wg0Wawk4Tz7hR3L/WBQX9ASKkF1ptpcUU5O2VJns1LfrPin05gfhTsN
 bJEdXT3GVuXr6bo9piogYztUSzSDLkxRMPAksPkkmvhgEx5u5Y6aVHBHIBgR7l4oMhhA
 yRxD19/NxwqqjwP/Qm2p3Gb8yNDVAxeoAKXT3Bj3f6Bq5EnDmRuWsusH+RDNfetI4tPr
 Zfpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAZbUlAc3R7rgVZnPqtc7a3f2EOzwAYQYATfa6hfEvA7/Q4RzJj97NQfkDFZvGkP/nGTTNulkLUarJEyJC4KoxmqWXTeo=
X-Gm-Message-State: AOJu0YwxKIcRzGeWWYGD+UXqbCn5jTrrD/jn61IxpW0cdwMtK10QagFR
 z7NOu224PURomE2sqOpf7idK/LXIlajFZO3ygwdmrPbIkjAEs6UGAS4/YRvz6FI=
X-Google-Smtp-Source: AGHT+IFhEOZymvw0hm4rdlLY0NH8acf4crWg1lmtE1TDV7rBcmnRzr3u3fVpczPjlEijt4QvobZRJQ==
X-Received: by 2002:a17:902:da8f:b0:1dc:d515:79cb with SMTP id
 j15-20020a170902da8f00b001dcd51579cbmr43286plx.3.1709249544634; 
 Thu, 29 Feb 2024 15:32:24 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 g5-20020a170902c38500b001dc78455383sm2071495plg.223.2024.02.29.15.32.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Feb 2024 15:32:24 -0800 (PST)
Message-ID: <eb98644a-aff0-4188-924f-6ca64e99b2a4@linaro.org>
Date: Thu, 29 Feb 2024 13:32:20 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 17/22] hw/intc/arm_gicv3: Add NMI handling CPU
 interface registers
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240229131039.1868904-1-ruanjinjie@huawei.com>
 <20240229131039.1868904-18-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240229131039.1868904-18-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 2/29/24 03:10, Jinjie Ruan via wrote:
> +static uint64_t icv_nmiar1_read(CPUARMState *env, const ARMCPRegInfo *ri)
> +{
> +    /* todo */
> +    uint64_t intid = INTID_SPURIOUS;
> +    return intid;
> +}

You're going to need to fill this in.

It's like icv_iar_read() but only affects irqs with superpriority.


r~

