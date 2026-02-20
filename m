Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DFC5C5AE49
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 19:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtWXr-0000Xn-JK; Fri, 20 Feb 2026 14:52:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vtWXh-0000Ue-UN
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 14:52:02 -0500
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vtWXf-0001SZ-61
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 14:52:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1771617111; x=1772221911; i=lukasstraub2@web.de;
 bh=M4oN3ce3lEdgtN7JBdV1BpBJqmDTcNHIBAHkYu1vDHI=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=YMQMP4965OdpVOfPyTh62Zv2rvPW8VMRY6Gg3gEA9qo6vng3iFVoScIU8hA3+QGH
 OC+UKRzggh2mGSGvN2/11i5kbXt+7R8raWEJnjsGCcFgJWnOREKKFprXtNJkAmAus
 QnW+U1ti7q6J1gpQslZplaKopK1Z6suxbbzDJQZo+ppERPwiaE7C2jHU76ogd8ydu
 m4uZ7wG6ODpQqIWVD9alQzs5nVnYMYjT00MClFOgnIFmZo6UVJGP37gW6+Dth9vpb
 4Vvqp3L17h32DRkhTqfC9s6rusnvmB+M7MOtZY5rdW3Q2GZFeKuE+0GqxcsRATHwt
 9PYN6UMGEtR73KluQA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([84.133.37.84]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N7QUL-1vfNH83HO1-014YKL; Fri, 20
 Feb 2026 20:51:51 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 20 Feb 2026 20:51:38 +0100
Subject: [PATCH v10 16/19] qemu-colo.rst: Add my copyright
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260220-colo_unit_test_multifd-v10-16-bfe67d422ef1@web.de>
References: <20260220-colo_unit_test_multifd-v10-0-bfe67d422ef1@web.de>
In-Reply-To: <20260220-colo_unit_test_multifd-v10-0-bfe67d422ef1@web.de>
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
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpmLtPE6f1UIGnURL2tN7CZum8L29UO5WG3q09S
 DYfxmdDTN6JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaZi7TwAKCRA1qwsonF2y
 WBVpEACRvTwVGkOq2Zv67VxTZEQhGjNt29+q30MFPh1yp6uNfiPLkqu3vqoi46zsHrrR0aU4280
 qieBtnjjWyLlAsOKxlUCcGTihMwhm2AP2ZpFPNahvshIOaLiwWHjIPR4/5aapeC4DdytaMESUMT
 Vh+RS1+DYtTDjI9FabNkIyKNoMvf6vRjCdQ0XTXzWx+8NU+PYweRlW6aNo1Q2BcCHiZljA4HiI/
 Ugw4FL6en3ZCIOjzhLnkxo0pRJl8vi9RciAqvnL7NpQpjriYE8Y+FsKR3UxT0d2GDz7DRD7QzBm
 0ydOkHI58gRnw7ZMzw/exgWyj6j+3BLFrzzh5ZxXJfSXTURuHXQ3/4ofMNr1bF6Yg6sJYI/pEQv
 bk/DE3hKC1ETjN5ibg4eGvMGP1JEFHoYMyeAhBkhD2TR0Oj2wS6NuHTTJ1WQAwLCkhb6d0gAo5R
 kMLC765JnhoDFoIfwvWjqzqYpIPA0D0dhWX6KavsaV2STS8vtqIXJDSz9np6jpBncalhs+n+TDj
 PIxUMEMzurBGlG7Hetx6y5l2QNHhPmfY7HuMT98IAOtuNbzQx64xubO8Pl4jW1Bjpa6fhS260w8
 CH6BwxzxcOAw3vyB5In+i2X7REkv4HppbzSAJ16m8aVgY2X2+/6aTH+2+fgjRwxu/Q1qBUFwSlM
 trd/rsXhx0QcGvQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:BXqjFk2z+mIlofDGNJZWtNl0O6KWfSSSdtV/whoPbGm9PbNXSB2
 xSHcRixNdiCjGgYrXlxHoV2P7uf+z4kg+SrVgPWtZvWPc8HHsVSC/clRLnEFi77uk38AJfx
 vQ98CpR69+BU4odUELFUDYhTc9/DhpF6kPCB0p52AfQ9AmNHXnh5ScEyVfu0MnvE48DPUp5
 mcuKO7XWu0Iewx7SgRMOQ==
UI-OutboundReport: notjunk:1;M01:P0:SSgaMUkJ+m4=;6PA03Gk948w6MGWLmMpqk7cx9lR
 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
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


