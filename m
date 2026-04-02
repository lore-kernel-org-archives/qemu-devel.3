Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23233D39406
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 09:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Ej1-0007GD-5I; Thu, 02 Apr 2026 05:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w8Eiy-0007Dc-Ca
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 05:52:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w8Eiw-0008Tg-Oq
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 05:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775123544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1XTWrPgq4sCwgSTOwpsTMMw/F62QUQmlEI3gOkYR/ZE=;
 b=cNtWkpbMxk3K45QhDHhC1ZtlohCsWYgVceKD8J2agfYqBvQtNPZGq+hK8sNn0/cw8Dg08U
 09L8iTUHIeW7gautHFlctppnflRDvm7+XWyqWL4pILEyYHTEbTqPPBKyVgal0iCNjinTL7
 /yzaBCdPvvPulhtk0Tt/LhpSZ6miVt0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-t3LmcyEeNnWluNdasNIvrQ-1; Thu,
 02 Apr 2026 05:52:21 -0400
X-MC-Unique: t3LmcyEeNnWluNdasNIvrQ-1
X-Mimecast-MFC-AGG-ID: t3LmcyEeNnWluNdasNIvrQ_1775123540
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B5B85180044D; Thu,  2 Apr 2026 09:52:20 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.44])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7C2F1196B088; Thu,  2 Apr 2026 09:52:16 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 10/10] docs/about/deprecated: Deprecate the qemu-system-i386
 binary
Date: Thu,  2 Apr 2026 11:51:32 +0200
Message-ID: <20260402095132.29245-11-thuth@redhat.com>
In-Reply-To: <20260402095132.29245-1-thuth@redhat.com>
References: <20260402095132.29245-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

Aside from not supporting KVM on 32-bit hosts, the qemu-system-x86_64
binary is a proper superset of the qemu-system-i386 binary. And with
the 32-bit x86 host support being removed now, it is possible to
deprecate the qemu-system-i386 binary now, too.

With regards to 32-bit KVM support in the x86 Linux kernel,
the developers confirmed that they do not need a recent
qemu-system-i386 binary here:

 https://lore.kernel.org/kvm/Y%2ffkTs5ajFy0hP1U@google.com/

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/about/deprecated.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index a6d6a713265..2de51337d75 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -301,6 +301,25 @@ machine must ensure that they're setting the ``spike`` machine in the
 command line (``-M spike``).
 
 
+System emulator binaries
+------------------------
+
+``qemu-system-i386`` binary (since 11.1)
+''''''''''''''''''''''''''''''''''''''''
+
+The ``qemu-system-i386`` binary was mainly useful for running with KVM
+on 32-bit x86 hosts, but most Linux distributions already removed their
+support for 32-bit x86 kernels, so hardly anybody still needs this. The
+``qemu-system-x86_64`` binary is a proper superset and can be used to
+run 32-bit guests by selecting a 32-bit CPU model, including KVM support
+on x86_64 hosts. Thus users are recommended to reconfigure their systems
+to use the ``qemu-system-x86_64`` binary instead. If a 32-bit CPU guest
+environment should be enforced, you can switch off the "long mode" CPU
+flag with ``-cpu max,lm=off``, or rename/symlink ``qemu-system-x86_64``
+to ``qemu-system-i386`` -- QEMU will then run with the 64-bit extensions
+disabled.
+
+
 Backend options
 ---------------
 
-- 
2.53.0


