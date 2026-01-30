Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A27E6BF0A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 12:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlnOp-0004Zo-3M; Fri, 30 Jan 2026 07:14:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vlnOj-0003ss-VC
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 07:14:50 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vlnOh-0001ut-Ic
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 07:14:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1769775278; x=1770380078; i=lukasstraub2@web.de;
 bh=iKyLRZKXJSFEcCUd/CpIynVD2diyxFI2e/ukmWL9g3s=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=sviqIQqzRLSiITYiTuo+MQNIw/1jZR0bF9EMz6AUsS8jeXJ2s4Fhzk518LZcJP1j
 kDWGQW6n7hxX1vhVHf0yR6zVTZQVOFaDFbaXGJTvc8+TgO8SFO4Fh8G1Ak99Y2lnt
 n04E7YjM89li+tjF0I7C6QhVQM7nQktzm1Y6t2JyJTgfCskM22x8aMZLLLCgLXm0K
 6eCLe7IVCgbIwOaSPJbihGqkD7Q9wP/LYOzza8DKehnME24OXcoXny9+BoSRXw1qo
 CYkVlLc3kTMGqCKLoVtLL53RBc1ywg6+3q2G1RJ3lrHdjMqotpB2G2FvNdzU1Jrkj
 7cmN5J946IpW4wS7Vg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1McZjb-1wHqQF1gC5-00lR2r; Fri, 30
 Jan 2026 13:14:38 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 30 Jan 2026 13:14:23 +0100
Subject: [PATCH v4 15/16] qemu-colo.rst: Add my copyright
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260130-colo_unit_test_multifd-v4-15-7115ab6f0e77@web.de>
References: <20260130-colo_unit_test_multifd-v4-0-7115ab6f0e77@web.de>
In-Reply-To: <20260130-colo_unit_test_multifd-v4-0-7115ab6f0e77@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=908; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=OswessapI1H7sfJLERN6Md1iEosxHPhzYxn5Z/RITfM=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpfKCmIbED/CPGLdSmuqS+q6ntTMrKcGC2KD0Ak
 iMja7dMCy+JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaXygpgAKCRA1qwsonF2y
 WMUoD/9yvoXXaUs930dcd1pZ3ltPqFtGsts0jGuMN1hHPSBY+XazGJ/84xfFjrIFCtbyoeNEbzH
 heDU+R/QWTcwy6rlRp8rYI61I+/5Dygv6ulPLur5A8LH0z3V0+crttuTn/IZmxoClzHabPm6HoH
 x0kwRRHwF62rKFwReBtH9zwUJKw2lCxQvKZ2B9xhV85mtl9tIdB2IuHXqhd1lKBxHtnmuvQEY8D
 ggJG6vBx9lXabkfUWIweDPxWR16nWVhgag6ptmuRmtLmsSqDK2UnE80Upy2tpurYoGaOqhQ0MET
 q7QO6WOP1c4hCEnw6vglE52KyvThO34tBgTtiW1c4NRSkEKHUddQbAdDvNsAvNbtcKQITgDEjoz
 b6RPpXUj8Fcu8V/1i776gETy+Y5jvKu9xuA9WarqwsE8tySWs50ZkZZ/p6pqk06ZFOi+AKHc7Sr
 +OPzhl19DuYmdCDsMwjpLpzZtebBbrYtvvz+il8KBhuTZaZTOYkYitYa4Dv59lyv6vul7Mqe86y
 5xCJ8+PlkTtZhq+54xMUyIeWaST7HY6mpebYlpJfQ9JAaLvz2zh6rWO0cEAc3MEwHHZNNwxX1w5
 TY9ywXm6RSwLfw8nTK/hL6tuegljZH48pnqYOUQpzxd4cOR8kRQrEkRWxwEeuQyQTUypbQTo8sF
 oKa97SCwsAfTb0A==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:nyQTRsth+KGPI+akmMCUitdIbyEYAAUSvVJGHooQdkNdXpzJivJ
 LmWhYkHOjwez0EN0lFabr6zqixqyLdFt/+wexdVrI2pGuEXLSIGZ5/5ozVYZ+j1Cl6BtpQm
 BtKybI9LxnaCBEY8+thAtIyP+5K2MJsoj2djxlZtQSH0KuSwjxMHbQHDHKHK87tIzHe2GsG
 Z2QQAUqja5aH7P7zYOtsg==
UI-OutboundReport: notjunk:1;M01:P0:CZMlOYn8Oeo=;mPCDR4EQxjdsytYwOAhBC/9Pnzp
 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
 7Q4a7Ls7QcDNcKSJ4BS4UyJLBWp8+peXIPqS8M
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

I have so far contributed 61 commits to the colo project, waranting
the addition of my copyright to this file.

Reviewed-by: Zhang Chen <zhangckid@gmail.com>
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


