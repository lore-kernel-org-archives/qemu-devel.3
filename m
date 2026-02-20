Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D3E7C5B568
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 21:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtXsP-0001F2-4E; Fri, 20 Feb 2026 16:17:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vtXsL-0001E7-C1; Fri, 20 Feb 2026 16:17:25 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vtXsH-0007rr-Ne; Fri, 20 Feb 2026 16:17:25 -0500
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 2845D80764;
 Sat, 21 Feb 2026 00:17:17 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:87::1:2c] (unknown [2a02:6bf:8080:87::1:2c])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id FHknR65AB0U0-5LYNP8NH; Sat, 21 Feb 2026 00:17:16 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1771622236;
 bh=QJFtd5bsNRDrZpUJj6TGyEzhcgsvpwW0nhenadFMWwc=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=vC0r6w3O9xB8kAkQZ5cq6RfX5bNkpVWZn3kkO4P8tLT5XZAzAiqFe7e9wFRtiSwHe
 1C90RFlem76Bb/wT9dfunzJxrYkSZI3cm5xYkg043NraJprQlG667Uyce7Hapr+RId
 9jW4hm5edt+X1SKdznO6BvwqIo0e8xYCEZRT8/sY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <9dacb6b6-fd6a-45bd-a618-630904cc67ce@yandex-team.ru>
Date: Sat, 21 Feb 2026 00:17:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/23] vhost: move protocol_features to vhost_user
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, zhenwei pi
 <zhenwei.pi@linux.dev>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
References: <20260206095258.894504-1-vsementsov@yandex-team.ru>
 <20260206095258.894504-5-vsementsov@yandex-team.ru>
 <20260220111948-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260220111948-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 20.02.26 19:20, Michael S. Tsirkin wrote:
> On Fri, Feb 06, 2026 at 12:52:38PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> As comment says: it's only for vhost-user. So, let's move it
>> to corresponding vhost backend realization.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> 
> breaks build:
> 
> https://gitlab.com/mstredhat/qemu/-/jobs/13201554836
> 
> builds/mstredhat/qemu/build/../hw/virtio/virtio-qmp.c:830:(.text+0xd60): undefined reference to `vhost_user_qmp_status'
> 

Suggest:

diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 6675b63ce6..047385df3d 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -45,13 +45,15 @@ if have_vhost
                           if_true: files('vhost-user-input-pci.c'))
      system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_SPI'],
                           if_true: files('vhost-user-spi-pci.c'))
+  else
+    system_virtio_ss.add(files('vhost-user-stub.c'))
    endif
    if have_vhost_vdpa
      system_virtio_ss.add(files('vhost-vdpa.c'))
      system_virtio_ss.add(files('vhost-shadow-virtqueue.c'))
    endif
  else
-  system_virtio_ss.add(files('vhost-stub.c'))
+  system_virtio_ss.add(files('vhost-stub.c', 'vhost-user-stub.c'))
  endif
  system_virtio_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-user-vsock.c'))
  system_virtio_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-rng.c'))
diff --git a/hw/virtio/vhost-user-stub.c b/hw/virtio/vhost-user-stub.c
new file mode 100644
index 0000000000..45559788dd
--- /dev/null
+++ b/hw/virtio/vhost-user-stub.c
@@ -0,0 +1,6 @@
+#include "qemu/osdep.h"
+#include "hw/virtio/vhost-user.h"
+
+void vhost_user_qmp_status(struct vhost_dev *dev, VirtioStatus *status)
+{
+}


it fixes the problem: https://gitlab.com/vsementsov/qemu/-/pipelines/2340295574

here rebased on master branch: https://gitlab.com/vsementsov/qemu/-/tree/up-vhost-user-blk-refactor

the only chnage is above fixup and the fact that

07 "virtio-ccw: virtio_ccw_set_guest_notifier(): fix failure path"
is already in master as 391c230f71fbf22284d




-- 
Best regards,
Vladimir

