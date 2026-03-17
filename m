Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA26BF3381F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QEE-0006HF-57; Tue, 17 Mar 2026 04:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QDx-0004qV-Qi
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:56:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QDw-0007dx-BZ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yZha2cobxbnJSN26XX9Uh5E5JAqwHkCKFFu6Rh83jWM=;
 b=c7XN2L2J8teHVhYd/yY7urwiJrWfXaCpQxhLmWNTCLW0t2zte/U9fiAXlLM6bm5OX6t7mM
 PktsXugZfRiUOEBLPX1HMyW0jfY8fvkRoSBOYCAzSTo74PjSqIMLhhjVlm6pF0ejYKJ5Fu
 VOXxWvGHogZbOzmmjXIHEQP0PrM1JwU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-8i6CQ7clNNWTVGACC_LNzg-1; Tue,
 17 Mar 2026 04:56:22 -0400
X-MC-Unique: 8i6CQ7clNNWTVGACC_LNzg-1
X-Mimecast-MFC-AGG-ID: 8i6CQ7clNNWTVGACC_LNzg_1773737781
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 692B118005BB
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:56:21 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 54CFF1800361
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:56:19 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:51:13 +0400
Subject: [PATCH 59/60] tests/qtest: drop DBUS_VMSTATE_TEST_TMPDIR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-59-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1247;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=pWmLiM6H0bHXqtHHxabbCrpUXS9tin4BcNjH23gfJYw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXdAg7c/RLYBUK3z0g47M6R2utqpTFCb7/jQ
 abK0wJMGPCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV3QAKCRDa6OEJdZac
 5XgJD/9IPxVOipz6vo+zhWTYiXPhvYiM1Brz6mHfwzg0Bt4ZOwG/cuanxcr+d9Q7X99nvudYI7P
 qxHKgLoSQeD05Ng3TEgFyMAgcMSgOeEhFhLi9ENuTttOfF5zSOz2S4wsi2eP9xq78Kibu51KGJF
 fIpl0H1RxU4HH3yvhclnfasmEj058LFxcMAvVMP+f/JnByAxNboT5N2uufVJg7mHfJXpAFWLJtr
 Z24ngQwxlBhs0eAvLpVq5IP0+HEUYA3MSOp9n07yTDpb1Pt/4y0FvlWcTinVNfr4vBlg/2fs0E+
 6SnicWFEVTpxS3g5pRBcu+pirTVlppZWAMZdumBQIwLMTuuYsctR0bGmaiOnmX/dGds8JJpMnA1
 Ou0TXaSWAiRnj+PCzuZ5DYV2etI6GNZq/JrRYIZFI3XhOP1BR3e088MjWwCfsBsSoHHiCHgjFXj
 NA7uzy1GDb+Ycc7oFC9k08Ms5ce33j7+WA6JIIlcw6gfu//LbqtKH8nVR/MUMUyyKwI3ZljEl1Q
 MoMydJxucaR6Alm89/yT8DfEuxMCk6eXcWUSBR11r8fgq+JnAqQBvyi6vy40aC+uTT2pc/IK/Rl
 raWKlGKkvCCFkgaq4NmCqhN5Ya3tv69uP1YEqVTvwnh3rtu/GS7mFYfMLCFzI2JLolo2adRTgUk
 Px8x1A/LCxQGUCA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

It can rely on the location of the temporary configuration instead.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/dbus-vmstate-test.c | 2 --
 tests/dbus-daemon.sh            | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/qtest/dbus-vmstate-test.c b/tests/qtest/dbus-vmstate-test.c
index ed4a52d0255..23d1c872f71 100644
--- a/tests/qtest/dbus-vmstate-test.c
+++ b/tests/qtest/dbus-vmstate-test.c
@@ -352,8 +352,6 @@ main(int argc, char **argv)
         exit(1);
     }
 
-    g_setenv("DBUS_VMSTATE_TEST_TMPDIR", workdir, true);
-
     qtest_add_func("/dbus-vmstate/without-list",
                    test_dbus_vmstate_without_list);
     qtest_add_func("/dbus-vmstate/with-list",
diff --git a/tests/dbus-daemon.sh b/tests/dbus-daemon.sh
index 474e2501548..c4a50c73774 100755
--- a/tests/dbus-daemon.sh
+++ b/tests/dbus-daemon.sh
@@ -26,7 +26,7 @@ write_config()
     cat > "$CONF" <<EOF
 <busconfig>
   <type>session</type>
-  <listen>unix:tmpdir=$DBUS_VMSTATE_TEST_TMPDIR</listen>
+  <listen>unix:tmpdir=$(dirname "$CONF")</listen>
 
   <policy context="default">
      <!-- Holes must be punched in service configuration files for

-- 
2.53.0


