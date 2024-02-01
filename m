Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83329C4828C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 13:47:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVXOX-0005bU-2s; Thu, 01 Feb 2024 08:46:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1rVXOT-0005b7-Hy
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 08:46:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1rVXOQ-0002Ao-UA
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 08:46:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706795173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZnWg0qluTscQcGCgWuSCGrjw6wta2H09onDP5jzUyzc=;
 b=TNIoiHrcBnZZiLIld+g9TLIxv4q3oY83SC7swuR3M/VF/fxjlnTCUMmFdptCzJyHwjyVh2
 JUW3XVY1ae4WJviNZjlADxB3BQhKrGjG67ZWHtnqBPlY4bP7XNtdFef3YUT/S21u0pqoCh
 1Fw5Du69VtOBLfAwPm7VRfbi0aH17CI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-WbiL6VuHNKGT92rDBe-W9g-1; Thu, 01 Feb 2024 08:46:11 -0500
X-MC-Unique: WbiL6VuHNKGT92rDBe-W9g-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-42ab80d5317so10172131cf.3
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 05:46:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706795171; x=1707399971;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZnWg0qluTscQcGCgWuSCGrjw6wta2H09onDP5jzUyzc=;
 b=KKnkJH7fcapkKMsKVF1PGf3jOYIXHwBwtj4WDZmFW01YqCc9hoJLxVX79OGJOa5t0o
 E+d23wdKMU3avpWcnT4hrplMA3MRaCacjp4WWKXfu7p7b9kLxD8d95i71+xmO3C6cyj9
 dm5cF4TAA6rVbOLuo0oH+VBr8TOcRxIhus4gMSmuZXc2PMb59G5+5qP+s4s7qrDZodbI
 cDq0FaKmS00oBfPd4ZdAdp7AeeqB+jiBuAPXDteyBS6AemPhWk2r+jCSTWr6R8MDVo8h
 2VolIPdG+9fw2wpcMMeYGQ7iMvHiMrP3lo1UfhEmVSHNT/7dWvPzCoj+zmICXDp+FRn3
 0kjg==
X-Gm-Message-State: AOJu0YydSWXunlobZlmJNz50x3Nxxwkv9e598hCSEF3Z36rBP48oyAWJ
 x0klSvfT0wTBjb0xHlVUvaYX/eUBA9aHsABKrNa63Fon/TOoZLwEJMchGz3Lx89Nq8mqQkCOLea
 AGzb+G5herhpCYbbLBenetW1HZtc1lAgP4HCaIh3ZtTTePSA1fN43
X-Received: by 2002:a05:622a:48e:b0:42b:ff2:639b with SMTP id
 p14-20020a05622a048e00b0042b0ff2639bmr5427979qtx.9.1706795171261; 
 Thu, 01 Feb 2024 05:46:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeK3q58LNAm0gxWqciJ8052o9LhPo8ZLRHRQSmoXdgz0RAuVX0MfoisTDZ87xG7OTQABQJig==
X-Received: by 2002:a05:622a:48e:b0:42b:ff2:639b with SMTP id
 p14-20020a05622a048e00b0042b0ff2639bmr5427969qtx.9.1706795170941; 
 Thu, 01 Feb 2024 05:46:10 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWQv5liLhsXXI/Fg2dh/u3kQPmnjBfYGUHTShvlYF08l0ufttkBvD7YVowhjD6IUJPKBEMh6AXnkLdUgrr6IP3BDPwk/fugYKgfSI2su6lDPXpbucyeKj4a7g==
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ez13-20020a05622a4c8d00b0042bf33fa059sm667761qtb.45.2024.02.01.05.46.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Feb 2024 05:46:10 -0800 (PST)
Message-ID: <d5085c5a-d31d-4210-a500-f1e3687b97a1@redhat.com>
Date: Thu, 1 Feb 2024 14:46:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/pci-host/raven.c: Mark raven_io_ops as implementing
 unaligned accesses
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>
References: <20240112134640.1775041-1-peter.maydell@linaro.org>
 <eaf71668-fe0d-45db-817e-fe052df91c17@redhat.com>
 <CAFEAcA-jV1z0M+i=pjrgJ6DJc2ofnjeSvUqtkpxzWVbU1S3gWA@mail.gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <CAFEAcA-jV1z0M+i=pjrgJ6DJc2ofnjeSvUqtkpxzWVbU1S3gWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SORBS_WEB=1.5,
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

On 2/1/24 14:32, Peter Maydell wrote:
> On Tue, 23 Jan 2024 at 11:03, Cédric Le Goater <clegoate@redhat.com> wrote:
>>
>> On 1/12/24 14:46, Peter Maydell wrote:
>>> The raven_io_ops MemoryRegionOps is the only one in the source tree
>>> which sets .valid.unaligned to indicate that it should support
>>> unaligned accesses and which does not also set .impl.unaligned to
>>> indicate that its read and write functions can do the unaligned
>>> handling themselves.  This is a problem, because at the moment the
>>> core memory system does not implement the support for handling
>>> unaligned accesses by doing a series of aligned accesses and
>>> combining them (system/memory.c:access_with_adjusted_size() has a
>>> TODO comment noting this).
>>>
>>> Fortunately raven_io_read() and raven_io_write() will correctly deal
>>> with the case of being passed an unaligned address, so we can fix the
>>> missing unaligned access support by setting .impl.unaligned in the
>>> MemoryRegionOps struct.
>>>
>>> Fixes: 9a1839164c9c8f06 ("raven: Implement non-contiguous I/O region")
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>> Spotted by code inspection: I was looking for devices whose behaviour
>>> might be changed by a patch I'm reviewing that adds that missing
>>> support for unaligned accesses in the core memory system. But even
>>> if we do implement it there, it's more efficient for the raven MR
>>> to correctly mark it as handling unaligned accesses itself.
>>>
>>> Tested with 'make check' and 'make check-avocado' only.
>>
>> It doesn't affect the prep machine boot with OpenBIOS and a
>> "Debian GNU/Linux 3.0 6015" image.
>>
>> Tested-by: Cédric Le Goater <clg@redhat.com>
>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> 
> Thanks for the review -- is this patch going to go via a
> ppc queue, or should I throw it in with my upcoming
> target-arm pullreq?

Please take it through target-arm. PPC is in low power state AFAICT.

Thanks,

C.




