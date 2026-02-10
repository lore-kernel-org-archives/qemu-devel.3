Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E565EEA811F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 14:27:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpohU-00055m-AX; Tue, 10 Feb 2026 09:26:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpohP-00054t-D1
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:26:43 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpohN-0005iY-Kq
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:26:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770733599; x=1771338399; i=lukasstraub2@web.de;
 bh=lB5C+xSIkMKIRDv1x5Wfn129/4q5gzxH7gAd/BDyFJw=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=wAyNkVozGbexj2LP/oFyT2pM2ZQTdCVVOUIoKr/UWJ1rKYRyLP12aNK31sj7VfNZ
 bOiDb1uLKYSZo17TfuLX3RNvzn+r9oRMIA3gDF3eVtRw4C0Z/SkEXJ3OFCYkVIA/4
 Jz+MrfGRbo6p/obvavR6FFiBne1PbKAf8g7v9lJWCxXtXlJbHI5wLI/uDMAJ/ISoK
 tVgcNsNDa0m/CLsuzLNwEvycMYkl8QCydw0Pdi+dnoOECu9ODB+EPK200YNycIUhl
 ldLEW4Vg6OY2jVVtVCMgZ2NUP3f0w6YdoJ0M3a8a+P1ARmu4Ey0wKuZ7Up0rCUE2R
 PowP+og+ri803ccM9Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([141.58.43.188]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mhnvw-1vLAq71UTQ-00pnxu; Tue, 10
 Feb 2026 15:26:39 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 10 Feb 2026 15:26:13 +0100
Subject: [PATCH v7 01/18] MAINTAINERS: Add myself as maintainer for COLO
 migration framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260210-colo_unit_test_multifd-v7-1-23bd32f36828@web.de>
References: <20260210-colo_unit_test_multifd-v7-0-23bd32f36828@web.de>
In-Reply-To: <20260210-colo_unit_test_multifd-v7-0-23bd32f36828@web.de>
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
 h=from:subject:message-id; bh=5+dRgR5m8zdVwsdJs1KEds2XCCwojWugkIa5UcGjC6w=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpi0Ab8s5WJS+Rzad1O11sC0JO47kah7PuYhIpJ
 +lFO33U+NaJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYtAGwAKCRA1qwsonF2y
 WAaVEACR5FzwDYZc8yWIMcDiTzB24JbPzGvdZMmGXN50/swhWOPv49NkDjLk0/t92XB6EFILxGk
 eFHMGUpBwhtnETqeKwUnnYtmMAeZk3wch66tpeeaAfgDS18CTKco3YPB0q48yOJ6pg1lYRPIh5H
 u+GtAmnyr1WqZRGWuRxGuIJVlduQ65soeYafHFFHG7M8fars7aCqQItIEyIStSEA8TP5Bf2hSJ3
 re8v23ZUjHdxa2wjNrKI2G6oPgJCoZCm4+TQsjNT3Vco5mhnRXRjL4H0IwaZa+gw54msitxtZcx
 1sxtX5kdVePZJRiLEIbgt8GFJt1I9tOVQZhvlOXeOr1yXsg22NYDvxGta5XPGVdNIp6VsD3vWYW
 x7snGuYN5WRwvUIgHMSbCDqzQ1NKxWZkesgtx27u7KocRIqMGz9bYKvwheTIteMR9ZAFu6IcY2N
 1hT8B2+V1YEaOpCsgwgoEjoj3+6xDvyHQsL0Ocr32Ib30Ujv+iodPYye7cQ0UAfMaDjbodhuw1j
 Tnn+AOI9KvT1/GGOqlrPwpiVuJfvjQL8uEOGhOomitNh1STSowPTOjrRisCF8TPmMQ196yS5jfo
 uyuNmfbHizMnHoRI93XrYYob8ApJr/1zt4LFKzlWb6EhuC4UzgTd2YajlfAorQua799PoVlSpyt
 jWFkc+4VrcCJgpw==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:qjljJoQEh3trsQbcc18MSErvyTCO+Ccse+SZKL/vlM8qCZ/6Fm+
 r13+moTbEyHGe80ZZChkjQHxgP/fHE64RzqiDCCsdujhL2XT0r47pnk/dLgcI+zIt6iwPko
 MaUzQfvVfaF2ubo4dHKTE5ZkTRb4oU1wtblVA9tmYgAKsOrx/xfLDcCCjAU8UdFnNtwBlOx
 drEsPamYeqZNkJYNlEtnQ==
UI-OutboundReport: notjunk:1;M01:P0:Z36oasV9KwM=;FsF9D9omOotklPkkMt0AmLs5u7/
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

I am ready to maintain it.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Zhang Chen <zhangckid@gmail.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 29f88d48f3072aa182908bab667d3a108ffc246d..feaa4e47082499b3c7c9eee1a0=
e1a1fa28f70e2b 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3857,6 +3857,7 @@ F: qapi/yank.json
=20
 COLO Framework
 M: Hailiang Zhang <zhanghailiang@xfusion.com>
+M: Lukas Straub <lukasstraub2@web.de>
 S: Maintained
 F: migration/colo*
 F: include/migration/colo.h

=2D-=20
2.39.5


