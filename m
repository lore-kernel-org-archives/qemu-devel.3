Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17506C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2026 05:07:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdLFc-0004H2-2I; Sat, 27 Jun 2026 01:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wdLEz-0004Fo-Hb
 for qemu-devel@nongnu.org; Sat, 27 Jun 2026 01:06:09 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wdLEw-00005f-0F
 for qemu-devel@nongnu.org; Sat, 27 Jun 2026 01:06:04 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65R55fSE031006
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 27 Jun 2026 14:05:45 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=5sRHsxkxAtdwE1uaG+IIesix4iCIlG6M2vU+SjT5OdA=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1782536745; v=1;
 b=udM4M7LJHYsWzP2OCgKc/VpAtGskBL12iyVsvdagzOP1IAzUVrlfBrYfKTXxva0Y
 bMLOUt0KxJPZCT7k7k5eX1baz4ijw4nmok9mGo7OKE5BqwXqmpYrBLJUJ20LbIwL
 lmtj12xJvbOrE0OWpwnMorETRQmo9ZM2JzSVJbojSkKukELw+gYzAzlyK26plbrM
 /Tvgfm0SmshF2uHnpzgERW4itboKedNXOZTA6r45u6JbrTVXthmtH0ZzF95n/sYb
 S5TDVXdvspNYC4vL+91Z0A6q3zVEh/61jU1RZXcmWszgHJFaTt604doVuqeN11IQ
 kgzF4QTct9jTXnd89lR+YA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 27 Jun 2026 14:04:14 +0900
Subject: [PATCH v4] checkpatch: Check .m, .build, .in, .json, .txt and .plist
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260627-checkpatch-v4-1-f4ef0c1a9fb0@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22MQQ6CMBAAv0J6tg1dsFVP/MN4WJYCK5GSFonE8
 HeriQcTjzPJzFNEF9hFccqeIriFI/sxQbnLBPU4dk5yk1hADvtcay2pdzRMOFMvwTg8NgdD1qB
 IwRRcy4/P7HxJ3HOcfVg/7wXe9u9mAallU1uLewCsDVYNriM/FPmbeH+W4tua3OTlT1ukFoqWb
 K0BrSurEDtFrFjd5eyH1SskdZ3EZdu2F3uh9nztAAAA
X-Change-ID: 20250111-checkpatch-26ea9d86c76a
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, qemu-devel@nongnu.org,
 devel@daynix.com, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-16047
X-Developer-Signature: v=1; a=openpgp-sha256; l=1593;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=6FScv53KNQs+4sVQmknoqOVoDlPiJwW4xfVn7MqAt/0=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ5Z9lPrcM0f9yj4/XFNhHaLcu5Njd/GKO6ot/TFRr973d
 G0KqdzSUcrCIMbFICumyJJStJtbI7r2U2FCfAvMHFYmkCEMXJwCMBGjC4wMV/9dXP32wpEvL8pK
 WN6prXkx5+DBuK1WJavreVuLtRaHVzEyPDrWphz+7ILBmXnMgi6NMRu0zwjHn2TYWRTDt7zzWvs
 PbgA=
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

Check more manually-written text files: Objective-C sources, Meson
build files, templates, JSON, plain text, and property lists. The
generic text checks apply to these formats.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Changes in v4:
- Dropped ".hx" from the checked file suffixes because .hx files contain
  intentional trailing whitespace. See commit 09ce5f2d6bd6
  ("qemu-options.hx: Fix up the autogenerated rST") for the context.
  (Peter Maydell)
- Expanded the patch message to explain why the newly covered file types
  are suitable for generic text checks.
- Link to v3: https://lore.kernel.org/qemu-devel/20260604-checkpatch-v3-1-23fc7b12a7e4@rsg.ci.i.u-tokyo.ac.jp

Changes in v3:
- Rebased.
- Link to v2: https://lore.kernel.org/r/20250111-checkpatch-v2-1-db77a522ab6a@daynix.com

To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 03f35e75012c..3d37e21fb79e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -12,7 +12,8 @@ use Term::ANSIColor qw(:constants);
 my $P = $0;
 $P =~ s@.*/@@g;
 
-our $SrcFile    = qr{\.(?:(h|c)(\.inc)?|cpp|s|S|pl|py|sh)$};
+our $SrcFile =
+	qr{\.(?:(h|c|m)(\.inc)?|cpp|s|S|pl|py|sh|build|in|json|plist|txt)$};
 
 my $V = '0.31';
 

---
base-commit: b83371668192a705b878e909c5ae9c1233cbd5fb
change-id: 20250111-checkpatch-26ea9d86c76a

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


