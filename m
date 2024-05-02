Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9EC7C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 12:15:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2VLO-0007sP-Hf; Thu, 02 May 2024 08:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1s2VL0-0007mK-1q
 for qemu-devel@nongnu.org; Thu, 02 May 2024 08:15:05 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1s2VKw-0001HH-62
 for qemu-devel@nongnu.org; Thu, 02 May 2024 08:14:56 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a52223e004dso865940866b.2
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 05:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714652088; x=1715256888; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=sSL3pGTMQlm7IP/X66VH7ZW6vD/svFwsuz+4xiwLQsQ=;
 b=rd0UvXF8idhqsYSBmqRX+brLfqxD3nBKIzYYuqxkcvmwuAYzFoAcnLxxPJNrEMw3gq
 RThaTS+tliv05zNyta5UyP68M/nin6mpLN71kbcAPYkn5sBgsP0P8xBdkEF+64XTDRU0
 XT7WNeeFtqLbz+lgOmfl3BNcssaVqfEQ0OpEZLPEwVPDuGtuy3EKvm/c7r2BAtRWzvKk
 pBQv78d0lVAxFCYqIMtSQV+cfDYuzsmy/TefvVXHoH8oknHcSe/CagpZ28ECGP4DiMvF
 WgYmwFUZ9QAAzHdUk4aVscgNICKQSXsFzITuKvUdJSdG6oCtii5LrEMxyBiz597YnNVf
 ZPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714652088; x=1715256888;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sSL3pGTMQlm7IP/X66VH7ZW6vD/svFwsuz+4xiwLQsQ=;
 b=p1ny91KQ7FKiVUsMJqKmY4FtrMav4lIYnmjGbp3dD5Cw6s6KcwycjUWfAPuDVptw9S
 bvEsGq2chMpY4zTS3MQeaScKqOVS3GJspfvlD8KuOxBPebWaa8SlrizB/i03DscgB1lH
 4FvZY5gJnVSp/LrSYd8iS3ty9AboPlnQYITwV2AsTpmuvWCjDkz/wbrMl1tYjYhipB7m
 eAk4tdUe5VIzZINQ/CbF0dtGVFINpL6ZkDionV/fYKqOnPVShd26FtmUgmGancecUSCE
 5GepyIdpBgHXkBedi8mL9TSYcMud06f2Bn+0QH5ziQvDqfkxyAi3Ikff5Y9xW6/eIK3t
 19bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXL60qy6VVE7qAtxWS1FDq8OUTl7gEc3nvD7Q/+MQaM1FMIzNAZ49dhm8MLFGBu8rYhYIZKe/fK1kHoXfiSsp8MJdSBvRg=
X-Gm-Message-State: AOJu0Yw1Ckg0ygjktGdxqQgy6anFdjwVssBr1zBpbhq5lsI+DdI/Mjf9
 iiCPhkP1AQmkF6EPJzNlk8vNW2Poe9Kqc2RREQ+UFV6DC4COI5Y79+JHmx29xzkCmZUKdmPtPHy
 xrD+n2Q==
X-Google-Smtp-Source: AGHT+IFrZ2SRXYWD78aiQRKBJohDDNX7VMLi1k1RpQOLHtmXt2qClo8dHgM163n4Er1Zrn7WJ5GXwA==
X-Received: by 2002:a17:906:640d:b0:a56:e555:3ea6 with SMTP id
 d13-20020a170906640d00b00a56e5553ea6mr1530689ejm.55.1714652088477; 
 Thu, 02 May 2024 05:14:48 -0700 (PDT)
Received: from [192.168.200.106] (83.11.37.15.ipv4.supernova.orange.pl.
 [83.11.37.15]) by smtp.gmail.com with ESMTPSA id
 hz18-20020a1709072cf200b00a597bd55982sm11984ejc.130.2024.05.02.05.14.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 05:14:47 -0700 (PDT)
Message-ID: <7c6f66bf-2610-494c-9389-b558a11f8c5f@linaro.org>
Date: Thu, 2 May 2024 14:14:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: fix MPIDR value for ARM CPUs with SMT
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20240419183135.12276-1-dorjoychy111@gmail.com>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Language: pl-PL, en-GB, en-HK
Organization: Linaro
In-Reply-To: <20240419183135.12276-1-dorjoychy111@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ej1-x630.google.com
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

W dniu 19.04.2024 o 20:31, Dorjoy Chowdhury pisze:
> -uint64_t arm_build_mp_affinity(int idx, uint8_t clustersz)
> +uint64_t arm_build_mp_affinity(ARMCPU *cpu, int idx, uint8_t clustersz)
>   {
> +    if (cpu->has_smt) {
> +        /*
> +         * Right now, the ARM CPUs with SMT supported by QEMU only have
> +         * one thread per core. So Aff0 is always 0.
> +         */
> +        uint32_t Aff2 = idx / clustersz;
> +        uint32_t Aff1 = idx % clustersz;
> +        uint32_t Aff0 = 0;
> +        return (Aff2 << ARM_AFF2_SHIFT) | (Aff1 << ARM_AFF1_SHIFT) | Aff0;
> +    }

Should "return" also have "(1 << 24) |" to have MT=1 set?

Otherwise MPIDR_EL1 = 0x000100 can mean core0 in cluster1 or core1 in 
cluster0.

Value 0x1000100 shows MT=1 so thread0 in core1 in cluster0.

