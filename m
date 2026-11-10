Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613CC606A325
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 18:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=Qg/YQwdW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQqei-0005Q6-Po; Tue, 10 Nov 2026 13:33:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xQqef-0005O2-3W
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 13:33:13 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xQqec-0003NP-00
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 13:33:12 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-4918c2d727fso1298666f8f.3
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 10:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1794335588; x=1794940388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+E13g80s30L9W/BYkJ3BK+ngM9SB5aSpfwYclbX7M68=;
 b=Qg/YQwdWfMWNm036hyYQsystU88QPglCK0hCOqAAAqPpY4eC+U0YlZnpmwrkGaJSVV
 cBO/7O0y3R/hkRD1fbw3W/kmjJNILAP8i5Q9z9zw5xMXdcdQLXgqaVrkMHti/0SpY3d2
 U8Neb0+0pi2iv2TOIhxsoMlmzWEL7DL3bT+CchVOBhpydt13w8G7oviBkeqlML8zJ5/D
 Y9uZL7eyYaslB3vlMK39BnDOhbMoi7PyCHXDDBX6z4btsEdfHwrYDeJF6muJznBz9QvW
 pDopIQTR0lHz+DEPkztvrb9JEMo95ITl6lLkViBZRNaFR05T1wfGXNylYaTCWSAYKfC0
 2S7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794335588; x=1794940388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+E13g80s30L9W/BYkJ3BK+ngM9SB5aSpfwYclbX7M68=;
 b=W1hX4zn7oGz2Njcjw0Sm7wLxyvjlc8/GBkoMes/XBFRdNZkejn2k+j1pUzeOOPBpq6
 FewoyM8QAzcBDvy4Ceo3AwTKTOeV+dKRmcVHTKmCOuaUrthULPQB+baP+rbbz8Dch8bQ
 D/qPgly4PubeI4eT73BuFMLWVYZvkvycUPrx+rLxzx4azd2vABuGhTaVqL+ETbei1Qyk
 cCDMXLVe6K6y11HCi9lBeU48OUAOvTxkW+w7P7waR5t26KjQg4/Y4IGieuRhZCoZPOUb
 zrdsdkrnPqPzRt/BQ0atLLOZ8k9NKNk5nWdJjAas7JSIzwplOZOWR2QD8G3Ciswasy4Z
 IloA==
X-Gm-Message-State: APuU4Z+UR3K/t5PGLliyYfIUuQvCaqMlQ/2yrw5nimLaJVGb3gCGdYp7
 OzL6ECmrjRmyBaRTyRGY19S2Buc6CND1u9k9pASU7OFIlbZhLPxqT4jXakRVYH9gaiGqycNcrUz
 +CIW0
X-Gm-Gg: AYBFou0YObmW9xLxwLIEjRP4MqvklFphWerpS6wjFRrPpnRtrSFU6yPwnYzCzWkLgiY
 B0W1f4mQgfr5T73ugi58ZIhDleaf3K5WczZ2jtGTE5WMaJQk4rhRopUSvSFPAHRuvcQ8CeXpXuu
 zef22ZA4N/Px/71M1FprisV5g/AJPVKQTMuOmm+bBIBFXjwVCr+0wQKdC/S+899PCLMEYA9vZdR
 /FZAJhGuLV7zCzatBYM6gHjjEIHHN/gfOtjt9HvAXlB7y7tRehp8xoMdSle5YcCIvQCRX2kk+fx
 dv0SXCAztD5KP0kFKTKPMm1hJUpzgoAsDNEwSfTjtHOED76R0WclQ6IbI2qkE0rauj6n/DV92Hl
 UleUG9vwRYxMjeEIaRwbhOu3sz+e3bG2gm9phrfjovHXXZZSCZCReiECMyTx/33ZgjsdPETd8J2
 sZ/BnzPyY+XdRREuuIZrXsuepfNX9MgZNNA8Ajpwuwny1Zn8AlnCBToSdYNDe0pDZzo6nrTUCzv
 Uj2BCpEUVJR9Hy/EK0yL1JpU/GeilZHXrMrtSZVdEpAd1YbHZlFS+d+JetC3K5CQQ8txntorwZx
 8TFlC477184IIE05zkM3pl9YKQ==
X-Received: by 2002:a05:6000:230b:b0:48d:fdd0:6ce8 with SMTP id
 ffacd0b85a97d-4982b28a797mr7863741f8f.3.1794335588148; 
 Tue, 10 Nov 2026 10:33:08 -0800 (PST)
Received: from athena.sw.ru ([2a06:5b06:b600:300:4f78:6441:d0f1:22af])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498363df7a5sm6384827f8f.37.2026.11.10.10.33.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 10:33:07 -0800 (PST)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH v2 5/5] iotests/migrate-bitmaps-postcopy-test: cover postcopy
 with a return path
Date: Tue, 10 Nov 2026 19:32:57 +0100
Message-ID: <20261110183257.2930908-6-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110183257.2930908-1-den@openvz.org>
References: <20261110183257.2930908-1-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=den@openvz.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Denis V. Lunev <den@openvz.org>

The test migrates through an exec: fifo, which has no return path, so
the source never waits for the destination's package-loaded pong.
libvirt enables return-path for every migration that is not tunnelled.

Add a case that migrates one bitmap over a unix socket with return-path,
unthrottled, and waits for the source to enter postcopy-active, so that
the bitmap really goes through postcopy, and then for both sides to
complete. It times out when the destination answers the pong from the
run BH while dirty_bitmap_load() holds its lock across stream reads.

The existing cases are not run with a return path instead. They
throttle the source, which lets the run BH take the lock between
sections, and with a return path the source notices the destination
shutdown and resumes the VM, as each VM has its own image.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Juraj Marcin <jmarcin@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>
Cc: qemu-block@nongnu.org
---
 .../tests/migrate-bitmaps-postcopy-test       | 39 +++++++++++++++++++
 .../tests/migrate-bitmaps-postcopy-test.out   |  4 +-
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test b/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
index 53f7dafc79..a6e21dec0a 100755
--- a/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
+++ b/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
@@ -31,6 +31,7 @@ disk_a1 = os.path.join(iotests.test_dir, 'disk_a1')
 disk_b1 = os.path.join(iotests.test_dir, 'disk_b1')
 size = '256G'
 fifo = os.path.join(iotests.test_dir, 'mig_fifo')
+mig_sock = os.path.join(iotests.sock_dir, 'mig_sock')
 
 granularity = 512
 nb_bitmaps = 15
@@ -299,6 +300,44 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
         check_bitmaps(self.vm_b, 0)
 
 
+# libvirt's configuration: the source waits for the destination's pong
+class TestDirtyBitmapPostcopyReturnPath(iotests.QMPTestCase):
+    def setUp(self):
+        qemu_img('create', '-f', iotests.imgfmt, disk_a, '1G')
+        qemu_img('create', '-f', iotests.imgfmt, disk_b, '1G')
+        self.vm_a = iotests.VM(path_suffix='a').add_drive(disk_a)
+        self.vm_b = iotests.VM(path_suffix='b').add_drive(disk_b)
+        self.vm_b.add_incoming('unix:' + mig_sock)
+        self.vm_a.launch()
+        self.vm_b.launch()
+
+    def tearDown(self):
+        self.vm_a.shutdown()
+        self.vm_b.shutdown()
+        os.remove(disk_a)
+        os.remove(disk_b)
+
+    def test_postcopy_success(self):
+        self.vm_a.cmd('block-dirty-bitmap-add', node='drive0',
+                      name='bitmap0', persistent=True)
+
+        caps = [{'capability': 'dirty-bitmaps', 'state': True},
+                {'capability': 'events', 'state': True},
+                {'capability': 'return-path', 'state': True}]
+        self.vm_a.cmd('migrate-set-capabilities', capabilities=caps)
+        self.vm_b.cmd('migrate-set-capabilities', capabilities=caps)
+
+        self.vm_a.cmd('migrate', uri='unix:' + mig_sock)
+        self.vm_a.cmd('migrate-start-postcopy')
+
+        match = {'data': {'status': 'postcopy-active'}}
+        self.vm_a.event_wait('MIGRATION', match=match)
+        match = {'data': {'status': 'completed'}}
+        self.vm_b.event_wait('MIGRATION', match=match)
+        self.vm_a.event_wait('MIGRATION', match=match)
+        check_bitmaps(self.vm_b, 1)
+
+
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2'],
                  unsupported_imgopts=['compat'],
diff --git a/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test.out b/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test.out
index 8d7e996700..89968f35d7 100644
--- a/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test.out
+++ b/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test.out
@@ -1,5 +1,5 @@
-...
+....
 ----------------------------------------------------------------------
-Ran 3 tests
+Ran 4 tests
 
 OK
-- 
2.53.0


