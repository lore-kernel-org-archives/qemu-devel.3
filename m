Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C5FC5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 10:50:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhoqH-0005yB-VC; Wed, 06 Mar 2024 05:49:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rhoqF-0005xk-0m
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 05:49:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rhoqD-0008OK-9w
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 05:49:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709722179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tgxlsQU7Onx7o9yd8BOOGfB9GAaZDdWNdiHka0URGjk=;
 b=eFjrW+KtD8h4SjCrNehMN1QunTV1u8Gia0RjuOK4D2NlC+FqMzyN9DgGSCBzbSJfdJYZ3L
 b4BbFq1UOQ10DBA3jiw/WI2JryClaOLb8fhD3BKCZQaJpesdeEcwOR/kVHblB3ISyJIwCk
 SE0lkD3vbr6JkY40IGqCtxicSp5bfN0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-OhOm3MHGOiyymrceSpr5pw-1; Wed, 06 Mar 2024 05:49:38 -0500
X-MC-Unique: OhOm3MHGOiyymrceSpr5pw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-787dea68f58so162461485a.3
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 02:49:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709722178; x=1710326978;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tgxlsQU7Onx7o9yd8BOOGfB9GAaZDdWNdiHka0URGjk=;
 b=mnZFs50Cgi1t+8AXb+B/l89bYAE4TmbxU7GjXbKL4nrNPN9W5MfxkUSfWuz4yHJNz9
 E7CaJmMdI2FU3r+pucTXhGpK/a4aao0qjwlgB+BQAdPwfC5D21I12l3eyjemcZH8VjG9
 aQ4Mia9gX9Rc3IubXBE1Js3EfPRzAgPt3w5fUpd1HhC6kr68E1VITv8qTiGpJdTEMBAZ
 L8QBaY6cy3EMWJvK0VuoX77gBiQlIsrVngUuKoXepOhVUkCUUsG3MEInlsjx8z+b8hc2
 DHEEu3yjaBeI87XNRvLWASdaiWvwjHv5bo+pv6gkkc2kDApo4zDWBunws8OF+SeloiAB
 gJCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMz0kg/INid9YcR96doCJ+sXUy46FWAFtTEyj7s/x7l5d3GCFUIg8Gaw5t2jKr+RjZedEExOzT8EsEd9LQJRtup2kIrds=
X-Gm-Message-State: AOJu0YzVqL68DjZl/BW4bMbMbo8LjrokGR7bvETKGsrNYkNn7Jyc9Mx9
 w9WWtFntCd6x7WjXP/2SY76cKazd5Dg8ZkB9B9FnnxbNOr5iSQDakY+fPpBYFW1DVxnyHGl10VD
 bzrfvPGL9ZMu9dWnQpOQNzdUH2/ZdO9DI29xFCQ6cqO1QgaY81+rh
X-Received: by 2002:a05:620a:170d:b0:788:2d55:3dd4 with SMTP id
 az13-20020a05620a170d00b007882d553dd4mr5276102qkb.31.1709722178122; 
 Wed, 06 Mar 2024 02:49:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNZsUVNqjKtFMpMhTN485ZwhTO/AiFPVWPCKfZp+KbIAvYf317CVek5kQ9wq9XMt6quqy/mA==
X-Received: by 2002:a05:620a:170d:b0:788:2d55:3dd4 with SMTP id
 az13-20020a05620a170d00b007882d553dd4mr5276093qkb.31.1709722177866; 
 Wed, 06 Mar 2024 02:49:37 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a05620a12e500b007884003f9a0sm396584qkl.122.2024.03.06.02.49.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 02:49:37 -0800 (PST)
Message-ID: <efcec7b9-32b4-44c1-a8f2-13e131c0f9f2@redhat.com>
Date: Wed, 6 Mar 2024 11:49:34 +0100
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
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <aad3aa6b-79e5-4968-8bb9-ddd35883d02b@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 3/6/24 10:56, Avihai Horon wrote:
> 
> On 04/03/2024 14:28, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> This will prepare ground for futur changes adding an Error** argument
>> to the save_setup() handler. We need to make sure that on failure,
>> vfio_save_setup() always sets a new error.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   hw/vfio/migration.c | 15 ++++++++++++---
>>   1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 2050ac8897231ff89cc223f0570d5c7a65dede9e..51bea536cc290ba0aa393f78b017b0650e333bff 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -383,6 +383,7 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
>>       VFIODevice *vbasedev = opaque;
>>       VFIOMigration *migration = vbasedev->migration;
>>       uint64_t stop_copy_size = VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE;
>> +    int ret;
>>
>>       qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
>>
>> @@ -397,13 +398,13 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
>>       }
>>
>>       if (vfio_precopy_supported(vbasedev)) {
>> -        int ret;
>> -
>>           switch (migration->device_state) {
>>           case VFIO_DEVICE_STATE_RUNNING:
>>               ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_PRE_COPY,
>>                                              VFIO_DEVICE_STATE_RUNNING);
>>               if (ret) {
>> +                error_report("%s: Failed to set new RUNNING state",
>> +                             vbasedev->name);
>>                   return ret;
>>               }
>>
>> @@ -414,6 +415,8 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
>>               /* vfio_save_complete_precopy() will go to STOP_COPY */
>>               break;
>>           default:
>> +            error_report("%s: Invalid device state %d", vbasedev->name,
>> +                         migration->device_state);
>>               return -EINVAL;
>>           }
>>       }
>> @@ -422,7 +425,13 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
>>
>>       qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>>
>> -    return qemu_file_get_error(f);
>> +    ret = qemu_file_get_error(f);
>> +    if (ret) {
>> +        error_report("%s: save setup failed : %s", vbasedev->name,
>> +                     strerror(ret));
> 
> Here it should be -ret (and also later in patch #12).

Yes this is like qemu_fflush(). I will also change the test to

   if (ret < 0)

As Prasad suggested.


Thanks,

C.


