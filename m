Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC28C98327
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Jan 2026 14:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vh706-0007aq-Ib; Sat, 17 Jan 2026 09:10:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vh6zo-0007Vz-Rr
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 09:09:47 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vh6zn-0002ap-6T
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 09:09:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1768658974; x=1769263774; i=lukasstraub2@web.de;
 bh=lnMKUyxF6wlRJPiJZ0WtYkfE2uPGowCOM6UjVwMUYMc=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=DlHxkH7HOnVR9QOx4fK0KSq/NFGij7TTaU0ybrJrhCwMjCslBmr/3IBTAR+PYV2C
 4wxOkEOUYYCIri39bcRaS//WeMuRiZ4VxVn5qEKLISihOxeokjvhaYltoVgD0wTG4
 59BIaBKkpQICpxXrynXzRZg1nJ5FLcIPlxFFO2fKND8QMNl6ZOxchMevcUvCq8q62
 GjXa8zwU5OV2yZgw1UwPlK8GYATgA1L+aFR0WQVg5bLi+xWR9BvkbUc9egtBq90ZI
 NcSIelwE0Ao+gN21wdfJZDvOtHUBwVPU29YhZuZEmJU1knCMxdZLjgnV6YzFn/8FX
 NuG5zxFs9Lgyzek/XQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.100.70]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLRUX-1vOlC91x5f-00YF19; Sat, 17
 Jan 2026 15:09:34 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sat, 17 Jan 2026 15:09:08 +0100
Subject: [PATCH v2 1/8] MAINTAINERS: Add myself as maintainer for COLO
 migration framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260117-colo_unit_test_multifd-v2-1-ab521777fa51@web.de>
References: <20260117-colo_unit_test_multifd-v2-0-ab521777fa51@web.de>
In-Reply-To: <20260117-colo_unit_test_multifd-v2-0-ab521777fa51@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=547; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=B7l5lXeDfyFh891yX0/RL7d7jcBb8MS3vxtis6zPlOc=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpa5gbdwbEIfXmcKRoA1Q6fhM4AEHSxSnk2Add+
 v8/Wd9q5IqJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaWuYGwAKCRA1qwsonF2y
 WByREACaorG1P778JkGkiDkFPVlbmlPhsuyPskBOyb/xd2idcMzENeoxBkPJCa0iieqUOx/+uqj
 Gfx3BhT74BeBzZhrteCvJM4GY0T8g2IPEXIAC2TJlZlZoK8PRiR4fhOj8g4SCcYf0yUWlE4s8Hk
 yJ8d5pUXKizd8sVo+c7QIpZl7zifSjI6oABlROB2818AWWvRw/Y92QIy5urv1pg4qVCkhzZkr7Q
 scFTtulwnIHkfkDuRUFiAi2ZmPRHxTj2VTa5WzE5ClVF3rwvxp9pDM1odZCc+qG9FWXke63edWr
 qUr4wm9FQJZkjUMOF/DxMT+eM6BUWjs0LfsLEFyiyDBwv2FQtypVQFE4YSEJZ2IPPCpXtWcAvg+
 Qg64MGAeq6c5uBdjNZdETqE8TH+Bakox+okrHb65oskq1nR0O8VsqsDK4d26yiGFftEeJ7eFM5b
 vW2LHsnBUKkzeJCHL8z4BuWhIu7ocNegd3i+W8Fl16U30Mt03pORCxXDV4+RYlUqgID5Mih4zOi
 BPNpISNrurr+yL0esHt+V/YPP7N/wDv+T4dJ7LzrlFiG8Vay8qivPs1fOYeoMLyeYbnEe/VDFlG
 2DWUG+zh5lbpnOcxvmt58U4qeP3G12efbr4/JNbmF1Xqiglb/pA7kUNXWASasggNddBJJA+TYSw
 SLKg5zsk6Ofiteg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:fP3ZmO5NIsZFZSCS+L8rHEO7bQMJ/m2OcOElWHRvHEPk/0nLL1x
 Wb1NKBllo62GlAt+2EgW+GwpLOR3CKZbfI+yHg5oD6/5cUj2pz0VqwZ+KRiyh8bL4+uSoTx
 vSdx1wO7ccxH0MmiHyxurh6W9chMcwkAgPP/Gr2pAyRtQdWbhjpbqdzqLx4THfPa0h30ie8
 0oi5F7poa2bTSmyu86vNw==
UI-OutboundReport: notjunk:1;M01:P0:f7haSNVYDKc=;Izy5UU7bNO2JTBCuGdKKW7BWpfq
 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
 XjcuLZBYr1ymQfuBdEO3TFrc213rKPqo1Gz2or
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

I am ready to maintain it.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index de8246c3ffdbfb73d8d3df06cb1fffd80a707522..38691feea8941635c7ce45f30a=
822030016e922f 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3835,6 +3835,7 @@ F: qapi/yank.json
=20
 COLO Framework
 M: Hailiang Zhang <zhanghailiang@xfusion.com>
+M: Lukas Straub <lukasstraub2@web.de>
 S: Maintained
 F: migration/colo*
 F: include/migration/colo.h

=2D-=20
2.39.5


