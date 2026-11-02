Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC19606A796
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 12:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i4NQBSRG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNr89-0008SO-EA; Mon, 02 Nov 2026 07:27:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xNr82-0008Hd-8F
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 07:27:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xNr80-0001mj-QE
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 07:27:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793622428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J90sM9BvmEkVOSyjIqEfgWmK8j3jEDEHzKIZeiSJnMs=;
 b=i4NQBSRGFcru7Af6IhMtdQIgGB9bTcPHcdBKcMpYYzCZ1FR2vaZbzXWDZxPejiOrdYKRuD
 FBXK7QO58ULCFDUmuanZJhUISvmMAefiQyDxyNk9YjjQcO8aBPTNto8TvF7/meQykvq9lX
 2El/z9kWJ18pQfSH/3zCE4zhJZ60FmY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-73-hBVTQGC0PziEPoN1cFFRlQ-1; Mon,
 02 Nov 2026 07:27:06 -0500
X-MC-Unique: hBVTQGC0PziEPoN1cFFRlQ-1
X-Mimecast-MFC-AGG-ID: hBVTQGC0PziEPoN1cFFRlQ_1793622425
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C512818001F3; Mon,  2 Nov 2026 12:27:05 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 943C1195608B; Mon,  2 Nov 2026 12:27:04 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexander Graf <graf@amazon.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 13/13] accel/nitro: mark 'nitro' accelerator as secure
Date: Mon,  2 Nov 2026 12:26:45 +0000
Message-ID: <20261102122645.3353402-14-berrange@redhat.com>
In-Reply-To: <20261102122645.3353402-1-berrange@redhat.com>
References: <20261102122645.3353402-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The 'nitro' accelerator is used with a real AWS deployment and
thus is considered to be secure.

Reviewed-by: Alexander Graf <graf@amazon.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 accel/nitro/nitro-accel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/accel/nitro/nitro-accel.c b/accel/nitro/nitro-accel.c
index a1e97a9162e..a1489b8019a 100644
--- a/accel/nitro/nitro-accel.c
+++ b/accel/nitro/nitro-accel.c
@@ -251,6 +251,7 @@ static const TypeInfo nitro_accel_type = {
     .parent = TYPE_ACCEL,
     .instance_size = sizeof(NitroAccelState),
     .class_init = nitro_accel_class_init,
+    .secure = true,
 };
 module_obj(TYPE_NITRO_ACCEL);
 
-- 
2.56.0


