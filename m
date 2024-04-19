Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB085C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 06:56:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxi9y-0006oc-EU; Fri, 19 Apr 2024 02:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxi9u-0006nu-Ek
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 02:55:42 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxi9q-0003Mz-Ag
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 02:55:39 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-418effbc5d4so8257145e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 23:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713509737; x=1714114537; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=csp0o8vqss6n4IlofThfaNYbIqpMUyWiwBDccyMUJEE=;
 b=O/gqwaaWPKOCTThzUQ6CdREond1pr5+uoblCgPZIFNzGsI7Uj0J1zWlSv/gzzbiIiC
 GWMUmieT8erRLzeCO/HE1cLRlYR975mPwQzoco/S//9hBx6/pMSfqDF14rn4co3G1eVs
 5FOCviZGqCmslCZR42a4zmc6D0cAdt2STenfKDTHoAF645SilhyDnbEk7ugQTtkgM6I9
 kv7M9Z4ZtK6PdQXOeLB8oncvmxrJ8HkYrOl7gEgbpocOgrjQwSyEHgyNPl+upLutxFPB
 9yUVYrpNuWkLeRAazPLvRPAp8nyRnr/UoK8/k+wry5AZTS8wv50UzCbu6mJI+zfj46xD
 OsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713509737; x=1714114537;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=csp0o8vqss6n4IlofThfaNYbIqpMUyWiwBDccyMUJEE=;
 b=dS3EHebH3eVCtuHR00Qn1S3f6MfNLah7Dbrb5/T3kPdmJsyECGMpmpKZFzJ4be6y+C
 DQ7e+39BjQOCsvNWDTnzPnr0p1lzUfrdwzoodEZYnl0NU82BsKqnDFFz4YKJ48+scar1
 tXpOxyEJqVJ8rUao/aUgF6FpdVx8sz89g+To5TSPHtq4leoSHI808Sb95O38NDQxD3rf
 9RrBa+xPhiro5jLpQ0qEOQBn5OhDOuU+0vaqFg8u0/KlbOPWkD05CEFEL33A0qWwgVo5
 +A0fKyyRWxwYE8lKSsQVYgxEGSst5Ayq3RO1wzbkOoq8FpH6jJv7F+uJeG3iQZIMHMVM
 Lr3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXb3SWtDJJrlBIYBBLqWNYyjUy+uJNHIDKKFkUM78wW3dx+djA2sxMCjN9pJLLON7Hrw/m4t+cZIqEFL7TidcPtz7esIQo=
X-Gm-Message-State: AOJu0YzFCisWHgIZc+U3KXU66FNvPm+q8npNDAR2hOM4rVbhmlG3uqWw
 +E7sy+HNZxNK5ehdlCHeLCgjAzIwN9RkgRBwykq2mHlXFNvgjL7FZ2N7DcRMvYU=
X-Google-Smtp-Source: AGHT+IE6BvV3xELCaoQHJTLkzuUa8J8QUiT5w8PHRdPWhOSQQZAT/k8aUvYlzUVNWgLoJGXHSZtn3Q==
X-Received: by 2002:a05:600c:3108:b0:418:e964:605c with SMTP id
 g8-20020a05600c310800b00418e964605cmr761351wmo.40.1713509736728; 
 Thu, 18 Apr 2024 23:55:36 -0700 (PDT)
Received: from [192.168.235.175] (149.red-88-28-24.dynamicip.rima-tde.net.
 [88.28.24.149]) by smtp.gmail.com with ESMTPSA id
 n17-20020a05600c501100b00418f1d77098sm3684001wmr.25.2024.04.18.23.55.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 23:55:36 -0700 (PDT)
Message-ID: <61dca21b-576f-40d0-a155-e52111acb45a@linaro.org>
Date: Fri, 19 Apr 2024 08:55:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] target/s390x/cpu_models: Make
 kvm_s390_get_host_cpu_model() return boolean
To: Zhao Liu <zhao1.liu@linux.intel.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
References: <20240419065712.1225038-1-zhao1.liu@linux.intel.com>
 <20240419065712.1225038-4-zhao1.liu@linux.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240419065712.1225038-4-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 19/4/24 08:57, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> As error.h suggested, the best practice for callee is to return
> something to indicate success / failure.
> 
> So make kvm_s390_get_host_cpu_model() return boolean and check the
> returned boolean in get_max_cpu_model() instead of accessing @err.
> 
> Additionally, since now get_max_cpu_model() returns directly if
> kvm_s390_get_host_cpu_model() fills @err, so make
> kvm_s390_get_host_cpu_model() return true by default for the non-KVM
> case in target/s390x/cpu_models.h.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   target/s390x/cpu_models.c |  9 ++++-----
>   target/s390x/cpu_models.h |  5 +++--
>   target/s390x/kvm/kvm.c    | 13 +++++++------
>   3 files changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 052540a866ac..a0e4acb707d7 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -560,16 +560,15 @@ S390CPUModel *get_max_cpu_model(Error **errp)
>       }
>   
>       if (kvm_enabled()) {

Nitpicking, we could move @err declaration here:

           Error *err = NULL;

> -        kvm_s390_get_host_cpu_model(&max_model, &err);
> +        if (!kvm_s390_get_host_cpu_model(&max_model, &err)) {
> +            error_propagate(errp, err);
> +            return NULL;
> +        }
>       } else {
>           max_model.def = s390_find_cpu_def(QEMU_MAX_CPU_TYPE, QEMU_MAX_CPU_GEN,
>                                             QEMU_MAX_CPU_EC_GA, NULL);
>           bitmap_copy(max_model.features, qemu_max_cpu_feat, S390_FEAT_MAX);
>       }
> -    if (err) {
> -        error_propagate(errp, err);
> -        return NULL;
> -    }
>       cached = true;
>       return &max_model;
>   }


