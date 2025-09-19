Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E4DECAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 15:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzdNk-0006zB-89; Fri, 19 Sep 2025 11:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uzdNi-0006yP-F7
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 11:50:42 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uzdNa-0003o9-QO
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 11:50:42 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1621:0:640:12d9:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id A25B0C0367;
 Fri, 19 Sep 2025 18:50:25 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a72::1:38] (unknown
 [2a02:6bf:8080:a72::1:38])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id NoVPYZ1G4a60-BFQEAHvP; Fri, 19 Sep 2025 18:50:24 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758297024;
 bh=Qax2pkSTwcVIAZpRZ61hBp/lZeoM/GIoZnCjxLqGRNo=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=fUFTJgTavNdyivwU0hzfq0GdfY/SgGKYp3w2NJ2RKvL9LcCwihKFQG6ggABE3+EDE
 14osAlKWytszH5Ni1hKeOfnKsiuLU6LUxUMVc1bEyaXudXJEdvu5xdCfwGfMJTQKgb
 rndODhU9G4y5Ohu27UFCTwyUIRNcDet5txeIUHMI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <82642da2-eff7-4eb6-b007-fd239fa0ef64@yandex-team.ru>
Date: Fri, 19 Sep 2025 18:50:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 16/19] qapi: add interface for local TAP migration
To: Fabiano Rosas <farosas@suse.de>, mst@redhat.com
Cc: qemu-devel@nongnu.org, philmd@linaro.org, thuth@redhat.com,
 eblake@redhat.com, michael.roth@amd.com, armbru@redhat.com,
 peterx@redhat.com, berrange@redhat.com, jasowang@redhat.com,
 steven.sistare@oracle.com, leiyang@redhat.com, davydov-max@yandex-team.ru,
 yc-core@yandex-team.ru
References: <20250919095545.1912042-1-vsementsov@yandex-team.ru>
 <20250919095545.1912042-17-vsementsov@yandex-team.ru>
 <87y0qatqoa.fsf@suse.de>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87y0qatqoa.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 19.09.25 18:20, Fabiano Rosas wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
> Hi Vladimir, as usual with "qapi:" patches, some comments about
> language:
> 
>> To migrate virtio-net TAP device backend (including open fds) locally,
>> user should simply set migration parameter
>>
>>     fds = [virtio-net]
>>
>> Why not simple boolean? To simplify migration to further versions,
>> when more devices will support fds migration.
>>
>> Alternatively, we may add per-device option to disable fds-migration,
>> but still:
>>
>> 1. It's more comfortable to set same capabilities/parameters on both
>> source and target QEMU, than care about each device.
>>
>> 2. To not break the design, that machine-type + device options +
>> migration capabilites and parameters are fully define the resulting
>> migration stream. We'll break this if add in future more fds-passing
>> support in devices under same fds=true parameter.
>>
> 
> These arguments look convincing to me.
> 

[..]

>>       return true;
>>   }
>>   
>> @@ -1297,6 +1315,11 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>>       if (params->has_direct_io) {
>>           dest->direct_io = params->direct_io;
>>       }
>> +
>> +    if (params->has_fds) {
>> +        dest->has_fds = true;
> 
> I think what you want is to set this in
> migrate_params_init(). block_bitmap_mapping is a bit of an outlier in
> that it takes an empty *input* as valid.

Hmm I made it behave like block_bitmap_mapping because it also a list.

As I understand, for list we have to treat empty list not like absent parameter: we should have a way
to clear previously set list by subsequent migrate-set-parameters call.

> 
>> +        dest->fds = params->fds;
>> +    }
>>   }
>>   
>>   static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>> @@ -1429,6 +1452,13 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>>       if (params->has_direct_io) {
>>           s->parameters.direct_io = params->direct_io;
>>       }
>> +
>> +    if (params->has_fds) {
>> +        qapi_free_FdsTargetList(s->parameters.fds);
>> +
>> +        s->parameters.has_fds = true;
>> +        s->parameters.fds = QAPI_CLONE(FdsTargetList, params->fds);
> 
> Same here, has_fds should always be true in s->parameters.
> 
>> +    }
>>   }
>>   
>>   void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
>> diff --git a/migration/options.h b/migration/options.h
>> index 82d839709e..a79472a235 100644
>> --- a/migration/options.h
>> +++ b/migration/options.h
>> @@ -87,6 +87,8 @@ const char *migrate_tls_hostname(void);
>>   uint64_t migrate_xbzrle_cache_size(void);
>>   ZeroPageDetection migrate_zero_page_detection(void);
>>   
>> +bool migrate_fds_virtio_net(void);
>> +
>>   /* parameters helpers */
>>   
>>   bool migrate_params_check(MigrationParameters *params, Error **errp);
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 2387c21e9c..6ef9629c6d 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -747,6 +747,19 @@
>>         '*transform': 'BitmapMigrationBitmapAliasTransform'
>>     } }
>>   
>> +##
>> +# @FdsTarget:
>> +#
>> +# @virtio-net: Enable live backend migration for virtio-net.
> 
> So you're assuming normal migration is "non-live backend migration"
> because the backend is stopped and started again on the destination. I
> think it makes sense.
> 
>> +#     The only supported backend is TAP device. When enabled, TAP fds
>> +#     and all related state is passed to target QEMU through migration
>> +#     channel (which should be unix socket).
>> +#
>> +# Since: 10.2
>> +##
>> +{ 'enum': 'FdsTarget',
>> +  'data': [ 'virtio-net' ] }
>> +
>>   ##
>>   # @BitmapMigrationNodeAlias:
>>   #
>> @@ -924,10 +937,14 @@
>>   #     only has effect if the @mapped-ram capability is enabled.
>>   #     (Since 9.1)
>>   #
>> +# @fds: List of targets to enable live-backend migration for. This
>> +#     requires migration channel to be a unix socket (to pass fds
>> +#     through). (Since 10.2)
> 
> I think I prefer live-backend as written here rather than the non
> hyphenated version above. This clears up the ambiguity and can be used
> in variable names, as a name for the feature and ... _thinks really
> hard_ ... as the parameter name! (maybe)
> 
> On that note, fds is just too broad, I'm sure you know that, but to be
> specific, we already have fd migration, multifd, fdset (as argument of
> file: migration), etc. Talking just about the user interface here, of
> course.
> 
> Also: "@fds: List of targets..." is super confusing.
> 
> And although "to pass fds through" is helping clarify the meaning of
> @fds, it exposes implementation details on the QAPI, I don't think it's
> relevant in the parameter description.

Agree. I see all this mess, each time I come with some new name:
live-tap, live-backend, fds-passing, fds migration, local tap migration, fds...
Finally, only one should be chosen for all names and in documentation.

With your comments, "live-backend" really looks the best one.

Still, we can't say live-backends: [virtio-net], as virtio-net is not
a backed.

Maybe
    
    live-backends: [virtio-net-tap]

to show that it's about virtio-net+TAP pair.

> 
>> +#
>>   # Features:
>>   #
>> -# @unstable: Members @x-checkpoint-delay and
>> -#     @x-vcpu-dirty-limit-period are experimental.


Thanks!


-- 
Best regards,
Vladimir

