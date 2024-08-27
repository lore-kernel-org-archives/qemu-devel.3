Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D274C54734
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 10:36:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sitYF-00059N-9n; Tue, 27 Aug 2024 06:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sitY8-0004yq-T0
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 06:35:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sitY7-0004Yo-6Q
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 06:35:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724754942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=P0+/Wqdzz+qE+8BCY5yvExQ+s+0h5/YE/eZxJawqeSM=;
 b=XgLKWnIRIMr8quz2eThFZ4vPQ3fE1O0ct+rKtKQ2vjS9kK/CYXQbR+ISYk3X2cQeDXYo4N
 RM5I2qcmukcySrZr0f95HSX9iEMgbl/Gu9fkgU22i2GPDZSTmiop/McHEOJQcSpy3rU5tn
 5tHhuGtcYDJnBfUejKnTptFuknhgaE8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-d58ONpxvN3CUEclOsH18Mg-1; Tue,
 27 Aug 2024 06:35:37 -0400
X-MC-Unique: d58ONpxvN3CUEclOsH18Mg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C77019560B1; Tue, 27 Aug 2024 10:35:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0BAFF1956056; Tue, 27 Aug 2024 10:35:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C486F21E6A28; Tue, 27 Aug 2024 12:35:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL 0/1] QAPI patches patches for 2024-08-27
Date: Tue, 27 Aug 2024 12:35:31 +0200
Message-ID: <20240827103532.799039-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

I'm nominating this fix for v9.1 because it can only affect generated
documentation, and CI should protect us from surprise build breaks.
Feel free to delay it to v9.2 if you think even that is too much risk
or simply too much trouble to be worthwhile.

The following changes since commit afaee42f777bc359db95f692804f7fc7e12c0c02:

  Merge tag 'pull-nbd-2024-08-26' of https://repo.or.cz/qemu/ericb into staging (2024-08-27 07:06:42 +1000)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2024-08-27

for you to fetch changes up to 43e0d14ee09a0565adcf4ce5f35be79695958fb0:

  docs/sphinx: fix extra stuff in TOC after freeform QMP sections (2024-08-27 11:10:58 +0200)

----------------------------------------------------------------
QAPI patches patches for 2024-08-27

----------------------------------------------------------------
John Snow (1):
      docs/sphinx: fix extra stuff in TOC after freeform QMP sections

 docs/sphinx/qapidoc.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

-- 
2.46.0


