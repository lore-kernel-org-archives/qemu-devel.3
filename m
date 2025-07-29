Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAD5C83F26
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 07:11:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugeUh-0005c8-DY; Tue, 29 Jul 2025 03:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugeUf-0005bG-OW
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 03:11:25 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugeUe-00043Q-25
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 03:11:25 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4563a57f947so2268055e9.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 00:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753773081; x=1754377881; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3n8Q/FWvXU48hzdGE0lTPBuMDpimpoj0YAlsli//xEs=;
 b=d4KEzKFpQs2CU6uxDpc9mMuEwZetlD0+bA1onCxRiWHGbpAjQyy3gis65h8RgMbG6m
 rCh5BV/m9y63bby0XUkg8qPYmuIVaTC9EtPAluUXV/6rlJYet9Bdz1Q6sDogRwy6jnhj
 PVUDrnccZV/t9gx4nqSvk5TH0lYm38p4m/SzlmP2oaTBejZcVPoluuYyKo7IUXxxDuZl
 dZxoPnK5xoF13/VFyuxfk5HzM4sVYXxaFodRrJ2pSjMcLHr0+TXPN+EmTO9zodbuM0DT
 gXOXQ8tQKBeS1r3FIKApxb2dnnTub2P8NKUXx398HRz6g0OYCnwAljKrdTQUjUt1fNcB
 UaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753773081; x=1754377881;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3n8Q/FWvXU48hzdGE0lTPBuMDpimpoj0YAlsli//xEs=;
 b=ut7mYl+/2CdchxhXDr6QhVn3ABtgzd+pyVSC2OKqrgiOQVSMaLLLrj+3+HJXbo8bwo
 HhE+S/SYz3atTBVCTEtVwOtZOixMVHB5P8gFdVV+b2amWvR+RROqf/TDT/IlD+8UgaIZ
 kdc4VfVhFsobNsMoFLULj3J5Xz5SS3ld7OiqWkLAv8HPyZFIz3elLnRiyHILomdU+WiU
 ewYxI9vd61BypjndwIMz5Fm/b1Qz53z2CLtzUIIvZS8uL5w5gF1pLbYVvaSf00jshswK
 jKuYltU+7+HUNIV49VBWTNic9NipArJXzNw11VOXEeZnMRyDkXu+T+CDXltFiraaIXLl
 oExA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8V7yMUY64JFerp03bFIDymbfocfr9k2izrZFg1NH3++vZFMbk5jD7Lde1b7i5c/fDxLcmtgoNla9b@nongnu.org
X-Gm-Message-State: AOJu0Yyy/dK1oKHD8J/sP79D5dktBNlCjfH33PCVzlec/1NNKIP2Sn7g
 nSTUDhU+MP5TX7K2Ksd4adnLMLGsHtYSZoykJ540jKMjqAqyy+vGuPln8zFVq43kGrs=
X-Gm-Gg: ASbGncu9vZa5UOvzLZmRtNnsbZjsmUebPY0zsd6VVYacoYg4HNQhunB1u+XSPliDIwa
 OD2RuX6C1a2K4zF1eLOkkq2VkIvWIB7T2ZxBQLMZkGzPyBE2nPW8+J4n2Gp0M0Ozbk7qH3x7Nmx
 5Ms3IVbcuJ4GPE/1yd5JxkALk7yxj7hGanzS7GzxETsobmG01SmA4ouPG1YaTK/fYyd8GaUZwI3
 EqaO2udfRm1r3JhaVnW6wxJSbHTcc36nQBHGE2sug/QxBzOZRyMGwrZUPRMG9sRXKDubZ37gG2m
 6FOEkmG1pZ2vDFZymx1CnNUmgHjdNRzA3iQpfmb1iaxmLzCnQC8fhKOCSnqHAxy6mhnGb1W9N82
 UQ9IQmPfbFbkS81u0su60KyU4eZF94+/M0F5oH6vk6nr7lOc0GOD8IM7frepHOaN7SQ==
X-Google-Smtp-Source: AGHT+IHdSRJ4knEIExJN0lVEFOmbH8F8KS6lkxRaM9aHz1YuKvSq1e/f0wnr7p/uFH5sW09Yfpus7Q==
X-Received: by 2002:a05:600c:5493:b0:456:18e:eb7f with SMTP id
 5b1f17b1804b1-4588d110499mr18642445e9.3.1753773081460; 
 Tue, 29 Jul 2025 00:11:21 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458705bcbfbsm189080045e9.16.2025.07.29.00.11.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jul 2025 00:11:20 -0700 (PDT)
Message-ID: <18da82d6-39e1-4dc1-848e-b64cf40e0d49@linaro.org>
Date: Tue, 29 Jul 2025 09:11:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/i386: Define enum X86ASIdx for x86's address
 spaces
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Kirill Martynov <stdcalllevi@yandex-team.ru>,
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250729054023.1668443-1-xiaoyao.li@intel.com>
 <20250729054023.1668443-3-xiaoyao.li@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250729054023.1668443-3-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 29/7/25 07:40, Xiaoyao Li wrote:
> Like ARM defines ARMASIdx, do the same to define X86ASIdx as enum. So
> that it's more clear what index 0 is for memory and index 1 is for SMM.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>   accel/kvm/kvm-all.c              | 2 +-
>   target/i386/cpu.h                | 5 +++++
>   target/i386/kvm/kvm-cpu.c        | 2 +-
>   target/i386/kvm/kvm.c            | 4 ++--
>   target/i386/tcg/system/tcg-cpu.c | 4 ++--
>   5 files changed, 11 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


