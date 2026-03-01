Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C92FD0078
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 21:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwoTy-00045X-FZ; Sun, 01 Mar 2026 16:37:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwoTx-00045F-DU
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 16:37:45 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwoTv-00041h-IM
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 16:37:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772401061; x=1773005861; i=lukasstraub2@web.de;
 bh=HwK2p4T1L+s5e+s9n+9hT46e4+ZnKxyeq7tjYkZiYtk=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=HWPQeczLQwsd4T3L4MJywLNDJRlufE3fliv//Q/G0c3rLLOz16gdQxk8qzVJEBOs
 fir1iGG3XBgITCfZ6CIzzuT2QYc0qBDBumqRydnToXGzxuOSsXc+8WHUaNWCXBF1K
 HNjGpSzd6QzgJJ5PTo3grrEkxI+trKrEzL62IhQFqgqaMa6UqW85IzMnN+cTi13LZ
 V6RCbntyvDgEWPtnre4j8FrjFqs/uQKk8DKLwWww+EraBb6dbAKbD2Y+u5xCtoXX1
 Fru0ctUceyLQgrWLjAT+/TqMmBeuj46XAgrlrgZ8ib9b1gUbKcZIRO9UxoLEZGaym
 j7dhU4UfFB1QqjnzKw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MzCED-1vkM0U17Jb-00rRj1; Sun, 01
 Mar 2026 22:37:41 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 01 Mar 2026 22:37:21 +0100
Subject: [PATCH v11 01/21] MAINTAINERS: Add myself as maintainer for COLO
 migration framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260301-colo_unit_test_multifd-v11-1-14c8a70c36df@web.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=637; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=1tZjB/3/ppKqe9sB1vbDXigu3FezuQVf4cS6OWdEReY=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppLGg8Ai/tSztIVtRl8dUQAB+kLm7b9SF0h88y
 lGdeHLjmwGJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaSxoAAKCRA1qwsonF2y
 WMxED/oD0VA6TtLXGPCLq4tD7z+FjdZQpKOA34SXz+bjSSMua9nUK5emgIsOWuWZlQlMdE3du1g
 ZlmS8OHgjbPPZ0CBU80v7MJaP16Qwam1rJ70pEMSlFL5kdvPuqD5207Kg0Z5ZAvK4dtfDj3ZnY+
 9fOFuJq+19+SgGS6rWEiql6AK4AFmNQDqGi9sRbRANJ4jN06B5BTTUnhS5gK5vK7K74k6bCOnYM
 TB/+zehpZc6/KFx7g63FjvDFiSu8uuDHkmlTwRgbmkA2Lj4vOGLIcnXhRLflv0JDZjd7s5icQlV
 UjWqw8H3LyITGbacBtMm3TE7aLzlwNVjwYenxGdoY4UKiqe6UF3fkFIcCgGwLSSpvHHSbtjR472
 whRI2ENgF0d88Q0eUMNWuq4Blo16Buj49njQxn3RD8Yoh+ON26JhPJDlHpsIQLr2E2EnYuhkKzr
 NT6qpCig8SMaIQiIZpsgZ2O56q4UuZ6vDBMis8zRiO+30WPkcJNQOhiztSHdd7PHNQ8C1XgzEio
 eTdSnpaz7F1HD4IgtqiP3irfH3Fv0M/bL9Ft/4TdXfbVLU7XwIxiHtNs5Pn4rokwO4M4jFOn14C
 Ec2uvrvY6ZcacBhHNW2DtM0Giz1fu33SAR0MXCl4Q0WpK+Hvc4+nVCS3TAeXOJv3mptSM2jlJWz
 4Tf67GOQF9hzMDA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:1kpkxhA0aeyqf5OhqYfkPvPb8xAx78OazOxL3WwDKCQPIsoKtnz
 egLfZ6nahR76Xx/XlvYomvtA5n6hAqvgYq+dVfIwnvxGnSg7fWAs8fcEA51c/vYvV4kxJLo
 LkJYhjyxfj4F8Grg59sY3f+kCyy7CcbBg/jd4J6W2k2i6F/pxzpT2UzY3YenDj9W213m2+1
 WXlEGO5cAP5owBHoKc1DA==
UI-OutboundReport: notjunk:1;M01:P0:hqNhk9XgzlY=;+JUQQCAWwdQISXcfTUN8usk0NG9
 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
 dp0xfvwmMxNzZ+M9Swcc948dBVd6GAlArJYiA+
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
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

I am ready to maintain it.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Zhang Chen <zhangckid@gmail.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 606b16762cf2ba24d6bd8bb72421db1325bb1908..ff592384b366acc823f19a6596=
ea8f32446763b2 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3870,6 +3870,7 @@ F: qapi/yank.json
=20
 COLO Framework
 M: Hailiang Zhang <zhanghailiang@xfusion.com>
+M: Lukas Straub <lukasstraub2@web.de>
 S: Maintained
 F: migration/colo*
 F: include/migration/colo.h

=2D-=20
2.39.5


