Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8503D65C7B
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 11:33:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBY6H-0002NZ-0w; Thu, 14 Nov 2024 06:33:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tBY6F-0002NJ-9Z
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 06:33:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tBY6D-000828-Nn
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 06:33:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731583999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DAa6kIvY2dz6toBl8wQ2GnqV4GhMoN8dBZFEX4sP6fk=;
 b=EodiF3V6/3TSPFrYfCiqCSkypHmFvV5wtsy+ZSo3pr1hQvChf74wSRocYPx/mOeoN1hNS3
 2U6GRr7f3D39TZpSZGJJylOVLeDsSsJCYY0uW2DCelTISgF56QroO6Uc4RAQY0j1MX/PJp
 PzNtNYTExC7c6Po6skNz1NIT7IERgEM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133-J_VPWZHdMZCe7BrHwD2pRg-1; Thu,
 14 Nov 2024 06:33:15 -0500
X-MC-Unique: J_VPWZHdMZCe7BrHwD2pRg-1
X-Mimecast-MFC-AGG-ID: J_VPWZHdMZCe7BrHwD2pRg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2983119560AE; Thu, 14 Nov 2024 11:33:13 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.143])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 570BC19560A3; Thu, 14 Nov 2024 11:33:12 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1BF0D18009A1; Thu, 14 Nov 2024 12:33:10 +0100 (CET)
Date: Thu, 14 Nov 2024 12:33:10 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PULL 0/5] Firmware 20241114 patches
Message-ID: <2svr2cmjdyjkbvjkc5jecfpa2xxzea4luuq5ecm7v6i7ubbrf6@7two2tspqqyj>
References: <20241114110101.44322-1-kraxel@redhat.com>
 <ZzXak8gl-IksvLkQ@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZzXak8gl-IksvLkQ@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.738,
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

On Thu, Nov 14, 2024 at 11:10:11AM +0000, Daniel P. Berrangé wrote:
> On Thu, Nov 14, 2024 at 12:00:56PM +0100, Gerd Hoffmann wrote:
> > The following changes since commit f0a5a31c33a8109061c2493e475c8a2f4d022432:
> > 
> >   Update version for v9.2.0-rc0 release (2024-11-13 21:44:45 +0000)
> > 
> > are available in the Git repository at:
> > 
> >   https://gitlab.com/kraxel/qemu.git tags/firmware-20241114-pull-request
> > 
> > for you to fetch changes up to 5916a3b20fdbfbfc2f987f1121e945100c8c3cd2:
> > 
> >   x86/loader: add -shim option (2024-11-14 11:55:39 +0100)
> > 
> > ----------------------------------------------------------------
> > loader: fix efi binary loading via -kernel
> > loader: support secure boot verification with direct kernel boot
> 
> Hard feature freeze was two days ago, so I would have thought
> the new secure boot feature should wait until 10.0 cycle ?

Patches have been posted back in September.  This PR is a bit late
because I was offline in October, and also because I didn't realize we
are in freeze already due to being active mostly in edk2 these days.

So, if an exception is out if question I'll have to wait until 10.0
opens I guess ...

> Their commits say they depend on new OVMF features and we've
> not updated the OVMF binaries in this cycle, so do we even
> have the OVMF feature needed for this to work[1] ?

Nope.  I have a branch ready.  The plan is to submit that once the qemu
changes are accepted.  edk2 is in freeze too, so this will not make the
edk2 2024-11 stable tag.  If all goes well it'll land in 2025-02, which
we should be able to put into qemu 10.0

take care,
  Gerd


