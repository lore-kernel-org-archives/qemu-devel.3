Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE838C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 08:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEPZs-0006No-Uv; Tue, 04 Jun 2024 04:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1sEPZh-0006Hl-AM
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 04:31:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1sEPZe-0001z8-Rv
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 04:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717489877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WT8HZchqd4jmOTeFJ01MQqLaw3ZiES2eoNiqjfMO8I0=;
 b=CFMDZER1jOPXHGU5W7med6Dq9KM3g3zHuevQGUDfkD9MlmHAMu70jJ6ZVSo0M1DSVa4pfD
 4N/mntmCkE26SnPmnNZzJOvP+zLbUI2tVtvkVjomU1dYiboZzsYjSz7CFwTu/Nn2GeOUdP
 2lzd/ZFMNyyy3GwbYzbMjMD/sZtrZWI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-Vsdb2mSOP9KDnTpdqQY3eA-1; Tue, 04 Jun 2024 04:31:08 -0400
X-MC-Unique: Vsdb2mSOP9KDnTpdqQY3eA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8652B811E8D
 for <qemu-devel@nongnu.org>; Tue,  4 Jun 2024 08:31:08 +0000 (UTC)
Received: from localhost (dhcp-192-239.str.redhat.com [10.33.192.239])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D670112C06B;
 Tue,  4 Jun 2024 08:31:08 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com
Subject: Re: [PATCH 0/4] update-linux-headers: prepare for updating to 6.9+
 and for SNP patches
In-Reply-To: <20240603131141.834241-1-pbonzini@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20240603131141.834241-1-pbonzini@redhat.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Tue, 04 Jun 2024 10:31:07 +0200
Message-ID: <87y17lkt2s.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Jun 03 2024, Paolo Bonzini <pbonzini@redhat.com> wrote:

> This series contains a few cleanups and fixes to update-linux-headers.sh,
> which I needed or found in order to pass CI for the SEV-SNP patches.
>
> First, updating linux-headers/ fails due to the lack of
> arch/loongarch/include/uapi/asm/bitsperlong.h.  I am not sure if I am
> doing something wrong but it is caused by commit 3efc75ad9d9
> ("scripts/update-linux-headers.sh: Remove temporary directory inbetween",
> 2024-05-29); if so, I guess I'm 1-1 with Thomas given my own bug in
> commit 66210a1a30 that he fixed.
>
> Before commit 3efc75ad9d9, the missing file would incorrectly cause stale
> files to be included in linux-headers/.  The files were never committed
> to qemu.git, but were wrong nevertheless. The build would just use
> the system version of the files, which is opposite to the idea of
> importing Linux header files into QEMU's tree.
>
> Second, pvpanic.h was incorrectly included in a slightly different
> path than what is used in Linux.
>
> Third, SNP host-side patches will need linux/kvm_para.h, because some
> of the supported distros do not have a definition for KVM_HC_MAP_GPA_RANGE.
> Including it is a bit complicated because we also have a version of
> x86's kvm_para.h under include/standard-headers/; linux/kvm_para.h
> tries to include <asm/kvm_para.h> and that could cause conflicts.
> So, the linux/kvm_para.h is also placed in include/standard-headers
> (patch 4).
>
> Pankaj Gupta (1):
>   linux-headers: Update to current kvm/next
>
> Paolo Bonzini (3):
>   update-linux-headers: fix forwarding to asm-generic headers
>   update-linux-headers: move pvpanic.h to correct directory
>   update-linux-headers: import linux/kvm_para.h header
>
>  include/standard-headers/linux/kvm_para.h     | 38 ++++++++++++++
>  .../{linux => misc}/pvpanic.h                 |  0
>  linux-headers/asm-loongarch/kvm.h             |  4 ++
>  linux-headers/asm-riscv/kvm.h                 |  1 +
>  linux-headers/asm-x86/kvm.h                   | 52 ++++++++++++++++++-
>  linux-headers/asm-x86/kvm_para.h              |  1 +
>  linux-headers/linux/kvm_para.h                |  2 +
>  linux-headers/linux/vhost.h                   | 15 +++---
>  hw/misc/pvpanic-isa.c                         |  2 +-
>  hw/misc/pvpanic-pci.c                         |  2 +-
>  hw/misc/pvpanic.c                             |  2 +-
>  scripts/update-linux-headers.sh               | 37 +++++++++++--
>  12 files changed, 141 insertions(+), 15 deletions(-)
>  create mode 100644 include/standard-headers/linux/kvm_para.h
>  rename include/standard-headers/{linux => misc}/pvpanic.h (100%)
>  create mode 100644 linux-headers/asm-x86/kvm_para.h
>  create mode 100644 linux-headers/linux/kvm_para.h

With the hash added to the headers update,

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

for the series.


