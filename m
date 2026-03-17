Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C009F3381C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QFV-0002QZ-41; Tue, 17 Mar 2026 04:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QDn-0004S6-7E
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:56:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QDl-0007Al-9f
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IThIbV3TFRFRLbuyCHha/PXGer5pKdYiecHjOLIjUJo=;
 b=JXoE2rMhHC7buPS1KnvYlq+rYH+7BsE2kcX7r8H9cegUJYAWC04tdcP8hFLIYsNWwMKJjv
 2FmREx0wRB2qM5bV0+VUF77Ndu+4kK/fKUdlt7ycJkutaHG8H+dAqJZ/ASONP/Ddzx60xi
 IDb0XwamLaFNsguW8qUmupApUUiGZeI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-6TsztJv_NBC1t_gVSCjhng-1; Tue,
 17 Mar 2026 04:56:11 -0400
X-MC-Unique: 6TsztJv_NBC1t_gVSCjhng-1
X-Mimecast-MFC-AGG-ID: 6TsztJv_NBC1t_gVSCjhng_1773737770
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D14A19560B5
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:56:10 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1449C180075B
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:56:08 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:51:11 +0400
Subject: [PATCH 57/60] tests: rename the dbus-daemon helper script
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-57-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1187;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=I8NqN9mhZ5tch4xSwu14CjXz3zrFIMA/k1n2seamxoI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXdJn4AvotO+ZHOQcAqzqNW76H2bhhU1DcS5
 /3Jk3lUErGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV3QAKCRDa6OEJdZac
 5UvREACteLOxeiWOlJAqo7XrWShWDkCPvw9SvwAYucvxS/Egcnpf/P3DTPdyAaEKl/1EQpLMFoz
 xWE74hCtZSMKRGnUZxeGnyBg6mNXhHcE2pnM+mZhbpAUBlSQAq/8gEfkzyhUat+H+Z2HG/s2+oQ
 hYRgCKaOOLWpMrQrqftRviDHGpAIJAe4v/yAQGnMvuG7c076BNJXchf1/UW+46DkMSHWFM/FQlK
 OayO3W/fpzkpwl820EbKtfoCXrx4LZyzCWhbkq0ufiTi+pNW5hEkdsq6c2nSvW2wdZTOYmiRMH9
 PLj02LE2px/KbYW12ZwXoSMFNyCwQ0te7hBYc0l9+2UOwPzB5SNHhd7FtQ/qipGkbSqXNeS7360
 H3pZsz3Cx3iV/LcL8PYvq7BYatMgb73Qi2KFJFVtHDm9HQ5K5tPscjWaFTHKXQ8SeCAXjgWtXvv
 jtI2oESyYpiaOrbFN6wsmZYDWZO23xCSSSnqpCsvpocE3IOEkbOjPluqee6+Qafb6t8J7ZptApq
 j5N2L4J2RHjDof1+OrC2E+n8UtpktI4nezeQncI/7VBohrUH9nLzbqUbuzfzLs0ym4lVZAKqTGj
 3RPiqHiNR3CiXX+ikTY7/AEUKjTVzO1Z5dwUT7Xo1cfBMJ5z88hsSoDUAKcQiboBFhBbWu4+b5O
 kSOLBak6g9ndhOA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following patches are going to use it for qemu-vnc.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/{dbus-vmstate-daemon.sh => dbus-daemon.sh} | 0
 tests/qtest/meson.build                          | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/dbus-vmstate-daemon.sh b/tests/dbus-daemon.sh
similarity index 100%
rename from tests/dbus-vmstate-daemon.sh
rename to tests/dbus-daemon.sh
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index be4fa627b5f..b735f55fc40 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -435,7 +435,7 @@ foreach dir : target_dirs
     qtest_env.set('QTEST_QEMU_IMG', './qemu-img')
     test_deps += [qemu_img]
   endif
-  qtest_env.set('G_TEST_DBUS_DAEMON', meson.project_source_root() / 'tests/dbus-vmstate-daemon.sh')
+  qtest_env.set('G_TEST_DBUS_DAEMON', meson.project_source_root() / 'tests/dbus-daemon.sh')
   qtest_env.set('QTEST_QEMU_BINARY', './qemu-system-' + target_base)
   if have_tools and have_vhost_user_blk_server
     qtest_env.set('QTEST_QEMU_STORAGE_DAEMON_BINARY', './storage-daemon/qemu-storage-daemon')

-- 
2.53.0


