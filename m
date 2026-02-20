Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D72C5AD68
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 19:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtWXh-0000UW-7i; Fri, 20 Feb 2026 14:52:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vtWXc-0000S2-Lu
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 14:51:56 -0500
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vtWXa-0001QI-Ox
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 14:51:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1771617107; x=1772221907; i=lukasstraub2@web.de;
 bh=EItZ/+gLUzr/5kLXi4A0a68bhxdVbobY0N6WGPa39kA=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=GlUFAeKltsBpcrIQNM8VaPpjVsU725RIFqHbcZe9lxo1/ae3WnF8NjMAlTgVnBp3
 oivtvEOxwmsIlkg6XMcs59cQleQ934+U1rYIMjSqarbv4UGm/UcQNodjJh/WV51CU
 UKuzi3lmcjk44HbJmvYBq/lzIuoUJVDq+t/ArP8RoA8Zh0e8JxleCpEaBKsRarGTD
 SbFbhDtYdTm4kbGYnj1urir2HgQAPwYxrZ0vwCLzHvD+Y8Ry10yXYn7RFUmsgR+kg
 utsHfoh4RnWY23374DDYe4qNX4FdMS5TmhCOReItBGfrRa264TtiYAEYz7jsZwJ/d
 h35zXOAnCSGs70tbXQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([84.133.37.84]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MVrft-1wLKnm1wIf-00TJq1; Fri, 20
 Feb 2026 20:51:47 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 20 Feb 2026 20:51:24 +0100
Subject: [PATCH v10 02/19] MAINTAINERS: Remove Hailiang Zhang from COLO
 migration framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260220-colo_unit_test_multifd-v10-2-bfe67d422ef1@web.de>
References: <20260220-colo_unit_test_multifd-v10-0-bfe67d422ef1@web.de>
In-Reply-To: <20260220-colo_unit_test_multifd-v10-0-bfe67d422ef1@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=747; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=is3YRplQqUwEeytK+Q8qH2cF/R5ufk9k2waP/h9xIHA=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpmLtN+4xLGgQfg7MPEVkovVpErQop/xuuQHjNF
 bEyj8HpH+2JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaZi7TQAKCRA1qwsonF2y
 WNQmD/9yxE0ziKIYsle9aMADlRLBFX/2hKl99/d/eU94mYCCqFMYxgVvMnhTQ7TJiAuUr80pvA9
 0v8XXsf7SuZdFIVJHvVZsz29yXpSiYBllmrXVWtWHrD5YvzFh12ImUjTs7ZfMAhE/G8jKisqcVt
 W29WoBH7/D9InpvKt7WxO20B1YLLQqh2z7WGUlplcbzWqeibFRwDhgaZqwGhVtP7/NLPWigV5IR
 VBsWRPhmPxHKaYk7NA5i2Ulr8I3E/77HXfWPnQro5ColSzR9ynO4KFI1q1g5phKJpv2w+dFbIeg
 m0yHnzSRMy+w7sN12brQTD5vsY7yZDEMnRndECJEANugnS/G5t6UbqcZdyk6CWOSe53MIOdle47
 P/1kvQkDPoTbcTEzGRfJH8rY73IrhiJoUUhawMwUst1+qciAmlAXwlMDDG+x7bIfBCR+9IARmCL
 Dg3pY8/ZJZ88RVXpa/jHHM6JHT6p5LOQ25u4QkNdj3x74acnMucajV1fsmqGc263C708VwrnmJH
 u++D1UIWUxbN7yeKitzDzJvgn2e72YYeCKCH9il3a+fL4uy7LDfY5EEzEvzHixF+umG7Moy54b5
 TYZexFfdtcNb2mkWonqbbMEk27/FN4E8EpUhg4G9EVx12CSEvMmYPmZWBG8mgh/rL7ZqeoFUttw
 0+SiCum/TOkys4w==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:oYMxSdf4DIWblhpv/SrJNwGmx2o7XbEMMZS8cC1FD619qbSQRmL
 E5p9NpProrPfmnEWV+vs8hbutUzni2NQNATzKY5voeZV3dEjICfKGTuZx3Xpj5tVLzDn3Uf
 NV6CxlNxlYUzcuQ9FXpmT6aI19RDOaUupoT4pKmjhRbiz6qmE8w4aTL3+Ev7yYl27VRT9JQ
 kPPZUbc3c3Z3zx8s9Mjlg==
UI-OutboundReport: notjunk:1;M01:P0:Xomx4kUjcyc=;QCe6h8jdqoYfFRyzErbUH/UYuW5
 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
 iRCycDS588aziuQowM9U5xwvfRoWw
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

His last email to the mailing list is from December 2021:
https://lore.kernel.org/qemu-devel/20211214075424.6920-1-zhanghailiang@xfu=
sion.com/

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Zhang Chen <zhangckid@gmail.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2458241e3cd45673d7228a3fecf2fe94f3b51b77..3c4eb3bc744e23dc3d49d14b24=
a0d576d7bd60d6 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3865,7 +3865,6 @@ F: include/qemu/yank.h
 F: qapi/yank.json
=20
 COLO Framework
-M: Hailiang Zhang <zhanghailiang@xfusion.com>
 M: Lukas Straub <lukasstraub2@web.de>
 S: Maintained
 F: migration/colo*

=2D-=20
2.39.5


