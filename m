Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B25FE7719B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 07:08:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTbmP-0007x1-0x; Fri, 03 Jan 2025 02:07:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTbmK-0007we-Bc
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 02:07:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTbmH-0001yk-VA
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 02:07:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735888043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=geBIPLcV2FBCwntuhU2GAvx8N2+g3wcArPxuaoR9Cus=;
 b=LNF5E98A5soXs//MFP3v34b6IrOyP7Ew4gNzF6YDL9ldA83COdhNyCF0OQQDQ3qHxaW+vY
 MkkKbGq8XP+kFOvynxY2bOZ8F/MPhucjBIti7eEP/mA5aq3gKnP0ovU84croQ7BvMF0WTm
 C4anpmt0Mw9qeH7GZRWpMoz4hcTgL4c=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-mmsYeJilPLeduF1q0wfKzg-1; Fri, 03 Jan 2025 02:07:21 -0500
X-MC-Unique: mmsYeJilPLeduF1q0wfKzg-1
X-Mimecast-MFC-AGG-ID: mmsYeJilPLeduF1q0wfKzg
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5d3eea3b9aaso9838252a12.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 23:07:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735888040; x=1736492840;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=geBIPLcV2FBCwntuhU2GAvx8N2+g3wcArPxuaoR9Cus=;
 b=Iyzz74gQeYNUBCf1eakzAAMfznlbcT6MrEdVk6bMkUHXKR1hgVM/nAIgCWKBndNaVz
 IHHUr89jzao9FZgz7fMAQ/RvNG+0AoX8GwBcw8ehWWWPgyIhTPYAID6FKrhReWS4ritP
 Mjrwyd4sBlgPsmPiHYHA8M4U7CK/I72pAU//p3vauehdxNE2+idO0boo8/fIeHVgb5N6
 mWNJ86twhhJizu5AOAIIwO3ksDnmf1WG/OSlxKd0KedY2RON4OOH7Azck/nmNOqQGIU+
 pquD4azWaEOtspFTj3sF4P73KZ5270bMsqiFVUgt4gDYVI8HH0iajyaUGlErpppI8/om
 QRkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7riGDXfjFoQstZYzqW+yckbU0U/+s/d8mAXJ1j69QR5w3vwu2asL7EAbwfWf/6gdJnOcGCSM7djfl@nongnu.org
X-Gm-Message-State: AOJu0Yyt9+FXGeHXuwtgbMcRoM4B5m6oMrGhYdDr9MAiBUcQH9KYipCF
 IB4jTcE/fhEexM/ccLbsXAzuEZ6+ms4W7jovhkeNEucIsbrwQYPQr1z3b68veAqoCRjJBZrdY1r
 em21lmTfJVq/vdgQVJfxfvApmK0a5+bqjQEz/SLPAbFhayd5qZwdm
X-Gm-Gg: ASbGncscgD2jeHPNyjtjpIGrlfAGtiJjUQIikZfxdOi5mPV7eqBIfRaYIym9hlUU9GH
 xWg6V7MqPvB3VcoZkX2r6GC3qdG4+sEl5p/G0zk5FPM6Gc7NnRH7eaNMyGnFOqJXam7pMRcMluX
 gONSGr4OTw1u/WfKqtLNkopgvQIuIvaTd6KguQW1uimiZbiIELn9PtwbOfJLld1il4L344b5+ns
 7YFbdsi/dawI37CnTx0yB164nVWck82y35VanIG2CDMkYrXxndp8Qslf0zf5Kk6W9wFxRL2/g9i
 hyry856TVnQV
X-Received: by 2002:a05:6402:210f:b0:5d0:cfad:f71 with SMTP id
 4fb4d7f45d1cf-5d81de1c921mr109557243a12.32.1735888040221; 
 Thu, 02 Jan 2025 23:07:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFN2ovi17VoVV3YvF5quk9AZnPDi3/0yw7lw5e4qGZeQpR0TEJ6kUbY0iionhRsb8mmuZ1vZg==
X-Received: by 2002:a05:6402:210f:b0:5d0:cfad:f71 with SMTP id
 4fb4d7f45d1cf-5d81de1c921mr109557216a12.32.1735888039871; 
 Thu, 02 Jan 2025 23:07:19 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-148.web.vodafone.de.
 [109.42.51.148]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e830b9esm1859222366b.36.2025.01.02.23.07.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jan 2025 23:07:19 -0800 (PST)
Message-ID: <5c47e871-c753-4244-aa24-39a9e0a9d5f8@redhat.com>
Date: Fri, 3 Jan 2025 08:07:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: which test.hex is right for qemu-microbit?
To: Liu Jaloo <liu.jaloo@gmail.com>, qemu-devel@nongnu.org
Cc: joel@jms.id.au, Peter Maydell <peter.maydell@linaro.org>
References: <CAOYM0N2sXVBkPz64J44kFGPhdSq+qvheQD-yy53trAjv0NDh0w@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAOYM0N2sXVBkPz64J44kFGPhdSq+qvheQD-yy53trAjv0NDh0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 02/01/2025 06.49, Liu Jaloo wrote:
> in qemu branch statble-9.2
> 
>     $ ./build/qemu-system-arm -M microbit -device loader,file=/path/to/
>     heart-hearts-makecode.hex
> 
>     Segmentation fault

That's a bug of course - a segfault should never happen...

...
> according to docs/system/arm/nrf.rst
> 
>     $ qemu-system-arm -M microbit -device loader,file=test.hex
> 
> 
> from the page https://microbit.org/projects/make-it-code-it/heart/ <https:// 
> microbit.org/projects/make-it-code-it/heart/> download the hex file :
> 
>     wget https://microbit.org/downloads/heart-hearts-makecode.hex <https://
>     microbit.org/downloads/heart-hearts-makecode.hex>

... but if that one is failing, maybe the clue from 
https://wiki.qemu.org/Testing/Machines could help: It points to a mail that 
suggests to use https://ozlabs.org/~joel/microbit-micropython.hex for 
testing this machine.

  HTH,
   Thomas


