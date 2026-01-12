Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52FD8C9EC86
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHmQ-0001ce-72; Mon, 12 Jan 2026 08:16:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfHlK-0001FI-AJ
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:15:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfHlI-0002Vb-4A
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:15:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768223710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oKfegducDODgkba1XJ/HW/MbccnFLGGMVBYQq+f+uTM=;
 b=jEDsdZXWidoqgIy7rg4AI8mWOCeAi7hRtrbF7vmAFkKHzpK5ZTgqf9FpbRFgIU43z/6RKj
 iJI+ZThFdVm5dubKXeOB/deLyMwdXjOg6Q1DZHnUqvrIJx8hsNcbh73imehU7/FoK/vr3q
 Eq3O+m5oe2L6KXwRDvQ+wVFC+lcAXuI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-XIp_bFlnOd-fK-tadKqcIw-1; Mon,
 12 Jan 2026 08:15:09 -0500
X-MC-Unique: XIp_bFlnOd-fK-tadKqcIw-1
X-Mimecast-MFC-AGG-ID: XIp_bFlnOd-fK-tadKqcIw_1768223708
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5EE0F1800451; Mon, 12 Jan 2026 13:15:08 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.179])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BE40330001A2; Mon, 12 Jan 2026 13:15:06 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 03/15] tests/functional/ppc64/test_hv: Silence warnings
 reported by pylint
Date: Mon, 12 Jan 2026 14:14:45 +0100
Message-ID: <20260112131457.67128-4-thuth@redhat.com>
In-Reply-To: <20260112131457.67128-1-thuth@redhat.com>
References: <20260112131457.67128-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

To make pylint happy here, remove unused variables, switch to f-string,
use "check=True" when calling subprocess.run() and split a line that was
too long.

Message-Id: <20251119082636.43286-7-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/ppc64/test_hv.py | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tests/functional/ppc64/test_hv.py b/tests/functional/ppc64/test_hv.py
index d87f440fa79..beec1dbbea3 100755
--- a/tests/functional/ppc64/test_hv.py
+++ b/tests/functional/ppc64/test_hv.py
@@ -29,8 +29,6 @@
 @skipBigDataTest()
 class HypervisorTest(QemuSystemTest):
 
-    timeout = 1000
-    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 console=hvc0 '
     panic_message = 'Kernel panic - not syncing'
     good_message = 'VFS: Cannot open root device'
 
@@ -49,8 +47,8 @@ def extract_from_iso(self, iso, path):
         """
         filename = self.scratch_file(os.path.basename(path))
 
-        cmd = "xorriso -osirrox on -indev %s -cpx %s %s" % (iso, path, filename)
-        subprocess.run(cmd.split(),
+        cmd = f"xorriso -osirrox on -indev {iso} -cpx {path} {filename}"
+        subprocess.run(cmd.split(), check=True,
                        stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
 
         os.chmod(filename, 0o600)
@@ -66,7 +64,6 @@ def setUp(self):
 
     def do_start_alpine(self):
         self.vm.set_console()
-        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE
         self.vm.add_args("-kernel", self.vmlinuz)
         self.vm.add_args("-initrd", self.initramfs)
         self.vm.add_args("-smp", "4", "-m", "2g")
@@ -78,7 +75,8 @@ def do_start_alpine(self):
         wait_for_console_pattern(self, 'localhost login:')
         exec_command_and_wait_for_pattern(self, 'root', ps1)
         # If the time is wrong, SSL certificates can fail.
-        exec_command_and_wait_for_pattern(self, 'date -s "' + datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S' + '"'), ps1)
+        cmd='date -s "' + datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S' + '"')
+        exec_command_and_wait_for_pattern(self, cmd, ps1)
         ps1='alpine:~#'
         exec_command_and_wait_for_pattern(self, 'setup-alpine -qe', ps1)
         exec_command_and_wait_for_pattern(self, 'setup-apkrepos -c1', ps1)
-- 
2.52.0


