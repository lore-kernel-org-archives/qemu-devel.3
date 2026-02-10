Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED9DEB26E1
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 16:24:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpqWQ-0000fw-Qa; Tue, 10 Feb 2026 11:23:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpqWN-0000fJ-6U
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 11:23:27 -0500
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpqWL-0006vb-BD
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 11:23:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770740602; x=1771345402; i=lukasstraub2@web.de;
 bh=lB5C+xSIkMKIRDv1x5Wfn129/4q5gzxH7gAd/BDyFJw=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=IuvBzzUn/RK/pWcww8Ea6eMtZ7Rs8PEP8BJshxz5tUWr8gNjAou6B7U1kaQl8qDY
 QurrPmb3Idw8h68vI1Diopnn2LQv7MeEUwild2djZM0UmWVevqtdR99+Smv0WOJ8j
 /9Q2ynZJneOHiXo5Vjrj3LEwFGqH9ZZsS1lKCEstFNK7Jb0bP9gNpMD/Rsw7TUnIp
 hkEAVV/DeIwbj0jYm/xAZPBfKdB02ixSa16BHzRC0Jlbz83ZzZz3I6Xq9kuiz5Zh2
 LPn8wXmgiIEidPugGS8XWWQYs1ibv+wBxJs1s+NjzMlaEMmtcE4i5IGV/XMSyd3Wg
 yUXdyDKh4aOQSP55IA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([141.58.43.188]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MUl9B-1wFvwZ28Hp-00QmKc; Tue, 10
 Feb 2026 17:23:22 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 10 Feb 2026 17:22:59 +0100
Subject: [PATCH v8 01/17] MAINTAINERS: Add myself as maintainer for COLO
 migration framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260210-colo_unit_test_multifd-v8-1-7f9e5f7d082b@web.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=637; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=5+dRgR5m8zdVwsdJs1KEds2XCCwojWugkIa5UcGjC6w=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpi1t2xXUgiD8OwogKKFcP1MsI1PyiKVa8taaav
 ctbFqi4982JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYtbdgAKCRA1qwsonF2y
 WOW2EACUW+rRioVYKufASJcbYLoLb8XAjPGTCMNro6+LSIuNIzcfwvYjhIR8Gn+//oEiFmWBnWM
 qTKT+Hi0sz7vllR8hYvp20jWaDxDjJZxe/uale1CZy8Ea42LjfvqJkhwNLwLP8MHmHsDtsaYHQT
 bTckxb8zn+1yoyeRBXZ/FtbhZmYz67r+Mm/i0Fa7tLvp0QmhivUZJQH9tYRveN6jM/ChJr6wFWr
 YiDWPhkgX/ZTOAWwE6XZBiRDUhIRcvynOB4oN6ykHOhZ+wIO8b0Sk8A0EWxSvaY2AvOoztWuA7s
 97On+xTISUq+FcaFilnwwjqqyxTMZiB36K6Fa+FXDrkHFWUA8VOF1DhYQnJz7y/t9hn3nW/hz28
 vkWZ9Iwx9cexqUdHHZTi9DtYkFHQwTa6LselbvprVrtqzuE/UoFXjH/MmWx+bdKlwM1M2qm2UNP
 TZiVKK6ACd4hCRPm3b4ncEB+W7jZaWRIx3mhv8mFmB9amI/kbCeS9+amb9tm5IfekASx8uVbqjZ
 DozG32MuCyg7rE/dDFoM7IOyhRwt/SPRzzeVxqx5rnRlIwX7Agp5ZPtSno3OgQmLTgGrtOyytaU
 8YGWQhoMag94QtnE4gWcV+73io9Irrx2uQLVK12YXKXbxXRwJ7igaEGpDS+WIPR0lx2boXBNkBS
 ZpkMNIWyB99BrNg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:ONIhYSCj2Og62YUoQdWbSD7IMSuYjzfQI/rlCU6GA7xtsJCoahs
 zWAA6NUsuVGRINUH52VLp1anC3OsosUqDG4Vc3wnNnQpYP6OwR5pTamnvN49BYzRjDApkzA
 1940WX2/gbVzl8NAzOJlcCBDI/6PTANDy/4AfAR/TTO42R3nFBMZoXLHbZmp9usxTJRCJm+
 +ajVZqus1qe81t1MwuYuQ==
UI-OutboundReport: notjunk:1;M01:P0:Mj9o4+0JQhc=;2r9zfFmb6ps2Y5idKcRnR7FzeOr
 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
 P3TA7XJBO6gIaT5q9OsMg7CU3JFMV
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


