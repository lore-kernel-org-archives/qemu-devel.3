Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D698ACA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 11:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBVxM-0005Vc-11; Tue, 29 Sep 2026 07:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ghoffman@redhat.com>)
 id 1xBVxC-0005V4-K0
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 07:24:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ghoffman@redhat.com>)
 id 1xBVxA-0004Aj-Sl
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 07:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790681094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QhJf/XwsRN8T1T1AxbjEQa0henYFxevEzP+mDeyDSKo=;
 b=OfgaUqSAKZ0mI9QprU5CkZwRwMzsg1XwJv5XXjl/zWUOA5QZ2Q7JjoM9GtT/zwgim8ECgG
 U5L4pdTM4vAIugc8qFIs+bwNBeCWncNII+qiWXpZ9XJ4I7szuIT3x4oLbj5wpYVLQcpIrf
 L1DKfAmEsUtMC+USDOAxAMsiCuakTZc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-28-Rz5kVb-yMBuWZkTXMRvITw-1; Tue,
 29 Sep 2026 07:24:51 -0400
X-MC-Unique: Rz5kVb-yMBuWZkTXMRvITw-1
X-Mimecast-MFC-AGG-ID: Rz5kVb-yMBuWZkTXMRvITw_1790681090
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F6A51945CB3; Tue, 29 Sep 2026 11:24:49 +0000 (UTC)
Received: from nucbdw.ghoffman.csb.home.kraxel.org
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C94F71956095; Tue, 29 Sep 2026 11:24:48 +0000 (UTC)
Received: by nucbdw.ghoffman.csb.home.kraxel.org (Postfix, from userid 11758)
 id D0077413A854; Tue, 29 Sep 2026 13:24:46 +0200 (CEST)
Date: Tue, 29 Sep 2026 13:24:46 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Weqaar Janjua <weqaar.janjua@packetfive.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, 
 pierrick.bouvier@oss.qualcomm.com, jasowangio@gmail.com, pbonzini@redhat.com,
 farosas@suse.de, lvivier@redhat.com
Subject: Re: [PATCH v2 1/6] pci: Add device ID for CnuasNIC
Message-ID: <arufcG2LDc_hYdx5@nucbdw.ghoffman.csb.home.kraxel.org>
References: <20260922223045.190062-1-weqaar.janjua@packetfive.com>
 <20260922223045.190062-2-weqaar.janjua@packetfive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922223045.190062-2-weqaar.janjua@packetfive.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ghoffman@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Sep 22, 2026 at 10:30:40PM +0000, Weqaar Janjua wrote:
> Reserve device ID 0015 for the Cnuas virtual network adapter.

There is a patch in flight allocating 15 + 16 for an generic pcie switch
(https://lore.kernel.org/all/20260928152431.310363-2-david.vrabel@nutanix.com/),
so I'd suggest to take 17 (and 18 in the other patch for the other
device).

Otherwise looks good to me.

take care,
  Gerd


