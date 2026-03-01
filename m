Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F250AFD0047
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 19:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwmHw-0001Ds-Ob; Sun, 01 Mar 2026 14:17:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwmHo-00016Z-3a
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 14:17:04 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwmHl-0003Ws-Nw
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 14:17:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772392609; x=1772997409; i=lukasstraub2@web.de;
 bh=HwK2p4T1L+s5e+s9n+9hT46e4+ZnKxyeq7tjYkZiYtk=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=FpP2IP82AxIohLBVdy2KymEAwdgGvvgEQCz4qK5O15hFiRVN3c0Ka+ha+VdOKOaj
 KydjDeaJw0p+OAFxnluMvGQdFqzQQB0pkg44jizV8cPGJq4EiA38M65Xm1SpbhFCZ
 f3FZEAHjRwVCiJC+2kQGSTqIwOYMZG/6n4fLhpnOk35aVIgKXk0XdDELSZN8aewCv
 tbQScGBGDhAbjVFYG0ftpvjTyySCcPTmmTE0F1ZGWsJ61MMCJJL5RdJBcD+mI+myy
 sQM/Z91RRXwXb01W7iu5y/tm0UsMyjhOXRuVEIejzP4xZtw3tfy7C9LIh5A1cqFPu
 l8HxgVPjsUJ0IBHkFA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MUlDP-1w5xMe049Z-00V35f; Sun, 01
 Mar 2026 20:16:49 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 01 Mar 2026 20:16:26 +0100
Subject: [PATCH v11 01/21] MAINTAINERS: Add myself as maintainer for COLO
 migration framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260301-colo_unit_test_multifd-v11-1-a9701e795d7a@web.de>
References: <20260301-colo_unit_test_multifd-v11-0-a9701e795d7a@web.de>
In-Reply-To: <20260301-colo_unit_test_multifd-v11-0-a9701e795d7a@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=637; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=1tZjB/3/ppKqe9sB1vbDXigu3FezuQVf4cS6OWdEReY=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppJCcrZWpV6PZ6mrPeX7VDTfHBrf8cQnZn23sm
 Gum5naIVrCJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaSQnAAKCRA1qwsonF2y
 WN7pD/95iex033lGXpcZWMcqNJYN35YXr1oCGyai6muaOwCwarf/r3rU8JMLY9tVH55nQw/M2E7
 7BTJtK5+TkzqWa0Izj08yOVeBskBSsFLGcjp/H8/9j4VfU6uVfbLLa5H1WxFlv9tkcaSwETxsTj
 fiExFH203ASyRHf5AmHe/nMHdF1Q317soOv/qgEKsR6Q/tmMHANDL9rRkw47+0kgq9Fi3Q4EJdt
 /3CX+2iCAE7Rn8YesaHVIrviBoI34utB+bIYKuJBAhAoBZBfqxsdBqeIxxZOwA0lSyOl13+RXmb
 PwjbzIaP2LNYcMULXmNycH8906vgO2wlnwlzfgamdaQps/XCHf9Wc0Di6P0q5p1rWScfa/aSc0x
 pb6jG7I+qbDhPnLsaaei71Lk16mnJxA0I4+p2wZEwI5G4Z0MZAxVhf9OO3nBIjhDAmcSPuBDYD6
 1hQABHo/qn+epCN/aKZ3Uoam4SIq3UHUTZ16REUbXbJcfCGx17ZXPH1xmw17f94lcSYIjUqNcyo
 lzj/lIXNR4jpf/ifr6hInVMq31XBhVMZlr3bynkK7t4lfF70AHmFrbxU+zuAB5ixpxFNK4HZgCr
 Ni/+eAc87nlUmFIcCPKP1EwHoyUK7YbiFrOzrhB3DLuBUIX9UuaNu+kOtNspjV9kXQtLvDpPe3u
 fvn0CVRfFv48lqA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:FBY1bydnuC+Z5O30PaWbtdA6wyKa8L5p0cJoyBAZLwXsHeAyZQC
 lBw1kG5rv0KtCACphkIzizu7fETFE07g9n5V/wDGFUxHMCUYEmwj9t3Xw9FqeJI+tqDHWVT
 O5VAxcCA1UkBAjAsMrYI8mGWgY9j8nRvkRQZ4uQRSeJ3QNWLu52dnY0Me7CB5wNCIgG6g9o
 sA/ATny5JJw6XroXbuCIw==
UI-OutboundReport: notjunk:1;M01:P0:EvBhf05QJzQ=;oS5lNoohUhIQAMoLSDU19xz6DT1
 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
 /SwRS0OY=
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


