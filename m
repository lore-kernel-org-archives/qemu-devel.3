Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 721F1CD128A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 16:30:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruEMJ-0001n6-Ak; Tue, 09 Apr 2024 12:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1ruEM6-0001lg-4O
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 12:29:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1ruEM3-0005hD-8o
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 12:29:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712680190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=s+cXtSHyBPY5sy5W2Geif/XYny2REtsDgxJhOipIxZk=;
 b=A+xoIZcTGclJ0MqdpJQQQ4poBVoqn47ASnDGpWrMegxspLV0qu4aP48d1UY6D9/0i9/usK
 jsnYMBGfIJmMkSFRAd+tdweG8uxKMWHvupHoGhuXWTZx+df6yyp3+RBgY3ifpK8sY6rA3Y
 n4M6lZox9mRYn2pcNCIJr2zsOojW+e0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-cXF7AWjOMwCTDynCKdw3lw-1; Tue,
 09 Apr 2024 12:29:48 -0400
X-MC-Unique: cXF7AWjOMwCTDynCKdw3lw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97E2229AB3FF;
 Tue,  9 Apr 2024 16:29:48 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.204])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A83782026D1F;
 Tue,  9 Apr 2024 16:29:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 95DB118009F4; Tue,  9 Apr 2024 18:29:42 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/4] Edk2 20240409 patches
Date: Tue,  9 Apr 2024 18:29:30 +0200
Message-ID: <20240409162942.454419-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.701,
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

The following changes since commit e5c6528dce86d7a9ada7ecf02fcb7b8560955131:

  Update version for v9.0.0-rc2 release (2024-04-02 20:59:43 +0100)

are available in the Git repository at:

  https://gitlab.com/kraxel/qemu.git tags/edk2-20240409-pull-request

for you to fetch changes up to e3404e01c7f74efdc3440ddfd339d67bf7a8410e:

  edk2: rebuild binaries with correct version information (2024-04-09 18:21:23 +0200)

----------------------------------------------------------------
edk2: fix version information, rebuild binaries.

----------------------------------------------------------------

Gerd Hoffmann (4):
  edk2: get version + date from git submodule
  edk2: commit version info
  edk2/seabios: use common extra version
  edk2: rebuild binaries with correct version information

 pc-bios/edk2-aarch64-code.fd.bz2       | Bin 1589310 -> 1588976 bytes
 pc-bios/edk2-arm-code.fd.bz2           | Bin 1571693 -> 1571639 bytes
 pc-bios/edk2-i386-code.fd.bz2          | Bin 1775832 -> 1775230 bytes
 pc-bios/edk2-i386-secure-code.fd.bz2   | Bin 1876986 -> 1877268 bytes
 pc-bios/edk2-riscv-code.fd.bz2         | Bin 1289160 -> 1289337 bytes
 pc-bios/edk2-x86_64-code.fd.bz2        | Bin 1892372 -> 1892766 bytes
 pc-bios/edk2-x86_64-microvm.fd.bz2     | Bin 1785258 -> 1785290 bytes
 pc-bios/edk2-x86_64-secure-code.fd.bz2 | Bin 2214892 -> 1969096 bytes
 roms/Makefile                          |  25 ++++++++++++++++++-------
 roms/edk2-version                      |   2 ++
 10 files changed, 20 insertions(+), 7 deletions(-)
 create mode 100644 roms/edk2-version

-- 
2.44.0


