Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90FBE7316F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 13:23:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmtsy-0002og-S2; Mon, 02 Feb 2026 08:22:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vmtsu-0002mf-QX
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:22:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vmtss-0008On-PH
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:22:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770038549;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pLUPhQlXmPpps65dt3t5XQhfRLXskdsELvV8I8fMCAQ=;
 b=ivVMVYiiqg7RzmWXXMRZYXtjzZqIY/SI/svLpsQ8HgUz09Gi5ox2zt/V75KIpnpLJf80pt
 BFBluZdUcM9n8Hg3CIRkbAaAHBSrsGzbj+pDHInA5q9O+ipM4z5n+bOhGLMYHKS9AVefpH
 CIoj/V5N/XS+dAcxLWMHxe2VFg3pXwg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-YpxtBxibOdC6R7Tcbzs6Cw-1; Mon,
 02 Feb 2026 08:22:26 -0500
X-MC-Unique: YpxtBxibOdC6R7Tcbzs6Cw-1
X-Mimecast-MFC-AGG-ID: YpxtBxibOdC6R7Tcbzs6Cw_1770038544
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9647F180060D; Mon,  2 Feb 2026 13:22:24 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.68])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA4781800285; Mon,  2 Feb 2026 13:22:20 +0000 (UTC)
Date: Mon, 2 Feb 2026 13:22:16 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, jpcottin@google.com,
 Markus Armbruster <armbru@redhat.com>, Roman Kiryanov <rkir@google.com>,
 Will Hollins <whollins@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, jansene@google.com,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 1/2] bulk: Stop forward-declaring enum typedefs
Message-ID: <aYClCOwYfr1xXRTM@redhat.com>
References: <20260130211746.46667-1-philmd@linaro.org>
 <20260130211746.46667-2-philmd@linaro.org>
 <87ms1rpdnw.fsf@draig.linaro.org>
 <7bfa5966-b7cd-4af4-b979-ea973a30195a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7bfa5966-b7cd-4af4-b979-ea973a30195a@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Mon, Feb 02, 2026 at 01:05:33PM +0100, Philippe Mathieu-Daudé wrote:
> On 2/2/26 12:50, Alex Bennée wrote:
> > Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> > 
> > > The C99 standard chapter §6.7.2.2 point 4 mentions:
> > > 
> > >    Each enumerated type shall be compatible with char, a signed
> > >    integer type, or an unsigned integer type. The choice of type
> > >    is implementation-defined, but shall be capable of representing
> > >    the values of all the members of the enumeration.
> > > 
> > > Align with that recommendation by defining the typedef
> > > along with the enum.
> > > 
> > > For information, building with -Werror=pedantic was reporting:
> > > 
> > >    In file included from ../../ui/kbd-state.c:10:
> > >    include/ui/kbd-state.h:12:14: error: ISO C forbids forward references to 'enum' types [-Werror,-Wpedantic]
> > >       12 | typedef enum QKbdModifier QKbdModifier;
> > >          |              ^
> > >    ...
> > > 
> > > Reported-by: Roman Kiryanov <rkir@google.com>
> > > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> > > ---
> > >   hw/riscv/riscv-iommu-bits.h          |  4 ++--
> > >   hw/riscv/riscv-iommu.h               |  2 --
> > >   include/hw/misc/auxbus.h             | 11 ++++-------
> > >   include/hw/pci/pci_device.h          |  5 ++---
> > >   include/hw/ssi/ssi.h                 |  6 ++----
> > >   include/hw/xen/interface/io/xenbus.h |  5 ++---
> > >   include/io/channel.h                 | 11 ++++-------
> > >   include/system/replay.h              | 10 ++++------
> > >   include/ui/clipboard.h               | 15 ++++++---------
> > >   include/ui/kbd-state.h               |  6 ++----
> > >   pc-bios/s390-ccw/virtio.h            |  5 ++---
> > >   tests/qtest/libqos/qgraph_internal.h | 10 ++++------
> > >   hw/core/loader.c                     |  5 ++---
> > >   hw/display/xlnx_dp.c                 | 11 ++++-------
> > >   hw/dma/xlnx_dpdma.c                  | 10 ++++------
> > >   qapi/opts-visitor.c                  |  7 ++-----
> > >   qapi/string-output-visitor.c         |  6 ++----
> > >   tests/unit/check-qom-proplist.c      |  6 ++----
> > >   18 files changed, 50 insertions(+), 85 deletions(-)
> > > 
> > > diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
> > > index 47fe01bee58..281afa7bc3f 100644
> > > --- a/hw/riscv/riscv-iommu-bits.h
> > > +++ b/hw/riscv/riscv-iommu-bits.h
> > > @@ -96,11 +96,11 @@ struct riscv_iommu_pq_record {
> > >   #define RISCV_IOMMU_CAP_PD17            BIT_ULL(39)
> > >   #define RISCV_IOMMU_CAP_PD20            BIT_ULL(40)
> > > -enum riscv_iommu_igs_modes {
> > > +typedef enum riscv_iommu_igs_modes {
> > >       RISCV_IOMMU_CAP_IGS_MSI = 0,
> > >       RISCV_IOMMU_CAP_IGS_WSI,
> > >       RISCV_IOMMU_CAP_IGS_BOTH
> > > -};
> > > +} riscv_iommu_igs_mode;
> > 
> > mode vs modes.
> 
> Pre-existing...
> 
> > It seems very clumsy to have the type at the front and
> > back of the declaration. The only real reason to have the tag ahead of
> > the struct/enum was if there are references in the structure.
> > 
> > IOW this does feel like a lot of churn.
> 
> Well I got it clear old-school maintainers are very reluctant

This kind of personally directed language is unhelpful.

> to open the project to more contributors, even if changes
> required are only cosmetics, and less invasive than Rust ones.

The project as a whole has debated C++ multiple times over the years, and
there were of course different opinions. Eventually the consensus for making
QEMU sustainable & interesting to new contributors over the long term was
to focus on Rust.

Consensus does not imply unanimous, so there are doubtless still people,
(whether upstream or dealing with forks) whom have a preference for C++.
Given the decision to focus on Rust, however, work that facilitates or
encourages use C++ at is sending people down a dead end path, and is a
distraction for upstream reviewers/maintainers. It may look like an
"quick win" but IMHO it is unhelpful (perhaps even harmful) over the
longer time.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


