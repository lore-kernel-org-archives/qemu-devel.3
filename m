Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E842C982CF
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 13:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7CFO-0000dQ-5Y; Thu, 17 Sep 2026 09:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1x7CF5-0000bQ-DB
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 09:33:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1x7CEx-0003W6-Vn
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 09:33:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789652006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Av6nBe1Y0N1kAACVoG4KmV0IhLEUFAA5rCZsV2qXMQk=;
 b=LNd5Gxth3xPhofzMerDpivuM0STbgA2kgM2pbwBG/x79ldpd2w8EHZIQShIAAsEzo0qWs1
 A7TQrngXUrPoBALoy9BDJIyEWUMRtB6aWnJJ5RwD9SfF59bHymbtsWTy/bKkrqHMbjXLLC
 pMXicBAbgJDPDmbbbPNFPDZOFgvdCIk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-wkJoFJ9cOA2LZmkVfbxaeQ-1; Thu,
 17 Sep 2026 09:33:21 -0400
X-MC-Unique: wkJoFJ9cOA2LZmkVfbxaeQ-1
X-Mimecast-MFC-AGG-ID: wkJoFJ9cOA2LZmkVfbxaeQ_1789652001
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB0CC180B5C6; Thu, 17 Sep 2026 13:33:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.37])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 47FE71800579; Thu, 17 Sep 2026 13:33:20 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id CC4541800395; Thu, 17 Sep 2026 15:33:18 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 0/5] Firmware 20260917 patches
Date: Thu, 17 Sep 2026 15:33:13 +0200
Message-ID: <20260917133318.2004317-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit f8296b816fabd370307cd22b0270b610fc0fa279:

  Merge tag 'pull-loongarch-20260917' of https://github.com/bibo-mao/qemu into staging (2026-09-16 18:24:08 -1000)

are available in the Git repository at:

  https://gitlab.com/kraxel/qemu.git tags/firmware-20260917-pull-request

for you to fetch changes up to a1b96fcde870e49896cddee40459d5feb1f15694:

  hw/uefi: improve default config security (2026-09-17 13:16:02 +0200)

----------------------------------------------------------------
- igvm: add checks to parameter directive processing
- hw/uefi: add check to uefi_vars_mm_lock_variable
- hw/uefi: align default config with upstream edk2

----------------------------------------------------------------

Gerd Hoffmann (3):
  hw/uefi: add missing uefi_str_is_valid check to
    uefi_vars_mm_lock_variable
  hw/uefi: add require-self-signed-pk config option
  hw/uefi: improve default config security

Luigi Leonardi (2):
  igvm: validate and honor byte_offset in parameter directives
  igvm: mark qigvm_find_param_entry as static

 include/hw/uefi/var-service.h  |  1 +
 include/system/igvm-internal.h |  7 +--
 backends/igvm.c                | 95 ++++++++++++++++++++++++----------
 hw/uefi/var-service-auth.c     | 25 +++++----
 hw/uefi/var-service-sysbus.c   |  4 +-
 hw/uefi/var-service-vars.c     |  4 ++
 target/i386/igvm.c             | 12 ++---
 7 files changed, 102 insertions(+), 46 deletions(-)

-- 
2.55.0


