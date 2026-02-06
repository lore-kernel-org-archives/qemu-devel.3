Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F7FEE6B4D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 20:05:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voS3b-0004NH-8K; Fri, 06 Feb 2026 15:03:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1voS3I-0004FP-O7
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 15:03:45 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1voS3E-0008OY-LH
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 15:03:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770408202; x=1771013002; i=lukasstraub2@web.de;
 bh=2fLOiQss7mpS/YnSLXytum1S8EPo3MszBelWBV6HFKs=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=CHp2tKC9nszsokZO5mMuhFHAt3eApYU6LbmWWKbypWjjyDPm2JOW3su8wxzhMtHy
 Q+8hDEZsqmoRGrRcTNGYNx7/yMJBTO/Fks3LyvEQ5HPDe7Ix+NJ8tOKT1CcpSycAy
 01+d5IgbkQj96yMzGTiNJxDl9pmx+sN9ooknl8EiWypTii3nVpPgFsnybFW0a8Tsq
 2UgPWmeQRJgSG16Pd/9h6z2Ty/Dbx2y5csit8KAZ1h3QlnJ3IhNTwWlAhyR+u5nrX
 aaZtxtQfNeqK7gr6LuEXU5qtDDFnCQX7RBqMzGQ7b53mHdaFFuC4U26qnVtyPGiSO
 l3W92J82tI9JfIX42w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mav6t-1vHJDd0oeJ-00bJ73; Fri, 06
 Feb 2026 21:03:22 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 06 Feb 2026 21:02:59 +0100
Subject: [PATCH v6 01/18] MAINTAINERS: Add myself as maintainer for COLO
 migration framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260206-colo_unit_test_multifd-v6-1-27779dda139d@web.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=637; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=FH2/0egZipw9UBAskN0KxY1g2vT4HwhIXXub1fgoQvs=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBphkkFAdXWhZQN6ngXg5JL7mHg0QeSNfwq9nzRX
 xl6iWjFq7uJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYZJBQAKCRA1qwsonF2y
 WPaOD/440vDov7sxTub2GvNpzekob7MiaaT/WyikVIGRjmqQR1NAQrF8391WHMeXlpD3SEKLfCB
 AbbPjBttmXi7uqrM+cHzF8HZT8ZmjPFkdHTMYc2Mu/MPAzEo5jAFziFWnTzTHwPvde2z3HN/Dhl
 +txQMCiyTJmCrHUXA2SpAgJRIZws05+IohW+X5JgNvG5I3MLojN/7RC7vOseQSSOdWvtgGnqGki
 tAIPCEAIdrMDYkpE26BxupeN39iCLTRuE0Do7ZI64dOuGbZmYKTQJQwfOh9RhoLQ3D3Hkjq12Kq
 UEW0hOQU8XvGZYm3oLFDzAiRJr8wcOESIqG1WCtk/2H5rrXoKT+KX4XX923j4iMhpPMsHiKwXvV
 Yhy5PGYJElI/HrvAxYE6PUTkVc6aypABpWKAHnnFITPCGBbnymKDWcHY5qTKc6PNXMDnMP4OXC5
 4ejQwnKemXvoFcXkjBap+tveQ0UDsPdFEV7bdGpvSd06/BIF1W9A6fRIauhsfmZUZQ1CS2OlSNX
 hId2hKIinlMVC//dllG/P8jds1bbFnAuQEIINkLCaIeKywUmQG0NzAeuyWjEooCHBRt1Ebgcdq1
 cLr7qyRDu2c4PK81tKaOANabP+RjK22dPvJ1zXflTvxaQ/lAGGWEY5YHYYp/0Q85bbavF0l0hlR
 hvhNwA2EAu3c4YA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:dm8AP0b8IXrPMUkPaJrsCT8kjQwNdBCWlaQSyOMvNb3+W4EqUxi
 zHN1nAPPebvurCK8MkeqhCOsHQJR3h72S/vmM4QglLw43ThjIyqprnB/6ZEnoPXL+adugFn
 Mkv6KJgJGqfOIlLYZuRJ2NyQLFHpeff8TnJ6wk9pWLr+Tz+Jj0aH4D5IkrjZqtzki+8ElvR
 3YIeyocrqVjWK96cc0iYQ==
UI-OutboundReport: notjunk:1;M01:P0:GtgoDNEB874=;QTAmhy85PAC7ArhytPSOwCG9hct
 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
 an8AWWvI=
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


