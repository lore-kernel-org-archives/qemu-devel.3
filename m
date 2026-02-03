Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B191E8784C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 18:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnL2k-0000e8-Fz; Tue, 03 Feb 2026 13:22:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vnL2j-0000dr-5k
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 13:22:29 -0500
Received: from k62.kb8c70eb.use4.send.mailgun.net ([204.220.184.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vnL2h-0003Vs-P8
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 13:22:28 -0500
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 d5625f92ec748e676b1e2ef6343905c72ce53dd557a099c8ab9643e246702dba with SMTP id
 69823cdb39c23bd66636a5ad; Tue, 03 Feb 2026 18:22:19 GMT
X-Mailgun-Sending-Ip: 204.220.184.62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1770142938;
 bh=CmoOMUsHxA+OPz/QIS9zmLkYe3g6/ZFRWRSxshy6GEo=;
 h=X-Mailgun-Dkim:From:To:Cc:Subject:Date:Message-ID:MIME-Version:
 Content-Transfer-Encoding:From:Reply-to:Subject:Date:Message-id:To:
 Cc:Mime-version:Content-type:Content-transfer-encoding:In-reply-to:
 References;
 b=QHONZ6SfLbyEKCYI+mWf5sVNh/jjsc/oM8n8lsittEDlPsB/mw0G0Icls4TQNq2nd
 D41PlGR784ZRywdP9wgRDUtQii7kLwlzYZFpqV+M3HNZxXiyDLj6QbxsECwJffZdWG
 9GXhRSOIXPSyQ6SIIJdYp83WUyk+FLEaHB50NNZTxPOiPhutgmgTS4sCxV/3fbKu7p
 pyP2w69oCZ/AdTj/fyNUx+Rk21kvEbzpfiZCl+4Qfrolpqx83cMutaeWL3TxMd1Y4T
 InMYmqcDDBUffidapskM1ht2SnWguUooOere6g962pRuk2hQ3SYrtQUksUjhcT3k1c
 PYlNTUpnx3Nhw==
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
 Yodel Eldar <yodel.eldar@yodel.dev>
Subject: [PATCH] tests/.../reverse_debugging: Remove unsatisfiable condition
Date: Tue,  3 Feb 2026 12:21:53 -0600
Message-ID: <20260203182153.75276-1-yodel.eldar@yodel.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=204.220.184.62;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=k62.kb8c70eb.use4.send.mailgun.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

get_qemu_img() already skips the test if qemu-img is not found and does
not return None. Eliminate the check for None on its result, and the
unreachable skipTest() gated by it.

Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
---
 tests/functional/reverse_debugging.py | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tests/functional/reverse_debugging.py b/tests/functional/reverse_debugging.py
index 8e6f0b0e92..eaf178da49 100644
--- a/tests/functional/reverse_debugging.py
+++ b/tests/functional/reverse_debugging.py
@@ -73,9 +73,6 @@ def reverse_debugging(self, gdb_arch, shift=7, args=None, big_endian=False):
         self.log.info('creating qcow2 image for VM snapshots')
         image_path = os.path.join(self.workdir, 'disk.qcow2')
         qemu_img = get_qemu_img(self)
-        if qemu_img is None:
-            self.skipTest('Could not find "qemu-img", which is required to '
-                          'create the temporary qcow2 image')
         out = check_output([qemu_img, 'create', '-f', 'qcow2', image_path, '128M'],
                            encoding='utf8')
         self.log.info("qemu-img: %s" % out)
-- 
2.53.0


