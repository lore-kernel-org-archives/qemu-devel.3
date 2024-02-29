Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F81FC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 10:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfdle-0003xY-FF; Thu, 29 Feb 2024 05:35:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rfdlc-0003ty-4Z
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 05:35:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rfdla-0000gZ-D1
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 05:35:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709202953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=r4oz9F+Ibm56901DLXPnEbrgzctCTXqHWRDl5gV5M18=;
 b=Gj2PLbPrDlNiScWBi0K9pZcw05t2Dd0X2LtJ/H9jmSkw7RtGAGUFFsaILNNAQNYhJLyL+4
 MEIHl3mLFeT4JqHvQLBwZBbtShMneGmHAQdHWIbl+tLPWjDJgkLuri1+9TOnOEMFysOnXC
 NmpAc6TsjO7eQdSnItbQ2ukjfuuOFvU=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-bVXu8XuQOCeASZvThKQ82A-1; Thu, 29 Feb 2024 05:35:51 -0500
X-MC-Unique: bVXu8XuQOCeASZvThKQ82A-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-59907104d88so770025eaf.3
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 02:35:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709202951; x=1709807751;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r4oz9F+Ibm56901DLXPnEbrgzctCTXqHWRDl5gV5M18=;
 b=Z0zSY9dCuv3hfoB4ypIWWSWNbOmCFq9INHF/fLasUnAetesFdXsDHtJry4uyvtbi8N
 1itM5dOYchUJHD+SPFtGbFlsUtIHAgffP2yAEkHyw7yVfZES9L3KMVMvpitO1bo9txQD
 5ed7NW7MopKVFKQcIPD5R0mm/q3cckqHXJMBM6aN6sJRwGx37bLMls4gEmExRPzBisNg
 f/7YGdS644Y38kTVKnq8KkvhlPZld1CpJ7oOzURVVJStba9fiCO4eSNyv+l9XnWoiLLL
 BPvGlTd5EQ97i+IlwYqmllSJhNCjzM862qKmEuxEsaOoGbbglM/bVXGq/CD9GtE9XEzL
 L2Mw==
X-Gm-Message-State: AOJu0Yw82Sy1RGD+32FW4gULmXTIRfqVezxiHfmXmXwqlZJgdnObIzbv
 6bRouVzcXHCtaWy10WeCXF95v52Y8FFQYafdQ8rFKzpqow0deOaJ6afk3VcSx0MPoS/l9zFYGTR
 77kmJ6CTDHqpAZ+UclA91ZHNOD1KK6iyJV7sZWJFTrYLBIP7ABFdZ
X-Received: by 2002:a05:6359:4581:b0:17b:570c:92ba with SMTP id
 no1-20020a056359458100b0017b570c92bamr1479047rwb.21.1709202950733; 
 Thu, 29 Feb 2024 02:35:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOhGtNnSw1Rb5f66pPyiq6lySfu6i3c2kgD0Xa0uNDPM+pvzvzISFVOO6So/Cc1/VU4L1igA==
X-Received: by 2002:a05:6359:4581:b0:17b:570c:92ba with SMTP id
 no1-20020a056359458100b0017b570c92bamr1479026rwb.21.1709202950344; 
 Thu, 29 Feb 2024 02:35:50 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-133.web.vodafone.de.
 [109.43.178.133]) by smtp.gmail.com with ESMTPSA id
 r13-20020ac85e8d000000b0042e703a8d74sm574557qtx.56.2024.02.29.02.35.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Feb 2024 02:35:49 -0800 (PST)
Message-ID: <bea4ca16-a2ea-4a06-bb8d-27b485d63cc1@redhat.com>
Date: Thu, 29 Feb 2024 11:35:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/21] migration: Add Error** argument to .save_setup()
 handler
Content-Language: en-US
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Alex Williamson
 <alex.williamson@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>, Eric Blake <eblake@redhat.com>,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20240227180345.548960-1-clg@redhat.com>
 <20240227180345.548960-7-clg@redhat.com> <87zfvj3hnd.fsf@pond.sub.org>
 <86d70a2e-7250-440b-bcd6-7877fe3b3dba@yandex-team.ru>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <86d70a2e-7250-440b-bcd6-7877fe3b3dba@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
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

On 29/02/2024 08.20, Vladimir Sementsov-Ogievskiy wrote:
> On 29.02.24 09:32, Markus Armbruster wrote:
>> Cédric Le Goater <clg@redhat.com> writes:
>>
>>> The purpose is to record a potential error in the migration stream if
>>> qemu_savevm_state_setup() fails. Most of the current .save_setup()
>>> handlers can be modified to use the Error argument instead of managing
>>> their own and calling locally error_report(). The following patches
>>> will introduce such changes for VFIO first.
>>>
>>> Cc: Nicholas Piggin <npiggin@gmail.com>
>>> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
>>> Cc: Halil Pasic <pasic@linux.ibm.com>
>>> Cc: Thomas Huth <thuth@redhat.com>
>>> Cc: Eric Blake <eblake@redhat.com>
>>> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>> Cc: John Snow <jsnow@redhat.com>
>>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>> ---
>>
>> [...]
>>
>>> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
>>> index 
>>> c483b62a9b5f71772639fc180bdad15ecb6711cb..c934df424a555d83d2198f5ddfc0cbe0ea98e9ec 100644
>>> --- a/hw/s390x/s390-stattrib.c
>>> +++ b/hw/s390x/s390-stattrib.c
>>> @@ -166,7 +166,7 @@ static int cmma_load(QEMUFile *f, void *opaque, int 
>>> version_id)
>>>       return ret;
>>>   }
>>> -static int cmma_save_setup(QEMUFile *f, void *opaque)
>>> +static int cmma_save_setup(QEMUFile *f, void *opaque, Error **errp)
>>>   {
>>>       S390StAttribState *sas = S390_STATTRIB(opaque);
>>>       S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
>>         int res;
>>         /*
>>          * Signal that we want to start a migration, thus needing PGSTE dirty
>>          * tracking.
>>          */
>>         res = sac->set_migrationmode(sas, 1);
>>         if (res) {
>>             return res;
>>
>> I believe this is a failure return.
>>
>> Anti-pattern: fail without setting an error.  There might be more
>> elsewhere in the series.
>>
>> qapi/error.h's big comment:
>>
>>   * - On success, the function should not touch *errp.  On failure, it
>>   *   should set a new error, e.g. with error_setg(errp, ...), or
>>   *   propagate an existing one, e.g. with error_propagate(errp, ...).
>>   *
>>   * - Whenever practical, also return a value that indicates success /
>>   *   failure.  This can make the error checking more concise, and can
>>   *   avoid useless error object creation and destruction.  Note that
>>   *   we still have many functions returning void.  We recommend
>>   *   • bool-valued functions return true on success / false on failure,
>>   *   • pointer-valued functions return non-null / null pointer, and
>>   *   • integer-valued functions return non-negative / negative.
>>
>>         }
>>         qemu_put_be64(f, STATTR_FLAG_EOS);
>>         return 0;
>>     }
>>
>> When adding Error **errp to a function, you must also add code to set an
>> error on failure to every failure path.  Adding it in a later patch in
>> the same series can be okay,
> 
> Personally, I'd prefer not doing so. Creating wrong commits and fixing them 
> in same series - better to merge all fixes into bad commit:)

I agree - that might create issues with bisecting later. Please fix it in 
this patch here already!

  Thanks,
   Thomas



