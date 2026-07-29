Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB7AC53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 10:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp1Eu-0006CE-QG; Wed, 29 Jul 2026 06:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1wp1Es-00069j-JT; Wed, 29 Jul 2026 06:10:14 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1wp1Ep-0004qz-Vz; Wed, 29 Jul 2026 06:10:14 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id AE13480751;
 Wed, 29 Jul 2026 13:10:05 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b6f::1:d] (unknown [2a02:6bf:8080:b6f::1:d])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id w9bbWI46dOs0-TZRjoJd4; Wed, 29 Jul 2026 13:10:04 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1785319805;
 bh=6VqBSJrGuBKQciTs3ZUEWb642k2uE+/MmlaIkErgY2c=;
 h=In-Reply-To:Cc:Date:References:To:Subject:Message-ID:From;
 b=E8C69o9sB3I9bW6OgPHpZbpXmfNjkEywjqbLf9BOqtmm1nvnkaihLbbADNGGhKjEr
 aMDNxWEcoZ1rI+5F1oJObphUh3o6SECnoKnjCnMp2vAmeNFKfoUyLZDNd1pNRuiaso
 0vhg1NeSr74xzrkWxuhwxCm1olBWLd94iTIiVA1k=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Content-Type: multipart/alternative;
 boundary="------------0TYlVCWjJtBSp7PYYpQl0aS0"
Message-ID: <679a33d1-0f6c-4456-ac76-1f9e1251f2ec@yandex-team.ru>
Date: Wed, 29 Jul 2026 15:09:57 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] vhost-user-blk: make inflight-migration prop
 mutable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, Jason Wang
 <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 virtio-fs@lists.linux.dev, Kevin Wolf <kwolf@redhat.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Milan Zamazal
 <mzamazal@redhat.com>, Raphael Norwitz <rnorwitz@nvidia.com>
References: <20260728100841.3475774-1-dtalexundeer@yandex-team.ru>
 <20260728100841.3475774-5-dtalexundeer@yandex-team.ru>
 <20260729051509-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
In-Reply-To: <20260729051509-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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
--------------0TYlVCWjJtBSp7PYYpQl0aS0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/29/26 14:32, Michael S. Tsirkin wrote:
> On Tue, Jul 28, 2026 at 03:08:39PM +0500, Alexandr Moshkov wrote:
>> When migrating from a QEMU version that supports inflight-migration to
>> an older one that does not, there is no way to disable the feature at
>> runtime — the VM must be stopped and reconfigured. This is impractical
>> in production environments.
>>
>> Make the inflight-migration property mutable after device realization
>> so it can be toggled via qom-set without restarting the VM.
>>
>> Acked-by: Raphael Norwitz<rnorwitz@nvidia.com>
>> Signed-off-by: Alexandr Moshkov<dtalexundeer@yandex-team.ru>
>
>
> I think I am beginning to understand.
>
>
> You are running qemu with inflight-migration on and want to migrate
> to qemu without inflight-migration at all.
>
>
> Since it is guest transparent you could retrofit it like this.
>
> My question is why is it worth it, we do not normally support
> migrating between qemu versions with different command lines.

I think you right. MaybeI've beenfocusingtoomuchonthe abilityto migrate 
betweenversionsof qemuwithandwithoutinflightmigration.

Thisseriesallows to turnoffand on the inflight-migration feature 
atruntimewithout recreatingthe VM (it was the only way to turn off the 
feature, since the protocol feature could no longer be turned off, 
afterinitialization withthe backend). This is more important feature,and 
it leads to the fact that this feature allows to migrate between 
different versions of qemu (with and without inflight-migration support).

>
>> ---
>>   hw/block/vhost-user-blk.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
>> index e3b873af7c..650c004bde 100644
>> --- a/hw/block/vhost-user-blk.c
>> +++ b/hw/block/vhost-user-blk.c
>> @@ -619,6 +619,8 @@ static const VMStateDescription vmstate_vhost_user_blk = {
>>       }
>>   };
>>   
>> +static PropertyInfo vhost_user_blk_inflight_migration_prop;
>> +
>>   static const Property vhost_user_blk_properties[] = {
>>       DEFINE_PROP_CHR("chardev", VHostUserBlk, chardev),
>>       DEFINE_PROP_UINT16("num-queues", VHostUserBlk, num_queues,
>> @@ -632,8 +634,9 @@ static const Property vhost_user_blk_properties[] = {
>>                         VIRTIO_BLK_F_WRITE_ZEROES, true),
>>       DEFINE_PROP_BOOL("skip-get-vring-base-on-force-shutdown", VHostUserBlk,
>>                        skip_get_vring_base_on_force_shutdown, false),
>> -    DEFINE_PROP_BOOL("inflight-migration", VHostUserBlk,
>> -                     inflight_migration, false),
>> +    DEFINE_PROP("inflight-migration", VHostUserBlk, inflight_migration,
>> +                vhost_user_blk_inflight_migration_prop, bool,
>> +                .set_default = true, .defval.u = false),
>>   };
>>   
>>   static void vhost_user_blk_class_init(ObjectClass *klass, const void *data)
>> @@ -665,6 +668,9 @@ static const TypeInfo vhost_user_blk_info = {
>>   
>>   static void virtio_register_types(void)
>>   {
>> +    vhost_user_blk_inflight_migration_prop = qdev_prop_bool;
>> +    vhost_user_blk_inflight_migration_prop.realized_set_allowed = true;
>> +
>>       type_register_static(&vhost_user_blk_info);
>>   }
> So then,  for example, let us say I paused the VM, then set the flag,
> now inflight is on but GET_BASE did not drain it?
If I understood the question correctly, thisis validbehavior. Before 
migration QEMU check protocol features to understand does the backend 
support inflight migration. If it does, after that QEMU migrate inflight 
buffer to other VM. If it's not, return error before migration started.
>> -- 
>> 2.34.1
--------------0TYlVCWjJtBSp7PYYpQl0aS0
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
    <div class="moz-cite-prefix">On 7/29/26 14:32, Michael S. Tsirkin
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20260729051509-mutt-send-email-mst@kernel.org">
      <pre wrap="" class="moz-quote-pre">On Tue, Jul 28, 2026 at 03:08:39PM +0500, Alexandr Moshkov wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">When migrating from a QEMU version that supports inflight-migration to
an older one that does not, there is no way to disable the feature at
runtime — the VM must be stopped and reconfigured. This is impractical
in production environments.

Make the inflight-migration property mutable after device realization
so it can be toggled via qom-set without restarting the VM.

Acked-by: Raphael Norwitz <a class="moz-txt-link-rfc2396E" href="mailto:rnorwitz@nvidia.com">&lt;rnorwitz@nvidia.com&gt;</a>
Signed-off-by: Alexandr Moshkov <a class="moz-txt-link-rfc2396E" href="mailto:dtalexundeer@yandex-team.ru">&lt;dtalexundeer@yandex-team.ru&gt;</a>
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">


I think I am beginning to understand.


You are running qemu with inflight-migration on and want to migrate
to qemu without inflight-migration at all.


Since it is guest transparent you could retrofit it like this.

My question is why is it worth it, we do not normally support
migrating between qemu versions with different command lines.</pre>
    </blockquote>
    <p>I think you right. <span class="YPkS7KbdpWfGdYKd3QB9"
      data-src-align="0:5:221:4" style="white-space: pre-wrap;">Maybe</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="11:1"
      style="white-space: pre-wrap;">I</span><span
      style="white-space: pre-wrap;">'ve </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="6:4"
      style="white-space: pre-wrap;">been</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="27:14"
      style="white-space: pre-wrap;">focusing</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="13:7"
      style="white-space: pre-wrap;">too</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="21:5"
      style="white-space: pre-wrap;">much</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="42:2"
      style="white-space: pre-wrap;">on</span><span
      style="white-space: pre-wrap;"> the </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="45:11:129:11:162:11"
      style="white-space: pre-wrap;">ability</span><span
      style="white-space: pre-wrap;"> to migrate </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="66:5"
      style="white-space: pre-wrap;">between</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="72:8"
      style="white-space: pre-wrap;">versions</span><span
      style="white-space: pre-wrap;"> of </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="81:4"
      style="white-space: pre-wrap;">qemu</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="86:1"
      style="white-space: pre-wrap;">with</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="107:1:151:1"
      style="white-space: pre-wrap;">and</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="109:3:205:2"
      style="white-space: pre-wrap;">without</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="88:8:174:8"
      style="white-space: pre-wrap;">inflight</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="57:8:97:9:183:9"
      style="white-space: pre-wrap;">migration</span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="112:1:225:1"
      style="white-space: pre-wrap;">.</span><span
      style="white-space: pre-wrap;"> </span></p>
    <p><span class="YPkS7KbdpWfGdYKd3QB9" data-src-align="114:3:124:4"
      style="white-space: pre-wrap;">This</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="118:5"
      style="white-space: pre-wrap;">series</span><span
      style="white-space: pre-wrap;"> allows to </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="153:8"
      style="white-space: pre-wrap;">turn</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="141:9"
      style="white-space: pre-wrap;">off</span><span
      style="white-space: pre-wrap;"> and on the inflight</span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="182:1"
      style="white-space: pre-wrap;">-</span><span
      style="white-space: pre-wrap;">migration feature </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="193:1"
      style="white-space: pre-wrap;">at</span><span
      style="white-space: pre-wrap;"> </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="195:8"
      style="white-space: pre-wrap;">runtime</span><span
      style="white-space: pre-wrap;"> without </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="208:12"
      style="white-space: pre-wrap;">recreating</span><span
      style="white-space: pre-wrap;"> the VM (it was the only way to turn off the feature, since the protocol feature could no longer be turned off, </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="53:5"
      style="white-space: pre-wrap;">after</span><span
      style="white-space: pre-wrap;"> initialization </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="71:1"
      style="white-space: pre-wrap;">with</span><span
      style="white-space: pre-wrap;"> the </span><span
      class="YPkS7KbdpWfGdYKd3QB9" data-src-align="73:8"
      style="white-space: pre-wrap;">backend</span><span
      style="white-space: pre-wrap;">). 
This is more important feature,</span><span class="YPkS7KbdpWfGdYKd3QB9"
      data-src-align="0:149" style="white-space: pre-wrap;"> and it leads to the fact that this feature allows to migrate between different versions of qemu (with and without inflight-migration support).</span></p>
    <p><span class="YPkS7KbdpWfGdYKd3QB9" data-src-align="0:149"
      style="white-space: pre-wrap;">
</span></p>
    <blockquote type="cite"
      cite="mid:20260729051509-mutt-send-email-mst@kernel.org">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">---
 hw/block/vhost-user-blk.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index e3b873af7c..650c004bde 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -619,6 +619,8 @@ static const VMStateDescription vmstate_vhost_user_blk = {
     }
 };
 
+static PropertyInfo vhost_user_blk_inflight_migration_prop;
+
 static const Property vhost_user_blk_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserBlk, chardev),
     DEFINE_PROP_UINT16("num-queues", VHostUserBlk, num_queues,
@@ -632,8 +634,9 @@ static const Property vhost_user_blk_properties[] = {
                       VIRTIO_BLK_F_WRITE_ZEROES, true),
     DEFINE_PROP_BOOL("skip-get-vring-base-on-force-shutdown", VHostUserBlk,
                      skip_get_vring_base_on_force_shutdown, false),
-    DEFINE_PROP_BOOL("inflight-migration", VHostUserBlk,
-                     inflight_migration, false),
+    DEFINE_PROP("inflight-migration", VHostUserBlk, inflight_migration,
+                vhost_user_blk_inflight_migration_prop, bool,
+                .set_default = true, .defval.u = false),
 };
 
 static void vhost_user_blk_class_init(ObjectClass *klass, const void *data)
@@ -665,6 +668,9 @@ static const TypeInfo vhost_user_blk_info = {
 
 static void virtio_register_types(void)
 {
+    vhost_user_blk_inflight_migration_prop = qdev_prop_bool;
+    vhost_user_blk_inflight_migration_prop.realized_set_allowed = true;
+
     type_register_static(&amp;vhost_user_blk_info);
 }
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
So then,  for example, let us say I paused the VM, then set the flag,
now inflight is on but GET_BASE did not drain it?
</pre>
    </blockquote>
    <span class="YPkS7KbdpWfGdYKd3QB9" data-src-align="0:3"
    style="white-space: pre-wrap;">If I understood the question correctly, this</span><span
    style="white-space: pre-wrap;"> is </span><span
    class="YPkS7KbdpWfGdYKd3QB9" data-src-align="4:8"
    style="white-space: pre-wrap;">valid</span><span
    style="white-space: pre-wrap;"> </span><span
    class="YPkS7KbdpWfGdYKd3QB9" data-src-align="13:9"
    style="white-space: pre-wrap;">behavior</span><span
    style="white-space: pre-wrap;">. </span>Before migration QEMU check
    protocol features to understand does the backend support inflight
    migration. If it does, after that QEMU migrate inflight buffer to
    other VM. If it's not, return error before migration started.  
    <blockquote type="cite"
      cite="mid:20260729051509-mutt-send-email-mst@kernel.org">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">-- 
2.34.1
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------0TYlVCWjJtBSp7PYYpQl0aS0--

