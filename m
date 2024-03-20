Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD53DC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 08:57:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmrlI-0000Mf-Jm; Wed, 20 Mar 2024 04:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rmrlG-0000Ic-Qs
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:57:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rmrlF-0002lF-7d
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:57:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710925044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yeoQxtV68NI2pJx0Fr2sZhrQUf02wD/C+fL7yygsjeY=;
 b=dQ50UEBPmWiOoYZyF5NhCD8F1fKjfNGSf8bpqHO9Q+nDvwslKEbEwzRLo+dcmEAg9EbLh/
 QK5JRbMr4Ow4Lu6u+/u10Wz8XY+5NXokcnys2Xa35OOO6r3pVQvmvM5IfjJhVjWK9tD/cB
 ANc9x2QVhJxDdQCxLnBEmRnr9/n/UTw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-WAs23dwEOjqvAGizs3VCOA-1; Wed, 20 Mar 2024 04:56:42 -0400
X-MC-Unique: WAs23dwEOjqvAGizs3VCOA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a46852c2239so320522466b.1
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 01:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710925001; x=1711529801;
 h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yeoQxtV68NI2pJx0Fr2sZhrQUf02wD/C+fL7yygsjeY=;
 b=Ii8DO6XMxmBqoiLwhpQAyZ890gBroz4VFzZECNGyAmzYJxcdoIL+S/aRk6eOXY7Zl5
 /Phb88Bz7OlrMmocuchml9qGJpfQUvJuMPXoADlRAzr3TuKYC6q+M26sDXP84HVOo4x6
 iIFteNgRoeLelck2REKeCTBC7EAmSJDvkk/LId0kfu6PWAy167wZvZUvevKsLioRdp+f
 ByXeupR+3VkIJlk6qvWyxg+8i8g+wFvYgmV/Eb4tVxDTBJsULrh/BB8k1HfkAjDdMw/n
 +UrqGNCnPqZW06JZ2qTQCu7Wj5g/jAOsX5tjgZBAot4w81DB6C5qb6a5kv6hCEKTgwtH
 wCUA==
X-Gm-Message-State: AOJu0Yy3E2DgD3v5tiEA5PzDV1wNtcTS9JPlXIgXKXkNhROA5RpFG6zG
 XhYfSUzlmE2MfRaczGzGigg67Op8TnC3OmrADv+KKxCOst1TO12lUtcaukQREBoQ87AWCQrUJJv
 7zGTc1tamc0yTKRWGorz8wUWnZW2Vp8eWJRwmSgA0grqJxedlTDO2
X-Received: by 2002:a17:906:e951:b0:a44:dc35:df19 with SMTP id
 jw17-20020a170906e95100b00a44dc35df19mr11330056ejb.67.1710925000925; 
 Wed, 20 Mar 2024 01:56:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxdMcZjyJmzIs2RCZUyanVXOyRTN7Zu6cwGLCNNGfw2pkm4f7zqy7p2u2AqxVjveC9fzG/Wg==
X-Received: by 2002:a17:906:e951:b0:a44:dc35:df19 with SMTP id
 jw17-20020a170906e95100b00a44dc35df19mr11330039ejb.67.1710925000605; 
 Wed, 20 Mar 2024 01:56:40 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-177-50.web.vodafone.de.
 [109.43.177.50]) by smtp.gmail.com with ESMTPSA id
 hz13-20020a1709072ced00b00a46a9cdcfa5sm4710252ejc.162.2024.03.20.01.56.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 01:56:40 -0700 (PDT)
Message-ID: <8cf83c55-3557-4589-a37e-d832109cc703@redhat.com>
Date: Wed, 20 Mar 2024 09:56:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/7] configure: add --enable-qpl build option
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
To: Yuan Liu <yuan1.liu@intel.com>, peterx@redhat.com, farosas@suse.de
Cc: qemu-devel@nongnu.org, hao.xiang@bytedance.com,
 bryan.zhang@bytedance.com, nanhai.zou@intel.com
References: <20240319164527.1873891-1-yuan1.liu@intel.com>
 <20240319164527.1873891-4-yuan1.liu@intel.com>
 <a7e38ec4-641f-409b-86d7-ea09d9ac1b18@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <a7e38ec4-641f-409b-86d7-ea09d9ac1b18@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
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

On 20/03/2024 09.55, Thomas Huth wrote:
> On 19/03/2024 17.45, Yuan Liu wrote:
>> add --enable-qpl and --disable-qpl options to enable and disable
>> the QPL compression method for multifd migration.
>>
>> the Query Processing Library (QPL) is an open-source library
>> that supports data compression and decompression features.
>>
>> The QPL compression is based on the deflate compression algorithm
>> and use Intel In-Memory Analytics Accelerator(IAA) hardware for
>> compression and decompression acceleration.
>>
>> Please refer to the following for more information about QPL
>> https://intel.github.io/qpl/documentation/introduction_docs/introduction.html
>>
>> Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
>> Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
>> ---
>>   meson.build                   | 16 ++++++++++++++++
>>   meson_options.txt             |  2 ++
>>   scripts/meson-buildoptions.sh |  3 +++
>>   3 files changed, 21 insertions(+)
>>
>> diff --git a/meson.build b/meson.build
>> index b375248a76..bee7dcd53b 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -1200,6 +1200,20 @@ if not get_option('zstd').auto() or have_block
>>                       required: get_option('zstd'),
>>                       method: 'pkg-config')
>>   endif
>> +qpl = not_found
>> +if not get_option('qpl').auto()
> 
> Do you really only want to enable this if the user explicitly specified 
> "--enable-qpl" ? Otherwise, I think this should be:
> 
>   if not get_option('qpl').auto() or have_system
> 
> ?
> 
>   Thomas
> 
> 
> 
> 
>> +  libqpl = cc.find_library('qpl', required: false)

... and it should use "required: get_option('qpl')" in that case.

  Thomas


>> +  if not libqpl.found()
>> +    error('libqpl not found, please install it from ' +
>> +    
>> 'https://intel.github.io/qpl/documentation/get_started_docs/installation.html')
>> +  endif
>> +  libaccel = dependency('libaccel-config', version: '>=4.0.0',
>> +                        required: true,
>> +                        method: 'pkg-config')
>> +  qpl = declare_dependency(dependencies: [libqpl, libaccel,
>> +        cc.find_library('dl', required: get_option('qpl'))],
>> +        link_args: ['-lstdc++'])
>> +endif
>>   virgl = not_found
> 


