Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615C0606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 19:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=psSOAge+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWejk-0008Rt-MF; Thu, 26 Nov 2026 14:02:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWejF-00084M-Ar
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 14:01:58 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWej9-0005EK-8C
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 14:01:53 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c4d427836e9so971236966b.1
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 11:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795719706; x=1796324506; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=38dWrsSr7dq7CGW7X5t+PZK65OCbdGdS+3mjFfeGmUY=;
 b=psSOAge+TIlXoMu+/HAUCux7p4TNb2tgMW0DxEJ916kc0f+VvytR55f9HTUjFC3/2d
 fq31G0vzy3cD56TU3RaetzSYWV88TLhaVBsutDwK5fjDHQwjFSciWMcyFGdryDobplC6
 YFeyNSbvmbqqlojlboguehzI/bPRalF1jC+UljJWP9FYsU+rO8yCeqVUJw8lo5g68oNU
 Eu+MotC9/JyhDE40dXBeMyK3soMmscCVGHaaRcYwK+oVzfvY27/cUROuc3mBCxxlZS1B
 hwESHzIallAWwO24frXup4i0w+LPCHP81giZ5VjJmxyReEHnzOm1JI9ShlYMCgdo2TRZ
 dQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795719706; x=1796324506;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=38dWrsSr7dq7CGW7X5t+PZK65OCbdGdS+3mjFfeGmUY=;
 b=D0DjpYYiicp/HP7cxeB6Ai73klp3qhp07jDbmNkzt6mueq1zJoN7/LMM/y4+qaVOEl
 rBX1DdMPq1+nNTU8cDI1Wao+OQe/ZeeucNkFhXJbIhbXNsjgVBVjJnHERfb0QJ8ADvpM
 eAdaKEARe7EsyXTVMabrp8D3e7KeCDMOljZBh7u+WgcQTlO0KR01gGWNJrZAFYeo8K4f
 Rx6BRz5kl2WTnKklxY/ag27LaQyeqeo7JNCg74VgtNU0HrbYIlfjBmh8+J2d6a0U36Kk
 iT/Eu4tZJlNqHV1ZMId/2M0YjTawILIsGm/vKp/hrr0TTkI1H7Voy++YaGNLHLTYsx1P
 B9mg==
X-Gm-Message-State: APuU4Z/W6EQTBRY7AVKTTTyJthVhSq1QilKwhXuv9R50LMNQfgEa6S52
 jRd0li38w93S54AsEU43qdkdKRhE0TZoK2KMkUljO5lbkK2DKs3UcZHerS4C8BbjY+g=
X-Gm-Gg: AZFdTZenrbCqTgfEp0ra+zDyJojDDywMt5+7nHPxEib/+r9Ce5Zg1C6ERd1+eF7mYKY
 shWx1WRKuxMnF9Jwy4mWnaszbzGbLaaAx5uBGaWszYVtmMOnZcRl3gtd9Tq08qprwrPs9jSipDA
 +TH5xH2eh+qXzJEAkSktc54gsdBlGf76ee5iuMLAMf5rfUhz6OYIex2AhcnDiv5xeSjFeJmhEX9
 /02KNlDx5uJXDYeUptmR+E7We8vY0ERl7j4VkF4mZp8Ou7+cuVj32eDBmxJZfCgObWvWqIajirY
 1Fye+WWvAJRTjlthsL/88rUFx/coEmI8A5whN0OvxjZAlVFUkt55RS2bJzkp+N5euHv20GEZ1Y6
 vGp+xEhvcnFB/217/gayi4+pYPifYtBa2Sk8vMHNkZvPsiR77WAsu9sIGJBIxtViPheroKsLD6D
 Ot3PRr+vQ/yMgHjXU4Al3QW0AtloNPhUdddSbEiK5RJNHHeqZkS4iDtaKGKjB+M4Z1g+ghG8svO
 G2lt9+sUDckO2gFcZZU9QiOr2aD0/68DdHkCozIisOeAocCAnnL83WQDQv4j3JRsrFmoh3HQTkR
 XCq+V1xFwAhCZiYKR319oflA/DMoE5vPhTnF
X-Received: by 2002:a17:907:6d15:b0:c51:5589:2ff2 with SMTP id
 a640c23a62f3a-c5155898309mr1525215766b.9.1795719706502; 
 Thu, 26 Nov 2026 11:01:46 -0800 (PST)
Received: from tulp.my.domain ([2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ae6663esm786278766b.21.2026.11.26.11.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 11:01:46 -0800 (PST)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH v3 10/10] iotests: fix test 211
Date: Thu, 26 Nov 2026 20:00:53 +0100
Message-ID: <20261126190054.40844-11-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126190054.40844-1-bogorodskiy@gmail.com>
References: <20261126190054.40844-1-bogorodskiy@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Test 211 compares "qemu-img map" output against a fixed expected layout.
As this layout depends on the host filesystem, the test might fail.

Move away from direct output comparison and ensure correctness by
asserting the essential fields.

Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qemu-iotests/211     | 19 ++++++++++++++++++-
 tests/qemu-iotests/211.out |  1 -
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/211 b/tests/qemu-iotests/211
index 1a3b4596c8..0b1fa7b33d 100755
--- a/tests/qemu-iotests/211
+++ b/tests/qemu-iotests/211
@@ -107,7 +107,24 @@ with iotests.FilePath('t.vdi') as disk_path, \
     vm.shutdown()
 
     iotests.img_info_log(disk_path)
-    iotests.log(iotests.qemu_img_map(disk_path))
+    img_map = iotests.qemu_img_map(disk_path)
+
+    assert len(img_map) > 0
+    assert img_map[0]['start'] == 0
+    mapping_offset = img_map[0]['offset'] - img_map[0]['start']
+    for i, ext in enumerate(img_map):
+        assert ext['length'] > 0
+        assert ext['compressed'] is False
+        assert ext['present'] is True
+        assert ext['data'] is True
+        assert ext['depth'] == 0
+        assert 'offset' in ext
+        if i != 0:
+            assert ext['offset'] - ext['start'] == mapping_offset
+            assert img_map[i - 1]['start'] + img_map[i - 1]['length'] == \
+                    ext['start']
+
+    assert img_map[-1]['start'] + img_map[-1]['length'] == size
 
     #
     # Invalid BlockdevRef
diff --git a/tests/qemu-iotests/211.out b/tests/qemu-iotests/211.out
index ff9f9a6913..caf5caae5e 100644
--- a/tests/qemu-iotests/211.out
+++ b/tests/qemu-iotests/211.out
@@ -53,7 +53,6 @@ file format: IMGFMT
 virtual size: 32 MiB (33554432 bytes)
 cluster_size: 1048576
 
-[{"compressed": false, "data": true, "depth": 0, "length": 3072, "offset": 1024, "present": true, "start": 0, "zero": false}, {"compressed": false, "data": true, "depth": 0, "length": 33551360, "offset": 4096, "present": true, "start": 3072, "zero": true}]
 === Invalid BlockdevRef ===
 
 {"execute": "blockdev-create", "arguments": {"job-id": "job0", "options": {"driver": "vdi", "file": "this doesn't exist", "size": 33554432}}}
-- 
2.56.0


