Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F54DD3515C
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:50:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7sDZ-0002Ow-Ny; Wed, 01 Apr 2026 05:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1w7sDX-0002OR-Ud
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:50:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1w7sDW-0000iN-Ia
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775037029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lnY8Fl9fvJKH0+qRHMrlzSsu7xGQmttbXjTWYlHlz4E=;
 b=A69e6OOMuz1SD0jjWVqdAE26GjApfFqG7K/BXFw8z7jhW0xT1HNf8c9x7vDaxYwzCMCcOl
 2SQ32qAAfeOEWBo4Xl2t5YRHY05/ApBBLqnGhM1Da19PqRzX+Ryt3d9RE1wERR7MACAiar
 myfiedEBnZOVdmhN7QraflUcCkCiEm8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-giEmTMczNqCkccrj5FBdog-1; Wed,
 01 Apr 2026 05:50:28 -0400
X-MC-Unique: giEmTMczNqCkccrj5FBdog-1
X-Mimecast-MFC-AGG-ID: giEmTMczNqCkccrj5FBdog_1775037027
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A97991800372
 for <qemu-devel@nongnu.org>; Wed,  1 Apr 2026 09:50:27 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.48])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 43DFE1800361; Wed,  1 Apr 2026 09:50:27 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E6FA91800609; Wed, 01 Apr 2026 11:50:24 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 0/3] Firmware 20260401 for 11.0 patches
Date: Wed,  1 Apr 2026 11:50:21 +0200
Message-ID: <20260401095024.1562621-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

The following changes since commit dd3ee9c63d96b223c8d41bf5d65392eb898be626:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-03-30 13:54:56 +0100)

are available in the Git repository at:

  https://gitlab.com/kraxel/qemu.git tags/firmware-20260401-for-11.0-pull-request

for you to fetch changes up to 9b4edc3ecacf2f6ef3f2e7e3d423dfe9e67a781a:

  igvm: fix parent object type in IgvmCfg struct (2026-03-31 08:53:47 +0200)

----------------------------------------------------------------
igvm bugfixes

----------------------------------------------------------------

Luigi Leonardi (3):
  igvm: switch to PRIx64
  igvm: fix memory leak on failed memory region init
  igvm: fix parent object type in IgvmCfg struct

 include/system/igvm-internal.h | 2 +-
 backends/igvm.c                | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.53.0


