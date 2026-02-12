Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CDBEEA871
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 23:57:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqgYZ-0008JQ-Dk; Thu, 12 Feb 2026 18:57:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqgYU-0008J3-Jr
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 18:57:06 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqgYT-0005Ui-6J
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 18:57:06 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c0c24d0f4ceso118534a12.1
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 15:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770940624; x=1771545424; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SolhyXajg4bZSKQlWyLn1N1ofnuI1IU75RAUQ4HV41M=;
 b=q+zBqXOmlvRH+N/c2W+pP57czS9//09xoPsAl4Gv/uShorET8Nuu5YtqewwSEVREko
 ZR2qbXVQCeVAK6PmoVI0tceyIXhc/8KTYTR5Ti/Qwj4Beg0EZELmNoLvKt2hGJmUkwwr
 3BJubJNclhF15yD5oNmdX4RlM67svlii9GNZIKmprt5GX82LiJLq0lU2NL1N7Wr5tgjE
 uDEv2m/t9cZt3nb7BTg8gl6qGBbsDSy1/k+OyOISxKcGkE1aRV7Wt6GcIFjNkUHjxyRy
 pHwDx1NHJKhf7aNc3mb649eNS3oqCVgvWGL1cXwsFUkmIivlh6OFLPH0gqz3kWqDLAI8
 L4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770940624; x=1771545424;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SolhyXajg4bZSKQlWyLn1N1ofnuI1IU75RAUQ4HV41M=;
 b=lMGSD67RklJFA2JLkSPwcELtPA5jWjcUtjstrV0pCvgDLqejAOcRtRJvYp3WjWGZ/F
 dROOrJc07tsnhbv5ronzBAP8AEPpItkaKB/I55ufHBgWKimBDAE6kQ1NDR+/cmtei2ML
 iymx7kY+myoGTpBTIF2eT5aIKYvcRU29d26C0jwfYS0g43TCU2a53bvj6QmAbTwsnAXF
 qvdPHr9KNgTBwG53ySanboIGqnWX1bFgCGwxIxZeYx8rdLijelsurwt1pmDymeorvCVN
 7xzn5vv5ygiqRB4CKjYmjhdx5VI2qnrnK7Lu8gcxyVIvnY93i8oD9SwmcjnvYTePkdyE
 3wJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNU8SBVc0LPkRRS+TmSQ6FQ1BtDc9sYoZ1LnXerSD+UWPoOt7L+sLri6SBDTyIuTkqRe8mgVw+xATn@nongnu.org
X-Gm-Message-State: AOJu0Yx5z1dzCglwv1b9uzDOl2P+x+ACHxAuLqR66O2EcOVMbZ250DZ5
 vCbnt1HcqSz5ZaW1RL6yLHj1LrmcYqeoC5ytEptU9dyMDivikc0ZKaKdnys12qnDGzC/MLM/NrN
 m1uB2
X-Gm-Gg: AZuq6aKI2KPzYvRoDVOk1SW2H5+GgHn6VsURYyub/Y0j3MCYn8pLQwApg4rn8VHGNtT
 QTu52WG8TMCg5tDQd3n9gMNAMoi+Rr1YSWRze0Bep9VqobpIWm57R29Nghw17M1sARRzpxg3Bz3
 rN5/u13lg9Ye7z3z0ceLRXm179SSg2oHzFy/Nkg4nMUV5vtJCBvc9HYTNXE0meqq79iSXrxIE68
 z+hCJWBHEu1DV2S6MBQ8rOZURR7nLlE8Af4M3CiNaiRCLKZEqQSTO8AvW3L9W2VNVP+FUqMVapK
 NE24zo6Sl42RcyWAHybKtXfe4/+6p7b3FZltcTKf/ULiLHpwis+neZPUclZv7PzPe/nQiMuUb3t
 ibcgMQVNdETDS92TaMfxXyjP3NFvMGvva0Yr1bMEde6PnJ3031zg/sXJ8DN9M475hnVu4n1tuhy
 jLdfWr8OYGtHHrIxfI74Kn318ZeWufiFaHfJeHTd86IyvTov8l4XtemN6pFqSZbAF6w8Vr
X-Received: by 2002:a17:902:e804:b0:2aa:d1e1:29cb with SMTP id
 d9443c01a7336-2ab4d0ad572mr6389155ad.61.1770940623621; 
 Thu, 12 Feb 2026 15:57:03 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ab2984c0d8sm76653525ad.13.2026.02.12.15.57.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Feb 2026 15:57:03 -0800 (PST)
Message-ID: <d0ea25ca-5138-4874-9032-2870054e17fd@linaro.org>
Date: Thu, 12 Feb 2026 15:57:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] contrib/plugins/uftrace: add riscv64 support
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, alistair.francis@wdc.com,
 Mahmoud Mandour <ma.mandourr@gmail.com>, manos.pitsidianakis@linaro.org,
 anjo@rev.ng, brian.cain@oss.qualcomm.com
References: <20260210201344.1403613-1-pierrick.bouvier@linaro.org>
 <20260210201344.1403613-5-pierrick.bouvier@linaro.org>
 <14ee1f39-a8b5-44e4-b9f4-1eb08244c9cc@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <14ee1f39-a8b5-44e4-b9f4-1eb08244c9cc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x534.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/12/26 12:00 PM, Philippe Mathieu-Daudé wrote:
> On 10/2/26 21:13, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    docs/about/emulation.rst  | 10 +++--
>>    contrib/plugins/uftrace.c | 87 +++++++++++++++++++++++++++++++++++++++
>>    2 files changed, 94 insertions(+), 3 deletions(-)
> 
> 
>> +typedef enum {
>> +    RISCV64_USER,
>> +    RISCV64_SUPERVISOR,
>> +    RISCV64_RESERVED,
>> +    RISCV64_MACHINE,
>> +    RISCV64_PRIVILEGE_LEVEL_MAX,
> 
> Dropping the superfluous trailing comma:
>

There are many examples in codebase of enum with such style, and no 
specific direction in docs/devel/style.rst.
This plugin is deliberately making usage of this for structs and enum 
definitions, so better to stay coherent.

> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
>> +} Riscv64PrivilegeLevel;
> 

Regards,
Pierrick

