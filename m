Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EDFED29FFA
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 08:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgIJj-0007VR-T8; Thu, 15 Jan 2026 03:02:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vgIJh-0007V7-Uu; Thu, 15 Jan 2026 03:02:53 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vgIJf-0003nO-H2; Thu, 15 Jan 2026 03:02:53 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:5c05:0:640:ff67:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 40D30C01FF;
 Thu, 15 Jan 2026 11:02:44 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:973::1:c] (unknown [2a02:6bf:8080:973::1:c])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id e2QOZR0AtOs0-G2hSGKBs; Thu, 15 Jan 2026 11:02:43 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1768464163;
 bh=ZUJZI7SQZpwpRWo/U9YelphDIPCuoS/LEwjSNozNdgk=;
 h=In-Reply-To:Cc:Date:References:To:Subject:Message-ID:From;
 b=PPtnS+CdJuMoC003CD+fY8B9H9EzgyReivy2Rg1h8cts1Brp/FJJWYqUSR/sDn2FT
 5L6fk2ZUHXfEhWdrrJ0SlQV9Z6fKAr/fzcZDWY+5N5YUd0XJmmGgV+PihNeGZwDjGf
 1Djvb/+vtWiFiqcHDFZj07gVYjK4lU65D2EcOx18=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Content-Type: multipart/alternative;
 boundary="------------JRS3MVlEFliYQpBjkHu5GDll"
Message-ID: <20b51375-fbb5-47d4-a77a-1baf04fa037b@yandex-team.ru>
Date: Thu, 15 Jan 2026 13:02:40 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] vhost-user-blk: support inter-host inflight
 migration
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, mzamazal@redhat.com,
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 virtio-fs@lists.linux.dev, "yc-core@yandex-team.ru"
 <yc-core@yandex-team.ru>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20260113095813.134810-1-dtalexundeer@yandex-team.ru>
 <20260113095813.134810-6-dtalexundeer@yandex-team.ru>
 <aWeLcDtZyRpk81W6@x1.local>
Content-Language: en-US
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
In-Reply-To: <aWeLcDtZyRpk81W6@x1.local>
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
--------------JRS3MVlEFliYQpBjkHu5GDll
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/14/26 17:26, Peter Xu wrote:
>> +}
>> +
>> +static const VMStateDescription vmstate_vhost_user_blk_inflight = {
>> +    .name = "vhost-user-blk/inflight",
>> +    .version_id = 1,
>> +    .needed = vhost_user_blk_inflight_needed,
>> +    .fields = (const VMStateField[]) {
>> +        VMSTATE_VHOST_INFLIGHT_REGION(inflight, VHostUserBlk),
> One other trivial nitpick while glimpsing over the patch: should we move
> the macro definition from previous patch to this one, where it is used?
Thanks for reply! I think you right, I'll move this macro.
>
>> +        VMSTATE_END_OF_LIST()
>> +    },
>> +};
>> +
>>   static bool vhost_user_blk_pre_incoming(void *opaque, Error **errp)
>>   {
>>       VHostUserBlk *s = VHOST_USER_BLK(opaque);
>> @@ -678,6 +700,10 @@ static const VMStateDescription vmstate_vhost_user_blk = {
>>           VMSTATE_VIRTIO_DEVICE,
>>           VMSTATE_END_OF_LIST()
>>       },
>> +    .subsections = (const VMStateDescription * const []) {
>> +        &vmstate_vhost_user_blk_inflight,
>> +        NULL
>> +    }
>>   };
>>   
>>   static bool vhost_user_needed(void *opaque)
>> @@ -751,6 +777,8 @@ static const Property vhost_user_blk_properties[] = {
>>                         VIRTIO_BLK_F_WRITE_ZEROES, true),
>>       DEFINE_PROP_BOOL("skip-get-vring-base-on-force-shutdown", VHostUserBlk,
>>                        skip_get_vring_base_on_force_shutdown, false),
>> +    DEFINE_PROP_BOOL("inflight-migration", VHostUserBlk,
>> +                     inflight_migration, false),
>>   };
>>   
>>   static void vhost_user_blk_class_init(ObjectClass *klass, const void *data)
>> diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-user-blk.h
>> index b06f55fd6f..e1466e5cf6 100644
>> --- a/include/hw/virtio/vhost-user-blk.h
>> +++ b/include/hw/virtio/vhost-user-blk.h
>> @@ -52,6 +52,7 @@ struct VHostUserBlk {
>>       bool started_vu;
>>   
>>       bool skip_get_vring_base_on_force_shutdown;
>> +    bool inflight_migration;
>>   
>>       bool incoming_backend;
>>   };
>> -- 
>> 2.34.1
>>
--------------JRS3MVlEFliYQpBjkHu5GDll
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 1/14/26 17:26, Peter Xu wrote:<span
      style="white-space: pre-wrap">
</span></div>
    <div class="moz-cite-prefix"><span style="white-space: pre-wrap">
</span></div>
    <blockquote type="cite" cite="mid:aWeLcDtZyRpk81W6@x1.local">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+}
+
+static const VMStateDescription vmstate_vhost_user_blk_inflight = {
+    .name = "vhost-user-blk/inflight",
+    .version_id = 1,
+    .needed = vhost_user_blk_inflight_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_VHOST_INFLIGHT_REGION(inflight, VHostUserBlk),
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
One other trivial nitpick while glimpsing over the patch: should we move
the macro definition from previous patch to this one, where it is used?</pre>
    </blockquote>
    Thanks for reply! I think you right, I'll move this macro.<br>
    <blockquote type="cite" cite="mid:aWeLcDtZyRpk81W6@x1.local">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static bool vhost_user_blk_pre_incoming(void *opaque, Error **errp)
 {
     VHostUserBlk *s = VHOST_USER_BLK(opaque);
@@ -678,6 +700,10 @@ static const VMStateDescription vmstate_vhost_user_blk = {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
+    .subsections = (const VMStateDescription * const []) {
+        &amp;vmstate_vhost_user_blk_inflight,
+        NULL
+    }
 };
 
 static bool vhost_user_needed(void *opaque)
@@ -751,6 +777,8 @@ static const Property vhost_user_blk_properties[] = {
                       VIRTIO_BLK_F_WRITE_ZEROES, true),
     DEFINE_PROP_BOOL("skip-get-vring-base-on-force-shutdown", VHostUserBlk,
                      skip_get_vring_base_on_force_shutdown, false),
+    DEFINE_PROP_BOOL("inflight-migration", VHostUserBlk,
+                     inflight_migration, false),
 };
 
 static void vhost_user_blk_class_init(ObjectClass *klass, const void *data)
diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-user-blk.h
index b06f55fd6f..e1466e5cf6 100644
--- a/include/hw/virtio/vhost-user-blk.h
+++ b/include/hw/virtio/vhost-user-blk.h
@@ -52,6 +52,7 @@ struct VHostUserBlk {
     bool started_vu;
 
     bool skip_get_vring_base_on_force_shutdown;
+    bool inflight_migration;
 
     bool incoming_backend;
 };
-- 
2.34.1

</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------JRS3MVlEFliYQpBjkHu5GDll--

