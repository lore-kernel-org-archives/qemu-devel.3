Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A624E9B357
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0Pt-00006P-HR; Mon, 02 Mar 2026 05:22:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0O9-0006lv-AZ
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:20:35 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0O4-0007QI-H0
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:20:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772446816; x=1773051616; i=lukasstraub2@web.de;
 bh=M4oN3ce3lEdgtN7JBdV1BpBJqmDTcNHIBAHkYu1vDHI=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=uYq+9l85u19WkABP+ggVmU/w0OYzeRY1BcCDWDme4Cr6v9Orl23X8vhAR4JklqQ7
 NFCH7ROuEQ15kcdVBB65CgD+PByt8E9eJuHcbpKReAPsGMco8AypzA8Y/8RGXK+ng
 qSCOokH/KC5na9Fx4t6PCb1/XPh3hkCvmXC6q8uMXnrDc1dATstb6opDqCg3vlBEV
 +Go57I30A3AbwsOMbP4X84Zx5hw37WNcvP7wwWvKdwvKB7Rn39KBpAMZlpclBOSF7
 PVJYQCj7caTZwwdUD9YCgaBo016sJv5bZ+l+926L0cKeQyfZWXCkZDS3vY/7hpJ4N
 lFqi4aSpN4Dhjb6g7w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MVJRb-1w4sJr1MGt-00OBgO; Mon, 02
 Mar 2026 11:20:16 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v11 16/21] qemu-colo.rst: Add my copyright
Date: Mon,  2 Mar 2026 11:19:58 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-16-a2d96276c707@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-a2d96276c707@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-a2d96276c707@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=954; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=RBjsUyK419OI2tM2s9seVXuGPbNJkvd1FTM/9fBKVHA=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppWQpE9QY3TdDawVB4qP3ZdNKgo7YqY0SJVika
 5u/QpdqlEKJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVkKQAKCRA1qwsonF2y
 WLUXEACOEBz0CwK1gHIIemGpzWmLkfANN1Xjeqrriuuic6MDv9UY9DPP5NmRLF4DJjxGv6hILuB
 XqRu5Pb0Yy1Uwcj9UOxRDgbuU+6UV6BS5xa5PdJrMGB1iu0eawipBQLOTy68uAnzrV2lJYTsclj
 kRPCi/2boSTVhUdiq2RrQB5cUyHwDxqzI/cv97V9mXciju/LQ5k99QnzsNhlfmU+S5HNqFl6Tjk
 vwfwRyvh4OeIBCGeqnPcvVKWHJRn+T6ETzEqgamwYDwM2iew7sZcm1pVNxlsIysM9XAP7g9vekZ
 3JETctD/juExxAOpsIVTZ6wyaETye2h+Yq0CxaJx7R8yQisdLG1w82VTMdxrM4Jr5i3Gf26DTCW
 aPKz1xt9T2iC3IZvPEVYbuLRvOJ/FyDEeIE3yVccTH/9VHJyGule62C6eXos8KFicE+LxwIa+TJ
 JeEIlWM7jtK/52MXSUyGkLvugO1/0NY+l65r2ZhuBYb5yMZbn5dD3ccxxU7MuCZT1Jt1i5yPW7c
 BAJC/vhRGV1Cm46GKzAVgLAtRwB1agt6A5r2EdEItw6EAchbOM+qn3hT2hBxEXI3m0zbbzh5I1+
 K7kftAL0xlZ2AmpCte+8c3VoCzX1VOWJHpos32khw0zuxT0jztVfksb1iNNpBS/BpkAvOjsBVy+
 Q6Qx/Ky8fDjRsXg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uZM94815gJoi8njV0seugmi8UTjBSgO9Orcx80LdbmXxfU9rnUq
 j4u2Ql5liml/TfKoyfLvUTNbzyDFIdB6kRDV4fbvKVfnY+6o25hFsc1Z17dsCSILn3Y+Y8g
 R48u0mQW3CrmZwMKYWSsoG4XDkIrgWnDFgugMLbR0ygJQZ49Tu8vb45CoF9ftn0BipZH42m
 5dq6ghmcHbblAHZ1QJLXA==
UI-OutboundReport: notjunk:1;M01:P0:lUiZWeNOU6w=;dSVICkaF60hiYY0k19yARkPGC+a
 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
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
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

I have so far contributed 61 commits to the colo project, waranting
the addition of my copyright to this file.

Reviewed-by: Zhang Chen <zhangckid@gmail.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 docs/system/qemu-colo.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/docs/system/qemu-colo.rst b/docs/system/qemu-colo.rst
index a70e61aa09391cda933031535fa982d27cf6654b..75abbd80298df79223cb8e7006=
4a5dc83d70f4eb 100644
=2D-- a/docs/system/qemu-colo.rst
+++ b/docs/system/qemu-colo.rst
@@ -356,6 +356,7 @@ Wait until disk is synced, then::
 | Copyright (c) 2016 Intel Corporation
 | Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
 | Copyright (c) 2016 Fujitsu, Corp.
+| Copyright (c) 2026 Lukas Straub <lukasstraub2@web.de>
=20
 This work is licensed under the terms of the GNU GPL, version 2 or later.
 See the COPYING file in the top-level directory.

=2D-=20
2.39.5


