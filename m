Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F894C531DC
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 05:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgHCK-0000dN-RK; Tue, 20 Aug 2024 01:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgHCK-0000cQ-4Y
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 01:14:24 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgHCI-0008SU-Im
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 01:14:23 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-70d316f0060so4071069b3a.1
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 22:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724130861; x=1724735661; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H9fF/c4KbgwoZm/T9VXqc0FPD6oAUh2tvZ84BOAmvRE=;
 b=UmibYS20h5PeNMUkQiE820H/zDWGCTYf3ZRAoPkykQ1j26cHdr1IMDrLvbST82QHve
 sOutrG65sKPZHrqIYGYck5BMR4lIOf/SFf2/LHant+fXsFT59a4lXFAENGSiW+xsUrbA
 LWmmOJssxZuB5sjImgnbdCCYnHSI2NXS6pbi1nOL0GQ5kqd1Wdto+CbWdMwQgUJSgjaT
 OI7KBCT3hmiEj0hJeKX7CZV3JGXiCw62ZCVxhqeNUj4NiFWSKWx/bVvjaUnduBkvNRz4
 z0TXXTQlrcQMJe8PmACbth46I8lFEA35JdKVegqsUU+AmjdpmWIAcfQJu16EhnRl5IM7
 0ayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724130861; x=1724735661;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H9fF/c4KbgwoZm/T9VXqc0FPD6oAUh2tvZ84BOAmvRE=;
 b=K8lX8FpsnwwDnIa0izeUy3LctJ33VtBLWYPMzLW0AkZzDiA9I7fi/CQd8ZTNzburzG
 Z9UbLn59XN7G5XreWhdmnrbJJvn65OKAh+J36+nj0aX6D4APg845Xv+ZkPmxVbdVIjLJ
 Wwx2i3jQWyRNgGcJ6jFeApO1tmaSlSVUdE6rc2r/Bif6T3ZltQqtyFg2luJt777nJKDI
 9Wbm6QnnK5lQuAkXmfuwPg8oCQ5SzNulYx+cXyNCgasctVNwFdj7oZ6HoeW/78KgF5nF
 KzdfiJ2loNKpPBq52wsECfJ8DNseC3pIQwJWg4PushAHqbZR0AIYXB88Tj+rsWInbilw
 /T3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZBLwN1uE0Ik86g4Yg9dmlrUZryXbgr7TeaqDQItfln8cYeTA0N8nGRGYM1n6xNrEMwItZmJa0ufgSjQn6AgtsP5kowFA=
X-Gm-Message-State: AOJu0YzUejF0+rchkaFiFqhkgnh0P8OGEQ0Gi8wOtnx0AJVvgZUnaDUI
 1oJ2ZzY816TNzETO4+3jVAr6/dz1KPfRJH0utLZDpyQLmMJF2abfv619Tc33VLE=
X-Google-Smtp-Source: AGHT+IH3k+tucXoVjbp4QpeBy+LWpBTDihbcNenTtcWE07tSp7HmFvL16Z5xb1Jt/4GUyoN9Qks8mA==
X-Received: by 2002:a05:6a20:841c:b0:1c6:b364:dbdd with SMTP id
 adf61e73a8af0-1cac6ff6b7dmr2951762637.8.1724130860686; 
 Mon, 19 Aug 2024 22:14:20 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.3.188])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-714023a326fsm1330602b3a.77.2024.08.19.22.14.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Aug 2024 22:14:20 -0700 (PDT)
Message-ID: <26cfd876-70d3-4942-9498-8435863df76c@linaro.org>
Date: Tue, 20 Aug 2024 15:14:13 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/15] tcg/riscv: Add support for basic vector opcodes
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240813113436.831-1-zhiwei_liu@linux.alibaba.com>
 <20240813113436.831-9-zhiwei_liu@linux.alibaba.com>
 <b325f636-c337-4fbd-b5da-c08b8978da15@linaro.org>
 <c3d0e2bf-9e5b-40ce-9acd-73f10f06913c@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <c3d0e2bf-9e5b-40ce-9acd-73f10f06913c@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/20/24 11:57, LIU Zhiwei wrote:
> 
> On 2024/8/14 17:17, Richard Henderson wrote:
>> On 8/13/24 21:34, LIU Zhiwei wrote:
>>> +    OPC_VADD_VV = 0x57 | V_OPIVV,
>>> +    OPC_VSUB_VV = 0x8000057 | V_OPIVV,
>>> +    OPC_VAND_VV = 0x24000057 | V_OPIVV,
>>> +    OPC_VOR_VV = 0x28000057 | V_OPIVV,
>>> +    OPC_VXOR_VV = 0x2c000057 | V_OPIVV,
>>
>> Immediate operand variants to be handled as a follow-up?
> Do you mean VXOR_VI? We use vxor.vi for not_vec already in patch 10.

Yes, and you match the 5-bit signed operand in patch 9.
All that is required is to put the two together here.


r~

