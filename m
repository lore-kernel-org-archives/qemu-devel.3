Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 326FCCAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 04:17:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1zsQ-0007PW-H1; Fri, 26 Sep 2025 00:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhaoxin04@baidu.com>)
 id 1v1zsH-0007Oz-0D
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 00:16:05 -0400
Received: from mx24.baidu.com ([111.206.215.185] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhaoxin04@baidu.com>)
 id 1v1zs0-0005bq-CI
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 00:16:00 -0400
To: qemu-devel <qemu-devel@nongnu.org>
CC: "Michael S . Tsirkin" <mst@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, Jonah Palmer <jonah.palmer@oracle.com>, Miao Kezhan
 <miaokezhan@baidu.com>, Li Zhaoxin <lizhaoxin04@baidu.com>
Subject: Re: [PATCH] vdpa-dev: add get_vhost() callback for vhost-vdpa device
Date: Fri, 26 Sep 2025 12:15:15 +0800
Message-ID: <20250926041515.36123-1-lizhaoxin04@baidu.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <lh5yr3s3xej3mejfkoz5q6m5jf62b6ox2mvaspu5t3niuhv3qx@gdwzsqquroei>
References: <lh5yr3s3xej3mejfkoz5q6m5jf62b6ox2mvaspu5t3niuhv3qx@gdwzsqquroei>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.127.73.8]
X-ClientProxiedBy: bjhj-exc12.internal.baidu.com (172.31.3.22) To
 bjhj-exc18.internal.baidu.com (172.31.4.16)
X-FEAS-Client-IP: 172.31.4.16
X-FE-Policy-ID: 52:10:53:SYSTEM
Received-SPF: pass client-ip=111.206.215.185;
 envelope-from=lizhaoxin04@baidu.com; helo=baidu.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Li Zhaoxin <lizhaoxin04@baidu.com>
From:  Li Zhaoxin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 24 Sep 2025 04:08:24 -0700, Stefano Garzarella wrote:
>On Tue, Sep 23, 2025 at 09:51:10PM +0800, Li Zhaoxin wrote:
>>Commit c255488d67 "virtio: add vhost support for virtio devices"
>>added the get_vhost() function, but it did not include vhost-vdpa devices.
>>Now we add it.
>
>Again, could you please explain what problem you had and how this patch 
>solves it?
>
>This information must always be included in a commit message, so please 
>pay attention to this.
>
>Thanks,
>Stefano
>

OK, I've got it.
When I use the vdpa device and query the status of the vdpa device with
the x-query-virtio-status qmp command, since vdpa does not implement vhost_get,
it will cause qemu to crash. 

Therefore, in order to obtain the status of the virtio device under vhost-vdpa,
we need to add a vhost_get implement for the vdpa device.

Later, I will send Patch v2 that includes the complete commit information.

Thanks,
Li Zhaoxin

>>
>>Co-developed-by: Miao Kezhan <miaokezhan@baidu.com>
>>Signed-off-by: Miao Kezhan <miaokezhan@baidu.com>
>>Signed-off-by: Li Zhaoxin <lizhaoxin04@baidu.com>
>>---
>> hw/virtio/vdpa-dev.c | 7 +++++++
>> 1 file changed, 7 insertions(+)
>>
>>diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
>>index d1da40afc8..4a7b970976 100644
>>--- a/hw/virtio/vdpa-dev.c
>>+++ b/hw/virtio/vdpa-dev.c
>>@@ -338,6 +338,12 @@ static int vhost_vdpa_device_set_status(VirtIODevice *vdev, uint8_t status)
>>     return 0;
>> }
>>
>>+static struct vhost_dev *vhost_vdpa_device_get_vhost(VirtIODevice *vdev)
>>+{
>>+    VhostVdpaDevice *s = VHOST_VDPA_DEVICE(vdev);
>>+    return &s->dev;
>>+}
>>+
>> static const Property vhost_vdpa_device_properties[] = {
>>     DEFINE_PROP_STRING("vhostdev", VhostVdpaDevice, vhostdev),
>>     DEFINE_PROP_UINT16("queue-size", VhostVdpaDevice, queue_size, 0),
>>@@ -369,6 +375,7 @@ static void vhost_vdpa_device_class_init(ObjectClass *klass, const void *data)
>>     vdc->set_config = vhost_vdpa_device_set_config;
>>     vdc->get_features = vhost_vdpa_device_get_features;
>>     vdc->set_status = vhost_vdpa_device_set_status;
>>+    vdc->get_vhost = vhost_vdpa_device_get_vhost;
>> }
>>
>> static void vhost_vdpa_device_instance_init(Object *obj)
>>-- 
>>2.34.1
>>

