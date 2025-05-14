Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64244C3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 11:47:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFAZa-0003Zh-AO; Wed, 14 May 2025 07:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uFAZU-0003ZM-Q6; Wed, 14 May 2025 07:46:48 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uFAZR-0004Ml-LI; Wed, 14 May 2025 07:46:48 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 12BC355D21A;
 Wed, 14 May 2025 13:46:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id aIapBQrQMQxB; Wed, 14 May 2025 13:46:21 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1588F55D22A; Wed, 14 May 2025 13:46:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1369A745682;
 Wed, 14 May 2025 13:46:21 +0200 (CEST)
Date: Wed, 14 May 2025 13:46:21 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Zhao Liu <zhao1.liu@intel.com>
cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?ISO-8859-15?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org, 
 qemu-trivial@nongnu.org, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
Subject: Re: [PATCH 6/9] hw/ppc/pef: Consolidate
 OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES
In-Reply-To: <20250514084957.2221975-7-zhao1.liu@intel.com>
Message-ID: <0b162bfe-27ed-371e-d46d-22de58f73a37@eik.bme.hu>
References: <20250514084957.2221975-1-zhao1.liu@intel.com>
 <20250514084957.2221975-7-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Wed, 14 May 2025, Zhao Liu wrote:
> The QOM type of PefGuest is declared by OBJECT_DECLARE_SIMPLE_TYPE,
> which means it doesn't need the class!
>
> Therefore, use OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES to implement
> the type, then there's no need for class definition.
>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Cc: qemu-ppc@nongnu.org
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> hw/ppc/pef.c | 17 ++++++-----------
> 1 file changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/hw/ppc/pef.c b/hw/ppc/pef.c
> index 254f5707876f..1832791ee533 100644
> --- a/hw/ppc/pef.c
> +++ b/hw/ppc/pef.c
> @@ -20,11 +20,6 @@
> OBJECT_DECLARE_SIMPLE_TYPE(PefGuest, PEF_GUEST)
>
> typedef struct PefGuest PefGuest;
> -typedef struct PefGuestClass PefGuestClass;
> -
> -struct PefGuestClass {
> -    ConfidentialGuestSupportClass parent_class;
> -};
>
> /**
>  * PefGuest:
> @@ -121,12 +116,12 @@ static int pef_kvm_reset(ConfidentialGuestSupport *cgs, Error **errp)
>     return kvmppc_svm_off(errp);
> }
>
> -OBJECT_DEFINE_TYPE_WITH_INTERFACES(PefGuest,
> -                                   pef_guest,
> -                                   PEF_GUEST,
> -                                   CONFIDENTIAL_GUEST_SUPPORT,
> -                                   { TYPE_USER_CREATABLE },
> -                                   { NULL })
> +OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(PefGuest,
> +                                          pef_guest,
> +                                          PEF_GUEST,
> +                                          CONFIDENTIAL_GUEST_SUPPORT,
> +                                          { TYPE_USER_CREATABLE },
> +                                          { NULL })

Maybe also change the name while at it because the WITH_INTERFACES macros 
usually allow to pass an interfaces list instead of the single hardcoded 
USER_CREATABLE interface here so if such variant is added it would clash. 
Better call this something that shows this is PEF specific or just use the 
appropriate macro from qemu/object.h to define it.

Regards,
BALATON Zoltan

>
> static void pef_guest_class_init(ObjectClass *oc, const void *data)
> {
>

