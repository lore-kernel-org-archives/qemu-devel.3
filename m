Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73BFCC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 14:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgkBU-00010d-KG; Mon, 06 Jul 2026 10:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>)
 id 1wgkBT-00010O-8I; Mon, 06 Jul 2026 10:20:31 -0400
Received: from fhigh-a7-smtp.messagingengine.com ([103.168.172.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>)
 id 1wgkBR-0007XC-88; Mon, 06 Jul 2026 10:20:30 -0400
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 730E214000F9;
 Mon,  6 Jul 2026 10:20:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Mon, 06 Jul 2026 10:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1783347626;
 x=1783434026; bh=YjnPuIv9+2JKVK3cMkWliR7IEeGGZEXVkq5SA1HLoic=; b=
 Re0iyRXmJvvJi1CAbVnYbYDlTPXQPqWrAM9WYhvLl5K1rcg5TNGYG123QYAEdUdy
 iKPq5xy1gfbap+waBPfT+Gh9jwpPT1A0l7avU+D2YFL2s/WcFWS+FIVYp35DJB63
 BBMKSfNGlvjOVjc7ugEPCdRQmXrkL2QTR0FjHOmILxnj/QSTe0XldpCQTAeVdydL
 aPb+QjZmy6ABGGxrPHj36olBVCurmdI4BvnLCuDinbbC1f+ZMHkWa3eiFQoj/JfE
 YXgxK0Nqy05pmOBBtEwwdzT0fA+tkoQ8JnW9zSk/sgenT20Bc/pYrMOtaJKNmpud
 E9nTukUP+BVTpxao9PuxPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783347626; x=
 1783434026; bh=YjnPuIv9+2JKVK3cMkWliR7IEeGGZEXVkq5SA1HLoic=; b=a
 xNH9+9kjS9MIWxm+Rp23LqfyGD6fUZEfC9bCM7ACO1Y1Yv+JkBzvCwb0kNwc8/WN
 L2lcgz/Osr8BfElLcUtcLxlwVNU2h4pWGzO1apilVTak7j7iXEBD529dzQdlg7Ds
 O8tuqT+xyMbb1vd3PPweULoPK60CrR7D96Pnlyu8CkrBCpROUZ5rUmlmS82D0MWk
 +1izZqDayHACIFngB/xhKKeCiOHgtILCkcLPbAiTEZDAJ34tfkjjuw26O8LH3Hqx
 jcetcmLAqwUthELm3EOXmoiWGhkoytg6JFsRwDMW/8/P3iyEIfgZVZcs0O8ejJum
 5pcQGXNMa2N3cpRLfxmnQ==
X-ME-Sender: <xms:qblLao3RJvTVdkM18TdvJI2dR9R3EOnHn8TEcRXDmBTiKzD3qLQQcg>
 <xme:qblLalXrlUdMCa_XJflVGHgEYt-5eY5AOASKnwW9m6r09B_uATazHotASipgnWwty
 wlsgkxXQRUtHGc31g9YStf1BDM3NV7sZ4aZXjouuBJ_J3_4YqYptw>
X-ME-Received: <xmr:qblLajJt47_rw50NKRnvM2rvSKSdGOJM3Iq-BtXCyBQAxuH_3rbF98XND-o>
X-ME-Proxy-Cause: dmFkZTF9/XpAPF1pnC+czCU49T3BT0nKcD41hOwjMkLvdjksB/Lz0UXNCRVAwGAXD+rgQW
 t2xPf9Hs2Ka78r6aaVA+Z4gFx32wpPEF+wp3dr1Dh6t4fW0tBSNruKtN5vnmwjQilfTZCQ
 Bft8zOrHWBhWj0n7KC56e5gycFLkv8xSm7hHS9HYYm7BcomNxvh0WC4AAcWk+VTWFPEUgo
 3y/PhPwQVUeHFUt8t6I38xXh54gdsQYtqJAwYbPOQY9PW2cewzHkkKz9oUNIZMvMcABdN+
 t3K9qaMWynRiQP5XoqhI2JLIUsFa6xmtdcEB5i9OLCo8ieh7FYLB3MIqnTERTOhcRT+wDH
 J/mzGgq44IAeK5k56zcFVo3gklbrwMw94zgeKXX9zWwK8DsYoQ6ruDN6agR8X0Q4nfjgSN
 s1rWki0QLi+V/FieDLrouMZk0vLbGQKEvaUu9bkGaErb34ZG76zffKKDnOcc9XMSMxJkuj
 Kz/8VjoWe+iJbnfXSYCvqrM/l/CktjXR/wTrsOPsTWlORvBDwPRd3Od6KHsPztg18ILJSF
 5/loBItf5/ZW6O0LvgP4MgMFGdGlc0pCMqp5hyH8pwRze5HXD9icMNASRewcnkkfUVLJ3B
 0PO6asDbvf0sscB3SKYat5q+EnwyEmGIDxqK8bO9yzaumlPaJHrmdczKaNjw
X-ME-Proxy: <xmx:qblLan3Yt5ynIx5CHcXvWG_lWVO_4ENc0Z_Xh_Aq4d64xEQGojpoew>
 <xmx:qblLap5PuCfltSSMrgZrFLrVsmGzliEDfEmMN0QfXnGDLYUqtvxWLA>
 <xmx:qblLag869zw9IDaCr481MQKiRHsolyodeK9bJe1-m3-pvPi1ikxJYQ>
 <xmx:qblLagWOGw-dtdkKLhX_i2tj3N6k2WPzoQN1Bh0aJPpEsz2EAcykHA>
 <xmx:qrlLalaMUmGD5SocPQD-HXgtnl02eyJ4ienbRmGzWqwjCcwmCxZ9yu8W>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 10:20:25 -0400 (EDT)
Date: Mon, 6 Jul 2026 08:20:23 -0600
From: Alex Williamson <alex@shazbot.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Eric Auger
 <eric.auger@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>, Peter
 Maydell <peter.maydell@linaro.org>, alex@shazbot.org
Subject: Re: [PATCH] vfio/listener: Only warn on misalignment for VFIO-owned
 regions
Message-ID: <20260706082023.7ee830b8@shazbot.org>
In-Reply-To: <20260702160640.3875666-1-clg@redhat.com>
References: <20260702160640.3875666-1-clg@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.158; envelope-from=alex@shazbot.org;
 helo=fhigh-a7-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu,  2 Jul 2026 18:06:40 +0200
C=C3=A9dric Le Goater <clg@redhat.com> wrote:

> Any device on the board can have non-page-aligned memory regions. The
> VFIO listener should not warn about misalignment for regions that are
> not VFIO-related.
>=20
> Replace the vfio_known_safe_misalignment() whitelist with a
> vfio_get_vfio_device() ownership check: only warn when a VFIO device's
> own region is misaligned. For all other regions, emit a trace event
> and silently skip. Extract the misalignment test into a
> vfio_section_misaligned() helper for readability.
>=20
> Note: vfio_get_vfio_device() currently only covers VFIO PCI devices,
> including vfio-user-pci.  Other VFIO backends (AP, CCW) don't expose
> memory regions through this path so this is sufficient for now.

I thought the whole point was to warn when there are non-vfio devices
that we cannot insert into the DMA map.  851d6d1a0ff2 added tpm-crb-cmd
to an ignore list because it's not a DMA target.  The intention of that
ignore list was to continue to evaluate devices that are misaligned
and either add them to the ignore list or determine they could be a
valid DMA target and correct the alignment.

Can this even legitimately trigger with a vfio-pci device?  Thanks,

Alex

>=20
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  hw/vfio/device.c     |  2 +-
>  hw/vfio/listener.c   | 33 +++++++++++++++------------------
>  hw/vfio/trace-events |  2 +-
>  3 files changed, 17 insertions(+), 20 deletions(-)
>=20
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 1a7f8088aad9583ee96fc303be917fdb2f100df9..3a47109efb35c6dc28719dcc1=
9acb85bef1d26cd 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -439,7 +439,7 @@ bool vfio_device_hiod_create_and_realize(VFIODevice *=
vbasedev,
> =20
>  VFIODevice *vfio_get_vfio_device(Object *obj)
>  {
> -    if (object_dynamic_cast(obj, TYPE_VFIO_PCI)) {
> +    if (object_dynamic_cast(obj, TYPE_VFIO_PCI_DEVICE)) {
>          return &VFIO_PCI_DEVICE(obj)->vbasedev;
>      } else {
>          return NULL;
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index c19600e980a8d02217b5d9df4aca8f879ab2c5d5..76b9b02f8163f18d20994e4ec=
1f914a4d148fa92 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -40,7 +40,6 @@
>  #include "migration/misc.h"
>  #include "migration/qemu-file.h"
>  #include "system/tcg.h"
> -#include "system/tpm.h"
>  #include "vfio-migration-internal.h"
>  #include "vfio-helpers.h"
>  #include "vfio-listener.h"
> @@ -352,20 +351,10 @@ static void vfio_ram_discard_unregister_listener(VF=
IOContainer *bcontainer,
>      g_free(vrdl);
>  }
> =20
> -static bool vfio_known_safe_misalignment(MemoryRegionSection *section)
> +static bool vfio_section_misaligned(MemoryRegionSection *section)
>  {
> -    MemoryRegion *mr =3D section->mr;
> -
> -    if (!TPM_IS_CRB(mr->owner)) {
> -        return false;
> -    }
> -
> -    /* this is a known safe misaligned region, just trace for debug purp=
ose */
> -    trace_vfio_known_safe_misalignment(memory_region_name(mr),
> -                                       section->offset_within_address_sp=
ace,
> -                                       section->offset_within_region,
> -                                       qemu_real_host_page_size());
> -    return true;
> +    return (section->offset_within_address_space & ~qemu_real_host_page_=
mask()) !=3D
> +           (section->offset_within_region & ~qemu_real_host_page_mask());
>  }
> =20
>  static bool vfio_listener_valid_section(MemoryRegionSection *section,
> @@ -379,10 +368,12 @@ static bool vfio_listener_valid_section(MemoryRegio=
nSection *section,
>          return false;
>      }
> =20
> -    if (unlikely((section->offset_within_address_space &
> -                  ~qemu_real_host_page_mask()) !=3D
> -                 (section->offset_within_region & ~qemu_real_host_page_m=
ask()))) {
> -        if (!vfio_known_safe_misalignment(section)) {
> +    if (unlikely(vfio_section_misaligned(section))) {
> +        /*
> +         * Only warn for VFIO device regions.  Other VFIO backends
> +         * (AP, CCW) don't expose memory regions through this path.
> +         */
> +        if (vfio_get_vfio_device(memory_region_owner(section->mr))) {
>              error_report("%s received unaligned region %s iova=3D0x%"PRI=
x64
>                           " offset_within_region=3D0x%"PRIx64
>                           " qemu_real_host_page_size=3D0x%"PRIxPTR,
> @@ -390,6 +381,12 @@ static bool vfio_listener_valid_section(MemoryRegion=
Section *section,
>                           section->offset_within_address_space,
>                           section->offset_within_region,
>                           qemu_real_host_page_size());
> +        } else {
> +            trace_vfio_listener_region_misaligned(
> +                         memory_region_name(section->mr),
> +                         section->offset_within_address_space,
> +                         section->offset_within_region,
> +                         qemu_real_host_page_size());
>          }
>          return false;
>      }
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index f71d0bbc0a5440e4ccd374fac4733af08438e7be..5056b9942027938cd6bc83219=
8acc9809739399f 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -98,7 +98,7 @@ vfio_spapr_group_attach(int groupfd, int tablefd) "Atta=
ched groupfd %d to liobn
>  vfio_listener_region_add_iommu(const char* name, uint64_t start, uint64_=
t end) "region_add [iommu] %s 0x%"PRIx64" - 0x%"PRIx64
>  vfio_listener_region_del_iommu(const char *name) "region_del [iommu] %s"
>  vfio_listener_region_add_ram(uint64_t iova_start, uint64_t iova_end, voi=
d *vaddr) "region_add [ram] 0x%"PRIx64" - 0x%"PRIx64" [%p]"
> -vfio_known_safe_misalignment(const char *name, uint64_t iova, uint64_t o=
ffset_within_region, uintptr_t page_size) "Region \"%s\" iova=3D0x%"PRIx64"=
 offset_within_region=3D0x%"PRIx64" qemu_real_host_page_size=3D0x%"PRIxPTR
> +vfio_listener_region_misaligned(const char *name, uint64_t iova, uint64_=
t offset_within_region, uintptr_t page_size) "Region \"%s\" iova=3D0x%"PRIx=
64" offset_within_region=3D0x%"PRIx64" qemu_real_host_page_size=3D0x%"PRIxP=
TR
>  vfio_listener_region_add_no_dma_map(const char *name, uint64_t iova, uin=
t64_t size, uint64_t page_size) "Region \"%s\" 0x%"PRIx64" size=3D0x%"PRIx6=
4" is not aligned to 0x%"PRIx64" and cannot be mapped for DMA"
>  vfio_listener_region_skip_dma_map(const char *name, uint64_t iova, uint6=
4_t size) "Region \"%s\" 0x%"PRIx64" size=3D0x%"PRIx64" marked to skip IOMM=
U mapping"
>  vfio_listener_region_del(uint64_t start, uint64_t end) "region_del 0x%"P=
RIx64" - 0x%"PRIx64


