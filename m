Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E10BC3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 19:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX4bX-0003DK-Tu; Thu, 25 Jul 2024 15:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sX4bN-0003AP-FV
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 15:58:14 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sX4bH-0002jG-KZ
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 15:58:13 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42802de6f59so9399455e9.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 12:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721937485; x=1722542285; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=08E/n+GUDqaYs2L55EuvfBFjhi4NdHbtQbAAEoYvT6M=;
 b=G9vRTx+oFJwiANa49eFQy9pljnekkZkFLRo9NT4nPbxjUybrbUMpj6ODMLmDuU8ni2
 T97Uu+UDHizjxC7AXfh3yKI9IiF1w1LFx0fe4/FZUv6ESYqvvNMC/k3zF6bIR8blL59p
 jslYrSIqjVnTv61fyEr9OmZ1KQ9p4U/eq54s83vzVmJ5anaPQ58GTAHbc1NFTxf/62M3
 hl4PjNYMVKLmZb0/EcDQ/+3CZ+o4/cQxAiCdjYL8tswq99Se+b3IYde1O+34qf9MwAHM
 +grdsEi2P6dk7ESZx3tCg0tsSo8ptURvZeluIvt8vSXMu05M+oEuId0VZie7JdDmFTur
 //8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721937485; x=1722542285;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=08E/n+GUDqaYs2L55EuvfBFjhi4NdHbtQbAAEoYvT6M=;
 b=NYiEIEa5H8I/D8+ODKwW0xJWYSwKaGLmmI6Qc1ItLCiqtEjM+DSkU6CCsYwxng9hQN
 2CIXLNYNKodZ0s4M9dy9TK9zf3CekOex9ugPoZUHYQcsMk3RFrY/8OLO4/bkcNDrhnG9
 848pLIfbL8w/PnlwsOjtZhfDMWFmf1p9BoAkX3qx/1EQkA3YwbzP6VCS/I0ZU3zc5mPM
 5XKGN4ookuYs0X2pRRsWYm8hFNZS02RVwolnDPAAQs94jD7gmku17M13EFtqQLsgiI7d
 q7aajw56lJPTKbkL3UYfCJ/QkA7EQ3Cb2EqVjY+pgLnjy9Th6SgkTzjzSBv9xWwAF1GB
 MmJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUL68bVxP1uDbOkEuJd/PL0m6b6r+0AC7mUDHPT4uv5M5XUUFpHtmWgAGe3UVvNPbkvHcKFBwFL/hMKOmHvgMaxuK+6z6s=
X-Gm-Message-State: AOJu0YyP/T3Rt46PYB4/VEBINNLt3T5dPpDVb14SFMbmk3KcDCV7c1YN
 0JVCmm0+1JjwXCoEwdqhe0xfiIVPDaHGCw19apnl0yoiTcx4iNb0iPzrTZ+PsVI=
X-Google-Smtp-Source: AGHT+IGMyU0f9+kVFbmISeNr7L1KMhVjswFa5Qjbq5K58etVaEKUuWrg1ZkLWj10yVr8YEY0lIc+hg==
X-Received: by 2002:a05:600c:3549:b0:427:faa6:5648 with SMTP id
 5b1f17b1804b1-4280550c3cbmr22056595e9.3.1721937484732; 
 Thu, 25 Jul 2024 12:58:04 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.216.35])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f1f52b8dsm78004675e9.1.2024.07.25.12.58.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jul 2024 12:58:04 -0700 (PDT)
Message-ID: <3601c8e8-4e45-4e91-9ed0-ea57ed8f90da@linaro.org>
Date: Thu, 25 Jul 2024 21:57:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/kvm/kvm-all: Fixes the missing break in vCPU unpark
 logic
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, peter.maydell@linaro.org
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, richard.henderson@linaro.org, imammedo@redhat.com,
 andrew.jones@linux.dev, david@redhat.com, eric.auger@redhat.com,
 oliver.upton@linux.dev, pbonzini@redhat.com, will@kernel.org,
 gshan@redhat.com, rafael@kernel.org, alex.bennee@linaro.org,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 karl.heubaum@oracle.com, miguel.luis@oracle.com, salil.mehta@opnsrc.net,
 zhukeqian1@huawei.com, wangxiongfeng2@huawei.com, wangyanan55@huawei.com,
 jiakernel2@gmail.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 npiggin@gmail.com, harshpb@linux.ibm.com, linuxarm@huawei.com
References: <20240725145132.99355-1-salil.mehta@huawei.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240725145132.99355-1-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 25/7/24 16:51, Salil Mehta wrote:
> Loop should exit prematurely on successfully finding out the parked vCPU (struct
> KVMParkedVcpu) in the 'struct KVMState' maintained 'kvm_parked_vcpus' list of
> parked vCPUs.
> 
> Fixes: Coverity CID 1558552
> Fixes: 08c3286822 ("accel/kvm: Extract common KVM vCPU {creation,parking} code")
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Message-ID: <CAFEAcA-3_d1c7XSXWkFubD-LsW5c5i95e6xxV09r2C9yGtzcdA@mail.gmail.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   accel/kvm/kvm-all.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


