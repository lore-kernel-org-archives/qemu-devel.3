Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB94C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 07:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcgqL-00053E-Qa; Wed, 21 Feb 2024 02:16:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rcgqF-000510-Rp
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 02:16:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rcgqE-00077f-BX
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 02:16:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708499788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TjYX//FZ7Op6zzAuS38Az7p1gyhJt+2lWcBgORzp7qA=;
 b=HPmKNig5nROKpLGC1AXbRllV7QcgJehmuhq/jRdn58ziPqcUjATSrOF+dery7zzq+/zP9d
 rTOt9VICPwhC/4IcAn5MgSIch7nDdBKXlh1fUVtsyhILcQU8m6ipcg5uxA32JJk/DxI5yQ
 be7ec5W8WOjHWoE9xWVoXuX2ECjW0mk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-Ai4-kTfIN3q9s0hcqJnzfA-1; Wed, 21 Feb 2024 02:16:26 -0500
X-MC-Unique: Ai4-kTfIN3q9s0hcqJnzfA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a3f52ebbb6cso3013166b.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 23:16:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708499785; x=1709104585;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TjYX//FZ7Op6zzAuS38Az7p1gyhJt+2lWcBgORzp7qA=;
 b=EpRv58BGlyS9IDLf4KhKoFuQdQ6yygf2xnG/nvDOcQzac5errMDr6nbhdSmhunoZ+P
 upGyiwzsKEUYKrL+5s5ZtrQQ6ULeceEwxZQuVCYm79ChmDf4MaB/nG9PnnfNp64J7ZG/
 wAJ3k+tPaqRqNSzvEld51bL8ZVVibURz8y6yLxSzc8FxJv0lNbvv3o5eWuBdUUAJX01C
 T4fO4ReoQdMrxiF2KWWpzI9+96m3wd8zwyfLGvSKGIy07Y6kSL2QR1P7uSMydfNDA8Bk
 KsbgB7Vonnwm7Fp9SRcPT5eZuPOH+rhIwRPtkN4fD2fkcbCmUovTYtV/fdrlnzv3IMq7
 MOJA==
X-Gm-Message-State: AOJu0YwB0N1wDWNBZls4N5pzYZ2KX7kdYvr51MpOjFgWmEFQsYyTtLUU
 B0AvskuoEbnFVl89EqPwq4KKLOPpd6I9W6LKeLiau56GWNeudvZAmnlwBPLpBI/2Gg5qdJsiHI8
 ynjijS2Y162ErfaMhhtcCGykeJrf+tCboI9M5bz08faEA8caMCnEW
X-Received: by 2002:a17:907:100b:b0:a3e:876d:1b1 with SMTP id
 ox11-20020a170907100b00b00a3e876d01b1mr6079215ejb.20.1708499785574; 
 Tue, 20 Feb 2024 23:16:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0LbfXMEOqIFIahmcWWZs6OO3K0+GaSmEBW+DAav9a331/Wq4BBfSWgzIA1/nKCfGOTxBOoQ==
X-Received: by 2002:a17:907:100b:b0:a3e:876d:1b1 with SMTP id
 ox11-20020a170907100b00b00a3e876d01b1mr6079200ejb.20.1708499785283; 
 Tue, 20 Feb 2024 23:16:25 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-100.web.vodafone.de.
 [109.43.178.100]) by smtp.gmail.com with ESMTPSA id
 g16-20020a170906c19000b00a3cee88ddc7sm4744454ejz.147.2024.02.20.23.16.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 23:16:24 -0800 (PST)
Message-ID: <ceb828d1-9283-4ad0-9833-2316b024d00e@redhat.com>
Date: Wed, 21 Feb 2024 08:16:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] .gitlab-ci.d/windows.yml: Remove shared-msys2
 abstraction
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Yonggang Luo <luoyonggang@gmail.com>
References: <20240220174412.155885-1-peter.maydell@linaro.org>
 <20240220174412.155885-4-peter.maydell@linaro.org>
 <ZdTqNmZvM_S9SwDB@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ZdTqNmZvM_S9SwDB@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 20/02/2024 19.06, Daniel P. Berrangé wrote:
> On Tue, Feb 20, 2024 at 05:44:12PM +0000, Peter Maydell wrote:
>> Now we don't build msys2-32bit we don't need the abstraction out of the
>> common msys2 handling from the 32-vs-64-bit specifics. Collapse it
>> down into the msys2-64bit job definition.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>   .gitlab-ci.d/windows.yml | 84 +++++++++++++++++++---------------------
>>   1 file changed, 40 insertions(+), 44 deletions(-)
>>
>> diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
>> index 8fc08218d28..e784d5a68cd 100644
>> --- a/.gitlab-ci.d/windows.yml
>> +++ b/.gitlab-ci.d/windows.yml
>> @@ -1,4 +1,4 @@
>> -.shared_msys2_builder:
>> +msys2-64bit:
>>     extends: .base_job_template
>>     tags:
>>     - shared-windows
>> @@ -14,9 +14,19 @@
>>     stage: build
>>     timeout: 100m
>>     variables:
>> +    MINGW_TARGET: mingw-w64-x86_64
> 
> This var isn't needed since you remove the only usage of it.
> 
>> +    MSYSTEM: MINGW64
> 
> I'm fuzzy on whether this is needed or not ?   We don't use it,
> but perhaps it is something MSys wants set ?

We've had this in the very first version of this file already:

  - $env:MSYSTEM = 'MINGW64'     # Start a 64 bit Mingw environment

So I think this is required by MSYS.

  Thomas



