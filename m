Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 521E6EE6B48
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 20:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voS3a-0004Mg-94; Fri, 06 Feb 2026 15:03:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1voS3I-0004FQ-N2
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 15:03:45 -0500
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1voS3B-0008OB-1p
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 15:03:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770408203; x=1771013003; i=lukasstraub2@web.de;
 bh=SIsYoIOUBzpJ4PEyh0nc52NL9mD2skAsvSA7Ee6VW9o=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=HZj4NOIIRieqokKFOGLhMIQiby9la5c1VgA6Qnw76jS1JZASjUzLG0cHfkNh1k5P
 h9LR6WhqLL6iUUNwn7OqK2DWNxAehs2zzztp/W5RRcj2aXsfF6wU9AFKqQMl+WacU
 +VS/uVQbCLs3EQpRcm+2TeERK4oxu22yJfXlhZXlb3jaINhH7NzYepmNtueO2NTMj
 nWGke/lpzpuTDWqyLTbpOt3C+1rHriv9Ot6aDBBLn52K9fKj41nh5xQN/cj4GkeKi
 Vlkld5pvOqOYTQbne6Wg8wR19Jm5LkPwfagwOTJyw+2a5hqOQ6eYzCPbx2UnbnElH
 BmD7Q0dNx7iUe1iJyg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M59iy-1vnM7S3YVI-002EkA; Fri, 06
 Feb 2026 21:03:22 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 06 Feb 2026 21:03:00 +0100
Subject: [PATCH v6 02/18] MAINTAINERS: Remove Hailiang Zhang from COLO
 migration framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260206-colo_unit_test_multifd-v6-2-27779dda139d@web.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=747; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=akLtAizr0Rulj9FVksSEosvDq4TvXIp7Un4kokIcchA=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBphkkF9gZOgz1M3at1A0+XyQVKwsk+Z5hiX8bW3
 48oKUb9vwSJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYZJBQAKCRA1qwsonF2y
 WGT8D/9o1nl6UW6Qa44jYUqXWFKSv0V7vedgG49J2utVxW/pFLyMFYO4Iq3vQPsGkmie2C0nnQ/
 5ZZiwF7g0+bZ5VA8/GG6qNG/hMWhF9cZT2kFGCwbp6V6/l5OnMomqhLzqc0DA4TFZmRia+uO+fm
 uAcTfi52w478NZEhJq6dm9a8LEe3S6Y58r6UtUpQEw9jbcBFKCWV0hfuvR6MYs5h+IsY6zC1yO5
 VPtG0ApN4LnWnBcsphK4IH4KJdpUVfXvzas0Rw4ruBvpzHBv5LbpTt+b3DzLUGo5a3OWdYc3OuA
 25ESrJNrF7PRmNrMoQHozfK/JnRjrI2nwLV9RxYMIu8Mig1h2ZbJGVpZU7LelCqyaSFXrAf70Dq
 4Dd9QfbWB5dGBVTCII9Gfo/4umnvw6xAsiNNCGfvsaolW1pTBk0OkkonF6oXMHT1EmMEX3M8UZ9
 nimPgf6Dszv5E9jYeT77fTZNX8N2wkdoLrHExZDDL/Z5lE03BqJMjwqd/Mglw5vcHyObRmS6GbH
 DM1VbvmdRJpjQyO415LCpPygomf7OXAtNwj+9vR0oiguyjOLvVQLfyJyX9lvoEcfajCfmyym74L
 hclYpVDVCMj82IqKWFxO3yYJld+mY54yGclLZUjRksZIlxKVETEBTUIf1JRoukUr4lta4FqwhYy
 n2q/OH0X83mh6VQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:XuvNxD2pY4W6TNsdk590efCqtLFTG0BijqVSkbHT7+5aHlYPgde
 kIEsnImPFpFEbcZwHP+jM/A1/p8t4oKoRSGY3O9DTTEaPjwgf7Oce3VT9fhK1rqeSkhTlLy
 K2760bLUtjDgE2bMl1J7KQzeCV/JRCvM1mJPJi85osqY4WDtxYOMox4keOZMRvdcNB116i+
 yATT3nFDEciFO0WWQpwDA==
UI-OutboundReport: notjunk:1;M01:P0:3dS9WMdb3nc=;rEcnHbXFIIv4NLPUhpsc+kfN7fQ
 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
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
index a9b29cbd528633b25adb6ed7ab2162a2d11b179f..ea170280580af6e3ebc586c3cb=
9bf6e144b30c11 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3848,7 +3848,6 @@ F: include/qemu/yank.h
 F: qapi/yank.json
=20
 COLO Framework
-M: Hailiang Zhang <zhanghailiang@xfusion.com>
 M: Lukas Straub <lukasstraub2@web.de>
 S: Maintained
 F: migration/colo*

=2D-=20
2.39.5


