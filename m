Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30846CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kMA-0007fn-9n; Fri, 17 Oct 2025 09:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v9kM8-0007cG-Me
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:18:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v9kLx-0006Fy-Ll
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:18:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760707115;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jAkRelVz1BnP2QFOmLj5neVDaWWMzJ0SC1T6l3BxGAY=;
 b=JU96bECicveG0uq03UvFGfnQjVT0vaVBgQM0jxFLzeGQqNlSlfqy/q988mUvsmUywWALcW
 881R5pAALfy0w3OZJHnZElVWcwG9QadIeiiykWNZAv14NqRn8VgPzdPtfg0jV4AAN+7o/j
 lpac3xRntWr7TCOMSgRvOQTuRBvk3Pw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-5E2a032kMP-KYOp3hGJEIg-1; Fri,
 17 Oct 2025 09:18:33 -0400
X-MC-Unique: 5E2a032kMP-KYOp3hGJEIg-1
X-Mimecast-MFC-AGG-ID: 5E2a032kMP-KYOp3hGJEIg_1760707112
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B6031956048; Fri, 17 Oct 2025 13:18:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.139])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7BFD9180035A; Fri, 17 Oct 2025 13:18:29 +0000 (UTC)
Date: Fri, 17 Oct 2025 14:18:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-arm@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 00/20] hw/arm/virt: Remove virt-4.1 -> virt-7.2 machines
Message-ID: <aPJCIuoL2_C2wrv2@redhat.com>
References: <20251017130821.58388-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251017130821.58388-1-philmd@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Oct 17, 2025 at 03:07:59PM +0200, Philippe Mathieu-Daudé wrote:
> Remove the deprecated virt-4.1 up to virt-7.2 machines,
> which are older than 6 years. Remove resulting dead code.

Nope, that's too aggressive here too. Only the 4.1/4.2 machines
can be removed. The others are all still reported as being valid
machines with '-machine help' - they'll be automatically removed
from that list once their expiry release cycle is started.

> 
> Philippe Mathieu-Daudé (20):
>   hw/arm/virt: Remove deprecated virt-4.1 machine
>   hw/arm/virt: Remove VirtMachineClass::no_ged field
>   hw/arm/virt: Remove deprecated virt-4.2 machine
>   hw/arm/virt: Remove VirtMachineClass::kvm_no_adjvtime field
>   hw/arm/virt: Remove deprecated virt-5.0 machine
>   hw/arm/virt: Remove VirtMachineClass::acpi_expose_flash field
>   hw/arm/virt: Remove deprecated virt-5.1 machine
>   hw/arm/virt: Remove VirtMachineClass::no_kvm_steal_time field
>   hw/arm/virt: Remove deprecated virt-5.2 machine
>   hw/arm/virt: Remove VirtMachineClass::no_secure_gpio field
>   hw/arm/virt: Remove deprecated virt-6.0 machine
>   hw/arm/virt: Remove deprecated virt-6.1 machine
>   hw/arm/virt: Remove VirtMachineClass::no_tcg_its field
>   hw/arm/virt: Remove VirtMachineClass::no_cpu_topology field
>   hw/arm/virt: Remove deprecated virt-6.2 machine
>   hw/arm/virt: Remove VirtMachineClass::no_tcg_lpa2 field
>   hw/arm/virt: Remove deprecated virt-7.0 machine
>   hw/arm/virt: Remove deprecated virt-7.1 machine
>   hw/arm/virt: Remove VirtMachineClass::no_highmem_compact field
>   hw/arm/virt: Remove deprecated virt-7.2 machine
> 
>  include/hw/arm/virt.h    |  11 --
>  hw/arm/virt-acpi-build.c |  37 +------
>  hw/arm/virt.c            | 228 ++++++++-------------------------------
>  3 files changed, 50 insertions(+), 226 deletions(-)
> 
> -- 
> 2.51.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


