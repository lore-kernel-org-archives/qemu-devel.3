Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B1AC88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 16:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x69wn-00063p-GK; Mon, 14 Sep 2026 12:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1x69vc-0005im-Tj
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 12:53:16 -0400
Received: from v512.v5f06b487.use4.send.mailgun.net ([143.55.232.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1x69vb-000509-7v
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 12:53:12 -0400
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 efda66be99d8ccf263d823feadc39e8b5359ad180ac14f2f331762a08144cf11 with SMTP id
 6aa82675bbda3fbb0e72db35; Mon, 14 Sep 2026 16:53:09 GMT
X-Mailgun-Sending-Ip: 143.55.232.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1789404789;
 bh=TdEWDEl78ihzRItaIHSwcRK+bm41OdIHOlh63OrtTew=;
 h=X-Mailgun-Dkim:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:X-Developer-Signature:
 X-Developer-Key:Content-Transfer-Encoding:From:Reply-to:Subject:
 Date:Message-id:To:Cc:Mime-version:Content-type:
 Content-transfer-encoding:In-reply-to:References;
 b=f5PIudeTbDQenTcSf+TXg8v+5JiBNTspFc5X2n7Y/0d/hO2+uBikYV6AVpeHcORov
 sWJEOeKXj4sUcV2P2tPZfJybPsEDbjc6J+j5GsSP9I+ZJYMGHfOX3JkE/y9mMzhpwo
 GclGJegZwHYxFUdDyn/FygaforAFNmMv2CYAgAXdhbAZTfEI68r+//mnYp+Mq+b3a6
 Y+9JDu6fPjBDdDG2ePtvYfNZWoKBJje8Aeofyvg1/8/IqWfpJc2BZCg+NjS8FO0G/R
 4jMCVx6+t5yXnlGRoj7Z0XNZZi2cB+seAn1Wg9UutKWBm5WQzu4kzkz7WCLuiUfck7
 a+vK7JxHQ9ypQ==
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: "Yodel Eldar" <yodel.eldar@yodel.dev>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Yodel Eldar <yodel.eldar@yodel.dev>
Subject: [PATCH 2/2] tests/functional/x86_64/test_vhost_user_bridge: Eliminate
 stdbuf usage
Date: Mon, 14 Sep 2026 11:52:50 -0500
Message-ID: <20260914165250.88382-3-yodel.eldar@yodel.dev>
In-Reply-To: <20260914165250.88382-1-yodel.eldar@yodel.dev>
References: <20260914165250.88382-1-yodel.eldar@yodel.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1439; i=yodel.eldar@yodel.dev;
 h=from:subject; bh=aNJqAWLNRvSUteo1BEriXIOyjmKcty/65Mwvnkr//3U=;
 b=owGbwMvMwCU29Z3/drNU3zWMp9WSGLJWqFa/9TjPEPxuh2re/clLFoVG7loxuW/Lm233jSbGN
 GsWfTl+uaOUhUGMi0FWTJHl8lmJsw65u7vSVv64DzOHlQlkCAMXpwBMJDGQkWF9x9H5c6eIGazn
 3WV96R9Lbih7z7wTxRlbM7kkl2y8eiyL4b//+tCcVimXNysaVXSvZaWumeB24eOVmLZUiX9Lj1u
 +/8kHAA==
X-Developer-Key: i=yodel.eldar@yodel.dev; a=openpgp;
 fpr=D3CD18CD406DBB8A66A9F8DF95EE4FB736654DAC
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=143.55.232.12;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=v512.v5f06b487.use4.send.mailgun.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HELO_STATIC_HOST=-0.001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

From: Yodel Eldar <yodel.eldar@yodel.dev>

Usage of stdbuf triggers a runtime error when vhost-user-bridge
is built with ASAN. Now that vhost-user-bridge writes debug
output to stderr, stdbuf is obviated; remove its invocation.

Message ID of relevant thread:
<20260906-nohmp-next-v1-2-2b21e63974f3@redhat.com>

Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
---
 tests/functional/x86_64/test_vhost_user_bridge.py | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tests/functional/x86_64/test_vhost_user_bridge.py b/tests/functional/x86_64/test_vhost_user_bridge.py
index c36c625420..5e1db48884 100755
--- a/tests/functional/x86_64/test_vhost_user_bridge.py
+++ b/tests/functional/x86_64/test_vhost_user_bridge.py
@@ -76,12 +76,6 @@ def configure_vm(self, ud_socket_path, lport, rport, hostfwd_port, tftpdir):
     def assemble_vubr_args(self, vubr_path, ud_socket_path, lport, rport):
         vubr_args = []
 
-        if (stdbuf_path := which("stdbuf")) is None:
-            self.log.info("Could not find stdbuf: vhost-user-bridge "
-                          "log lines may appear out of order")
-        else:
-            vubr_args += [stdbuf_path, "-o0", "-e0"]
-
         vubr_args += [vubr_path, "-u", f"{ud_socket_path}",
                       "-l", f"127.0.0.1:{lport}", "-r", f"127.0.0.1:{rport}"]
 
-- 
2.55.0


