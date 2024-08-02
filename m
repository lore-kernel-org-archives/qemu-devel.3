Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0209CC52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 06:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZm3i-0007Tr-IH; Fri, 02 Aug 2024 02:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZm3g-0007La-G6
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 02:46:36 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZm3e-0005Eh-Ik
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 02:46:36 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1fc5296e214so62110245ad.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 23:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722581193; x=1723185993; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5tEoOLtfO6EowiYqIMtSauztx+dLNCR1F4Be6OplouY=;
 b=gyXfcVfVPS+TnNpwqz5Jk3QA3SwYWA7lo20xtUTxhRHsvPgmRPg5ZYcM/p9xx4ahzi
 EgAyBe9srcek4Vfs6vzErbaW/aGGFuYBAHKLUE22AA6YsxdrutzXlOEp17uB4Hjz2iho
 KwjrzvsZOzYVwM1HneIqdo9OWf510Ev78Evk7L1M57nx6NVt6pyuXeGJmgMtEPvHKMKx
 JHqalm/LRRqo5ZR5Gfnkw6SloenlPc+mSYdRhRJjmfLMUwGA6vi27+CgMdveWhHdCSxG
 PKR5FhWPrRgl0//DVsLxUyvzpqheeGrhTxPRBlbV4l+TatfZbWrtq/DB7Wb+0zzPhVP8
 Inrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722581193; x=1723185993;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5tEoOLtfO6EowiYqIMtSauztx+dLNCR1F4Be6OplouY=;
 b=Z7GKExr5kMzK7v8XsiqyaVO7o9XBSmxPNTO0l2CJMYZ0bIET8CSRYmVIevs58cvUB/
 RQ2YGuvYnozdCUN3YG/7xI4T8Srna17NRUI3LfjLEiE1NQnhqvVmJXQx4G2uFJlCjI4j
 1JA0cxayyZvdJvDPnzpROJfX5FwI0Sm34cq+t9sbVsR856Wrhys3M6IPsMHNTGKyc/iG
 wKcBhBxabxrUqCIQw/jMAYuhcj0TUf8X+iLDv3LgPpgB04OFbxSClzcwgmVc5E1c9xuv
 JOXI1G2egUb2Pma39M9pfDzqdF0p3C6UwQew70MJYnlKL/jFQgdRZDr/hLhqXO1AgcDj
 4JgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoS/X37WAjLAQqHly0W4kvO/pvUAi4svOcvhkMYH92t0g3MmrGa9+an8Fly5TWejTBuduaRES02VitSWJt6N5aZCjKMbI=
X-Gm-Message-State: AOJu0Yx+dUh6XAxpYUu/nvbDlXxtEcRcKbPD6n3DJLU0Y54lwXghoLbK
 8YrtIzD6lUFPmizDj3nBlb8W8NwidGh1ol/XVXWTs3fpamoU9F07xgbkJZSBLqE=
X-Google-Smtp-Source: AGHT+IHUKPKvIXK/G7k4bbMqAZRSBqW+izjRjMkPXqaZi+z98f8NLKDMFU7RTblaqv9f6JNaA4ZWiw==
X-Received: by 2002:a17:903:191:b0:1fb:9b91:d7be with SMTP id
 d9443c01a7336-1ff57250de0mr33106385ad.9.1722581192924; 
 Thu, 01 Aug 2024 23:46:32 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff58f53416sm9791385ad.101.2024.08.01.23.46.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 23:46:32 -0700 (PDT)
Message-ID: <e59ce92a-b8ef-4ddc-b385-14ae89db02e2@linaro.org>
Date: Fri, 2 Aug 2024 16:46:26 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] target/riscv: Add MXLEN check for F/D/Q applies to
 zama16b
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com
References: <20240802031612.604-1-zhiwei_liu@linux.alibaba.com>
 <20240802031612.604-3-zhiwei_liu@linux.alibaba.com>
 <e565894d-8378-4dbe-92ef-afd54d864810@linaro.org>
 <84313f06-fae5-471e-b218-2640554f6c46@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <84313f06-fae5-471e-b218-2640554f6c46@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 8/2/24 16:42, LIU Zhiwei wrote:
> 
> On 2024/8/2 13:47, Richard Henderson wrote:
>> On 8/2/24 13:16, LIU Zhiwei wrote:
>>> Zama16b loads and stores of no more than MXLEN bits defined in the F, D, and Q
>>> extensions.
>>>
>>> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
>>> ---
>>>   target/riscv/insn_trans/trans_rvd.c.inc | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/target/riscv/insn_trans/trans_rvd.c.inc b/target/riscv/insn_trans/ 
>>> trans_rvd.c.inc
>>> index 2be037930a..dbe508c7e0 100644
>>> --- a/target/riscv/insn_trans/trans_rvd.c.inc
>>> +++ b/target/riscv/insn_trans/trans_rvd.c.inc
>>> @@ -52,7 +52,7 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
>>>        * in the F, D, and Q extensions. Otherwise, it falls through to default
>>>        * MO_ATOM_IFALIGN.
>>>        */
>>> -    if ((ctx->xl >= MXL_RV64) && (ctx->cfg_ptr->ext_zama16b)) {
>>> +    if ((ctx->misa_mxl_max >= MXL_RV64) && ctx->cfg_ptr->ext_zama16b) {
>>>           memop |= MO_ATOM_WITHIN16;
>>>       }
>>>   @@ -72,7 +72,7 @@ static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
>>>       REQUIRE_FPU;
>>>       REQUIRE_EXT(ctx, RVD);
>>>   -    if (ctx->cfg_ptr->ext_zama16b) {
>>> +    if ((ctx->misa_mxl_max >= MXL_RV64) && ctx->cfg_ptr->ext_zama16b) {
>>>           memop |= MO_ATOM_WITHIN16;
>>>       }
>>
>> I guess this is ok, because MXL cannot currently be changed. But since that is a 
>> possible future enhancement, perhaps add a get_mxl(ctx) accessor anyway, for 
>> documentation purposes.
> Can we use the existing get_xl_max(ctx) instead of adding a new get_mxl(ctx).

Yes, that looks fine.
That could be renamed get_mxl.  :-)


r~

