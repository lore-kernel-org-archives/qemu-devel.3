Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F295C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 10:42:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmtOk-0006Bs-9B; Wed, 20 Mar 2024 06:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rmtOU-00069J-NU
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 06:42:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rmtOT-00073O-92
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 06:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710931320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fVCFmf2BNtBOMMSpQVnk2QxYciZTmyIg2jXiLRDPJ8c=;
 b=I1++FLr/lXaHQh7cuctloasOMcEOz6m4Chw4HwGRc/p56lY8A+DAi8iayXW8ZPZrQbzyhl
 FDxxPPiGX2LS6JH6TbrrwiIvwy89JGR24M1Wz8F8bxcWJIOORxGdYilyRf4HS8yp9VAhXO
 31FPh0d5VEnaHW4bbc1VPbFX9VIctvs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-AmoD8IPvMhu_Boc0sVhasQ-1; Wed,
 20 Mar 2024 06:41:57 -0400
X-MC-Unique: AmoD8IPvMhu_Boc0sVhasQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A5F573CBD507;
 Wed, 20 Mar 2024 10:41:56 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 218452166B34;
 Wed, 20 Mar 2024 10:41:54 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: [PATCH 3/6] Revert ".travis.yml: Cache Avocado cache"
Date: Wed, 20 Mar 2024 11:41:41 +0100
Message-ID: <20240320104144.823425-4-thuth@redhat.com>
In-Reply-To: <20240320104144.823425-1-thuth@redhat.com>
References: <20240320104144.823425-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This reverts commit c1073e44b46490133e16420e1784dec7bcd4e030.

The Avocado tests have been removed from Travis a long time ago with
commit c5008c76ee ("gitlab: add acceptance testing to system builds"),
so we don't need to cache the avocado files here anymore.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .travis.yml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 8a3ae76a7c..8da88c4360 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -12,8 +12,6 @@ cache:
   timeout: 1200
   ccache: true
   pip: true
-  directories:
-  - $HOME/avocado/data/cache
 
 
 # The channel name "irc.oftc.net#qemu" is encrypted against qemu/qemu
-- 
2.44.0


