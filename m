Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6746C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 13:28:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY4Rq-0005Cr-1W; Thu, 08 Feb 2024 08:28:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rY4Rk-00058l-D5
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 08:28:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rY4Ri-00021Q-T8
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 08:28:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707398885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n4uIA4vdy+EkQrwo5R0NEo3wLubbFougz1l6WhUpRUU=;
 b=KOJGxJgcbhb2oqFTXuzvKbMrrl7Cw2tad0ylt/C72ucAGR3V64diK7aUTyrkBCIfU9aftw
 2LLplTkzCI/VZ54sxMLXmhUaxSEu73sAKZX5vZZIjtXdU7aAoEmkl39rTouimbV/qbVmsJ
 GUImCGVKk/Wck2VMiNyA+RlvrVFYQtg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-icXGvOr6O5eaguSVI4SGxw-1; Thu, 08 Feb 2024 08:28:03 -0500
X-MC-Unique: icXGvOr6O5eaguSVI4SGxw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-68c43a4cc11so29452636d6.1
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 05:28:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707398883; x=1708003683;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n4uIA4vdy+EkQrwo5R0NEo3wLubbFougz1l6WhUpRUU=;
 b=FrOb+pvpm3MWKGSRB6hK6TJXk2TPTD0dNqzb7JS45XuR1aLzrsOVQHO9MwSWPeODCE
 1alvi3UFD2LrivMwzNiGIQUUY/pvyBbkpZx1HU95xTxlo3LQJVrKRxmHy6xUJFjXr/ey
 dSqQGV6yX858WO+QT/hbutHs0vT/x+sZbwAi1DCwdqtspX9WgwB8EAT3W39b8P/77qzY
 O6qHN0S2wmQQ+HoBVLvH4qTJbcKpg/dtyNnRkkCe3/ockdroDNRoFQbZ1jRkwbrkvVGb
 40UcAT3sz4EW/PY9RI09z895K7Sw1+1DoSqEnr0lyV3SAmembt9Q2KuwgAqXv4Hmpq00
 YSPw==
X-Gm-Message-State: AOJu0YzaYCLlOLLOw6hamORFFIm54MtX30dcnTsNwKa/cxks/JGZBOMK
 MjQRFv9Q+Jvoeu2IeM7E6fub4b0UCLEv+7xADuF2RJ88QpZS5/Wmc12loXHJr/2oryTu+VqqkAw
 4R+D+v10wb+J4t6FCwYkA+tDkI7cnfZOXwvdGjdkPwBIPeruvqom2
X-Received: by 2002:a0c:9e89:0:b0:685:c584:6e8b with SMTP id
 r9-20020a0c9e89000000b00685c5846e8bmr6326146qvd.0.1707398882823; 
 Thu, 08 Feb 2024 05:28:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGh8e90PQy1O6WXMVTsUTh0fs5ZWVSZOYaUQboVdJSeEmzVwfmPejXstag1gJTIpETN9jOGfA==
X-Received: by 2002:a0c:9e89:0:b0:685:c584:6e8b with SMTP id
 r9-20020a0c9e89000000b00685c5846e8bmr6326136qvd.0.1707398882521; 
 Thu, 08 Feb 2024 05:28:02 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCX6VjMMvTqsvl20KavNVtoPx7GKTp7aFE0Il48FMWg8ncEk/3QgWKbB4XKZyq+Hfbc2r/G0/5aopNvPe6ORlywZ5md7I57eE7sye1Zj/UXT559CgjLpb9HSrDpmyz9e3BuT2vWNspLDrdzewOBGVlZhVWE=
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 z21-20020a05620a101500b00783b6da58a9sm1386334qkj.39.2024.02.08.05.28.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Feb 2024 05:28:02 -0800 (PST)
Message-ID: <db5564fd-d8fe-4aff-96d8-6aee3a387e6b@redhat.com>
Date: Thu, 8 Feb 2024 14:27:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] migration: Add Error** argument to .save_setup()
 handler
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-2-clg@redhat.com>
 <6b71edf4-26cd-4a13-8696-51c18ad1b207@linaro.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <6b71edf4-26cd-4a13-8696-51c18ad1b207@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.213,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 2/7/24 21:11, Philippe Mathieu-Daudé wrote:
> On 7/2/24 14:33, Cédric Le Goater wrote:
>> The purpose is to record a potential error in the migration stream if
>> qemu_savevm_state_setup() fails. Most of the current .save_setup()
>> handlers can be modified to use the Error argument instead of managing
>> their own and calling locally error_report(). The following patches
>> will introduce such changes for VFIO first.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   include/migration/register.h   | 2 +-
>>   hw/ppc/spapr.c                 | 2 +-
>>   hw/s390x/s390-stattrib.c       | 2 +-
>>   hw/vfio/migration.c            | 2 +-
>>   migration/block-dirty-bitmap.c | 2 +-
>>   migration/block.c              | 2 +-
>>   migration/ram.c                | 2 +-
>>   migration/savevm.c             | 4 ++--
>>   8 files changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/migration/register.h b/include/migration/register.h
>> index 9ab1f79512c605f0c88a45b560c57486fa054441..831600a00eae4efd0464b60925d65de4d9dbcff8 100644
>> --- a/include/migration/register.h
>> +++ b/include/migration/register.h
>> @@ -25,7 +25,7 @@ typedef struct SaveVMHandlers {
>>        * used to perform early checks.
>>        */
>>       int (*save_prepare)(void *opaque, Error **errp);
>> -    int (*save_setup)(QEMUFile *f, void *opaque);
>> +    int (*save_setup)(QEMUFile *f, void *opaque, Error **errp);
> 
> Since you change this, do you mind adding a docstring
> describing this prototype?

I can send an initial patch adding the documentation tags and then
resend the same patch with the updates people will provide. I don't
have the knowledge to cover all of the SaveVMHandlers struct on my
own.

Thanks,

C.


> Otherwise,
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 


