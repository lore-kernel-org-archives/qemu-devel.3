Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF680CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 09:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLHvq-0007FW-NW; Fri, 08 May 2026 05:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wLHvo-0007Dn-CF
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:55:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wLHvl-0000cb-Ob
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778234137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JOJhP0UIQ8fephuWSN4p4ozboMCdEbFGoLYJ9wlqmZc=;
 b=M505Aiv5Q35lUNlDdj5kmtluQuDh9H6CMbD9yvczwGNL8BdYm6k175w40BiQxnqDrq624+
 HXCyk3anxVgEsFtSKcP0t2+R64+SGFVHrhbunlqkzmzMvhdv3tNiS/lIuqeGiT0T5Qzrwu
 /+ef3P8KNxpMF79RQYL3YnOYfhDU1lk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-i_8Al_-3N1K_6L398MTaPw-1; Fri,
 08 May 2026 05:55:34 -0400
X-MC-Unique: i_8Al_-3N1K_6L398MTaPw-1
X-Mimecast-MFC-AGG-ID: i_8Al_-3N1K_6L398MTaPw_1778234133
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 09D1619560B7
 for <qemu-devel@nongnu.org>; Fri,  8 May 2026 09:55:33 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.50.155])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 932DE195394A; Fri,  8 May 2026 09:55:32 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 7CC191800787; Fri, 08 May 2026 11:55:31 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 0/6] Firmware 20260508 patches
Date: Fri,  8 May 2026 11:55:25 +0200
Message-ID: <20260508095531.570979-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit ee7eb612be8f8886d48c1d0c1f1c65e495138f83:

  Merge tag 'single-binary-20260506' of https://github.com/philmd/qemu into staging (2026-05-06 10:45:02 -0400)

are available in the Git repository at:

  https://gitlab.com/kraxel/qemu.git tags/firmware-20260508-pull-request

for you to fetch changes up to b4680c02b8e838c75691656ee2c4450b454d1ca7:

  hw/uefi: avoid possibly unaligned variable_auth_2 struct field access (2026-05-08 09:12:11 +0200)

----------------------------------------------------------------
hw/uefi: collection of CVE fixes.

----------------------------------------------------------------

Gerd Hoffmann (6):
  hw/uefi: fix buffer overruns
  hw/uefi: verify pio_xfer_offset before calculating buffer checksum
  hw/uefi: fix ucs2 string helper functions
  hw/uefi: add name_size check to uefi_vars_mm_lock_variable()
  hw/uefi: verify data size before accessing it in wrap_pkcs7
  hw/uefi: avoid possibly unaligned variable_auth_2 struct field access

 hw/uefi/var-service-auth.c  | 21 +++++++++++--------
 hw/uefi/var-service-core.c  |  4 ++++
 hw/uefi/var-service-pkcs7.c | 21 ++++++++++++-------
 hw/uefi/var-service-utils.c | 42 +++++++++++++++++++++----------------
 hw/uefi/var-service-vars.c  | 22 +++++++++++++++----
 5 files changed, 71 insertions(+), 39 deletions(-)

-- 
2.54.0


