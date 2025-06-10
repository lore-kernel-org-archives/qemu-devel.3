Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98BD3C677C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 19:51:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP502-0002Vy-9i; Tue, 10 Jun 2025 15:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sertonix@posteo.net>)
 id 1uP3Eh-0002kN-Um
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 13:58:12 -0400
Received: from mout01.posteo.de ([185.67.36.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sertonix@posteo.net>)
 id 1uP3Eg-0001dc-2N
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 13:58:11 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id D0E99240027
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 19:58:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net;
 s=1984.ea087b; t=1749578286;
 bh=virSmyg9yBkjNHV+QKHPqLne67mu64M5jcNafW8sykU=;
 h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:
 Message-Id:Subject:From:To:From;
 b=JJXT371idrz7HaChX72/o56X8ucwnwkh0ze7dVLSeBVwGcItNOnvyUwJYKJDw94VO
 QU1B5x0RgFse7xGp5tAMn9dI/clpCqsAEm7aHlfv96fyY+S5tabYCX6TMhGU7gZusq
 8lUWHSq6GRGicILZ3WX83zuEOO90S23a8EulP9MvhRkOzsOh7J66rSCI4H7/E/HVII
 g3WvIBxugycd//7nTR+cAO6sKFiTFmfjCHLwD41Rg1Z99/Ic6BuceEAqTNRIaaIbf4
 5XYFaZlHR/d8pdeSjMnAjOALxFJ/kGrmzdWbvEl8WdFhnJ2fnjhUIzdG9mr55eawLm
 laySWe6jnnwkiMxaJ3kgXbJjdggCwMavkDMnUV6z1knGOd5j3mWZMd5AgLJr4asIRW
 L1nbGESPYE61uB5MbbHI6fmJnNiiDAeTW15EKfUmt54MXzL+nYp9iYLJqo2Z2MR+By
 aZ7wZhIZ5eiLlu6CESB7xzYqppJniAcz654w6vDvzIBog4Y988m
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4bGxNG2KHPz6twY;
 Tue, 10 Jun 2025 19:58:06 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Jun 2025 17:58:06 +0000
Message-Id: <DAJ1QOSAP9LS.342SQSM0UZU80@posteo.net>
Subject: [PATCH] pc-bios/s390-ccw: link statically
From: "Sertonix" <sertonix@posteo.net>
To: <qemu-devel@nongnu.org>, "Thomas Huth" <thuth@redhat.com>
Received-SPF: pass client-ip=185.67.36.65; envelope-from=sertonix@posteo.net;
 helo=mout01.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 10 Jun 2025 15:51:04 -0400
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


Adding -pie to LDFLAGS caused s390-ccw.img to become dynamically linked.
By using -static-pie it will be linked statically like other bios.

This ensures that the build output doesn't change depending on the
default dynamic loader path of the toolchain.

Ref d884c86dcd3b s390/bios: Make the s390-ccw.img relocatable

Signed-off-by: Sertonix <sertonix@posteo.net>
---
 pc-bios/s390-ccw/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index dc69dd484f..a0f24c94a8 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -47,7 +47,7 @@ EXTRA_CFLAGS +=3D -fwrapv -fno-strict-aliasing -fno-async=
hronous-unwind-tables
 EXTRA_CFLAGS +=3D -msoft-float
 EXTRA_CFLAGS +=3D -std=3Dgnu99
 EXTRA_CFLAGS +=3D $(LIBC_INC) $(LIBNET_INC)
-EXTRA_LDFLAGS +=3D -Wl,-pie -nostdlib -z noexecstack -z text
+EXTRA_LDFLAGS +=3D -static-pie -nostdlib -z noexecstack -z text
=20
 cc-test =3D $(CC) -Werror $1 -c -o /dev/null -xc /dev/null >/dev/null 2>/d=
ev/null
 cc-option =3D if $(call cc-test, $1); then \
--=20
2.49.0


