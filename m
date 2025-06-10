Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F05C677C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 17:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP27n-0002vY-Bu; Tue, 10 Jun 2025 12:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uP02M-00026F-FO
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 10:33:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uP02H-0005zm-TD
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 10:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749565986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nZb4ucaOK666f4Mp5IessTrBl/S3IzkH1NVU2azg++0=;
 b=gY6ZtpwxR0mZ05SoT76RJ7vINm/HfnweN4B+xZUo1KRz2PZFdj9UpWl2fozujkaorCIgJr
 3yweXAWijGSK3JPmu9CL6kiSz0rCqSs/EqzxnB3TieDvsEEEQkK7TnElyszpfP4Skl5vab
 O4zsbVA2qCwGHMT/yvKVl1yehD8HgeY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-153-2Z7UqJWhOKiD3sdd1nHfYA-1; Tue,
 10 Jun 2025 10:33:05 -0400
X-MC-Unique: 2Z7UqJWhOKiD3sdd1nHfYA-1
X-Mimecast-MFC-AGG-ID: 2Z7UqJWhOKiD3sdd1nHfYA_1749565984
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7DBE81956048
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 14:33:04 +0000 (UTC)
Received: from gondolin.str.redhat.com (dhcp-192-216.str.redhat.com
 [10.33.192.216])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A86211956087; Tue, 10 Jun 2025 14:33:02 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org,
	Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 0/2] cosmetics for the i6300esb watchdog
Date: Tue, 10 Jun 2025 16:32:57 +0200
Message-ID: <20250610143259.1056400-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The i6300esb watchdog device is generic enough to be used on any PCI
platform; however, having an "Intel" device on a non-x86 platform looks
a bit odd. Just call it a "virtual" device instead, and also fix an old
typo for the config option while at it.

Cornelia Huck (2):
  watchdog: CONFIG_WDT_IB6300ESB -> CONFIG_WDT_I6300ESB
  watchdog: generic name for i6300esb

 hw/watchdog/Kconfig        | 2 +-
 hw/watchdog/meson.build    | 2 +-
 hw/watchdog/wdt_i6300esb.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.49.0


