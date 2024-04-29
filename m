Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B70CC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 12:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Q1T-0005LR-O7; Mon, 29 Apr 2024 08:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1Q1O-0005K3-5v; Mon, 29 Apr 2024 08:22:15 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1Q1J-0000qz-Rs; Mon, 29 Apr 2024 08:22:13 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2a2a:0:640:d546:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id F276660A8D;
 Mon, 29 Apr 2024 15:22:03 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b739::1:30] (unknown
 [2a02:6b8:b081:b739::1:30])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 2MPSKE11PmI0-9VINApjD; Mon, 29 Apr 2024 15:22:03 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1714393323;
 bh=l7TzBvxOdTtz2kN5Zhu2+DU43VtRtXgrZEVcnfxd0XU=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=PmL6boaN8VqZM7xewbJcfrlHgoO3UQRQql4K8e2cRdTNI4mF9TrhhdsSw63SyzI60
 NMPLNJMp20k94JNimk2LiwYD5iBdvvgkyyrEqJwj0RE9oQ/TMgNvbMmIR+1UYhYL0/
 gxk8X9FGsLwkld2eHywi5Bh9Tl7bimkZzjDq8tgA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <a8245017-131c-47c4-b323-0185a08d728b@yandex-team.ru>
Date: Mon, 29 Apr 2024 15:22:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] qapi: introduce device-sync-config
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, raphael@enfabrica.net, mst@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, dave@treblig.org,
 eblake@redhat.com, qemu-devel@nongnu.org, yc-core@yandex-team.ru
References: <20240329183758.3360733-1-vsementsov@yandex-team.ru>
 <20240329183758.3360733-5-vsementsov@yandex-team.ru>
 <87plufvv4s.fsf@pond.sub.org>
 <60a332e2-f18c-4c78-9ea9-344ab49e9b8e@yandex-team.ru>
 <87le4wjvbl.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87le4wjvbl.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 29.04.24 13:51, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> On 24.04.24 14:48, Markus Armbruster wrote:
>>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>>>
>>>> Add command to sync config from vhost-user backend to the device. It
>>>> may be helpful when VHOST_USER_SLAVE_CONFIG_CHANGE_MSG failed or not
>>>> triggered interrupt to the guest or just not available (not supported
>>>> by vhost-user server).
>>>>
>>>> Command result is racy if allow it during migration. Let's allow the
>>>> sync only in RUNNING state.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> [...]
> 
>>>> diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
>>>> index 0117d243c4..296af52322 100644
>>>> --- a/include/sysemu/runstate.h
>>>> +++ b/include/sysemu/runstate.h
>>>> @@ -5,6 +5,7 @@
>>>>    #include "qemu/notify.h"
>>>>    
>>>>    bool runstate_check(RunState state);
>>>> +const char *current_run_state_str(void);
>>>>    void runstate_set(RunState new_state);
>>>>    RunState runstate_get(void);
>>>>    bool runstate_is_running(void);
>>>> diff --git a/qapi/qdev.json b/qapi/qdev.json
>>>> index facaa0bc6a..e8be79c3d5 100644
>>>> --- a/qapi/qdev.json
>>>> +++ b/qapi/qdev.json
>>>> @@ -161,3 +161,24 @@
>>>>    ##
>>>>    { 'event': 'DEVICE_UNPLUG_GUEST_ERROR',
>>>>      'data': { '*device': 'str', 'path': 'str' } }
>>>> +
>>>> +##
>>>> +# @device-sync-config:
>>>> +#
>>>> +# Synchronize config from backend to the guest. The command notifies
>>>> +# re-read the device config from the backend and notifies the guest
>>>> +# to re-read the config. The command may be used to notify the guest
>>>> +# about block device capcity change. Currently only vhost-user-blk
>>>> +# device supports this.
>>>
>>> I'm not sure I understand this.  To work towards an understanding, I
>>> rephrase it, and you point out the errors.
>>>
>>>        Synchronize device configuration from host to guest part.  First,
>>>        copy the configuration from the host part (backend) to the guest
>>>        part (frontend).  Then notify guest software that device
>>>        configuration changed.
>>
>> Correct, thanks
> 
> Perhaps
> 
>    Synchronize guest-visible device configuration with the backend's
>    configuration, and notify guest software that device configuration
>    changed.
> 
>    This may be useful to notify the guest of a block device capacity
>    change.  Currenrly, only vhost-user-blk devices support this.

Sounds good

> 
> Next question: what happens when the device *doesn't* support this?

An error "device-sync-config is not supported ..."

> 
>>> I wonder how configuration can get out of sync.  Can you explain?
>>>
>>
>> The example (and the original feature, which triggered developing this) is vhost disk resize. If vhost-server (backend) doesn't support VHOST_USER_SLAVE_CONFIG_CHANGE_MSG, neither QEMU nor guest will know that disk capacity changed.
> 
> Sounds like we wouldn't need this command if we could make the
> vhost-server support VHOST_USER_SLAVE_CONFIG_CHANGE_MSG.  Is making it
> support it impractical?  Or are there other uses for this command?

Qemu's internal vhost-server do support it. But that's not the only vhost-user server) So the command is useful for those servers which doesn't support VHOST_USER_SLAVE_CONFIG_CHANGE_MSG. Note, that this message requires setting up additional channel of server -> client communication. That was the reason, why the "change-msg" solution was rejected in our downstream: it's safer to reuse existing channel (QMP), than to add and support an additional channel.

Also, the command may help to debug the system, when VHOST_USER_SLAVE_CONFIG_CHANGE_MSG doesn't work for some reason.

> 
>>>> +#
>>>> +# @id: the device's ID or QOM path
>>>> +#
>>>> +# Features:
>>>> +#
>>>> +# @unstable: The command is experimental.
>>>> +#
>>>> +# Since: 9.1
>>>> +##
>>>> +{ 'command': 'device-sync-config',
>>>> +  'features': [ 'unstable' ],
>>>> +  'data': {'id': 'str'} }
>>>> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
>>>> index 7e075d91c1..cb35ea0b86 100644
>>>> --- a/system/qdev-monitor.c
>>>> +++ b/system/qdev-monitor.c
>>>> @@ -23,6 +23,7 @@
>>>>   #include "monitor/monitor.h"
>>>>   #include "monitor/qdev.h"
>>>>   #include "sysemu/arch_init.h"
>>>> +#include "sysemu/runstate.h"
>>>>   #include "qapi/error.h"
>>>>   #include "qapi/qapi-commands-qdev.h"
>>>>   #include "qapi/qmp/dispatch.h"
>>>> @@ -969,6 +970,52 @@ void qmp_device_del(const char *id, Error **errp)
>>>>        }
>>>>    }
>>>>    
>>>> +int qdev_sync_config(DeviceState *dev, Error **errp)
>>>> +{
>>>> +    DeviceClass *dc = DEVICE_GET_CLASS(dev);
>>>> +
>>>> +    if (!dc->sync_config) {
>>>> +        error_setg(errp, "device-sync-config is not supported for '%s'",
>>>> +                   object_get_typename(OBJECT(dev)));
>>>> +        return -ENOTSUP;
>>>> +    }
>>>> +
>>>> +    return dc->sync_config(dev, errp);
>>>> +}
>>>> +
>>>> +void qmp_device_sync_config(const char *id, Error **errp)
>>>> +{
>>>> +    DeviceState *dev;
>>>> +
>>>> +    /*
>>>> +     * During migration there is a race between syncing`config and
>>>> +     * migrating it, so let's just not allow it.
>>>
>>> Can you briefly explain the race?
>>
>> If at the moment of qmp command, corresponding config already migrated to the target, we'll change only the config on source, but on the target we'll still have outdated config.
> 
> For RAM, dirty tracking ensures the change gets sent.  But this is
> device memory.  Correct?

Yes. It's stored in malloced buffer VirtIIODevice::config, and accessed through handlers virtio_pci_config_read()/virtio_pci_config_write(). As I understand, no kind of dirty tracking here..

And I see, it's migrated in virtio_save():
...
     qemu_put_be32(f, vdev->config_len);
     qemu_put_buffer(f, vdev->config, vdev->config_len);
...

> 
>>>> +     *
>>>> +     * Moreover, let's not rely on setting up interrupts in paused
>>>> +     * state, which may be a part of migration process.
>>>
>>> What dependence exactly are you avoiding?  Config synchronization
>>> depending on guest interrupt delivery?
>>
>> Right, guest is notified by pci_set_irq.
> 
> If we allowed it in paused state, the delivery of the interrupt would be
> delayed until the guest resumes running.  Correct?

I think so. But this will not work, if we do offline migration like pause -> migrate -> resume on target. So I decided that better be more safe. The restrictions may be relaxed in future if needed.

> 
>>>> +     */
>>>> +
>>>> +    if (migration_is_running()) {
>>>> +        error_setg(errp, "Config synchronization is not allowed "
>>>> +                   "during migration.");
>>>
>>> qapi/error.h:
>>>
>>>        * The resulting message should be a single phrase, with no newline or
>>>        * trailing punctuation.
>>>
>>> Drop the period, please.
>>
>> Will do
>>
>>>
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    if (!runstate_is_running()) {
>>>> +        error_setg(errp, "Config synchronization allowed only in '%s' state, "
>>>> +                   "current state is '%s'", RunState_str(RUN_STATE_RUNNING),
>>>> +                   current_run_state_str());
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    dev = find_device_state(id, true, errp);
>>>> +    if (!dev) {
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    qdev_sync_config(dev, errp);
>>>> +}
>>>> +
>>>>    void hmp_device_add(Monitor *mon, const QDict *qdict)
>>>>    {
>>>>        Error *err = NULL;
> 
> [...]
> 

-- 
Best regards,
Vladimir


