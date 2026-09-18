Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1078DC982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 13:43:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7YrX-0002N2-Ox; Fri, 18 Sep 2026 09:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ghoffman@redhat.com>)
 id 1x7YrU-0002MS-S7
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:42:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ghoffman@redhat.com>)
 id 1x7YrT-0002er-4y
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:42:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789738962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cless3V8cqGG6MPYZ6NXWdEsjd7njdCUrX8D72Dy1wc=;
 b=BvRwMeNx38wquNKxfvDLzWCr7pbnjMEy6mGyTg0K5VRBs1CU4NJ4VWNOBB2kjX9lU2aez4
 rVKQ8LmUTyL/NB33ND11Uwd5SbL+6BP0YUSDQ3bOmWHnG8TAFhlxQtnNUOoXtNkLMZVQWk
 tGU0d/5R5QN/HMmYBqThUgvPcZ+v3sg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-B_nrUypFN-mToIxmNiAJSQ-1; Fri,
 18 Sep 2026 09:42:34 -0400
X-MC-Unique: B_nrUypFN-mToIxmNiAJSQ-1
X-Mimecast-MFC-AGG-ID: B_nrUypFN-mToIxmNiAJSQ_1789738954
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 34D8F1935DF7; Fri, 18 Sep 2026 13:42:33 +0000 (UTC)
Received: from nucbdw.ghoffman.csb.home.kraxel.org
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D65C540E; Fri, 18 Sep 2026 13:42:32 +0000 (UTC)
Received: by nucbdw.ghoffman.csb.home.kraxel.org (Postfix, from userid 11758)
 id AA87F407754F; Fri, 18 Sep 2026 15:42:30 +0200 (CEST)
Date: Fri, 18 Sep 2026 15:42:30 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Weqaar Janjua <weqaar.janjua@packetfive.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 1/2] pci: Add device ID for CnuasNIC RDMA network adapter
Message-ID: <aq071ObdOPcgr0uF@nucbdw.ghoffman.csb.home.kraxel.org>
References: <20260917180831.3142920-1-weqaar.janjua@packetfive.com>
 <20260917180831.3142920-2-weqaar.janjua@packetfive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917180831.3142920-2-weqaar.janjua@packetfive.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ghoffman@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Sep 17, 2026 at 06:08:28PM +0000, Weqaar Janjua wrote:
> PCI device ID under QEMU vendor ID 0x1b36, device ID 0x0015
> 
> Request is for the CnuasNIC non-virtio QEMU device model of the Cnuas project.
> 
> CnuasNIC (QEMU device name: cnuas-vnic) is a software-emulated RDMA NIC supporting RoCEv2 and native InfiniBand, with guest Linux network and RDMA drivers and a standard verbs provider.
> 
> Datasheet: https://cnuas.io/cnuas/docs/datasheets/CnuasNIC_Datasheet/
> 
> The allocation is requested in preparation for public release and upstream submission.

Ok.  Update to documentation and header file looks good.

Ideally this update should be submitted together with the upstream
submission of the device emulation code.  Sending it beforehand (to
avoid the IDs changing while the code is under review) is possible
too, but please include a link to the repository with the code then.

> Cnuas is an experimental rack-scale AI/HPC emulation platform for functional experimentation in academic and industrial research and development. Its architecture and device interfaces are described in the public arXiv preprint paper:
> 
> Cnuas: A Software-Defined AI/HPC Rack-scale Emulation Platform and Hyperscale Data Center Facility Twin
> https://doi.org/10.48550/arXiv.2609.15889
> 
> Website: https://cnuas.io

This is the device added by patch 2/2, right?  So this should go only to
the other commit message.

take care,
  Gerd


