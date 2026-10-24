Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A273606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 12:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=i3crrRq1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKavb-0007OJ-Jx; Sat, 24 Oct 2026 08:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mehw.is.me@proton.me>)
 id 1xKSAu-00016K-KY
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 23:12:05 -0400
Received: from mail-06.mail-europe.com ([85.9.210.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mehw.is.me@proton.me>)
 id 1xKSAq-0007Rg-Td
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 23:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail2; t=1792811509; x=1793070709;
 bh=SeAEWKtYXttCKoeOd7H9vO6ZiMUsTaI2ix3/lxMEldw=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=i3crrRq11mgo3M470Pk/cUsIWJdpoQ9nTn56gJo1uW5xpxHwwLBjZJy1NP7Yif7WQ
 Ve0Yc3ofnXftFGx8M25rItsNBVYtTdrPh81i+jKtmggxChmfDGDYr6pCpAm3t7D931
 jPQ+PV4+i2tngpB8afGAxMoXP/hAF4EOHpfgNNA0rDqNTreDlcE8bG9JN+ZHcfuYtf
 kPz1en8e42uqAmWqeseSIoTzXLEsMrF4jp4rrRlqTJjQOA9rBBE5dIRzFMjP8+VOiY
 79Tg0F0/LwLTTKmR7JJCK+AI5ZEYGEoW3SsYpRG2vdqMI3hRGl+V7/KnXxPlMViwmc
 by7GYhiaa8c4Q==
Date: Sat, 24 Oct 2026 03:11:46 +0000
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
From: Matthew White <mehw.is.me@proton.me>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Subject: [PATCH] configure: --disable-containers should prevent `docker.py
 probe`
Message-ID: <hKx77zqhBpdBpNwknGTIJKnuItYep_9IN8RxpWG8PpKt02ncFgkx1HX0VE24agoa31lYrMB8g_y5C6pqW-1nu2oQiwyepSe3eWDsescwVSM=@proton.me>
Feedback-ID: 220061500:user:proton
X-Pm-Message-ID: f6825025b288e8b9d7e5e56125b3c75b82184434
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=85.9.210.45; envelope-from=mehw.is.me@proton.me;
 helo=mail-06.mail-europe.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) AC_FROM_MANY_DOTS=1.123, BAYES_00=-1.9,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 24 Oct 2026 08:32:13 -0400
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From bfd8cd877b563bc27263f1384843fb669baae509 Mon Sep 17 00:00:00 2001
From: Matthew White <mehw.is.me@proton.me>
Date: Fri, 23 Oct 2026 23:24:14 +0000
Subject: [PATCH] configure: --disable-containers should prevent `docker.py
 probe`

Upstream commit c4ce04cfb7460d46c0262d437a7f35bb5c5fc449 changed the
configure file to set container_command regardless of use_containers.
As a result, it runs `docker.py probe` to detect a Docker-compatible
application, such as Podman, even when --disable-containers is used.

On Gentoo, this reopens https://bugs.gentoo.org/732972.  As reported
in https://bugs.gentoo.org/984747, the `docker.py probe` command can
trigger SANDBOX ACCESS VIOLATION errors under QEMU v11.1.2:

 * ACCESS DENIED:  open_wr_creat: /var/lib/rpm/rpmdb.sqlite-wal
 * ACCESS DENIED:  fchown:        /var/lib/rpm/rpmdb.sqlite-wal
 ...

This patch is to prevent `docker.py probe` from running and to clear
container_command when --disable-containers is used.

Buglink: https://bugs.gentoo.org/984747
Signed-off-by: Matthew White <mehw.is.me@proton.me>
---
 configure | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/configure b/configure
index af14a9c23e..d38268e340 100755
--- a/configure
+++ b/configure
@@ -1277,12 +1277,17 @@ fi
 ##########################################
 # functions to probe cross compilers

-if test "$container_command" =3D ""; then
-    container_command=3D$($python "$source_path"/tests/docker/docker.py pr=
obe)
-    test "$container_command" =3D "no" && container_command=3D""
-fi
-if test $use_containers =3D "yes" && test "$container_command" !=3D ""; th=
en
-    docker_py=3D"$python $source_path/tests/docker/docker.py --command $co=
ntainer_command"
+if test $use_containers =3D "yes"; then
+    if test "$container_command" =3D ""; then
+        container_command=3D$($python "$source_path"/tests/docker/docker.p=
y probe)
+        test "$container_command" =3D "no" && container_command=3D""
+    fi
+    if test "$container_command" !=3D ""; then
+        docker_py=3D"$python $source_path/tests/docker/docker.py --command=
 $container_command"
+    fi
+else
+    # the option --disable-containers should override and disable --contai=
ner-command
+    container_command=3D""
 fi

 # cross compilers defaults, can be overridden with --cross-cc-ARCH
--
2.56.0



