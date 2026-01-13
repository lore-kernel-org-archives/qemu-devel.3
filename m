Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC5ED29DD4
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 06:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfXux-0001u9-89; Tue, 13 Jan 2026 01:30:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vfXuv-0001tL-EX; Tue, 13 Jan 2026 01:30:13 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vfXut-0008BK-5O; Tue, 13 Jan 2026 01:30:13 -0500
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 93C61807B3;
 Tue, 13 Jan 2026 09:30:09 +0300 (MSK)
Received: from [IPV6:2a02:6bf:803e:400:93c4:8e38:1f90:3c73] (unknown
 [2a02:6bf:803e:400:93c4:8e38:1f90:3c73])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 7UMZ4e5Ap0U0-Bw4lnULO; Tue, 13 Jan 2026 09:30:09 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1768285809;
 bh=Z9RGfIZsZWn1wm4SoksS9iVwNskMczF3C++lBNvF/J0=;
 h=In-Reply-To:Cc:Date:References:To:Subject:Message-ID:From;
 b=XVFr2Mkl3+bwCrrBQDjDxlQCMDPx2TTUC9oXbeo7rnRJHnmbDR4pRWTdwG+Qz+XLX
 0X8+lnOeVDCXnktKGw0GYiF//lKdEBe4QKTA8szXjRv9D21fY+MObiFGtWrd/hKfeM
 bASP1xaWidBuodD1AiH209jjL6j6NIo0G7f0A42o=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Content-Type: multipart/alternative;
 boundary="------------QKZK2WCdD6atbKh7dPQzH0p7"
Message-ID: <8667a0ca-b2f8-48c0-a3fe-85dd96ad5c96@yandex-team.ru>
Date: Tue, 13 Jan 2026 11:30:07 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] vhost-user: introduce protocol feature for skip
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
References: <20260112114503.1174330-1-dtalexundeer@yandex-team.ru>
 <20260112114503.1174330-3-dtalexundeer@yandex-team.ru>
 <20260112180807.GD462084@fedora>
Content-Language: en-US
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
In-Reply-To: <20260112180807.GD462084@fedora>
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
--------------QKZK2WCdD6atbKh7dPQzH0p7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/12/26 23:08, Stefan Hajnoczi wrote:
> On Mon, Jan 12, 2026 at 04:45:00PM +0500, Alexandr Moshkov wrote:
>> Add vhost-user protocol feature
>> VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT
>>
>> Now on GET_VRING_BASE this feature can control whether to wait for
>> in-flight requests to complete or not.
>>
>> It will be helpfull in future for in-flight requests migration in
>> vhost-user devices.
>>
>> Signed-off-by: Alexandr Moshkov<dtalexundeer@yandex-team.ru>
>> ---
>>   docs/interop/vhost-user.rst    | 52 ++++++++++++++++++----------------
>>   include/hw/virtio/vhost-user.h |  1 +
>>   2 files changed, 29 insertions(+), 24 deletions(-)
>>
>> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
>> index 02908b48fa..80c80aada5 100644
>> --- a/docs/interop/vhost-user.rst
>> +++ b/docs/interop/vhost-user.rst
>> @@ -1033,26 +1033,27 @@ Protocol features
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
>> @@ -1243,11 +1244,14 @@ Front-end message types
>>   
>>     When and as long as all of a device's vrings are stopped, it is
>>     *suspended*, see :ref:`Suspended device state
>> -  <suspended_device_state>`. The back-end must complete all inflight I/O
>> -  requests for the specified vring before stopping it.
>> +  <suspended_device_state>`.
>>   
>> -  The request payload's *num* field is currently reserved and must be
>> -  set to 0.
>> +  By default, the back-end must complete all inflight I/O requests for the
>> +  specified vring before stopping it.
>> +
>> +  If the ``VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT`` protocol feature
>> +  has been negotiated, the back-end may stop the vring immediately without
>> +  waiting for inflight I/O requests to complete.
> This paragraph is not specific enough. It gives the impression that I/O
> requests can be left running, but that's not the case. They need to be
> quiesced and recorded in the Inflight I/O Tracking
> (VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD) shared memory data structure.
>
> I suggest rewording it as follows:
>
>    If the ``VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT`` protocol
>    feature has been negotiated, the back-end may suspend in-flight I/O
>    requests and record them as described in :ref:`inflight-io-tracking`
>    instead of completing them before stopping the vring. How to suspend
>    an in-flight request depends on the implementation of the back-end but
>    it typically can be done by aborting or cancelling the underlying I/O
>    request. The ``VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT``
>    protocol feature must only be neogotiated if
>    ``VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD`` is also negotiated.
>
> (A _inflight-io-tracking label needs to be added in order to reference
> the "Inflight I/O tracking" section.)

I'll fix that, thanks!

--------------QKZK2WCdD6atbKh7dPQzH0p7
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
    <div class="moz-cite-prefix">On 1/12/26 23:08, Stefan Hajnoczi
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260112180807.GD462084@fedora">
      <pre wrap="" class="moz-quote-pre">On Mon, Jan 12, 2026 at 04:45:00PM +0500, Alexandr Moshkov wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Add vhost-user protocol feature
VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT

Now on GET_VRING_BASE this feature can control whether to wait for
in-flight requests to complete or not.

It will be helpfull in future for in-flight requests migration in
vhost-user devices.

Signed-off-by: Alexandr Moshkov <a class="moz-txt-link-rfc2396E" href="mailto:dtalexundeer@yandex-team.ru">&lt;dtalexundeer@yandex-team.ru&gt;</a>
---
 docs/interop/vhost-user.rst    | 52 ++++++++++++++++++----------------
 include/hw/virtio/vhost-user.h |  1 +
 2 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 02908b48fa..80c80aada5 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -1033,26 +1033,27 @@ Protocol features
 
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
@@ -1243,11 +1244,14 @@ Front-end message types
 
   When and as long as all of a device's vrings are stopped, it is
   *suspended*, see :ref:`Suspended device state
-  &lt;suspended_device_state&gt;`. The back-end must complete all inflight I/O
-  requests for the specified vring before stopping it.
+  &lt;suspended_device_state&gt;`.
 
-  The request payload's *num* field is currently reserved and must be
-  set to 0.
+  By default, the back-end must complete all inflight I/O requests for the
+  specified vring before stopping it.
+
+  If the ``VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT`` protocol feature
+  has been negotiated, the back-end may stop the vring immediately without
+  waiting for inflight I/O requests to complete.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
This paragraph is not specific enough. It gives the impression that I/O
requests can be left running, but that's not the case. They need to be
quiesced and recorded in the Inflight I/O Tracking
(VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD) shared memory data structure.

I suggest rewording it as follows:

  If the ``VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT`` protocol
  feature has been negotiated, the back-end may suspend in-flight I/O
  requests and record them as described in :ref:`inflight-io-tracking`
  instead of completing them before stopping the vring. How to suspend
  an in-flight request depends on the implementation of the back-end but
  it typically can be done by aborting or cancelling the underlying I/O
  request. The ``VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT``
  protocol feature must only be neogotiated if
  ``VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD`` is also negotiated.

(A _inflight-io-tracking label needs to be added in order to reference
the "Inflight I/O tracking" section.)</pre>
    </blockquote>
    <p>I'll fix that, thanks!<span style="white-space: pre-wrap">
</span></p>
  </body>
</html>

--------------QKZK2WCdD6atbKh7dPQzH0p7--

