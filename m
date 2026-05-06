Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEF8CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 10:55:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKZti-0006II-Bm; Wed, 06 May 2026 06:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKZtg-0006GK-3A
 for qemu-devel@nongnu.org; Wed, 06 May 2026 06:54:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKZtd-0001to-GH
 for qemu-devel@nongnu.org; Wed, 06 May 2026 06:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778064868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=WiijPnvQY8jptCr0FVsLzmUx4GGJ1gYDv05Jm347/1c=;
 b=B60qqhwSaX4Lb9XufiOxXZyZK+0vNEQUXgrIxWgHO+HZPLS3fomOtuI/i9ebXsMa2Cad9w
 ZdI7lFKC17RZ7y7QGN5p6rtl1HypT5yLMktHaba4OUBCgHU8ZuBfxjEGUGgfzaJrUfWT6T
 y4RJhyaRNRlfMh57ToOEiPrMFQqDlnc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-KJUQ90jENIC1xc-Br7__6g-1; Wed,
 06 May 2026 06:54:25 -0400
X-MC-Unique: KJUQ90jENIC1xc-Br7__6g-1
X-Mimecast-MFC-AGG-ID: KJUQ90jENIC1xc-Br7__6g_1778064864
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 681BD18005B9; Wed,  6 May 2026 10:54:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC56B18004A3; Wed,  6 May 2026 10:54:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 67D0A21E6A01; Wed, 06 May 2026 12:54:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, lvivier@redhat.com, sbrivio@redhat.com,
 samuel.thibault@ens-lyon.org, marcandre.lureau@redhat.com
Subject: [PATCH 0/4] qapi/net: Some doc improvement and cleanup
Date: Wed,  6 May 2026 12:54:17 +0200
Message-ID: <20260506105421.2461117-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This series replaces useless documentation by hopefully useful one.
I'm not familiar with this stuff, though.  Please review critically.

Markus Armbruster (4):
  qapi/net: Rename NetDevPasstOptions to NetdevPasstOptions
  qapi/net: Wean passt off QAPI type String to improve documentation
  qapi/net: Wean SLIRP off QAPI type String to improve documentation
  qapi/net: Drop unused type String

 qapi/net.json | 96 ++++++++++++++++++++++++++++++++++++++++++++-------
 net/passt.c   | 10 +++---
 net/slirp.c   | 27 +++++++++++----
 3 files changed, 109 insertions(+), 24 deletions(-)

-- 
2.54.0


