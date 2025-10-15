Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D32CCD193
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 10:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8z2E-0004LU-LM; Wed, 15 Oct 2025 06:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v8z2A-0004ID-56
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 06:47:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v8z20-0004aX-J1
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 06:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760525200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mt4oFQ22T1RIJhewU0+cZJJ9T5BXMeU28BF9Chsfg/c=;
 b=jCr8rjRVJ6yJD22vIHNmkNLigUMdgE6RKmktaWIFfmemV5O8qP4dlfrxSEcHthPGPR29Kk
 9a7oamqZoPn0K19pAGdkzpB8PYehQfjUPjrXo89zk60tx4GfDWjeq4UdTNy2A0eQMvBmar
 Hy586jiLT0xcO8KU4LTPHtmXirM3vvY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-IqWVcGffN56yVELKODxccg-1; Wed, 15 Oct 2025 06:46:39 -0400
X-MC-Unique: IqWVcGffN56yVELKODxccg-1
X-Mimecast-MFC-AGG-ID: IqWVcGffN56yVELKODxccg_1760525198
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3ee888281c3so1467939f8f.3
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 03:46:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760525198; x=1761129998;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mt4oFQ22T1RIJhewU0+cZJJ9T5BXMeU28BF9Chsfg/c=;
 b=u12493GQ7podJ7YtXMo95CMW+S6j+WQ9TRmAm1Y+96meeOUaw5zoumqvHu0c8fiQFz
 +HpZpBsz6mxfcG5ngQrBKV1nT5+5jrr1Q1k20TVb6djtlAAEZqMddmjXSg+96LcmiGY2
 0/yplwybx8rpDLEB57MTFpkWwZZDUMsP5eGA1CbWB4FJTB4H5reFhnMgV+K+3emKsGC0
 xybUsyzq2clIgZxQLmLU1jyGBaOx2FKllCar5cQ5VXsaQ8+5L+DOELF+Kd7S0f35YYDg
 X2huGjJXYZhnrBKherTnkd4GxQAHh/OwToRsCEA3bS3S2QKOCZCde5ZFL2fB79Rq2Kuf
 Yyew==
X-Forwarded-Encrypted: i=1;
 AJvYcCWx6NzcadTquNssh9+kqFRGH3KYpiD3GN5AFPqHLvmGvBhMrFufATytMpMVULzlzKRgAzemisxPtcLT@nongnu.org
X-Gm-Message-State: AOJu0Yxk++WGa9TtW44nwNXyLyxpEgwxQmq8v0WnNTZaFvcCWThd6Kw+
 rsCkdQoK9QgNdrC1XX+D6QWxZMeKD+9Qmu0mpHRODKH951VT0LApKFnVK7WYw4qDfTMum3camYb
 6Xzy78D0/mnF9l824WQ94f8rZMmNPyiHQ+gmAPfEG1yHFObrBQGtwA9dN
X-Gm-Gg: ASbGncvwX7Cp2xjf0SuuobEZK+88HhGeMRgRar0r2eTweuGVqy46/Qn/a+9MTcZXp2U
 M3KNfRA0WMtGcBpx+qfNpFol7louf84mAN6VrhsjFT0eiU4ffav9uAd/zrfLHsQdmrk0+5k6+qY
 1dEKCNmysOrT8Jms2mB8ebqyU0qVIrAHlgSol8A2V/5XxgvbsRkly+nhjjb9s+SiLLKIEuE3OsY
 jjrIWEgpPx5DHvPg/ekei2CReKnTD4UkIdA3W+OBmF8ZrFi9lhuIU4jk51x46r3JUSeP7LCap4t
 YxgcR+o/VC4CrIEj8bykr+lhAEAiq/mWcpd87O8XhnBXkctTVW8adYzY7UswdbeScB37MtyZrRB
 Atd/MNg==
X-Received: by 2002:a05:6000:4304:b0:3e7:6268:71fd with SMTP id
 ffacd0b85a97d-4266e8d93b2mr19404738f8f.52.1760525198279; 
 Wed, 15 Oct 2025 03:46:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWsXyJgrCXiKq3ZghjBKSAqNu/INmH7dq0enPjFeE5326QA0pjfqW4G3XF2xi/Cc4HfwIheQ==
X-Received: by 2002:a05:6000:4304:b0:3e7:6268:71fd with SMTP id
 ffacd0b85a97d-4266e8d93b2mr19404726f8f.52.1760525197853; 
 Wed, 15 Oct 2025 03:46:37 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-136.pools.arcor-ip.net.
 [47.64.112.136]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5825aasm28076597f8f.14.2025.10.15.03.46.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 03:46:37 -0700 (PDT)
Message-ID: <7e87c09b-a8e6-48c9-b5fe-f39d5208bf14@redhat.com>
Date: Wed, 15 Oct 2025 12:46:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ppc/e500: Check for compatible CPU type instead of
 aborting ungracefully
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20251015065742.1562288-1-thuth@redhat.com>
 <bc32be80-a01e-7ec7-f073-9a8b7b0eeec8@eik.bme.hu>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <bc32be80-a01e-7ec7-f073-9a8b7b0eeec8@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On 15/10/2025 12.17, BALATON Zoltan wrote:
> On Wed, 15 Oct 2025, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> When using the ppce500 machine with an embedded CPU type that has
>> the right MMU model, but is not part of the e500 CPU family, QEMU
>> currently aborts ungracefully:
>>
>> $ ./qemu-system-ppc -machine ppce500 -cpu e200z5 -nographic
>> qemu-system-ppc: ../qemu/hw/core/gpio.c:108: qdev_get_gpio_in_named:
>>  Assertion `n >= 0 && n < gpio_list->num_in' failed.
>> Aborted (core dumped)
>>
>> The ppce500 machine expects a CPU with certain GPIO interrupt pins,
>> so let's check for a compatible model before we try to wire some
>> pins that don't exist.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3162
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>> hw/ppc/e500.c | 5 +++++
>> 1 file changed, 5 insertions(+)
>>
>> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
>> index 723c97fad2e..d40b7a618db 100644
>> --- a/hw/ppc/e500.c
>> +++ b/hw/ppc/e500.c
>> @@ -20,6 +20,7 @@
>> #include "qemu/guest-random.h"
>> #include "exec/target_page.h"
>> #include "qapi/error.h"
>> +#include "cpu-models.h"
>> #include "e500.h"
>> #include "e500-ccsr.h"
>> #include "net/net.h"
>> @@ -947,6 +948,10 @@ void ppce500_init(MachineState *machine)
>>                          env->mmu_model);
>>             exit(1);
>>         }
> 
> I think you can drop the mmu_model check above now becuase it's a no-op 
> after the stricter check for e500 you added so no need to keep that separate 
> error, the new check catches that too.

Right, good idea, I'll respin a v2...

  Thomas


