Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 310A8C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 18:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC1MX-0002MD-CQ; Tue, 28 May 2024 14:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC1MU-0002Ld-GN
 for qemu-devel@nongnu.org; Tue, 28 May 2024 14:15:51 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC1MN-0001Yk-MZ
 for qemu-devel@nongnu.org; Tue, 28 May 2024 14:15:50 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-70109d34a16so962275b3a.2
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 11:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716920142; x=1717524942; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2Lx3NmyUMqPCFI58sSraM2uGDNvT04DJM9Ku9isZcWE=;
 b=w6YNy50KLCASEam9MGxpfi/HPSgOSH0l3aoT2GufuLEIMGuWDG5TnrNA5YsTdxMXkz
 hsYlkHUSp2W8bm56CELl5E26qgU1lmR/ppfNWWuYk1u+TKNbZJaxLxEWhr1qzqk2kfOd
 x2qFjzcXoyGoSg1aZckI/t61sM9WmxsxWolLqSouEM+xlvQ1VNw4zPYOEAoY90W3vpt3
 5446ooflR04F3yRzrV0PAqCHKZOUsrWpNV3AwC93UipjJt3W19vlz01RmQOvaY3eCwGL
 u39/h1OGmp+U3gCGAQE7zfdaFMbD9MFiXhbaHF9++BTh0Hg5Z5ahBmZGfu6EBWX2MOOx
 m0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716920142; x=1717524942;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2Lx3NmyUMqPCFI58sSraM2uGDNvT04DJM9Ku9isZcWE=;
 b=c9LDK/QEiSKisrBzCNZWEVmjs3YjM3vSEtOfDf0OcvOnxyR8Vas+C6dEVG4uUSQWJH
 GjCsbOzASm/vymvQhJbJKeCMqMg2WEfmZ36FoXKiCD0fhvIqwRc1/33Tl9My7rbyMi2V
 pbjxkZHvxm2jij+YDK4zJ6YZ+RBH4xBy4rSJyvip+ZaJM4B2XXCWGq2rszR0nw5AQm8Q
 42G1W8PMpFUfLpTBFSB6X4xuf61Bzt+E5ciCLjFSHiIFdMeLMkP3UGmlQmqX28OdWLc1
 u8JG071ldcQeg+vMffVHoaOe7XzJFbWUCW0/y7ogPMGdF1f914ziokvpbWO/3JEKrTYg
 QFiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJsl59xrTtrUblw11951F1DJ/vw9Uwh/Hm4hrlMWtQrcNH9nX0Sfb4s1ymv1AGgQpvxdX/vgr4pq1XhWfqN4kYj4C/iF8=
X-Gm-Message-State: AOJu0YzqZSdSatEV15Oxv6bI//5Zv48xuaHHKAY9U/7MVoxqzsYdxhtv
 M5ZC7b6bgoV9w9qj+trCD69+AJqN5SFADOUGAZ/7Ry6E9aR7Xr2K5syqQ8ur9vo=
X-Google-Smtp-Source: AGHT+IG0n5iZlW1FhNEPDlmv5tAO2lP1kjI4hsIl1EgLNvWjaGo/3fLh3uAo0iSnchjEf/D7B0jTHw==
X-Received: by 2002:a05:6a21:3383:b0:1af:d95d:98e with SMTP id
 adf61e73a8af0-1b212d45624mr15937566637.29.1716920141944; 
 Tue, 28 May 2024 11:15:41 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fcbeaa98sm6711125b3a.128.2024.05.28.11.15.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 11:15:41 -0700 (PDT)
Message-ID: <6babb1e3-d8af-437d-b832-946bb1bd5985@linaro.org>
Date: Tue, 28 May 2024 11:15:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] accel: Restrict TCG plugin (un)registration to TCG
 accel
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240528145953.65398-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240528145953.65398-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 5/28/24 07:59, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (6):
>    system/runstate: Remove unused 'qemu/plugin.h' header
>    accel/tcg: Move common declarations to 'internal-common.h'
>    accel: Clarify accel_cpu_common_[un]realize() use unassigned vCPU
>    accel: Introduce accel_cpu_common_[un]realize_assigned() handlers
>    accel: Restrict TCG plugin (un)registration to TCG accel
>    accel/tcg: Move qemu_plugin_vcpu_init__async() to plugins/

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

