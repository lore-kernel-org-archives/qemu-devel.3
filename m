Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67C3D65C6F
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 11:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBXb8-0001rz-QQ; Thu, 14 Nov 2024 06:01:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tBXb7-0001rZ-73
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 06:01:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tBXb5-0006uS-K5
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 06:01:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731582069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jhn1SCmWq1URH/YAp7J4RIEQcZ2o0LDcpld/Y0q03V0=;
 b=Iy/RRo9DxyxFq5l+2DWAuOHiuPXLZKfYCcWoTSz6Xb/TICNMtOVYb1XTilIKEwB+iIL8s5
 dav3DKVZd694Jg4cIET1gowc+DwJcpHHupv7UtMdjBT/cmSaDRb+7o1yVGb80d1Z1L1I+j
 ZFaGw4/ckrNPjS/7BwTPgllmeEglNcA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-aaWyvnrMMMCYAYgm-RRxLw-1; Thu,
 14 Nov 2024 06:01:06 -0500
X-MC-Unique: aaWyvnrMMMCYAYgm-RRxLw-1
X-Mimecast-MFC-AGG-ID: aaWyvnrMMMCYAYgm-RRxLw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB2151955F41; Thu, 14 Nov 2024 11:01:04 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.143])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF459195E480; Thu, 14 Nov 2024 11:01:03 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 94C5318009A1; Thu, 14 Nov 2024 12:01:01 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 0/5] Firmware 20241114 patches
Date: Thu, 14 Nov 2024 12:00:56 +0100
Message-ID: <20241114110101.44322-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.738,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The following changes since commit f0a5a31c33a8109061c2493e475c8a2f4d022432:

  Update version for v9.2.0-rc0 release (2024-11-13 21:44:45 +0000)

are available in the Git repository at:

  https://gitlab.com/kraxel/qemu.git tags/firmware-20241114-pull-request

for you to fetch changes up to 5916a3b20fdbfbfc2f987f1121e945100c8c3cd2:

  x86/loader: add -shim option (2024-11-14 11:55:39 +0100)

----------------------------------------------------------------
loader: fix efi binary loading via -kernel
loader: support secure boot verification with direct kernel boot

----------------------------------------------------------------

Gerd Hoffmann (5):
  vl: fix qemu_validate_options() indention
  x86/loader: only patch linux kernels
  x86/loader: read complete kernel
  x86/loader: expose unpatched kernel
  x86/loader: add -shim option

 include/hw/boards.h  |  1 +
 hw/core/machine.c    | 20 ++++++++++++++++++++
 hw/i386/x86-common.c | 32 ++++++++++++++++++++++++++------
 system/vl.c          | 25 +++++++++++++++++--------
 qemu-options.hx      |  7 +++++++
 5 files changed, 71 insertions(+), 14 deletions(-)

-- 
2.47.0


