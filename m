Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A97C27C4F
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2024 17:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNbrP-0005xl-Iw; Sat, 29 Jun 2024 13:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNbrO-0005xS-5a
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 13:27:38 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNbrM-00043o-LY
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 13:27:37 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2c901185d73so1956984a91.0
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2024 10:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719682055; x=1720286855; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3kWmdhjmCZKSz2j5dEsN40l/UWaacFCAkC7GnSoRnPc=;
 b=Pl58Tbne8yEJFK+ovgqYlwzDCCdr3SSO8WMSOoEpTZHU8i0RUPN6Gs6SQHnobDg9Nl
 x6JdbI2ez5WOqbbmoNW8E/75z+s4bvWyu7IJM/7ToLFMipJzR8/XDpnMIcfnuD/EoLiB
 n8H+KhOZI8o+E0HChCGUdEBfayj5KyX2Ndyea/qgmL00b27DSZvFyADo2xTLt0vqkV2l
 HAUyfMQ05XOmCo0UY1TsMX+vVX9SQW5+BE9uAke5ZJ7kFHZrRsN8OyU9NTqWa2h7Oiaz
 bR/n2iw+YwuBlxA8LKnNvVJVxI5ymUho8ByvrlqIrKLCvu91ZYRQSqRcH+kn2SeSjMen
 MpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719682055; x=1720286855;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3kWmdhjmCZKSz2j5dEsN40l/UWaacFCAkC7GnSoRnPc=;
 b=JevwO5PA0g1iLLE+cqFGz7AaCqiD8/JOff3OTc7qzLIPQLw/KZdmqaaKFmgnbTgh7+
 VBxC3Hpmp44BKoSTOUtnaXN6ayEQOwZIwMdF5pj91r78TCld6IghEzo5WzxzfmxtUTJd
 qCKwC6abIBSQ4sqpKwN6fnXkyAIKYboHTX/GAiGQJz0BM13E6XfOa+1PTX8c90ynUXxA
 6GB2zzLEwijk+37s2tzyRu97Cf60S/zGl1bE8dV5bAidRuKIX3MMb9GQs6KB2mXfuTo4
 jJ1XdgyO8+vPQjtSD/pjpAYAytabyCdmRE2EsFUzAUlVaBozPUreZ7/jWWEVKKP6V1zG
 yCNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqJjuKGPPjQIOmhyNwgO0yMqJNZsMAijQTvquJh3gRPU5Xa3s2Nt3UKZy2ODmsef+CJGGnQsJRgiLVysSSnR/2gaCCfZ0=
X-Gm-Message-State: AOJu0YxQX+JzVnasiWqqwb+anttnVpskWSpE8EedICEUu7LKIyU5OiRG
 0gbrU1C8ilEwzV78Nh4t8AiwrOPKAjeI3H2NoV2sdUocC4mNcrvRHPSxT/oqP/E=
X-Google-Smtp-Source: AGHT+IGI5fJJSxK6v/RRVQHDcDvnhYC5HWfKBkxbBPQm9NPLA9ktgzdF+ZNmf39tUsGfV+xPiW3Bcw==
X-Received: by 2002:a17:90b:4a0f:b0:2c3:2f5a:17d4 with SMTP id
 98e67ed59e1d1-2c93d185e2cmr2330333a91.4.1719682055007; 
 Sat, 29 Jun 2024 10:27:35 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91ce433c0sm3643452a91.16.2024.06.29.10.27.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Jun 2024 10:27:34 -0700 (PDT)
Message-ID: <c9fd8ce7-6c88-495f-8f43-917fc675743e@linaro.org>
Date: Sat, 29 Jun 2024 10:27:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] target/arm/kvm: Report PMU unavailability
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20240629-pmu-v1-0-7269123b88a4@daynix.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240629-pmu-v1-0-7269123b88a4@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 6/29/24 05:50, Akihiko Odaki wrote:
> Akihiko Odaki (3):
>        tests/arm-cpu-features: Do not assume PMU availability
>        target/arm: Always add pmu property
>        target/arm/kvm: Report PMU unavailability

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

