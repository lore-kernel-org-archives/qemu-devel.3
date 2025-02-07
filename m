Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7052FC02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 18:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgTRI-0007wx-Tb; Fri, 07 Feb 2025 13:50:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgTRH-0007wP-5F
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 13:50:55 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgTRF-00013p-E8
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 13:50:54 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21f0444b478so36889245ad.0
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 10:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738954252; x=1739559052; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ClFzQ7PCDwu5Ar2O509WOBBN9Z5B/IHbSallb/vMYQc=;
 b=NJLPeGyYCGQ3y4ErcCSYb0z6kd6DfSiphYok43KtOibZX2SgtMZPN8rweWGpVItUx+
 +W/kpiUwgoV+hS+H4XsIjfN1LauSzduWwM5qn3cgLFKtvoHls0upEomHxHFvIQNDqWSY
 agISVQRQ2+uc6BDM8K2SNxLSfQMHmIkhiv2GJ+fwd876kmLwVY426p0D3lGfaX6SVDyP
 EvYUMlkJmpTkSNGZrFJ1vtdrGdtfLJwd9fEJrcw6y8+HGXC6o7qK+26McrrbF3lDQyF/
 n/GYV6YQ0ToQEM4tcByZKZIZqXrw0ePlEA293oYNoSrfxRZ9a8kPuhUT3tdq8d99MANj
 Rwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738954252; x=1739559052;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ClFzQ7PCDwu5Ar2O509WOBBN9Z5B/IHbSallb/vMYQc=;
 b=ATE0QrrQoCBy/VF2f3ArAL11WztxlV96M9mlZndUvqJ7ooPDsyHCcRiwDNBXIvI0JU
 4r2fOlBIBdxk/6Hi7aPva3g6DW8tv9kht/lXh4twJmyOfbIP1WORjk1vWz8HN65oZW2e
 yVlqqCH5EgYk4tg6wyWc0frr+Zg4VO3AvyLoBb2EiSYTfPcHESg4scELw0InfNz8XzcU
 arBF6tS4WHo1mNecrwqJUqEovMOeo1KUqJLdSm3KjshqI4+KiVNUFSLa0Utlg7y8IGC+
 uGJ2kNzzY8+wOOZhkS2b6CTErzVgih+iNL08lg6My76UYBMOIikJj11WG28MZOtN3YUR
 EwAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnIPQ6ThE2yVK0Xci+Q83WvHBM2isSMN0sUy9S8e1uxFevLrKDu0zvdpmnJKtchT1xMPH0jW5IwfVz@nongnu.org
X-Gm-Message-State: AOJu0YwvRPR9T9lM9cNRcATVw5b4nxvLZJqdpGrU9YiHOxEGx57hCPwl
 edZEi+md4e1OqZ2pqrdJUsGl5z74A88UhME2JSAo0bR4vUJ4Q82AbVCMDBP/vts=
X-Gm-Gg: ASbGncubYOCMqM7/orh25wn2uusUMnwi2N/fUw6uodcyq2DSNxfx6lglzvZmn9yuZOW
 aJppIvalJW9wWwiP0khutdN6kDAhYXLBGbKCsdO7Lve2vNnZVZCRcnkjwFlrRlxzzge9zkbF/RY
 Pggqpxe7fesjJBekTNo02emiBuyZt4KuL9jYzL0YkiWWjener7jmr1HBrtJkU+KSMlrdT20kqAP
 GoXakepIjTz3CzGVyt68Neg1/TO2fFuxJkzlRBMH1PakZkPSt5lrHXORFPS0Vemkr5SfNZZ2vxE
 m2k3dIHF7kqesgWkHyrwOrEj9klSZykIIDUsZX+W4S5XN44nErW1248=
X-Google-Smtp-Source: AGHT+IFx3qX2cQp+Q9eBXyOEC/NAQTDbyj7HflA9TUhCXxbmP1q2CgGRY6AB2kSCZUzRBvIdtf4RCA==
X-Received: by 2002:a05:6a00:3e07:b0:72f:d50a:9096 with SMTP id
 d2e1a72fcca58-7305d44f5eemr8026145b3a.8.1738954252004; 
 Fri, 07 Feb 2025 10:50:52 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048c16222sm3412972b3a.135.2025.02.07.10.50.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2025 10:50:51 -0800 (PST)
Message-ID: <c06aee81-1802-405d-964d-c68b3147b294@linaro.org>
Date: Fri, 7 Feb 2025 10:50:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/15] arm/kvm: add accessors for storing host features
 into idregs
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev
References: <20250207110248.1580465-1-cohuck@redhat.com>
 <20250207110248.1580465-3-cohuck@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250207110248.1580465-3-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 2/7/25 03:02, Cornelia Huck wrote:
> +/* read a 32b sysreg value and store it in the idregs */
> +static int get_host_cpu_reg32(int fd, ARMHostCPUFeatures *ahcf, ARMSysRegs sysreg)
> +{
> +    int index = get_sysreg_idx(sysreg);
> +    uint64_t *reg;
> +    int ret;
> +
> +    if (index < 0) {
> +        return -ERANGE;
> +    }
> +    reg = &ahcf->isar.idregs[index];
> +    ret = read_sys_reg32(fd, (uint32_t *)reg, idregs_sysreg_to_kvm_reg(sysreg));
> +    return ret;
> +}
> +
> +/* read a 64b sysreg value and store it in the idregs */
> +static int get_host_cpu_reg64(int fd, ARMHostCPUFeatures *ahcf, ARMSysRegs sysreg)
> +{
> +    int index = get_sysreg_idx(sysreg);

Why pass the ARMSysRegs value instead of the ARMIDRegisterIdx value?

You save yourself a linear search over the id_register_sysreg array, and you can't use 
this interface with a sysreg that doesn't have an index anyway -- ERANGE is a new failure 
mode.


r~

