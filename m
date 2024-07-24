Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CABD3C3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 10:15:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWZ1S-0007bf-9b; Wed, 24 Jul 2024 06:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWZ1Q-0007aI-9q
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 06:15:00 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWZ1O-000318-HU
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 06:15:00 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3d9e233873aso3179801b6e.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 03:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721816097; x=1722420897; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bA0hhaLu9ChI2mMyne82iUilmamAUGj29iNlKn/cseM=;
 b=fNn0O4Fqr1xSgwFtljS/XNc0p3MQcOZ6smB94UnPzw6uDq1A/WDRHhDopzYnHXwhFA
 7o0xK0KQmou4D7D9HgC+8nAjXLLJ+lyoXT/+9N1OvuDkLtrqIPA7fnUp9o2oIcQ6D/BE
 8gvY/qWM9402GGzQ62qLdkVEeMYfxgF4mTK93mx7jyXvSxHdHAJkEGCieXOo0y0MiiR8
 F9jUJRzL4xGeRCpKO6j4BSnRzoIcA0KHaE/OUqpezsGATDyM0JcahMmxVbnxTfHDSzt/
 5L5x+BYOgngvfI/ONaD/Yi2SspZbIHvmruX9OMDJCuGR3wtait0cdoToZZwOSA7fNGbF
 pTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721816097; x=1722420897;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bA0hhaLu9ChI2mMyne82iUilmamAUGj29iNlKn/cseM=;
 b=qx6iUIRay1JauXoDqddErc+gSRK1aKDupte3o0Be4Y/cVUfsXgTVAvWUPLOT0yXXp2
 3OKpGKDlpB5P5Cyic7ckyquki0AALt3KJK8SbfMswJFINq6p3bAtGd0FC8kuR/SkGkyH
 4+E+F7FyLUL0xJS6w6RUaUiCgMztlthfX9dnW+AAp7qcYia7cV5TlIV3pI3ziUprwRMq
 7Axz72OjksXJyexOoiRBNmV2gbw6C7D/i4mrGgeBS62MVCi8K5T9gbxwhFYPUzljqhOm
 N+jrMFjUqTJqrfs06HxRwtXRr4kNxLNHmOZTlV4Pj2gY9VfiU27x3qAcfO0hi8lrDufW
 Yh1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQRrf+qCM334AaufcRCaJGMT2JlehMND5aQNyMLTcfCr9oVci7XLykHYdm/uFgnfbaxWToRdTeG18PqJqnmjBDSHsnc3s=
X-Gm-Message-State: AOJu0YyY9IMcZ2MhAVCGnQpvzZOVAPFZep1hLXwmFWPP7v2HybgC+zr3
 eneRSUM5mJmHVE4UTyIlqRAc+USacDue2g2zzM5kZAQp2RN1ATd0Eze81ZgfIm4=
X-Google-Smtp-Source: AGHT+IE76oE+ef9pMRWdoR7Q1mnIPiKWTuf/CnNl86Wj2KtR038j6eoTjEV7OPiltdh68IeVeyfM5g==
X-Received: by 2002:a05:6870:8292:b0:25d:ff4c:bc64 with SMTP id
 586e51a60fabf-2648764e7b5mr2873751fac.6.1721816096570; 
 Wed, 24 Jul 2024 03:14:56 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70d1c5902bdsm5763591b3a.146.2024.07.24.03.14.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jul 2024 03:14:56 -0700 (PDT)
Message-ID: <707d1076-4f29-4089-b7ae-0bdd3e1305ee@linaro.org>
Date: Wed, 24 Jul 2024 20:14:49 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] gdbstub: Use specific MMU index when probing MTE
 addresses
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 philmd@linaro.org, alex.bennee@linaro.org
Cc: peter.maydell@linaro.org
References: <20240722160709.1677430-1-gustavo.romero@linaro.org>
 <20240722160709.1677430-2-gustavo.romero@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240722160709.1677430-2-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x229.google.com
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

On 7/23/24 02:07, Gustavo Romero wrote:
> +    /* Find out the current translation regime for probe. */
> +    mmu_index = arm_mmu_idx(env) & ARM_MMU_IDX_COREIDX_MASK;

The official interface is cpu_mmu_index().

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

