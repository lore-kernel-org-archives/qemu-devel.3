Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9CFEE6B48
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 20:05:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voS3b-0004NM-Nz; Fri, 06 Feb 2026 15:03:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1voS3I-0004FO-NN
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 15:03:45 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1voS39-0008O3-QI
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 15:03:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770408208; x=1771013008; i=lukasstraub2@web.de;
 bh=M4oN3ce3lEdgtN7JBdV1BpBJqmDTcNHIBAHkYu1vDHI=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=buinqHLS8N3lxIvvsKlJR9fKUBTLJftA4oa2ZDBRWJ9D8/OGaC7hK0K+MhxkuuHs
 HFctcyxMrUshDMNkmae2MJUGFH1dUqQG41ZIP5hJnlWQAFtJCKUtRvs0yN0pceUBm
 2S0Y2cTCQntyixhhETVf8w+gh739GszLpfFlJoMVunO96zSlgLWQBAsTVd88tmA2f
 a2PGoG148pTjF/JePlSU4LJZ/cHr55/yhsk8rtfuq8mpvTiLndx9XoUTFJ/K8lfMC
 FQlhIX/8GhekG2Qum5Iu2RlgXkhQ0FYg2703P+rdxDxwsbDVz8Q/kOJFOsvvOWcqO
 0ajuQK/elDY4PGSYgA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MlbHC-1vNg5S1nWc-00lzQe; Fri, 06
 Feb 2026 21:03:28 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 06 Feb 2026 21:03:15 +0100
Subject: [PATCH v6 17/18] qemu-colo.rst: Add my copyright
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260206-colo_unit_test_multifd-v6-17-27779dda139d@web.de>
References: <20260206-colo_unit_test_multifd-v6-0-27779dda139d@web.de>
In-Reply-To: <20260206-colo_unit_test_multifd-v6-0-27779dda139d@web.de>
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
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBphkkGzBYO9eXcMT9dhjiL4ugke/MYTOBVYX39x
 HIJlr/kaMKJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYZJBgAKCRA1qwsonF2y
 WB9kD/4r1ZwsAyuTtZ9md1wECsUgEks4goRKGxCLQp/6irWZX+fSTyJXcPiLzyYSYSchC05KxZR
 v1Zxc2r2rZjI+Lf3ZABiBwjEd02vImQxck1wiU5cmP+vTCs0afQZg4LXG5PJoT1UkU42hpnw/YM
 kRCQsh754eQAgq4wrUmibq62pkD/uEY8UcK+9M2PeyATyJ7DwAMKI+++cDxZYeKwD9RolqePPJd
 t4j/mUrVoZ0I8jac091DXjPxQJ62LSmuCqO9d+vge3DuilLjhT7XzlwF1BrmaVWXL6lmTrEw2PA
 VIj7bYKVCboE38+f0ImTdPkzm947jN9yNdIaUOqTGOU5ic+DoPCqh8rvakemeK3rLzJ92uj09Fx
 JZnQJ86odofJNjlkMmWwGMIt0AaGz463/R8wE4Plau/C5CXZcjO5PCIiC6wAQ2qpW5wn9TjC6Hk
 MHA4p3OYAvCKqIum+xMWXZO7FzhUbQhF5w0IY7o41NmnMzgZycdr7v9fdI2m41ZzF45RdrnjlJJ
 AEGIvKwxbgVCfOnY6IgnKVcKyC13PgHQ/vDR21RI1oBuNqPRKwu5zvES/h+5TtpLlSAMY8tFC+/
 N/yVUL0zwO+Vi4hOVyGq9PuLgP83N3FR6lvQ6BCe3qPoyDNjPXa/HgatfF8D6H2O8ZON+GnjQAb
 ZZJJxRaeULjPiWQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:YMeISeRSQM/lAQNi5QzP7KEILhG99nuqwZRx839T+M9Js9tmimv
 evMIxnKiV0KDOAnVfzwexvBxHgw8E/8HmLJtX22eq6MambMrsyo+jd1NHnaH4/w9lKp6LBu
 8+FWnrb4OQ58fJtGRQfRgDNG7SmGKCtS5JbUwd1Ju80KJkzk7+ZT+QsVNAUZK2SSz/2+uiE
 xkXI9NOvPlLKy7kHDgHug==
UI-OutboundReport: notjunk:1;M01:P0:NFl10fLnnkA=;VWe5D/PVzQMwX9mD/+TrldxYXXh
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


