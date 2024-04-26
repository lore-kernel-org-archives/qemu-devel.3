Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE6DC04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 12:15:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0KSr-0006C9-Ai; Fri, 26 Apr 2024 08:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1s0KSo-0006Ao-T2
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 08:14:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1s0KSh-0002Th-7v
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 08:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714133633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w6JR5VlUXsk9+UzoYxNC5y9SS1rfpBWHtMB86agaGjw=;
 b=iXGgSP6Oo7Rgd1mkjazB58OtlSpKSbLS2w0TIHM9woIYwIvEj5Dp/MaLT27+viYtW+jBY9
 YsUcuwHIUXjrVOtLf9xT/89ra28q8bGV1GBQJQPR9Mx+nC3zv0bPL7te98ZWS4rNoLR6AI
 tbon1Vydp6uQkNKUoVvROzFIf4Uzgh8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-WlNuJjNPNLagAjK-DbWDNw-1; Fri,
 26 Apr 2024 08:13:51 -0400
X-MC-Unique: WlNuJjNPNLagAjK-DbWDNw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6131D385A192;
 Fri, 26 Apr 2024 12:13:51 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.225.126])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 529A7EC680;
 Fri, 26 Apr 2024 12:13:50 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 1/1] stubs: Add missing qga stubs
Date: Fri, 26 Apr 2024 15:13:42 +0300
Message-ID: <20240426121347.18843-2-kkostiuk@redhat.com>
In-Reply-To: <20240426121347.18843-1-kkostiuk@redhat.com>
References: <20240426121347.18843-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


