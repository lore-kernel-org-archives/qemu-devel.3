Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DBCBCD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 07:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa7ce-0001Gg-S2; Thu, 18 Jun 2026 03:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1wa7cb-0001G9-Fo
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 03:57:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1wa7cZ-0005eL-TF
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 03:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781769426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BAsysMrQn8K45idvWA6gfaatQiUPlYGBaXK6to98XJA=;
 b=SN4gXI0gm1rQZROrJlJWkkuTYHnx/0RS78D82xW9406kbdxvTvG2APziZbvGj7Qms1wFtS
 eggEeHPh1x5L0UecLWwuXdjR2421pcPRSQypvLsPzrI7ReII7EuB0NqwUDItiKcC2DMIA0
 3u1Tkuuk/aQqNvjbq2GOqjCMWqb7Rr4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-xH7w6s0oOUK77MUJHNoZzQ-1; Thu,
 18 Jun 2026 03:55:54 -0400
X-MC-Unique: xH7w6s0oOUK77MUJHNoZzQ-1
X-Mimecast-MFC-AGG-ID: xH7w6s0oOUK77MUJHNoZzQ_1781769353
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9CAC21956049; Thu, 18 Jun 2026 07:55:53 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.44.24.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B94F1956041; Thu, 18 Jun 2026 07:55:51 +0000 (UTC)
Date: Thu, 18 Jun 2026 09:55:48 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PULL 15/28] hw/i386/x86-iommu: Remove
 X86IOMMUState::pt_supported field
Message-ID: <ajOkhPtZvUakzpoi@angien.pipo.sk>
References: <20260305105215.302571-1-thuth@redhat.com>
 <20260305105215.302571-16-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260305105215.302571-16-thuth@redhat.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Mar 05, 2026 at 11:52:02 +0100, Thomas Huth wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> The X86IOMMUState::pt_supported boolean was only set in
> the hw_compat_2_9[] array, via the 'pt=off' property. We
> removed all machines using that array, lets remove that
> property and all the code around it, always setting the
> VTD_ECAP_PT capability.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Message-ID: <20250501210456.89071-19-philmd@linaro.org>
> [thuth: Dropped the hunks that were already merged via commit 31753d5a336f]
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Message-ID: <20260225092024.794595-16-thuth@redhat.com>
> ---
>  include/hw/i386/x86-iommu.h |  1 -
>  hw/i386/intel_iommu.c       | 13 ++-----------
>  hw/i386/x86-iommu.c         |  1 -
>  3 files changed, 2 insertions(+), 13 deletions(-)

[...]

> diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
> index 33ac0bfc97e..a57445404ef 100644
> --- a/hw/i386/x86-iommu.c
> +++ b/hw/i386/x86-iommu.c
> @@ -129,7 +129,6 @@ static const Property x86_iommu_properties[] = {
>      DEFINE_PROP_ON_OFF_AUTO("intremap", X86IOMMUState,
>                              intr_supported, ON_OFF_AUTO_AUTO),
>      DEFINE_PROP_BOOL("device-iotlb", X86IOMMUState, dt_supported, false),
> -    DEFINE_PROP_BOOL("pt", X86IOMMUState, pt_supported, true),
>      DEFINE_PROP_BOOL("dma-translation", X86IOMMUState, dma_translation, true),

Sorry for necromancing this 3 months later.

This removes the 'pt' option from the 'amd-iommu' device too since
it inherits from  X86IOMMUState. Libvirt does expose the setting for
that option although I no longer remember why that was added.

I'm not sure based on the commit message though whether that was an
intended outcome.

When updating the libvirt dumps of capability probing I unfortunately
mis-read the diff and thought that 'pt' was added instead of removed so
I didn't pay any closer attention:

 https://gitlab.com/libvirt/libvirt/-/commit/75edc7ae98938ae0548e4c368d9c291d3763289a

IMO since device properties are visible from outside changes like this
should be mentioned in the 'deprecated.rst' document.

Since this is just an optional setting it doesn't cause any problems for
users who didn't set it though so it's not really too big of a problem.
Libvirt will likely add a capability to reject it.


