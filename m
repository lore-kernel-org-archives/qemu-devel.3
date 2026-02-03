Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C308CE8307C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 10:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnDS9-0007L9-8y; Tue, 03 Feb 2026 05:16:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vnDRy-00076V-GQ
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:16:04 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vnDRr-000280-Oq
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:15:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770113747; x=1770718547; i=lukasstraub2@web.de;
 bh=2fLOiQss7mpS/YnSLXytum1S8EPo3MszBelWBV6HFKs=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=WF8DUp4wpF9/KhFlG2H4NoByQSn6+lPlU5bRsRqwP4OY/MsE+3eCj0iSUqXl6YJo
 wtjjWRXep+eHblavuGWvPvp40+vVm3/2oApq1yOy8eFdGYNP0Ijih5QxrDb5t1KtB
 nyNb1FpzhTase20knAbLQtduKhoXFL47RgZt9I0XdK4GAmXMyrgVUO+Ck7hS+KTfd
 o3J4TuKC9M6K6KmR4xXTr/Xb5WkqL90e2FUIPKC6JjB3+Wrhlak5Ntw+LtRTjRIcO
 b40gyhabO2BOfCEuP6EarrQf65m0tljcwHpqyAyZJW7kXW2qqU3EHKOF0OOM5LKRA
 prdDmq/ef01sy7rY5w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MiuSs-1vJOw30fvY-00nwUM; Tue, 03
 Feb 2026 11:15:47 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 03 Feb 2026 11:15:07 +0100
Subject: [PATCH v5 01/16] MAINTAINERS: Add myself as maintainer for COLO
 migration framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260203-colo_unit_test_multifd-v5-1-57508b7389f6@web.de>
References: <20260203-colo_unit_test_multifd-v5-0-57508b7389f6@web.de>
In-Reply-To: <20260203-colo_unit_test_multifd-v5-0-57508b7389f6@web.de>
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
 h=from:subject:message-id; bh=FH2/0egZipw9UBAskN0KxY1g2vT4HwhIXXub1fgoQvs=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpgcrPG5GEPetGIO1D8HQEM2QwYYGrj1DKMdX0H
 p3eVQYdWfCJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYHKzwAKCRA1qwsonF2y
 WLCcD/95yfezigYWOIhTaos0GHOHegOqtoJKGEPOnt/AJq7oLFxW3UJhxJ/WenO6s9V72rIrsPo
 Mc+fThwPfjdC3Occ0UsyK+EEKjMe+uMwStYdb3Hcby0bpqcnGSanDbRCxkNgRt8G0W/+3McsUII
 ran/VnlbpAHqdPqT+HUtBssmV33W+nxFB9OoMoc372DYYd8LlLAjndWFlaIkcgz7hdTYM3aHB8f
 /342Ea25iAp8+Fs3aFz8UDdl4m9piE9dg6DsXT7CmwCzUA1shwFdcDJGVlpU9xpGIGVHKmEAxdN
 FrckcGQc/QzS4mErc38Oe6L6ig5QB5HDO0iUEBDVo93D/Tp4pGAb1fosilDdxnETCHhpMAJYka0
 OA07AJiw2MExqFrsgMhpyvd7o1M6iSMWukL6GADeE9YfxujDGxiua9KFguG0cVtq0XkbApVXfc0
 4656h+u3evsQL5CTq1oEaXiHvdOCTYZSUw6X7CP+drmvOMRNo5I6WATIsAvw328yfVZ177vtR2E
 9Z/SWcNlgFC61sb7z2HdaQNAJO9PURZZnf6Bzy15eKNtdMU6m1N94XVp9hizy59GO9mthCmtFgH
 HtBfprM7+vey9rXXDGLH9nIrspZTlYM9vmERIaOEUPEL1MvuNbFke850++LE7hWaB1pI3EbCRH+
 9t2ucKsugA3DpZw==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:CuaJ34oqkMuSVhYm2sH+sRzXwkkGEKmCDmXa0TeRzgCVmbX4pvu
 p/R0k2tSKX2EhzOl/o7HUs2tDFFciVuqi8Uu93cLamWoMVqVvZJGb3cXfSHFrJ/LOh52Lfu
 C6bDHLxhh31QkTizfOAy2djlFE5EupNrPu911dSDANlvf9Up31FjkOZQVqbJX3moCAV5Nco
 yJb/3GXdRWBwC5OEr/lmA==
UI-OutboundReport: notjunk:1;M01:P0:DwJiwBCFGAg=;2UD+CJpefbghO18M25UOy6lk+iv
 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
 fl5jFdiT8kvUYLIJVljGlbpRrkyLr
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
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
index 9b7ed4fccb1dd0572abbb52ecdc9f0b217fea13a..a9b29cbd528633b25adb6ed7ab=
2162a2d11b179f 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3849,6 +3849,7 @@ F: qapi/yank.json
=20
 COLO Framework
 M: Hailiang Zhang <zhanghailiang@xfusion.com>
+M: Lukas Straub <lukasstraub2@web.de>
 S: Maintained
 F: migration/colo*
 F: include/migration/colo.h

=2D-=20
2.39.5


