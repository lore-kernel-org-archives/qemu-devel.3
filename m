Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE580C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 08:24:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhQ5n-0000pu-1c; Tue, 05 Mar 2024 03:24:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rhQ5i-0000eI-Np
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 03:24:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rhQ5Z-0005yR-Pu
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 03:24:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709627033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t97PPAvAR+1evBiiddKA2s1dqRYW7WAJ8wooILuMRtI=;
 b=Xmw/ojKjjoQ5p2vfr/NFhZRPoHFzspQcoM9RvmbCxgs3De/ChTl/cqK+W25cJfX1SSSZsX
 XfhJnmYpSioaCvWsD2tPyOuH9XYjq6fxJRfi2C/52a2xCpu0kBAOZ7dZyl5wHt8bWmnMYv
 ph+B7+hJbLtbKed175pmPru1TcEDIqs=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-IpkaTYVhMn-BppT_oxNC2g-1; Tue, 05 Mar 2024 03:23:51 -0500
X-MC-Unique: IpkaTYVhMn-BppT_oxNC2g-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-788228e459dso270239285a.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 00:23:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709627031; x=1710231831;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t97PPAvAR+1evBiiddKA2s1dqRYW7WAJ8wooILuMRtI=;
 b=RfJBux4J+kqk6XRiAZE6iCBYW1AYD3/IAboMNtD1uABRX0KaqZeXgh4JyZOHhScZVF
 Q3W7Yp4JOxc70ksjegig/TKMOTsYVTs4tHBQcUo3ZD8RJzyARx4iLztW8wIthOAH8eDL
 QBQ2luSjo4CDz92dnZi+1lfSUi1xxsaC6abrHzisqMHXukU0DS4wHA2lI+0nTNuGGIPC
 TCGkvEkmeJYuHscOT4aSBTewx7GN9NnleUGHpuuBy+7L338w2qz3CLst4tjVSvr6m+GF
 Zgex7AFjAHRU8+IZ5nQ/69F0F9AL9vlj9fCeS8RQalNdqZGWcTZwS3UujEtRlxKYLd+N
 QOzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvtx/4fHYphHqLCnPJuRuXSXnyZ8pZ+RYnKZew81I3qEOtljOrdh6V4FY8vVBXaXg2nJeZL1vilNvXIYB5hks1bDxWwmI=
X-Gm-Message-State: AOJu0YxNdkT0XNBzqV2eBEXlZUk0NHuz76AHT1n7N6hptIeSGlISazFa
 r6Kp/W4rENmxkA9L3/xY3cdHph01+39I2HB8QuRLtMbf17G+gcSzLnF0TPEcUOwnFfMO4KnutuL
 E3aMPI4MuIzPk27oj/1CrFckuifUBt+DOYoVd+v1IjcCIhpYPuoVQ
X-Received: by 2002:a05:620a:149a:b0:788:20bb:6bc6 with SMTP id
 w26-20020a05620a149a00b0078820bb6bc6mr1181928qkj.17.1709627031314; 
 Tue, 05 Mar 2024 00:23:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVgMV6SBXunoTYJzb6DLZLDLPxGuE1B2YzjcmpVqlD4qFOf7znxfUzoUXbyPk7O2NQNLjIgw==
X-Received: by 2002:a05:620a:149a:b0:788:20bb:6bc6 with SMTP id
 w26-20020a05620a149a00b0078820bb6bc6mr1181913qkj.17.1709627030975; 
 Tue, 05 Mar 2024 00:23:50 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 a17-20020a05620a125100b007881f769315sm2802681qkl.68.2024.03.05.00.23.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 00:23:50 -0800 (PST)
Message-ID: <2dae4a33-14de-4ab6-9848-da48d08ff9b3@redhat.com>
Date: Tue, 5 Mar 2024 09:23:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/26] migration: Always report an error in
 block_save_setup()
Content-Language: en-US, fr
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, qemu-block@nongnu.org
References: <20240304122844.1888308-1-clg@redhat.com>
 <20240304122844.1888308-4-clg@redhat.com> <87plw9hfoa.fsf@suse.de>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <87plw9hfoa.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 3/4/24 22:04, Fabiano Rosas wrote:
> Cédric Le Goater <clg@redhat.com> writes:
> 
>> This will prepare ground for futur changes adding an Error** argument
>> to the save_setup() handler. We need to make sure that on failure,
>> block_save_setup() always sets a new error.
>>
>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   migration/block.c | 18 +++++++++++++-----
>>   1 file changed, 13 insertions(+), 5 deletions(-)
>>
>> diff --git a/migration/block.c b/migration/block.c
>> index 8c6ebafacc1ffe930d1d4f19d968817b14852c69..06f5857cf049df3261d2cf1d7c3607ab92350ac6 100644
>> --- a/migration/block.c
>> +++ b/migration/block.c
>> @@ -367,7 +367,7 @@ static void unset_dirty_tracking(void)
>>       }
>>   }
>>   
>> -static int init_blk_migration(QEMUFile *f)
>> +static int init_blk_migration(QEMUFile *f, Error **errp)
>>   {
>>       BlockDriverState *bs;
>>       BlkMigDevState *bmds;
>> @@ -378,7 +378,6 @@ static int init_blk_migration(QEMUFile *f)
>>           BlkMigDevState *bmds;
>>           BlockDriverState *bs;
>>       } *bmds_bs;
>> -    Error *local_err = NULL;
>>       int ret;
>>   
>>       GRAPH_RDLOCK_GUARD_MAINLOOP();
> 
> There's a negative return below at:
> 
>      for (i = 0, bs = bdrv_first(&it); bs; bs = bdrv_next(&it), i++) {
>          if (bdrv_is_read_only(bs)) {
>              continue;
>          }
> 
>          sectors = bdrv_nb_sectors(bs);
>          if (sectors <= 0) {
>              ret = sectors;
>                  ^
>              bdrv_next_cleanup(&it);
>              goto out;
>          }
>          ...


Indeed.

I understand that the bdrv_nb_sectors() == 0 case only breaks the loop but
it is not considered as an error. Could the block folks confirm please ?

Thanks,

C.

> 
> I presume that must be covered by an error as well. A similar function
> somewhere else reports:
> 
>          total_sectors = blk_nb_sectors(blk);
>          if (total_sectors <= 0) {
>              error_report("Error getting length of block device %s",
>                           device_name);
>              return -EINVAL;
>          }
>
>> @@ -439,9 +438,8 @@ static int init_blk_migration(QEMUFile *f)
>>           bs = bmds_bs[i].bs;
>>   
>>           if (bmds) {
>> -            ret = blk_insert_bs(bmds->blk, bs, &local_err);
>> +            ret = blk_insert_bs(bmds->blk, bs, errp);
>>               if (ret < 0) {
>> -                error_report_err(local_err);
>>                   goto out;
>>               }
>>   
>> @@ -711,6 +709,7 @@ static void block_migration_cleanup(void *opaque)
>>   static int block_save_setup(QEMUFile *f, void *opaque)
>>   {
>>       int ret;
>> +    Error *local_err = NULL;
>>   
>>       trace_migration_block_save("setup", block_mig_state.submitted,
>>                                  block_mig_state.transferred);
>> @@ -718,18 +717,27 @@ static int block_save_setup(QEMUFile *f, void *opaque)
>>       warn_report("block migration is deprecated;"
>>                   " use blockdev-mirror with NBD instead");
>>   
>> -    ret = init_blk_migration(f);
>> +    ret = init_blk_migration(f, &local_err);
>>       if (ret < 0) {
>> +        error_report_err(local_err);
>>           return ret;
>>       }
>>   
>>       /* start track dirty blocks */
>>       ret = set_dirty_tracking();
>>       if (ret) {
>> +        error_setg_errno(&local_err, -ret,
>> +                         "Failed to start block dirty tracking");
>> +        error_report_err(local_err);
>>           return ret;
>>       }
>>   
>>       ret = flush_blks(f);
>> +    if (ret) {
>> +        error_setg_errno(&local_err, -ret, "Flushing block failed");
>> +        error_report_err(local_err);
>> +        return ret;
>> +    }
>>       blk_mig_reset_dirty_cursor();
>>       qemu_put_be64(f, BLK_MIG_FLAG_EOS);
> 


