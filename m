Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E9FD58E73
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 07:13:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwxSj-0004uM-Kd; Mon, 02 Mar 2026 02:13:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vwxSZ-0004sP-So; Mon, 02 Mar 2026 02:12:56 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vwxSX-000529-Mp; Mon, 02 Mar 2026 02:12:55 -0500
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c37:8aa5:0:640:e6ae:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 2304A80896;
 Mon, 02 Mar 2026 10:12:52 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:522::1:d] (unknown [2a02:6bf:8080:522::1:d])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id lCgbxx8Ak4Y0-oD4PDXQz; Mon, 02 Mar 2026 10:12:51 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1772435571;
 bh=jM4F0wcWMS7QAaUTe6Ufa0wmn5VyLSmOYlE6G5vCqeI=;
 h=In-Reply-To:Cc:Date:References:To:Subject:Message-ID:From;
 b=mueQLfumxJLEkf3oqx12gh+JScOQZSApv7i39WD9DSfkDShA0rDqoXmbLeFGSAZyu
 kcndR43Y6EFmPaJY+MQcvgmdgkF8Q/2xYPaTvvq6asCcUCLQfXcvhcoBIvJOMko5w9
 EDWurHs85UKzF2xUfKcmv+oIVQY01GlPPR1yylc8=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Content-Type: multipart/alternative;
 boundary="------------9oP2R0i2MvAmkNDBCwN0KaRf"
Message-ID: <121fea54-0041-4004-aa4f-3a402da8169e@yandex-team.ru>
Date: Mon, 2 Mar 2026 12:12:47 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] vhost-user: add skip_drain param to GET_VRING_BASE
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Raphael Norwitz <rnorwitz@nvidia.com>,
 virtio-fs@lists.linux.dev, Milan Zamazal <mzamazal@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, "Gonglei (Arei)"
 <arei.gonglei@huawei.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org
References: <20260224075055.863068-1-dtalexundeer@yandex-team.ru>
 <20260224075055.863068-3-dtalexundeer@yandex-team.ru>
 <20260301233406.GA8465@fedora>
Content-Language: en-US
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
In-Reply-To: <20260301233406.GA8465@fedora>
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
Precedence: list
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
--------------9oP2R0i2MvAmkNDBCwN0KaRf
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/2/26 04:34, Stefan Hajnoczi wrote:
> On Tue, Feb 24, 2026 at 12:50:53PM +0500, Alexandr Moshkov wrote:
>> In case of migration of QEMU from the new version (where the
>> inllight-migration parameter is present), to the old one (where it is
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
>> Signed-off-by: Alexandr Moshkov<dtalexundeer@yandex-team.ru>
>> ---
>>   backends/cryptodev-vhost.c     |  2 +-
>>   backends/vhost-user.c          |  2 +-
>>   docs/interop/vhost-user.rst    |  3 ++-
>>   hw/block/vhost-user-blk.c      |  2 +-
>>   hw/net/vhost_net.c             |  9 +++++----
>>   hw/scsi/vhost-scsi-common.c    |  2 +-
>>   hw/virtio/vdpa-dev.c           |  2 +-
>>   hw/virtio/vhost-user-base.c    |  2 +-
>>   hw/virtio/vhost-user-fs.c      |  2 +-
>>   hw/virtio/vhost-user-scmi.c    |  2 +-
>>   hw/virtio/vhost-vsock-common.c |  2 +-
>>   hw/virtio/vhost.c              | 24 +++++++++++++++---------
>>   include/hw/virtio/vhost.h      |  7 +++++--
>>   13 files changed, 36 insertions(+), 25 deletions(-)
>>
>> diff --git a/backends/cryptodev-vhost.c b/backends/cryptodev-vhost.c
>> index 943680a23a..7a457380d0 100644
>> --- a/backends/cryptodev-vhost.c
>> +++ b/backends/cryptodev-vhost.c
>> @@ -110,7 +110,7 @@ static void
>>   cryptodev_vhost_stop_one(CryptoDevBackendVhost *crypto,
>>                                    VirtIODevice *dev)
>>   {
>> -    vhost_dev_stop(&crypto->dev, dev, false);
>> +    vhost_dev_stop(&crypto->dev, dev, false, false);
>>       vhost_dev_disable_notifiers(&crypto->dev, dev);
>>   }
>>   
>> diff --git a/backends/vhost-user.c b/backends/vhost-user.c
>> index 42845329e7..10be713ebd 100644
>> --- a/backends/vhost-user.c
>> +++ b/backends/vhost-user.c
>> @@ -108,7 +108,7 @@ vhost_user_backend_stop(VhostUserBackend *b)
>>           return 0;
>>       }
>>   
>> -    ret = vhost_dev_stop(&b->dev, b->vdev, true);
>> +    ret = vhost_dev_stop(&b->dev, b->vdev, true, false);
>>   
>>       if (k->set_guest_notifiers &&
>>           k->set_guest_notifiers(qbus->parent, b->dev.nvqs, false) < 0) {
>> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
>> index bfa75ff9a3..5b944322b4 100644
>> --- a/docs/interop/vhost-user.rst
>> +++ b/docs/interop/vhost-user.rst
>> @@ -1262,7 +1262,8 @@ Front-end message types
>>     specified vring before stopping it.
>>   
>>     If the ``VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT`` protocol
>> -  feature has been negotiated, the back-end may suspend in-flight I/O
>> +  feature has been negotiated, using request payload's *num* field,
>> +  when num is set to 1, QEMU can tell the back-end to suspend in-flight I/O
> This changes the behavior of an existing feature bit. How can the
> front-end detect that the back-end supports this new behavior?

Thanks for reply!

The protocol feature VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT was 
added by me about a month ago, so I decided to fix it instead of adding 
another one.

It seemed to me to be the more correct solution, because it took a 
little time for someone to use it and adding a new "feature for a 
feature" looked too much for me.

--------------9oP2R0i2MvAmkNDBCwN0KaRf
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
    <div class="moz-cite-prefix">On 3/2/26 04:34, Stefan Hajnoczi wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260301233406.GA8465@fedora">
      <pre wrap="" class="moz-quote-pre">On Tue, Feb 24, 2026 at 12:50:53PM +0500, Alexandr Moshkov wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">In case of migration of QEMU from the new version (where the
inllight-migration parameter is present), to the old one (where it is
absent) there is no way to disable this feature on the backend during
runtime.

This commit slightly changes the semantics of the protocol feature
VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT. Enabling this feature
adds a new parameter for GET_VRING_BASE, which allows to control the
drain in-flight requests on the backend.
Thus, QEMU will be able to turn this feature on GET_VRING_BASE off and
on anytime.

Signed-off-by: Alexandr Moshkov <a class="moz-txt-link-rfc2396E" href="mailto:dtalexundeer@yandex-team.ru">&lt;dtalexundeer@yandex-team.ru&gt;</a>
---
 backends/cryptodev-vhost.c     |  2 +-
 backends/vhost-user.c          |  2 +-
 docs/interop/vhost-user.rst    |  3 ++-
 hw/block/vhost-user-blk.c      |  2 +-
 hw/net/vhost_net.c             |  9 +++++----
 hw/scsi/vhost-scsi-common.c    |  2 +-
 hw/virtio/vdpa-dev.c           |  2 +-
 hw/virtio/vhost-user-base.c    |  2 +-
 hw/virtio/vhost-user-fs.c      |  2 +-
 hw/virtio/vhost-user-scmi.c    |  2 +-
 hw/virtio/vhost-vsock-common.c |  2 +-
 hw/virtio/vhost.c              | 24 +++++++++++++++---------
 include/hw/virtio/vhost.h      |  7 +++++--
 13 files changed, 36 insertions(+), 25 deletions(-)

diff --git a/backends/cryptodev-vhost.c b/backends/cryptodev-vhost.c
index 943680a23a..7a457380d0 100644
--- a/backends/cryptodev-vhost.c
+++ b/backends/cryptodev-vhost.c
@@ -110,7 +110,7 @@ static void
 cryptodev_vhost_stop_one(CryptoDevBackendVhost *crypto,
                                  VirtIODevice *dev)
 {
-    vhost_dev_stop(&amp;crypto-&gt;dev, dev, false);
+    vhost_dev_stop(&amp;crypto-&gt;dev, dev, false, false);
     vhost_dev_disable_notifiers(&amp;crypto-&gt;dev, dev);
 }
 
diff --git a/backends/vhost-user.c b/backends/vhost-user.c
index 42845329e7..10be713ebd 100644
--- a/backends/vhost-user.c
+++ b/backends/vhost-user.c
@@ -108,7 +108,7 @@ vhost_user_backend_stop(VhostUserBackend *b)
         return 0;
     }
 
-    ret = vhost_dev_stop(&amp;b-&gt;dev, b-&gt;vdev, true);
+    ret = vhost_dev_stop(&amp;b-&gt;dev, b-&gt;vdev, true, false);
 
     if (k-&gt;set_guest_notifiers &amp;&amp;
         k-&gt;set_guest_notifiers(qbus-&gt;parent, b-&gt;dev.nvqs, false) &lt; 0) {
diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index bfa75ff9a3..5b944322b4 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -1262,7 +1262,8 @@ Front-end message types
   specified vring before stopping it.
 
   If the ``VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT`` protocol
-  feature has been negotiated, the back-end may suspend in-flight I/O
+  feature has been negotiated, using request payload's *num* field,
+  when num is set to 1, QEMU can tell the back-end to suspend in-flight I/O
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
This changes the behavior of an existing feature bit. How can the
front-end detect that the back-end supports this new behavior?</pre>
    </blockquote>
    <p>Thanks for reply!</p>
    <p class="CPO0LE0j16AwB0G2HeuZ" dir="ltr"><span
      style="white-space: pre-wrap;">The protocol feature VHOST_USER_PROTOCOL_F_GET_</span><span
      data-lexical-key="96" data-highlighted="false" data-error="true"
      style="white-space: pre-wrap;">VRING</span><span
      style="white-space: pre-wrap;">_</span><span data-lexical-key="98"
      data-highlighted="false" data-error="true"
      style="white-space: pre-wrap;">BASE</span><span
      style="white-space: pre-wrap;">_INFLIGHT was added by me about a month ago, so I decided to fix it instead of adding another one. </span></p>
    <p class="CPO0LE0j16AwB0G2HeuZ" dir="ltr"><span
      style="white-space: pre-wrap;">It seemed to me to be the more correct solution, because it took a little time for someone to use it and adding a new "feature for a feature" looked too much for me.</span></p>
  </body>
</html>

--------------9oP2R0i2MvAmkNDBCwN0KaRf--

