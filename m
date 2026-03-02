Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C289E9B356
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0Ny-0006YK-Gy; Mon, 02 Mar 2026 05:20:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0Nw-0006Wl-5o
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:20:20 -0500
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0Np-0007GM-Pi
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:20:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772446811; x=1773051611; i=lukasstraub2@web.de;
 bh=HwK2p4T1L+s5e+s9n+9hT46e4+ZnKxyeq7tjYkZiYtk=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=wyYrXDsMkQxCbmnZFIyg+rJV2gfvWg0lAGstAJAoecr/61lSuyPQCVZhdrjfQWG6
 rqmpsqOLLD22+mrR1egJgrt4IPHu7yjJSXP1qPK04YrF6PaSP19V9tu2TVrNCp2m3
 H9lnjKSeggFh61AAhnGAig7+HlCKyQWc8XmM/4hM7iNnmau7o9JYT6YDsGd/2zvnM
 rfPV9darTBUfCsEX/M0OOVwRKtMXuAvOzy729KVSxLwmipVkVgiHagmyhKICAbf41
 4kuZ3iJEYOPmOnArVUKXYkGI2XP37Nvywtaja4B+1a8WODqbvF8gxgwz7vUrcg5WM
 Q/MhxuZ14318P/Z3iQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MMXx5-1wDi1M00Ln-00Qzdb; Mon, 02
 Mar 2026 11:20:11 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v11 01/21] MAINTAINERS: Add myself as maintainer for COLO
 migration framework
Date: Mon,  2 Mar 2026 11:19:43 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-1-a2d96276c707@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-a2d96276c707@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-a2d96276c707@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=637; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=1tZjB/3/ppKqe9sB1vbDXigu3FezuQVf4cS6OWdEReY=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppWQokyvrFdxuodDe6JudnKJMzJG1SXSUKYYJp
 6Jshaq1+naJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVkKAAKCRA1qwsonF2y
 WDlsEAC1bKQGR3gaIeBCce7hsolKWyAaDxuKL0sIMJUTGUp9+QpCAALT/EACPMaHOrBATi78zk/
 FAyslrI8GXSB22opysNnVcKWUda12QpOHWs8hwNux5zbaa8YcG/Kkcfq4qdww0psV54i3ENuuOa
 d3ysYPphKD2qitqxoa8R7a5Hdf+SOaP/x8Bzz1WsfD8h5nwQw6WeOp9f1lWfq1Dqhc3QVjoQkIx
 Lche4kzluuwNoiGq7SxnIlfiEN2qlL3bRha6baa7yuJXbDWpnaXolMiq7ai92+Lr9JbyzOvTGxm
 FvXxM8JMOvXaPoy3BXBi9TUo55ixm85uLJhuyjeKancSjtHj5vh+zpjmNPRoNxPWGCZMksYnXSw
 BvTY/H+/Lqjt++Za68nnnRB+80rtfQ/UWF9MDOdvuG7L8nAj8UH7R27elC2rKJ7j3tRjDiu82Bd
 HSeJl8WDgi8bv7p/4R3s1DNeivOj/ho2RKQsctmRuyBvWyCXMeYoGTuB3RXlHGnEKMVJmD7GUut
 MGUYDCOqP7YZWrqDdPYZlMiJtsvSTTMECEuHMRx8SY66muGXh5GF0Vh+9blPVcAkXGq+iNzGZdb
 k9+J2keJ0vChjT16hyRZ7gUHkLpt1ckpWqC033WMP7+EtCKWXaK0BwE7rG1FB1cJdYOi9REgQKJ
 igEqfFFoPHhKGZQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J/U4N/Un3pF26xqJP86+WHkKSgdL0dcbDmhXDPzlQ05Gq577Mq0
 18AQ2VLPyaO3YZqsN74r+cqEJkL9d2SH/KCVWcBMGXzbQ2B9nrdqhkD4mpce3tvyd9x1Rzi
 Xy8uVfbBem4GADQvNXbmublJBbzLi/KLrgYuSDLj2WCalcqi2kzjJsVH1lQaw9EPCbFInZB
 8uH15E1jPE99/xO9DpWrg==
UI-OutboundReport: notjunk:1;M01:P0:le0qIjmOXHE=;MXjfcI01kjH+ORA2A/CXBnb4aDm
 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
 vVPngpqM=
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

I am ready to maintain it.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Zhang Chen <zhangckid@gmail.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 606b16762cf2ba24d6bd8bb72421db1325bb1908..ff592384b366acc823f19a6596=
ea8f32446763b2 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3870,6 +3870,7 @@ F: qapi/yank.json
=20
 COLO Framework
 M: Hailiang Zhang <zhanghailiang@xfusion.com>
+M: Lukas Straub <lukasstraub2@web.de>
 S: Maintained
 F: migration/colo*
 F: include/migration/colo.h

=2D-=20
2.39.5


