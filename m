Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CAABCA5FEF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 06:45:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhj06-0004NN-9o; Mon, 19 Jan 2026 01:44:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vhj00-0004Gy-9y; Mon, 19 Jan 2026 01:44:28 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vhizx-0005EG-1D; Mon, 19 Jan 2026 01:44:28 -0500
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 7CDCF80773;
 Mon, 19 Jan 2026 09:44:17 +0300 (MSK)
Received: from [IPV6:2a02:6bf:803e:400:b140:e026:1e77:2c4e] (unknown
 [2a02:6bf:803e:400:b140:e026:1e77:2c4e])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id DiS7FK1AGSw0-7xdEwpIv; Mon, 19 Jan 2026 09:44:16 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1768805057;
 bh=ZsvMTs0Uqlh1GRTwseMjcxyIQFvUltLDZ2/diE7k4E4=;
 h=In-Reply-To:Cc:Date:References:To:Subject:Message-ID:From;
 b=pr7LkyulQMe7nFML1MZxUjJEL4zyxR4gjFL6bL/Hq+jYYZcfWfq5rs9Qe1uroSMcE
 4pHoxx/MBiGagVG1H+JXLBg/qSkr/sUu4PdCen6GH55J69l70sn5RU76OblNQRknCR
 4FQZM2SXyfn2rpELJQJRdBfKGXS4oO1R5oALKT6k=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Content-Type: multipart/alternative;
 boundary="------------1y9Tz0fCHamFvToe7ZbcvFe9"
Message-ID: <947c2ef9-dbd8-46ea-b61d-1817fb4c33aa@yandex-team.ru>
Date: Mon, 19 Jan 2026 11:44:21 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/5] vhost-user-blk: support inter-host inflight
 migration
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Cc: qemu-devel@nongnu.org, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, mzamazal@redhat.com,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-block@nongnu.org, virtio-fs@lists.linux.dev,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20260115081103.655749-1-dtalexundeer@yandex-team.ru>
 <20260115081103.655749-6-dtalexundeer@yandex-team.ru>
 <CAFubqFtKrsPn++kMPEAOO2LdygY9BZyDmzb0nU7YbK1on2GNCw@mail.gmail.com>
Content-Language: en-US
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
In-Reply-To: <CAFubqFtKrsPn++kMPEAOO2LdygY9BZyDmzb0nU7YbK1on2GNCw@mail.gmail.com>
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
--------------1y9Tz0fCHamFvToe7ZbcvFe9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/17/26 00:50, Raphael Norwitz wrote:
> Apologies if I've missed something obvious here - what actually skips
> the GET_VRING_BASE operation here? I was expecting something like:
>
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -221,8 +221,9 @@ static int vhost_user_blk_stop(VirtIODevice *vdev)
>           return 0;
>       }
>
> -    force_stop = s->skip_get_vring_base_on_force_shutdown &&
> -                 qemu_force_shutdown_requested();
> +    force_stop = (s->skip_get_vring_base_on_force_shutdown &&
> +                 qemu_force_shutdown_requested()) ||
> +                 s->inflight_migration; // FIXME: runstate check?
>
> Without setting force_stop in vhost_user_blk_stop() I don't see how
> the GET_VRING_BASE operation would be skipped.

Nothing skip GET_VRING_BASE) In the first versions of the patch, this 
was done, but then I realized that this was the wrong way, because the 
last_avail_idx and avail_idx counters may be incorrect after migration.

Therefore, it is now implemented that on GET_VRING_BASE the backend 
needs to either wait for all in-flight requests or not (depending on 
protocol_feature).

> On Thu, Jan 15, 2026 at 3:13 AM Alexandr Moshkov
> <dtalexundeer@yandex-team.ru> wrote:
>> During inter-host migration, waiting for disk requests to be drained
>> in the vhost-user backend can incur significant downtime.
>>
>> This can be avoided if QEMU migrates the inflight region in
>> vhost-user-blk.
>> Thus, during the qemu migration, with feature flag the vhost-user
>> back-end can immediately stop vrings, so all in-flight requests will be
>> migrated to another host.
>>
>> Signed-off-by: Alexandr Moshkov<dtalexundeer@yandex-team.ru>
>> Reviewed-by: Stefan Hajnoczi<stefanha@redhat.com>
>> ---
>>   hw/block/vhost-user-blk.c          | 27 +++++++++++++++++++++++++++
>>   include/hw/virtio/vhost-user-blk.h |  1 +
>>   include/hw/virtio/vhost.h          |  6 ++++++
>>   3 files changed, 34 insertions(+)
>>
>> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
>> index 4d81d2dc34..c151e83677 100644
>> --- a/hw/block/vhost-user-blk.c
>> +++ b/hw/block/vhost-user-blk.c
>> @@ -353,6 +353,7 @@ static int vhost_user_blk_connect(DeviceState *dev, Error **errp)
>>       vhost_dev_set_config_notifier(&s->dev, &blk_ops);
>>
>>       s->vhost_user.supports_config = true;
>> +    s->vhost_user.supports_inflight_migration = s->inflight_migration;
>>       ret = vhost_dev_init(&s->dev, &s->vhost_user, VHOST_BACKEND_TYPE_USER, 0,
>>                            errp);
>>       if (ret < 0) {
>> @@ -568,6 +569,26 @@ static struct vhost_dev *vhost_user_blk_get_vhost(VirtIODevice *vdev)
>>       return &s->dev;
>>   }
>>
>> +static bool vhost_user_blk_inflight_needed(void *opaque)
>> +{
>> +    struct VHostUserBlk *s = opaque;
>> +
>> +    bool inflight_migration = virtio_has_feature(s->dev.protocol_features,
>> +                               VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT);
>> +
>> +    return inflight_migration;
>> +}
>> +
>> +static const VMStateDescription vmstate_vhost_user_blk_inflight = {
>> +    .name = "vhost-user-blk/inflight",
>> +    .version_id = 1,
>> +    .needed = vhost_user_blk_inflight_needed,
>> +    .fields = (const VMStateField[]) {
>> +        VMSTATE_VHOST_INFLIGHT_REGION(inflight, VHostUserBlk),
>> +        VMSTATE_END_OF_LIST()
>> +    },
>> +};
>> +
>>   static const VMStateDescription vmstate_vhost_user_blk = {
>>       .name = "vhost-user-blk",
>>       .minimum_version_id = 1,
>> @@ -576,6 +597,10 @@ static const VMStateDescription vmstate_vhost_user_blk = {
>>           VMSTATE_VIRTIO_DEVICE,
>>           VMSTATE_END_OF_LIST()
>>       },
>> +    .subsections = (const VMStateDescription * const []) {
>> +        &vmstate_vhost_user_blk_inflight,
>> +        NULL
>> +    }
>>   };
>>
>>   static const Property vhost_user_blk_properties[] = {
>> @@ -591,6 +616,8 @@ static const Property vhost_user_blk_properties[] = {
>>                         VIRTIO_BLK_F_WRITE_ZEROES, true),
>>       DEFINE_PROP_BOOL("skip-get-vring-base-on-force-shutdown", VHostUserBlk,
>>                        skip_get_vring_base_on_force_shutdown, false),
>> +    DEFINE_PROP_BOOL("inflight-migration", VHostUserBlk,
>> +                     inflight_migration, false),
>>   };
>>
>>   static void vhost_user_blk_class_init(ObjectClass *klass, const void *data)
>> diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-user-blk.h
>> index 8158d4673d..1e41a2bcdf 100644
>> --- a/include/hw/virtio/vhost-user-blk.h
>> +++ b/include/hw/virtio/vhost-user-blk.h
>> @@ -52,6 +52,7 @@ struct VHostUserBlk {
>>       bool started_vu;
>>
>>       bool skip_get_vring_base_on_force_shutdown;
>> +    bool inflight_migration;
>>   };
>>
>>   #endif
>> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
>> index 08bbb4dfe9..89817bd848 100644
>> --- a/include/hw/virtio/vhost.h
>> +++ b/include/hw/virtio/vhost.h
>> @@ -554,4 +554,10 @@ static inline int vhost_load_backend_state(struct vhost_dev *dev, QEMUFile *f,
>>   }
>>   #endif
>>
>> +extern const VMStateDescription vmstate_vhost_inflight_region;
>> +#define VMSTATE_VHOST_INFLIGHT_REGION(_field, _state) \
>> +    VMSTATE_STRUCT_POINTER(_field, _state, \
>> +                           vmstate_vhost_inflight_region, \
>> +                           struct vhost_inflight)
>> +
>>   #endif
>> --
>> 2.34.1
>>
>>
--------------1y9Tz0fCHamFvToe7ZbcvFe9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 1/17/26 00:50, Raphael Norwitz
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAFubqFtKrsPn++kMPEAOO2LdygY9BZyDmzb0nU7YbK1on2GNCw@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">Apologies if I've missed something obvious here - what actually skips
the GET_VRING_BASE operation here? I was expecting something like:

--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -221,8 +221,9 @@ static int vhost_user_blk_stop(VirtIODevice *vdev)
         return 0;
     }

-    force_stop = s-&gt;skip_get_vring_base_on_force_shutdown &amp;&amp;
-                 qemu_force_shutdown_requested();
+    force_stop = (s-&gt;skip_get_vring_base_on_force_shutdown &amp;&amp;
+                 qemu_force_shutdown_requested()) ||
+                 s-&gt;inflight_migration; // FIXME: runstate check?

Without setting force_stop in vhost_user_blk_stop() I don't see how
the GET_VRING_BASE operation would be skipped.</pre>
    </blockquote>
    <p class="CPO0LE0j16AwB0G2HeuZ" dir="ltr"><span
      style="white-space: pre-wrap;">Nothing skip GET_VRING_BASE) In the first versions of the patch, this was done, but then I realized that this was the wrong way, because the last_avail_idx and avail_idx counters may be incorrect after migration. </span></p>
    <p class="CPO0LE0j16AwB0G2HeuZ" dir="ltr"><span
      style="white-space: pre-wrap;">Therefore, it is now implemented that on GET_</span><span
      data-lexical-key="142" data-highlighted="false" data-error="true"
      style="white-space: pre-wrap;">VRING</span><span
      style="white-space: pre-wrap;">_BASE the backend needs to either wait for all in-flight requests or not (depending on protocol_feature).</span></p>
    <p></p>
    <blockquote type="cite"
cite="mid:CAFubqFtKrsPn++kMPEAOO2LdygY9BZyDmzb0nU7YbK1on2GNCw@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">
On Thu, Jan 15, 2026 at 3:13 AM Alexandr Moshkov
<a class="moz-txt-link-rfc2396E" href="mailto:dtalexundeer@yandex-team.ru">&lt;dtalexundeer@yandex-team.ru&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
During inter-host migration, waiting for disk requests to be drained
in the vhost-user backend can incur significant downtime.

This can be avoided if QEMU migrates the inflight region in
vhost-user-blk.
Thus, during the qemu migration, with feature flag the vhost-user
back-end can immediately stop vrings, so all in-flight requests will be
migrated to another host.

Signed-off-by: Alexandr Moshkov <a class="moz-txt-link-rfc2396E" href="mailto:dtalexundeer@yandex-team.ru">&lt;dtalexundeer@yandex-team.ru&gt;</a>
Reviewed-by: Stefan Hajnoczi <a class="moz-txt-link-rfc2396E" href="mailto:stefanha@redhat.com">&lt;stefanha@redhat.com&gt;</a>
---
 hw/block/vhost-user-blk.c          | 27 +++++++++++++++++++++++++++
 include/hw/virtio/vhost-user-blk.h |  1 +
 include/hw/virtio/vhost.h          |  6 ++++++
 3 files changed, 34 insertions(+)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 4d81d2dc34..c151e83677 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -353,6 +353,7 @@ static int vhost_user_blk_connect(DeviceState *dev, Error **errp)
     vhost_dev_set_config_notifier(&amp;s-&gt;dev, &amp;blk_ops);

     s-&gt;vhost_user.supports_config = true;
+    s-&gt;vhost_user.supports_inflight_migration = s-&gt;inflight_migration;
     ret = vhost_dev_init(&amp;s-&gt;dev, &amp;s-&gt;vhost_user, VHOST_BACKEND_TYPE_USER, 0,
                          errp);
     if (ret &lt; 0) {
@@ -568,6 +569,26 @@ static struct vhost_dev *vhost_user_blk_get_vhost(VirtIODevice *vdev)
     return &amp;s-&gt;dev;
 }

+static bool vhost_user_blk_inflight_needed(void *opaque)
+{
+    struct VHostUserBlk *s = opaque;
+
+    bool inflight_migration = virtio_has_feature(s-&gt;dev.protocol_features,
+                               VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT);
+
+    return inflight_migration;
+}
+
+static const VMStateDescription vmstate_vhost_user_blk_inflight = {
+    .name = "vhost-user-blk/inflight",
+    .version_id = 1,
+    .needed = vhost_user_blk_inflight_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_VHOST_INFLIGHT_REGION(inflight, VHostUserBlk),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static const VMStateDescription vmstate_vhost_user_blk = {
     .name = "vhost-user-blk",
     .minimum_version_id = 1,
@@ -576,6 +597,10 @@ static const VMStateDescription vmstate_vhost_user_blk = {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
+    .subsections = (const VMStateDescription * const []) {
+        &amp;vmstate_vhost_user_blk_inflight,
+        NULL
+    }
 };

 static const Property vhost_user_blk_properties[] = {
@@ -591,6 +616,8 @@ static const Property vhost_user_blk_properties[] = {
                       VIRTIO_BLK_F_WRITE_ZEROES, true),
     DEFINE_PROP_BOOL("skip-get-vring-base-on-force-shutdown", VHostUserBlk,
                      skip_get_vring_base_on_force_shutdown, false),
+    DEFINE_PROP_BOOL("inflight-migration", VHostUserBlk,
+                     inflight_migration, false),
 };

 static void vhost_user_blk_class_init(ObjectClass *klass, const void *data)
diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-user-blk.h
index 8158d4673d..1e41a2bcdf 100644
--- a/include/hw/virtio/vhost-user-blk.h
+++ b/include/hw/virtio/vhost-user-blk.h
@@ -52,6 +52,7 @@ struct VHostUserBlk {
     bool started_vu;

     bool skip_get_vring_base_on_force_shutdown;
+    bool inflight_migration;
 };

 #endif
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 08bbb4dfe9..89817bd848 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -554,4 +554,10 @@ static inline int vhost_load_backend_state(struct vhost_dev *dev, QEMUFile *f,
 }
 #endif

+extern const VMStateDescription vmstate_vhost_inflight_region;
+#define VMSTATE_VHOST_INFLIGHT_REGION(_field, _state) \
+    VMSTATE_STRUCT_POINTER(_field, _state, \
+                           vmstate_vhost_inflight_region, \
+                           struct vhost_inflight)
+
 #endif
--
2.34.1


</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------1y9Tz0fCHamFvToe7ZbcvFe9--

