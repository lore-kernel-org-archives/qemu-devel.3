Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37614CCD194
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 10:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqrhL-0001OH-RG; Wed, 18 Sep 2024 06:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sqrhJ-0001MV-OZ
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 06:14:09 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sqrhI-0000zn-52
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 06:14:09 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a8d6ac24a3bso121970466b.1
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 03:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726654446; x=1727259246; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JBHx0JQUQDQqxiq3UgNPe+t/f4kRFZSysAsotUj2TYQ=;
 b=LsfdJOxkf2/7n4WjaJseVbrLgwmbjL9PD02pQmyKppogGPkDPOJnkVp1+X23TfyXV7
 OAzV2xjUfHyhMDt6UxHWRwwHjpbsQ066vpH405mbqup0Ukxe8ClkVFOZbIGdBfy692wn
 hJZTpMa29GPx2wt4KxlmI+oE0z7UaP5zqy5CctCcZOtCC8HhWzJNKOzvAmvVsaL0oUVr
 Dk9WHARWunQ8wwB3ClrFd9ze6kSRrD9rM435Szg3h5F6tSpS8S5dHrUgbA5YBeNMRGZz
 pp2MiXX6SAkhtgVpyFoe3DtOnFWLW5h6+hLSy5wdj2rGGLz9wqu8z9/jMW6iZwXSTDmU
 54tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726654446; x=1727259246;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JBHx0JQUQDQqxiq3UgNPe+t/f4kRFZSysAsotUj2TYQ=;
 b=T/Gp0TVvQeLkYDmtioNJCVFlT10Oq6r0/lEa1vxdsYjlDGwL6qI3V67Xv2uNeIwWJH
 bdfkalCA9hENRVmboWu1rX3+4t5vnGATbA9Q2Qd1L7dOlCPZdy7tWr+rLxbjyF90I7x0
 tFX0xc1FPHYN78ch66D/4teRo1tMG7fuIFhxhh7mX3vWaDns5m8ewkg1SHLLybzjPEDo
 m6beToTTp0T8qjdmaxNfy2WJz5r9SxaGWLWEKKv4RFHAIsf/GhekGIzxApCAsMXk3sPL
 OoLtkGPQ2nkJKnqpoUU2QP4quKWAiLIwQ5C+HZ9PwYyMT/uBit8rmPDRo/U+B+s11fo5
 5b5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCULF8FBPF3KjnA2t4Aami6w9Cz4psnDgiKSanX9geCOdcdhUQBbBUNHCHDn3aqcQ3hfo395PAY619zl@nongnu.org
X-Gm-Message-State: AOJu0YxKwhkz3kdgDtRPNe7kf/7NAmjMSKuU9bYe6we4VN6rCxUvfo4B
 1z63wEfFSB7qT9DFHSKmhIeiRNPYx7MpzbvOV3bZD9UyVSZSu1MthGTanEehX3I=
X-Google-Smtp-Source: AGHT+IHwTcWtZJ+u/tP7Wwen/869aGIlZUfxF/CJ0Pw7Y4ZWiB3Vc23yZxDcDvgK3RYQ7aVNik1mhQ==
X-Received: by 2002:a17:907:e8e:b0:a8d:4954:c209 with SMTP id
 a640c23a62f3a-a8ffae0018emr2809119366b.22.1726654446091; 
 Wed, 18 Sep 2024 03:14:06 -0700 (PDT)
Received: from [10.133.7.245] ([83.68.141.146])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a906109628fsm567969466b.6.2024.09.18.03.14.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Sep 2024 03:14:05 -0700 (PDT)
Message-ID: <90585496-ee96-4d33-8bd3-92eb9b151ac0@linaro.org>
Date: Wed, 18 Sep 2024 12:14:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/12] util: Add RISC-V vector extension probe in
 cpuinfo
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240911132630.461-1-zhiwei_liu@linux.alibaba.com>
 <20240911132630.461-2-zhiwei_liu@linux.alibaba.com>
 <6c97e5d3-75a9-4884-8a6f-6498dfc5b12d@linaro.org>
 <0f3b7593-5963-40e4-9c4b-010081aa3b9a@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <0f3b7593-5963-40e4-9c4b-010081aa3b9a@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62f.google.com
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

On 9/18/24 07:14, LIU Zhiwei wrote:
> 
> On 2024/9/12 2:34, Richard Henderson wrote:
>> On 9/11/24 06:26, LIU Zhiwei wrote:
>>> While the compiler doesn't support RISCV_HWPROBE_EXT_ZVE64X,
>>> we use RISCV_HWPROBE_IMA_V instead.
>>
>> Language is incorrect here.  The compiler has nothing to do with it.
>> Perhaps "If the installed kernel header files do not support...".
> OK. Thanks.
>>
>> However, if you use only RISCV_HWPROBE_IMA_V, then you do not have any of the additional 
>> guarantees of Zve64x.
> 
> IMHO, RISCV_HWPROBE_IMA_V is more strictly constrainted than RISCV_HWPROBE_EXT_ZVE64X.
> At least in current QEMU implemenation, the V vector extension depends on the Zve64d 
> extension.

Ok.  That is a better explanation for the patch description.


r~

