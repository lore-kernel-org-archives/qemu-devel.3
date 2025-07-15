Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78AA9C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 14:16:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubgQh-0001CO-2t; Tue, 15 Jul 2025 10:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1ubfp4-0003tU-FZ; Tue, 15 Jul 2025 09:35:55 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1ubfp1-0004kS-GC; Tue, 15 Jul 2025 09:35:53 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2119B55D23A;
 Tue, 15 Jul 2025 15:35:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id pAYOvAYW3-am; Tue, 15 Jul 2025 15:35:43 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 247DC55BC04; Tue, 15 Jul 2025 15:35:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1FFB0745682;
 Tue, 15 Jul 2025 15:35:43 +0200 (CEST)
Date: Tue, 15 Jul 2025 15:35:43 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
cc: npiggin@gmail.com, danielhb413@gmail.com, harshpb@linux.ibm.com, 
 mjrosato@linux.ibm.com, farman@linux.ibm.com, pasic@linux.ibm.com, 
 borntraeger@linux.ibm.com, thuth@redhat.com, richard.henderson@linaro.org, 
 david@redhat.com, iii@linux.ibm.com, john.levon@nutanix.com, 
 thanos.makatos@nutanix.com, alex.williamson@redhat.com, clg@redhat.com, 
 steven.sistare@oracle.com, tomitamoeko@gmail.com, qemu-ppc@nongnu.org, 
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 11/22] vfio-user/pci.c: update VFIOUserPCIDevice
 declaration
In-Reply-To: <20250715093110.107317-12-mark.caveayland@nutanix.com>
Message-ID: <63286625-82b9-63aa-0741-81525a250e62@eik.bme.hu>
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
 <20250715093110.107317-12-mark.caveayland@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, 15 Jul 2025, Mark Cave-Ayland wrote:
> Update the VFIOUserPCIDevice declaration so that it is closer to our coding
> guidelines: add a blank line after the parent object.
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
> hw/vfio-user/pci.c | 1 +
> 1 file changed, 1 insertion(+)
>
> diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
> index be71c77729..da6fe51809 100644
> --- a/hw/vfio-user/pci.c
> +++ b/hw/vfio-user/pci.c
> @@ -21,6 +21,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserPCIDevice, VFIO_USER_PCI)
>
> struct VFIOUserPCIDevice {
>     VFIOPCIDevice device;
> +

This isn't worth a separate patch. Can be squashed in patch 13.

Regards,
BALATON Zoltan

>     SocketAddress *socket;
>     bool send_queued;   /* all sends are queued */
>     uint32_t wait_time; /* timeout for message replies */
>

