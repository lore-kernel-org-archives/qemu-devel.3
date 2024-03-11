Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00776C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 17:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjfY-0004Cn-O7; Mon, 11 Mar 2024 13:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjjfL-0003lr-F5
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:42:27 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjjfI-0007Sl-SI
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:42:22 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6e46dcd8feaso2740628b3a.2
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 10:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710178939; x=1710783739; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rISfc8l1xBFHITbDV0m0cgRwOmIPXYSeOi4Nk95AjkA=;
 b=K3+WyGoLFGPePJmBoWNI5QY/YpnhojErT+qpLb1GKN8KMWEBiKa6MdLbfQbaJDOUob
 pLlnELhwIL7qMTSYsbNZfzwRdqCKO2IlpLeulDMsSKlFCK3jHdW+9zxyTSbrA5YNEwGy
 YtY/xE5IPW5W4pVBR8vbrjVPRU+kF8lfYrSjTSyXRU7D7/SH0L/xmWK/yvagLkKg7gw6
 lXSh8T34YuJ0gvuV3buQNSD/z57Rr241jx38M7xJukedS0e5i48TxlJ6s2vcssfhqA2Q
 oZlFlKf3RQ9nkf31my69S/9FJ/P8xAgvy3koRpiEe4hufCgRDEYj99xqHRxspv1Q1j3S
 7mmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710178939; x=1710783739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rISfc8l1xBFHITbDV0m0cgRwOmIPXYSeOi4Nk95AjkA=;
 b=vt0/beiz+tE4gyqjo7CcvfHOAXAubzR//uppkWlr/PvjQOG8IOq5jJsVl+goNfsOly
 7AOWua1JpE5S15NvGkuKB/Rh3saxalH0B64skAJ1rlqXQoPk42XR8wxIv7IfBHQXWFT0
 BFUCab/tlf0M0tab1XDE3I0NcntLdFSBJu4adkzdWDG/lNkIm7SvzV/SaDo3ehGkjExe
 SC1PN8LmurKGXUHfL7AgLZMK6JBL2KgTxpQRr65RK94/W3ktK1eypDlcDuYkHOpoysNs
 cg02ttqA+lHgdPz9OcCzddo2DZCRnW+O3QXdoiMHQ3fJWfqrT6iYF7wpwBdaS5UVX8Fg
 ztEg==
X-Gm-Message-State: AOJu0Yyu0jw2kBD5crBrLJUMOu0ZYNtc1/6o/PxtbYTro4tT7fati11C
 vggKjcqzLCmXqENc5F8PxMO8E3J+1XuzS7z242H3FKbqLtOPfJ9a0PZ1SmL8XWM=
X-Google-Smtp-Source: AGHT+IGRvS6YTzo8fFTT7cpnzRiZ9I9vJC/AkNtE7REgEH+nsHBJoP1b95VO/gB5czdXXnqydubGgA==
X-Received: by 2002:a05:6a20:e118:b0:1a1:7257:6302 with SMTP id
 kr24-20020a056a20e11800b001a172576302mr5353318pzb.4.1710178938670; 
 Mon, 11 Mar 2024 10:42:18 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 a18-20020a62d412000000b006e67b4d7b74sm4593187pfh.197.2024.03.11.10.42.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 10:42:18 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v4 19/24] tests/avocado: reverse_debugging.py add snapshot
 testing
Date: Tue, 12 Mar 2024 03:40:21 +1000
Message-ID: <20240311174026.2177152-20-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240311174026.2177152-1-npiggin@gmail.com>
References: <20240311174026.2177152-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Make a manual snapshot halfway though initial building of the address
map in record mode.

This will cause the reverse-step and reverse-continue tests to load that
snapshot when beginning from later points in the trace, exercising the
post-initial snapshot saving and loading.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/reverse_debugging.py | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/tests/avocado/reverse_debugging.py b/tests/avocado/reverse_debugging.py
index 635ff7bacc..4bf4e6e1e5 100644
--- a/tests/avocado/reverse_debugging.py
+++ b/tests/avocado/reverse_debugging.py
@@ -50,7 +50,7 @@ def run_vm(self, record, shift, args, replay_path, image_path, port):
         vm.add_args('-icount', 'shift=%s,rr=%s,rrfile=%s,rrsnapshot=init' %
                     (shift, mode, replay_path),
                     '-net', 'none')
-        vm.add_args('-drive', 'file=%s,if=none' % image_path)
+        vm.add_args('-drive', 'file=%s,if=none,id=disk0' % image_path)
         if args:
             vm.add_args(*args)
         vm.launch()
@@ -124,6 +124,14 @@ def gdb_bstep(g):
     def vm_get_icount(vm):
         return vm.qmp('query-replay')['return']['icount']
 
+    @staticmethod
+    def vm_snapshot(vm):
+        return vm.qmp('snapshot-save',
+                      {'job-id': 'snapshot-job',
+                       'tag': 'manual',
+                       'vmstate': 'disk0',
+                       'devices': []})
+
     def reverse_debugging(self, shift=7, args=None, x86_workaround=False):
         logger = logging.getLogger('replay')
 
@@ -162,6 +170,9 @@ def reverse_debugging(self, shift=7, args=None, x86_workaround=False):
             pc = self.get_pc(g)
             logger.info('saving position %x' % pc)
             steps.append(pc)
+            if i == self.STEPS//2:
+                logger.info('saving VM snapshot at step %x...' % i)
+                self.vm_snapshot(vm)
             self.gdb_step(g)
             if x86_workaround and i == 0 and self.vm_get_icount(vm) == 0:
                 logger.warn('failed to take first step, stepping again')
@@ -208,7 +219,9 @@ def reverse_debugging(self, shift=7, args=None, x86_workaround=False):
             self.gdb_step(g)
             logger.info('found position %x' % addr)
 
-        # Try reverse stepping
+        # Try reverse stepping. The manual snapshot taken in the record
+        # phase should be used for reverse-stepping until the machine
+        # reverses to an icount older than the snapshot.
         logger.info('stepping backward')
         for addr in steps[::-1]:
             self.gdb_bstep(g)
@@ -232,6 +245,8 @@ def reverse_debugging(self, shift=7, args=None, x86_workaround=False):
             self.check_pc(g, last_pc)
             logger.info('found position %x' % last_pc)
 
+        # This should load the last snapshot taken. Could that be verified
+        # with QMP?
         logger.info('stepping backward')
         self.gdb_bstep(g)
 
-- 
2.42.0


