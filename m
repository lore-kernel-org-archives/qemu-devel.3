Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2823C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 10:32:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1OIS-0007wW-KJ; Mon, 29 Apr 2024 06:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1s1OIO-0007vm-Kv
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 06:31:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1s1OIN-0001Ju-1g
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 06:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714386697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=coTu4c/mDN0xy4qZpUCjoUq9FadfKF2tgUcBQTH8aug=;
 b=Z/NxAATBXyNFUbbBnvehBqVRYxwpP+vZA3WvzcztRGK00s4ELZwFv1ffD6QoaHruVZOOPy
 LomiWuz3BA8wOYljX7UPazYMy8P6veGj+eZb4o8E6qX57HDN0p0bOaiLehhtoFRJLTh6V3
 LclaRkEXRSCHOsLvm8AFH3noCPs6LhA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-2CD7U2H6PTGyZ7FzEVk1Dw-1; Mon, 29 Apr 2024 06:31:33 -0400
X-MC-Unique: 2CD7U2H6PTGyZ7FzEVk1Dw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E9F98059E0;
 Mon, 29 Apr 2024 10:31:33 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BB3991121306;
 Mon, 29 Apr 2024 10:31:31 +0000 (UTC)
Date: Mon, 29 Apr 2024 12:31:30 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Miroslav Rezanina <mrezanin@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH 0/3] Make it possible to compile the x86 binaries without
 FDC
Message-ID: <Zi93AtlPTdjmpgfu@redhat.com>
References: <20240425184315.553329-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425184315.553329-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.114,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

[ Cc: qemu-block ]

Am 25.04.2024 um 20:43 hat Thomas Huth geschrieben:
> For downstream versions of QEMU, we'd like to be able to compile QEMU
> without the FDC code included (since it's not required for modern VMs
> anymore and the FDC code has rather a bad reputation, see the VENOM CVE).
> 
> The q35 machine can already be instantiated without FDC, but for being
> able to link a binary without the FDC code, the Kconfig file needs some
> tweaks and there are two spots in the pc code that directly call functions
> from the FDC code - those need to be disabled via #ifdefs.
> 
> The third patch changes the i440fx and isapc machine types so that
> they can work without the FDC device, too, in case it has not been
> compiled into the binary. It's marked as RFC since I assume that the
> FDC was originally a fix compononent of these motherboards, so I'm
> unsure whether we should allow the disablement there. OTOH, it seems
> to work fine, and the FDC is only disabled when it is not available
> in the binary, so I hope this patch is fine, too.
> 
> Thomas Huth (3):
>   hw/i386/pc: Allow to compile without CONFIG_FDC_ISA
>   hw/i386/Kconfig: Allow to compile Q35 without FDC_ISA
>   hw/i386: Add the possibility to use i440fx and isapc without FDC
> 
>  hw/i386/pc.c      | 13 +++++++++----
>  hw/i386/pc_piix.c |  6 ++++--
>  hw/i386/Kconfig   |  2 +-
>  3 files changed, 14 insertions(+), 7 deletions(-)
> 
> -- 
> 2.44.0
> 
> 


