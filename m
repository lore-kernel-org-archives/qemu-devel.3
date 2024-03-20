Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 530B7C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 08:41:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmrVb-0002cn-02; Wed, 20 Mar 2024 04:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmrVZ-0002cA-EO
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:41:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmrVX-0007PA-4o
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:41:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710924070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zCX4Gvp2ULmguV3yxtkiVVrYj/bBffQ1Bvkw6NHId5Q=;
 b=diV3v/BKYe07m9FDM8wbq/Mo2pGNQLOJQ7GPTPkU8vOikjdD3niNWL9GS5uZ50XTqy1sOt
 MH2ZFtxna/6Weh46WweP3z1cNg3q0iZFfavXbJC60dhoxvHaRXYYNpN1wU5G1LmUvFqOwU
 e5x5jGFrzrGm1RZj6bA5TMM8kLcZoUg=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-8380TKdYPEK1jJ-nFUyCdg-1; Wed, 20 Mar 2024 04:41:08 -0400
X-MC-Unique: 8380TKdYPEK1jJ-nFUyCdg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2d4af32be9fso26968631fa.2
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 01:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710924067; x=1711528867;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zCX4Gvp2ULmguV3yxtkiVVrYj/bBffQ1Bvkw6NHId5Q=;
 b=sZASFJ39KBWZfmM+0jkQrD5WIpBRE4V24rmLXOiE/4Yqwmtx4QZhHolnm81rOJ9dBr
 DUmE4vzNQBpyodF/FLsaEEydKFi/gulfZYJdAt13jpZV8Hy4YbLsKRZL7mdIVelXN6/f
 /2dJvd0WxNdsd52IBdLCmv7rASduNgixkmV2/imK320pDH1l1MVO/g7CMCQUnSu+HjrP
 41Ogq0VtL053aimJdMR/f+mu7SqkeIESk4R1cJ1zCfW6iUHSK4otoOTRYrsxudsR3OGl
 KTMMvgECeqxHCHyLt7elpnUeD01tLKAONeuXVk33VIrtor1+GDxNmse5JOvU8TwAjAOM
 V65w==
X-Gm-Message-State: AOJu0YzaIiu/YB1+TN3l4l/rEzydGJDCu+hNCsCwVbHql6CYQdGusF++
 MzWoehOFYo95fwyoYTBc/3otBMXG+a0IO6nAV7jemQPsG4CyBQA8CKsRiSUdMdQ1jKnoU0gBrQC
 hwkzyJvUb7hTaR/P5ldGkElcqsabsADLhWW4IQb/5Mb64iyb/2/3F
X-Received: by 2002:a2e:a724:0:b0:2d4:8878:a15d with SMTP id
 s36-20020a2ea724000000b002d48878a15dmr3045366lje.7.1710924066795; 
 Wed, 20 Mar 2024 01:41:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEm8MpvaWTj1+wc5neM6At/11mqOGaDRHto6zQcNyj5VEPwdxYMG5dApRREf0EVHGcsCs2yXg==
X-Received: by 2002:a2e:a724:0:b0:2d4:8878:a15d with SMTP id
 s36-20020a2ea724000000b002d48878a15dmr3045352lje.7.1710924066456; 
 Wed, 20 Mar 2024 01:41:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 q16-20020a05600c46d000b00412a31d2e2asm1462823wmo.32.2024.03.20.01.41.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 01:41:05 -0700 (PDT)
Message-ID: <a6e0a011-817b-4e9e-9985-8fb64fa0aa5e@redhat.com>
Date: Wed, 20 Mar 2024 09:41:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 v5 08/14] migration: Add Error** argument to
 .load_setup() handler
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Prasad Pandit <pjp@fedoraproject.org>
References: <20240320064911.545001-1-clg@redhat.com>
 <20240320064911.545001-9-clg@redhat.com> <87il1htjpc.fsf@pond.sub.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <87il1htjpc.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
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

On 3/20/24 09:02, Markus Armbruster wrote:
> Cédric Le Goater <clg@redhat.com> writes:
> 
>> This will be useful to report errors at a higher level, mostly in VFIO
>> today.
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
> 
> [...]
> 
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index 535ad5a32d67057dd172ce25d561a66a07172e97..8f42999a15d1685957de9ed517d6bc9ba49c3f11 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -2747,8 +2747,9 @@ static void qemu_loadvm_state_switchover_ack_needed(MigrationIncomingState *mis)
>>       trace_loadvm_state_switchover_ack_needed(mis->switchover_ack_pending_num);
>>   }
>>   
>> -static int qemu_loadvm_state_setup(QEMUFile *f)
>> +static int qemu_loadvm_state_setup(QEMUFile *f, Error **errp)
>>   {
>> +    ERRP_GUARD(); /* error_prepend use */
> 
> The comment is correct, but prone to go stale.  No other use of
> ERRP_GUARD() is commented.  Suggest to drop it.

OK. I found it interesting, for me at least. Will drop in the VFIO
patches also.

Thanks,

C.


> 
>>       SaveStateEntry *se;
>>       int ret;
>>   
>> @@ -2763,10 +2764,11 @@ static int qemu_loadvm_state_setup(QEMUFile *f)
>>               }
>>           }
>>   
>> -        ret = se->ops->load_setup(f, se->opaque);
>> +        ret = se->ops->load_setup(f, se->opaque, errp);
>>           if (ret < 0) {
>> +            error_prepend(errp, "Load state of device %s failed: ",
>> +                          se->idstr);
>>               qemu_file_set_error(f, ret);
>> -            error_report("Load state of device %s failed", se->idstr);
>>               return ret;
>>           }
>>       }
>> @@ -2947,7 +2949,8 @@ int qemu_loadvm_state(QEMUFile *f)
>>           return ret;
>>       }
>>   
>> -    if (qemu_loadvm_state_setup(f) != 0) {
>> +    if (qemu_loadvm_state_setup(f, &local_err) != 0) {
>> +        error_report_err(local_err);
>>           return -EINVAL;
>>       }
> 


