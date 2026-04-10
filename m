Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95913F45A0A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:26:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHU2-0008NS-3f; Fri, 10 Apr 2026 15:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHU0-0008Hz-H6
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:25:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHTy-0003DO-3K
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775849133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zuQTehlxbQZEf/T4EFVs6VfrOKOLIxuCqrhgYf6F91s=;
 b=BhBYccp48J6TM2clgItYs2cVTLiezFSmpfD0sb/bRxp1yAvN7LULGTvngezC9GBhKR7TaH
 9agzYXsDDCFkxbDOws2tNDcaALvZL6jk5A/hYBm9dFAz6jGeKDBMxsBaMbVIOSZ1Hbtyki
 JYs79kd1pJO/mORA3UELcF8cU+UBgAk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-54Tf9sr-N5m4vcaqw9TSNw-1; Fri,
 10 Apr 2026 15:25:31 -0400
X-MC-Unique: 54Tf9sr-N5m4vcaqw9TSNw-1
X-Mimecast-MFC-AGG-ID: 54Tf9sr-N5m4vcaqw9TSNw_1775849130
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 384F419560B2
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 19:25:30 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2405E19560AB; Fri, 10 Apr 2026 19:25:28 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:19:28 +0400
Subject: [PATCH v2 66/67] tests/qtest: drop DBUS_VMSTATE_TEST_TMPDIR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-66-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1247;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=NFWE5HoAsedukDnbwcUMEd/HneFj5c5ptOyyObXNxms=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0XG3d0SM/5zItq2j4OPE2HUu460v5mtfdhk
 YBwMb0MyKyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNFwAKCRDa6OEJdZac
 5YCkEACF6CSid73Wn5KQESRz+6Eg2T1SHZku5WuKKb8gjTibGNyLsmWP8A596HH30qmaxjdPuaT
 Le5QvO2HyFD42e+9fyWEghKB/VtiQK6FfBaswnGfIxHdb2XJmDNwGQRtYS8b13IyzIblxyCMVBW
 U0mvk1KYA7Ukg/LZtuD/TXzxrAz8vVqBT7BFsjd5l8Z9hU00sGiqZEV6s/mFzg4Z7P6zSI+3oi0
 NGj2Ohk6yJGFGzi1PurHHKZa9RgvzsT/XValazIZaUpLN3S+zEP3SIfmtBUl7P4+I/6roadvLQu
 K1n1kIcPk7FIInWv/dnIOmhC+uxr350t0dRYZawN+9cX90m5wqYzAfxeUiGupOC3znw9QqlDqKV
 B+Ozxm0M1+B4vArvn4d0ln2mjBWHVTh+tnyhAy9zEK2CSFLqWaGEVFcQOY/8rwNKpl74elDQFwM
 j/oI3XHtuq8GSuVsp8b4bHhsRfNlDcrM5McunC20JaKk7jtLDOLhKYTA9gDRv390ehDsbi4AFvW
 oprRlgVLsRuqWXnum7R27A/ehSjWuCQNICUzFQbkTCU8hc9Ocox/fVzqXuhcrehxdB87oeShd8D
 TNiAvF0NSMRi2TVI2vi2VHoXd519P3cU+rVBPS5+zD5pSRe3o6cAEFQfOHPf0oVQS1fsUe7L/dp
 wbeX8MNZFuSI8qw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

It can rely on the location of the temporary configuration instead.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/dbus-vmstate-test.c | 2 --
 tests/dbus-daemon.sh            | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/qtest/dbus-vmstate-test.c b/tests/qtest/dbus-vmstate-test.c
index 5c80bb303b6..1812d0fb70a 100644
--- a/tests/qtest/dbus-vmstate-test.c
+++ b/tests/qtest/dbus-vmstate-test.c
@@ -353,8 +353,6 @@ main(int argc, char **argv)
         exit(1);
     }
 
-    g_setenv("DBUS_VMSTATE_TEST_TMPDIR", workdir, true);
-
     qtest_add_func("/dbus-vmstate/without-list",
                    test_dbus_vmstate_without_list);
     qtest_add_func("/dbus-vmstate/with-list",
diff --git a/tests/dbus-daemon.sh b/tests/dbus-daemon.sh
index 474e2501548..c4a50c73774 100755
--- a/tests/dbus-daemon.sh
+++ b/tests/dbus-daemon.sh
@@ -26,7 +26,7 @@ write_config()
     cat > "$CONF" <<EOF
 <busconfig>
   <type>session</type>
-  <listen>unix:tmpdir=$DBUS_VMSTATE_TEST_TMPDIR</listen>
+  <listen>unix:tmpdir=$(dirname "$CONF")</listen>
 
   <policy context="default">
      <!-- Holes must be punched in service configuration files for

-- 
2.53.0


