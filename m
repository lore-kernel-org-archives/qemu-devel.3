Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEBDFFF8861
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 14:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGdgn-00081u-3W; Sat, 25 Apr 2026 10:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1wGdgk-00080E-HN; Sat, 25 Apr 2026 10:08:54 -0400
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1wGdgZ-0005o6-4G; Sat, 25 Apr 2026 10:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1777126119; x=1777730919; i=lukasstraub2@web.de;
 bh=ms7YS2ueteKVF/m9YqvSxooKgTBdjHrN7bWBYlR4+dc=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=cZ8I7N3D/ZZ0SHvd4n/+FkDIX1DyTYFf0H+AsbOYWLithAvz4ACvibf5DZo8kO0P
 3yA/td59+ZaIh7qErbpM555JlxiwigPb5SxS0wIc2z/3keWWV4td+eGmHlKiMHGj5
 /+YSbB+Z7HzXqtMlUea7HfioQT7yiWMCgE60HquVv3PTTrp+GlfhnqVEUqEioPYD5
 +tEtlMzHc4+RBEePgOj0gKAd2yv75OZJmWEWq0o5gIAfSv5zQ7XHvxb85KvrWVRwb
 YkvNN+T+Y9gYO1bnMBoKGt7ZWT8Auj5yxhKx7KDhG18S9RowlX4p8FVEk4HJ0Bire
 r8+yyjjEmabjtUDd4A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mvbn2-1vP5UW3jXi-017Br0; Sat, 25
 Apr 2026 16:08:38 +0200
From: Lukas Straub <lukasstraub2@web.de>
Date: Sat, 25 Apr 2026 16:08:22 +0200
Subject: [PATCH 1/2] MAINTAINERS: Add myself as maintainer for replication
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260425-replication_maintainer-v1-1-f6ab019ff0ca@web.de>
References: <20260425-replication_maintainer-v1-0-f6ab019ff0ca@web.de>
In-Reply-To: <20260425-replication_maintainer-v1-0-f6ab019ff0ca@web.de>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Zhang Chen <zhangckid@gmail.com>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=739; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=4aucc7e1379PXFMOnYRD1k9ckwILM4okuvV8LPKGTv8=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBp7Mrlm5WudRzs+QspdOsplL/XnyWWAWczUSb6A
 wPhqgCcUOOJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaezK5QAKCRA1qwsonF2y
 WArLD/9jGBnc4/2Q8K7RJk96Ss4TpoytWdNkMYvQyd8y41JZhdHWgmFVvwvmPos3Fy2zJuUOj/g
 gndM3okkkdp/QZDK1NzXHW1Ebsl2+/tGMkUwdVnokoeup8nhJaz9ZP8fucekWfV4mX9Bh4uZZCf
 kVEvp4WfbZZLmkJSMh2Pn56N8Z2t3kAywQ0FxaLn8BTpCdCx8tAfP1UG+xgHYF+MTaSPSKESl27
 Gq4jxHo7JIA5SGEo5fLLfgOJAPd77Xb1rb1+Q4v0CuCbch8JRz49NnglUkB6fEYz+yBW5E+V4L/
 VY9TXNcU0s4pM4zS+inb0S1o7TkBCnSge1OM4dHT9lWVa8bMCpKMTGNfjlnHZGWOr9meRSlgonO
 aPyJY6Ispddj3nK50VeXTZChL6OMhw8WG/xdJktdsgTF3Cf00sEoMYvYIxLhjBredY1IdGQOw1v
 LeNUwH352DEexGHCmWsp6YVJGpjUAPyH2yGQscv4VJwFEO3k+feu2GFFU1KaWeRTpeOgCUFKA25
 xMZA9OvJ+bmYZ6lTOUPIkOCv0T/8ZCGZQnHHpYvUR8vI8+7Brasg/yzHEc5orTER31jVEBqw82D
 AxspfU1BOPsspP24DQjXlExN0rErCZddf5XNsvwrdAXbDHCIshjz8g4IGMFm6xPtPiy2iExWhP+
 4tbGTZVWkU+wWtQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:SZGkpivY1RAYqnS/8yrSHdDnRNBT2yG3K2xtu8Ox3wjaJWWvn/L
 dxeAHaAmw2MV7DP8gExbgUh8X7cXEb2VmDiioFuKj1bjsM3M+QdYiuFqUt1UFjxwUXKFnBl
 /g10SN6ptY36icJCpAvlB3NlK5FvmpuMDzh9kTURuOgJLj6ur5/7rDYO+HIk1mhodHXrthp
 WkgpIZYlmpDuan3op9HSw==
UI-OutboundReport: notjunk:1;M01:P0:65I08ARRMYo=;LogHDWbwPAzjMWpHLR+/aEI6nQR
 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
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

I recently took up maintainership for the orphaned COLO migraion component=
.
Here I take over maintainership for replication which is another important
component for COLO.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index facc4b499a91b571c5f008a9cad11d6a29522719..39f4982b1fcd12264ffeb9396d=
b48356c00f96df 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4384,7 +4384,8 @@ F: block/export/vduse-blk.c
 F: block/export/vduse-blk.h
=20
 Replication
-S: Orphan
+M: Lukas Straub <lukasstraub2@web.de>
+S: Maintained
 F: replication*
 F: block/replication.c
 F: tests/unit/test-replication.c

=2D-=20
2.39.5


