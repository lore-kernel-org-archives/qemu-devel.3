Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13744C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 10:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txODN-000232-67; Wed, 26 Mar 2025 06:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1txODI-00022Z-Fk
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 06:42:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1txODG-000614-NV
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 06:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742985741;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2SFEffpS3bPVFkIn5tuo1vTiLlmWYN8wcl4QlKIeLJI=;
 b=KAvU+gTEQ1A572pxUU7j12sYvX54i23M0KYm+a2Utm5RCaxZlDd2jbLzQB1v75JbatANja
 tZgugpaE6QLdu0FLcsmuRiHjYZjyBRJOIRovvkz51C3wRhiRdoffd8ExKhu9V5qMuiBXnH
 S4TBYtUaihBnmq2gAL4hrixkiwRN7+Y=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-1E4eixybNOq4wRCWq2ewOQ-1; Wed,
 26 Mar 2025 06:42:16 -0400
X-MC-Unique: 1E4eixybNOq4wRCWq2ewOQ-1
X-Mimecast-MFC-AGG-ID: 1E4eixybNOq4wRCWq2ewOQ_1742985735
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 991C9190308B; Wed, 26 Mar 2025 10:42:15 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.107])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC9B31800944; Wed, 26 Mar 2025 10:42:10 +0000 (UTC)
Date: Wed, 26 Mar 2025 10:42:07 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, jon.grimm@amd.com,
 santosh.shukla@amd.com, vasant.hegde@amd.com, Wei.Huang2@amd.com,
 kraxel@redhat.com, bsd@redhat.com, ddutile@redhat.com, yvugenfi@redhat.com
Subject: Re: [PATCH v2] hw/i386/amd_iommu: Assign pci-id 0x1419 for the AMD
 IOMMU device
Message-ID: <Z-PZ_-j8m0ipEHev@redhat.com>
References: <20250325021140.5676-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250325021140.5676-1-suravee.suthikulpanit@amd.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Mar 25, 2025 at 02:11:40AM +0000, Suravee Suthikulpanit wrote:
> Currently, the QEMU-emulated AMD IOMMU device use PCI vendor id 0x1022
> (AMD) with device id zero (undefined). Eventhough this does not cause any
> functional issue for AMD IOMMU driver since it normally uses information
> in the ACPI IVRS table to probe and initialize the device per
> recommendation in the AMD IOMMU specification, the device id zero causes
> the Windows Device Manager utility to show the device as an unknown device.
> 
> Since Windows only recognizes AMD IOMMU device with device id 0x1419 as
> listed in the machine.inf file, modify the QEMU AMD IOMMU model to use
> the id 0x1419 to avoid the issue. This advertise the IOMMU as the AMD
> IOMMU device for Family 15h (Models 10h-1fh).
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
> Changes from v1 (https://lore.kernel.org/all/20250304183747.639382-1-suravee.suthikulpanit@amd.com/)
> * Use the existing device id 0x1419 instead of the proposed new id.
> 
>  hw/i386/amd_iommu.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


NB, this must be merged before we enable migration support for the
device, in order to avoid the need to add versioned machine type compat.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


