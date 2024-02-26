Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43914C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 16:01:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1redOz-0003vO-6K; Mon, 26 Feb 2024 11:00:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1redOm-0003t1-VH
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:00:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1redOj-00054d-0N
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:00:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708963208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9eJZtzlO9vphsG189HpfuuzAkS1ub1ImVFPD3iWmQ/Y=;
 b=AcYdqOCVpn/ROFZGx0FfEvwqBTAtxVuljigXsmS9+kJorV2pRooYbiIRcbfJtwlSMP7T06
 qsWVmz0Y570m5S/Qdah7da3v3mzjz+lHmEFc3iMCPkTLytz5mT4sMkoQbY6CcGpE6HMfOX
 nneaqBMRFAwyH9RqCt3WCvl3nSiZ2Ik=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-mignOApjM9yyeNmU9u_MpQ-1; Mon, 26 Feb 2024 11:00:04 -0500
X-MC-Unique: mignOApjM9yyeNmU9u_MpQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 87BD683DDE0;
 Mon, 26 Feb 2024 16:00:04 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2CCB8C01644;
 Mon, 26 Feb 2024 16:00:04 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 17BDD1800097; Mon, 26 Feb 2024 17:00:03 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 0/2] Edk2 stable202402 20240226 patches
Date: Mon, 26 Feb 2024 16:59:52 +0100
Message-ID: <20240226160003.903191-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The following changes since commit 4a4efae44f19528589204581e9e2fab69c5d39aa:

  Merge tag 'pull-hex-20240121' of https://github.com/quic/qemu into staging (2024-01-23 13:40:45 +0000)

are available in the Git repository at:

  https://gitlab.com/kraxel/qemu.git tags/edk2-stable202402-20240226-pull-request

for you to fetch changes up to 658178c3d4e95b3f4106e25ec5a209356e339032:

  update edk2 binaries to edk2-stable202402 (2024-02-26 10:23:25 +0100)

----------------------------------------------------------------
firmware: update to edk2-stable202402

Update edk2 to the latest release tagged end of last week.

Cc stable this time because we should move away from the
git snapshot update done in January.

----------------------------------------------------------------

Gerd Hoffmann (2):
  update edk2 submodule to edk2-stable202402
  update edk2 binaries to edk2-stable202402

 pc-bios/edk2-aarch64-code.fd.bz2       | Bin 1587761 -> 1589320 bytes
 pc-bios/edk2-arm-code.fd.bz2           | Bin 1569509 -> 1571418 bytes
 pc-bios/edk2-i386-code.fd.bz2          | Bin 1773520 -> 1775832 bytes
 pc-bios/edk2-i386-secure-code.fd.bz2   | Bin 2127480 -> 2130741 bytes
 pc-bios/edk2-riscv-code.fd.bz2         | Bin 1180314 -> 1345420 bytes
 pc-bios/edk2-riscv-vars.fd.bz2         | Bin 231 -> 235 bytes
 pc-bios/edk2-x86_64-code.fd.bz2        | Bin 1891942 -> 1892372 bytes
 pc-bios/edk2-x86_64-microvm.fd.bz2     | Bin 1783951 -> 1785258 bytes
 pc-bios/edk2-x86_64-secure-code.fd.bz2 | Bin 2212258 -> 2214892 bytes
 roms/edk2                              |   2 +-
 10 files changed, 1 insertion(+), 1 deletion(-)

-- 
2.43.2


