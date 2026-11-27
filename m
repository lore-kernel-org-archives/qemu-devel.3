Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997CD606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BTDsWMOd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWx8e-0003TN-02; Fri, 27 Nov 2026 09:41:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xWx8X-0003So-AC
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:41:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xWx8S-0007ZR-De
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:41:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795790470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=yUV7HmX5GTc8etEstTZ5GnmEYWmrp4btsfCF03etjII=;
 b=BTDsWMOdV0ou5XmzZxrdlZ8Gm7DYIujzyiWwU3cPT1CFCt50+WdJzxig+phUNpKIV/XHOL
 6x8q6JMezWK8Mj5o8fy2kxEnQEDiyeJ0+C+e5d4UL+p1MTn7VcLDx/EdH9Dkz64MzilXhu
 VeBrSoX0DoxBy3st4O3OqX6YKrdwNJs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-tzidtD_GPyepGIv2fIEaDA-1; Fri,
 27 Nov 2026 14:41:04 +0000
X-MC-Unique: tzidtD_GPyepGIv2fIEaDA-1
X-Mimecast-MFC-AGG-ID: tzidtD_GPyepGIv2fIEaDA_1795790463
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BFCE3180054A; Fri, 27 Nov 2026 14:41:02 +0000 (UTC)
Received: from thuth-p1g4.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 736171801977; Fri, 27 Nov 2026 14:41:00 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH for-12.0 0/2] Remove code of the obsolete pc-q35-4.1 and
 pc-i440fx-4.1 machines
Date: Fri, 27 Nov 2026 15:40:57 +0100
Message-ID: <20261127144059.278754-1-thuth@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The pc-q35-4.1 and pc-i440fx-4.1 have already been disabled automatically
since they are older than 6 years. The related code is dead, we can remove
it now.

Thomas Huth (2):
  hw/i386: Remove the code of the obsolete pc-q35-4.1 and pc-i440fx-4.1
    machines
  hw/virtio: Remove hw_compat_4_1[] array and "x-pcie-flr-init" from
    virtio-pci

 include/hw/core/boards.h       |  3 ---
 include/hw/i386/pc.h           |  3 ---
 include/hw/virtio/virtio-pci.h |  4 ----
 hw/core/machine.c              |  5 -----
 hw/i386/pc.c                   |  3 ---
 hw/i386/pc_piix.c              |  9 ---------
 hw/i386/pc_q35.c               |  9 ---------
 hw/virtio/virtio-pci.c         | 13 +++----------
 8 files changed, 3 insertions(+), 46 deletions(-)

-- 
2.56.1


