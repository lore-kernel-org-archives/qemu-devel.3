Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB51FC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 07:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1hgw-0001Lu-CC; Tue, 30 Apr 2024 03:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s1hgv-0001KP-G5
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 03:14:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s1hgj-0008Qs-0z
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 03:14:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714461244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LmVyI7fttefjFTJGbcPHAdiK+MeFHWmqArfe42MQBow=;
 b=hY60OKQ0Hz8zZQ6HxvdHjskozd7zfyfs4lx+ZGpTi4aEn220hmW4LhFWOKv17Dh6er/0Jc
 RmbFjtzpmVKiTD1YFazHjkpW9Bkm7EZjkSyrUxbCcr5kED2sZGaxaeZyntmdKkCgWKpzLx
 Co+3WS0+Xt5sGpFz7vj0Hq4AIVhaODc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-VytbiU-pNkSdHd0Bmx4sNA-1; Tue,
 30 Apr 2024 03:14:00 -0400
X-MC-Unique: VytbiU-pNkSdHd0Bmx4sNA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0ED843806738;
 Tue, 30 Apr 2024 07:14:00 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.79])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EF7E440C6CC1;
 Tue, 30 Apr 2024 07:13:58 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Konstantin Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/19] stubs: Add missing qga stubs
Date: Tue, 30 Apr 2024 09:13:31 +0200
Message-ID: <20240430071340.413305-11-thuth@redhat.com>
In-Reply-To: <20240430071340.413305-1-thuth@redhat.com>
References: <20240430071340.413305-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Konstantin Kostiuk <kkostiuk@redhat.com>

Compilation QGA without system and user fails
./configure --disable-system --disable-user --enable-guest-agent

Link failure:
  /usr/bin/ld: libqemuutil.a.p/util_main-loop.c.o: in function
`os_host_main_loop_wait':
   ../util/main-loop.c:303: undefined reference to `replay_mutex_unlock'
   /usr/bin/ld: ../util/main-loop.c:307: undefined reference to
`replay_mutex_lock'
   /usr/bin/ld: libqemuutil.a.p/util_error-report.c.o: in function
`error_printf':
   ../util/error-report.c:38: undefined reference to `error_vprintf'
   /usr/bin/ld: libqemuutil.a.p/util_error-report.c.o: in function
`vreport':
   ../util/error-report.c:225: undefined reference to `error_vprintf'
   /usr/bin/ld: libqemuutil.a.p/util_qemu-timer.c.o: in function
`timerlist_run_timers':
   ../util/qemu-timer.c:562: undefined reference to `replay_checkpoint'
   /usr/bin/ld: ../util/qemu-timer.c:530: undefined reference to
`replay_checkpoint'
   /usr/bin/ld: ../util/qemu-timer.c:525: undefined reference to
`replay_checkpoint'
   ninja: build stopped: subcommand failed.

Fixes: 3a15604900 ("stubs: include stubs only if needed")

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Message-ID: <20240426121347.18843-2-kkostiuk@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 stubs/meson.build | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/stubs/meson.build b/stubs/meson.build
index 8ee1fd5753..3b9d42023c 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -21,12 +21,12 @@ if have_block
   stub_ss.add(files('migr-blocker.c'))
   stub_ss.add(files('physmem.c'))
   stub_ss.add(files('ram-block.c'))
-  stub_ss.add(files('replay-tools.c'))
   stub_ss.add(files('runstate-check.c'))
   stub_ss.add(files('uuid.c'))
 endif
 
 if have_block or have_ga
+  stub_ss.add(files('replay-tools.c'))
   # stubs for hooks in util/main-loop.c, util/async.c etc.
   stub_ss.add(files('cpus-get-virtual-clock.c'))
   stub_ss.add(files('icount.c'))
@@ -45,6 +45,10 @@ if have_block or have_ga
   stub_ss.add(files('qmp-quit.c'))
 endif
 
+if have_ga
+  stub_ss.add(files('error-printf.c'))
+endif
+
 if have_block or have_user
   stub_ss.add(files('qtest.c'))
   stub_ss.add(files('vm-stop.c'))
-- 
2.44.0


