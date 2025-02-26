Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70766C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 14:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnIBQ-00033O-Gm; Wed, 26 Feb 2025 09:14:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tnI9d-0008Eb-VZ
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:12:56 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tnI9a-0007gp-Ia
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:12:52 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6927F4E6198;
 Wed, 26 Feb 2025 15:12:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id x1tfbavgWWUM; Wed, 26 Feb 2025 15:12:46 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7C7F64E6182; Wed, 26 Feb 2025 15:12:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7A1E374577D;
 Wed, 26 Feb 2025 15:12:46 +0100 (CET)
Date: Wed, 26 Feb 2025 15:12:46 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Tony Krowiak <akrowiak@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH 1/2] vfio: Make vfio-pci available on 64-bit host platforms
 only
In-Reply-To: <20250226084721.232703-2-clg@redhat.com>
Message-ID: <a39e97c2-c6fd-34e4-f91b-b3491185b789@eik.bme.hu>
References: <20250226084721.232703-1-clg@redhat.com>
 <20250226084721.232703-2-clg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-867407228-1740579166=:45476"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-867407228-1740579166=:45476
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 26 Feb 2025, Cédric Le Goater wrote:
> VFIO PCI never worked on PPC32 nor ARM, S390x is 64-bit, it might have
> worked on i386 long ago but we have no plans to further support VFIO
> on any 32-bit host platforms. Restrict to 64-bit host platforms.
>
> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Cc: Tony Krowiak <akrowiak@linux.ibm.com>
> Cc: Eric Farman <farman@linux.ibm.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
> hw/vfio/Kconfig | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/vfio/Kconfig b/hw/vfio/Kconfig
> index 7cdba0560aa821c88d3420b36f86020575834202..6ed825429a9151fcdff33e95d1a310210689b258 100644
> --- a/hw/vfio/Kconfig
> +++ b/hw/vfio/Kconfig
> @@ -7,7 +7,7 @@ config VFIO_PCI
>     default y
>     select VFIO
>     select EDID
> -    depends on LINUX && PCI
> +    depends on LINUX && PCI && (AARCH64 || PPC64 || X86_64 || S390X)

Are these defined for the host or target? I see PPC is defined in 
target/ppc/Kconfig so I think these mark the target not the host. Vfio-pci 
works with qemu-system-ppc and we are trying to use it for GPU pass 
through for 32 bit PPC guests. Please keep that enabled.

Regards,
BALATON Zoltan

> config VFIO_CCW
>     bool
>
--3866299591-867407228-1740579166=:45476--

