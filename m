Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08EBFC021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 09:22:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tna5y-0002dV-QJ; Thu, 27 Feb 2025 04:22:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tna5w-0002Wa-HH
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 04:22:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tna5t-0006sW-Fo
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 04:22:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740648131;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PJZO4qyXBe3WFpfdSMpRGls6plQkOeA2pNCd1r3/Vu8=;
 b=H+MA8Yi4qDzoHMG6TcRBBlZ66kB8hKDvamJrIVD0CJ+Uzjda5uD7XR+QYqTDfoaN2GJrAr
 C6oelB/ZauqOtBC63X8oE7eytVczN0Z5MxeTSs3ZuGFkjoiqxgr/pe2ONr/Onff4N17qom
 vK0TGc6J/XgGX4rbE92mBC7rgZhIkHY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-eAzS_Wy0Mx2aShAyHdcD3w-1; Thu,
 27 Feb 2025 04:22:06 -0500
X-MC-Unique: eAzS_Wy0Mx2aShAyHdcD3w-1
X-Mimecast-MFC-AGG-ID: eAzS_Wy0Mx2aShAyHdcD3w_1740648125
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 433001800984; Thu, 27 Feb 2025 09:22:05 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.99])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A1711800358; Thu, 27 Feb 2025 09:22:01 +0000 (UTC)
Date: Thu, 27 Feb 2025 09:21:55 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, eduardo@habkost.net
Subject: Re: [PATCH v2 3/6] qdev: Rename PropertyInfo member @name to @type
Message-ID: <Z8Aus6YaBIMrePzi@redhat.com>
References: <20250227085601.4140852-1-armbru@redhat.com>
 <20250227085601.4140852-4-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250227085601.4140852-4-armbru@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
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

On Thu, Feb 27, 2025 at 09:55:58AM +0100, Markus Armbruster wrote:
> PropertyInfo member @name becomes ObjectProperty member @type, while
> Property member @name becomes ObjectProperty member @name.  Rename the
> former.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/hw/qdev-properties.h     |  2 +-
>  backends/tpm/tpm_util.c          |  2 +-
>  hw/block/xen-block.c             |  2 +-
>  hw/core/qdev-properties-system.c | 50 ++++++++++++++++----------------
>  hw/core/qdev-properties.c        | 36 +++++++++++------------
>  hw/misc/xlnx-versal-trng.c       |  2 +-
>  hw/nvme/nguid.c                  |  2 +-
>  hw/nvram/xlnx-bbram.c            |  2 +-
>  hw/nvram/xlnx-efuse.c            |  2 +-
>  hw/pci/pci.c                     |  2 +-
>  hw/s390x/ccw-device.c            |  2 +-
>  hw/s390x/css.c                   |  4 +--
>  hw/s390x/s390-pci-bus.c          |  2 +-
>  hw/vfio/pci-quirks.c             |  2 +-
>  target/riscv/cpu.c               | 28 +++++++++---------
>  target/sparc/cpu.c               |  2 +-
>  hw/display/apple-gfx.m           |  2 +-
>  17 files changed, 72 insertions(+), 72 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


