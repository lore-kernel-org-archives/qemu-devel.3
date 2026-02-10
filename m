Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF7EEB26E1
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 16:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpqWU-0000ih-HM; Tue, 10 Feb 2026 11:23:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpqWQ-0000gV-Tj
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 11:23:30 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpqWO-0006wX-Pn
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 11:23:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770740602; x=1771345402; i=lukasstraub2@web.de;
 bh=4LaXbTl0THXOahwuMttIKN3IotOqiTe82gAMkr3oLpI=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=kBSxiYiOB8xm5IzR9g0vRPDe/LNijyEtJZM3LvykugXmupY9sqlnwN0Im/n6Zr6s
 CM6L7LhI7MKQE9h6SMb/357pNXt5jsxoPBcnuO2CSPaJQL4ZeSxPAoKm4PwbOGHSu
 /3EPAuZimcoU0d4HWf5NBKbEIRVJSNh7S5ZPc/wzsUqqny/2HBk/mnUaKj2+GjwwD
 UVGfok7tGr8l+GqlXba4n3trw/n2zZhLbhbxJdz+V/tAMoJKTYOMIBAVtWdJEjRyz
 ay4XYcXL5hVcKJAzVAef7pssOCx4mpRg1cxTYqIz34EHnY/2Xj8ak3KXK/T4S54ci
 SwHqHuQMql2K0vjpPQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([141.58.43.188]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N01di-1vdFc42uGc-00x4fp; Tue, 10
 Feb 2026 17:23:22 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 10 Feb 2026 17:23:00 +0100
Subject: [PATCH v8 02/17] MAINTAINERS: Remove Hailiang Zhang from COLO
 migration framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260210-colo_unit_test_multifd-v8-2-7f9e5f7d082b@web.de>
References: <20260210-colo_unit_test_multifd-v8-0-7f9e5f7d082b@web.de>
In-Reply-To: <20260210-colo_unit_test_multifd-v8-0-7f9e5f7d082b@web.de>
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
 h=from:subject:message-id; bh=Q+MgSdFh34hx+cFCgJDYFMQn9ZkaS5SNN9GtvvR6EzU=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpi1t2BxTmyQBLn/B4dvjqcbvnMPGJ7WUxtYQWC
 tlKCNUk1JyJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYtbdgAKCRA1qwsonF2y
 WBoQEACyJbBkl6nuUSOxMe85856MJIqKWy5wdiEkxMRUSIzNy/jmBMmeYFnbgZrrt5k2thLs/gS
 YhEN+qP0xm7r0WlYqZfLi8f+jwI5l3E05DD04xZQZbSZrsS1NNAf/wIp9tBTfeDroYs7FMNPwbL
 XtYHjgeqV6+F8RACJB6DvKcLjm8dqchuKSiQ0o/egoquKU34G3vTs/9uauhVVDhgClTlyoj+A1o
 PCbggNrNbToGzGgLvLxmAwoXk4jvDWrNmDEHLwd/fBqPjOpC6gkIKPnoukkdW2QAsG++ktjtpvK
 8dvXP74u7QoGQoIoMk3j+Dqmlnmy5vtleACdEWy4yL2hNvmPaYGWRFfljhB2nT8eyi7TmBEMpJT
 9RiXXQxGEsMIHF6iiLYOFr9nnlj+GZnH5zIJlROCRcOzrjr7FG8eH8p6i2+U8arXAt2SBJqEUJO
 HfvcOx6Q9NWB6hG/sZVsRTg//tgHR9y2h0DSN1hYBC5FRpHRYvHsfVHNf4TPWgsKfLwfQQfoNi3
 wakFXD5wyexaeco2nGeTxxMJ47RszCTegsWVJuLghHrNF5be99Qo2i3F4M1pij2L1JcDbdAhkHg
 8ozSuycTsn58EV2FXB3JpVvmBLFKMf8Wr0pmk0agwwMe96AwVH61oa9ACwCdDPzZY4zuoix/9jU
 xzA/iifgHU0OXgQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:45zOyM0LzzB9oQHb90MlsRZkS2X2CjoTVmrVqyPPHAGcKQASbWb
 37dvLpVRoUp3kRHiqIxJmfLI7UJrOW68cN8/JWbEPZPh1C33RWgx4Jq+tKn5KrvFWPYxdey
 vqmsEpz35SqnEEUnEDyETV14RY9LqRjr331sg6PhkRRsh/1rhGIr5S8DcP9sRz0t7N2TIHd
 71uuC+U22rgFVm0yrcbWQ==
UI-OutboundReport: notjunk:1;M01:P0:o6U15kT1JdY=;YkLSba4bsqUcE+b/VKyX8zxb6N5
 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
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
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
index feaa4e47082499b3c7c9eee1a0e1a1fa28f70e2b..356e3a7889f9ab45f002f16511=
2322e6fb5a1967 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3856,7 +3856,6 @@ F: include/qemu/yank.h
 F: qapi/yank.json
=20
 COLO Framework
-M: Hailiang Zhang <zhanghailiang@xfusion.com>
 M: Lukas Straub <lukasstraub2@web.de>
 S: Maintained
 F: migration/colo*

=2D-=20
2.39.5


