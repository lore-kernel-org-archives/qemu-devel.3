Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8E9606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bu4knLhT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJRzE-0003Fj-5M; Wed, 21 Oct 2026 04:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>)
 id 1xJRz9-0003F4-8V; Wed, 21 Oct 2026 04:47:47 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>)
 id 1xJRz7-0001Zh-1C; Wed, 21 Oct 2026 04:47:46 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 08C1060142;
 Wed, 21 Oct 2026 08:47:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC98A1F000C9;
 Wed, 21 Oct 2026 08:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792572454;
 bh=3uFRkXCC1DCjxJHPcHxFRkAxw/pEw0cj3qwmfqNIzCM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=bu4knLhT6z/L7Nsj7lqgWSLdBJSrCDLozBED5XguJKJLBg0tk7I7oqVXDr+YfYB5Z
 2uVS4Y9E0SrXb7K1E7K71WGDiuOJt4Bctq8GlRYoJIpNmLJZbgDJzcDWboFegTrMt3
 kNvOL8bvPJwR9Hv2iSril92Jwe8hXehqahJ6kpICOL+sfBpbSX1igD3HMIuv7QMk5M
 MrFP859OLur1o9JEMwvOHzYCyeZSKQAS/f+M/6tBkoq36kYc8/ADRaU8qPz1Bwuh1D
 DjL0JkWOku42jdXOLGhBDB4FEYFKHDvR/FnwnqiYOXvtSuk4Y0L0p4WDmQZn/Uhpds
 qLgS98H7r1mpA==
Message-ID: <202fa691-1d7d-460a-b892-2942c23f270e@kernel.org>
Date: Wed, 21 Oct 2026 10:47:31 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/virtio/virtio-mem: Fix error message on invalid NUMA
 node
To: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, mst@redhat.com, shan.gavin@gmail.com
References: <20261020012404.191329-1-gshan@redhat.com>
From: David Hildenbrand <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20261020012404.191329-1-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=david@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 03:24, Gavin Shan wrote:
> Add space as the separator between "exceeds" and "the number of numa
> nodes:". Otherwise, we will see error message with twisted format like
> below.
> 
>   qemu-system-aarch64: -device virtio-mem-pci,id=vmem1,bus=pcie.3, \
>   memdev=virtio-mem1-mem,requested-size=0,node=1: 'node' property  \
>   has value '1', which exceedsthe number of numa nodes: 1
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  hw/virtio/virtio-mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> index 7130ed852d..ee6a0c206a 100644
> --- a/hw/virtio/virtio-mem.c
> +++ b/hw/virtio/virtio-mem.c
> @@ -846,7 +846,7 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
>      if ((nb_numa_nodes && vmem->node >= nb_numa_nodes) ||
>          (!nb_numa_nodes && vmem->node)) {
>          error_setg(errp, "'%s' property has value '%" PRIu32 "', which exceeds"
> -                   "the number of numa nodes: %d", VIRTIO_MEM_NODE_PROP,
> +                   " the number of numa nodes: %d", VIRTIO_MEM_NODE_PROP,
>                     vmem->node, nb_numa_nodes ? nb_numa_nodes : 1);
>          return;
>      }

Reviewed-by: David Hildenbrand <david@kernel.org>

-- 
Cheers,

David


