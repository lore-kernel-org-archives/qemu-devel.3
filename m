Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7353EC67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 17:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruFSP-0003Ve-Pz; Tue, 09 Apr 2024 13:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1ruFSM-0003VP-Rt
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 13:40:26 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1ruFSK-0001lk-2a
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 13:40:26 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 022325D386;
 Tue,  9 Apr 2024 20:42:16 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7E8EDAF831;
 Tue,  9 Apr 2024 20:40:19 +0300 (MSK)
Message-ID: <dd05e66b-1437-4293-b8b6-76b717e70c07@tls.msk.ru>
Date: Tue, 9 Apr 2024 20:40:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 4/7] hw/virtio: Fix packed virtqueue flush used_idx
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Wafer <wafer@jaguarmicro.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>
References: <cover.1712647890.git.mst@redhat.com>
 <2d9a31b3c27311eca1682cb2c076d7a300441960.1712647890.git.mst@redhat.com>
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
In-Reply-To: <2d9a31b3c27311eca1682cb2c076d7a300441960.1712647890.git.mst@redhat.com>
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

09.04.2024 10:32, Michael S. Tsirkin wrote:
> From: Wafer <wafer@jaguarmicro.com>
> 
> In the event of writing many chains of descriptors, the device must
> write just the id of the last buffer in the descriptor chain, skip
> forward the number of descriptors in the chain, and then repeat the
> operations for the rest of chains.
> 
> Current QEMU code writes all the buffer ids consecutively, and then
> skips all the buffers altogether. This is a bug, and can be reproduced
> with a VirtIONet device with _F_MRG_RXBUB and without
> _F_INDIRECT_DESC:
> 
> If a virtio-net device has the VIRTIO_NET_F_MRG_RXBUF feature
> but not the VIRTIO_RING_F_INDIRECT_DESC feature,
> 'VirtIONetQueue->rx_vq' will use the merge feature
> to store data in multiple 'elems'.
> The 'num_buffers' in the virtio header indicates how many elements are merged.
> If the value of 'num_buffers' is greater than 1,
> all the merged elements will be filled into the descriptor ring.
> The 'idx' of the elements should be the value of 'vq->used_idx' plus 'ndescs'.
> 
> Fixes: 86044b24e8 ("virtio: basic packed virtqueue support")
> Acked-by: Eugenio Pérez <eperezma@redhat.com>
> Signed-off-by: Wafer <wafer@jaguarmicro.com>
> Message-Id: <20240407015451.5228-2-wafer@jaguarmicro.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   hw/virtio/virtio.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)

Is this a -stable material?

Thanks,

/mjt

> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index d229755eae..c5bedca848 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -957,12 +957,20 @@ static void virtqueue_packed_flush(VirtQueue *vq, unsigned int count)
>           return;
>       }
>   
> +    /*
> +     * For indirect element's 'ndescs' is 1.
> +     * For all other elemment's 'ndescs' is the
> +     * number of descriptors chained by NEXT (as set in virtqueue_packed_pop).
> +     * So When the 'elem' be filled into the descriptor ring,
> +     * The 'idx' of this 'elem' shall be
> +     * the value of 'vq->used_idx' plus the 'ndescs'.
> +     */
> +    ndescs += vq->used_elems[0].ndescs;
>       for (i = 1; i < count; i++) {
> -        virtqueue_packed_fill_desc(vq, &vq->used_elems[i], i, false);
> +        virtqueue_packed_fill_desc(vq, &vq->used_elems[i], ndescs, false);
>           ndescs += vq->used_elems[i].ndescs;
>       }
>       virtqueue_packed_fill_desc(vq, &vq->used_elems[0], 0, true);
> -    ndescs += vq->used_elems[0].ndescs;
>   
>       vq->inuse -= ndescs;
>       vq->used_idx += ndescs;


