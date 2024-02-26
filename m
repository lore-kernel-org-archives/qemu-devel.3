Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A1EC54E41
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 06:56:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reUuS-0006RP-27; Mon, 26 Feb 2024 01:56:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1reUuP-0006Po-Bx
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 01:56:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1reUuN-0001QW-Lh
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 01:56:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708930574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=CzTidy1Z8ZWm5Q8py8tT8wEg+RhoD/kYjFQJPO/ACPM=;
 b=cF8OC2m5yQXR7bNI2rfregQZdXh0MSqcuCE1JMCPhju7HaOT9yrR38DytkYox+xBBlDrY5
 Xadfl7ndfuFX0NLasdAvglREHN7nZslJTKNXko5ocxRihPV6fPJ673+tNmxfbtKJcIVWOF
 9BCpEmHoAGAfn0a1LWyo8BHGodpH2Ag=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-L8eoZdEROQ-Xft-0JsENig-1; Mon, 26 Feb 2024 01:56:13 -0500
X-MC-Unique: L8eoZdEROQ-Xft-0JsENig-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33dcd5d117fso264482f8f.1
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 22:56:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708930572; x=1709535372;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CzTidy1Z8ZWm5Q8py8tT8wEg+RhoD/kYjFQJPO/ACPM=;
 b=fY5fuF7+gRn/VoF6FdoCa7vU35X7ZfOC7B9OZgkyXEwkhFu6rs+3xmoKco6KM5BaMo
 7PFiuZ94K3/bHfVyJvlZsZL4j5/gQ00WfcSCi0tW4KAjv6RDKTlgRLe7pZ8hsUEzpFqr
 9E1bC43Tm1VQRYitSoLo/J00PyGOPvgibAfVl3wY0F4M/RzzVr+pO8re4yEzLo2ed2zg
 6FDaJry8ucHPvv5ENa8bp+Kw2odtJ+gg1uwy8qh4YLc5ds7cEWW+D6M12VCOHWJfbve/
 oZlASVKxBQKgoK4tT7vKWMxSJbvUg6OzYMDbl1u6rl0lgaqA5qFo8UmPrBbrXKlP5FOE
 KvQA==
X-Gm-Message-State: AOJu0YxoPj9YGC8qwhVIZUzyYB7ZYioLpaR/Dy0SE+70gGEyPjt45Lwh
 C6900VzvirARrl29XxU/OaMHRpysCw+FnOXn2xVZZ7gFk73fTo7lbOPZT/Mcoh+lFQeflEpEyG2
 4hKmf5b6lVmFp7HEKG0bwbMxbqDNTEaqwRkmXkLxCyF5s58jZElLf
X-Received: by 2002:a5d:468a:0:b0:33d:1d3a:4412 with SMTP id
 u10-20020a5d468a000000b0033d1d3a4412mr4755097wrq.12.1708930572427; 
 Sun, 25 Feb 2024 22:56:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHj+lM2xMyIRsIfk6K4BWNgOmlenIzi9I0+W9KS4WCV8Rzy/b9v7daTJI4Sa5qrGY9aEYlUZA==
X-Received: by 2002:a5d:468a:0:b0:33d:1d3a:4412 with SMTP id
 u10-20020a5d468a000000b0033d1d3a4412mr4755089wrq.12.1708930572161; 
 Sun, 25 Feb 2024 22:56:12 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-176-215.web.vodafone.de.
 [109.43.176.215]) by smtp.gmail.com with ESMTPSA id
 g9-20020adfd1e9000000b0033cf4e47496sm7328171wrd.51.2024.02.25.22.56.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Feb 2024 22:56:11 -0800 (PST)
Message-ID: <3f32c4ba-b958-4892-8c35-874593f79fc6@redhat.com>
Date: Mon, 26 Feb 2024 07:56:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] hppa: do not require CONFIG_USB
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, philmd@linaro.org
References: <20240223124406.234509-1-pbonzini@redhat.com>
 <20240223124406.234509-6-pbonzini@redhat.com>
 <50972788-77b0-4494-b956-367e227575b6@redhat.com>
 <ab8ce4b2-d0c4-867e-44cf-44137e91a610@eik.bme.hu>
 <CABgObfaTc47kf7L5Jyh75KA__Jfzb-0cmOEwCRbPHOT8f=7qUQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CABgObfaTc47kf7L5Jyh75KA__Jfzb-0cmOEwCRbPHOT8f=7qUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 24/02/2024 23.38, Paolo Bonzini wrote:
> On Fri, Feb 23, 2024 at 8:56 PM BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>>> -    if (!lasi_dev && machine->enable_graphics) {
>>>> +    if (!lasi_dev && machine->enable_graphics && defaults_enabled()) {
>>>
>>> Do we need the defaults_enabled() here? Isn't enable_graphics already
>>> disabled if defaults_enabled() is not set?
>>
>> Isn't enable_graphics controlled by -nographic and defaults_enabled
>> controlled by -nodefaults? I think they are independent but maybe that
>> does not answer the question if it's needed or not.
> 
> Indeed they are different. The idea is that if graphics are disabled
> you interact with a serial console so you don't need keyboard or
> mouse; and if default devices are disabled of course you create as
> little as possible and leave everything to the user.

Indeed, I just double-checked and they are independent, sorry for 
mis-remembering that.

  Thomas


