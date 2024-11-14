Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA027D68B03
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 12:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBZOI-0006z5-NE; Thu, 14 Nov 2024 07:56:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBZOG-0006ua-Ge
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 07:56:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBZOF-0006c4-4F
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 07:56:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731588962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LvwPSYVMMlt45joT6Tkvv6VROB33AoxENjWxrjiuWMI=;
 b=KTDPA7XkK5JHnsKrF5qItfXUbJIi7iz9+DnVwfozTM+lh/t3pQVkIGJJABhR0OCsechVwI
 JwmzbxZ9ewE5r8YTEf9ZhjY8srsKojC/cqphUh1H1dprWT17CwhIIiVeZ5s6VIRf3HQeOv
 DkyfhXcK4G5A0Uq5RC8qqnQfgfLv9Hc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-mf870yM0NReJqYPVW41GDA-1; Thu, 14 Nov 2024 07:56:00 -0500
X-MC-Unique: mf870yM0NReJqYPVW41GDA-1
X-Mimecast-MFC-AGG-ID: mf870yM0NReJqYPVW41GDA
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d4854fa0eso423141f8f.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 04:56:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731588960; x=1732193760;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LvwPSYVMMlt45joT6Tkvv6VROB33AoxENjWxrjiuWMI=;
 b=vrTEk6Tch2jyqTt59PpMIqj25RZD5AbEl468XP8iX/NaQ0aJAwlfXkv42Oq5ebgVBO
 Yk5d0xoIDT7gQMDODfv6QY4v4Eedopv9/OkhSdLrwcbJVOQ3f84wj9b1yIQLFj+PnRp+
 jwsh7GWrt4xYMLsxtKX/gIBodaZPlGG1/Xqh1Qb2wl4BCfOiVxXtERkRGUWTOL4oTGrM
 nS9E3SsTRITqr8JwKaFq1jzEnSEHhKhDlUfYRIIVyMf9acBGJOJTScGb8WAsBNnfk6vK
 xj6nD8H+bFYwaQOqastJrli6Qg4Ua0JJWvZ+Mrv4et8C/c3jiZ5IBw2MhLQ9m8YuT1+x
 hw8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXulEO3BjNi/Pf8KsPDIu8JaT9FUDzQSg9plyIzemTSne4sv7e6vw3Q/MUnWSH5hsSsC+aX64qHFqw7@nongnu.org
X-Gm-Message-State: AOJu0Yx+zlKV2VeDV4aEkb0Ceda0m4dccYd7q+cfZcqg5pUA4wk3N7x+
 KxQ4oUbJrcWPADccoZMh4SVUkQOnpstcTEVCUoe4tG/6zFKtCuP/4QAw9SuWhVX743rHqSVO939
 LkebngvzkxZW58B95jLVyDS6D2m8XSSSbqjLkJ0DMQzhf1I6Gpx2e
X-Received: by 2002:a05:6000:799:b0:382:d7a:315b with SMTP id
 ffacd0b85a97d-3820d7a319fmr6218473f8f.11.1731588959732; 
 Thu, 14 Nov 2024 04:55:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3Jf8bx5Ti46Cxl4LDQhr5D0OFAw6DOnqBw9ISJhNeTvL3m3vKRmBhMGyxzoOxReyiNVOzNA==
X-Received: by 2002:a05:6000:799:b0:382:d7a:315b with SMTP id
 ffacd0b85a97d-3820d7a319fmr6218458f8f.11.1731588959351; 
 Thu, 14 Nov 2024 04:55:59 -0800 (PST)
Received: from [192.168.10.3] ([151.49.84.243])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3821ae2f651sm1451121f8f.87.2024.11.14.04.55.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 04:55:58 -0800 (PST)
Message-ID: <34bbd871-3050-48b3-8a5c-3d8e1c73816b@redhat.com>
Date: Thu, 14 Nov 2024 13:55:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: hyperv: add stub for
 hyperv_syndbg_query_options
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20241114121555.1697250-1-pbonzini@redhat.com>
 <a3ad589c-26f8-46b9-b3b0-967ad9620768@tls.msk.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <a3ad589c-26f8-46b9-b3b0-967ad9620768@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.69,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/14/24 13:41, Michael Tokarev wrote:
> 14.11.2024 15:15, Paolo Bonzini wrote:
>> Building without CONFIG_HYPERV is currently broken due to a missing
>> symbol 'hyperv_syndbg_query_options'.  Add it to the stubs
>> that exist for that very reasons.
>>
>> Reported-by: Michael Tokarev <mjt@tls.msk.ru>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Rewviewed-by: Michael Tokarev <mjt@tls.msk.ru>
> 
> I'm a bit confused though, - why a stub is "better" than an #ifdef,
> especially in such simple cases?

To be honest the #ifdef was the first thing I did (#ifdef 
CONFIG_HYPERV).  I switched to the stub just to avoid doing the same 
thing in two different ways.

In general I prefer stubs because they put all the code in one place. 
For example there is a benefit, which doesn't apply here, when you have 
stubs with Error** arguments.  Then it's easier to make the error text 
consistent.

Paolo


> Restoring the #ifdef around this place fixes the build.
> I understand if the function in question were used in lots of
> places around the code, but here it's not the case.
> 
> Another option would be, instead of stubs, to use:
> 
> #ifndef CONFIG_SYNDBY
> #define hyperv_syndbg_query_options() 0
> #endif
> 
> which will make stubs unnecessary entirely.
> 
>> ---
>>   target/i386/kvm/hyperv-stub.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/target/i386/kvm/hyperv-stub.c b/target/i386/kvm/hyperv- 
>> stub.c
>> index 3263dcf05d3..5836f53c23b 100644
>> --- a/target/i386/kvm/hyperv-stub.c
>> +++ b/target/i386/kvm/hyperv-stub.c
>> @@ -56,3 +56,8 @@ void hyperv_x86_synic_update(X86CPU *cpu)
>>   void hyperv_x86_set_vmbus_recommended_features_enabled(void)
>>   {
>>   }
>> +
>> +uint64_t hyperv_syndbg_query_options(void)
>> +{
>> +    return 0;
>> +}
> 
> Thanks,
> 
> /mjt
> 
> 


