Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E0ADC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 16:24:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD52n-0002qz-4T; Fri, 31 May 2024 12:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sD52l-0002qH-GG
 for qemu-devel@nongnu.org; Fri, 31 May 2024 12:23:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sD52j-0001xd-6n
 for qemu-devel@nongnu.org; Fri, 31 May 2024 12:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717172627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QSyRvL3fViS1ze85bZ1WGsZzC+7tfcXns1wLCwSrmPY=;
 b=ROLiLid89JzvcUr1xMcDVxjD8HLSygb+/UkmZMqk0LhIzxjPdnS51zwIvcInH3uDaBSt9F
 tH+CRpOitnI/dTuTDaZHeLkXmA/wHUdji4osq0//pzp5BHxhiTWNXBkEP8tREEUPwYnA5Y
 /XtIN/fbP+60sbbPHuhuDa/7YazN1ms=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-Dm7pjjv4NBirpuQdGEM3aw-1; Fri, 31 May 2024 12:23:45 -0400
X-MC-Unique: Dm7pjjv4NBirpuQdGEM3aw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a6266ffdb45so97399666b.1
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 09:23:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717172623; x=1717777423;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QSyRvL3fViS1ze85bZ1WGsZzC+7tfcXns1wLCwSrmPY=;
 b=b4CpbgoZ5PnAvBcGl+FSGbcWg7d7QWIJ1z3u7iwV2iWVxni7GBV0Dt4Kg6+Rxp5zGy
 I/gqOUsrJfg/k5G8aSZkuJKqeG4cfTg5iSOQvFqGJwtX021BCMWboasHs78ig9b9a+Vh
 SmByXiI01nZjMEFMHkObjBdfOEOYuSULLLMAQDshbbdg4sFvuRWKmezTK85LDrUFvrDc
 bYkFuLUYZcaQk4kHKLUYgZ6AS13OrUhCdRi2mbrcIfuT+NIAFKPsk5+wI31KURMaLDGQ
 oqR26iYBj5gl9f9QwufOubTFqs50JWc2YCQjZN3UPOl+iNKToKFS+2RrrJRNc+WcyO7R
 imBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVanxFmTv06+R+zN+Or2XBPjeURq/+FrTQgtePcNjFCKWAfVYdjxTR8tympEQ5DE9KfBbFTW5VJUNRFNiUggePNBth2w64=
X-Gm-Message-State: AOJu0YyFOgRnIITSIu8JTpV5nZHLeqjzXA/LBQD8MC+KWHUkpe2qk8id
 Leg+lZu7FpKpM78rlIjQkcYNPYexzbuL4J3dEsWzev/6amVuN8rcjiEzqF2D9Mh6KQajLCAFKaj
 Cft1JjkJmvqWNzAyTx7fSH9nr6zqNaQl+wpffhD15qaeTLNuXVn22
X-Received: by 2002:a17:906:b24c:b0:a5a:8ca4:6781 with SMTP id
 a640c23a62f3a-a6821f51918mr157770266b.51.1717172623150; 
 Fri, 31 May 2024 09:23:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnlBi+40Kp+23IXR5CuOMLIYQyYCaAvwlOMT0bI764mSgoyjf/59xWp/6W5oZdOQkv10/cWA==
X-Received: by 2002:a17:906:b24c:b0:a5a:8ca4:6781 with SMTP id
 a640c23a62f3a-a6821f51918mr157768166b.51.1717172622691; 
 Fri, 31 May 2024 09:23:42 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-176-229.web.vodafone.de.
 [109.43.176.229]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a67ea586905sm101745666b.114.2024.05.31.09.23.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 May 2024 09:23:42 -0700 (PDT)
Message-ID: <6fec1c49-c6a6-4e96-bc44-5dc7feb843e6@redhat.com>
Date: Fri, 31 May 2024 18:23:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] hw/s390x: Alias @dump-skeys -> @dump-s390-skey and
 deprecate
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 David Hildenbrand <david@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-s390x@nongnu.org, devel@lists.libvirt.org,
 Eric Farman <farman@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Anton Johansson <anjo@rev.ng>, qemu-arm <qemu-arm@nongnu.org>
References: <20240530074544.25444-1-philmd@linaro.org>
 <cb4028fc-9596-47f3-9468-f8912dd48aed@redhat.com>
 <ZlnYkt9sLgDbQqVT@gallifrey>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ZlnYkt9sLgDbQqVT@gallifrey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 31/05/2024 16.02, Dr. David Alan Gilbert wrote:
> * Thomas Huth (thuth@redhat.com) wrote:
>> On 30/05/2024 09.45, Philippe Mathieu-Daudé wrote:
>>> We are trying to unify all qemu-system-FOO to a single binary.
>>> In order to do that we need to remove QAPI target specific code.
>>>
>>> @dump-skeys is only available on qemu-system-s390x. This series
>>> rename it as @dump-s390-skey, making it available on other
>>> binaries. We take care of backward compatibility via deprecation.
>>>
>>> Philippe Mathieu-Daudé (4):
>>>     hw/s390x: Introduce the @dump-s390-skeys QMP command
>>>     hw/s390x: Introduce the 'dump_s390_skeys' HMP command
>>>     hw/s390x: Deprecate the HMP 'dump_skeys' command
>>>     hw/s390x: Deprecate the QMP @dump-skeys command
>>
>> Why do we have to rename the command? Just for the sake of it? I think
>> renaming HMP commands is maybe ok, but breaking the API in QMP is something
>> you should consider twice.
>>
>> And even if we decide to rename ... maybe we should discuss whether it makes
>> sense to come up with a generic command instead: As far as I know, ARM also
>> has something similar, called MTE. Maybe we also want to dump MTE keys one
>> day? So the new command should maybe be called "dump-memory-keys" instead?
> 
> I think there are at least two different concepts; but I agree it would be
> nice to keep a single command for matching concepts across different architectures;
> I can't say I know the details of any, but:
> 
>    a) Page table things - I think x86 PKRU/PKEY (???) is a page table thing
>      where pages marked a special way are associated with keys.
>      That sounds similar to what the skeys are???

Sounds a little bit similar, but s390 storage keys are independent from page 
tables. It's rather that each page (4096 bytes) of RAM has an additional 
7-bit value that contains the storage key and some additional bits. It's 
also usable when page tables are still disabled.

 > I'm not sure the two fit in the same command.

Does it make sense to dump all the MTE or x86 keys all at once? If so, we 
could maybe come up with an unified command. Otherwise it might not make 
sense, indeed.

  Thomas


