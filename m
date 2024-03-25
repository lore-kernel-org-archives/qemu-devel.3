Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 566F9C54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 09:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rogb6-0004C8-OU; Mon, 25 Mar 2024 05:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rogb4-00047j-Tn
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 05:26:26 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rogb3-0004iO-E0
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 05:26:26 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-341cf77b86dso415735f8f.2
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 02:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711358784; x=1711963584; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LypfqdL3ZK459FC/ggZtK9UslnChOjSoSlLouV3UHZc=;
 b=mrECIv8HqcdXPiChjm0gt+HrKt8Va8oVSAqDQqh2CpQWYx8iZJxENNgGJYy51e1NEE
 V2Ocay8odpEGoqxpmJ+rQMskkH+PgwPHJ0bO7lvuoIUGt+ChnBlnuf2YwTW64an9SPN3
 kle3rREmZuz/4OytZ9IsBA/NuEY33eEMewJtWGmkcJq4uknczvHR5q0ACZuRho6noyq2
 1iCbVOY9DhuwkfeaKnqERQOTZY99hJm4jlG88/99d9zL8w+XAgf1mgnGP9Oo0hiZXkmG
 cdQ66cg7j8pIPR/iufdpk92bMWYKcEXlwTiZlqv64EVT+ntPXcnZEwgZayj1ZXm/XTVW
 NxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711358784; x=1711963584;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LypfqdL3ZK459FC/ggZtK9UslnChOjSoSlLouV3UHZc=;
 b=tlAJH8263NxyiO5PeD/8xSKmj1Kn+TuuwtnwYyVVtoPyozehUQvIMuOfP3TYtSQHH3
 SpMTxb3qzu0eIg9WKptAlCq0egi/1VaiB6t757HCkQJtwRMW6TxeHgo00wi1XYBOu3d1
 d5HvE6D7EVOeuQB+Lw3BmgU4g22RJp6tdRgopFpRD+cWtOMEyElFy0gjcolTjS7PTNtw
 MW4bWOpK0UudWvd2/GNCxb0bDre3omIRBYKxejXo73ZDqIOtVHQhySv0Ewl3fBejkwc6
 5/OUu/sM9/cfZsiy2CkL8PDNQC8YEeTxxgR5+FBQP5uLB4RFr1Cnq8QSwO5Q3W9jS8PK
 h81w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMJzOVLLg9t/V+LhCP9h7h/78nrcow3bdi2aTOjw4eCmiVSor6GAm8sUcEHhnt9Lv3VI16oXpOmLe6VVeehHVfAX3He/A=
X-Gm-Message-State: AOJu0YwCDGAh6UM705a/0myZQplF10gGpRY6t5Sg0hdL2ppHEGoj+x6o
 MJkbSYocIFR/J7jwuw87SdUzAycfY0l+PrQkTk2PACGGUbtFsZgcaOL3xzcAdF2p0kEtataJCHu
 GV1I=
X-Google-Smtp-Source: AGHT+IHkE2f/YxvFVNMFvEu0t4Uyn6QY88oFCNjECcrJiPMahrBh6dqYKx9EXOc1x9WvYsD3MfYihQ==
X-Received: by 2002:adf:a395:0:b0:33e:9dd3:5998 with SMTP id
 l21-20020adfa395000000b0033e9dd35998mr5600987wrb.49.1711358783836; 
 Mon, 25 Mar 2024 02:26:23 -0700 (PDT)
Received: from [192.168.163.175] (237.red-88-29-182.dynamicip.rima-tde.net.
 [88.29.182.237]) by smtp.gmail.com with ESMTPSA id
 ch9-20020a5d5d09000000b00341c6778171sm4614864wrb.83.2024.03.25.02.26.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Mar 2024 02:26:23 -0700 (PDT)
Message-ID: <992d3094-0983-4731-a6d7-5253b065d581@linaro.org>
Date: Mon, 25 Mar 2024 10:26:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/26] KVM: remove kvm_arch_cpu_check_are_resettable
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com, michael.roth@amd.com, david@redhat.com
References: <20240322181116.1228416-1-pbonzini@redhat.com>
 <20240322181116.1228416-14-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240322181116.1228416-14-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 22/3/24 19:11, Paolo Bonzini wrote:
> Board reset requires writing a fresh CPU state.  As far as KVM is
> concerned, the only thing that blocks reset is that CPU state is
> encrypted; therefore, kvm_cpus_are_resettable() can simply check
> if that is the case.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/sysemu/kvm.h       | 10 ----------
>   accel/kvm/kvm-accel-ops.c  |  2 +-
>   accel/kvm/kvm-all.c        |  5 -----
>   target/arm/kvm.c           |  5 -----
>   target/i386/kvm/kvm.c      |  5 -----
>   target/loongarch/kvm/kvm.c |  5 -----
>   target/mips/kvm.c          |  5 -----
>   target/ppc/kvm.c           |  5 -----
>   target/riscv/kvm/kvm-cpu.c |  5 -----
>   target/s390x/kvm/kvm.c     |  5 -----
>   10 files changed, 1 insertion(+), 51 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


