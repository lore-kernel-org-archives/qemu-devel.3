Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C92CF31B4
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 12:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svyqX-0006dG-33; Wed, 02 Oct 2024 08:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svyqO-0006bf-4d
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 08:52:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svyqL-0003ak-Dx
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 08:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727873556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZiJTSvw5KrzNOT2DaBsL1j7GG0p8znzWVpq2ChB6YkY=;
 b=dQf0VKRduJ//sNitnd4VquI6oHnb5HtuSgnF5N4f1g/lmASTWnbMegkP3DXDKqRZDJGbR6
 tYYo1Jm4eU+LB8JCh38H8l6R0GoxGz/YpYw3gea4UVVJaiXqgxft8rGY2sVKLMgSz5Tcvk
 WbEQQDbj+9q2+BkSgrSHZnCtH5Y2CiU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-XCA23_YxN3eYAYtMmSHh4w-1; Wed,
 02 Oct 2024 08:52:35 -0400
X-MC-Unique: XCA23_YxN3eYAYtMmSHh4w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0FCCA1955EAA; Wed,  2 Oct 2024 12:52:34 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.239])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CE25819560A3; Wed,  2 Oct 2024 12:52:31 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 2/5] configs: Fix typo in the sh4-softmmu devices config file
Date: Wed,  2 Oct 2024 14:52:23 +0200
Message-ID: <20241002125226.282193-3-thuth@redhat.com>
In-Reply-To: <20241002125226.282193-1-thuth@redhat.com>
References: <20241002125226.282193-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is the config file for the little endian target, so there
should not be a "eb" in here.

Message-ID: <20240920161045.84622-1-thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 configs/devices/sh4-softmmu/default.mak | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/devices/sh4-softmmu/default.mak b/configs/devices/sh4-softmmu/default.mak
index aa821e4b60..efb401bfb1 100644
--- a/configs/devices/sh4-softmmu/default.mak
+++ b/configs/devices/sh4-softmmu/default.mak
@@ -1,4 +1,4 @@
-# Default configuration for sh4eb-softmmu
+# Default configuration for sh4-softmmu
 
 # Uncomment the following lines to disable these optional devices:
 #
-- 
2.46.1


