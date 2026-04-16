Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6EA1F8A14D
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 09:27:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDIzv-0008QQ-Dk; Thu, 16 Apr 2026 05:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1wDIzi-0008O7-Nn; Thu, 16 Apr 2026 05:26:44 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1wDIze-0003P3-HM; Thu, 16 Apr 2026 05:26:42 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:7605:0:640:8d9a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id C3ED780612;
 Thu, 16 Apr 2026 12:26:31 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:730::1:7] (unknown [2a02:6bf:8080:730::1:7])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id SQJgAh0Lx8c0-6Oo0V4JS; Thu, 16 Apr 2026 12:26:31 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1776331591;
 bh=RqfRdkLPZtbsG526LYelcnrhoiAXUNgR/6jzmI91SQE=;
 h=In-Reply-To:Cc:Date:References:To:Subject:Message-ID:From;
 b=UIHIRVm6GbV9oibf/E/yMqAEaLCELyQpROXcjeeJG43gPn8xxn245PrYO7wE/LVj4
 FSmvntYdjqIsNTxUZTCm7Bu05QhUX+MYb2ep+8M3tf3PwAF13+qBMzQeEc0wBIxLrA
 9/J/4e9DN6fAVn+ElkbnglA+kwHSlYTkDARsbYsw=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Content-Type: multipart/alternative;
 boundary="------------8Bw7S1yUTzNSg9uY8sTttm6G"
Message-ID: <965db8ae-b44a-4b29-b006-56e8474d52b5@yandex-team.ru>
Date: Thu, 16 Apr 2026 14:26:27 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] vhost-user: add skip_drain param to GET_VRING_BASE
To: Raphael Norwitz <rnorwitz@nvidia.com>, qemu-devel@nongnu.org
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Milan Zamazal <mzamazal@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, zhenwei pi <zhenwei.pi@linux.dev>,
 Hanna Reitz <hreitz@redhat.com>, virtio-fs@lists.linux.dev,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
References: <20260330095226.158386-1-dtalexundeer@yandex-team.ru>
 <20260330095226.158386-6-dtalexundeer@yandex-team.ru>
 <613f140f-de27-4f83-8a02-5370833dd659@nvidia.com>
Content-Language: en-US
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
In-Reply-To: <613f140f-de27-4f83-8a02-5370833dd659@nvidia.com>
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is a multi-part message in MIME format.
--------------8Bw7S1yUTzNSg9uY8sTttm6G
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Greetings! Thanks for reply!


On 4/15/26 20:21, Raphael Norwitz wrote:
> I’m not sure I like using the num field in vhost_vring_state to set 
> magic values which affect protocol behavior for GET_VRING_BASE. It 
> feels like a hack to me. I would think the proper solution if we want 
> to support migration from new to old would be to have new use a 
> different new message entirely. Can we do that?

I think we can, but I thought at first that this will be almost a 
complete copy of GET_VRING_BASE message, with the exception of waiting 
for drain of requests, so I choose to expand existing message.

If this is not an appropriate approach, is it better to make a new 
message like GET_VRING_BASE or a separate message used together with 
default GET_VRING_BASE message (for example, message for setting some 
kind of status on the server)? What should I name this new message?

I also fix other comments, thanks!

>
> On 3/30/26 11:52 AM, Alexandr Moshkov wrote:
>> In case of migration of QEMU from the new version (where the
>> inllight-migration parameter is present), to the old one (where it is
>
> nit: spelling inllight-migration
>
>> absent) there is no way to disable this feature on the backend during
>> runtime.
>>
>> This commit slightly changes the semantics of the protocol feature
>> VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT. Enabling this feature
>> adds a new parameter for GET_VRING_BASE, which allows to control the
>> drain in-flight requests on the backend.
>> Thus, QEMU will be able to turn this feature on GET_VRING_BASE off and
>> on anytime.
>>
>> In vhost-user-blk use inflight_migration param to enable skip_drain to
>> suspend in-flight I/O requests, and then migrate them throught inflight
>> subsection.
>>
>> Also now QEMU will always try to setup
>> VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT protocol featrue with
>> backend. This will allow to use skip_drain parameter on GET_VRING_BASE
>> message.
>>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
>> ---
>>   docs/interop/vhost-user.rst    |  6 ++----
>>   hw/block/vhost-user-blk.c      | 30 ++++++++++++++++++++++++------
>>   hw/virtio/vhost-user.c         |  3 +--
>>   hw/virtio/vhost.c              |  1 +
>>   include/hw/virtio/vhost-user.h |  1 -
>>   5 files changed, 28 insertions(+), 13 deletions(-)
>>
>> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
>> index bfa75ff9a3..63efc87264 100644
>> --- a/docs/interop/vhost-user.rst
>> +++ b/docs/interop/vhost-user.rst
>> @@ -1255,14 +1255,12 @@ Front-end message types
>>     *suspended*, see :ref:`Suspended device state
>>     <suspended_device_state>`.
>>   -  The request payload's *num* field is currently reserved and must be
>> -  set to 0.
>> -
>>     By default, the back-end must complete all inflight I/O requests 
>> for the
>>     specified vring before stopping it.
>>       If the ``VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT`` protocol
>> -  feature has been negotiated, the back-end may suspend in-flight I/O
>> +  feature has been negotiated, using request payload's *num* field,
>> +  when *num* is set to 1, QEMU can tell the back-end to suspend 
>> in-flight I/O
>>     requests and record them as described in :ref:`Inflight I/O tracking
>>     <inflight_io_tracking>` instead of completing them before 
>> stopping the vring.
>>     How to suspend an in-flight request depends on the implementation 
>> of the back-end
>> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
>> index a3ecd83f54..522e9d34b5 100644
>> --- a/hw/block/vhost-user-blk.c
>> +++ b/hw/block/vhost-user-blk.c
>> @@ -134,10 +134,7 @@ static bool vhost_user_blk_inflight_needed(void 
>> *opaque)
>>   {
>>       struct VHostUserBlk *s = opaque;
>>   -    bool inflight_migration = 
>> virtio_has_feature(s->dev.protocol_features,
>> - VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT);
>> -
>> -    return inflight_migration;
>> +    return s->inflight_migration;
>>   }
>>     @@ -232,11 +229,14 @@ static int vhost_user_blk_stop(VirtIODevice 
>> *vdev)
>>           return 0;
>>       }
>>   +    bool skip_drain = vhost_user_blk_inflight_needed(s) &&
>
> nit: declarations on top
>
>> + runstate_check(RUN_STATE_FINISH_MIGRATE);
>> +
>>       force_stop = s->skip_get_vring_base_on_force_shutdown &&
>>                    qemu_force_shutdown_requested();
>>         ret = force_stop ? vhost_dev_force_stop(&s->dev, vdev, true) :
>> -                       vhost_dev_stop(&s->dev, vdev, true, false);
>> +                       vhost_dev_stop(&s->dev, vdev, true, skip_drain);
>>         if (k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false) 
>> < 0) {
>>           error_report("vhost guest notifier cleanup failed: %d", ret);
>> @@ -364,7 +364,6 @@ static int vhost_user_blk_connect(DeviceState 
>> *dev, Error **errp)
>>       vhost_dev_set_config_notifier(&s->dev, &blk_ops);
>>         s->vhost_user.supports_config = true;
>> -    s->vhost_user.supports_inflight_migration = s->inflight_migration;
>>       ret = vhost_dev_init(&s->dev, &s->vhost_user, 
>> VHOST_BACKEND_TYPE_USER, 0,
>>                            errp);
>>       if (ret < 0) {
>> @@ -580,10 +579,29 @@ static struct vhost_dev 
>> *vhost_user_blk_get_vhost(VirtIODevice *vdev)
>>       return &s->dev;
>>   }
>>   +static bool vhost_user_blk_pre_save(void *opaque, Error **errp)
>> +{
>> +    VHostUserBlk *s = VHOST_USER_BLK(opaque);
>> +
>> +    bool inflight_migration_enabled = virtio_has_feature(
>> +        s->dev.protocol_features,
>> +        VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT);
>> +    if (vhost_user_blk_inflight_needed(s) && 
>> !inflight_migration_enabled) {
>> +        error_setg(errp, "can't migrate vhost-user-blk device: "
>> +                         "backend doesn't support "
>> + "VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT "
>> +                         "protocol feature");
>> +        return false;
>> +    }
>> +
>> +    return true;
>> +}
>> +
>>   static const VMStateDescription vmstate_vhost_user_blk_inflight = {
>>       .name = "vhost-user-blk/inflight",
>>       .version_id = 1,
>>       .needed = vhost_user_blk_inflight_needed,
>> +    .pre_save_errp = vhost_user_blk_pre_save,
>>       .fields = (const VMStateField[]) {
>>           VMSTATE_VHOST_INFLIGHT_REGION(inflight, VHostUserBlk),
>>           VMSTATE_END_OF_LIST()
>> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>> index bb8f8eab77..ed95ec7523 100644
>> --- a/hw/virtio/vhost-user.c
>> +++ b/hw/virtio/vhost-user.c
>> @@ -2225,8 +2225,7 @@ static int vhost_user_backend_init(struct 
>> vhost_dev *dev, void *opaque,
>>               }
>>           }
>>   -        if (!u->user->supports_inflight_migration ||
>> -            !virtio_has_feature(protocol_features,
>> +        if (!virtio_has_feature(protocol_features,
>> VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
>>               protocol_features &= ~(1ULL <<
>> VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT);
>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> index ac4d6fca73..54e4ce2660 100644
>> --- a/hw/virtio/vhost.c
>> +++ b/hw/virtio/vhost.c
>> @@ -1398,6 +1398,7 @@ static int do_vhost_virtqueue_stop(struct 
>> vhost_dev *dev,
>>       int vhost_vq_index = dev->vhost_ops->vhost_get_vq_index(dev, idx);
>>       struct vhost_vring_state state = {
>>           .index = vhost_vq_index,
>> +        .num = skip_drain,
>>       };
>>       int r = 0;
>>   diff --git a/include/hw/virtio/vhost-user.h 
>> b/include/hw/virtio/vhost-user.h
>> index 53fe996686..c95bad5ddc 100644
>> --- a/include/hw/virtio/vhost-user.h
>> +++ b/include/hw/virtio/vhost-user.h
>> @@ -69,7 +69,6 @@ typedef struct VhostUserState {
>>       GPtrArray *notifiers;
>>       int memory_slots;
>>       bool supports_config;
>> -    bool supports_inflight_migration;
>>   } VhostUserState;
>>     /**
>
--------------8Bw7S1yUTzNSg9uY8sTttm6G
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Greetings! Thanks for reply!</p>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 4/15/26 20:21, Raphael Norwitz
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:613f140f-de27-4f83-8a02-5370833dd659@nvidia.com">I’m not
      sure I like using the num field in vhost_vring_state to set magic
      values which affect protocol behavior for GET_VRING_BASE. It feels
      like a hack to me. I would think the proper solution if we want to
      support migration from new to old would be to have new use a
      different new message entirely. Can we do that? <br>
    </blockquote>
    <p>I think we can, but I thought at first that this will be almost a
      complete copy of GET_VRING_BASE message, with the exception of
      waiting for drain of requests, so I choose to expand existing
      message.</p>
    <p><span style="white-space: pre-wrap;">If this is not an appropriate approach, is it better to make a new message like GET_</span><span
      data-lexical-key="157" data-highlighted="false" data-error="true"
      style="white-space: pre-wrap;">VRING</span><span
      style="white-space: pre-wrap;">_BASE or a separate message used together with default GET_</span><span
      data-lexical-key="159" data-highlighted="false" data-error="true"
      style="white-space: pre-wrap;">VRING</span><span
      style="white-space: pre-wrap;">_BASE message (for example, message for setting some kind of status on the server)? What should I name this new message?</span><span
      style="white-space: pre-wrap;"> </span></p>
    <p>I also fix other comments, thanks!</p>
    <blockquote type="cite"
      cite="mid:613f140f-de27-4f83-8a02-5370833dd659@nvidia.com"><br>
      On 3/30/26 11:52 AM, Alexandr Moshkov wrote:
      <br>
      <blockquote type="cite">In case of migration of QEMU from the new
        version (where the
        <br>
        inllight-migration parameter is present), to the old one (where
        it is
        <br>
      </blockquote>
      <br>
      nit: spelling inllight-migration
      <br>
      <br>
      <blockquote type="cite">absent) there is no way to disable this
        feature on the backend during
        <br>
        runtime.
        <br>
        <br>
        This commit slightly changes the semantics of the protocol
        feature
        <br>
        VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT. Enabling this
        feature
        <br>
        adds a new parameter for GET_VRING_BASE, which allows to control
        the
        <br>
        drain in-flight requests on the backend.
        <br>
        Thus, QEMU will be able to turn this feature on GET_VRING_BASE
        off and
        <br>
        on anytime.
        <br>
        <br>
        In vhost-user-blk use inflight_migration param to enable
        skip_drain to
        <br>
        suspend in-flight I/O requests, and then migrate them throught
        inflight
        <br>
        subsection.
        <br>
        <br>
        Also now QEMU will always try to setup
        <br>
        VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT protocol featrue
        with
        <br>
        backend. This will allow to use skip_drain parameter on
        GET_VRING_BASE
        <br>
        message.
        <br>
        <br>
        Reviewed-by: Vladimir Sementsov-Ogievskiy
        <a class="moz-txt-link-rfc2396E" href="mailto:vsementsov@yandex-team.ru">&lt;vsementsov@yandex-team.ru&gt;</a>
        <br>
        Signed-off-by: Alexandr Moshkov
        <a class="moz-txt-link-rfc2396E" href="mailto:dtalexundeer@yandex-team.ru">&lt;dtalexundeer@yandex-team.ru&gt;</a>
        <br>
        ---
        <br>
          docs/interop/vhost-user.rst    |  6 ++----
        <br>
          hw/block/vhost-user-blk.c      | 30
        ++++++++++++++++++++++++------
        <br>
          hw/virtio/vhost-user.c         |  3 +--
        <br>
          hw/virtio/vhost.c              |  1 +
        <br>
          include/hw/virtio/vhost-user.h |  1 -
        <br>
          5 files changed, 28 insertions(+), 13 deletions(-)
        <br>
        <br>
        diff --git a/docs/interop/vhost-user.rst
        b/docs/interop/vhost-user.rst
        <br>
        index bfa75ff9a3..63efc87264 100644
        <br>
        --- a/docs/interop/vhost-user.rst
        <br>
        +++ b/docs/interop/vhost-user.rst
        <br>
        @@ -1255,14 +1255,12 @@ Front-end message types
        <br>
            *suspended*, see :ref:`Suspended device state
        <br>
            &lt;suspended_device_state&gt;`.
        <br>
          -  The request payload's *num* field is currently reserved and
        must be
        <br>
        -  set to 0.
        <br>
        -
        <br>
            By default, the back-end must complete all inflight I/O
        requests for the
        <br>
            specified vring before stopping it.
        <br>
              If the ``VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT``
        protocol
        <br>
        -  feature has been negotiated, the back-end may suspend
        in-flight I/O
        <br>
        +  feature has been negotiated, using request payload's *num*
        field,
        <br>
        +  when *num* is set to 1, QEMU can tell the back-end to suspend
        in-flight I/O
        <br>
            requests and record them as described in :ref:`Inflight I/O
        tracking
        <br>
            &lt;inflight_io_tracking&gt;` instead of completing them
        before stopping the vring.
        <br>
            How to suspend an in-flight request depends on the
        implementation of the back-end
        <br>
        diff --git a/hw/block/vhost-user-blk.c
        b/hw/block/vhost-user-blk.c
        <br>
        index a3ecd83f54..522e9d34b5 100644
        <br>
        --- a/hw/block/vhost-user-blk.c
        <br>
        +++ b/hw/block/vhost-user-blk.c
        <br>
        @@ -134,10 +134,7 @@ static bool
        vhost_user_blk_inflight_needed(void *opaque)
        <br>
          {
        <br>
              struct VHostUserBlk *s = opaque;
        <br>
          -    bool inflight_migration =
        virtio_has_feature(s-&gt;dev.protocol_features,
        <br>
        -                              
        VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT);
        <br>
        -
        <br>
        -    return inflight_migration;
        <br>
        +    return s-&gt;inflight_migration;
        <br>
          }
        <br>
            @@ -232,11 +229,14 @@ static int
        vhost_user_blk_stop(VirtIODevice *vdev)
        <br>
                  return 0;
        <br>
              }
        <br>
          +    bool skip_drain = vhost_user_blk_inflight_needed(s)
        &amp;&amp;
        <br>
      </blockquote>
      <br>
      nit: declarations on top
      <br>
      <br>
      <blockquote type="cite">+                     
        runstate_check(RUN_STATE_FINISH_MIGRATE);
        <br>
        +
        <br>
              force_stop = s-&gt;skip_get_vring_base_on_force_shutdown
        &amp;&amp;
        <br>
                           qemu_force_shutdown_requested();
        <br>
                ret = force_stop ? vhost_dev_force_stop(&amp;s-&gt;dev,
        vdev, true) :
        <br>
        -                       vhost_dev_stop(&amp;s-&gt;dev, vdev,
        true, false);
        <br>
        +                       vhost_dev_stop(&amp;s-&gt;dev, vdev,
        true, skip_drain);
        <br>
                if (k-&gt;set_guest_notifiers(qbus-&gt;parent,
        s-&gt;dev.nvqs, false) &lt; 0) {
        <br>
                  error_report("vhost guest notifier cleanup failed:
        %d", ret);
        <br>
        @@ -364,7 +364,6 @@ static int
        vhost_user_blk_connect(DeviceState *dev, Error **errp)
        <br>
              vhost_dev_set_config_notifier(&amp;s-&gt;dev,
        &amp;blk_ops);
        <br>
                s-&gt;vhost_user.supports_config = true;
        <br>
        -    s-&gt;vhost_user.supports_inflight_migration =
        s-&gt;inflight_migration;
        <br>
              ret = vhost_dev_init(&amp;s-&gt;dev,
        &amp;s-&gt;vhost_user, VHOST_BACKEND_TYPE_USER, 0,
        <br>
                                   errp);
        <br>
              if (ret &lt; 0) {
        <br>
        @@ -580,10 +579,29 @@ static struct vhost_dev
        *vhost_user_blk_get_vhost(VirtIODevice *vdev)
        <br>
              return &amp;s-&gt;dev;
        <br>
          }
        <br>
          +static bool vhost_user_blk_pre_save(void *opaque, Error
        **errp)
        <br>
        +{
        <br>
        +    VHostUserBlk *s = VHOST_USER_BLK(opaque);
        <br>
        +
        <br>
        +    bool inflight_migration_enabled = virtio_has_feature(
        <br>
        +        s-&gt;dev.protocol_features,
        <br>
        +        VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT);
        <br>
        +    if (vhost_user_blk_inflight_needed(s) &amp;&amp;
        !inflight_migration_enabled) {
        <br>
        +        error_setg(errp, "can't migrate vhost-user-blk device:
        "
        <br>
        +                         "backend doesn't support "
        <br>
        +                        
        "VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT "
        <br>
        +                         "protocol feature");
        <br>
        +        return false;
        <br>
        +    }
        <br>
        +
        <br>
        +    return true;
        <br>
        +}
        <br>
        +
        <br>
          static const VMStateDescription
        vmstate_vhost_user_blk_inflight = {
        <br>
              .name = "vhost-user-blk/inflight",
        <br>
              .version_id = 1,
        <br>
              .needed = vhost_user_blk_inflight_needed,
        <br>
        +    .pre_save_errp = vhost_user_blk_pre_save,
        <br>
              .fields = (const VMStateField[]) {
        <br>
                  VMSTATE_VHOST_INFLIGHT_REGION(inflight, VHostUserBlk),
        <br>
                  VMSTATE_END_OF_LIST()
        <br>
        diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
        <br>
        index bb8f8eab77..ed95ec7523 100644
        <br>
        --- a/hw/virtio/vhost-user.c
        <br>
        +++ b/hw/virtio/vhost-user.c
        <br>
        @@ -2225,8 +2225,7 @@ static int vhost_user_backend_init(struct
        vhost_dev *dev, void *opaque,
        <br>
                      }
        <br>
                  }
        <br>
          -        if (!u-&gt;user-&gt;supports_inflight_migration ||
        <br>
        -            !virtio_has_feature(protocol_features,
        <br>
        +        if (!virtio_has_feature(protocol_features,
        <br>
                                         
        VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
        <br>
                      protocol_features &amp;= ~(1ULL &lt;&lt;
        <br>
                                        
        VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT);
        <br>
        diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
        <br>
        index ac4d6fca73..54e4ce2660 100644
        <br>
        --- a/hw/virtio/vhost.c
        <br>
        +++ b/hw/virtio/vhost.c
        <br>
        @@ -1398,6 +1398,7 @@ static int do_vhost_virtqueue_stop(struct
        vhost_dev *dev,
        <br>
              int vhost_vq_index =
        dev-&gt;vhost_ops-&gt;vhost_get_vq_index(dev, idx);
        <br>
              struct vhost_vring_state state = {
        <br>
                  .index = vhost_vq_index,
        <br>
        +        .num = skip_drain,
        <br>
              };
        <br>
              int r = 0;
        <br>
          diff --git a/include/hw/virtio/vhost-user.h
        b/include/hw/virtio/vhost-user.h
        <br>
        index 53fe996686..c95bad5ddc 100644
        <br>
        --- a/include/hw/virtio/vhost-user.h
        <br>
        +++ b/include/hw/virtio/vhost-user.h
        <br>
        @@ -69,7 +69,6 @@ typedef struct VhostUserState {
        <br>
              GPtrArray *notifiers;
        <br>
              int memory_slots;
        <br>
              bool supports_config;
        <br>
        -    bool supports_inflight_migration;
        <br>
          } VhostUserState;
        <br>
            /**
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------8Bw7S1yUTzNSg9uY8sTttm6G--

