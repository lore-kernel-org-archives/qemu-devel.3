Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B743DC54791
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Mar 2024 18:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjNe6-0000je-PU; Sun, 10 Mar 2024 14:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rjNe5-0000jJ-3W
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 14:11:37 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rjNe3-0008OP-KU
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 14:11:36 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6e4d48a5823so1687395b3a.1
 for <qemu-devel@nongnu.org>; Sun, 10 Mar 2024 11:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710094294; x=1710699094; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XfND68FBVFIdI4ZzMSHb1Ep3xpv6zc8EZZ1BvIFM8Gk=;
 b=Ovy/6tLbwGKjvkuX4/K24PcWt7L9tpwkSmQ7iCIj7r5g1Z8JHeALxoCqrdUcwi2Pbz
 snwg3TazT5SI8bH1g1Rp0q7F/OmdNPHafVLcSFSnXHnpzVyUvUW1uhegslyH95F55KhY
 2gRiD0MfZeNn/teyZpPgq8qI3cSsj3uFjX0sNJEoH8BTRT62pExRAlNK7p75pWWz4Rpn
 HtJVbqhGWKf4wLwJVxqLa+UdcJVzSoO1GoRCuciPp2I0skEqrwHYAE1wqvS90ZIKmwUR
 +iu7Oo/yvnYHFoXor9LcLCdvplqfG9P7mQUqTGoVC0jY9e6odpoJRi2wKIT7kcn+xNNi
 1Jqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710094294; x=1710699094;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XfND68FBVFIdI4ZzMSHb1Ep3xpv6zc8EZZ1BvIFM8Gk=;
 b=EedEYEdFTzGozDemx3eoDxAtMvcNFLG1VviTCtyokucBYG4rfMciXOArS2DbEUjd7Z
 M29a4RkXiIwvc2iCOI+/Xhf/iItSkd0su+5tok9ohxPPg7ZNurJzVXOCLVVFgiG8jlpK
 4etzbGCrHKbblj5rZB/7JSsmXXUQGo5kDpVRcQuJakEybPpEn22R6vFQxevfOv8Ix+Ik
 16Zvl+swMOt8mWnIfVVXf0rmU1/CFAuqpZybgFoaOnT491qmCz64Unch1BUalXtTbuHc
 /BvBc4MmvkMDA+Lfzcddv9wkVtj795wy904VyhcB29K8aPGp46CuQUP8iAmMt3d/foRW
 I2nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHU26tRrquWku5IbePhJRnTq1MAWXmYfGjY5BaC15s8z+bavCvTX9BzGkqiQhro/9pEXaRqbQ7dchJ5fpAKjPhrkkrG04=
X-Gm-Message-State: AOJu0YwoVe16ivtaIB9DpONynfv7VO34bWUpbiYLnGhtWWEIetm4U9h3
 SutVQi+aG+0luY1GMg4PtdGd/yKk4OMZNVwPP5GGpkemheu6RPiY0GTbadO6aoE=
X-Google-Smtp-Source: AGHT+IFsPpL6bEdz2s230T6r01WIvhRkEnOjMTMhz6R39l/o+3Z88ZBhzrRkmxbxJXqvXMrhoqn/fg==
X-Received: by 2002:a05:6a00:3cc8:b0:6e6:42ef:ed1b with SMTP id
 ln8-20020a056a003cc800b006e642efed1bmr5224475pfb.31.1710094294087; 
 Sun, 10 Mar 2024 11:11:34 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 r15-20020aa78b8f000000b006e64f75c947sm2786295pfd.46.2024.03.10.11.11.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Mar 2024 11:11:33 -0700 (PDT)
Message-ID: <b5e5cace-5b90-4576-ba2c-91d3ae86369f@ventanamicro.com>
Date: Sun, 10 Mar 2024 15:11:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 09/10] target/riscv: Clear vstart_qe_zero flag
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 philmd@linaro.org, Ivan Klokov <ivan.klokov@syntacore.com>
References: <20240309204347.174251-1-dbarboza@ventanamicro.com>
 <20240309204347.174251-10-dbarboza@ventanamicro.com>
 <a3765207-28bb-44fd-b207-58327516a6cc@linaro.org>
 <93e34ed6-9876-4a1c-897b-b0bc59831a01@ventanamicro.com>
 <f8b57cb7-75d2-4153-81e5-d82554c6a311@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <f8b57cb7-75d2-4153-81e5-d82554c6a311@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42b.google.com
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



On 3/10/24 15:04, Richard Henderson wrote:
> On 3/10/24 00:17, Daniel Henrique Barboza wrote:
>>
>>
>> On 3/10/24 04:47, Richard Henderson wrote:
>>> On 3/9/24 10:43, Daniel Henrique Barboza wrote:
>>>> From: Ivan Klokov <ivan.klokov@syntacore.com>
>>>>
>>>> The vstart_qe_zero flag is set at the beginning of the translation
>>>
>>> Here and subject, s/qe/ne/.
>>
>> Hmmmm  ... the flag name is correct - vstart_qe_zero.
> 
> Gah.  My mistake in pointing out the mistake, which is "qe" not "eq".

Hhehe the flag is still named 'vstart_qe_zero' in v10 both the subject and
commit msg instead of 'vstart_eq_zero' :D

Alistair, can you amend the commit msg of patch 9 when queueing? Thanks,


Daniel




> 
> 
> r~

