Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EF0C25B5F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 20:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4nk5-0005Iu-7S; Wed, 08 May 2024 16:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1s4njz-0005IK-LL; Wed, 08 May 2024 16:18:17 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1s4njx-0000e8-AZ; Wed, 08 May 2024 16:18:15 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 61BE4655B8;
 Wed,  8 May 2024 23:18:17 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 451F1C9CC3;
 Wed,  8 May 2024 23:17:55 +0300 (MSK)
Message-ID: <f1d4bddc-f2e9-4cb7-8866-5f010b21b756@tls.msk.ru>
Date: Wed, 8 May 2024 23:17:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] virtio-pci: fix use of a released vector
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Cindy Lu <lulu@redhat.com>, qemu-stable@nongnu.org,
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <2321ade5f601367efe7380c04e3f61379c59b48f.1713173550.git.mst@redhat.com>
Content-Language: en-US
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 xsBLBETIiwkBCADh3cFB56BQYPjtMZCfK6PSLR8lw8EB20rsrPeJtd91IoNZlnCjSoxd9Th1
 bLUR8YlpRJ2rjc6O1Bc04VghqUOHgS/tYt8vLjcGWixzdhSLJgPDK3QQZPAvBjMbCt1B6euC
 WuD87Pv5Udlpnzf4aMwxkgfTusx+ynae/o+T5r7tXD+isccbC3SiGhmAPxFyY3zGcFk4+Rxc
 0tP8YY2FWE/baHu+lBDTUN79efWAkHhex1XzVZsV7ZD16rzDbXFK5m6ApvGJWlr5YDEEydTF
 WwmvwBfr4OINVxzEG/ujNiG4fpMf2NsnFGyB9aSbFjXZevB4qWkduYYW+xpK1EryszHtAAYp
 zSBNaWNoYWVsIFRva2FyZXYgPG1qdEB0bHMubXNrLnJ1PsLAlgQTAQoAQAIbAwYLCQgHAwIE
 FQIIAwQWAgMBAh4BAheAAhkBFiEEbuGV0Yhuj/uBDUMkRXzgoIBEZcUFAmBbcjwFCS5e6jMA
 CgkQRXzgoIBEZcUTIQgA1hPsOF82pXxbcJXBMc4zB9OQu4AlnZvERoGyw7I2222QzaN3RFuj
 Fia//mapXzpIQNF08l/AA6cx+CKPeGnXwyZfF9fLa4RfifmdNKME8C00XlqnoJDZBGzq8yMy
 LAKDxl9OQWFcDwDxV+irg5U3fbtNVhvV0kLbS2TyQ0aU5w60ERS2NcyDWplOo7AOzZWChcA4
 UFf78oVdZdCW8YDtU0uQFhA9moNnrePy1HSFqduxnlFHEI+fDj/TiOm2ci48b8SBBJOIJFjl
 SBgH8+SfT9ZqkzhN9vh3YJ49831NwASVm0x1rDHcIwWD32VFZViZ3NjehogRNH9br0PSUYOC
 3s7ATQRX2BjLAQgAnak3m0imYOkv2tO/olULFa686tlwuvl5kL0NWCdGQeXv2uMxy36szcrh
 K1uYhpiQv4r2qNd8BJtYlnYIK16N8GBdkplaDIHcBMbU4t+6bQzEIJIaWoq1hzakmHHngE2a
 pNMnUf/01GFvCRPlv3imkujE/5ILbagjtdyJaHF0wGOSlTnNT4W8j+zPJ/XK0I5EVQwtbmoc
 GY62LKxxz2pID6sPZV4zQVY4JdUQaFvOz1emnBxakkt0cq3Qnnqso1tjiy7vyH9CAwPR/48W
 fpK6dew4Fk+STYtBeixOTfSUS8qRS/wfpUeNa5RnEdTtFQ9IcjpQ/nPrvJJsu9FqwlpjMwAR
 AQABwsBlBBgBCAAPBQJX2BjLAhsMBQkSzAMAAAoJEEV84KCARGXFUKcH/jqKETECkbyPktdP
 cWVqw2ZIsmGxMkIdnZTbPwhORseGXMHadQODayhU9GWfCDdSPkWDWzMamD+qStfl9MhlVT60
 HTbo6wu1W/ogUS70qQPTY9IfsvAj6f8TlSlK0eLMa3s2UxL2oe5FkNs2CnVeRlr4Yqvp/ZQV
 6LXtew4GPRrmplUT/Cre9QIUqR4pxYCQaMoOXQQw3Y0csBwoDYUQujn3slbDJRIweHoppBzT
 rM6ZG5ldWQN3n3d71pVuv80guylX8+TSB8Mvkqwb5I36/NAFKl0CbGbTuQli7SmNiTAKilXc
 Y5Uh9PIrmixt0JrmGVRzke6+11mTjVlio/J5dCM=
In-Reply-To: <2321ade5f601367efe7380c04e3f61379c59b48f.1713173550.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

15.04.2024 12:34, Michael S. Tsirkin wrote:
> From: Cindy Lu <lulu@redhat.com>
> 
> During the booting process of the non-standard image, the behavior of the
> called function in qemu is as follows:
> 
> 1. vhost_net_stop() was triggered by guest image. This will call the function
> virtio_pci_set_guest_notifiers() with assgin= false,
> virtio_pci_set_guest_notifiers(） will release the irqfd for vector 0
> 
> 2. virtio_reset() was triggered, this will set configure vector to VIRTIO_NO_VECTOR
> 
> 3.vhost_net_start() was called (at this time, the configure vector is
> still VIRTIO_NO_VECTOR) and then call virtio_pci_set_guest_notifiers() with
> assgin=true, so the irqfd for vector 0 is still not "init" during this process
> 
> 4. The system continues to boot and sets the vector back to 0. After that
> msix_fire_vector_notifier() was triggered to unmask the vector 0 and  meet the crash
> 
> To fix the issue, we need to support changing the vector after VIRTIO_CONFIG_S_DRIVER_OK is set.

This change breaks both 9.0 and stable-8.2.3:

https://gitlab.com/qemu-project/qemu/-/issues/2321
https://gitlab.com/qemu-project/qemu/-/issues/2334

So something's not right here.

Thanks,

/mjt

...
> MST: coding style and typo fixups
> 
> Fixes: f9a09ca3ea ("vhost: add support for configure interrupt")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> Message-Id: <20240412062750.475180-1-lulu@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   hw/virtio/virtio-pci.c | 37 +++++++++++++++++++++++++++++++++++--
>   1 file changed, 35 insertions(+), 2 deletions(-)
> 
> v7->v8:
> more cleanups, suggested by Philip
> 
> still untested, i just got involved to help address coding style
> issues
> 
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index cb6940fc0e..cb159fd078 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1424,6 +1424,38 @@ static int virtio_pci_add_mem_cap(VirtIOPCIProxy *proxy,
>       return offset;
>   }
>   
> +static void virtio_pci_set_vector(VirtIODevice *vdev,
> +                                  VirtIOPCIProxy *proxy,
> +                                  int queue_no, uint16_t old_vector,
> +                                  uint16_t new_vector)
> +{
> +    bool kvm_irqfd = (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK) &&
> +        msix_enabled(&proxy->pci_dev) && kvm_msi_via_irqfd_enabled();
> +
> +    if (new_vector == old_vector) {
> +        return;
> +    }
> +
> +    /*
> +     * If the device uses irqfd and the vector changes after DRIVER_OK is
> +     * set, we need to release the old vector and set up the new one.
> +     * Otherwise just need to set the new vector on the device.
> +     */
> +    if (kvm_irqfd && old_vector != VIRTIO_NO_VECTOR) {
> +        kvm_virtio_pci_vector_release_one(proxy, queue_no);
> +    }
> +    /* Set the new vector on the device. */
> +    if (queue_no == VIRTIO_CONFIG_IRQ_IDX) {
> +        vdev->config_vector = new_vector;
> +    } else {
> +        virtio_queue_set_vector(vdev, queue_no, new_vector);
> +    }
> +    /* If the new vector changed need to set it up. */
> +    if (kvm_irqfd && new_vector != VIRTIO_NO_VECTOR) {
> +        kvm_virtio_pci_vector_use_one(proxy, queue_no);
> +    }
> +}
> +
>   int virtio_pci_add_shm_cap(VirtIOPCIProxy *proxy,
>                              uint8_t bar, uint64_t offset, uint64_t length,
>                              uint8_t id)
> @@ -1570,7 +1602,8 @@ static void virtio_pci_common_write(void *opaque, hwaddr addr,
>           } else {
>               val = VIRTIO_NO_VECTOR;
>           }
> -        vdev->config_vector = val;
> +        virtio_pci_set_vector(vdev, proxy, VIRTIO_CONFIG_IRQ_IDX,
> +                              vdev->config_vector, val);
>           break;
>       case VIRTIO_PCI_COMMON_STATUS:
>           if (!(val & VIRTIO_CONFIG_S_DRIVER_OK)) {
> @@ -1610,7 +1643,7 @@ static void virtio_pci_common_write(void *opaque, hwaddr addr,
>           } else {
>               val = VIRTIO_NO_VECTOR;
>           }
> -        virtio_queue_set_vector(vdev, vdev->queue_sel, val);
> +        virtio_pci_set_vector(vdev, proxy, vdev->queue_sel, vector, val);
>           break;
>       case VIRTIO_PCI_COMMON_Q_ENABLE:
>           if (val == 1) {

-- 
GPG Key transition (from rsa2048 to rsa4096) since 2024-04-24.
New key: rsa4096/61AD3D98ECDF2C8E  9D8B E14E 3F2A 9DD7 9199  28F1 61AD 3D98 ECDF 2C8E
Old key: rsa2048/457CE0A0804465C5  6EE1 95D1 886E 8FFB 810D  4324 457C E0A0 8044 65C5
Transition statement: http://www.corpit.ru/mjt/gpg-transition-2024.txt


