Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC71FD0078
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 21:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwoUM-0004Dk-65; Sun, 01 Mar 2026 16:38:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwoUI-0004C7-BO
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 16:38:06 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwoUF-00044T-78
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 16:38:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772401066; x=1773005866; i=lukasstraub2@web.de;
 bh=M4oN3ce3lEdgtN7JBdV1BpBJqmDTcNHIBAHkYu1vDHI=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=juHmR28JH1tbr43SwUx+6DJXWthG5H9cw2sUpMH33GCuhZ98lmo1YxY+jZ6pUDLT
 W0MwCu7aNwOm7hys4lMCRn8mgSs74iSyVJQ+Nqe/8cIKTh3VIJROuRfDKdZUfyn7Q
 Hc3XaivsQy4X2nyYrI2I1NOGjWqEjOPDhq+YP70G38zKqlVWf2DJwVbkT1aSczkt2
 ZxjrGjfZUFJU9y1UKtxFPes157wHuQVauRWvCB+Lfs/B0sRkzM1Xbuq00xWDH2VMv
 aAqNPLWHlXwT9/9iedtgwicJslM24pXnBh1F4aEA2BanI1/6bkyal/54hbvLc+KWP
 uaZdxJdY1YEO9MzVBQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MwjFg-1vmHwm1YDq-00tuZ0; Sun, 01
 Mar 2026 22:37:46 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 01 Mar 2026 22:37:36 +0100
Subject: [PATCH v11 16/21] qemu-colo.rst: Add my copyright
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260301-colo_unit_test_multifd-v11-16-14c8a70c36df@web.de>
References: <20260301-colo_unit_test_multifd-v11-0-14c8a70c36df@web.de>
In-Reply-To: <20260301-colo_unit_test_multifd-v11-0-14c8a70c36df@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=954; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=RBjsUyK419OI2tM2s9seVXuGPbNJkvd1FTM/9fBKVHA=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppLGiYws3CGJgNMdhHekJe0DmhFhBD0LJnbhM0
 xIApjzHqp+JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaSxogAKCRA1qwsonF2y
 WEGDD/0X7FLjYVCya26+BQeLjf/05/o9T6kFdSWBvnSUab/iz4z4gX6vzGC5R0DaEVKjin95o3J
 +cfbN4QsZ75/Sth2W3BWLUgt+q0FxAzteEgJLUj3uKSynf5alfFwojMqFnvnUNw47eYkeAkPNyc
 z4w//h15c++9iBo/2k4xch9186bCxTWfHftD9uEaV9r7jOTkpEOJGgavrXtsUAuLA5P1wQg08Ha
 DkpRnteAQUjbbg0VDQRTFFUEEBaRuqMp3ZB3drr3Y59NB3EVmVVD0xYxodTgyRHewc9FgrEahS0
 dUYIBJhiQe0YWZ92ZZCth9JO5fzWieEIg/RbVhm5PmyoQ/X0D0M1hOV5JnDlhSvlaD4kHW6ZTH7
 b41BU2IMHYTi0izH2sHoxkijrdUyyv+3SaJw3nfRDomjF7ERjBLLbL2c/gM1z3oOYMFijexCO4u
 eaAa8XO1NY0+Ki5ZQgcOPtb9OE7O3SJP4Oq1ff/BYOvfHVACjHFSc05V6mGuSmybiw3bH4u3tB4
 ZyvFrFOxSGbR7GmjdGxqF4ppz4IgWt0htGv+q0fA33hE0FFN0EQYXrM9MJPrZvCEjUJK9QcL8lN
 e6QZO4NO2rg382s/nF/Lwjwbtmy8VcQGMdKlOr+eZezBynXaofH72MtN15xpH0rskYgU2SBa5Jx
 RsXLOmQQxeWhQRg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:hPQf6SJocKQcwAJnvfZBlJ9zVbBHOoQruTt0q0lCLTclILehw0T
 ci1Qb+8t40BcuShgIkegmTMK0qlXDBU94QWl/tnCLmuc3KuFnQU3932qNH8DGv6IsqjiHwR
 O0Yq2bGbFCBGm6ZiHKobn18FKgyhLZdu4FwKQk05Xd3VxAe2IGamPWibXyesgLpfiJzmBF/
 zi/zmYn+vyRvCZmfU27gQ==
UI-OutboundReport: notjunk:1;M01:P0:wLUNCqsP5Nw=;Gwt5TieuUV+f9nwWBKwuVKHbk/6
 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
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
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


