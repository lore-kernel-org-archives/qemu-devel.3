Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A47A6C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 10:38:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBXjx-0003Zn-7J; Mon, 27 May 2024 06:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBXju-0003ZC-Gu
 for qemu-devel@nongnu.org; Mon, 27 May 2024 06:38:03 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBXjs-0007gk-Tj
 for qemu-devel@nongnu.org; Mon, 27 May 2024 06:38:02 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4210c9d1df6so17787875e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 03:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716806279; x=1717411079; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N7pG08FIIfcXRHsfMeUjpGjVEDg5uGIFPgxIe0gMGw4=;
 b=bbnEX+WCZc87zXjctDmqrDdLOLQ4ARHUeYbkaXPH+89oLCtMrTQN1Cpl8k1kLvn7GE
 P+AZ1ehmIWYOLEkjOO+DQCplSqNMDRKbYzpE0USyC/l53N+wVmyrkxcI6pjJTMuP+X3b
 f93u4bSzcUUcjPD9Z1QvMuu/cqJZuupbGy796Cl9YRhnfrQ4L2+bYpBGFyjrGk2HMDbh
 86WhTkHPDZPodbHFW0Xe1QnxX2rPdqKsOva+u0nk7ryYlDez8jCq56Pq3dM2Q++UEVhX
 rsNPO1HcKAKKEoU435sxuLg0RuHfchOe4VXj4SAUBXwEhim41WexS1pASNaYmHOSNiJq
 8Jdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716806279; x=1717411079;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N7pG08FIIfcXRHsfMeUjpGjVEDg5uGIFPgxIe0gMGw4=;
 b=FO186g+CtNHgoKvrztfZK3LLF4NRIPcbPCes8sjVUXRDUlRaa6knYBq+LdY1lglz0G
 dKxoVX24+UZ9Ar5taMVLDqkwtYg3ql4wYgrVHOhsJtkrWsvc6M3ZZN9xleXCUWJRNagv
 Ft/DDByc3RvUuzW9ZDMHDaJ7ECronv+AxfXkFgU0IqdnEParQ0nxzV3MudJ4pxH+WLcF
 VY5iKTs9/duYOZBIVBx2XUqcHv3zgcQfC0+nYpeATQt7kldxNAAdX7RR2a4OPWHSeAbn
 Oher8SB063NQY/XU/o3L4JFDC6Wghk8j9OwOZC9PNBOJhbzq3CXeVTofn51i3CiJnT0b
 D4wQ==
X-Gm-Message-State: AOJu0YyznHtedVnW7CFYZsctj/H6a+/VWzYL/JlmcwX1KqVnNDfUBoJQ
 x3+yY3Ju7Y/jiwfNZFoBoLjCuS4V5DDe1Fdfpa8TVlqi4XyMmuXt8K+N5jdcMx8Lv4NkQwVOVms
 Kcr8=
X-Google-Smtp-Source: AGHT+IGDxACxOKlQ/s+eH18te9ob3QNWM9yxK3R+3rvr9GubMAaEpOt8NH27vczpX8EWhvCyvVV8vQ==
X-Received: by 2002:a05:600c:1387:b0:420:e88b:6fb3 with SMTP id
 5b1f17b1804b1-42108964ad6mr61114465e9.0.1716806278744; 
 Mon, 27 May 2024 03:37:58 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.152.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-421089ae976sm104823435e9.38.2024.05.27.03.37.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 03:37:58 -0700 (PDT)
Message-ID: <40cad008-6959-495c-97c0-978c0868bf86@linaro.org>
Date: Mon, 27 May 2024 12:37:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 1/2] target/loongarch: Add loongson binary translation
 feature
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20240527083501.844854-1-maobibo@loongson.cn>
 <20240527083501.844854-2-maobibo@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240527083501.844854-2-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Hi Bibo,

On 27/5/24 10:35, Bibo Mao wrote:
> Loongson Binary Translation (LBT) is used to accelerate binary
> translation, which contains 4 scratch registers (scr0 to scr3), x86/ARM
> eflags (eflags) and x87 fpu stack pointer (ftop).
> 
> Now LBT feature is added in kvm mode, not supported in TCG mode since
> it is not emulated. There are two feature flags such as forced_features
> and default_features for each vcpu, the real feature is still in cpucfg.
> Flag forced_features is parsed from command line, default_features is
> parsed from cpu type.
> 
> Flag forced_features has higher priority than flag default_features,
> default_features will be used if there is no command line option for LBT
> feature. If the feature is not supported with KVM host, it reports error
> and exits if forced_features is set, else it disables feature and continues
> if default_features is set.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/cpu.c                | 69 +++++++++++++++++++++++++++
>   target/loongarch/cpu.h                | 12 +++++
>   target/loongarch/kvm/kvm.c            | 26 ++++++++++
>   target/loongarch/kvm/kvm_loongarch.h  | 16 +++++++
>   target/loongarch/loongarch-qmp-cmds.c |  2 +-
>   5 files changed, 124 insertions(+), 1 deletion(-)


> +static void loongarch_set_lbt(Object *obj, bool value, Error **errp)
> +{
> +    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
> +
> +    if (!kvm_enabled()) {

Either set errp, ...

> +        return;
> +    }
> +
> +    if (value) {
> +        /* Enable binary translation for all architectures */
> +        cpu->env.forced_features |= BIT_ULL(LOONGARCH_FEATURE_LBT);
> +    } else {
> +        /* Disable default features also */
> +        cpu->env.default_features &= ~BIT_ULL(LOONGARCH_FEATURE_LBT);
> +    }
> +}
> +
>   void loongarch_cpu_post_init(Object *obj)
>   {
>       object_property_add_bool(obj, "lsx", loongarch_get_lsx,
>                                loongarch_set_lsx);
>       object_property_add_bool(obj, "lasx", loongarch_get_lasx,
>                                loongarch_set_lasx);

... or only add the property if KVM is enabled:

    if (kvm_enabled()) {

> +    object_property_add_bool(obj, "lbt", loongarch_get_lbt,
> +                             loongarch_set_lbt);
>   }


