Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF718EA8121
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 14:27:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpohl-0005EF-8F; Tue, 10 Feb 2026 09:27:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpohZ-00057q-JT
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:26:53 -0500
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpohX-0005lW-MP
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:26:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770733602; x=1771338402; i=lukasstraub2@web.de;
 bh=M4oN3ce3lEdgtN7JBdV1BpBJqmDTcNHIBAHkYu1vDHI=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=SL9XAG+x2uTnNnrPKSKhs2UhaWve2i3EsxTJp6zlv21fJbpJaqLJ9sPW/9H2KIW6
 6gtdJn7TUCXMgh4amQFk0wP93yCghY/24WU/9W9BYW1QOzlRhcfiMIqX/+0weaWAu
 nJfDUWxnR88ArKbwNxHnBeoEYDX+p52YJ4fhppEefuMY5pKM5+dsU9fwbUiFJHn8u
 I0fDkT59PLTAafiTxh0igkQ+8eFoPJ6r9wpx2JOaB025ut+4r+PalLVg0/jcHXpym
 1dJGGsLwsmqGs+g/MTW0oKQ6pBB8gtiv0Dx+xZ8AcSWmlb5iNJqrTtTsIcRn1934K
 e3t3Dhs54luHFQgtZA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([141.58.43.188]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N30dV-1vflC33GW5-00r65j; Tue, 10
 Feb 2026 15:26:42 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 10 Feb 2026 15:26:29 +0100
Subject: [PATCH v7 17/18] qemu-colo.rst: Add my copyright
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260210-colo_unit_test_multifd-v7-17-23bd32f36828@web.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=954; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=RBjsUyK419OI2tM2s9seVXuGPbNJkvd1FTM/9fBKVHA=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpi0AdVka8uv9dxNW8q+nLq+k5oyBb7xv8oFETE
 q34MdHKmryJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYtAHQAKCRA1qwsonF2y
 WI0wD/9g1VSVvOuNBQwYslkCVqOzi0/5xmvkPyA2A5FmlV3ciBcK21ojkXVsLLQPuWDzwB4/1Ua
 8t84smI6pteDIPqOJ3HjXh5HvZj509x5YSS2/435s9a/TnT/+k8M+uiY469jaxM+T/zeT7pqo2j
 JJdd0bjjmt6ZvWPqxL0W3hT2liBwAo9p9dSQtXLp6FsBOwaknS12JkWGDuMikYZMsMIQ+jN3Dxh
 jpkurl1ryu5dFsZdlhYdGUtuEC5UAa0yTSrXtzwZVZHBDnIbvva/aLeMlYqzv+cpKO5wHnM8sWb
 nnOPGB2cSwmBEyAS1QIqOEb7Ytj1Y7+u7e3W0u0Lq60xoEUBgC2Bj8OHszA8ekhPzY7JpsMIbQW
 KtSssJlIJqSvOr/Z9suK6QQjjaKsbeHQUXK+KG0ATUKov8/5OXhIYFaTDxzM0Jm3TgpIeitq6NH
 bRw7IFQj8N6/846RZavl635AXdBqNEsOLjLDE4PKK4qR1hS0kOaYuOIx+1xFmGIL6vvARFLFApJ
 klIOcByh6MOsUmXbhSMh0JpTN5Oncz0VdTH7km5vSxd+hfPz6PlanoElR2LjhDi+23omQ7Gsb/R
 CUuRFbWAAQ7N8C6NiNJaey+/7jxjUDZWAOO/tAKyB1z2NaTt4yWYySf0+y4VPc4xU93OhuzCukb
 NXQ797v4sOynvRg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:gRV0ONw1Ly5NFfKH7zqQU4TaHV4ieQpdk1bdmCaBZ7oUtH78I7k
 EHY/oITfqYlcMy2QiSJxGxtcrE3Ot8TzmYZBCcuASnycgIr/F3Gc/r/Mb9zdsVXDo8B7vl2
 y5DAytTKa8x3diIW30/sfedb1LtNWB5kOcqS7yC5WRekrDbnG4fmbIzk5dxdgHXzcqeu+7+
 EHqxC2QRN7bcv5IQCfl9g==
UI-OutboundReport: notjunk:1;M01:P0:QS5LtaJWGwY=;TlJwEssQJEs0OMAB5z5KO9mpmWX
 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
 xaLZWfyGvmcKBgXeSL/dMLkHtCEjnRorB1nMdO
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


