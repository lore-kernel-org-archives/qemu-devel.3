Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E1A0C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 08:00:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzXWM-0004sm-4g; Wed, 24 Apr 2024 03:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rzXWI-0004kB-FQ
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 03:58:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rzXWG-00033P-UM
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 03:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713945500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h5LHVnYyLW2OICqVeP2czgrsfF1STKIdoc75JBnDZiI=;
 b=hQeaVaJSZcPb1glZ+TwHl0shSBnmGW1tuana2zNoKBgARYFcUbResXASEaTPcX/5nwY0Mt
 WgJG7V7gndzAM35nfAfPgtepmFeYTp1NY1BAztTd2Zrvl8BeosvXU8tpgpKaAGGastd/Rq
 HBT8BFOnCorPnJFG8/P9H52LlxitMkM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-JcjMR8jRMa6ElX6nTWWOSg-1; Wed, 24 Apr 2024 03:58:16 -0400
X-MC-Unique: JcjMR8jRMa6ElX6nTWWOSg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E2EC281B5AF;
 Wed, 24 Apr 2024 07:58:15 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD5A13543A;
 Wed, 24 Apr 2024 07:58:14 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 14/17] hw/s390x: Include missing 'cpu.h' header
Date: Wed, 24 Apr 2024 09:57:32 +0200
Message-ID: <20240424075735.248041-15-thuth@redhat.com>
In-Reply-To: <20240424075735.248041-1-thuth@redhat.com>
References: <20240424075735.248041-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

"cpu.h" is implicitly included. Include it explicitly to
avoid the following error when refactoring headers:

  hw/s390x/s390-stattrib.c:86:40: error: use of undeclared identifier 'TARGET_PAGE_SIZE'
      len = sac->peek_stattr(sas, addr / TARGET_PAGE_SIZE, buflen, vals);
                                         ^
  hw/s390x/s390-stattrib.c:94:58: error: use of undeclared identifier 'TARGET_PAGE_MASK'
                     addr / TARGET_PAGE_SIZE, len, addr & ~TARGET_PAGE_MASK);
                                                         ^
  hw/s390x/s390-stattrib.c:224:40: error: use of undeclared identifier 'TARGET_PAGE_BITS'
          qemu_put_be64(f, (start_gfn << TARGET_PAGE_BITS) | STATTR_FLAG_MORE);
                                         ^
  In file included from hw/s390x/s390-virtio-ccw.c:17:
  hw/s390x/s390-virtio-hcall.h:22:27: error: unknown type name 'CPUS390XState'
  int s390_virtio_hypercall(CPUS390XState *env);
                            ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Eric Farman <farman@linux.ibm.com>
Message-ID: <20240322162822.7391-1-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/s390-virtio-hcall.h | 2 ++
 hw/s390x/s390-stattrib.c     | 1 +
 2 files changed, 3 insertions(+)

diff --git a/hw/s390x/s390-virtio-hcall.h b/hw/s390x/s390-virtio-hcall.h
index 9800c4b351..3ae6d6ae3a 100644
--- a/hw/s390x/s390-virtio-hcall.h
+++ b/hw/s390x/s390-virtio-hcall.h
@@ -13,6 +13,7 @@
 #define HW_S390_VIRTIO_HCALL_H
 
 #include "standard-headers/asm-s390/virtio-ccw.h"
+#include "cpu.h"
 
 /* The only thing that we need from the old kvm_virtio.h file */
 #define KVM_S390_VIRTIO_NOTIFY 0
@@ -20,4 +21,5 @@
 typedef int (*s390_virtio_fn)(const uint64_t *args);
 void s390_register_virtio_hypercall(uint64_t code, s390_virtio_fn fn);
 int s390_virtio_hypercall(CPUS390XState *env);
+
 #endif /* HW_S390_VIRTIO_HCALL_H */
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index c483b62a9b..aaf48ac73f 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -19,6 +19,7 @@
 #include "exec/ram_addr.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
+#include "cpu.h"
 
 /* 512KiB cover 2GB of guest memory */
 #define CMMA_BLOCK_SIZE  (512 * KiB)
-- 
2.44.0


