Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F11DC54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 10:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhos9-0002Fa-Sc; Wed, 06 Mar 2024 05:51:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rhos6-0001ua-0T
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 05:51:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rhos4-0000Px-HX
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 05:51:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709722295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iqk6dACE811z3q6ltjCuw2btuo5rQDmB34hYDv8sdaQ=;
 b=WiwEHWDLH91V5MgNNoc74ZKGARekA9w2OPsksNj28u66g8xrtX1EbCsAI71OjMkRgWfUWv
 0gvAkggwhfLnjR5fzDlabiS3qn4StRb2ooyUZY0e2xQzwGWuOF/+J9V+kg/L+jx8FQ/vSg
 aICzYyWLuD1Ef7O2ErdN8Ad51WsY4a0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-h7Pnv2nlPRqkB6eSBOCkuQ-1; Wed, 06 Mar 2024 05:51:34 -0500
X-MC-Unique: h7Pnv2nlPRqkB6eSBOCkuQ-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-42ee0da398eso9311551cf.1
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 02:51:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709722294; x=1710327094;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iqk6dACE811z3q6ltjCuw2btuo5rQDmB34hYDv8sdaQ=;
 b=LcQXMgMjwTQhqzomtDSYv9DGdf9Am4KPYbNm0ULbOsR3SrR/TPqMe10Uw7NUSorCs9
 2GOFr8I1DKKaZgodbq2y2+6xKjB+w1DJnkzDcneYZtDxkyUrTySo7aCultX/jyl7c3FG
 M1euhSri1Wb19GsHtOptAqAoeWhw6JkW8dy71yuqHnrcL+hQJ4mFvknJ82os2y2at8Ru
 T+YB0n+9pYLG+lzHR+3LM0n4KS9iAimIOrI8iwO+Yuld4NkcO2jtWfBNjlUF2XuSK3tC
 8uZSTZ4JnYuCcRvi3kQobWZ3H3lMP1SDh4CVRxaZXJKn11A9yYRAfLLu/7b56Hnu3rXs
 NbVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8tgvHxHKkxVnwVBG8m06hlct9/S5hR0bwdLWOySrEhJ98AtbrJnpgbEekdbdXRuC/wZTxO4ljqYBAb5+AGbk2lb3QhNk=
X-Gm-Message-State: AOJu0YwNumL11zUJwQMmUixj1rPcwkp2xM/4w4UPBX7YJKH58QGY7c5/
 aAxXw+N72t/xAK6uCxlTLuBoMggR/0YGYDOMUQCMZpMP7en2rE5CYR+uwjBvxT15PCdG6dUdEeB
 MGPYmjFvYOHoLU1vVPke0wG9c0rM9BXRyqB9cWhWY1YHX5zJIa30m
X-Received: by 2002:a05:622a:1314:b0:42e:7280:526b with SMTP id
 v20-20020a05622a131400b0042e7280526bmr4662094qtk.43.1709722294150; 
 Wed, 06 Mar 2024 02:51:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2PRvZTVZOKkvhy7WVtGhb99Zzq1XXui4CraCh9RQrNUExJtl9g0Su7ExB1vbtPwzAr3EtYw==
X-Received: by 2002:a05:622a:1314:b0:42e:7280:526b with SMTP id
 v20-20020a05622a131400b0042e7280526bmr4662084qtk.43.1709722293797; 
 Wed, 06 Mar 2024 02:51:33 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 x25-20020ac87319000000b0042f01e612bbsm1444473qto.37.2024.03.06.02.51.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 02:51:33 -0800 (PST)
Message-ID: <2ef19667-1a45-45d3-ba1b-e4eaeefcda99@redhat.com>
Date: Wed, 6 Mar 2024 11:51:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/26] vfio: Always report an error in vfio_save_setup()
Content-Language: en-US, fr
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20240304122844.1888308-1-clg@redhat.com>
 <20240304122844.1888308-3-clg@redhat.com>
 <aad3aa6b-79e5-4968-8bb9-ddd35883d02b@nvidia.com>
 <11899e68-a3a6-400a-b031-078ef1de0fe0@nvidia.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <11899e68-a3a6-400a-b031-078ef1de0fe0@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 3/6/24 11:16, Avihai Horon wrote:
> 
> On 06/03/2024 11:56, Avihai Horon wrote:
>>
>> On 04/03/2024 14:28, Cédric Le Goater wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> This will prepare ground for futur changes adding an Error** argument
>>> to the save_setup() handler. We need to make sure that on failure,
>>> vfio_save_setup() always sets a new error.
>>>
>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>> ---
>>>   hw/vfio/migration.c | 15 ++++++++++++---
>>>   1 file changed, 12 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>> index 2050ac8897231ff89cc223f0570d5c7a65dede9e..51bea536cc290ba0aa393f78b017b0650e333bff 100644
>>> --- a/hw/vfio/migration.c
>>> +++ b/hw/vfio/migration.c
>>> @@ -383,6 +383,7 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
>>>       VFIODevice *vbasedev = opaque;
>>>       VFIOMigration *migration = vbasedev->migration;
>>>       uint64_t stop_copy_size = VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE;
>>> +    int ret;
>>>
>>>       qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
>>>
>>> @@ -397,13 +398,13 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
>>>       }
>>>
>>>       if (vfio_precopy_supported(vbasedev)) {
>>> -        int ret;
>>> -
>>>           switch (migration->device_state) {
>>>           case VFIO_DEVICE_STATE_RUNNING:
>>>               ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_PRE_COPY,
>>> VFIO_DEVICE_STATE_RUNNING);
>>>               if (ret) {
>>> +                error_report("%s: Failed to set new RUNNING state",
> 
> Oh, sorry, forgot to mention in previous mail:
> s/RUNNING/PRE_COPY

Ah yes. Parameters are <new> and <recover> state.

Thanks,

C.




> 
>>> + vbasedev->name);
>>>                   return ret;
>>>               }
>>>
>>> @@ -414,6 +415,8 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
>>>               /* vfio_save_complete_precopy() will go to STOP_COPY */
>>>               break;
>>>           default:
>>> +            error_report("%s: Invalid device state %d", vbasedev->name,
>>> +                         migration->device_state);
>>>               return -EINVAL;
>>>           }
>>>       }
>>> @@ -422,7 +425,13 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
>>>
>>>       qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>>>
>>> -    return qemu_file_get_error(f);
>>> +    ret = qemu_file_get_error(f);
>>> +    if (ret) {
>>> +        error_report("%s: save setup failed : %s", vbasedev->name,
>>> +                     strerror(ret));
>>
>> Here it should be -ret (and also later in patch #12).
>>
>> Thanks.
>>
>>> +    }
>>> +
>>> +    return ret;
>>>   }
>>>
>>>   static void vfio_save_cleanup(void *opaque)
>>> -- 
>>> 2.44.0
>>>
> 


