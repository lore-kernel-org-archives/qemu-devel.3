Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7C6606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 14:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=owVjleqh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNWMK-0002YP-Vn; Sun, 01 Nov 2026 09:16:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <holypumpkin@foxmail.com>)
 id 1xNWMI-0002Xt-Oe
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 09:16:31 -0500
Received: from out203-205-221-231.mail.qq.com ([203.205.221.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <holypumpkin@foxmail.com>)
 id 1xNWME-0006zt-6B
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 09:16:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1793542578;
 bh=dv1rlug3Z/mPlR9S44hCGM+tbmdh2DKgB3y8BKaDXZw=;
 h=From:To:Subject:Date;
 b=owVjleqhchUF7cSGUzUtS+x8HyLQyOGJDMxcmdbWUTHy56wiiq0++razO8wfRb1Ci
 1w0loUptFMe0nOf/bwQu1B6WB2G9sXsJaB+GgnFlC/51thJxo32uOAcIUJvwkcAUqH
 Eys2klX9eSnMeGDapoVPQDAc8gO9glmBSKqhmo4I=
Received: from localhost.localdomain ([113.200.174.63])
 by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
 id 3F3BBA98; Sun, 01 Nov 2026 22:15:51 +0800
X-QQ-mid: xmsmtpt1793542551trf0f0sr8
Message-ID: <tencent_4D5CFD14526BEBB75635A40E6A1CFA153108@qq.com>
X-QQ-XMAILINFO: NT7dO8ok7FP2qGNVwX4VOYQVWKn+Z8vVkmY4L/9vSYxzplVNRAskpIqQ9HRbY7
 Nf2Gyrcfz6vIsEQOkwXWP74bWLUhZBMCTKkgjnuCtrpXWKG11Co1A8vSg06HvQeqQkLhP1JJoaoD
 KufVav5GJSr8H3h+hEfO52bIWYSYiwYck8H7VfYZN4yD7/x9RFZsAVVyZ1L5yyguasid0yGDGhPN
 YhDBYreu+JlrJkESNLXPRSqRyBvPomPvnauumIkzPBwA+V7gH/ngZfC5u3VQ+YPuISfx4Pvg3HGU
 oWRLPdpqyWOdUXVwBrXUlcNRm9K1AdfFesDFLej5xy4uaFBTVOxzuyakfmpBJovoDfjHcEwdXh4Y
 M8GPcFl6FF5h0ZTa8JbAbGwVwWYUJbE3kt2LNhhz4StEIHEF5EvsLxj5ErThhe7nbAgdiZOx39kQ
 2TjkO3pQgdrJjORxbGnVIvKQVOWk8lT+P2leWR19GOLyH6Q/uqZpcVGdeVZaEh86XqCPLn2cHK1Z
 qV2NRyp3ygQ0qQAdBtewMREmCbf0jkq61Scll6ByiQlUtW4u6adQ4NiQDIUiLy0u4A5cLZQucoz7
 ZJJH+bbqJqWv7DQp4zC5bhYbAXtBske/022hwtdskHfIBArZxGfgAwAQ0d7y2RVw5UVKm+HT+db2
 RJ7DJh1VxP6sL2rCLMhlSel62MKvh4pLP5hUGunvid13ReqKhG1ZxQu7gLtrLZIhyxCu36l+egZT
 pXeDSzAkLx/Ceo/q4XQ60k5PTmkGmag9aiwGkJO0neMqd7njzaNNjSSmGeIFcEQyCXEy/2om/L71
 bIwAGJSryWTE64JecE7jgFJ3FGhrwYI60+Mpy/BxLWgOk7ixw/3y6Vq+U2H3nMvSPo1O2XQgggWJ
 Lex0QmLWHJ8fYFZKU4l9mssMY9Rfm6DKS5pVjWL3U+gXEtMC3Cs69lUwSkI9ky6yNqZNBqGy/6ly
 qXE0bk53unjIp9ox638V5SvAv0344qBGwtjj66s6SYi7ZoCds69X2wUI/A7e/yLqCx+iqjkaP3hJ
 KDz+Nm05r90GGu3LL1lnIzItlPcCOtvuo1P+vhhDh+9pUne8AUlIMQIy3BClYQuVba9m9gRCRJrd
 bvkVust6yZUQ5qh5dXnPEaw/dDyIpSfUU85CsU1ta+HHgqrf55kVEI7l6I5g==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Haoyu Nan <Holypumpkin@foxmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 0/2] *** Reduce QOM initialization and RISC-V virt mapping
 publication overhead ***
Date: Sun,  1 Nov 2026 22:15:38 +0800
X-OQ-MSGID: <20261101141540.2021-1-Holypumpkin@foxmail.com>
X-Mailer: git-send-email 2.47.0.windows.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.205.221.231;
 envelope-from=holypumpkin@foxmail.com; helo=out203-205-221-231.mail.qq.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HELO_STATIC_HOST=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

*** BLURB HERE ***

Haoyu Nan (2):
  qom: filter unrelated classes before initializing them
  hw/riscv/virt: batch VirtIO MMIO mapping updates

 MAINTAINERS                        |   2 +
 hw/riscv/virt.c                    |   3 +
 qom/object.c                       |  17 +++-
 tests/qtest/meson.build            |   3 +
 tests/qtest/riscv-virt-mmio-test.c |  65 ++++++++++++++
 tests/unit/check-qom-enumeration.c | 138 +++++++++++++++++++++++++++++
 tests/unit/meson.build             |   1 +
 7 files changed, 228 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/riscv-virt-mmio-test.c
 create mode 100644 tests/unit/check-qom-enumeration.c


base-commit: 9703b6cf418d2ce72fae8d00e511135ce0bfda43
-- 
2.47.0.windows.1


