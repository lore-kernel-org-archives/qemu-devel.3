Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2276EC54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 19:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHp1J-0000N6-U5; Wed, 21 May 2025 15:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHp1I-0000MM-Je
 for qemu-devel@nongnu.org; Wed, 21 May 2025 15:22:28 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHp1G-0001KU-DX
 for qemu-devel@nongnu.org; Wed, 21 May 2025 15:22:28 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-739b3fe7ce8so5993906b3a.0
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 12:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747855345; x=1748460145; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GPdlN5UXk6XW4sbbz2sp5I8HWlwBFTHeim/u0mXvZ3Q=;
 b=dDQtz/Yc7qF/fLL1oKd3ToPYiAAdcHx50G5ZRaMUtxDs7yW2kEuQmw1gVptJGmUkEu
 b3BD01o5awdUQSl//6R13eIlNozl+CcOtF6zYMqaqmqxGGhdfFDf1f211aehGaWelrmP
 uDCGpNC3W4BdmXorlOKMBVtuhmTUbjJVqZORFOMbHW4iFCQnPPzJb3Zu2WqyiTDszWcr
 aFFcS88e7lHDrT/+WzOIkpLNmRNJb9mEzxEadfSBm1UWjSx8fj+48zorWy5AK5EeRwHj
 CrFS4JM9sbdIl4hQwalsWN3rrwC1qrn2767uLwrTgE0Nw92avVbCY1Uk+UxxsKotTIrU
 x1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747855345; x=1748460145;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GPdlN5UXk6XW4sbbz2sp5I8HWlwBFTHeim/u0mXvZ3Q=;
 b=iCX9Nk80nPMX6ohjTZqLah58aZMdwtx4SeKzB0DMi2Peq5YM9leM5+O2rTivsU4ON2
 f5sXX3jBmOm/E3bBheC0/BcSWBfR4iAeFcxlJ7OhSFEzPF5vv63A3MP+VEzs2LRtPFGa
 QnHxY9IvZRjQY9c75nVKLhj/uOocBcZMOoZkGBLIahGzXMasOfjf4zepJz0ksqIsqcFb
 v4TZX6xjCFwJbbYjZzm72S3xhLDkpS5d9mBuPpfqH7+FbY9RaKCk3WVexIQZqvDjT6Dd
 eTdi15D+ZPhMJMswUbakUKj2AUUK+tNnp6h7noIGv4vbui9VHfp3ob8W95eNqFKfqqit
 ODuQ==
X-Gm-Message-State: AOJu0YxHjc3IrujUB7zzOm30FbyIIpFoKmgDnV3mppMtDZWQx+wt2V1W
 2P8EyvMNU4wHahMoGmWVJAuG8Dg8IJnYGr3WCrFPVCk+u2520s5DH4utQzIe/n5jTK0=
X-Gm-Gg: ASbGncttdbsqE/mm44OPDig7sWYZgReUE1n2L9uW2gMqCY2hCDozhPgDbLmRfTh+Ius
 +UVvKJNcAoPmDfdrkGqkGaFISFVGMXFhj9Rv0xhkvZ57kt8qS+N/rTUvx3iOwnZnWCyXo5P+Cut
 RnMIQWOGEyQrc0k9BK+/K6nOMwd5HkN6rj/HE8Ow7iFvsjIb+wq6SoOPMHdwFfmHK3fgOJ+Saa3
 VeR3BoeXYo8jMhZ2K7uzOiZTQrwi48R4/y0ntf9IE3/ekhYfWDOwvUDBQqVxxgsPYmLfWhvb2ZO
 CwjaFzNeNC5CMh++qK4xgcGE/h7f77pv4ZBB8kPAobDhqMyU2uk3k3JurfnNFJ+j
X-Google-Smtp-Source: AGHT+IEV/b3AKGmI2ELJxwlqr/z+D5qXzztJs5iEzWqi2W+c2p4xGFWJn/TPQKYl6AFlIRSj/p7jCQ==
X-Received: by 2002:a05:6a20:7d9c:b0:1fe:90c5:7cfb with SMTP id
 adf61e73a8af0-216219b24bemr32062993637.27.1747855344748; 
 Wed, 21 May 2025 12:22:24 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b26eaf6dc3csm9957711a12.24.2025.05.21.12.22.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 12:22:24 -0700 (PDT)
Message-ID: <376e7bce-afc8-439e-b24e-3e7e2acb22a8@linaro.org>
Date: Wed, 21 May 2025 12:22:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/12] qapi: Make
 CpuModelExpansionInfo::deprecated-props optional and generic
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 berrange@redhat.com, Peter Maydell <peter.maydell@linaro.org>
References: <20250515172732.3992504-1-pierrick.bouvier@linaro.org>
 <20250515172732.3992504-9-pierrick.bouvier@linaro.org>
 <87a579jf77.fsf@pond.sub.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87a579jf77.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

On 5/18/25 11:18 PM, Markus Armbruster wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>> We'd like to have some unified QAPI schema. Having a structure field
>> conditional to a target being built in is not very practical.
>>
>> While @deprecated-props is only used by s390x target, it is generic
>> enough and could be used by other targets (assuming we expand
>> CpuModelExpansionType enum values).
>>
>> Let's always include this field, regardless of the target, but
>> make it optional.
> 
> Let's add:
> 
>    This is not a compatibility break only because the field remains
>    present always on S390x.
> 
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   qapi/machine-target.json | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
>> index 426ce4ee82d..e153291a7fc 100644
>> --- a/qapi/machine-target.json
>> +++ b/qapi/machine-target.json
>> @@ -244,19 +244,18 @@
>>   #
>>   # @model: the expanded CpuModelInfo.
>>   #
>> -# @deprecated-props: a list of properties that are flagged as
>> +# @deprecated-props: an optional list of properties that are flagged as
>>   #     deprecated by the CPU vendor.  The list depends on the
>>   #     CpuModelExpansionType: "static" properties are a subset of the
>>   #     enabled-properties for the expanded model; "full" properties are
>>   #     a set of properties that are deprecated across all models for
>> -#     the architecture.  (since: 9.1).
>> +#     the architecture.  (since: 10.1 -- since 9.1 on s390x --).
>>   #
>>   # Since: 2.8
>>   ##
>>   { 'struct': 'CpuModelExpansionInfo',
>>     'data': { 'model': 'CpuModelInfo',
>> -            'deprecated-props' : { 'type': ['str'],
>> -                                   'if': 'TARGET_S390X' } },
>> +            '*deprecated-props' : { 'type': ['str'] } },
> 
> [Copied from review of prior posts]
> 
> Make this
> 
>                 '*deprecated-props' : ['str'] },
> 
> please.
> 
> When I see "optional array", I wonder about the difference between
> "absent" and "present and empty".  The doc comment doesn't quite explain
> it.  I figure "present and empty" means empty, while "absent" means we
> don't know / not implemented.
> 
> Is the difference useful?
> 
> Daniel doubts it is.
> 
> Philippe is happy to implement either variant.
> 
>>     'if': { 'any': [ 'TARGET_S390X',
>>                      'TARGET_I386',
>>                      'TARGET_ARM',
> 
> Note the patch doesn't touch any of the qmp_query_cpu_model_expansion().
> The S390x version continues to set @deprecated_props always.  The others
> continue not to set it.
> 

Changed to "'*deprecated-props' : ['str'] }", as requested.

