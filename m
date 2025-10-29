Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC9C7CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 12:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE4xY-0003Ij-QC; Wed, 29 Oct 2025 08:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vE4xN-0003Bc-8C
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 08:07:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vE4xG-00051a-HE
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 08:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761739619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ob1mZP10conViV2ZR2n8/iCp29dtRS7dycILfLsui8=;
 b=M0gSpFBuOMtEj3IFpIM8nsD3N3P3zBwds9+YZSbmBjgx2QX3J48mEuLAkEhJ/mUB+49P9z
 qm0jK7PtMxFMxHft/wE5M1NLUNxrLl70lTIY1pi6TTo9z+n3s94fugsDADI6yXYmm5Fqrm
 H89cHVSH0uN/Fn2KIH1q/fuG8ezFhEc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-aCVWDLygMh2sgLaFfJXR7g-1; Wed,
 29 Oct 2025 08:06:56 -0400
X-MC-Unique: aCVWDLygMh2sgLaFfJXR7g-1
X-Mimecast-MFC-AGG-ID: aCVWDLygMh2sgLaFfJXR7g_1761739615
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77B3C196F75C; Wed, 29 Oct 2025 12:06:55 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.33.204])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 37100180044F; Wed, 29 Oct 2025 12:06:53 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 09/18] MAINTAINERS: Mark VHDX block driver as "Odd Fixes"
Date: Wed, 29 Oct 2025 13:06:25 +0100
Message-ID: <20251029120634.288467-10-kwolf@redhat.com>
In-Reply-To: <20251029120634.288467-1-kwolf@redhat.com>
References: <20251029120634.288467-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

In 2018 (in commit 5f5246b6b) Jeff Cody stepped down as block
maintainer, but left himself as maintainer for VHDX and with a status
of "Supported", with the rationale:

    For VHDX, added my personal email address as a maintainer, as I can
    answer questions or send the occassional bug fix.  Leaving it as
    'Supported', instead of 'Odd Fixes', because I think the rest of the
    block layer maintainers and developers will upkeep it as well, if
    needed.

However, today the way we treat subsystems which are only maintained
under the general umbrella of a wider system is usually to mark them
as "Odd Fixes".  The vhdx.c code has had no commits which aren't a
part of more general refactoring changes since 2020, and Jeff himself
hasn't been active on qemu-devel since 2018, so this seems also to be
how we've handled the code in practice.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20251002125446.2500179-1-peter.maydell@linaro.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 64491c800c..fd78a563a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4081,7 +4081,7 @@ F: block/rbd.c
 VHDX
 M: Jeff Cody <codyprime@gmail.com>
 L: qemu-block@nongnu.org
-S: Supported
+S: Odd Fixes
 F: block/vhdx*
 
 VDI
-- 
2.51.0


