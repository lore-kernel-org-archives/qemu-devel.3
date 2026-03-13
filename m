Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D7F105F79C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 11:35:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w10n7-00062R-Gh; Fri, 13 Mar 2026 07:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w10n5-00060w-4w
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 07:34:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w10n3-0003Ub-NG
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 07:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773401687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y2uRxOq/G5RYSACxuH5R+7MLnjV0nEVpdjKFucogYMU=;
 b=AH8Mipec+70HSuYVAVteyOH0hJsX2Y2YZT1UltXwcX5nb7SfTtG1C550qaNmWwm77o9Hs0
 rygXc75WR64H2eXxfQZgT/Dshv3ZJzACqHCyH8N3kRxpYI/y7aCl3GRYBdUVv3uTUqaAyK
 7BAtdSwntSzs9QCsXx7nRmoZdMqC3g8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-Kol7_67cMGa2abZNCHyXNg-1; Fri,
 13 Mar 2026 07:34:44 -0400
X-MC-Unique: Kol7_67cMGa2abZNCHyXNg-1
X-Mimecast-MFC-AGG-ID: Kol7_67cMGa2abZNCHyXNg_1773401683
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B10C1977696; Fri, 13 Mar 2026 11:34:43 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.225.234])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0839119560B7; Fri, 13 Mar 2026 11:34:39 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-s390x@nongnu.org
Subject: [PATCH 3/4] MAINTAINERS: Remove myself from various sections
Date: Fri, 13 Mar 2026 12:34:21 +0100
Message-ID: <20260313113424.15583-4-thuth@redhat.com>
In-Reply-To: <20260313113424.15583-1-thuth@redhat.com>
References: <20260313113424.15583-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

From: Thomas Huth <thuth@redhat.com>

I likely won't have much time in the future for QEMU anymore, so
remove myself from various sections that have already enough other
maintainers / reviewers.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9a859e4133a..1c7dfab39d3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -67,7 +67,6 @@ F: */
 Project policy and developer guides
 R: Alex Bennée <alex.bennee@linaro.org>
 R: Daniel P. Berrangé <berrange@redhat.com>
-R: Thomas Huth <thuth@redhat.com>
 R: Markus Armbruster <armbru@redhat.com>
 R: Philippe Mathieu-Daudé <philmd@linaro.org>
 W: https://www.qemu.org/docs/master/devel/index.html
@@ -4489,7 +4488,6 @@ Build and test automation, general continuous integration
 M: Alex Bennée <alex.bennee@linaro.org>
 T: git https://gitlab.com/stsquad/qemu testing/next
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
-M: Thomas Huth <thuth@redhat.com>
 S: Maintained
 F: .github/workflows/lockdown.yml
 F: .gitlab-ci.yml
@@ -4586,7 +4584,6 @@ F: scripts/symlink-install-tree.py
 Top Level Makefile and configure
 M: Paolo Bonzini <pbonzini@redhat.com>
 R: Alex Bennée <alex.bennee@linaro.org>
-R: Thomas Huth <thuth@redhat.com>
 S: Maintained
 F: Makefile
 F: configure
-- 
2.53.0


