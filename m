Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC5FBC3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 12:02:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRsUd-0002mI-RQ; Thu, 11 Jul 2024 08:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sRsUU-0002Cv-Ky
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 08:01:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sRsUS-0001Yh-Ah
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 08:01:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720699294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0gLwoj1SXkAY24T0lSJw6CNEkseyTtyBXiw1QYbOZpI=;
 b=HGlYET40jZBUPBfJoEyo8TpFTKPjOKGV07WULWmP9QXbw6OQazz24TVQKglgc5XUKI284c
 6P4C7DHWN+1A6yj4jNRdjvm0CtCjxbcc39gVPfZcLmQONcp/MiI2rVpKsc1niO4hPGJs1j
 a16itIDV/yXJSv5WwHKSNUlKo2kDngI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-HwOQ-g0TMI-vbKkXgxOA8w-1; Thu, 11 Jul 2024 08:01:32 -0400
X-MC-Unique: HwOQ-g0TMI-vbKkXgxOA8w-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-79eff210166so115802985a.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 05:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720699292; x=1721304092;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0gLwoj1SXkAY24T0lSJw6CNEkseyTtyBXiw1QYbOZpI=;
 b=NSZO4HtEZ7Qbh+Co3YQi/wLty4ImN9ra3XDZXxzQzIADP6ZINotVltjk7Tdx6u6/AK
 /zSn7omhiEVZmSX/at4/f0fyTAy4CDR1xDO7PBi8E+3xUyh1VmY30s8MxOqIXpYRmmQK
 dDO4x051KSh5Ihef1ozKvdBHInphcEjE53robSJ2Am5bKwn0N/ScEfOSkno5s0VdveF8
 XWrYlK7GjheU5JThiTQqxJCILSOb4PrXjEe3Rp2uC9tQeqb47gy39Enin7ah8mf3rnOm
 LVQ1VThyvrroQoFWt0/CobhU6O1PID77od74CpaFqMgnFjHQvX57nUzy/uzclVojluYQ
 pMFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcE7pnErLSQrLVez0QZBWLll+ApjosQPC0VfAad1PpYXPnOzU6aVBf3GsElQx0PFvELu2smjsYMqgOQp1SQsJE9VLG8l4=
X-Gm-Message-State: AOJu0YzBk4rQ5bGuHQs9EvdzHKJ/vRTt2uqrvucAS6ZQRHd5jyu4D1OX
 NFihHBqOSdMufUXkJxnfTYHajF4Auj7tU56qoYkIwQENOPqybcOxxPPWtaa2Kkc7Jjcsc96PLJB
 NmvEfKdG8/qrdgtxoaRMP9VYw5aA3DiKa0hGZRgpCUw7Qv6QcMRHQ
X-Received: by 2002:a05:6214:1c8e:b0:6b5:d7a1:ead7 with SMTP id
 6a1803df08f44-6b61bca4338mr98782416d6.14.1720699291749; 
 Thu, 11 Jul 2024 05:01:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaMa3EAPriILFgpD4+UGXbE/gZO/D8VEBpw73r41gAInBVax61AjRrQYULIZQ3gCdOnBr0IQ==
X-Received: by 2002:a05:6214:1c8e:b0:6b5:d7a1:ead7 with SMTP id
 6a1803df08f44-6b61bca4338mr98782236d6.14.1720699291384; 
 Thu, 11 Jul 2024 05:01:31 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-50-229.web.vodafone.de.
 [109.43.50.229]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b61ba8ab80sm24661676d6.113.2024.07.11.05.01.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jul 2024 05:01:31 -0700 (PDT)
Message-ID: <4aa7d5cd-259b-4b63-9ce2-b73c9027848f@redhat.com>
Date: Thu, 11 Jul 2024 14:01:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Avocado 88.1 vs Python 3.12
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>
References: <6d22c5c5-cab0-49d3-88a8-3dd34c8c4938@linaro.org>
 <56ef21cc-f2e3-42df-a114-b7368c77253b@linaro.org>
 <5aa7be9d-1ce1-4448-97c4-fb0d5c4c0985@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <5aa7be9d-1ce1-4448-97c4-fb0d5c4c0985@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/07/2024 01.45, Richard Henderson wrote:
> On 7/9/24 09:26, Philippe Mathieu-Daudé wrote:
>> On 9/7/24 17:41, Richard Henderson wrote:
>>> Hi guys,
>>>
>>> I have reinstalled my development box to ubuntu 24 (because the Rust 
>>> support is better than my previous install; ho hum).  I thought I had 
>>> tested everything in a VM before committing, but I missed out on Avocado:
>>>
>>>>   AVOCADO Downloading avocado tests VM image for aarch64
>>>> Failed to load plugin from module "avocado.plugins.list": 
>>>> ModuleNotFoundError("No module named 'imp'") :
>>
>>
>>> If I understand things correctly, the python "imp" package was 
>>> deprecated, and has been removed before v3.12.  This is fixed in upstream 
>>> avocado as of v93.  But we have a hard stop in pythondeps.toml at v92.
>>>
>>> Remind me what the blocker is to upgrading?
>>
>> IIRC we're waiting for v2 of:
>> https://lore.kernel.org/qemu-devel/20231208190911.102879-1-crosa@redhat.com/
> 
> Yes indeed.  There are two minor conflicts in rebasing this branch, but 
> otherwise it works.  Cleber, do you have time to pick this up again?

As an alternative, if nobody has time to work on that Avocado update, we 
could maybe also try to integrate the python-based tests directly with the 
meson test runner. A prototype can be found here:

  https://lore.kernel.org/qemu-devel/20240711115546.40859-1-thuth@redhat.com/

  Thomas


