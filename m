Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB93C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 09:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfxlc-0004J4-VI; Thu, 06 Feb 2025 04:01:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tfxlb-0004IU-2J
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 04:01:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tfxlY-0004u3-Kh
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 04:01:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738832502;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=OLFnOyzeMgN3PSGDypiRPKAPrLrgXMKnWAwVDvAHNL8=;
 b=DPETR/CLHGHLSKWE8Yw1CRvdxcgOUMZHtU6Y8/LE/Z2exyLc/YaHinXFVdvnmZPeMbMDcj
 Ttxe1e5/cUkm338bwcU/8vWGen/e/pd3brQXA1GQxF1GRrP5OqEtRFB/McWeUItE5s4/O5
 td0dfmPO4f3h3NlvDZwE6JSkxDr+SM8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-vh2zwKEnP7O44c_SetWfVQ-1; Thu,
 06 Feb 2025 04:01:38 -0500
X-MC-Unique: vh2zwKEnP7O44c_SetWfVQ-1
X-Mimecast-MFC-AGG-ID: vh2zwKEnP7O44c_SetWfVQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 05BDF19560AA; Thu,  6 Feb 2025 09:01:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.33])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A646530001AB; Thu,  6 Feb 2025 09:01:30 +0000 (UTC)
Date: Thu, 6 Feb 2025 09:01:26 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, jon.grimm@amd.com,
 santosh.shukla@amd.com, vasant.hegde@amd.com, Wei.Huang2@amd.com,
 bsd@redhat.com
Subject: Re: [PATCH v2] hw/i386/amd_iommu: Allow migration
Message-ID: <Z6R6ZiHhbBjOfbko@redhat.com>
References: <20250206051856.323651-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250206051856.323651-1-suravee.suthikulpanit@amd.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Feb 06, 2025 at 05:18:56AM +0000, Suravee Suthikulpanit wrote:
> Add migration support for AMD IOMMU model by saving necessary AMDVIState
> parameters for MMIO registers, device table, command buffer, and event
> buffers.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
> Changes from v1:
> (https://lore.kernel.org/all/9ecffa7a-f4c6-45a5-a066-84826ccb55dd@amd.com/T/)
> * Include ppr_log, pprlog_len, pprlog_head, pprlog_tail per Joao.
> 
>  hw/i386/amd_iommu.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 13af7211e1..a1940a0ab3 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1673,7 +1673,48 @@ static Property amdvi_properties[] = {
>  
>  static const VMStateDescription vmstate_amdvi_sysbus = {
>      .name = "amd-iommu",
> -    .unmigratable = 1
> +    .version_id = 1,

IMHO we should not remove the 'unmigratable = 1'  setting, until we
have fixed the design problem with this device, to split the creation
of the 'AMDVI-PCI' device off from the 'amd-iommu' device, so that the
former is user creatable.

As it stands now, there's no mechanism to guarantee that the internally
created 'AMDVI-PCI' device gets the same PCI address properties on every
boot. Thus it isn't safe to claim this device is migratable yet IMHO.

> +    .minimum_version_id = 1,
> +    .priority = MIG_PRI_IOMMU,
> +    .fields = (VMStateField[]) {


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


