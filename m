Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D723C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 09:38:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhnih-0006QW-8f; Wed, 06 Mar 2024 04:37:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rhnid-0006PH-UZ
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 04:37:49 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rhnib-0001RM-8X
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 04:37:46 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1dc13fb0133so49278895ad.3
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 01:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709717863; x=1710322663; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fNvmPfvH9W7Kwn40uZp3Qj0TVVLusroseZdtJTf9XT8=;
 b=btDw0Ew3t1smuWbYfdJbQt4m4eebc4VzkpKTv5JnU45yFTJJCGeyzfGwwIyuBnqzXB
 Q1szbW4tLGu855tuUwzocTwaRAQ//tV36C1xEszJfNGk8lnwlBUaMNaAPf9ZeosIBEYD
 3BX32c3NqIip83n6rO0MfqXw/xbTSh2X4NS1PMqtxuXEP2y5TKVGBqpKNq/ZpSSu1nWS
 W7WzV+57EXhECx0/w6s4cVGDqeupxKEd6lnsUXryEdsLPkpUI3bwnNmZENaebsDPcZPm
 20ZJOgTiFOzkr5oYrpl5S89/h1CPN6Gcwmetb3yvAyhheT4RuqDJ++GgIby9RE4B2n7a
 WoQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709717863; x=1710322663;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fNvmPfvH9W7Kwn40uZp3Qj0TVVLusroseZdtJTf9XT8=;
 b=BX9R4BItSWggQqrWri7jssnFOhJWUsiM/E0xFDVrLdqA/feEHsl5pWyQk6bk+3kdXo
 /Ge9/bJ92qzxy7V5BwRjduZjlwip831aRYTC/UepT/NHYluSiXgHafKp6OsEVnzVobnA
 3jM/7dcYmdIkQL6c08z1sDwg24Tn0/FHl1C579xoS1Ldmu39zSainMUu7nFyYa94LRzu
 clygqELrCX92EhLfhmoD11QkkuVfUjE5rEXT+7MjDayGk5X7TsY3MKYTA9AS1aTAbcAh
 e5hdSCGfjzkIStM/LG1p4ctiYuA6ya+ldrkO0etUEaaA+cCSTYfIriAWvLgZvmjvui2V
 MdpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/Q64sy9LnDwFeOp3GDq/6SsYymSCGLSko2O6SMhLtMzmxU4e3UGafU+2WbBNFs3e7bjFB0xUXpaR7gbc3zXXgZaO7Grk=
X-Gm-Message-State: AOJu0Ywdmel9g2v7MmYT3kLi7WbOIxOvIVNLSWRnm/U4E00gPW/IpfZv
 1W8LD/MYbB+rl+RPqfWyF27WoBuUe3JgLIuZTH97wlFBqdJPXYWOXPwGt/ikphU=
X-Google-Smtp-Source: AGHT+IGt81MdIZX2EcH6UTdpm/R4YbgCQsmn15v4Pg+/oxq9Jk2yJ+29PHVTMnVZoTzuZq8E/kH3bA==
X-Received: by 2002:a17:902:db86:b0:1dc:c8d3:52ba with SMTP id
 m6-20020a170902db8600b001dcc8d352bamr4279236pld.56.1709717862902; 
 Wed, 06 Mar 2024 01:37:42 -0800 (PST)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 c1-20020a170903234100b001db594c9d17sm12081686plh.254.2024.03.06.01.37.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 01:37:42 -0800 (PST)
Message-ID: <339358de-fc57-42fb-80ec-9413648ea44f@ventanamicro.com>
Date: Wed, 6 Mar 2024 06:37:39 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/riscv: Fix shift count overflow
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: "demin.han" <demin.han@starfivetech.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, philmd@linaro.org
References: <20240225174114.5298-1-demin.han@starfivetech.com>
 <a5c8ed1b-0b67-449a-83b9-accf0754c562@ventanamicro.com>
In-Reply-To: <a5c8ed1b-0b67-449a-83b9-accf0754c562@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
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

Hi Alistair,


Please don't forget to queue this up. Thanks,


Daniel

On 2/26/24 06:31, Daniel Henrique Barboza wrote:
> 
> 
> On 2/25/24 14:41, demin.han wrote:
>> The result of (8 - 3 - vlmul) is negative when vlmul >= 6,
>> and results in wrong vill.
>>
>> Signed-off-by: demin.han <demin.han@starfivetech.com>
>> ---
> 
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> 
>> Changes in v2:
>> - Add vlen var
>>
>> Changes in v3:
>> - Fix commit msg typo
>>
>>   target/riscv/vector_helper.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
>> index 84cec73eb2..fe56c007d5 100644
>> --- a/target/riscv/vector_helper.c
>> +++ b/target/riscv/vector_helper.c
>> @@ -44,6 +44,7 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>>       target_ulong reserved = s2 &
>>                               MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
>>                                               xlen - 1 - R_VTYPE_RESERVED_SHIFT);
>> +    uint16_t vlen = cpu->cfg.vlenb << 3;
>>       int8_t lmul;
>>       if (vlmul & 4) {
>> @@ -53,10 +54,8 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>>            * VLEN * LMUL >= SEW
>>            * VLEN >> (8 - lmul) >= sew
>>            * (vlenb << 3) >> (8 - lmul) >= sew
>> -         * vlenb >> (8 - 3 - lmul) >= sew
>>            */
>> -        if (vlmul == 4 ||
>> -            cpu->cfg.vlenb >> (8 - 3 - vlmul) < sew) {
>> +        if (vlmul == 4 || (vlen >> (8 - vlmul)) < sew) {
>>               vill = true;
>>           }
>>       }

