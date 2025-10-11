Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D46CCD184
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 14:27:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7aEL-0005d5-GW; Sat, 11 Oct 2025 10:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7aEB-0005HQ-Ae
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 10:05:43 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7aDt-0005cl-Mh
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 10:05:42 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 557EBC01A7;
 Sat, 11 Oct 2025 17:04:58 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id h4NOTl1FrqM0-eLez2dbC; Sat, 11 Oct 2025 17:04:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760191498;
 bh=rK/+G9hpA6fAo+LzVNCj2d73nJK3eoEO5+jb4Tdcr/8=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=FHwjrLJdt+cnDlwZnm8gF6zC37QfISJbOFEnhyxG/dlOVULOY8kgSR60R/f9fUFfp
 9H8doXm3VDeHuO9BPrdoHroWzNL8FcVrxr6Mf58htgjZ9ImB4zwpUPIFnc+P/YqvYM
 YIqPFcwg0btEgdi58FTO6NMAV1LPJZpbNKQS333A=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, eblake@redhat.com,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH v2 26/33] qapi/tpm.json: docs: width=70 and two spaces between
 sentences
Date: Sat, 11 Oct 2025 17:04:32 +0300
Message-ID: <20251011140441.297246-27-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251011140441.297246-1-vsementsov@yandex-team.ru>
References: <20251011140441.297246-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 qapi/tpm.json | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/qapi/tpm.json b/qapi/tpm.json
index 3f2850a573..efa7addd78 100644
--- a/qapi/tpm.json
+++ b/qapi/tpm.json
@@ -175,7 +175,8 @@
 #              "options":
 #                { "type": "passthrough",
 #                  "data":
-#                    { "cancel-path": "/sys/class/misc/tpm0/device/cancel",
+#                    { "cancel-path":
+#                        "/sys/class/misc/tpm0/device/cancel",
 #                      "path": "/dev/tpm0"
 #                    }
 #                },
-- 
2.48.1


