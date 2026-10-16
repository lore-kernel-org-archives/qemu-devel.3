Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB7DFCC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 07:38:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHcVk-000478-0T; Fri, 16 Oct 2026 03:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>)
 id 1xHcVb-0003qp-CK; Fri, 16 Oct 2026 03:37:45 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>)
 id 1xHcVZ-0003FL-2z; Fri, 16 Oct 2026 03:37:42 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DCF0960008;
 Fri, 16 Oct 2026 07:37:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999531F000C4;
 Fri, 16 Oct 2026 07:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792136256;
 bh=Cf8t2q8kHerQlGKlDU2xSim1IxOG9CBfmPfRJi7x8uI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=hnQ3K5r7FRometXPIlUmyiDWyU/5Bsa9Ld4twuekSgZnsMUQ1T6ZCBAGwFrB1WPfY
 7VhxORtNkdfAB7qBqfST4RxU3rgyaRLoNoytFLiZTlxMJdsmM8WUH+nhns+r074kUM
 X6e2QWA1eam2NPcIlIbsCw9EnGLZB67480o6GuX7lRyjt5ZkuY3BwIqVEsbJ2FoezL
 qXM12YvWE1xVvNHbL5mQ6Hou8eDyqs/Rd1cYEyOCcXvC7SWntI1uEni16zt39mwuB5
 FP81mM3Dt+407ZMOyas+5HCNupOLAA5F9rggdPXzQsg+9HBUsz7y91FN6Kj8kWIV3M
 REVPfEoIezPww==
Message-ID: <6da8ceed-7ff4-497b-9499-a0d5d3925e15@kernel.org>
Date: Fri, 16 Oct 2026 09:37:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/34] hw/virtio/virtio-mem: Avoid call to target_info()
 in class_init
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Cornelia Huck <cohuck@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>, Eric Blake <eblake@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-s390x@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alexander Bulekov <alxndr@bu.edu>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier
 <laurent@vivier.eu>, Fabiano Rosas <farosas@suse.de>,
 Song Gao <17746591750@163.com>, Fam Zheng <fam@euphon.net>,
 Markus Armbruster <armbru@redhat.com>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Chao Liu <chao.liu@processmission.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Stafford Horne <shorne@gmail.com>
References: <20261014094224.1976-1-luoyonggang@gmail.com>
From: David Hildenbrand <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20261014094224.1976-1-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=david@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/14/26 11:41, Yonggang Luo wrote:
> Done by merge virtio_mem_legacy_guests_properties into virtio_mem_properties.
> As we already have vmem->unplugged_inaccessible handle in virtio_mem_device_realize
> So we can reject the wrong option in virtio_mem_device_realize, then the call
> target_info() in class_init no need anymore.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  hw/virtio/virtio-mem.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> index a4110d61312..81e2192c2fb 100644
> --- a/hw/virtio/virtio-mem.c
> +++ b/hw/virtio/virtio-mem.c
> @@ -879,7 +879,11 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
>              break;
>          }
>      } else {
> -        vmem->unplugged_inaccessible = ON_OFF_AUTO_ON;
> +        if (vmem->unplugged_inaccessible != ON_OFF_AUTO_ON) {
> +            error_setg(errp, "'%s' must be 'on' on non-x86 targets",
> +                       VIRTIO_MEM_UNPLUGGED_INACCESSIBLE_PROP);
> +            return;
> +        }
>      }
>  
>      if (vmem->dynamic_memslots &&
> @@ -1568,9 +1572,6 @@ static const Property virtio_mem_properties[] = {
>                       early_migration, true),
>      DEFINE_PROP_BOOL(VIRTIO_MEM_DYNAMIC_MEMSLOTS_PROP, VirtIOMEM,
>                       dynamic_memslots, false),
> -};
> -
> -static const Property virtio_mem_legacy_guests_properties[] = {
>      DEFINE_PROP_ON_OFF_AUTO(VIRTIO_MEM_UNPLUGGED_INACCESSIBLE_PROP, VirtIOMEM,
>                              unplugged_inaccessible, ON_OFF_AUTO_ON),
>  };
> @@ -1635,9 +1636,6 @@ static void virtio_mem_class_init(ObjectClass *klass, const void *data)
>      RamDiscardSourceClass *rdsc = RAM_DISCARD_SOURCE_CLASS(klass);
>  
>      device_class_set_props(dc, virtio_mem_properties);
> -    if (virtio_mem_has_legacy_guests()) {
> -        device_class_set_props(dc, virtio_mem_legacy_guests_properties);
> -    }
>      dc->vmsd = &vmstate_virtio_mem;
>  
>      set_bit(DEVICE_CATEGORY_MISC, dc->categories);

Now a property introspection shows properties that don't make any sense for
other targets.

I don't see the value, really.

-- 
Cheers,

David


