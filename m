Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55964C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 09:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxkEV-0004nC-Su; Fri, 19 Apr 2024 05:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxkET-0004mx-Kq
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 05:08:33 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxkEN-0002cw-It
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 05:08:33 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a5252e5aa01so222039966b.1
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 02:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713517705; x=1714122505; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k/k8hBHPcqxqUofyhWemYC7+cX76fkZsQPj8ufP0o20=;
 b=v5uiFsnO7174m7I4D0UzsR6uhV6Y8HV5AdnVSZLsTAvF8hcWOhUW25WA+FU7voadtc
 p/5xsd9JYXyIUOeXCoYrAv2x1Eq1kuAvksaG/p3PAe0ejZc+umsPhyUt+KbM8F5TBWzw
 OlUJM5N0jaEI2oHuo+5eKLTQ9EqWMvG5VJAW6tsAkchbKD4rrTS7EQibaqt6REYxhru0
 MF4QWTXiATCd8zeMC71iniqkDtFfn1VvIK0UjZfF8vh1Y/ORJ0MonIEh7cvx6egBu8cO
 VWggY4HeAd9HHdCM+Qk6dP34s7bdVHIj/POjkJN45zbE5b9c9ALvN2jjmsCy0sw2KSto
 MtLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713517705; x=1714122505;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k/k8hBHPcqxqUofyhWemYC7+cX76fkZsQPj8ufP0o20=;
 b=CFg1kSV3vKz6GtD51wNGZEM2zSSYk+yzEgcVIRZIA9wrauUxGEzr7wgbHaYwwEhJtC
 gcDWGFz4nt6P9Edw1To+/clXH6+IvMEWkz5E2RKYzzJX8mPPII/Ihi1yVdfYv7q0w1Qh
 g7yp3DpfWl7WlquQvMQ1zjMwHnictM3lTVo+3+lCI3AEs4cTjvu8n7xQvs+HQn1EMyox
 yqEbeE5I0Ey4COi55o4NpgjPhc3CBsoBXLRuMbW/DAmdL4TP5ce9B0siC2jUo1eQdxjk
 pckP1PezU9kA5QCuvBy/iR4VYMbXN/yjahM8sYgjPw5vU4pF80Lio7aFnlKv1MhtyzIU
 Ja6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAdwMYqZfX8Z88Dwcpe04UBpoo3lyG/Ki6Ow6+RFKE92/2wPTmGbOSNgUvcpA2cpgaEe4KnYdItXWLrJBL0DvkoEFCmi0=
X-Gm-Message-State: AOJu0YwN42MGXInUlGYE9U3fMhhU8leHV/s6ES/nBKWHS0bERpQEiFHy
 5IgOiF8O/qkP2VmIy1aFUMhnkPvbyut6upX5qX22/QEhgVv4FuP6xdkrghjn5tc=
X-Google-Smtp-Source: AGHT+IFXoeP/hHztKg1kCtDpRddMdXQ4CPc62OK31iAjBV9z7yRFXgeSkWxARzqgDF150vEhtrNxlw==
X-Received: by 2002:a17:906:2c4e:b0:a52:6cdc:c83 with SMTP id
 f14-20020a1709062c4e00b00a526cdc0c83mr916056ejh.64.1713517705463; 
 Fri, 19 Apr 2024 02:08:25 -0700 (PDT)
Received: from [192.168.235.175] ([176.176.143.233])
 by smtp.gmail.com with ESMTPSA id
 l22-20020a1709065a9600b00a51b5282837sm1956662ejq.15.2024.04.19.02.08.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 02:08:25 -0700 (PDT)
Message-ID: <d6b6f544-ea3c-495e-95ff-e6f974dc7e9c@linaro.org>
Date: Fri, 19 Apr 2024 11:08:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] target/s390x/cpu_models: Make
 kvm_s390_get_host_cpu_model() return boolean
To: Zhao Liu <zhao1.liu@linux.intel.com>, Thomas Huth <thuth@redhat.com>
Cc: David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
References: <20240419065712.1225038-1-zhao1.liu@linux.intel.com>
 <20240419065712.1225038-4-zhao1.liu@linux.intel.com>
 <0ae778e1-b4aa-4021-bdbc-4c6a663db41a@redhat.com>
 <ZiIvAXd6wFQ2pwoM@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZiIvAXd6wFQ2pwoM@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

On 19/4/24 10:44, Zhao Liu wrote:
> Hi Thomas,
> 
> On Fri, Apr 19, 2024 at 09:50:46AM +0200, Thomas Huth wrote:
>> Date: Fri, 19 Apr 2024 09:50:46 +0200
>> From: Thomas Huth <thuth@redhat.com>
>> Subject: Re: [PATCH 3/6] target/s390x/cpu_models: Make
>>   kvm_s390_get_host_cpu_model() return boolean
>>
>> On 19/04/2024 08.57, Zhao Liu wrote:
>>> From: Zhao Liu <zhao1.liu@intel.com>
>>>
>>> As error.h suggested, the best practice for callee is to return
>>> something to indicate success / failure.
>>>
>>> So make kvm_s390_get_host_cpu_model() return boolean and check the
>>> returned boolean in get_max_cpu_model() instead of accessing @err.
>>>
>>> Additionally, since now get_max_cpu_model() returns directly if
>>> kvm_s390_get_host_cpu_model() fills @err, so make
>>> kvm_s390_get_host_cpu_model() return true by default for the non-KVM
>>> case in target/s390x/cpu_models.h.
>>
>> You could also argue the other way round that there should be something in
>> *model if it returns "true" ... anyway, the stub should never be executed,
>> so it likely doesn't matter too much, but I'd still prefer if we'd rather
>> return "false" in the non-KVM stub instead.
> 
> I see, since this interface in wrapped in kvm_enabled() condition, so
> the non-kvm sutb wouldn't be called.
> 
> Thanks! Will change to return false.

Or try to rebase your series on this untested patch:
https://lore.kernel.org/qemu-devel/20240419090631.48055-1-philmd@linaro.org/


