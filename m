Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E2F7CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 13:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBvMv-0007xY-Bq; Thu, 23 Oct 2025 09:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vBvMs-0007x4-M4
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 09:28:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vBvMp-0001Gl-0l
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 09:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761226110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZOjex2sUFAYTa6fSUEWj+kUzmaQOqxKGDLUloYvNbRk=;
 b=ZUcPuN+kaoODDb5MN0+XnAI1pUF+xK2xQv6RMfVZpQX2JvqJNqSDgTEdoqxrNWwr4rm9K/
 JJRnrthiCAT9pkDlNN28fPLUQ88h/49hH5RPlqrmWAZ0BIiYbkEE6duztsTBwUUNQ4HaPA
 QIIkQyODXMWymUouJM1FMUZBGAor4UQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-TMwDiSPeP3KUwuN2lXulhQ-1; Thu,
 23 Oct 2025 09:28:29 -0400
X-MC-Unique: TMwDiSPeP3KUwuN2lXulhQ-1
X-Mimecast-MFC-AGG-ID: TMwDiSPeP3KUwuN2lXulhQ_1761226108
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 72ECA19560B7
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 13:28:28 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.138])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E4A82180057D; Thu, 23 Oct 2025 13:28:27 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 756601800393; Thu, 23 Oct 2025 15:28:25 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 0/1] Uefi 20251023  patches
Date: Thu, 23 Oct 2025 15:28:24 +0200
Message-ID: <20251023132825.338615-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit c0e80879c876cbe4cbde43a92403329bcedf2ba0:

  Merge tag 'pull-vfio-20251022' of https://github.com/legoater/qemu into staging (2025-10-22 08:01:21 -0500)

are available in the Git repository at:

  https://gitlab.com/kraxel/qemu.git tags/uefi-20251023--pull-request

for you to fetch changes up to b6478122f059274b19805e14d12f76d2c0272ad4:

  hw/uefi/ovmf-log: Fix memory leak in hmp_info_firmware_log (2025-10-23 13:27:27 +0200)

----------------------------------------------------------------
hw/uefi: fix memory leak

----------------------------------------------------------------

GuoHan Zhao (1):
  hw/uefi/ovmf-log: Fix memory leak in hmp_info_firmware_log

 hw/uefi/ovmf-log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.51.0


