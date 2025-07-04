Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A91C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhGs-0003aE-QJ; Fri, 04 Jul 2025 10:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uXhGc-0003Vr-Jw
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:19:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uXhGa-0003QS-5b
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751638791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BXq/TWo0J4bekJDCOo3hKeCjbVUNwgGjqkUO0Euh61U=;
 b=GZu/hiWMecif2MYzx4rc+WP6zcYuLUEIzB5Wz0G9IJxhq0ZwKY/TgwyOsjMyuR2jvUDWS2
 vGkDDWR3YTfWwqLbhEIwJ818XqK8myX24FiztIIAYYh+Ll/WWSSUhdChxMf7ySUfJekMrZ
 +D56f3zBocFXkzlpzoZ7qgLd4+1ctxk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-DMT8h4TGPOyKAjfy8f4MAg-1; Fri,
 04 Jul 2025 10:19:48 -0400
X-MC-Unique: DMT8h4TGPOyKAjfy8f4MAg-1
X-Mimecast-MFC-AGG-ID: DMT8h4TGPOyKAjfy8f4MAg_1751638787
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 16BD019560A1; Fri,  4 Jul 2025 14:19:47 +0000 (UTC)
Received: from gondolin.redhat.com (unknown [10.44.34.37])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F360A195608F; Fri,  4 Jul 2025 14:19:44 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Sebastian Ott <sebott@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 5/5] arm/kvm: shorten one overly long line
Date: Fri,  4 Jul 2025 16:19:27 +0200
Message-ID: <20250704141927.38963-6-cohuck@redhat.com>
In-Reply-To: <20250704141927.38963-1-cohuck@redhat.com>
References: <20250704141927.38963-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Fixes: 804cfc7eedb7 ("arm/cpu: Store aa64isar0/aa64zfr0 into the idregs arrays")
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/arm/kvm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 426f8b159e82..8ab0d692d36a 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -230,7 +230,8 @@ static uint64_t idregs_sysreg_to_kvm_reg(ARMSysRegs sysreg)
 }
 
 /* read a sysreg value and store it in the idregs */
-static int get_host_cpu_reg(int fd, ARMHostCPUFeatures *ahcf, ARMIDRegisterIdx index)
+static int get_host_cpu_reg(int fd, ARMHostCPUFeatures *ahcf,
+                            ARMIDRegisterIdx index)
 {
     uint64_t *reg;
     int ret;
-- 
2.50.0


