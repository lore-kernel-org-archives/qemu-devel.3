Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C67C54E49
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Mar 2024 18:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjNXZ-0007OJ-Uk; Sun, 10 Mar 2024 14:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rjNXY-0007L3-00
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 14:04:52 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rjNXW-0006vY-I5
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 14:04:51 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-53fa455cd94so3207012a12.2
 for <qemu-devel@nongnu.org>; Sun, 10 Mar 2024 11:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710093889; x=1710698689; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NoGCf3sBLegSWxypsL2KaF58hSmbQznCl+fHLZDt8Ls=;
 b=oH5SihdeCr6B4vyu5sq2Y5AEjXGYqZ4amg4XnQFmQtYuBrECB42xzAev1fDmhzwrMf
 Nr+vXj+YO+PBZ1ylwfoZCinUwWAg4wMXl9pa8Ry5wrjP9Ls5aBzNCkmTGCpSXtPAArnC
 NY8OEWXk8l8vfPdK15+WOGcVc39waB49QU8lMmVjlleUQmH7W1VOsLxqfC7HY1IwqMeU
 Y3Bb1klvQ30WC6expciXH4pONRZ7oKCxSNi5wtpoimNGtiGvGDippanFNXucPNP5n7xw
 3W4YeWtjTdERAdViQ2s+NzgauDx76HpU6NDVuzb6q3bonjIAZpgCfXwYJ5yxrFmcfPe+
 P2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710093889; x=1710698689;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NoGCf3sBLegSWxypsL2KaF58hSmbQznCl+fHLZDt8Ls=;
 b=svEykjVHWOTLkDikJguocMjOjd9bw/Vsl0AgdzJ1yBNGniRWNW4zHBoZDgNS8vXNuo
 Kq8e3mLYR5wUr3c/VS7Nft0InWlJyX6Y3Wb7Hg1TYt2kK+ghXCaatgprf2nwBgFCNlbn
 81L2SuK9fy72dMVHGAjWGATM1d6UYGZY9J44A19kgKqaEVNT+cjmgcYzZyzJ9tNP02VU
 x+axPKGH0Qj3gXBM/wgfJs1YN8Eu8YCnzF2Au2STTi5aKwgNYitGfOKaLY1+M6e/jeWI
 o6yzDLddFbbytZUqgg7Q9jjqIvFR1IiaAXnwHvDKBz7ShZrJuSQkweCFQi1eF9ENcWL+
 LSyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPTOZiJxKw0n55r177YaaWIPBi79nV8q2UZwsDOXQfkcf4ElcJDyzAfvB3TmNsIwOJHNnnR3OkujIlBa9r6QI6Dun05F0=
X-Gm-Message-State: AOJu0YwpBdZdsRkFsJ3B2+zsdbnI7BiMUmPa9wi2XSEU3skqC+1AQnCZ
 30ssiaJSU6cDnGKg9eLHYdkbqg+etBXj0c+A6uUNtaqP5ciw/0fVn465XwgyZQs=
X-Google-Smtp-Source: AGHT+IE8fQTqfpeJrV4JqHTaOD6Fq61j2HGzj/sqgxZrzr+QTnx2cC8dwqZpSyzCN1KHucpo7aaPoA==
X-Received: by 2002:a17:903:1206:b0:1dd:76f0:4455 with SMTP id
 l6-20020a170903120600b001dd76f04455mr4884680plh.49.1710093888772; 
 Sun, 10 Mar 2024 11:04:48 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 x4-20020a170902a38400b001dd63e22484sm3004874pla.135.2024.03.10.11.04.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Mar 2024 11:04:48 -0700 (PDT)
Message-ID: <f8b57cb7-75d2-4153-81e5-d82554c6a311@linaro.org>
Date: Sun, 10 Mar 2024 08:04:44 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 09/10] target/riscv: Clear vstart_qe_zero flag
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 philmd@linaro.org, Ivan Klokov <ivan.klokov@syntacore.com>
References: <20240309204347.174251-1-dbarboza@ventanamicro.com>
 <20240309204347.174251-10-dbarboza@ventanamicro.com>
 <a3765207-28bb-44fd-b207-58327516a6cc@linaro.org>
 <93e34ed6-9876-4a1c-897b-b0bc59831a01@ventanamicro.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <93e34ed6-9876-4a1c-897b-b0bc59831a01@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

On 3/10/24 00:17, Daniel Henrique Barboza wrote:
> 
> 
> On 3/10/24 04:47, Richard Henderson wrote:
>> On 3/9/24 10:43, Daniel Henrique Barboza wrote:
>>> From: Ivan Klokov <ivan.klokov@syntacore.com>
>>>
>>> The vstart_qe_zero flag is set at the beginning of the translation
>>
>> Here and subject, s/qe/ne/.
> 
> Hmmmm  ... the flag name is correct - vstart_qe_zero.

Gah.  My mistake in pointing out the mistake, which is "qe" not "eq".


r~

