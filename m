Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A02D591AA
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 17:37:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD5gc-0008Gr-L5; Mon, 18 Nov 2024 12:37:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tD5gF-0008Aq-N2
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 12:37:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tD5gD-0004lJ-VZ
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 12:36:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731951413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VJhFIt+Avk9efs65XYYhBIvWur/LnUUbkyjdszyi2Io=;
 b=bEffYB6EjRnDZvCTkOHv2kqSpkbeu0lWOsJzY3P41UNfyAJWbZNGtljJxTlMtLIv46/8bi
 M2xef+DtmzPWBDNVwP4CabaREwbLXQjFy/4/wFoNMi6Vbx1IAGLvSvVV0qqzK0nW2D1aQE
 XuQxqdOMZDb0wjwBfvX/rZIwzziasl0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-212-sFgwC8BXOD6ouafXXwan7w-1; Mon,
 18 Nov 2024 12:36:50 -0500
X-MC-Unique: sFgwC8BXOD6ouafXXwan7w-1
X-Mimecast-MFC-AGG-ID: sFgwC8BXOD6ouafXXwan7w
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA9B2195608B; Mon, 18 Nov 2024 17:36:48 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3E5E919560A3; Mon, 18 Nov 2024 17:36:46 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jared Rossi <jrossi@linux.ibm.com>
Subject: [PULL 04/12] docs/system/s390x/bootdevices: Update loadparm
 documentation
Date: Mon, 18 Nov 2024 18:36:26 +0100
Message-ID: <20241118173634.473532-5-thuth@redhat.com>
In-Reply-To: <20241118173634.473532-1-thuth@redhat.com>
References: <20241118173634.473532-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Jared Rossi <jrossi@linux.ibm.com>

Update documentation to include per-device loadparm support.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20241115002742.3576842-1-jrossi@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/system/s390x/bootdevices.rst | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/docs/system/s390x/bootdevices.rst b/docs/system/s390x/bootdevices.rst
index 1a1a764c1c..97b3914785 100644
--- a/docs/system/s390x/bootdevices.rst
+++ b/docs/system/s390x/bootdevices.rst
@@ -79,7 +79,29 @@ The second way to use this parameter is to use a number in the range from 0
 to 31. The numbers that can be used here correspond to the numbers that are
 shown when using the ``PROMPT`` option, and the s390-ccw bios will then try
 to automatically boot the kernel that is associated with the given number.
-Note that ``0`` can be used to boot the default entry.
+Note that ``0`` can be used to boot the default entry. If the machine
+``loadparm`` is not assigned a value, then the default entry is used.
+
+By default, the machine ``loadparm`` applies to all boot devices. If multiple
+devices are assigned a ``bootindex`` and the ``loadparm`` is to be different
+between them, an independent ``loadparm`` may be assigned on a per-device basis.
+
+An example guest using per-device ``loadparm``::
+
+  qemu-system-s390x -drive if=none,id=dr1,file=primary.qcow2 \
+                   -device virtio-blk,drive=dr1,bootindex=1 \
+                   -drive if=none,id=dr2,file=secondary.qcow2 \
+                   -device virtio-blk,drive=dr2,bootindex=2,loadparm=3
+
+In this case, the primary boot device will attempt to IPL using the default
+entry (because no ``loadparm`` is specified for this device or for the
+machine). If that device fails to boot, the secondary device will attempt to
+IPL using entry number 3.
+
+If a ``loadparm`` is specified on both the machine and a device, the per-device
+value will superseded the machine value.  Per-device ``loadparm`` values are
+only used for devices with an assigned ``bootindex``. The machine ``loadparm``
+is used when attempting to boot without a ``bootindex``.
 
 
 Booting from a network device
-- 
2.47.0


