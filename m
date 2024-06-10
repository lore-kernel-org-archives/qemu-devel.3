Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E598AC27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 17:15:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGiau-00040t-15; Mon, 10 Jun 2024 13:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sGias-00040e-Lv
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 13:14:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sGiar-00018p-71
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 13:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718039644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Eb5h6zwH2jnVLvmgEhxAZ6r++W58ZEwjCwZbOR0q6qU=;
 b=ixeNyFkTxBUN70fzyuVEoza5nxvwVdFVhwUOWnYi/BobkWycGOxyzLJ0fMes45s9ABrV3A
 RA3h0HK2OD9/e+Ksug3PUr7U39803imkfmtaWBAoYhx8JcVLltE2GbMiCOf4to2kgTGZ2K
 1sjgQxt3WSN3CJ9wuMUabxRy/zuum6Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-140-pWLSxVIIP4SCIGHanP-kHA-1; Mon,
 10 Jun 2024 13:14:00 -0400
X-MC-Unique: pWLSxVIIP4SCIGHanP-kHA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE07B1955D6D; Mon, 10 Jun 2024 17:13:58 +0000 (UTC)
Received: from localhost (unknown [10.39.195.112])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9662F1956089; Mon, 10 Jun 2024 17:13:57 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Alex Williamson <alex.williamson@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PULL 3/6] hw/sh4: Remove newline character in trace events
Date: Mon, 10 Jun 2024 13:13:12 -0400
Message-ID: <20240610171315.346143-4-stefanha@redhat.com>
In-Reply-To: <20240610171315.346143-1-stefanha@redhat.com>
References: <20240610171315.346143-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Trace events aren't designed to be multi-lines. Remove
the newline character which doesn't bring much value.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Mads Ynddal <mads@ynddal.dk>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-id: 20240606103943.79116-3-philmd@linaro.org
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/sh4/trace-events | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sh4/trace-events b/hw/sh4/trace-events
index 4b61cd56c8..6bfd7eebc4 100644
--- a/hw/sh4/trace-events
+++ b/hw/sh4/trace-events
@@ -1,3 +1,3 @@
 # sh7750.c
-sh7750_porta(uint16_t prev, uint16_t cur, uint16_t pdtr, uint16_t pctr) "porta changed from 0x%04x to 0x%04x\npdtra=0x%04x, pctra=0x%08x"
-sh7750_portb(uint16_t prev, uint16_t cur, uint16_t pdtr, uint16_t pctr) "portb changed from 0x%04x to 0x%04x\npdtrb=0x%04x, pctrb=0x%08x"
+sh7750_porta(uint16_t prev, uint16_t cur, uint16_t pdtr, uint16_t pctr) "porta changed from 0x%04x to 0x%04x (pdtra=0x%04x, pctra=0x%08x)"
+sh7750_portb(uint16_t prev, uint16_t cur, uint16_t pdtr, uint16_t pctr) "portb changed from 0x%04x to 0x%04x (pdtrb=0x%04x, pctrb=0x%08x)"
-- 
2.45.1


