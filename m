Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC21FC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 03:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF4BB-0005K7-Qe; Wed, 05 Jun 2024 23:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sF4B9-0005Jh-TV
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 23:52:43 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sF4B8-00086I-F6
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 23:52:43 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2c1ab9e17f6so472423a91.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 20:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717645960; x=1718250760; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HLxLQq0roojJISlebJuyw3eCIquZlk+FmRY0e3h0v+A=;
 b=MViCxLegKUtmn64YGscmev9XyYdS547LnIHwzo/NJIPNx6V8IEIU8Rh2d7DcfQ1wsZ
 UpV3wQPb9PsvR5bXhypOKfXbuz2ZljrkhsVoXGfBxVLWZqeDMSUevQNjvH5G+IrxlOsV
 tJ51Uw37nNMigVZUktpy+T0clyrHbaZnth1PoWGZMD9ud3vUUYDgK8/qEIumVljbomCV
 7uVESX0F2cMzort+6e7ov+viIupktuRJ97h3+RIBfhXxPXhyZ9tybuBMR/1eRIGpQdk+
 JuZmDwedCvhJjnQ8IBlDXnpoyIUQtPjPfsEp5SgAxYnq0Vix3q1gA50Q4pDD7JoQjzKM
 QlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717645960; x=1718250760;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HLxLQq0roojJISlebJuyw3eCIquZlk+FmRY0e3h0v+A=;
 b=uYfZBhz2zdF3dMXUqz7vqZyx9loBnhqwwQJtvZ6YogjCGxRi9+Cyhk/tPJbxvnTXLv
 15Z21dV2plHhvvva82BScvTx8SQgekvQ6bAAjH+VPjR9DgFvS7dDQoqq/odDX8OLFl0y
 5MdEva5BalGIib4OYAXu77gHPjRXiQ2NS1ENOYrAFWBxTLj6k1Bw7p090+9cvy+9Zere
 mTC6nGph1NM+Lh5FPyaCRV+4C5w2KkJQ8jUMjMD9sL4g4G7UiXDqODqMxa1IIWMAv2oj
 wu5bUyQHD6ZNW2XnhgyjuY/fqBZDyKAe6JlbZ7ph6YekAsuEHMUZUL4UrgUgkeyRBUVl
 +7Dg==
X-Gm-Message-State: AOJu0Yx7D0jkolGXdhnpBj9bDp5J+F+f/nKD224Nil4pP8Y3Ap/HC6l6
 +0Go61WKCjVjYE/jNT1ZXQ9Hxd7mGBPr805CdWkyPkqCbZUAv7MFyAuVMoHGt5E=
X-Google-Smtp-Source: AGHT+IEco5Kxtqx2hXA1djt9K4i0QZgmse/2vHu05VkH/WkNzrLlMrXJ7WNj+Zz+SYOQXyh3ipARiw==
X-Received: by 2002:a17:90a:b298:b0:2bd:b155:a7d8 with SMTP id
 98e67ed59e1d1-2c27db21de6mr4564384a91.22.1717645960309; 
 Wed, 05 Jun 2024 20:52:40 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c29c4a574bsm413828a91.56.2024.06.05.20.52.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 20:52:39 -0700 (PDT)
Message-ID: <b930a4ea-73a3-40a8-bbc1-def8aea72c5d@linaro.org>
Date: Wed, 5 Jun 2024 20:52:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: SEV: do not assume machine->cgs is SEV
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, pankaj.gupta@amd.com
References: <20240605224409.2103109-1-pbonzini@redhat.com>
 <ZmEwvsAnh1lXNqhS@intel.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZmEwvsAnh1lXNqhS@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 6/5/24 20:45, Zhao Liu wrote:
>> @@ -1710,7 +1710,9 @@ void sev_es_set_reset_vector(CPUState *cpu)
>>   {
>>       X86CPU *x86;
>>       CPUX86State *env;
>> -    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
>> +    ConfidentialGuestSupport *cgs = MACHINE(qdev_get_machine())->cgs;
>> +    SevCommonState *sev_common = SEV_COMMON(
>> +        object_dynamic_cast(OBJECT(cgs), TYPE_SEV_COMMON));
> 
> SEV_COMMON(object_dynamic_cast()) looks to be twice cast, we can just
> force to do conversion with pointer type:
> 
> (SevCommonState *) object_dynamic_cast(OBJECT(cgs), TYPE_SEV_COMMON)

You don't need the explicit cast either, since C auto-converts from void*.

   sev_common = object_dynamic_cast(OBJECT(cgs), TYPE_SEV_COMMON);


r~

