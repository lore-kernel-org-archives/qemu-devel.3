Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D016AC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 08:10:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYhQT-0004zx-AD; Fri, 17 Jan 2025 03:09:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tYhQI-0004zH-AQ
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 03:09:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tYhQG-0007Zi-Jg
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 03:09:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737101380;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=flSp3jdiRGCNWWEc/nCcQVcW5UmRm2tKQCoo+DVSnvQ=;
 b=WbvJj37KcwIfKrs12C6OrMecgKeQkXpspsSf5D+5ytKrjsq5DdRHNrcQU0wDhP9gdJB87E
 LBtkf6s4IzvluRmGFnuh7KNeFAPZ2gZUa0jx59vefjeVqHDLvepIOIdF/pTAcmgL73a7o3
 eBl0plXRpmIxiRgxRHs1MsFnvWiXCqM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-sQ1xIMJHM56wMNp2C2WMPA-1; Fri,
 17 Jan 2025 03:09:36 -0500
X-MC-Unique: sQ1xIMJHM56wMNp2C2WMPA-1
X-Mimecast-MFC-AGG-ID: sQ1xIMJHM56wMNp2C2WMPA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3BF981956080; Fri, 17 Jan 2025 08:09:30 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.60])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F5591955F10; Fri, 17 Jan 2025 08:09:26 +0000 (UTC)
Date: Fri, 17 Jan 2025 08:09:23 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-arm@nongnu.org
Subject: Re: [PATCH-for-10.1 v2 00/13] hw/arm: Remove virt-2.6 up to
 virt-2.12 machines
Message-ID: <Z4oP9YEBc-opiL4K@redhat.com>
References: <20250116145944.38028-1-philmd@linaro.org>
 <823a0892-e9d9-4d26-b862-83ffd60c2ad1@linaro.org>
 <d9f97b63-dbfc-4322-b7a1-8759d6be5cd7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9f97b63-dbfc-4322-b7a1-8759d6be5cd7@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jan 17, 2025 at 07:47:15AM +0100, Thomas Huth wrote:
> On 16/01/2025 22.13, Philippe Mathieu-Daudé wrote:
> > Hi Peter,
> > 
> > On 16/1/25 15:59, Philippe Mathieu-Daudé wrote:
> > > The versioned 'virt' machines up to 2.12 been marked as deprecated
> > > two releases ago, and are older than 6 years, so according to our
> > > support policy we can remove them. Remove associated dead code.
> > 
> > > Philippe Mathieu-Daudé (13):
> > >    hw/arm/virt: Remove deprecated virt-2.6 machine
> > >    hw/arm/virt: Remove VirtMachineClass::no_pmu field
> > >    hw/arm/virt: Remove VirtMachineClass::disallow_affinity_adjustment
> > >    hw/arm/virt: Remove deprecated virt-2.7 machine
> > >    hw/arm/virt: Remove VirtMachineClass::no_its field
> > >    hw/arm/virt: Remove deprecated virt-2.8 machine
> > >    hw/arm/virt: Remove VirtMachineClass::claim_edge_triggered_timers
> > >      field
> > >    hw/arm/virt: Remove deprecated virt-2.9 machine
> > >    hw/arm/virt: Remove deprecated virt-2.10 machine
> > >    hw/arm/virt: Remove deprecated virt-2.11 machine
> > >    hw/arm/virt: Remove VirtMachineClass::smbios_old_sys_ver field
> > >    hw/arm/virt: Remove deprecated virt-2.12 machine
> > >    hw/arm/virt: Remove VirtMachineClass::no_highmem_ecam field
> > 
> > Please ignore this (reviewed) series for now. I'll rebase it and
> > repost after the 10.0 release.
> 
> Why? IMHO it should be ok to include them now already. While Daniel's macro
> only starts the automatic disablement for 10.1, it should be ok to remove
> them now already according to our normal deprecation policy: The machines
> have been marked as deprecated in the 9.1 release already (via commit
> https://gitlab.com/qemu-project/qemu/-/commit/ce80c4fa6ff ), and thus they
> have been deprecated since two releases already. So it should be fine to
> remove them now, shouldn't it?

No, because as of 9.1.0 we documented that machine types are under the
new policy, and these were only deprecated in 9.1.0, hence the new policy
applies to them.
 
With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


