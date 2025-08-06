Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE4DC87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 11:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujcDe-0000sa-VC; Wed, 06 Aug 2025 07:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujcDH-0000dn-MR
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 07:21:45 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujcDG-0006gw-5n
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 07:21:43 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3b78127c5d1so3905246f8f.3
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 04:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754479300; x=1755084100; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NeONzXVcpGLWC773oWhdvssn0MHhWt4lmYUy/kVuZFE=;
 b=mijXWHXyqbmkjmTvzl3RMkkatfReWMTC1jOYV4vsp7A4KSE/PAGyf0gvPFbgsZGk5a
 1u2kniSECDK8WtWW4UDuR/+80RsURo5vOAapusD9xxqvHJDYqSnA7/WrgLYOFUJWj/7L
 temI8nZunjvHV8iRQyrr7JP5qlfkaLnqDU5eG2shy5w9jri7mDsn3BnvM9hJZTAobLLF
 t9O7EHK3t5pnKUu4hkx7Gso0GH8xQWUQaVTfK0fXbTu32oaknNHid50T6m8DD6V9E0ZC
 i6AYXppxCNfD6ZgV7az9zw7HimHJt6Befpa9QtYLeYHm0d0oRxQLuX61biYOzzETb7sS
 v7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754479300; x=1755084100;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NeONzXVcpGLWC773oWhdvssn0MHhWt4lmYUy/kVuZFE=;
 b=dSBGuBlvJBTdLojaKqCyew8Y4UaAhpmSdHfsI4Ql3sMQt9uVTBCTZM52sRgYCCO+Ae
 XSjAig9jGbNmK9Ti+MyhbzQMtlZytNrndz1cs2s4cCFPO4hcFe8CSQ3szWKP2Y/wqWRF
 ll3t9j7hGYlqJ65G2KA3f+QegkhuUlYSjifY+dz9DSHxtRDmrgkfMt9g7O7Z0yYcoxL4
 QJp83GiGoVJju9wBBN+G7eKLCQMqAIANBkVeNH2kEeGnXNNU+7ir7U78TtwG35p6gCrM
 q2g/YF85Krte+E2tEAJdEXNFYIY2XwjGuy1Lyg4DdzrDFR0fzKogDt8st85viMG7A/5C
 g0Og==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXqwib/5slBTufTO8KcexSpkRq3gE6cJ9stNTaj9sVnpvg+hwL3MQGCraVLSenycndI33bJI24Nlhx@nongnu.org
X-Gm-Message-State: AOJu0YwblkFsp9okzO2xxmXD4MPoPBqtC7KsW2OVaeZRq6/imJrE6oNR
 OBESgOTUIJea//0WHrqmpdfn+OY63Ce3Onbfh2K1UtaVY2UffSzktmsoNUNC37X0Cyo=
X-Gm-Gg: ASbGncvcapQ/wOkvsX+HfudRM/k9ST8GhlYhDgM/dCr8SGZQ4xy2GAn28i16SroFr4G
 /T7lpyBcY2v5w2YdhhpS+onK2ZQb9WGlQvDKcg97L2Na1s5JO3R3ERaflhoweww9e83kdlmK2W7
 +ko3XRatFczssSoutnCqp6LgQA+NUoSYlwC/BnNIzR903Luj4G63pXd8pgg3V7V3s6N2XYSL7tl
 mdTxYrPtUpOkCr3AmJPRVStHDrwStA725sCy1UfjEG0vKBtiwH+sj9KdM4sutXra6vKiy9bx1fm
 mMF8lKpyqnJWQDCNm+Y++b5uxiAddqKeStFvIXD/sVtdCFlaGZMir+EW1/ckuKuzlEWAehjjtSg
 hPupURqimlfg8UjGr+vyfMkCrUC+aO9tg/YAWg7Rb2JxoZWAUura0bLihEjPesDE2xA==
X-Google-Smtp-Source: AGHT+IHeGNx8BTdME2A4MoKHpIl//6W4DW5/qMlf8En9lPUDcGKaUrtVgyufmMtQZlDiSJiW5ZuIeA==
X-Received: by 2002:a05:6000:24c6:b0:3b8:d1a4:bab9 with SMTP id
 ffacd0b85a97d-3b8f41f3109mr2066663f8f.45.1754479300381; 
 Wed, 06 Aug 2025 04:21:40 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3bc12csm23149635f8f.28.2025.08.06.04.21.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Aug 2025 04:21:39 -0700 (PDT)
Message-ID: <9a445a3b-df8d-4cfd-8561-5295ad6fd30b@linaro.org>
Date: Wed, 6 Aug 2025 13:21:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/13] hvf: gate ARM_FEATURE_PMU register emulation
 behind not being at EL2
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Igor Mammedov
 <imammedo@redhat.com>, qemu-arm@nongnu.org, Alexander Graf
 <agraf@csgraf.de>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Cameron Esfahani <dirty@apple.com>
References: <20250728134114.77545-1-mohamed@unpredictable.fr>
 <20250728134114.77545-12-mohamed@unpredictable.fr>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250728134114.77545-12-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 28/7/25 15:41, Mohamed Mediouni wrote:
>  From Apple documentation:
> 
>> When EL2 is disabled, PMU register accesses trigger "Trapped MSR, MRS, or
>> System Instruction" exceptions. When this happens, hv_vcpu_run() returns, and the
>>  hv_vcpu_exit_t object contains the information about this exception.
> 
>> When EL2 is enabled, the handling of PMU register accesses is determined by the PMUVer
>> field of ID_AA64DFR0_EL1 register.
>> If the PMUVer field value is zero or is invalid, PMU register accesses generate "Undefined"
>> exceptions, which are sent to the guest.
>> If the PMUVer field value is non-zero and valid, PMU register accesses are emulated by the framework.
>> The ID_AA64DFR0_EL1 register can be modified via hv_vcpu_set_sys_reg API.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   target/arm/hvf/hvf.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


