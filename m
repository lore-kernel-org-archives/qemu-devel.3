Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF14E9A049
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 21:31:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsp7E-00076l-BK; Wed, 18 Feb 2026 16:29:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vsp7B-00076J-0E
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:29:45 -0500
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vsp78-00072p-QM
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:29:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1771450177; x=1772054977; i=lukasstraub2@web.de;
 bh=Wgs8JnPLwSHCXYAOpefvV8N7YHva0erDF8oWhWNsX3A=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=vTz/6NtXLhmtJlGciXhcklBp0TLmryVXQezWUxXqW/eBHFnza+oRlGBL2Ofuxynw
 y5xyWvDZXyEpj5P3by8xcbjhgzCnFsLDs3/hHE78CIanv1PrOCo/k+laHYooMZIEv
 TbHM8dLJodS+32WOx6EOwT0jUTK+hguLE7ewnn6k4ZEmfCxPoBJwXWYZQriVl5cwp
 EiU/g/hcTDkShxBiwSsyei/f4RlrS74tSKxKcUD+keB4pW8+8lmfbbBQKQx/WjE18
 bBMisXnF9hKhzVwWQ3yr2q9BspJ4LtWWSmU2QY6ZB/oRwF+hOfHVTO12Sx/73gx5w
 MklbrWBZb8OM/KTRew==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([84.133.37.84]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MPaII-1w5YXr0rpa-00PkvR; Wed, 18
 Feb 2026 22:29:37 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Wed, 18 Feb 2026 22:29:21 +0100
Subject: [PATCH v9 01/19] MAINTAINERS: Add myself as maintainer for COLO
 migration framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260218-colo_unit_test_multifd-v9-1-d8dbdb0ca6f6@web.de>
References: <20260218-colo_unit_test_multifd-v9-0-d8dbdb0ca6f6@web.de>
In-Reply-To: <20260218-colo_unit_test_multifd-v9-0-d8dbdb0ca6f6@web.de>
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
 h=from:subject:message-id; bh=MPZRkh7CVx78Nod7CaK6mwPKVKcE6Kz1AKvpzLXE0w8=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpli88u1nqb+lgKNS6uCeBl7JDsxWlXhzhJ4B5Z
 q/6fAJeiPiJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaZYvPAAKCRA1qwsonF2y
 WBZLD/9XDwa87X103cG3Mc4Shj5TBx4OTkMGGu+tkuRrB5HTlxQjDB/vHU7f+npSJOp8fcFfWQS
 h21sfZqZmP3aU5HGsreqhQEeg+LGvBq5kKp4nkforQcYdzT5WtrBDzf5wgftgo1Uh2DyFxAhZgz
 JD4rdaXE9iuhdMTOrLSNgx2SMRoehFjciw0qJ3/lJ3zGel0jXOH06T9jYzGBm0yrlwWJfhyai0I
 v1Q7zhpTjoWAkog2YxRQro6xst+UNQYEnV3DAyBeVD5rEm8YoelgyD5cmA9ScuxaB4GzQL49CZs
 CIBKuV6bknk6s+eYP0mqSTm6R5TQJjrIry8E9PID+2FidS5m8IDGyMK0hwps4oqAYsz0ipfxkQT
 F7bYJK/L/v93Y7AzF/8rWGByneh8UevKVd0Q4aTqI+a+g3NM+Qxk6mdku2BJb2VVQdwW4/d9+EJ
 AeTaxEQMHdpT1yAHcvfBnSaEBLAUVDjRFFz8uGK1oXl00diPxlyDWeAMw48NuK/1xsEOtOUZ16/
 5UY5NETAC9XDd0/tuUG21dchcTKNNGILkIQfZVIs49mUW0vjJiFgQQKfUVWQ/Ke1tO4jtRnPbml
 Kg+RtiNdb1TC1LXBT/gEqLIOnUYQ9gdF/xRkHYpqiFon5ekGEhHBGQDTK2GOi2XT+RjKTommlvr
 4YlTB0ZX7yvGG0g==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:YI94hL6h8JHZK+hNMk3DjfgX9SuoUI2RhU2rVjActXOSqo7XrwR
 eyyCKUryxJ/GiFYZCThB/OLpAzShrBd17OiRe54nApQiyLM41oWztb0MPqE1v2ndV5qAeJa
 s8w5zYf/SeMd0qy2Pjh9AWYzf1sJI5hbddYcMKnNNtewARZ7iLWOHBANXnkRPAWeW1Os4tV
 0W5hQNDnRfu/SzlQ27Kvg==
UI-OutboundReport: notjunk:1;M01:P0:x9kiSxNTM/Q=;Bmd9++kFOkm6bUWvapOPcLKa1T/
 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
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

I am ready to maintain it.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Zhang Chen <zhangckid@gmail.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e0c481e2125d81298a52caf7f7b51c3e4f026d85..2458241e3cd45673d7228a3fec=
f2fe94f3b51b77 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3866,6 +3866,7 @@ F: qapi/yank.json
=20
 COLO Framework
 M: Hailiang Zhang <zhanghailiang@xfusion.com>
+M: Lukas Straub <lukasstraub2@web.de>
 S: Maintained
 F: migration/colo*
 F: include/migration/colo.h

=2D-=20
2.39.5


