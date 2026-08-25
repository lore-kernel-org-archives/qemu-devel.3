Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2917C61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wypMz-0006NG-SX; Tue, 25 Aug 2026 07:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wypMR-0005eD-Ix
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:30:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wypMN-0006Wp-As
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787657430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=30yn/c+wt/bT8D/y3U/P9jFrQ+FxGSkq4u+zKm/7UQc=;
 b=EUScvauJBRUFtdoZ2k+rUH76uck4HZSHDlHAbczBRBgyl5wkM0mIaObwkBhC2dpawHHqxe
 yfy8op5WJ+KeoM+ErzRd49Y9mxicFwJux7rsXuWGpuTFEmVxsFTMu4yRDfql4FIr21mujg
 6wDOQ97rspTSMnlX5nug9iBDacy39NI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-7bDGwIqnPWG6xuyR7imlDw-1; Tue,
 25 Aug 2026 07:30:27 -0400
X-MC-Unique: 7bDGwIqnPWG6xuyR7imlDw-1
X-Mimecast-MFC-AGG-ID: 7bDGwIqnPWG6xuyR7imlDw_1787657427
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1AB321800877; Tue, 25 Aug 2026 11:30:27 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CC45230002EF; Tue, 25 Aug 2026 11:30:25 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 15:21:09 +0400
Subject: [GIT PULL 19/19] hw/input/ps2: say why unknown keyboard commands
 draw a resend
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-fixes-v1-19-c59e8a620836@redhat.com>
References: <20260825-fixes-v1-0-c59e8a620836@redhat.com>
In-Reply-To: <20260825-fixes-v1-0-c59e8a620836@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1209;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=BTCwLkEhXu+eBXujb6Fbe5sGYtMzBGPyeDMAYsbUyS0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjXrVVMowQ6YgR7nqdZXzDD4gjnS/zJh82xGQF
 TimzfPdvPKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao161QAKCRDa6OEJdZac
 5RgID/9zDb6/oGRgu/Ah2TJ8IK+tbgCprN6voaBqheuvyyYnO48UXjuEsdyBRzt/OhzRoPP+AB4
 EULYOel8oSCPkOhUvAAapa7uCi+NOFwJAHKnnStcbcasjygTr/LflRdi7TSbQvcuS0CnQ8hZoOp
 18wBR2O+N1EiAzaqWROMkGHOHylojqb2sHpqt6n38kjTv6tFx3wmLHcDyxs8OC9p7WFQ3/DZKRg
 hWEwzMKrK77MeZmGQqm9uI0pb6C1bUFQQiYayjZrGM7Cf7bKXoYb8IlrPCu1Cug08ooU5H1K7uJ
 z4GkuvHzJRl5GE/+Af6P/fXSivDgwI+o0yZXBk0HU0TeWWFTuo4tA/aa9+vD2i9rS5X6hEq2McQ
 d0MUUPxx/KjxK2ypz/pLECLAmZUbxBOP8F4XtyqjRuDv2Kc9VSih+z2dlJYSQYenzT1OOceg3r4
 Mg9nlWbRIYiN6PJBHDUF34QpaJon1Lg6Qcbx5M41MUJ0WdbizGNZ/MPrQq3EqvlN/b6/WQZctT7
 sgrswurKNvKC9RG2OU5XY4/dgntqWnguIO2eChfsvgsXAtTfMbRqwGz5N33ctGTV8hEf9bOgTpX
 Z7dskfzt8+dy0rp0m1eW68aq4lXxfKR4B0AiRvbey+VHpLbbT7fY+sVR9J33UdsM4cL5uOglamg
 ZL9hydcZCApMsYg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Christian Quante <christian@quante.one>

The keyboard path has answered unknown commands with KBD_REPLY_RESEND
since commit 06b3611fc2a3 ("ps2: reject unknown commands, instead of
blindly accepting them"), but never said why. Give it the comment the
mouse path just gained, so the reasoning is written down in both
places.

Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Christian Quante <christian@quante.one>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <20260825075127.34876-3-christian@quante.one>
---
 hw/input/ps2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index e8300d2d8308..01af4350b3bc 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -647,6 +647,10 @@ void ps2_write_keyboard(PS2KbdState *s, int val)
             ps2_cqueue_1(ps2, KBD_REPLY_ACK);
             break;
         default:
+            /*
+             * A PS/2 device answers every command it is given; an unknown
+             * one draws a resend.
+             */
             ps2_cqueue_1(ps2, KBD_REPLY_RESEND);
             break;
         }

-- 
2.55.0.543.g5ebe2ebe4ea8


