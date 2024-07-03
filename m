Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F1CC30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 16:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP3Ae-0000n7-V0; Wed, 03 Jul 2024 12:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sP3Ab-0000lw-PQ
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 12:49:25 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sP3AZ-0007Kx-9w
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 12:49:25 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5b53bb4bebaso3047774eaf.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 09:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720025362; x=1720630162; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OZp0Bii4nRJJoiyitJmwEFgcORMHGq6abJNjwLzuGmA=;
 b=H0uCFANUyRqwXknb1nNCp9GslRHKLhKLpBphlDJx027pdbclZ+HUmdGEifEBWDo7Cm
 9rzLu13f1YAfv+DBCNqgsN8AkR6tk/alUumZrF2cnhNkGDTo2V3iuJClSMDxYCDxg3/4
 JrCB2vl8OrCgGwTpeJ9pyj5mWIyJoayRztK7cGUz+7OQMnAJ8J8Yh1kfEGb+z78MKvF5
 g8Aer3lFnDX4W7dGNBwgPr+WUK6aBgv8/Sb4NZdyQIz2c9ZJn+ye94zEdv3h+FCnWLSr
 mjCUh286wRUEMF9/tzUomkRZbQ8T9eXcIFbYZCkPmjJbkDmbAH+14KK2I1SFN9aSixo7
 /eag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720025362; x=1720630162;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OZp0Bii4nRJJoiyitJmwEFgcORMHGq6abJNjwLzuGmA=;
 b=McNwlHh6V/wXghFzFG+gKytRCP81aLXFRBEDt0FYTyRcPLyTl5vF6yUdNrLZTjKLTl
 lGnNhwX+24cTXOiv89hrfDZGQnF3937fFWtnHDPBRNLCMwbfMx040nm+ERJblQClQSX/
 gOoQD6ZDz+zLVG9/kTQFZFQT1dBxICW5gzKM2/M36OLzHkmnYRNkwZKc4pxq15MRSUpu
 GpqpV+Arlt5QL7te3hwpfZOZAxiZJhlIniG0vR94tunliyskU6HEdoFq2sCROFA/qesS
 81MPcV68YKCFxK2EpdQRr9Xe4VaZYCAijgGs8Xwlr9861pt/XnH8hVDW7Km1CHJe5HIw
 hb+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYyjL6CNIQbUZiVCZq4Qq5dUAAhQapiGAPVtuuIzCHNgY8OmhL3bzYR4eGn0kc6dqY8QyNYSa1aQ6cWc3vlAoZQaRHQuA=
X-Gm-Message-State: AOJu0YzSB6udEu0rLkyGMo82fQZ4bgNpu1dzwIix0d/xUfOscZtb2yH5
 Kf4UhqiATHp93buFPGF1TTA7VuKMdEWrdBj9JYtPuIidmunzlUUTNx7aKrMjGPI=
X-Google-Smtp-Source: AGHT+IFjAgCnhzNLn4UbzI8IyMyzP+hXwMCcRERWC3zA8eIghrLSLPIC/70wN/03a4SAO3XIzxKPYw==
X-Received: by 2002:a05:6871:412:b0:25e:e09:786d with SMTP id
 586e51a60fabf-25e0e098fc9mr2065015fac.53.1720025361845; 
 Wed, 03 Jul 2024 09:49:21 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70801e54b97sm11009730b3a.16.2024.07.03.09.49.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 09:49:21 -0700 (PDT)
Message-ID: <9611f0a9-ac9b-4250-b60d-677694f331b1@linaro.org>
Date: Wed, 3 Jul 2024 09:49:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] target/riscv: Correct mcause/scause bit width for
 RV32 in RV64 QEMU
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240703144921.1281-1-zhiwei_liu@linux.alibaba.com>
 <20240703144921.1281-6-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240703144921.1281-6-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc30.google.com
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

On 7/3/24 07:49, LIU Zhiwei wrote:
> +        sxlen = 16UL << riscv_cpu_sxl(env);

As before, drop UL.


r~

