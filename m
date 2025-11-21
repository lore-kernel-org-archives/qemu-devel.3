Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545E0CFC504
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 04:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcvF-000139-0J; Fri, 21 Nov 2025 21:00:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vMbuS-00064J-LE
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:55:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vMbuH-0001MD-9g
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:55:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763772902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=dXGrOMAXZoa+eKLR88nWG975ZQ+DSySMBSm57RK041w=;
 b=al4S+iPhSW01CZyMEE3UKmSVT3Dm0JVJ98X3OL4xHwec+fYlD5VtpTbj2+q1KOOBILcxx+
 lphxXVeyxC4Mut1RD9qvu02oDSxJme9/gj+Iln8pt8QhDxetc2mH6XU2TX7NcxXkuIixvn
 S/zgv3oVRz+d5lnirhH9H1HonpbxgVo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-PcVG4_fpPP6JhhA78XsN9A-1; Fri,
 21 Nov 2025 07:35:59 -0500
X-MC-Unique: PcVG4_fpPP6JhhA78XsN9A-1
X-Mimecast-MFC-AGG-ID: PcVG4_fpPP6JhhA78XsN9A_1763728558
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CFD511956061; Fri, 21 Nov 2025 12:35:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E64B1940E82; Fri, 21 Nov 2025 12:35:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C42EF21E6A27; Fri, 21 Nov 2025 13:35:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, zhenwei.pi@linux.dev, fam@euphon.net,
 xieyongji@bytedance.com
Subject: [PULL 0/1] Lost MAINTAINERS update
Date: Fri, 21 Nov 2025 13:35:53 +0100
Message-ID: <20251121123554.1255093-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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

Zhenwei Pi posted this patch back in May, but it fell through the
cracks somehow.  It is still valid (we talked).

The following changes since commit 5a5b06d2f6f71d7789719b97143fc5b543bec07a:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2025-11-20 08:12:59 +0100)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-maintainers-2025-11-21

for you to fetch changes up to efbcf49ba06221241e3fed07ca4ac79f07b2bbbc:

  MAINTAINERS: update email of zhenwei pi (2025-11-21 13:31:55 +0100)

----------------------------------------------------------------
MAINTAINERS patches for 2025-11-21

----------------------------------------------------------------
Zhenwei Pi (1):
      MAINTAINERS: update email of zhenwei pi

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


