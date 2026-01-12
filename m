Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C8CFC9EC86
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHlU-0001WD-5c; Mon, 12 Jan 2026 08:15:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfHlK-0001F4-7a
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:15:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfHlI-0002Ve-ON
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:15:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768223711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bYNER3tv7jKHijECoLFlWzyNVq0wnfgD03vxD77kjgc=;
 b=GKuBNYKHqjeyAAnHyMJ3J2VwFWdYi4BYL/91ELZgQBX46fTeTxdEiqrx21PwpDyMjAJbsG
 4q9YCsKjZ53QPEjnjz2rdN/h/9Cnc3hfvxFlPa7PvBgT032/DGJ2/QIQFPIvOeaN6vm1DZ
 nGbwxGrVBBWKafz8v9rGHEV6qze+PcU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-DFzMbf4OMZW97BJ_TKY95Q-1; Mon,
 12 Jan 2026 08:15:06 -0500
X-MC-Unique: DFzMbf4OMZW97BJ_TKY95Q-1
X-Mimecast-MFC-AGG-ID: DFzMbf4OMZW97BJ_TKY95Q_1768223705
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96C52180061A; Mon, 12 Jan 2026 13:15:05 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.179])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B566930001A2; Mon, 12 Jan 2026 13:15:03 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 02/15] tests/functional/mips/test_malta: Silence warnings
 reported by pylint
Date: Mon, 12 Jan 2026 14:14:44 +0100
Message-ID: <20260112131457.67128-3-thuth@redhat.com>
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

Pylint complains about too many positional arguments for the
mips_check_wheezy() function. Add a "*" to enforce that the later
ones are passed with an argument name (all calling sites are doing
this already).

Also turn some old-school format strings into proper f-strings now.

Message-Id: <20251119082636.43286-6-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/mips/test_malta.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/functional/mips/test_malta.py b/tests/functional/mips/test_malta.py
index 7a734bc069b..e8f49f130be 100755
--- a/tests/functional/mips/test_malta.py
+++ b/tests/functional/mips/test_malta.py
@@ -50,7 +50,7 @@ def mips_run_common_commands(test, prompt='#'):
         ' : ata_piix')
     wait_for_console_pattern(test, prompt)
 
-def mips_check_wheezy(test, kernel_path, image_path, kernel_command_line,
+def mips_check_wheezy(test, kernel_path, image_path, kernel_command_line, *,
                       dl_file, hsum, nic='pcnet', cpuinfo='MIPS 24Kc'):
     test.require_netdev('user')
     test.require_device(nic)
@@ -59,10 +59,10 @@ def mips_check_wheezy(test, kernel_path, image_path, kernel_command_line,
     port=8080
     test.vm.add_args('-kernel', kernel_path,
                      '-append', kernel_command_line,
-                     '-drive', 'file=%s,snapshot=on' % image_path,
+                     '-drive', f'file={image_path},snapshot=on',
                      '-netdev', 'user,id=n1' +
                                 ',tftp=' + os.path.basename(kernel_path) +
-                                ',hostfwd=tcp:127.0.0.1:0-:%d' % port,
+                                f',hostfwd=tcp:127.0.0.1:0-:{port}',
                      '-device', f'{nic},netdev=n1',
                      '-no-reboot')
     test.vm.set_console()
@@ -111,7 +111,7 @@ def test_mips_malta(self):
         self.vm.add_args('-kernel', kernel_path,
                          '-append', kernel_command_line)
         self.vm.launch()
-        console_pattern = 'Kernel command line: %s' % kernel_command_line
+        console_pattern = f'Kernel command line: {kernel_command_line}'
         self.wait_for_console_pattern(console_pattern)
 
     ASSET_KERNEL_4_5_0 = Asset(
-- 
2.52.0


