Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB8CC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 08:29:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmqJM-0001WI-Up; Tue, 25 Feb 2025 03:29:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tmqJK-0001Va-VB
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 03:29:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tmqJI-0005HA-8S
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 03:29:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740472137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/AHAEEBc0LS89VwVOulkfwztz2km81VTrWewgANp3K0=;
 b=hx+UvVk3lzuCzZnTaL0tDhQ8wWdAAG9owOc0jPSSK72WIJdFo1Jfs0M8m8fwE3GvTEFTwK
 macDKPDvX3oqpXz6R1YGGf3EgkKXj1W6iR9dTpMLTXixkZb4JR4ErLUdoER0bhsKSnR1ww
 wGuifU1wZAM3a/CXrCqNDQKGG0E1DHc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-r0JjdMWtN22oxxxF5zrJCA-1; Tue, 25 Feb 2025 03:28:56 -0500
X-MC-Unique: r0JjdMWtN22oxxxF5zrJCA-1
X-Mimecast-MFC-AGG-ID: r0JjdMWtN22oxxxF5zrJCA_1740472135
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-abb87e3a3c9so561718366b.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 00:28:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740472135; x=1741076935;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/AHAEEBc0LS89VwVOulkfwztz2km81VTrWewgANp3K0=;
 b=UZ939uSOt7D2LNvc3PVsapbr0ORAnJuxq0JMX5hfcAxspsNgGTVBDW3muKcoW4/n3T
 Bazr4CjYEeztUEKNqHbT6RAEcqZSdNZlYd4mszJQzRiIab8pcae+X01nk5DNp9X9MJ/f
 Ie9Y1XYwlWY1q1dgCSX09Pwm1ruaKNOEN/rMNH1vWzLMllKk8u0j+PhqwSSo595fnQkF
 FgI8/JzIYJMJhMc6K++IyvWDbclQsRM2XXPSlfY1ngPIKlscXnVZbXmP39in27iGm9QV
 eEzEs8UUiB20xJl/iMFLRZ5oefqa7wxK1AiR/j11oQ66jgAKrylMD43dloSR6YB5S3jf
 Fd3g==
X-Gm-Message-State: AOJu0YxkuBjL6WnkAdV95lbn9TJhFSx5vda69QWRcuRQdam1OjBcUhZM
 2YaF5dHeSiHNJZ8NA2H3KxCaKl4IyxxING9itV1aBIR1XbXZklW/unAF57f0WpoSx2Ylq9YOjBY
 XrZ+CP32WJvvR+1uPQRp6y2h3dlNkiIDteDJfgj52IqnANH+hdnG4
X-Gm-Gg: ASbGnctRZZHyvjP6cQ18pU1RKrwcJMO6BgA7ggoqRGfXryvm0MbfabAyzBTISxUrH88
 IYRI6CIkW0jTh6/wzDdl75vmilrbTee27etOoxqLjcg914cryOcNpOw2PXMRBQG6L9X0GOsZ4gl
 wAl9/q34w+GjDpAjwzUmTohLt/yBVuZorgIfD45n+7JDt6trdMggkC2AAoh4mi/y+cvB8M6+uqM
 2Mv74PQE6yqHlmG2EM3QtqLN/zsTWv0KUHnNy22qiXtM7hue3yjD/3it0cG3WnTRYGgbPWdjTLq
 2NnIi0MaF58npfaOGBiE
X-Received: by 2002:a17:906:6a2a:b0:abc:663:5fb4 with SMTP id
 a640c23a62f3a-abc09ab8b7amr1898264766b.33.1740472134772; 
 Tue, 25 Feb 2025 00:28:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvEgvfCf+uIu9V/w6OrLZ5r3WWWC80uO62Dq1mQromL12hwij3vN7liQ81s61vGHHjNeFC4w==
X-Received: by 2002:a17:906:6a2a:b0:abc:663:5fb4 with SMTP id
 a640c23a62f3a-abc09ab8b7amr1898261766b.33.1740472134331; 
 Tue, 25 Feb 2025 00:28:54 -0800 (PST)
Received: from [192.168.10.81] ([176.206.102.52])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-abed20b72bbsm100138266b.182.2025.02.25.00.28.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 00:28:53 -0800 (PST)
Message-ID: <a776b84b-dd3c-4e17-b89a-a745c1f89a83@redhat.com>
Date: Tue, 25 Feb 2025 09:28:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/15] rust: irq: wrap IRQState with Opaque<>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20250221170342.63591-1-pbonzini@redhat.com>
 <20250221170342.63591-10-pbonzini@redhat.com> <Z71+qiu+X4BKW2ja@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <Z71+qiu+X4BKW2ja@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/25/25 09:26, Zhao Liu wrote:
>> +/// An opaque wrapper around [`bindings::IRQState`].
>> +#[repr(transparent)]
>> +#[derive(Debug, qemu_api_macros::Wrapper)]
>> +pub struct IRQState(Opaque<bindings::IRQState>);
>> +
>>   /// Interrupt sources are used by devices to pass changes to a value (typically
>>   /// a boolean).  The interrupt sink is usually an interrupt controller or
>>   /// GPIO controller.
>> @@ -22,8 +28,7 @@
>>   /// method sends a `true` value to the sink.  If the guest has to see a
>>   /// different polarity, that change is performed by the board between the
>>   /// device and the interrupt controller.
>> -pub type IRQState = bindings::IRQState;
>> -
>> +///
>>   /// Interrupts are implemented as a pointer to the interrupt "sink", which has
>>   /// type [`IRQState`].  A device exposes its source as a QOM link property using
>>   /// a function such as [`SysBusDeviceMethods::init_irq`], and
>> @@ -41,7 +46,7 @@ pub struct InterruptSource<T = bool>
>>   where
>>       c_int: From<T>,
>>   {
>> -    cell: BqlCell<*mut IRQState>,
>> +    cell: BqlCell<*mut bindings::IRQState>,
> 
> Once we've already wrapper IRQState in Opaque<>, should we still use
> bindings::IRQState?
> 
> Although InterruptSource just stores a pointer. However, I think we can
> use wrapped IRQState here instead of the native binding type, since this
> item is also crossing the FFI boundary. What do you think?

Using the wrapped IRQState would be a bit more code because you have to 
cast the pointer all the time when calling C code.  As far as 
correctness is concerned, it does not really matter because as you said 
it only stores a pointer.

However, if needed, InterruptSource could have a function that converts 
from IRQState to Option<&Opaque<irq::IRQState>>.  Since the accessor is 
needed anyway, that would be a good place to put the conversion.

Paolo


