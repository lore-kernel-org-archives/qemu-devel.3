Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6F5C53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 09:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp0do-00057c-73; Wed, 29 Jul 2026 05:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wp0dm-00056x-7L
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 05:31:54 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wp0dj-0007kl-UH
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 05:31:53 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 27FE5C0161;
 Wed, 29 Jul 2026 12:31:50 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:484::1:24])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id kVacraKWFGk0-CaHBnQTP; Wed, 29 Jul 2026 12:31:49 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1785317509;
 bh=kpFI+Sq6hDSo9FArcBTmOvsw9J/vVjMk1ZhQtqh1Iv4=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=uTOhE7A4ahz/h87Ooed9aZnRhzzdGBPum8JNRcfBGpgLiEZhTlhDRPPQQo+r4lLJB
 AamW4CHqTnK/Rjk19RSi16yYnn1wUasVr+9DBlQpAPC3lj0UZ+q3S/1csEkMwsdtQ6
 Y8CnPnmaiKJ/Cdo6IPaP/gGlkNovOH1QRYoEUu6E=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH 2/5] tests/functional/qemu_test: drop *args argument from
 .get_vm()
Date: Wed, 29 Jul 2026 12:31:42 +0300
Message-ID: <20260729093146.1893719-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729093146.1893719-1-vsementsov@yandex-team.ru>
References: <20260729093146.1893719-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

It's redundant. Only one caller use it, and it may be simply
substituted by .add_args().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 tests/functional/migration.py          | 3 ++-
 tests/functional/qemu_test/testcase.py | 9 +++------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/tests/functional/migration.py b/tests/functional/migration.py
index 4344e03be41..8d2428efc24 100644
--- a/tests/functional/migration.py
+++ b/tests/functional/migration.py
@@ -63,7 +63,8 @@ def migrate_vms(self, dst_uri, src_uri, dst_vm, src_vm):
         self.assert_dest_vm(dst_vm)
 
     def migrate(self, dst_uri, src_uri=None):
-        dst_vm = self.get_vm('-incoming', 'defer', name="dst-qemu")
+        dst_vm = self.get_vm("dst-qemu")
+        dst_vm.add_args('-incoming', 'defer')
         self.configure_machine(dst_vm)
         dst_vm.launch()
 
diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index e4179d165c0..12ef84281c4 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -381,7 +381,7 @@ def require_device(self, devicename):
         if helptxt.find(devicename) < 0:
             self.skipTest('no support for device ' + devicename)
 
-    def _new_vm(self, name, *args):
+    def _new_vm(self, name):
         vm = QEMUMachine(self.qemu_bin,
                          name=name,
                          base_temp_dir=self.workdir,
@@ -394,20 +394,17 @@ def _new_vm(self, name, *args):
             vm.add_args("-chardev",
                         f"socket,id=backdoor,path={sockpath},server=on,wait=off",
                         "-mon", "chardev=backdoor,mode=control")
-
-        if args:
-            vm.add_args(*args)
         return vm
 
     @property
     def vm(self):
         return self.get_vm(name='default')
 
-    def get_vm(self, *args, name=None):
+    def get_vm(self, name=None):
         if not name:
             name = str(uuid.uuid4())
         if self._vms.get(name) is None:
-            self._vms[name] = self._new_vm(name, *args)
+            self._vms[name] = self._new_vm(name)
             if self.cpu is not None:
                 self._vms[name].add_args('-cpu', self.cpu)
             if self.machine is not None:
-- 
2.43.0


