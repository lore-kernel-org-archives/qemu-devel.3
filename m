Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DE6C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 13:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOziz-0000Rk-1M; Wed, 03 Jul 2024 09:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOzix-0000RI-QD
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 09:08:39 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOziu-0001XR-OB
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 09:08:39 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-36786081ac8so938406f8f.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 06:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720012115; x=1720616915; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MR11Ftgzu+iAn24XxK8Z3rVKsH115yKZTN0muXx4JzM=;
 b=EfcwyUHW7oU4CCWneofZXmn0k8hCFw8QgCuuG1bpomX2Vf7Nu6C1eQgHaxjIZBeL6P
 LQvzKdcXVMF+yovcJBf8MTKm5cZCz1qV+xRNPKen7seuFSP7ivPEIpMEPDyn0Ol3Obdl
 oIPVJ9Fo1h/swpBypD5vB1tQ4/BUfA3TL6E98fQi0GcY8xqN6NNHy5j7WptcpcAVQr3P
 GFwxjE6AqGNWvSghbrKLaFT5WNGs9vHBKq/Qn9Dfx7AubE+CjL3I8tRgu189N2d4DY6F
 Jedg5kwIheTEyf1GiNS+hGUT9OS5aqo4HPCTupZ4ydjq1lbzZd75MeP0SMinqYsJ7WPW
 HZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720012115; x=1720616915;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MR11Ftgzu+iAn24XxK8Z3rVKsH115yKZTN0muXx4JzM=;
 b=geAKGVA/8tJxwIeoH7w+s6CEC3O+F+h1mu7MOk681OhFBn1D0hFiHmFea0+WwOMlSl
 O6RTxv/uqCqd/QYbYYY8OnD5R5HhVCiN1ba01uvCM2d/NVixJ7zjXIbqa134gASXLpDr
 t0nrwAXRHSelCg5RCmIJGXL8iZOjydXFUc17oCOYUAMCoAu85MTEaZ+GBB+4Ahj31xti
 swWBK99ai8lY4TKNW26ulxmW5gplAzTdXp4OqhKtl0J6efhe2U5cMawVvetC0Ej61A3h
 5Lb+1twGfca3uhIkcJ3SPUfnWoPYHE4/9KufA8m/0HtCW4+mrDnFaaXdIxXuzczBB0RX
 dXcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQZS2o2Zg49b5MqME9vUQYZSym04+D2aXLAtiKSNiIpb8mLsJDTnvxbLNJF/czSdtYFrQ2mb6H7wdGP684nbNvV8YZNTM=
X-Gm-Message-State: AOJu0YxRfq0NVDUjlYjzVEV6cjOAwtH4QRMbHxjnEzB0ol3z2k6iouHu
 MWlYxEZ7bW/OXZggcWjoH0NXSDMZ+55aP0Y1gM/OCUH/y5CwX04wQUcXj59kiiU=
X-Google-Smtp-Source: AGHT+IG9CXE8gNzzYcT4g7F00sJ4ycLmH0kKqzZYVJKhNxnZMrIbCFJhDAE/5Be16oPhw1ou/xApLQ==
X-Received: by 2002:a05:6000:400c:b0:364:d2b6:4520 with SMTP id
 ffacd0b85a97d-367756233bbmr11254567f8f.0.1720012114906; 
 Wed, 03 Jul 2024 06:08:34 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.220.97])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36790a40391sm2278984f8f.54.2024.07.03.06.08.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 06:08:34 -0700 (PDT)
Message-ID: <41c74f3c-eaac-47aa-ae63-b89f6b322d96@linaro.org>
Date: Wed, 3 Jul 2024 15:08:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] target/riscv: Expose RV32 cpu to RV64 QEMU
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240703123449.1108-1-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240703123449.1108-1-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Hi,

On 3/7/24 14:34, LIU Zhiwei wrote:
> From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
> 
> This patch set aims to expose 32-bit RISC-V cpu to RV64 QEMU. Thus
> qemu-system-riscv64 can directly boot a RV32 Linux.
> 
> This patch set has been tested with 6.9.0 Linux Image.
> And add an avocado test in tests/avocado.
> 
> v2:
>    Remove the line that was inadvertently left in PATCH v1 4/6.
>    Add an avocado test.
> 
> v1:
>    https://mail.gnu.org/archive/html/qemu-riscv/2024-06/msg00501.html
> 
> TANG Tiancheng (7):
>    target/riscv: Add fw_dynamic_info32 for booting RV32 OpenSBI
>    target/riscv: Adjust PMP size for no-MMU RV64 QEMU running RV32
>    target/riscv: Correct SXL return value for RV32 in RV64 QEMU
>    target/riscv: Detect sxl to set bit width for RV32 in RV64
>    target/riscv: Correct mcause/scause bit width for RV32 in RV64 QEMU
>    target/riscv: Enable RV32 CPU support in RV64 QEMU
>    tests/avocado: Add an avocado test for riscv64

On what is that based? It fails when applying:

Applying: target/riscv: Add fw_dynamic_info32 for booting RV32 OpenSBI
Applying: target/riscv: Adjust PMP size for no-MMU RV64 QEMU running RV32
Applying: target/riscv: Correct SXL return value for RV32 in RV64 QEMU
Applying: target/riscv: Detect sxl to set bit width for RV32 in RV64
Applying: target/riscv: Correct mcause/scause bit width for RV32 in RV64 
QEMU
Applying: target/riscv: Enable RV32 CPU support in RV64 QEMU
Patch failed at 0006 target/riscv: Enable RV32 CPU support in RV64 QEMU
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
error: patch failed: configs/targets/riscv64-softmmu.mak:1
error: configs/targets/riscv64-softmmu.mak: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch


