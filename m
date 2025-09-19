Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB65DCAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 17:36:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzf14-0003Jh-2z; Fri, 19 Sep 2025 13:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uzf0y-0003J9-CR
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 13:35:22 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uzf0v-0001hJ-BI
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 13:35:20 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id B75BEC034C;
 Fri, 19 Sep 2025 20:35:09 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a72::1:38] (unknown
 [2a02:6bf:8080:a72::1:38])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 8ZX9vV1FvqM0-MBvt53Qe; Fri, 19 Sep 2025 20:35:09 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758303309;
 bh=4tRzB9QjU9uZH2OPhbM+QegcFb4PZNpLa3ksjFWgkdk=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=VEeWeQq3jXwcNiadKCr9IYtSe0o1105oPHvuOUpvKKHctsBFrfWSrvfjmKLHEgjrk
 CWEnOkAdYG8+hfjitp6Er4BsTbqXLMHLTcp2KZC6Apuqatuj2fASObx5lLye798qQF
 sr0iUNqS7Ar61ANsSnOOf5klr3mWIRpTGDdGQKNI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <dd172f7d-9b16-44fb-8000-f8891877bd99@yandex-team.ru>
Date: Fri, 19 Sep 2025 20:35:08 +0300
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
 <82642da2-eff7-4eb6-b007-fd239fa0ef64@yandex-team.ru>
 <87ms6qtlgf.fsf@suse.de>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87ms6qtlgf.fsf@suse.de>
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

On 19.09.25 20:13, Fabiano Rosas wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> On 19.09.25 18:20, Fabiano Rosas wrote:
>>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>>>
>>> Hi Vladimir, as usual with "qapi:" patches, some comments about
>>> language:
>>>
>>>> To migrate virtio-net TAP device backend (including open fds) locally,
>>>> user should simply set migration parameter
>>>>
>>>>      fds = [virtio-net]
>>>>
>>>> Why not simple boolean? To simplify migration to further versions,
>>>> when more devices will support fds migration.
>>>>
>>>> Alternatively, we may add per-device option to disable fds-migration,
>>>> but still:
>>>>
>>>> 1. It's more comfortable to set same capabilities/parameters on both
>>>> source and target QEMU, than care about each device.
>>>>
>>>> 2. To not break the design, that machine-type + device options +
>>>> migration capabilites and parameters are fully define the resulting
>>>> migration stream. We'll break this if add in future more fds-passing
>>>> support in devices under same fds=true parameter.
>>>>
>>>
>>> These arguments look convincing to me.
>>>
>>
>> [..]
>>
>>>>        return true;
>>>>    }
>>>>    
>>>> @@ -1297,6 +1315,11 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>>>>        if (params->has_direct_io) {
>>>>            dest->direct_io = params->direct_io;
>>>>        }
>>>> +
>>>> +    if (params->has_fds) {
>>>> +        dest->has_fds = true;
>>>
>>> I think what you want is to set this in
>>> migrate_params_init(). block_bitmap_mapping is a bit of an outlier in
>>> that it takes an empty *input* as valid.
>>
>> Hmm I made it behave like block_bitmap_mapping because it also a list.
>>
>> As I understand, for list we have to treat empty list not like absent parameter: we should have a way
>> to clear previously set list by subsequent migrate-set-parameters call.
>>
> 
> Sorry, I explained myself poorly. Yes, the empty list is valid and it
> clears a previously set value. But that's just:
> 
> migrate_params_init(MigrationParameters *params):
>      ...
>      params->has_fds = true;
> 
> migrate_params_test_apply(MigrateSetParameters *params,
>                            MigrationParameters *dest):
>      ...
>      /* means user provided it */
>      if (params->has_fds) {
>          dest->fds = params->fds;
>      }
> 
> migrate_params_check(MigrationParameters *params):
>      ...
>      if (params->has_fds) {
>         /* empty list ok */
>      }
> 
> migrate_params_apply(MigrateSetParameters *params):
>      ...
>      if (params->has_fds) {
>          qapi_free_...(s->parameters.fds);
>          /* clones the full list or the empty list, no difference */
>          s->parameters.fds = QAPI_CLONE(..., params->fds);
>      }
> 
> The block_bitmap_mapping does the has_ part a bit differently because it
> wants to carry that flag over to the rest of the code. See 3cba22c9ad
> ("migration: Fix block_bitmap_mapping migration"). In that case, even if
> the list is empty, it needs to know when it was made empty on purpose to
> carry on with the removal of the mappings. In your case, it doesn't
> matter, empty is empty, whether forcefully, or because it was never
> set. Right?

Oh, yes, understand now, thanks.



-- 
Best regards,
Vladimir

