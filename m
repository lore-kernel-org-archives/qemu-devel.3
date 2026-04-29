Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44628FF8873
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 21:07:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIC7U-0000pG-Rk; Wed, 29 Apr 2026 17:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wIC6O-0006vu-R1
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:05:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wIC6L-0003mB-V4
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777496744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5M69FqQz8i1tkdKMn9kq/IgsfDbfg7yNoRa3QNEz72o=;
 b=g4IceB2DF5+AqXw1iAZE6nHO10gCJs+DuHAuxja8hF0hYjU6esz/yG2Bd0tncAGGSu/26C
 rwkp/62rm+buZrJwqlBswuzs63yZ2Xl3JbvsotKeLmvowqCZxw7RBgLYEKSUq70JpUQlkO
 J5anIQqfiUgO22CAGtDW8txSIDZdyLI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222--PGbzyVtPLCzXsfEYoscmg-1; Wed,
 29 Apr 2026 17:05:42 -0400
X-MC-Unique: -PGbzyVtPLCzXsfEYoscmg-1
X-Mimecast-MFC-AGG-ID: -PGbzyVtPLCzXsfEYoscmg_1777496741
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B19A31800350
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 21:05:41 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 59A04195608E; Wed, 29 Apr 2026 21:05:39 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 30 Apr 2026 01:02:58 +0400
Subject: [PATCH v3 25/26] tests/qtest: drop DBUS_VMSTATE_TEST_TMPDIR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260430-qemu-vnc-v3-25-be96757428d0@redhat.com>
References: <20260430-qemu-vnc-v3-0-be96757428d0@redhat.com>
In-Reply-To: <20260430-qemu-vnc-v3-0-be96757428d0@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1313;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=AF4tw00UydsKNYnU8BNeLalb8J4vuxmLglgznwUcFSY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp8nIMW/qvxfnqn4y0Ah7ob4fHqmBH753+YO1CH
 10RF9NJsyWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafJyDAAKCRDa6OEJdZac
 5X17D/9xtTUbuAsYJ+WO+iW06Ro+n/RbB6sO9aVs3v/LmNIB55X1lVqeqH41ZwMbfQSx4QiwOYS
 k181RdDWRjUOSkzwpUA/yYy7dKkDycZGhPHLeN8GIxIK8r2B30ECoEZByp7ayEMGTiyAMZ994Bu
 LcmAzswlA2K7E9d9il4nzTfj5+tN0J02N9AFNq1t45MVrCij/WAwp368HyymiUyKQl8QIVatApO
 eqbzr3PECfX3gGR/7OOzwV4nuQL1OQUqqOXTVH6XP3uu0jq08idSeOo79bS69mOnGAZlGpsv24x
 VUYCSxKIqL834relHbqhGkvzBOExuHbLZSi9o1BKieHdjcz1J1CdN022fx6wTsIii4VA0tcv+3u
 i6Zh697SUFEpbIIWzYokXnbquULG/+UEXQ1V28E7ne+fYZkZg7KfLN3o8fbXSbofS9je7aqw7m2
 fiU6uPMyoYf0K82MXLMgvUoLHvRGeODtOBjuOTWP22XZMZHA5eFXR3sM/b5CWYmDZv1dGPOwIMZ
 OuNc4RoRyu+QpKOXbYyzE4jPRjXe4dg5vUE6eypBjf06Ott0YEaF5mZwslTTWnY5RXe8w5/fg0n
 GoGVKZ5fud1MiXCzxBI+GptiAuDL+OxTLZFBxsDiOv8BPxo0q0OBD8VEDJeO9xfjv0xxOYeQgEy
 AOulCeCFjTgIGPg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

It can rely on the location of the temporary configuration instead, so
we don't have to set that environment variable on every test.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/dbus-vmstate-test.c | 2 --
 tests/dbus-daemon.sh            | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/qtest/dbus-vmstate-test.c b/tests/qtest/dbus-vmstate-test.c
index 0a82cc9f935..ee034afa7ba 100644
--- a/tests/qtest/dbus-vmstate-test.c
+++ b/tests/qtest/dbus-vmstate-test.c
@@ -360,8 +360,6 @@ main(int argc, char **argv)
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
2.54.0


