Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A165C3DA61
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 02:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWoU1-0000Fe-K7; Wed, 24 Jul 2024 22:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWoTy-0000EG-Ca
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 22:45:30 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWoTw-0002RO-AB
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 22:45:30 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1fc56fd4de1so3377285ad.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 19:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721875526; x=1722480326; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xe3QJDfxIAuoiRpyLObV4mXGxxOfU5mk7la8DjtIrrE=;
 b=l786cpgXbZbpoN8CFIUNI35xlvbUKPi2HPHrVutGI2E0ANA34KicnA0clqcZtzY10u
 AydPyvmuljrxbUW7lzB3SI66BxIUwie/m4razk2sNhw2pc0FRX+NezjlslVEIvmTZrUs
 f8buNflDCsB70ptIpNyvshG1PmIxOnXXJQoP+56I2CyYrFmhyrCBaLmutZAazNXatb5Z
 dp81t7IQAK7jkYoCc4ROfepksxuK+TYqTODv9kCp7JlrW5pWOGzzdoBGtyg0rXXm3pXt
 tvB5Dr6V9FduIojxboekAmO+yVBofr7rcgGs/WMf5sZZQFVNzfyjsmH0WQywEiU0t/as
 qCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721875526; x=1722480326;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xe3QJDfxIAuoiRpyLObV4mXGxxOfU5mk7la8DjtIrrE=;
 b=kRScwjDOrtLy2QZ2ZRvQ7XAuam0IYIsPNFxKT1hujKLD6RSgXxShOJW+DnGOsYf1K6
 NetW3OcWYUqySIKqMdVBoMFMampbhelRPBfMTASOkD/VJpb/Wwq3RjuT9xr9f/KnV2G7
 oIYj0kcwPwdN4YsHgVgue4JHogwfENcAG6L6V8Ew6n19400cGURqz+FiujPNsoTXaoO5
 G3esLzjtqdvyM+7TwuYGsu3hKGvqH/cfz6STXzpBfD8Q81Jr+rWvSOzfYEEZTO7ldnJr
 S15FWRwx8dwM6quwqDpUafGdx6tDDSrSRn/0gdkLg/bkGbjWeGuMeoP6kYsYa2e9mBaB
 +rLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtuw9jMKE0fsPLO1fVeJvripzNaUuzvpedgB4R9zCQdFp2R+7gybIRW1rfiF7qz95TjZjY68GKyt5hLW5wa1Bxd+zzIjY=
X-Gm-Message-State: AOJu0YyiQIcw1ZVDCPvxtM4tK0WhKwHt5+NAs4nD7/g6bn/DIMHoAvbl
 qh7eVv9+AseGYbDgJsmjWtW+3YrMurQM6ABs3A7TYCDR1ajiYCYsL3b48XOX/hk=
X-Google-Smtp-Source: AGHT+IFtvUcnYGi3Fuuhlwp510LTZuZSOtxCJAVpZzQjmLw+vw+5uXpQFrfyyQ2daGy8qnr6d2Efkg==
X-Received: by 2002:a17:902:e842:b0:1fd:7432:16c8 with SMTP id
 d9443c01a7336-1fdd6d897ffmr61978675ad.10.1721875526022; 
 Wed, 24 Jul 2024 19:45:26 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7ca8fd5sm2904695ad.64.2024.07.24.19.45.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jul 2024 19:45:25 -0700 (PDT)
Message-ID: <1c82060a-4352-497b-818e-767c1ceb73df@linaro.org>
Date: Thu, 25 Jul 2024 12:45:18 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] target/riscv: Remove redundant insn length check for
 zama16b
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com
References: <20240723013012.1443-1-zhiwei_liu@linux.alibaba.com>
 <dea63117-cabd-4669-bffd-e8c0cb8d9147@linaro.org>
 <df37fdc2-79c6-420c-bcf4-e7c3649fe446@linux.alibaba.com>
 <8d12202f-7170-4127-a1a6-c23c03835cf6@linaro.org>
 <5c34fb1a-ce46-4039-b887-9ea56488239b@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <5c34fb1a-ce46-4039-b887-9ea56488239b@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 7/24/24 16:32, LIU Zhiwei wrote:
>> However!  It does explicitly say "no more than MXLEN bits", which means that an RV32/ 
>> RV64 check is appropriate for FLD/FSD, since MXLEN may be less than 64.
> Yes.  That's true. Although I don't know why MXLEN is needed as F, D or Q don't depend on 
> MXLEN. We can implement D extension on RV32 CPU.

Implementation of D on RV32 does not mean that FLD/FST is atomic -- it can be implemented 
with two 32-bit loads/stores under the hood.


r~

