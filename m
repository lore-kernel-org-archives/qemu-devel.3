Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A74C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 09:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txjtm-00050z-Uv; Thu, 27 Mar 2025 05:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1txjtk-00050d-PQ
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 05:51:40 -0400
Received: from ssh.movementarian.org ([139.162.205.133] helo=movementarian.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1txjtj-0001zS-7k
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 05:51:40 -0400
Received: from movement by movementarian.org with local (Exim 4.95)
 (envelope-from <movement@movementarian.org>) id 1txjth-003mpU-Mk;
 Thu, 27 Mar 2025 09:51:37 +0000
Date: Thu, 27 Mar 2025 09:51:37 +0000
From: John Levon <levon@movementarian.org>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH for-10.1 v2 33/37] vfio: Rename RAM discard related
 services
Message-ID: <Z+UfqXAgNGaE3rR9@movementarian.org>
References: <20250326075122.1299361-1-clg@redhat.com>
 <20250326075122.1299361-34-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250326075122.1299361-34-clg@redhat.com>
X-Url: http://www.movementarian.org/
Received-SPF: pass client-ip=139.162.205.133;
 envelope-from=movement@movementarian.org; helo=movementarian.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Mar 26, 2025 at 08:51:18AM +0100, Cédric Le Goater wrote:

> Rename some routines to better reflect the namespace they belong to.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>  hw/vfio/listener.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index 26ced6d4fb04b0dedf399686db40acaca5d85552..07c8dc6ce343510dea20c5946e64a23a57c0f91b 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -243,7 +243,7 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
>      return 0;
>  }
>  
> -static void vfio_register_ram_discard_listener(VFIOContainerBase *bcontainer,
> +static void  vfio_ram_discard_register_listener(VFIOContainerBase *bcontainer,
>                                                 MemoryRegionSection *section)
>  {
>      RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
> @@ -318,7 +318,7 @@ static void vfio_register_ram_discard_listener(VFIOContainerBase *bcontainer,
>      }
>  }
>  
> -static void vfio_unregister_ram_discard_listener(VFIOContainerBase *bcontainer,
> +static void  vfio_ram_discard_unregister_listener(VFIOContainerBase *bcontainer,
>                                                   MemoryRegionSection *section)

Nit, unnecessary double spaces introduced here?

regards
john

