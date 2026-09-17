Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C34C982D1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 13:34:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7CFL-0000d1-DT; Thu, 17 Sep 2026 09:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1x7CF5-0000bR-KB
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 09:33:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1x7CEz-0003Wb-5M
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 09:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789652008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gwt7byog0znHqLQSJptfme+CjdJYRGTbgDMgA+bi2VU=;
 b=VYcukAGweyCHfdzd5idxC2OZBO5yiAqice5WjZole9lOPLtBaofrcP+2O/YBOcbk+2N49l
 wLRgQY64hDkIxURnNoar73KM3m3Vsf1LVB/b6Rjl+g2nxLuKe2+UD40aqZvVmIrKm1ONIX
 HqkG5sdW2k7l3pT6zDmJHVY5oRFn91w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-znEgBguvPDyC6sAm0dBRwA-1; Thu,
 17 Sep 2026 09:33:23 -0400
X-MC-Unique: znEgBguvPDyC6sAm0dBRwA-1
X-Mimecast-MFC-AGG-ID: znEgBguvPDyC6sAm0dBRwA_1789652002
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A40B0182E699; Thu, 17 Sep 2026 13:33:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.37])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 04DF930001BE; Thu, 17 Sep 2026 13:33:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 280061800780; Thu, 17 Sep 2026 15:33:19 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Luigi Leonardi <leonardi@redhat.com>
Subject: [PULL 3/5] igvm: mark qigvm_find_param_entry as static
Date: Thu, 17 Sep 2026 15:33:16 +0200
Message-ID: <20260917133318.2004317-4-kraxel@redhat.com>
In-Reply-To: <20260917133318.2004317-1-kraxel@redhat.com>
References: <20260917133318.2004317-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

From: Luigi Leonardi <leonardi@redhat.com>

Previous commit removed all external usage of `qigvm_find_param_entry`,
therefore we can mark it as a static function.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20260916-fix_offset-v5-2-11cf8ef37854@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/system/igvm-internal.h | 4 ----
 backends/igvm.c                | 2 +-
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
index 0467eff0ceab..b3b64cb58444 100644
--- a/include/system/igvm-internal.h
+++ b/include/system/igvm-internal.h
@@ -77,10 +77,6 @@ struct QIgvm {
 
 IgvmHandle qigvm_file_init(char *filename, Error **errp);
 
-QIgvmParameterData*
-qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index,
-                       Error **errp);
-
 uint8_t *
 qigvm_get_param_data(QIgvm *igvm, const IGVM_VHS_PARAMETER *param,
                      uint32_t *param_size,
diff --git a/backends/igvm.c b/backends/igvm.c
index 9a2bafc0cad0..ec7bee428bcc 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -85,7 +85,7 @@ struct QEMU_PACKED sev_id_authentication {
 
 #define IGVM_SEV_ID_BLOCK_VERSION 1
 
-QIgvmParameterData*
+static QIgvmParameterData*
 qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index,
                        Error **errp)
 {
-- 
2.55.0


