Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC757D29DD4
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 06:33:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfXqJ-0006Iv-8G; Tue, 13 Jan 2026 01:25:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vfXqH-0006Gw-AZ; Tue, 13 Jan 2026 01:25:25 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vfXqE-0007g2-Kd; Tue, 13 Jan 2026 01:25:25 -0500
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 7C307807CC;
 Tue, 13 Jan 2026 09:25:15 +0300 (MSK)
Received: from [IPV6:2a02:6bf:803e:400:93c4:8e38:1f90:3c73] (unknown
 [2a02:6bf:803e:400:93c4:8e38:1f90:3c73])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id CPMBkt4Al0U0-G4QxwWki; Tue, 13 Jan 2026 09:25:14 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1768285515;
 bh=Upzzry1rt7I+TS7Hy4kcH8X9oTRHpsXtBI+ig/+HnKs=;
 h=In-Reply-To:Cc:Date:References:To:Subject:Message-ID:From;
 b=KyN81QvtJ6g+hwwO5aK086ggf6TXqBlt3Co/wVsgcc3ToB6eLodYt5QF21lG8cxqd
 yH+8WhsEP2r7Diypq6SfD3y18RKS/GVAF0h9yS8KDUrD3ZBoNTVyu5wcMYS4VuY/Gr
 ZohVFEICM5no5RZCepp0rZwMSB+jOpioUNWHeCNA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Content-Type: multipart/alternative;
 boundary="------------deVnu0pTy8JPHIY90UQrVWvo"
Message-ID: <3a84a77a-2f8b-4542-96e1-53211edb72db@yandex-team.ru>
Date: Tue, 13 Jan 2026 11:25:12 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] vhost: add vmstate for inflight region with inner
 buffer
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
 <20260112114503.1174330-5-dtalexundeer@yandex-team.ru>
 <20260112182259.GF462084@fedora>
Content-Language: en-US
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
In-Reply-To: <20260112182259.GF462084@fedora>
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
--------------deVnu0pTy8JPHIY90UQrVWvo
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/12/26 23:22, Stefan Hajnoczi wrote:
> On Mon, Jan 12, 2026 at 04:45:02PM +0500, Alexandr Moshkov wrote:
>> Prepare for future inflight region migration for vhost-user-blk.
>> We need to migrate size, queue_size, and inner buffer.
>>
>> So firstly it migrate size and queue_size fields, then allocate memory for buffer with
>> migrated size, then migrate inner buffer itself.
>>
>> Signed-off-by: Alexandr Moshkov<dtalexundeer@yandex-team.ru>
>> ---
>>   hw/virtio/vhost.c         | 42 +++++++++++++++++++++++++++++++++++++++
>>   include/hw/virtio/vhost.h |  6 ++++++
>>   2 files changed, 48 insertions(+)
>>
>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> index c46203eb9c..9a746c9861 100644
>> --- a/hw/virtio/vhost.c
>> +++ b/hw/virtio/vhost.c
>> @@ -2028,6 +2028,48 @@ const VMStateDescription vmstate_backend_transfer_vhost_inflight = {
>>       }
>>   };
>>   
>> +static int vhost_inflight_buffer_pre_load(void *opaque, Error **errp)
>> +{
>> +    info_report("vhost_inflight_region_buffer_pre_load");
>> +    struct vhost_inflight *inflight = opaque;
>> +
>> +    int fd = -1;
>> +    void *addr = qemu_memfd_alloc("vhost-inflight", inflight->size,
>> +                                  F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
>> +                                  &fd, errp);
>> +    if (*errp) {
>> +        return -ENOMEM;
>> +    }
>> +
>> +    inflight->offset = 0;
>> +    inflight->addr = addr;
>> +    inflight->fd = fd;
>> +
>> +    return 0;
>> +}
>> +
>> +const VMStateDescription vmstate_vhost_inflight_region_buffer = {
>> +    .name = "vhost-inflight-region/buffer",
>> +    .pre_load_errp = vhost_inflight_buffer_pre_load,
>> +    .fields = (const VMStateField[]) {
>> +        VMSTATE_VBUFFER_UINT64(addr, struct vhost_inflight, 0, NULL, size),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>> +const VMStateDescription vmstate_vhost_inflight_region = {
>> +    .name = "vhost-inflight-region",
>> +    .fields = (const VMStateField[]) {
>> +        VMSTATE_UINT64(size, struct vhost_inflight),
>> +        VMSTATE_UINT16(queue_size, struct vhost_inflight),
>> +        VMSTATE_END_OF_LIST()
>> +    },
>> +    .subsections = (const VMStateDescription * const []) {
>> +        &vmstate_vhost_inflight_region_buffer,
>> +        NULL
>> +    }
>> +};
> The subsection trick is neat - it allows the size to be loaded first and
> then the memfd is allocated. However, it introduces a weird case: if the
> source QEMU does not send the subsection, then the destination QEMU
> loads successfully but with inflight partially uninitialized.
>
> It's not obvious to me that the destination QEMU will fail in a safe way
> when this happens. The source QEMU must not be able to trigger undefined
> behavior. Can you add an explicit check somewhere to fail when this
> required subsection is missing?
>
Thanks for reply! For this check, I can add post_load on 
`vmstate_vhost_inflight_region` vmstate and check that `inflight->addr` 
has been initialized (not NULL)
--------------deVnu0pTy8JPHIY90UQrVWvo
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
    <div class="moz-cite-prefix">On 1/12/26 23:22, Stefan Hajnoczi
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260112182259.GF462084@fedora">
      <pre wrap="" class="moz-quote-pre">On Mon, Jan 12, 2026 at 04:45:02PM +0500, Alexandr Moshkov wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Prepare for future inflight region migration for vhost-user-blk.
We need to migrate size, queue_size, and inner buffer.

So firstly it migrate size and queue_size fields, then allocate memory for buffer with
migrated size, then migrate inner buffer itself.

Signed-off-by: Alexandr Moshkov <a class="moz-txt-link-rfc2396E" href="mailto:dtalexundeer@yandex-team.ru">&lt;dtalexundeer@yandex-team.ru&gt;</a>
---
 hw/virtio/vhost.c         | 42 +++++++++++++++++++++++++++++++++++++++
 include/hw/virtio/vhost.h |  6 ++++++
 2 files changed, 48 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index c46203eb9c..9a746c9861 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -2028,6 +2028,48 @@ const VMStateDescription vmstate_backend_transfer_vhost_inflight = {
     }
 };
 
+static int vhost_inflight_buffer_pre_load(void *opaque, Error **errp)
+{
+    info_report("vhost_inflight_region_buffer_pre_load");
+    struct vhost_inflight *inflight = opaque;
+
+    int fd = -1;
+    void *addr = qemu_memfd_alloc("vhost-inflight", inflight-&gt;size,
+                                  F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
+                                  &amp;fd, errp);
+    if (*errp) {
+        return -ENOMEM;
+    }
+
+    inflight-&gt;offset = 0;
+    inflight-&gt;addr = addr;
+    inflight-&gt;fd = fd;
+
+    return 0;
+}
+
+const VMStateDescription vmstate_vhost_inflight_region_buffer = {
+    .name = "vhost-inflight-region/buffer",
+    .pre_load_errp = vhost_inflight_buffer_pre_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_VBUFFER_UINT64(addr, struct vhost_inflight, 0, NULL, size),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+const VMStateDescription vmstate_vhost_inflight_region = {
+    .name = "vhost-inflight-region",
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(size, struct vhost_inflight),
+        VMSTATE_UINT16(queue_size, struct vhost_inflight),
+        VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * const []) {
+        &amp;vmstate_vhost_inflight_region_buffer,
+        NULL
+    }
+};
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
The subsection trick is neat - it allows the size to be loaded first and
then the memfd is allocated. However, it introduces a weird case: if the
source QEMU does not send the subsection, then the destination QEMU
loads successfully but with inflight partially uninitialized.

It's not obvious to me that the destination QEMU will fail in a safe way
when this happens. The source QEMU must not be able to trigger undefined
behavior. Can you add an explicit check somewhere to fail when this
required subsection is missing?

</pre>
    </blockquote>
    Thanks for reply! For this check, I can add post_load on
    `vmstate_vhost_inflight_region` vmstate and check that
    `inflight-&gt;addr` has been initialized (not NULL)<span
    style="white-space: pre-wrap">
</span>
  </body>
</html>

--------------deVnu0pTy8JPHIY90UQrVWvo--

