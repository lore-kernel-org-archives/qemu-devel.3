Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75575606A332
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 19:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nnesUxGh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWIWq-00030i-Fj; Wed, 25 Nov 2026 14:19:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWIV9-0001aj-AC
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 14:18:00 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWIV3-0002Pm-I8
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 14:17:54 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c4203bbb1e9so1033622966b.3
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 11:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795634267; x=1796239067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R7gvPdDdW4g0ZfmIpRNGoRMBCil7VRNFeBNhRqfU4DY=;
 b=nnesUxGhDDGKYSQck9N+FClNd8ey62w4f0oE0CVujNRiy1EQrq6PjFCE7yFP5iwaaC
 9PaZ2so/6WHVWyDM7+jk+oZOg0BKi16aCxLvdYX2/J7KgQbdwnI7hs4yxRplkY/XS9u6
 jG46zJ1Ctpsorl+eeQzO8EAfInRVl7z7DGHsrykz0AEC/vMeURxZI3uSLi0MBQRO3vj6
 ydgkkcA3OQMb72E0fjJ3miPl+zhLUBOAqzEtLpvlGp2JiCyjYbUBMAn6DztQQdCCNRwU
 Y78iXTeLW+ss2XutZD+0pdFWB3LoeNiDqTj1wA6+vDp1X7T5e50+Wh7qtorxqHgn1pnW
 lySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795634267; x=1796239067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=R7gvPdDdW4g0ZfmIpRNGoRMBCil7VRNFeBNhRqfU4DY=;
 b=giKUhdFd5BJZ+OfrZe17FnYKvS723Ghr8Q96ts/JRvEgs9FhxjbJlZE37ZlQyRttF9
 3eJw56xAeaPmrR67bu2pum/sI6SQ0iHfMblGNxXgcyHoOdJg/y8XKF7HINI73x4PhQ47
 lI6yG0P5QGbIuNC5FW+E8mXQM7oDF5c8bmeIozrh+clXwrqhOPkf4uc3KwCsVwQewplJ
 7J5lZZEvpvIjXw2Ngmu1RTtJq+H7jA25+R1+8NjH6LIBPqQv6c/awz4B8ySgQYA7wNjg
 BHM5rz13MCEPnKkkviTxzdXWeuwvUeIl1jYoROD0tkrbxcprLl+PEAqqRJ1PnDH6Seyu
 0zVA==
X-Gm-Message-State: APuU4Z8wf6EMrgl8Oq6ix+o3Q7ENCMM8HFGOk/BSoTVolgiU96824ot+
 MVXUgUaYTd/SzRskJk2PFO3aoQpKbs91Tilzjqfbt1T9NvSEXNYIZjIP9NprfLpQzkE=
X-Gm-Gg: AZFdTZfe1wxEGjK1BeLhpB8uYIT0qECa3+7E70QF3nFn2o2D9/HUNDR0vCmKwY1ZtnQ
 TWR6sJ+vcvQA0caCXW8fK9Necu7jbYZVbDUYk9Bod33G4jBgaIlVj3Ncs5hBUD+a8bt754GgK2L
 o1udtQhuz7fpBvGYgGZdrIYk5GRhBwJUQ9nO+4A/nIWmnn9u4z+fYYI/57dnKPC1Nm5pgwopBI0
 MEhYKj0JVY+JvqoBHAEJ/RbeADMxfi7rRDx1kbC3agKuzNWKamUesOdAlIItirdtHrAcwnPRaSz
 liYXjz8bTlbbER+02eKfP51luaJbBr9eG/RyzEGgkT+bYIG7djNQIl8l4QGC5ciZ9MlJegmq1T1
 hIQwVQUf+wQPedZmc2E2vX98w6gctKi953jhNW68/m7ZKgRX1lEbs3ahfvHUVw70QuEFxVucpYW
 sfN/dnmahDNh9mlS0RKmqkn0HgKU5CVwE/YA24zQrnlbh34aCFEF3WiMWbxg2P+7lrFcE0BqMiQ
 CHJ8NmgF9a0WqeIQAwXnu3XF7Bj6ea8Mhepyu40bbYBT8W0gmsIFLhte8ro08L8V+NbTbLcBx+0
 AqyWQUIMUKDoCH8LoYCIDW9hDyYPSNIMYWrs/W0aosqPhI+mQKSeE4xvZYyRd8sjyJePgjoHX16
 vw6d/4GY0iHGLF43I+qMtimzwzXDDmIIivSxzTWE=
X-Received: by 2002:a17:906:7c2:b0:c50:f0fe:438a with SMTP id
 a640c23a62f3a-c513a5e2526mr1302465566b.8.1795634267321; 
 Wed, 25 Nov 2026 11:17:47 -0800 (PST)
Received: from tulp.my.domain
 (2001-1c02-1a15-3000-2727-f7d1-9628-aa81.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513b003eacsm672686266b.81.2026.11.25.11.17.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 11:17:47 -0800 (PST)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH v2 10/10] iotests: fix test 211
Date: Wed, 25 Nov 2026 20:17:00 +0100
Message-ID: <20261125191701.93931-11-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261125191701.93931-1-bogorodskiy@gmail.com>
References: <20261125191701.93931-1-bogorodskiy@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


