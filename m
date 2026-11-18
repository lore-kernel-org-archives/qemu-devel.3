Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3329606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm2 header.b=EV+Aox53;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=0K3ISFk/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTf2o-0007Cc-5L; Wed, 18 Nov 2026 07:45:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xTf2m-0007CK-Mx
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:45:44 -0500
Received: from fhigh-b8-smtp.messagingengine.com ([202.12.124.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xTf2k-0000jV-LM
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:45:44 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 6E6387A02A3
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 07:45:39 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Wed, 18 Nov 2026 07:45:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm2; t=1795005939; x=
 1795092339; bh=CjNpnbAcZNitqwRJ4RDKRsFmaFforIWG2BLSSHQgHtQ=; b=E
 V+Aox53zttADtE+mgf2zNfS9LVMcsXcXixxAfOB/0eL4yl43oR7xcRvcQeK4yKwX
 35tCGdhgGagep8NZcLI0iRVdshh68n1epuEdBKJEib2TCHcdHq5uY6quLBI3d+E+
 SGZ4zLEOmmNyMpLQVtfrXwHPNqvwI4kUYLLn/xdqXfQrtw7hFdLTSA8IGEdDp0ua
 YOpNcbRpTVtheL7xKtre6yBwhvDENdkX5URjBBXX5v7IQv/pVTZAdI52oPTVZftX
 yKtQx9/9zquILIlZSXCKhxw6Eq5ObotlGAfRicv52lsF8Uzww8Kbt1jvK1ZlHo+g
 2q4PJPoB/Vsng9skspevA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1795005939; x=1795092339; bh=CjNpnbAcZNitqwRJ4RDKRsFmaFfo
 rIWG2BLSSHQgHtQ=; b=0K3ISFk/Eqsvxj/HQ0bOPkO9XX6/nb4M/EKsmVjm2KRs
 3bwnx22TbY82FWVsk81Icw7sBXwujJHGzOEqgN4KjNer5zL4HamCc0GWGoM35acx
 7GDONfYan85yjQxy/jVQDDqTxnBdbMmarLSbygfHDleBAwRZB1/O5A8wCe/SaDzE
 LSlq820xzT9gznfx2GHBJcQJG9zyiP2Stp4d4MVhdpEFExaVn3CNjwRXVOj0UoOV
 MDS2hxz50DvqDzH2OLOHBuy4cN18EytybnS0BPtsWVtwXck8zFCpyxdQ6KKRzdQj
 GJgqkVmyaSbJ48TaoKbHWmfukggUNK5ePt4VaBEk6A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795005939; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:iH500sxPo+q7nKSxNNPfRgczAsakOU/je4eOAza/KLCiSZ7
 BHUIK1kKgLagBRkovzjm5EJrOWHW/VF0t/S8PAoJonAg8Iw9xX2pIts0S3NqBwas
 RCiBIPemL66HMC+bNlic5faOoyqMPYSGBiAb370PzdchE734/sHPf142XWghu+nP
 bN6Q0LGF8vFARcNzojOCxKXFwxrbajioaHwdTLmepEaa1Dq847s6QRdYH6fy7E/V
 96gjhdl+9fNMncqAZPkWQ4ecabpIHbfr7DhE6WIvVpsMwAduz6E93bA86lB65fyH
 sCPLUBUB5cHVcDJ+/bVgLBSWpFyycbKUktYQmig==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=10;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,message-id,mime-version,subject,to;
Message-Instance: m=1;
 h=sha256:iilUmc0NGfuP/15fzFxPA6j1OCKgWnpduYFaIwBlnIw=:px+MfpktoqtNJEQ6wMjaG8aGZJeof7xoY5kHPJSTKdc=;
X-ME-Sender: <xms:8p39aj7hjrTU4qoplVxCbmSmN9foTXefuGUREfhYWReQH5yYmFP2UQ>
 <xme:8p39aj26izdp6n6Ku-m9vAnJQHv9yxcvVkiMW9xy86sEf3WHccZIgKwNjULerwa8B
 JgactPqZErj4vpcXaibh52gZoc2gPtF1mdoOCvC_hg8l1NEtcimMI2j>
X-ME-Received: <xmr:8p39apeQFdQF6xwmwkXAKIFptKqZu9uH1F_Y4yczqOeWoUlSbLQoubSmuzrU0g1UHOATgoX-AlG-WsMyXnhtFxE>
X-ME-Proxy-Cause: dmFkZTGcYGhIt+f+7we0R7IPv63LJdqNz1d2ghFgwYkp/kC+a/5tSF9mTm2YtsT+CJ2C9Y
 H6TRwlL1cCiGUYOuwB0QEfUqFF2dxIGAg3D7zWlqfCJAz2sNyKnMS+uoQHkzcdGnE7gWdT
 v1nUkUqXuUegE2I+4gqwjhf3NE7EkCDpXuh9Sl/9orlo0DjMCQD5gMLRcFzH2RPBpa5952
 I731LoWtjiYR1brabGOd144qUDBiuQ/5s+7GrWHxJz3CqSQR3aNVKU7v0lV3Za2ANWAzrO
 iz1nal4zo7hck60xYQOjYeYfyzgeC/0bfaXVbdWblhABFQFykEzPv0uNUSF7BClBpHsaKs
 mmL89cA/ZFgOL+7Kotp5nxJfrQhiL5v/ehISJLQ3ZO/Rfrk5NGnM0OTWIbul478bMj6T8+
 +9Lf0+RQWNCcqjWjupKSRXLvyfpxyF5GxTHDQIa9+Gj07n59eeOhcSuRPhUR6f2nqUbrPq
 sg7+QTo+JZ9q4iXZ9rjAF+I1MKP1uU80MwN2Io2TvOIYIR9aY3RbmWceWWvBJLq02iSxBF
 wNoJaH8ROCLKKDZf0cOpLd4+Ec0IHyHgrQhSDJp6Dvaa53FGQ8xpHBRC3Lasg9QQSrtjja
 28RClS0eQEOHrCLrg9Zem72qKgHbJhbisYFQIzoW4EoIzfvBL3vZ8gbjENTg
X-ME-Proxy: <xmx:8p39apc-GOnhG_ShVwmy7SbaiHwAlH1UwcGoX3GUTKab-08pXUMPAg>
 <xmx:8p39akwsBphsH3fEsXvg30pDoJtIEdDGw49NTc4wz3VuNqOEb4-z0w>
 <xmx:8p39ao-SLJMgrkc2RCRjCbPQxQn4i1k183UuFEKtSLOuKEYrvjEH9w>
 <xmx:8p39aki1LxucF5LZtrKpzMl0TMndstfdpxrtySeDsCjk55HJs9ebSQ>
 <xmx:8539ap8S_XEdx38hPP32GFd9eOn67bXiymoYRT_23__Pz477QzlWA4qJ>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 07:45:37 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
Subject: [PATCH 0/3] hw/nvme: zns/zrwa fixes
Date: Wed, 18 Nov 2026 13:45:33 +0100
Message-Id: <20261118-fix-4520-v1-0-dfa182213376@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO2d/WoC/yXMTQ5AMBAG0KvIrE3SaRFxFbGoGowF0iIScXfF8
 uX7uSCwFw5QJRd4PiTIMkdQmoAb7TwwShcNWumCiErs5cQs1wp7tsa0jlTGHcT66jlm31Xd/A5
 7O7Hb3j3c9wP+xfirbAAAAA==
X-Change-ID: 20261118-fix-4520-fea33bc104ed
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=605; i=k.jensen@samsung.com;
 h=from:subject:message-id; bh=px+MfpktoqtNJEQ6wMjaG8aGZJeof7xoY5kHPJSTKdc=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR3I5bmZBOTB4SW5ZakJoaHpNb21XY0l6R3BHCkpiclI0V1JncWdMWTVINUdC
 ZkhvU0lrQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKcS9aM3d
 BQW9KRUUzaHJ6RnRUdzNwN2RjSC9pV2ljRlBaMHBtOTI5ZFlldC80SXJOWXdGTDVNUWlWL1V0Zw
 o3eFYrUUdCUlRBdjhsaUhvZFIrRDB0TnlwbTFoalh5Q2xENmthZFRzVEVjbHIvbmk4L2hibSs3S
 GwvcnUya0FJCnZkeGk4VjlkZHhZQjZMa29CdUhJM3lwbUNGY3lpcHlZc2RUOHJLcXV2Z2RpaCs3
 UittalR2QVhmaFd3WHRMbGEKS0t1ZXlTRHQ4d09MMU4zQm0vTEc5T01pOHJzeDJ0Wmluam81TFh
 4cVRoRFZKdmFGQXlTZEc0MUkwcVBNbVkzRApCUmpNTC9tblNSSEhpa3d2RFdWUTRDeC8wcWIwUT
 cvbHphRGhST2VRUmZQZFUwTm5lb3YxTDk0YUJkLzk1TWdnClllZFV5SjhPUzdzdE1IbnpIc0k5c
 ytlSUNtOHF6clZzZys5WHB3SE1lMTJ4NkZ3ZmhYWXpwYlhQCj1ERTBICi0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=202.12.124.159; envelope-from=its@irrelevant.dk;
 helo=fhigh-b8-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Three fixes for zns/zrwa issues reported in #4520.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
Klaus Jensen (3):
      hw/nvme: fix open zone zrwa allocation
      hw/nvme: bound zrwa flush by the write area and zone write boundary
      hw/nvme: advance zone write pointer only once the write is committed

 hw/nvme/ctrl.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)
---
base-commit: 37c23beb36286b9fb44849088522480bcdfe376d
change-id: 20261118-fix-4520-fea33bc104ed

Best regards,
--  
Klaus Jensen <k.jensen@samsung.com>


