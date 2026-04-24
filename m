Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D496FE51EE
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 09:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGCYo-0001nm-CP; Fri, 24 Apr 2026 05:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wGCYW-0001dD-G3
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 05:10:40 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wGCYU-0001G4-Qa
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 05:10:36 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2C2CB43796;
 Fri, 24 Apr 2026 09:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2337BC19425;
 Fri, 24 Apr 2026 09:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777021833;
 bh=lG4yTxj4efr0GH6gcaXlfFaYibj1BOVRs7iSfyuetSg=;
 h=From:To:Cc:Subject:Date:From;
 b=qRKypkklxwtHi9N/6VQKbYbfCT+v/XwOQ3ueXaJolAMKg6B65Cm2DhSPKdKiEFVNL
 GMlk62Wh0LQaaYXd2/A+ijEp2dhCJMjk9Lyggh1eI2lJ3w3ESucNuMoeNXUCSgrvH9
 +FnDlaSu3jYpKa/OaeKXlmW06DO/mySYMjvOxkp3V9ykJHGXPvKwqNlXeAWq42bWN8
 iqYhZlPkwwJe17Q7DWC7GkKMLpZUPu6qvyWy6ll9D94xlwKG1mqvIus9JnzbfWptIJ
 8abEktp+Rj93VpMylOYhxW8IaO38/ccvy82zregwTyCMpoc2xP9so75t84xI5zNDB5
 OewJEfQ6/b4Qg==
From: Helge Deller <deller@kernel.org>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: linux-user: Add sockopts for SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW
Date: Fri, 24 Apr 2026 11:08:46 +0200
Message-ID: <20260424091024.23495-1-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series should fix
https://gitlab.com/qemu-project/qemu/-/work_items/885

Please review.

