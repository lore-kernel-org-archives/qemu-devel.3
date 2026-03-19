Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF847108E1FE
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 12:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3CNq-0004nM-Pi; Thu, 19 Mar 2026 08:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w3CNZ-0004jt-1F
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 08:21:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w3CNT-0007dm-KL
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 08:21:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773922887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P3HpqVf2NTLHU1CVipak5+mNjgrkSd89Ycx51M1CmPY=;
 b=MQ6kFgLPrSCJabQR+RDNWlbNrFziuOxvpfISGGZR1GAaVQPDBbEAQ1umwkVlUEGGqp4MVd
 tBmXEG7+g26jccm3egMAQP6J8tesSEp/IzTjBSAF16TQdpbG8fvVt7vPGdMmIycER8NX8V
 qPo7SUObEwdhRJMOuqxQ5TpB1AwLqIc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-MFZYNZtfOwCAQVRbIMBH5w-1; Thu,
 19 Mar 2026 08:21:24 -0400
X-MC-Unique: MFZYNZtfOwCAQVRbIMBH5w-1
X-Mimecast-MFC-AGG-ID: MFZYNZtfOwCAQVRbIMBH5w_1773922882
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7553819560B8; Thu, 19 Mar 2026 12:21:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 30AC11800763; Thu, 19 Mar 2026 12:21:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DEE9F21E6937; Thu, 19 Mar 2026 13:21:19 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Nathan Chen <nathanc@nvidia.com>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  Eric Auger
 <eric.auger@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,  Igor Mammedov
 <imammedo@redhat.com>,  Ani Sinha <anisinha@redhat.com>,  Shannon Zhao
 <shannon.zhaosl@gmail.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel
 P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eric Blake
 <eblake@redhat.com>, Shameer Kolothum <skolothumtho@nvidia.com>,  Matt Ochs
 <mochs@nvidia.com>,  Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v4 8/8] qemu-options.hx: Document arm-smmuv3 device's
 accel properties
In-Reply-To: <20260318184907.4060030-9-nathanc@nvidia.com> (Nathan Chen's
 message of "Wed, 18 Mar 2026 11:49:07 -0700")
References: <20260318184907.4060030-1-nathanc@nvidia.com>
 <20260318184907.4060030-9-nathanc@nvidia.com>
Date: Thu, 19 Mar 2026 13:21:19 +0100
Message-ID: <87ldfo80xs.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Nathan Chen <nathanc@nvidia.com> writes:

> From: Nathan Chen <nathanc@nvidia.com>
>
> Document arm-smmuv3 properties for setting HW-acceleration,
> Range Invalidation, and Address Translation Services support, as
> well as setting Output Address size and Substream ID size.
>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>  qemu-options.hx | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 69e5a874c1..f8da35513a 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1279,13 +1279,43 @@ SRST
>      ``aw-bits=val`` (val between 32 and 64, default depends on machine)
>          This decides the address width of the IOVA address space.
>  
> -``-device arm-smmuv3,primary-bus=id``
> +``-device arm-smmuv3,primary-bus=id[,option=...]``
>      This is only supported by ``-machine virt`` (ARM).
>  
>      ``primary-bus=id``
>          Accepts either the default root complex (pcie.0) or a
>          pxb-pcie based root complex.
>  
> +    ``accel=on|off`` (default: off)
> +        Enables guest to leverage host SMMUv3 features for acceleration.
> +        Enabling accel configures the host SMMUv3 in nested mode to support
> +        vfio-pci passthrough.
> +
> +     The following options are available when accel=on.

What happens when you try to use them with accel=off?

> +     Note: 'auto' mode is not currently supported.
> +
> +    ``ril=on|off`` (default: on)
> +        Support for Range Invalidation, which allows the SMMUv3 driver to
> +        invalidate TLB entries for a range of IOVAs at once instead of issuing
> +        separate commands to invalidate each page. Must match with host SMMUv3
> +        Range Invalidation support.
> +
> +    ``ats=on|off`` (default: off)
> +        Support for Address Translation Services, which enables PCIe devices to
> +        cache address translations in their local TLB and reduce latency. Host
> +        SMMUv3 must support ATS in order to enable this feature for the vIOMMU.
> +
> +    ``oas=val`` (supported values are 44 and 48. default: 44)
> +        Sets the Output Address Size in bits. The value set here must be less
> +        than or equal to the host SMMUv3's supported OAS, so that the
> +        intermediate physical addresses (IPA) consumed by host SMMU for stage-2
> +        translation do not exceed the host's max supported IPA size.
> +
> +    ``ssidsize=val`` (val between 0 and 20. default: 0)
> +        Sets the Substream ID size in bits. When set to a non-zero value,
> +        PASID capability is advertised to the vIOMMU and accelerated use cases
> +        such as Shared Virtual Addressing (SVA) are supported.
> +
>  ``-device amd-iommu[,option=...]``
>      Enables emulation of an AMD-Vi I/O Memory Management Unit (IOMMU).
>      Only available with ``-machine q35``, it supports the following options:


