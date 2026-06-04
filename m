Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01793CD6E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 10:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV51v-0005jN-EN; Thu, 04 Jun 2026 06:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wV51r-0005iy-5i
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 06:10:23 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wV51l-0002H9-KX
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 06:10:21 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 654A9vT7040538
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 4 Jun 2026 19:10:02 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=0sA1bqIUg9J8jqQchxiABtnCClpqepQJhF11mfu7QTU=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1780567802; v=1;
 b=Z8Jnu9+KdJVeDeCQR92P2FmQqM8o9MQ6JcD5V+9GpLWDAigy4bZYjR1/7GW1mf/o
 JUEZUzhxvlHBXZkPwY6+CQnrnINq+2bRGXg9xRkl70cjG9cpw2vtu5CTs7WpCdu8
 /AUw4BN5BzP8htNEU8WZpj8uPtep6zpBX0iou5O0K6Pbz09LaZGby6i9ipBM+Rye
 G8IZOL/wzgppRiUCIiHAaMCID9lvDUn/GfZmx1qwD3pHPkYNuBZtSErDBIcbD2v4
 FxBcGuzp7bBcczYl9QJYDXG7h4yQTGTEDhIAp/NRX8Fo2nLSA0z520HVxYzFLNm/
 /qA+xGqREMFten1WMAisLA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 04 Jun 2026 19:09:42 +0900
Subject: [PATCH v3] checkpatch: Check .m, .build, .hx, .in, .json, .txt and
 .plist
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-checkpatch-v3-1-23fc7b12a7e4@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23MQQ6CMBCF4auQWVtDx9CqK+5hWAztaCfGQlpCI
 IS7W1m7/F/yvg0yJ+EM92qDxLNkGWKJy6kCFyi+WIkvDVhjU2utlQvs3iNNLig0TDd/Nc4agnI
 YEz9lObBHVzpInoa0HvaMv/UvM6PSyvfWUoNIvaHW0xplObvhA92+71+1jdT4pQAAAA==
X-Change-ID: 20250111-checkpatch-26ea9d86c76a
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, qemu-devel@nongnu.org,
 devel@daynix.com, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-16047
X-Developer-Signature: v=1; a=openpgp-sha256; l=954;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=K9llADG5osqEvCLgOrTGa/IZLPJAGHPc/PzAN7n/gh4=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ5ai30/GzIcvb3+KYt2Z+Ofrw/XmW/j4i59X5say9kSaL
 Gf8cSWuo5SFQYyLQVZMkSWlaDe3RnTtp8KE+BaYOaxMIEMYuDgFYCITAxkZdihs+HZhNVu4xofG
 bU6/8501OS5ZMz9ZX2/4+kDjixelOowMFz+sso6alm7evGr3gqlzK3MPCH72e7Ln2oPr1szVzb2
 WTAA=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Check more text files: Objective-C, Meson, "hx", JSON, and property
list.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Changes in v3:
- Rebased.
- Link to v2: https://lore.kernel.org/r/20250111-checkpatch-v2-1-db77a522ab6a@daynix.com
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 2189db19f540..4ec74a4e9236 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -12,7 +12,8 @@ use Term::ANSIColor qw(:constants);
 my $P = $0;
 $P =~ s@.*/@@g;
 
-our $SrcFile    = qr{\.(?:(h|c)(\.inc)?|cpp|s|S|pl|py|sh)$};
+our $SrcFile =
+	qr{\.(?:(h|c|m)(\.inc)?|cpp|s|S|pl|py|sh|build|hx|in|json|plist|txt)$};
 
 my $V = '0.31';
 

---
base-commit: 2db91528542672cf0db78b3f2cc0e22b36302b38
change-id: 20250111-checkpatch-26ea9d86c76a

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


