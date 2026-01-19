Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72980CCF2D5
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 10:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhmbR-000897-7t; Mon, 19 Jan 2026 05:35:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vhmbM-000851-PK
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 05:35:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vhmbI-0002Pc-Ib
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 05:35:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768818911;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jVymgvqZdkbToOFIV6TVI6iy5jIDGiBC2ILnfVUA5bI=;
 b=UDSNtNI3Ybi87da3ubDzA5AwhKEiV3z7TxPgmIp+gCjLA0zbl3ao7cy7QtdJhf2fDVbkIU
 qNrLoF9yXVKCkBlpCUpyfCrezaVNf+O+2KJTxxMlIonO25tAh1YNYoMTjfhpMViOemMIBC
 D0hxrgOhbcHAVcjS2DOUUQF0JA6UZ4I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-06DHthiqOi-Wa9T0-ybQ7A-1; Mon,
 19 Jan 2026 05:35:09 -0500
X-MC-Unique: 06DHthiqOi-Wa9T0-ybQ7A-1
X-Mimecast-MFC-AGG-ID: 06DHthiqOi-Wa9T0-ybQ7A_1768818908
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B74018005B2
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 10:35:08 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.53])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65A671800577; Mon, 19 Jan 2026 10:35:07 +0000 (UTC)
Date: Mon, 19 Jan 2026 10:35:03 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 2/5] Clean up header guards that don't match their file
 name
Message-ID: <aW4I1-Ro9R5l2bqK@redhat.com>
References: <20260119100537.463312-1-armbru@redhat.com>
 <20260119100537.463312-3-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260119100537.463312-3-armbru@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.077,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jan 19, 2026 at 11:05:34AM +0100, Markus Armbruster wrote:
> Header guard symbols should match their file name to make guard
> collisions less likely.
> 
> Cleaned up with scripts/clean-header-guards.pl, followed by some
> renaming of new guard symbols picked by the script to better ones.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  accel/accel-internal.h                    | 2 +-
>  accel/tcg/tb-internal.h                   | 4 ++--
>  crypto/tlscredsbox.h                      | 6 +++---
>  hw/i386/tdvf-hob.h                        | 4 ++--
>  hw/riscv/riscv-iommu.h                    | 4 ++--
>  include/exec/page-protection.h            | 5 +++--
>  include/exec/replay-core.h                | 4 ++--
>  include/hw/acpi/ich9_tco.h                | 6 +++---
>  include/hw/audio/virtio-snd.h             | 4 ++--
>  include/hw/core/hw-error.h                | 4 ++--
>  include/hw/core/qdev.h                    | 4 ++--
>  include/hw/core/sysemu-cpu-ops.h          | 6 +++---
>  include/hw/loongarch/virt.h               | 4 ++--
>  include/hw/misc/sifive_e_aon.h            | 4 ++--
>  include/hw/misc/xlnx-versal-cfu.h         | 5 +++--
>  include/hw/net/xlnx-versal-canfd.h        | 4 ++--
>  include/hw/pci-bridge/cxl_upstream_port.h | 7 ++++---
>  include/hw/pci-host/fsl_imx8m_phy.h       | 4 ++--
>  include/hw/ppc/pnv_nest_pervasive.h       | 6 +++---
>  include/hw/ssi/pnv_spi_regs.h             | 4 ++--
>  include/hw/virtio/vdpa-dev.h              | 5 +++--
>  include/io/channel-null.h                 | 4 ++--
>  include/qapi/qmp-registry.h               | 4 ++--
>  include/qemu/target-info-qapi.h           | 4 ++--
>  include/system/cpu-timers-internal.h      | 6 +++---
>  include/system/dirtylimit.h               | 5 +++--
>  include/system/spdm-socket.h              | 4 ++--
>  include/user/tswap-target.h               | 5 +++--
>  target/arm/cpu-features.h                 | 4 ++--
>  target/arm/tcg/mte_helper.h               | 6 +++---
>  target/i386/confidential-guest.h          | 5 +++--
>  target/i386/emulate/x86.h                 | 4 ++--
>  target/i386/emulate/x86_decode.h          | 4 ++--
>  target/i386/emulate/x86_flags.h           | 6 +++---
>  target/sparc/translate.h                  | 5 +++--
>  target/xtensa/core-lx106/core-isa.h       | 7 +++----
>  36 files changed, 88 insertions(+), 81 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


