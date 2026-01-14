Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4883DD31A15
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 07:39:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfvT3-0002sg-5o; Wed, 14 Jan 2026 02:39:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vfvSv-0002qC-Ku; Wed, 14 Jan 2026 02:38:53 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vfvSq-0005gN-6r; Wed, 14 Jan 2026 02:38:51 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 441B7C0161;
 Wed, 14 Jan 2026 10:38:41 +0300 (MSK)
Received: from [IPV6:2a02:6bf:803e:400:7bff:2c31:9726:e00b] (unknown
 [2a02:6bf:803e:400:7bff:2c31:9726:e00b])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id bcOiu90BieA0-iNbF0xfL; Wed, 14 Jan 2026 10:38:40 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1768376320;
 bh=onKp6N7olYPWV71umkR7uDJtfFUHkxt9pTpd9jPbYgY=;
 h=In-Reply-To:Cc:Date:References:To:Subject:Message-ID:From;
 b=S0Sl2BqYEic5pDv/wOoNXqIzU8j6acteAcASTxBn+N0nJs3Tmu9sOfiTKmYP1Akrb
 oiMN/0DCNfZinLCaAEg9Wb0HSvnaTv9AT9w5kC+6jLCugQZX7bH7LLS3vIhW6qwZh8
 9BxqL27dERRBPMEYfdgdcfdKHN+crP1quQosWn8k=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Content-Type: multipart/alternative;
 boundary="------------XEsVvd4SdsAmyCkdndmnNG11"
Message-ID: <693fc635-0a92-4384-9dbc-ce6fe83d4e3e@yandex-team.ru>
Date: Wed, 14 Jan 2026 12:38:37 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/5] vhost-user: introduce protocol feature for skip
 drain on GET_VRING_BASE
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, mzamazal@redhat.com,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-block@nongnu.org, virtio-fs@lists.linux.dev,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20260113095813.134810-1-dtalexundeer@yandex-team.ru>
 <20260113095813.134810-3-dtalexundeer@yandex-team.ru>
 <20260113180017.GA528940@fedora>
Content-Language: en-US
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
In-Reply-To: <20260113180017.GA528940@fedora>
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
--------------XEsVvd4SdsAmyCkdndmnNG11
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/13/26 23:00, Stefan Hajnoczi wrote:
> On Tue, Jan 13, 2026 at 02:58:13PM +0500, Alexandr Moshkov wrote:
>> Add vhost-user protocol feature
>> VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT
>>
>> Now on GET_VRING_BASE this feature can control whether to wait for
>> in-flight requests to complete or not.
>> Also we have to validate that this feature will be enabled only when
>> qemu and back-end supports in-flight buffer and in-flight migration
>>
>> It will be helpfull in future for in-flight requests migration in
>> vhost-user devices.
>>
>> Update docs, add ref to label for inflight-io-tracking
>>
>> Signed-off-by: Alexandr Moshkov<dtalexundeer@yandex-team.ru>
>> ---
>>   docs/interop/vhost-user.rst    | 59 +++++++++++++++++++++-------------
>>   hw/virtio/vhost-user.c         |  5 +++
>>   include/hw/virtio/vhost-user.h |  2 ++
>>   3 files changed, 44 insertions(+), 22 deletions(-)
>>
>> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
>> index 02908b48fa..dcf79de0c0 100644
>> --- a/docs/interop/vhost-user.rst
>> +++ b/docs/interop/vhost-user.rst
>> @@ -736,6 +736,8 @@ negotiated, back-end can send file descriptors (at most 8 descriptors in
>>   each message) to front-end via ancillary data using this fd communication
>>   channel.
>>   
>> +.. _inflight_io_tracking:
>> +
>>   Inflight I/O tracking
>>   ---------------------
>>   
>> @@ -1033,26 +1035,27 @@ Protocol features
>>   
>>   .. code:: c
>>   
>> -  #define VHOST_USER_PROTOCOL_F_MQ                    0
>> -  #define VHOST_USER_PROTOCOL_F_LOG_SHMFD             1
>> -  #define VHOST_USER_PROTOCOL_F_RARP                  2
>> -  #define VHOST_USER_PROTOCOL_F_REPLY_ACK             3
>> -  #define VHOST_USER_PROTOCOL_F_MTU                   4
>> -  #define VHOST_USER_PROTOCOL_F_BACKEND_REQ           5
>> -  #define VHOST_USER_PROTOCOL_F_CROSS_ENDIAN          6
>> -  #define VHOST_USER_PROTOCOL_F_CRYPTO_SESSION        7
>> -  #define VHOST_USER_PROTOCOL_F_PAGEFAULT             8
>> -  #define VHOST_USER_PROTOCOL_F_CONFIG                9
>> -  #define VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD      10
>> -  #define VHOST_USER_PROTOCOL_F_HOST_NOTIFIER        11
>> -  #define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD       12
>> -  #define VHOST_USER_PROTOCOL_F_RESET_DEVICE         13
>> -  #define VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS 14
>> -  #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
>> -  #define VHOST_USER_PROTOCOL_F_STATUS               16
>> -  #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
>> -  #define VHOST_USER_PROTOCOL_F_SHARED_OBJECT        18
>> -  #define VHOST_USER_PROTOCOL_F_DEVICE_STATE         19
>> +  #define VHOST_USER_PROTOCOL_F_MQ                       0
>> +  #define VHOST_USER_PROTOCOL_F_LOG_SHMFD                1
>> +  #define VHOST_USER_PROTOCOL_F_RARP                     2
>> +  #define VHOST_USER_PROTOCOL_F_REPLY_ACK                3
>> +  #define VHOST_USER_PROTOCOL_F_MTU                      4
>> +  #define VHOST_USER_PROTOCOL_F_BACKEND_REQ              5
>> +  #define VHOST_USER_PROTOCOL_F_CROSS_ENDIAN             6
>> +  #define VHOST_USER_PROTOCOL_F_CRYPTO_SESSION           7
>> +  #define VHOST_USER_PROTOCOL_F_PAGEFAULT                8
>> +  #define VHOST_USER_PROTOCOL_F_CONFIG                   9
>> +  #define VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD         10
>> +  #define VHOST_USER_PROTOCOL_F_HOST_NOTIFIER           11
>> +  #define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD          12
>> +  #define VHOST_USER_PROTOCOL_F_RESET_DEVICE            13
>> +  #define VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS    14
>> +  #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS     15
>> +  #define VHOST_USER_PROTOCOL_F_STATUS                  16
>> +  #define VHOST_USER_PROTOCOL_F_XEN_MMAP                17
>> +  #define VHOST_USER_PROTOCOL_F_SHARED_OBJECT           18
>> +  #define VHOST_USER_PROTOCOL_F_DEVICE_STATE            19
>> +  #define VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT 20
>>   
>>   Front-end message types
>>   -----------------------
>> @@ -1243,12 +1246,24 @@ Front-end message types
>>   
>>     When and as long as all of a device's vrings are stopped, it is
>>     *suspended*, see :ref:`Suspended device state
>> -  <suspended_device_state>`. The back-end must complete all inflight I/O
>> -  requests for the specified vring before stopping it.
>> +  <suspended_device_state>`.
>>   
>>     The request payload's *num* field is currently reserved and must be
>>     set to 0.
>>   
>> +  By default, the back-end must complete all inflight I/O requests for the
>> +  specified vring before stopping it.
>> +
>> +  If the ``VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT`` protocol
>> +  feature has been negotiated, the back-end may suspend in-flight I/O
>> +  requests and record them as described in :ref:`Inflight I/O tracking
>> +  <inflight_io_tracking>` instead of completing them before stopping the vring.
>> +  How to suspend an in-flight request depends on the implementation of the back-end
>> +  but it typically can be done by aborting or cancelling the underlying I/O
>> +  request. The ``VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT``
>> +  protocol feature must only be neogotiated if
>> +  ``VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD`` is also negotiated.
>> +
>>   ``VHOST_USER_SET_VRING_KICK``
>>     :id: 12
>>     :equivalent ioctl: ``VHOST_SET_VRING_KICK``
>> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>> index a820214188..793d1b36d8 100644
>> --- a/hw/virtio/vhost-user.c
>> +++ b/hw/virtio/vhost-user.c
>> @@ -2320,6 +2320,11 @@ static int vhost_user_backend_connect(struct vhost_dev *dev, Error **errp)
>>               }
>>           }
>>   
>> +        if (!u->user->supports_inflight_migration ||
>> +            !virtio_has_feature(VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
> This looks like it will not compile since virtio_has_features() takes
> two arguments. I think it should be:
>
>    !virtio_has_feature(dev->protocol_features,
>                        VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)
>
Oh, how did I miss that...

I'll fix it! Thanks

>> +            protocol_features &= ~(1ULL <<
>> +                               VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT);
>> +        }
>> +
>>           /* final set of protocol features */
>>           u->protocol_features = protocol_features;
>>           err = vhost_user_set_protocol_features(dev, u->protocol_features);
> I seem to have different version of hw/virtio/vhost-user.c. Is this
> patch against qemu.git/master?

This patch is based on Vladimir's patch, but I now thinks that I can 
separate my patch from his.

At first I thought there would be a lot of intersections with his patch.

In the next version, I will rebase this patch on the master

>> diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
>> index fb89268de2..f30c1792e4 100644
>> --- a/include/hw/virtio/vhost-user.h
>> +++ b/include/hw/virtio/vhost-user.h
>> @@ -33,6 +33,7 @@ enum VhostUserProtocolFeature {
>>       /* Feature 17 reserved for VHOST_USER_PROTOCOL_F_XEN_MMAP. */
>>       VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 18,
>>       VHOST_USER_PROTOCOL_F_DEVICE_STATE = 19,
>> +    VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT = 20,
>>       VHOST_USER_PROTOCOL_F_MAX
>>   };
>>   
>> @@ -69,6 +70,7 @@ typedef struct VhostUserState {
>>       GPtrArray *notifiers;
>>       int memory_slots;
>>       bool supports_config;
>> +    bool supports_inflight_migration;
>>   } VhostUserState;
>>   
>>   /**
>> -- 
>> 2.34.1
>>
--------------XEsVvd4SdsAmyCkdndmnNG11
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
    <div class="moz-cite-prefix">On 1/13/26 23:00, Stefan Hajnoczi
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260113180017.GA528940@fedora">
      <pre wrap="" class="moz-quote-pre">On Tue, Jan 13, 2026 at 02:58:13PM +0500, Alexandr Moshkov wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Add vhost-user protocol feature
VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT

Now on GET_VRING_BASE this feature can control whether to wait for
in-flight requests to complete or not.
Also we have to validate that this feature will be enabled only when
qemu and back-end supports in-flight buffer and in-flight migration

It will be helpfull in future for in-flight requests migration in
vhost-user devices.

Update docs, add ref to label for inflight-io-tracking

Signed-off-by: Alexandr Moshkov <a class="moz-txt-link-rfc2396E" href="mailto:dtalexundeer@yandex-team.ru">&lt;dtalexundeer@yandex-team.ru&gt;</a>
---
 docs/interop/vhost-user.rst    | 59 +++++++++++++++++++++-------------
 hw/virtio/vhost-user.c         |  5 +++
 include/hw/virtio/vhost-user.h |  2 ++
 3 files changed, 44 insertions(+), 22 deletions(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 02908b48fa..dcf79de0c0 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -736,6 +736,8 @@ negotiated, back-end can send file descriptors (at most 8 descriptors in
 each message) to front-end via ancillary data using this fd communication
 channel.
 
+.. _inflight_io_tracking:
+
 Inflight I/O tracking
 ---------------------
 
@@ -1033,26 +1035,27 @@ Protocol features
 
 .. code:: c
 
-  #define VHOST_USER_PROTOCOL_F_MQ                    0
-  #define VHOST_USER_PROTOCOL_F_LOG_SHMFD             1
-  #define VHOST_USER_PROTOCOL_F_RARP                  2
-  #define VHOST_USER_PROTOCOL_F_REPLY_ACK             3
-  #define VHOST_USER_PROTOCOL_F_MTU                   4
-  #define VHOST_USER_PROTOCOL_F_BACKEND_REQ           5
-  #define VHOST_USER_PROTOCOL_F_CROSS_ENDIAN          6
-  #define VHOST_USER_PROTOCOL_F_CRYPTO_SESSION        7
-  #define VHOST_USER_PROTOCOL_F_PAGEFAULT             8
-  #define VHOST_USER_PROTOCOL_F_CONFIG                9
-  #define VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD      10
-  #define VHOST_USER_PROTOCOL_F_HOST_NOTIFIER        11
-  #define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD       12
-  #define VHOST_USER_PROTOCOL_F_RESET_DEVICE         13
-  #define VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS 14
-  #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
-  #define VHOST_USER_PROTOCOL_F_STATUS               16
-  #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
-  #define VHOST_USER_PROTOCOL_F_SHARED_OBJECT        18
-  #define VHOST_USER_PROTOCOL_F_DEVICE_STATE         19
+  #define VHOST_USER_PROTOCOL_F_MQ                       0
+  #define VHOST_USER_PROTOCOL_F_LOG_SHMFD                1
+  #define VHOST_USER_PROTOCOL_F_RARP                     2
+  #define VHOST_USER_PROTOCOL_F_REPLY_ACK                3
+  #define VHOST_USER_PROTOCOL_F_MTU                      4
+  #define VHOST_USER_PROTOCOL_F_BACKEND_REQ              5
+  #define VHOST_USER_PROTOCOL_F_CROSS_ENDIAN             6
+  #define VHOST_USER_PROTOCOL_F_CRYPTO_SESSION           7
+  #define VHOST_USER_PROTOCOL_F_PAGEFAULT                8
+  #define VHOST_USER_PROTOCOL_F_CONFIG                   9
+  #define VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD         10
+  #define VHOST_USER_PROTOCOL_F_HOST_NOTIFIER           11
+  #define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD          12
+  #define VHOST_USER_PROTOCOL_F_RESET_DEVICE            13
+  #define VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS    14
+  #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS     15
+  #define VHOST_USER_PROTOCOL_F_STATUS                  16
+  #define VHOST_USER_PROTOCOL_F_XEN_MMAP                17
+  #define VHOST_USER_PROTOCOL_F_SHARED_OBJECT           18
+  #define VHOST_USER_PROTOCOL_F_DEVICE_STATE            19
+  #define VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT 20
 
 Front-end message types
 -----------------------
@@ -1243,12 +1246,24 @@ Front-end message types
 
   When and as long as all of a device's vrings are stopped, it is
   *suspended*, see :ref:`Suspended device state
-  &lt;suspended_device_state&gt;`. The back-end must complete all inflight I/O
-  requests for the specified vring before stopping it.
+  &lt;suspended_device_state&gt;`.
 
   The request payload's *num* field is currently reserved and must be
   set to 0.
 
+  By default, the back-end must complete all inflight I/O requests for the
+  specified vring before stopping it.
+
+  If the ``VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT`` protocol
+  feature has been negotiated, the back-end may suspend in-flight I/O
+  requests and record them as described in :ref:`Inflight I/O tracking
+  &lt;inflight_io_tracking&gt;` instead of completing them before stopping the vring.
+  How to suspend an in-flight request depends on the implementation of the back-end
+  but it typically can be done by aborting or cancelling the underlying I/O
+  request. The ``VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT``
+  protocol feature must only be neogotiated if
+  ``VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD`` is also negotiated.
+
 ``VHOST_USER_SET_VRING_KICK``
   :id: 12
   :equivalent ioctl: ``VHOST_SET_VRING_KICK``
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index a820214188..793d1b36d8 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -2320,6 +2320,11 @@ static int vhost_user_backend_connect(struct vhost_dev *dev, Error **errp)
             }
         }
 
+        if (!u-&gt;user-&gt;supports_inflight_migration ||
+            !virtio_has_feature(VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
This looks like it will not compile since virtio_has_features() takes
two arguments. I think it should be:

  !virtio_has_feature(dev-&gt;protocol_features,
                      VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)

</pre>
    </blockquote>
    <p>Oh, how did I miss that...</p>
    <p>I'll fix it! Thanks<br>
    </p>
    <blockquote type="cite" cite="mid:20260113180017.GA528940@fedora">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+            protocol_features &amp;= ~(1ULL &lt;&lt;
+                               VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT);
+        }
+
         /* final set of protocol features */
         u-&gt;protocol_features = protocol_features;
         err = vhost_user_set_protocol_features(dev, u-&gt;protocol_features);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I seem to have different version of hw/virtio/vhost-user.c. Is this
patch against qemu.git/master?</pre>
    </blockquote>
    <p>This patch is based on Vladimir's patch, but I now thinks that I
      can separate my patch from his.</p>
    <p><span style="white-space: pre-wrap;">At first I thought there would be a lot of intersections with his patch.</span></p>
    <p><span style="white-space: pre-wrap;">In the next version, I will rebase this patch on the master</span></p>
    <blockquote type="cite" cite="mid:20260113180017.GA528940@fedora">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index fb89268de2..f30c1792e4 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -33,6 +33,7 @@ enum VhostUserProtocolFeature {
     /* Feature 17 reserved for VHOST_USER_PROTOCOL_F_XEN_MMAP. */
     VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 18,
     VHOST_USER_PROTOCOL_F_DEVICE_STATE = 19,
+    VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT = 20,
     VHOST_USER_PROTOCOL_F_MAX
 };
 
@@ -69,6 +70,7 @@ typedef struct VhostUserState {
     GPtrArray *notifiers;
     int memory_slots;
     bool supports_config;
+    bool supports_inflight_migration;
 } VhostUserState;
 
 /**
-- 
2.34.1

</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------XEsVvd4SdsAmyCkdndmnNG11--

