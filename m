Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE11C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 18:13:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkT65-0000gA-DW; Wed, 13 Mar 2024 14:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1rkT63-0000fP-Lz
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 14:12:59 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1rkT61-0006OJ-Po
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 14:12:59 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 52DEB55B9F;
 Wed, 13 Mar 2024 21:13:48 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 56D1898955;
 Wed, 13 Mar 2024 21:12:43 +0300 (MSK)
Message-ID: <41f0f7b4-ce3d-4e60-8567-1aa34a616b1a@tls.msk.ru>
Date: Wed, 13 Mar 2024 21:12:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] vdpa: fix network breakage after cancelling
 migration
Content-Language: en-US
To: Si-Wei Liu <si-wei.liu@oracle.com>, jasowang@redhat.com, mst@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, yin31149@gmail.com,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org
References: <1707910082-10243-1-git-send-email-si-wei.liu@oracle.com>
 <1707910082-10243-13-git-send-email-si-wei.liu@oracle.com>
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
In-Reply-To: <1707910082-10243-13-git-send-email-si-wei.liu@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

14.02.2024 14:28, Si-Wei Liu wrote:
> Fix an issue where cancellation of ongoing migration ends up
> with no network connectivity.
> 
> When canceling migration, SVQ will be switched back to the
> passthrough mode, but the right call fd is not programed to
> the device and the svq's own call fd is still used. At the
> point of this transitioning period, the shadow_vqs_enabled
> hadn't been set back to false yet, causing the installation
> of call fd inadvertently bypassed.
> 
> Fixes: a8ac88585da1 ("vhost: Add Shadow VirtQueue call forwarding capabilities")
> Cc: Eugenio Pérez <eperezma@redhat.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>   hw/virtio/vhost-vdpa.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)

Is this a -stable material?

If yes, is it also applicable for stable-7.2 (mentioned commit is in 7.2.0),
which lacks v7.2.0-2327-gb276524386 "vdpa: Remember last call fd set",
or should this one also be picked up?

Thanks,

/mjt

> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 004110f..dfeca8b 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -1468,7 +1468,15 @@ static int vhost_vdpa_set_vring_call(struct vhost_dev *dev,
>   
>       /* Remember last call fd because we can switch to SVQ anytime. */
>       vhost_svq_set_svq_call_fd(svq, file->fd);
> -    if (v->shadow_vqs_enabled) {
> +    /*
> +     * When SVQ is transitioning to off, shadow_vqs_enabled has
> +     * not been set back to false yet, but the underlying call fd
> +     * will have to switch back to the guest notifier to signal the
> +     * passthrough virtqueues. In other situations, SVQ's own call
> +     * fd shall be used to signal the device model.
> +     */
> +    if (v->shadow_vqs_enabled &&
> +        v->shared->svq_switching != SVQ_TSTATE_DISABLING) {
>           return 0;
>       }
>   


