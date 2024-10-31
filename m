Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 740C5E68974
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 10:46:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6SgF-0006Id-6D; Thu, 31 Oct 2024 06:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t6Sfv-0006DP-9O
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 06:45:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t6Sfn-0008SB-Af
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 06:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730371500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NTZJYLfvhuk4k62IKYVeRKCBya4JzreOpI4SwpaNtNA=;
 b=BUP9b6aU9B48Hh2EyjTEExPPFkRGodJiVN4Id+dJZ+tZLV0IYTCk9pXdfs7hLwUQSkqGWy
 i3TNv/zta7hC8Nc7gCg/bifADDnbNjxyegWTPjmhrnNR2SlqGtZ0MdaQQxaJwnXw1QOhu0
 PANdQ/sE+O+m1RZQ028HnbzPd4TxVR4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-yxcarqcHNQ-b0JCaoxB7bg-1; Thu, 31 Oct 2024 06:44:57 -0400
X-MC-Unique: yxcarqcHNQ-b0JCaoxB7bg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43159603c92so5245755e9.2
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 03:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730371497; x=1730976297;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NTZJYLfvhuk4k62IKYVeRKCBya4JzreOpI4SwpaNtNA=;
 b=VuuUfnw6sRY9ICtWbfHVhKCSqFei1oH1cZXmcv7sm+gmvZyNceocQr6Rcj65uEZ0E5
 CUUMz8OI2B1UKryjvkel8E2dV6LJnkDb+xfjP0PEq4bxXZpVkdPiV9bk6VNOVEs+hlg+
 93CTJvSQEx9JWufy/ohmoCZ0qUcpqKLRVnCZ6V3a6FoFxgqtdRg6numON4L94vxXmtl0
 oPFJ1FPvAWqPJWlK14/9+/gpna7W2+pB4/FCe+FiMu2Y3sWgi5IJ/qwRL68iXtZtVJBN
 CjS085RWOVsy7e+nXeHaR/kBswLVxlyyRYNxRTWbUXkUgAxX/mRiZYoR87+loArmOtpk
 l8TQ==
X-Gm-Message-State: AOJu0YwjRhH6D5T6+rEmaBf1T3sqIdlM96S/pQ0sovVTw4wvAtRaVD22
 RCuVKU/90W0aIezdGR3e/m1xmmif2kZiNKB7HURuiqtOOVk14Ntk8qgDtWBHneV2pUD5zRMF+Ww
 X0sG79rpyI4uEMJ/z9ivKdW3Rj+wwADMjWeVyZgCvAQXp3Ov3uUxg
X-Received: by 2002:a05:600c:458f:b0:42b:a7c7:5667 with SMTP id
 5b1f17b1804b1-4319ad02659mr165779905e9.25.1730371496684; 
 Thu, 31 Oct 2024 03:44:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQ4jbzo10xAXi13IAPesb3Z/9olChn5BWY+K/Cj77z8QG1w8OdBAxv2d0I9vWQKMJ+PRbi3g==
X-Received: by 2002:a05:600c:458f:b0:42b:a7c7:5667 with SMTP id
 5b1f17b1804b1-4319ad02659mr165779685e9.25.1730371496246; 
 Thu, 31 Oct 2024 03:44:56 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-48-251.web.vodafone.de.
 [109.42.48.251]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd9ca704sm52073865e9.41.2024.10.31.03.44.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Oct 2024 03:44:55 -0700 (PDT)
Message-ID: <e7e2f194-601c-4c26-bc51-1fc786f06aa2@redhat.com>
Date: Thu, 31 Oct 2024 11:44:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] win32: use compiler option instead of attribute
 gcc_struct
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Konstantin Kostiuk
 <kkostiuk@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20241031040426.772604-1-pierrick.bouvier@linaro.org>
 <20241031040426.772604-8-pierrick.bouvier@linaro.org>
 <ZyNNrKi2Of8j5WEh@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ZyNNrKi2Of8j5WEh@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 31/10/2024 10.28, Daniel P. Berrangé wrote:
> On Wed, Oct 30, 2024 at 09:04:21PM -0700, Pierrick Bouvier wrote:
>> This attribute is not recognized by clang, but the associated option is.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   meson.build                               | 8 ++++----
>>   include/qemu/compiler.h                   | 7 +------
>>   subprojects/libvhost-user/libvhost-user.h | 6 +-----
>>   3 files changed, 6 insertions(+), 15 deletions(-)
>>
>> diff --git a/meson.build b/meson.build
>> index d8af08299e0..d0d5dbe1479 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -330,10 +330,10 @@ elif host_os == 'sunos'
>>   elif host_os == 'haiku'
>>     qemu_common_flags += ['-DB_USE_POSITIVE_POSIX_ERRORS', '-D_BSD_SOURCE', '-fPIC']
>>   elif host_os == 'windows'
>> -  if not compiler.compiles('struct x { int y; } __attribute__((gcc_struct));',
>> -                           args: '-Werror')
>> -    error('Your compiler does not support __attribute__((gcc_struct)) - please use GCC instead of Clang')
>> -  endif
>> +  # https://gcc.gnu.org/onlinedocs/gcc/x86-Type-Attributes.html
>> +  # We use this compilation option instead of relying on gcc_struct attribute
>> +  # because clang does not support it (but supports the option).
>> +  qemu_common_flags += ['-mno-ms-bitfields']
>>   endif
> 
> Is this really safe for us to use ?   The current gcc_struct
> attribute affects only structs marked as QEMU_PACKED. This
> flag will affect all code.
> 
> If we call from QEMU code into Windows native APIs, and pass
> or receive structs, then those structs' layouts would be
> affected by this flag. I don't have a specific example, but
> this feels unsafe to me, otherwise we would have done this
> originally rather than only targetting internal packed structs
> with the gcc_struct attribute.

I agree with Daniel, we likely cannot use this switch globally.

But seems like Clang folks are trying to include support for the attribute, 
see: https://gitlab.com/qemu-project/qemu/-/issues/2476#note_2159643081
so I'd rather recommend to wait for that for proper Clang support here.

  Thomas


