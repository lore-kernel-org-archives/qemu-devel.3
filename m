Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C72CA5FBB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:01:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBoJ0-0000aN-1P; Wed, 30 Sep 2026 03:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ghoffman@redhat.com>)
 id 1xBoIp-0000Zr-Ql
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:00:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ghoffman@redhat.com>)
 id 1xBoIo-0006V6-DF
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790751627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N/jstaymyUw7gArJBIfb3wt7UPvCyIKpH1xc1rOQKqQ=;
 b=ddqqOO41eYb2RNPC/mzjNnql6MUWlEEaCGV8GZSCspTSAQxwzUSS1LzguvU20jQ9Js5/d6
 2VIvpOUXSEqVnT3WwFb55Ga4sooUZ3ISYpWwnnLBy7FxFqnl2hkwdRBUy54TNw0Kqx5na6
 uAOjrbh19eHGKdiHLigdQMOEsVEnd0Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-DmJo4CxnPHyYvaq4IooDHA-1; Wed,
 30 Sep 2026 03:00:20 -0400
X-MC-Unique: DmJo4CxnPHyYvaq4IooDHA-1
X-Mimecast-MFC-AGG-ID: DmJo4CxnPHyYvaq4IooDHA_1790751618
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 53FBD1964CD0; Wed, 30 Sep 2026 07:00:18 +0000 (UTC)
Received: from nucbdw.ghoffman.csb.home.kraxel.org
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B3D161800361; Wed, 30 Sep 2026 07:00:17 +0000 (UTC)
Received: by nucbdw.ghoffman.csb.home.kraxel.org (Postfix, from userid 11758)
 id A64CE40775D0; Wed, 30 Sep 2026 09:00:15 +0200 (CEST)
Date: Wed, 30 Sep 2026 09:00:15 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Weqaar Janjua <weqaar.janjua@packetfive.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, mst@redhat.com, 
 pierrick.bouvier@oss.qualcomm.com, jasowangio@gmail.com, pbonzini@redhat.com,
 farosas@suse.de, lvivier@redhat.com
Subject: Re: [PATCH v3 1/6] pci: Add device ID for CnuasNIC
Message-ID: <aryzYrs58TOoHLDp@nucbdw.ghoffman.csb.home.kraxel.org>
References: <20260929202358.725310-1-weqaar.janjua@packetfive.com>
 <20260929202358.725310-2-weqaar.janjua@packetfive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929202358.725310-2-weqaar.janjua@packetfive.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

On Tue, Sep 29, 2026 at 08:23:52PM +0000, Weqaar Janjua wrote:
> Reserve device ID 0017 for the Cnuas virtual network adapter.

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>


